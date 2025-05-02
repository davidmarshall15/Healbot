local HealBot_UnitBuffIcons={}
local HealBot_UnitDebuffIcons={}
local HealBot_UnitBuffCurrent={}
local HealBot_UnitDebuffCurrent={}
local HealBot_UnitExtraIcons={}
local HealBot_BuffNameTypes={}
local HealBot_BuffMinLevels={}
local HealBot_AuraBuffCache={}
local HealBot_AuraBuffIconCache={}
local HealBot_AuraDebuffCache={}
local HealBot_ExcludeBuffInCache={}
local HealBot_Aura_WarningFilter={}
local HealBot_Aura_CanDispel={}
local HealBot_Aura_prevIconCount={["DEBUFF"]={[1]=0,[2]=0,[3]=0,},["BUFF"]={[1]=0,[2]=0,[3]=0,} }
local HealBot_Watch_HoT={};
local HealBot_CheckBuffs={}
local HealBot_ShortBuffs={}
local HealBot_BuffWatch={}
local HealBot_BuffWatchList={}
local PlayerBuffs={}
local PlayerBuffTypes={}
local xButton, pButton
local buffSort={[1]={},[2]={},[3]={}}
local debuffSort={[1]={},[2]={},[3]={}}
local HealBot_Aura_ID={}
local HealBot_Aura_IconSet={}
local HealBot_SpellID_LookupData={}
local HealBot_SpellID_LookupIdx={}
local HealBot_BuffIconSet={}
local HealBot_BuffIconGlow={}
local HealBot_BuffFilter={}
local HealBot_DebuffIconSet={}
local HealBot_DebuffIconGlow={}
local HealBot_DebuffFilter={}
local HealBot_BuffTagNames={}
local HealBot_DebuffTagNames={}
local HealBot_AuraBuffXRef={}
local HealBot_AuraDebuffXRef={}
local _
local HealBot_Buff_Aura2Item={}
local HealBot_Buff_Aura2Spell={}
local HealBot_Buff_ItemIDs={};
local buffCheck, generalBuffs, buffWarnings, debuffCheck, debuffWarnings=false,false,false,true,true
local tmpBCheck, tmpCBuffs, tmpGBuffs, tmpDCheck, tmpBGroup, tmpDGroup, tmpNumGroup=false,false,false,false,false,false,0
local uaName, uaTexture, uaCount, uaDebuffType, uaDuration="","",0,"",0
local uaExpirationTime, uaUnitCaster, uaUnitIsPlayer, uaSpellId, uaIsBossDebuff=0,"",false,0,false
local uaExtra17, uaExtra18, uaExtra19=nil, nil, nil
local uaBuffData={}
local uaDebuffData={}
local uaBuffSlot, uaDebuffSlot=0,0
local HealBot_Classic_Absorbs={}
local HealBot_Classic_AbsorbsV1Track={}
local classicAbsorbBonusV1={}
local HealBot_Weapon_Enchant={[1]=false,[2]=false}
local HealBot_Aura_AuxAssigns={}
HealBot_Aura_AuxAssigns["NameOverlayBuff"]={[0]=false,[1]=false,[2]=false,[3]=false,[4]=false,[5]=false,[6]=false,[7]=false,[8]=false,[9]=false,[10]=false}
HealBot_Aura_AuxAssigns["NameOverlayDebuff"]={[0]=false,[1]=false,[2]=false,[3]=false,[4]=false,[5]=false,[6]=false,[7]=false,[8]=false,[9]=false,[10]=false}
HealBot_Aura_AuxAssigns["HealthOverlayBuff"]={[0]=false,[1]=false,[2]=false,[3]=false,[4]=false,[5]=false,[6]=false,[7]=false,[8]=false,[9]=false,[10]=false}
HealBot_Aura_AuxAssigns["HealthOverlayDebuff"]={[0]=false,[1]=false,[2]=false,[3]=false,[4]=false,[5]=false,[6]=false,[7]=false,[8]=false,[9]=false,[10]=false}
local HealBot_Aura_luVars={}
HealBot_Aura_luVars["TankGUID1"]="x"
HealBot_Aura_luVars["mapName"]=HEALBOT_WORD_OUTSIDE
HealBot_Aura_luVars["IgnoreFastDurDebuffsSecs"]=-1
HealBot_Aura_luVars["HotBarDebuff"]=0
HealBot_Aura_luVars["ManaDrink"]=""
HealBot_Aura_luVars["WellFed"]=""
HealBot_Aura_luVars["TestBarsOn"]=false
HealBot_Aura_luVars["AuraUpdate"]=0.98

local hbDebuffOnCD={}

local hbTextureUpdateId={}
local hbTextureUpdateTime={}

local BleedList={}

function HealBot_Aura_setLuVars(vName, vValue)
    --HealBot_setCall("HealBot_Aura_setLuVars - "..vName)
    HealBot_Aura_luVars[vName]=vValue
end

function HealBot_Aura_retLuVars(vName)
    --HealBot_setCall("HealBot_retLuVars"..vName)
    return HealBot_Aura_luVars[vName]
end

function HealBot_Aura_UpdateCheckInterval()
    HealBot_Aura_luVars["AuraUpdate"]=HealBot_Util_PerfVal4(98)
    if HealBot_Aura_luVars["AuraUpdate"]<0.9 then 
        HealBot_Aura_luVars["AuraUpdate"]=0.9 
    elseif HealBot_Aura_luVars["AuraUpdate"]>1 then 
        HealBot_Aura_luVars["AuraUpdate"]=0.99
    end
    HealBot_Debug_PerfUpdate("AuraUpdate", HealBot_Aura_luVars["AuraUpdate"])
end

function HealBot_Aura_setAuxAssigns(vName, frame, vValue)
        --HealBot_setCall("HealBot_Aura_setAuxAssigns")
    HealBot_Aura_AuxAssigns[vName][frame]=vValue
end

--function HealBot_Aura_retRaidtargetIcon(id)
        --HealBot_setCall("HealBot_Aura_retRaidtargetIcon")
--    return HealBot_Media_retTargetIcon(id)
--end

function HealBot_Aura_ResetBuffCache()
        --HealBot_setCall("HealBot_Aura_ResetBuffCache")
    for spellId,_ in pairs(HealBot_AuraBuffCache) do
        HealBot_AuraBuffCache[spellId].always=false
        HealBot_AuraBuffCache[spellId].isAuto=false
        HealBot_AuraBuffCache[spellId].reset=true
    end
    HealBot_Timers_Set("AURA","CustomBuffFilterDisabled")
end

function HealBot_Aura_ResetDebuffCache()
        --HealBot_setCall("HealBot_Aura_ResetDebuffCache")
    for spellId,_ in pairs(HealBot_AuraDebuffCache) do
        HealBot_AuraDebuffCache[spellId].always=false
        HealBot_AuraDebuffCache[spellId].isAuto=false
        HealBot_AuraDebuffCache[spellId].reset=true
    end
    HealBot_Timers_Set("AURA","CustomDebuffFilterDisabled")
    HealBot_Timers_Set("AURA","CheckDebuffs")
end

function HealBot_Aura_DeleteExcludeBuffInCache()
        --HealBot_setCall("HealBot_Aura_DeleteExcludeBuffInCache")
    for id,_ in pairs(HealBot_ExcludeBuffInCache) do
        HealBot_ExcludeBuffInCache[id]=nil
    end
    HealBot_setLuVars("UpdateAllAura", 5)
    HealBot_Aura_luVars["updateAll"]=true
    HealBot_Timers_Set("AURA","CheckBuffs")
end

function HealBot_Aura_RemoveIcon(button, index)
      --HealBot_setCall("HealBot_Aura_RemoveIcon", button)
    if not button then return; end;
    button.gref.icon[index]:SetAlpha(0)
    if index<90 then
        button.gref.txt.expire[index]:SetTextColor(1,1,1,0);
        button.gref.txt.count[index]:SetTextColor(1,1,1,0)
        button.gref.txt.expire[index]:SetText(" ");
        button.gref.txt.count[index]:SetText(" ");
        if index<50 then
            if HealBot_UnitBuffIcons[button.id] then
                HealBot_UnitBuffIcons[button.id][index].current=false
            end
            button.gref.indicator.selfcast[index]:SetAlpha(0)
            if button.glow.icon[index]>1 then
                HealBot_Action_DisableIconGlow(button, "ICONBUFF", index)
            end
        else
            if HealBot_UnitDebuffIcons[button.id] then
                HealBot_UnitDebuffIcons[button.id][index].current=false
            end
            if button.glow.icon[index]>1 then
                HealBot_Action_DisableIconGlow(button, "ICONDEBUFF", index)
            end
        end
        button.gref.iconf[index]:SetFrameLevel(0)
    else
        if HealBot_UnitExtraIcons[button.id] then
            HealBot_UnitExtraIcons[button.id][index].current=false
        end
        if index == 91 then
            button.icon.extra.classtexture=false
        elseif index == 92 then
            button.icon.extra.targeticon=0
        elseif index == 93 then
            button.icon.extra.readycheck=false
        end
    end
end

function HealBot_Aura_RemoveBuffIcons(button)
        --HealBot_setCall("HealBot_Aura_RemoveBuffIcons", button)
    if button.frame>0 then
        for i=1,button.icon.buff.count[1] do
            HealBot_Aura_RemoveIcon(button, i)
        end
        for i=9,8+button.icon.buff.count[2] do
            HealBot_Aura_RemoveIcon(button, i)
        end
        for i=11,10+button.icon.buff.count[3] do
            HealBot_Aura_RemoveIcon(button, i)
        end
        HealBot_Aura_ClearBuff(button)
    end
end

function HealBot_Aura_RemoveUnusedBuffIconsButton(button)
    if hbv_Skins_GetIconVar("MAXBICONS", button.frame, 1)<8 then
        for i=hbv_Skins_GetIconVar("MAXBICONS", button.frame, 1)+1,8 do
            HealBot_Aura_RemoveIcon(button, i)
        end
    end
    if hbv_Skins_GetIconVar("MAXBICONS", button.frame, 2)<2 then
        for i=hbv_Skins_GetIconVar("MAXBICONS", button.frame, 2)+9,10 do
            HealBot_Aura_RemoveIcon(button, i)
        end
    end
    if hbv_Skins_GetIconVar("MAXBICONS", button.frame, 3)<2 then
        for i=hbv_Skins_GetIconVar("MAXBICONS", button.frame, 3)+11,12 do
            HealBot_Aura_RemoveIcon(button, i)
        end
    end
end

function HealBot_Aura_RemoveDebuffIcons(button)
        --HealBot_setCall("HealBot_Aura_RemoveDebuffIcons", button)
    if button.frame>0 then
        for i=51,50+button.icon.debuff.count[1] do
            HealBot_Aura_RemoveIcon(button, i)
        end
        for i=57,56+button.icon.debuff.count[2] do
            HealBot_Aura_RemoveIcon(button, i)
        end
        for i=59,58+button.icon.debuff.count[3] do
            HealBot_Aura_RemoveIcon(button, i)
        end
        HealBot_Aura_ClearDebuff(button)
    end
end

function HealBot_Aura_RemoveUnusedDebuffIconsButton(button)
    if hbv_Skins_GetIconVar("MAXDICONS", button.frame, 1)<6 then
        for i=hbv_Skins_GetIconVar("MAXDICONS", button.frame, 1)+51,56 do
            HealBot_Aura_RemoveIcon(button, i)
        end
    end
    if hbv_Skins_GetIconVar("MAXDICONS", button.frame, 2)<2 then
        for i=hbv_Skins_GetIconVar("MAXDICONS", button.frame, 2)+57,58 do
            HealBot_Aura_RemoveIcon(button, i)
        end
    end
    if hbv_Skins_GetIconVar("MAXDICONS", button.frame, 3)<2 then
        for i=hbv_Skins_GetIconVar("MAXDICONS", button.frame, 3)+59,60 do
            HealBot_Aura_RemoveIcon(button, i)
        end
    end
end

function HealBot_Aura_RemoveExtraUnitIcons(button, index)
      --HealBot_setCall("HealBot_Aura_RemoveExtraUnitIcons", button)
    HealBot_Aura_RemoveIcon(button, index)
end

HealBot_Aura_luVars["exIconAlpha"]=0
function HealBot_Aura_UpdateExtraIcon(button, iconData, index)
      --HealBot_setCall("HealBot_Aura_UpdateExtraIcon", button)
    if (index == 91 and hbv_Skins_GetFrameBoolean("Icons", "CLASSEN", button.frame)) or
       (index == 92 and hbv_Skins_GetFrameBoolean("Icons", "TARGETEN", button.frame)) or
       (index == 93 and hbv_Skins_GetFrameBoolean("Icons", "RCEN", button.frame)) or
       (index == 94 and hbv_Skins_GetFrameBoolean("Icons", "OOREN", button.frame)) or
       (index == 95 and hbv_Skins_GetFrameBoolean("Icons", "RANKEN", button.frame)) or
       (index == 96 and hbv_Skins_GetFrameBoolean("Icons", "COMBATEN", button.frame)) then
        HealBot_Aura_luVars["exIconAlpha"]=HealBot_Action_BarColourAlpha(button, hbv_Skins_GetFrameVar("BarCol", "HA", button.framecol), 1)
    else
        HealBot_Aura_luVars["exIconAlpha"]=button.status.alpha
    end
    button.gref.icon[index]:SetAlpha(HealBot_Aura_luVars["exIconAlpha"])
end

local dbSecsLeft, dbRetAlpha, dbFadeDiff, dbNextAuraUpdate, dbMaxAlpha, dbMaxDur=0,0,0,1,1,1
function HealBot_Aura_DebuffIconAlphaValue(button, iconData, secsLeft)
      --HealBot_setCall("HealBot_Aura_DebuffIconAlphaValue", button, nil, nil, true)
    dbNextAuraUpdate=999
    if secsLeft>-3 then
        if hbv_Skins_GetIconBoolean("DFADE", button.frame, iconData.iconSet) then
            if iconData.duration<hbv_Skins_GetIconVar("DFADESECS", button.frame, iconData.iconSet) then
                dbMaxDur=iconData.duration
            else
                dbMaxDur=hbv_Skins_GetIconVar("DFADESECS", button.frame, iconData.iconSet)
            end
            if secsLeft<dbMaxDur then
                dbNextAuraUpdate=0.122
                if (iconData.expirationTime-HealBot_TimeNow)<0 then
                    dbFadeDiff=0.01
                else
                    dbFadeDiff=(iconData.expirationTime-HealBot_TimeNow)/dbMaxDur
                end
                if dbFadeDiff<0.97 then
                    dbRetAlpha=dbFadeDiff+0.03 --+((1-dbFadeDiff)/3)
                else
                    dbRetAlpha=1
                end
                if hbv_Skins_GetIconBoolean("DI15EN", button.frame, iconData.iconSet) then
                    dbMaxAlpha=HealBot_Action_BarColourAlpha(button, hbv_Skins_GetFrameVar("BarCol", "HA", button.framecol), 1)
                    if dbRetAlpha>dbMaxAlpha then
                        dbRetAlpha=dbMaxAlpha
                    end
                elseif dbRetAlpha>button.status.alpha then
                    dbRetAlpha=button.status.alpha
                end
            else
                dbNextAuraUpdate=secsLeft-dbMaxDur
                if hbv_Skins_GetIconBoolean("DI15EN", button.frame, iconData.iconSet) then
                    dbRetAlpha=HealBot_Action_BarColourAlpha(button, hbv_Skins_GetFrameVar("BarCol", "HA", button.framecol), 1)
                else
                    dbRetAlpha=button.status.alpha
                end
            end
        elseif hbv_Skins_GetIconBoolean("DI15EN", button.frame, iconData.iconSet) then
            dbRetAlpha=HealBot_Action_BarColourAlpha(button, hbv_Skins_GetFrameVar("BarCol", "HA", button.framecol), 1)
        else
            dbRetAlpha=button.status.alpha
        end
    else
        dbRetAlpha=0
        HealBot_DebuffThrottleUpdateButton(button)
    end
    return dbRetAlpha, dbNextAuraUpdate
end

local dbAlphaNextUpdate, dbDurNextUpdate, dbiconAlpha=0,0,0
function HealBot_Aura_DoUpdateDebuffIcon(button, iconData, index, timer, lastSpellId, srcTimer)
      --HealBot_setCall("HealBot_Aura_DoUpdateDebuffIcon", button, nil, nil, true)
    if iconData.current and lastSpellId == iconData.spellId then
        dbAlphaNextUpdate=999
        dbDurNextUpdate=999
        dbSecsLeft=floor((iconData.expirationTime-HealBot_TimeNow)-0.5)
        if iconData.expirationTime>0 then
            dbiconAlpha, dbAlphaNextUpdate=HealBot_Aura_DebuffIconAlphaValue(button, iconData, dbSecsLeft)
        elseif hbv_Skins_GetIconBoolean("DI15EN", button.frame, iconData.iconSet) then
            dbiconAlpha=HealBot_Action_BarColourAlpha(button, hbv_Skins_GetFrameVar("BarCol", "HA", button.framecol), 1)
        else
            dbiconAlpha=button.status.alpha
        end
        button.gref.icon[index]:SetAlpha(dbiconAlpha)
        if dbiconAlpha<button.status.alpha then
            dbiconAlpha=button.status.alpha
        end
        if dbSecsLeft>-2 and hbv_Skins_GetIconTextBoolean("DBSDUR", button.frame, iconData.iconSet) then
            if dbSecsLeft<=hbv_Skins_GetIconTextVar("DBDURTHRH", button.frame, iconData.iconSet) then
                if dbSecsLeft<=hbv_Skins_GetIconTextVar("DBDURWARN", button.frame, iconData.iconSet) then
                    if UnitIsFriend("player",button.unit) then
                        button.gref.txt.expire[index]:SetTextColor(0,1,0,dbiconAlpha)
                    else
                        button.gref.txt.expire[index]:SetTextColor(1,0,0,dbiconAlpha);
                    end
                    if dbSecsLeft>-1 then
                        button.gref.txt.expire[index]:SetText(dbSecsLeft);
                    else
                        button.gref.txt.expire[index]:SetText("0")
                    end
                else
                    button.gref.txt.expire[index]:SetTextColor(1,1,1,dbiconAlpha);
                    button.gref.txt.expire[index]:SetText(dbSecsLeft)
                end
                dbDurNextUpdate=HealBot_Aura_luVars["AuraUpdate"]
            else
                button.gref.txt.expire[index]:SetTextColor(1,1,1,0)
                button.gref.txt.expire[index]:SetText(" ");
                dbDurNextUpdate=dbSecsLeft-hbv_Skins_GetIconTextVar("DBDURTHRH", button.frame, iconData.iconSet)
                --if (iconData.expirationTime-HealBot_TimeNow-1)>hbv_Skins_GetIconTextVar("DBDURTHRH", button.frame, iconData.iconSet) then
                --    dbDurNextUpdate=(iconData.expirationTime-HealBot_TimeNow-1)-hbv_Skins_GetIconTextVar("DBDURTHRH", button.frame, iconData.iconSet)
                --else
                --    dbDurNextUpdate=HealBot_Aura_luVars["AuraUpdate"]
                --end
            end
        else
            button.gref.txt.expire[index]:SetTextColor(1,1,1,0)
            button.gref.txt.expire[index]:SetText(" ");
        end
        if hbTextureUpdateTime[button.id][lastSpellId] then
            if hbTextureUpdateTime[button.id][lastSpellId]<HealBot_TimeNow then
                hbTextureUpdateTime[button.id][lastSpellId]=nil
                button.gref.icon[index]:SetTexture(HealBot_WoWAPI_SpellTexture(iconData.spellId))
            elseif (dbDurNextUpdate+1)>hbTextureUpdateTime[button.id][lastSpellId]-HealBot_TimeNow then
                dbDurNextUpdate=hbTextureUpdateTime[button.id][lastSpellId]-HealBot_TimeNow
            end
        end
        if not srcTimer then
            if iconData.count > 1 and hbv_Skins_GetIconTextBoolean("DBSCNT", button.frame, iconData.iconSet) then
                button.gref.txt.count[index]:SetText(iconData.count);
                button.gref.txt.count[index]:SetTextColor(1,1,1,dbiconAlpha);
            else
                button.gref.txt.count[index]:SetTextColor(1,1,1,0)
                button.gref.txt.count[index]:SetText(" ");
            end
        end
        if timer then
            if dbAlphaNextUpdate<dbDurNextUpdate then
                C_Timer.After(dbAlphaNextUpdate, function() HealBot_Aura_DoUpdateDebuffIcon(button, iconData, index, true, lastSpellId, true) end)
            elseif dbDurNextUpdate<999 then
                C_Timer.After(dbDurNextUpdate, function() HealBot_Aura_DoUpdateDebuffIcon(button, iconData, index, true, lastSpellId, true) end)
            end
        end
    end
end

local hbGlowSpellName,hbGlowIdx="",1
local customDebuffPriority=hbv_GetStatic("cDebuff")
function HealBot_Aura_UpdateDebuffIcon(button, iconData, index, timer, spellId)
      --HealBot_setCall("HealBot_Aura_UpdateDebuffIcon", button, nil, nil, true)
    HealBot_Aura_DoUpdateDebuffIcon(button, iconData, index, timer, spellId, false)
    if HealBot_AuraDebuffCache[spellId] then
        hbGlowSpellName=HealBot_AuraDebuffCache[spellId]["name"] or "x"
        hbGlowIdx=HealBot_DebuffIconGlow[spellId] or HealBot_DebuffIconGlow[hbGlowSpellName] or 1
    else
        hbGlowIdx=1
    end
    if hbGlowIdx>1 then
        if HealBot_Globals.CDCBarColour[spellId] then
            HealBot_Action_EnableIconGlow(button, 
                                          HealBot_Globals.CDCBarColour[spellId].R or 1, 
                                          HealBot_Globals.CDCBarColour[spellId].G or 0.25, 
                                          HealBot_Globals.CDCBarColour[spellId].B or 0.25, 
                                          "ICONDEBUFF", 
                                          hbGlowIdx, 
                                          index,
                                          dbiconAlpha)
        elseif HealBot_Globals.CDCBarColour[hbGlowSpellName] then
            HealBot_Action_EnableIconGlow(button, 
                                          HealBot_Globals.CDCBarColour[hbGlowSpellName].R or 1, 
                                          HealBot_Globals.CDCBarColour[hbGlowSpellName].G or 0.25, 
                                          HealBot_Globals.CDCBarColour[hbGlowSpellName].B or 0.25, 
                                          "ICONDEBUFF", 
                                          hbGlowIdx, 
                                          index,
                                          dbiconAlpha)
        else
            HealBot_Action_EnableIconGlow(button,  
                                          HealBot_Globals.CDCBarColour[customDebuffPriority].R or 1, 
                                          HealBot_Globals.CDCBarColour[customDebuffPriority].G or 0.25, 
                                          HealBot_Globals.CDCBarColour[customDebuffPriority].B or 0.25, 
                                          "ICONDEBUFF", 
                                          hbGlowIdx, 
                                          index,
                                          dbiconAlpha)
        end
    elseif button.glow.icon[index]>1 then
        HealBot_Action_DisableIconGlow(button, "ICONDEBUFF", index)
    end
end

local bSecsLeft, bRetAlpha, bFadeDiff, bNextAuraUpdate, bMaxAlpha, bMaxDur=0,0,0,1,1,5
function HealBot_Aura_BuffIconAlphaValue(button, iconData, secsLeft)
      --HealBot_setCall("HealBot_Aura_BuffIconAlphaValue", button, nil, nil, true)
    bNextAuraUpdate=999
    if secsLeft>-3 then
        if hbv_Skins_GetIconBoolean("BUFFFADE", button.frame, iconData.iconSet) then
            if iconData.duration<hbv_Skins_GetIconVar("BUFFFADESECS", button.frame, iconData.iconSet) then
                bMaxDur=iconData.duration
            else
                bMaxDur=hbv_Skins_GetIconVar("BUFFFADESECS", button.frame, iconData.iconSet)
            end
            if secsLeft<bMaxDur then
                bNextAuraUpdate=0.122
                if (iconData.expirationTime-HealBot_TimeNow)<0 then
                    bFadeDiff=0.01
                else
                    bFadeDiff=(iconData.expirationTime-HealBot_TimeNow)/bMaxDur
                end
                if bFadeDiff<0.97 then
                    bRetAlpha=bFadeDiff+0.03 --+((1-bFadeDiff)/3)
                else
                    bRetAlpha=1
                end
                if hbv_Skins_GetIconBoolean("BUFFI15EN", button.frame, iconData.iconSet) then
                    bMaxAlpha=HealBot_Action_BarColourAlpha(button, hbv_Skins_GetFrameVar("BarCol", "HA", button.framecol), 1)
                    if bRetAlpha>bMaxAlpha then
                        bRetAlpha=bMaxAlpha
                    end
                elseif bRetAlpha>button.status.alpha then
                    bRetAlpha=button.status.alpha
                end
            else
                bNextAuraUpdate=secsLeft-bMaxDur
                if hbv_Skins_GetIconBoolean("BUFFI15EN", button.frame, iconData.iconSet) then
                    bRetAlpha=HealBot_Action_BarColourAlpha(button, hbv_Skins_GetFrameVar("BarCol", "HA", button.framecol), 1)
                else
                    bRetAlpha=button.status.alpha
                end
            end
        elseif hbv_Skins_GetIconBoolean("BUFFI15EN", button.frame, iconData.iconSet) then
            bRetAlpha=HealBot_Action_BarColourAlpha(button, hbv_Skins_GetFrameVar("BarCol", "HA", button.framecol), 1)
        else
            bRetAlpha=button.status.alpha
        end
    else
        bRetAlpha=0
        --HealBot_BuffSlowUpdate(button)
        HealBot_BuffThrottleUpdateButton(button)
    end
    return bRetAlpha, bNextAuraUpdate
end

local bAlphaNextUpdate, bDurNextUpdate, bIconAlpha=0,0,0
function HealBot_Aura_DoUpdateBuffIcon(button, iconData, index, timer, lastSpellId, srcTimer)
      --HealBot_setCall("HealBot_Aura_DoUpdateBuffIcon", button, nil, nil, true)
    if iconData.current and lastSpellId == iconData.spellId then
        bAlphaNextUpdate=999
        bDurNextUpdate=999
        bSecsLeft=floor((iconData.expirationTime-HealBot_TimeNow)-0.5)
        if iconData.expirationTime>0 then
            bIconAlpha, bAlphaNextUpdate=HealBot_Aura_BuffIconAlphaValue(button, iconData, bSecsLeft)
        elseif hbv_Skins_GetIconBoolean("BUFFI15EN", button.frame, iconData.iconSet) then
            bIconAlpha=HealBot_Action_BarColourAlpha(button, hbv_Skins_GetFrameVar("BarCol", "HA", button.framecol), 1)
        else
            bIconAlpha=button.status.alpha
        end
        button.gref.icon[index]:SetAlpha(bIconAlpha)
        if bIconAlpha<button.status.alpha then
            bIconAlpha=button.status.alpha
        end
        if bSecsLeft>-2 and hbv_Skins_GetIconTextBoolean("BUFFSDUR", button.frame, iconData.iconSet)
                        and (not hbv_Skins_GetIconTextBoolean("BUFFSSDUR", button.frame, iconData.iconSet) or UnitIsUnit(iconData.unitCaster,"player")) then
            if bSecsLeft<=hbv_Skins_GetIconTextVar("BUFFDURTHRH", button.frame, iconData.iconSet) then
                if bSecsLeft<=hbv_Skins_GetIconTextVar("BUFFDURWARN", button.frame, iconData.iconSet) then
                    if UnitIsFriend("player",button.unit) then
                        button.gref.txt.expire[index]:SetTextColor(1,0.5,0,bIconAlpha)
                    else
                        button.gref.txt.expire[index]:SetTextColor(1,0,0,bIconAlpha);
                    end
                    if bSecsLeft>-1 then
                        button.gref.txt.expire[index]:SetText(bSecsLeft);
                    else
                        button.gref.txt.expire[index]:SetText("0")
                    end
                else
                    button.gref.txt.expire[index]:SetTextColor(1,1,1,bIconAlpha);
                    button.gref.txt.expire[index]:SetText(bSecsLeft)
                end
                bDurNextUpdate=HealBot_Aura_luVars["AuraUpdate"]
            else
                button.gref.txt.expire[index]:SetTextColor(1,1,1,0)
                button.gref.txt.expire[index]:SetText(" ");
                bDurNextUpdate=bSecsLeft-hbv_Skins_GetIconTextVar("BUFFDURTHRH", button.frame, iconData.iconSet)
                --if (iconData.expirationTime-HealBot_TimeNow-1)>hbv_Skins_GetIconTextVar("BUFFDURTHRH", button.frame, iconData.iconSet) then
                --    bDurNextUpdate=(iconData.expirationTime-HealBot_TimeNow-1)-hbv_Skins_GetIconTextVar("BUFFDURTHRH", button.frame, iconData.iconSet)
                --else
                --    bDurNextUpdate=HealBot_Aura_luVars["AuraUpdate"]
                --end
            end
        else
            button.gref.txt.expire[index]:SetTextColor(1,1,1,0)
            button.gref.txt.expire[index]:SetText(" ");
        end
        if hbTextureUpdateTime[button.id][lastSpellId] then
            if hbTextureUpdateTime[button.id][lastSpellId]<HealBot_TimeNow then
                hbTextureUpdateTime[button.id][lastSpellId]=nil
                button.gref.icon[index]:SetTexture(HealBot_WoWAPI_SpellTexture(iconData.spellId))
            elseif (bDurNextUpdate+1)>hbTextureUpdateTime[button.id][lastSpellId]-HealBot_TimeNow then
                bDurNextUpdate=hbTextureUpdateTime[button.id][lastSpellId]-HealBot_TimeNow
            end
        end
        if not srcTimer then
            if hbv_Skins_GetFrameBoolean("IconText", "SELFIND", button.frame) and UnitIsUnit(iconData.unitCaster,"player") then
                button.gref.indicator.selfcast[index]:SetAlpha(HealBot_Action_BarColourAlpha(button, 1, 1))
            else
                button.gref.indicator.selfcast[index]:SetAlpha(0)
            end
            if iconData.count > 1 and hbv_Skins_GetIconTextBoolean("BUFFSCNT", button.frame, iconData.iconSet)
                                  and (not hbv_Skins_GetIconTextBoolean("BUFFSSCNT", button.frame, iconData.iconSet) or UnitIsUnit(iconData.unitCaster,"player")) then
                button.gref.txt.count[index]:SetText(iconData.count);
                button.gref.txt.count[index]:SetTextColor(1,1,1,bIconAlpha);
            else
                button.gref.txt.count[index]:SetTextColor(1,1,1,0)
                button.gref.txt.count[index]:SetText(" ");
            end
        end
        if timer then
            if bAlphaNextUpdate<bDurNextUpdate then
                C_Timer.After(bAlphaNextUpdate, function() HealBot_Aura_DoUpdateBuffIcon(button, iconData, index, true, lastSpellId, true) end)
            elseif bDurNextUpdate<999 then
                C_Timer.After(bDurNextUpdate, function() HealBot_Aura_DoUpdateBuffIcon(button, iconData, index, true, lastSpellId, true) end)
            end
        end
    end
end

local customBuffPriority=hbv_GetStatic("cBuff")
function HealBot_Aura_UpdateBuffIcon(button, iconData, index, timer, spellId)
      --HealBot_setCall("HealBot_Aura_UpdateBuffIcon", button, nil, nil, true)
    HealBot_Aura_DoUpdateBuffIcon(button, iconData, index, timer, spellId, false)
    if HealBot_AuraBuffCache[spellId] then
        hbGlowSpellName=HealBot_AuraBuffCache[spellId]["name"] or "x"
        hbGlowIdx=HealBot_BuffIconGlow[spellId] or HealBot_BuffIconGlow[hbGlowSpellName] or 1
    else
        hbGlowIdx=1
    end
    if hbGlowIdx>1 then
        if HealBot_Globals.CustomBuffBarColour[spellId] then
            HealBot_Action_EnableIconGlow(button, 
                                          HealBot_Globals.CustomBuffBarColour[spellId].R or 0.25, 
                                          HealBot_Globals.CustomBuffBarColour[spellId].G or 0.58, 
                                          HealBot_Globals.CustomBuffBarColour[spellId].B or 0.8, 
                                          "ICONBUFF", 
                                          hbGlowIdx, 
                                          index,
                                          bIconAlpha)
        elseif HealBot_Globals.CustomBuffBarColour[hbGlowSpellName] then
            HealBot_Action_EnableIconGlow(button, 
                                          HealBot_Globals.CustomBuffBarColour[hbGlowSpellName].R or 0.25, 
                                          HealBot_Globals.CustomBuffBarColour[hbGlowSpellName].G or 0.58, 
                                          HealBot_Globals.CustomBuffBarColour[hbGlowSpellName].B or 0.8, 
                                          "ICONBUFF", 
                                          hbGlowIdx, 
                                          index,
                                          bIconAlpha)
        elseif HealBot_Globals.CustomBuffBarColour[HEALBOT_CUSTOM_CAT_CUSTOM_AUTOBUFFS] then
            HealBot_Action_EnableIconGlow(button, 
                                          HealBot_Globals.CustomBuffBarColour[HEALBOT_CUSTOM_CAT_CUSTOM_AUTOBUFFS].R or 0.25, 
                                          HealBot_Globals.CustomBuffBarColour[HEALBOT_CUSTOM_CAT_CUSTOM_AUTOBUFFS].G or 0.58, 
                                          HealBot_Globals.CustomBuffBarColour[HEALBOT_CUSTOM_CAT_CUSTOM_AUTOBUFFS].B or 0.8, 
                                          "ICONBUFF", 
                                          hbGlowIdx, 
                                          index,
                                          bIconAlpha)
        else
            HealBot_Action_EnableIconGlow(button, 
                                          HealBot_Globals.CustomBuffBarColour[customBuffPriority].R or 0.25, 
                                          HealBot_Globals.CustomBuffBarColour[customBuffPriority].G or 0.58, 
                                          HealBot_Globals.CustomBuffBarColour[customBuffPriority].B or 0.8, 
                                          "ICONBUFF", 
                                          hbGlowIdx, 
                                          index,
                                          bIconAlpha)
        end
    elseif button.glow.icon[index]>1 then
        HealBot_Action_DisableIconGlow(button, "ICONBUFF", index)
    end
end

function HealBot_Aura_AddExtraIcon(button, index)
    --HealBot_setCall("HealBot_Aura_AddExtraIcon", button)
    button.gref.icon[index]:SetTexture(HealBot_UnitExtraIcons[button.id][index]["texture"])
    --if index == 94 then HealBot_Action_SetDirectionArrow(button) end
    HealBot_Aura_UpdateExtraIcon(button, HealBot_UnitExtraIcons[button.id][index], index)
end

function HealBot_Aura_AddBuffIcon(button, index)
      --HealBot_setCall("HealBot_Aura_AddBuffIcon", button, nil, nil, true)
    button.gref.iconf[index]:SetFrameLevel(200)
    button.gref.icon[index]:SetTexture(HealBot_UnitBuffIcons[button.id][index]["icon"])
    HealBot_Aura_UpdateBuffIcon(button, HealBot_UnitBuffIcons[button.id][index], index, true, HealBot_UnitBuffIcons[button.id][index]["spellId"])
end

function HealBot_Aura_DebuffAddIcon(button, index)
      --HealBot_setCall("HealBot_Aura_DebuffAddIcon", button, nil, nil, true)
    button.gref.iconf[index]:SetFrameLevel(200)
    button.gref.icon[index]:SetTexture(HealBot_UnitDebuffIcons[button.id][index]["icon"])
    HealBot_Aura_UpdateDebuffIcon(button, HealBot_UnitDebuffIcons[button.id][index], index, true, HealBot_UnitDebuffIcons[button.id][index]["spellId"])
end

