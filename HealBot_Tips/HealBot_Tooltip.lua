local linenum=1
local HealBot_CheckBuffs = {}
local xUnit=nil
local xGUID=nil
local xButton=nil
local hbGameTooltip = CreateFrame("GameTooltip", "hbGameTooltip", nil, "GameTooltipTemplate")
local _
local hbCommands = { [strlower(HEALBOT_DISABLED_TARGET)]=true,
                     [strlower(HEALBOT_ASSIST)]=true, 
                     [strlower(HEALBOT_FOCUS)]=true,
                     [strlower(HEALBOT_MENU)]=true,
                     [strlower(HEALBOT_HBMENU)]=true,
                     [strlower(HEALBOT_STOP)]=true,
                     [strlower(HEALBOT_TELL)]=true,
                    }  
local HealBot_Tooltip_luVars={}
HealBot_Tooltip_luVars["uGroup"]=false
HealBot_Tooltip_luVars["doInit"]=true

function HealBot_Tooltip_setLuVars(vName, vValue)
    HealBot_Tooltip_luVars[vName]=vValue
      --HealBot_setCall("HealBot_Tooltip_setLuVars")
end

function HealBot_Tooltip_Clear_CheckBuffs()
    for x,_ in pairs(HealBot_CheckBuffs) do
        HealBot_CheckBuffs[x]=nil;
    end
end

function HealBot_Tooltip_CheckBuffs(buff)
    HealBot_CheckBuffs[buff]=true;
end

function HealBot_Tooltip_ReturnMinsSecs(s)
    local mins=floor(s/60)
    local secs=floor(s-(mins*60))
  --  mins=mins+1
    if secs<10 then secs="0"..secs end
    return mins,secs
end

function HealBot_Tooltip_readNumber(n)
    if n>99999999 then
        n=tostring(HealBot_Comm_round(n/1000000,0)).."M"
    elseif n>9999999 then
        n=tostring(HealBot_Comm_round(n/1000000,1)).."M"
    elseif n>999999 then
        n=tostring(HealBot_Comm_round(n/1000000,2)).."M"
    elseif n>99999 then
        n=tostring(HealBot_Comm_round(n/1000,0)).."K"
    elseif n>9999 then
        n=tostring(HealBot_Comm_round(n/1000,1)).."K"
    else
        n=tostring(n)
    end
    return n
end

function HealBot_Tooltip_SpellPattern(button, click)
    local sPattern=nil
    if IsShiftKeyDown() and IsAltKeyDown() and IsControlKeyDown() then
        if click=="Left" then
            sPattern=HEALBOT_WOWMENU
        elseif click=="Right" then
            sPattern=HEALBOT_HBMENU
            --HealBot_Panel_ToggelHealTarget(self.unit)
        elseif click=="Middle" then
            sPattern=HEALBOT_TOGGLE_ENABLED
        end
    else    
        local x = click;
        if IsShiftKeyDown() then 
            if IsAltKeyDown() then 
                x = "Alt-Shift"..x
            elseif IsControlKeyDown() then 
                x = "Ctrl-Shift"..x
            else
                x = "Shift"..x
            end
        elseif IsAltKeyDown() then 
            if IsControlKeyDown() then 
                 x = "Alt-Ctrl"..x
            else
                x = "Alt"..x
            end
        elseif IsControlKeyDown() then 
            x = "Ctrl"..x 
        end
        x=x..HealBot_Config.CurrentSpec
        sPattern=HealBot_Action_GetSpell(string.upper(HealBot_Data["TIPTYPE"]), x)
    end
    return sPattern
end

function HealBot_Tooltip_GetHealSpell(button,sName)
    if not sName or not HealBot_Spell_Names[sName] then
        if sName then
            local s = GetItemSpell(sName)
            if not s then
                return nil, 1,0.5
            else
                if HealBot_Data["PGUID"]~=button.guid then
                    if IsItemInRange(sName,button.unit) then
                        return sName, 0, 1
                    else
                        return sName, 1,0.5
                    end
                else
                    return sName, 0, 1
                end
            end
        else
            return nil, 1,0.5
        end
    end

    if not UnitIsUnit("player",button.unit) and HealBot_UnitInRange(button.unit, sName, false)<1 then
        return sName, 1,0.5
    end
 
    return sName, 0, 1
end

function HealBot_Tooltip_setspellName(button, spellName)
    local validSpellName=spellName
    local spellAR,spellAG=1,1
    if spellName then
        spellAR,spellAG=0,1
        if not hbCommands[strlower(spellName)] then
            local mIdx=GetMacroIndexByName(spellName)
            if mIdx==0 then 
                validSpellName, spellAR, spellAG = HealBot_Tooltip_GetHealSpell(button,spellName) 
                if validSpellName then
                    local gcdSTART, gcdDUR = GetSpellCooldown(61304) -- GCD
                    local z, x, _ = GetSpellCooldown(spellName);
                    if x and x>1 and (not HealBot_Globals.Tooltip_IgnoreGCD or x > gcdDUR) then 
                        z = HealBot_Comm_round(x-(GetTime()-z),3)
                        local u=HEALBOT_TOOLTIP_SECS
                        if HealBot_Globals.Tooltip_ShowCD then
                            z = HealBot_Comm_round(z,1)
                            if z>=10 then
                                if z>59 then
                                    z = ceil(z/60)
                                    u=HEALBOT_TOOLTIP_MINS
                                else
                                    z = HealBot_Comm_round(z,0)
                                end
                            elseif ceil(z)==z then
                                u=".0"..u
                            end                            
                            validSpellName=validSpellName..HEALBOT_TOOLTIP_CD..z..u 
                            if z>0 then spellAR,spellAG=1,0.5 end
                        elseif z>0.101 then
                            spellAR,spellAG=1,0.5
                        end
                    end
                end
            else
                if validSpellName and GetMacroIndexByName(validSpellName)>0 then
                    local _,_,mText=GetMacroInfo(GetMacroIndexByName(validSpellName))
                    local _,s=string.find(mText, "#showtooltip ")
                    if s and s>0 then
                        local e,_=string.find(mText, "\n")
                        if e and e>0 then
                             validSpellName=(string.sub(mText, s+1, e-1)) or validSpellName
                        end
                    end
                end
                spellAR,spellAG=0.5,1
            end
        end
    end
    return validSpellName, spellAR, spellAG
