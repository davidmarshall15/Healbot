-- Exercise tooltip ownership with both immediate and out-of-order spell loads.
local function noop() end
local function fixture()
    local env=setmetatable({}, {__index=function(_,key)
        if key:match("^HEALBOT_") then return key end
        return _G[key]
    end})
    local g={ShowTooltip=true,Tooltip_ShowDebuffIconInfo=true,Tooltip_ShowBuffIconInfo=true,
             CDCBarColour={},CustomBuffBarColour={},CustomDebuffsShowBarCol={},CustomDebuffsIconGlow={},
             CustomBuffs={},CustomBuffsShowBarCol={},CustomBuffsIconGlow={}}
    local icons, callbacks, cached={}, {}, {}
    local state={loads=0,reads=0,draws=0,compact=0}
    local buttons={{id=1,unit="raid1",frame=1,text={nameonly="One"}},{id=2,unit="raid2",frame=2,text={nameonly="Two"}}}
    for i=1,2 do
        icons[i]={}
        for _,slot in ipairs({1,51,52}) do
            local id=slot==52 and 99 or 42
            icons[i][slot]={current=true,spellId=id,gSlot=slot,count=1,expirationTime=0}
            g.CDCBarColour[id]={R=1,G=1,B=1}
            g.CustomBuffBarColour[id]=g.CDCBarColour[id]
        end
    end
    local function line(_,text) state.first=state.first or text end
    local tip={
        ClearLines=function() state.first=nil end, AddLine=line, AddDoubleLine=line, SetAlpha=noop,
        Show=function() state.visible=true;state.draws=state.draws+1 end, Hide=function() state.visible=false end,
        SetUnit=function(_,unit) state.first=unit end,
    }
    for key,value in pairs({
        HEALBOT_GAME_VERSION=1,strlower=string.lower,ceil=math.ceil,GetTime=function() return 10 end,
        HealBot_Globals=g,HealBot_Data={TIPUSE=true},HealBot_GameTooltip=tip,hbv_GetStatic=function() return 1 end,
        HealBot_Aura_ReturnDebuffdetails=function(id) return icons[id] end,HealBot_Aura_ReturnHoTdetails=function(id) return icons[id] end,
        HealBot_Aura_ReturnDebuffdetailsname=function(id) return "Debuff "..id end,
        HealBot_Aura_ReturnHoTdetailsname=function(id) return "Buff "..id end,
        HealBot_Options_retDebuffPriority=function() return 1,1 end,HealBot_Options_retAuraBarCol=noop,
        HealBot_Options_retAuraIconGlow=noop,hbv_Skins_GetIconVar=function() return 1 end,
        HealBot_issecretvalue=function() return false end,UnitGUID=function() return "fixture" end,UnitExists=function() return true end,
        HealBot_Action_SetCurrentModKeys=noop,HealBot_Action_ModKey=noop,HealBot_Range_setLuVars=noop,
        HealBot_Action_UpdateGlobalDimming=noop,grpFrameBar={{},{}},
        HealBot_ScanTooltip={SetUnitDebuff=function() state.compact=state.compact+1 end,SetUnitBuff=function() state.compact=state.compact+1 end},
        HealBot_ScanTooltipTextLeft2={GetText=noop},HealBot_ScanTooltipTextLeft3={GetText=noop},
        Spell={CreateFromSpellID=function(_,id)
            state.loads=state.loads+1
            return {ContinueOnSpellLoad=function(_,callback)
                if cached[id] then callback(); return end
                callbacks[id]=callbacks[id] or {}
                table.insert(callbacks[id],callback)
                if state.failNext then state.failNext=false; error("injected registration error") end
            end,GetSpellDescription=function() state.reads=state.reads+1; return "" end}
        end},
    }) do env[key]=value end
    setfenv(assert(loadfile("HealBot_Tips/HealBot_Tooltip.lua")),env)()
    env.HealBot_Tooltip_setLuVars("doInit",false)
    env.HealBot_ToolTip_SetTooltipPos=function(frame) state.frame=frame end
    local function loadHandlers(file,names)
        local f=assert(io.open(file,"rb"));local source=f:read("*a"):gsub("\r\n","\n");f:close()
        for _,name in ipairs(names) do
            setfenv(assert(loadstring(assert(source:match("(function "..name.."%b().-\nend)")))),env)()
        end
    end
    loadHandlers("HealBot/HealBot_Action.lua",{"HealBot_Action_DebuffIcon_OnLeave","HealBot_Action_HideTooltipFrame"})
    loadHandlers("HealBot/HealBot_Events.lua",{"HealBot_Events_ModifierChange"})
    local function complete(id)
        local waiting=assert(callbacks[id])
        callbacks[id]=nil;cached[id]=true
        for _,callback in ipairs(waiting) do callback() end
    end
    return env,g,state,buttons,icons,cached,complete
