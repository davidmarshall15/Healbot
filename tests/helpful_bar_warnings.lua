-- Drive ordinary public helpful-aura selection, RGB updates, and cleanup.
local e,make,put=assert(loadfile("tests/fixtures/public_helpful.lua"))()("party")
local function noop() end
local g=e.HealBot_Globals
g.WatchHoT={ALL={}}
g.CustomBuffIDMethod={};g.CustomBuffsIconSet={};g.CustomBuffsIconGlow={};g.CustomBuffsFilter={}
local names={[774]="Rejuvenation",[1058]="Rejuvenation",[19740]="Blessing of Might",[1459]="Arcane Intellect"}
for id in pairs(names) do
    g.WatchHoT.ALL[id]=3
    g.CustomBuffIDMethod[id]=1
    g.CustomBuffsShowBarCol[id]=3
end
g.CustomBuffs[774],g.CustomBuffs[1058],g.CustomBuffs[19740],g.CustomBuffs[1459]=3,3,4,1
g.CustomBuffsIconSet[774],g.CustomBuffsIconSet[1058],g.CustomBuffsIconSet[19740],g.CustomBuffsIconSet[1459]=2,2,1,3
e.HealBot_WoWAPI_SpellName=function(id) return names[id] end
e.HealBot_Data.PCLASSTRIM="DRUI"
e.HealBot_setLuVars=noop
e.HealBot_Aura_CheckUnitBuffIcons=noop
e.HealBot_Aura_BuffUpdate_Plugins=noop
e.HealBot_Aura_AuxSetAuraBuffBars=noop;e.HealBot_Aura_AuxClearAuraBuffBars=noop
e.HealBot_Range_WarnInRange=function() return true end
e.HealBot_Emerg_Button={{}};e.HealBot_RefreshUnit=noop
e.HealBot_Aura_SetAuraWarningFlags()
local colors={[774]=.1,[1058]=.2,[19740]=.3,[1459]=.4}
local repaints=0
e.HealBot_Options_RetBuffRGB=function(b) repaints=repaints+1;return colors[b.aura.buff.id],0,0 end
local limits={1,0,0}
e.hbv_Skins_GetIconVar=function(_,_,set) return limits[set] end
local b=make("raid1",1)
b.hazard={};b.glow={};b.aura.debuff={priority=1,colbar=2}
e.HealBot_Aura_ConfigClassHoT()
local function scan(ids,locked)
    local list={}
    for _,id in ipairs(ids) do
        list[#list+1]={name=names[id],spellId=id,sourceUnit="player",duration=12,expirationTime=220,applications=1,icon=1}
    end
    put(list,locked)
    b.aura.buff.update=true
    e.HealBot_Aura_CheckUnitBuffs(b,false)
    return b.aura.buff
end
for _,combat in ipairs({false,true}) do
    local state=scan({774,19740},combat)
    assert(state.id==774 and state.colbar==2 and state.r==colors[774],"a hidden Rejuvenation set lost its higher-priority tint")
    assert(b.icon.buff.count[1]==1 and b.icon.buff.count[2]==0 and b.aura.debuff.colbar==2)
    state=scan({1058,19740},combat)
    assert(state.id==1058 and state.r==colors[1058],"the new strict-ID rank kept the previous rank's RGB")
    local steady=repaints
    scan({1058,19740},combat)
    assert(repaints==steady,"unchanged warning repainted")
    state=scan({1058,19740,1459},combat)
    assert(state.id==1459 and state.r==colors[1459] and b.icon.buff.count[3]==0,"third set lost its priority")
    g.CustomBuffsShowBarCol[1459]=1
    state=scan({1058,19740,1459},combat)
    assert(state.id==1058 and state.r==colors[1058],"hidden icon-only candidate suppressed a configured tint")
    g.CustomBuffsShowBarCol[1459]=3
    state=scan({19740},combat)
    assert(state.id==19740 and state.r==colors[19740])
    limits[1]=0
    state=scan({19740},combat)
    assert(state.id==19740 and state.r==colors[19740] and b.icon.buff.count[1]==0)
    state=scan({},combat)
    assert(not state.name and state.colbar==0,"ended warning retained its tint")
    limits[1]=1
end
e.HealBot_Config_Buffs.BuffCustomWatchInCombat=false
local blocked=scan({774,19740},true)
assert(not blocked.name and blocked.colbar==0,"disabled in-combat monitoring still painted a hidden set")
print("PASS: helpful tints across three sets, hidden icons, strict same-name ranks, higher-priority debuffs, cleanup and stable repaints")
