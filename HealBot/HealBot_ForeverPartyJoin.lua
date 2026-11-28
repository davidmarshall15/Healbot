if not HEALBOT_FOREVER then return end

local rows={}
local panel
local refreshQueued=false
local bindingGeneration=0
local rosterMode
local bindingError
local mouseButtons={"Left","Right","Middle"}
for index=4,20 do mouseButtons[index]="Button"..index end

local frame
local frameSkin
local skinDirty=true
local alignments={"LEFT","CENTER","RIGHT"}
local secret=HealBot_issecretvalue

local function GroupFrame(inRaid)
    local groups=Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin]
    local groupFrame,raidFrame
    for _,group in ipairs(groups or {}) do
        if group.STATE then
            if group.NAME==HEALBOT_OPTIONS_GROUPHEALS_en then groupFrame=group.FRAME end
            if group.NAME==HEALBOT_OPTIONS_EMERGENCYHEALS_en then raidFrame=group.FRAME end
        end
    end
    return (inRaid and raidFrame) or groupFrame or raidFrame or 1
end

local function Get(category,key)
    return hbv_Skins_GetFrameVar(category,key,frame)
end

local function RGB(category,prefix)
    return Get(category,prefix.."R"),Get(category,prefix.."G"),Get(category,prefix.."B")
end

local function Colour(mode,category,prefix,pct,red,green,cr,cg,cb,rr,rg,rb)
    if mode==1 then return red,green,0 end
    if mode==2 then return cr,cg,cb end
    if mode==3 then return rr,rg,rb end
    if mode==5 or mode==6 then
        local r,g,b=cr,cg,cb
        if mode==6 then r,g,b=rr,rg,rb end
        if secret(pct) or pct>0.89 then return r,g,b end
        if pct<=0.64 then return red,green,0 end
        local mix=(0.89-pct)/0.25
        return r+(1-r)*mix,g+(1-g)*mix,b*pct
    end
    return RGB(category,prefix)
end

local function PaintPower(row)
    if not row.skinPower or not next(row.skinPower) then return end
    local powerType,token=UnitPowerType(row.unit)
    local power,maximum,percent=HealBot_WoWAPI_UnitMana(row.unit,powerType)
    local colour=not secret(token) and PowerBarColor[token] or nil
    colour=colour or PowerBarColor.MANA
    local role=UnitGroupRolesAssigned(row.unit)
    for id,entry in pairs(row.skinPower) do
        local bar,text=entry.bar,entry.text
        bar:SetMinMaxValues(0,maximum)
        bar:SetValue(power)
        if hbv_Aux_GetBarVar("COLOUR",row.frame,id)==1 then
            bar:SetStatusBarColor(colour.r,colour.g,colour.b,entry.alpha)
        end
        local hidden=false
        if hbv_Aux_GetBarBoolean("MANAONLY",row.frame,id) then
            hidden=not secret(powerType) and powerType~=0
            if hbv_Aux_GetBarBoolean("HEALERSMANAONLY",row.frame,id) and not secret(role) then
                hidden=hidden or (role~="HEALER")
            end
        end
        bar:SetAlpha(hidden and 0 or 1)
        if hbv_Aux_GetBarBoolean("TEXT",row.frame,id) and not hidden then
            if Get("BarText","HLTHTYPE")==1 then text:SetFormattedText("%d",power)
            else text:SetFormattedText("%d%%",percent) end
        else text:SetText("") end
    end
end

local incomingColourModes={[3]=2,[4]=3,[6]=4,[7]=5,[8]=6}

local function SelectWarning(row)
    row.warningKind=nil
    local button=row.warningButton
    if button and button.status.events and not button.status.isdead then
        local d,buff=button.aura.debuff,button.aura.buff
        if d.name and (d.colbar==2 or d.colbar==3) and HealBot_Config_Cures.CDCshownHB
            and (d.dispellable or not HealBot_Config_Cures.CDCshownHBDispelOnly)
            and HealBot_Range_WarnInRange(button,d.curespell,HealBot_Config_Cures.WarnRange_Bar) then
            row.warningKind="debuff"
        elseif buff.name and not buff.missingbuff and (buff.colbar==2 or buff.colbar==3)
            and HealBot_Config_Buffs.CBshownHB and not HealBot_Config_Buffs.CBshownHBMissingOnly
            and HealBot_Range_WarnInRange(button,buff.name,HealBot_Config_Buffs.WarnRange_Bar) then
            row.warningKind="buff"
        end
    end
end

local function ApplyHealthColour(row)
    if not row.hasHealthColour then return end
    local warning=row.warningKind and row.aura[row.warningKind]
    if warning then row.healthBar:SetStatusBarColor(warning.r,warning.g,warning.b,row.barAlpha)
    else row.healthBar:SetStatusBarColor(row.baseR,row.baseG,row.baseB,row.barAlpha) end
end

local function Public(value)
    if not secret(value) then return value end
end

local function ResetWarnings(row)
    local button=row.warningButton
    if not button then return end
    button.status.events=false
    button.aura.buff={colbar=0,priority=99,recheck={},temp={}}
    button.aura.debuff={colbar=0,priority=99,temp={}}
    button.guid=nil
    button.rosterName,button.rosterRealm=nil,nil
    if row.warningTimer then row.warningTimer:Cancel(); row.warningTimer=nil end
    row.warningDeadline=nil
    row.warningKind=nil
end

