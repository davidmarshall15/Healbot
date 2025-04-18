local HealBotcommAddonSummary={}
local HealBotAddonSummaryNoCommsCPU={}
local HealBotAddonSummaryNoCommsMem={}
local HealBotAddonSummaryNoCommsSort={}
local _

local qAddonMsg={}
function HealBot_Comms_SendAddonMsg(msg, aType, pName)
      --HealBot_setCall("HealBot_Comms_SendAddonMsg")
    local aMsg=""
    if pName then
        aMsg=msg.."~"..aType.."~"..pName
    else
        aMsg=msg.."~"..aType
    end
    local unique=true;
    table.foreach(qAddonMsg, function (index,msg)
        if msg == aMsg then unique=false; end
    end)
    if unique then
        table.insert(qAddonMsg,aMsg)
    end
end

function HealBot_Comms_Set()
      --HealBot_setCall("HealBot_Comms_Set")
    local inInst,inType=HealBot_ZoneType()
    HealBot_Comms_SendTo(inInst,inType)
    HealBot_Comms_GuildUpdate()
end

local hbCommsTo,hbInInst=0,false
function HealBot_Comms_SendTo(inInst,inType)
      --HealBot_setCall("HealBot_Comms_SendTo")
    local lastCommsTo=hbCommsTo
    hbInInst=inInst
    if (IsInGroup(LE_PARTY_CATEGORY_INSTANCE) or IsInRaid(LE_PARTY_CATEGORY_INSTANCE) or inType == "pvp" or inType == "arena" or HasLFGRestrictions()) then
        hbCommsTo=1
    elseif IsInRaid() then
        hbCommsTo=2
    elseif IsInGroup() then
        hbCommsTo=3
    else
        hbCommsTo=0
    end
    if lastCommsTo~=hbCommsTo then
        HealBot_Timers_Set("LAST","CheckVersions",true,true)
    end
    HealBot_AddDebug("INFO: Comms is "..hbCommsTo,"Comms",true)
end

local hbInGuild=false
function HealBot_Comms_GuildUpdate()
      --HealBot_setCall("HealBot_Comms_GuildUpdate")
    hbInGuild=IsInGuild()
end

function HealBot_Comms_SendInstantMsg(msg,toPlayer,toSay,toYell)
      --HealBot_setCall("HealBot_Comms_SendInstantMsg")
    if toPlayer then
        SendChatMessage(msg,"WHISPER",nil,toPlayer)
        HealBot_AddDebug(" == SENT--: Whisper to "..toPlayer,"Comms",true)
    elseif toSay then
        if hbInInst then
            SendChatMessage(msg,"SAY",nil,nil)
        else
            HealBot_AddChat(msg)
        end
    elseif toYell then
        if hbInInst then
            SendChatMessage(msg,"YELL",nil,nil)
        else
            HealBot_AddChat(msg)
        end
    elseif hbCommsTo == 1 then
        SendChatMessage(msg,"INSTANCE_CHAT",nil,nil)
    elseif hbCommsTo == 2 then
        SendChatMessage(msg,"RAID",nil,nil)
    elseif hbCommsTo == 3 then
        SendChatMessage(msg,"PARTY",nil,nil)
    end
end

function HealBot_Comms_SendInstantAddonMsg(msg,notGroup,toPlayer)
      --HealBot_setCall("HealBot_Comms_SendInstantAddonMsg")
    if notGroup then
        if toPlayer then
            C_ChatInfo.SendAddonMessage(HEALBOT_HEALBOT, msg, "WHISPER", toPlayer)
        elseif hbInGuild then
            C_ChatInfo.SendAddonMessage(HEALBOT_HEALBOT, msg, "GUILD")
        end
    elseif hbCommsTo == 1 then
        C_ChatInfo.SendAddonMessage(HEALBOT_HEALBOT, msg, "INSTANCE_CHAT")
    elseif hbCommsTo == 2 then
        C_ChatInfo.SendAddonMessage(HEALBOT_HEALBOT, msg, "RAID")
    elseif hbCommsTo == 3 then
        C_ChatInfo.SendAddonMessage(HEALBOT_HEALBOT, msg, "PARTY")
    end
end

