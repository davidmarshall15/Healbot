-- Run both ordinary aura scanners through the data-only reserve model and
-- verify the resulting status bar across applications, removals and reuse.
local function source(path)
    local f=assert(io.open(path,"rb"))
    local s=f:read("*a"):gsub("\r\n","\n")
    f:close()
    return s
end
local e,_,setHelpful=assert(loadfile("tests/fixtures/public_helpful.lua"))()("raid")
setHelpful({},true)
local noop=function() end
local timers,harmful={},{}
local curse="Hex"
local g=e.HealBot_Globals
e.HealBot_Data.UILOCK=true
e.HealBot_Data.PLAYERGROUP=1
e.HEALBOT_CUSTOM_en="Custom"
e.HealBot_Unit_Status={DEAD=100}
e.HealBot_Config_Buffs.CBshownHB=true
e.HealBot_Config_Cures.CDCshownHB=true
g.CustomDebuffs={[6002]=5}
g.CustomDebuffsShowBarCol={[6002]=3}
g.CureCustomDefaultCastBy=1
g.CustomDebuffsIconSet={}
g.CustomDebuffsIconGlow={}
g.WatchHoT={ALL={[6003]=3}}
g.CustomBuffIDMethod={[6003]=1}
g.CustomBuffsIconSet,g.CustomBuffsIconGlow,g.CustomBuffsFilter={},{},{}
g.CustomBuffs[6003],g.CustomBuffsShowBarCol[6003]=1,3
e.C_Secrets={ShouldAurasBeSecret=function() return false end}
e.C_UnitAuras.GetUnitAuras=function(_,filter) return filter=="HARMFUL" and harmful or {} end
e.UnitClass=function() return "Mage","MAGE" end
e.UnitGUID=function() return "public-guid" end
e.UnitGroupRolesAssigned=function() return "DAMAGER" end
e.UnitIsDeadOrGhost=function() return false end
e.UnitIsUnit=function(a,b) return a==b end
e.UnitIsEnemy=function() return false end
e.UnitPowerType=function() return 0 end
e.UnitLevel=function() return 35 end
e.GetRaidRosterInfo=function() return nil,nil,1 end
e.GetTime=function() return 100 end
e.HealBot_Panel_IsTank=function() return false end
e.HealBot_WoWAPI_UnitMana=function() return 200,400,50 end
e.HealBot_WoWAPI_SpellName=function(id) return ({[6002]=curse,[6003]="Tranquility"})[id] end
e.HealBot_Options_retDebuffPriority=function(id) return id==6002 and 5 or 99,20 end
e.HealBot_Options_retDebuffCureSpell=function() return nil end
e.HealBot_Options_RetBuffRGB=function() return .75,.76,.77 end
e.HealBot_Options_RetDebuffRGB=function() return .95,.2,.82 end
e.HealBot_Range_WarnInRange=function() return true end
e.hbv_Skins_GetIconVar=function() return 2 end
e.C_Timer={After=function(_,f) timers[#timers+1]=f end}
e.wipe=function(t) for k in pairs(t) do t[k]=nil end end
e.hooksecurefunc=noop
e.CreateFrame=function() return {RegisterEvent=noop,SetScript=noop} end
e.SlashCmdList={}
e.HealBot_Data.PCLASSTRIM="MAGE"
e.HealBot_setLuVars=noop
e.HealBot_Aura_ConfigClassHoT()
e.HealBot_Aura_SetAuraCheckFlags(false,false,false,false,false)
local refresh,paint,reset=setfenv(assert(loadstring(source("HealBot/HealBot_ForeverPartyJoin.lua")..
    "\nframe=1; return RefreshWarnings,ApplyHealthColour,ResetWarnings")),e)()
local colour
local row={unit="raid7",frame=1,hasHealthColour=true,baseR=.1,baseG=.2,baseB=.3,barAlpha=.5,
    IsVisible=function() return true end,healthBar={SetStatusBarColor=function(_,...) colour={...} end}}
e.HealBot_Events_UnitAura=function(button)
    button.aura.buff.update=true
    button.event.buff=true
end
local function check(expected,r,event)
    refresh(row,event or "UNIT_CONNECTION")
    for _,fn in ipairs(timers) do fn() end
    timers={}
    assert(row.warningKind==expected and colour[1]==r and colour[4]==.5,tostring(row.warningKind).." / "..tostring(colour[1]))
    paint(row)
    assert(colour[1]==r,"ordinary health paint lost the active warning")
end
local function aura(id,name,source)
    return {name=name,spellId=id,sourceUnit=source,expirationTime=0,duration=0,applications=1,icon=1}
end
check(nil,.1)
harmful={aura(6002,curse,"raid5")}
check("debuff",.95)
setHelpful({aura(6003,"Tranquility","raid6")})
check("buff",.75,"UNIT_AURA")
setHelpful({})
check("debuff",.95,"UNIT_AURA")
g.CustomDebuffsShowBarCol[6002]=1
check(nil,.1)
g.CustomDebuffsShowBarCol[6002]=3
check("debuff",.95)
harmful={}
check(nil,.1)
setHelpful({aura(6003,"Tranquility","raid4")})
check("buff",.75)
reset(row)
e.UnitGUID=function() return "replacement" end
setHelpful({})
check(nil,.1)
print("PASS: observed helpful and harmful auras drive reserve bar colors, priority, settings, removal and slot reuse")