end

do
    local e,g,s,b,_,_,complete=fixture()
    e.HealBot_Tooltip_DebuffIconTooltip(b[1],51)
    for i=1,40 do e.HealBot_Events_ModifierChange() end
    assert(s.loads==1 and s.draws==0,"modifier refreshes queued duplicate spell loads")
    e.HealBot_Action_DebuffIcon_OnLeave(b[1],51)
    complete(42)
    assert(not s.visible and s.draws==0 and s.reads==0,"late data revived the tooltip after leave")
    e.HealBot_Tooltip_DebuffIconTooltip(b[1],51)
    assert(s.visible and s.first=="Debuff 42" and s.reads==1,"cached spell data failed to draw immediately")
end

do
    local e,_,s,b,_,_,complete=fixture()
    e.HealBot_Tooltip_DebuffIconTooltip(b[1],51)
    e.HealBot_Action_DebuffIcon_OnLeave(b[1],51)
    e.HealBot_Tooltip_DebuffIconTooltip(b[2],52)
    complete(99);complete(42)
    assert(s.draws==1 and s.reads==1 and s.frame==2 and s.first=="Debuff 99","old spell replaced new tooltip")
end

do
    local e,_,s,b,_,_,complete=fixture()
    e.HealBot_Tooltip_DebuffIconTooltip(b[1],51)
    e.HealBot_Action_DebuffIcon_OnLeave(b[1],51)
    e.HealBot_Tooltip_BuffIconTooltip(b[2],1)
    complete(42)
    assert(s.loads==1 and s.reads==1 and s.draws==1 and s.frame==2 and s.first=="Buff 42",
           "same-spell handoff used old unit, slot, or aura type")
end

do
    local e,g,s,b,_,_,complete=fixture()
    e.HealBot_Tooltip_DebuffIconTooltip(b[1],51)
    g.Tooltip_ShowDebuffIconCompact=true
    e.HealBot_Events_ModifierChange()
    complete(42)
    assert(s.compact==1 and s.draws==1 and s.reads==0,"detailed callback overwrote compact mode")
end

do
    local e,g,s,b,_,_,complete=fixture()
    e.HealBot_Tooltip_BuffIconTooltip(b[1],1)
    g.Tooltip_ShowTarget=true
    e.HealBot_Data.TIPBUTTON,e.HealBot_Data.TIPTYPE=b[2],"WoWUnit"
    e.HealBot_Action_DoRefreshTooltip()
    complete(42)
    assert(s.draws==1 and s.first=="raid2" and s.reads==0,"icon replaced the newer unit tooltip")
end

for _,changed in ipairs({"unit","slot","spell","removed","settings"}) do
    local e,g,s,b,icons,_,complete=fixture()
    e.HealBot_Tooltip_DebuffIconTooltip(b[1],51)
    if changed=="unit" then b[1].unit="raid3"
    elseif changed=="slot" then icons[1][51]=nil
    elseif changed=="spell" then icons[1][51].spellId=77
    elseif changed=="removed" then icons[1][51].current=false
    else g.Tooltip_ShowDebuffIconInfo=false end
    complete(42)
    assert(s.draws==0 and s.reads==0,"obsolete icon rendered after change to "..changed)
end
do
    local e,_,s,b,_,_,complete=fixture()
    s.failNext=true
    assert(not pcall(e.HealBot_Tooltip_DebuffIconTooltip,b[1],51))
    e.HealBot_Tooltip_DebuffIconTooltip(b[1],51)
    complete(42)
    assert(s.loads==2 and s.draws==1 and s.reads==1,"failed registration blocked or duplicated retry")
end
print("PASS: icon tooltip loads follow current unit, slot, mode and owner, including immediate completion")
