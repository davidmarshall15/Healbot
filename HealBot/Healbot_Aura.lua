local HealBot_UnitBuffIcons={}
local HealBot_UnitDebuffIcons={}
local HealBot_UnitBuffCurrent={}
local HealBot_UnitDebuffCurrent={}
local HealBot_UnitBuffTagsCurrent={}
local HealBot_UnitDebuffTagsCurrent={}
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
local uaName, uaTexture, uaCount, uaDebuffType, uaDuration="","",0,"",0
local uaExpirationTime, uaUnitCaster, uaUnitIsPlayer, uaSpellId, uaIsBossDebuff=0,"",false,0,false
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
local hb_lVars={}
hb_lVars["TankGUID1"]="x"
hb_lVars["mapName"]=HEALBOT_WORD_OUTSIDE
hb_lVars["IgnoreFastDurDebuffsSecs"]=-1
hb_lVars["HotBarDebuff"]=0
hb_lVars["ManaDrink"]=""
hb_lVars["WellFed"]=""
hb_lVars["TestBarsOn"]=false
hb_lVars["AuraUpdate"]=0.98
--hb_lVars["BossExists"]=false

local hbDebuffOnCD={}

local hbTextureUpdateId={}
local hbTextureUpdateTime={}

local BleedList={}
-- Forever build 71139, ordinary SpellCategories/SpellEffect mechanic 15
-- with a direct aura on the same difficulty. Use only on applied harmful data.
local ForeverHarmfulBleeds=HEALBOT_FOREVER and {
    [703]=true,[772]=true,[1079]=true,[1822]=true,[1823]=true,[1824]=true,[1943]=true,[3147]=true,
    [4102]=true,[4244]=true,[5597]=true,[5598]=true,[6546]=true,[6547]=true,[6548]=true,[8631]=true,
    [8632]=true,[8633]=true,[8639]=true,[8640]=true,[8818]=true,[9007]=true,[9492]=true,[9493]=true,
    [9752]=true,[9824]=true,[9826]=true,[9894]=true,[9896]=true,[9904]=true,[10266]=true,[11273]=true,
    [11274]=true,[11275]=true,[11289]=true,[11290]=true,[11572]=true,[11573]=true,[11574]=true,[11977]=true,
    [12054]=true,[13318]=true,[13443]=true,[13445]=true,[13738]=true,[14087]=true,[14118]=true,[14331]=true,
    [14874]=true,[14903]=true,[15583]=true,[15976]=true,[16095]=true,[16393]=true,[16403]=true,[16406]=true,
    [16509]=true,[17153]=true,[17504]=true,[18075]=true,[18078]=true,[18106]=true,[18200]=true,[18202]=true,
    [19771]=true,[21949]=true,[24118]=true,[24119]=true,[24120]=true,[24192]=true,[24331]=true,[24332]=true,
    [27555]=true,[27556]=true,[27638]=true,[28911]=true,[28913]=true,[29915]=true,[30285]=true,[407794]=true,
    [412096]=true,[412609]=true,[414644]=true,[417441]=true,[417448]=true,[424573]=true,[424785]=true,[430723]=true,
    [436332]=true,[458436]=true,[458481]=true,[458482]=true,[462724]=true,[462726]=true,[462727]=true,[462728]=true,
    [462729]=true,[462730]=true,[468076]=true,[1213176]=true,[1213442]=true,[1231094]=true,[1231317]=true,[1231387]=true,
    [1231775]=true,[1232390]=true,[1233361]=true,[1235826]=true,[1235827]=true,[1236125]=true,[1245164]=true,[1250421]=true,
    [1252000]=true,[1263129]=true,[1265038]=true,[1265039]=true,[1265040]=true,[1265041]=true,[1265042]=true,[1265065]=true,
    [1265066]=true,[1265067]=true,[1265068]=true,[1265069]=true,[1265883]=true,[1271514]=true,[1272982]=true,[1285903]=true,
    [1288524]=true,[1289140]=true,[1289141]=true,[1289250]=true,[1292029]=true,[1293682]=true,[1294426]=true,[1299332]=true,
    [1299739]=true,[1300787]=true,[1309069]=true,[1310243]=true,[1310536]=true,[1320824]=true,[1323184]=true,[1328616]=true,
    [1328617]=true,
} or {}

function HealBot_Aura_setLuVars(vName, vValue)
    --HealBot_setCall("HealBot_Aura_setLuVars - "..vName)
    hb_lVars[vName]=vValue
end

function HealBot_Aura_retLuVars(vName)
    --HealBot_setCall("HealBot_retLuVars"..vName)
    return hb_lVars[vName]
end

local function HealBot_Aura_EmptyLocalTable(t, key)
    if t and t[key] then
        hb_lVars["emptyTable"]=true
        for _,v in pairs(t[key]) do
            if v or v == false then
                hb_lVars["emptyTable"]=false
                break
            end
        end
        if hb_lVars["emptyTable"] then
            t[key]=nil
        end
    end
end

function HealBot_Aura_UpdateCheckInterval()
    hb_lVars["AuraUpdate"]=HealBot_Util_PerfVal4(98)
    if hb_lVars["AuraUpdate"]<0.9 then 
        hb_lVars["AuraUpdate"]=0.9 
    elseif hb_lVars["AuraUpdate"]>1 then 
        hb_lVars["AuraUpdate"]=0.99
    end
    HealBot_Debug_PerfUpdate("AuraUpdate", hb_lVars["AuraUpdate"])
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
    hb_lVars["updateAll"]=true
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
        local offset=button.icon.debuff.offset or 0
        for i=51+offset,50+offset+button.icon.debuff.count[1] do
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

hb_lVars["exIconAlpha"]=0
function HealBot_Aura_UpdateExtraIcon(button, iconData, index)
      --HealBot_setCall("HealBot_Aura_UpdateExtraIcon", button)
    if (index == 91 and hbv_Skins_GetFrameBoolean("Icons", "CLASSEN", button.frame)) or
       (index == 92 and hbv_Skins_GetFrameBoolean("Icons", "TARGETEN", button.frame)) or
       (index == 93 and hbv_Skins_GetFrameBoolean("Icons", "RCEN", button.frame)) or
       (index == 94 and hbv_Skins_GetFrameBoolean("Icons", "OOREN", button.frame)) or
       (index == 95 and hbv_Skins_GetFrameBoolean("Icons", "RANKEN", button.frame)) or
       (index == 96 and hbv_Skins_GetFrameBoolean("Icons", "COMBATEN", button.frame)) then
        hb_lVars["exIconAlpha"]=HealBot_Action_BarColourAlpha(button, hbv_Skins_GetFrameVar("BarCol", "HA", button.framecol), 1)
    else
        hb_lVars["exIconAlpha"]=button.status.alpha or 1
    end
    button.gref.icon[index]:SetAlpha(hb_lVars["exIconAlpha"])
end

local dbSecsLeft, dbRetAlpha, dbFadeDiff, dbNextAuraUpdate, dbMaxAlpha, dbMaxDur=0,0,0,1,1,1
function HealBot_Aura_DebuffIconAlphaValue(button, iconData, secsLeft)
      --HealBot_setCall("HealBot_Aura_DebuffIconAlphaValue", button, nil, nil, true)
    dbNextAuraUpdate=999
    if HealBot_issecretvalue(iconData.expirationTime) or HealBot_issecretvalue(iconData.duration) then
        -- Secret values: show icon at full alpha, skip fade/duration arithmetic
        if hbv_Skins_GetIconBoolean("DI15EN", button.frame, iconData.iconSet) then
            dbRetAlpha=HealBot_Action_BarColourAlpha(button, hbv_Skins_GetFrameVar("BarCol", "HA", button.framecol), 1)
        else
            dbRetAlpha=button.status.alpha
        end
        return dbRetAlpha, dbNextAuraUpdate
    end
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
    if index>=51 and index<=56 and HealBot_CombatAuras_UsesNativeDebuffs and HealBot_CombatAuras_UsesNativeDebuffs(button) then
        HealBot_Aura_RemoveIcon(button, index)
        return
    end
    if iconData.current and lastSpellId == iconData.spellId then
        dbAlphaNextUpdate=999
        dbDurNextUpdate=999
        if HealBot_issecretvalue(iconData.expirationTime) then
            dbSecsLeft=-1
        else
            dbSecsLeft=floor((iconData.expirationTime-HealBot_TimeNow)-0.5)
        end
        if not HealBot_issecretvalue(iconData.expirationTime) and iconData.expirationTime>0 then
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
        if not HealBot_issecretvalue(iconData.expirationTime) and dbSecsLeft>-2 and hbv_Skins_GetIconTextBoolean("DBSDUR", button.frame, iconData.iconSet) then
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
                dbDurNextUpdate=hb_lVars["AuraUpdate"]
            else
                button.gref.txt.expire[index]:SetTextColor(1,1,1,0)
                button.gref.txt.expire[index]:SetText(" ");
                dbDurNextUpdate=dbSecsLeft-hbv_Skins_GetIconTextVar("DBDURTHRH", button.frame, iconData.iconSet)
                --if (iconData.expirationTime-HealBot_TimeNow-1)>hbv_Skins_GetIconTextVar("DBDURTHRH", button.frame, iconData.iconSet) then
                --    dbDurNextUpdate=(iconData.expirationTime-HealBot_TimeNow-1)-hbv_Skins_GetIconTextVar("DBDURTHRH", button.frame, iconData.iconSet)
                --else
                --    dbDurNextUpdate=hb_lVars["AuraUpdate"]
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
function HealBot_Aura_CustomDebuffSetting(settings,id,name)
    if settings[id]~=nil then return settings[id] end
    if settings[name]~=nil then return settings[name] end
    local owners=hb_lVars.customDebuffNameOwners
    if owners and owners[name] then return settings[owners[name]] end
end

function HealBot_Aura_UpdateDebuffIcon(button, iconData, index, timer, spellId)
      --HealBot_setCall("HealBot_Aura_UpdateDebuffIcon", button, nil, nil, true)
    if index>=51 and index<=56 and HealBot_CombatAuras_UsesNativeDebuffs and HealBot_CombatAuras_UsesNativeDebuffs(button) then
        HealBot_Aura_RemoveIcon(button, index)
        return
    end
    HealBot_Aura_DoUpdateDebuffIcon(button, iconData, index, timer, spellId, false)
    if HealBot_AuraDebuffCache[spellId] then
        hbGlowSpellName=HealBot_AuraDebuffCache[spellId]["name"] or "x"
        hbGlowIdx=HealBot_DebuffIconGlow[spellId] or HealBot_DebuffIconGlow[hbGlowSpellName] or 1
    else
        hbGlowIdx=1
    end
    if hbGlowIdx>1 then
        local color=HealBot_Aura_CustomDebuffSetting(HealBot_Globals.CDCBarColour,spellId,hbGlowSpellName)
            or HealBot_Globals.CDCBarColour[customDebuffPriority]
        HealBot_Action_EnableIconGlow(button,color.R or 1,color.G or 0.25,color.B or 0.25,
            "ICONDEBUFF",hbGlowIdx,index,dbiconAlpha)
    elseif button.glow.icon[index]>1 then
        HealBot_Action_DisableIconGlow(button, "ICONDEBUFF", index)
    end
end

local bSecsLeft, bRetAlpha, bFadeDiff, bNextAuraUpdate, bMaxAlpha, bMaxDur=0,0,0,1,1,5
function HealBot_Aura_BuffIconAlphaValue(button, iconData, secsLeft)
      --HealBot_setCall("HealBot_Aura_BuffIconAlphaValue", button, nil, nil, true)
    bNextAuraUpdate=999
    if HealBot_issecretvalue(iconData.expirationTime) or HealBot_issecretvalue(iconData.duration) then
        -- Secret values: show icon at full alpha, skip fade/duration arithmetic
        if hbv_Skins_GetIconBoolean("BUFFI15EN", button.frame, iconData.iconSet) then
            bRetAlpha=HealBot_Action_BarColourAlpha(button, hbv_Skins_GetFrameVar("BarCol", "HA", button.framecol), 1)
        else
            bRetAlpha=button.status.alpha
        end
        return bRetAlpha, bNextAuraUpdate
    end
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
        if HealBot_issecretvalue(iconData.expirationTime) then
            bSecsLeft=-1
        else
            bSecsLeft=floor((iconData.expirationTime-HealBot_TimeNow)-0.5)
        end
        if not HealBot_issecretvalue(iconData.expirationTime) and iconData.expirationTime>0 then
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
        if not HealBot_issecretvalue(iconData.expirationTime) and bSecsLeft>-2 and hbv_Skins_GetIconTextBoolean("BUFFSDUR", button.frame, iconData.iconSet)
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
                bDurNextUpdate=hb_lVars["AuraUpdate"]
            else
                button.gref.txt.expire[index]:SetTextColor(1,1,1,0)
                button.gref.txt.expire[index]:SetText(" ");
                bDurNextUpdate=bSecsLeft-hbv_Skins_GetIconTextVar("BUFFDURTHRH", button.frame, iconData.iconSet)
                --if (iconData.expirationTime-HealBot_TimeNow-1)>hbv_Skins_GetIconTextVar("BUFFDURTHRH", button.frame, iconData.iconSet) then
                --    bDurNextUpdate=(iconData.expirationTime-HealBot_TimeNow-1)-hbv_Skins_GetIconTextVar("BUFFDURTHRH", button.frame, iconData.iconSet)
                --else
                --    bDurNextUpdate=hb_lVars["AuraUpdate"]
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
function HealBot_Aura_AuraWatchRaidTarget(unit, state)
        --HealBot_setCall("HealBot_Aura_AuraWatchRaidTarget", nil, guid)
    if state then
        hbAuraWatchRaidTarget[unit]=true
    else
        hbAuraWatchRaidTarget[unit]=nil
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
        if hbAuraWatchRaidTarget[button.unit] then
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

function HealBot_Aura_TestTank(button)
    if hb_lVars["TestBarsOn"] and button.rank == 5 then
        return true
    else
        return HealBot_Panel_IsTank(button.unit)
    end
end

function HealBot_Aura_UpdateRank(button)
        --HealBot_setCall("HealBot_Aura_UpdateRank", button)
    if HealBot_UnitExtraIcons[button.id] then
        if button.rank>0 and hbv_Skins_GetFrameBoolean("Icons", "SHOWRANK", button.frame) then
            HealBot_UnitExtraIcons[button.id][95]["texture"]=HealBot_Media_retRankIcon(button.rank)
            HealBot_UnitExtraIcons[button.id][95].current=true
            HealBot_Aura_AddExtraIcon(button, 95)
        elseif HealBot_Aura_TestTank(button) and hbv_Skins_GetFrameBoolean("Icons", "SHOWRANKMT", button.frame) then 
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
                HealBot_UnitExtraIcons[button.id][96]["texture"]=HealBot_Media_retCombatIcon("HOSTILE")
            else
                HealBot_UnitExtraIcons[button.id][96]["texture"]=HealBot_Media_retCombatIcon("INCOMBAT")
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
                HealBot_UnitExtraIcons[button.id][93]["texture"]=HealBot_Media_retStateIcon("AFK")
            else
                HealBot_UnitExtraIcons[button.id][93]["texture"]=HealBot_Media_retReadyCheckIcon(button.icon.extra.readycheck)
                if HealBot_Panel_RaidUnitButtonCheck(button.unit) then HealBot_Action_SetGuidData(button, "READYCHECK", button.icon.extra.readycheck) end
            end
            HealBot_UnitExtraIcons[button.id][93].current=true
            HealBot_Aura_AddExtraIcon(button, 93)
        elseif button.player and hbv_Skins_GetFrameBoolean("Icons", "SHOWRESTING", button.frame) and IsResting() then 
            HealBot_UnitExtraIcons[button.id][93]["texture"]=HealBot_Media_retStateIcon("REST")
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