function HealBot_Comms_SendAddonMessage()
      --HealBot_setCall("HealBot_Comms_SendAddonMessage")
    if #qAddonMsg>0 then
        local aMsg=qAddonMsg[1]
        table.remove(qAddonMsg,1)
        HealBot_AddDebug("SEND: "..aMsg,"Comms",true)
        
        local msg, aType, pName=string.split("~", aMsg)
        aType=tonumber(aType)
        if aType == 1 then
            HealBot_Comms_SendInstantAddonMsg(msg)
        elseif aType == 2 and pName then
            local xUnit=HealBot_Panel_RaidUnitName(pName)
            if xUnit and UnitExists(xUnit) and UnitIsConnected(xUnit) and UnitIsPlayer(xUnit) and UnitName(xUnit) == pName then
                HealBot_Comms_SendInstantAddonMsg(msg,true,pName)
            end
        elseif aType == 3 then
            HealBot_Comms_SendInstantAddonMsg(msg,true)
        end
    end
end

function HealBot_Comms_GetChan(chan)
      --HealBot_setCall("HealBot_Comms_GetChan")
    if GetChannelName(chan)>0 then
        return GetChannelName(chan);
    else
        return nil;
    end
end

local function HealBot_Comms_Print_IncHealsSum(sender_id,addon_id,HealsCnt,linenum)
      --HealBot_setCall("HealBot_Comms_Print_IncHealsSum")
    HealBot_Options_SetLabel("HBIncH"..linenum.."Healer",sender_id)
    HealBot_Options_SetLabel("HBIncH"..linenum.."Ver",addon_id)
end

local hbcommver={}
function HealBot_Comms_PlayerVersion(name, version)
    hbcommver[name]=version
end

function HealBot_Comms_KnownNames(name)
    if name then
        return hbcommver[name]
    else
        return hbcommver
    end
end

function HealBot_Comms_About()
      --HealBot_setCall("HealBot_Comms_About")

    local linenum=1
    for x,v in pairs(hbcommver) do
        if linenum<21 then
            HealBot_Comms_Print_IncHealsSum(x,v,0,linenum)
            linenum=linenum+1
        end
    end

    HealBot_Options_SetLabel("HealBot_Error_Clientx",HEALBOT_WORD_CLIENT..": "..GetLocale())
    if HealBot_Globals.localLang then
        HealBot_Options_SetLabel("HealBot_Error_Versionx",HEALBOT_OPTIONS_LANG..": "..HealBot_Globals.localLang)
    else
        HealBot_Options_SetLabel("HealBot_Error_Versionx",HEALBOT_OPTIONS_LANG..": "..GetLocale())
    end
    HealBot_Options_SetLabel("HealBot_Error_Classx",HEALBOT_WORD_VERSION..": "..HEALBOT_VERSION)
    HealBot_Comms_MacroSuppressError()
    HealBot_Comms_MacroSuppressSound()
end

local sPeople={}
function HealBot_Comms_Print_Supports()
      --HealBot_setCall("HealBot_Comms_Print_Supports")
    if not HEALBOT_CREDITS_PEOPLE[1] then return end
    local b=0
    for x,_ in pairs(sPeople) do
        sPeople[x]=false
    end 
    for x=1,20 do
        local s=HealBot_Globals.LastSupporter+x
        if not HEALBOT_CREDITS_PEOPLE[s] then
            b=b+1
            s=b
            if not HEALBOT_CREDITS_PEOPLE[s] then s=1 end
        end
        if not sPeople[HEALBOT_CREDITS_PEOPLE[s]] then
            HealBot_Options_SetLabel("HBIncH"..x.."Supporter",HEALBOT_CREDITS_PEOPLE[s])
            sPeople[HEALBOT_CREDITS_PEOPLE[s]]=true
        end
    end
    if HEALBOT_CREDITS_PEOPLE[21] then
        HealBot_Globals.LastSupporter=HealBot_Globals.LastSupporter+1
        local s=HealBot_Globals.LastSupporter+1
        if not HEALBOT_CREDITS_PEOPLE[s] then
            HealBot_Globals.LastSupporter=0
        end
    end
end

function HealBot_Comm_round(num, idp)
      --HealBot_setCall("HealBot_Util_Round")
    return HealBot_Util_Round(num, idp)
end

local HealBot_MsgUpdateAvail=nil
local hbMajor, hbMinor, hbPatch, hbHealbot=string.split(".", HEALBOT_VERSION)
local hbVersionChecked={}
function HealBot_Comms_SetVersion()
    hbMajor, hbMinor, hbPatch, hbHealbot=string.split(".", HEALBOT_VERSION)
