local LibDeflate = HealBot_Libs_LibC()
local hbLinkFrame=nil
local hbLinkFrameObjects={}
local hbLinkFrameText={}
local hbPostLinkFrame=nil
local hbPostLinkFrameObjects={}
local hbPostLinkFrameText={}
local Skin_TextData=""
local Debuffs_TextData=""
local Buffs_TextData=""
local Spells_TextData=""
local PresetCols_TextData=""
local linkData=""
local RequestQueue={}
local _
local shareType={[1]=HEALBOT_OPTIONS_SKIN,
                 [2]=HEALBOT_OPTIONS_TAB_CUSTOM_DEBUFFS,
                 [3]=HEALBOT_OPTIONS_TAB_CUSTOM_BUFFS,
                 [4]=HEALBOT_OPTIONS_TAB_SPELLS,
                 [5]=HEALBOT_OPTIONS_PRESET_COLOUR,}
local validType={[1]="Skin",
                 [2]="CustomDebuffs",
                 [3]="CustomBuffs_v8300",
                 [4]="Spells_v8202",
                 [5]="PresetCols"}
local linkChannelList={HEALBOT_WORD_PARTY,
                       HEALBOT_OPTIONS_EMERGENCYHEALS,
                       HEALBOT_WORD_GUILD,
                       HEALBOT_WORD_WHISPER,}
local HealBot_Share_luVars={}
HealBot_Share_luVars["InMethodSpell"]=2
HealBot_Share_luVars["InMethodBuff"]=2
HealBot_Share_luVars["InMethodDebuff"]=2
HealBot_Share_luVars["InOutSkin"]=1
HealBot_Share_luVars["validImport"]=1
HealBot_Share_luVars["LinkRequest"]=""
HealBot_Share_luVars["RequestReady"]=true
HealBot_Share_luVars["LastLinkRequest"]=0
HealBot_Share_luVars["PostChannel"]=1
HealBot_Share_luVars["PostWhisper"]=""

function HealBot_Share_setLuVars(vName, vValue)
    HealBot_Share_luVars[vName]=vValue
end

function HealBot_Share_retLuVars(vName)
    return HealBot_Share_luVars[vName]
end

function HealBot_Share_Compress(s)
    local compressed = LibDeflate:CompressDeflate(s, {level = 9})
    if compressed then
        local encoded = LibDeflate:EncodeForPrint(compressed)
        return encoded or s
    else
        return s
    end
end

function HealBot_Share_Decompress(s)
    local decoded = LibDeflate:DecodeForPrint(s)
    if decoded then
        local decompressed = LibDeflate:DecompressDeflate(decoded)
        return decompressed or s
    else
        return s
    end
end

local function HealBot_Comms_SendShareAddonMsg(msg, pName)
    C_ChatInfo.SendAddonMessage(HEALBOT_HEALBOT, msg, "WHISPER", pName);
end

local function HealBot_Share_ClearExportComplete(sType)
    local g
    if sType==HEALBOT_OPTIONS_SKIN then
        g=_G["HealBot_Options_ShareSkinStatusf"]
        g:SetText("")
        g=_G["HealBot_InOut_ShareSkins_Text"]
        g:SetText(HEALBOT_OPTIONS_SKINS_DISCORD)
    elseif sType==HEALBOT_OPTIONS_TAB_CUSTOM_DEBUFFS then
        g=_G["HealBot_Options_ShareCDbuffStatusf"]
        g:SetText("")
        g=_G["HealBot_InOut_ShareCDbuffs_Text"]
        g:SetText(HEALBOT_OPTIONS_CDEBUFFS_DISCORD)
    elseif sType==HEALBOT_OPTIONS_TAB_CUSTOM_BUFFS then
        g=_G["HealBot_Options_ShareBuffsStatusf"]
        g:SetText("")
        g=_G["HealBot_InOut_ShareBuffs_Text"]
        g:SetText(HEALBOT_OPTIONS_CBUFFS_DISCORD)
    elseif sType==HEALBOT_OPTIONS_TAB_SPELLS then
        g=_G["HealBot_Options_ShareSpellsStatusf"]
        g:SetText("")
        g=_G["HealBot_InOut_ShareSpells_Text"]
        g:SetText(HEALBOT_OPTIONS_SPELLS_DISCORD)
    elseif sType==HEALBOT_OPTIONS_CONTENT_INOUT_PRESETCOL then
        g=_G["HealBot_Options_SharePresetColsStatusf"]
        g:SetText("")
        g=_G["HealBot_InOut_SharePresetCols_Text"]
        g:SetText(HEALBOT_OPTIONS_PRECOLS_DISCORD)
    end
end

local function HealBot_Share_ExportComplete(sType, sExtra)
    local g
    local sText=""
    if sExtra then
        sText=" |cff77c8ff"..sType.." |cffffffff"..sExtra.." |cff77c8ff"..HEALBOT_SHARE_EXPORTED
    else
        sText=" |cff77c8ff"..sType.." "..HEALBOT_SHARE_EXPORTED
    end
    if sType==HEALBOT_OPTIONS_SKIN then
        g=_G["HealBot_Options_ShareSkinStatusf"]
        g:SetText(sText)
        g=_G["HealBot_InOut_ShareSkins_Text"]
        g:SetText("")
    elseif sType==HEALBOT_OPTIONS_TAB_CUSTOM_DEBUFFS then
        g=_G["HealBot_Options_ShareCDbuffStatusf"]
        g:SetText(sText)
        g=_G["HealBot_InOut_ShareCDbuffs_Text"]
        g:SetText("")
    elseif sType==HEALBOT_OPTIONS_TAB_CUSTOM_BUFFS then
        g=_G["HealBot_Options_ShareBuffsStatusf"]
        g:SetText(sText)
        g=_G["HealBot_InOut_ShareBuffs_Text"]
        g:SetText("")
    elseif sType==HEALBOT_OPTIONS_TAB_SPELLS then
        g=_G["HealBot_Options_ShareSpellsStatusf"]
        g:SetText(sText)
        g=_G["HealBot_InOut_ShareSpells_Text"]
        g:SetText("")
    elseif sType==HEALBOT_OPTIONS_CONTENT_INOUT_PRESETCOL then
        g=_G["HealBot_Options_SharePresetColsStatusf"]
        g:SetText(sText)
        g=_G["HealBot_InOut_SharePresetCols_Text"]
        g:SetText("")
    end
    C_Timer.After(15, function() HealBot_Share_ClearExportComplete(sType) end)
end

local function HealBot_Share_SendLinkRequest()
    HealBot_Comms_SendShareAddonMsg(HealBot_Share_luVars["LinkRequest"], HealBot_Share_luVars["LinkRequestPlayer"])
    hbLinkFrameObjects["YesBtn"]:Disable()
    hbLinkFrameObjects["NoBtn"]:Disable()
    HealBot_Share_luVars["LastLinkTimeOut"]=GetTime()
    C_Timer.After(2, HealBot_Share_TimeoutRequest)
end

local function HealBot_Share_CancelLinkRequest()
    HealBot_Share_luVars["LastLinkRequest"]=0
    HealBot_Share_LinkFrame_Hide()
end

local function HealBot_Share_ImportFail(import, reason)
    StaticPopupDialogs["HEALBOT_SHARE_IMPORTFAIL"] = {
        text = HEALBOT_OPTIONS_IMPORT_FAIL1.." "..import.."\n\n"..HEALBOT_OPTIONS_IMPORT_FAIL2.." "..reason,
        button1 = CLOSE,
        timeout = 0,
        whileDead = 1,
        hideOnEscape = 1
    };
    StaticPopup_Show("HEALBOT_SHARE_IMPORTFAIL");
end

function HealBot_Share_TimeoutRequest()
    if hbLinkFrame:IsVisible() then
        if HealBot_Share_luVars["LastLinkTimeOut"]+15<GetTime() then
            HealBot_Share_CancelLinkRequest()
        elseif HealBot_Share_luVars["LastLinkTimeOut"]+5<GetTime() and hbLinkFrameObjects["YesBtn"]:IsVisible() then
            hbLinkFrameObjects["YesBtn"]:Hide()
            hbLinkFrameObjects["NoBtn"]:Hide()
            hbLinkFrameObjects["CloseBtn"]:Show()
            if not HealBot_Share_luVars["TransferComplete"] then
                HealBot_Share_ImportFail(shareType[HealBot_Share_luVars["RequestType"]], "Lost connection")
            end
        end
        C_Timer.After(1, HealBot_Share_TimeoutRequest)
    end
end

local function HealBot_Share_ThrottleLinkRequest()
    StaticPopupDialogs["HEALBOT_SHARE_DENYLINKREQUEST"] = {
        text = HEALBOT_OPTIONS_LINK_REQUEST_DENIED,
        button1 = OKAY,
        timeout = 0,
        whileDead = 1,
        hideOnEscape = 1
    };
    StaticPopup_Show("HEALBOT_SHARE_DENYLINKREQUEST");
end

function HealBot_Share_GetLink(sType, uName, eInfo)
    if sType>0 then
        if uName then
            if not eInfo then 
                HealBot_Share_luVars["LinkRequest"]="L:R~"..sType
            else
                HealBot_Share_luVars["LinkRequest"]="L:R~"..sType.."~"..eInfo
            end
            HealBot_Share_luVars["LinkRequestPlayer"]=uName
            if HealBot_Share_luVars["LastLinkRequest"]>GetTime() then
                HealBot_Share_ThrottleLinkRequest()
            else
                HealBot_Share_luVars["LastLinkRequest"]=GetTime()+30
                HealBot_Share_luVars["RequestType"]=sType
                HealBot_Share_luVars["RequestName"]=uName
                HealBot_Share_ShowLinkFrame()
                HealBot_Share_LinkFrame_SetRequestText(sType, uName, eInfo)
            end
        end
    end
end
hooksecurefunc("SetItemRef", function(link, text)
    if link=="garrmission:healbot" then
        local _, encoded=strsplit("~", text)
        local s=HealBot_Share_Decompress(encoded)
        HealBot_AddDebug("link="..(link or "nil"), "Share", true)
        HealBot_AddDebug("text="..(text or "nil"), "Share", true)
        HealBot_AddDebug("encoded="..(encoded or "nil"), "Share", true)
        HealBot_AddDebug("s="..(s or "nil"), "Share", true)
        local _, sType, uName, eInfo=strsplit("~", s)
        sType=tonumber(sType or 0)
        return HealBot_Share_GetLink(sType, uName, eInfo)
    end
end)

local function HealBot_Share_DoImportValid()
    if HealBot_Share_luVars["validImport"]==1 then
        HealBot_Share_SkinLoad(Skin_TextData)
    elseif HealBot_Share_luVars["validImport"]==2 then
        HealBot_Share_LoadDebuffs(Debuffs_TextData)
    elseif HealBot_Share_luVars["validImport"]==3 then
        HealBot_Share_LoadBuffs(Buffs_TextData)
    elseif HealBot_Share_luVars["validImport"]==4 then
        HealBot_Share_LoadSpells(Spells_TextData)
    elseif HealBot_Share_luVars["validImport"]==5 then
        HealBot_Share_LoadPresetCols(PresetCols_TextData)
    end