end

function HealBot_Tooltip_SetLineLeft(Text,R,G,B,lNo,a)
    if lNo>40 then return end
    local txtL = _G["HealBot_TooltipTextL" .. lNo]
    hbGameTooltip:AddFontStrings(
        hbGameTooltip:CreateFontString( "$parentTextLeft" .. lNo, nil, "GameTooltipText" ),
        hbGameTooltip:CreateFontString( "$parentTextRight" .. lNo, nil, "GameTooltipText" ) );
    txtL:SetTextColor(R,G,B,a)
    txtL:SetText(Text)
    txtL:Show()
end

function HealBot_Tooltip_SetLineRight(Text,R,G,B,lNo,a)
    if lNo>40 then return end
    local txtR = _G["HealBot_TooltipTextR" .. lNo]
    txtR:SetTextColor(R,G,B,a)
    txtR:SetText(Text)
    txtR:Show()
end

function HealBot_Tooltip_InitFont()
    local fontType=GameFontNormal
    if HealBot_Globals.Tooltip_TextSize==1 then
        fontType=GameFontNormalSmall
    elseif HealBot_Globals.Tooltip_TextSize==3 then
        fontType=GameFontNormalLarge
    end
    for x=1,44 do
        local txtR = _G["HealBot_TooltipTextR" .. x]
        txtR:SetFontObject(fontType)
        local txtL = _G["HealBot_TooltipTextL" .. x]
        txtL:SetFontObject(fontType)
    end
end

function HealBot_Tooltip_SetLine(lNo,lText,lR,lG,lB,la,rText,rR,rG,rB,ra)
    if rText then
        if HealBot_Globals.UseGameTooltip then
            GameTooltip:AddDoubleLine(lText,rText,lR,lG,lB,rR,rG,rB)
        else
            HealBot_Tooltip_SetLineLeft(lText,lR,lG,lB,lNo,la)
            HealBot_Tooltip_SetLineRight(rText,rR,rG,rB,lNo,ra)
        end
    else
        if HealBot_Globals.UseGameTooltip then
            GameTooltip:AddLine(lText,lR,lG,lB)
        else
            HealBot_Tooltip_SetLineLeft(lText,lR,lG,lB,lNo,la)
        end
    end
end

local HealBot_Tooltip_Power = 9
local HealBot_Tooltip_PowerDesc = {[0]="Mana", 
                                   [1]="Rage", 
                                   [2]="Focus", 
                                   [3]="Energy", 
                                   [4]="Happiness", 
                                   [5]="Runes", 
                                   [6]="Runic Power", 
                                   [7]="Soul Shards", 
                                   [8]="Eclipse", 
                                   [9]="Holy Power"}
function HealBot_Tooltip_SpellInfo(spellName)
    if HealBot_Spell_Names[spellName] then
        if HealBot_Spell_IDs[HealBot_Spell_Names[spellName]].Mana>0 then
            linenum=linenum+1
            if HealBot_Data["POWERTYPE"]==0 and HealBot_Spell_IDs[HealBot_Spell_Names[spellName]].Mana<HealBot_Tooltip_Power then
                HealBot_Tooltip_SetLine(linenum,HEALBOT_WORDS_CAST..": "..HealBot_Spell_IDs[HealBot_Spell_Names[spellName]].CastTime.." "..HEALBOT_WORDS_SEC..".",0.8,0.8,0.8,1,"Power: "..HealBot_Spell_IDs[HealBot_Spell_Names[spellName]].Mana,0.4,0.4,1,1)
            else
                HealBot_Tooltip_SetLine(linenum,HEALBOT_WORDS_CAST..": "..HealBot_Spell_IDs[HealBot_Spell_Names[spellName]].CastTime.." "..HEALBOT_WORDS_SEC..".",0.8,0.8,0.8,1,HealBot_Tooltip_PowerDesc[HealBot_Data["POWERTYPE"]]..": "..HealBot_Spell_IDs[HealBot_Spell_Names[spellName]].Mana,0.4,0.4,1,1)
            end
        end
    end
end

function HealBot_Tooltip_SpellSummary(spellName)
    local ret_val = "  "
    if HealBot_Spell_Names[spellName] then
        if HealBot_Data["POWERTYPE"]==0 and HealBot_Spell_IDs[HealBot_Spell_Names[spellName]].Mana<HealBot_Tooltip_Power then
            ret_val = " -  "..HealBot_Spell_IDs[HealBot_Spell_Names[spellName]].Mana.." Power"
        else
            ret_val = " -  "..HealBot_Spell_IDs[HealBot_Spell_Names[spellName]].Mana.." "..HealBot_Tooltip_PowerDesc[HealBot_Data["POWERTYPE"]]
        end
    end
    if strlen(ret_val)<5 then ret_val = " - "..spellName; end
    return ret_val;
end

function HealBot_Tooltip_Show()
    if HealBot_Globals.UseGameTooltip then
        GameTooltip:Show();
    else
        local height = 20 
        local width = 0
        for x = 1, linenum do
            local txtL = _G["HealBot_TooltipTextL" .. x]
            local txtR = _G["HealBot_TooltipTextR" .. x]
            height = height + txtL:GetHeight() + 2
            if (txtL:GetWidth() + txtR:GetWidth() + 25 > width) then
                width = txtL:GetWidth() + txtR:GetWidth() + 25
            end
        end
        HealBot_Tooltip:SetWidth(width)
        HealBot_Tooltip:SetHeight(height)
        HealBot_Tooltip:SetScale(1.01);
        HealBot_Tooltip:SetScale(1);
        HealBot_Tooltip:Show();
    end