local function QueueWarningScan(row)
    if row.warningQueued then return end
    row.warningQueued=true
    C_Timer.After(0,function()
        row.warningQueued=nil
        local button=row.warningButton
        if not button or not button.status.events or not row:IsVisible() then return end
        -- Changes to either family can change which warning wins.
        if button.event.buff then
            button.event.buff=false
            local suppressedDebuff=button.aura.buff.overdb
            HealBot_Aura_CheckUnitBuffs(button)
            if suppressedDebuff then button.event.debuff=true end
        end
        if button.event.debuff then
            button.event.debuff=false
            HealBot_Aura_CheckUnitDebuffs(button)
        end
        SelectWarning(row)
        ApplyHealthColour(row)
        local now=GetTime()
        local deadline
        local d=button.aura.debuff
        if d.barOnly and d.id==6788 and HealBot_Forever_GetShieldLockout then
            local start,duration=HealBot_Forever_GetShieldLockout(button)
            if start and start+duration>now then deadline=start+duration end
        end
        if row.warningDeadline~=deadline then
            if row.warningTimer then row.warningTimer:Cancel(); row.warningTimer=nil end
            row.warningDeadline=deadline
            if deadline then
                row.warningTimer=C_Timer.NewTimer(deadline-now+0.05,function()
                    row.warningTimer,row.warningDeadline=nil,nil
                    button.aura.buff.update,button.aura.debuff.update=true,true
                    button.event.buff,button.event.debuff=true,true
                    QueueWarningScan(row)
                end)
            end
        end
    end)
end

local function RefreshWarnings(row,event,info)
    if not HealBot_Aura_InitReserveWarnings then return end
    local unit=row.unit
    local button=row.warningButton
    local guid=Public(UnitGUID(unit))
    local name,realm
    if not guid and HealBot_Events_RosterAuraName then name,realm=HealBot_Events_RosterAuraName(unit) end
    if not button then
        button={reserveWarnings=true,reserveBuffCurrent={},reserveDebuffCurrent={},unit=unit,
            frame=row.frame or frame,isplayer=true,isgroupraid=true,special={},status={current=0},
            event={},range={},health={current=0},mana={},text={},aura={},
            icon={buff={count={0,0,0}},debuff={count={0,0,0}}}}
        row.warningButton=button
        row.aura=button.aura
        button.queueReserveScan=function() QueueWarningScan(row) end
        HealBot_Aura_InitReserveWarnings(button)
        ResetWarnings(row)
    elseif (guid and button.guid and guid~=button.guid) or event=="PLAYER_ENTERING_WORLD"
        or (event=="GROUP_ROSTER_UPDATE" and not (guid and guid==button.guid)
            and not (name and name==button.rosterName and realm==button.rosterRealm)) then
        ResetWarnings(row)
    end
    if not Public(UnitIsConnected(unit)) or not Public(UnitIsVisible(unit)) then
        ResetWarnings(row)
        ApplyHealthColour(row)
        return
    end
    local fresh=not button.status.events
    button.frame=row.frame or frame
    button.framecol=button.frame
    if guid then button.guid=guid end
    if name then button.rosterName,button.rosterRealm=name,realm end
    button.status.events=true
    button.status.isdead=Public(UnitIsDeadOrGhost(unit))
    if fresh or event~="UNIT_AURA" then
        local oldGroup,oldRole,oldPlayerGroup,oldTank=button.group,button.roletxt,button.playerGroup,button.rosterTank
        button.player=Public(UnitIsUnit(unit,"player"))
        button.roletxt=Public(UnitGroupRolesAssigned(unit))
        if button.roletxt=="NONE" then button.roletxt=Public(HealBot_Panel_UnitRoleDefault(unit)) end
        local _,class=UnitClass(unit)
        class=Public(class)
        button.text.classtrim=class and class:sub(1,4)
        button.level=Public(UnitLevel(unit)) or 0
        button.mana.type=Public(UnitPowerType(unit))
        local _,_,pct=HealBot_WoWAPI_UnitMana(unit,button.mana.type)
        button.mana.pct=pct
        local index=tonumber(unit:match("^raid(%d+)$"))
        if index then
            local _,_,group=GetRaidRosterInfo(index)
            button.group=Public(group)
        else
            button.group=HealBot_Data.PLAYERGROUP
        end
        button.playerGroup=HealBot_Data.PLAYERGROUP
        button.rosterTank=Public(HealBot_Panel_IsTank(unit))
        if not fresh and event=="GROUP_ROSTER_UPDATE" and oldGroup==button.group and oldRole==button.roletxt
            and oldPlayerGroup==button.playerGroup and oldTank==button.rosterTank then return end
    end
    button.range.eventIn=row.eventInRange
    button.range.current=row.outOfRange and 0 or 1
    if event=="UNIT_AURA" and not fresh then
        HealBot_Events_UnitAura(button,unit,info)
    else
        button.aura.buff.update,button.aura.debuff.update=true,true
        button.event.buff,button.event.debuff=true,true
        if event=="UNIT_AURA" then HealBot_Events_UnitAura(button,unit,info) end
    end
    QueueWarningScan(row)
end

function HealBot_Forever_RefreshReserveWarnings(side)
    for _,row in ipairs(rows) do
        if row:IsVisible() then
            local button=row.warningButton
            if button and button.status.events then
                button.aura[side].update=true
                button.event[side]=true
                QueueWarningScan(row)
            else
                RefreshWarnings(row)
            end
        end
    end
end