end

local function HealBot_Share_ImportValid(importType)
    StaticPopupDialogs["HEALBOT_SHARE_IMPORTVALID"] = {
        text = HEALBOT_OPTIONS_IMPORT_VALID1.."\n\n"..importType..HEALBOT_OPTIONS_IMPORT_VALID2,
        button1 = HEALBOT_WORDS_YES,
        button2 = HEALBOT_WORDS_NO,
        OnAccept = function()
            HealBot_Share_DoImportValid()
        end,
        timeout = 0,
        whileDead = 1,
        hideOnEscape = 1
    };
    StaticPopup_Show("HEALBOT_SHARE_IMPORTVALID");
end

function HealBot_Share_ValidateData(sType, sIn)
    local sStr=HealBot_Share_Decompress(sIn)
    local id=nil
    local extra=nil
    for l in string.gmatch(sStr, "[^\n]+") do
        local t=(string.gsub(l, "^%s*(.-)%s*$", "%1"))
        if string.len(t)>1 and not id then
            if string.len(t)>40 then
                id="Invalid string, unable to decompress"
            else
                id=t
            end
        elseif string.len(t)>1  then
            if sType==1 then extra=t end
            break
        end
    end
    if not id or id~=validType[sType] then
        HealBot_Share_ImportFail(shareType[sType], "Incorrect Header\n\nExpecting: "..validType[sType].."\nReceived: "..(id or ""))
    else
        HealBot_Share_luVars["validImport"]=sType
        local vInfo=shareType[sType]
        if extra then vInfo=extra.." "..vInfo end
        HealBot_Share_ImportValid(vInfo)
    end
end

-- Preset Colours
function HealBot_Share_ExportPresetCols(lData)
    local ssStr=validType[5].."\n"
    for x=1,10 do
        local alias=HealBot_Globals.PresetColoursAlias[x] or ""
        if strlen(alias)<1 then alias=HEALBOT_OPTIONS_PRESET.." "..x end
        ssStr=ssStr..alias.."~"
        ssStr=ssStr..HealBot_Globals.PresetColours[x]["R"]..","
        ssStr=ssStr..HealBot_Globals.PresetColours[x]["G"]..","
        ssStr=ssStr..HealBot_Globals.PresetColours[x]["B"]..","
        ssStr=ssStr..HealBot_Globals.PresetColours[x]["A"].."\n"
    end
    if lData or HealBot_Globals.CompressExport then
        ssStr=HealBot_Share_Compress(ssStr)
    end
    if lData then
        HealBot_Share_ProcessLinkData(ssStr)
    else
        HealBot_Options_SharePresetColsExternalEditBox:SetText(ssStr)
    end
    HealBot_Share_ExportComplete(HEALBOT_OPTIONS_CONTENT_INOUT_PRESETCOL)
end

function HealBot_Share_ExportPresetCols_OnClick()
    HealBot_Share_ExportPresetCols()
end

function HealBot_Share_LoadPresetCols(sIn)
    local sStr=HealBot_Share_Decompress(sIn)
    local ssTab={}
    local i=0
    for l in string.gmatch(sStr, "[^\n]+") do
        local t=(string.gsub(l, "^%s*(.-)%s*$", "%1"))
        if string.len(t)>1 then
            i=i+1
            ssTab[i]=t
        end
    end
    
    -- Test~0.2,0.2,0.902,1
    for e=2,#ssTab do 
        local x=e-1
        if x>10 then break end
        local alias,d = string.split("~", ssTab[e])
        local r,g,b,a=string.split(",", d)
        if not alias or not r or not g or not b or not a then
            HealBot_Options_ImportFail("Preset Colours", "Data corruption")
        else
            HealBot_Globals.PresetColoursAlias[x]=alias
            HealBot_Globals.PresetColours[x]["R"]=tonumber(r)
            HealBot_Globals.PresetColours[x]["G"]=tonumber(g)
            HealBot_Globals.PresetColours[x]["B"]=tonumber(b)
            HealBot_Globals.PresetColours[x]["A"]=tonumber(a)
        end
    end
    HealBot_Timers_InitExtraOptions()
end

function HealBot_Share_ImportPresetCols_OnClick()
    PresetCols_TextData=HealBot_Options_SharePresetColsExternalEditBox:GetText()
    HealBot_Share_ValidateData(5, PresetCols_TextData)
end

-- Spells
function HealBot_Share_ExportSpells(lData)
    local ssStr=validType[4].."\n"
    local sName, sTar, sTrin1, sTrin2, AvoidBC, HB_button, HB_combo_prefix, sText, sId=nil,nil,nil,nil,nil,nil,nil,nil,nil
    local HealBot_Keys_List=HealBot_Action_retComboKeysList()
    for z=1,4 do
        for x=1,20 do
            HB_button = HealBot_Options_ComboClass_Button(x)
            -- Menu~1,1,7~2,4,false,false,false,false,
            for y=1, getn(HealBot_Keys_List), 1 do
                HB_combo_prefix = HealBot_Action_GetComboSpec(HealBot_Keys_List[y], HB_button)
                if z==1 then
                    sName, sTar, sTrin1, sTrin2, AvoidBC = HealBot_Action_AttribSpellPattern(HB_combo_prefix)
                    sText = HealBot_Config_Spells.EnabledKeyCombo[HB_combo_prefix]
                elseif z==2 then
                    sName, sTar, sTrin1, sTrin2, AvoidBC = HealBot_Action_AttribEnemySpellPattern(HB_combo_prefix)
                    sText = HealBot_Config_Spells.EnemyKeyCombo[HB_combo_prefix]
                elseif z==3 then
                    sName, sTar, sTrin1, sTrin2, AvoidBC = HealBot_Action_AttribEmergSpellPattern(HB_combo_prefix)
                    sText = HealBot_Config_Spells.EmergKeyCombo[HB_combo_prefix]
                else
                    sName, sTar, sTrin1, sTrin2, AvoidBC = HealBot_Action_AttribIconSpellPattern(HB_combo_prefix)
                    sText = HealBot_Globals.IconKeyCombo[HB_combo_prefix]
                end
                if sName and strlen(sName)>1 then
                    ssStr=ssStr..sName.."~"..z..","..x..","..y.."~"..sText..","
                    if sTar then
                        ssStr=ssStr.."true,"
                    else
                        ssStr=ssStr.."false,"
                    end
                    if sTrin1 then
                        ssStr=ssStr.."true,"
                    else
                        ssStr=ssStr.."false,"
                    end
                    if sTrin2 then
                        ssStr=ssStr.."true,"
                    else
                        ssStr=ssStr.."false,"
                    end
                    if AvoidBC then
                        ssStr=ssStr.."true,"
                    else
                        ssStr=ssStr.."false,"
                    end
                    ssStr=ssStr.."\n"
                end
            end
        end
    end
    if lData or HealBot_Globals.CompressExport then
        ssStr=HealBot_Share_Compress(ssStr)
    end
    if lData then
        HealBot_Share_ProcessLinkData(ssStr)
    else
        HealBot_Options_ShareSpellsExternalEditBox:SetText(ssStr)
    end
    HealBot_Share_ExportComplete(HEALBOT_OPTIONS_TAB_SPELLS)
end

function HealBot_Share_ExportSpells_OnClick()
    HealBot_Share_ExportSpells()
end

function HealBot_Share_LoadSpells(sIn)
    local sStr=HealBot_Share_Decompress(sIn)
    local ssTab={}
    local i=0
    local HealBot_Keys_List=HealBot_Action_retComboKeysList()
    HealBot_Action_ClearSpellCache()
    for l in string.gmatch(sStr, "[^\n]+") do
        local t=(string.gsub(l, "^%s*(.-)%s*$", "%1"))
        if string.len(t)>1 then
            i=i+1
            ssTab[i]=t
        end
    end
    if HealBot_Share_luVars["InMethodSpell"]==1 then
        HealBot_Config_Spells.EnabledKeyCombo = {}
        HealBot_Config_Spells.EnemyKeyCombo = {}
        HealBot_Config_Spells.EmergKeyCombo = {}
    end
    
    -- Flash Heal~1,1,1~1,2061,false,true,true,false,
    for e=2,#ssTab do 
        local _,c,d = string.split("~", ssTab[e])
        local ActionBarsCombo,Buttons_Button,KeyPress=string.split(",", c)
        local sName,sTar,sTrin1,sTrin2,AvoidBC=string.split(",", d)
        if not ActionBarsCombo or not Buttons_Button or not KeyPress or not sName then
            HealBot_Options_ImportFail("Spells", "Data corruption")
        else
            ActionBarsCombo=tonumber(ActionBarsCombo)
            Buttons_Button=tonumber(Buttons_Button)
            KeyPress=tonumber(KeyPress)
            local cType="ICON"
            if ActionBarsCombo==1 then
                cType = "ENABLED"
            elseif ActionBarsCombo==2 then
                cType = "ENEMY"
            elseif ActionBarsCombo==3 then
                cType = "EMERG"
            end
            local button = HealBot_Options_ComboClass_Button(Buttons_Button)
            local cText=HealBot_Action_GetSpell(cType, HealBot_Action_GetComboSpec(HealBot_Keys_List[KeyPress], button))
            if not cText or (cText and strlen(cText)<2) or HealBot_Share_luVars["InMethodSpell"]<3 then
                HealBot_Action_SetSpell(cType, HealBot_Action_GetComboSpec(HealBot_Keys_List[KeyPress], button), sName)
                HealBot_Options_KnownSpellCheck(nil, sName,cType,HealBot_Keys_List[KeyPress],Buttons_Button)
                HealBot_SpellAutoButton_Update("Target", HealBot_Keys_List[KeyPress], ActionBarsCombo, Buttons_Button, sTar)
                HealBot_SpellAutoButton_Update("Trinket1", HealBot_Keys_List[KeyPress], ActionBarsCombo, Buttons_Button, sTrin1)
                HealBot_SpellAutoButton_Update("Trinket2", HealBot_Keys_List[KeyPress], ActionBarsCombo, Buttons_Button, sTrin2)
                HealBot_SpellAutoButton_Update("AvoidBC", HealBot_Keys_List[KeyPress], ActionBarsCombo, Buttons_Button, AvoidBC)
            end
        end
    end
    HealBot_Options_SaveProfile()
    HealBot_Timers_InitExtraOptions()
    HealBot_Options_ComboClass_Text()
    HealBot_Timers_Set("INIT","PrepSetAllAttribs")
end

function HealBot_Share_ImportSpells_OnClick()
    Spells_TextData=HealBot_Options_ShareSpellsExternalEditBox:GetText()
    HealBot_Share_ValidateData(4, Spells_TextData)
end