end

local UnitBuffIcons=nil
local UnitDebuffIcons=nil
function HealBot_ToolTip_ShowHoT(buttonId, unit)
    if HealBot_Globals.Tooltip_ShowHoT then
        local hbHoTline1=true
        UnitBuffIcons=HealBot_Aura_ReturnHoTdetails(buttonId)
        if linenum<43 and UnitBuffIcons then
            for i = 1,10 do
                if UnitBuffIcons[i].current and HealBot_Spell_IDs[UnitBuffIcons[i].spellId] then
                    if UnitBuffIcons[i].unitCaster then
                        local ttCaster=UnitName(UnitBuffIcons[i].unitCaster)
                        if ttCaster and linenum<44 then
                            local ttHoTd=nil
                            if hbHoTline1 then
                                hbHoTline1=false
                                linenum=linenum+1
                                HealBot_Tooltip_SetLine(linenum," ",0,0,0,0)
                            end
                            linenum=linenum+1
                            if UnitBuffIcons[i].expirationTime and UnitBuffIcons[i].expirationTime>0 then
                                ttHoTd=floor(UnitBuffIcons[i].expirationTime-GetTime())
                            end
                            local ttHoTc=UnitBuffIcons[i].count or 0
                            local ttHoTright=nil
                            if ttHoTd and ttHoTd>60 then
                                local ttHoTdt=floor(ttHoTd/60)
                                if ttHoTdt>120 then
                                    ttHoTd=nil
                                else
                                    ttHoTd=ttHoTd - (ttHoTdt*60)
                                    if ttHoTd<10 then ttHoTd="0"..ttHoTd end
                                    ttHoTd=ttHoTdt.."m "..ttHoTd
                                end
                            end
                            if ttHoTd then 
                                ttHoTright=" "..HEALBOT_OPTIONS_HOTTEXTDURATION..": "..ttHoTd.."s   " 
                            else
                                ttHoTright=" "
                            end
                            if ttHoTc>0 then 
                                ttHoTright=ttHoTright..HEALBOT_OPTIONS_HOTTEXTCOUNT..": "..ttHoTc.."   " 
                            else
                                ttHoTright=ttHoTright.."   " 
                            end
                            if ttHoTright then 
                                HealBot_Tooltip_SetLine(linenum,"   "..ttCaster.." "..strlower(HEALBOT_WORDS_CAST).." "..HealBot_Spell_IDs[UnitBuffIcons[i].spellId].name.." ",0.4,1,1,1,ttHoTright,0.7,1,0.7,1)
                            else
                                HealBot_Tooltip_SetLine(linenum,"   "..ttCaster.." "..strlower(HEALBOT_WORDS_CAST).." "..HealBot_Spell_IDs[UnitBuffIcons[i].spellId].name.." ",0.4,1,1,1)
                            end
                        end
                    end
                end
            end
        end
    end
end

function HealBot_ToolTip_SetTooltipPos()
    xButton=HealBot_Data["TIPBUTTON"]
    if xButton then
        local g = _G["f"..xButton.frame.."_HealBot_Action"]
        local top = g:GetTop();
        local x, y = GetCursorPosition();
        if HealBot_Globals.UseGameTooltip then
            if Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][xButton.frame]["TIPLOC"]>1 then
                x=x/UIParent:GetScale();
                y=y/UIParent:GetScale();
                if Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][xButton.frame]["TIPLOC"]==2 then
                    GameTooltip:SetOwner(g, "ANCHOR_LEFT", 0, 0-(top-(y-50)))
                elseif Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][xButton.frame]["TIPLOC"]==3 then
                    GameTooltip:SetOwner(g, "ANCHOR_RIGHT", 0, 0-(top-(y-50)))
                elseif Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][xButton.frame]["TIPLOC"]==4 then
                   GameTooltip:SetOwner(g, "ANCHOR_TOP")
                elseif Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][xButton.frame]["TIPLOC"]==5 then
                   GameTooltip:SetOwner(g, "ANCHOR_BOTTOM")
                else
                    GameTooltip:SetOwner(g, "ANCHOR_NONE")
                    GameTooltip:SetPoint("TOPLEFT","WorldFrame","BOTTOMLEFT",x+25,y-20);
                end
            else
                GameTooltip:SetOwner(g, "ANCHOR_NONE")
                GameTooltip_SetDefaultAnchor(GameTooltip, hbGameTooltip)
            end
        else
            HealBot_Tooltip:ClearAllPoints();
            if Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][xButton.frame]["TIPLOC"]>1 then
                x=x/UIParent:GetScale();
                y=y/UIParent:GetScale();
                if Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][xButton.frame]["TIPLOC"]==2 then
                    HealBot_Tooltip:SetPoint("TOPRIGHT",g,"TOPLEFT",0,0-(top-(y+35)));
                elseif Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][xButton.frame]["TIPLOC"]==3 then
                    HealBot_Tooltip:SetPoint("TOPLEFT",g,"TOPRIGHT",0,0-(top-(y+35)));
                elseif Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][xButton.frame]["TIPLOC"]==4 then
                    HealBot_Tooltip:SetPoint("BOTTOM",g,"TOP",0,0);
                elseif Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][xButton.frame]["TIPLOC"]==5 then
                    HealBot_Tooltip:SetPoint("TOP",g,"BOTTOM",0,0);
                else
                    HealBot_Tooltip:SetPoint("TOPLEFT","WorldFrame","BOTTOMLEFT",x+25,y-20);
                end
            else
                HealBot_Tooltip:SetPoint("BOTTOMRIGHT","WorldFrame","BOTTOMRIGHT",-105,105);
            end
        end
    end
end

function HealBot_Tooltip_ClearLines(allLines)
    if HealBot_Globals.UseGameTooltip then
        GameTooltip:ClearLines()
    else
        for x=1,44 do
            local txtR = _G["HealBot_TooltipTextR" .. x]
            txtR:SetText(" ")
            local txtL = _G["HealBot_TooltipTextL" .. x]
            txtL:SetText(" ")
        end
    end