local function Paint(row,event,info)
    local unit=row.unit
    if not frame or not UnitExists(unit) then return end
    if event=="UNIT_AURA" or event=="UNIT_POWER_UPDATE" or event=="UNIT_MAXPOWER" or event=="UNIT_DISPLAYPOWER" then
        if event=="UNIT_AURA" or event=="UNIT_DISPLAYPOWER" then RefreshWarnings(row,event,info) end
        if event~="UNIT_AURA" then PaintPower(row) end
        if HealBot_Forever_UpdateArrivalAuras then
            HealBot_Forever_UpdateArrivalAuras(row,event=="UNIT_AURA" or event=="UNIT_DISPLAYPOWER")
        end
        return
    end
    local health,maximum,pct,percent,_,red,green=HealBot_WoWAPI_UnitHealth(unit)
    row.healthBar:SetMinMaxValues(0,maximum)
    row.healthBar:SetValue(health)
    local _,class=UnitClass(unit)
    local cr,cg,cb=HealBot_Action_ClassColour(nil,not secret(class) and class and class:sub(1,4) or nil)
    local role=UnitGroupRolesAssigned(unit)
    if secret(role) or (role~="TANK" and role~="HEALER") then role="DAMAGER" end
    local rr,rg,rb=hbv_Skins_GetRoleCol(role,HealBot_Globals.OverrideColours["USEROLE"])
    local inRange,checked=UnitInRange(unit)
    local outOfRange=row.eventInRange==false
    if not secret(inRange) and not secret(checked) and checked then
        outOfRange=not inRange
    end
    local function SkinColour(category,key,prefix)
        return Colour(Get(category,key),category,prefix,pct,red,green,cr,cg,cb,rr,rg,rb)
    end
    local r,g,b=SkinColour("BarCol","HLTH","H")
    local enabledAlpha=Get("BarCol","HA")
    local barAlpha=outOfRange and Get("BarCol","ORA") or enabledAlpha
    row.baseR,row.baseG,row.baseB,row.barAlpha,row.outOfRange=r,g,b,barAlpha,outOfRange
    row.hasHealthColour=true
    if event~="UNIT_HEALTH" and event~="UNIT_MAXHEALTH" and event~="UNIT_HEAL_PREDICTION" then RefreshWarnings(row,event) end
    ApplyHealthColour(row)
    if HealBot_Forever_SetArrivalIconOpacity then HealBot_Forever_SetArrivalIconOpacity(row,barAlpha,enabledAlpha) end
    local incoming=row.incomingBar
    if incoming then
        local mode=Get("BarIACol","IC")
        if mode>=2 then
            local calculator=row.incomingCalculator
            UnitGetDetailedHealPrediction(unit,"player",calculator)
            incoming:SetMinMaxValues(0,calculator:GetMaximumHealth())
            -- The second result is a clamp flag, not a StatusBar interpolation mode.
            local amount=calculator:GetIncomingHeals()
            incoming:SetValue(amount)
            local ir,ig,ib=Colour(incomingColourModes[mode] or 1,"BarIACol","I",pct,red,green,cr,cg,cb,rr,rg,rb)
            local alpha=Get("BarIACol","IA")
            incoming:SetStatusBarColor(ir,ig,ib,outOfRange and alpha/3 or alpha)
            incoming:Show()
        else
            incoming:Hide()
        end
    end
    r,g,b=SkinColour("BarCol","BACK","B")
    row.background:SetVertexColor(r,g,b,Get("BarCol","BA"))
    local borderMode=Get("BarCol","BORDER")
    r,g,b=Colour(borderMode-1,"BarCol","BOR",pct,red,green,cr,cg,cb,rr,rg,rb)
    row.border:SetBackdropBorderColor(r,g,b,borderMode==1 and 0 or Get("BarCol","BORA"))
    r,g,b=SkinColour("BarTextCol","NAME","NC")
    row.nameText:SetTextColor(r,g,b,Get("BarTextCol",outOfRange and "NCOA" or "NCA"))
    r,g,b=SkinColour("BarTextCol","HLTH","HC")
    row.healthText:SetTextColor(r,g,b,Get("BarTextCol",outOfRange and "HCOA" or "HCA"))

    local name=UnitName(unit)
    local showName=hbv_Skins_GetFrameBoolean("BarText","NAMEONBAR",frame)
    local showHealth=hbv_Skins_GetFrameBoolean("BarText","HLTHONBAR",frame)
    local combined=Get("BarText","HLTHTXTANCHOR")==4
    local healthText=""
    if showHealth then
        local healthType=Get("BarText","HLTHTYPE")
        if healthType==1 and hbv_Skins_GetFrameBoolean("BarText","HLTHINCPTC",frame) then
            healthText=string.format("%d  %d%%",health,percent)
        elseif healthType==1 then
            healthText=string.format("%d",health)
        else
            healthText=string.format("%d%%",percent)
        end
        if hbv_Skins_GetFrameBoolean("BarText","HLTHMAXHIDE",frame) and not secret(health) and not secret(maximum) and health==maximum then
            healthText=""
        end
    end
    if combined and showName and showHealth then
        row.nameText:SetFormattedText("%s  %s",name,healthText)
    else
        row.nameText:SetText(showName and name or "")
    end
    row.healthText:SetText(combined and showName and "" or healthText)
    PaintPower(row)
    if HealBot_Forever_UpdateArrivalAuras then
        HealBot_Forever_UpdateArrivalAuras(row,event~="UNIT_HEALTH" and event~="UNIT_MAXHEALTH" and event~="UNIT_HEAL_PREDICTION")
    end
end

local function SetTextPosition(text,bar,point,x,y)
    text:ClearAllPoints()
    text:SetPoint(point,bar,point,x,y)
    text:SetJustifyH(point)
end