-- Buffs
function HealBot_Share_ExportBuffs(lData)
    local ssStr=validType[3].."\n"
    local hbClassHoTwatch=HealBot_Globals.WatchHoT
    for xClass,_  in pairs(hbClassHoTwatch) do
        local HealBot_configClassHoTClass=HealBot_Globals.WatchHoT[xClass]
        for bId,x  in pairs(HealBot_configClassHoTClass) do
            ssStr=ssStr..(GetSpellInfo(bId) or HEALBOT_WORDS_UNKNOWN).."~"
            ssStr=ssStr..xClass.."~"
            if not HealBot_Globals.HealBot_Custom_Buffs_ShowBarCol[bId] then
                HealBot_Globals.HealBot_Custom_Buffs_ShowBarCol[bId]=1
            elseif HealBot_Globals.HealBot_Custom_Buffs_ShowBarCol[bId]==true then
                HealBot_Globals.HealBot_Custom_Buffs_ShowBarCol[bId]=3
            end
            ssStr=ssStr..bId..","..(HealBot_Globals.HealBot_Custom_Buffs[bId] or 0)..","..x..","..HealBot_Globals.HealBot_Custom_Buffs_ShowBarCol[bId]..","
            if HealBot_Globals.CustomBuffBarColour[bId] then
                ssStr=ssStr..(HealBot_Globals.CustomBuffBarColour[bId]["R"] or 0.25)..","
                ssStr=ssStr..(HealBot_Globals.CustomBuffBarColour[bId]["G"] or 0.58)..","
                ssStr=ssStr..(HealBot_Globals.CustomBuffBarColour[bId]["B"] or 0.8)..","
            else
                ssStr=ssStr..",,,"
            end
            ssStr=ssStr..(HealBot_Globals.CustomBuffIDMethod[bId] or 3).."," 
            if HealBot_Globals.CustomBuffTag[bId] then
                ssStr=ssStr..HealBot_Globals.CustomBuffTag[bId]..","
            else
                ssStr=ssStr..","
            end
            ssStr=ssStr..(HealBot_Globals.HealBot_Custom_Buffs_IconSet[bId] or 1).."," 
            ssStr=ssStr..(HealBot_Globals.HealBot_Custom_Buffs_IconGlow[bId] or 1).."," 
            if HealBot_Globals.IgnoreCustomBuff[bId] then
                for instName, _ in pairs(HealBot_Globals.IgnoreCustomBuff[bId]) do
                    ssStr=ssStr..(instName)..","
                end
            end
            ssStr=ssStr..",,,\n"
        end
    end
    if lData or HealBot_Globals.CompressExport then
        ssStr=HealBot_Share_Compress(ssStr)
    end
    if lData then
        HealBot_Share_ProcessLinkData(ssStr)
    else
        HealBot_Options_ShareBuffsExternalEditBox:SetText(ssStr)
    end
    HealBot_Share_ExportComplete(HEALBOT_OPTIONS_TAB_CUSTOM_BUFFS)
end

function HealBot_Share_ExportBuffs_OnClick()
    HealBot_Share_ExportBuffs()
end

local customBuffPriority=HEALBOT_CUSTOM_en.."Buff"
function HealBot_Share_LoadBuffs(sIn)
    local scbStr=HealBot_Share_Decompress(sIn)
    local ssTab={}
    local i=0
    for l in string.gmatch(scbStr, "[^\n]+") do
        local t=(string.gsub(l, "^%s*(.-)%s*$", "%1"))
        if string.len(t)>1 then
            i=i+1
            ssTab[i]=t
        end
    end
    
    if HealBot_Share_luVars["InMethodBuff"]==1 then
        HealBot_Share_luVars["custombufftextpage"]=1
        HealBot_Globals.WatchHoT={ ["DRUI"]={}, ["HUNT"]={}, ["MAGE"]={}, ["PALA"]={}, ["PRIE"]={}, ["ROGU"]={}, ["SHAM"]={},
                                   ["WARL"]={}, ["WARR"]={}, ["DEAT"]={}, ["DEMO"]={}, ["MONK"]={}, ["EVOK"]={}, ["ALL"]={} }
        HealBot_Globals.HealBot_Custom_Buffs={}
        HealBot_Globals.HealBot_Custom_Buffs_ShowBarCol={}
        HealBot_Globals.CustomBuffIDMethod={}
        HealBot_Globals.HealBot_Custom_Buffs_IconSet={}
        HealBot_Globals.HealBot_Custom_Buffs_IconGlow={}
        local r=HealBot_Globals.CustomBuffBarColour[customBuffPriority]["R"]
        local g=HealBot_Globals.CustomBuffBarColour[customBuffPriority]["G"]
        local b=HealBot_Globals.CustomBuffBarColour[customBuffPriority]["B"]
        HealBot_Globals.CustomBuffBarColour={ [customBuffPriority] = { ["R"] = r, ["G"] = g, ["B"] = b, }, }
        HealBot_Globals.IgnoreCustomBuff={}
    end
    for e=2,#ssTab do 
        local _,c,d = string.split("~", ssTab[e])
        local bId,prio,filter,show,r,g,b,idMethod,tag,iconSet,iconGlow,i1,i2,i3,i4=string.split(",", d)
        if not c or not bId or not prio or not filter or not show or not r or not g or not b then
            HealBot_Options_ImportFail("Buffs", "Data corruption - ensure it is exactly as the original file")
        else
            bId=tonumber(bId) or bId
            prio=tonumber(prio)
            filter=tonumber(filter)
            r=tonumber(r)
            g=tonumber(g)
            b=tonumber(b)
            idMethod=tonumber(idMethod) or 3
            iconSet=tonumber(iconSet) or 1
            iconGlow=tonumber(iconGlow) or 1
            if not HealBot_Globals.WatchHoT[c][bId] or HealBot_Share_luVars["InMethodBuff"]<3 then
                local bName=GetSpellInfo(bId) or bId
                HealBot_Globals.WatchHoT[c][bId]=filter
                if prio>0 then 
                    HealBot_Globals.HealBot_Custom_Buffs[bId]=prio 
                    if bName then HealBot_Globals.HealBot_Custom_Buffs[bName]=prio end
                end
                if show=="true" then 
                    HealBot_Globals.HealBot_Custom_Buffs_ShowBarCol[bId]=3
                    if bName then HealBot_Globals.HealBot_Custom_Buffs_ShowBarCol[bName]=3 end
                elseif show=="false" then 
                    HealBot_Globals.HealBot_Custom_Buffs_ShowBarCol[bId]=1
                    if bName then HealBot_Globals.HealBot_Custom_Buffs_ShowBarCol[bName]=1 end
                else
                    HealBot_Globals.HealBot_Custom_Buffs_ShowBarCol[bId]=tonumber(show) or 1
                    if bName then HealBot_Globals.HealBot_Custom_Buffs_ShowBarCol[bName]=tonumber(show) or 1 end
                end
                if r then
                    HealBot_Globals.CustomBuffBarColour[bId]={}
                    HealBot_Globals.CustomBuffBarColour[bId]["R"]=r
                    HealBot_Globals.CustomBuffBarColour[bId]["G"]=g
                    HealBot_Globals.CustomBuffBarColour[bId]["B"]=b
                elseif HealBot_Globals.CustomBuffBarColour[bId] then
                    HealBot_Globals.CustomBuffBarColour[bId]=nil
                end
                if idMethod>0 and idMethod<3 then
                    HealBot_Globals.CustomBuffIDMethod[bId]=idMethod
                end
                HealBot_Globals.CustomBuffTag[bId]=tag
                if iconSet>1 then
                    HealBot_Globals.HealBot_Custom_Buffs_IconSet[bId]=iconSet
                end
                if iconGlow>1 then
                    HealBot_Globals.HealBot_Custom_Buffs_IconGlow[bId]=iconGlow
                end
                if string.len(i1 or "")>0 then 
                    if not HealBot_Globals.IgnoreCustomBuff[bId] then HealBot_Globals.IgnoreCustomBuff[bId]={} end
                    HealBot_Globals.IgnoreCustomBuff[bId][i1]=true 
                end
                if string.len(i2 or "")>0 then
                    HealBot_Globals.IgnoreCustomBuff[bId][i2]=true 
                end
                if string.len(i3 or "")>0 then
                    HealBot_Globals.IgnoreCustomBuff[bId][i3]=true 
                end
                if string.len(i4 or "")>0 then
                    HealBot_Globals.IgnoreCustomBuff[bId][i4]=true 
                end
                if bName and HealBot_Globals.IgnoreCustomBuff[bId] then 
                    HealBot_Globals.IgnoreCustomBuff[bName]=HealBot_Options_copyTable(HealBot_Globals.IgnoreCustomBuff[bId])
                end
            end
        end
    end
    HealBot_Timers_InitExtraOptions()
    HealBot_Timers_Set("AURA","ConfigClassHoT")
    HealBot_Timers_Set("AURA","CustomBuffListPrep")
end

function HealBot_Share_ImportBuffs_OnClick()
    Buffs_TextData=HealBot_Options_ShareBuffsExternalEditBox:GetText()
    HealBot_Share_ValidateData(3, Buffs_TextData)
end

-- Debuffs
function HealBot_Share_ExportDebuffs(lData)
    local ssStr=validType[2].."\n"
    for dId, x in pairs(HealBot_Globals.HealBot_Custom_Debuffs) do
        if (HealBot_Globals.Custom_Debuff_Categories[dId] or 10)>1 then
            ssStr=ssStr..(GetSpellInfo(dId) or HEALBOT_WORDS_UNKNOWN).."~"
            ssStr=ssStr..(HealBot_Globals.Custom_Debuff_Categories[dId] or 10).."~"
            if not HealBot_Globals.HealBot_Custom_Debuffs_ShowBarCol[dId] then
                HealBot_Globals.HealBot_Custom_Debuffs_ShowBarCol[dId]=1
            elseif HealBot_Globals.HealBot_Custom_Debuffs_ShowBarCol[dId]==true then
                HealBot_Globals.HealBot_Custom_Debuffs_ShowBarCol[dId]=3
            end                
            ssStr=ssStr..dId..","..x..","..(HealBot_Globals.FilterCustomDebuff[dId] or "")..","..HealBot_Globals.HealBot_Custom_Debuffs_ShowBarCol[dId]..","
            if HealBot_Globals.CDCBarColour[dId] then
                ssStr=ssStr..(HealBot_Globals.CDCBarColour[dId]["R"] or 0.8)..","
                ssStr=ssStr..(HealBot_Globals.CDCBarColour[dId]["G"] or 0.2)..","
                ssStr=ssStr..(HealBot_Globals.CDCBarColour[dId]["B"] or 0.2)..","
            else
                ssStr=ssStr..",,,"
            end
            ssStr=ssStr..(HealBot_Globals.CustomDebuffIDMethod[dId] or 3)..","
            if HealBot_Globals.CDCTag[dId] then
                ssStr=ssStr..HealBot_Globals.CDCTag[dId]..","
            else
                ssStr=ssStr..","
            end
            ssStr=ssStr..(HealBot_Globals.HealBot_Custom_Debuffs_IconSet[dId] or 1)..","
            ssStr=ssStr..(HealBot_Globals.HealBot_Custom_Debuffs_IconGlow[dId] or 1)..","
            if HealBot_Globals.IgnoreCustomDebuff[dId] then
                for instName, _ in pairs(HealBot_Globals.IgnoreCustomDebuff[dId]) do
                    ssStr=ssStr..(instName)..","
                end
            end
            ssStr=ssStr..",,,\n"
        end
    end
    if lData or HealBot_Globals.CompressExport then
        ssStr=HealBot_Share_Compress(ssStr)
    end
    if lData then
        HealBot_Share_ProcessLinkData(ssStr)
    else
        HealBot_Options_ShareCDebuffExternalEditBox:SetText(ssStr)
    end
    HealBot_Share_ExportComplete(HEALBOT_OPTIONS_TAB_CUSTOM_DEBUFFS)