function HealBot_Aura_setUnitIcons(unit, guid)
      --HealBot_setCall("HealBot_Aura_setUnitIcons", nil, nil, unit)
    if not HealBot_Aura_WarningFilter[unit] then HealBot_Aura_WarningFilter[unit]={} end
end

function HealBot_Aura_AutoUpdateCustomDebuff(button, name, spellId)
      --HealBot_setCall("HealBot_Aura_AutoUpdateCustomDebuff", button)
    local x=HealBot_Globals.CustomDebuffs[name]
    if not x or HealBot_WoWAPI_SpellName(name) then return end
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
    HealBot_Timers_Set("AURA","CustomDebuffListPrep")
end

function HealBot_Aura_CacheDebuffIcon(button, id, spellId, slot)
      --HealBot_setCall("HealBot_Aura_CacheDebuffIcon", button)
    local oldIcon=HealBot_UnitDebuffIcons[button.id][id].icon
    if HealBot_UnitDebuffIcons[button.id][id]["spellId"]~=spellId or
       oldIcon~=uaDebuffData[button.id][slot].icon or
       HealBot_UnitDebuffIcons[button.id][id].duration~=uaDebuffData[button.id][slot].duration or
       HealBot_UnitDebuffIcons[button.id][id].debuffType~=uaDebuffData[button.id][slot].debuffType or
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
                if oldIcon~=uaDebuffData[button.id][slot].icon or HealBot_UnitDebuffIcons[button.id][id]["expirationTime"]~=uaDebuffData[button.id][slot].expirationTime then
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

function HealBot_Aura_GetDebuffIconPreference(spellID, inCombat)
    local rules=HealBot_Globals and HealBot_Globals.DebuffIconVisibility
    local rule=rules and rules[spellID]
    if rule then return rule[inCombat and "combat" or "rest"] end
end

function HealBot_Aura_GetHiddenDebuffIcons(inCombat)
    local hidden={}
    local state=inCombat and "combat" or "rest"
    local rules=HealBot_Globals and HealBot_Globals.DebuffIconVisibility
    for spellID,rule in pairs(rules or {}) do
        if rule[state]==false then hidden[spellID]=true end
    end
    return hidden
end

function HealBot_Aura_RefreshDebuffIconVisibility()
    HealBot_Timers_Set("AURA","CheckDebuffs")
end

function HealBot_Aura_SetDebuffIconPreference(spellID, inCombat, value)
    if type(spellID)~="number" or spellID<1
        or (value~=nil and type(value)~="boolean")
        or HealBot_Aura_GetDebuffIconPreference(spellID,inCombat)==value then return end
    local rules=HealBot_Globals.DebuffIconVisibility or {}
    HealBot_Globals.DebuffIconVisibility=rules
    local rule=rules[spellID] or {}
    rule[inCombat and "combat" or "rest"]=value
    if next(rule) then
        rules[spellID]=rule
    else
        rules[spellID]=nil
    end
    if HealBot_Forever_RefreshDebuffIconPreferences then
        HealBot_Forever_RefreshDebuffIconPreferences()
    end
    HealBot_Aura_RefreshDebuffIconVisibility()
end

local debuffWarningSlot,debuffIconPrio=0,0
local function HealBot_Aura_SortDebuffIconSet(button, iconSet, sIndex)
      --HealBot_setCall("HealBot_Aura_SortDebuffIconSet", button)
    local ordered=debuffSort[iconSet]
    local limit=hbv_Skins_GetIconVar("MAXDICONS",button.frame,iconSet)
    local inCombat=InCombatLockdown()
    local offset=0
    if iconSet==1 then
        if HealBot_CombatAuras_GetMixedDebuffSlots and button.aura and button.aura.debuff
            and not button.aura.debuff.publicUnit then
            local wanted=0
            for _,uid in ipairs(ordered) do
                local id=HealBot_AuraDebuffXRef[uid].spellID
                if (id~=6788 or not button.hbcaNativeDebuffs) and HealBot_Aura_GetDebuffIconPreference(id,inCombat)~=false then
                    wanted=wanted+1
                    if wanted>=limit then break end
                end
            end
            offset,limit=HealBot_CombatAuras_GetMixedDebuffSlots(button,limit,wanted)
        end
        button.icon.debuff.offset=offset
    end
    local state=button.aura and button.aura.debuff
    local count=0
    table.sort(ordered)
    for _,uid in ipairs(ordered) do
        local aura=HealBot_AuraDebuffXRef[uid]
        local spellID=aura.spellID
        local slotData=uaDebuffData[button.id][aura.slot]
        local priority=slotData.priority or HealBot_AuraDebuffCache[spellID].priority
        -- The same normally tracked debuff wins the warning even when its icon is hidden.
        if not aura.iconOnly and priority<debuffIconPrio then
            debuffWarningSlot=aura.slot
            debuffIconPrio=priority
        end
        if count<limit and (spellID~=6788 or not button.hbcaNativeDebuffs)
            and HealBot_Aura_GetDebuffIconPreference(spellID,inCombat)~=false then
            count=count+1
            HealBot_Aura_CacheDebuffIcon(button,sIndex+offset+count,spellID,aura.slot)
            if state and state.publicDispels and state.publicDispels[spellID] then
                state.visibleDispels=state.visibleDispels or {}
                state.visibleDispels[spellID]=true
            end
        end
    end
    button.icon.debuff.count[iconSet]=count
end

function HealBot_Aura_SortDebuffIcons(button)
      --HealBot_setCall("HealBot_Aura_SortDebuffIcons", button)
    debuffWarningSlot,debuffIconPrio=0,21
    local state=button.aura and button.aura.debuff
    local previous=state and state.visibleDispels
    if state then
        state.visibleDispels=nil
        state.sortedPublicIcons=true
    end
    -- An icon cap controls artwork. A tracked debuff in that set still
    -- competes for the bar warning, including when its icon cap is zero.
    HealBot_Aura_SortDebuffIconSet(button, 1, 50)
    HealBot_Aura_SortDebuffIconSet(button, 2, 56)
    HealBot_Aura_SortDebuffIconSet(button, 3, 58)
    if previous and state.visibleDispels then
        local same=true
        for id in pairs(previous) do if not state.visibleDispels[id] then same=false; break end end
        if same then
            for id in pairs(state.visibleDispels) do if not previous[id] then same=false; break end end
        end
        if same then state.visibleDispels=previous end
    end
    return debuffWarningSlot
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

function HealBot_Aura_CheckUnitDebuffIcons(button)
      --HealBot_setCall("HealBot_Aura_CheckUnitDebuffIcons", button)
    local offset=button.icon.debuff.offset or 0
    for i=51,56 do
        if i>50+offset and i<=50+offset+button.icon.debuff.count[1] then
            if not HealBot_UnitDebuffIcons[button.id][i].current then
                HealBot_UnitDebuffIcons[button.id][i].current=true
                HealBot_Aura_DebuffAddIcon(button,i)
            end
        elseif HealBot_UnitDebuffIcons[button.id][i].current then
            HealBot_Aura_RemoveIcon(button,i)
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
    if generalBuffs and HealBot_BuffWatch[HealBot_Config_Buffs.ManaDrinkItem] and not button.aura.buff.update and not HealBot_issecretvalue(button.mana.pct)then
        if button.aura.buff.missingbuff ~= hb_lVars["ManaDrink"] then
            if button.mana.pct<HealBot_Config_Buffs.ManaDrinkThreshold then
                HealBot_Events_UnitBuff(button)
            end
        elseif button.mana.pct>=HealBot_Config_Buffs.ManaDrinkThreshold then
            HealBot_Events_UnitBuff(button)
        end
    end
end

local HealBot_Aura_GetItemCooldown=GetItemCooldown
if C_Item and C_Item.GetItemCooldown then
    HealBot_Aura_GetItemCooldown=C_Item.GetItemCooldown
elseif C_Container and C_Container.GetItemCooldown then
    HealBot_Aura_GetItemCooldown=C_Container.GetItemCooldown
end

local buffWatchName=""
local PlayerBuffsList={}
function HealBot_Aura_CheckGeneralBuff(button)
      --HealBot_setCall("HealBot_Aura_CheckGeneralBuff", button)
    -- An incomplete/protected scan is not evidence that a buff is missing.
    if HealBot_Util_isMidnight(true) or button.aura.buff.scanIncomplete then return end
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
            if HealBot_Util_isMidnight(false) or (buffSpellStart+buffSpellDur)-HealBot_TimeNow<2 then
                buffCheckThis=false;
                buffWatchTarget=HealBot_Options_retBuffWatchTarget(buffWatchName) or "";
                if buffWatchTarget["Raid"] then
                    buffCheckThis=true;
                elseif buffWatchTarget["Self"] and button.player then
                    if hb_lVars["ManaDrink"]~=buffWatchName or (not HealBot_issecretvalue(button.mana.pct) and button.mana.pct<HealBot_Config_Buffs.ManaDrinkThreshold) then
                        buffCheckThis=true
                    end
                elseif buffWatchTarget["Party"] and button.group == HealBot_Data["PLAYERGROUP"] then 
                    buffCheckThis=true
                elseif buffWatchTarget["Solo"] and not IsInRaid() and not IsInGroup() then
                    buffCheckThis=true
                elseif buffWatchTarget["MainTanks"] and HealBot_Panel_IsTank(button.unit) then
                    buffCheckThis=true;
                elseif buffWatchTarget["SingleTank"] and button.guid == hb_lVars["TankGUID1"] then
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
    for key in pairs(hbCustomBuffsDisabled) do hbCustomBuffsDisabled[key]=nil end
    for entry,instances in pairs(HealBot_Globals.IgnoreCustomBuff) do
        local id,name=entry,nil
        if (HealBot_Globals.CustomBuffIDMethod[entry] or 2)>1 then
            name=type(entry)=="string" and entry or HealBot_WoWAPI_SpellName(entry)
        elseif type(entry)=="string" then
            id=HealBot_WoWAPI_SpellId(entry)
        end
        if id then
            for zone,disabled in pairs(instances) do
                if disabled then
                    hbCustomBuffsDisabled[id]=hbCustomBuffsDisabled[id] or {}
                    hbCustomBuffsDisabled[id][zone]=true
                    if name then
                        hbCustomBuffsDisabled[name]=hbCustomBuffsDisabled[name] or {}
                        hbCustomBuffsDisabled[name][zone]=true
                    end
                end
            end
        end
    end
    HealBot_Timers_Set("AURA","DeleteExcludeBuffInCache")
    if HEALBOT_FOREVER and HealBot_Forever_RefreshBuffExclusions then
        HealBot_Forever_RefreshBuffExclusions()
    end
end

function HealBot_Aura_CustomBuffDisabled(spellId, name)
    local byId=hbCustomBuffsDisabled[spellId]
    local byName=name and hbCustomBuffsDisabled[name]
    local zone=hb_lVars["mapName"]
    return not not ((byId and (byId[zone] or byId.ALL))
        or (byName and (byName[zone] or byName.ALL)))
end

function HealBot_Aura_CustomBuffCaster(spellId, name)
    return (name and HealBot_Watch_HoT[name]) or HealBot_Watch_HoT[spellId]
end

function HealBot_Aura_VisitKnownBuffs(visit)
    for id,data in pairs(HealBot_AuraBuffCache) do
        if not HealBot_issecretvalue(id) and type(id)=="number" and
           not HealBot_issecretvalue(data) and type(data)=="table" and not HealBot_issecretvalue(data.name) then
            visit(id,data.name)
        end
    end
end

-- Build native exclusions from configuration/cache only, never combat aura data.
function HealBot_Aura_NativeBuffExclusions(unresolved)
    local excluded={}
    local function Exclude(id) excluded[id]=true end
    local zone=hb_lVars["mapName"]
    for key,instances in pairs(HealBot_Globals.IgnoreCustomBuff) do
        if instances.ALL or instances[zone] then
            local id=type(key)=="number" and key or HealBot_WoWAPI_SpellId(key)
            if type(id)=="number" then Exclude(id) end
            if unresolved and type(key)=="string" and not id then unresolved(key) end
            if HealBot_Forever_VisitSpellNameIDs and (HealBot_Globals.CustomBuffIDMethod[key] or 2)>1 then
                local name=type(key)=="string" and key or HealBot_WoWAPI_SpellName(key)
                HealBot_Forever_VisitSpellNameIDs(id,name,Exclude,unresolved)
            end
        end
    end
    HealBot_Aura_VisitKnownBuffs(function(id,name)
        if HealBot_Aura_CustomBuffDisabled(id,name) then Exclude(id) end
    end)
    return excluded
end

local scbUnitClassEN, scbWatchHoT="XXXX", false
local function HealBot_Aura_BuffCasterClass(unit)
    local _,class=UnitClass(unit)
    if not HealBot_issecretvalue(class) and type(class)=="string" then
        return strsub(class,1,4)
    end
end

function HealBot_Aura_ShowCustomBuff(button)
      --HealBot_setCall("HealBot_Aura_ShowCustomBuff", button)
    if HealBot_Aura_CustomBuffDisabled(uaBuffData[button.id][uaBuffSlot].spellId, uaBuffData[button.id][uaBuffSlot].name) then
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
                local class=HealBot_Aura_BuffCasterClass(uaBuffData[button.id][uaBuffSlot].sourceUnit)
                -- Two players can apply the same spell. A class decision
                -- belongs to this cast, never to the spell-wide cache.
                return class~=nil and class==HealBot_Data["PCLASSTRIM"], true, false
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
                    HealBot_AuraBuffCache[uaBuffData[button.id][uaBuffSlot].spellId].isAuto=true
                    return true, true, false
                else
                    local class=HealBot_Aura_BuffCasterClass(uaBuffData[button.id][uaBuffSlot].sourceUnit)
                    if class and class==HealBot_Data["PCLASSTRIM"] then
                        HealBot_AuraBuffCache[uaBuffData[button.id][uaBuffSlot].spellId].isAuto=true
                        return true, true, false
                    end
                    return false, true, false
                end
            end
        end
    end
    -- Duration-based auto rules can match a later cast of this same ID.
    return false, false, HealBot_Config_Buffs.AutoBuff~=2 and HealBot_Config_Buffs.AutoBuff~=3