end

function HealBot_Action_GetTimeOffline(button)
    local timeOffline=nil
    if button.status.offline then
        timeOffline = GetTime() - button.status.offline;
        local seconds = math.floor(timeOffline % 60)
        local minutes = math.floor(timeOffline / 60) % 60
        local hours = math.floor(timeOffline / 3600)
        timeOffline = "";
        if hours > 0 then
            if hours == 1 then
                timeOffline = hours.." hour ";
            else
                timeOffline = hours.." hours ";
            end
        end
        if minutes > 0 then
            if minutes == 1 then
                timeOffline = timeOffline..minutes.." min ";
            else
                timeOffline = timeOffline..minutes.." mins ";
            end
        end
        if seconds > 0 then
            if seconds == 1 then
                timeOffline = timeOffline..seconds.." sec";
            else
                timeOffline = timeOffline..seconds.." secs";
            end
        end                        
    end      
    return timeOffline;
end

local msgs={}
local order={}
function HealBot_DebugTooltip()
    HealBot_Tooltip_ClearLines();
    msgs=HealBot_retCalls()
    linenum = 1
    local leftname=false
    local leftcount=0
    local maxcount=0
    for x,_ in pairs(order) do
        order[x]=nil;
    end
    
    for name,count in pairs(msgs) do
        table.insert(order,name)
        if count>maxcount then maxcount=count end
    end
    local filtercount=floor(maxcount/100)
    table.sort(order,function (a,b)
        if msgs[a]>msgs[b] then return true end
        if msgs[a]<msgs[b] then return false end
        return a>b
    end)
    for j=1,#order do
        if linenum<45 and msgs[order[j]]>filtercount then
            if leftname and order[j] then
                linenum = linenum + 1
                HealBot_Tooltip_SetLine(linenum,leftname.." count="..leftcount,1,1,1,1,order[j].." = "..msgs[order[j]],1,1,1,1)    
                leftname=false
            else
                leftname=order[j]
                leftcount=msgs[order[j]]
            end      
        end
    end

    HealBot_Tooltip_Show()
end