end

function HealBot_Share_ExportDebuffs_OnClick()
    HealBot_Share_ExportDebuffs()
end

local customDebuffPriority=HEALBOT_CUSTOM_en.."15"
function HealBot_Share_LoadDebuffs(sIn)
    local scdStr=HealBot_Share_Decompress(sIn)
    local ssTab={}
    local i=0
    for l in string.gmatch(scdStr, "[^\n]+") do
        local t=(string.gsub(l, "^%s*(.-)%s*$", "%1"))
        if string.len(t)>1 then
            i=i+1
            ssTab[i]=t
        end
    end

    if HealBot_Share_luVars["InMethodDebuff"]==1 then
        HealBot_Share_luVars["customdebufftextpage"]=1
        HealBot_Globals.Custom_Debuff_Categories={ [HEALBOT_CUSTOM_CAT_CUSTOM_AUTOMATIC]  = 1, }
        HealBot_Globals.HealBot_Custom_Debuffs={ [HEALBOT_CUSTOM_CAT_CUSTOM_AUTOMATIC]     = 15, }
        HealBot_Globals.FilterCustomDebuff={}
        HealBot_Globals.CustomDebuffIDMethod={}
        HealBot_Globals.HealBot_Custom_Debuffs_IconSet={}
        HealBot_Globals.HealBot_Custom_Debuffs_IconGlow={}
        HealBot_Globals.HealBot_Custom_Debuffs_ShowBarCol={}
        HealBot_Globals.HealBot_Custom_Debuffs_ShowBarCol[HEALBOT_CUSTOM_CAT_CUSTOM_AUTOMATIC]=4
        local r=HealBot_Globals.CDCBarColour[customDebuffPriority]["R"]
        local g=HealBot_Globals.CDCBarColour[customDebuffPriority]["G"]
        local b=HealBot_Globals.CDCBarColour[customDebuffPriority]["B"]
        HealBot_Globals.CDCBarColour={ [customDebuffPriority] = { ["R"] = r, ["G"] = g, ["B"] = b, }, }
        HealBot_Globals.IgnoreCustomDebuff={}
    end
    for e=2,#ssTab do 
        local _,c,d = string.split("~", ssTab[e])
        local dId,prio,filter,show,r,g,b,idMethod,tag,iconSet,iconGlow,i1,i2,i3,i4=string.split(",", d)
        if not c or not dId or not prio or not filter or not show or not r or not g or not b then
            HealBot_Options_ImportFail("Debuffs", "Data corruption - ensure it is exactly as the original file")
        else
            c=tonumber(c)
            dId=tonumber(dId) or dId
            prio=tonumber(prio)
            filter=tonumber(filter)
            r=tonumber(r)
            g=tonumber(g)
            b=tonumber(b)
            idMethod=tonumber(idMethod) or 3
            iconSet=tonumber(iconSet) or 1
            iconGlow=tonumber(iconGlow) or 1
            if not HealBot_Globals.HealBot_Custom_Debuffs[dId] or HealBot_Share_luVars["InMethodDebuff"]<3 then
                local dName=GetSpellInfo(dId) or dId
                HealBot_Globals.Custom_Debuff_Categories[dId]=c
                HealBot_Globals.HealBot_Custom_Debuffs[dId]=prio
                if filter then HealBot_Globals.FilterCustomDebuff[dId]=filter end
                if show=="true" then
                    HealBot_Globals.HealBot_Custom_Debuffs_ShowBarCol[dId]=3
                elseif show=="false" then
                    HealBot_Globals.HealBot_Custom_Debuffs_ShowBarCol[dId]=1
                else
                    HealBot_Globals.HealBot_Custom_Debuffs_ShowBarCol[dId]=tonumber(show) or 1
                end
                if r then
                    HealBot_Globals.CDCBarColour[dId]={}
                    HealBot_Globals.CDCBarColour[dId]["R"]=r
                    HealBot_Globals.CDCBarColour[dId]["G"]=g
                    HealBot_Globals.CDCBarColour[dId]["B"]=b
                elseif HealBot_Globals.CDCBarColour[dId] then
                    HealBot_Globals.CDCBarColour[dId]=nil
                end
                if idMethod>0 and idMethod<3 then
                    HealBot_Globals.CustomDebuffIDMethod[dId]=idMethod
                end
                if iconSet>1 then
                    HealBot_Globals.HealBot_Custom_Debuffs_IconSet[dId]=iconSet
                end
                if iconGlow>1 then
                    HealBot_Globals.HealBot_Custom_Debuffs_IconGlow[dId]=iconGlow
                end
                HealBot_Globals.CDCTag[dId]=tag
                if string.len(i1 or "")>0 then 
                    if not HealBot_Globals.IgnoreCustomDebuff[dId] then HealBot_Globals.IgnoreCustomDebuff[dId]={} end
                    HealBot_Globals.IgnoreCustomDebuff[dId][i1]=true 
                end
                if string.len(i2 or "")>0 then
                    HealBot_Globals.IgnoreCustomDebuff[dId][i2]=true 
                end
                if string.len(i3 or "")>0 then
                    HealBot_Globals.IgnoreCustomDebuff[dId][i3]=true 
                end
                if string.len(i4 or "")>0 then
                    HealBot_Globals.IgnoreCustomDebuff[dId][i4]=true 
                end
            end
        end
    end
    HealBot_Timers_InitExtraOptions()
    HealBot_Aura_ClearCustomDebuffsDone()
    HealBot_Timers_Set("AURA","CustomDebuffList")
    HealBot_Timers_Set("AURA","ConfigDebuffs")
end

function HealBot_Share_ImportDebuffs_OnClick()
    Debuffs_TextData=HealBot_Options_ShareCDebuffExternalEditBox:GetText()
    HealBot_Share_ValidateData(2, Debuffs_TextData)
end
-- Skins
local AuxLookupClassic={[0]={[1]="None",
                             [2]="Absorb",
                             [3]="InHeals",
                             [4]="Power",
                             [5]="Aggro",
                             [6]="Threat",
                             [7]="Overheal",
                             [8]="Highlight",
                             [9]="Buff",
                            [10]="Debuff",
                            [11]="Cast",
                            [12]="Target",
                            [13]="OOR",
                            [14]="Range30",
                            [15]="RecentHeals",
                            [16]="Res",
                            [17]="HlthDrop",
                            [18]="Name",
                            [19]="Hlth",
                            [20]="State",},
                        [8]={[1]="None",
                             [2]="Absorb",
                             [3]="InHeals",
                             [4]="Power",
                             [5]="Aggro",
                             [6]="Threat",
                             [7]="Overheal",
                             [8]="Highlight",
                             [9]="Buff",
                            [10]="Debuff",
                            [11]="OOR",
                            [12]="Range30",
                            [13]="HlthDrop",
                            [14]="Name",
                            [15]="Hlth",
                            [16]="State",},
                       [10]={[1]="None",
                             [2]="Absorb",
                             [3]="InHeals",
                             [4]="Power",
                             [5]="Cast",
                             [6]="OOR",
                             [7]="Range30",
                             [8]="HlthDrop",
                             [9]="Name",
                            [10]="Hlth",
                            [11]="State",}
                       }
local AuxLookupRetail={[0]={[1]="None",
                            [2]="Absorb",
                            [3]="InHeals",
                            [4]="Power",
                            [5]="Aggro",
                            [6]="Threat",
                            [7]="Overheal",
                            [8]="Highlight",
                            [9]="Buff",
                           [10]="Debuff",
                           [11]="Cast",
                           [12]="Target",
                           [13]="OOR",
                           [14]="Range30",
                           [15]="RecentHeals",
                           [16]="Res",
                           [17]="Summon",
                           [18]="HlthDrop",
                           [19]="Name",
                           [20]="Hlth",
                           [21]="State",},
                       [8]={[1]="None",
                            [2]="Absorb",
                            [3]="InHeals",
                            [4]="Power",
                            [5]="Aggro",
                            [6]="Threat",
                            [7]="Overheal",
                            [8]="Highlight",
                            [9]="Buff",
                           [10]="Debuff",
                           [11]="OOR",
                           [12]="Range30",
                           [13]="HlthDrop",
                           [14]="Name",
                           [15]="Hlth",
                           [16]="State",},
                      [10]={[1]="None",
                            [2]="Absorb",
                            [3]="InHeals",
                            [4]="Power",
                            [5]="Cast",
                            [6]="OOR",
                            [7]="Range30",
                            [8]="HlthDrop",
                            [9]="Name",
                           [10]="Hlth",
                           [11]="State",}
                      }
function HealBot_Share_SkinDecodeAux(dat, frame)
    if frame<8 then 
        frame=0
    elseif frame<10 then
        frame=8
    end
    if HEALBOT_GAME_VERSION<4 then
        for j=1, getn(AuxLookupClassic[frame]), 1 do
            if AuxLookupClassic[frame][j]==dat then
                dat=j
                break
            end
        end
    else
        for j=1, getn(AuxLookupRetail[frame]), 1 do
            if AuxLookupRetail[frame][j]==dat then
                dat=j
                break
            end
        end
    end
    if type(dat)=="string" then dat=1 end
    return dat
end

function HealBot_Share_SkinEncodeAux(dat, frame)
    if frame<8 then 
        frame=0
    elseif frame<10 then
        frame=8
    end
    if HEALBOT_GAME_VERSION<4 then
        dat=AuxLookupClassic[frame][dat] or dat
    else
        dat=AuxLookupRetail[frame][dat] or dat
    end
    return dat
end

local ssData=""
function HealBot_Share_BuildSkinData(cmd, msg, lData)
    if cmd=="Init" then
        HealBot_Share_ExportComplete(HEALBOT_OPTIONS_SKIN, msg)
        if tonumber(msg) then msg=UnitName("player").."-"..msg end
        if msg==HEALBOT_SKINS_STD then msg=UnitName("player").."-"..HEALBOT_SKINS_STD end
        ssData=validType[1].."\n"..msg
    elseif cmd and msg then
        ssData=ssData.."\n"..cmd.."!"..msg
        if cmd=="Complete" then
            if lData or HealBot_Globals.CompressExport then
                ssData=HealBot_Share_Compress(ssData)
            end
            if lData then
                HealBot_Share_ProcessLinkData(ssData)
            else
                HealBot_Options_ShareExternalEditBox:SetText(ssData)
            end
        end
    end