local function ApplySkin()
    local width,height,scale=Get("HealBar","WIDTH"),Get("HealBar","HEIGHT"),Get("Frame","SCALE")
    width,height=math.ceil(width*scale),math.ceil(height*scale)
    local texture=Get("HealBar","TEXTURE")
    for _,row in ipairs(rows) do
        local bar=row.healthBar
        row:SetSize(width,height)
        HealBot_Media_UpdateTexture(bar,texture,"Forever party bar")
        bar:GetStatusBarTexture():SetHorizTile(false)
        row.background:SetTexture(bar:GetStatusBarTexture():GetTexture())
        bar:SetOrientation(Get("HealBar","OFIX")==1 and "HORIZONTAL" or "VERTICAL")
        local incoming=row.incomingBar
        if incoming then
            local vertical=bar:GetOrientation()=="VERTICAL"
            incoming:SetSize(width,height)
            incoming:SetOrientation(bar:GetOrientation())
            incoming:ClearAllPoints()
            incoming:SetPoint(vertical and "BOTTOMLEFT" or "TOPLEFT",
                              bar:GetStatusBarTexture(),vertical and "TOPLEFT" or "TOPRIGHT")
            HealBot_Media_UpdateTexture(incoming,texture,"Forever party incoming heals")
            incoming:GetStatusBarTexture():SetHorizTile(false)
        end
        local borderSize=math.ceil(Get("BarCol","BOUT")*scale)
        if borderSize>0 then
            row.border:SetBackdrop({edgeFile=[[Interface\Buttons\WHITE8X8]],edgeSize=borderSize})
            row.border:Show()
        else
            row.border:Hide()
        end
        local name,health=row.nameText,row.healthText
        HealBot_Media_UpdateFont(name,Get("BarText","FONT"),math.ceil(Get("BarText","HEIGHT")*scale),Get("BarText","OUTLINE"),"Forever party name")
        HealBot_Media_UpdateFont(health,Get("BarText","HFONT"),math.ceil(Get("BarText","HHEIGHT")*scale),Get("BarText","HOUTLINE"),"Forever party health")
        name:SetWidth(math.ceil(width*1.05))
        health:SetWidth(math.ceil(width*1.05))
        local nameAlign=alignments[Get("BarText","ALIGN")] or "CENTER"
        local healthAnchor=Get("BarText","HLTHTXTANCHOR")
        SetTextPosition(name,bar,nameAlign,math.ceil(Get("BarText","OFFSET2")*scale),math.ceil((5+Get("BarText","OFFSET"))*scale))
        if healthAnchor==5 then
            health:ClearAllPoints()
            health:SetPoint("TOP",name,"BOTTOM",math.ceil(Get("BarText","HOFFSET2")*scale),math.ceil((-2+Get("BarText","HOFFSET"))*scale))
            health:SetJustifyH(nameAlign)
        else
            SetTextPosition(health,bar,alignments[healthAnchor] or nameAlign,math.ceil(Get("BarText","HOFFSET2")*scale),math.ceil((-7+Get("BarText","HOFFSET"))*scale))
        end
    end
end

-- Reserve places against the live grid while protected anchors can be changed.
local function AnchorReserve(row,main,x,y)
    if row:GetNumPoints()==1 then
        local point,relative,relativePoint,oldX,oldY=row:GetPoint(1)
        if point=="CENTER" and relative==main and relativePoint=="CENTER" and oldX==x and oldY==y then return end
    end
    row:ClearAllPoints()
    row:SetPoint("CENTER",main,"CENTER",x,y)
end

local expandedPanel
local backdropQueued=false
local function SetBackdropBounds(main,left,top,right,bottom)
    local art=main.hbArrivalBackdrop
    if (art.joinLeft or 0)==left and (art.joinTop or 0)==top and
        (art.joinRight or 0)==right and (art.joinBottom or 0)==bottom then return end
    art.joinLeft,art.joinTop,art.joinRight,art.joinBottom=left,top,right,bottom
    art:ClearAllPoints()
    if left==0 and top==0 and right==0 and bottom==0 then
        art:SetAllPoints(main)
    else
        art:SetPoint("TOPLEFT",main,"TOPLEFT",left,top)
        art:SetPoint("BOTTOMRIGHT",main,"BOTTOMRIGHT",right,bottom)
    end
end

local function UpdateBackdrop()
    backdropQueued=false
    local main=frame and _G["f"..frame.."_HealBot_Action"]
    if expandedPanel and expandedPanel~=main then SetBackdropBounds(expandedPanel,0,0,0,0) end
    expandedPanel=nil
    if not main or not main.hbArrivalBackdrop then return end
    local left,top,right,bottom=0,0,0,0
    for _,row in ipairs(rows) do
        if row.reserve and row.layoutPanel==main and row:IsVisible() then
            left,top=math.min(left,row.joinLeft),math.max(top,row.joinTop)
            right,bottom=math.max(right,row.joinRight),math.min(bottom,row.joinBottom)
        end
    end
    SetBackdropBounds(main,left,top,right,bottom)
    if left<0 or top>0 or right>0 or bottom<0 then expandedPanel=main end
end

local function QueueBackdrop(row)
    if backdropQueued or not (expandedPanel or row and row.layoutPanel) then return end
    backdropQueued=true
    C_Timer.After(0,UpdateBackdrop)
end

