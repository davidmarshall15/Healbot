local function read(path)
    local f=assert(io.open(path,"rb")); local s=f:read("*a"); f:close()
    return s:gsub("\r\n","\n")
end
local prefix=assert(read("tests/native_buff_matching.lua"):match("^(.-)\ndo\n    local env,build=fixture"))
local fixture,contains=assert(loadstring(prefix.."\nreturn fixture,contains"))()
local classes={"DRUID","HUNTER","MAGE","PALADIN","PRIEST","ROGUE","SHAMAN","WARLOCK","WARRIOR"}
local function install(env)
    setfenv(assert(loadfile("HealBot/HealBot_ForeverSpellNames.lua")),env)()
end

for _,class in ipairs(classes) do
    local env,build,names=fixture()
    env.class=class
    names[6117]="Mage Armor"; names[22782]="Mage Armor"; names[22783]="Mage Armor"
    install(env)
    local g=env.HealBot_Globals
    g.WatchHoT.ALL[6117]=3; g.CustomBuffsIconSet[6117]=2
    assert(contains(build(),22783,2,"everyoneSpellFilter"),class.." cold rank missing")
    g.CustomBuffIDMethod[6117]=1
    assert(not contains(build(),22783,2),"strict ID widened")
    g.CustomBuffIDMethod[6117]=2
    g.IgnoreCustomBuff[6117]={A=true}
    g.IgnoreCustomBuff[22782]={B=true}
    for _,zone in ipairs({"A","B"}) do
        env.hb_lVars.mapName=zone
        assert(not contains(build(),22783,2),"overlapping name ignores lost zone "..zone)
        assert(env.HealBot_Aura_CustomBuffDisabled(22783,"Mage Armor"),"public ignore lost zone "..zone)
    end
    env.hb_lVars.mapName="C"
    assert(contains(build(),22783,2),"stale zone exclusion survived")
    g.WatchHoT.ALL[6117]=nil; g.CombatAurasPriestOnly=true
    env.hb_lVars.mapName="A"
    local broad=build()
    if class~="PRIEST" then
        assert(broad[1].selfSpellFilter.excludeSpellIDs[22783],"broad scope ignored unknown name-mode exclusion")
        g.CustomBuffIDMethod[6117]=1
        assert(not build()[1].selfSpellFilter.excludeSpellIDs[22783],"strict exclusion widened across family")
    end
end

do
    local env,build,names=fixture()
    local secret={}; env.HealBot_issecretvalue=function(v) return rawequal(v,secret) end
    names[6117]="Armure du mage"; names[22782]="Armure du mage"; names[22783]="A changed spell"
    names[8696]=secret
    install(env)
    local g=env.HealBot_Globals
    g.WatchHoT.ALL[6117]=3
    local filters=build()
    assert(contains(filters,22782),"numeric localized lookup missed")
    assert(not contains(filters,22783),"changed name admitted from historical group")
    g.WatchHoT.ALL[6117]=nil; g.WatchHoT.ALL["Mage Armor"]=3
    assert(not contains(build(),22782),"English name admitted another locale")
    for _,name in ipairs({"Sprint",secret}) do
        env.HealBot_Forever_VisitSpellNameIDs(nil,name,function(id)
            assert(id~=8696,"secret metadata compared")
        end)
    end
end

do
    local env,build,names=fixture()
    install(env)
    local g=env.HealBot_Globals
    names[4079]="Cloaking"
    g.WatchHoT.ALL.Cloaking=3
    assert(not env.HealBot_WoWAPI_SpellId("Cloaking"))
    assert(contains(build(),4079,1,"everyoneSpellFilter"),"bare enUS singleton did not reach the filter")
    g.WatchHoT.ALL.Cloaking=nil; g.WatchHoT.ALL["Custom Mend"]="C"; g.CustomBuffIDMethod["Custom Mend"]=1
    assert(contains(build(),99001,1,"selfSpellFilter") and not contains(build(),99002))
    assert(env.HealBot_Watch_HoT[99001]=="C" and not env.HealBot_Watch_HoT["Custom Mend"],"strict text leaked to public siblings")
    g.IgnoreCustomBuff["Custom Mend"]={ALL=true}; build()
    assert(env.HealBot_Aura_CustomBuffDisabled(99001,"Custom Mend"))
    assert(not env.HealBot_Aura_CustomBuffDisabled(99002,"Custom Mend"),"strict text ignore leaked to sibling")
    g.WatchHoT.ALL["Custom Mend"]=false
    assert(not contains(build(),99001) and not env.HealBot_Watch_HoT[99001],"false watch remained active")
end

do
    local native=assert(read("tests/native_buff_casters.lua"):match("^(.-)\nlocal function admits%("))
    local driver=assert(loadstring(native.."\nreturn fixture"))()("WARLOCK",4,install)
    local row=driver.row(driver.button())
    local allocated=#driver.frames
    driver.combat(true)
    driver.names[4079]="Cloaking"
    driver.globals.WatchHoT.ALL.Cloaking=3
    driver.hook("HealBot_Aura_ConfigClassHoT")
    assert(row.groups.hbcahotEveryone.options.candidateFilters.includeSpellIDs[4079],"first restricted frame lost bare singleton")
    assert(#driver.frames==allocated,"cold name lookup created frames in combat")
end

print("PASS: cold numeric and named settings, all nine classes, strict changes, rank-zone exclusions, broad mode, localized names, renamed and protected metadata")