local hbAuraWatchRaidTarget={}
function HealBot_Aura_AuraWatchRaidTarget(guid, state)
        --HealBot_setCall("HealBot_Aura_AuraWatchRaidTarget", nil, guid)
    if state then
        hbAuraWatchRaidTarget[guid]=true
    else
        hbAuraWatchRaidTarget[guid]=nil
    end
end

function HealBot_Aura_AuraWatchRaidTargetClear()
        --HealBot_setCall("HealBot_Aura_AuraWatchRaidTargetClear")
    hbAuraWatchRaidTarget={}
end

local rtuPrevId=false
function HealBot_Aura_RaidTargetUpdate(button, iconID)
        --HealBot_setCall("HealBot_Aura_RaidTargetUpdate", button)
    rtuPrevId=button.icon.extra.targeticon
    button.icon.extra.targeticon=iconID
    if button.icon.extra.targeticon~=rtuPrevId and HealBot_UnitExtraIcons[button.id] then
        if not HealBot_Media_retTargetIcon(button.icon.extra.targeticon) then
            HealBot_Aura_RemoveIcon(button, 92)
        elseif not HealBot_UnitExtraIcons[button.id][92].current or
           HealBot_UnitExtraIcons[button.id][92]["texture"]~=HealBot_Media_retTargetIcon(button.icon.extra.targeticon) then
            HealBot_UnitExtraIcons[button.id][92]["texture"]=HealBot_Media_retTargetIcon(button.icon.extra.targeticon)
            HealBot_UnitExtraIcons[button.id][92].current=true
            HealBot_Aura_AddExtraIcon(button, 92)
        end
        if hbAuraWatchRaidTarget[button.guid] then
            HealBot_Plugin_AuraWatch_RaidTargetUpdate(button)
        end
    end
end

local cuPrevTexture=false
function HealBot_Aura_ClassUpdate(button, ClassRole)
        --HealBot_setCall("HealBot_Aura_ClassUpdate", button)
    cuPrevTexture=button.icon.extra.classtexture
    button.icon.extra.classtexture=HealBot_Media_retClassRoleIcon(ClassRole)
    if button.icon.extra.classtexture~=cuPrevTexture and HealBot_UnitExtraIcons[button.id] then
        if not button.icon.extra.classtexture then 
            HealBot_Aura_RemoveIcon(button, 91)
        elseif not HealBot_UnitExtraIcons[button.id][91].current or
           HealBot_UnitExtraIcons[button.id][91]["texture"]~=button.icon.extra.classtexture then
            HealBot_UnitExtraIcons[button.id][91]["texture"]=button.icon.extra.classtexture
            HealBot_UnitExtraIcons[button.id][91].current=true
            HealBot_Aura_AddExtraIcon(button, 91)
        end
    end
end

function HealBot_Aura_UpdateRank(button)
        --HealBot_setCall("HealBot_Aura_UpdateRank", button)
    if HealBot_UnitExtraIcons[button.id] then
        if button.rank>0 and hbv_Skins_GetFrameBoolean("Icons", "SHOWRANK", button.frame) then
            HealBot_UnitExtraIcons[button.id][95]["texture"]=HealBot_Media_retRankIcon(button.rank)
            HealBot_UnitExtraIcons[button.id][95].current=true
            HealBot_Aura_AddExtraIcon(button, 95)
        elseif HealBot_Panel_IsTank(button.guid) and hbv_Skins_GetFrameBoolean("Icons", "SHOWRANKMT", button.frame) then 
            HealBot_UnitExtraIcons[button.id][95]["texture"]=HealBot_Media_retRankIcon(5)
            HealBot_UnitExtraIcons[button.id][95].current=true
            HealBot_Aura_AddExtraIcon(button, 95)
        else
            HealBot_Aura_RemoveIcon(button, 95)
        end
    end
end

function HealBot_Aura_UpdateCombat(button)
        --HealBot_setCall("HealBot_Aura_UpdateCombat", button)
    if HealBot_UnitExtraIcons[button.id] then
        if button.icon.extra.hostile or button.status.incombat then
            if button.icon.extra.hostile then
                HealBot_UnitExtraIcons[button.id][96]["texture"]="Interface\\Addons\\HealBot\\Images\\combat\\1\\hostile.tga"
            else
                HealBot_UnitExtraIcons[button.id][96]["texture"]="Interface\\Addons\\HealBot\\Images\\combat\\1\\incombat.tga"
            end
            HealBot_UnitExtraIcons[button.id][96].current=true
            HealBot_Aura_AddExtraIcon(button, 96)
        else
            HealBot_Aura_RemoveIcon(button, 96)
        end
    end
end

function HealBot_Aura_UpdateState(button)
        --HealBot_setCall("HealBot_Aura_UpdateState", button)
    if HealBot_UnitExtraIcons[button.id] then
        if button.icon.extra.readycheck or button.status.afk then
            if button.status.afk then
                HealBot_UnitExtraIcons[button.id][93]["texture"]="Interface\\Addons\\HealBot\\Images\\state\\1\\afk.tga"
            else
                if button.icon.extra.readycheck == hbv_GetStatic("rcWAITING") then
                    HealBot_UnitExtraIcons[button.id][93]["texture"]="Interface\\RAIDFRAME\\ReadyCheck-Waiting"
                elseif button.icon.extra.readycheck == hbv_GetStatic("rcNOTREADY") then
                    HealBot_UnitExtraIcons[button.id][93]["texture"]="Interface\\RAIDFRAME\\ReadyCheck-NotReady"
                else
                    HealBot_UnitExtraIcons[button.id][93]["texture"]="Interface\\RAIDFRAME\\ReadyCheck-Ready"
                end
                if HealBot_Panel_RaidUnitButtonCheck(button.guid) then HealBot_Action_SetGuidData(button, "READYCHECK", button.icon.extra.readycheck) end
            end
            HealBot_UnitExtraIcons[button.id][93].current=true
            HealBot_Aura_AddExtraIcon(button, 93)
        elseif button.player and hbv_Skins_GetFrameBoolean("Icons", "SHOWRESTING", button.frame) and IsResting() then 
            HealBot_UnitExtraIcons[button.id][93]["texture"]="Interface\\Addons\\HealBot\\Images\\state\\1\\rested.tga"
            HealBot_UnitExtraIcons[button.id][93].current=true
            HealBot_Aura_AddExtraIcon(button, 93)
        else
            HealBot_Aura_RemoveIcon(button, 93)
        end
    end
end

function HealBot_Aura_OORUpdate(button, texture)
        --HealBot_setCall("HealBot_Aura_OORUpdate", button)
    button.icon.extra.oorarrow=texture
    if HealBot_UnitExtraIcons[button.id] then
        if not button.icon.extra.oorarrow then 
            HealBot_Aura_RemoveIcon(button, 94)
        else
            HealBot_UnitExtraIcons[button.id][94]["texture"]=button.icon.extra.oorarrow
            HealBot_UnitExtraIcons[button.id][94].current=true
            HealBot_Action_SetDirectionArrow(button, 94)
            HealBot_Aura_AddExtraIcon(button, 94)
        end
    end
end

function HealBot_Aura_InitUnitBuffIcons(buttonId)
      --HealBot_setCall("HealBot_Aura_InitUnitBuffIcons")
    HealBot_UnitBuffIcons[buttonId]={}
    uaBuffData[buttonId]={}
    for i=1,12 do
        HealBot_UnitBuffIcons[buttonId][i]={}
        HealBot_UnitBuffIcons[buttonId][i]["count"]=0
        HealBot_UnitBuffIcons[buttonId][i]["expirationTime"]=0
        HealBot_UnitBuffIcons[buttonId][i]["duration"]=0
        HealBot_UnitBuffIcons[buttonId][i]["spellId"]=0
        HealBot_UnitBuffIcons[buttonId][i]["debuffType"]=""
        HealBot_UnitBuffIcons[buttonId][i]["unitCaster"]="x"
        HealBot_UnitBuffIcons[buttonId][i]["iconSet"]=1
        HealBot_UnitBuffIcons[buttonId][i]["icon"]=""
        HealBot_UnitBuffIcons[buttonId][i]["gSlot"]=0
        HealBot_UnitBuffIcons[buttonId][i].current=false
    end
    for i=1,20 do
        uaBuffData[buttonId][i]={}
        uaBuffData[buttonId][i].name=""
        uaBuffData[buttonId][i].icon=""
        uaBuffData[buttonId][i].count=0
        uaBuffData[buttonId][i].debuffType=""
        uaBuffData[buttonId][i].duration=0
        uaBuffData[buttonId][i].expirationTime=0
        uaBuffData[buttonId][i].sourceUnit="x"
        uaBuffData[buttonId][i].sourceUnitIsPlayer=false
        uaBuffData[buttonId][i].spellId=0
        uaBuffData[buttonId][i].gSlot=0
    end
    uaBuffData[buttonId].lastslot=0
end

function HealBot_Aura_InitUnitDebuffIcons(buttonId)
      --HealBot_setCall("HealBot_Aura_InitUnitDebuffIcons")
    HealBot_UnitDebuffIcons[buttonId]={}
    uaDebuffData[buttonId]={}
    for i=51,60 do
        HealBot_UnitDebuffIcons[buttonId][i]={}
        HealBot_UnitDebuffIcons[buttonId][i]["count"]=0
        HealBot_UnitDebuffIcons[buttonId][i]["expirationTime"]=0
        HealBot_UnitDebuffIcons[buttonId][i]["duration"]=0
        HealBot_UnitDebuffIcons[buttonId][i]["spellId"]=0
        HealBot_UnitDebuffIcons[buttonId][i]["debuffType"]=""
        HealBot_UnitDebuffIcons[buttonId][i]["unitCaster"]="x"
        HealBot_UnitDebuffIcons[buttonId][i]["iconSet"]=1
        HealBot_UnitDebuffIcons[buttonId][i]["icon"]=""
        HealBot_UnitDebuffIcons[buttonId][i]["gSlot"]=0
        HealBot_UnitDebuffIcons[buttonId][i].current=false
    end
    for i=1,20 do
        uaDebuffData[buttonId][i]={}
        uaDebuffData[buttonId][i].name=""
        uaDebuffData[buttonId][i].icon=""
        uaDebuffData[buttonId][i].count=0
        uaDebuffData[buttonId][i].debuffType=""
        uaDebuffData[buttonId][i].duration=0
        uaDebuffData[buttonId][i].expirationTime=0
        uaDebuffData[buttonId][i].sourceUnit="x"
        uaDebuffData[buttonId][i].sourceUnitIsPlayer=false
        uaDebuffData[buttonId][i].spellId=0
        uaDebuffData[buttonId][i].gSlot=0
        uaDebuffData[buttonId][i].isBossAura=false
    end
    uaDebuffData[buttonId].lastslot=0
end

function HealBot_Aura_InitUnitExtraIcons(buttonId)
      --HealBot_setCall("HealBot_Aura_InitUnitExtraIcons")
    HealBot_UnitExtraIcons[buttonId]={}
    for i=91,96 do
        HealBot_UnitExtraIcons[buttonId][i]={}
        HealBot_UnitExtraIcons[buttonId][i]["texture"]=""
        HealBot_UnitExtraIcons[buttonId][i].current=false
    end
end

local hbClassicAbsorbsTrack={}
local hbClassicAbsorbsAmount={}
function HealBot_Aura_setButtonIcons(buttonId)
      --HealBot_setCall("HealBot_Aura_setButtonIcons")
    HealBot_Aura_InitUnitDebuffIcons(buttonId) 
    HealBot_Aura_InitUnitBuffIcons(buttonId) 
    HealBot_Aura_InitUnitExtraIcons(buttonId)
    hbClassicAbsorbsTrack[buttonId]={}
    hbClassicAbsorbsAmount[buttonId]={}
    hbTextureUpdateId[buttonId]={}
    hbTextureUpdateTime[buttonId]={}
end

function HealBot_Aura_setUnitIcons(unit)
      --HealBot_setCall("HealBot_Aura_setUnitIcons", nil, nil, unit)
    if not HealBot_Aura_WarningFilter[unit] then
        HealBot_Aura_WarningFilter[unit]={}
    end
end

function HealBot_Aura_AutoUpdateCustomDebuff(button, name, spellId)
      --HealBot_setCall("HealBot_Aura_AutoUpdateCustomDebuff", button)
    for dID, x in pairs(HealBot_Globals.CustomDebuffs) do
        if not HealBot_WoWAPI_SpellName(dID) and dID == name then
            HealBot_Globals.Custom_Debuff_Categories[spellId]=HealBot_Globals.Custom_Debuff_Categories[name]
            HealBot_Globals.CustomDebuffs[spellId]=x
            if HealBot_Globals.FilterCustomDebuff[name] then 
                HealBot_Globals.FilterCustomDebuff[spellId]=HealBot_Globals.FilterCustomDebuff[name]
            end
            if HealBot_Globals.CustomDebuffsShowBarCol[name] then
                HealBot_Globals.CustomDebuffsShowBarCol[spellId]=HealBot_Globals.CustomDebuffsShowBarCol[name]
            end
            if HealBot_Globals.CDCBarColour[name] then
                HealBot_Globals.CDCBarColour[spellId]=HealBot_Options_copyTable(HealBot_Globals.CDCBarColour[name])
            end
            if HealBot_Globals.IgnoreCustomDebuff[name] then
                HealBot_Globals.IgnoreCustomDebuff[spellId]=HealBot_Options_copyTable(HealBot_Globals.IgnoreCustomDebuff[name])
            end
            if HealBot_Globals.CustomDebuffsIconSet[name] then
                HealBot_Globals.CustomDebuffsIconSet[spellId]=HealBot_Globals.CustomDebuffsIconSet[name]
            end
            if HealBot_Globals.CustomDebuffsIconGlow[name] then
                HealBot_Globals.CustomDebuffsIconGlow[spellId]=HealBot_Globals.CustomDebuffsIconGlow[name]
            end
            HealBot_Options_DeleteCDebuff(name, name)
            break
        end
    end
    HealBot_Timers_Set("AURA","CustomDebuffListPrep")
end

function HealBot_Aura_CacheDebuffIcon(button, id, spellId, slot)
      --HealBot_setCall("HealBot_Aura_CacheDebuffIcon", button)
    if HealBot_UnitDebuffIcons[button.id][id]["spellId"]~=spellId or
       HealBot_UnitDebuffIcons[button.id][id]["count"]~=uaDebuffData[button.id][slot].count or
       HealBot_UnitDebuffIcons[button.id][id]["expirationTime"]~=uaDebuffData[button.id][slot].expirationTime or
       HealBot_UnitDebuffIcons[button.id][id]["unitCaster"]~=uaDebuffData[button.id][slot].sourceUnit then
        HealBot_UnitDebuffIcons[button.id][id]["count"]=uaDebuffData[button.id][slot].count
        HealBot_UnitDebuffIcons[button.id][id]["duration"]=uaDebuffData[button.id][slot].duration
        HealBot_UnitDebuffIcons[button.id][id]["iconSet"]=HealBot_Aura_IconSet[spellId]
        HealBot_UnitDebuffIcons[button.id][id]["icon"]=uaDebuffData[button.id][slot].icon
        HealBot_UnitDebuffIcons[button.id][id]["gSlot"]=uaDebuffData[button.id][slot].gSlot
        HealBot_UnitDebuffIcons[button.id][id]["debuffType"]=uaDebuffData[button.id][slot].debuffType
        HealBot_UnitDebuffIcons[button.id][id]["unitCaster"]=uaDebuffData[button.id][slot].sourceUnit
        if HealBot_UnitDebuffIcons[button.id][id].current then
            if HealBot_UnitDebuffIcons[button.id][id]["spellId"]~=spellId then
                HealBot_UnitDebuffIcons[button.id][id]["spellId"]=spellId
                HealBot_UnitDebuffIcons[button.id][id]["expirationTime"]=uaDebuffData[button.id][slot].expirationTime
                button.gref.icon[id]:SetTexture(HealBot_UnitDebuffIcons[button.id][id]["icon"])
                HealBot_Aura_UpdateDebuffIcon(button, HealBot_UnitDebuffIcons[button.id][id], id, true, spellId)
            else
                if HealBot_UnitDebuffIcons[button.id][id]["expirationTime"]~=uaDebuffData[button.id][slot].expirationTime then
                    HealBot_UnitDebuffIcons[button.id][id]["expirationTime"]=uaDebuffData[button.id][slot].expirationTime
                    button.gref.icon[id]:SetTexture(HealBot_UnitDebuffIcons[button.id][id]["icon"])
                end
                HealBot_Aura_UpdateDebuffIcon(button, HealBot_UnitDebuffIcons[button.id][id], id, false, spellId)
            end
        else
            HealBot_UnitDebuffIcons[button.id][id]["spellId"]=spellId
            HealBot_UnitDebuffIcons[button.id][id]["expirationTime"]=uaDebuffData[button.id][slot].expirationTime
        end
    end
end

local hbCustomDebuffsCastBy={}
local hbCustomDebuffsDisabled={}

local debuffIconIdx,debuffIconPrio=0,0
local function HealBot_Aura_SortDebuffIconSet(button, iconSet, sIndex)
      --HealBot_setCall("HealBot_Aura_SortDebuffIconSet", button)
    button.icon.debuff.count[iconSet]=#debuffSort[iconSet]
    if button.icon.debuff.count[iconSet]>0 then
        table.sort(debuffSort[iconSet])
        if button.icon.debuff.count[iconSet]>hbv_Skins_GetIconVar("MAXDICONS", button.frame, iconSet) then
            button.icon.debuff.count[iconSet]=hbv_Skins_GetIconVar("MAXDICONS", button.frame, iconSet)
        end
        for j=1, button.icon.debuff.count[iconSet], 1 do
            HealBot_Aura_CacheDebuffIcon(button, sIndex+j, HealBot_AuraDebuffXRef[debuffSort[iconSet][j]]["spellID"], HealBot_AuraDebuffXRef[debuffSort[iconSet][j]]["slot"])
        end
        if HealBot_AuraDebuffCache[HealBot_AuraDebuffXRef[debuffSort[iconSet][1]]["spellID"]]["priority"]<debuffIconPrio then
            debuffIconIdx=sIndex+1
            debuffIconPrio=HealBot_AuraDebuffCache[HealBot_AuraDebuffXRef[debuffSort[iconSet][1]]["spellID"]]["priority"]
        end
    end
end

function HealBot_Aura_SortDebuffIcons(button)
      --HealBot_setCall("HealBot_Aura_SortDebuffIcons", button)
    debuffIconIdx,debuffIconPrio=0,21
    if hbv_Skins_GetIconVar("MAXDICONS", button.frame, 1)>0 then
        HealBot_Aura_SortDebuffIconSet(button, 1, 50)
    end
    if hbv_Skins_GetIconVar("MAXDICONS", button.frame, 2)>0 then
        HealBot_Aura_SortDebuffIconSet(button, 2, 56)
    end
    if hbv_Skins_GetIconVar("MAXDICONS", button.frame, 3)>0 then
        HealBot_Aura_SortDebuffIconSet(button, 3, 58)
    end
    return debuffIconIdx
end

function HealBot_Aura_CacheBuffIcon(button, id, spellId, slot)
      --HealBot_setCall("HealBot_Aura_CacheBuffIcon", button)
    if HealBot_UnitBuffIcons[button.id][id]["spellId"]~=spellId or
       HealBot_UnitBuffIcons[button.id][id]["count"]~=uaBuffData[button.id][slot].count or
       HealBot_UnitBuffIcons[button.id][id]["expirationTime"]~=uaBuffData[button.id][slot].expirationTime or
       HealBot_UnitBuffIcons[button.id][id]["unitCaster"]~=uaBuffData[button.id][slot].sourceUnit then
        HealBot_UnitBuffIcons[button.id][id]["count"]=uaBuffData[button.id][slot].count
        HealBot_UnitBuffIcons[button.id][id]["gSlot"]=uaBuffData[button.id][slot].gSlot
        HealBot_UnitBuffIcons[button.id][id]["duration"]=uaBuffData[button.id][slot].duration
        HealBot_UnitBuffIcons[button.id][id]["iconSet"]=HealBot_Aura_IconSet[spellId]
        HealBot_UnitBuffIcons[button.id][id]["icon"]=uaBuffData[button.id][slot].icon
        HealBot_UnitBuffIcons[button.id][id]["debuffType"]=uaBuffData[button.id][slot].debuffType
        HealBot_UnitBuffIcons[button.id][id]["unitCaster"]=uaBuffData[button.id][slot].sourceUnit
        if HealBot_UnitBuffIcons[button.id][id].current then
            if HealBot_UnitBuffIcons[button.id][id]["spellId"]~=spellId then
                HealBot_UnitBuffIcons[button.id][id]["spellId"]=spellId
                HealBot_UnitBuffIcons[button.id][id]["expirationTime"]=uaBuffData[button.id][slot].expirationTime
                button.gref.icon[id]:SetTexture(HealBot_UnitBuffIcons[button.id][id]["icon"])
                HealBot_Aura_UpdateBuffIcon(button, HealBot_UnitBuffIcons[button.id][id], id, true, spellId)
            else
                if HealBot_UnitBuffIcons[button.id][id]["expirationTime"]~=uaBuffData[button.id][slot].expirationTime then
                    HealBot_UnitBuffIcons[button.id][id]["expirationTime"]=uaBuffData[button.id][slot].expirationTime
                    button.gref.icon[id]:SetTexture(HealBot_UnitBuffIcons[button.id][id]["icon"])
                end
                HealBot_Aura_UpdateBuffIcon(button, HealBot_UnitBuffIcons[button.id][id], id, false, spellId)
            end
        else
            HealBot_UnitBuffIcons[button.id][id]["spellId"]=spellId
            HealBot_UnitBuffIcons[button.id][id]["expirationTime"]=uaBuffData[button.id][slot].expirationTime
        end
    end
end

function HealBot_Aura_Counts(button)
      --HealBot_setCall("HealBot_Aura_Counts", button)
    HealBot_AddDebug("button count="..button.icon.debuff.count[1].."  Aura Count="..HealBot_Aura_prevIconCount["DEBUFF"][1],"DebuffSet",true)
end

function HealBot_Aura_CheckUnitDebuffIcons(button)
      --HealBot_setCall("HealBot_Aura_CheckUnitDebuffIcons", button)
    for i=51,56 do
        if i<=(50+button.icon.debuff.count[1]) then
            if not HealBot_UnitDebuffIcons[button.id][i].current then
                HealBot_UnitDebuffIcons[button.id][i].current=true
                HealBot_Aura_DebuffAddIcon(button, i)
            end
        elseif i<=(50+HealBot_Aura_prevIconCount["DEBUFF"][1]) then
            HealBot_Aura_RemoveIcon(button, i)
        else
            break
        end
    end
    for i=57,58 do
        if i<=(56+button.icon.debuff.count[2]) then
            --if not HealBot_UnitDebuffIcons[button.id][i].current then
                HealBot_UnitDebuffIcons[button.id][i].current=true
                HealBot_Aura_DebuffAddIcon(button, i)
            --end
        elseif i<=(56+HealBot_Aura_prevIconCount["DEBUFF"][2]) then
            HealBot_Aura_RemoveIcon(button, i)
        else
            break
        end
    end
    for i=59,60 do
        if i<=(58+button.icon.debuff.count[3]) then
            if not HealBot_UnitDebuffIcons[button.id][i].current then
                HealBot_UnitDebuffIcons[button.id][i].current=true
                HealBot_Aura_DebuffAddIcon(button, i)
            end
        elseif i<=(58+HealBot_Aura_prevIconCount["DEBUFF"][3]) then
            HealBot_Aura_RemoveIcon(button, i)
        else
            break
        end
    end
end

local hasBuffTypes, ownBlessing=false, false
function HealBot_Aura_HasBuffTypes(spellName, pBuffTypes)
      --HealBot_setCall("HealBot_Aura_HasBuffTypes")
    hasBuffTypes=false
    if HealBot_BuffNameTypes[spellName] then
        if pBuffTypes[HealBot_BuffNameTypes[spellName]] or (ownBlessing and HealBot_BuffNameTypes[spellName]<7 and HealBot_Config_Buffs.PalaBlessingsAsOne) then
            hasBuffTypes=true
        end
    end
    return hasBuffTypes
end

local curBuffName=false
local curBuffxTime={}
local buffCheckThis, buffWatchTarget, buffSpellStart, buffSpellDur=false,false,0,0
local weaponEnchantState={[1]={["Active"]=false,["Expire"]=0},[2]={["Active"]=false,["Expire"]=0}}
function HealBot_Aura_SetGeneralBuff(button, bName)
      --HealBot_setCall("HealBot_Aura_SetGeneralBuff", button)
    curBuffName=bName
    if button.aura.buff.missingbuff~=bName then
        button.aura.buff.missingbuff=bName
        if HealBot_Text_TagInUse(button.framecol, "BUFF") then
            HealBot_Text_setNameTag(button)
        end
    end
    button.aura.buff.colbar=(HealBot_Globals.CustomBuffsShowBarCol["DEFAULT"] or 4)-1
    if HealBot_Aura_ID[bName] and HealBot_AuraBuffCache[uaBuffData[button.id][uaBuffSlot].spellId] then
        if not button.aura.buff.temp.active or button.aura.buff.temp.priority>HealBot_AuraBuffCache[uaBuffData[button.id][uaBuffSlot].spellId]["priority"] then
            button.aura.buff.temp.active=true
            button.aura.buff.temp.id=HealBot_Aura_ID[bName]
            button.aura.buff.temp.name=bName
            button.aura.buff.temp.priority=HealBot_AuraBuffCache[HealBot_Aura_ID[bName]]["priority"]
        end
    end
    --button.aura.buff.priority=21
end

function HealBot_Aura_CheckForMana(button)
    if generalBuffs and HealBot_BuffWatch[HealBot_Config_Buffs.ManaDrinkItem] and not button.aura.buff.update then
        if button.aura.buff.missingbuff ~= HealBot_Aura_luVars["ManaDrink"] then
            if button.mana.pct<HealBot_Config_Buffs.ManaDrinkThreshold then
                button.aura.buff.update=true
            end
        elseif button.mana.pct>=HealBot_Config_Buffs.ManaDrinkThreshold then
            button.aura.buff.update=true
        end
    end
end

local HealBot_Aura_GetItemCooldown=GetItemCooldown
if C_Container then
    HealBot_Aura_GetItemCooldown=C_Container.GetItemCooldown or GetItemCooldown
end

local buffWatchName=""
local PlayerBuffsList={}
function HealBot_Aura_CheckGeneralBuff(button)
      --HealBot_setCall("HealBot_Aura_CheckGeneralBuff", button)
    PlayerBuffsList=button.aura.buff.recheck
    for bName,nexttime in pairs (PlayerBuffsList) do
        if not PlayerBuffs[bName] then
            PlayerBuffsList[bName]=nil
            HealBot_Aura_MarkCheckBuffsTime(button)
        elseif nexttime < HealBot_TimeNow then
            PlayerBuffs[bName]=false
        end
    end
    for j=1, #HealBot_BuffWatchList do
        buffWatchName=HealBot_BuffWatchList[j]
        if HEALBOT_GAME_VERSION<4 and HealBot_BuffMinLevels[buffWatchName] then
            if button.level<HealBot_BuffMinLevels[buffWatchName] then
                PlayerBuffs[buffWatchName]=true
            end
        end
        if not PlayerBuffs[buffWatchName] and not HealBot_Aura_HasBuffTypes(buffWatchName, PlayerBuffTypes) then
            buffSpellStart, buffSpellDur=HealBot_WoWAPI_SpellCooldown(buffWatchName)
            if HealBot_Buff_ItemIDs[buffWatchName] and (not buffSpellStart or not buffSpellDur) then
                buffSpellStart, buffSpellDur=HealBot_Aura_GetItemCooldown(HealBot_Buff_ItemIDs[buffWatchName])
            end
            buffSpellStart=buffSpellStart or 0
            buffSpellDur=buffSpellDur or 0
            if (buffSpellStart+buffSpellDur)-HealBot_TimeNow<2 then
                buffCheckThis=false;
                buffWatchTarget=HealBot_Options_retBuffWatchTarget(buffWatchName) or "";
                if buffWatchTarget["Raid"] then
                    buffCheckThis=true;
                elseif buffWatchTarget["Self"] and button.player then
                    if HealBot_Aura_luVars["ManaDrink"]~=buffWatchName or button.mana.pct<HealBot_Config_Buffs.ManaDrinkThreshold then
                        buffCheckThis=true
                    end
                elseif buffWatchTarget["Party"] and button.group == HealBot_Data["PLAYERGROUP"] then 
                    buffCheckThis=true
                elseif buffWatchTarget["Solo"] and not IsInRaid() and not IsInGroup() then
                    buffCheckThis=true
                elseif buffWatchTarget["MainTanks"] and HealBot_Panel_IsTank(button.guid) then
                    buffCheckThis=true;
                elseif buffWatchTarget["SingleTank"] and button.guid == HealBot_Aura_luVars["TankGUID1"] then
                    buffCheckThis=true
                elseif buffWatchTarget[button.text.classtrim] then
                    buffCheckThis=true
                elseif buffWatchTarget["Name"] and button.guid == HealBot_Config.PrivFocus then
                    buffCheckThis=true
                elseif buffWatchTarget["Focus"] and UnitIsUnit(button.unit, "focus") then
                    buffCheckThis=true
                elseif buffWatchTarget["PvP"] and UnitIsPVP(button.unit) then
                    buffCheckThis=true
                elseif buffWatchTarget["PvE"] and not UnitIsPVP(button.unit) then
                    buffCheckThis=true
                elseif buffWatchTarget["MyTargets"] and HealBot_Panel_IsMyTarget(button.guid) then
                    buffCheckThis=true;
                end
                if buffCheckThis then
                    HealBot_Aura_SetGeneralBuff(button, buffWatchName)
                    break
                end
            else
                button.aura.buff.recheck[buffWatchName]=(HealBot_TimeNow-buffSpellStart)+buffSpellDur
                HealBot_Aura_MarkCheckBuffsTime(button)
            end
        end
    end
    if button.player and (HealBot_Weapon_Enchant[1] or HealBot_Weapon_Enchant[2]) and not button.aura.buff.missingbuff and (not HealBot_Config_Buffs.ExtraBuffsOnlyInInstance or IsInInstance()) then
        weaponEnchantState[1]["Active"], weaponEnchantState[1]["Expire"], _, _, weaponEnchantState[2]["Active"], weaponEnchantState[2]["Expire"]=GetWeaponEnchantInfo()
        -- local hasMainHandEnchant, mainHandExpiration, _, mainHandEnchantID, hasOffHandEnchant, offHandExpiration, _, offHandEnchantID=GetWeaponEnchantInfo()
        for x=1,2 do
            if HealBot_Weapon_Enchant[x] then
                if weaponEnchantState[x]["Active"] then
                    if not weaponEnchantState[x]["Expire"] then 
                        if HEALBOT_GAME_VERSION<4 then
                            weaponEnchantState[x]["Expire"]=30*60*1000
                        else
                            weaponEnchantState[x]["Expire"]=60*60*1000
                        end
                    end
                    if (weaponEnchantState[x]["Expire"]/1000)<HealBot_Config_Buffs.LongBuffTimer then
                        HealBot_Aura_SetGeneralBuff(button, HealBot_Weapon_Enchant[x])
                    else
                        button.aura.buff.recheck[HealBot_Weapon_Enchant[x]]=ceil(HealBot_TimeNow+(weaponEnchantState[x]["Expire"]/1000)-HealBot_Config_Buffs.LongBuffTimer)
                        if not button.aura.buff.nextcheck or button.aura.buff.nextcheck>button.aura.buff.recheck[HealBot_Weapon_Enchant[x]] then
                            HealBot_Aura_MarkCheckBuffsTime(button)
                        end
                    end
                else
                    weaponEnchantState[x]["Expire"]=nil
                    HealBot_Aura_SetGeneralBuff(button, HealBot_Weapon_Enchant[x])
                    button.aura.buff.recheck[HealBot_Weapon_Enchant[x]]=nil
                    HealBot_Aura_MarkCheckBuffsTime(button)
                end
            end
        end
    end
end

local hbCustomBuffsDisabled={}
function HealBot_Aura_setCustomBuffFilterDisabled()
      --HealBot_setCall("HealBot_Aura_setCustomBuffFilterDisabled")
    for id,_ in pairs(hbCustomBuffsDisabled) do
        hbCustomBuffsDisabled[id]=false
    end
    for id, _ in pairs(HealBot_Globals.IgnoreCustomBuff) do
        local name=HealBot_WoWAPI_SpellName(id)
        hbCustomBuffsDisabled[id]={}
        if (HealBot_Globals.CustomBuffIDMethod[id] or 2)>1 and name then
            hbCustomBuffsDisabled[name]={}
        end
        for instName, disabled in pairs(HealBot_Globals.IgnoreCustomBuff[id]) do
            if disabled then
                hbCustomBuffsDisabled[id][instName]=disabled
                if (HealBot_Globals.CustomBuffIDMethod[id] or 2)>1 and name then
                    hbCustomBuffsDisabled[name][instName]=disabled
                end
            end
        end
    end
    for id,_ in pairs(hbCustomBuffsDisabled) do
        if not hbCustomBuffsDisabled[id] then hbCustomBuffsDisabled[id]=nil end
    end
    HealBot_Timers_Set("AURA","DeleteExcludeBuffInCache")
end

local scbUnitClassEN, scbWatchHoT="XXXX", false
function HealBot_Aura_ShowCustomBuff(button)
      --HealBot_setCall("HealBot_Aura_ShowCustomBuff", button)
    if (hbCustomBuffsDisabled[uaBuffData[button.id][uaBuffSlot].spellId] and (hbCustomBuffsDisabled[uaBuffData[button.id][uaBuffSlot].spellId][HealBot_Aura_luVars["mapName"]] or hbCustomBuffsDisabled[uaBuffData[button.id][uaBuffSlot].spellId]["ALL"])) or
       (hbCustomBuffsDisabled[uaBuffData[button.id][uaBuffSlot].name] and (hbCustomBuffsDisabled[uaBuffData[button.id][uaBuffSlot].name][HealBot_Aura_luVars["mapName"]] or hbCustomBuffsDisabled[uaBuffData[button.id][uaBuffSlot].name]["ALL"])) then
       return false, false, true
    else
        scbWatchHoT=HealBot_Watch_HoT[uaBuffData[button.id][uaBuffSlot].name] or HealBot_Watch_HoT[uaBuffData[button.id][uaBuffSlot].spellId] or false
        if scbWatchHoT then
            if scbWatchHoT == "S" then
                if uaBuffData[button.id][uaBuffSlot].sourceUnitIsPlayer then
                    return true, true, false
                else
                    return false, true, false
                end
            elseif scbWatchHoT == "A" then
                HealBot_AuraBuffCache[uaBuffData[button.id][uaBuffSlot].spellId].always=true
                return true, true, false
            else
                _, scbUnitClassEN=UnitClass(uaBuffData[button.id][uaBuffSlot].sourceUnit)
                if scbUnitClassEN then
                    if HealBot_Data["PCLASSTRIM"] == strsub(scbUnitClassEN,1,4) then
                        HealBot_AuraBuffCache[uaBuffData[button.id][uaBuffSlot].spellId].always=true
                        return true, true, false
                    else
                        return false, true, true
                    end
                else
                    return false, true, false
                end
            end
        elseif uaBuffData[button.id][uaBuffSlot].expirationTime>0 then
            if HealBot_Config_Buffs.AutoBuff == 3 or (HealBot_Config_Buffs.AutoBuff == 2 and uaBuffData[button.id][uaBuffSlot].duration<HealBot_Config_Buffs.AutoBuffExpireTime) then
                if HealBot_Config_Buffs.AutoBuffCastBy == 1 then
                    if uaBuffData[button.id][uaBuffSlot].sourceUnitIsPlayer then
                        HealBot_AuraBuffCache[uaBuffData[button.id][uaBuffSlot].spellId].isAuto=true
                        return true, true, false
                    else
                        return false, true, false
                    end
                elseif HealBot_Config_Buffs.AutoBuffCastBy == 3 then
                    HealBot_AuraBuffCache[uaBuffData[button.id][uaBuffSlot].spellId].always=true
                    HealBot_AuraBuffCache[uaBuffData[button.id][uaBuffSlot].spellId].isAuto=true
                    return true, true, false
                else
                    _, scbUnitClassEN=UnitClass(uaBuffData[button.id][uaBuffSlot].sourceUnit)
                    if scbUnitClassEN then
                        if HealBot_Data["PCLASSTRIM"] == strsub(scbUnitClassEN,1,4) then
                            HealBot_AuraBuffCache[uaBuffData[button.id][uaBuffSlot].spellId].always=true
                            HealBot_AuraBuffCache[uaBuffData[button.id][uaBuffSlot].spellId].isAuto=true
                            return true, true, false
                        else
                            return false, true, true
                        end
                    else
                        return false, true, false
                    end
                end
            end
        end
    end
    return false, false, true
