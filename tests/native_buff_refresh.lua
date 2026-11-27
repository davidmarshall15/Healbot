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

print("PASS: "..passed.." native buff refresh assertions (mock native widgets; not an in-game test)")