end

local function HealBot_Share_ExportSkinFrames(skinName, varName, varNameAppend)
    local dups=""
    local p={}
    local tabStr=""
    local tmpTab={}
    for i=1,10 do
        if varName=="AuxBar" then
            tmpTab=HealBot_Options_copyTable(Healbot_Config_Skins[varName][skinName][varNameAppend][i])
            tmpTab["USE"]=HealBot_Share_SkinEncodeAux(tmpTab["USE"], i)
            tabStr=HealBot_Options_tab2str(tmpTab)
        elseif varName=="AuxBarText" then
            tabStr=HealBot_Options_tab2str(Healbot_Config_Skins[varName][skinName][varNameAppend][i])
        elseif varName=="IconSets" then
            tabStr=HealBot_Options_tab2str(Healbot_Config_Skins[varName][skinName][i][varNameAppend])
        elseif varName=="IconSetsText" then
            tabStr=HealBot_Options_tab2str(Healbot_Config_Skins[varName][skinName][i][varNameAppend])
        else
            tabStr=HealBot_Options_tab2str(Healbot_Config_Skins[varName][skinName][i])
        end
        local isDup=true
        local lMsg=strsub(tabStr,2,string.len(tabStr)-1)
        local d={}
        d=HealBot_Options_StringSplit(lMsg, ",")
        for j=1,getn(d) do
            local var, dat=string.split("=", d[j])
            if tonumber(dat) then dat=tonumber(dat) end
            if not p[var] then p[var]="" end
            if p[var]~=dat then
                p[var]=dat
                isDup=false
            end
        end
        if isDup then
            dups=dups..i.."~"
            if i==10 then
                if varNameAppend then 
                    HealBot_Share_BuildSkinData(varName.."^"..varNameAppend.."~d", dups) 
                else
                    HealBot_Share_BuildSkinData(varName.."~d", dups) 
                end
            end
        else
            if string.len(dups)>1 then 
                if varNameAppend then
                    HealBot_Share_BuildSkinData(varName.."^"..varNameAppend.."~d", dups)
                else
                    HealBot_Share_BuildSkinData(varName.."~d", dups)
                end
                dups=""
            end
            if varNameAppend then
                HealBot_Share_BuildSkinData(varName.."^"..varNameAppend.."~f~"..i, tabStr)
            else
                HealBot_Share_BuildSkinData(varName.."~f~"..i, tabStr)
            end
        end
    end
end

function HealBot_Share_ExportSkin(skinName, lData)
    local SkinVars={'Author', 'DuplicateBars'}
    local SkinTabVars={'Chat', 'General', 'Healing', 'Enemy', 'FocusGroups'}
    local SkinTabFrameVars={'FrameAlias', 'FrameAliasBar', 'Frame', 'StickyFrames', 'HealGroups', 'Anchors', 'HeadBar', 'HeadText', 'HealBar', 'BarCol', 'BarIACol', 'BarText', 'BarTextCol', 'Icons', 'RaidIcon', 'IconText', 'BarVisibility', 'BarSort', 'BarAggro', 'AuxBarFrame', 'Indicators', 'Emerg'}
    HealBot_Share_BuildSkinData("Init", skinName)
    for j=1, getn(SkinVars), 1 do
        local varName=SkinVars[j]
        local tabStr=Healbot_Config_Skins[varName][skinName]
        if "string" == type( tabStr ) then
            HealBot_Share_BuildSkinData(varName.."~v", tabStr)
        elseif tabStr then
            HealBot_Share_BuildSkinData(varName.."~v", "true")
        else
            HealBot_Share_BuildSkinData(varName.."~v", "false")
        end
    end
    for j=1, getn(SkinTabVars), 1 do
        local varName=SkinTabVars[j]
        local tabStr=HealBot_Options_tab2str(Healbot_Config_Skins[varName][skinName])
        HealBot_Share_BuildSkinData(varName.."~t", tabStr)
    end
    for j=1, getn(SkinTabFrameVars), 1 do
        local varName=SkinTabFrameVars[j]
        HealBot_Share_ExportSkinFrames(skinName, varName)
        if varName=="HealGroups" then
            local tabStr=HealBot_Options_tab2str(Healbot_Config_Skins[varName][skinName][11])
            HealBot_Share_BuildSkinData(varName.."~f~11", tabStr)
        end
    end
    for x=1,9 do
        HealBot_Share_ExportSkinFrames(skinName, "AuxBar", x)
        HealBot_Share_ExportSkinFrames(skinName, "AuxBarText", x)
    end
    for x=1,3 do
        if Healbot_Config_Skins.IconSets and Healbot_Config_Skins.IconSets[skinName] then
            HealBot_Share_ExportSkinFrames(skinName, "IconSets", x)
        end
        if Healbot_Config_Skins.IconSetsText and Healbot_Config_Skins.IconSetsText[skinName] then
            HealBot_Share_ExportSkinFrames(skinName, "IconSetsText", x)
        end
    end
    HealBot_Share_BuildSkinData("Complete", "", lData)
end

function HealBot_Share_ExportSkin_OnClick()
    HealBot_Share_ExportSkin(Healbot_Config_Skins.Skins[HealBot_Share_luVars["InOutSkin"]])
end

local hbOptGetSkinName=" "
local hbWarnSharedMedia=false
function HealBot_Share_SkinLoad(sIn, internal)
    local ssStr=HealBot_Share_Decompress(sIn)
    local ssTab={}
    local i=0
    for l in string.gmatch(ssStr, "[^\n]+") do
        local t=(string.gsub(l, "^%s*(.-)%s*$", "%1"))
        if string.len(t)>1 then
            i=i+1
            ssTab[i]=t
        end
    end
    hbOptGetSkinName=ssTab[2]
    if tonumber(hbOptGetSkinName) then hbOptGetSkinName='#'..hbOptGetSkinName end
    for e=3,#ssTab do 
        local c,m = string.split("!", ssTab[e])
        if c and m then HealBot_Share_BuildSkinRecMsg(hbOptGetSkinName, c, 0, m) end
    end
    if not HealBot_Options_checkSkinName(hbOptGetSkinName) then
        table.insert(Healbot_Config_Skins.Skins,2,hbOptGetSkinName)
        Healbot_Config_Skins.Skin_ID = 2;
    end
    HealBot_Skins_Check_Skin(hbOptGetSkinName, true)
    if not internal then
        HealBot_Options_Set_Current_Skin(hbOptGetSkinName, nil, nil, true)
        HealBot_SetResetFlag("SOFT")
        HealBot_Options_NewSkin:SetText("")
        hbWarnSharedMedia=false
        HealBot_AddChat(hbOptGetSkinName..HEALBOT_CHAT_SKINREC)
    end
end

function HealBot_Share_ImportSkin_OnClick()
    Skin_TextData=HealBot_Options_ShareExternalEditBox:GetText()
    HealBot_Share_ValidateData(1, Skin_TextData)
end

function HealBot_Options_StringSplit(s, delimiter)
    local result = {};
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match);
    end
    return result;
end

local tmpRecParts={}
local lFrame=1
function HealBot_Share_BuildSkinRecMsg(skinName, cmd, parts, msg)
    local varDat, vType, fNo = string.split("~", cmd)
    local varName, aID=string.split("^", varDat)
    msg=string.gsub(msg,'\"', '' )
    if parts==1 then
        tmpRecParts[varName]=msg
        return
    elseif parts==2 then
        msg=tmpRecParts[varName]..msg
        tmpRecParts[varName]=nil
    end
    if vType=="f" and Healbot_Config_Skins[varName] then
        if tonumber(fNo) then fNo=tonumber(fNo) end
        if not Healbot_Config_Skins[varName][skinName] then Healbot_Config_Skins[varName][skinName]={} end
        if varName=="AuxBar" or varName=="AuxBarText" then
            if tonumber(aID) then 
                aID=tonumber(aID) 
                if not Healbot_Config_Skins[varName][skinName][aID] then Healbot_Config_Skins[varName][skinName][aID]={} end
                for j=1,10 do
                    if not Healbot_Config_Skins[varName][skinName][aID][j] then Healbot_Config_Skins[varName][skinName][aID][j]={} end
                end
            end
        else
            for j=1,10 do
                if not Healbot_Config_Skins[varName][skinName][j] then Healbot_Config_Skins[varName][skinName][j]={} end
                if varName=="IconSets" or varName=="IconSetsText" then
                    if tonumber(aID) then 
                        aID=tonumber(aID) 
                        if not Healbot_Config_Skins[varName][skinName][j][aID] then Healbot_Config_Skins[varName][skinName][j][aID]={} end
                    end
                end
            end
        end
        if varName=="HealGroups" then
            if not Healbot_Config_Skins[varName][skinName][11] then Healbot_Config_Skins[varName][skinName][11]={} end
        end
        if varName=="AuxBar" or varName=="AuxBarText" then
            if tonumber(aID) then 
                aID=tonumber(aID) 
                local lMsg=strsub(msg,2,string.len(msg)-1)
                local d={}
                d=HealBot_Options_StringSplit(lMsg, ",")
                for j=1,getn(d) do
                    local var, dat=string.split("=", d[j])
                    if tonumber(dat) then dat=tonumber(dat) end
                    if var and dat then
                        if varName=="AuxBar" and var=="USE" then
                            dat=HealBot_Share_SkinDecodeAux(dat, fNo)
                        end
                        if dat=="false" then                
                            Healbot_Config_Skins[varName][skinName][aID][fNo][var]=false 
                        elseif dat=="true" then
                            Healbot_Config_Skins[varName][skinName][aID][fNo][var]=true 
                        else
                            Healbot_Config_Skins[varName][skinName][aID][fNo][var]=dat 
                        end
                    end
                    lFrame=fNo
                end
            end
        elseif varName=="IconSets" or varName=="IconSetsText" then
            if tonumber(aID) then 
                aID=tonumber(aID) 
                local lMsg=strsub(msg,2,string.len(msg)-1)
                local d={}
                d=HealBot_Options_StringSplit(lMsg, ",")
                for j=1,getn(d) do
                    local var, dat=string.split("=", d[j])
                    if tonumber(dat) then dat=tonumber(dat) end
                    if var and dat then
                        if dat=="false" then                
                            Healbot_Config_Skins[varName][skinName][fNo][aID][var]=false 
                        elseif dat=="true" then
                            Healbot_Config_Skins[varName][skinName][fNo][aID][var]=true 
                        else
                            Healbot_Config_Skins[varName][skinName][fNo][aID][var]=dat 
                        end
                    end
                    lFrame=fNo
                end
            end
        elseif varName~="ExtraIncGroup" then
            local lMsg=strsub(msg,2,string.len(msg)-1)
            local d={}
            d=HealBot_Options_StringSplit(lMsg, ",")
            for j=1,getn(d) do
                local var, dat=string.split("=", d[j])
                if tonumber(dat) then dat=tonumber(dat) end
                if var and dat then
                    if dat=="false" then                
                        Healbot_Config_Skins[varName][skinName][fNo][var]=false 
                    elseif dat=="true" then
                        Healbot_Config_Skins[varName][skinName][fNo][var]=true 
                    else
                        Healbot_Config_Skins[varName][skinName][fNo][var]=dat 
                    end
                end
                lFrame=fNo
            end
        end
    elseif vType=="d" and Healbot_Config_Skins[varName] then
        local dups={}
        dups=HealBot_Options_StringSplit(msg, "~")
        for j=1,getn(dups) do
            local f=nil
            if tonumber(dups[j]) then f=tonumber(dups[j]) end
            if varName=="AuxBar" or varName=="AuxBarText" then
                if tonumber(aID) then 
                    aID=tonumber(aID) 
                    if f then Healbot_Config_Skins[varName][skinName][aID][f]=HealBot_Options_copyTable(Healbot_Config_Skins[varName][skinName][aID][lFrame]) end
                end
            elseif varName=="IconSets" or varName=="IconSetsText" then
                if tonumber(aID) then 
                    aID=tonumber(aID) 
                    if f then Healbot_Config_Skins[varName][skinName][f][aID]=HealBot_Options_copyTable(Healbot_Config_Skins[varName][skinName][lFrame][aID]) end
                end
            else
                if f then Healbot_Config_Skins[varName][skinName][f]=HealBot_Options_copyTable(Healbot_Config_Skins[varName][skinName][lFrame]) end
            end
        end
    elseif vType=="t" and Healbot_Config_Skins[varName] then
        if not Healbot_Config_Skins[varName][skinName] then Healbot_Config_Skins[varName][skinName]={} end
        local lMsg=strsub(msg,2,string.len(msg)-1)
        local d={}
        d=HealBot_Options_StringSplit(lMsg, ",")
        for j=1,getn(d) do
            local var, dat=string.split("=", d[j])
            if tonumber(dat) then dat=tonumber(dat) end
            if var and dat then
                if dat=="false" then                
                    Healbot_Config_Skins[varName][skinName][var]=false 
                elseif dat=="true" then
                    Healbot_Config_Skins[varName][skinName][var]=true 
                else
                    Healbot_Config_Skins[varName][skinName][var]=dat 
                end
            end
        end
    elseif vType=="v" and Healbot_Config_Skins[varName] then
        if msg=="true" then
            Healbot_Config_Skins[varName][skinName]=true
        elseif msg=="false" then
            Healbot_Config_Skins[varName][skinName]=false
        else
            if tonumber(msg) then msg=tonumber(msg) end
            Healbot_Config_Skins[varName][skinName]=msg
        end
    end