end

local buffIconIdx,buffIconPrio=0,0
function HealBot_Aura_SortBuffIconSet(button, iconSet, sIndex)
      --HealBot_setCall("HealBot_Aura_SortBuffIconSet", button)
    button.icon.buff.count[iconSet]=#buffSort[iconSet]
    if button.icon.buff.count[iconSet]>0 then
        table.sort(buffSort[iconSet])
        -- The legacy renderer only allocates two slots each for sets 2 and 3.
        local maxIcons=hbv_Skins_GetIconVar("MAXBICONS", button.frame, iconSet)
        button.icon.buff.count[iconSet]=math.min(button.icon.buff.count[iconSet], maxIcons, iconSet==1 and 8 or 2)
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
        hbCustomDebuffsDisabled[id]=hbCustomDebuffsDisabled[id] or {}
        if (HealBot_Globals.CustomDebuffIDMethod[id] or 2)>1 and name then
            hbCustomDebuffsDisabled[name]=hbCustomDebuffsDisabled[name] or {}
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

function HealBot_Aura_setDebuffXRefUID(uid, spellID, slot, iconOnly)
    if not HealBot_AuraDebuffXRef[uid] then HealBot_AuraDebuffXRef[uid]={} end
    HealBot_AuraDebuffXRef[uid]["spellID"]=spellID
    HealBot_AuraDebuffXRef[uid]["slot"]=slot
    HealBot_AuraDebuffXRef[uid].iconOnly=iconOnly
    table.insert(debuffSort[HealBot_Aura_IconSet[spellID]],uid)
end

function HealBot_Aura_CustomDebuffDisabled(spellID, spellName)
    local byID,byName=hbCustomDebuffsDisabled[spellID],hbCustomDebuffsDisabled[spellName]
    local zone=hb_lVars["mapName"]
    return (byID and (byID[zone] or byID.ALL)) or (byName and (byName[zone] or byName.ALL))
end

function HealBot_Forever_WatchesWeakenedSoul()
    local id=6788
    local name=HealBot_WoWAPI_SpellName(id)
    if HealBot_issecretvalue(name) then name=nil end
    local custom=HealBot_Globals.CustomDebuffs
    return not not (custom and (custom[id] or custom[name]) and not HealBot_Aura_CustomDebuffDisabled(id,name))
end

do
    local function public(value)
        if not HealBot_issecretvalue(value) then return value end
    end
    local function unitValue(fn,...)
        if type(fn)~="function" then return end
        local ok,value=pcall(fn,...)
        if ok then return public(value) end
    end
    function HealBot_Aura_DispelTargetMatches(button,scope)
        if scope.Raid then return true end
        local unit=button.unit
        if scope.Self and (public(button.player) or unitValue(UnitIsUnit,unit,"player")) then return true end
        if scope.Solo and not IsInRaid() and not IsInGroup() then return true end
        if scope.MainTanks and unitValue(HealBot_Panel_IsTank,unit) then return true end
        if scope.Focus and unitValue(UnitIsUnit,unit,"focus") then return true end
        if scope.Party then
            local group=public(button.group)
            local own=public(HealBot_Data.PLAYERGROUP) or public(HealBot_Data.PGROUP)
            if group==nil and own~=nil and type(unit)=="string" then
                if unit=="player" or unit:match("^party%d+$") then group=own
                else
                    local i=tonumber(unit:match("^raid(%d+)$"))
                    if i and GetRaidRosterInfo then
                        local ok,_,_,g=pcall(GetRaidRosterInfo,i)
                        if ok then group=public(g) end
                    end
                end
            end
            if group~=nil and group==own then return true end
        end
        if scope.Name or scope.SingleTank or scope.MyTargets then
            local guid=public(button.guid) or unitValue(UnitGUID,unit)
            if guid and ((scope.Name and guid==public(HealBot_Config.PrivFocus))
                or (scope.SingleTank and guid==public(hb_lVars.TankGUID1))
                or (scope.MyTargets and unitValue(HealBot_Panel_IsMyTarget,guid))) then return true end
        end
        if scope.PvP or scope.PvE then
            local flagged=unitValue(UnitIsPVP,unit)
            if (flagged and scope.PvP) or (flagged==false and scope.PvE) then return true end
        end
        local class=button.text and public(button.text.classtrim)
        if not class and UnitClass then
            local ok,_,file=pcall(UnitClass,unit)
            if ok and not HealBot_issecretvalue(file) and type(file)=="string" then class=file:sub(1,4) end
        end
        return class~=nil and not not scope[class]
    end
end

function HealBot_Aura_CheckCurDebuff(button)
      --HealBot_setCall("HealBot_Aura_CheckCurDebuff", button)
    local debuff=uaDebuffData[button.id][uaDebuffSlot]
    local canDispel=debuff.dispellable
    if not HEALBOT_FOREVER then canDispel=HealBot_Aura_CanDispel[debuff.spellId] end
    debuffIsCurrent, cDebuffPrio=true, 20
    if HealBot_Aura_CustomDebuffDisabled(uaDebuffData[button.id][uaDebuffSlot].spellId,uaDebuffData[button.id][uaDebuffSlot].name) then
        debuffIsCurrent=false
    elseif HealBot_AuraDebuffCache[uaDebuffData[button.id][uaDebuffSlot].spellId]["typePrio"]>HealBot_AuraDebuffCache[uaDebuffData[button.id][uaDebuffSlot].spellId]["customPrio"] and HealBot_AuraDebuffCache[uaDebuffData[button.id][uaDebuffSlot].spellId]["customPrio"]<21 then
        HealBot_Aura_CheckCurCustomDebuff(button, true)
    else
        ccdbCheckthis=false
        if HealBot_AuraDebuffCache[uaDebuffData[button.id][uaDebuffSlot].spellId]["typePrio"]<21 and
          (not HealBot_Config_Cures.IgnoreCannotDispell or canDispel) and
          (not hbDebuffOnCD[uaDebuffData[button.id][uaDebuffSlot].debuffType] or hbDebuffOnCD[uaDebuffData[button.id][uaDebuffSlot].debuffType]<HealBot_TimeNow) and 
          (not HealBot_Config_Cures.IgnoreFriendDebuffs or not UnitIsFriend("player",uaDebuffData[button.id][uaDebuffSlot].sourceUnit)) and
          (uaDebuffData[button.id][uaDebuffSlot].duration == 0 or uaDebuffData[button.id][uaDebuffSlot].duration>=hb_lVars["IgnoreFastDurDebuffsSecs"]) then
            ccdbWatchTarget=HealBot_Options_retDebuffWatchTarget(uaDebuffData[button.id][uaDebuffSlot].debuffType);
            if ccdbWatchTarget then
                ccdbCheckthis=HealBot_Aura_DispelTargetMatches(button,ccdbWatchTarget)
                if ccdbWatchTarget.Raid and not HealBot_Config_Cures.IgnoreOnCooldownDebuffs then
                    HealBot_AuraDebuffCache[uaDebuffData[button.id][uaDebuffSlot].spellId].always=true
                end
            end
        end
        if ccdbCheckthis and HealBot_AuraDebuffCache[uaDebuffData[button.id][uaDebuffSlot].spellId]["typePrio"]<16 then
            cDebuffPrio=HealBot_AuraDebuffCache[uaDebuffData[button.id][uaDebuffSlot].spellId]["typePrio"]
            HealBot_AuraDebuffCache[uaDebuffData[button.id][uaDebuffSlot].spellId]["debuffType"]=uaDebuffData[button.id][uaDebuffSlot].debuffType
        elseif (not UnitIsFriend("player",uaDebuffData[button.id][uaDebuffSlot].sourceUnit) and uaDebuffData[button.id][uaDebuffSlot].isBossAura and HealBot_Config_Cures.AlwaysShowBoss) or 
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

function HealBot_Aura_DebuffWarnings(button, debuffName, force, debuffIconIndex, expirationTime, barOnly)
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
        if button.range.current>0 and (button.isplayer or button.isgroupraid) and button.frame<10 and button.aura.debuff.priority<=HealBot_Aura_retLuVars("HotBarDebuff") then
            HealBot_Action_BarHotEnable(button, "DEBUFF")
        elseif button.hotbars.debuff then
            HealBot_Action_BarHotDisable(button, "DEBUFF")
        end
        if not barOnly and debuffWarnings and (not HealBot_Aura_WarningFilter[button.unit][button.aura.debuff.name] or HealBot_Aura_WarningFilter[button.unit][button.aura.debuff.name]<HealBot_TimeNow) then
            if debuffIconIndex == 0 then debuffIconIndex=51 end
            HealBot_Aura_WarningFilter[button.unit][button.aura.debuff.name]=expirationTime or HealBot_UnitDebuffIcons[button.id][debuffIconIndex]["expirationTime"]
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
    if HealBot_issecretvalue(uaBuffData[button.id][uaBuffSlot].expirationTime) then return end
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

local hbAuraWatch={}
local hbAuraBuffWatch={}
local hbAuraBuffTagWatch={}
local hbAuraDebuffWatch={}
local hbAuraDebuffTagWatch={}
local hbAuraActionBuffWatch={}
local hbAuraActionBuffTagWatch={}
local hbAuraActionDebuffWatch={}
local hbAuraActionDebuffTagWatch={}

function HealBot_Aura_AddWatch(unit)
      --HealBot_setCall("HealBot_Aura_AddWatch", nil, guid)
    if not hbAuraWatch[unit] then
        hbAuraWatch[unit]=true
    end
end

function HealBot_Aura_DelWatch(unit)
      --HealBot_setCall("HealBot_Aura_DelWatch", nil, guid)
    if hbAuraWatch[unit] then
        if not hbAuraBuffWatch[unit] and not hbAuraBuffTagWatch[unit] and not hbAuraActionBuffWatch[unit] and not hbAuraActionBuffTagWatch[unit] and 
           not hbAuraDebuffWatch[unit] and not hbAuraDebuffTagWatch[unit] and not hbAuraActionDebuffWatch[unit] and not hbAuraActionDebuffTagWatch[unit] then
            hbAuraWatch[unit]=nil
        end
    end
end

function HealBot_Aura_BuffWatch(unit, buff, active, actionicon)
      --HealBot_setCall("HealBot_Aura_BuffWatch", nil, guid)
    local hbbwa=nil
    if actionicon then
        hbbwa=hbAuraActionBuffWatch
    else
        hbbwa=hbAuraBuffWatch
    end
    if buff then
        if active then
            if not hbbwa[unit] then 
                hbbwa[unit]={}
                HealBot_Aura_AddWatch(unit)
            end
            if not hbbwa[unit][buff] then
                hbbwa[unit][buff]=0
            end
        elseif hbbwa[unit] and hbbwa[unit][buff] then
            hbbwa[unit][buff]=nil
        end
    else
        hbbwa[unit]=nil
        HealBot_Aura_DelWatch(unit)
    end
end

function HealBot_Aura_BuffTagWatch(unit, tag, active, actionicon)
      --HealBot_setCall("HealBot_Aura_BuffTagWatch", nil, guid)
    local hbbwta=nil
    if actionicon then
        hbbwta=hbAuraActionBuffTagWatch
    else
        hbbwta=hbAuraBuffTagWatch
    end
    if tag then
        if active then
            if not hbbwta[unit] then 
                hbbwta[unit]={}
                HealBot_Aura_AddWatch(unit)
            end
            if not hbbwta[unit][tag] then
                hbbwta[unit][tag]=0
            end
        elseif hbbwta[unit] and hbbwta[unit][tag] then
            hbbwta[unit][tag]=nil
        end
    else
        hbbwta[unit]=nil
        HealBot_Aura_DelWatch(unit)
    end
end

function HealBot_Aura_AuraWatchClear()
      --HealBot_setCall("HealBot_Aura_AuraWatchClear")
    for unit,_ in pairs(hbAuraBuffWatch) do
        hbAuraBuffWatch[unit]=nil
        HealBot_Aura_DelWatch(unit)
    end
    for unit,_ in pairs(hbAuraBuffTagWatch) do
        hbAuraBuffWatch[unit]=nil
        hbAuraBuffTagWatch(unit)
    end
    for unit,_ in pairs(hbAuraDebuffWatch) do
        hbAuraBuffWatch[unit]=nil
        hbAuraDebuffWatch(unit)
    end
    for unit,_ in pairs(hbAuraDebuffTagWatch) do
        hbAuraBuffWatch[unit]=nil
        hbAuraDebuffTagWatch(unit)
    end
end

function HealBot_Aura_DebuffWatch(unit, debuff, active, actionicon)
      --HealBot_setCall("HealBot_Aura_DebuffWatch", nil, guid)
    local hbdwa=nil
    if actionicon then
        hbdwa=hbAuraActionDebuffWatch
    else
        hbdwa=hbAuraDebuffWatch
    end
    if debuff then
        if active then
            if not hbdwa[unit] then 
                hbdwa[unit]={}
                HealBot_Aura_AddWatch(unit)
            end
            if not hbdwa[unit][debuff] then
                hbdwa[unit][debuff]=0
            end
        elseif hbdwa[unit] and hbdwa[unit][debuff] then
            hbdwa[unit][debuff]=nil
        end
    else
        hbdwa[unit]=nil
        HealBot_Aura_DelWatch(unit)
    end
end

function HealBot_Aura_DebuffTagWatch(unit, tag, active, actionicon)
      --HealBot_setCall("HealBot_Aura_DebuffTagWatch", nil, guid)
    local hbdwta=nil
    if actionicon then
        hbdwta=hbAuraActionDebuffTagWatch
    else
        hbdwta=hbAuraDebuffTagWatch
    end
    if tag then
        if active then
            if not hbdwta[unit] then 
                hbdwta[unit]={}
                HealBot_Aura_AddWatch(unit)
            end
            if not hbdwta[unit][tag] then
                hbdwta[unit][tag]=0
            end
        elseif hbdwta[unit] and hbdwta[unit][tag] then
            hbdwta[unit][tag]=nil
        end
    else
        hbdwta[unit]=nil
        HealBot_Aura_DelWatch(unit)
    end
end

function HealBot_Aura_CurrentBuffTag(unit, tag)
      --HealBot_setCall("HealBot_Aura_CurrentBuffTag", nil, guid)
    if not HealBot_issecretvalue(unit) and hbAuraBuffTagWatch[unit] and (hbAuraBuffTagWatch[unit][tag] or 0) == 1 then
        return true
    else
        return false
    end
end

function HealBot_Aura_ActionIconBuffTag(unit, tag)
      --HealBot_setCall("HealBot_Aura_ActionIconBuffTag", nil, guid)
    if not HealBot_issecretvalue(unit) and hbAuraActionBuffTagWatch[unit] and (hbAuraActionBuffTagWatch[unit][tag] or 0) == 1 then
        return true
    else
        return false
    end
end