function HealBot_Action_DoRefreshTooltip()
    --if IsAltKeyDown() and HealBot_retCalls() then 
    --    HealBot_DebugTooltip() 
    --    return
    --end
    if HealBot_Data["TIPTYPE"]=="NONE" then return end
    if HealBot_Globals.ShowTooltip==false then return end
    if HealBot_Globals.DisableToolTipInCombat and HealBot_Data["UILOCK"] then return end
    xButton=HealBot_Data["TIPBUTTON"]
    if not xButton then return end
    xUnit=xButton.unit
    xGUID=UnitGUID(xUnit)
    if not xGUID then return end
    local uName=HealBot_GetUnitName(xUnit, xGUID)
    if not uName then return end;
    
    HealBot_ToolTip_SetTooltipPos();
  
    if xUnit=="target" and HealBot_Globals.TargetBarRestricted==1 then
        HealBot_Action_RefreshTargetTooltip(xButton)
        return
    end

    local hlth=xButton.health.current
    local maxhlth=xButton.health.max
    local mana=xButton.mana.current
    local maxmana=xButton.mana.max

    if hlth>maxhlth then
        hlth=maxhlth
    end
  
    local UnitOffline=HealBot_Action_GetTimeOffline(xButton); --added by Diacono
    local DebuffType=xButton.aura.debuff.type;

    local spellLeft = HealBot_Tooltip_SpellPattern(xButton, "Left");
    local spellMiddle = HealBot_Tooltip_SpellPattern(xButton, "Middle");
    local spellRight = HealBot_Tooltip_SpellPattern(xButton, "Right");
    local spellButton4 = HealBot_Tooltip_SpellPattern(xButton, "Button4");
    local spellButton5 = HealBot_Tooltip_SpellPattern(xButton, "Button5");
    linenum = 1

    if spellLeft and strsub(strlower(spellLeft),1,4)==strlower(HEALBOT_TELL) then spellLeft=HEALBOT_TELL end
    if spellMiddle and strsub(strlower(spellMiddle),1,4)==strlower(HEALBOT_TELL) then spellMiddle=HEALBOT_TELL end
    if spellRight and strsub(strlower(spellRight),1,4)==strlower(HEALBOT_TELL) then spellRight=HEALBOT_TELL end
    if spellButton4 and strsub(strlower(spellButton4),1,4)==strlower(HEALBOT_TELL) then spellButton4=HEALBOT_TELL end
    if spellButton5 and strsub(strlower(spellButton5),1,4)==strlower(HEALBOT_TELL) then spellButton5=HEALBOT_TELL end
  
    if not IsModifierKeyDown() and not HealBot_Data["UILOCK"] and HealBot_Globals.SmartCast and UnitExists(xUnit) and UnitIsFriend("player",xButton.unit) then 
        local z=spellLeft;
        spellLeft=nil;
        spellLeft=HealBot_Action_SmartCast(xButton);
        if not spellLeft then spellLeft=z; end;
    end
    if spellLeft=="" then spellLeft=nil; end
    if spellMiddle=="" then spellMiddle=nil; end
    if spellRight=="" then spellRight=nil; end
    if spellButton4=="" then spellButton4=nil; end
    if spellButton5=="" then spellButton5=nil; end
    local LeftN, LeftR, LeftG = HealBot_Tooltip_setspellName(xButton, spellLeft)
    local MiddleN, MiddleR, MiddleG = HealBot_Tooltip_setspellName(xButton, spellMiddle)
    local RightN, RightR, RightG = HealBot_Tooltip_setspellName(xButton, spellRight)
    local Button4N, Button4R, Button4G = HealBot_Tooltip_setspellName(xButton, spellButton4)
    local Button5N, Button5R, Button5G = HealBot_Tooltip_setspellName(xButton, spellButton5)

    HealBot_Tooltip_ClearLines();
    
    if HealBot_Globals.Tooltip_ShowTarget then
        if uName then
            local r,g,b=xButton.text.r,xButton.text.g,xButton.text.b
            local uLvl=UnitLevel(xUnit)
            if uLvl<1 then 
                uLvl=nil
            else
                uLvl="Level "..uLvl
            end
            local uClassify=UnitClassification(xUnit) or " "
            if uClassify=="worldboss" or HealBot_UnitBosses(xUnit) then 
                uClassify="Boss"
            elseif uClassify=="rareelite" then 
                uClassify="Rare Elite"
            elseif uClassify=="elite" then 
                uClassify="Elite"
            elseif uClassify=="rare" then 
                uClassify="Rare"
            else
                uClassify=nil
            end
            if uClassify then
                if uLvl then
                    uLvl=uClassify.." "..uLvl
                else
                    uLvl="Boss"
                end
            elseif not uLvl then
                uLvl=""
            end
            local uClass=UnitCreatureFamily(xUnit) or UnitClass(xUnit) or UnitCreatureType(xUnit)
            if uClass==uName then uClass=UnitCreatureType(xUnit) or "" end
            if not uClass or uClass=="" then
                if strfind(xUnit,"pet") then
                    uClass=HEALBOT_WORD_PET 
                else
                    uClass=HEALBOT_WORDS_UNKNOWN 
                end
            end
            local inRange=true
            if HEALBOT_GAME_VERSION<4 then inRange=CheckInteractDistance(xUnit,1) end
            if xButton.spec==" " and UnitIsPlayer(xUnit) and inRange and HealBot_Globals.QueryTalents and not HealBot_Data["INSPECT"] then
                HealBot_Data["INSPECT"]=true
                HealBot_TalentQuery(xUnit)
            end
            HealBot_Tooltip_SetLine(linenum,uName,r,g,b,1,uLvl..xButton.spec..uClass,r,g,b,1)                     
      
            local zone=nil;
            if HealBot_Data["PGUID"]==xGUID or UnitIsVisible(xUnit) then
                zone=GetRealZoneText();
            elseif IsInRaid() and xUnit~="target" and xUnit~="focus" and UnitIsPlayer(xUnit) and UnitInRaid(xUnit) then
                local raidID=UnitInRaid(xUnit)
                _, _, _, _, _, _, zone, _, _ = GetRaidRosterInfo(raidID);
            else
                HealBot_TooltipInit();
                HealBot_ScanTooltip:SetUnit(xUnit)
                zone = HealBot_ScanTooltipTextLeft3:GetText()
                if zone == "PvP" then
                    zone = HealBot_ScanTooltipTextLeft4:GetText()
                end
            end
            linenum=linenum+1
            if hlth and maxhlth then
                local inHeal, inAbsorb = HealBot_IncHeals_retHealsIn(xUnit, xButton)
                local hPct=100
                if maxhlth>0 then
                    hPct=floor((hlth/maxhlth)*100)
                end
                hlth=HealBot_Tooltip_readNumber(hlth)
                maxhlth=HealBot_Tooltip_readNumber(maxhlth)
                if UnitOffline then 
                    HealBot_Tooltip_SetLine(linenum,HB_TOOLTIP_OFFLINE..": "..UnitOffline,1,1,1,1,hlth.."/"..maxhlth.." ("..hPct.."%)",xButton.health.rcol,xButton.health.gcol,0,1)
                elseif zone and not strfind(zone,"Level") then
                    --if zone==HB_TOOLTIP_OFFLINE then xButton.status.offline = GetTime() end
                    HealBot_Tooltip_SetLine(linenum,zone,1,1,1,1,hlth.."/"..maxhlth.." ("..hPct.."%)",xButton.health.rcol,xButton.health.gcol,0,1)
                else
                    HealBot_Tooltip_SetLine(linenum," ",1,1,1,1,hlth.."/"..maxhlth.." ("..hPct.."%)",xButton.health.rcol,xButton.health.gcol,0,1)
                end
                local vUnit=HealBot_retIsInVehicle(xUnit)
                if vUnit then
                    linenum=linenum+1
                    local lr,lg,lb=HealBot_Action_ClassColour(vUnit)
                    hlth,maxhlth=HealBot_VehicleHealth(vUnit)
                    local hPct=floor((hlth/maxhlth)*100)
                    hlth=HealBot_Tooltip_readNumber(hlth)
                    maxhlth=HealBot_Tooltip_readNumber(maxhlth)
                    if UnitExists(vUnit) then
                        HealBot_Tooltip_SetLine(linenum,"  "..HealBot_GetUnitName(vUnit),lr,lg,lb,1,hlth.."/"..maxhlth.." ("..hPct.."%)",xButton.health.rcol,xButton.health.gcol,0,1)
                    else
                        HealBot_Tooltip_SetLine(linenum,"  "..HEALBOT_VEHICLE,lr,lg,lb,1,hlth.."/"..maxhlth.." ("..hPct.."%)",xButton.health.rcol,xButton.health.gcol,0,1)
                    end
                end
            end
            HealBot_Tooltip_luVars["uGroup"]=false
            if IsInRaid() then 
                HealBot_Tooltip_luVars["uGroup"]=HealBot_RetUnitGroups(xUnit)
            end
            if UnitIsPlayer(xUnit) and xButton.aggro.threatpct>0 or mana or (HealBot_Tooltip_luVars["uGroup"] and HealBot_Tooltip_luVars["uGroup"]>0) then
                if not mana or (maxmana and maxmana==0) then
                    if xButton.aggro.threatpct>0 then
                        linenum=linenum+1
						HealBot_Tooltip_SetLine(linenum,HEALBOT_WORD_THREAT.." "..xButton.aggro.threatpct.."%",1,0.1,0.1,1," ",0,0,0,0)
						linenum=linenum+1
						local threatvalue=HealBot_Tooltip_readNumber(xButton.aggro.threatvalue)
						HealBot_Tooltip_SetLine(linenum,xButton.aggro.mobname.." ("..threatvalue..")",1,0.1,0.1,1," ",0,0,0,0)
                    elseif HealBot_Tooltip_luVars["uGroup"] then
                        linenum=linenum+1
                        HealBot_Tooltip_SetLine(linenum,HEALBOT_OPTIONS_GROUPHEALS.." "..HealBot_Tooltip_luVars["uGroup"],1,1,1,1," ",0,0,0,0)
                    end
                else
                    linenum=linenum+1
                    local mPct=100
                    if maxmana>0 then
                        mPct=floor((mana/maxmana)*100)
                    end
                    mana=HealBot_Tooltip_readNumber(mana)
                    maxmana=HealBot_Tooltip_readNumber(maxmana)
                    if xButton.aggro.threatpct<1 then
                        if HealBot_Tooltip_luVars["uGroup"] then
                            HealBot_Tooltip_SetLine(linenum,HEALBOT_OPTIONS_GROUPHEALS.." "..HealBot_Tooltip_luVars["uGroup"],1,1,1,1,mana.."/"..maxmana.." ("..mPct.."%)",0.4,0.4,1,1)
                        else
                            HealBot_Tooltip_SetLine(linenum," ",0,0,0,0,mana.."/"..maxmana.." ("..mPct.."%)",0.4,0.4,1,1)
                        end
                    else
						HealBot_Tooltip_SetLine(linenum,HEALBOT_WORD_THREAT.." "..xButton.aggro.threatpct.."%",1,0.1,0.1,1,mana.."/"..maxmana.." ("..mPct.."%)",0.4,0.4,1,1)
						linenum=linenum+1
						local threatvalue=HealBot_Tooltip_readNumber(xButton.aggro.threatvalue)
						HealBot_Tooltip_SetLine(linenum,xButton.aggro.mobname.." ("..threatvalue..")",1,0.1,0.1,1," ",0,0,0,0)
                    end
                end
            end

            UnitDebuffIcons=HealBot_Aura_ReturnDebuffdetails(xButton.id)
            if UnitDebuffIcons then
                for i = 51,Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][xButton.frame]["MAXDICONS"]+50 do
                    if UnitDebuffIcons[i].current and UnitDebuffIcons[i].spellId>0 and GetSpellInfo(UnitDebuffIcons[i].spellId) then
                        linenum=linenum+1
                        local DebuffType=HealBot_Aura_retDebufftype(xUnit, UnitDebuffIcons[i].spellId)
                        local name=GetSpellInfo(UnitDebuffIcons[i].spellId)
                        if HealBot_Globals.CDCBarColour[i] then
                            HealBot_Tooltip_SetLine(linenum,uName.." suffers from "..name,
                                                        (HealBot_Globals.CDCBarColour[name].R or 0.4)+0.2,
                                                        (HealBot_Globals.CDCBarColour[name].G or 0.05)+0.2,
                                                        (HealBot_Globals.CDCBarColour[name].B or 0.2)+0.2,
                                                        1," ",0,0,0,0)
                        elseif HealBot_Config_Cures.CDCBarColour[DebuffType] then
                            HealBot_Tooltip_SetLine(linenum,uName.." suffers from "..name,
                                                        (HealBot_Config_Cures.CDCBarColour[DebuffType].R or 0.5)+0.2,
                                                        (HealBot_Config_Cures.CDCBarColour[DebuffType].G or 0.2)+0.2,
                                                        (HealBot_Config_Cures.CDCBarColour[DebuffType].B or 0.4)+0.2,
                                                        1," ",0,0,0,0)
                        else
                            local customDebuffPriority=HEALBOT_CUSTOM_en.."15"
                            HealBot_Tooltip_SetLine(linenum,uName.." suffers from "..name,
                                                        (HealBot_Globals.CDCBarColour[customDebuffPriority].R or 0.5)+0.2,
                                                        (HealBot_Globals.CDCBarColour[customDebuffPriority].G or 0.2)+0.2,
                                                        (HealBot_Globals.CDCBarColour[customDebuffPriority].B or 0.4)+0.2,
                                                        1," ",0,0,0,0)
                        end
                    end
                end
            end
            linenum=linenum+1
            --if HealBot_Globals.UseGameTooltip then HealBot_Tooltip_SetLine(linenum,"  ",0,0,0,0) end
            if xButton.aura.buff.name and xButton.aura.buff.name~=HEALBOT_CUSTOM_en then
                linenum=linenum+1
                local br,bg,bb=HealBot_Options_RetBuffRGB(xButton)
                HealBot_Tooltip_SetLine(linenum,"  Requires "..xButton.aura.buff.name,br,bg,bb,1," ",0,0,0,0)
            end
            local d=false
            if HealBot_Globals.Tooltip_ShowMyBuffs then
                for x,_ in pairs(HealBot_CheckBuffs) do
                    local z=HealBot_Aura_RetMyBuffTime(xButton,x)
                    if z and z>GetTime() then
                        d=true
                        z=z-GetTime()
                        local mins,secs=HealBot_Tooltip_ReturnMinsSecs(z)
                        linenum=linenum+1
                        local br,bg,bb=HealBot_Options_RetBuffRGBName(x)
                        if mins>1 then 
                            HealBot_Tooltip_SetLine(linenum,"    "..x.."  "..mins.." mins",br,bg,bb,1," ",0,0,0,0)
                        elseif tonumber(secs)>=0 then
                            HealBot_Tooltip_SetLine(linenum,"    "..x.."  "..secs.." secs",br,bg,bb,1," ",0,0,0,0)
                        else
                            linenum=linenum-1
                            HealBot_Queue_MyBuffsCheck(xGUID, xUnit)
                        end
                    end
                end
            end
            if d then 
                linenum=linenum+1 
            end
            if HealBot_Globals.UseGameTooltip then HealBot_Tooltip_SetLine(linenum,"  ",0,0,0,0) end
            if HealBot_Globals.ProtectPvP and UnitIsPVP(xUnit) and not UnitIsPVP("player") then 
                HealBot_Tooltip_SetLine(linenum,"    ----- PVP -----",1,0.5,0.5,1,"----- PVP -----    ",1,0.5,0.5,1)
                linenum=linenum+1;
            end
        end
    else
        HealBot_Tooltip_SetLine(linenum,HEALBOT_OPTIONS_TAB_SPELLS,1,1,1,1," ",0,0,0,0)
    end
    
    if IsShiftKeyDown() and IsAltKeyDown() and IsControlKeyDown() then
        if spellLeft then 
            linenum=linenum+1
            HealBot_Tooltip_SetLine(linenum,HEALBOT_OPTIONS_BUTTONLEFT,1,1,0,1,spellLeft,0.5,0.5,1,1)
        end
        if spellMiddle then
            linenum=linenum+1
            HealBot_Tooltip_SetLine(linenum,HEALBOT_OPTIONS_BUTTONMIDDLE,1,1,0,1,spellMiddle,0.5,0.5,1,1)
        end
        if spellRight then
            linenum=linenum+1
            HealBot_Tooltip_SetLine(linenum,HEALBOT_OPTIONS_BUTTONRIGHT,1,1,0,1,spellRight,0.5,0.5,1,1)
        end
    elseif HealBot_Globals.Tooltip_ShowSpellDetail then

        if LeftN then
            linenum=linenum+1
            HealBot_Tooltip_SetLine(linenum,HEALBOT_OPTIONS_BUTTONLEFT.." "..HEALBOT_OPTIONS_COMBOBUTTON..": "..LeftN,LeftR,LeftG,0,1) 
            HealBot_Tooltip_SpellInfo(LeftN);
        end
        if MiddleN then
            linenum=linenum+1;
            HealBot_Tooltip_SetLine(linenum,HEALBOT_OPTIONS_BUTTONMIDDLE.." "..HEALBOT_OPTIONS_COMBOBUTTON..": "..MiddleN,MiddleR,MiddleG,0,1) 
            HealBot_Tooltip_SpellInfo(MiddleN);
        end
        if RightN then
            linenum=linenum+1;
            HealBot_Tooltip_SetLine(linenum,HEALBOT_OPTIONS_BUTTONRIGHT.." "..HEALBOT_OPTIONS_COMBOBUTTON..": "..RightN,RightR,RightG,0,1) 
            HealBot_Tooltip_SpellInfo(RightN);
        end
        if Button4N then
            linenum=linenum+1;
            HealBot_Tooltip_SetLine(linenum,HEALBOT_OPTIONS_BUTTON4.." "..HEALBOT_OPTIONS_COMBOBUTTON..": "..Button4N,Button4R,Button4G,0,1) 
            HealBot_Tooltip_SpellInfo(Button4N);
        end
        if Button5N then
            linenum=linenum+1;
            HealBot_Tooltip_SetLine(linenum,HEALBOT_OPTIONS_BUTTON5.." "..HEALBOT_OPTIONS_COMBOBUTTON..": "..Button5N,Button5R,Button5G,0,1) 
            HealBot_Tooltip_SpellInfo(Button5N);
        end
    else
        if LeftN then 
            linenum=linenum+1
            HealBot_Tooltip_SetLine(linenum,HEALBOT_OPTIONS_BUTTONLEFT..": "..LeftN,LeftR,LeftG,0,1,HealBot_Tooltip_SpellSummary(spellLeft),0.5,0.5,1,1)
        end
        if MiddleN then
            linenum=linenum+1
            HealBot_Tooltip_SetLine(linenum,HEALBOT_OPTIONS_BUTTONMIDDLE..": "..MiddleN,MiddleR,MiddleG,0,1,HealBot_Tooltip_SpellSummary(spellMiddle),0.5,0.5,1,1)               
        end
        if RightN then
            linenum=linenum+1
            HealBot_Tooltip_SetLine(linenum,HEALBOT_OPTIONS_BUTTONRIGHT..": "..RightN,RightR,RightG,0,1,HealBot_Tooltip_SpellSummary(spellRight),0.5,0.5,1,1)
        end
        if Button4N then
            linenum=linenum+1
            HealBot_Tooltip_SetLine(linenum,HEALBOT_OPTIONS_BUTTON4..": "..Button4N,Button4R,Button4G,0,1,HealBot_Tooltip_SpellSummary(spellButton4),0.5,0.5,1,1)
        end
        if Button5N then
            linenum=linenum+1
            HealBot_Tooltip_SetLine(linenum,HEALBOT_OPTIONS_BUTTON5..": "..Button5N,Button5R,Button5G,0,1,HealBot_Tooltip_SpellSummary(spellButton5),0.5,0.5,1,1)
        end
    end      
    if HealBot_Globals.Tooltip_MouseWheel then
        local nCommands=0
        local keyDown="None"
        if IsShiftKeyDown() then
            keyDown="Shift"
        elseif IsControlKeyDown() then
            keyDown="Ctrl"
        elseif IsAltKeyDown() then
            keyDown="Alt"
        end
        local wheelUp=HealBot_Globals.HealBot_MouseWheelTxt[keyDown.."Up"]
        local wheelDown=HealBot_Globals.HealBot_MouseWheelTxt[keyDown.."Down"]
        if (wheelUp and wheelUp~=HEALBOT_WORDS_NONE) or (wheelDown and wheelDown~=HEALBOT_WORDS_NONE) then
            linenum=linenum+1
            HealBot_Tooltip_SetLine(linenum," ",0,0,0,0)
            if wheelUp and wheelUp~=HEALBOT_WORDS_NONE then 
                if wheelUp==HEALBOT_EMOTE then wheelUp=wheelUp..": "..HealBot_Globals.HealBot_Emotes[keyDown.."Up"] end
                linenum=linenum+1
                HealBot_Tooltip_SetLine(linenum,HEALBOT_OPTIONS_MOUSEUP,1,1,0,1,wheelUp,0.5,0.5,1,1)
            end
            if wheelDown and wheelDown~=HEALBOT_WORDS_NONE then
                if wheelDown==HEALBOT_EMOTE then wheelDown=wheelDown..": "..HealBot_Globals.HealBot_Emotes[keyDown.."Down"] end
                linenum=linenum+1
                HealBot_Tooltip_SetLine(linenum,HEALBOT_OPTIONS_MOUSEDOWN,1,1,0,1,wheelDown,0.5,0.5,1,1)
            end
        end
    end
  
    HealBot_ToolTip_ShowHoT(xButton.id, xUnit)
    HealBot_Tooltip_Show()