end

local buffIconIdx,buffIconPrio=0,0
function HealBot_Aura_SortBuffIconSet(button, iconSet, sIndex)
      --HealBot_setCall("HealBot_Aura_SortBuffIconSet", button)
    button.icon.buff.count[iconSet]=#buffSort[iconSet]
    if button.icon.buff.count[iconSet]>0 then
        table.sort(buffSort[iconSet])
        if button.icon.buff.count[iconSet]>hbv_Skins_GetIconVar("MAXBICONS", button.frame, iconSet) then
            button.icon.buff.count[iconSet]=hbv_Skins_GetIconVar("MAXBICONS", button.frame, iconSet)
        end
        for j=1, button.icon.buff.count[iconSet], 1 do
            HealBot_Aura_CacheBuffIcon(button, sIndex+j, HealBot_AuraBuffXRef[buffSort[iconSet][j]]["spellID"], HealBot_AuraBuffXRef[buffSort[iconSet][j]]["slot"])
        end
        if HealBot_AuraBuffCache[HealBot_AuraBuffXRef[buffSort[iconSet][1]]["spellID"]]["priority"]<buffIconPrio then
            buffIconIdx=sIndex+1
            buffIconPrio=HealBot_AuraBuffCache[HealBot_AuraBuffXRef[buffSort[iconSet][1]]["spellID"]]["priority"]
        end
    end
end

function HealBot_Aura_SortBuffIcons(button)
      --HealBot_setCall("HealBot_Aura_SortBuffIcons", button)
    buffIconIdx,buffIconPrio=0,21
    if hbv_Skins_GetIconVar("MAXBICONS", button.frame, 1)>0 then
        HealBot_Aura_SortBuffIconSet(button, 1, 0)
    end
    if hbv_Skins_GetIconVar("MAXBICONS", button.frame, 2)>0 then
        HealBot_Aura_SortBuffIconSet(button, 2, 8)
    end
    if hbv_Skins_GetIconVar("MAXBICONS", button.frame, 3)>0 then
        HealBot_Aura_SortBuffIconSet(button, 3, 10)
    end
    return buffIconIdx
end

local castByListIndexed={[HEALBOT_CUSTOM_CASTBY_EVERYONE]=1,
                         [HEALBOT_CUSTOM_CASTBY_ENEMY]=2,
                         [HEALBOT_CUSTOM_CASTBY_FRIEND]=3,
                         [HEALBOT_OPTIONS_SELFHEALS]=4,
                        }
function HealBot_Aura_setCDebuffCasyByIndexed(CDebuffCasyByList)
      --HealBot_setCall("HealBot_Aura_setCDebuffCasyByIndexed")
    castByListIndexed=CDebuffCasyByList
end

function HealBot_Aura_setCustomDebuffFilterCastBy()
      --HealBot_setCall("HealBot_Aura_setCustomDebuffFilterCastBy")
    for id,_ in pairs(hbCustomDebuffsCastBy) do
        hbCustomDebuffsCastBy[id]=false
    end
    for id, x in pairs(HealBot_Globals.FilterCustomDebuff) do
        local name=HealBot_WoWAPI_SpellName(id)
        hbCustomDebuffsCastBy[id]=x
        if (HealBot_Globals.CustomDebuffIDMethod[id] or 2)>1 and name then
            hbCustomDebuffsCastBy[name]=x
        end
    end
    for id,_ in pairs(hbCustomDebuffsCastBy) do
        if not hbCustomDebuffsCastBy[id] then hbCustomDebuffsCastBy[id]=nil end
    end
    HealBot_Timers_Set("AURA","CheckDebuffs")
end

function HealBot_Aura_setCustomDebuffFilterDisabled()
      --HealBot_setCall("HealBot_Aura_setCustomDebuffFilterDisabled")
    for id,_ in pairs(hbCustomDebuffsDisabled) do
        hbCustomDebuffsDisabled[id]=false
    end
    for id, _ in pairs(HealBot_Globals.IgnoreCustomDebuff) do
        local name=HealBot_WoWAPI_SpellName(id)
        hbCustomDebuffsDisabled[id]={}
        if (HealBot_Globals.CustomDebuffIDMethod[id] or 2)>1 and name then
            hbCustomDebuffsDisabled[name]={}
        end
        for instName, disabled in pairs(HealBot_Globals.IgnoreCustomDebuff[id]) do
            if disabled then
                hbCustomDebuffsDisabled[id][instName]=disabled
                if (HealBot_Globals.CustomDebuffIDMethod[id] or 2)>1 and name then
                    hbCustomDebuffsDisabled[name][instName]=disabled
                end
            end
        end
    end
    for id,_ in pairs(hbCustomDebuffsDisabled) do
        if not hbCustomDebuffsDisabled[id] then hbCustomDebuffsDisabled[id]=nil end
    end
    HealBot_Timers_Set("AURA","CheckDebuffs")
end

local cureSpellCD, cureSpellName=0, ""
local debuffIsCurrent, cDebuffPrio=true, 15
local ccdbCasterID, ccdbUnitCasterID, ccdbCheckthis, ccdbAlways=0,1,false,false
local ccdbWatchTarget={}
function HealBot_Aura_CheckCurCustomDebuff(button, canBeAlways)
      --HealBot_setCall("HealBot_Aura_CheckCurCustomDebuff", button)
    ccdbCasterID=hbCustomDebuffsCastBy[uaDebuffData[button.id][uaDebuffSlot].spellId] or hbCustomDebuffsCastBy[uaDebuffData[button.id][uaDebuffSlot].name] or HealBot_Globals.CureCustomDefaultCastBy
    if ccdbCasterID~=castByListIndexed[HEALBOT_CUSTOM_CASTBY_EVERYONE] then
        if uaDebuffData[button.id][uaDebuffSlot].sourceUnitIsPlayer then
            ccdbUnitCasterID=castByListIndexed[HEALBOT_OPTIONS_SELFHEALS]
            if ccdbCasterID == castByListIndexed[HEALBOT_CUSTOM_CASTBY_FRIEND] then 
                ccdbCasterID=castByListIndexed[HEALBOT_OPTIONS_SELFHEALS]
            end
        elseif UnitIsFriend("player",uaDebuffData[button.id][uaDebuffSlot].sourceUnit) then
            ccdbUnitCasterID=castByListIndexed[HEALBOT_CUSTOM_CASTBY_FRIEND]
        else
            ccdbUnitCasterID=castByListIndexed[HEALBOT_CUSTOM_CASTBY_ENEMY]
        end
        if ccdbUnitCasterID == ccdbCasterID then 
            HealBot_AuraDebuffCache[uaDebuffData[button.id][uaDebuffSlot].spellId]["debuffType"]=HEALBOT_CUSTOM_en
            cDebuffPrio=HealBot_AuraDebuffCache[uaDebuffData[button.id][uaDebuffSlot].spellId]["customPrio"]
        else
            debuffIsCurrent=false
        end
    else
        HealBot_AuraDebuffCache[uaDebuffData[button.id][uaDebuffSlot].spellId]["debuffType"]=HEALBOT_CUSTOM_en
        cDebuffPrio=HealBot_AuraDebuffCache[uaDebuffData[button.id][uaDebuffSlot].spellId]["customPrio"]
        if canBeAlways then
            HealBot_AuraDebuffCache[uaDebuffData[button.id][uaDebuffSlot].spellId].always=true 
        end
    end
end

function HealBot_Aura_setDebuffXRefUID(uid, spellID, slot)
    if not HealBot_AuraDebuffXRef[uid] then HealBot_AuraDebuffXRef[uid]={} end
    HealBot_AuraDebuffXRef[uid]["spellID"]=spellID
    HealBot_AuraDebuffXRef[uid]["slot"]=slot
    table.insert(debuffSort[HealBot_Aura_IconSet[spellID]],uid)
end

function HealBot_Aura_CheckCurDebuff(button)
      --HealBot_setCall("HealBot_Aura_CheckCurDebuff", button)
    debuffIsCurrent, cDebuffPrio=true, 20
    if (hbCustomDebuffsDisabled[uaDebuffData[button.id][uaDebuffSlot].spellId] and (hbCustomDebuffsDisabled[uaDebuffData[button.id][uaDebuffSlot].spellId][HealBot_Aura_luVars["mapName"]] or hbCustomDebuffsDisabled[uaDebuffData[button.id][uaDebuffSlot].spellId]["ALL"])) or
       (hbCustomDebuffsDisabled[uaDebuffData[button.id][uaDebuffSlot].name] and (hbCustomDebuffsDisabled[uaDebuffData[button.id][uaDebuffSlot].name][HealBot_Aura_luVars["mapName"]] or hbCustomDebuffsDisabled[uaDebuffData[button.id][uaDebuffSlot].name]["ALL"])) then
        debuffIsCurrent=false
    elseif HealBot_AuraDebuffCache[uaDebuffData[button.id][uaDebuffSlot].spellId]["typePrio"]>HealBot_AuraDebuffCache[uaDebuffData[button.id][uaDebuffSlot].spellId]["customPrio"] and HealBot_AuraDebuffCache[uaDebuffData[button.id][uaDebuffSlot].spellId]["customPrio"]<21 then
        HealBot_Aura_CheckCurCustomDebuff(button, true)
    else
        ccdbCheckthis=false
        if HealBot_AuraDebuffCache[uaDebuffData[button.id][uaDebuffSlot].spellId]["typePrio"]<21 and
          (not HealBot_Config_Cures.IgnoreCannotDispell or HealBot_Aura_CanDispel[uaDebuffData[button.id][uaDebuffSlot].spellId]) and
          (not hbDebuffOnCD[uaDebuffData[button.id][uaDebuffSlot].debuffType] or hbDebuffOnCD[uaDebuffData[button.id][uaDebuffSlot].debuffType]<HealBot_TimeNow) and 
          (not HealBot_Config_Cures.IgnoreFriendDebuffs or not UnitIsFriend("player",uaDebuffData[button.id][uaDebuffSlot].sourceUnit)) and
          (uaDebuffData[button.id][uaDebuffSlot].duration == 0 or uaDebuffData[button.id][uaDebuffSlot].duration>=HealBot_Aura_luVars["IgnoreFastDurDebuffsSecs"]) then
            ccdbWatchTarget=HealBot_Options_retDebuffWatchTarget(uaDebuffData[button.id][uaDebuffSlot].debuffType);
            if ccdbWatchTarget then
                if ccdbWatchTarget["Raid"] then
                    ccdbCheckthis=true;
                    if not HealBot_Config_Cures.IgnoreOnCooldownDebuffs then HealBot_AuraDebuffCache[uaDebuffData[button.id][uaDebuffSlot].spellId].always=true end
                elseif ccdbWatchTarget["Party"] and button.group == HealBot_Data["PLAYERGROUP"] then 
                    ccdbCheckthis=true;
                elseif ccdbWatchTarget["MainTanks"] and HealBot_Panel_IsTank(button.guid) then
                    ccdbCheckthis=true;
                elseif ccdbWatchTarget["SingleTank"] and button.guid == HealBot_Aura_luVars["TankGUID1"] then
                    ccdbCheckthis=true
                elseif ccdbWatchTarget["Self"] and button.player then
                    ccdbCheckthis=true
                elseif ccdbWatchTarget["Solo"] and not IsInRaid() and not IsInGroup() then
                    ccdbCheckthis=true
                elseif ccdbWatchTarget[button.text.classtrim] then
                    ccdbCheckthis=true;
                elseif ccdbWatchTarget["Name"] and button.guid == HealBot_Config.PrivFocus then
                    ccdbCheckthis=true
                elseif ccdbWatchTarget["Focus"] and UnitIsUnit(button.unit, "focus") then
                    ccdbCheckthis=true;
                elseif ccdbWatchTarget["PvP"] and UnitIsPVP(button.unit) then
                    ccdbCheckthis=true
                elseif ccdbWatchTarget["PvE"] and not UnitIsPVP(button.unit) then
                    ccdbCheckthis=true
                elseif ccdbWatchTarget["MyTargets"] and HealBot_Panel_IsMyTarget(button.guid) then
                    ccdbCheckthis=true
                end
            end
        end
        if ccdbCheckthis and HealBot_AuraDebuffCache[uaDebuffData[button.id][uaDebuffSlot].spellId]["typePrio"]<16 then
            cDebuffPrio=HealBot_AuraDebuffCache[uaDebuffData[button.id][uaDebuffSlot].spellId]["typePrio"]
            HealBot_AuraDebuffCache[uaDebuffData[button.id][uaDebuffSlot].spellId]["debuffType"]=uaDebuffData[button.id][uaDebuffSlot].debuffType
        elseif (not UnitIsFriend("player",uaDebuffData[button.id][uaDebuffSlot].sourceUnit) and uaDebuffData[button.id][uaDebuffSlot].isBossAura and HealBot_Config_Cures.AlwaysShowBoss and UnitExists("boss1")) or 
           (HealBot_Config_Cures.AlwaysShowTimed and uaDebuffData[button.id][uaDebuffSlot].duration>0 and uaDebuffData[button.id][uaDebuffSlot].duration<HealBot_Config_Cures.ShowTimeMaxDuration) or 
           (HealBot_Config_Cures.HealBot_Custom_Debuffs_All[uaDebuffData[button.id][uaDebuffSlot].debuffType]) then
            HealBot_AuraDebuffCache[uaDebuffData[button.id][uaDebuffSlot].spellId]["debuffType"]=HEALBOT_CUSTOM_en
            cDebuffPrio=15
            HealBot_AuraDebuffCache[uaDebuffData[button.id][uaDebuffSlot].spellId].isAuto=true
            if HealBot_AuraDebuffCache[uaDebuffData[button.id][uaDebuffSlot].spellId]["typePrio"]>15 then
                HealBot_AuraDebuffCache[uaDebuffData[button.id][uaDebuffSlot].spellId].always=true
            end
        elseif ccdbCheckthis then
            cDebuffPrio=HealBot_AuraDebuffCache[uaDebuffData[button.id][uaDebuffSlot].spellId]["typePrio"]
        elseif HealBot_AuraDebuffCache[uaDebuffData[button.id][uaDebuffSlot].spellId]["customPrio"]<21 then
            HealBot_Aura_CheckCurCustomDebuff(button, false)
        elseif uaDebuffData[button.id][uaDebuffSlot].sourceUnitIsPlayer and not UnitIsFriend("player",button.unit) then
            HealBot_AuraDebuffCache[uaDebuffData[button.id][uaDebuffSlot].spellId]["debuffType"]=HEALBOT_CUSTOM_en
            cDebuffPrio=20
        else
            debuffIsCurrent=false
        end
    end
    if debuffIsCurrent and HealBot_AuraDebuffCache[uaDebuffData[button.id][uaDebuffSlot].spellId]["priority"]~=cDebuffPrio then
        HealBot_AuraDebuffCache[uaDebuffData[button.id][uaDebuffSlot].spellId]["priority"]=cDebuffPrio
        if HealBot_AuraDebuffCache[uaDebuffData[button.id][uaDebuffSlot].spellId]["priority"]<10 then
            HealBot_AuraDebuffCache[uaDebuffData[button.id][uaDebuffSlot].spellId]["pid"]="x0"..HealBot_AuraDebuffCache[uaDebuffData[button.id][uaDebuffSlot].spellId]["priority"]..uaDebuffData[button.id][uaDebuffSlot].spellId
        else
            HealBot_AuraDebuffCache[uaDebuffData[button.id][uaDebuffSlot].spellId]["pid"]="x"..HealBot_AuraDebuffCache[uaDebuffData[button.id][uaDebuffSlot].spellId]["priority"]..uaDebuffData[button.id][uaDebuffSlot].spellId
        end
    end
    return debuffIsCurrent
end

function HealBot_Aura_AuxSetAuraBuffBars(button)
        --HealBot_setCall("HealBot_Aura_AuxSetAuraBuffBars", button)
    HealBot_Aux_UpdateAuraBuffBars(button)
    if HealBot_Aura_AuxAssigns["NameOverlayBuff"][button.frame] then
        HealBot_Aux_UpdateNameOverLay(button, 8, true)
    end
    if HealBot_Aura_AuxAssigns["HealthOverlayBuff"][button.frame] then
        HealBot_Aux_UpdateHealthOverLay(button, 8, true)
    end
end

function HealBot_Aura_AuxClearAuraBuffBars(button)
        --HealBot_setCall("HealBot_Aura_AuxClearAuraBuffBars", button)
    HealBot_Aux_ClearAuraBuffBars(button)
    if HealBot_Aura_AuxAssigns["NameOverlayBuff"][button.frame] then
        HealBot_Aux_UpdateNameOverLay(button, 8, false)
    end
    if HealBot_Aura_AuxAssigns["HealthOverlayBuff"][button.frame] then
        HealBot_Aux_UpdateHealthOverLay(button, 8, false)
    end
end

function HealBot_Aura_BuffWarnings(button, buffName, force)
        --HealBot_setCall("HealBot_Aura_BuffWarnings", button)
    if button.aura.buff.name~=buffName or force then
        button.aura.buff.name=buffName
        HealBot_Emerg_Button[button.id].buffupdate=true
        button.aura.buff.r,button.aura.buff.g,button.aura.buff.b=HealBot_Options_RetBuffRGB(button)
        if HealBot_Range_WarnInRange(button, button.aura.buff.name, HealBot_Config_Buffs.WarnRange_Bar) then
            if button.aura.buff.colbar == 4 then
                HealBot_Action_EnableBorderHazardType(button, button.aura.buff.r, button.aura.buff.g, button.aura.buff.b, "BUFF")
            elseif button.hazard.buff then
                HealBot_Action_DisableBorderHazardType(button, "BUFF")
            end
            if button.aura.buff.colbar>4 then
                HealBot_Action_EnableButtonGlowType(button, button.aura.buff.r, button.aura.buff.g, button.aura.buff.b, "BUFF", "", button.aura.buff.colbar)
            elseif button.glow.buff then
                HealBot_Action_DisableButtonGlowType(button, "BUFF")
            end
            if button.aura.buff.colbar>0 then 
                HealBot_Aura_AuxSetAuraBuffBars(button)
            else
                HealBot_Aura_AuxClearAuraBuffBars(button)
            end
        else
            if button.hazard.buff then HealBot_Action_DisableBorderHazardType(button, "BUFF") end
            if button.glow.buff then HealBot_Action_DisableButtonGlowType(button, "BUFF") end
            HealBot_Aura_AuxClearAuraBuffBars(button) 
        end
        if button.mouseover and HealBot_Data["TIPBUTTON"] then 
            HealBot_setTooltipUpdateNow()
        end
        if buffWarnings and (not HealBot_Aura_WarningFilter[button.unit][buffName] or HealBot_Aura_WarningFilter[button.unit][buffName]<HealBot_TimeNow) then
            if button.aura.buff.missingbuff and HealBot_BuffWatch[button.aura.buff.name] then
                HealBot_Aura_WarningFilter[button.unit][buffName]=HealBot_TimeNow+1
            else
                HealBot_Aura_WarningFilter[button.unit][buffName]=curBuffxTime[buffName] or HealBot_TimeNow+5
            end
            if HealBot_Config_Buffs.ShowBuffWarning and (button.aura.buff.missingbuff or not HealBot_Config_Buffs.ShowBuffWarningMissingOnly) and
               HealBot_Range_WarnInRange(button, button.aura.buff.name, HealBot_Config_Buffs.WarnRange_Screen) then
                UIErrorsFrame:AddMessage(button.text.nameonly.." requires "..button.aura.buff.name, 
                                         button.aura.buff.r, button.aura.buff.g, button.aura.buff.b, 1, UIERRORS_HOLD_TIME);
            end
            if HealBot_Config_Buffs.SoundBuffWarning and (button.aura.buff.missingbuff or not HealBot_Config_Buffs.SoundBuffWarningMissingOnly) and
               HealBot_Range_WarnInRange(button, button.aura.buff.name, HealBot_Config_Buffs.WarnRange_Sound) then
                HealBot_Media_PlaySound(HealBot_Config_Buffs.SoundBuffPlay, HealBot_Config_Buffs.SoundBuffChan)
            end
        end
        HealBot_RefreshUnit(button)
    end
end

function HealBot_Aura_AuxSetAuraDebuffBars(button)
        --HealBot_setCall("HealBot_Aura_AuxSetAuraDebuffBars", button)
    HealBot_Aux_UpdateAuraDebuffBars(button)
    if HealBot_Aura_AuxAssigns["NameOverlayDebuff"][button.frame] then
        HealBot_Aux_UpdateNameOverLay(button, 3, true)
    end
    if HealBot_Aura_AuxAssigns["HealthOverlayDebuff"][button.frame] then
        HealBot_Aux_UpdateHealthOverLay(button, 3, true)
    end
end

function HealBot_Aura_AuxClearAuraDebuffBars(button)
        --HealBot_setCall("HealBot_Aura_AuxClearAuraDebuffBars", button)
    HealBot_Aux_ClearAuraDebuffBars(button)
    if HealBot_Aura_AuxAssigns["NameOverlayDebuff"][button.frame] then
        HealBot_Aux_UpdateNameOverLay(button, 3, false)
    end
    if HealBot_Aura_AuxAssigns["HealthOverlayDebuff"][button.frame] then
        HealBot_Aux_UpdateHealthOverLay(button, 3, false)
    end
end

function HealBot_Aura_IsCureSpell(button)
        --HealBot_setCall("HealBot_Aura_IsCureSpell", button)
    if button.aura.debuff.curespell and HealBot_Spells_KnownByName(button.aura.debuff.curespell) then
        return true
    else
        return false
    end
end

function HealBot_Aura_DebuffWarnings(button, debuffName, force, debuffIconIndex)
        --HealBot_setCall("HealBot_Aura_DebuffWarnings", button)
    if button.aura.debuff.name~=debuffName or force then
        button.aura.debuff.name=debuffName
        if HealBot_Text_TagInUse(button.framecol, "DEBUFF") then
            HealBot_Text_setNameTag(button)
        end
        HealBot_Emerg_Button[button.id].debuffupdate=true
        button.aura.debuff.r,button.aura.debuff.g,button.aura.debuff.b=HealBot_Options_RetDebuffRGB(button)
        button.aura.debuff.curespell=HealBot_Options_retDebuffCureSpell(button.aura.debuff.type)
        if HealBot_Range_WarnInRange(button, button.aura.debuff.curespell, HealBot_Config_Cures.WarnRange_Bar) then
            if button.aura.debuff.colbar == 4 then
                HealBot_Action_EnableBorderHazardType(button, button.aura.debuff.r, button.aura.debuff.g, button.aura.debuff.b, "DEBUFF")
            elseif button.hazard.debuff then
                HealBot_Action_DisableBorderHazardType(button, "DEBUFF")
            end
            if button.aura.debuff.colbar>4 then
                HealBot_Action_EnableButtonGlowType(button, button.aura.debuff.r, button.aura.debuff.g, button.aura.debuff.b, "DEBUFF", "", button.aura.debuff.colbar)
            elseif button.glow.debuff then
                HealBot_Action_DisableButtonGlowType(button, "DEBUFF")
            end
            if button.aura.debuff.colbar>0 then 
                HealBot_Aura_AuxSetAuraDebuffBars(button) 
            else
                HealBot_Aura_AuxClearAuraDebuffBars(button)
            end
        else
            if button.hazard.debuff then HealBot_Action_DisableBorderHazardType(button, "DEBUFF") end
            if button.glow.debuff then HealBot_Action_DisableButtonGlowType(button, "DEBUFF") end
            HealBot_Aura_AuxClearAuraDebuffBars(button)
        end
        if button.mouseover and HealBot_Data["TIPBUTTON"] then 
            HealBot_setTooltipUpdateNow()
        end
        if button.status.range>0 and (button.isplayer or button.isgroupraid) and button.frame<10 and button.aura.debuff.priority<=HealBot_Aura_retLuVars("HotBarDebuff") then
            HealBot_Action_BarHotEnable(button, "DEBUFF")
        elseif button.hotbars.debuff then
            HealBot_Action_BarHotDisable(button, "DEBUFF")
        end
        if debuffWarnings and (not HealBot_Aura_WarningFilter[button.unit][button.aura.debuff.name] or HealBot_Aura_WarningFilter[button.unit][button.aura.debuff.name]<HealBot_TimeNow) then
            if debuffIconIndex == 0 then debuffIconIndex=51 end
            HealBot_Aura_WarningFilter[button.unit][button.aura.debuff.name]=HealBot_UnitDebuffIcons[button.id][debuffIconIndex]["expirationTime"]
            if HealBot_Config_Cures.ShowDebuffWarning and (button.aura.debuff.dispellable or not HealBot_Config_Cures.ShowDebuffWarningDispelOnly) then
                if HealBot_Range_WarnInRange(button, button.aura.debuff.curespell, HealBot_Config_Cures.WarnRange_Screen) and type(button.aura.debuff.name) == "string" then
                    UIErrorsFrame:AddMessage(button.text.nameonly.." suffers from "..button.aura.debuff.name, 
                                             button.aura.debuff.r,button.aura.debuff.g,button.aura.debuff.b, 1, UIERRORS_HOLD_TIME);
                end
            end
            if HealBot_Config_Cures.SoundDebuffWarning and (button.aura.debuff.dispellable or not HealBot_Config_Cures.SoundDebuffWarningDispelOnly) then
                if HealBot_Range_WarnInRange(button, button.aura.debuff.curespell, HealBot_Config_Cures.WarnRange_Sound) then
                    HealBot_Media_PlaySound(HealBot_Config_Cures.SoundDebuffPlay, HealBot_Config_Cures.SoundDebuffChan)
                end
            end
        end
        HealBot_RefreshUnit(button)
    end
end

local asbtPrevEndTime=0
function HealBot_Aura_SetUnitBuffTimer(button)
      --HealBot_setCall("HealBot_Aura_SetUnitBuffTimer", button)
    asbtPrevEndTime=button.aura.buff.recheck[uaBuffData[button.id][uaBuffSlot].name] or 0
    if HealBot_ShortBuffs[uaBuffData[button.id][uaBuffSlot].name] then 
        button.aura.buff.recheck[uaBuffData[button.id][uaBuffSlot].name]=uaBuffData[button.id][uaBuffSlot].expirationTime-HealBot_Config_Buffs.ShortBuffTimer
    else
        button.aura.buff.recheck[uaBuffData[button.id][uaBuffSlot].name]=uaBuffData[button.id][uaBuffSlot].expirationTime-HealBot_Config_Buffs.LongBuffTimer
    end
    if asbtPrevEndTime~=button.aura.buff.recheck[uaBuffData[button.id][uaBuffSlot].name] then
        HealBot_Aura_MarkCheckBuffsTime(button)
    end
end

function HealBot_Aura_CheckUnitBuffIcons(button)
      --HealBot_setCall("HealBot_Aura_CheckUnitBuffIcons", button)
    for i=1,8 do
        if i<=button.icon.buff.count[1] then
            if not HealBot_UnitBuffIcons[button.id][i].current then
                HealBot_UnitBuffIcons[button.id][i].current=true
                HealBot_Aura_AddBuffIcon(button, i)
            end
        elseif i<=HealBot_Aura_prevIconCount["BUFF"][1] then
            HealBot_Aura_RemoveIcon(button, i)
        else
            break
        end
    end
    for i=9,10 do
        if i<=(8+button.icon.buff.count[2]) then
            if not HealBot_UnitBuffIcons[button.id][i].current then
                HealBot_UnitBuffIcons[button.id][i].current=true
                HealBot_Aura_AddBuffIcon(button, i)
            end
        elseif i<=(8+HealBot_Aura_prevIconCount["BUFF"][2]) then
            HealBot_Aura_RemoveIcon(button, i)
        else
            break
        end
    end
    for i=11,12 do
        if i<=(10+button.icon.buff.count[3]) then
            if not HealBot_UnitBuffIcons[button.id][i].current then
                HealBot_UnitBuffIcons[button.id][i].current=true
                HealBot_Aura_AddBuffIcon(button, i)
            end
        elseif i<=(10+HealBot_Aura_prevIconCount["BUFF"][3]) then
            HealBot_Aura_RemoveIcon(button, i)
        else
            break
        end
    end
end

local hbAuraRequests={}
function HealBot_Aura_Requests(guid, buff)
      --HealBot_setCall("HealBot_Aura_Requests", nil, guid)
    if buff then
        if not hbAuraRequests[guid] then 
            hbAuraRequests[guid]={} 
            HealBot_Aura_AddWatch(guid)
        end
        hbAuraRequests[guid][buff]=true
    else
        hbAuraRequests[guid]=nil
        HealBot_Aura_DelWatch(guid)
    end
end

function HealBot_Aura_RequestsClear()
      --HealBot_setCall("HealBot_Aura_RequestsClear")
    hbAuraRequests={}
end

local hbAuraWatch={}
local hbAuraBuffWatch={}
local hbAuraBuffTagWatch={}
local hbAuraDebuffWatch={}
local hbAuraDebuffTagWatch={}
local hbAuraActionBuffWatch={}
local hbAuraActionBuffTagWatch={}
local hbAuraActionDebuffWatch={}
local hbAuraActionDebuffTagWatch={}

function HealBot_Aura_AddWatch(guid)
      --HealBot_setCall("HealBot_Aura_AddWatch", nil, guid)
    if not hbAuraWatch[guid] then
        hbAuraWatch[guid]=true
    end
end

function HealBot_Aura_DelWatch(guid)
      --HealBot_setCall("HealBot_Aura_DelWatch", nil, guid)
    if hbAuraWatch[guid] then
        if not hbAuraRequests[guid] and 
           not hbAuraBuffWatch[guid] and not hbAuraBuffTagWatch[guid] and not hbAuraActionBuffWatch[guid] and not hbAuraActionBuffTagWatch[guid] and 
           not hbAuraDebuffWatch[guid] and not hbAuraDebuffTagWatch[guid] and not hbAuraActionDebuffWatch[guid] and not hbAuraActionDebuffTagWatch[guid] then
            hbAuraWatch[guid]=nil
        end
    end
end

function HealBot_Aura_BuffWatch(guid, buff, active, actionicon)
      --HealBot_setCall("HealBot_Aura_BuffWatch", nil, guid)
    local hbbwa=nil
    if actionicon then
        hbbwa=hbAuraActionBuffWatch
    else
        hbbwa=hbAuraBuffWatch
    end
    if buff then
        if active then
            if not hbbwa[guid] then 
                hbbwa[guid]={}
                HealBot_Aura_AddWatch(guid)
            end
            if not hbbwa[guid][buff] then
                if HealBot_Aura_CurrentBuff(guid, buff) then
                    hbbwa[guid][buff]=1
                else
                    hbbwa[guid][buff]=0
                end
            end
        elseif hbbwa[guid] and hbbwa[guid][buff] then
            hbbwa[guid][buff]=nil
        end
    else
        hbbwa[guid]=nil
        HealBot_Aura_DelWatch(guid)
    end
end

function HealBot_Aura_BuffTagWatch(guid, tag, active, actionicon)
      --HealBot_setCall("HealBot_Aura_BuffTagWatch", nil, guid)
    local hbbwta=nil
    if actionicon then
        hbbwta=hbAuraActionBuffTagWatch
    else
        hbbwta=hbAuraBuffTagWatch
    end
    if tag then
        if active then
            if not hbbwta[guid] then 
                hbbwta[guid]={}
                HealBot_Aura_AddWatch(guid)
            end
            if not hbbwta[guid][tag] then
                hbbwta[guid][tag]=0
                if HealBot_UnitBuffCurrent[guid] then
                    for bName, _ in pairs(HealBot_UnitBuffCurrent[guid]) do
                        if (HealBot_BuffTagNames[bName] and HealBot_BuffTagNames[bName] == tag) or
                           (HealBot_Aura_ID[bName] and HealBot_Globals.CustomBuffTag[HealBot_Aura_ID[bName]] and HealBot_Globals.CustomBuffTag[HealBot_Aura_ID[bName]] == tag) then
                            hbbwta[guid][tag]=1
                            break
                        end
                    end
                end
            end
        elseif hbbwta[guid] and hbbwta[guid][tag] then
            hbbwta[guid][tag]=nil
        end
    else
        hbbwta[guid]=nil
        HealBot_Aura_DelWatch(guid)
    end
end

function HealBot_Aura_AuraWatchClear()
      --HealBot_setCall("HealBot_Aura_AuraWatchClear")
    for guid,_ in pairs(hbAuraBuffWatch) do
        hbAuraBuffWatch[guid]=nil
        HealBot_Aura_DelWatch(guid)
    end
    for guid,_ in pairs(hbAuraBuffTagWatch) do
        hbAuraBuffWatch[guid]=nil
        hbAuraBuffTagWatch(guid)
    end
    for guid,_ in pairs(hbAuraDebuffWatch) do
        hbAuraBuffWatch[guid]=nil
        hbAuraDebuffWatch(guid)
    end
    for guid,_ in pairs(hbAuraDebuffTagWatch) do
        hbAuraBuffWatch[guid]=nil
        hbAuraDebuffTagWatch(guid)
    end
end

function HealBot_Aura_DebuffWatch(guid, debuff, active, actionicon)
      --HealBot_setCall("HealBot_Aura_DebuffWatch", nil, guid)
    local hbdwa=nil
    if actionicon then
        hbdwa=hbAuraActionDebuffWatch
    else
        hbdwa=hbAuraDebuffWatch
    end
    if debuff then
        if active then
            if not hbdwa[guid] then 
                hbdwa[guid]={}
                HealBot_Aura_AddWatch(guid)
            end
            if not hbdwa[guid][debuff] then
                if HealBot_Aura_CurrentDebuff(guid, debuff) then
                    hbdwa[guid][debuff]=1
                else
                    hbdwa[guid][debuff]=0
                end
            end
        elseif hbdwa[guid] and hbdwa[guid][debuff] then
            hbdwa[guid][debuff]=nil
        end
    else
        hbdwa[guid]=nil
        HealBot_Aura_DelWatch(guid)
    end
end

function HealBot_Aura_DebuffTagWatch(guid, tag, active, actionicon)
      --HealBot_setCall("HealBot_Aura_DebuffTagWatch", nil, guid)
    local hbdwta=nil
    if actionicon then
        hbdwta=hbAuraActionDebuffTagWatch
    else
        hbdwta=hbAuraDebuffTagWatch
    end
    if tag then
        if active then
            if not hbdwta[guid] then 
                hbdwta[guid]={}
                HealBot_Aura_AddWatch(guid)
            end
            if not hbdwta[guid][tag] then
                hbdwta[guid][tag]=0
                if HealBot_UnitDebuffCurrent[guid] then
                    for dName, _ in pairs(HealBot_UnitDebuffCurrent[guid]) do
                        if (HealBot_DebuffTagNames[dName] and HealBot_DebuffTagNames[dName] == tag) or
                           (HealBot_Aura_ID[dName] and HealBot_Globals.CDCTag[HealBot_Aura_ID[dName]] and HealBot_Globals.CDCTag[HealBot_Aura_ID[dName]] == tag) then
                            hbdwta[guid][tag]=1
                            break
                        end
                    end
                end
            end
        elseif hbdwta[guid] and hbdwta[guid][tag] then
            hbdwta[guid][tag]=nil
        end
    else
        hbdwta[guid]=nil
        HealBot_Aura_DelWatch(guid)
    end