end

function HealBot_Share_WarnPossibleNoSharedMedia()
    if not hbWarnSharedMedia then
        HealBot_AddChat(HEALBOT_CHAT_POSSIBLEMISSINGMEDIA)
        hbWarnSharedMedia=true
    end
end

local linkDataIn, nChunks, cChunk="", 1, 0
local dChunk={}
function HealBot_Share_LinkMsg(msg, sender)
    local mType,data=strsplit("~", msg)
    if mType=="L" then
        HealBot_Share_DisplayLink(data)
    elseif mType=="R" then
        local _, sType, eInfo=strsplit("~", msg)
        if sType and sender then
            sType=tonumber(sType)
        --    HealBot_AddDebug("HBLink Request Type="..sType.." from="..sender.." extra="..(eInfo or "nil"))
            if HealBot_Share_luVars["RequestReady"] then
                HealBot_Share_luVars["RequestReady"]=false
                HealBot_Share_luVars["RequestType"]=sType
                HealBot_Share_luVars["RequestName"]=sender
                HealBot_Share_LinkData(sType, eInfo)
            else
                if not RequestQueue[sender] then RequestQueue[sender]=msg end
                HealBot_Comms_SendShareAddonMsg("L:Q~", sender)
            end
        end
    elseif mType=="D" then
        local _,id,data=strsplit("~", msg)
        id=tonumber(id)
        dChunk[id]=data
        cChunk=cChunk+1
        HealBot_Share_luVars["LastLinkTimeOut"]=GetTime()
        HealBot_Share_LinkFrame_SetStateText(HEALBOT_OPTIONS_LINK_TRANSINPROGRESS, ceil((cChunk/nChunks)*100).."%")
    elseif mType=="S" then
        nChunks=tonumber(data)
        linkDataIn=""
        cChunk=0
        HealBot_Share_luVars["LastLinkTimeOut"]=GetTime()
        HealBot_Share_luVars["TransferComplete"]=false
        HealBot_Share_LinkFrame_SetStateText(HEALBOT_OPTIONS_LINK_TRANSSTARTED)
    elseif mType=="E" then
        for x=1,cChunk do
            linkDataIn=linkDataIn..dChunk[x]
        end
        if string.len(linkDataIn)==tonumber(data) then
            if HealBot_Share_luVars["RequestType"]==1 then
                Skin_TextData=linkDataIn
                HealBot_Share_ValidateData(1, Skin_TextData)
            elseif HealBot_Share_luVars["RequestType"]==2 then
                Debuffs_TextData=linkDataIn
                HealBot_Share_ValidateData(2, Debuffs_TextData)
            elseif HealBot_Share_luVars["RequestType"]==3 then
                Buffs_TextData=linkDataIn
                HealBot_Share_ValidateData(3, Buffs_TextData)
            elseif HealBot_Share_luVars["RequestType"]==4 then
                Spells_TextData=linkDataIn
                HealBot_Share_ValidateData(4, Spells_TextData)
            elseif HealBot_Share_luVars["RequestType"]==5 then
                PresetCols_TextData=linkDataIn
                HealBot_Share_ValidateData(5, PresetCols_TextData)
            end
            HealBot_Share_luVars["LastLinkRequest"]=GetTime()+3
        else
            HealBot_Share_ImportFail(shareType[HealBot_Share_luVars["RequestType"]], "String length mismatch")
        end
        HealBot_Share_luVars["TransferComplete"]=true
        HealBot_Share_luVars["LastLinkTimeOut"]=GetTime()-5
        HealBot_Share_LinkFrame_SetStateText(HEALBOT_OPTIONS_LINK_TRANSCOMPLETE)
    --    HealBot_Options_SharePresetColsExternalEditBox:SetText("Test\nnChunks="..nChunks.."\nstring.len="..data.."\n"..linkDataIn)
    elseif mType=="Q" then
        HealBot_Share_luVars["LastLinkTimeOut"]=GetTime()+15
        HealBot_Share_LinkFrame_SetStateText(HEALBOT_OPTIONS_LINK_WAITQUEUE)
    end
end

local function HealBot_Share_SendLinkData(lType, data)
    HealBot_Comms_SendShareAddonMsg("L:"..lType.."~"..data, HealBot_Share_luVars["RequestName"])
end

function HealBot_Share_SentLinkData()
    HealBot_Share_luVars["RequestReady"]=true
    for sender,msg in pairs(RequestQueue) do
        RequestQueue[uName]=nil
        HealBot_Share_LinkMsg(msg, sender)
    end
end

function HealBot_Share_ProcessLinkData(data)
    local chunks=ceil(string.len(data)/240)
    local tDelay=0.25
    local pointer=1
    HealBot_Share_SendLinkData("S", chunks)
    for x=1,chunks do
        local dat=string.sub(data, pointer, pointer+239)
        C_Timer.After(tDelay, function() HealBot_Share_SendLinkData("D~"..x, dat) end)
        pointer=(240*x)+1
        tDelay=tDelay+0.25
    end
    C_Timer.After(tDelay, function() HealBot_Share_SendLinkData("E", string.len(data)) end)
    tDelay=tDelay+0.25
    C_Timer.After(tDelay, HealBot_Share_SentLinkData)
end

function HealBot_Share_LinkData(sType, eInfo)
    if sType==1 then
        HealBot_Share_ExportSkin(eInfo, true)
    elseif sType==2 then
        HealBot_Share_ExportDebuffs(true)
    elseif sType==3 then
        HealBot_Share_ExportBuffs(true)
    elseif sType==4 then
        HealBot_Share_ExportSpells(true)
    elseif sType==5 then
        HealBot_Share_ExportPresetCols(true)
    end
end

local function HealBot_Share_LinkFrame_OnMouseDown(self, button)
    if button=="LeftButton" and not hbLinkFrame.isMoving then
        hbLinkFrame:StartMoving();
        hbLinkFrame.isMoving = true;
    end
end

local function HealBot_Share_LinkFrame_OnMouseUp(self, button)
    if button=="LeftButton" and hbLinkFrame.isMoving then
		hbLinkFrame:StopMovingOrSizing();
		hbLinkFrame.isMoving = false;
    end
end

function HealBot_Share_LinkFrame_SetStateText(state, pct)
    hbLinkFrameText["STATE"]:SetText(state)
    if pct then
        hbLinkFrameText["PCT"]:SetText(pct)
    else
        hbLinkFrameText["PCT"]:SetText("")
    end
end

local inMethodTxt={[0]=HEALBOT_IMPORT_CREATEORREPLACE,
                   [1]=HEALBOT_IMPORT_OVERWRITEALL,
                   [2]=HEALBOT_IMPORT_MERGEALL,
                   [3]=HEALBOT_IMPORT_MERGENEW,}
function HealBot_Share_LinkFrame_SetRequestText(sType, uName, eInfo)
    if eInfo then
        hbLinkFrameText["RTYPE"]:SetText("|cffffffff"..HEALBOT_WORD_TYPE..": |cff55ff55"..shareType[sType].." ("..eInfo..")")
    else
        hbLinkFrameText["RTYPE"]:SetText("|cffffffff"..HEALBOT_WORD_TYPE..": |cff55ff55"..shareType[sType])
    end
    hbLinkFrameText["RFROM"]:SetText("|cffffffff"..HEALBOT_WORD_FROM..": |cff55ff55"..uName)
    local inMethod=0
    if sType==2 then inMethod=HealBot_Options_retLuVars("InMethodDebuff") end
    if sType==3 then inMethod=HealBot_Options_retLuVars("InMethodBuff") end
    if sType==4 then inMethod=HealBot_Options_retLuVars("InMethodSpell") end
    hbLinkFrameText["INMETHOD"]:SetText("|cffffffff"..HEALBOT_OPTIONS_BUTTONIMPORTMETHOD..": |cff55ff55"..inMethodTxt[inMethod])
    
    hbLinkFrameObjects["YesBtn"]:Hide()
    hbLinkFrameObjects["NoBtn"]:Hide()
    hbLinkFrameObjects["CloseBtn"]:Hide()
    if uName~=UnitName("player") then
        HealBot_Share_LinkFrame_SetStateText(HEALBOT_OPTIONS_LINK_REQUESTSENDQ)
        hbLinkFrameObjects["YesBtn"]:Show()
        hbLinkFrameObjects["NoBtn"]:Show()    
        hbLinkFrameObjects["YesBtn"]:Enable()
        hbLinkFrameObjects["NoBtn"]:Enable()
    else
        HealBot_Share_LinkFrame_SetStateText(HEALBOT_OPTIONS_LINK_REQUEST2)
        hbLinkFrameObjects["CloseBtn"]:Show()
    end
