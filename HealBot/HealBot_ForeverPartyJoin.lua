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
    if not row.skinPower then return end
    local power,maximum,percent=HealBot_WoWAPI_UnitMana(row.unit,UnitPowerType(row.unit))
    local powerType,token=UnitPowerType(row.unit)
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

local function Paint(row)
    local unit=row.unit
    if not frame or not UnitExists(unit) then return end
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
    row.healthBar:SetStatusBarColor(r,g,b,Get("BarCol",outOfRange and "ORA" or "HA"))
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
    if HealBot_Forever_UpdateArrivalAuras then HealBot_Forever_UpdateArrivalAuras(row) end
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
    local dx=width+math.ceil(Get("HealBar","CMARGIN")*scale)
    local dy=height+math.ceil(Get("HealBar","RMARGIN")*scale)
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
                dx=math.max(dx,w+math.ceil(Get("HealBar","CMARGIN")*scale))
                dy=math.max(dy,h+math.ceil(Get("HealBar","RMARGIN")*scale))
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
            row:ClearAllPoints()
            row:SetPoint("CENTER",main,"CENTER",x-mainX,y-mainY)
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
    row.background=bar:CreateTexture(nil,"BACKGROUND")
    row.background:SetAllPoints()
    row.border=CreateFrame("Frame",nil,bar,"BackdropTemplate")
    row.border:EnableMouse(false)
    row.border:SetAllPoints()
    row.nameText=bar:CreateFontString(nil,"OVERLAY")
    row.healthText=bar:CreateFontString(nil,"OVERLAY")
    row:HookScript("OnShow",Paint)
    for _,event in ipairs({"UNIT_HEALTH","UNIT_MAXHEALTH","UNIT_NAME_UPDATE","UNIT_IN_RANGE_UPDATE","UNIT_POWER_UPDATE","UNIT_MAXPOWER","UNIT_DISPLAYPOWER","UNIT_AURA","UNIT_CONNECTION"}) do
        row:RegisterUnitEvent(event,row.unit)
    end
    row:SetScript("OnEvent",function(self,event,_,inRange)
        if event=="UNIT_IN_RANGE_UPDATE" and not secret(inRange) then self.eventInRange=inRange end
        if self:IsVisible() then Paint(self) end
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

local function SkinExtras(row, donor)
    row.frame=frame
    row.skinPower=row.skinPower or {}
    for _,entry in pairs(row.skinPower) do entry.bar:Hide() end
    local cx,cy=donor.gref.Bar:GetCenter()
    if not cx or not cy then return end
    for id=1,9 do
        if hbv_Aux_GetBarVar("USE",frame,id)==4 then
            local source=donor.gref.aux[id]
            local x,y=source:GetCenter()
            if x and y then
                local entry=row.skinPower[id]
                if not entry then
                    local bar=CreateFrame("StatusBar",nil,row)
                    bar:EnableMouse(false)
                    entry={bar=bar,text=bar:CreateFontString(nil,"OVERLAY")}
                    row.skinPower[id]=entry
                end
                local bar,text=entry.bar,entry.text
                bar:ClearAllPoints()
                bar:SetPoint("CENTER",row.healthBar,"CENTER",x-cx,y-cy)
                bar:SetSize(source:GetWidth(),source:GetHeight())
                bar:SetStatusBarTexture(source:GetStatusBarTexture():GetTexture())
                bar:SetOrientation(source:GetOrientation())
                bar:SetReverseFill(source:GetReverseFill())
                local r,g,b,alpha=source:GetStatusBarColor()
                bar:SetStatusBarColor(r,g,b,alpha)
                entry.alpha=alpha
                text:ClearAllPoints()
                local alignment=alignments[hbv_Aux_GetBarTextVar("ALIGN",frame,id)] or "CENTER"
                local scale=Get("Frame","SCALE")
                text:SetPoint(alignment,bar,alignment,math.ceil(hbv_Aux_GetBarTextVar("HOFFSET",frame,id)*scale),math.ceil(hbv_Aux_GetBarTextVar("OFFSET",frame,id)*scale))
                text:SetJustifyH(alignment)
                text:SetWidth(bar:GetWidth())
                HealBot_Media_UpdateFont(text,hbv_Aux_GetBarTextVar("FONT",frame,id),math.ceil(hbv_Aux_GetBarTextVar("HEIGHT",frame,id)*scale),hbv_Aux_GetBarTextVar("OUTLINE",frame,id),"Arrival power text")
                local original=donor.gref.auxtxt[id]
                text:SetTextColor(original:GetTextColor())
                bar:Show()
            end
        end
    end
    if HealBot_Forever_SkinArrivalAuras then HealBot_Forever_SkinArrivalAuras(row,donor) end
end

local function Sync()
    if InCombatLockdown() or not HealBot_Globals then return end
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
    local donor
    for _,button in pairs(HealBot_Buttons or {}) do
        if button.frame==frame and button.status.active and button:IsShown() and button.gref then
            donor=button
            break
        end
    end
    bindingError=nil
    for _,row in ipairs(rows) do
        local reserve=enabled and not UnitExists(row.unit)
        if reserve and donor then SkinExtras(row,donor) end
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
end

local function QueueSync()
    if refreshQueued then return end
    refreshQueued=true
    C_Timer.After(0,function()
        refreshQueued=false
        Sync()
    end)
end

local events=CreateFrame("Frame")
for _,event in ipairs({"PLAYER_LOGIN","PLAYER_REGEN_ENABLED","GROUP_ROSTER_UPDATE",
    "PLAYER_ENTERING_WORLD","PLAYER_SPECIALIZATION_CHANGED"}) do
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
        if event=="GROUP_ROSTER_UPDATE" then
            for _,row in ipairs(rows) do if row:IsVisible() then Paint(row) end end
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

hooksecurefunc("HealBot_Options_framesChanged",QueueSkinSync)
hooksecurefunc("HealBot_Options_SetSkins",QueueSkinSync)
hooksecurefunc("HealBot_Panel_SetupBars",QueueSync)
hooksecurefunc("HealBot_Aura_SetAuraCheckFlags",function()
    for _,row in ipairs(rows) do
        if HealBot_Forever_UpdateArrivalAuras then HealBot_Forever_UpdateArrivalAuras(row) end
    end
end)
hooksecurefunc("HealBot_Forever_RefreshBuffExclusions",QueueSkinSync)

function HealBot_Forever_SetPartyJoinEnabled(enabled)
    HealBot_Globals.ForeverPartyJoin=enabled
    if HealBot_Options_ForeverPartyJoin then
        HealBot_Options_ForeverPartyJoin:SetChecked(enabled)
    end
    QueueSync()
    print("HealBot combat party arrivals "..(enabled and "on" or "off")..(InCombatLockdown() and " (after combat)." or "."))
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