end

function HealBot_Aura_CurrentBuffTag(guid, tag)
      --HealBot_setCall("HealBot_Aura_CurrentBuffTag", nil, guid)
    if hbAuraBuffTagWatch[guid] and (hbAuraBuffTagWatch[guid][tag] or 0) == 1 then
        return true
    else
        return false
    end
end

function HealBot_Aura_ActionIconBuffTag(guid, tag)
      --HealBot_setCall("HealBot_Aura_ActionIconBuffTag", nil, guid)
    if hbAuraActionBuffTagWatch[guid] and (hbAuraActionBuffTagWatch[guid][tag] or 0) == 1 then
        return true
    else
        return false
    end
end

function HealBot_Aura_CurrentBuff(guid, bName)
      --HealBot_setCall("HealBot_Aura_CurrentBuff", nil, guid)
    if HealBot_UnitBuffCurrent[guid] then
        return HealBot_UnitBuffCurrent[guid][bName]
    else
        return false
    end
end

function HealBot_Aura_CurrentDebuff(guid, dName)
      --HealBot_setCall("HealBot_Aura_CurrentDebuff", nil, guid)
    if HealBot_UnitDebuffCurrent[guid] then
        return HealBot_UnitDebuffCurrent[guid][dName]
    else
        return false
    end
end

function HealBot_Aura_CurrentDebuffTag(guid, tag)
      --HealBot_setCall("HealBot_Aura_CurrentDebuffTag", nil, guid)
    if hbAuraDebuffTagWatch[guid] and (hbAuraDebuffTagWatch[guid][tag] or 0) == 1 then
        return true
    else
        return false
    end
end

function HealBot_Aura_ActionIconDebuffTag(guid, tag)
      --HealBot_setCall("HealBot_Aura_ActionIconDebuffTag", nil, guid)
    if hbAuraActionDebuffTagWatch[guid] and (hbAuraActionDebuffTagWatch[guid][tag] or 0) == 1 then
        return true
    else
        return false
    end
end

local uaIsCurrent, uaIsCustom, uaNever, uaZ=false, false, false, 1
local onlyPlayers,prevMissingbuff=false,false
local HealBot_UnusedSelfBuffs={}
local HealBot_UnusedBuffs={}
function HealBot_Aura_CheckUnitGeneralBuff(button)
    if onlyPlayers and (HealBot_BuffWatch[uaBuffData[button.id][uaBuffSlot].name] or HealBot_BuffNameTypes[uaBuffData[button.id][uaBuffSlot].name]) then
        if not button.aura.buff.recheck[uaBuffData[button.id][uaBuffSlot].name] or button.aura.buff.recheck[uaBuffData[button.id][uaBuffSlot].name]>HealBot_TimeNow then
            if HealBot_BuffNameTypes[uaBuffData[button.id][uaBuffSlot].name] then
                if HealBot_BuffNameTypes[uaBuffData[button.id][uaBuffSlot].name]<7 and uaBuffData[button.id][uaBuffSlot].sourceUnitIsPlayer then ownBlessing=true end
                PlayerBuffTypes[HealBot_BuffNameTypes[uaBuffData[button.id][uaBuffSlot].name]]=true
            end
        end
        PlayerBuffs[uaBuffData[button.id][uaBuffSlot].name]=true
        if HealBot_CheckBuffs[uaBuffData[button.id][uaBuffSlot].name] and uaBuffData[button.id][uaBuffSlot].expirationTime>0 and (HEALBOT_GAME_VERSION>1 or uaBuffData[button.id][uaBuffSlot].sourceUnitIsPlayer) then
            HealBot_Aura_SetUnitBuffTimer(button)
        elseif button.aura.buff.recheck[uaBuffData[button.id][uaBuffSlot].name] then
            button.aura.buff.recheck[uaBuffData[button.id][uaBuffSlot].name]=nil
            HealBot_Aura_MarkCheckBuffsTime(button)
        end
    end
end

function HealBot_Aura_CheckUnitBuff(button)
      --HealBot_setCall("HealBot_Aura_CheckUnitBuff", button)
    if uaBuffData[button.id][uaBuffSlot].name == HEALBOT_SPIRIT_OF_REDEMPTION_NAME and button.health.current>0 then 
        C_Timer.After(0.1, function() HealBot_Action_UpdateTheDeadButton(button) end)
    end
    if HealBot_Buff_Aura2Item[uaBuffData[button.id][uaBuffSlot].name] then
        uaBuffData[button.id][uaBuffSlot].name=HealBot_WoWAPI_ItemInfo(HealBot_Buff_Aura2Item[uaBuffData[button.id][uaBuffSlot].name]) or uaBuffData[button.id][uaBuffSlot].name
    end
    if not uaBuffData[button.id][uaBuffSlot].isCurrent then
        uaIsCurrent, uaIsCustom, uaNever=HealBot_Aura_ShowCustomBuff(button)
        if uaIsCurrent then 
            uaBuffData[button.id][uaBuffSlot].isCurrent=true
            HealBot_AuraBuffCache[uaBuffData[button.id][uaBuffSlot].spellId].isCustom=uaIsCustom
        end
    else
        uaIsCurrent=true
        uaIsCustom=HealBot_AuraBuffCache[uaBuffData[button.id][uaBuffSlot].spellId].isCustom
    end
    if uaIsCurrent then
        if not button.status.isspirit or uaBuffData[button.id][uaBuffSlot].name == HEALBOT_SPIRIT_OF_REDEMPTION_NAME then
            curBuffxTime[uaBuffData[button.id][uaBuffSlot].name]=uaBuffData[button.id][uaBuffSlot].expirationTime
            if uaIsCustom then
                HealBot_Aura_setBuffXRefUID(HealBot_AuraBuffCache[uaBuffData[button.id][uaBuffSlot].spellId]["pid"]..uaBuffSlot, uaBuffData[button.id][uaBuffSlot].spellId, uaBuffSlot)
            end
        end
        HealBot_Aura_CheckUnitGeneralBuff(button)
    elseif not HealBot_BuffWatch[uaBuffData[button.id][uaBuffSlot].name] and not HealBot_BuffNameTypes[uaBuffData[button.id][uaBuffSlot].name] then
        if uaNever then HealBot_ExcludeBuffInCache[uaBuffData[button.id][uaBuffSlot].spellId]=true end
        if not HealBot_Watch_HoT[uaBuffData[button.id][uaBuffSlot].name] and not HealBot_Watch_HoT[uaBuffData[button.id][uaBuffSlot].spellId] then
            if uaBuffData[button.id][uaBuffSlot].sourceUnitIsPlayer then
                HealBot_UnusedSelfBuffs[uaBuffData[button.id][uaBuffSlot].spellId]=true
            elseif not HealBot_UnusedBuffs[uaBuffData[button.id][uaBuffSlot].spellId] then
                _, scbUnitClassEN=UnitClass(uaBuffData[button.id][uaBuffSlot].sourceUnit)
                if scbUnitClassEN then
                    scbUnitClassEN=strsub(scbUnitClassEN,1,4)
                    HealBot_UnusedBuffs[uaBuffData[button.id][uaBuffSlot].spellId]=scbUnitClassEN..":"..HealBot_Aura_UnusedAuraInfo(uaBuffData[button.id][uaBuffSlot].sourceUnit, scbUnitClassEN)
                else
                    HealBot_UnusedBuffs[uaBuffData[button.id][uaBuffSlot].spellId]=HEALBOT_WORDS_UNKNOWN..":"..HealBot_Aura_UnusedAuraInfo(uaBuffData[button.id][uaBuffSlot].sourceUnit, "XXXX")
                end
            end
        end
    else
        HealBot_Aura_CheckUnitGeneralBuff(button)
    end
end

function HealBot_Aura_ListUnusedBuffsBySelf()
    local l={}
    --HealBot_UnusedSelfBuffs[139]=true
    --HealBot_UnusedSelfBuffs[17]=true
    for x,_ in pairs(HealBot_UnusedSelfBuffs) do
        local bName=HealBot_Options_CDebuffTextID(x)
        if tonumber(bName) == nil then
            table.insert(l,bName)
        end
    end
    table.sort(l)
    return l
end

function HealBot_Aura_ListUnusedBuffsByOther(myclass)
    local l={}
    local i={}
    --HealBot_UnusedBuffs[139]=HealBot_Data["PCLASSTRIM"]..":SillyLittleKnickers"
    --HealBot_UnusedBuffs[17]=HealBot_Data["PCLASSTRIM"]..":BillyBigPants"
    for x,y in pairs(HealBot_UnusedBuffs) do
        local t,n=string.split(":",y)
        local bName=nil
        if myclass then
            if t == HealBot_Data["PCLASSTRIM"] then
                bName=HealBot_Options_CDebuffTextID(x)
            end
        elseif t ~= HealBot_Data["PCLASSTRIM"] then
            bName=HealBot_Options_CDebuffTextID(x)
        end
        if bName and tonumber(bName) == nil then
            table.insert(l,bName)
            i[bName]=n
        end
    end
    table.sort(l)
    return l,i
end

local HealBot_UnusedSelfDebuffs={}
local HealBot_UnusedDebuffs={}
function HealBot_Aura_CheckUnitDebuff(button)
      --HealBot_setCall("HealBot_Aura_CheckUnitDebuff", button)
    if not uaDebuffData[button.id][uaDebuffSlot].isCurrent then
        uaIsCurrent=HealBot_Aura_CheckCurDebuff(button)
        if uaIsCurrent and (hbDebuffOnCD[uaDebuffData[button.id][uaDebuffSlot].debuffType] or 0)<(HealBot_TimeNow+2) then
            uaDebuffData[button.id][uaDebuffSlot].isCurrent=true
        end
    else
        uaIsCurrent=true
    end
    if uaIsCurrent then
        HealBot_Aura_setDebuffXRefUID(HealBot_AuraDebuffCache[uaDebuffData[button.id][uaDebuffSlot].spellId]["pid"]..uaDebuffSlot, uaDebuffData[button.id][uaDebuffSlot].spellId, uaDebuffSlot)
        if not button.aura.debuff.temp.active or button.aura.debuff.temp.priority>HealBot_AuraDebuffCache[uaDebuffData[button.id][uaDebuffSlot].spellId]["priority"] then
            button.aura.debuff.temp.active=true
            button.aura.debuff.temp.id=uaDebuffData[button.id][uaDebuffSlot].spellId
            button.aura.debuff.temp.priority=HealBot_AuraDebuffCache[uaDebuffData[button.id][uaDebuffSlot].spellId]["priority"]
        end
    elseif uaDebuffData[button.id][uaDebuffSlot].sourceUnitIsPlayer then
        HealBot_UnusedSelfDebuffs[uaDebuffData[button.id][uaDebuffSlot].spellId]=true
    elseif not HealBot_UnusedDebuffs[uaDebuffData[button.id][uaDebuffSlot].spellId] then
        if UnitIsFriend("player",uaDebuffData[button.id][uaDebuffSlot].sourceUnit) then
            HealBot_UnusedDebuffs[uaDebuffData[button.id][uaDebuffSlot].spellId]="1:"..HealBot_Aura_UnusedAuraInfo(uaDebuffData[button.id][uaDebuffSlot].sourceUnit)
        else
            HealBot_UnusedDebuffs[uaDebuffData[button.id][uaDebuffSlot].spellId]="2:"..HealBot_Aura_UnusedAuraInfo(uaDebuffData[button.id][uaDebuffSlot].sourceUnit)
        end
    end
end

function HealBot_Aura_UnusedAuraUnitInfo(unit, classEn)
    local info=HEALBOT_WORDS_UNKNOWN
    --if unit then
        local uLoc=nil
        if UnitIsVisible(unit) then uLoc=GetRealZoneText() end
        local uName=UnitName(unit)
        local uClassify=HealBot_UnitClassification(unit)
        local uRace=UnitRace(unit)
        local uClass=nil
        if classEn then
            uClass=hbv_GetClass("Disc", classEn) or UnitClass(unit) or UnitCreatureFamily(unit) or UnitCreatureType(unit)
        end
        local info=UnitLevel(unit) or 0
        if info<1 then
            info=nil
        else
            info="Level "..info
        end
        if uClassify then
            if info then
                info=uClassify.." "..info
            else
                info=uClassify
            end
        end
        if uRace then
            if info then
                info=info.." "..uRace
            else
                info=uRace
            end
        end
        if uClass then
            if info then
                info=info.." "..uClass
            else
                info=uClass
            end
        end
        if uLoc then
            if info then
                info=info.." - "..uLoc
            else
                info=uLoc
            end
        end
        if info then 
            if uName then
                info=uName.."!"..info
            else
                info=HEALBOT_WORDS_UNKNOWN.."!"..info
            end
        else
            info=uName or HEALBOT_WORDS_UNKNOWN
        end
    --end
    return info
end

function HealBot_Aura_UnusedAuraInfo(unit, classEn)
    xButton=HealBot_Panel_AllButton(UnitGUID(unit))
    if xButton then
        return HealBot_Aura_UnusedAuraUnitInfo(xButton.unit, classEn)
    else
        return HealBot_Aura_UnusedAuraUnitInfo(unit, classEn)
    end
end

function HealBot_Aura_ListUnusedDebuffsBySelf()
    local l={}
    for x,_ in pairs(HealBot_UnusedSelfDebuffs) do
        local dName=HealBot_Options_CDebuffTextID(x)
        if tonumber(dName) == nil then
            table.insert(l,dName)
        end
    end
    table.sort(l)
    return l
end

function HealBot_Aura_ListUnusedDebuffsByOther(key)
    local l={}
    local i={}
    for x,y in pairs(HealBot_UnusedDebuffs) do
        local t,n=string.split(":",y)
        if t == key then
            local dName=HealBot_Options_CDebuffTextID(x)
            if tonumber(dName) == nil then
                table.insert(l,dName)
                i[dName]=n
            end
        end
    end
    table.sort(l)
    return l,i
end

local uaID,uaSlot="",0
function HealBot_Aura_setBuffXRefUID(uid, spellID, slot)
    if not HealBot_AuraBuffXRef[uid] then HealBot_AuraBuffXRef[uid]={} end
    HealBot_AuraBuffXRef[uid]["spellID"]=spellID
    HealBot_AuraBuffXRef[uid]["slot"]=slot
    table.insert(buffSort[HealBot_Aura_IconSet[spellID]],uid)
end

local function HealBot_Aura_PostUpdateUnitBuffsData(button, spellID, spellName)
      --HealBot_setCall("HealBot_Aura_PostUpdateUnitBuffsData", button)
    if not HealBot_AuraBuffCache[spellID] or HealBot_AuraBuffCache[spellID].reset then
        if not HealBot_AuraBuffCache[spellID] then 
            HealBot_AuraBuffCache[spellID]={}
            HealBot_AuraBuffCache[spellID]["name"]=spellName
            HealBot_Aura_ID[spellName]=spellID
            if HealBot_SpellID_LookupData[spellName] and HealBot_SpellID_LookupData[spellName]["CHECK"] then
                HealBot_SpellID_LookupData[spellName]["CHECK"]=false
                HealBot_SpellID_LookupData[spellName]["ID"]=spellID
                table.insert(HealBot_SpellID_LookupIdx,spellName)
                HealBot_Timers_Set("OOC","BuffIdLookup",true)
            end
        end
        HealBot_AuraBuffCache[spellID]["priority"]=HealBot_Globals.CustomBuffs[spellName] or HealBot_Globals.CustomBuffs[spellID] or 20
        if HealBot_AuraBuffCache[spellID]["priority"]<10 then
            HealBot_AuraBuffCache[spellID]["pid"]="x0"..HealBot_AuraBuffCache[spellID]["priority"]..spellID
        else
            HealBot_AuraBuffCache[spellID]["pid"]="x"..HealBot_AuraBuffCache[spellID]["priority"]..spellID
        end
        HealBot_Aura_IconSet[spellID]=HealBot_BuffIconSet[spellID] or HealBot_BuffIconSet[spellName] or 1
        HealBot_AuraBuffCache[spellID]["always"]=false
        HealBot_AuraBuffCache[spellID]["isCustom"]=false
        uaBuffData[button.id][uaSlot].isCurrent=false
        HealBot_AuraBuffCache[spellID].reset=false
    end
end

local function HealBot_Aura_PostUpdateUnitBuffsCurrent(button, spellID, spellName, count, casterIsPlayer)
    HealBot_UnitBuffCurrent[button.guid][spellName]=true
    HealBot_Aura_BuffUpdate_Plugins(button, spellName, HealBot_Globals.CustomBuffTag[spellID] or HealBot_BuffTagNames[spellName], count, true, casterIsPlayer)
end

function HealBot_Aura_FilterNone(button)
    return true
end

function HealBot_Aura_FilterTanks(button)
    if button.roletxt == "TANK" then
        return true
    else
        return false
    end
end

function HealBot_Aura_FilterHealers(button)
    if button.roletxt == "HEALER" then
        return true
    else
        return false
    end
end

function HealBot_Aura_FilterDamagers(button)
    if button.roletxt == "DAMAGER" then
        return true
    else
        return false
    end
end

function HealBot_Aura_FilterManaUsers(button)
    if button.mana.type == 0 then 
        return true
    else
        return false
    end
end

function HealBot_Aura_FilterNonManaUsers(button)
    if button.mana.type ~= 0 then 
        return true
    else
        return false
    end
end

function HealBot_Aura_FilterOwnGroup(button)
    if HealBot_Data["PGROUP"] == button.group then
        return true
    else
        return false
    end
end

function HealBot_Aura_FilterPC(button)
    return button.isplayer
end

function HealBot_Aura_FilterNPC(button)
    if button.isplayer then
        return false
    else
        return true
    end
end

function HealBot_Aura_FilterPrivFocus(button)
    if HealBot_Config.PrivFocus == button.guid then
        return true
    else
        return false
    end
end

function HealBot_Aura_FilterPrivList(button)
    return HealBot_Panel_IsPrivateList(button.guid)
end

function HealBot_Aura_FilterPrivTanks(button)
    return HealBot_Panel_IsPrivateTank(button.guid)
end

function HealBot_Aura_FilterPrivHealers(button)
    return HealBot_Panel_IsPrivateHealer(button.guid)
end

function HealBot_Aura_FilterPrivDamagers(button)
    return HealBot_Panel_IsPrivateDamager(button.guid)
end

local hbAuraFilterFuncs={[1]=HealBot_Aura_FilterNone,
                         [2]=HealBot_Aura_FilterTanks,
                         [3]=HealBot_Aura_FilterHealers,
                         [4]=HealBot_Aura_FilterDamagers,
                         [5]=HealBot_Aura_FilterManaUsers,
                         [6]=HealBot_Aura_FilterNonManaUsers,
                         [7]=HealBot_Aura_FilterOwnGroup,
                         [8]=HealBot_Aura_FilterPC,
                         [9]=HealBot_Aura_FilterNPC,
                        [10]=HealBot_Aura_FilterPrivFocus,
                        [11]=HealBot_Aura_FilterPrivList,
                        [12]=HealBot_Aura_FilterPrivTanks,
                        [13]=HealBot_Aura_FilterPrivHealers,
                        [14]=HealBot_Aura_FilterPrivDamagers,}
                 
local function HealBot_Aura_FilterUnitBuffs(button, selfOnly)
    if not uaUnitCaster then 
        uaUnitCaster="nil"
        uaUnitIsPlayer=false
    elseif UnitIsUnit(uaUnitCaster,"player") then
        uaUnitIsPlayer=true
    else
        uaUnitIsPlayer=false
    end
    if (uaUnitIsPlayer or not selfOnly) then
        if HealBot_BuffFilter[uaSpellId] then
            return hbAuraFilterFuncs[HealBot_BuffFilter[uaSpellId]](button)
        elseif HealBot_BuffFilter[uaName] then
            return hbAuraFilterFuncs[HealBot_BuffFilter[uaName]](button)
        else
            return true
        end
    else
        return false
    end
end
        
local function HealBot_Aura_UpdateUnitBuffsData(button, selfOnly, gSlot)
      --HealBot_setCall("HealBot_Aura_UpdateUnitBuffsData", button)
      
    if uaExpirationTime then
        if not HealBot_ExcludeBuffInCache[uaSpellId] and uaSlot<20 and HealBot_Aura_FilterUnitBuffs(button, selfOnly) then
            uaSlot=uaSlot+1
            uaExpirationTime=HealBot_Util_Round(uaExpirationTime,1)
            if uaBuffData[button.id][uaSlot].spellId~=uaSpellId or uaBuffData[button.id][uaSlot].sourceUnit~=(uaUnitCaster or "nil") then 
                uaBuffData[button.id][uaSlot].name=uaName
                if BleedList[uaSpellId] and (not uaDebuffType or not HealBot_Options_retDebuffCureType(uaDebuffType)) then
                    uaBuffData[button.id][uaSlot].debuffType=HEALBOT_BLEED_en
                else
                    uaBuffData[button.id][uaSlot].debuffType=uaDebuffType
                end
                uaBuffData[button.id][uaSlot].duration=uaDuration or 15
                uaBuffData[button.id][uaSlot].sourceUnit=uaUnitCaster
                uaBuffData[button.id][uaSlot].sourceUnitIsPlayer=uaUnitIsPlayer
                uaBuffData[button.id][uaSlot].spellId=uaSpellId
                if not HealBot_AuraBuffCache[uaSpellId] or not HealBot_AuraBuffCache[uaSpellId].always then
                    uaBuffData[button.id][uaSlot].isCurrent=false
                end
                if uaName == HEALBOT_RENEWING_MIST_NAME and (not hbTextureUpdateId[button.id][uaName] or (hbTextureUpdateId[button.id][uaName]+1)<uaExpirationTime) then
                    hbTextureUpdateId[button.id][uaName]=uaExpirationTime
                    hbTextureUpdateTime[button.id][uaSpellId]=HealBot_TimeNow+8
                end
            end
            uaBuffData[button.id][uaSlot].icon=uaTexture
            uaBuffData[button.id][uaSlot].count=uaCount
            uaBuffData[button.id][uaSlot].expirationTime=uaExpirationTime
            uaBuffData[button.id].lastslot=uaSlot
            uaBuffData[button.id][uaSlot].gSlot=gSlot
            HealBot_Aura_PostUpdateUnitBuffsData(button, uaSpellId, uaName)
        end
        HealBot_Aura_PostUpdateUnitBuffsCurrent(button, uaSpellId, uaName, uaCount, uaUnitIsPlayer)
    end
end

function HealBot_Aura_StartCheckClassicAbsorbs(button)
    for n,_ in pairs(hbClassicAbsorbsTrack[button.id]) do
        hbClassicAbsorbsTrack[button.id][n]=false
    end
end

function HealBot_Aura_CheckClassicAbsorbs(button)
    if HealBot_Classic_Absorbs[uaName] then
        hbClassicAbsorbsAmount[button.id][uaName]=0
        if uaExtra17 and type(uaExtra17) == "number" then
            hbClassicAbsorbsAmount[button.id][uaName]=uaExtra17
        end
        if uaExtra18 and type(uaExtra18) == "number" and uaExtra18>hbClassicAbsorbsAmount[button.id][uaName] then
            hbClassicAbsorbsAmount[button.id][uaName]=uaExtra18
        end
        if uaExtra19 and type(uaExtra19) == "number" and uaExtra19>hbClassicAbsorbsAmount[button.id][uaName] then
            hbClassicAbsorbsAmount[button.id][uaName]=uaExtra19
        end
        hbClassicAbsorbsTrack[button.id][uaName]=true
    end
end

local hbClassicAbsorbValues=0
function HealBot_Aura_EndCheckClassicAbsorbs(button)
    hbClassicAbsorbValues=0
    for n,t in pairs(hbClassicAbsorbsTrack[button.id]) do
        if not hbClassicAbsorbsTrack[button.id][n] then
            hbClassicAbsorbsTrack[button.id][n]=nil;
        else
            hbClassicAbsorbValues=hbClassicAbsorbValues+hbClassicAbsorbsAmount[button.id][n]
        end
    end
    if button.health.auraabsorbs~=hbClassicAbsorbValues then
        button.health.auraabsorbs=hbClassicAbsorbValues
        HealBot_AbsorbsUpdate(button)
    end
end

local hbClassicAbsorbTotal=0
function HealBot_Aura_UpdateUnitBuffsV1(button, selfOnly)
      --HealBot_setCall("HealBot_Aura_UpdateUnitBuffsV1", button)
    uaZ=1
    hbClassicAbsorbTotal=0
    while true do
        uaName, uaTexture, uaCount, uaDebuffType, uaDuration, uaExpirationTime, uaUnitCaster, _, _, uaSpellId, _, _, _, _, _, _, uaExtra17, uaExtra18, uaExtra19=UnitAura(button.unit,uaZ,"HELPFUL")
        if uaSpellId then
            HealBot_Aura_UpdateUnitBuffsData(button, selfOnly, uaZ)
            if HealBot_Classic_Absorbs[uaName] then
                hbClassicAbsorbValues=(HealBot_Classic_Absorbs[uaName][uaSpellId] or HealBot_Classic_Absorbs[uaName][0] or 0) + (classicAbsorbBonusV1[button.guid] or classicAbsorbBonusV1["DEFAULT"])
                hbClassicAbsorbTotal=hbClassicAbsorbTotal+hbClassicAbsorbValues
                if HealBot_Classic_AbsorbsV1Track[uaName]~=uaExpirationTime then
                    HealBot_Classic_AbsorbsV1Track[uaName]=uaExpirationTime
                    button.health.auraabsorbs=0
                end
            end
            uaZ=uaZ+1
        else
            break
        end
    end
    if button.health.auraabsorbs~=hbClassicAbsorbTotal then
        button.health.auraabsorbs=hbClassicAbsorbTotal
        HealBot_AbsorbsUpdate(button)
    end
end

function HealBot_Aura_UpdateUnitBuffsV2(button, selfOnly)
      --HealBot_setCall("HealBot_Aura_UpdateUnitBuffsV2", button)
    uaZ=1
    HealBot_Aura_StartCheckClassicAbsorbs(button)
    while true do
        uaName, uaTexture, uaCount, uaDebuffType, uaDuration, uaExpirationTime, uaUnitCaster, _, _, uaSpellId, _, _, _, _, _, _, uaExtra17, uaExtra18, uaExtra19=UnitBuff(button.unit,uaZ)
        if uaSpellId then
            HealBot_Aura_UpdateUnitBuffsData(button, selfOnly, uaZ)
            HealBot_Aura_CheckClassicAbsorbs(button)
            uaZ=uaZ+1
        else
            break
        end
    end
    HealBot_Aura_EndCheckClassicAbsorbs(button)
end

function HealBot_Aura_UpdateUnitBuffsV9(button, selfOnly)
      --HealBot_setCall("HealBot_Aura_UpdateUnitBuffsV9", button)
    uaZ=1
    AuraUtil.ForEachAura(button.unit, "HELPFUL", nil, function(...)
        uaName, uaTexture, uaCount, uaDebuffType, uaDuration, uaExpirationTime, uaUnitCaster, _, _, uaSpellId=...
        HealBot_Aura_UpdateUnitBuffsData(button, selfOnly, uaZ)
        uaZ=uaZ+1
    end)
end

local HealBot_Aura_UpdateUnitBuffs=HealBot_Aura_UpdateUnitBuffsV2
if HEALBOT_GAME_VERSION>8 then
    HealBot_Aura_UpdateUnitBuffs=HealBot_Aura_UpdateUnitBuffsV9
elseif HEALBOT_GAME_VERSION<2 then
    HealBot_Aura_UpdateUnitBuffs=HealBot_Aura_UpdateUnitBuffsV1
end

function HealBot_Aura_PostUpdateUnitDebuffsData(button, spellID, spellName, debuffType)
      --HealBot_setCall("HealBot_Aura_PostUpdateUnitDebuffsData", button)
    if not HealBot_AuraDebuffCache[spellID] or HealBot_AuraDebuffCache[spellID].reset then
        if not HealBot_AuraDebuffCache[spellID] then 
            HealBot_AuraDebuffCache[spellID]={} 
            HealBot_AuraDebuffCache[spellID]["priority"]=99
            HealBot_AuraDebuffCache[spellID]["name"]=spellName
            HealBot_Aura_ID[spellName]=spellID
            if not HealBot_Globals.CustomDebuffs[spellID] then
                HealBot_Aura_AutoUpdateCustomDebuff(button, spellName, spellID)
            end
            if HealBot_Aura_CanDispel[spellID] == nil then
                local aSpellId=nil
                if HEALBOT_GAME_VERSION>8 then
                    AuraUtil.ForEachAura(button.unit, "HARMFUL|RAID", nil, function(...)
                        _, _, _, _, _, _, _, _, _, aSpellId=...
                        HealBot_Aura_CanDispel[aSpellId]=true
                    end)
                else
                    local aId=1
                    while true do
                        _, _, _, _, _, _, _, _, _, aSpellId=UnitAura(button.unit,aId,"HARMFUL|RAID")
                        if aSpellId then
                            aId=aId+1
                            HealBot_Aura_CanDispel[aSpellId]=true
                        else
                            break
                        end
                    end
                end
                if HealBot_Aura_CanDispel[spellID] == nil then
                    HealBot_Aura_CanDispel[spellID]=false
                end
            end
        end
        HealBot_Aura_IconSet[spellID]=HealBot_DebuffIconSet[spellID] or HealBot_DebuffIconSet[spellName] or 1
        HealBot_AuraDebuffCache[spellID]["customPrio"], HealBot_AuraDebuffCache[spellID]["typePrio"]=HealBot_Options_retDebuffPriority(spellID, spellName, debuffType)
        uaDebuffData[button.id][uaSlot].isCurrent=false
        HealBot_AuraDebuffCache[spellID].reset=false
    elseif (hbDebuffOnCD[debuffType] or 0)>=(HealBot_TimeNow-2) then
        uaDebuffData[button.id][uaSlot].isCurrent=false
    end
end

function HealBot_Aura_PostUpdateUnitDebuffsCurrent(button, spellID, spellName, count, casterIsPlayer)
    HealBot_UnitDebuffCurrent[button.guid][spellName]=true
    HealBot_Aura_DebuffUpdate_Plugins(button, spellName, HealBot_Globals.CDCTag[spellID] or HealBot_DebuffTagNames[spellName], count, true, casterIsPlayer)
end

local function HealBot_Aura_FilterUnitDebuffs(button, selfOnly)
    if not uaUnitCaster then 
        uaUnitCaster="nil"
        uaUnitIsPlayer=false
    elseif UnitIsUnit(uaUnitCaster,"player") then
        uaUnitIsPlayer=true
    else
        uaUnitIsPlayer=false
    end
    if (uaUnitIsPlayer or not selfOnly) then
        if HealBot_DebuffFilter[uaSpellId] then
            return hbAuraFilterFuncs[HealBot_DebuffFilter[uaSpellId]](button)
        elseif HealBot_DebuffFilter[uaName] then
            return hbAuraFilterFuncs[HealBot_DebuffFilter[uaName]](button)
        else
            return true
        end
    else
        return false
    end
end

--BleedList[32407]="Strange Aura"
local function HealBot_Aura_UpdateUnitDebuffsData(button, selfOnly, gSlot)
      --HealBot_setCall("HealBot_Aura_UpdateUnitDebuffsData", button)
    if uaExpirationTime then
        if uaSlot<20 and HealBot_Aura_FilterUnitDebuffs(button, selfOnly) then
            --if uaSpellId == 32407 or uaName == "Strange Aura" then
            --    uaDebuffType=HEALBOT_DISEASE_en
            --    uaDebuffType=HEALBOT_MAGIC_en
            --    uaDebuffType=HEALBOT_CURSE_en
            --    uaDebuffType=HEALBOT_POISON_en
            --    uaDebuffType=HEALBOT_BLEED_en
            --    HealBot_Aura_CanDispel[uaSpellId]=true
            --    HealBot_Aura_IconSet[uaSpellId].spellId]=3
            --end
            uaSlot=uaSlot+1
            uaExpirationTime=HealBot_Util_Round(uaExpirationTime,1)
            if uaDebuffData[button.id][uaSlot].spellId~=uaSpellId or uaDebuffData[button.id][uaSlot].sourceUnit~=(uaUnitCaster or "nil") then 
                uaDebuffData[button.id][uaSlot].name=uaName
                if BleedList[uaSpellId] and (not uaDebuffType or not HealBot_Options_retDebuffCureSpell(uaDebuffType)) then
                    uaDebuffData[button.id][uaSlot].debuffType=HEALBOT_BLEED_en
                else
                    uaDebuffData[button.id][uaSlot].debuffType=uaDebuffType or "nil"
                end
                uaDebuffData[button.id][uaSlot].duration=uaDuration or 15
                uaDebuffData[button.id][uaSlot].sourceUnit=uaUnitCaster
                uaDebuffData[button.id][uaSlot].sourceUnitIsPlayer=uaUnitIsPlayer
                uaDebuffData[button.id][uaSlot].spellId=uaSpellId
                uaDebuffData[button.id][uaSlot].isBossAura=uaIsBossDebuff
                if not HealBot_AuraDebuffCache[uaSpellId] or not HealBot_AuraDebuffCache[uaSpellId].always then
                    uaDebuffData[button.id][uaSlot].isCurrent=false
                end
            end
            uaDebuffData[button.id][uaSlot].icon=uaTexture
            uaDebuffData[button.id][uaSlot].count=uaCount
            uaDebuffData[button.id][uaSlot].expirationTime=uaExpirationTime
            uaDebuffData[button.id].lastslot=uaSlot
            uaDebuffData[button.id][uaSlot].gSlot=gSlot
            HealBot_Aura_PostUpdateUnitDebuffsData(button, uaSpellId, uaName, uaDebuffData[button.id][uaSlot].debuffType)
        end
        HealBot_Aura_PostUpdateUnitDebuffsCurrent(button, uaSpellId, uaName, uaCount, uaUnitIsPlayer)
    end
end

function HealBot_Aura_IsBoss(unit)
      --HealBot_setCall("HealBot_Aura_IsBoss", nil, nil, unit)
    if unit and (UnitClassification(unit) == "worldboss" or (UnitClassification(unit) == 'elite' and (UnitLevel(unit) == -1 or UnitHealthMax(unit)>HealBot_Aura_luVars["bossHlth"]))) then
        return true
    else
        return false
    end
end

function HealBot_Aura_UpdateUnitDebuffsV2(button, selfOnly)
      --HealBot_setCall("HealBot_Aura_UpdateUnitDebuffsV2", button)
    uaZ=1
    while true do
        uaName, uaTexture, uaCount, uaDebuffType, uaDuration, uaExpirationTime, uaUnitCaster, _, _, uaSpellId=UnitDebuff(button.unit,uaZ)
        if uaSpellId then
            uaIsBossDebuff=HealBot_Aura_IsBoss(uaUnitCaster)
            HealBot_Aura_UpdateUnitDebuffsData(button, selfOnly, uaZ)
            uaZ=uaZ+1
        else
            break
        end
    end
end

function HealBot_Aura_UpdateUnitDebuffsV9(button, selfOnly)
      --HealBot_setCall("HealBot_Aura_UpdateUnitDebuffsV9", button)
    uaZ=1
    AuraUtil.ForEachAura(button.unit, "HARMFUL", nil, function(...)
        uaName, uaTexture, uaCount, uaDebuffType, uaDuration, uaExpirationTime, uaUnitCaster, _, _, uaSpellId, _, uaIsBossDebuff=...
        HealBot_Aura_UpdateUnitDebuffsData(button, selfOnly, uaZ)
        uaZ=uaZ+1
    end)
end

local HealBot_Aura_UpdateUnitDebuffs=HealBot_Aura_UpdateUnitDebuffsV2
if HEALBOT_GAME_VERSION>8 then
    HealBot_Aura_UpdateUnitDebuffs=HealBot_Aura_UpdateUnitDebuffsV9
end

function HealBot_Aura_ClearUnitBuffOverDebuff(button, callerIsBuff)
      --HealBot_setCall("HealBot_Aura_ClearUnitBuffOverDebuff", button)
    button.aura.buff.overdb=false
    button.aura.debuff.bodupd=true
    if callerIsBuff then HealBot_Events_UnitDebuff(button) end