local function PositionReservedRows()
    local main=_G["f"..frame.."_HealBot_Action"]
    if not main then return false end
    local mainX,mainY=main:GetCenter()
    if not mainX or not mainY then return false end
    local corner=Get("Anchors","BARS")
    local xDir=corner<3 and 1 or -1
    local yDir=corner%2==1 and -1 or 1
    local horizontal=Get("Anchors","GROW")==1
    local scale=Get("Frame","SCALE")
    local width,height=rows[1]:GetWidth(),rows[1]:GetHeight()
    local columnMargin=math.ceil(Get("HealBar","CMARGIN")*scale)
    local rowMargin=math.ceil(Get("HealBar","RMARGIN")*scale)
    local dx,dy=width+columnMargin,height+rowMargin
    local occupied={}
    local originX,originY
    for _,button in pairs(HealBot_Buttons or {}) do
        if button.frame==frame and button.status.active and button:IsShown() then
            local x,y=button:GetCenter()
            if x and y then
                local back=button.gref and button.gref.Back
                local w,h=button:GetWidth(),button:GetHeight()
                if back then w,h=math.max(w,back:GetWidth()),math.max(h,back:GetHeight()) end
                occupied[#occupied+1]={x=x,y=y,width=w,height=h}
                originX=originX and xDir*math.min(xDir*originX,xDir*x) or x
                originY=originY and yDir*math.min(yDir*originY,yDir*y) or y
                dx=math.max(dx,w+columnMargin)
                dy=math.max(dy,h+rowMargin)
            end
        end
    end
    local padding=5+Get("Frame","PADDING")
    originX=originX or mainX+xDir*(padding+width/2-main:GetWidth()/2)
    originY=originY or mainY+yDir*(padding+height/2-main:GetHeight()/2)
    local groupSize=rosterMode=="raid" and 40 or 5
    local columns=math.max(1,Get("HealBar","NUMCOLS"))
    local laneSize=math.ceil(groupSize/columns)
    local usedAcross,usedAlong=0,0
    for _,slot in ipairs(occupied) do
        local column=math.floor(math.abs(slot.x-originX)/dx+0.5)
        local line=math.floor(math.abs(slot.y-originY)/dy+0.5)
        usedAcross=math.max(usedAcross,(horizontal and line or column)+1)
        usedAlong=math.max(usedAlong,(horizontal and column or line)+1)
    end
    if usedAcross>1 then laneSize=usedAlong end
    laneSize=math.max(1,laneSize,usedAlong)
    local nextSlot=0
    local ratio,w,h,halfWidth,halfHeight
    if main.hbArrivalBackdrop then
        ratio=rows[1]:GetEffectiveScale()/main:GetEffectiveScale()
        w,h=(dx-columnMargin)*ratio/2+padding,(dy-rowMargin)*ratio/2+padding
        halfWidth,halfHeight=main:GetWidth()/2,main:GetHeight()/2
    end
    for _,row in ipairs(rows) do
        if not UnitExists(row.unit) then
            local x,y,free
            repeat
                local along=nextSlot%laneSize
                local across=math.floor(nextSlot/laneSize)
                x=originX+xDir*(horizontal and along or across)*dx
                y=originY+yDir*(horizontal and across or along)*dy
                nextSlot=nextSlot+1
                free=true
                for _,slot in ipairs(occupied) do
                    if math.abs(slot.x-x)<(slot.width+width)/2-0.5 and
                        math.abs(slot.y-y)<(slot.height+height)/2-0.5 then
                        free=false
                        break
                    end
                end
            until free
            AnchorReserve(row,main,x-mainX,y-mainY)
            if ratio then
                -- Anchors and dimensions below are prepared before lockdown.
                -- Store offsets in the visual panel's coordinate system.
                local cx,cy=(x-mainX)*ratio,(y-mainY)*ratio
                row.joinLeft,row.joinRight=cx-w+halfWidth,cx+w-halfWidth
                row.joinBottom,row.joinTop=cy-h+halfHeight,cy+h-halfHeight
                row.layoutPanel=main
            end
        end
    end
    return true
end

local function CreateRow(mode,index)
    local row=CreateFrame("Button","HealBotForeverJoin"..mode..index,panel,"SecureUnitButtonTemplate")
    row.unit=mode..index
    row.guid=""
    row:SetAttribute("unit",row.unit)
    row:SetAttribute("checkselfcast",false)
    row:SetAttribute("checkfocuscast",false)
    row:SetAttribute("checkmouseovercast",false)
    row:SetAttribute("toggleForVehicle",true)
    row:Hide()

    local bar=CreateFrame("StatusBar",nil,row)
    bar:SetAllPoints()
    bar:EnableMouse(false)
    row.healthBar=bar
    if CreateUnitHealPredictionCalculator and UnitGetDetailedHealPrediction then
        local calculator=CreateUnitHealPredictionCalculator()
        calculator:SetIncomingHealClampMode(Enum.UnitIncomingHealClampMode.MissingHealth)
        calculator:SetIncomingHealOverflowPercent(1)
        row.incomingCalculator=calculator
        row.incomingBar=CreateFrame("StatusBar",nil,row)
        row.incomingBar:EnableMouse(false)
        row.incomingBar:SetFrameLevel(bar:GetFrameLevel())
        row.incomingBar:Hide()
        row:RegisterUnitEvent("UNIT_HEAL_PREDICTION",row.unit)
    end
    row.background=bar:CreateTexture(nil,"BACKGROUND")
    row.background:SetAllPoints()
    row.border=CreateFrame("Frame",nil,bar,"BackdropTemplate")
    row.border:EnableMouse(false)
    row.border:SetAllPoints()
    row.nameText=bar:CreateFontString(nil,"OVERLAY")
    row.healthText=bar:CreateFontString(nil,"OVERLAY")
    row:HookScript("OnShow",function(self) Paint(self); QueueBackdrop(self) end)
    row:HookScript("OnHide",function(self) ResetWarnings(self); QueueBackdrop(self) end)
    for _,event in ipairs({"UNIT_HEALTH","UNIT_MAXHEALTH","UNIT_NAME_UPDATE","UNIT_IN_RANGE_UPDATE","UNIT_POWER_UPDATE","UNIT_MAXPOWER","UNIT_DISPLAYPOWER","UNIT_AURA","UNIT_CONNECTION","UNIT_FLAGS"}) do
        row:RegisterUnitEvent(event,row.unit)
    end
    row:SetScript("OnEvent",function(self,event,_,inRange)
        if event=="UNIT_IN_RANGE_UPDATE" and not secret(inRange) then self.eventInRange=inRange end
        if self:IsVisible() then Paint(self,event,inRange) end
    end)
    return row
end

local function BindRow(row)
    row.attribs={Enabled={}}
    HealBot_Action_ButtonRegisterForClicks(row)
    for index,mouseButton in ipairs(mouseButtons) do
        row:SetAttribute("*unit-heal"..index,row.unit)
        for _,modifier in ipairs(HealBot_Action_retComboKeysList()) do
            HealBot_Action_SetButtonAttrib(row,mouseButton,modifier,"Enabled",index,row.unit)
        end
    end
    row.bindingGeneration=bindingGeneration
end

local function FindSkinDonor()
    local groupToken="^"..rosterMode.."%d+$"
    local fallback,fx,fy,liveFallback
    for _,button in pairs(HealBot_Buttons or {}) do
        if button.frame==frame and button.status.active and button:IsShown() and button.gref and button.gref.Bar then
            local x,y=button.gref.Bar:GetCenter()
            if x and y then
                local unit=button.unit
                local exists=unit and UnitExists(unit)
                if exists and (unit=="player" or unit:match(groupToken)) then return button,x,y end
                if not fallback or (exists and not liveFallback) then
                    fallback,fx,fy,liveFallback=button,x,y,exists
                end
            end
        end
    end
    return fallback,fx,fy
end

local previousPowerStyles={}
local powerStyleFields={"x","y","width","height","texture","orientation","reverse","r","g","b","alpha",
    "alignment","textX","textY","font","fontHeight","outline","tr","tg","tb","ta"}

local function SamePowerStyle(previous,style)
    if not previous then return false end
    for _,field in ipairs(powerStyleFields) do
        local a,b=previous[field],style[field]
        if secret(a) or secret(b) or a~=b then return false end
    end
    return true
end

-- A roster pass copies one donor to many empty slots. Share the actual
-- rendered values, so a new donor or media change is picked up on the next pass.
local function PowerStyles(donor,cx,cy)
    local styles={}
    for id=1,9 do
        if hbv_Aux_GetBarVar("USE",frame,id)==4 then
            local source=donor.gref.aux[id]
            local text=donor.gref.auxtxt[id]
            local texture=source and source:GetStatusBarTexture()
            local x,y
            if texture then x,y=source:GetCenter() end
            if x and y and text then
                local scale=Get("Frame","SCALE")
                local style={x=x-cx,y=y-cy,width=source:GetWidth(),height=source:GetHeight(),
                    texture=texture:GetTexture(),orientation=source:GetOrientation(),reverse=source:GetReverseFill(),
                    alignment=alignments[hbv_Aux_GetBarTextVar("ALIGN",frame,id)] or "CENTER",
                    textX=math.ceil(hbv_Aux_GetBarTextVar("HOFFSET",frame,id)*scale),
                    textY=math.ceil(hbv_Aux_GetBarTextVar("OFFSET",frame,id)*scale)}
                style.r,style.g,style.b,style.alpha=source:GetStatusBarColor()
                style.tr,style.tg,style.tb,style.ta=text:GetTextColor()
                style.font,style.fontHeight,style.outline=HealBot_Media_ResolveFont(hbv_Aux_GetBarTextVar("FONT",frame,id),
                    math.ceil(hbv_Aux_GetBarTextVar("HEIGHT",frame,id)*scale),hbv_Aux_GetBarTextVar("OUTLINE",frame,id))
                styles[id]=SamePowerStyle(previousPowerStyles[id],style) and previousPowerStyles[id] or style
            end
        end
    end
    previousPowerStyles=styles
    return styles
end

local function SkinExtras(row, donor, context, cx, cy)
    row.frame=frame
    row.skinPower=row.skinPower or {}
    if not context.powerStyles then context.powerStyles=PowerStyles(donor,cx,cy) end
    local styles=context.powerStyles
    for id,entry in pairs(row.skinPower) do
        if not styles[id] and entry.shown then
            entry.bar:Hide()
            entry.shown,entry.style=false,nil
        end
    end
    for id,style in pairs(styles) do
        local entry=row.skinPower[id]
        if not entry then
            local bar=CreateFrame("StatusBar",nil,row)
            bar:EnableMouse(false)
            entry={bar=bar,text=bar:CreateFontString(nil,"OVERLAY")}
            row.skinPower[id]=entry
        end
        if entry.style~=style or entry.anchor~=row.healthBar then
            local bar,text=entry.bar,entry.text
            entry.style=nil
            bar:ClearAllPoints()
            bar:SetPoint("CENTER",row.healthBar,"CENTER",style.x,style.y)
            bar:SetSize(style.width,style.height)
            bar:SetStatusBarTexture(style.texture)
            bar:SetOrientation(style.orientation)
            bar:SetReverseFill(style.reverse)
            bar:SetStatusBarColor(style.r,style.g,style.b,style.alpha)
            entry.alpha=style.alpha
            text:ClearAllPoints()
            text:SetPoint(style.alignment,bar,style.alignment,style.textX,style.textY)
            text:SetJustifyH(style.alignment)
            text:SetWidth(style.width)
            local fontApplied=text:SetFont(style.font,style.fontHeight,style.outline)
            text:SetTextColor(style.tr,style.tg,style.tb,style.ta)
            if not entry.shown then bar:Show(); entry.shown=true end
            if fontApplied then entry.style,entry.anchor=style,row.healthBar end
        end
    end
end

-- Secure watches, click bindings and base artwork are ready in Sync. Native
-- aura templates for empty slots are substantially more expensive. Prepare one
-- member per rendered frame, starting with the next available roster slot.
local auraWorker
local auraRoster,auraDonor,auraContext
local auraIndex,auraRemaining=1,0

local function StopAuraPreparation()
    auraDonor,auraContext=nil,nil
    auraRemaining=0
    if auraWorker then auraWorker:SetScript("OnUpdate",nil) end
end

local function PrepareNextReserve()
    if InCombatLockdown() or HealBot_Globals.ForeverPartyJoin==false then
        StopAuraPreparation()
        return
    end
    if skinDirty then return end
    if not auraDonor.status.active or not auraDonor:IsShown() or auraDonor.frame~=frame then
        auraDonor=FindSkinDonor()
        auraContext=nil
        if not auraDonor then StopAuraPreparation(); return end
    end
    while auraRemaining>0 do
        local row=rows[auraIndex]
        auraIndex=auraIndex%#rows+1
        auraRemaining=auraRemaining-1
        if row.reserve and not UnitExists(row.unit) then
            auraContext=auraContext or HealBot_Forever_PrepareArrivalAuraContext(true)
            HealBot_Forever_SkinArrivalAuras(row,auraDonor,auraContext)
            HealBot_Forever_UpdateArrivalAuras(row)
            break
        end
    end
    if auraRemaining==0 then
        auraIndex=1
        StopAuraPreparation()
    end
end

local function QueueReserveAuras(donor)
    if not donor or not HealBot_Forever_SkinArrivalAuras then
        if auraRemaining>0 then StopAuraPreparation() end
        return
    end
    -- Keep our place through repeated roster changes so later rows get a turn.
    if auraRoster~=rows then auraIndex=1 end
    auraRoster,auraDonor,auraContext=rows,donor,nil
    if auraRemaining==0 then
        auraWorker=auraWorker or CreateFrame("Frame")
        auraWorker:SetScript("OnUpdate",PrepareNextReserve)
    end
    auraRemaining=#rows
end

function HealBot_Forever_UpdateQueuedArrivalFilters(filters)
    if auraContext then auraContext.filters=filters end
end

local function Sync()
    if InCombatLockdown() then return end
    -- Login callbacks can run before core media and skin initialization finish.
    if not HealBot_Globals or not HealBot_retLuVars("Loaded") or
       not HealBot_Media_retLuVars("Registered") or not Healbot_Config_Skins or
       not Healbot_Config_Skins.HealGroups or
       not Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin] then
        return false
    end
    local enabled=HealBot_Globals.ForeverPartyJoin~=false
    if enabled then
        local inRaid=IsInRaid()
        local mode=inRaid and "raid" or "party"
        local groupFrame=GroupFrame(inRaid)
        local currentSkin=Healbot_Config_Skins.Current_Skin
        if rosterMode~=mode then
            for _,row in ipairs(rows) do
                if row.reserve then UnregisterUnitWatch(row); row.reserve=false end
                row:Hide()
            end
            if panel then UnregisterStateDriver(panel,"visibility"); panel:Hide() end
            rosterMode=mode
            rows={}
            panel=_G["HealBotForeverJoinPanel"..mode]
            if not panel then
                panel=CreateFrame("Frame","HealBotForeverJoinPanel"..mode,UIParent,"SecureHandlerStateTemplate")
                panel:SetSize(1,1)
                panel:SetPoint("CENTER",UIParent,"CENTER")
                panel:SetFrameStrata("DIALOG")
            end
            RegisterStateDriver(panel,"visibility",inRaid and "[combat,group:raid] show; hide" or "[combat,nogroup:raid] show; hide")
            for index=1,(inRaid and 40 or 4) do
                rows[index]=_G["HealBotForeverJoin"..mode..index] or CreateRow(mode,index)
            end
            skinDirty=true
        end
        if frame~=groupFrame or frameSkin~=currentSkin then skinDirty=true end
        frame,frameSkin=groupFrame,currentSkin
        if skinDirty then
            ApplySkin()
            skinDirty=false
        end
        enabled=PositionReservedRows()
    end
    local donor,donorX,donorY,checkedDonor
    bindingError=nil
    local extraContext={}
    for _,row in ipairs(rows) do
        local reserve=enabled and not UnitExists(row.unit)
        if reserve and not checkedDonor then
            donor,donorX,donorY=FindSkinDonor()
            checkedDonor=true
        end
        if reserve and donor then
            SkinExtras(row,donor,extraContext,donorX,donorY)
        end
        if reserve and row.bindingGeneration~=bindingGeneration then
            local ok,err=pcall(BindRow,row)
            if not ok then
                bindingError=tostring(err)
                reserve=false
            end
        end
        if reserve and not row.reserve then
            RegisterUnitWatch(row)
            row.reserve=true
        elseif not reserve and row.reserve then
            UnregisterUnitWatch(row)
            row.reserve=false
            row:Hide()
        end
    end
    QueueReserveAuras(donor)
