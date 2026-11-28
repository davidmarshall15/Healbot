-- Exercise the native module through the same mocked widgets and lifecycle hooks as the caster suite.
local file=assert(io.open("tests/native_buff_casters.lua","rb"))
local contents=file:read("*a"):gsub("\r\n","\n")
file:close()
local prefix=assert(contents:match("^(.-)\nlocal d=fixture%("),"native caster fixture boundary moved")
local fixture,copies=assert(loadstring(prefix.."\nreturn fixture,copies"))()

local function equal(actual,expected,label)
    assert(actual==expected,label..": expected "..tostring(expected)..", got "..tostring(actual))
end

local function instrument(class)
    local scans={policy=0,exclusions=0}
    local callbacks={}
    local marker=990000
    local d=fixture(class,4,function(env)
        local name=env.HealBot_WoWAPI_SpellName
        env.HealBot_WoWAPI_SpellName=function(id)
            -- The compiler resolves this cache-only ID once on every complete pass.
            if id==marker then scans.policy=scans.policy+1 end
            return name(id)
        end
        local exclusions=env.HealBot_Aura_NativeBuffExclusions
        env.HealBot_Aura_NativeBuffExclusions=function()
            scans.exclusions=scans.exclusions+1
            return exclusions()
        end
        env.HealBot_Aura_VisitKnownBuffs=function(visit)
            for id,data in pairs(env.HealBot_AuraBuffCache) do visit(id,data.name) end
        end
        env.C_Timer={After=function(_,callback) callbacks[#callbacks+1]=callback end}
    end)
    d.env.HealBot_Spell_IDs[marker]={}
    d.skin.limits={4,2,2}
    d.globals.CombatAurasPriestOnly=true
    return d,scans,callbacks
end

local function deferredRaid(d)
    local bars={}
    d.combat(true)
    for i=1,40 do bars[i]=d.button("raid"..i) end
    d.combat(false)
    return bars
end

local function prepareReserves(d,donor)
    local context=d.env.HealBot_Forever_PrepareArrivalAuraContext()
    local rows={}
    for i=1,4 do
        local reserve={unit="party"..i,frame=1,healthBar={},GetFrameLevel=function() return 5 end}
        d.env.HealBot_Forever_SkinArrivalAuras(reserve,donor,context)
        for _,item in ipairs(reserve.arrivalAuras) do
            if item.set==1 then rows[i]=item.container end
        end
        assert(rows[i],"missing primary reserve buff row")
    end
    return rows
end

local function primaryRow(d,bar)
    for _,row in ipairs(d.frames) do
        if row.parent==bar and row.groups.hbcahot and row.hbcaBuffLimit==4 then return row end
    end
    error("missing primary raid buff row")
end

local function enabledBatch(class)
    local d,scans=instrument(class)
    local broad=class~="PRIEST"
    local ignored,nextIgnored=990010,990011
    d.disabled[ignored]=true
    local bars=deferredRaid(d)
    equal(scans.policy,1,"policy passes for 40 deferred bars")
    equal(scans.exclusions,broad and 1 or 0,"exclusion passes for 40 deferred bars")
    scans.policy,scans.exclusions=0,0
    local rows=prepareReserves(d,bars[1])
    equal(scans.policy,1,"policy passes for four reserve bars")
    equal(scans.exclusions,broad and 1 or 0,"exclusion passes for four reserve bars")
    for _,bar in ipairs(bars) do rows[#rows+1]=primaryRow(d,bar) end
    d.combat(true)
    for _,row in ipairs(rows) do
        equal(copies(row,139,"party2"),0,"Self rejects another caster")
        if broad then
            equal(copies(row,ignored,"player"),0,"broad group rejects ignored spell")
            equal(copies(row,nextIgnored,"player"),1,"broad group admits unconfigured spell")
        end
    end
    d.globals.WatchHoT.PRIE[139]=3
    d.disabled[ignored],d.disabled[nextIgnored]=nil,true
    scans.policy,scans.exclusions=0,0
    d.hook("HealBot_Aura_ConfigClassHoT")
    equal(scans.policy,1,"one refresh updates regular and reserve rows")
    equal(scans.exclusions,broad and 1 or 0,"exclusion passes for joint refresh")
    for _,row in ipairs(rows) do
        equal(copies(row,139,"party2"),1,"Everyone accepts another caster")
        if broad then
            equal(copies(row,ignored,"player"),1,"clearing an ignore restores the spell")
            equal(copies(row,nextIgnored,"player"),0,"adding an ignore removes the spell")
        end
    end
end

local function toggleMonitoring()
    local d,scans,callbacks=instrument("PRIEST")
    d.hook("HealBot_Aura_ConfigClassHoT") -- Prime watched names before disabling the monitor.
    scans.policy,scans.exclusions=0,0
    d.config.BuffWatch=false
    d.hook("HealBot_Aura_SetAuraCheckFlags")
    local bars=deferredRaid(d)
    local row=primaryRow(d,bars[1])
    local reserves=prepareReserves(d,bars[1])
    d.combat(true)
    d.hook("HealBot_Aura_SetAuraCheckFlags")
    equal(scans.policy,0,"disabled raid, reserve and flag refresh policy passes")
    equal(scans.exclusions,0,"disabled row exclusion passes")
    equal(row.shown,false,"disabled regular buff row")
    equal(reserves[1].shown,false,"disabled reserve buff row")
    local dispel
    for _,frame in ipairs(d.frames) do
        if frame.parent==bars[1] and frame.groups.hbcadb then dispel=frame end
    end
    equal(assert(dispel).shown,true,"dispel monitoring stays active")
    local rank,shieldRank=990020,990021
    d.env.HealBot_Forever_ObserveBuffRank(rank,"Renew")
    equal(#callbacks,0,"disabled name watcher queues no refresh")
    d.globals.WatchHoT.PRIE[139]=3
    d.globals.WatchHoT.PRIE[17]=3
    d.globals.CustomBuffIDMethod[17]=1
    local allocated=#d.frames
    d.config.BuffWatch=true
    d.hook("HealBot_Aura_SetAuraCheckFlags")
    equal(scans.policy,1,"re-enable reads current settings once")
    equal(row.shown,true,"re-enabled regular buff row")
    equal(reserves[1].shown,true,"re-enabled reserve buff row")
    equal(copies(row,139,"party2"),1,"changed caster on regular row")
    equal(copies(reserves[1],139,"party2"),1,"changed caster on reserve row")
    d.env.HealBot_AuraBuffCache[shieldRank]={name="Power Word: Shield"}
    d.env.HealBot_Forever_ObserveBuffRank(shieldRank,"Power Word: Shield")
    equal(#callbacks,0,"exact-ID setting excludes another rank from the watcher")
    d.env.HealBot_AuraBuffCache[rank]={name="Renew"}
    d.env.HealBot_Forever_ObserveBuffRank(rank,"Renew")
    d.env.HealBot_Forever_ObserveBuffRank(rank,"Renew")
    equal(#callbacks,1,"new watched rank queues one refresh")
    table.remove(callbacks,1)()
    equal(scans.policy,2,"one refresh compiles the new rank after re-enable")
    equal(copies(row,rank,"party2"),1,"regular row admits the observed rank")
    equal(copies(reserves[1],rank,"party2"),1,"reserve row admits the observed rank")
    equal(copies(row,shieldRank,"party2"),0,"exact-ID setting rejects the other rank")
    d.env.HealBot_Forever_ObserveBuffRank(rank,"Renew")
    equal(#callbacks,0,"compiled rank does not queue another refresh")
    equal(#d.frames,allocated,"all combat changes reuse prepared rows")
end

toggleMonitoring()
for _,class in ipairs({"DRUID","HUNTER","MAGE","PALADIN","PRIEST","ROGUE","SHAMAN","WARLOCK","WARRIOR"}) do
    enabledBatch(class)
end
print("PASS: native buff scan budgets, caster and rank toggles, raid and reserve exclusions on nine classes")