end

local function HealBot_Share_LinkFrame_CreateText()
	hbLinkFrameText["TITLE"]=hbLinkFrame:CreateFontString("HealBot_LinkFrameTitleText", "OVERLAY", "GameFontNormal")
	hbLinkFrameText["TITLE"]:SetPoint("TOP", hbLinkFrame, "TOP", 0, -8)
	hbLinkFrameText["TITLE"]:SetText(HEALBOT_OPTIONS_LINK_REQUEST1)
    hbLinkFrameText["TITLE"]:SetTextColor(1,1,1,1)
	hbLinkFrameText["RTYPE"]=hbLinkFrame:CreateFontString("HealBot_LinkFrameRequestTypeText", "OVERLAY", "GameFontNormal")
	hbLinkFrameText["RTYPE"]:SetPoint("TOP", hbLinkFrame, "TOP", 0, -37)
	hbLinkFrameText["RFROM"]=hbLinkFrame:CreateFontString("HealBot_LinkFrameRequestFromText", "OVERLAY", "GameFontNormal")
	hbLinkFrameText["RFROM"]:SetPoint("TOP", hbLinkFrame, "TOP", 0, -54)
	hbLinkFrameText["INMETHOD"]=hbLinkFrame:CreateFontString("HealBot_LinkFrameImportMethodText", "OVERLAY", "GameFontNormal")
	hbLinkFrameText["INMETHOD"]:SetPoint("TOP", hbLinkFrame, "TOP", 0, -71)
	hbLinkFrameText["STATE"]=hbLinkFrame:CreateFontString("HealBot_LinkFrameRequestStateText", "OVERLAY", "GameFontNormal")
	hbLinkFrameText["STATE"]:SetPoint("TOP", hbLinkFrame, "TOP", 0, -100)
    hbLinkFrameText["STATE"]:SetTextColor(0.95,0.95,0.4,1)
	hbLinkFrameText["PCT"]=hbLinkFrame:CreateFontString("HealBot_LinkFrameRequestPctText", "OVERLAY", "GameFontNormal")
	hbLinkFrameText["PCT"]:SetPoint("LEFT", hbLinkFrameText["STATE"], "RIGHT", 5, 0)
    hbLinkFrameText["PCT"]:SetTextColor(0.95,0.95,0.4,1)
end

function HealBot_Share_LinkFrame_Hide()
    if hbLinkFrame then 
        hbLinkFrame:Hide()
    end
end

function HealBot_Share_ShowLinkFrame()
    if not hbLinkFrame then
		hbLinkFrame=CreateFrame("Frame", "HealBot_Link_Frame", UIParent, BackdropTemplateMixin and "BackdropTemplate")
		hbLinkFrame:SetBackdrop({
			bgFile = "Interface\\Addons\\HealBot\\Images\\WhiteLine",
			edgeFile = "Interface\\Addons\\HealBot\\Images\\border",
			tile = true,
			tileSize = 8,
			edgeSize = 8,
			insets = { left = 3, right = 3, top = 3, bottom = 3, },
		})
		hbLinkFrame:SetMovable(true)
		hbLinkFrame:EnableMouse(true)
		hbLinkFrame:SetScript("OnMouseDown", function(self, button) HealBot_Share_LinkFrame_OnMouseDown(self, button) end)
		hbLinkFrame:SetScript("OnMouseUp", function(self, button) HealBot_Share_LinkFrame_OnMouseUp(self, button) end)

		hbLinkFrame:SetWidth(300)
        hbLinkFrame:SetHeight(150)	
        hbLinkFrame:SetBackdropColor(0.2,0.2,0.2,0.8)
        hbLinkFrame:SetBackdropBorderColor(0.4,0.4,0.4,0.9)
        hbLinkFrame:ClearAllPoints()
        hbLinkFrame:SetPoint("BOTTOM","WorldFrame","BOTTOM",0,175);

        hbLinkFrameObjects["CloseBtn"] = CreateFrame("Button", "HealBot_Link_Frame_CloseBtn", hbLinkFrame, "UIPanelButtonTemplate")
        hbLinkFrameObjects["CloseBtn"]:SetPoint("BOTTOM", 0, 10)
        hbLinkFrameObjects["CloseBtn"]:SetWidth(120)
        hbLinkFrameObjects["CloseBtn"]:SetHeight(22)
        hbLinkFrameObjects["CloseBtn"]:SetNormalFontObject("GameFontNormal")
        hbLinkFrameObjects["CloseBtn"]:SetText(HEALBOT_OPTIONS_CLOSE)
        hbLinkFrameObjects["CloseBtn"]:SetScript("OnMouseDown", function() HealBot_Share_CancelLinkRequest(); end)
        hbLinkFrameObjects["YesBtn"] = CreateFrame("Button", "HealBot_Link_Frame_YesBtn", hbLinkFrame, "UIPanelButtonTemplate")
        hbLinkFrameObjects["YesBtn"]:SetPoint("BOTTOM", -60, 10)
        hbLinkFrameObjects["YesBtn"]:SetWidth(110)
        hbLinkFrameObjects["YesBtn"]:SetHeight(22)
        hbLinkFrameObjects["YesBtn"]:SetNormalFontObject("GameFontNormal")
        hbLinkFrameObjects["YesBtn"]:SetText(HEALBOT_WORDS_YES)
        hbLinkFrameObjects["YesBtn"]:SetScript("OnMouseDown", function() HealBot_Share_SendLinkRequest(); end)
        hbLinkFrameObjects["NoBtn"] = CreateFrame("Button", "HealBot_Link_Frame_NoBtn", hbLinkFrame, "UIPanelButtonTemplate")
        hbLinkFrameObjects["NoBtn"]:SetPoint("BOTTOM", 60, 10)
        hbLinkFrameObjects["NoBtn"]:SetWidth(110)
        hbLinkFrameObjects["NoBtn"]:SetHeight(22)
        hbLinkFrameObjects["NoBtn"]:SetNormalFontObject("GameFontNormal")
        hbLinkFrameObjects["NoBtn"]:SetText(HEALBOT_WORDS_NO)
        hbLinkFrameObjects["NoBtn"]:SetScript("OnMouseDown", function() HealBot_Share_CancelLinkRequest(); end)
        
        HealBot_Share_LinkFrame_CreateText()
    end
    hbLinkFrame:Show()
end

function HealBot_Share_ClosePostLink()
    if hbPostLinkFrame and hbPostLinkFrame:IsVisible() then
        hbPostLinkFrame:Hide()
        HealBot_Share_luVars["CurrentEditBox"]:Show()
        HealBot_Share_luVars["CurrentEditBoxScroll"]:Show()
    end
end

function HealBot_Share_DisplayLink(s)
    s=HealBot_Share_Decompress(s)
    HealBot_AddChat(s)
end

function HealBot_Share_PostLink()
    local s="|cffe6cc80|Hgarrmission:healbot|hHealBot Share [~"..HealBot_Share_luVars["RequestString"].."~]|h|r"
    s=HealBot_Share_Compress(s)
    if HealBot_Share_luVars["PostChannel"]<3 and IsInInstance() and (IsInGroup(LE_PARTY_CATEGORY_INSTANCE) or IsInRaid(LE_PARTY_CATEGORY_INSTANCE)) then
        C_ChatInfo.SendAddonMessage(HEALBOT_HEALBOT, "L:L~"..s, "INSTANCE_CHAT")
    elseif HealBot_Share_luVars["PostChannel"]==1 and IsInGroup() then
        C_ChatInfo.SendAddonMessage(HEALBOT_HEALBOT, "L:L~"..s, "PARTY")
    elseif HealBot_Share_luVars["PostChannel"]==2 and IsInRaid() then
        C_ChatInfo.SendAddonMessage(HEALBOT_HEALBOT, "L:L~"..s, "RAID")
    elseif HealBot_Share_luVars["PostChannel"]==3 and IsInGuild() then
        C_ChatInfo.SendAddonMessage(HEALBOT_HEALBOT, "L:L~"..s, "GUILD")
    elseif HealBot_Share_luVars["PostChannel"]==4 and string.len(HealBot_Share_luVars["PostWhisper"])>1 then
        C_ChatInfo.SendAddonMessage(HEALBOT_HEALBOT, "L:L~"..s, "WHISPER", HealBot_Share_luVars["PostWhisper"]);
    end
end

local function HealBot_Share_SetupDropDown(dropdown, width, x, y, text)
	dropdown:SetPoint("TOP", x, y)
	UIDropDownMenu_SetWidth(dropdown, width)	
	dropdown.Txt = dropdown:CreateFontString()
	dropdown.Txt:SetFontObject(GameFontNormal)
	dropdown.Txt:SetPoint("TOP", 0 , 12)
    dropdown.Txt:SetText(text)
end

local function HealBot_Share_PostFrameChannel_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    for j=1, 4, 1 do
        info.text = linkChannelList[j];
        info.func = function(self)
                        if HealBot_Share_luVars["PostChannel"]~=self:GetID() then
							HealBot_Share_luVars["PostChannel"]=self:GetID()
                            UIDropDownMenu_SetText(hbPostLinkFrameObjects["PostFrameChannel"],linkChannelList[HealBot_Share_luVars["PostChannel"]])
							if HealBot_Share_luVars["PostChannel"]==4 then
                                hbPostLinkFrameObjects["PostFrameWhisper"]:Show()
                            else
                                hbPostLinkFrameObjects["PostFrameWhisper"]:Hide()
                            end
                        end
                    end
        info.checked = false;
        if HealBot_Share_luVars["PostChannel"]==j then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
end

local function HealBot_Share_PostFrameWhisper_DropDown()
    local info = UIDropDownMenu_CreateInfo()    
    local wList=HealBot_GetInfo()
    local uID=""
    local uName=nil
    for x,_ in pairs(wList) do
        info.text = x;
        info.func = function(self)
                        if HealBot_Share_luVars["PostWhisper"]~=self:GetText() then
                            HealBot_Share_luVars["PostWhisper"]=self:GetText()
                            UIDropDownMenu_SetText(hbPostLinkFrameObjects["PostFrameWhisper"],HealBot_Share_luVars["PostWhisper"])
                        end
                    end
        info.checked = false;
        if HealBot_Share_luVars["PostWhisper"]==x then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
end

local function HealBot_Share_SetLabel(object, text)
	local r,g,b,a=HealBot_Options_OptionsThemeCols()
	object:SetText(text)
	object:SetTextColor(r,g,b,a)
end