end

function HealBot_Action_DoRefreshTargetTooltip(button)
    HealBot_TooltipInit();
    HealBot_Tooltip_ClearLines();
    linenum=1
    local r,g,b=button.text.r,button.text.g,button.text.b

    if UnitClass(button.unit) then
        HealBot_Tooltip_SetLine(linenum,HealBot_GetUnitName(button.unit, button.guid),r,g,b,1,"Level "..UnitLevel(button.unit)..button.spec..UnitClass(button.unit),r,g,b,1)    
    else
        HealBot_Tooltip_SetLine(linenum,HealBot_GetUnitName(button.unit, button.guid),r,g,b,1,rText,rR,rG,rB,ra)
    end
    linenum=linenum+1
    HealBot_Tooltip_SetLine(linenum,HEALBOT_TOOLTIP_TARGETBAR,1,1,0.5,1,HEALBOT_OPTIONS_TAB_SPELLS.." "..HEALBOT_SKIN_DISTEXT,1,1,0,1)
    linenum=linenum+2
    if HealBot_Globals.SmartCast then
        HealBot_Tooltip_SetLine(linenum," "..HEALBOT_OPTIONS_BUTTONLEFT..":",1,1,0.2,1,HEALBOT_TITAN_SMARTCAST.." ",1,1,1,1)
    end
    linenum=linenum+1
    HealBot_Tooltip_SetLineLeft(" "..HEALBOT_OPTIONS_BUTTONRIGHT..":",1,1,0.2,linenum,1)
    if HealBot_Panel_RetMyHealTarget(button.unit) then
        HealBot_Tooltip_SetLine(linenum," "..HEALBOT_OPTIONS_BUTTONRIGHT..":",1,1,0.2,1,HEALBOT_WORDS_REMOVEFROM.." "..HEALBOT_OPTIONS_MYTARGET.." ",1,1,1,1)
    else
        HealBot_Tooltip_SetLine(linenum," "..HEALBOT_OPTIONS_BUTTONRIGHT..":",1,1,0.2,1,HEALBOT_WORDS_ADDTO.." "..HEALBOT_OPTIONS_MYTARGET.." ",1,1,1,1)
    end
    HealBot_Tooltip_Show()