end

local function QueueSync()
    if refreshQueued then return end
    refreshQueued=true
    local function TrySync()
        refreshQueued=false
        if Sync()==false then
            -- Keep one startup retry; combat resumes via PLAYER_REGEN_ENABLED.
            refreshQueued=true
            C_Timer.After(0.5,TrySync)
        end
    end
    C_Timer.After(0,TrySync)
end

function HealBot_Forever_QueueReserveAuraRefresh()
    QueueSync()
end

local events=CreateFrame("Frame")
for _,event in ipairs({"PLAYER_LOGIN","PLAYER_REGEN_ENABLED","GROUP_ROSTER_UPDATE",
    "PLAYER_ENTERING_WORLD","ADDON_RESTRICTION_STATE_CHANGED","PLAYER_SPECIALIZATION_CHANGED"}) do
    events:RegisterEvent(event)
end
events:SetScript("OnEvent",function(_,event)
    if event=="PLAYER_LOGIN" and HealBot_Options_ForeverPartyJoin then
        local checkbox=HealBot_Options_ForeverPartyJoin
        HealBot_Options_SetText(checkbox,"Show new party and raid members during combat")
        local labelWidth=checkbox.Text:GetStringWidth()
        checkbox:SetPoint("TOP",checkbox:GetParent(),"TOP",-labelWidth/2,-267)
        checkbox:SetChecked(HealBot_Globals.ForeverPartyJoin~=false)
        checkbox:Show()
    end
    if event=="PLAYER_SPECIALIZATION_CHANGED" then bindingGeneration=bindingGeneration+1 end
    if InCombatLockdown() then
        if event=="GROUP_ROSTER_UPDATE" or event=="PLAYER_ENTERING_WORLD" or event=="ADDON_RESTRICTION_STATE_CHANGED" then
            for _,row in ipairs(rows) do if row:IsVisible() then Paint(row,event) end end
        end
    else
        QueueSync()
    end
end)