function HealBot_Share_ShowPostFrame(g,h,f,tTxt)
    if not hbPostLinkFrame then
		hbPostLinkFrame=CreateFrame("Frame", "HealBot_Link_PostFrame", UIParent, BackdropTemplateMixin and "BackdropTemplate")
		hbPostLinkFrame:SetBackdrop({
			bgFile = "Interface\\Addons\\HealBot\\Images\\WhiteLine",
			edgeFile = "Interface\\Addons\\HealBot\\Images\\border",
			tile = true,
			tileSize = 8,
			edgeSize = 8,
			insets = { left = 3, right = 3, top = 3, bottom = 3, },
		})
        hbPostLinkFrame:SetBackdropColor(0,0,0,1)
        hbPostLinkFrame:SetBackdropBorderColor(0,0,0,0)
        hbPostLinkFrame:SetWidth(320)
        hbPostLinkFrame:SetHeight(425)
        
		hbPostLinkFrameObjects["PostFrameChannel"] = CreateFrame("Frame", "HealBot_PostFrame_Channel", hbPostLinkFrame, "UIDropDownMenuTemplate")
		HealBot_Share_SetupDropDown(hbPostLinkFrameObjects["PostFrameChannel"], 170, 0, -225, HEALBOT_OPTIONS_LINK_POSTCHANNEL)
		hbPostLinkFrameObjects["PostFrameWhisper"] = CreateFrame("Frame", "HealBot_PostFrame_Whisper", hbPostLinkFrame, "UIDropDownMenuTemplate")
		HealBot_Share_SetupDropDown(hbPostLinkFrameObjects["PostFrameWhisper"], 170, 0, -285, HEALBOT_OPTIONS_LINK_POSTWHISPER)
        hbPostLinkFrameObjects["PostFrameWhisper"]:Hide()
        
        hbPostLinkFrameText["TITLE"]=hbPostLinkFrame:CreateFontString("HealBot_PostFrameTitleText", "OVERLAY", "GameFontNormal")
        hbPostLinkFrameText["TITLE"]:SetPoint("TOP", hbPostLinkFrame, "TOP", 0, 0)
        hbPostLinkFrameText["TITLE"]:SetText(HEALBOT_OPTIONS_LINK_CREATELR)
        hbPostLinkFrameText["TITLE"]:SetTextColor(1,1,1,1)
        hbPostLinkFrameText["TYPE"]=hbPostLinkFrame:CreateFontString("HealBot_PostFrameTypeText", "OVERLAY", "GameFontNormal")
        hbPostLinkFrameText["TYPE"]:SetPoint("TOP", hbPostLinkFrame, "TOP", 0, -25)
        hbPostLinkFrameText["TYPE"]:SetTextColor(0.2,1,0.2,1)
        hbPostLinkFrameText["CHAN1"]=hbPostLinkFrame:CreateFontString("HealBot_PostFrameChat1Text", "OVERLAY", "GameFontNormal")
        hbPostLinkFrameText["CHAN1"]:SetPoint("TOP", hbPostLinkFrame, "TOP", 0, -85)
        hbPostLinkFrameText["CHAN1"]:SetText(HEALBOT_OPTIONS_LINK_CHAN1)
        hbPostLinkFrameText["CHAN1"]:SetTextColor(1,1,1,1)
        hbPostLinkFrameText["CHAN2"]=hbPostLinkFrame:CreateFontString("HealBot_PostFrameChat2Text", "OVERLAY", "GameFontNormal")
        hbPostLinkFrameText["CHAN2"]:SetPoint("TOPLEFT", hbPostLinkFrameText["CHAN1"], "TOPLEFT", 0, -20)
        hbPostLinkFrameText["CHAN2"]:SetText(HEALBOT_OPTIONS_LINK_CHAN2)
        hbPostLinkFrameText["CHAN2"]:SetTextColor(1,1,0.8,1)
        hbPostLinkFrameText["CHAN3"]=hbPostLinkFrame:CreateFontString("HealBot_PostFrameChat3Text", "OVERLAY", "GameFontNormal")
        hbPostLinkFrameText["CHAN3"]:SetPoint("TOPLEFT", hbPostLinkFrameText["CHAN2"], "TOPLEFT", 0, -20)
        hbPostLinkFrameText["CHAN3"]:SetText(HEALBOT_OPTIONS_LINK_CHAN3)
        hbPostLinkFrameText["CHAN3"]:SetTextColor(1,1,0.8,1)
        hbPostLinkFrameText["CHAN4"]=hbPostLinkFrame:CreateFontString("HealBot_PostFrameChat3Text", "OVERLAY", "GameFontNormal")
        hbPostLinkFrameText["CHAN4"]:SetPoint("TOPLEFT", hbPostLinkFrameText["CHAN3"], "TOPLEFT", 0, -20)
        hbPostLinkFrameText["CHAN4"]:SetText(HEALBOT_OPTIONS_LINK_CHAN4)
        hbPostLinkFrameText["CHAN4"]:SetTextColor(1,1,0.8,1)
        hbPostLinkFrameObjects["PostBtn"] = CreateFrame("Button", "HealBot_Post_Frame_PostBtn", hbPostLinkFrame, "UIPanelButtonTemplate")
        hbPostLinkFrameObjects["PostBtn"]:SetPoint("BOTTOM", -80, 20)
        hbPostLinkFrameObjects["PostBtn"]:SetWidth(140)
        hbPostLinkFrameObjects["PostBtn"]:SetHeight(22)
        hbPostLinkFrameObjects["PostBtn"]:SetNormalFontObject("GameFontNormal")
        hbPostLinkFrameObjects["PostBtn"]:SetText(HEALBOT_OPTIONS_BUTTONPOST)
        hbPostLinkFrameObjects["PostBtn"]:SetScript("OnMouseDown", function() HealBot_Share_PostLink(); end)
        hbPostLinkFrameObjects["CloseBtn"] = CreateFrame("Button", "HealBot_Post_Frame_CloseBtn", hbPostLinkFrame, "UIPanelButtonTemplate")
        hbPostLinkFrameObjects["CloseBtn"]:SetPoint("BOTTOM", 80, 20)
        hbPostLinkFrameObjects["CloseBtn"]:SetWidth(140)
        hbPostLinkFrameObjects["CloseBtn"]:SetHeight(22)
        hbPostLinkFrameObjects["CloseBtn"]:SetNormalFontObject("GameFontNormal")
        hbPostLinkFrameObjects["CloseBtn"]:SetText(HEALBOT_OPTIONS_CLOSE)
        hbPostLinkFrameObjects["CloseBtn"]:SetScript("OnMouseDown", function() HealBot_Share_ClosePostLink(); end)
    end
    HealBot_Share_luVars["PostWhisper"]=""
    
    UIDropDownMenu_Initialize(hbPostLinkFrameObjects["PostFrameChannel"], HealBot_Share_PostFrameChannel_DropDown)
	UIDropDownMenu_SetText(hbPostLinkFrameObjects["PostFrameChannel"],linkChannelList[HealBot_Share_luVars["PostChannel"]])
	HealBot_Share_SetLabel(hbPostLinkFrameObjects["PostFrameChannel"].Txt, HEALBOT_OPTIONS_LINK_POSTCHANNEL)
    UIDropDownMenu_Initialize(hbPostLinkFrameObjects["PostFrameWhisper"], HealBot_Share_PostFrameWhisper_DropDown)
	UIDropDownMenu_SetText(hbPostLinkFrameObjects["PostFrameWhisper"],HealBot_Share_luVars["PostWhisper"])
	HealBot_Share_SetLabel(hbPostLinkFrameObjects["PostFrameWhisper"].Txt, HEALBOT_OPTIONS_LINK_POSTWHISPER)
    
    hbPostLinkFrame:SetParent(f)
    hbPostLinkFrame:ClearAllPoints()
    hbPostLinkFrame:SetPoint("BOTTOM",f,"BOTTOM",0,2)
    HealBot_Share_luVars["CurrentEditBox"]=g
    HealBot_Share_luVars["CurrentEditBoxScroll"]=h
    hbPostLinkFrameText["TYPE"]:SetText(tTxt)
    g:Hide()
    h:Hide()
    hbPostLinkFrame:Show()
end

function HealBot_Share_ShowPostSkinFrame()
    local sType=1
    local g=_G["HealBot_Options_ShareExternalEditBox"]
    local h=_G["HealBot_Options_ShareExternalScroll"]
    local f=_G["HealBot_Options_ShareExternalEditBoxFrame"]
    HealBot_Share_luVars["RequestString"]=HealBot_Share_Compress("~"..sType.."~"..UnitName("player").."~"..Healbot_Config_Skins.Skins[HealBot_Share_luVars["InOutSkin"]])
    HealBot_Share_ShowPostFrame(g,h,f,shareType[sType].." ("..Healbot_Config_Skins.Skins[HealBot_Share_luVars["InOutSkin"]]..")")
end

function HealBot_Share_ShowPostDebuffFrame()
    local sType=2
    local g=_G["HealBot_Options_ShareCDebuffExternalEditBox"]
    local h=_G["HealBot_Options_ShareCDebuffExternalScroll"]
    local f=_G["HealBot_Options_ShareCDebuffExternalEditBoxFrame"]
    HealBot_Share_luVars["RequestString"]=HealBot_Share_Compress("~"..sType.."~"..UnitName("player"))
    HealBot_Share_ShowPostFrame(g,h,f,shareType[sType])
end

function HealBot_Share_ShowPostBuffFrame()
    local sType=3
    local g=_G["HealBot_Options_ShareBuffsExternalEditBox"]
    local h=_G["HealBot_Options_ShareBuffsExternalScroll"]
    local f=_G["HealBot_Options_ShareBuffsExternalEditBoxFrame"]
    HealBot_Share_luVars["RequestString"]=HealBot_Share_Compress("~"..sType.."~"..UnitName("player"))
    HealBot_Share_ShowPostFrame(g,h,f,shareType[sType])
end

function HealBot_Share_ShowPostSpellsFrame()
    local sType=4
    local g=_G["HealBot_Options_ShareSpellsExternalEditBox"]
    local h=_G["HealBot_Options_ShareSpellsExternalScroll"]
    local f=_G["HealBot_Options_ShareSpellsExternalEditBoxFrame"]
    HealBot_Share_luVars["RequestString"]=HealBot_Share_Compress("~"..sType.."~"..UnitName("player"))
    HealBot_Share_ShowPostFrame(g,h,f,shareType[sType])
end

function HealBot_Share_ShowPostPresetColsFrame()
    local sType=5
    local g=_G["HealBot_Options_SharePresetColsExternalEditBox"]
    local h=_G["HealBot_Options_SharePresetColsExternalScroll"]
    local f=_G["HealBot_Options_SharePresetColsExternalEditBoxFrame"]
    HealBot_Share_luVars["RequestString"]=HealBot_Share_Compress("~"..sType.."~"..UnitName("player"))
    HealBot_Share_ShowPostFrame(g,h,f,shareType[sType])
end