end

local hbOverDebuff=false
function HealBot_Aura_SetUnitBuffOverDebuff(button, dCol)
      --HealBot_setCall("HealBot_Aura_SetUnitBuffOverDebuff", button)
    button.aura.debuff.colbar=dCol
    button.aura.buff.overdb=true
    hbOverDebuff=true
end

function HealBot_Aura_CheckUnitBuffOverDebuff(button, callerIsBuff)
      --HealBot_setCall("HealBot_Aura_CheckUnitBuffOverDebuff", button)
    hbOverDebuff=false
    if button.aura.debuff.colbar>0 and button.aura.buff.colbar>0 then
        if button.aura.buff.priority<button.aura.debuff.priority then
            if (button.aura.buff.colbar<5 or button.aura.buff.colbar == 7) and (button.aura.debuff.colbar<5 or button.aura.debuff.colbar == 7) then
                if button.aura.buff.colbar == button.aura.debuff.colbar or (button.aura.buff.colbar == 2 and button.aura.debuff.colbar<4) then
                    HealBot_Aura_SetUnitBuffOverDebuff(button, 0)
                elseif button.aura.debuff.colbar == 2 then
                    if button.aura.buff.colbar == 1 then
                        HealBot_Aura_SetUnitBuffOverDebuff(button, 3)
                    elseif button.aura.buff.colbar == 3 then
                        HealBot_Aura_SetUnitBuffOverDebuff(button, 1)
                    end
                end
            end
        end
    end
    if button.aura.buff.overdb and not hbOverDebuff then
        HealBot_Aura_ClearUnitBuffOverDebuff(button, callerIsBuff)
    end
end

local buffBarCol,buffPrio,buffIconIndex=0,99,0
function HealBot_Aura_CheckUnitBuffs(button, selfOnly)
      --HealBot_setCall("HealBot_Aura_CheckUnitBuffs", button)
    if buffCheck and (not button.status.isdead or button.status.isspirit) then
        prevMissingbuff=button.aura.buff.missingbuff
        button.aura.buff.missingbuff=false
        button.aura.buff.priority=99
        button.aura.buff.colbar=0
        curBuffName=false;

        if generalBuffs and HealBot_Data["PALIVE"] then
            if button.player then
                onlyPlayers=true
            elseif HEALBOT_GAME_VERSION>3 then
                onlyPlayers=button.isplayer or button.isgroupraid
            else
                onlyPlayers=UnitIsFriend("player",button.unit)
            end
            if onlyPlayers then 
                for x,_ in pairs(PlayerBuffs) do
                    PlayerBuffs[x]=false;
                end
                for x,_ in pairs(PlayerBuffTypes) do
                    PlayerBuffTypes[x]=false;
                end
                ownBlessing=false
            end
        else
            onlyPlayers=false
        end

        if button.aura.buff.update then
            if not HealBot_UnitBuffCurrent[button.guid] then HealBot_UnitBuffCurrent[button.guid]={} end
            for bName, _ in pairs(HealBot_UnitBuffCurrent[button.guid]) do
                HealBot_UnitBuffCurrent[button.guid][bName]=false
            end
            button.aura.buff.update=false
            button.aura.buff.temp.active=false
            uaSlot=0
            uaBuffData[button.id].lastslot=0
            HealBot_Aura_UpdateUnitBuffs(button, selfOnly)
            for bName, _ in pairs(HealBot_UnitBuffCurrent[button.guid]) do
                if not HealBot_UnitBuffCurrent[button.guid][bName] then
                    HealBot_UnitBuffCurrent[button.guid][bName]=nil
                    HealBot_Aura_BuffUpdate_Plugins(button, bName, HealBot_Globals.CustomBuffTag[HealBot_Aura_ID[bName]] or HealBot_BuffTagNames[bName], 0, false)
                end
            end
        end
        for z=1,3 do
            HealBot_Aura_prevIconCount["BUFF"][z]=button.icon.buff.count[z]
            for x,_ in pairs(buffSort[z]) do
                buffSort[z][x]=nil;
            end
        end
        if uaBuffData[button.id].lastslot>0 then
            for x=1,uaBuffData[button.id].lastslot do
                uaBuffSlot=x
                HealBot_Aura_CheckUnitBuff(button)
            end
        end
    --    if buffCheck then
            if onlyPlayers then
                HealBot_Aura_CheckGeneralBuff(button)
            end
            buffIconIndex=HealBot_Aura_SortBuffIcons(button)
            HealBot_Aura_CheckUnitBuffIcons(button)

            if not curBuffName then
                if buffIconIndex>0 then
                    button.aura.buff.id=HealBot_UnitBuffIcons[button.id][buffIconIndex]["spellId"]
                    curBuffName=HealBot_AuraBuffCache[button.aura.buff.id]["name"]
                    buffPrio=HealBot_AuraBuffCache[button.aura.buff.id]["priority"]
                elseif button.aura.buff.temp.active then
                    button.aura.buff.id=button.aura.buff.temp.id
                    curBuffName=button.aura.buff.temp.name
                    buffPrio=button.aura.buff.temp.priority
                end
                if curBuffName then
                    if HealBot_AuraBuffCache[button.aura.buff.id].isAuto then
                        buffBarCol=HealBot_Globals.CustomBuffsShowBarCol[HEALBOT_CUSTOM_CAT_CUSTOM_AUTOBUFFS] or 1
                    else
                        buffBarCol=HealBot_Globals.CustomBuffsShowBarCol[button.aura.buff.id] or 
                                   HealBot_Globals.CustomBuffsShowBarCol[HealBot_AuraBuffCache[button.aura.buff.id]["name"]] or 1
                    end
                    if buffBarCol>1 and button.aura.buff.colbar == 0 then
                        button.aura.buff.colbar=buffBarCol-1
                        button.aura.buff.priority=buffPrio
                        HealBot_Aura_CheckUnitBuffOverDebuff(button, true)
                    elseif button.aura.buff.overdb then
                        HealBot_Aura_ClearUnitBuffOverDebuff(button)
                    end
                end
            end
            if curBuffName then               
                if prevMissingbuff~=button.aura.buff.missingbuff or HealBot_Aura_luVars["updateAll"] then
                    button.aura.buff.name="needUpdate"
                end
                HealBot_Aura_BuffWarnings(button, curBuffName)
            else
                HealBot_Aura_ClearBuff(button)
            end
    --    else
    --        HealBot_Aura_ClearBuff(button)
    --    end
    else
        button.aura.buff.missingbuff=false
        HealBot_Aura_ClearBuff(button)
    end
    if button.text.tagbuff and not button.aura.buff.missingbuff then
        HealBot_Text_setNameTag(button)
    end
end

function HealBot_Aura_resetSpellCD()
      --HealBot_setCall("HealBot_Aura_resetSpellCD")
    hbDebuffOnCD[HEALBOT_DISEASE_en]=0
    hbDebuffOnCD[HEALBOT_MAGIC_en]=0
    hbDebuffOnCD[HEALBOT_CURSE_en]=0
    hbDebuffOnCD[HEALBOT_POISON_en]=0
    hbDebuffOnCD[HEALBOT_BLEED_en]=0
end
hbDebuffOnCD[HEALBOT_DISEASE_en]=0
hbDebuffOnCD[HEALBOT_MAGIC_en]=0
hbDebuffOnCD[HEALBOT_CURSE_en]=0
hbDebuffOnCD[HEALBOT_POISON_en]=0
hbDebuffOnCD[HEALBOT_BLEED_en]=0

function HealBot_Aura_setDebuffTypeCD(dType, eTime)
    hbDebuffOnCD[dType]=eTime
end

HealBot_Aura_luVars["bossHlth"]=250000
function HealBot_Aura_SetBossHealth(inInst)
      --HealBot_setCall("HealBot_Aura_SetBossHealth")
    if HealBot_Data["PLEVEL"]<50 then
        HealBot_Aura_luVars["bossHlth"]=HealBot_Data["PLEVEL"]*750
    elseif HealBot_Data["PLEVEL"]<60 then
        HealBot_Aura_luVars["bossHlth"]=HealBot_Data["PLEVEL"]*900
    elseif HealBot_Data["PLEVEL"]<70 then
        HealBot_Aura_luVars["bossHlth"]=HealBot_Data["PLEVEL"]*1000
    elseif HealBot_Data["PLEVEL"]<75 then
        HealBot_Aura_luVars["bossHlth"]=HealBot_Data["PLEVEL"]*1100
    elseif HealBot_Data["PLEVEL"]<80 then
        HealBot_Aura_luVars["bossHlth"]=HealBot_Data["PLEVEL"]*1250
    elseif HealBot_Data["PLEVEL"]<85 then
        HealBot_Aura_luVars["bossHlth"]=HealBot_Data["PLEVEL"]*1500
    else
        HealBot_Aura_luVars["bossHlth"]=250000
    end
    if inInst then
        local difficultyID=GetDungeonDifficultyID()
        if difficultyID~=1 and difficultyID~=173 then
            HealBot_Aura_luVars["bossHlth"]=HealBot_Aura_luVars["bossHlth"]*2
        end
    end
end

function HealBot_Aura_UnitDebuffsUpdateWhenActive(button)
    if uaDebuffData[button.id].lastslot>0 then
        for x=1,uaDebuffData[button.id].lastslot do
            uaDebuffData[button.id][x].isCurrent=false
        end
    end
end

local debuffBarCol,debuffIconIndex=0,0
function HealBot_Aura_CheckUnitDebuffs(button, selfOnly)
      --HealBot_setCall("HealBot_Aura_CheckUnitDebuffs", button)
    if debuffCheck and button.status.current<HealBot_Unit_Status["DEAD"] then
        for z=1,3 do
            HealBot_Aura_prevIconCount["DEBUFF"][z]=button.icon.debuff.count[z]
        end
        --button.aura.debuff.type=false
        if button.aura.debuff.update then
            if not HealBot_UnitDebuffCurrent[button.guid] then HealBot_UnitDebuffCurrent[button.guid]={} end
            for dName, _ in pairs(HealBot_UnitDebuffCurrent[button.guid]) do
                HealBot_UnitDebuffCurrent[button.guid][dName]=false
            end
            button.aura.debuff.update=false
            button.aura.debuff.temp.active=false
            uaSlot=0
            uaDebuffData[button.id].lastslot=0
            HealBot_Aura_UpdateUnitDebuffs(button, selfOnly)
            for dName, _ in pairs(HealBot_UnitDebuffCurrent[button.guid]) do
                if not HealBot_UnitDebuffCurrent[button.guid][dName] then
                    HealBot_UnitDebuffCurrent[button.guid][dName]=nil
                    HealBot_Aura_DebuffUpdate_Plugins(button, dName, HealBot_Globals.CDCTag[HealBot_Aura_ID[dName]] or HealBot_DebuffTagNames[dName], 0, false)
                end
            end
        end

        for z=1,3 do
            for x,_ in pairs(debuffSort[z]) do
                debuffSort[z][x]=nil;
            end
        end
        if uaDebuffData[button.id].lastslot>0 then
            for x=1,uaDebuffData[button.id].lastslot do
                uaDebuffSlot=x
                HealBot_Aura_CheckUnitDebuff(button)
            end
        end

        debuffIconIndex=HealBot_Aura_SortDebuffIcons(button)
        HealBot_Aura_CheckUnitDebuffIcons(button)
        if debuffIconIndex>0 then
            button.aura.debuff.id=HealBot_UnitDebuffIcons[button.id][debuffIconIndex]["spellId"]
            button.aura.debuff.priority=HealBot_AuraDebuffCache[button.aura.debuff.id]["priority"]
        elseif button.aura.debuff.temp.active then
            button.aura.debuff.id=button.aura.debuff.temp.id
            button.aura.debuff.priority=button.aura.debuff.temp.priority
        else
            button.aura.debuff.id=0
        end
        if button.aura.debuff.id>0 and HealBot_Panel_RaidPetUnitButtonCheck(button.guid) then
            if HealBot_AuraDebuffCache[button.aura.debuff.id].isAuto then 
                debuffBarCol=HealBot_Globals.CustomDebuffsShowBarCol[HEALBOT_CUSTOM_CAT_CUSTOM_AUTOMATIC] or 4
            elseif HealBot_AuraDebuffCache[button.aura.debuff.id]["debuffType"] == HEALBOT_CUSTOM_en then
                debuffBarCol=HealBot_Globals.CustomDebuffsShowBarCol[button.aura.debuff.id] or 
                             HealBot_Globals.CustomDebuffsShowBarCol[HealBot_AuraDebuffCache[button.aura.debuff.id]["name"]] or 4
            else
                debuffBarCol=HealBot_Globals.CustomDebuffsShowBarCol["DEFAULT"] or 4
            end
            button.aura.debuff.dispellable=HealBot_Aura_CanDispel[button.aura.debuff.id]
            button.aura.debuff.colbar=debuffBarCol-1
            HealBot_Aura_CheckUnitBuffOverDebuff(button)
            if button.aura.debuff.type~=HealBot_AuraDebuffCache[button.aura.debuff.id]["debuffType"] or button.aura.debuff.bodupd then
                button.aura.debuff.bodupd=false
                button.aura.debuff.name="needUpdate"
                button.aura.debuff.type=HealBot_AuraDebuffCache[button.aura.debuff.id]["debuffType"]
            end
            HealBot_Aura_DebuffWarnings(button, HealBot_AuraDebuffCache[button.aura.debuff.id]["name"], false, debuffIconIndex)
        else
            HealBot_Aura_ClearDebuff(button)
        end
    else
        HealBot_Aura_ClearDebuff(button)
    end
end

function HealBot_Aura_CheckUnitAuras(button, debuff, selfOnly)
      --HealBot_setCall("HealBot_Aura_CheckUnitAuras", button)
    if not HealBot_Aura_luVars["TestBarsOn"] then
        if debuff then
            HealBot_Aura_CheckUnitDebuffs(button, selfOnly)
        else
            HealBot_Aura_CheckUnitBuffs(button, selfOnly)
        end
    end
end

local lowTime=0
function HealBot_Aura_ResetCheckBuffsTime(button)
      --HealBot_setCall("HealBot_Aura_ResetCheckBuffsTime", button)
    lowTime=HealBot_TimeNow+10000000
    PlayerBuffsList=button.aura.buff.recheck
    button.aura.buff.resetcheck=false
    button.aura.buff.nextcheck=false
    for name,nexttime in pairs (PlayerBuffsList) do
        if nexttime<0 then
            PlayerBuffsList[name]=nil
        elseif nexttime < lowTime then
            lowTime=nexttime
            if nexttime<HealBot_TimeNow+5 then nexttime=HealBot_TimeNow+5 end
            button.aura.buff.nextcheck=nexttime
        end
    end
end

function HealBot_Aura_MarkCheckBuffsTime(button)
        --HealBot_setCall("HealBot_Aura_MarkCheckBuffsTime", button)
    if not button.aura.buff.nextcheck then button.aura.buff.nextcheck=HealBot_TimeNow+5 end
    button.aura.buff.resetcheck=true
end

function HealBot_Aura_SetAuraWarningFlags()
        --HealBot_setCall("HealBot_Aura_SetAuraWarningFlags")
    if HealBot_Config_Buffs.SoundBuffWarning or HealBot_Config_Buffs.ShowBuffWarning then
        buffWarnings=true
    else
        buffWarnings=false
    end
    if HealBot_Config_Cures.SoundDebuffWarning or HealBot_Config_Cures.ShowDebuffWarning then
        debuffWarnings=true
    else
        debuffWarnings=false
    end
end

function HealBot_Aura_SetAuraCheckFlags(debuffMounted, buffMounted, onTaxi, resting, inVehicle)
        --HealBot_setCall("HealBot_Aura_SetAuraCheckFlags")
    tmpBCheck=buffCheck
    tmpGBuffs=generalBuffs
    tmpDCheck=debuffCheck
    tmpNumGroup=GetNumGroupMembers() or 0
    if (not HealBot_Config_Buffs.BuffWatchWhenGrouped or tmpNumGroup>0) then
        tmpBGroup=false
    else
        tmpBGroup=true
    end
    if (not HealBot_Config_Buffs.DebuffWatchWhenGrouped or tmpNumGroup>0) then
        tmpDGroup=false
    else
        tmpDGroup=true
    end

    if resting or onTaxi or buffMounted or inVehicle or tmpBGroup or not HealBot_Config_Buffs.BuffWatch then 
        buffCheck=false
        HealBot_Action_setLuVars("CheckManaDrink", false)
    elseif (HealBot_Config_Buffs.BuffCustomWatchInCombat or not HealBot_Data["UILOCK"]) then
        buffCheck=true
        if (HealBot_Config_Buffs.BuffWatchInCombat or not HealBot_Data["UILOCK"]) then
            generalBuffs=true
            if HealBot_Config_Buffs.CheckManaDrink then
                HealBot_Action_setLuVars("CheckManaDrink", true)
            else
                HealBot_Action_setLuVars("CheckManaDrink", false)
            end
        else
            generalBuffs=false
            HealBot_Action_setLuVars("CheckManaDrink", false)
        end
    else
        buffCheck=false
        HealBot_Action_setLuVars("CheckManaDrink", false)
    end

    if resting or onTaxi or debuffMounted or tmpDGroup or inVehicle or not HealBot_Config_Cures.DebuffWatch then 
        debuffCheck=false 
    elseif (HealBot_Config_Cures.DebuffWatchInCombat or not HealBot_Data["UILOCK"]) then
        debuffCheck=true
    else
        debuffCheck=false
    end
    
    if tmpBCheck~=buffCheck or tmpGBuffs~=generalBuffs then
        if tmpBCheck~=buffCheck then
            if tmpBCheck then
                HealBot_Timers_Set("AURA","RemoveAllBuffIcons")
                if HealBot_retLuVars("pluginAuraWatch") then HealBot_Plugin_AuraWatch_RemoveAllBuffAlerts() end
            elseif HealBot_retLuVars("pluginAuraWatch") then 
                HealBot_Plugin_AuraWatch_CheckAfterCancelBuff()
            end
            HealBot_ActionIcons_setLuVars("AllowBuffs", buffCheck)
            HealBot_Timers_Set("SKINS","ActionIconsStateChange",true)
        end
        HealBot_Timers_Set("AURA","CheckBuffs")
    end    
    if tmpDCheck~=debuffCheck then
        if tmpDCheck then
            HealBot_Timers_Set("AURA","RemoveAllDebuffIcons")
            if HealBot_retLuVars("pluginAuraWatch") then HealBot_Plugin_AuraWatch_RemoveAllDebuffAlerts() end
        elseif HealBot_retLuVars("pluginAuraWatch") then 
            HealBot_Plugin_AuraWatch_CheckAfterCancelDebuff()
        end
        HealBot_Timers_Set("AURA","CheckDebuffs")
        HealBot_ActionIcons_setLuVars("AllowDebuffs", debuffCheck)
        HealBot_Timers_Set("SKINS","ActionIconsStateChange",true)
    end
end

function HealBot_Aura_ClearDebuff(button)
        --HealBot_setCall("HealBot_Aura_ClearDebuff", button)
    if button.aura.debuff.name then
        button.aura.debuff.type=false;
        button.aura.debuff.name=false;
        button.aura.debuff.dispellable=false
        button.aura.debuff.colbar=0
        button.aura.debuff.curespell=false
        button.aura.debuff.id=0
        button.aura.debuff.priority=99;
        HealBot_Aura_AuxClearAuraDebuffBars(button)
        if button.hotbars.debuff then
            HealBot_Action_BarHotDisable(button, "DEBUFF")
        end
        if button.glow.debuff then
            HealBot_Action_DisableButtonGlowType(button, "DEBUFF")
        end
        if button.hazard.debuff then
            HealBot_Action_DisableBorderHazardType(button, "DEBUFF")
        end
        if button.text.tagdebuff then
            HealBot_Text_setNameTag(button)
        end
        HealBot_RefreshUnit(button)
    end
end

function HealBot_Aura_ClearBuff(button)
        --HealBot_setCall("HealBot_Aura_ClearBuff", button)
    if button.aura.buff.name then
        button.aura.buff.name=false
        button.aura.buff.colbar=0
        button.aura.buff.missingbuff=false
        if button.glow.buff then
            HealBot_Action_DisableButtonGlowType(button, "BUFF")
        end
        if button.aura.buff.overdb then
            HealBot_Aura_ClearUnitBuffOverDebuff(button)
        end
        if button.hazard.buff then
            HealBot_Action_DisableBorderHazardType(button, "BUFF")
        end
        HealBot_Aura_AuxClearAuraBuffBars(button)
        HealBot_RefreshUnit(button)
    end
end

local function HealBot_Aura_AuraWatch_PlayerBuffUpdate(guid, aura, count, active, casterIsPlayer)
    xButton, pButton=HealBot_Panel_AllUnitButton(guid)
    if xButton then HealBot_Plugin_AuraWatch_PlayerBuffUpdate(xButton, aura, count, active, casterIsPlayer) end
    if pButton then HealBot_Plugin_AuraWatch_PlayerBuffUpdate(pButton, aura, count, active, casterIsPlayer) end
end

function HealBot_Aura_BuffUpdate_Plugins(button, aura, tag, count, active, casterIsPlayer)
      --HealBot_setCall("HealBot_Aura_BuffUpdate_Plugins", button)
    if hbAuraWatch[button.guid] then
        if active and not count or count<1 then count=1 end
        if hbAuraRequests[button.guid] and hbAuraRequests[button.guid][aura] and active and button.frame<7 then
            HealBot_Plugin_Requests_CancelGUID(button.guid)
            hbAuraRequests[button.guid][aura]=false
        end
        if hbAuraBuffWatch[button.guid] and hbAuraBuffWatch[button.guid][aura] then
            if not active then
                hbAuraBuffWatch[button.guid][aura]=0
                HealBot_Aura_AuraWatch_PlayerBuffUpdate(button.guid, aura, count, active, casterIsPlayer)
            elseif hbAuraBuffWatch[button.guid][aura]~=count then
                hbAuraBuffWatch[button.guid][aura]=count
                HealBot_Aura_AuraWatch_PlayerBuffUpdate(button.guid, aura, count, active, casterIsPlayer)
            end
        end
        if hbAuraActionBuffWatch[button.guid] and hbAuraActionBuffWatch[button.guid][aura] then
            if not active then
                hbAuraActionBuffWatch[button.guid][aura]=0
                HealBot_ActionIcons_BuffUpdate(button.guid, aura, count, active, casterIsPlayer)
            elseif hbAuraActionBuffWatch[button.guid][aura]~=count then
                hbAuraActionBuffWatch[button.guid][aura]=count
                HealBot_ActionIcons_BuffUpdate(button.guid, aura, count, active, casterIsPlayer)
            end
        end
        if tag then
            if not active and ((hbAuraBuffTagWatch[button.guid] and hbAuraBuffTagWatch[button.guid][tag]) or
                               (hbAuraActionBuffTagWatch[button.guid] and hbAuraActionBuffTagWatch[button.guid][tag])) then
                if HealBot_UnitBuffCurrent[button.guid] then
                    for bName, _ in pairs(HealBot_UnitBuffCurrent[button.guid]) do
                        if (HealBot_BuffTagNames[bName] and HealBot_BuffTagNames[bName] == tag) or
                           (HealBot_Globals.CustomBuffTag[HealBot_Aura_ID[bName]] and HealBot_Globals.CustomBuffTag[HealBot_Aura_ID[bName]] == tag) then
                            active=true
                            break
                        end
                    end
                end
            end
            if hbAuraBuffTagWatch[button.guid] and hbAuraBuffTagWatch[button.guid][tag] then
                if not active then
                    hbAuraBuffTagWatch[button.guid][tag]=0
                    HealBot_Plugin_AuraWatch_PlayerBuffTagUpdate(button, tag, count, active, casterIsPlayer)
                elseif hbAuraBuffTagWatch[button.guid][tag] == 0 then
                    hbAuraBuffTagWatch[button.guid][tag]=1
                    HealBot_Plugin_AuraWatch_PlayerBuffTagUpdate(button, tag, count, active, casterIsPlayer)
                end
            end
            if hbAuraActionBuffTagWatch[button.guid] and hbAuraActionBuffTagWatch[button.guid][tag] then
                if not active then
                    hbAuraActionBuffTagWatch[button.guid][tag]=0
                    HealBot_ActionIcons_BuffTagUpdate(button.guid, tag, count, active, casterIsPlayer)
                elseif hbAuraActionBuffTagWatch[button.guid][tag] == 0 then
                    hbAuraActionBuffTagWatch[button.guid][tag]=1
                    HealBot_ActionIcons_BuffTagUpdate(button.guid, tag, count, active, casterIsPlayer)
                end
            end
        end
    end
end

local function HealBot_Aura_AuraWatch_PlayerDebuffUpdate(guid, aura, count, active, casterIsPlayer)
    xButton, pButton=HealBot_Panel_AllUnitButton(guid)
    if xButton then HealBot_Plugin_AuraWatch_PlayerDebuffUpdate(xButton, aura, count, active, casterIsPlayer) end
    if pButton then HealBot_Plugin_AuraWatch_PlayerDebuffUpdate(pButton, aura, count, active, casterIsPlayer) end
end

function HealBot_Aura_DebuffUpdate_Plugins(button, aura, tag, count, active, casterIsPlayer)
      --HealBot_setCall("HealBot_Aura_DebuffUpdate_Plugins", button)
    if hbAuraWatch[button.guid] then
        if count<1 then count=1 end
        if hbAuraDebuffWatch[button.guid] and hbAuraDebuffWatch[button.guid][aura] then
            if not active then
                hbAuraDebuffWatch[button.guid][aura]=0
                HealBot_Aura_AuraWatch_PlayerDebuffUpdate(button.guid, aura, count, active, casterIsPlayer)
            elseif hbAuraDebuffWatch[button.guid][aura]~=count then
                hbAuraDebuffWatch[button.guid][aura]=count
                HealBot_Aura_AuraWatch_PlayerDebuffUpdate(button.guid, aura, count, active, casterIsPlayer)
            end
        end
        if hbAuraActionDebuffWatch[button.guid] and hbAuraActionDebuffWatch[button.guid][aura] then
            if not active then
                hbAuraActionDebuffWatch[button.guid][aura]=0
                HealBot_ActionIcons_DebuffUpdate(button.guid, aura, count, active, casterIsPlayer)
            elseif hbAuraActionDebuffWatch[button.guid][aura]~=count then
                hbAuraActionDebuffWatch[button.guid][aura]=count
                HealBot_ActionIcons_DebuffUpdate(button.guid, aura, count, active, casterIsPlayer)
            end
        end
        if tag then
            if not active and ((hbAuraDebuffTagWatch[button.guid] and hbAuraDebuffTagWatch[button.guid][tag]) or
                               (hbAuraActionDebuffTagWatch[button.guid] and hbAuraActionDebuffTagWatch[button.guid][tag])) then
                if HealBot_UnitDebuffCurrent[button.guid] then
                    for dName, _ in pairs(HealBot_UnitDebuffCurrent[button.guid]) do
                        if (HealBot_DebuffTagNames[dName] and HealBot_DebuffTagNames[dName] == tag) or
                           (HealBot_Globals.CDCTag[HealBot_Aura_ID[dName]] and HealBot_Globals.CDCTag[HealBot_Aura_ID[dName]] == tag) then
                            active=true
                            break
                        end
                    end
                end
            end
            if hbAuraDebuffTagWatch[button.guid] and hbAuraDebuffTagWatch[button.guid][tag] then
                if not active then
                    hbAuraDebuffTagWatch[button.guid][tag]=0
                    HealBot_Plugin_AuraWatch_PlayerDebuffTagUpdate(button, tag, count, active, casterIsPlayer)
                elseif hbAuraDebuffTagWatch[button.guid][tag] == 0 then
                    hbAuraDebuffTagWatch[button.guid][tag]=1
                    HealBot_Plugin_AuraWatch_PlayerDebuffTagUpdate(button, tag, count, active, casterIsPlayer)
                end
            end
            if hbAuraActionDebuffTagWatch[button.guid] and hbAuraActionDebuffTagWatch[button.guid][tag] then
                if not active then
                    hbAuraActionDebuffTagWatch[button.guid][tag]=0
                    HealBot_ActionIcons_DebuffTagUpdate(button.guid, tag, count, active, casterIsPlayer)
                elseif hbAuraActionDebuffTagWatch[button.guid][tag] == 0 then
                    hbAuraActionDebuffTagWatch[button.guid][tag]=1
                    HealBot_ActionIcons_DebuffTagUpdate(button.guid, tag, count, active, casterIsPlayer)
                end
            end
        end
    end
end

function HealBot_Aura_ClearBuffWatch(buffName)
      --HealBot_setCall("HealBot_Aura_ClearBuffWatch")
    if buffName then
        for j=1, #HealBot_BuffWatchList do
            if buffName == HealBot_BuffWatchList[j] then
                table.remove(HealBot_BuffWatchList, j)
                break;
            end
        end
        HealBot_BuffWatch[buffName]=nil
    else
        for x,_ in pairs(HealBot_BuffWatch) do
            HealBot_BuffWatch[x]=nil;
        end
        for x,_ in pairs(HealBot_BuffWatchList) do
            HealBot_BuffWatchList[x]=nil;
        end
    end
end

local addBuffToWatch=true
function HealBot_Aura_SetBuffWatch(buffName)
      --HealBot_setCall("HealBot_Aura_SetBuffWatch")
    addBuffToWatch=true
    for j=1, #HealBot_BuffWatchList do
        if buffName == HealBot_BuffWatchList[j] then
            addBuffToWatch=false
            break;
        end
    end
    if addBuffToWatch then
        table.insert(HealBot_BuffWatchList,buffName)
    end
    HealBot_BuffWatch[buffName]=true
end

function HealBot_Aura_ClearCheckBuffs()
      --HealBot_setCall("HealBot_Aura_ClearCheckBuffs")
    for x,_ in pairs(HealBot_CheckBuffs) do
        HealBot_CheckBuffs[x]=nil;
    end
end

function HealBot_Aura_SetCheckBuffs(buffName)
      --HealBot_setCall("HealBot_Aura_SetCheckBuffs")
    HealBot_CheckBuffs[buffName]=true;
end

local isBuffSpellName=""
function HealBot_Aura_IsBuffSpell(spellId)
      --HealBot_setCall("HealBot_Aura_IsBuffSpell")
    isBuffSpellName=HealBot_WoWAPI_SpellName(spellId) or spellId
    return HealBot_CheckBuffs[isBuffSpellName]
end

function HealBot_Aura_RetMyBuffTime(button,buffName)
      --HealBot_setCall("HealBot_Aura_RetMyBuffTime", button)
    if not button.aura.buff.recheck[buffName] then return end
    if HealBot_ShortBuffs[buffName] then
        return button.aura.buff.recheck[buffName]+HealBot_Config_Buffs.ShortBuffTimer
    else
        return button.aura.buff.recheck[buffName]+HealBot_Config_Buffs.LongBuffTimer
    end
end

local rdType=HEALBOT_CUSTOM_en
function HealBot_Aura_retDebufftype(id)
      --HealBot_setCall("HealBot_Aura_retDebufftype")
    rdType=HEALBOT_CUSTOM_en
    if HealBot_AuraDebuffCache[id] then rdType=HealBot_AuraDebuffCache[id]["debuffType"] end
    return rdType
end

function HealBot_Aura_UpdateActiveDebuffs()
    for _,xButton in pairs(HealBot_Unit_Button) do
        if uaDebuffData[xButton.id].lastslot>0 then
            for x=1,uaDebuffData[xButton.id].lastslot do
                uaDebuffData[xButton.id][x].isCurrent=false
            end
            HealBot_Events_UnitDebuff(xButton)
        end
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        if uaDebuffData[xButton.id].lastslot>0 then
            for x=1,uaDebuffData[xButton.id].lastslot do
                uaDebuffData[xButton.id][x].isCurrent=false
            end
            HealBot_Events_UnitDebuff(xButton)
        end
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        if uaDebuffData[xButton.id].lastslot>0 then
            for x=1,uaDebuffData[xButton.id].lastslot do
                uaDebuffData[xButton.id][x].isCurrent=false
            end
            HealBot_Events_UnitDebuff(xButton)
        end
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        if uaDebuffData[xButton.id].lastslot>0 then
            for x=1,uaDebuffData[xButton.id].lastslot do
                uaDebuffData[xButton.id][x].isCurrent=false
            end
            HealBot_Events_UnitDebuff(xButton)
        end
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        if uaDebuffData[xButton.id].lastslot>0 then
            for x=1,uaDebuffData[xButton.id].lastslot do
                uaDebuffData[xButton.id][x].isCurrent=false
            end
            HealBot_Events_UnitDebuff(xButton)
        end
    end
end

function HealBot_Aura_UpdateAllBuffIcons(button)
      --HealBot_setCall("HealBot_Aura_UpdateAllBuffIcons", button)
    if button then
        for i=1,button.icon.buff.count[1] do
            HealBot_Aura_UpdateBuffIcon(button, HealBot_UnitBuffIcons[button.id][i], i, false, HealBot_UnitBuffIcons[button.id][i]["spellId"])
        end
        for i=9,button.icon.buff.count[2]+8 do
            HealBot_Aura_UpdateBuffIcon(button, HealBot_UnitBuffIcons[button.id][i], i, false, HealBot_UnitBuffIcons[button.id][i]["spellId"])
        end
        for i=11,button.icon.buff.count[3]+10 do
            HealBot_Aura_UpdateBuffIcon(button, HealBot_UnitBuffIcons[button.id][i], i, false, HealBot_UnitBuffIcons[button.id][i]["spellId"])
        end
    else
        for _,xButton in pairs(HealBot_Unit_Button) do
            for i=1,xButton.icon.buff.count[1] do
                HealBot_Aura_UpdateBuffIcon(xButton, HealBot_UnitBuffIcons[xButton.id][i], i, false, HealBot_UnitBuffIcons[xButton.id][i]["spellId"])
            end
            for i=9,xButton.icon.buff.count[2]+8 do
                HealBot_Aura_UpdateBuffIcon(xButton, HealBot_UnitBuffIcons[xButton.id][i], i, false, HealBot_UnitBuffIcons[xButton.id][i]["spellId"])
            end
            for i=11,xButton.icon.buff.count[3]+10 do
                HealBot_Aura_UpdateBuffIcon(xButton, HealBot_UnitBuffIcons[xButton.id][i], i, false, HealBot_UnitBuffIcons[xButton.id][i]["spellId"])
            end
        end
        for _,xButton in pairs(HealBot_Private_Button) do
            for i=1,xButton.icon.buff.count[1] do
                HealBot_Aura_UpdateBuffIcon(xButton, HealBot_UnitBuffIcons[xButton.id][i], i, false, HealBot_UnitBuffIcons[xButton.id][i]["spellId"])
            end
            for i=9,xButton.icon.buff.count[2]+8 do
                HealBot_Aura_UpdateBuffIcon(xButton, HealBot_UnitBuffIcons[xButton.id][i], i, false, HealBot_UnitBuffIcons[xButton.id][i]["spellId"])
            end
            for i=11,xButton.icon.buff.count[3]+10 do
                HealBot_Aura_UpdateBuffIcon(xButton, HealBot_UnitBuffIcons[xButton.id][i], i, false, HealBot_UnitBuffIcons[xButton.id][i]["spellId"])
            end
        end
        for _,xButton in pairs(HealBot_Pet_Button) do
            for i=1,xButton.icon.buff.count[1] do
                HealBot_Aura_UpdateBuffIcon(xButton, HealBot_UnitBuffIcons[xButton.id][i], i, false, HealBot_UnitBuffIcons[xButton.id][i]["spellId"])
            end
            for i=9,xButton.icon.buff.count[2]+8 do
                HealBot_Aura_UpdateBuffIcon(xButton, HealBot_UnitBuffIcons[xButton.id][i], i, false, HealBot_UnitBuffIcons[xButton.id][i]["spellId"])
            end
            for i=11,xButton.icon.buff.count[3]+10 do
                HealBot_Aura_UpdateBuffIcon(xButton, HealBot_UnitBuffIcons[xButton.id][i], i, false, HealBot_UnitBuffIcons[xButton.id][i]["spellId"])
            end
        end
        for _,xButton in pairs(HealBot_Vehicle_Button) do
            for i=1,xButton.icon.buff.count[1] do
                HealBot_Aura_UpdateBuffIcon(xButton, HealBot_UnitBuffIcons[xButton.id][i], i, false, HealBot_UnitBuffIcons[xButton.id][i]["spellId"])
            end
            for i=9,xButton.icon.buff.count[2]+8 do
                HealBot_Aura_UpdateBuffIcon(xButton, HealBot_UnitBuffIcons[xButton.id][i], i, false, HealBot_UnitBuffIcons[xButton.id][i]["spellId"])
            end
            for i=11,xButton.icon.buff.count[3]+10 do
                HealBot_Aura_UpdateBuffIcon(xButton, HealBot_UnitBuffIcons[xButton.id][i], i, false, HealBot_UnitBuffIcons[xButton.id][i]["spellId"])
            end
        end
        for _,xButton in pairs(HealBot_Extra_Button) do
            for i=1,xButton.icon.buff.count[1] do
                HealBot_Aura_UpdateBuffIcon(xButton, HealBot_UnitBuffIcons[xButton.id][i], i, false, HealBot_UnitBuffIcons[xButton.id][i]["spellId"])
            end
            for i=9,xButton.icon.buff.count[2]+8 do
                HealBot_Aura_UpdateBuffIcon(xButton, HealBot_UnitBuffIcons[xButton.id][i], i, false, HealBot_UnitBuffIcons[xButton.id][i]["spellId"])
            end
            for i=11,xButton.icon.buff.count[3]+10 do
                HealBot_Aura_UpdateBuffIcon(xButton, HealBot_UnitBuffIcons[xButton.id][i], i, false, HealBot_UnitBuffIcons[xButton.id][i]["spellId"])
            end
        end
    end
