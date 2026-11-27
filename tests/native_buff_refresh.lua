-- Reuse the existing native-widget fixture without running its caster tests.
-- The fixture loads the actual production module and rejects native inspection,
-- frame allocation, group creation and container enabling during combat.
local function read(path)
    local file=assert(io.open(path,"rb")); local source=file:read("*a"); file:close()
    return source:gsub("\r\n","\n"):gsub("^\239\187\191","")
end
local fixtureSource=assert(read("tests/native_buff_casters.lua"):match("^(.-)\nlocal function admits%("),
    "native caster fixture boundary moved")
local nativeFixture=assert(loadstring(fixtureSource.."\nreturn fixture"))()
local passed=0
local function eq(actual,expected,label)
    assert(actual==expected,label..": expected "..tostring(expected)..", got "..tostring(actual))
    passed=passed+1
end
local function fixture()
    local driver=nativeFixture("PRIEST",4)
    driver.skin.limits={4,2,2}
    driver.globals.CustomBuffsIconSet={[139]=1,[17]=2,[774]=3}
    local counters={filters=0,limits=0,refreshes=0,units=0}
    driver.counters=counters
    function driver.instrument()
        for _,frame in ipairs(driver.frames) do
            if frame.kind=="AuraContainer" and not frame.refreshInstrumented then
                frame.refreshInstrumented=true
                local setFilter,setLimit,setUnit,refresh=frame.SetAuraGroupCandidateFilters,
                    frame.SetAuraGroupMaxFrameCount,frame.SetUnit,frame.UpdateAllAuras
                local function failWrite(self)
                    if self.failWriteAfter then
                        self.failWriteAfter=self.failWriteAfter-1
                        if self.failWriteAfter==0 then self.failWriteAfter=nil; error("injected native setter failure") end
                    end
                end
                function frame:SetAuraGroupCandidateFilters(key,value)
                    counters.filters=counters.filters+1; failWrite(self)
                    return setFilter(self,key,value)
                end
                function frame:SetAuraGroupMaxFrameCount(key,value)
                    counters.limits=counters.limits+1; failWrite(self)
                    return setLimit(self,key,value)
                end
                function frame:SetUnit(unit)
                    counters.units=counters.units+1
                    if self.failRetarget then self.failRetarget=false; error("injected unit change failure") end
                    return setUnit(self,unit)
                end
                function frame:UpdateAllAuras()
                    if self.groups.hbcahot then counters.refreshes=counters.refreshes+1 end
                    return refresh(self)
                end
            end
        end
    end
    local hook=driver.hook
    driver.hook=function(...)
        hook(...)
        driver.instrument()
    end
    function driver.resetCounts()
        for key in pairs(counters) do counters[key]=0 end
    end
    function driver.rows(button)
        local rows={}
        for _,frame in ipairs(driver.frames) do
            if frame.parent==button and frame.groups.hbcahot then rows[#rows+1]=frame end
        end
        return rows
    end
    function driver.forSpell(button,id)
        for _,row in ipairs(driver.rows(button)) do
            for _,group in pairs(row.groups) do
                if group.options.candidateFilters.includeSpellIDs
                    and group.options.candidateFilters.includeSpellIDs[id] then return row end
            end
        end
        error("missing configured native spell "..id)
    end
    return driver
end
local function otherCaster(row,id)
    local group=row.groups.hbcahotEveryone
    local filters=group.options.candidateFilters
    return group.options.maxFrameCount>0 and (not filters.includeSpellIDs or not not filters.includeSpellIDs[id])
        and not (filters.excludeSpellIDs and filters.excludeSpellIDs[id])
end

local raid=fixture()
local buttons={}
for i=1,40 do buttons[i]=raid.button("raid"..i) end
local allocated=#raid.frames
raid.resetCounts()
for _=1,20 do
    for _,button in ipairs(buttons) do raid.hook("HealBot_Skins_ResetSkin","bar",button) end
end
eq(raid.counters.filters,0,"first and repeated unchanged ResetSkin calls skip native filter setters")
eq(raid.counters.limits,0,"unchanged ResetSkin calls skip native count setters")
eq(#raid.frames,allocated,"unchanged resets retain all prepared rows")
raid.combat(true)
raid.resetCounts()
for _=1,20 do raid.hook("HealBot_Aura_SetAuraCheckFlags") end
eq(raid.counters.filters,0,"unchanged combat refreshes skip native filter setters")
eq(raid.counters.limits,0,"unchanged combat refreshes skip native count setters")
eq(raid.counters.refreshes,0,"unchanged combat refreshes do not rescan visible rows")
eq(#raid.frames,allocated,"combat refreshes allocate no frames")

local d=fixture()
local button=d.button()
local rows=d.rows(button)
eq(#rows,3,"all three icon sets have prepared native rows")
local renew=d.forSpell(button,139)
local rejuvenation=d.forSpell(button,774)
d.combat(true)
allocated=#d.frames
d.resetCounts()
d.globals.WatchHoT.PRIE[139]=3; d.hook("HealBot_Aura_ConfigClassHoT")
eq(otherCaster(renew,139),true,"changed caster policy applies during combat")
eq(d.counters.filters>0,true,"changed caster policy reaches native setters")
eq(#d.frames,allocated,"changed caster policy reuses prepared rows")
d.resetCounts(); d.hook("HealBot_Aura_ConfigClassHoT")
eq(d.counters.filters,0,"successfully changed caster policy is cached")
eq(d.counters.limits,0,"successfully changed caster budgets are cached")
d.disabled[139]=true; d.env.HealBot_Forever_RefreshBuffExclusions()
eq(otherCaster(renew,139),false,"manual disable invalidates the row policy")
d.disabled[139]=nil; d.env.HealBot_Forever_RefreshBuffExclusions()
eq(otherCaster(renew,139),true,"manual re-enable updates the existing native row")
d.disabled[774]=true; d.hook("HealBot_Aura_setLuVars","mapName")
eq(otherCaster(rejuvenation,774),false,"zone-dependent exclusions invalidate the row policy")
d.disabled[774]=nil; d.hook("HealBot_Aura_setLuVars","mapName")
eq(otherCaster(rejuvenation,774),true,"leaving an excluded zone restores the configured spell")
d.globals.WatchHoT.ALL[19740]=3; d.globals.CustomBuffsIconSet[19740]=2
d.hook("HealBot_Aura_ConfigClassHoT")
local might=d.forSpell(button,19740)
eq(otherCaster(might,19740),true,"adding a configured spell ID updates its prepared icon set")
d.globals.WatchHoT.ALL[19740]=nil; d.hook("HealBot_Aura_ConfigClassHoT")
eq(otherCaster(might,19740),false,"removing a configured spell ID clears native membership")

d.resetCounts(); d.globals.CombatAurasMaxDur=45
d.hook("HealBot_Aura_SetAuraCheckFlags")
for _,row in ipairs(rows) do
    eq(row.groups.hbcahot.options.candidateFilters.maxDuration,45,"Self duration change applies without an ID change")
    eq(row.groups.hbcahotEveryone.options.candidateFilters.maxDuration,45,"Everyone duration change applies without an ID change")
end
eq(d.counters.filters,12,"duration change updates all three rows once")
eq(d.counters.limits,6,"duration update retains bounded group budgets")
d.resetCounts(); d.hook("HealBot_Aura_SetAuraCheckFlags")
eq(d.counters.filters,0,"unchanged duration refresh skips setters")
d.globals.CombatAurasMaxDur=0; d.hook("HealBot_Aura_SetAuraCheckFlags")
eq(renew.groups.hbcahotEveryone.options.candidateFilters.maxDuration,nil,"removing a duration cap clears native policy")

d.config.BuffCustomWatchInCombat=false; d.hook("HealBot_Aura_SetAuraCheckFlags")
eq(renew.shown,false,"Also in combat off hides native rows")
d.resetCounts(); d.globals.WatchHoT.PRIE[139]=1; d.globals.CombatAurasMaxDur=60
d.hook("HealBot_Aura_ConfigClassHoT")
eq(d.counters.filters,0,"combat-disabled policy updates are deferred")
eq(otherCaster(renew,139),true,"deferred policy preserves the previous prepared configuration")
eq(renew.groups.hbcahotEveryone.options.candidateFilters.maxDuration,nil,"combat gate also defers duration changes")
d.combat(false)
eq(otherCaster(renew,139),false,"deferred caster policy applies on regeneration")
eq(renew.groups.hbcahot.options.candidateFilters.maxDuration,60,"deferred duration applies on regeneration")
d.combat(true); d.resetCounts(); d.globals.CombatAurasMaxDur=61
d.hook("HealBot_Aura_SetAuraCheckFlags")
eq(d.counters.filters,0,"a duration-only change also obeys the disabled combat gate")
d.combat(false)
eq(renew.groups.hbcahot.options.candidateFilters.maxDuration,61,"a duration-only deferred policy is retried on regeneration")
d.config.BuffCustomWatchInCombat=true; d.combat(true)
d.resetCounts()
d.hook("HealBot_Action_UnregisterUnitEvents",button)
d.hook("HealBot_Action_RegisterUnitEvents",button)
eq(d.counters.refreshes,3,"hidden-to-visible transitions still refresh all buff rows")
eq(d.counters.filters,0,"visibility transitions reuse native policies")
button.unit="party3"; d.resetCounts(); d.hook("HealBot_Action_RegisterUnitEvents",button)
for _,row in ipairs(rows) do eq(row.unit,"party3","cached policies do not block retargeting") end
eq(d.counters.refreshes,3,"retargeting still refreshes every visible buff row")
eq(d.counters.filters,0,"retargeting does not rewrite unchanged policies")
renew.failRetarget=true; button.unit="party4"
d.hook("HealBot_Action_RegisterUnitEvents",button)
eq(renew.shown,false,"a failed native unit change hides the old recipient")
d.hook("HealBot_Action_RegisterUnitEvents",button)
eq(renew.unit,"party4","native unit changes remain retryable with a cached policy")
eq(renew.shown,true,"successful native retarget retry restores the row")

-- Failing after the first group is cleared leaves a partial native policy.
-- Restoring the previous setting must still retry; an old success cache cannot
-- claim that partially changed native state already matches the desired policy.
d.resetCounts(); renew.failWriteAfter=2
d.globals.WatchHoT.PRIE[139]=3; d.hook("HealBot_Aura_ConfigClassHoT")
eq(renew.shown,false,"partial native policy failure hides its unconfirmed display")
d.globals.WatchHoT.PRIE[139]=1; d.hook("HealBot_Aura_ConfigClassHoT")
eq(renew.groups.hbcahot.options.candidateFilters.includeSpellIDs[139],true,"reverting after partial failure reapplies the previous policy")
eq(renew.shown,true,"successful native policy retry restores the display")
d.resetCounts(); d.hook("HealBot_Aura_ConfigClassHoT")
eq(d.counters.filters,0,"a completed policy retry becomes cacheable")
renew.failWriteAfter=5; d.globals.CombatAurasMaxDur=90
d.hook("HealBot_Aura_SetAuraCheckFlags"); d.resetCounts()
d.hook("HealBot_Aura_SetAuraCheckFlags")
eq(renew.groups.hbcahot.options.candidateFilters.maxDuration,90,"same-filter duration failures are retried on the next refresh")
eq(d.counters.filters,4,"only the failed row needs its unchanged-policy retry")
eq(d.counters.limits,2,"only the failed row rewrites its group budgets")

local empty=fixture()
empty.globals.WatchHoT.PRIE={}; empty.globals.WatchHoT.DRUI={}
local emptyButton=empty.button(); local emptyRows=empty.rows(emptyButton)
empty.combat(true); empty.resetCounts(); allocated=#empty.frames
empty.hook("HealBot_Aura_ConfigClassHoT")
eq(empty.counters.filters,0,"prepared empty policies also skip unchanged setters")
empty.globals.WatchHoT.DRUI[774]=3; empty.hook("HealBot_Aura_ConfigClassHoT")
eq(empty.forSpell(emptyButton,774).shown,true,"first configured buff activates a prepared empty row")
eq(#empty.frames,allocated,"first combat buff allocates no replacement row")
for _,row in ipairs(emptyRows) do
    eq(row.groups.hbcahot.options.maxFrameCount+row.groups.hbcahotEveryone.options.maxFrameCount<=row.hbcaBuffLimit,
        true,"empty and populated scopes share their original icon cap")
end

local arrival=fixture()
local donor=arrival.button(); local reserve={unit="party2",frame=1,healthBar={}}
function reserve:GetFrameLevel() return 5 end
arrival.env.HealBot_Forever_SkinArrivalAuras(reserve,donor)
arrival.instrument()
arrival.resetCounts(); allocated=#arrival.frames
arrival.env.HealBot_Forever_SkinArrivalAuras(reserve,donor)
eq(arrival.counters.filters,0,"unchanged arrival reskin uses the creation-seeded policy cache")
eq(arrival.counters.limits,0,"unchanged arrival reskin skips native budget setters")
arrival.combat(true); arrival.resetCounts()
arrival.hook("HealBot_Aura_SetAuraCheckFlags")
eq(arrival.counters.filters,0,"unchanged combat arrival refreshes also skip native setters")
arrival.globals.WatchHoT.PRIE[139]=3; arrival.hook("HealBot_Aura_ConfigClassHoT")
local reserveRenew
for _,item in ipairs(reserve.arrivalAuras) do if item.set==1 then reserveRenew=item.container end end
eq(otherCaster(assert(reserveRenew),139),true,"arrival policies still update in combat")
eq(#arrival.frames,allocated,"arrival policy updates retain prepared frames")
reserveRenew.failWriteAfter=2; arrival.globals.CombatAurasMaxDur=30
arrival.hook("HealBot_Aura_SetAuraCheckFlags")
eq(reserveRenew.shown,false,"a failed arrival setter hides its unconfirmed partial policy")
arrival.resetCounts(); arrival.hook("HealBot_Aura_SetAuraCheckFlags")
eq(reserveRenew.shown,true,"a successful arrival retry restores the prepared row")
eq(reserveRenew.groups.hbcahotEveryone.options.candidateFilters.maxDuration,30,"same-filter arrival failures retry the requested duration")
eq(arrival.counters.filters,4,"arrival retry rewrites only the failed row")
eq(arrival.counters.limits,2,"arrival retry reapplies only the failed row budget")

-- Structural limits still rebuild outside combat and seed the replacement cache.
d.combat(false); d.skin.limits[1]=2; d.hook("hbv_Skins_SetIconVar",0,"MAXBICONS",1)
local limited
-- The fixture retains dormant frames, so select the newest matching row.
local candidates=d.rows(button)
for index=#candidates,1,-1 do
    local row=candidates[index]
    local ids=row.groups.hbcahot.options.candidateFilters.includeSpellIDs
    if ids and ids[139] then limited=row; break end
end
eq(limited.hbcaBuffLimit,2,"changed skin limits create the correct replacement policy")
eq(limited.groups.hbcahot.options.maxFrameCount+limited.groups.hbcahotEveryone.options.maxFrameCount,2,"replacement groups obey the changed limit")
d.resetCounts(); d.hook("HealBot_Skins_ResetSkin","bar",button)
eq(d.counters.filters,0,"replacement row creation also seeds its policy cache")
eq(d.counters.limits,0,"replacement budgets avoid the first redundant rewrite")

-- Count lookups of one cache-only spell. The policy builder resolves its name
-- once per full scan, regardless of how many spells match the configured rows.
local function countScans(driver)
    local counts={policy=0,exclusions=0}
    local marker=990002
    driver.env.HealBot_Spell_IDs[marker]={}
    local spellName=driver.env.HealBot_WoWAPI_SpellName
    driver.env.HealBot_WoWAPI_SpellName=function(id)
        if id==marker then counts.policy=counts.policy+1 end
        return spellName(id)
    end
    local exclusions=driver.env.HealBot_Aura_NativeBuffExclusions
    driver.env.HealBot_Aura_NativeBuffExclusions=function()
        counts.exclusions=counts.exclusions+1
        return exclusions()
    end
    return counts
end
local multi=fixture()
local scans=countScans(multi)
multi.combat(true)
local queued={}
for i=1,40 do queued[i]=multi.button("raid"..i) end
eq(scans.policy,0,"bar creation is deferred in combat")
multi.combat(false)
eq(scans.policy,1,"one configuration scan prepares 40 deferred raid bars")
eq(scans.exclusions,0,"Forever caster rows skip the unused single-group exclusions")
for _,bar in ipairs(queued) do
    eq(otherCaster(multi.forSpell(bar,139),139),false,"deferred bar has its Self policy")
end
scans.policy=0
for i=1,4 do
    local reserve={unit="party"..i,frame=1,healthBar={},GetFrameLevel=function() return 5 end}
    multi.env.HealBot_Forever_SkinArrivalAuras(reserve,queued[1])
end
eq(scans.policy,4,"standalone reserve refreshes each read fresh settings")
multi.globals.WatchHoT.PRIE[139]=3
scans.policy=0
multi.hook("HealBot_Aura_ConfigClassHoT")
eq(scans.policy,1,"ordinary and four reserve rows share one configuration scan")
for _,bar in ipairs(queued) do
    eq(otherCaster(multi.forSpell(bar,139),139),true,"next refresh applies changed caster settings")
end

local off=fixture()
local hiddenScans=countScans(off)
off.config.BuffWatch=false
off.combat(true)
local hiddenBars={}
for i=1,40 do hiddenBars[i]=off.button("raid"..i) end
off.combat(false)
eq(hiddenScans.policy,0,"disabled monitoring skips policy scans for deferred bars")
eq(hiddenScans.exclusions,0,"disabled monitoring skips exclusion scans during row creation")
local donor=hiddenBars[1]
local reserve={unit="party1",frame=1,healthBar={},GetFrameLevel=function() return 5 end}
off.env.HealBot_Forever_SkinArrivalAuras(reserve,donor)
off.combat(true)
off.hook("HealBot_Aura_SetAuraCheckFlags")
eq(hiddenScans.policy,0,"disabled monitoring skips scans on reserve setup and combat flag refresh")
eq(#off.rows(donor),3,"disabled monitoring keeps all native buff rows prepared")
local renew=off.rows(donor)[1]
eq(renew.shown,false,"disabled monitoring hides the prepared buff row")
local dispelRow
for _,frame in ipairs(off.frames) do
    if frame.parent==donor and frame.groups.hbcadb then dispelRow=frame; break end
end
eq(assert(dispelRow).shown,true,"debuff monitoring stays active with buffs disabled")
local framesBeforeToggle=#off.frames
off.globals.WatchHoT.PRIE[139]=3
off.config.BuffWatch=true
off.hook("HealBot_Aura_SetAuraCheckFlags")
eq(hiddenScans.policy,1,"re-enabling in combat reads current settings once")
eq(otherCaster(renew,139),true,"prepared raid row picks up caster changes made while disabled")
eq(renew.shown,true,"raid row is visible after re-enabling in combat")
local reserveRenew=reserve.arrivalAuras[1].container
eq(otherCaster(reserveRenew,139),true,"prepared reserve row picks up the same caster change")
eq(reserveRenew.shown,true,"reserve row is visible after re-enabling")
off.config.BuffWatch=false
off.hook("HealBot_Aura_SetAuraCheckFlags")
eq(hiddenScans.policy,1,"disabling again skips the configuration scan")
eq(renew.shown,false,"disabling again hides the raid row")
eq(reserveRenew.shown,false,"disabling again hides the reserve row")
eq(#off.frames,framesBeforeToggle,"both combat toggles reuse the prepared frames")

print("PASS: "..passed.." native buff refresh assertions (mock native widgets; not an in-game test)")