function HealBot_Aura_CurrentBuff(unit, bName)
      --HealBot_setCall("HealBot_Aura_CurrentBuff", nil, guid)
    if not HealBot_issecretvalue(unit) and HealBot_UnitBuffCurrent[unit] and bName then
        return HealBot_UnitBuffCurrent[unit][bName]
    else
        return false
    end
end

function HealBot_Aura_CurrentDebuff(unit, dName)
      --HealBot_setCall("HealBot_Aura_CurrentDebuff", nil, guid)
    if not HealBot_issecretvalue(unit) and HealBot_UnitDebuffCurrent[unit] then
        return HealBot_UnitDebuffCurrent[unit][dName]
    else
        return false
    end
end

function HealBot_Aura_CurrentDebuffTag(unit, tag)
      --HealBot_setCall("HealBot_Aura_CurrentDebuffTag", nil, guid)
    if not HealBot_issecretvalue(unit) and hbAuraDebuffTagWatch[unit] and (hbAuraDebuffTagWatch[unit][tag] or 0) == 1 then
        return true
    else
        return false
    end
end

function HealBot_Aura_ActionIconDebuffTag(unit, tag)
      --HealBot_setCall("HealBot_Aura_ActionIconDebuffTag", nil, guid)
    if not HealBot_issecretvalue(unit) and hbAuraActionDebuffTagWatch[unit] and (hbAuraActionDebuffTagWatch[unit][tag] or 0) == 1 then
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
    if uaBuffData[button.id][uaBuffSlot].name == HEALBOT_SPIRIT_OF_REDEMPTION_NAME and not HealBot_issecretvalue(button.health.current) and button.health.current>0 then 
        C_Timer.After(0.1, function() HealBot_Action_UpdateTheDeadButton(button) end)
    end
    if HealBot_Buff_Aura2Item[uaBuffData[button.id][uaBuffSlot].name] then
        uaBuffData[button.id][uaBuffSlot].name=HealBot_WoWAPI_ItemInfo(HealBot_Buff_Aura2Item[uaBuffData[button.id][uaBuffSlot].name]) or uaBuffData[button.id][uaBuffSlot].name
    end
    if not uaBuffData[button.id][uaBuffSlot].isCurrent then
        uaIsCurrent, uaIsCustom, uaNever=HealBot_Aura_ShowCustomBuff(button)
        if uaIsCurrent then 
            uaBuffData[button.id][uaBuffSlot].isCurrent=HealBot_AuraBuffCache[uaBuffData[button.id][uaBuffSlot].spellId].always
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
                HealBot_Aura_setBuffXRefUID(HealBot_AuraBuffCache[uaBuffData[button.id][uaBuffSlot].spellId]["pid"].."/"..uaBuffSlot, uaBuffData[button.id][uaBuffSlot].spellId, uaBuffSlot)
            end
        end
        HealBot_Aura_CheckUnitGeneralBuff(button)
    else
        if uaNever and not HealBot_BuffWatch[uaBuffData[button.id][uaBuffSlot].name] and not HealBot_BuffNameTypes[uaBuffData[button.id][uaBuffSlot].name] then
            HealBot_ExcludeBuffInCache[uaBuffData[button.id][uaBuffSlot].spellId]=true
        else
            HealBot_Aura_CheckUnitGeneralBuff(button)
        end
        if not HealBot_Watch_HoT[uaBuffData[button.id][uaBuffSlot].name] and not HealBot_Watch_HoT[uaBuffData[button.id][uaBuffSlot].spellId] then
            if uaBuffData[button.id][uaBuffSlot].sourceUnitIsPlayer then
                HealBot_UnusedSelfBuffs[uaBuffData[button.id][uaBuffSlot].spellId]=true
            elseif not HealBot_UnusedBuffs[uaBuffData[button.id][uaBuffSlot].spellId] then
                scbUnitClassEN=HealBot_Aura_BuffCasterClass(uaBuffData[button.id][uaBuffSlot].sourceUnit)
                if scbUnitClassEN then
                    HealBot_UnusedBuffs[uaBuffData[button.id][uaBuffSlot].spellId]=scbUnitClassEN..":"..HealBot_Aura_UnusedAuraInfo(uaBuffData[button.id][uaBuffSlot].sourceUnit, scbUnitClassEN)
                else
                    HealBot_UnusedBuffs[uaBuffData[button.id][uaBuffSlot].spellId]=HEALBOT_WORDS_UNKNOWN..":"..HealBot_Aura_UnusedAuraInfo(uaBuffData[button.id][uaBuffSlot].sourceUnit, "XXXX")
                end
            end
        end
    end
end

function HealBot_Aura_ListUnusedBuffsBySelf()
    local l={}
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
    local debuff=uaDebuffData[button.id][uaDebuffSlot]
    local spellID=debuff.spellId
    if debuff.iconOnly then
        if HealBot_Aura_GetDebuffIconPreference(spellID,InCombatLockdown())==true then
            HealBot_Aura_setDebuffXRefUID("z"..spellID..":"..uaDebuffSlot,spellID,uaDebuffSlot,true)
        end
        return
    end
    if HEALBOT_FOREVER then
        -- The same ID can be removable, timed or a boss aura on one unit only.
        local cache=HealBot_AuraDebuffCache[spellID]
        if cache.priorityType~=debuff.debuffType then
            cache.customPrio,cache.typePrio=HealBot_Options_retDebuffPriority(spellID,debuff.name,debuff.debuffType)
            cache.priorityType=debuff.debuffType
        end
        cache.debuffType=debuff.debuffType
        cache.isAuto=false
        uaIsCurrent=HealBot_Aura_CheckCurDebuff(button)
        debuff.priority,debuff.warningType,debuff.automatic=cache.priority,cache.debuffType,cache.isAuto
    elseif not debuff.isCurrent then
        uaIsCurrent=HealBot_Aura_CheckCurDebuff(button)
        if uaIsCurrent and (hbDebuffOnCD[uaDebuffData[button.id][uaDebuffSlot].debuffType] or 0)<(HealBot_TimeNow+2) then
            uaDebuffData[button.id][uaDebuffSlot].isCurrent=true
        end
    else
        uaIsCurrent=true
    end
    if uaIsCurrent then
        HealBot_Aura_setDebuffXRefUID(HealBot_AuraDebuffCache[spellID].pid..":"..uaDebuffSlot,spellID,uaDebuffSlot)
        if not button.aura.debuff.temp.active or button.aura.debuff.temp.priority>HealBot_AuraDebuffCache[spellID].priority then
            button.aura.debuff.temp.active=true
            button.aura.debuff.temp.id=spellID
            button.aura.debuff.temp.slot=uaDebuffSlot
            button.aura.debuff.temp.priority=HealBot_AuraDebuffCache[spellID].priority
            button.aura.debuff.temp.expirationTime=debuff.expirationTime
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
    if not uaIsCurrent then
        if HealBot_Aura_GetDebuffIconPreference(spellID,InCombatLockdown())==true then
            HealBot_Aura_setDebuffXRefUID("z"..spellID..":"..uaDebuffSlot,spellID,uaDebuffSlot,true)
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
    xButton=HealBot_Panel_AllButton(unit)
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

local function HealBot_Aura_PostUpdateInitBuffsCache(spellID, spellName)
    if not HealBot_AuraBuffCache[spellID] then 
        HealBot_AuraBuffCache[spellID]={}
        HealBot_AuraBuffCache[spellID]["name"]=spellName
        if HealBot_Forever_ObserveBuffRank then HealBot_Forever_ObserveBuffRank(spellID,spellName) end
        HealBot_Aura_ID[spellName]=spellID
        if HealBot_SpellID_LookupData[spellName] and HealBot_SpellID_LookupData[spellName]["CHECK"] then
            HealBot_SpellID_LookupData[spellName]["CHECK"]=false
            HealBot_SpellID_LookupData[spellName]["ID"]=spellID
            table.insert(HealBot_SpellID_LookupIdx,spellName)
            HealBot_Timers_Set("OOC","BuffIdLookup",true)
        end
        HealBot_AuraBuffCache[spellID].reset=true
    end
end

local function HealBot_Aura_PostUpdateUnitBuffsData(button, spellID, spellName)
      --HealBot_setCall("HealBot_Aura_PostUpdateUnitBuffsData", button)
    if HealBot_AuraBuffCache[spellID].reset then
        HealBot_AuraBuffCache[spellID]["priority"]=HealBot_Globals.CustomBuffs[spellName] or HealBot_Globals.CustomBuffs[spellID] or 20
        if HealBot_AuraBuffCache[spellID]["priority"]<10 then
            HealBot_AuraBuffCache[spellID]["pid"]="x0"..HealBot_AuraBuffCache[spellID]["priority"]..spellID
        else
            HealBot_AuraBuffCache[spellID]["pid"]="x"..HealBot_AuraBuffCache[spellID]["priority"]..spellID
        end
        local iconSetID=HealBot_BuffIconSetKey(spellID)
        HealBot_Aura_IconSet[spellID]=HealBot_BuffIconSet[iconSetID] or HealBot_BuffIconSet[spellName] or 1
        HealBot_AuraBuffCache[spellID]["always"]=false
        HealBot_AuraBuffCache[spellID]["isCustom"]=false
        uaBuffData[button.id][uaSlot].isCurrent=false
        HealBot_AuraBuffCache[spellID].reset=false
    end
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
                 
function HealBot_Aura_GetBuffTargetFilter(spellID, name)
    return HealBot_BuffFilter[spellID] or (name and HealBot_BuffFilter[name])
end

function HealBot_Aura_BuffTargetMatches(button, filter)
    if not filter or filter==1 then return true end
    local predicate=hbAuraFilterFuncs[filter]
    if not predicate then return false end
    if button.mana then return predicate(button) end
    -- Arrival rows have a fixed party/raid unit token and no ordinary button
    -- metadata. Only ask for the public field used by this particular rule.
    local unit=button.unit
    local function PublicRosterValue(fn)
        if type(fn)~="function" then return end
        local ok,value=pcall(fn,unit)
        if ok and not HealBot_issecretvalue(value) then return value end
    end
    local target={}
    if filter<=4 then
        target.roletxt=PublicRosterValue(UnitGroupRolesAssigned)
        if target.roletxt=="NONE" then target.roletxt=PublicRosterValue(HealBot_Panel_UnitRoleDefault) end
        if not target.roletxt then return false end
    elseif filter<=6 then
        local power=PublicRosterValue(UnitPowerType)
        if power==nil then return false end
        target.mana={type=power}
    elseif filter==7 then
        if type(unit)~="string" then return false end
        local index=tonumber(unit:match("^raid(%d+)$"))
        if index and type(GetRaidRosterInfo)=="function" then
            local ok,_,_,group=pcall(GetRaidRosterInfo,index)
            if ok and not HealBot_issecretvalue(group) then target.group=group end
        elseif unit=="player" or unit:match("^party%d+$") then
            target.group=HealBot_Data["PGROUP"]
        end
        if not target.group then return false end
    elseif filter<=9 then
        target.isplayer=type(unit)=="string" and
            (unit=="player" or unit:match("^party%d+$")~=nil or unit:match("^raid%d+$")~=nil)
    else
        target.guid=PublicRosterValue(UnitGUID)
        if not target.guid then return false end
    end
    return predicate(target)
end

local function HealBot_Aura_FilterUnitBuffs(button, selfOnly)
    if not uaUnitCaster then 
        uaUnitCaster="nil"
        uaUnitIsPlayer=false
    elseif HealBot_SafeUnitIsUnit(uaUnitCaster,"player") then
        uaUnitIsPlayer=true
    else
        uaUnitIsPlayer=false
    end
    if (uaUnitIsPlayer or not selfOnly) then
        return HealBot_Aura_BuffTargetMatches(button,HealBot_Aura_GetBuffTargetFilter(uaSpellId,uaName))
    else
        return false
    end
end
        
local function HealBot_Aura_UpdateUnitBuffsData(button, selfOnly, gSlot)
      --HealBot_setCall("HealBot_Aura_UpdateUnitBuffsData", button)
      
    if uaExpirationTime then
        HealBot_Aura_PostUpdateInitBuffsCache(uaSpellId, uaName)
        if not uaUnitCaster then uaUnitCaster="nil" end
        if not HealBot_ExcludeBuffInCache[uaSpellId] and (HEALBOT_FOREVER or uaSlot<20) and HealBot_Aura_FilterUnitBuffs(button, selfOnly) then
            uaSlot=uaSlot+1
            -- The icon limit applies after sorting. Reuse overflow records on
            -- units that had more public buffs than the initial allocation.
            if not uaBuffData[button.id][uaSlot] then uaBuffData[button.id][uaSlot]={} end
            if not HealBot_issecretvalue(uaExpirationTime) then
                uaExpirationTime=HealBot_Util_Round(uaExpirationTime,1)
            end
            uaBuffData[button.id][uaSlot].duration=uaDuration or 15
            uaBuffData[button.id][uaSlot].sourceUnitIsPlayer=uaUnitIsPlayer
            if uaBuffData[button.id][uaSlot].spellId~=uaSpellId or uaBuffData[button.id][uaSlot].sourceUnit~=uaUnitCaster then 
                uaBuffData[button.id][uaSlot].name=uaName
                if BleedList[uaSpellId] and (not uaDebuffType or not HealBot_Options_retDebuffCureType(uaDebuffType)) then
                    uaBuffData[button.id][uaSlot].debuffType=HEALBOT_BLEED_en
                else
                    uaBuffData[button.id][uaSlot].debuffType=uaDebuffType
                end
                uaBuffData[button.id][uaSlot].sourceUnit=uaUnitCaster
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
        HealBot_UnitBuffCurrent[button.unit][uaName]=uaSpellId
        HealBot_AuraBuffCache[uaSpellId].count=uaCount
        HealBot_AuraBuffCache[uaSpellId].sourceUnitIsPlayer=uaUnitIsPlayer
        if uaExpirationTime > 0 and button.isplayer and UnitIsFriend(uaUnitCaster, "player") then hbv_Auras_SetData("BUFFS", uaSpellId) end
    end
end

function HealBot_Aura_StartCheckClassicAbsorbs(button)
    for n,_ in pairs(hbClassicAbsorbsTrack[button.id]) do
        hbClassicAbsorbsTrack[button.id][n]=false
    end
end

local uaExtra17, uaExtra18, uaExtra19=nil, nil, nil
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

function HealBot_Aura_EndCheckClassicAbsorbs(button)
    local hbClassicAbsorbValues=0
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

function HealBot_Aura_UpdateUnitBuffsV1(button, selfOnly)
      --HealBot_setCall("HealBot_Aura_UpdateUnitBuffsV1", button)
    uaZ=1
    local hbClassicAbsorbValues=0
    local hbClassicAbsorbTotal=0
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