end

function HealBot_Aura_UpdateAllDebuffIcons(button)
      --HealBot_setCall("HealBot_Aura_UpdateAllDebuffIcons", button)
    if button then
        for i=51,button.icon.debuff.count[1]+50 do
            HealBot_Aura_UpdateDebuffIcon(button, HealBot_UnitDebuffIcons[button.id][i], i, false, HealBot_UnitDebuffIcons[button.id][i]["spellId"])
        end
        for i=57,button.icon.debuff.count[2]+56 do
            HealBot_Aura_UpdateDebuffIcon(button, HealBot_UnitDebuffIcons[button.id][i], i, false, HealBot_UnitDebuffIcons[button.id][i]["spellId"])
        end
        for i=59,button.icon.debuff.count[3]+58 do
            HealBot_Aura_UpdateDebuffIcon(button, HealBot_UnitDebuffIcons[button.id][i], i, false, HealBot_UnitDebuffIcons[button.id][i]["spellId"])
        end
    else
        for _,xButton in pairs(HealBot_Unit_Button) do
            for i=51,xButton.icon.debuff.count[1]+50 do
                HealBot_Aura_UpdateDebuffIcon(xButton, HealBot_UnitDebuffIcons[xButton.id][i], i, false, HealBot_UnitDebuffIcons[xButton.id][i]["spellId"])
            end
            for i=57,xButton.icon.debuff.count[2]+56 do
                HealBot_Aura_UpdateDebuffIcon(xButton, HealBot_UnitDebuffIcons[xButton.id][i], i, false, HealBot_UnitDebuffIcons[xButton.id][i]["spellId"])
            end
            for i=59,xButton.icon.debuff.count[3]+58 do
                HealBot_Aura_UpdateDebuffIcon(xButton, HealBot_UnitDebuffIcons[xButton.id][i], i, false, HealBot_UnitDebuffIcons[xButton.id][i]["spellId"])
            end
        end
        for _,xButton in pairs(HealBot_Private_Button) do
            for i=51,xButton.icon.debuff.count[1]+50 do
                HealBot_Aura_UpdateDebuffIcon(xButton, HealBot_UnitDebuffIcons[xButton.id][i], i, false, HealBot_UnitDebuffIcons[xButton.id][i]["spellId"])
            end
            for i=57,xButton.icon.debuff.count[2]+56 do
                HealBot_Aura_UpdateDebuffIcon(xButton, HealBot_UnitDebuffIcons[xButton.id][i], i, false, HealBot_UnitDebuffIcons[xButton.id][i]["spellId"])
            end
            for i=59,xButton.icon.debuff.count[3]+58 do
                HealBot_Aura_UpdateDebuffIcon(xButton, HealBot_UnitDebuffIcons[xButton.id][i], i, false, HealBot_UnitDebuffIcons[xButton.id][i]["spellId"])
            end
        end
        for _,xButton in pairs(HealBot_Pet_Button) do
            for i=51,xButton.icon.debuff.count[1]+50 do
                HealBot_Aura_UpdateDebuffIcon(xButton, HealBot_UnitDebuffIcons[xButton.id][i], i, false, HealBot_UnitDebuffIcons[xButton.id][i]["spellId"])
            end
            for i=57,xButton.icon.debuff.count[2]+56 do
                HealBot_Aura_UpdateDebuffIcon(xButton, HealBot_UnitDebuffIcons[xButton.id][i], i, false, HealBot_UnitDebuffIcons[xButton.id][i]["spellId"])
            end
            for i=59,xButton.icon.debuff.count[3]+58 do
                HealBot_Aura_UpdateDebuffIcon(xButton, HealBot_UnitDebuffIcons[xButton.id][i], i, false, HealBot_UnitDebuffIcons[xButton.id][i]["spellId"])
            end
        end
        for _,xButton in pairs(HealBot_Vehicle_Button) do
            for i=51,xButton.icon.debuff.count[1]+50 do
                HealBot_Aura_UpdateDebuffIcon(xButton, HealBot_UnitDebuffIcons[xButton.id][i], i, false, HealBot_UnitDebuffIcons[xButton.id][i]["spellId"])
            end
            for i=57,xButton.icon.debuff.count[2]+56 do
                HealBot_Aura_UpdateDebuffIcon(xButton, HealBot_UnitDebuffIcons[xButton.id][i], i, false, HealBot_UnitDebuffIcons[xButton.id][i]["spellId"])
            end
            for i=59,xButton.icon.debuff.count[3]+58 do
                HealBot_Aura_UpdateDebuffIcon(xButton, HealBot_UnitDebuffIcons[xButton.id][i], i, false, HealBot_UnitDebuffIcons[xButton.id][i]["spellId"])
            end
        end
        for _,xButton in pairs(HealBot_Extra_Button) do
            for i=51,xButton.icon.debuff.count[1]+50 do
                HealBot_Aura_UpdateDebuffIcon(xButton, HealBot_UnitDebuffIcons[xButton.id][i], i, false, HealBot_UnitDebuffIcons[xButton.id][i]["spellId"])
            end
            for i=57,xButton.icon.debuff.count[2]+56 do
                HealBot_Aura_UpdateDebuffIcon(xButton, HealBot_UnitDebuffIcons[xButton.id][i], i, false, HealBot_UnitDebuffIcons[xButton.id][i]["spellId"])
            end
            for i=59,xButton.icon.debuff.count[3]+58 do
                HealBot_Aura_UpdateDebuffIcon(xButton, HealBot_UnitDebuffIcons[xButton.id][i], i, false, HealBot_UnitDebuffIcons[xButton.id][i]["spellId"])
            end
        end
    end
end

function HealBot_Update_AllExtraIcons(button, index)
      --HealBot_setCall("HealBot_Update_AllExtraIcons", button)
    if button then
        if HealBot_UnitExtraIcons[button.id][index].current then
            HealBot_Aura_UpdateExtraIcon(button, HealBot_UnitExtraIcons[button.id][index], index)
        end
    else
        for _,xButton in pairs(HealBot_Unit_Button) do
            if HealBot_UnitExtraIcons[xButton.id] and HealBot_UnitExtraIcons[xButton.id][index].current then
                HealBot_Aura_UpdateExtraIcon(xButton, HealBot_UnitExtraIcons[xButton.id][index], index)
            end
        end
        for _,xButton in pairs(HealBot_Private_Button) do
            if HealBot_UnitExtraIcons[xButton.id] and HealBot_UnitExtraIcons[xButton.id][index].current then
                HealBot_Aura_UpdateExtraIcon(xButton, HealBot_UnitExtraIcons[xButton.id][index], index)
            end
        end
        for _,xButton in pairs(HealBot_Pet_Button) do
            if HealBot_UnitExtraIcons[xButton.id] and HealBot_UnitExtraIcons[xButton.id][index].current then
                HealBot_Aura_UpdateExtraIcon(xButton, HealBot_UnitExtraIcons[xButton.id][index], index)
            end
        end
        for _,xButton in pairs(HealBot_Vehicle_Button) do
            if HealBot_UnitExtraIcons[xButton.id] and HealBot_UnitExtraIcons[xButton.id][index].current then
                HealBot_Aura_UpdateExtraIcon(xButton, HealBot_UnitExtraIcons[xButton.id][index], index)
            end
        end
        for _,xButton in pairs(HealBot_Extra_Button) do
            if HealBot_UnitExtraIcons[xButton.id] and HealBot_UnitExtraIcons[xButton.id][index].current then
                HealBot_Aura_UpdateExtraIcon(xButton, HealBot_UnitExtraIcons[xButton.id][index], index)
            end
        end
    end
end

function HealBot_Aura_UpdateAllExtraIcons()
    for i=91,96 do
        HealBot_Update_AllExtraIcons(nil, i)
    end
end

function HealBot_Aura_Update_AllIcons(button)
      --HealBot_setCall("HealBot_Aura_Update_AllIcons", button)
    HealBot_Aura_UpdateAllBuffIcons(button)
    HealBot_Aura_UpdateAllDebuffIcons(button)
    for i=91,96 do
        HealBot_Update_AllExtraIcons(button, i)
    end
end

function HealBot_Aura_ReturnHoTdetails(buttonId)
      --HealBot_setCall("HealBot_Aura_ReturnHoTdetails")
    return HealBot_UnitBuffIcons[buttonId]
end

function HealBot_Aura_ReturnBuffSpellId(buttonId, iconId)
      --HealBot_setCall("HealBot_Aura_ReturnBuffSpellId")
    return HealBot_UnitBuffIcons[buttonId][iconId]["spellId"]
end

function HealBot_Aura_ReturnHoTdetailsname(spellId)
      --HealBot_setCall("HealBot_Aura_ReturnHoTdetailsname")
    if HealBot_AuraBuffCache[spellId] then
        return HealBot_AuraBuffCache[spellId]["name"]
    else
        return false
    end
end

function HealBot_Aura_ReturnDebuffdetails(buttonId)
      --HealBot_setCall("HealBot_Aura_ReturnDebuffdetails")
    return HealBot_UnitDebuffIcons[buttonId]
end

function HealBot_Aura_ReturnDebuffSpellId(buttonId, iconId)
      --HealBot_setCall("HealBot_Aura_ReturnDebuffSpellId")
    return HealBot_UnitDebuffIcons[buttonId][iconId]["spellId"]
end

function HealBot_Aura_ReturnDebuffdetailsname(spellId)
      --HealBot_setCall("HealBot_Aura_ReturnDebuffdetailsname")
    if HealBot_AuraDebuffCache[spellId] then
        return HealBot_AuraDebuffCache[spellId]["name"]
    else
        return false
    end
end

function HealBot_Aura_RemoveIcons(button)
      --HealBot_setCall("HealBot_Aura_RemoveIcons", button)
    HealBot_Aura_RemoveBuffIcons(button)
    HealBot_Aura_RemoveDebuffIcons(button)
    for i=91,96 do
        HealBot_Aura_RemoveExtraUnitIcons(button, i)
    end
end

local function HealBot_Aura_ConfigClassAllHoT(id, sName, wType)
      --HealBot_setCall("HealBot_Aura_ConfigClassAllHoT")
    HealBot_Watch_HoT[id]=wType
    if (HealBot_Globals.CustomBuffIDMethod[id] or 2)>1 and sName then
        HealBot_Watch_HoT[sName]=wType
    end
end

local function HealBot_Aura_ConfigBuffIconSetId(id, sName, set)
      --HealBot_setCall("HealBot_Aura_ConfigBuffIconSetId")
    HealBot_BuffIconSet[id]=set
    if (HealBot_Globals.CustomBuffIDMethod[id] or 2)>1 and sName then
        HealBot_BuffIconSet[sName]=set
    end
end

local function HealBot_Aura_ConfigBuffIconGlowId(id, sName, glow)
      --HealBot_setCall("HealBot_Aura_ConfigBuffIconGlowId")
    HealBot_BuffIconGlow[id]=glow
    if (HealBot_Globals.CustomBuffIDMethod[id] or 2)>1 and sName then
        HealBot_BuffIconGlow[sName]=glow
    end
end

local function HealBot_Aura_ConfigBuffFilter(id, sName, filter)
      --HealBot_setCall("HealBot_Aura_ConfigBuffFilter")
    HealBot_BuffFilter[id]=filter
    if (HealBot_Globals.CustomBuffIDMethod[id] or 2)>1 and sName then
        HealBot_BuffFilter[sName]=filter
    end
end

function HealBot_Aura_ConfigClassHoT()
      --HealBot_setCall("HealBot_configClassHoT")
    local hbClassHoTwatch=HealBot_Globals.WatchHoT
    for id,_ in pairs(HealBot_Watch_HoT) do
        HealBot_Watch_HoT[id]=nil
    end
    for id,_ in pairs(HealBot_BuffIconSet) do
        HealBot_BuffIconSet[id]=nil
    end
    for id,_ in pairs(HealBot_BuffIconGlow) do
        HealBot_BuffIconGlow[id]=nil
    end
    for id,_ in pairs(HealBot_BuffFilter) do
        HealBot_BuffFilter[id]=nil
    end
    for xClass,_  in pairs(hbClassHoTwatch) do
        local HealBot_configClassHoTClass=HealBot_Globals.WatchHoT[xClass]
        for id,x  in pairs(HealBot_configClassHoTClass) do
            local sName=false
            if type(id)~="number" then
                if not HealBot_SpellID_LookupData[id] then
                    HealBot_SpellID_LookupData[id]={}
                    HealBot_SpellID_LookupData[id]["CHECK"]=true
                    HealBot_SpellID_LookupData[id]["CLASS"]=xClass
                end
                sName=id
            else
                sName=HealBot_WoWAPI_SpellName(id)
            end
            if x == 1 then
                HealBot_Aura_ConfigClassAllHoT(id, sName, "S")
            elseif x == 2 then
                HealBot_Aura_ConfigClassAllHoT(id, sName, "C")
            else
                HealBot_Aura_ConfigClassAllHoT(id, sName, "A")
            end
            if HealBot_Globals.CustomBuffsIconSet[id] then
                HealBot_Aura_ConfigBuffIconSetId(id, sName, HealBot_Globals.CustomBuffsIconSet[id])
            end
            if HealBot_Globals.CustomBuffsIconGlow[id] then
                HealBot_Aura_ConfigBuffIconGlowId(id, sName, HealBot_Globals.CustomBuffsIconGlow[id])
            end
            if HealBot_Globals.CustomBuffsFilter[id] then
                HealBot_Aura_ConfigBuffFilter(id, sName, HealBot_Globals.CustomBuffsFilter[id])
            end
        end
    end
    HealBot_Timers_Set("AURA","ResetBuffCache")
    HealBot_Timers_Set("AURA","UpdateAllBuffIcons")
end

local function HealBot_Aura_ConfigDebuffIconSetId(id, sName, set)
      --HealBot_setCall("HealBot_Aura_ConfigDebuffIconSetId")
    HealBot_DebuffIconSet[id]=set
    if (HealBot_Globals.CustomDebuffIDMethod[id] or 2)>1 and sName then
        HealBot_DebuffIconSet[sName]=set
    end
end

local function HealBot_Aura_ConfigDebuffIconSetGlow(id, sName, glow)
      --HealBot_setCall("HealBot_Aura_ConfigDebuffIconSetGlow")
    HealBot_DebuffIconGlow[id]=glow
    if (HealBot_Globals.CustomDebuffIDMethod[id] or 2)>1 and sName then
        HealBot_DebuffIconGlow[sName]=glow
    end
end

local function HealBot_Aura_ConfigDebuffFilter(id, sName, filter)
      --HealBot_setCall("HealBot_Aura_ConfigDebuffIconSetGlow")
    HealBot_DebuffFilter[id]=filter
    if (HealBot_Globals.CustomDebuffIDMethod[id] or 2)>1 and sName then
        HealBot_DebuffFilter[sName]=filter
    end
end

function HealBot_Aura_ConfigDebuffs()
      --HealBot_setCall("HealBot_Aura_ConfigDebuffs")
    for id,_ in pairs(HealBot_DebuffIconGlow) do
        HealBot_DebuffIconGlow[id]=nil
    end
    for id,_ in pairs(HealBot_DebuffIconSet) do
        HealBot_DebuffIconSet[id]=nil
    end
    for id,_ in pairs(HealBot_DebuffFilter) do
        HealBot_DebuffFilter[id]=nil
    end
    for id, _ in pairs(HealBot_Globals.CustomDebuffs) do
        if HealBot_Globals.CustomDebuffsIconSet[id] then
            local sName=HealBot_WoWAPI_SpellName(id)
            HealBot_Aura_ConfigDebuffIconSetId(id, sName, HealBot_Globals.CustomDebuffsIconSet[id])
        end
        if HealBot_Globals.CustomDebuffsIconGlow[id] then
            local sName=HealBot_WoWAPI_SpellName(id)
            HealBot_Aura_ConfigDebuffIconSetGlow(id, sName, HealBot_Globals.CustomDebuffsIconGlow[id])
        end
        if HealBot_Globals.CustomDebuffsFilter[id] then
            local sName=HealBot_WoWAPI_SpellName(id)
            HealBot_Aura_ConfigDebuffFilter(id, sName, HealBot_Globals.CustomDebuffsFilter[id])
        end
    end
    HealBot_Timers_Set("AURA","ResetDebuffCache")
    HealBot_Timers_Set("AURA","UpdateAllDebuffIcons")
end

function HealBot_Aura_BuffTagNames()
      --HealBot_setCall("HealBot_Aura_BuffTagNames")
    for x,_ in pairs(HealBot_BuffTagNames) do
        HealBot_BuffTagNames[x]=nil;
    end
    for id,tag in pairs(HealBot_Globals.CustomBuffTag) do
        HealBot_BuffTagNames[id]=tag
        if (HealBot_Globals.CustomBuffIDMethod[id] or 2)>1 then
            local sName=HealBot_Options_SpellGetName(id)
            if sName then HealBot_BuffTagNames[sName]=tag end
        end
    end
end

function HealBot_Aura_DebuffTagNames()
      --HealBot_setCall("HealBot_Aura_DebuffTagNames")
    for x,_ in pairs(HealBot_DebuffTagNames) do
        HealBot_DebuffTagNames[x]=nil;
    end
    for id,tag in pairs(HealBot_Globals.CDCTag) do
        HealBot_DebuffTagNames[id]=tag
        if (HealBot_Globals.CustomDebuffIDMethod[id] or 2)>1 then
            local sName=HealBot_Options_SpellGetName(id)
            if sName then HealBot_DebuffTagNames[sName]=tag end
        end
    end
end

function HealBot_Aura_BuffIdLookup()
      --HealBot_setCall("HealBot_Aura_BuffIdLookup")
    if HealBot_SpellID_LookupIdx[1] then
        local sName=HealBot_SpellID_LookupIdx[1]
        local sID=HealBot_SpellID_LookupData[sName]["ID"]
        local class=HealBot_SpellID_LookupData[sName]["CLASS"]
        table.remove(HealBot_SpellID_LookupIdx,1)
        if HealBot_WoWAPI_SpellName(sID) and HealBot_WoWAPI_SpellName(sID) == sName and HealBot_Globals.WatchHoT[class][sName] then
            HealBot_Globals.WatchHoT[class][sID]=HealBot_Globals.WatchHoT[class][sName]
            if HealBot_Globals.IgnoreCustomBuff[sName] then
                HealBot_Globals.IgnoreCustomBuff[sID]=HealBot_Options_copyTable(HealBot_Globals.IgnoreCustomBuff[sName])
            end
            if HealBot_Globals.CustomBuffs[sName] then
                if HealBot_Globals.CustomBuffs[sName]<20 then
                    HealBot_Globals.CustomBuffs[sID]=HealBot_Globals.CustomBuffs[sName]
                else
                    HealBot_Globals.CustomBuffs[sName]=nil
                end
            end
            if HealBot_Globals.CustomBuffBarColour[sName] then
                HealBot_Globals.CustomBuffBarColour[sID]=HealBot_Options_copyTable(HealBot_Globals.CustomBuffBarColour[sName])
            end
            if HealBot_Globals.CustomBuffsShowBarCol[sName] then
                if HealBot_Globals.CustomBuffsShowBarCol[sName]>1 then
                    HealBot_Globals.CustomBuffsShowBarCol[sID]=HealBot_Globals.CustomBuffsShowBarCol[sName]
                else
                    HealBot_Globals.CustomBuffsShowBarCol[sName]=nil
                end
            end
            if HealBot_Globals.CustomBuffsIconSet[sName] then
                if HealBot_Globals.CustomBuffsIconSet[sName]>1 then
                    HealBot_Globals.CustomBuffsIconSet[sID]=HealBot_Globals.CustomBuffsIconSet[sName]
                else
                    HealBot_Globals.CustomBuffsIconSet[sName]=nil
                end
            end
            if HealBot_Globals.CustomBuffsIconGlow[sName] then
                if HealBot_Globals.CustomBuffsIconGlow[sName]>1 then
                    HealBot_Globals.CustomBuffsIconGlow[sID]=HealBot_Globals.CustomBuffsIconGlow[sName]
                else
                    HealBot_Globals.CustomBuffsIconGlow[sName]=nil
                end
            end
            HealBot_Options_DeleteBuffHoT(class, sName, sName)
        end
        HealBot_Timers_Set("OOC","BuffIdLookup",true)
    end
end

local function HealBot_Aura_InitItem2BuffsNames(buffId, itemId)
      --HealBot_setCall("HealBot_Aura_InitItem2BuffsNames")
    if HealBot_IsItemInBag(itemId) then
        local sName=HealBot_WoWAPI_SpellName(buffId)
        if sName then HealBot_Buff_Aura2Item[sName]=itemId end
    end
end

local hbWeaponEnchants={}
function HealBot_Aura_WeaponEnchants(spell, x)
      --HealBot_setCall("HealBot_Aura_WeaponEnchants")
    if hbWeaponEnchants[spell] and HealBot_WoWAPI_SpellName(spell) then
        HealBot_Weapon_Enchant[x]=HealBot_WoWAPI_SpellName(spell)
    elseif hbWeaponEnchants[spell] and HealBot_WoWAPI_ItemInfo(spell) then
        HealBot_Weapon_Enchant[x]=HealBot_WoWAPI_ItemInfo(spell)
    else
        HealBot_Weapon_Enchant[x]=false
    end
end

function HealBot_Aura_UpdateItemData(iName, id)
      --HealBot_setCall("HealBot_Aura_UpdateItemData")
    if iName then
        if HealBot_IsItemInBag(id) then 
            hbWeaponEnchants[iName]=true
        else
            hbWeaponEnchants[iName]=false 
        end
        HealBot_Aura_WeaponEnchants(iName, 1)
        if hbWeaponEnchants[1] then
            return hbWeaponEnchants[iName]
        end
    end
    return false
end

local InitItemsDataPrev={["MANADRINK"]=false, ["WELLFED"]=false, ["Vanilla1"]=false, ["Vanilla2"]=false, ["Vanilla3"]=false, ["Vanilla4"]=false, ["Vanilla5"]=false, ["Vanilla6"]=false}
local InitItemsDataUpdate=true
function HealBot_Aura_InitItemsDataReady()
      --HealBot_setCall("HealBot_Aura_InitItemsDataReady")
    local hbCustomItemID,hbCustomSpellID=0,0
    
    if HEALBOT_GAME_VERSION<4 then
        if HealBot_Aura_UpdateItemData(HealBot_WoWAPI_ItemInfo(HEALBOT_BRILLIANT_MANA_OIL_SPELL), HEALBOT_BRILLIANT_MANA_OIL_SPELL) then
            if not InitItemsDataPrev["Vanilla1"] then
                InitItemsDataPrev["Vanilla1"]=true
                InitItemsDataUpdate=true
            end
        elseif InitItemsDataPrev["Vanilla1"] then
            InitItemsDataPrev["Vanilla1"]=false
            InitItemsDataUpdate=true
        end
        if HealBot_Aura_UpdateItemData(HealBot_WoWAPI_ItemInfo(HEALBOT_BRILLIANT_WIZARD_OIL_SPELL), HEALBOT_BRILLIANT_WIZARD_OIL_SPELL) then
            if not InitItemsDataPrev["Vanilla2"] then
                InitItemsDataPrev["Vanilla2"]=true
                InitItemsDataUpdate=true
            end
        elseif InitItemsDataPrev["Vanilla2"] then
            InitItemsDataPrev["Vanilla2"]=false
            InitItemsDataUpdate=true
        end
        if HealBot_Aura_UpdateItemData(HealBot_WoWAPI_ItemInfo(HEALBOT_BLESSED_WIZARD_OIL_SPELL), HEALBOT_BLESSED_WIZARD_OIL_SPELL) then
            if not InitItemsDataPrev["Vanilla3"] then
                InitItemsDataPrev["Vanilla3"]=true
                InitItemsDataUpdate=true
            end
        elseif InitItemsDataPrev["Vanilla3"] then
            InitItemsDataPrev["Vanilla3"]=false
            InitItemsDataUpdate=true
        end
        if HealBot_Aura_UpdateItemData(HealBot_WoWAPI_ItemInfo(HEALBOT_WIZARD_OIL_SPELL), HEALBOT_WIZARD_OIL_SPELL) then
            if not InitItemsDataPrev["Vanilla6"] then
                InitItemsDataPrev["Vanilla6"]=true
                InitItemsDataUpdate=true
            end
        elseif InitItemsDataPrev["Vanilla6"] then
            InitItemsDataPrev["Vanilla6"]=false
            InitItemsDataUpdate=true
        end
        if HEALBOT_GAME_VERSION>1 then
            if HealBot_Aura_UpdateItemData(HealBot_WoWAPI_ItemInfo(HEALBOT_SUPERIOR_WIZARD_OIL_SPELL), HEALBOT_SUPERIOR_WIZARD_OIL_SPELL) then
                if not InitItemsDataPrev["Vanilla4"] then
                    InitItemsDataPrev["Vanilla4"]=true
                    InitItemsDataUpdate=true
                end
            elseif InitItemsDataPrev["Vanilla4"] then
                InitItemsDataPrev["Vanilla4"]=false
                InitItemsDataUpdate=true
            end
            if HealBot_Aura_UpdateItemData(HealBot_WoWAPI_ItemInfo(HEALBOT_SUPERIOR_MANA_OIL_SPELL), HEALBOT_SUPERIOR_MANA_OIL_SPELL) then
                if not InitItemsDataPrev["Vanilla5"] then
                    InitItemsDataPrev["Vanilla5"]=true
                    InitItemsDataUpdate=true
                end
            elseif InitItemsDataPrev["Vanilla5"] then
                InitItemsDataPrev["Vanilla5"]=false
                InitItemsDataUpdate=true
            end
        end
    end

    for x,_ in pairs(HealBot_Buff_Aura2Item) do
        HealBot_Buff_Aura2Item[x]=nil;
    end
    
    HealBot_Aura_luVars["ManaDrink"]=""
    if HealBot_Config_Buffs.CheckManaDrink then
        InitItemsDataPrev["MANADRINK"]=true
        hbCustomItemID=HealBot_WoWAPI_ItemInfoInstant(HealBot_Config_Buffs.ManaDrinkItem or "x") or 0
        if hbCustomItemID>0 and HealBot_IsItemInBag(hbCustomItemID) and (IsInInstance() or not HealBot_Config_Buffs.ExtraBuffsOnlyInInstance) then
            if HealBot_BuffWatch[HealBot_Config_Buffs.BackupManaDrinkItem] then HealBot_Aura_ClearBuffWatch(HealBot_Config_Buffs.BackupManaDrinkItem) end
            HealBot_Buff_Aura2Item[HEALBOT_MANA_DRINK]=hbCustomItemID
            HealBot_Aura_luVars["ManaDrink"]=HealBot_Config_Buffs.ManaDrinkItem
            if not HealBot_BuffWatch[HealBot_Aura_luVars["ManaDrink"]] then
                HealBot_Aura_SetBuffWatch(HealBot_Aura_luVars["ManaDrink"])
                InitItemsDataUpdate=true
            end
        else
            if HealBot_BuffWatch[HealBot_Config_Buffs.ManaDrinkItem] then 
                HealBot_Aura_ClearBuffWatch(HealBot_Config_Buffs.ManaDrinkItem)
                InitItemsDataUpdate=true
            end
            hbCustomItemID=HealBot_WoWAPI_ItemInfoInstant(HealBot_Config_Buffs.BackupManaDrinkItem or "x") or 0
            if hbCustomItemID>0 and HealBot_IsItemInBag(hbCustomItemID) and (IsInInstance() or not HealBot_Config_Buffs.ExtraBuffsOnlyInInstance) then
                HealBot_Buff_Aura2Item[HEALBOT_MANA_DRINK]=hbCustomItemID
                HealBot_Aura_luVars["ManaDrink"]=HealBot_Config_Buffs.BackupManaDrinkItem
                if not HealBot_BuffWatch[HealBot_Aura_luVars["ManaDrink"]] then
                    HealBot_Aura_SetBuffWatch(HealBot_Aura_luVars["ManaDrink"])
                    InitItemsDataUpdate=true
                end
            elseif HealBot_BuffWatch[HealBot_Config_Buffs.BackupManaDrinkItem] then
                HealBot_Aura_ClearBuffWatch(HealBot_Config_Buffs.BackupManaDrinkItem)
                InitItemsDataUpdate=true
            end
        end
    elseif InitItemsDataPrev["MANADRINK"] then
        InitItemsDataPrev["MANADRINK"]=false
        InitItemsDataUpdate=true
    end
    
    if HealBot_Config_Buffs.CheckWellFed then
        InitItemsDataPrev["WELLFED"]=true
        hbCustomItemID=HealBot_WoWAPI_ItemInfoInstant(HealBot_Config_Buffs.WellFedItem or "x") or 0
        if hbCustomItemID>0 and HealBot_IsItemInBag(hbCustomItemID) and (IsInInstance() or not HealBot_Config_Buffs.ExtraBuffsOnlyInInstance) then
            if HealBot_BuffWatch[HealBot_Config_Buffs.BackupWellFedItem] then HealBot_Aura_ClearBuffWatch(HealBot_Config_Buffs.BackupWellFedItem) end
            HealBot_Buff_Aura2Item[HEALBOT_WELL_FED]=hbCustomItemID
            HealBot_Buff_Aura2Item[HEALBOT_HEARTY_WELL_FED]=hbCustomItemID
            HealBot_Aura_luVars["WellFed"]=HealBot_Config_Buffs.WellFedItem
            if not HealBot_BuffWatch[HealBot_Aura_luVars["WellFed"]] then
                HealBot_Aura_SetBuffWatch(HealBot_Aura_luVars["WellFed"])
                InitItemsDataUpdate=true
            end
        else
            if HealBot_BuffWatch[HealBot_Config_Buffs.WellFedItem] then 
                HealBot_Aura_ClearBuffWatch(HealBot_Config_Buffs.WellFedItem) 
                InitItemsDataUpdate=true
            end
            hbCustomItemID=HealBot_WoWAPI_ItemInfoInstant(HealBot_Config_Buffs.BackupWellFedItem or "x") or 0
            if hbCustomItemID>0 and HealBot_IsItemInBag(hbCustomItemID) and (IsInInstance() or not HealBot_Config_Buffs.ExtraBuffsOnlyInInstance) then
                HealBot_Buff_Aura2Item[HEALBOT_WELL_FED]=hbCustomItemID
                HealBot_Buff_Aura2Item[HEALBOT_HEARTY_WELL_FED]=hbCustomItemID
                HealBot_Aura_luVars["WellFed"]=HealBot_Config_Buffs.BackupWellFedItem
                if not HealBot_BuffWatch[HealBot_Aura_luVars["WellFed"]] then
                    HealBot_Aura_SetBuffWatch(HealBot_Aura_luVars["WellFed"])
                    InitItemsDataUpdate=true
                end
            elseif HealBot_BuffWatch[HealBot_Config_Buffs.BackupWellFedItem] then
                HealBot_Aura_ClearBuffWatch(HealBot_Config_Buffs.BackupWellFedItem)
                InitItemsDataUpdate=true
            end
        end
    elseif InitItemsDataPrev["WELLFED"] then
        InitItemsDataPrev["WELLFED"]=false
        InitItemsDataUpdate=true
    end

    for x=1,4 do
        if string.len(HealBot_Config_Buffs.CustomBuffName[x])>0 then
            _,_,_,_,_,_,hbCustomSpellID=HealBot_WoWAPI_SpellInfo(HealBot_Config_Buffs.CustomItemName[x])
            InitItemsDataPrev[x]=true
            if not hbCustomSpellID then
                hbCustomItemID=HealBot_WoWAPI_ItemInfoInstant(HealBot_Config_Buffs.CustomItemName[x]) or 0
            end
            if HealBot_Config_Buffs.CustomBuffCheck[x] and hbCustomSpellID and (IsInInstance() or not HealBot_Config_Buffs.ExtraBuffsOnlyInInstance) then
                HealBot_Buff_Aura2Spell[HealBot_Config_Buffs.CustomBuffName[x]]=hbCustomSpellID
                if not HealBot_BuffWatch[HealBot_Config_Buffs.CustomItemName[x]] then
                    HealBot_Aura_SetBuffWatch(HealBot_Config_Buffs.CustomItemName[x])
                    InitItemsDataUpdate=true
                end
            elseif HealBot_Config_Buffs.CustomBuffCheck[x] and hbCustomItemID>0 and HealBot_IsItemInBag(hbCustomItemID) and (IsInInstance() or not HealBot_Config_Buffs.ExtraBuffsOnlyInInstance) then
                HealBot_Buff_Aura2Item[HealBot_Config_Buffs.CustomBuffName[x]]=hbCustomItemID
                if not HealBot_BuffWatch[HealBot_Config_Buffs.CustomItemName[x]] then
                    HealBot_Aura_SetBuffWatch(HealBot_Config_Buffs.CustomItemName[x])
                    InitItemsDataUpdate=true
                end
            elseif HealBot_BuffWatch[HealBot_Config_Buffs.CustomItemName[x]] and not HealBot_Options_retBuffWatchTarget(HealBot_Config_Buffs.CustomItemName[x]) then
                HealBot_Aura_ClearBuffWatch(HealBot_Config_Buffs.CustomItemName[x])
                InitItemsDataUpdate=true
            end
        elseif InitItemsDataPrev[x] then
            InitItemsDataPrev[x]=false
            InitItemsDataUpdate=true
        end
    end
    
    if InitItemsDataUpdate then
        for x,_ in pairs(HealBot_Buff_ItemIDs) do
            HealBot_Buff_ItemIDs[x]=nil;
        end
        for _,id in pairs(HealBot_Buff_Aura2Item) do
            local itemName=HealBot_WoWAPI_ItemInfo(id)
            if itemName then
                HealBot_Buff_ItemIDs[itemName]=id
            end
        end
        HealBot_Options_BuffWeaponEnchantSetAura(1)
        HealBot_Options_BuffWeaponEnchantSetAura(2)
        HealBot_Timers_Set("AURA","ExtraBuffReset")
        HealBot_Timers_Set("AURA","ResetBuffCache")
        HealBot_Timers_Set("AURA","CheckPlayer")
        InitItemsDataUpdate=false
    elseif HealBot_Weapon_Enchant[1] or HealBot_Weapon_Enchant[2] then
        HealBot_Timers_Set("AURA","CheckPlayer")
    end
