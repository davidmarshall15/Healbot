local HealBotcommAddonSummary={}
local HealBotAddonSummaryNoCommsCPU={}
local HealBotAddonSummaryNoCommsMem={}
local HealBotAddonSummaryNoCommsSort={}
local sortorder={}
local hbtmpver={}
local HealBot_Comms_luVars={}
local _

HealBot_Comms_luVars["LastSupport"]=0

function HealBot_Comms_About()
    local hbcommver=HealBot_GetInfo()

    for x,_ in pairs(hbtmpver) do
        hbtmpver[x]=nil
    end
    for x,_ in pairs(sortorder) do
        sortorder[x]=nil;
    end

    linenum=1
    for x,v in pairs(hbcommver) do
        if not hbtmpver[x] and linenum<21 then
            HealBot_Comms_Print_IncHealsSum(x,v,0,linenum)
            linenum=linenum+1
        end
    end

    HealBot_Error_Clientx:SetText(HEALBOT_WORD_CLIENT.."="..GetLocale())
    if HealBot_Globals.localLang then
        HealBot_Error_Versionx:SetText(HEALBOT_OPTIONS_LANG.."="..HealBot_Globals.localLang)
    else
        HealBot_Error_Versionx:SetText(HEALBOT_OPTIONS_LANG.."="..GetLocale())
    end
    HealBot_Error_Classx:SetText(HEALBOT_SORTBY_CLASS.."="..UnitClass("player"))
    HealBot_Comms_MacroSuppressError()
    HealBot_Comms_MacroSuppressSound()
end

function HealBot_Comms_Print_IncHealsSum(sender_id,addon_id,HealsCnt,linenum)
    local g=_G["HBIncH"..linenum.."Healer"]
    g:SetText(sender_id);
    g=_G["HBIncH"..linenum.."Ver"]
    g:SetText(addon_id);
end

function HealBot_Comms_Print_Supports()
    if not HEALBOT_SUPPORTERS_PEOPLE[1] then return end
    local b=0
    local d={}
    for x=1,10 do
        local g=_G["HBIncH"..x.."Supporter"]
        local s=HealBot_Comms_luVars["LastSupport"]+x
        if not HEALBOT_SUPPORTERS_PEOPLE[s] then
            b=b+1
            s=b
            if not HEALBOT_SUPPORTERS_PEOPLE[s] then s=1 end
        end
        if not d[HEALBOT_SUPPORTERS_PEOPLE[s]] then
            g:SetText(HEALBOT_SUPPORTERS_PEOPLE[s]);
            d[HEALBOT_SUPPORTERS_PEOPLE[s]]=true
        end
    end
    if HEALBOT_SUPPORTERS_PEOPLE[11] then
        HealBot_Comms_luVars["LastSupport"]=HealBot_Comms_luVars["LastSupport"]+1
        local s=HealBot_Comms_luVars["LastSupport"]+1
        if not HEALBOT_SUPPORTERS_PEOPLE[s] then
            HealBot_Comms_luVars["LastSupport"]=0
        end
    end
end

function HealBot_Comms_Zone()
    local HealBotAddonMsgType=HealBot_retLuVars("AddonMsgType")
    HealBot_AddChat(HEALBOT_CHAT_ADDONID.."Zone="..GetRealZoneText())
    if HealBotAddonMsgType==1 then
        HealBot_AddChat(HEALBOT_CHAT_ADDONID.."AddonComms=INSTANCE_CHAT")
    elseif HealBotAddonMsgType==2 then
        HealBot_AddChat(HEALBOT_CHAT_ADDONID.."AddonComms=RAID")
    elseif HealBotAddonMsgType==3 then
        HealBot_AddChat(HEALBOT_CHAT_ADDONID.."AddonComms=PARTY")
    elseif HealBotAddonMsgType==4 then
        HealBot_AddChat(HEALBOT_CHAT_ADDONID.."AddonComms=WHISPER")
    end
    HealBot_AddChat(HEALBOT_CHAT_ADDONID.."#Group="..GetNumGroupMembers())
end

function HealBot_Comm_round(num, idp)
    local mult = 10^(idp or 0)
    return math.floor(num * mult + 0.5) / mult
end

local HealBot_MsgUpdateAvail=nil
local hbMajor, hbMinor, hbPatch, hbHealbot = string.split(".", HEALBOT_VERSION)
local hbVersionChecked = {}
function HealBot_Comms_CheckVer(userName, version)
    if not hbVersionChecked[userName] then
        local tNewVer=nil
        hbVersionChecked[userName]=true
        local tMajor, tMinor, tPatch, tHealbot = string.split(".", version)
        if tonumber(tMajor)>tonumber(hbMajor) then 
            tNewVer=true
        elseif tonumber(tMajor)==tonumber(hbMajor) and tonumber(tMinor)>tonumber(hbMinor) then 
            tNewVer=true
        elseif tonumber(tMajor)==tonumber(hbMajor) and tonumber(tMinor)==tonumber(hbMinor) and tonumber(tPatch)>tonumber(hbPatch) then 
            tNewVer=true
        elseif tonumber(tMajor)==tonumber(hbMajor) and tonumber(tMinor)==tonumber(hbMinor) and tonumber(tPatch)==tonumber(hbPatch) and tonumber(tHealbot)>tonumber(hbHealbot) then 
            tNewVer=true
        end
        if tNewVer then
            hbMajor=tMajor
            hbMinor=tMinor
            hbPatch=tPatch
            hbHealbot=tHealbot
            if not HealBot_Globals.OneTimeMsg["VERSION"] then
                HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_NEWVERSION1)
                HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_NEWVERSION2)
				HealBot_Globals.OneTimeMsg["VERSION"]=true
            end
            HealBot_MsgUpdateAvail = hbMajor.."."..hbMinor.."."..hbPatch.."."..hbHealbot
        end
        HealBot_setOptions_Timer(195)
    end
end

function HealBot_Comms_MacroSuppressError()
    if HealBot_Globals.MacroSuppressError==1 then
        HealBot_Info_SuppressErrorsVal:SetText("ON")
        HealBot_Info_SuppressErrorsVal:SetTextColor(0.1,1,0.1)
    else
        HealBot_Info_SuppressErrorsVal:SetText("OFF")
        HealBot_Info_SuppressErrorsVal:SetTextColor(0.88,0.1,0.1)
    end
end

function HealBot_Comms_MacroSuppressSound()
    if HealBot_Globals.MacroSuppressSound==1 then
        HealBot_Info_SuppressSoundsVal:SetText("ON")
        HealBot_Info_SuppressSoundsVal:SetTextColor(0.1,1,0.1)
    else
        HealBot_Info_SuppressSoundsVal:SetText("OFF")
        HealBot_Info_SuppressSoundsVal:SetTextColor(0.88,0.1,0.1)
    end
end    