local uaAura={}
-- Midnight/12.1: any comparison, boolean test, arithmetic or table-key use of a
-- secret value is an immediate lua error. Only process an aura if every field
-- the update funcs touch is readable; secret auras are skipped (Blizzard hides
-- them from addons in combat/M+/PvP by design).
local function HealBot_Aura_AuraDataIsUsable(aura)
    if HealBot_issecretvalue(aura) or not aura then return false end
    if HealBot_issecretvalue(aura.spellId) or HealBot_issecretvalue(aura.name)
    or HealBot_issecretvalue(aura.dispelName) or HealBot_issecretvalue(aura.duration)
    or HealBot_issecretvalue(aura.expirationTime) or HealBot_issecretvalue(aura.sourceUnit)
    or HealBot_issecretvalue(aura.applications) or HealBot_issecretvalue(aura.icon)
    or HealBot_issecretvalue(aura.isBossAura) then
        return false
    end
    return true
end

function HealBot_Aura_UpdateUnitBuffsV9Alt(button, selfOnly, filter)
      --HealBot_setCall("HealBot_Aura_UpdateUnitBuffsV9Alt", button)
    uaZ=1
    -- 12.1 live: index/slot aura access THROWS while auras are secret in combat
    -- (even for "player", even with combat filters) - pcall, never call bare
    local okA
    okA, uaAura=pcall(C_UnitAuras.GetUnitAuras, button.unit, filter, 20, 3)
    if not okA or HealBot_issecretvalue(uaAura) or not uaAura then return end
	for _, uAura in ipairs(uaAura) do
        if HealBot_Aura_AuraDataIsUsable(uAura) and uAura.dispelName then
            uaName, uaTexture, uaCount, uaDebuffType, uaDuration, uaExpirationTime, uaUnitCaster, uaSpellId=
            uAura.name, uAura.icon, uAura.applications, uAura.dispelName, uAura.duration, uAura.expirationTime, uAura.sourceUnit, uAura.spellId
            HealBot_Aura_UpdateUnitBuffsData(button, selfOnly, uaZ)
            uaZ=uaZ+1
        end
    end
end

function HealBot_Aura_UpdateUnitBuffsV9Aura(button, selfOnly, filter, generation, guid, policy)
      --HealBot_setCall("HealBot_Aura_UpdateUnitBuffsV9Aura", button)
    local state=button.aura.buff
    state.scanIncomplete=false
    state.publicGeneration=nil
    uaZ=1
    while true do
        local okA
        okA, uaAura=pcall(C_UnitAuras.GetAuraDataByIndex, button.unit, uaZ, filter)
        if not okA or HealBot_issecretvalue(uaAura) then
            button.aura.buff.scanIncomplete=true
            break
        end
        if not uaAura then break end
        if HealBot_Aura_AuraDataIsUsable(uaAura) then
            uaName, uaTexture, uaCount, uaDebuffType, uaDuration, uaExpirationTime, uaUnitCaster, uaSpellId=
            uaAura.name, uaAura.icon, uaAura.applications, uaAura.dispelName, uaAura.duration, uaAura.expirationTime, uaAura.sourceUnit, uaAura.spellId
            if generation and (not uaExpirationTime or not uaName or not uaSpellId
                or not HealBot_CombatAuras_LegacyBuffMatches(uaSpellId,uaName)) then generation=nil end
            HealBot_Aura_UpdateUnitBuffsData(button, selfOnly, uaZ)
        else
            button.aura.buff.scanIncomplete=true
        end
        uaZ=uaZ+1
    end
    if generation and not state.scanIncomplete then
        state.publicGeneration,state.publicUnit,state.publicGuid,state.publicPolicy=generation,button.unit,guid,policy
    end
end
function HealBot_Aura_UpdateUnitBuffsV9(button, selfOnly)
      --HealBot_setCall("HealBot_Aura_UpdateUnitBuffsV9", button)
    if UnitExists(button.unit) then
        local generation,guid,policy
        if not selfOnly and HealBot_CombatAuras_PublicBuffContext then
            generation,guid,policy=HealBot_CombatAuras_PublicBuffContext(button)
        end
        if not generation and HealBot_Util_isMidnight(true) then
            HealBot_Aura_UpdateUnitBuffsV9Aura(button, selfOnly, "RAID_IN_COMBAT")
        else
            -- A clean, complete public scan can use the player's normal
            -- settings even in combat. Keep native ownership on any gap.
            HealBot_Aura_UpdateUnitBuffsV9Aura(button, selfOnly, "HELPFUL",generation,guid,policy)
        end
        if UnitIsVisible then
            local visible=UnitIsVisible(button.unit)
            if HealBot_issecretvalue(visible) or not visible then button.aura.buff.scanIncomplete=true end
        end
    else
        button.aura.buff.scanIncomplete=true
    end
end

local HealBot_Aura_UpdateUnitBuffs=HealBot_Aura_UpdateUnitBuffsV2
if HEALBOT_CLIENT_VERSION>8 then
    HealBot_Aura_UpdateUnitBuffs=HealBot_Aura_UpdateUnitBuffsV9
elseif HEALBOT_GAME_VERSION<2 then
    HealBot_Aura_UpdateUnitBuffs=HealBot_Aura_UpdateUnitBuffsV1
end

local function HealBot_Aura_PostUpdateInitDebuffsCache(spellID, spellName)
    if not HealBot_AuraDebuffCache[spellID] then 
            HealBot_AuraDebuffCache[spellID]={} 
            HealBot_AuraDebuffCache[spellID]["name"]=spellName
            HealBot_Aura_ID[spellName]=spellID
        HealBot_AuraDebuffCache[spellID].reset=true
    end
end

function HealBot_Aura_PostUpdateUnitDebuffsData(button, spellID, spellName, debuffType)
      --HealBot_setCall("HealBot_Aura_PostUpdateUnitDebuffsData", button)
    if HealBot_AuraDebuffCache[spellID].reset then 
        HealBot_AuraDebuffCache[spellID]["priority"]=99
        if not HealBot_Globals.CustomDebuffs[spellID] then
            HealBot_Aura_AutoUpdateCustomDebuff(button, spellName, spellID)
        end
        if not HEALBOT_FOREVER and HealBot_Aura_CanDispel[spellID] == nil then
            local aSpellId=nil
            if HEALBOT_CLIENT_VERSION>8 then
                local aDId=1 -- own index, uaZ belongs to the calling enumeration loop
                while true do
                    local okD, aDAura=pcall(C_UnitAuras.GetAuraDataByIndex, button.unit, aDId, "RAID_PLAYER_DISPELLABLE")
                    if not okD or HealBot_issecretvalue(aDAura) or not aDAura then break end
                    if not HealBot_issecretvalue(aDAura.spellId) then
                        HealBot_Aura_CanDispel[aDAura.spellId]=true
                    end
                    aDId=aDId+1
                end
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
        HealBot_Aura_IconSet[spellID]=HealBot_DebuffIconSet[spellID] or HealBot_DebuffIconSet[spellName] or 1
        HealBot_AuraDebuffCache[spellID]["customPrio"], HealBot_AuraDebuffCache[spellID]["typePrio"]=HealBot_Options_retDebuffPriority(spellID, spellName, debuffType)
        HealBot_AuraDebuffCache[spellID].priorityType=debuffType
        uaDebuffData[button.id][uaSlot].isCurrent=false
        HealBot_AuraDebuffCache[spellID].reset=false
    elseif (hbDebuffOnCD[debuffType] or 0)>=(HealBot_TimeNow-2) then
        uaDebuffData[button.id][uaSlot].isCurrent=false
    end
end

local function HealBot_Aura_FilterUnitDebuffs(button, selfOnly)
    if not uaUnitCaster then 
        uaUnitCaster="nil"
        uaUnitIsPlayer=false
    elseif HealBot_SafeUnitIsUnit(uaUnitCaster,"player") then
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
local function HealBot_Aura_UpdateUnitDebuffsData(button, selfOnly, gSlot, iconOnly, dispellable)
      --HealBot_setCall("HealBot_Aura_UpdateUnitDebuffsData", button)
    if uaExpirationTime then
        HealBot_Aura_PostUpdateInitDebuffsCache(uaSpellId, uaName)
        if not uaUnitCaster then uaUnitCaster="nil" end
        if (HEALBOT_FOREVER or uaSlot<20) and HealBot_Aura_FilterUnitDebuffs(button, selfOnly) then
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
            -- A raid member can have more than twenty readable harmful auras.
            -- Reuse overflow records; the configured cap applies after sorting.
            if not uaDebuffData[button.id][uaSlot] then uaDebuffData[button.id][uaSlot]={} end
            if not HealBot_issecretvalue(uaExpirationTime) then
                uaExpirationTime=HealBot_Util_Round(uaExpirationTime,1)
            end
            if HEALBOT_FOREVER or uaDebuffData[button.id][uaSlot].spellId~=uaSpellId or uaDebuffData[button.id][uaSlot].sourceUnit~=(uaUnitCaster) then
                uaDebuffData[button.id][uaSlot].name=uaName
                if (HEALBOT_FOREVER and not uaDebuffType and ForeverHarmfulBleeds[uaSpellId])
                    or (BleedList[uaSpellId] and (not uaDebuffType or not HealBot_Options_retDebuffCureSpell(uaDebuffType))) then
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
            uaDebuffData[button.id][uaSlot].iconOnly=iconOnly
            uaDebuffData[button.id][uaSlot].dispellable=dispellable
            HealBot_Aura_PostUpdateUnitDebuffsData(button, uaSpellId, uaName, uaDebuffData[button.id][uaSlot].debuffType)
        end
        if not iconOnly then
            HealBot_UnitDebuffCurrent[button.unit][uaName]=uaSpellId
            HealBot_AuraDebuffCache[uaSpellId].count=uaCount
            HealBot_AuraDebuffCache[uaSpellId].sourceUnitIsPlayer=uaUnitIsPlayer
            if UnitIsEnemy(uaUnitCaster, "player") then hbv_Auras_SetData("DEBUFFS", uaSpellId) end
        end
    end
end

function HealBot_Aura_IsBoss(unit)
      --HealBot_setCall("HealBot_Aura_IsBoss", nil, nil, unit)
    if unit and (UnitClassification(unit) == "worldboss" or (UnitClassification(unit) == 'elite' and (UnitLevel(unit) == -1 or UnitHealthMax(unit)>hb_lVars["bossHlth"]))) then
        --hb_lVars["BossExists"]=true
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

function HealBot_Aura_UpdateUnitDebuffsV5(button, selfOnly)
      --HealBot_setCall("HealBot_Aura_UpdateUnitDebuffsV5", button)
    uaZ=1
    while true do
        uaName, uaTexture, uaCount, uaDebuffType, uaDuration, uaExpirationTime, uaUnitCaster, _, _, uaSpellId, _, uaIsBossDebuff=UnitDebuff(button.unit,uaZ)
        if uaSpellId then
            HealBot_Aura_UpdateUnitDebuffsData(button, selfOnly, uaZ)
            uaZ=uaZ+1
        else
            break
        end
    end
end

function HealBot_Aura_UpdateUnitDebuffsV9Alt(button, selfOnly, filter)
      --HealBot_setCall("HealBot_Aura_UpdateUnitDebuffsV9Alt", button)
    uaZ=1
    -- 12.1 live: index/slot aura access THROWS while auras are secret in combat
    -- (even for "player", even with combat filters) - pcall, never call bare
    local okA
    okA, uaAura=pcall(C_UnitAuras.GetUnitAuras, button.unit, filter, 20, 3)
    if not okA or HealBot_issecretvalue(uaAura) or not uaAura then return end
	for _, uAura in ipairs(uaAura) do
        if HealBot_Aura_AuraDataIsUsable(uAura) and uAura.dispelName then
            uaName, uaTexture, uaCount, uaDebuffType, uaDuration, uaExpirationTime, uaUnitCaster, uaSpellId, uaIsBossDebuff=
            uAura.name, uAura.icon, uAura.applications, uAura.dispelName, uAura.duration, uAura.expirationTime, uAura.sourceUnit, uAura.spellId, uAura.isBossAura
            HealBot_Aura_UpdateUnitDebuffsData(button, selfOnly, uaZ)
            uaZ=uaZ+1
        end
    end
end

function HealBot_Aura_UpdateUnitDebuffsV9Aura(button, selfOnly, filter)
      --HealBot_setCall("HealBot_Aura_UpdateUnitDebuffsV9Auras", button)
    uaZ=1
    while true do
        local okA
        okA, uaAura=pcall(C_UnitAuras.GetAuraDataByIndex, button.unit, uaZ, filter)
        if not okA or HealBot_issecretvalue(uaAura) or not uaAura then break end
        if HealBot_Aura_AuraDataIsUsable(uaAura) then
            uaName, uaTexture, uaCount, uaDebuffType, uaDuration, uaExpirationTime, uaUnitCaster, uaSpellId, uaIsBossDebuff=
            uaAura.name, uaAura.icon, uaAura.applications, uaAura.dispelName, uaAura.duration, uaAura.expirationTime, uaAura.sourceUnit, uaAura.spellId, uaAura.isBossAura
            HealBot_Aura_UpdateUnitDebuffsData(button, selfOnly, uaZ)
        end
        uaZ=uaZ+1
    end
end

function HealBot_Aura_GetTrackedDebuffIconSet(button, spellId)
    local name=HealBot_WoWAPI_SpellName(spellId)
    if HealBot_issecretvalue(name) then name=nil end
    local zone=hb_lVars["mapName"]
    local byId=hbCustomDebuffsDisabled[spellId]
    local byName=hbCustomDebuffsDisabled[name]
    if (byId and (byId[zone] or byId["ALL"])) or
       (byName and (byName[zone] or byName["ALL"])) then
        return nil
    end
    local filter=HealBot_DebuffFilter[spellId] or HealBot_DebuffFilter[name]
    if filter and not HealBot_Aura_BuffTargetMatches(button,filter) then return nil end
    return HealBot_DebuffIconSet[spellId] or HealBot_DebuffIconSet[name] or 1
end