end
function HealBot_Comms_CheckVer(userName, version)
      --HealBot_setCall("HealBot_Comms_CheckVer")
    if not hbVersionChecked[userName] then
        local tNewVer=nil
        hbVersionChecked[userName]=true
        local tMajor, tMinor, tPatch, tHealbot=string.split(".", version)
        if tonumber(tMajor) == HEALBOT_GAME_VERSION and tMinor ~= "x" then
            if tonumber(tMajor)>tonumber(hbMajor) then 
                tNewVer=true
            elseif tonumber(tMajor) == tonumber(hbMajor) and tonumber(tMinor)>tonumber(hbMinor) then 
                tNewVer=true
            elseif tonumber(tMajor) == tonumber(hbMajor) and tonumber(tMinor) == tonumber(hbMinor) and tonumber(tPatch)>tonumber(hbPatch) then 
                tNewVer=true
            elseif tonumber(tMajor) == tonumber(hbMajor) and tonumber(tMinor) == tonumber(hbMinor) and tonumber(tPatch) == tonumber(hbPatch) and tonumber(tHealbot)>tonumber(hbHealbot) then 
                tNewVer=true
            end
            if tNewVer then
                hbMajor=tMajor
                hbMinor=tMinor
                hbPatch=tPatch
                hbHealbot=tHealbot
                if not HealBot_Globals.OneTimeMsg["VERSION"] then
                    HealBot_AddChat(HEALBOT_CHAT_NEWVERSION1)
                    HealBot_Globals.OneTimeMsg["VERSION"]=true
                end
                HealBot_MsgUpdateAvail=hbMajor.."."..hbMinor.."."..hbPatch.."."..hbHealbot
            end
        end
    end
end

function HealBot_Comms_MacroSuppressError()
      --HealBot_setCall("HealBot_Comms_MacroSuppressError")
    if HealBot_Globals.MacroSuppressError then
        HealBot_Info_SuppressErrorsVal:SetText("ON")
        HealBot_Info_SuppressErrorsVal:SetTextColor(0.1,1,0.1)
    else
        HealBot_Info_SuppressErrorsVal:SetText("OFF")
        HealBot_Info_SuppressErrorsVal:SetTextColor(0.88,0.1,0.1)
    end
end

function HealBot_Comms_MacroSuppressSound()
      --HealBot_setCall("HealBot_Comms_MacroSuppressSound")
    if HealBot_Globals.MacroSuppressSound then
        HealBot_Info_SuppressSoundsVal:SetText("ON")
        HealBot_Info_SuppressSoundsVal:SetTextColor(0.1,1,0.1)
    else
        HealBot_Info_SuppressSoundsVal:SetText("OFF")
        HealBot_Info_SuppressSoundsVal:SetTextColor(0.88,0.1,0.1)
    end
end    

local pCPU=1
function HealBot_Comms_PerfLevel()
      --HealBot_setCall("HealBot_Comms_PerfLevel")
    if HealBot_retLuVars("CPUProfilerOn") then
        HealBot_Info_PerfLevelVal:SetText("WARNING CPU Profiling is turned ON")
        HealBot_Info_PerfLevelVal:SetTextColor(0.98,0.25,0.25)
        HealBot_Info_PerfLevelCPUOff:SetText("Turn Off:   /hb cpu")
        HealBot_Info_PerfLevelCPUOff:SetTextColor(0.98,0.25,0.25)
        HealBot_Timers_SetnProcs(true)
    else
        HealBot_Info_PerfLevelVal:SetText(HealBot_Globals.CPUUsage.."  ["..HealBot_Globals.FPS.."fps]")
        if pCPU~=HealBot_Globals.CPUUsage then
            pCPU=HealBot_Globals.CPUUsage
            HealBot_Debug_PerfUpdate("PerfLevel", HealBot_Globals.CPUUsage)
            if HealBot_Globals.CPUUsage<8 then
                HealBot_Info_PerfLevelVal:SetTextColor(0.98,0.25,0.25)
            elseif HealBot_Globals.CPUUsage<12 then
                HealBot_Info_PerfLevelVal:SetTextColor(0.88,0.88,0.1)
            else
                HealBot_Info_PerfLevelVal:SetTextColor(0.1,1,0.1)
            end
            HealBot_Timers_SetnProcs()
        end
    end
end