end

function HealBot_Action_RefreshTooltip()
    if HealBot_Tooltip_luVars["doInit"] then
        HealBot_Tooltip_luVars["doInit"]=false
        HealBot_Tooltip_InitFont()
    end
    HealBot_Action_DoRefreshTooltip()
end

function HealBot_Action_RefreshTargetTooltip(button)
    HealBot_Action_DoRefreshTargetTooltip(button)
end

function HealBot_Tooltip_Options_Show(noLines)
	if HealBot_Globals.UseGameTooltip then
        GameTooltip:Show();
    else
		if HealBot_Tooltip_luVars["doInit"] then
			HealBot_Tooltip_luVars["doInit"]=false
			HealBot_Tooltip_InitFont()
		end
		local height = 20 
		local width = 0
		for x = 1, noLines do
			local txtL = _G["HealBot_TooltipTextL" .. x]
			height = height + txtL:GetHeight() + 2
			if (txtL:GetWidth() + 25 > width) then
				width = txtL:GetWidth() + 25
			end
		end
		HealBot_Tooltip:SetWidth(width)
		HealBot_Tooltip:SetHeight(height)        
		HealBot_Tooltip:SetScale(1.01);
		HealBot_Tooltip:SetScale(1);
		HealBot_Tooltip:Show();
	end