do
    local function readable(aura)
        return not HealBot_issecretvalue(aura) and type(aura)=="table" and (not canaccesstable or canaccesstable(aura))
            and HealBot_Aura_AuraDataIsUsable(aura) and type(aura.spellId)=="number"
            and type(aura.name)=="string" and type(aura.expirationTime)=="number"
    end

    -- A public spell ID can establish a custom bar warning even when the
    -- client withholds fields required to draw an icon or run its timer.
    local partialSpellNames={}
    local function notePartial(button,aura,expectedID,dispellable)
        if not HealBot_Config_Cures or not HealBot_Config_Cures.CDCshownHB then return end
        if HealBot_issecretvalue(aura) or type(aura)~="table" or (canaccesstable and not canaccesstable(aura)) then return end
        local id=aura.spellId
        if HealBot_issecretvalue(id) or type(id)~="number" then return end
        if expectedID and (id~=expectedID or HealBot_issecretvalue(aura.isHarmful) or not aura.isHarmful) then return end
        local tracked=HealBot_Globals.CustomDebuffs
        if not tracked or not next(tracked) then return end
        local name=aura.name
        if HealBot_issecretvalue(name) or type(name)~="string" then
            name=partialSpellNames[id] or HealBot_WoWAPI_SpellName(id)
            if HealBot_issecretvalue(name) or type(name)~="string" then return end
            partialSpellNames[id]=name
        end
        if not HealBot_Aura_CustomDebuffSetting(tracked,id,name) then return end
        local state=button.aura.debuff
        local dispelType=aura.dispelName
        if HealBot_issecretvalue(dispelType) then
            if id~=6788 then return end
            dispelType=nil
        end
        local source=aura.sourceUnit
        if HealBot_issecretvalue(source) or type(source)~="string" then source=nil end
        state.partialWarnings=state.partialWarnings or {}
        state.partialWarnings[#state.partialWarnings+1]={id=id,name=name,source=source,dispelType=dispelType,dispellable=dispellable}
    end

    local function apply(button,selfOnly,aura,index,dispellable)
        uaName,uaTexture,uaCount,uaDebuffType,uaDuration,uaExpirationTime,uaUnitCaster,uaSpellId,uaIsBossDebuff=
            aura.name,aura.icon,aura.applications,aura.dispelName,aura.duration,aura.expirationTime,
            aura.sourceUnit,aura.spellId,aura.isBossAura
        -- The ordinary path decides caster, target, priority, icon override and bar color.
        HealBot_Aura_UpdateUnitDebuffsData(button,selfOnly,index,nil,dispellable)
        local state=button.aura.debuff
        if state.lookupSeen then state.lookupSeen[aura.spellId]=true end
        if aura.spellId==6788 then state.publicShield=true end
        if state.collectDispels and aura.dispelName then
            state.publicDispels=state.publicDispels or {}
            state.publicDispels[aura.spellId]=true
        end
    end

    local function batch(unit,filter)
        local ok,auras=pcall(C_UnitAuras.GetUnitAuras,unit,filter)
        if ok and not HealBot_issecretvalue(auras) and type(auras)=="table"
            and (not canaccesstable or canaccesstable(auras)) then return auras end
    end

    -- Overlapping broad and dispellable queries can return more than one
    -- application of the same spell from the same caster. Consume one matching
    -- result per occurrence; an unreadable instance ID is never a table key.
    local function sameApplication(a,b)
        return a.name==b.name and a.dispelName==b.dispelName and a.duration==b.duration
            and a.expirationTime==b.expirationTime and a.applications==b.applications
            and a.isBossAura==b.isBossAura and a.icon==b.icon
    end

    local function matchOccurrence(seen,aura,record)
        local spell,source=aura.spellId,aura.sourceUnit or false
        local casters=seen[spell]
        if not casters then
            if not record then return false end
            casters={}
            seen[spell]=casters
        end
        local bucket=casters[source]
        if not bucket then
            if not record then return false end
            bucket={}
            casters[source]=bucket
        end
        local instance=aura.auraInstanceID
        if HealBot_issecretvalue(instance) or type(instance)~="number" then instance=nil end
        if record then
            if instance then bucket[instance]=aura
            else
                bucket.anonymous=bucket.anonymous or {}
                table.insert(bucket.anonymous,aura)
            end
        elseif instance and bucket[instance] then
            bucket[instance]=nil
            return true
        else
            for index,other in ipairs(bucket.anonymous or {}) do
                if sameApplication(aura,other) then
                    table.remove(bucket.anonymous,index)
                    return true
                end
            end
            if not instance then
                for key,other in pairs(bucket) do
                    if type(key)=="number" and sameApplication(aura,other) then bucket[key]=nil; return true end
                end
            end
        end
        return false
    end

    local function lookupPublic(button,selfOnly,id)
        if button.aura.debuff.lookupSeen and button.aura.debuff.lookupSeen[id] then return end
        local ok,aura=pcall(C_UnitAuras.GetUnitAuraBySpellID,button.unit,id)
        if not ok or HealBot_issecretvalue(aura) or type(aura)~="table" then return end
        if not readable(aura) then
            notePartial(button,aura,id)
        elseif aura.spellId==id and not HealBot_issecretvalue(aura.isHarmful) and aura.isHarmful
            and HealBot_UnitDebuffCurrent[button.unit][aura.name]~=aura.spellId then
            apply(button,selfOnly,aura,0)
        end
    end

    function HealBot_Aura_UpdateExplicitCombatDebuffs(button,selfOnly)
        if not C_UnitAuras.GetUnitAuraBySpellID then return end
        local publicCustomDebuffIDs=hb_lVars.publicCustomDebuffIDs
        if not publicCustomDebuffIDs then
            publicCustomDebuffIDs={}
            hb_lVars.publicCustomDebuffIDs=publicCustomDebuffIDs
            local secrecy=C_Secrets and C_Secrets.GetSpellAuraSecrecy
            local never=Enum and Enum.SecrecyLevel and Enum.SecrecyLevel.NeverSecret
            if secrecy and never~=nil then
                local function addPublic(id)
                    if type(id)~="number" or publicCustomDebuffIDs[id] then return end
                    local ok,value=pcall(secrecy,id)
                    if ok and not HealBot_issecretvalue(value) and value==never then
                        publicCustomDebuffIDs[id]=true
                    end
                end
                for id in pairs(HealBot_Globals.CustomDebuffs or {}) do
                    addPublic(id)
                    if HealBot_Forever_VisitSpellNameIDs and (HealBot_Globals.CustomDebuffIDMethod[id] or 2)>1 then
                        local name=type(id)=="number" and HealBot_WoWAPI_SpellName(id) or id
                        HealBot_Forever_VisitSpellNameIDs(id,name,addPublic)
                    end
                end
            end
        end
        for id in pairs(publicCustomDebuffIDs) do lookupPublic(button,selfOnly,id) end
        local context=InCombatLockdown() and "combat" or "rest"
        for id,rule in pairs(HealBot_Globals.DebuffIconVisibility or {}) do
            if rule[context]==true and not publicCustomDebuffIDs[id] then lookupPublic(button,selfOnly,id) end
        end
    end

    function HealBot_Aura_UpdateForeverDebuffs(button,selfOnly)
        local state=button.aura.debuff
        local previousDispels=state.publicDispels
        state.publicDispels=nil
        state.collectDispels=nil
        state.publicUnit=nil
        state.publicShield=nil
        state.partialWarnings=nil
        state.scanUnit=button.unit
        state.scanCombat=not not InCombatLockdown()
        local all=batch(button.unit,"HARMFUL")
        if not all and not state.scanCombat and C_UnitAuras.GetAuraDataByIndex then
            -- Some builds allow ordinary indexed reads when the bulk call is unavailable.
            -- Keep any readable prefix; the fallback below handles an interrupted scan.
            local indexed={}
            local index=1
            while true do
                local ok,aura=pcall(C_UnitAuras.GetAuraDataByIndex,button.unit,index,"HARMFUL")
                if not ok or HealBot_issecretvalue(aura) then
                    indexed[#indexed+1]=false
                    break
                end
                if not aura then break end
                indexed[#indexed+1]=aura
                index=index+1
            end
            all=indexed
        end
        local complete=all~=nil
        -- Even a nonempty result may omit restricted auras. Render its public
        -- entries normally and leave the native renderer available for the rest.
        if complete and C_Secrets and C_Secrets.ShouldAurasBeSecret then
            local ok,value=pcall(C_Secrets.ShouldAurasBeSecret)
            complete=ok and not HealBot_issecretvalue(value) and value==false
        end
        if complete and UnitIsVisible then
            local visible=UnitIsVisible(button.unit)
            complete=not HealBot_issecretvalue(visible) and visible
        end
        if complete and UnitIsConnected then
            local connected=UnitIsConnected(button.unit)
            complete=not HealBot_issecretvalue(connected) and connected
        end
        for _,aura in ipairs(all or {}) do
            if not readable(aura) then complete=false; break end
        end
        -- This filter describes the player's current ability on this unit. Never
        -- retain the result by spell ID across applications, zones or talent changes.
        local removable
        if not complete or #all>0 then
            removable=batch(button.unit,"RAID_PLAYER_DISPELLABLE")
            if not removable and C_UnitAuras.GetAuraDataByIndex then
                removable={}
                local index=1
                while true do
                    local ok,aura=pcall(C_UnitAuras.GetAuraDataByIndex,button.unit,index,"RAID_PLAYER_DISPELLABLE")
                    if not ok or HealBot_issecretvalue(aura) or not aura then break end
                    removable[#removable+1]=aura
                    index=index+1
                end
            end
        end
        if complete then
            state.publicUnit=button.unit
            local seen
            if removable and #removable>0 then
                seen={}
                for _,aura in ipairs(removable) do
                    if readable(aura) then matchOccurrence(seen,aura,true) end
                end
            end
            for index,aura in ipairs(all) do
                apply(button,selfOnly,aura,index,seen and matchOccurrence(seen,aura,false) or false)
            end
            if not state.publicShield and HealBot_Forever_GetShieldLockout then
                state.shieldAbsentStart=HealBot_Forever_GetShieldLockout(button)
            end
            return
        end
        -- A restricted general query can coexist with public dispellable entries.
        -- Keep both sets and deduplicate only across the two enumerations.
        state.collectDispels=true
        state.lookupSeen={}
        local seen=all and removable and {}
        for index,aura in ipairs(removable or {}) do
            if readable(aura) then
                apply(button,selfOnly,aura,index,true)
                if seen then matchOccurrence(seen,aura,true) end
            else
                notePartial(button,aura,nil,true)
            end
        end
        for index,aura in ipairs(all or {}) do
            if readable(aura) then
                if not (seen and matchOccurrence(seen,aura,false)) then apply(button,selfOnly,aura,index) end
            else
                notePartial(button,aura)
            end
        end
        HealBot_Aura_UpdateExplicitCombatDebuffs(button,selfOnly)
        state.lookupSeen=nil
        state.collectDispels=nil
        -- Retain identity for an unchanged public set so native groups need
        -- no writes on subsequent UNIT_AURA events.
        if previousDispels and state.publicDispels then
            for id in pairs(previousDispels) do if not state.publicDispels[id] then return end end
            for id in pairs(state.publicDispels) do if not previousDispels[id] then return end end
            state.publicDispels=previousDispels
        end
    end
end

function HealBot_Aura_UpdateUnitDebuffsV9(button, selfOnly)
      --HealBot_setCall("HealBot_Aura_UpdateUnitDebuffsV9", button)
    if HEALBOT_FOREVER and C_UnitAuras then
        HealBot_Aura_UpdateForeverDebuffs(button,selfOnly)
    elseif HealBot_Util_isMidnight(true) and (not HEALBOT_FOREVER or InCombatLockdown()) then
        HealBot_Aura_UpdateUnitDebuffsV9Alt(button, selfOnly, "RAID_PLAYER_DISPELLABLE")
        if HEALBOT_FOREVER then HealBot_Aura_UpdateExplicitCombatDebuffs(button,selfOnly) end
    else
        HealBot_Aura_UpdateUnitDebuffsV9Aura(button, selfOnly, "HARMFUL")
    end
end

local HealBot_Aura_UpdateUnitDebuffs=HealBot_Aura_UpdateUnitDebuffsV2
if HEALBOT_CLIENT_VERSION>8 then
    HealBot_Aura_UpdateUnitDebuffs=HealBot_Aura_UpdateUnitDebuffsV9
elseif HEALBOT_GAME_VERSION>4 then
    HealBot_Aura_UpdateUnitDebuffs=HealBot_Aura_UpdateUnitDebuffsV5
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
local function HealBot_Aura_InInstanceGroup()
    local category=LE_PARTY_CATEGORY_INSTANCE
    return category and ((IsInGroup and IsInGroup(category)) or (IsInRaid and IsInRaid(category)))
end

local function HealBot_Aura_IsGrouped()
    return (GetNumGroupMembers() or 0)>0 or HealBot_Aura_InInstanceGroup()
end

function HealBot_Aura_CheckUnitBuffs(button, selfOnly)
      --HealBot_setCall("HealBot_Aura_CheckUnitBuffs", button)
    if buffCheck and not button.special.unit and (not HEALBOT_FOREVER or UnitIsConnected(button.unit))
        and (not button.status.isdead or button.status.isspirit) then
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
            button.aura.buff.publicRendered=false
            if not HealBot_UnitBuffCurrent[button.unit] then
                HealBot_UnitBuffCurrent[button.unit]={}
                HealBot_UnitBuffTagsCurrent[button.unit]={}
            end
            for bName, _ in pairs(HealBot_UnitBuffCurrent[button.unit]) do
                HealBot_UnitBuffCurrent[button.unit][bName]=false
            end
            button.aura.buff.update=false
            button.aura.buff.temp.active=false
            uaSlot=0
            uaBuffData[button.id].lastslot=0
            HealBot_Aura_UpdateUnitBuffs(button, selfOnly)
            for bName, bID in pairs(HealBot_UnitBuffCurrent[button.unit]) do
                if not HealBot_UnitBuffCurrent[button.unit][bName] then
                    HealBot_UnitBuffCurrent[button.unit][bName]=nil
                    HealBot_Aura_BuffUpdate_Plugins(button.guid, bName, HealBot_Globals.CustomBuffTag[HealBot_Aura_ID[bName]] or HealBot_BuffTagNames[bName], 0, false, button.unit)
                else
                    HealBot_Aura_BuffUpdate_Plugins(button.guid, bName, HealBot_Globals.CustomBuffTag[bID] or HealBot_BuffTagNames[bName], HealBot_AuraBuffCache[bID].count, true, HealBot_AuraBuffCache[bID].sourceUnitIsPlayer, button.unit)
                end
            end
        end
        if button.aura.buff.scanIncomplete then button.aura.buff.update=true end
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
                if prevMissingbuff~=button.aura.buff.missingbuff or hb_lVars["updateAll"] then
                    button.aura.buff.name="needUpdate"
                end
                HealBot_Aura_BuffWarnings(button, curBuffName)
            else
                HealBot_Aura_ClearBuff(button)
            end
            button.aura.buff.publicRendered=button.aura.buff.publicGeneration~=nil and not button.aura.buff.scanIncomplete
    --    else
    --        HealBot_Aura_ClearBuff(button)
    --    end
    else
        button.aura.buff.publicGeneration=nil
        if HEALBOT_FOREVER and not UnitIsConnected(button.unit) then
            HealBot_Aura_RemoveBuffIcons(button)
        end
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

hb_lVars["bossHlth"]=250000
function HealBot_Aura_SetBossHealth(inInst)
      --HealBot_setCall("HealBot_Aura_SetBossHealth")
    if HealBot_Data["PLEVEL"]<50 then
        hb_lVars["bossHlth"]=HealBot_Data["PLEVEL"]*750
    elseif HealBot_Data["PLEVEL"]<60 then
        hb_lVars["bossHlth"]=HealBot_Data["PLEVEL"]*900
    elseif HealBot_Data["PLEVEL"]<70 then
        hb_lVars["bossHlth"]=HealBot_Data["PLEVEL"]*1000
    elseif HealBot_Data["PLEVEL"]<75 then
        hb_lVars["bossHlth"]=HealBot_Data["PLEVEL"]*1100
    elseif HealBot_Data["PLEVEL"]<80 then
        hb_lVars["bossHlth"]=HealBot_Data["PLEVEL"]*1250
    elseif HealBot_Data["PLEVEL"]<85 then
        hb_lVars["bossHlth"]=HealBot_Data["PLEVEL"]*1500
    else
        hb_lVars["bossHlth"]=250000
    end
    if inInst then
        local difficultyID=GetDungeonDifficultyID()
        if difficultyID~=1 and difficultyID~=173 then
            hb_lVars["bossHlth"]=hb_lVars["bossHlth"]*2
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

local debuffBarCol=0
function HealBot_Aura_BuffsEnabled()
    return buffCheck
end

-- Native buff rows follow the same monitoring flags as the legacy aura scan.
function HealBot_Forever_BuffsEnabled()
    local buffs=HealBot_Config_Buffs
    return buffs.BuffWatch and buffCheck
        and (buffs.BuffCustomWatchInCombat or not InCombatLockdown())
        and (buffs.BuffWatchWhenMounted or not IsMounted())
        and (not buffs.BuffWatchWhenGrouped or HealBot_Aura_IsGrouped())
end

function HealBot_Aura_DebuffsEnabled()
    return debuffCheck
end

-- Native Forever rows use the same configured dispel types as the general debuff list.
do
    local names={"Magic","Curse","Disease","Poison","Bleed"}
    local masks={}
    function HealBot_Forever_GetDebuffTypes(button)
        local mask,bit,scoped=0,1,false
        for _,name in ipairs(names) do
            local scope=HealBot_Options_retDebuffWatchTarget(name)
            if scope then
                if not scope.Raid then scoped=true end
                if not button or HealBot_Aura_DispelTargetMatches(button,scope) then mask=mask+bit end
            end
            bit=bit*2
        end
        local preset=masks[mask]
        if not preset then
            local types,keys={},{}
            bit=1
            for _,name in ipairs(names) do
                if math.floor(mask/bit)%2==1 then types[name]=true; keys[#keys+1]=name end
                bit=bit*2
            end
            preset={types,table.concat(keys,",")}
            masks[mask]=preset
        end
        return preset[1],preset[2],scoped
    end
end

function HealBot_Forever_DebuffsEnabled()
    local cures=HealBot_Config_Cures
    return cures.DebuffWatch and HealBot_Aura_DebuffsEnabled()
        and (cures.DebuffWatchInCombat or not InCombatLockdown())
        and (cures.DebuffWatchWhenMounted or not IsMounted())
        and (not cures.DebuffWatchWhenGrouped or HealBot_Aura_IsGrouped())
end

do
    local function casterMatches(source,rule,selfOnly)
        local everyone=rule==castByListIndexed[HEALBOT_CUSTOM_CASTBY_EVERYONE]
        if everyone and not selfOnly then return true end
        if not source then return false end
        local mine=source=="player" or HealBot_SafeUnitIsUnit(source,"player")
        if selfOnly and not mine then return false end
        if everyone or rule==castByListIndexed[HEALBOT_OPTIONS_SELFHEALS] then return mine end
        if mine then return rule==castByListIndexed[HEALBOT_CUSTOM_CASTBY_FRIEND] end
        local friendly=UnitIsFriend("player",source)
        if HealBot_issecretvalue(friendly) or type(friendly)~="boolean" then return false end
        if friendly then return rule==castByListIndexed[HEALBOT_CUSTOM_CASTBY_FRIEND] end
        local enemy=UnitIsEnemy("player",source)
        return not HealBot_issecretvalue(enemy) and enemy and rule==castByListIndexed[HEALBOT_CUSTOM_CASTBY_ENEMY]
    end

    local function customBar(button,selfOnly,id,name,source,dispelType,dispellable,currentPriority)
        if not name or HealBot_Aura_CustomDebuffDisabled(id,name) then return end
        local priority,typePriority=HealBot_Options_retDebuffPriority(id,name,dispelType or "nil")
        if priority>=21 or priority>=typePriority or (currentPriority and priority>=currentPriority) then return end
        if HealBot_Config_Cures.CDCshownHBDispelOnly and not dispellable then return end
        local mode=HealBot_Aura_CustomDebuffSetting(HealBot_Globals.CustomDebuffsShowBarCol,id,name) or 4
        if mode~=3 and mode~=4 then return end
        local filter=HealBot_DebuffFilter[id] or HealBot_DebuffFilter[name]
        if filter and not HealBot_Aura_BuffTargetMatches(button,filter) then return end
        local rule=hbCustomDebuffsCastBy[id] or hbCustomDebuffsCastBy[name] or HealBot_Globals.CureCustomDefaultCastBy
        if casterMatches(source,rule,selfOnly) then return mode,priority end
    end

    function HealBot_Forever_GetPartialBarWarning(button,selfOnly,currentPriority)
        if not HealBot_Config_Cures.CDCshownHB then return end
        local state=button.aura.debuff
        local id,name,mode,priority,dispellable
        local shieldSeen=state.publicShield
        if state.partialWarnings then
            local current=HealBot_UnitDebuffCurrent[button.unit]
            for _,aura in ipairs(state.partialWarnings) do
                if aura.id==6788 then shieldSeen=true end
                if not current or current[aura.name]~=aura.id then
                    local m,p=customBar(button,selfOnly,aura.id,aura.name,aura.source,aura.dispelType,aura.dispellable,priority or currentPriority)
                    if m then id,name,mode,priority,dispellable=aura.id,aura.name,m,p,aura.dispellable end
                end
            end
        end
        -- Only the player's own completed, target-matched shield cast provides
        -- a timer when spell identity is unavailable. A complete removal wins.
        if not shieldSeen and HealBot_Forever_GetShieldLockout then
            local start=HealBot_Forever_GetShieldLockout(button)
            if start and start~=state.shieldAbsentStart and HealBot_Forever_WatchesWeakenedSoul() then
                local shield=HealBot_WoWAPI_SpellName(6788)
                if not HealBot_issecretvalue(shield) and type(shield)=="string" then
                    local m,p=customBar(button,selfOnly,6788,shield,"player",nil,false,priority or currentPriority)
                    if m then return 6788,shield,m,p,false end
                end
            end
        end
        return id,name,mode,priority,dispellable
    end
end

function HealBot_Aura_CheckUnitDebuffs(button, selfOnly)
      --HealBot_setCall("HealBot_Aura_CheckUnitDebuffs", button)
    if debuffCheck and not button.special.unit and button.status.current<HealBot_Unit_Status["DEAD"] then
        for z=1,3 do
            HealBot_Aura_prevIconCount["DEBUFF"][z]=button.icon.debuff.count[z]
        end
        --button.aura.debuff.type=false
        if button.aura.debuff.update then
            if not HealBot_UnitDebuffCurrent[button.unit] then 
                HealBot_UnitDebuffCurrent[button.unit]={}
                HealBot_UnitDebuffTagsCurrent[button.unit]={}
            end
            for dName, _ in pairs(HealBot_UnitDebuffCurrent[button.unit]) do
                HealBot_UnitDebuffCurrent[button.unit][dName]=false
            end
            button.aura.debuff.update=false
            button.aura.debuff.temp.active=false
            uaSlot=0
            uaDebuffData[button.id].lastslot=0
            HealBot_Aura_UpdateUnitDebuffs(button, selfOnly)
            for dName, dID in pairs(HealBot_UnitDebuffCurrent[button.unit]) do
                if not HealBot_UnitDebuffCurrent[button.unit][dName] then
                    HealBot_UnitDebuffCurrent[button.unit][dName]=nil
                    HealBot_Aura_DebuffUpdate_Plugins(button.guid, dName, HealBot_Globals.CDCTag[HealBot_Aura_ID[dName]] or HealBot_DebuffTagNames[dName], 0, false, button.unit)
                else
                    HealBot_Aura_DebuffUpdate_Plugins(button.guid, dName, HealBot_Globals.CDCTag[dID] or HealBot_DebuffTagNames[dName], HealBot_AuraDebuffCache[dID].count, true, HealBot_AuraDebuffCache[dID].sourceUnitIsPlayer, button.unit)
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

        local warningSlot=HealBot_Aura_SortDebuffIcons(button)
        local oldID,oldDispel,oldMode=button.aura.debuff.id,button.aura.debuff.dispellable,button.aura.debuff.colbar
        local expirationTime,selected
        HealBot_Aura_CheckUnitDebuffIcons(button)
        if warningSlot>0 then
            selected=uaDebuffData[button.id][warningSlot]
            button.aura.debuff.id=selected.spellId
            button.aura.debuff.priority=selected.priority or HealBot_AuraDebuffCache[selected.spellId].priority
            expirationTime=selected.expirationTime
        elseif button.aura.debuff.temp.active then
            selected=uaDebuffData[button.id][button.aura.debuff.temp.slot]
            button.aura.debuff.id=button.aura.debuff.temp.id
            button.aura.debuff.priority=button.aura.debuff.temp.priority
            expirationTime=button.aura.debuff.temp.expirationTime
        else
            button.aura.debuff.id=0
        end
        local state=button.aura.debuff
        local barID,warningName,barMode,barPriority,canDispel
        if HEALBOT_FOREVER and state.scanUnit==button.unit and not state.publicUnit and HealBot_Forever_GetPartialBarWarning then
            barID,warningName,barMode,barPriority,canDispel=HealBot_Forever_GetPartialBarWarning(button,selfOnly,selected and state.priority)
        end
        if barID then state.id,state.priority=barID,barPriority end
        if state.id>0 and HealBot_Panel_RaidPetUnitButtonCheck(button.unit) then
            local warningType=HEALBOT_CUSTOM_en
            if barID then
                debuffBarCol,state.dispellable=barMode,canDispel
            else
                local cache=HealBot_AuraDebuffCache[state.id]
                local automatic=cache.isAuto
                warningName,warningType=cache.name,cache.debuffType
                if HEALBOT_FOREVER then automatic,warningType=selected.automatic,selected.warningType end
                if automatic then
                    debuffBarCol=HealBot_Globals.CustomDebuffsShowBarCol[HEALBOT_CUSTOM_CAT_CUSTOM_AUTOMATIC] or 4
                elseif warningType == HEALBOT_CUSTOM_en then
                    debuffBarCol=HealBot_Aura_CustomDebuffSetting(HealBot_Globals.CustomDebuffsShowBarCol,state.id,warningName) or 4
                else
                    debuffBarCol=HealBot_Globals.CustomDebuffsShowBarCol["DEFAULT"] or 4
                end
                if HEALBOT_FOREVER then
                    state.dispellable=selected.dispellable
                else
                    state.dispellable=HealBot_Aura_CanDispel[state.id]
                end
            end
            button.aura.debuff.colbar=debuffBarCol-1
            HealBot_Aura_CheckUnitBuffOverDebuff(button)
            if button.aura.debuff.type~=warningType or button.aura.debuff.bodupd or oldID~=button.aura.debuff.id
                or oldDispel~=button.aura.debuff.dispellable or oldMode~=button.aura.debuff.colbar
                or (state.barOnly and not barID) then
                button.aura.debuff.bodupd=false
                button.aura.debuff.name="needUpdate"
                button.aura.debuff.type=warningType
            end
            state.barOnly=barID~=nil
            HealBot_Aura_DebuffWarnings(button, warningName, false, 0, expirationTime, barID~=nil)
        else
            HealBot_Aura_ClearDebuff(button)
        end
    else
        HealBot_Aura_ClearDebuff(button)
    end
end

function HealBot_Aura_CheckUnitAuras(button, debuff, selfOnly)
      --HealBot_setCall("HealBot_Aura_CheckUnitAuras", button)
    if not hb_lVars["TestBarsOn"] then
        if debuff then
            HealBot_Aura_CheckUnitDebuffs(button, selfOnly)
        else
            HealBot_Aura_CheckUnitBuffs(button, selfOnly)
        end
    end
end

function HealBot_Aura_RefreshAfterCombat()
    -- Run after HealBot's own lock is cleared, not merely after the client
    -- regen event: the aura readers choose their filters using that lock.
    for _,button in pairs(HealBot_Buttons) do
        if button.status.events then
            button.aura.buff.update=true
            button.aura.debuff.update=true
            HealBot_Events_UnitBuff(button)
            HealBot_Events_UnitDebuff(button)
        end
    end
end

local lowTime=0
function HealBot_Aura_ResetCheckBuffsTime(button)
      --HealBot_setCall("HealBot_Aura_ResetCheckBuffsTime", button)
    lowTime=HealBot_ServerTimeNow+10000000
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
    local tmpBCheck=buffCheck
    local tmpGBuffs=generalBuffs
    local tmpDCheck=debuffCheck
    local grouped=HealBot_Aura_IsGrouped()
    local tmpBGroup=HealBot_Config_Buffs.BuffWatchWhenGrouped and not grouped
    local tmpDGroup=HealBot_Config_Cures.DebuffWatchWhenGrouped and not grouped

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

function HealBot_Aura_UpdateBuffTags(unit, aura, tag, active)
    if active then
        if not HealBot_UnitBuffTagsCurrent[unit][tag] then HealBot_UnitBuffTagsCurrent[unit][tag]={} end
        HealBot_UnitBuffTagsCurrent[unit][tag][aura]=true
    elseif HealBot_UnitBuffTagsCurrent[unit][tag] then
        HealBot_UnitBuffTagsCurrent[unit][tag][aura]=nil
        HealBot_Aura_EmptyLocalTable(HealBot_UnitBuffTagsCurrent[unit], tag)
        if HealBot_UnitBuffTagsCurrent[unit][tag] then active=true end
    end
    return active
end

function HealBot_Aura_BuffUpdate_Plugins(guid, aura, tag, count, active, casterIsPlayer, unit)
      --HealBot_setCall("HealBot_Aura_BuffUpdate_Plugins")
    if hbAuraWatch[unit] then
        if active and not count or count<1 then count=1 end
        if hbAuraBuffWatch[unit] and hbAuraBuffWatch[unit][aura] then
            if not active then
                hbAuraBuffWatch[unit][aura]=0
                if HealBot_UnitBuffCurrent["player"] and HealBot_UnitBuffCurrent["player"][aura] then
                    HealBot_Plugin_AuraWatch_PlayerBuffUpdate(guid, aura, count, active, casterIsPlayer, true)
                else
                    HealBot_Plugin_AuraWatch_PlayerBuffUpdate(guid, aura, count, active, casterIsPlayer, false)
                end
            elseif hbAuraBuffWatch[unit][aura]~=count then
                hbAuraBuffWatch[unit][aura]=count
                if HealBot_UnitBuffCurrent["player"] and HealBot_UnitBuffCurrent["player"][aura] then
                    HealBot_Plugin_AuraWatch_PlayerBuffUpdate(guid, aura, count, active, casterIsPlayer, true)
                else
                    HealBot_Plugin_AuraWatch_PlayerBuffUpdate(guid, aura, count, active, casterIsPlayer, false)
                end
            end
        end
        if hbAuraActionBuffWatch[unit] and hbAuraActionBuffWatch[unit][aura] then
            if not active then
                hbAuraActionBuffWatch[unit][aura]=0
                HealBot_ActionIcons_BuffUpdate(guid, aura, count, active, casterIsPlayer)
            elseif hbAuraActionBuffWatch[unit][aura]~=count then
                hbAuraActionBuffWatch[unit][aura]=count
                HealBot_ActionIcons_BuffUpdate(guid, aura, count, active, casterIsPlayer)
            end
        end
        if tag then
            active=HealBot_Aura_UpdateBuffTags(unit, aura, tag, active)
            if hbAuraBuffTagWatch[unit] and hbAuraBuffTagWatch[unit][tag] then
                if not active then
                    hbAuraBuffTagWatch[unit][tag]=0
                    HealBot_Plugin_AuraWatch_PlayerBuffTagUpdate(guid, tag, count, active, casterIsPlayer)
                elseif hbAuraBuffTagWatch[unit][tag] == 0 then
                    hbAuraBuffTagWatch[unit][tag]=1
                    HealBot_Plugin_AuraWatch_PlayerBuffTagUpdate(guid, tag, count, active, casterIsPlayer)
                end
            end
            if hbAuraActionBuffTagWatch[unit] and hbAuraActionBuffTagWatch[unit][tag] then
                if not active then
                    hbAuraActionBuffTagWatch[unit][tag]=0
                    HealBot_ActionIcons_BuffTagUpdate(guid, tag, count, active, casterIsPlayer)
                elseif hbAuraActionBuffTagWatch[unit][tag] == 0 then
                    hbAuraActionBuffTagWatch[unit][tag]=1
                    HealBot_ActionIcons_BuffTagUpdate(guid, tag, count, active, casterIsPlayer)
                end
            end
        end
    end
end

function HealBot_Aura_UpdateDebuffTags(unit, aura, tag, active)
    if active then
        if not HealBot_UnitDebuffTagsCurrent[unit][tag] then HealBot_UnitDebuffTagsCurrent[unit][tag]={} end
        HealBot_UnitDebuffTagsCurrent[unit][tag][aura]=true
    elseif HealBot_UnitDebuffTagsCurrent[unit][tag] then
        HealBot_UnitDebuffTagsCurrent[unit][tag][aura]=nil
        HealBot_Aura_EmptyLocalTable(HealBot_UnitDebuffTagsCurrent[unit], tag)
        if HealBot_UnitDebuffTagsCurrent[unit][tag] then
            active=true
        end
    end
    return active
end

function HealBot_Aura_DebuffUpdate_Plugins(guid, aura, tag, count, active, casterIsPlayer, unit)
      --HealBot_setCall("HealBot_Aura_DebuffUpdate_Plugins")
    if hbAuraWatch[unit] then
        if count<1 then count=1 end
        if hbAuraDebuffWatch[unit] and hbAuraDebuffWatch[unit][aura] then
            if not active then
                hbAuraDebuffWatch[unit][aura]=0
                HealBot_Plugin_AuraWatch_PlayerDebuffUpdate(guid, aura, count, active, casterIsPlayer)
            elseif hbAuraDebuffWatch[unit][aura]~=count then
                hbAuraDebuffWatch[unit][aura]=count
                HealBot_Plugin_AuraWatch_PlayerDebuffUpdate(guid, aura, count, active, casterIsPlayer)
            end
        end
        if hbAuraActionDebuffWatch[unit] and hbAuraActionDebuffWatch[unit][aura] then
            if not active then
                hbAuraActionDebuffWatch[unit][aura]=0
                HealBot_ActionIcons_DebuffUpdate(guid, aura, count, active, casterIsPlayer)
            elseif hbAuraActionDebuffWatch[unit][aura]~=count then
                hbAuraActionDebuffWatch[unit][aura]=count
                HealBot_ActionIcons_DebuffUpdate(guid, aura, count, active, casterIsPlayer)
            end
        end
        if tag then
            active=HealBot_Aura_UpdateDebuffTags(unit, aura, tag, active)
            if hbAuraDebuffTagWatch[unit] and hbAuraDebuffTagWatch[unit][tag] then
                if not active then
                    hbAuraDebuffTagWatch[unit][tag]=0
                    HealBot_Plugin_AuraWatch_PlayerDebuffTagUpdate(guid, tag, count, active, casterIsPlayer)
                elseif hbAuraDebuffTagWatch[unit][tag] == 0 then
                    hbAuraDebuffTagWatch[unit][tag]=1
                    HealBot_Plugin_AuraWatch_PlayerDebuffTagUpdate(guid, tag, count, active, casterIsPlayer)
                end
            end
            if hbAuraActionDebuffTagWatch[unit] and hbAuraActionDebuffTagWatch[unit][tag] then
                if not active then
                    hbAuraActionDebuffTagWatch[unit][tag]=0
                    HealBot_ActionIcons_DebuffTagUpdate(guid, tag, count, active, casterIsPlayer)
                elseif hbAuraActionDebuffTagWatch[unit][tag] == 0 then
                    hbAuraActionDebuffTagWatch[unit][tag]=1
                    HealBot_ActionIcons_DebuffTagUpdate(guid, tag, count, active, casterIsPlayer)
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
        for i=51+(button.icon.debuff.offset or 0),button.icon.debuff.count[1]+50+(button.icon.debuff.offset or 0) do
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
            for i=51+(xButton.icon.debuff.offset or 0),xButton.icon.debuff.count[1]+50+(xButton.icon.debuff.offset or 0) do
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
            for i=51+(xButton.icon.debuff.offset or 0),xButton.icon.debuff.count[1]+50+(xButton.icon.debuff.offset or 0) do
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
            for i=51+(xButton.icon.debuff.offset or 0),xButton.icon.debuff.count[1]+50+(xButton.icon.debuff.offset or 0) do
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
            for i=51+(xButton.icon.debuff.offset or 0),xButton.icon.debuff.count[1]+50+(xButton.icon.debuff.offset or 0) do
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
            for i=51+(xButton.icon.debuff.offset or 0),xButton.icon.debuff.count[1]+50+(xButton.icon.debuff.offset or 0) do
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
    local changed=HealBot_BuffFilter[id]~=filter
    HealBot_BuffFilter[id]=filter
    if (HealBot_Globals.CustomBuffIDMethod[id] or 2)>1 and sName then
        changed=changed or HealBot_BuffFilter[sName]~=filter
        HealBot_BuffFilter[sName]=filter
    end
    if changed and HealBot_Forever_InvalidateBuffPolicy then HealBot_Forever_InvalidateBuffPolicy() end
end

function HealBot_Aura_ConfigClassHoT()
      --HealBot_setCall("HealBot_configClassHoT")
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
    for xClass,_  in pairs(HealBot_Globals.WatchHoT) do
        for entry,x in pairs(HealBot_Globals.WatchHoT[xClass]) do
            local id,sName=entry,nil
            if type(entry)=="string" then
                if not HealBot_SpellID_LookupData[entry] then
                    HealBot_SpellID_LookupData[entry]={CHECK=true,CLASS=xClass}
                end
                if HealBot_Globals.CustomBuffIDMethod[entry]==1 then
                    id=HealBot_WoWAPI_SpellId(entry)
                else
                    sName=entry
                end
            else
                sName=HealBot_WoWAPI_SpellName(id)
            end
            if id and x~=false then
                local caster="A"
                if x==1 or x=="S" then caster="S" elseif x==2 or x=="C" then caster="C" end
                HealBot_Aura_ConfigClassAllHoT(id,sName,caster)
                local iconSetID=HealBot_BuffIconSetKey(id)
                local iconSet=HealBot_Globals.CustomBuffsIconSet[iconSetID] or HealBot_Globals.CustomBuffsIconSet[entry]
                if iconSet then
                    HealBot_Aura_ConfigBuffIconSetId(iconSetID,sName,iconSet)
                end
                if HealBot_Globals.CustomBuffsIconGlow[entry] then
                    HealBot_Aura_ConfigBuffIconGlowId(id,sName,HealBot_Globals.CustomBuffsIconGlow[entry])
                end
                if HealBot_Globals.CustomBuffsFilter[entry] then
                    HealBot_Aura_ConfigBuffFilter(id,sName,HealBot_Globals.CustomBuffsFilter[entry])
                end
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
    hb_lVars.publicCustomDebuffIDs=nil
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
    local owners={}
    hb_lVars.customDebuffNameOwners=owners
    for id, priority in pairs(HealBot_Globals.CustomDebuffs) do
        if type(id)=="number" and type(priority)=="number" and (HealBot_Globals.CustomDebuffIDMethod[id] or 2)>1 then
            local name=HealBot_WoWAPI_SpellName(id)
            if not HealBot_issecretvalue(name) and type(name)=="string" then
                local old=owners[name]
                if not old or priority<HealBot_Globals.CustomDebuffs[old]
                    or (priority==HealBot_Globals.CustomDebuffs[old] and id<old) then owners[name]=id end
            end
        end
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
        -- Do not set HealBot_Weapon_Enchant here, it is derived from the
        -- weapon enchant dropdowns by HealBot_Options_BuffWeaponEnchantSetAura
        return hbWeaponEnchants[iName]
    end
    return false
end

-- Consumable weapon oils, used to populate the weapon enchant dropdowns and
-- to flag which of them the player is currently carrying
local hbWeaponEnchantOils=false
function HealBot_Aura_retWeaponEnchantOils()
      --HealBot_setCall("HealBot_Aura_retWeaponEnchantOils")
    if not hbWeaponEnchantOils then
        hbWeaponEnchantOils={HEALBOT_BRILLIANT_MANA_OIL_SPELL,
                             HEALBOT_BRILLIANT_WIZARD_OIL_SPELL,
                             HEALBOT_BLESSED_WIZARD_OIL_SPELL,
                             HEALBOT_WIZARD_OIL_SPELL,
                             HEALBOT_LESSER_MANA_OIL_SPELL,
                             HEALBOT_MINOR_MANA_OIL_SPELL,
                             HEALBOT_LESSER_WIZARD_OIL_SPELL,
                             HEALBOT_MINOR_WIZARD_OIL_SPELL}
        if HEALBOT_GAME_VERSION>1 then
            table.insert(hbWeaponEnchantOils, HEALBOT_SUPERIOR_MANA_OIL_SPELL)
            table.insert(hbWeaponEnchantOils, HEALBOT_SUPERIOR_WIZARD_OIL_SPELL)
        end
    end
    return hbWeaponEnchantOils
end

local InitItemsDataPrev={["MANADRINK"]=false, ["WELLFED"]=false}
local InitItemsDataUpdate=true
function HealBot_Aura_InitItemsDataReady()
      --HealBot_setCall("HealBot_Aura_InitItemsDataReady")
    local hbCustomItemID,hbCustomSpellID=0,0

    if HEALBOT_GAME_VERSION<4 then
        local oils=HealBot_Aura_retWeaponEnchantOils()
        for j=1, #oils do
            local oilKey="OIL"..oils[j]
            if HealBot_Aura_UpdateItemData(HealBot_WoWAPI_ItemInfo(oils[j]), oils[j]) then
                if not InitItemsDataPrev[oilKey] then
                    InitItemsDataPrev[oilKey]=true
                    InitItemsDataUpdate=true
                end
            elseif InitItemsDataPrev[oilKey] then
                InitItemsDataPrev[oilKey]=false
                InitItemsDataUpdate=true
            end
        end
    end

    for x,_ in pairs(HealBot_Buff_Aura2Item) do
        HealBot_Buff_Aura2Item[x]=nil;
    end
    
    hb_lVars["ManaDrink"]=""
    if HealBot_Config_Buffs.CheckManaDrink then
        InitItemsDataPrev["MANADRINK"]=true
        hbCustomItemID=HealBot_WoWAPI_ItemInfoInstant(HealBot_Config_Buffs.ManaDrinkItem or "x") or 0
        if hbCustomItemID>0 and HealBot_IsItemInBag(hbCustomItemID) and (IsInInstance() or not HealBot_Config_Buffs.ExtraBuffsOnlyInInstance) then
            if HealBot_BuffWatch[HealBot_Config_Buffs.BackupManaDrinkItem] then HealBot_Aura_ClearBuffWatch(HealBot_Config_Buffs.BackupManaDrinkItem) end
            HealBot_Buff_Aura2Item[HEALBOT_MANA_DRINK]=hbCustomItemID
            hb_lVars["ManaDrink"]=HealBot_Config_Buffs.ManaDrinkItem
            if not HealBot_BuffWatch[hb_lVars["ManaDrink"]] then
                HealBot_Aura_SetBuffWatch(hb_lVars["ManaDrink"])
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
                hb_lVars["ManaDrink"]=HealBot_Config_Buffs.BackupManaDrinkItem
                if not HealBot_BuffWatch[hb_lVars["ManaDrink"]] then
                    HealBot_Aura_SetBuffWatch(hb_lVars["ManaDrink"])
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
            hb_lVars["WellFed"]=HealBot_Config_Buffs.WellFedItem
            if not HealBot_BuffWatch[hb_lVars["WellFed"]] then
                HealBot_Aura_SetBuffWatch(hb_lVars["WellFed"])
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
                hb_lVars["WellFed"]=HealBot_Config_Buffs.BackupWellFedItem
                if not HealBot_BuffWatch[hb_lVars["WellFed"]] then
                    HealBot_Aura_SetBuffWatch(hb_lVars["WellFed"])
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

        if HEALBOT_GAME_VERSION<6 then
            
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
            elseif HEALBOT_GAME_VERSION<6 then
                HealBot_BuffNameTypes={
                    [(HealBot_WoWAPI_SpellName(HEALBOT_MARK_OF_THE_WILD) or "Mark of the Wild")]=HBC_STATS_ID,
                    [(HealBot_WoWAPI_SpellName(HBC_BLESSING_OF_KINGS) or "Blessing of Kings")]=HBC_STATS_ID,
                    [(HealBot_WoWAPI_SpellName(HEALBOT_LEGACY_EMPEROR) or "Legacy of the Emperor")]=HBC_STATS_ID,
                    [(HealBot_WoWAPI_SpellName(HBC_INNER_FIRE) or "Inner Fire")]=HBC_INNER_ID,
                    [(HealBot_WoWAPI_SpellName(HBC_INNER_WILL) or "Inner Will")]=HBC_INNER_ID,
                    [(HealBot_WoWAPI_SpellName(HEALBOT_POWER_WORD_FORTITUDE) or "Power Word: Fortitude")]=HBC_STAMINA_ID,
                    [(HealBot_WoWAPI_SpellName(HEALBOT_COMMANDING_SHOUT) or "Commanding Shout")]=HBC_STAMINA_ID,
                    [(HealBot_WoWAPI_SpellName(HEALBOT_DARK_INTENT) or "Dark Intent")]=HBC_STAMINA_ID,
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
            
            -- Legacy shield estimates depend on the client API, not Classic content.
            if HEALBOT_CLIENT_VERSION<3 then
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
            elseif HEALBOT_CLIENT_VERSION<6 then
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