hooksecurefunc("HealBot_Update_SetEnabledAttribs",function()
    bindingGeneration=bindingGeneration+1
    QueueSync()
end)

local function QueueSkinSync()
    skinDirty=true
    QueueSync()
end

-- Buff watch/rank changes update prepared native groups in place. Only skin
-- and layout changes need to restyle the reserve panel.
hooksecurefunc("HealBot_Options_framesChanged",QueueSkinSync)
hooksecurefunc("HealBot_Options_SetSkins",QueueSkinSync)
hooksecurefunc("hbv_Skins_SetIconVar",function(_,key)
    if key=="MAXBICONS" or key=="MAXDICONS" or key=="BICONSPACER" or key=="DICONSPACER"
        or key=="BSCALE" or key=="DSCALE" or key=="BZOOM" or key=="DZOOM" then QueueSkinSync() end
end)
hooksecurefunc("hbv_Skins_SetIconTextVar",QueueSkinSync)
hooksecurefunc("HealBot_Panel_SetupBars",QueueSync)
hooksecurefunc("HealBot_Aura_SetAuraCheckFlags",function()
    for _,row in ipairs(rows) do
        if HealBot_Forever_UpdateArrivalAuras then HealBot_Forever_UpdateArrivalAuras(row) end
        if row:IsVisible() then RefreshWarnings(row) end
    end
end)
local function RefreshReserveDebuffs()
    if InCombatLockdown() then
        if HealBot_Forever_RefreshArrivalDebuffPolicy then HealBot_Forever_RefreshArrivalDebuffPolicy() end
        for _,row in ipairs(rows) do if row:IsVisible() then RefreshWarnings(row) end end
    else
        QueueSync()
    end