end

local tLine={}
function HealBot_Tooltip_OptionsHelp(title,text)
    HealBot_Tooltip_ClearLines();
    for x,_ in pairs(tLine) do
        tLine[x]=nil;
    end
    local i=0
    for l in string.gmatch(text, "[^\n]+") do
        local t=(string.gsub(l, "^%s*(.-)%s*$", "%1"))
        if string.len(t)>1 then
            i=i+1
            tLine[i]=t
        end
    end
    local linenum=1
	local x, y = GetCursorPosition();
	x=x/UIParent:GetScale();
	y=y/UIParent:GetScale();
    local g=_G["HealBot_Options"]
	if HealBot_Globals.UseGameTooltip then
		GameTooltip:SetOwner(g, "ANCHOR_NONE")
        GameTooltip:SetPoint("TOPLEFT","WorldFrame","BOTTOMLEFT",x,y-30);
        GameTooltip:AddLine(title,1,1,1)
        GameTooltip:AddLine("    ",1,1,1)
	else
		HealBot_Tooltip:ClearAllPoints();
		HealBot_Tooltip:SetPoint("TOPLEFT","WorldFrame","BOTTOMLEFT",x,y-30);
		HealBot_Tooltip_SetLineLeft(title,1,1,1,linenum,1)
		linenum=linenum+1
		HealBot_Tooltip_SetLineLeft("     ",0,0,0,linenum,0)
	end
    for l=1,#tLine do 
		if HealBot_Globals.UseGameTooltip then
			GameTooltip:AddLine(tLine[l],0.8,0.8,0.8)
		else
			linenum=linenum+1
			HealBot_Tooltip_SetLineLeft(tLine[l],0.8,0.8,0.8,linenum,1)
		end
    end
    HealBot_Tooltip_Options_Show(linenum)
end

function HealBot_Tooltip_OptionsHide()
	if HealBot_Globals.UseGameTooltip then
		GameTooltip:Hide()
	else
		HealBot_Tooltip:Hide()
	end
end