end

function HealBot_Aura_InitItemsData()
      --HealBot_setCall("HealBot_Aura_InitItemsData")
    if HealBot_retLuVars("BagsScanned") then
        HealBot_Aura_InitItemsDataReady()
    else
        HealBot_Timers_Set("LAST","InitItemsData",true,true) -- All recall require a delay
    end
end

function HealBot_Aura_InitData()
      --HealBot_setCall("HealBot_Aura_InitData")
    if HealBot_Data["PCLASSTRIM"] then
        local sName=nil
        if HealBot_Data["PCLASSTRIM"] == hbv_GetClass("En", HEALBOT_PRIEST) then
            sName=HealBot_WoWAPI_SpellName(HBC_DAMPEN_MAGIC)
            if sName then HealBot_ShortBuffs[sName]=true end
            sName=HealBot_WoWAPI_SpellName(HBC_SHADOW_PROTECTION)
            if sName then HealBot_ShortBuffs[sName]=true end
            sName=HealBot_WoWAPI_SpellName(HEALBOT_FEAR_WARD)
            if sName then HealBot_ShortBuffs[sName]=true end
            if HEALBOT_GAME_VERSION<3 then
                sName=HealBot_WoWAPI_SpellName(HBC_INNER_FIRE)
                if sName then HealBot_ShortBuffs[sName]=true end
            end
        elseif HealBot_Data["PCLASSTRIM"] == hbv_GetClass("En", HEALBOT_DRUID) then
            sName=HealBot_WoWAPI_SpellName(HBC_THORNS)
            if sName then HealBot_ShortBuffs[sName]=true end
            if HEALBOT_GAME_VERSION<2 then 
                sName=HealBot_WoWAPI_SpellName(HBC_OMEN_OF_CLARITY)
                if sName then HealBot_ShortBuffs[sName]=true end
            end
        elseif HealBot_Data["PCLASSTRIM"] == hbv_GetClass("En", HEALBOT_PALADIN) then
            sName=HealBot_WoWAPI_SpellName(HEALBOT_BEACON_OF_LIGHT)
            if sName then HealBot_ShortBuffs[sName]=true end
            sName=HealBot_WoWAPI_SpellName(HEALBOT_SACRED_SHIELD)
            if sName then HealBot_ShortBuffs[sName]=true end
            sName=HealBot_WoWAPI_SpellName(HBC_BLESSING_OF_KINGS)
            if sName then HealBot_ShortBuffs[sName]=true end
            sName=HealBot_WoWAPI_SpellName(HBC_BLESSING_OF_MIGHT)
            if sName then HealBot_ShortBuffs[sName]=true end
            sName=HealBot_WoWAPI_SpellName(HBC_BLESSING_OF_WISDOM)
            if sName then HealBot_ShortBuffs[sName]=true end
            sName=HealBot_WoWAPI_SpellName(HBC_BLESSING_OF_LIGHT)
            if sName then HealBot_ShortBuffs[sName]=true end
            sName=HealBot_WoWAPI_SpellName(HBC_BLESSING_OF_SANCTUARY)
            if sName then HealBot_ShortBuffs[sName]=true end
            sName=HealBot_WoWAPI_SpellName(HBC_SACRED_SHIELD)
            if sName then HealBot_ShortBuffs[sName]=true end
        elseif HealBot_Data["PCLASSTRIM"] == hbv_GetClass("En", HEALBOT_MONK) then
            -- Class buffs
        elseif HealBot_Data["PCLASSTRIM"] == hbv_GetClass("En", HEALBOT_WARRIOR) then
            -- Class buffs
        elseif HealBot_Data["PCLASSTRIM"] == hbv_GetClass("En", HEALBOT_MAGE) then
            sName=HealBot_WoWAPI_SpellName(HEALBOT_ICE_WARD)
            if sName then HealBot_ShortBuffs[sName]=true end
            sName=HealBot_WoWAPI_SpellName(HEALBOT_ICE_BARRIER)
            if sName then HealBot_ShortBuffs[sName]=true end
            sName=HealBot_WoWAPI_SpellName(HBC_DAMPEN_MAGIC)
            if sName then HealBot_ShortBuffs[sName]=true end
        elseif HealBot_Data["PCLASSTRIM"] == hbv_GetClass("En", HEALBOT_WARLOCK) then
            -- Class buffs
        elseif HealBot_Data["PCLASSTRIM"] == hbv_GetClass("En", HEALBOT_DEATHKNIGHT) then
            sName=HealBot_WoWAPI_SpellName(HEALBOT_HORN_OF_WINTER)
            if sName then HealBot_ShortBuffs[sName]=true end
        elseif HealBot_Data["PCLASSTRIM"] == hbv_GetClass("En", HEALBOT_HUNTER) then
            -- Class buffs
        elseif HealBot_Data["PCLASSTRIM"] == hbv_GetClass("En", HEALBOT_SHAMAN) then
            sName=HealBot_WoWAPI_SpellName(HEALBOT_FLAMETONGUE_SPELL)
            if sName then hbWeaponEnchants[sName]=true end
            sName=HealBot_WoWAPI_SpellName(HEALBOT_WINDFURY_SPELL)
            if sName then hbWeaponEnchants[sName]=true end
            sName=HealBot_WoWAPI_SpellName(HBC_ROCKBITER_WEAPON)
            if sName then hbWeaponEnchants[sName]=true end
            sName=HealBot_WoWAPI_SpellName(HBC_EARTHLIVING_WEAPON)
            if sName then hbWeaponEnchants[sName]=true end
            sName=HealBot_WoWAPI_SpellName(HEALBOT_EARTHLIVING_WEAPON)
            if sName then hbWeaponEnchants[sName]=true end
            sName=HealBot_WoWAPI_SpellName(HBC_FLAMETONGUE_WEAPON)
            if sName then hbWeaponEnchants[sName]=true end
            sName=HealBot_WoWAPI_SpellName(HBC_WINDFURY_WEAPON)
            if sName then hbWeaponEnchants[sName]=true end
        elseif HealBot_Data["PCLASSTRIM"] == hbv_GetClass("En", HEALBOT_ROGUE) then
            -- Class buffs
        elseif HealBot_Data["PCLASSTRIM"] == hbv_GetClass("En", HEALBOT_DEMONHUNTER) then
            -- Class buffs
        end

        if HEALBOT_GAME_VERSION<5 then
            
            local HBC_WISDOM_ID=1 --Mana Regen
            local HBC_LIGHT_ID=2 --Incoming Heals
            local HBC_SALVATION_ID=3 --Threat Reduction
            local HBC_SANCTUARY_ID=4 --Damage Reduction
            local HBC_STATS_ID=5 --Stats
            local HBC_MIGHT_ID=6 --Attack Power
            local HBC_STAMINA_ID=7 --Stamina
            local HBC_INT_ID=8 --Int
            local HBC_SPIRIT_ID=9 --Spirit
            local HBC_SP_ID=10 --Shadow Resistance 
            local HBC_MOTW_ID=11 --Wild 
            local HBC_INV_ID=12
            local HBC_INNER_ID=13
            if HEALBOT_GAME_VERSION<4 then
                if HealBot_Data["PCLASSTRIM"] == hbv_GetClass("En", HEALBOT_DRUID) then
                        HealBot_BuffNameTypes={
                            [(HealBot_WoWAPI_SpellName(HEALBOT_MARK_OF_THE_WILD) or "Mark of the Wild")]=HBC_MOTW_ID,
                            [(HealBot_WoWAPI_SpellName(HBC_GIFT_OF_THE_WILD) or "Gift of the Wild")]=HBC_MOTW_ID,
                        }
                elseif HealBot_Data["PCLASSTRIM"] == hbv_GetClass("En", HEALBOT_MAGE) then
                    HealBot_BuffNameTypes={
                        [(HealBot_WoWAPI_SpellName(HBC_ARCANE_BRILLIANCE) or "Arcane Brilliance")]=HBC_INT_ID,
                        [(HealBot_WoWAPI_SpellName(HEALBOT_ARCANE_BRILLIANCE) or "Arcane Brilliance")]=HBC_INT_ID,
                        [(HealBot_WoWAPI_SpellName(HEALBOT_DALARAN_BRILLIANCE) or "Dalaran Brilliance")]=HBC_INT_ID,
                    }
                elseif HealBot_Data["PCLASSTRIM"] == hbv_GetClass("En", HEALBOT_PALADIN) then
                    HealBot_BuffNameTypes={
                        [(HealBot_WoWAPI_SpellName(HBC_BLESSING_OF_KINGS) or "Blessing of Kings")]=HBC_STATS_ID,
                        [(HealBot_WoWAPI_SpellName(HBC_BLESSING_OF_LIGHT) or "Blessing of Light")]=HBC_LIGHT_ID,
                        [(HealBot_WoWAPI_SpellName(HBC_BLESSING_OF_MIGHT) or "Blessing of Might")]=HBC_MIGHT_ID,
                        [(HealBot_WoWAPI_SpellName(HEALBOT_HAND_OF_SALVATION) or "Hand of Salvation")]=HBC_SALVATION_ID,
                        [(HealBot_WoWAPI_SpellName(HBC_BLESSING_OF_SANCTUARY) or "Blessing of Sanctuary")]=HBC_SANCTUARY_ID,
                        [(HealBot_WoWAPI_SpellName(HBC_BLESSING_OF_WISDOM) or "Blessing of Wisdom")]=HBC_WISDOM_ID,
                        [(HealBot_WoWAPI_SpellName(HBC_GREATER_BLESSING_OF_KINGS) or "Greater Blessing of Kings")]=HBC_STATS_ID,
                        [(HealBot_WoWAPI_SpellName(HBC_GREATER_BLESSING_OF_LIGHT) or "Greater Blessing of Light")]=HBC_LIGHT_ID,
                        [(HealBot_WoWAPI_SpellName(HBC_GREATER_BLESSING_OF_MIGHT) or "Greater Blessing of Might")]=HBC_MIGHT_ID,
                        [(HealBot_WoWAPI_SpellName(HBC_GREATER_BLESSING_OF_SALVATION) or "Greater Blessing of Salvation")]=HBC_SALVATION_ID,
                        [(HealBot_WoWAPI_SpellName(HBC_GREATER_BLESSING_OF_SANCTUARY) or "Greater Blessing of Sanctuary")]=HBC_SANCTUARY_ID,
                        [(HealBot_WoWAPI_SpellName(HBC_GREATER_BLESSING_OF_WISDOM) or "Greater Blessing of Wisdom")]=HBC_WISDOM_ID,
                    }
                elseif HealBot_Data["PCLASSTRIM"] == hbv_GetClass("En", HEALBOT_PRIEST) then
                    HealBot_BuffNameTypes={
                        [(HealBot_WoWAPI_SpellName(HBC_POWER_WORD_FORTITUDE) or "Power Word:Fortitude")]=HBC_STAMINA_ID,
                        [(HealBot_WoWAPI_SpellName(HEALBOT_POWER_WORD_FORTITUDE) or "Power Word:Fortitude")]=HBC_STAMINA_ID,
                        [(HealBot_WoWAPI_SpellName(HBC_DIVINE_SPIRIT) or "Divine Spirit")]=HBC_SPIRIT_ID,
                        [(HealBot_WoWAPI_SpellName(HBC_PRAYER_OF_SPIRIT) or "Prayer of Spirit")]=HBC_SPIRIT_ID,
                        [(HealBot_WoWAPI_SpellName(HBC_SHADOW_PROTECTION) or "Shadow Protection")]=HBC_SP_ID,
                        [(HealBot_WoWAPI_SpellName(HBC_PRAYER_OF_SHADOW_PROTECTION) or "Prayer of Shadow Protection")]=HBC_SP_ID,
                    }
                    if HealBot_Data["PLEVEL"]<80 then
                        HealBot_BuffNameTypes[(HealBot_WoWAPI_SpellName(HBC_FEL_INTELLIGENCE) or "Fel Intelligence")]=HBC_SPIRIT_ID
                    end
                elseif HealBot_Data["PCLASSTRIM"] == hbv_GetClass("En", HEALBOT_WARLOCK) then
                    HealBot_BuffNameTypes={
                        [(HealBot_WoWAPI_SpellName(HBC_DETECT_LESSER_INVISIBILITY) or "Detect Lesser Invisibility")]=HBC_INV_ID,
                        [(HealBot_WoWAPI_SpellName(HBC_DETECT_INVISIBILITY) or "Detect Invisibility")]=HBC_INV_ID,
                        [(HealBot_WoWAPI_SpellName(HBC_DETECT_GREATER_INVISIBILITY) or "Detect Greater Invisibility")]=HBC_INV_ID,
                    }
                end
            elseif HEALBOT_GAME_VERSION<5 then
                HealBot_BuffNameTypes={
                    [(HealBot_WoWAPI_SpellName(HEALBOT_MARK_OF_THE_WILD) or "Mark of the Wild")]=HBC_STATS_ID,
                    [(HealBot_WoWAPI_SpellName(HBC_BLESSING_OF_KINGS) or "Blessing of Kings")]=HBC_STATS_ID,
                    [(HealBot_WoWAPI_SpellName(HBC_INNER_FIRE) or "Inner Fire")]=HBC_INNER_ID,
                    [(HealBot_WoWAPI_SpellName(HBC_INNER_WILL) or "Inner Will")]=HBC_INNER_ID,
                    [(HealBot_WoWAPI_SpellName(HEALBOT_POWER_WORD_FORTITUDE) or "Power Word: Fortitude")]=HBC_STAMINA_ID,
                    [(HealBot_WoWAPI_SpellName(HEALBOT_COMMANDING_SHOUT) or "Commanding Shout")]=HBC_STAMINA_ID,
                    [(HealBot_WoWAPI_SpellName(HEALBOT_ARCANE_BRILLIANCE) or "Arcane Brilliance")]=HBC_INT_ID,
                    [(HealBot_WoWAPI_SpellName(HEALBOT_DALARAN_BRILLIANCE) or "Dalaran Brilliance")]=HBC_INT_ID,
                }
            end

            if HEALBOT_GAME_VERSION<4 then
                HealBot_BuffMinLevels={[HealBot_WoWAPI_SpellName(HEALBOT_POWER_WORD_FORTITUDE) or "x"]=48,
                                       [HealBot_WoWAPI_SpellName(HBC_DIVINE_SPIRIT) or "x"]=20,
                                       [HealBot_WoWAPI_SpellName(HBC_PRAYER_OF_SPIRIT) or "x"]=60,
                                       [HealBot_WoWAPI_SpellName(HBC_PRAYER_OF_SHADOW_PROTECTION) or "x"]=56,
                                       [HealBot_WoWAPI_SpellName(HBC_SHADOW_PROTECTION) or "x"]=30,
                                       [HealBot_WoWAPI_SpellName(HBC_GIFT_OF_THE_WILD) or "x"]=50,
                                       [HealBot_WoWAPI_SpellName(HBC_THORNS) or "x"]=6,
                                       [HealBot_WoWAPI_SpellName(HBC_ARCANE_BRILLIANCE) or "x"]=56,
                                       [HealBot_WoWAPI_SpellName(HBC_GREATER_BLESSING_OF_LIGHT) or "x"]=60,
                                       [HealBot_WoWAPI_SpellName(HBC_BLESSING_OF_LIGHT) or "x"]=40,
                                       [HealBot_WoWAPI_SpellName(HBC_GREATER_BLESSING_OF_MIGHT) or "x"]=52,
                                       [HealBot_WoWAPI_SpellName(HBC_BLESSING_OF_MIGHT) or "x"]=4,
                                       [HealBot_WoWAPI_SpellName(HBC_GREATER_BLESSING_OF_SALVATION) or "x"]=60,
                                       [HealBot_WoWAPI_SpellName(HBC_BLESSING_OF_SALVATION) or "x"]=26,
                                       [HealBot_WoWAPI_SpellName(HBC_GREATER_BLESSING_OF_WISDOM) or "x"]=54,
                                       [HealBot_WoWAPI_SpellName(HBC_BLESSING_OF_WISDOM) or "x"]=14,
                                       [HealBot_WoWAPI_SpellName(HBC_GREATER_BLESSING_OF_SANCTUARY) or "x"]=60,
                                       [HealBot_WoWAPI_SpellName(HBC_GREATER_BLESSING_OF_KINGS) or "x"]=60,
                                      }
            end
            
            if HEALBOT_GAME_VERSION<3 then
                classicAbsorbBonusV1["DEFAULT"]=ceil(GetSpellBonusHealing()*0.3)
                classicAbsorbBonusV1[HealBot_Data["PGUID"]]=classicAbsorbBonusV1["DEFAULT"]
                HealBot_Classic_Absorbs={[HealBot_WoWAPI_SpellInfo(HEALBOT_POWER_WORD_SHIELD) or "Power Word: Shield"]={[17]=48,
                                                            [592]=94,
                                                            [600]=166,
                                                           [3747]=244,
                                                           [6065]=313,
                                                           [6066]=394,
                                                          [10898]=499,
                                                          [10899]=622,
                                                          [10900]=783,
                                                          [10901]=942,
                                                          [25217]=1144,
                                                          [25218]=1265,
                                                          [48065]=1951,
                                                          [48066]=2230,
                                                              [0]=2230,},
                                         [(HealBot_WoWAPI_SpellInfo(HEALBOT_ICE_BARRIER) or "Ice Barrier")]={[11426]=455,
                                                                                                 [13031]=569,
                                                                                                 [13032]=700,
                                                                                                 [13033]=824,
                                                                                                 [27134]=952,
                                                                                                 [33405]=1075,
                                                                                                 [43038]=2860,
                                                                                                 [43039]=3300,
                                                                                                     [0]=3300,},
                                         [(HealBot_WoWAPI_SpellInfo(HBC_MANA_SHIELD) or "Mana Shield")]={[1463]=120,
                                                                                             [8494]=210,
                                                                                             [8495]=300,
                                                                                            [10191]=390,
                                                                                            [10192]=480,
                                                                                            [10193]=570,
                                                                                            [27131]=715,
                                                                                            [43019]=1080,
                                                                                            [43020]=1330,
                                                                                                [0]=1330},
                                    }
                HealBot_Classic_AbsorbsV1Track[HealBot_WoWAPI_SpellInfo(HEALBOT_POWER_WORD_SHIELD) or "Power Word: Shield"]=0
                HealBot_Classic_AbsorbsV1Track[(HealBot_WoWAPI_SpellInfo(HEALBOT_ICE_BARRIER) or "Ice Barrier")]=0
                HealBot_Classic_AbsorbsV1Track[(HealBot_WoWAPI_SpellInfo(HBC_MANA_SHIELD) or "Mana Shield")]=0
            else
                if HealBot_Config.ClassicAbsorbsFilter == 1 then
                    HealBot_Classic_Absorbs={[(HealBot_WoWAPI_SpellName(76669) or "Illuminated Healing")]=true}
                else
                    HealBot_Classic_Absorbs={[(HealBot_WoWAPI_SpellName(HEALBOT_POWER_WORD_SHIELD) or "Power Word: Shield")]=true,
                                             [(HealBot_WoWAPI_SpellName(47509) or "Divine Aegis")]=true,
                                             [(HealBot_WoWAPI_SpellName(76669) or "Illuminated Healing")]=true,
                                             [(HealBot_WoWAPI_SpellName(HEALBOT_ICE_BARRIER) or "Ice Barrier")]=true,
                                             [(HealBot_WoWAPI_SpellName(HBC_MANA_SHIELD) or "Mana Shield")]=true,
                                             [(HealBot_WoWAPI_SpellName(HEALBOT_SACRED_SHIELD) or "Sacred Shield")]=true,
                                             [(HealBot_WoWAPI_SpellName(77513) or "Blood Shield")]=true,
                                             [(HealBot_WoWAPI_SpellName(48707) or "Anti-Magic Shell")]=true,
                                            }
                end
            end
        end
        HealBot_Timers_Set("LAST","InitItemsData")
    else
        HealBot_SetPlayerData()
        HealBot_Timers_Set("AURA","InitAuraData",true,true)
    end
    if HEALBOT_GAME_VERSION>9 and not BleedList[703] then
        BleedList[703] = "Garrote"
        BleedList[1079] = "Rip"
        BleedList[1943] = "Rupture"
        BleedList[3147] = "Rend Flesh"
        BleedList[5597] = "Serious Wound"
        BleedList[5598] = "Serious Wound"
        BleedList[8818] = "Garrote"
        BleedList[10266] = "Lung Puncture"
        BleedList[11977] = "Rend"
        BleedList[12054] = "Rend"
        BleedList[13318] = "Rend"
        BleedList[13443] = "Rend"
        BleedList[13445] = "Rend"
        BleedList[13738] = "Rend"
        BleedList[14087] = "Rend"
        BleedList[14118] = "Rend"
        BleedList[14331] = "Vicious Rend"
        BleedList[14874] = "Rupture"
        BleedList[14903] = "Rupture"
        BleedList[15583] = "Rupture"
        BleedList[15976] = "Puncture"
        BleedList[16095] = "Vicious Rend"
        BleedList[16393] = "Rend"
        BleedList[16403] = "Rend"
        BleedList[16406] = "Rend"
        BleedList[16509] = "Rend"
        BleedList[17153] = "Rend"
        BleedList[17504] = "Rend"
        BleedList[18075] = "Rend"
        BleedList[18078] = "Rend"
        BleedList[18106] = "Rend"
        BleedList[18200] = "Rend"
        BleedList[18202] = "Rend"
        BleedList[19771] = "Serrated Bite"
        BleedList[21949] = "Rend"
        BleedList[24192] = "Speed Slash"
        BleedList[24331] = "Rake"
        BleedList[24332] = "Rake"
        BleedList[27555] = "Shred"
        BleedList[27556] = "Rake"
        BleedList[27638] = "Rake"
        BleedList[28913] = "Flesh Rot"
        BleedList[29574] = "Rend"
        BleedList[29578] = "Rend"
        BleedList[29583] = "Impale"
        BleedList[29906] = "Ravage"
        BleedList[29935] = "Gaping Maw"
        BleedList[30285] = "Eagle Claw"
        BleedList[30639] = "Carnivorous Bite"
        BleedList[31041] = "Mangle"
        BleedList[31410] = "Coral Cut"
        BleedList[31956] = "Grievous Wound"
        BleedList[32019] = "Gore"
        BleedList[32901] = "Carnivorous Bite"
        BleedList[33865] = "Singe"
        BleedList[33912] = "Rip"
        BleedList[35144] = "Vicious Rend"
        BleedList[35318] = "Saw Blade"
        BleedList[35321] = "Gushing Wound"
        BleedList[36023] = "Deathblow"
        BleedList[36332] = "Rake"
        BleedList[36383] = "Carnivorous Bite"
        BleedList[36590] = "Rip"
        BleedList[36617] = "Gaping Maw"
        BleedList[36789] = "Diminish Soul"
        BleedList[36965] = "Rend"
        BleedList[36991] = "Rend"
        BleedList[37066] = "Garrote"
        BleedList[37123] = "Saw Blade"
        BleedList[37487] = "Blood Heal"
        BleedList[37641] = "Whirlwind"
        BleedList[37662] = "Rend"
        BleedList[37937] = "Flayed Flesh"
        BleedList[37973] = "Coral Cut"
        BleedList[38056] = "Flesh Rip"
        BleedList[38363] = "Gushing Wound"
        BleedList[38772] = "Grievous Wound"
        BleedList[38801] = "Grievous Wound"
        BleedList[38810] = "Gaping Maw"
        BleedList[38848] = "Diminish Soul"
        BleedList[39198] = "Carnivorous Bite"
        BleedList[39215] = "Gushing Wound"
        BleedList[39382] = "Carnivorous Bite"
        BleedList[40199] = "Flesh Rip"
        BleedList[41092] = "Carnivorous Bite"
        BleedList[41932] = "Carnivorous Bite"
        BleedList[42395] = "Lacerating Slash"
        BleedList[42397] = "Rend Flesh"
        BleedList[42658] = "Sic'em!"
        BleedList[43093] = "Grievous Throw"
        BleedList[43104] = "Deep Wound"
        BleedList[43153] = "Lynx Rush"
        BleedList[43246] = "Rend"
        BleedList[43931] = "Rend"
        BleedList[43937] = "Grievous Wound"
        BleedList[48130] = "Gore"
        BleedList[48261] = "Impale"
        BleedList[48286] = "Grievous Slash"
        BleedList[48374] = "Puncture Wound"
        BleedList[48880] = "Rend"
        BleedList[48920] = "Grievous Bite"
        BleedList[49678] = "Flesh Rot"
        BleedList[50729] = "Carnivorous Bite"
        BleedList[50871] = "Savage Rend"
        BleedList[51275] = "Gut Rip"
        BleedList[52401] = "Gut Rip"
        BleedList[52504] = "Lacerate"
        BleedList[52771] = "Wounding Strike"
        BleedList[52873] = "Open Wound"
        BleedList[53317] = "Rend"
        BleedList[53499] = "Rake"
        BleedList[53602] = "Dart"
        BleedList[54668] = "Rake"
        BleedList[54703] = "Rend"
        BleedList[54708] = "Rend"
        BleedList[55102] = "Determined Gore"
        BleedList[55249] = "Whirling Slash"
        BleedList[55250] = "Whirling Slash"
        BleedList[55276] = "Puncture"
        BleedList[55550] = "Jagged Knife"
        BleedList[55604] = "Death Plague"
        BleedList[55622] = "Impale"
        BleedList[55645] = "Death Plague"
        BleedList[57661] = "Rip"
        BleedList[58459] = "Impale"
        BleedList[58517] = "Grievous Wound"
        BleedList[58830] = "Wounding Strike"
        BleedList[58978] = "Impale"
        BleedList[59007] = "Flesh Rot"
        BleedList[59023] = "Puncturing Strike"
        BleedList[59239] = "Rend"
        BleedList[59256] = "Impale"
        BleedList[59262] = "Grievous Wound"
        BleedList[59264] = "Gore"
        BleedList[59268] = "Impale"
        BleedList[59269] = "Carnivorous Bite"
        BleedList[59343] = "Rend"
        BleedList[59349] = "Dart"
        BleedList[59444] = "Determined Gore"
        BleedList[59682] = "Grievous Wound"
        BleedList[59691] = "Rend"
        BleedList[59824] = "Whirling Slash"
        BleedList[59825] = "Whirling Slash"
        BleedList[59826] = "Puncture"
        BleedList[59881] = "Rake"
        BleedList[59989] = "Rip"
        BleedList[61164] = "Impale"
        BleedList[61896] = "Lacerate"
        BleedList[62318] = "Barbed Shot"
        BleedList[62331] = "Impale"
        BleedList[62418] = "Impale"
        BleedList[63468] = "Careful Aim"
        BleedList[64374] = "Savage Pounce"
        BleedList[64666] = "Savage Pounce"
        BleedList[65033] = "Constricting Rend"
        BleedList[65406] = "Rake"
        BleedList[66620] = "Old Wounds"
        BleedList[67280] = "Dagger Throw"
        BleedList[69203] = "Vicious Bite"
        BleedList[70278] = "Puncture Wound"
        BleedList[71926] = "Rip"
        BleedList[74846] = "Bleeding Wound"
        BleedList[75160] = "Bloody Rip"
        BleedList[75161] = "Spinning Rake"
        BleedList[75388] = "Rusty Cut"
        BleedList[75930] = "Mangle"
        BleedList[76507] = "Claw Puncture"
        BleedList[76524] = "Grievous Whirl"
        BleedList[76594] = "Rend"
        BleedList[78842] = "Carnivorous Bite"
        BleedList[78859] = "Elementium Spike Shield"
        BleedList[79444] = "Impale"
        BleedList[79828] = "Mangle"
        BleedList[79829] = "Rip"
        BleedList[80028] = "Rock Bore"
        BleedList[80051] = "Grievous Wound"
        BleedList[81043] = "Razor Slice"
        BleedList[81087] = "Puncture Wound"
        BleedList[81568] = "Spinning Slash"
        BleedList[81569] = "Spinning Slash"
        BleedList[81690] = "Scent of Blood"
        BleedList[82753] = "Ritual of Bloodletting"
        BleedList[82766] = "Eye Gouge"
        BleedList[83783] = "Impale"
        BleedList[84642] = "Puncture"
        BleedList[85415] = "Mangle"
        BleedList[87395] = "Serrated Slash"
        BleedList[89212] = "Eagle Claw"
        BleedList[90098] = "Axe to the Head"
        BleedList[91348] = "Tenderize"
        BleedList[93587] = "Ritual of Bloodletting"
        BleedList[93675] = "Mortal Wound"
        BleedList[95334] = "Elementium Spike Shield"
        BleedList[96570] = "Gaping Wound"
        BleedList[96592] = "Ravage"
        BleedList[96700] = "Ravage"
        BleedList[97357] = "Gaping Wound"
        BleedList[98282] = "Tiny Rend"
        BleedList[99100] = "Mangle"
        BleedList[102066] = "Flesh Rip"
        BleedList[102925] = "Garrote"
        BleedList[112896] = "Drain Blood"
        BleedList[113344] = "Bloodbath"
        BleedList[113855] = "Bleeding Wound"
        BleedList[114056] = "Bloody Mess"
        BleedList[114860] = "Rend"
        BleedList[114881] = "Hawk Rend"
        BleedList[115767] = "Deep Wounds"
        BleedList[115774] = "Vicious Wound"
        BleedList[115871] = "Rake"
        BleedList[118146] = "Lacerate"
        BleedList[119840] = "Serrated Blade"
        BleedList[120166] = "Serrated Blade"
        BleedList[120560] = "Rake"
        BleedList[120699] = "Lynx Rush"
        BleedList[121247] = "Impale"
        BleedList[121411] = "Crimson Tempest"
        BleedList[122962] = "Carnivorous Bite"
        BleedList[123422] = "Arterial Bleeding"
        BleedList[123852] = "Gored"
        BleedList[124015] = "Gored"
        BleedList[124296] = "Vicious Strikes"
        BleedList[124341] = "Bloodletting"
        BleedList[124678] = "Hacking Slash"
        BleedList[124800] = "Pinch Limb"
        BleedList[125099] = "Rake"
        BleedList[125206] = "Rend Flesh"
        BleedList[125431] = "Slice Bone"
        BleedList[125624] = "Vicious Rend"
        BleedList[126901] = "Mortal Rend"
        BleedList[126912] = "Grievous Whirl"
        BleedList[127872] = "Consume Flesh"
        BleedList[127987] = "Bleeding Bite"
        BleedList[128051] = "Serrated Slash"
        BleedList[128903] = "Garrote"
        BleedList[129463] = "Crane Kick"
        BleedList[129497] = "Pounced"
        BleedList[129537] = "Snap!"
        BleedList[130191] = "Rake"
        BleedList[130306] = "Ankle Bite"
        BleedList[130785] = "My Eye!"
        BleedList[130897] = "Vicious Bite"
        BleedList[131662] = "Vicious Stabbing"
        BleedList[133074] = "Puncture"
        BleedList[133081] = "Rip"
        BleedList[134691] = "Impale"
        BleedList[135528] = "Bleeding Wound"
        BleedList[135892] = "Razor Slice"
        BleedList[136654] = "Rending Charge"
        BleedList[136753] = "Slashing Talons"
        BleedList[137497] = "Garrote"
        BleedList[138956] = "Dark Bite"
        BleedList[139514] = "Bloodstorm"
        BleedList[140274] = "Vicious Wound"
        BleedList[140275] = "Rend"
        BleedList[140276] = "Rend"
        BleedList[140396] = "Rend"
        BleedList[143198] = "Garrote"
        BleedList[144113] = "Chomp"
        BleedList[144263] = "Rend"
        BleedList[144264] = "Rend"
        BleedList[144304] = "Rend"
        BleedList[144853] = "Carnivorous Bite"
        BleedList[145263] = "Chomp"
        BleedList[145417] = "Rupture"
        BleedList[146556] = "Pierce"
        BleedList[146927] = "Rend"
        BleedList[147396] = "Rake"
        BleedList[148033] = "Grapple"
        BleedList[148375] = "Brutal Hemorrhage"
        BleedList[150807] = "Traumatic Strike"
        BleedList[151092] = "Traumatic Strike"
        BleedList[151475] = "Drain Life"
        BleedList[152357] = "Rend"
        BleedList[152623] = "Rend"
        BleedList[152724] = "Lacerating Strike"
        BleedList[153897] = "Rending Cleave"
        BleedList[154489] = "Puncturing Horns"
        BleedList[154953] = "Internal Bleeding"
        BleedList[154960] = "Pinned Down"
        BleedList[155065] = "Ripping Claw"
        BleedList[155701] = "Serrated Slash"
        BleedList[155722] = "Rake"
        BleedList[157344] = "Vital Strike"
        BleedList[158020] = "Rearing Charge"
        BleedList[158150] = "Goring Swipe"
        BleedList[158341] = "Gushing Wounds"
        BleedList[158453] = "Rending Swipe"
        BleedList[158667] = "Warleader's Spear"
        BleedList[159238] = "Shattered Bleed"
        BleedList[161117] = "Puncturing Tusk"
        BleedList[161229] = "Pounce"
        BleedList[161765] = "Iron Axe"
        BleedList[162487] = "Steel Trap"
        BleedList[162516] = "Whirling Steel"
        BleedList[162921] = "Peck"
        BleedList[162951] = "Lacerating Spines"
        BleedList[163276] = "Shredded Tendons"
        BleedList[164218] = "Double Slash"
        BleedList[164323] = "Precise Strike"
        BleedList[164427] = "Ravage"
        BleedList[165308] = "Gushing Wound"
        BleedList[166185] = "Rending Slash"
        BleedList[166638] = "Gushing Wound"
        BleedList[166639] = "Item - Druid T17 Feral 4P Bonus Proc Driver"
        BleedList[166917] = "Savage"
        BleedList[167334] = "Windfang Bite"
        BleedList[167597] = "Rending Nails"
        BleedList[167978] = "Jagged Edge"
        BleedList[168097] = "Shredder Bomb"
        BleedList[168392] = "Fangs of the Predator"
        BleedList[169584] = "Serrated Spines"
        BleedList[170367] = "Vicious Throw"
        BleedList[170373] = "Razor Teeth"
        BleedList[170936] = "Talador Venom"
        BleedList[172019] = "Stingtail Venom"
        BleedList[172035] = "Thrash"
        BleedList[172139] = "Lacerating Bite"
        BleedList[172361] = "Puncturing Strike"
        BleedList[172366] = "Jagged Slash"
        BleedList[172657] = "Serrated Edge"
        BleedList[172889] = "Charging Slash"
        BleedList[173113] = "Hatchet Toss"
        BleedList[173278] = "Spinal Shards"
        BleedList[173299] = "Rip"
        BleedList[173307] = "Serrated Spear"
        BleedList[173378] = "Rending Bite"
        BleedList[173643] = "Drill Fist"
        BleedList[173876] = "Rending Claws"
        BleedList[174423] = "Pinning Spines"
        BleedList[174734] = "Axe to the Face!"
        BleedList[174820] = "Rending Claws"
        BleedList[175014] = "Rupture"
        BleedList[175151] = "Thousand Fangs"
        BleedList[175156] = "Painful Pinch"
        BleedList[175372] = "Sharp Teeth"
        BleedList[175461] = "Sadistic Slice"
        BleedList[175747] = "Big Sharp Nasty Claws"
        BleedList[176147] = "Ignite"
        BleedList[176256] = "Talon Sweep"
        BleedList[176575] = "Consume Flesh"
        BleedList[176695] = "Bone Fragments"
        BleedList[177337] = "Carnivorous Bite"
        BleedList[177422] = "Thrash"
        BleedList[181346] = "Lacerating Swipe"
        BleedList[181533] = "Jagged Blade"
        BleedList[182325] = "Phantasmal Wounds"
        BleedList[182330] = "Coral Cut"
        BleedList[182347] = "Impaling Coral"
        BleedList[182795] = "Primal Mangle"
        BleedList[182846] = "Thrash"
        BleedList[183025] = "Rending Lash"
        BleedList[183952] = "Shadow Claws"
        BleedList[184025] = "Rending Claws"
        BleedList[184090] = "Bloody Arc"
        BleedList[184175] = "Primal Rake"
        BleedList[185539] = "Rapid Rupture"
        BleedList[185698] = "Bloody Hack"
        BleedList[185855] = "Lacerate"
        BleedList[186191] = "Bloodletting Slash"
        BleedList[186365] = "Sweeping Blade"
        BleedList[186594] = "Laceration"
        BleedList[186639] = "Big Sharp Nasty Teeth"
        BleedList[186730] = "Exposed Wounds"
        BleedList[187647] = "Bloodletting Pounce"
        BleedList[188353] = "Rip"
        BleedList[189035] = "Barbed Cutlass"
        BleedList[191977] = "Impaling Spear"
        BleedList[192090] = "Thrash"
        BleedList[192131] = "Throw Spear"
        BleedList[192925] = "Blood of the Assassinated"
        BleedList[193092] = "Bloodletting Sweep"
        BleedList[193340] = "Fenri's Bite"
        BleedList[193585] = "Bound"
        BleedList[193639] = "Bone Chomp"
        BleedList[194636] = "Cursed Rend"
        BleedList[194639] = "Rending Claws"
        BleedList[194674] = "Barbed Spear"
        BleedList[195094] = "Coral Slash"
        BleedList[195506] = "Razorsharp Axe"
        BleedList[196111] = "Jagged Claws"
        BleedList[196122] = "Severing Swipe"
        BleedList[196189] = "Bloody Talons"
        BleedList[196313] = "Lacerating Talons"
        BleedList[196376] = "Grievous Tear"
        BleedList[196497] = "Ravenous Leap"
        BleedList[197359] = "Shred"
        BleedList[197381] = "Exposed Wounds"
        BleedList[197546] = "Brutal Glaive"
        BleedList[197863] = "Gore"
        BleedList[199108] = "Frantic Gore"
        BleedList[199146] = "Bucking Charge"
        BleedList[199337] = "Bear Trap"
        BleedList[199847] = "Grievous Wound"
        BleedList[200182] = "Festering Rip"
        BleedList[200620] = "Frantic Rip"
        BleedList[204175] = "Rend"
        BleedList[204179] = "Rend Flesh"
        BleedList[204968] = "Hemoraging Barbs"
        BleedList[205437] = "Laceration"
        BleedList[207662] = "Nightmare Wounds"
        BleedList[207690] = "Bloodlet"
        BleedList[208470] = "Necrotic Thrash"
        BleedList[208945] = "Mangle"
        BleedList[208946] = "Rip"
        BleedList[209336] = "Mangle"
        BleedList[209378] = "Whirling Blades"
        BleedList[209667] = "Blade Surge"
        BleedList[209858] = "Necrotic Wound"
        BleedList[210013] = "Bloodletting Slash"
        BleedList[210177] = "Spiked Shield"
        BleedList[210723] = "Ashamane's Frenzy"
        BleedList[211672] = "Mutilated Flesh"
        BleedList[211846] = "Bloodletting Lunge"
        BleedList[213431] = "Gnawing Eagle"
        BleedList[213537] = "Bloody Pin"
        BleedList[213824] = "Rending Pounce"
        BleedList[213933] = "Harpoon Swipe"
        BleedList[213990] = "Shard Bore"
        BleedList[214424] = "Gore"
        BleedList[214676] = "Razorsharp Teeth"
        BleedList[214967] = "Bloody Blade"
        BleedList[215442] = "Shred"
        BleedList[215506] = "Jagged Quills"
        BleedList[215537] = "Trauma"
        BleedList[215721] = "Gut Slash"
        BleedList[217023] = "Antler Gore"
        BleedList[217041] = "Shred"
        BleedList[217091] = "Puncturing Stab"
        BleedList[217142] = "Mangle"
        BleedList[217163] = "Rend"
        BleedList[217200] = "Barbed Shot"
        BleedList[217235] = "Rending Whirl"
        BleedList[217363] = "Ashamane's Frenzy"
        BleedList[217369] = "Rake"
        BleedList[217868] = "Impale"
        BleedList[218506] = "Jagged Slash"
        BleedList[219167] = "Chomp"
        BleedList[219240] = "Bloody Ricochet"
        BleedList[219339] = "Thrash"
        BleedList[219680] = "Impale"
        BleedList[220222] = "Rending Snap"
        BleedList[220874] = "Lacerate"
        BleedList[221352] = "Cut the Flank"
        BleedList[221422] = "Vicious Bite"
        BleedList[221759] = "Feathery Stab"
        BleedList[221770] = "Rend Flesh"
        BleedList[222491] = "Gutripper"
        BleedList[223111] = "Rake"
        BleedList[223572] = "Rend"
        BleedList[223954] = "Rake"
        BleedList[223967] = "Tear Flesh"
        BleedList[224435] = "Ashamane's Rip"
        BleedList[225484] = "Grievous Rip"
        BleedList[225963] = "Bloodthirsty Leap"
        BleedList[227742] = "Garrote"
        BleedList[228275] = "Rend"
        BleedList[228281] = "Rend"
        BleedList[228305] = "Unyielding Rend"
        BleedList[229127] = "Powershot"
        BleedList[229265] = "Garrote"
        BleedList[229923] = "Talon Rend"
        BleedList[230011] = "Cruel Garrote"
        BleedList[231003] = "Barbed Talons"
        BleedList[231998] = "Jagged Abrasion"
        BleedList[232135] = "Bloody Jab"
        BleedList[234052] = "Whirlwind"
        BleedList[235832] = "Bloodletting Strike"
        BleedList[237346] = "Rend"
        BleedList[238594] = "Ripper Blade"
        BleedList[238618] = "Fel Swipe"
        BleedList[238660] = "Wild Swipe"
        BleedList[240449] = "Grievous Wound"
        BleedList[240539] = "Wild Bite"
        BleedList[240559] = "Grievous Wound"
        BleedList[241070] = "Bloodletting Strike"
        BleedList[241092] = "Rend"
        BleedList[241212] = "Fel Slash"
        BleedList[241465] = "Coral Cut"
        BleedList[241644] = "Mangle"
        BleedList[242376] = "Puncturing Strike"
        BleedList[242828] = "Dire Thrash"
        BleedList[242931] = "Rake"
        BleedList[244040] = "Eskhandar's Rake"
        BleedList[246904] = "Smoldering Rend"
        BleedList[247932] = "Shrapnel Blast"
        BleedList[247949] = "Shrapnel Blast"
        BleedList[250393] = "Rake"
        BleedList[251332] = "Rip"
        BleedList[253384] = "Slaughter"
        BleedList[253516] = "Hexabite"
        BleedList[253610] = "Ripper Blade"
        BleedList[254280] = "Jagged Maw"
        BleedList[254575] = "Rend"
        BleedList[254901] = "Blood Frenzy"
        BleedList[255299] = "Bloodletting"
        BleedList[255434] = "Serrated Teeth"
        BleedList[255595] = "Chomp"
        BleedList[255627] = "Piercing Thrust"
        BleedList[255814] = "Rending Maul"
        BleedList[256077] = "Gore"
        BleedList[256314] = "Barbed Strike"
        BleedList[256363] = "Ripper Punch"
        BleedList[256476] = "Rending Whirl"
        BleedList[256709] = "Singing Steel"
        BleedList[256715] = "Jagged Maw"
        BleedList[256880] = "Bone Splinter"
        BleedList[256914] = "Barbed Blade"
        BleedList[256965] = "Thorned Barrage"
        BleedList[257036] = "Feral Charge"
        BleedList[257250] = "Bramblepelt"
        BleedList[257544] = "Jagged Cut"
        BleedList[257790] = "Gutripper"
        BleedList[257971] = "Leaping Thrash"
        BleedList[258058] = "Squeeze"
        BleedList[258075] = "Itchy Bite"
        BleedList[258143] = "Rending Claws"
        BleedList[258718] = "Scratched!"
        BleedList[258798] = "Razorsharp Teeth"
        BleedList[258825] = "Vampiric Bite"
        BleedList[259220] = "Barbed Net"
        BleedList[259277] = "Kill Command"
        BleedList[259328] = "Gory Whirl"
        BleedList[259382] = "Shell Slash"
        BleedList[259739] = "Stone Claws"
        BleedList[259873] = "Rip"
        BleedList[259983] = "Pierce"
        BleedList[260016] = "Itchy Bite"
        BleedList[260025] = "Rending Whirl"
        BleedList[260291] = "Rending Cut"
        BleedList[260400] = "Rend"
        BleedList[260455] = "Serrated Fangs"
        BleedList[260563] = "Gnaw"
        BleedList[260582] = "Gushing Wound"
        BleedList[260741] = "Jagged Nettles"
        BleedList[261882] = "Steel Jaw Trap"
        BleedList[261910] = "Cutting Slash"
        BleedList[262115] = "Deep Wounds"
        BleedList[262143] = "Ravenous Claws"
        BleedList[262557] = "Rake"
        BleedList[262677] = "Keelhaul"
        BleedList[262875] = "Papercut"
        BleedList[263144] = "Talon Slash"
        BleedList[263900] = "Rending Bite"
        BleedList[264145] = "Shatter"
        BleedList[264150] = "Shatter"
        BleedList[264210] = "Jagged Mandible"
        BleedList[264556] = "Tearing Strike"
        BleedList[264688] = "Goring Tusk"
        BleedList[265019] = "Savage Cleave"
        BleedList[265074] = "Rend"
        BleedList[265165] = "Charging Gore"
        BleedList[265232] = "Rend"
        BleedList[265341] = "Twin Cleave"
        BleedList[265377] = "Hooked Snare"
        BleedList[265533] = "Blood Maw"
        BleedList[265536] = "Rending Bite"
        BleedList[265948] = "Denticulated"
        BleedList[266035] = "Bone Splinter"
        BleedList[266191] = "Whirling Axe"
        BleedList[266231] = "Severing Axe"
        BleedList[266505] = "Rending Claw"
        BleedList[267064] = "Bleeding"
        BleedList[267080] = "Blight of G'huun"
        BleedList[267103] = "Blight of G'huun"
        BleedList[267441] = "Serrated Axe"
        BleedList[267523] = "Cutting Surge"
        BleedList[269576] = "Master Marksman"
        BleedList[269882] = "Overpowering Strike"
        BleedList[270084] = "Axe Barrage"
        BleedList[270139] = "Gore"
        BleedList[270343] = "Internal Bleeding"
        BleedList[270473] = "Serrated Arrows"
        BleedList[270487] = "Severing Blade"
        BleedList[270979] = "Rend and Tear"
        BleedList[270992] = "Rend Flesh"
        BleedList[271178] = "Ravaging Leap"
        BleedList[271798] = "Click"
        BleedList[272106] = "Rending Slash"
        BleedList[272273] = "Rending Cleave"
        BleedList[273436] = "Gore"
        BleedList[273632] = "Gaping Maw"
        BleedList[273794] = "Rezan's Fury"
        BleedList[273871] = "Shredding Claws"
        BleedList[273900] = "Bramble Swipe"
        BleedList[273909] = "Steelclaw Trap"
        BleedList[274089] = "Rend"
        BleedList[274389] = "Rat Traps"
        BleedList[274838] = "Feral Frenzy"
        BleedList[275090] = "Severing Swipe"
        BleedList[275570] = "Ravage"
        BleedList[275895] = "Rend of Kimbul"
        BleedList[276868] = "Impale"
        BleedList[276887] = "Hacking Slash"
        BleedList[277014] = "Bloody Maul"
        BleedList[277073] = "Jagged Blade"
        BleedList[277077] = "Big Sharp Nasty Teeth"
        BleedList[277309] = "Jagged Maw"
        BleedList[277431] = "Hunter Toxin"
        BleedList[277491] = "Crippling Strike"
        BleedList[277505] = "Spiked Shield"
        BleedList[277517] = "Serrated Slash"
        BleedList[277569] = "Bloodthirsty Rend"
        BleedList[277592] = "Blood Frenzy"
        BleedList[277794] = "Paw Swipe"
        BleedList[278139] = "Sharp Beak"
        BleedList[278175] = "Bramble Claw"
        BleedList[278396] = "Sever Artery"
        BleedList[278397] = "Slashing Talons"
        BleedList[278483] = "Toll"
        BleedList[278570] = "Boils and Sores"
        BleedList[278733] = "Deep Wound"
        BleedList[278866] = "Carve and Spit"
        BleedList[278950] = "Pouncing Claws"
        BleedList[279133] = "Rend"
        BleedList[279272] = "Puncturing Digit"
        BleedList[280286] = "Dagger in the Back"
        BleedList[280321] = "Garrote"
        BleedList[280940] = "Mangle"
        BleedList[281711] = "Cut of Death"
        BleedList[282444] = "Lacerating Claws"
        BleedList[282845] = "Bear Trap"
        BleedList[283419] = "Rend"
        BleedList[283667] = "Rupture"
        BleedList[283668] = "Crimson Tempest"
        BleedList[283700] = "Rake"
        BleedList[283708] = "Rip"
        BleedList[284158] = "Circular Saw"
        BleedList[285875] = "Rending Bite"
        BleedList[286269] = "Mangle"
        BleedList[288091] = "Gushing Wound"
        BleedList[288266] = "Mangle"
        BleedList[288516] = "Lacerating Swipe"
        BleedList[288535] = "Rip"
        BleedList[288539] = "Mangle"
        BleedList[289355] = "Smoldering Rend"
        BleedList[289373] = "Lacerating Pounce"
        BleedList[289848] = "Rending Claw"
        BleedList[292348] = "Bloodletting"
        BleedList[292611] = "Rake"
        BleedList[292626] = "Rip"
        BleedList[293670] = "Chainblade"
        BleedList[294617] = "Rupture"
        BleedList[294741] = "Saber Slash"
        BleedList[294901] = "Serrated Blades"
        BleedList[295008] = "Bloody Cleaver"
        BleedList[295929] = "Rats!"
        BleedList[295945] = "Rat Traps"
        BleedList[296777] = "Bleeding Wound"
        BleedList[297447] = "Sucking Teeth"
        BleedList[298029] = "Pincer Snap"
        BleedList[299474] = "Ripping Slash"
        BleedList[299502] = "Nanoslicer"
        BleedList[299923] = "Tear Flesh"
        BleedList[300610] = "Fanged Bite"
        BleedList[301061] = "Thrash"
        BleedList[301712] = "Pounce"
        BleedList[302295] = "Slicing Claw"
        BleedList[302474] = "Phantom Laceration"
        BleedList[302972] = "Rearing Charge"
        BleedList[303162] = "Carve Flesh"
        BleedList[303215] = "Shell Slash"
        BleedList[303501] = "Rending Strike"
        BleedList[304453] = "Hydra Maw"
        BleedList[308342] = "Bore"
        BleedList[308859] = "Carnivorous Bite"
        BleedList[308891] = "Jagged Chop"
        BleedList[308938] = "Lacerating Swipe"
        BleedList[309760] = "Raking Claws"
        BleedList[311122] = "Jagged Wound"
        BleedList[311744] = "Deep Wound"
        BleedList[311748] = "Lacerating Swipe"
        BleedList[313469] = "Rend"
        BleedList[313674] = "Jagged Wound"
        BleedList[313734] = "Ravaging Leap"
        BleedList[313747] = "Rend"
        BleedList[313957] = "Rend"
        BleedList[314130] = "Skewer"
        BleedList[314160] = "Penetrating Lance"
        BleedList[314454] = "Thrashing Lunge"
        BleedList[314531] = "Tear Flesh"
        BleedList[314568] = "Deep Wound"
        BleedList[314847] = "Decapitate"
        BleedList[314852] = "Rearing Charge"
        BleedList[315311] = "Ravage"
        BleedList[315711] = "Serrated Strike"
        BleedList[315805] = "Crippler"
        BleedList[316511] = "Scratch"
        BleedList[317561] = "Swooping Lunge"
        BleedList[317908] = "Razor Wing"
        BleedList[317916] = "Razor Clip"
        BleedList[318187] = "Gushing Wound"
        BleedList[319127] = "Gore"
        BleedList[319145] = "Rending Maul"
        BleedList[319275] = "Razor Wing"
        BleedList[319821] = "Regal Bite"
        BleedList[320007] = "Gash"
        BleedList[320147] = "Bleeding"
        BleedList[320200] = "Stitchneedle"
        BleedList[320617] = "Thrashing Whirl"
        BleedList[321043] = "Vital Slice"
        BleedList[321538] = "Bloodshed"
        BleedList[321807] = "Boneflay"
        BleedList[322429] = "Severing Slice"
        BleedList[322796] = "Wicked Gash"
        BleedList[322965] = "Tearing Bite"
        BleedList[323043] = "Bloodletting"
        BleedList[323406] = "Jagged Gash"
        BleedList[324073] = "Serrated Bone Spike"
        BleedList[324149] = "Flayed Shot"
        BleedList[324154] = "Dark Stride"
        BleedList[324447] = "Slashing Rend"
        BleedList[325021] = "Mistveil Tear"
        BleedList[325022] = "Jagged Swipe"
        BleedList[325037] = "Death Chakram"
        BleedList[326298] = "Bleeding Wound"
        BleedList[326586] = "Crimson Flurry"
        BleedList[327814] = "Wicked Gash"
        BleedList[328287] = "Heart Strike"
        BleedList[328897] = "Exsanguinated"
        BleedList[328910] = "Tantrum"
        BleedList[328940] = "Gore"
        BleedList[329293] = "Vorpal Wound"
        BleedList[329516] = "Swift Slash"
        BleedList[329563] = "Goring Swipe"
        BleedList[329609] = "Ravage"
        BleedList[329906] = "Carnage"
        BleedList[329986] = "Maul"
        BleedList[329990] = "Craggy Swipe"
        BleedList[330400] = "Bleeding Swipe"
        BleedList[330457] = "Ripping Strike"
        BleedList[330532] = "Jagged Quarrel"
        BleedList[330632] = "Maul"
        BleedList[331045] = "Talon Rake"
        BleedList[331066] = "Bursting Plumage"
        BleedList[331072] = "Talon Rake"
        BleedList[331340] = "Plague Swipe"
        BleedList[331415] = "Wicked Gash"
        BleedList[332168] = "Maul"
        BleedList[332610] = "Penetrating Insight"
        BleedList[332678] = "Gushing Wound"
        BleedList[332792] = "Gore"
        BleedList[332835] = "Ruthless Strikes"
        BleedList[332836] = "Chop"
        BleedList[333235] = "Horn Rush"
        BleedList[333250] = "Reaver"
        BleedList[333478] = "Gut Slice"
        BleedList[333861] = "Ricocheting Blade"
        BleedList[333985] = "Culling Strike"
        BleedList[334669] = "Tirnenn Wrath"
        BleedList[334960] = "Vicious Wound"
        BleedList[334971] = "Jagged Claws"
        BleedList[335105] = "Dinner Time"
        BleedList[336628] = "Eternal Polearm"
        BleedList[336810] = "Ragged Claws"
        BleedList[337349] = "Triple Thrash"
        BleedList[337729] = "Kerim's Laceration"
        BleedList[337892] = "Gore"
        BleedList[338935] = "Razor Petals"
        BleedList[339163] = "Wicked Gash"
        BleedList[339189] = "Chain Bleed"
        BleedList[339453] = "Darksworn Blast"
        BleedList[339789] = "Darksworn Blast"
        BleedList[339975] = "Grievous Strike"
        BleedList[340058] = "Heart Piercer"
        BleedList[340374] = "Bloody Tantrum"
        BleedList[340431] = "Mutilated Flesh"
        BleedList[341435] = "Lunge"
        BleedList[341475] = "Crimson Flurry"
        BleedList[341833] = "Rending Cleave"
        BleedList[341863] = "Bleeding Out"
        BleedList[342250] = "Jagged Swipe"
        BleedList[342391] = "Culling Cleave"
        BleedList[342464] = "Javelin Flurry"
        BleedList[342675] = "Bone Spear"
        BleedList[343159] = "Stone Claws"
        BleedList[343722] = "Crushing Bite"
        BleedList[344312] = "Serrated Edge"
        BleedList[344464] = "Shield Spike"
        BleedList[344993] = "Jagged Swipe"
        BleedList[345548] = "Spare Meat Hook"
        BleedList[346770] = "Grinding Bite"
        BleedList[346807] = "Rending Roar"
        BleedList[346823] = "Furious Cleave"
        BleedList[347227] = "Weighted Blade"
        BleedList[347716] = "Letter Opener"
        BleedList[348074] = "Assailing Lance"
        BleedList[348385] = "Bloody Cleave"
        BleedList[348726] = "Lethal Shot"
        BleedList[351119] = "Shuriken Blitz"
        BleedList[351976] = "Shredder"
        BleedList[353068] = "Razor Trap"
        BleedList[353466] = "Sadistic Glee"
        BleedList[353919] = "Rury's Sleepy Tantrum"
        BleedList[354334] = "Hook'd!"
        BleedList[355087] = "Piercing Quill"
        BleedList[355256] = "Rending Roar"
        BleedList[355416] = "Sharpened Hide"
        BleedList[355832] = "Quickblade"
        BleedList[356445] = "Sharpened Hide"
        BleedList[356620] = "Pouch of Razor Fragments"
        BleedList[356808] = "Spiked"
        BleedList[356923] = "Sever"
        BleedList[356925] = "Carnage"
        BleedList[357091] = "Cleave Flesh"
        BleedList[357192] = "Dark Flurry"
        BleedList[357239] = "Cleave Flesh"
        BleedList[357322] = "Night Glaive"
        BleedList[357665] = "Crystalline Flesh"
        BleedList[357827] = "Frantic Rip"
        BleedList[357938] = "Gnashing Teeth"
        BleedList[357953] = "Fanged Bite"
        BleedList[358197] = "Searing Scythe"
        BleedList[358224] = "Jagged Swipe"
        BleedList[359587] = "Bloody Peck"
        BleedList[359981] = "Rend"
        BleedList[360194] = "Deathmark"
        BleedList[360775] = "Puncture"
        BleedList[360826] = "Rupture"
        BleedList[360830] = "Garrote"
        BleedList[361024] = "Thief's Blade"
        BleedList[361042] = "Hardlight Assassination"
        BleedList[361049] = "Bleeding Gash"
        BleedList[361756] = "Death Chakram"
        BleedList[362194] = "Suffering"
        BleedList[362819] = "Rend"
        BleedList[363124] = "Hardlight Assassination"
        BleedList[363830] = "Sickle of the Lion"
        BleedList[363831] = "Bleeding Soul"
        BleedList[365336] = "Rending Bite"
        BleedList[365877] = "Jagged Blade"
        BleedList[366075] = "Bloody Peck"
        BleedList[366275] = "Rending Bite"
        BleedList[366884] = "Ripped Secrets"
        BleedList[367481] = "Bloody Bite"
        BleedList[367521] = "Bone Bolt"
        BleedList[367726] = "Lupine's Slash"
        BleedList[368401] = "Puncture"
        BleedList[368637] = "The Third Rune"
        BleedList[368651] = "Vicious Wound"
        BleedList[368701] = "Boon of Harvested Hope"
        BleedList[369408] = "Rending Slash"
        BleedList[369828] = "Chomp"
        BleedList[370742] = "Jagged Strike"
        BleedList[371472] = "Rake"
        BleedList[372224] = "Dragonbone Axe"
        BleedList[372397] = "Vicious Bite"
        BleedList[372404] = "Rend"
        BleedList[372474] = "Bloodletting"
        BleedList[372570] = "Bold Ambush"
        BleedList[372718] = "Earthen Shards"
        BleedList[372796] = "Blazing Rush"
        BleedList[372860] = "Searing Wounds"
        BleedList[373735] = "Dragon Strike"
        BleedList[373947] = "Rending Swipe"
        BleedList[374135] = "Gore"
        BleedList[374865] = "Rending Claw"
        BleedList[374892] = "Gore"
        BleedList[375201] = "Talon Rip"
        BleedList[375416] = "Bleeding"
        BleedList[375420] = "Woodchipper"
        BleedList[375475] = "Rending Bite"
        BleedList[375803] = "Mammoth Trap"
        BleedList[375893] = "Chakram"
        BleedList[375919] = "Severing Slice"
        BleedList[375937] = "Rending Strike"
        BleedList[376997] = "Savage Peck"
        BleedList[376999] = "Thrash"
        BleedList[377002] = "Thrash"
        BleedList[377344] = "Peck"
        BleedList[377609] = "Dragon Rend"
        BleedList[377732] = "Jagged Bite"
        BleedList[377854] = "Throat Gash"
        BleedList[378020] = "Gash Frenzy"
        BleedList[378118] = "Knocked Down"
        BleedList[378957] = "Spearhead"
        BleedList[378995] = "Deadly Rush"
        BleedList[381575] = "Lacerate"
        BleedList[381628] = "Internal Bleeding"
        BleedList[381672] = "Mutilated Flesh"
        BleedList[381692] = "Swift Stab"
        BleedList[384134] = "Pierce"
        BleedList[384148] = "Ensnaring Trap"
        BleedList[384366] = "Talon Rake"
        BleedList[384473] = "Skewer"
        BleedList[384575] = "Crippling Bite"
        BleedList[385042] = "Gushing Wound"
        BleedList[385060] = "Odyn's Fury"
        BleedList[385145] = "Chomp"
        BleedList[385363] = "Gore"
        BleedList[385511] = "Messy"
        BleedList[385638] = "Razor Fragments"
        BleedList[385834] = "Bloodthirsty Charge"
        BleedList[385905] = "Tailstrike"
        BleedList[386116] = "Messy"
        BleedList[386640] = "Tear Flesh"
        BleedList[387049] = "Shredding Bite"
        BleedList[387205] = "Beak Rend"
        BleedList[387473] = "Big Sharp Teeth"
        BleedList[387809] = "Splatter!"
        BleedList[388301] = "Savage Tear"
        BleedList[388377] = "Rending Slash"
        BleedList[388473] = "Feeding Frenzy"
        BleedList[388539] = "Rend"
        BleedList[388745] = "Slicing Claw"
        BleedList[388912] = "Severing Slash"
        BleedList[389505] = "Rending Slice"
        BleedList[389881] = "Spearhead"
        BleedList[390194] = "Rending Slash"
        BleedList[390583] = "Logcutter"
        BleedList[390834] = "Primal Rend"
        BleedList[391098] = "Puncturing Impalement"
        BleedList[391114] = "Cutting Winds"
        BleedList[391140] = "Frenzied Assault"
        BleedList[391308] = "Rending Swoop"
        BleedList[391356] = "Tear"
        BleedList[391725] = "Swooping Dive"
        BleedList[392006] = "Vicious Chomp"
        BleedList[392235] = "Furious Charge"
        BleedList[392236] = "Furious Charge"
        BleedList[392332] = "Horn Gore"
        BleedList[392341] = "Mighty Swipe"
        BleedList[392411] = "Beetle Thrust"
        BleedList[392416] = "Beetle Charge"
        BleedList[392734] = "Raking Slice"
        BleedList[392841] = "Hungry Chomp"
        BleedList[393426] = "Spear Swipe"
        BleedList[393444] = "Gushing Wound"
        BleedList[393718] = "Heartpiercer"
        BleedList[393817] = "Hardened Shards"
        BleedList[393820] = "Horn Swing"
        BleedList[394021] = "Mutilated Flesh"
        BleedList[394036] = "Serrated Bone Spike"
        BleedList[394063] = "Rend"
        BleedList[394371] = "Hit the Mark"
        BleedList[394628] = "Peck"
        BleedList[394647] = "Merciless Gore"
        BleedList[395827] = "Severing Gore"
        BleedList[395832] = "Jagged Cuts"
        BleedList[396007] = "Vicious Peck"
        BleedList[396093] = "Savage Leap"
        BleedList[396348] = "Dismember"
        BleedList[396353] = "Fatal Chomp"
        BleedList[396476] = "Rending Claw"
        BleedList[396639] = "Bloody Pounce"
        BleedList[396641] = "Rending Slash"
        BleedList[396674] = "Rupturing Slash"
        BleedList[396675] = "Hemorrhaging Rend"
        BleedList[396716] = "Splinterbark"
        BleedList[396807] = "Savage Gore"
        BleedList[397037] = "Slicing Winds"
        BleedList[397092] = "Impaling Horn"
        BleedList[397112] = "Primal Devastation"
        BleedList[397364] = "Thunderous Roar"
        BleedList[398392] = "Stomp"
        BleedList[398497] = "Rock Needle"
        BleedList[400050] = "Claw Rip"
        BleedList[400344] = "Spike Traps"
        BleedList[400941] = "Ragged Slash"
        BleedList[401370] = "Deep Claws"
        BleedList[403589] = "Gushing Wound"
        BleedList[403662] = "Garrote"
        BleedList[403790] = "Vicious Swipe"
        BleedList[404907] = "Rupturing Slash"
        BleedList[404945] = "Raking Slice"
        BleedList[404978] = "Devastating Rend"
        BleedList[405233] = "Thrash"
        BleedList[406183] = "Time Slash"
        BleedList[406215] = "Vicious Bite"
        BleedList[406365] = "Rending Charge"
        BleedList[406499] = "Ravening Leaps"
        BleedList[407120] = "Serrated Axe"
        BleedList[407313] = "Shrapnel"
        BleedList[411101] = "Artifact Shards"
        BleedList[411437] = "Brutal Lacerations"
        BleedList[411700] = "Slobbering Bite"
        BleedList[411924] = "Drilljaws"
        BleedList[412172] = "Ceaseless Nibbling"
        BleedList[412285] = "Stonebolt"
        BleedList[412505] = "Rending Cleave"
        BleedList[413131] = "Whirling Dagger"
        BleedList[413136] = "Whirling Dagger"
        BleedList[414340] = "Drenched Blades"
        BleedList[414466] = "Jagged Gills"
        BleedList[414506] = "Lacerate"
        BleedList[414552] = "Stonecrack"
        BleedList[416258] = "Stonebolt"
        BleedList[417751] = "Skewer"
        BleedList[417928] = "Burning Claws"
        BleedList[418009] = "Serrated Arrows"
        BleedList[418160] = "Sawblade-Storm"
        BleedList[418624] = "Rending Slash"
        BleedList[422466] = "Shadow Spines"
        BleedList[422683] = "Thrash"
        BleedList[423431] = "Crushing Blow"
        BleedList[424065] = "Umbral Destruction"
        BleedList[424414] = "Pierce Armor"
        BleedList[424426] = "Lunging Strike"
        BleedList[424493] = "Shadow Rupture"
        BleedList[425555] = "Crude Weapons"
        BleedList[426284] = "Finishing Wound"
        BleedList[426587] = "Bramble Burst"
        BleedList[426660] = "Razor Jaws"
        BleedList[427182] = "Bloody Pounce"
        BleedList[427621] = "Impale"
        BleedList[427635] = "Grievous Rip"
        BleedList[429233] = "Rezan's Fury"
        BleedList[431491] = "Tainted Slash"
        BleedList[432035] = "Slashing Menace"
        BleedList[432416] = "Treacherous Blow"
        BleedList[433825] = "Blood Feast"
        BleedList[434773] = "Mean Mug"
        BleedList[434860] = "Phase Blades"
        BleedList[438599] = "Bleeding Jab"
        BleedList[438975] = "Shredding Sting"
        BleedList[439037] = "Disembowel"
        BleedList[439468] = "Downward Trend"
        BleedList[439531] = "Bloodseeker Vines"
        BleedList[440107] = "Knife Throw"
        BleedList[440143] = "Feral Swipe"
        BleedList[440231] = "Cleaving Strikes"
        BleedList[440912] = "Lash"
        BleedList[441294] = "Jagged Strike"
        BleedList[441314] = "Lacerated Wound"
        BleedList[441413] = "Shredding Sting"
        BleedList[441812] = "Dreadful Wound"
        BleedList[443694] = "Crude Weapons"
        BleedList[443926] = "Ironweave Garrote"
        BleedList[444944] = "Talon Shred"
        BleedList[445184] = "Ambush"
        BleedList[445251] = "Rupturing Bite"
        BleedList[445311] = "Pincer Slice"
        BleedList[445497] = "Shred"
        BleedList[446535] = "Goring Charge"
        BleedList[447268] = "Skullsplitter"
        BleedList[447272] = "Hurl Spear"
        BleedList[448818] = "Scratch"
        BleedList[449233] = "Cull the Herd"
        BleedList[449585] = "Deep Cut"
        BleedList[449886] = "Deephunter's Bloody Hook"
        BleedList[449960] = "Fresh Cut"
        BleedList[450176] = "Jagged Slash"
        BleedList[450205] = "Clawing Pounce"
        BleedList[451177] = "Dreadful Wound"
        BleedList[451246] = "Jagged Slash"
        BleedList[452730] = "Domineering Gore"
        BleedList[452830] = "Gore Charge"
        BleedList[453031] = "Fury of the Roots"
        BleedList[453461] = "Caltrops"
        BleedList[453551] = "Bloodletting Rend"
        BleedList[453792] = "Brutal Strikes"
        BleedList[453919] = "Blood Frenzy"
        BleedList[453947] = "Jagged Maw"
        BleedList[454357] = "Piercing Spear"
        BleedList[454472] = "Gash Frenzy"
        BleedList[454539] = "Talon Swipe"
        BleedList[454587] = "Serrated Teeth"
        BleedList[454694] = "Headbutt"
        BleedList[454783] = "Void Rift"
        BleedList[454922] = "Slashing Claws"
        BleedList[454951] = "Skewer Flesh"
        BleedList[455543] = "Crushing Claws"
        BleedList[455815] = "Harvest Cabbage"
        BleedList[455896] = "Flurry of Steel"
        BleedList[455901] = "Gut Stab"
        BleedList[456145] = "Rake"
        BleedList[456147] = "Vicious Peck"
        BleedList[456265] = "Severing Thrash"
        BleedList[456284] = "Heroic Slash"
        BleedList[456516] = "Berserker Charge"
        BleedList[456851] = "Rock Needle"
        BleedList[457947] = "Limb-shredder Tornado"
        BleedList[458010] = "Deep Wounds"
        BleedList[458409] = "Goring Horn"
        BleedList[458771] = "Ravage"
        BleedList[459495] = "Soul Reaper"
        BleedList[459560] = "Laceration"
        BleedList[459753] = "Ravenous Leap"
        BleedList[459870] = "Merciless Blow"
        BleedList[461850] = "Piercing Fangs"
        BleedList[462018] = "Barbed Bolt"
        BleedList[463227] = "Splintered"
        BleedList[464064] = "Stab of Rubenstein"
        BleedList[464181] = "Bleeding"
        BleedList[464358] = "Rend"
        BleedList[464570] = "Toe-Slash"
        BleedList[465089] = "Shrapnel Blast"
        BleedList[465213] = "Bloody Slash"
        BleedList[465223] = "Blood Tithe"
        BleedList[465240] = "Blood Rush"
        BleedList[465247] = "Leg Rip"
        BleedList[465261] = "Perforate Flesh"
        BleedList[465271] = "Heart Shot"
        BleedList[467105] = "Ravenous Charge"
        BleedList[468457] = "Rend"
        BleedList[468873] = "Thrash"
        BleedList[468885] = "Rip"
        BleedList[468934] = "Rake"
        BleedList[469700] = "Stab"
        BleedList[470154] = "Latched On"
        BleedList[470632] = "Rend"
    end
end

function HealBot_Aura_ClearGUID(guid)
      --HealBot_setCall("HealBot_Aura_ClearGUID", nil, guid)
    hbAuraRequests[guid]=nil
    hbAuraWatchRaidTarget[guid]=nil
    hbAuraDebuffTagWatch[guid]=nil
    HealBot_UnitDebuffCurrent[guid]=nil
    hbAuraDebuffWatch[guid]=nil
    hbAuraBuffTagWatch[guid]=nil
    hbAuraBuffWatch[guid]=nil
    HealBot_UnitBuffCurrent[guid]=nil
end