end
for _,name in ipairs({"HealBot_Forever_RefreshDebuffIconPreferences","HealBot_Forever_SetWeakenedSoulNativeEnabled",
    "HealBot_Aura_ConfigDebuffs","HealBot_Options_Debuff_Reset"}) do
    if type(_G[name])=="function" then hooksecurefunc(name,RefreshReserveDebuffs) end
end

function HealBot_Forever_SetPartyJoinEnabled(enabled)
    HealBot_Globals.ForeverPartyJoin=enabled
    if HealBot_Options_ForeverPartyJoin then
        HealBot_Options_ForeverPartyJoin:SetChecked(enabled)
    end
    QueueSync()
    print("HealBot combat party arrivals "..(enabled and "on" or "off")..(InCombatLockdown() and " (after combat)." or "."))
end

function HealBot_Forever_VisitPartyPerfScopes(visit)
    Sync=visit("PartyJoin.Sync",Sync)
    PrepareNextReserve=visit("PartyJoin.PrepareReserve",PrepareNextReserve)
    if auraRemaining>0 then auraWorker:SetScript("OnUpdate",PrepareNextReserve) end
end

function HealBot_Forever_VisitReserveBars(visit)
    for _,row in ipairs(rows) do
        if row.reserve then visit(row) end
    end
end

SLASH_HBFOREVERPARTYJOIN1="/hbpartyjoin"
SlashCmdList.HBFOREVERPARTYJOIN=function(msg)
    if msg=="on" or msg=="off" then
        HealBot_Forever_SetPartyJoinEnabled(msg=="on")
    elseif msg=="status" then
        local status={}
        for _,row in ipairs(rows) do
            local state=row:IsVisible() and "visible" or (row.reserve and "armed" or "inactive")
            status[#status+1]=row.unit.."="..state..(UnitExists(row.unit) and "/present" or "/empty")
        end
        print("HealBot combat party arrivals: "..(#status>0 and table.concat(status,", ") or "panel not initialized"))
        if bindingError then print("HealBot party binding error: "..bindingError) end
    else
        print("HealBot combat party arrivals: "..(HealBot_Globals.ForeverPartyJoin==false and "off" or "on")..". /hbpartyjoin on | off | status")
    end
end
