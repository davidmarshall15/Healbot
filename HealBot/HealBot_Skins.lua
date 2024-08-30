local frameScale=1
local framePad=1
local bheight=20
local bWidth=120
local pWidth=120
local zWidth=120
local bOutline=1
local btextheight,btextheight2,btextheight3,btextheight4=10,10,10,10
local btextoutline,btextoutline2,btextoutline3,btextoutline4=1,1,1,1
local b,bar,icon,txt,pIcon,expire,count=nil,nil,nil,nil,nil,nil,nil,nil
local Aux1,Aux2,Aux3,Aux4,Aux5,Aux6,Aux7,AuxBelow,AuxAbove,AuxLeft,AuxRight=nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil
local AuxIdx={[1]={},[2]={},[3]={},[4]={},[5]={},[6]={},[7]={},[8]={},[9]={}}
local icon1,expire1,count1,icon51,expire51,count51=nil,nil,nil,nil,nil,nil
local barScale,h,hwidth,hheight,iScale,iZoom,itScale,x,hcpct=nil,nil,nil,nil,nil,nil,nil,nil,nil
local abtSize={[0]=1,[1]=1,[2]=1,[3]=2,[4]=2,[5]=2,[6]=3,[7]=3,[8]=3,[9]=3,[10]=4,[11]=4,[12]=4,[13]=4,[14]=4,[15]=5}
local auxWidth,auxHeight,auxTmp,auxOffsetBelow,auxOffsetLeft,auxOffsetRight=0,0,0,0,0,0
local AuxOverlapOffset=0
local tBarsConcat={}
local erButton=nil
local iAnchors={["ICON"]="", ["BUTTON"]="", ["DOUBLE"]="", ["RELATIVE"]="", ["TXTCOUNT"]="", ["TXTEXPIRE"]="", ["INDSELFCAST"]="", ["TXTEXPIREX"]=1, ["TXTCOUNTX"]=1}
local HealBot_Skins_ColAdjFrames={[1]={},[2]={},[3]={},[4]={},[5]={},[6]={},[7]={},[8]={},[9]={},[10]={}}
local HealBot_Skins_luVars={}
HealBot_Skins_luVars["IconGlowSize"]=2
HealBot_Skins_luVars["ColAdj"]=0

function HealBot_Skins_setLuVars(vName, vValue)
      --HealBot_setCall("HealBot_Skins_setLuVars - "..vName)
    HealBot_Skins_luVars[vName]=vValue
end

function HealBot_Skins_retLuVars(vName)
      --HealBot_setCall("HealBot_Skins_retLuVars - "..vName)
    return HealBot_Skins_luVars[vName]
end

function HealBot_Skins_retColWidth(frame, id)
    if HealBot_Skins_ColAdjFrames[frame][id] then
        --HealBot_AddDebug("HealBot_Skins_ColAdjFrames="..HealBot_Skins_ColAdjFrames[frame][id].." frame="..frame.."  id="..id,"Enemy",true)
        return HealBot_Skins_ColAdjFrames[frame][id]
    else
        --HealBot_AddDebug("HealBot_Skins_ColAdjFrames nil for id "..id,"Enemy",true)
        return 0
    end
end

local indTextures={ [2]=[[Interface\Addons\HealBot\Images\indicator_gold]],
                    [3]=[[Interface\Addons\HealBot\Images\indicator_silver]],
                    [4]=[[Interface\Addons\HealBot\Images\indicator_white]],
                    [5]=[[Interface\Addons\HealBot\Images\indicator_yellow]],
                    [6]=[[Interface\Addons\HealBot\Images\indicator_orange]],
                    [7]=[[Interface\Addons\HealBot\Images\indicator_pink]],
                    [8]=[[Interface\Addons\HealBot\Images\indicator_red]],
                    [9]=[[Interface\Addons\HealBot\Images\indicator_purple]],
                   [10]=[[Interface\Addons\HealBot\Images\indicator_aqua]],
                   [11]=[[Interface\Addons\HealBot\Images\indicator_lime]],
                   [12]=[[Interface\Addons\HealBot\Images\indicator_green]],
                   [13]=[[Interface\Addons\HealBot\Images\indicator_blue]],
                   [14]=[[Interface\Addons\HealBot\Images\indicator_brown]],
                   [15]=[[Interface\Addons\HealBot\Images\indicator_black]],
                   }

local tabconcat=table.concat
local function HealBot_Skins_Concat(elements)
      --HealBot_setCall("HealBot_Skins_Concat")
    return tabconcat(tBarsConcat,"",1,elements)
end

local testBarsOn=false
function HealBot_Skins_isTestBars(state)
      --HealBot_setCall("HealBot_Skins_isTestBars")
    testBarsOn=state
end

local testPowerOn=0
function HealBot_Skins_showPowerCounter(maxPower)
      --HealBot_setCall("HealBot_Skins_showPowerCounter")
    testPowerOn=maxPower
end

function HealBot_Skins_AdjustSpecialBarWidth(button, primary)
      --HealBot_setCall("HealBot_Skins_AdjustSpecialBarWidth", button)
    if button.frame == 10 then
        if primary then
            bWidth=bWidth*(1-HealBot_Skins_GetVar("Enemy", "ENEMYTARGETSIZE"))
            bWidth=bWidth-(Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][button.frame]["CMARGIN"]+bOutline)
            HealBot_Text_setEnemySizeWidth("EnemySizeWidth1", bWidth, HealBot_Skins_GetVar("Enemy", "ENEMYTARGETSIZE"))
            HealBot_Action_SetBackSpecialWidth(button.frame, 0)
        else
            bWidth=bWidth*HealBot_Skins_GetVar("Enemy", "ENEMYTARGETSIZE")
            bWidth=bWidth-bOutline
            HealBot_Text_setEnemySizeWidth("EnemySizeWidth2", bWidth, HealBot_Skins_GetVar("Enemy", "ENEMYTARGETSIZE"))
            HealBot_Action_SetBackSpecialWidth(button.frame, bWidth+Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][button.frame]["CMARGIN"])
        end
    else
        if primary then
            bWidth=bWidth*(1-HealBot_Skins_GetVar("Enemy", "ENEMYTARGETSIZEPLAYERFRAMES"))
            bWidth=bWidth-(Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][button.frame]["CMARGIN"]+bOutline)
            HealBot_Text_setEnemySizeWidth("EnemySizeWidth1", bWidth, HealBot_Skins_GetVar("Enemy", "ENEMYTARGETSIZEPLAYERFRAMES"))
            HealBot_Action_SetBackSpecialWidth(button.frame, 0)
        else
            bWidth=bWidth*HealBot_Skins_GetVar("Enemy", "ENEMYTARGETSIZEPLAYERFRAMES")
            bWidth=bWidth-bOutline
            HealBot_Text_setEnemySizeWidth("EnemySizeWidth2", bWidth, HealBot_Skins_GetVar("Enemy", "ENEMYTARGETSIZEPLAYERFRAMES"))
            HealBot_Action_SetBackSpecialWidth(button.frame, bWidth+Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][button.frame]["CMARGIN"])
        end
    end
end

function HealBot_Skins_ResetSkinWidth(button)
      --HealBot_setCall("HealBot_Skins_ResetSkinWidth", button)
    frameScale=HealBot_Skins_GetFrameVar("Frame", "SCALE", button.frame)
    bWidth=ceil(Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][button.frame]["WIDTH"]*frameScale);
    bOutline=ceil(HealBot_Skins_GetFrameVar("BarCol", "BOUT", button.frame)*frameScale);
    if HealBot_Panel_isSpecialUnit(button.unit)>0 then
        if HealBot_Panel_isSpecialUnit(button.unit) == 1 then
            HealBot_Skins_AdjustSpecialBarWidth(button, true)
        else
            HealBot_Skins_AdjustSpecialBarWidth(button, false)
        end
    end
    button.gref["Bar"]:SetWidth(bWidth)
    button.gref["Back"]:SetWidth(bWidth+(bOutline*2))
    button.gref["InHeal"]:SetWidth(bWidth)
    button.gref["Absorb"]:SetWidth(bWidth)
    button:SetWidth(bWidth)
    auxWidth=0
    for x=1,9 do
        if HealBot_Data_AuxGetBarVar("USE", button.frame, x)>1 and
           HealBot_Data_AuxGetOverlayVar("OVERLAP", button.frame) == 2 and
           HealBot_Data_AuxGetBarVar("ANCHOR", button.frame, x)>2 and
           HealBot_Data_AuxGetBarVar("ANCHOR", button.frame, x)<5 then
            auxTmp=auxWidth
            auxWidth=auxWidth+HealBot_Data_AuxGetBarVar("DEPTH", button.frame, x)
            auxWidth=auxWidth+HealBot_Data_AuxGetBarVar("OFFSET", button.frame, x)
            if auxWidth<auxTmp then auxWidth=auxTmp end
        end
    end
    auxWidth=ceil(auxWidth*frameScale)
    for x=1,9 do
        if HealBot_Data_AuxGetBarVar("USE", button.frame, x)>1 then
            if HealBot_Data_AuxGetBarVar("ANCHOR", button.frame, x)<3 or HealBot_Data_AuxGetBarVar("ANCHOR", button.frame, x)>4 then
                if HealBot_Data_AuxGetOverlayVar("OVERLAP", button.frame) == 2 then
                    button.gref.aux[x]:SetWidth(ceil((bWidth+auxWidth)*HealBot_Data_AuxGetBarVar("SIZE", button.frame, x)))
                else
                    button.gref.aux[x]:SetWidth(ceil(bWidth*HealBot_Data_AuxGetBarVar("SIZE", button.frame, x)))
                end
            else
                button.gref.aux[x]:SetWidth(HealBot_Data_AuxGetBarVar("DEPTH", button.frame, x))
            end
        end
    end
end

function HealBot_Skins_setEmergAnchor(position)
      --HealBot_setCall("HealBot_Skins_setEmergAnchor")
    if position == 1 then
        return "TOPLEFT"
    elseif position == 2 then
        return "BOTTOMLEFT"
    elseif position == 3 then
        return "TOPRIGHT"
    elseif position == 4 then
        return "BOTTOMRIGHT"
    elseif position == 5 then
        return "TOP"
    elseif position == 6 then
        return "LEFT"
    elseif position == 7 then
        return "RIGHT"
    else
        return "BOTTOM"
    end
end

iAnchors["TXTCOUNT"]="TOPLEFT"; iAnchors["TXTEXPIRE"]="BOTTOMRIGHT"; iAnchors["TXTEXPIREX"]=2; iAnchors["TXTCOUNTX"]=-2
function HealBot_Skins_setIconAnchors(onBar, position, extra)
      --HealBot_setCall("HealBot_Skins_setIconAnchors")
    if extra then
        if onBar == 1 then
            if position == 1 then
                iAnchors["ICON"]="LEFT"; iAnchors["BUTTON"]="LEFT";
            elseif position == 2 then
                iAnchors["ICON"]="RIGHT"; iAnchors["BUTTON"]="RIGHT";
            elseif position == 3 then
                iAnchors["ICON"]="TOP"; iAnchors["BUTTON"]="TOP";
            elseif position == 4 then
                iAnchors["ICON"]="BOTTOM"; iAnchors["BUTTON"]="BOTTOM";
            elseif position == 5 then
                iAnchors["ICON"]="TOPLEFT"; iAnchors["BUTTON"]="TOPLEFT";
            elseif position == 6 then
                iAnchors["ICON"]="TOPRIGHT"; iAnchors["BUTTON"]="TOPRIGHT";
            elseif position == 7 then
                iAnchors["ICON"]="BOTTOMLEFT"; iAnchors["BUTTON"]="BOTTOMLEFT";
            else
                iAnchors["ICON"]="BOTTOMRIGHT"; iAnchors["BUTTON"]="BOTTOMRIGHT";
            end
        elseif onBar == 2 then
            if position == 1 then
                iAnchors["ICON"]="RIGHT"; iAnchors["BUTTON"]="LEFT";
            else
                iAnchors["ICON"]="LEFT"; iAnchors["BUTTON"]="RIGHT";
            end
        else
            if position == 1 then
                iAnchors["ICON"]="TOPLEFT"; iAnchors["BUTTON"]="BOTTOMLEFT";
            elseif position == 2 then
                iAnchors["ICON"]="TOPRIGHT"; iAnchors["BUTTON"]="BOTTOMRIGHT";
            else
                iAnchors["ICON"]="TOP"; iAnchors["BUTTON"]="BOTTOM";
            end
        end
    else
        if onBar == 1 then
            if position == 1 then
                iAnchors["ICON"]="BOTTOMLEFT"; iAnchors["BUTTON"]="BOTTOMLEFT"; iAnchors["DOUBLE"]="TOPLEFT"; iAnchors["RELATIVE"]="BOTTOMRIGHT";
            --    iAnchors["TXTCOUNT"]="TOPRIGHT"; iAnchors["TXTEXPIRE"]="BOTTOMLEFT"; iAnchors["TXTEXPIREX"]=-2; iAnchors["TXTCOUNTX"]=2
                if HealBot_Skins_GetFrameVar("Indicators", "SANCHOR", b.frame) == 1 then
                    iAnchors["INDSELFCAST"]="TOPLEFT"
                else
                    iAnchors["INDSELFCAST"]="BOTTOMRIGHT"
                end
            elseif position == 2 then
                iAnchors["ICON"]="BOTTOMRIGHT"; iAnchors["BUTTON"]="BOTTOMRIGHT"; iAnchors["DOUBLE"]="TOPRIGHT"; iAnchors["RELATIVE"]="BOTTOMLEFT";
            --    iAnchors["TXTCOUNT"]="TOPLEFT"; iAnchors["TXTEXPIRE"]="BOTTOMRIGHT"; iAnchors["TXTEXPIREX"]=2; iAnchors["TXTCOUNTX"]=-1
                if HealBot_Skins_GetFrameVar("Indicators", "SANCHOR", b.frame) == 1 then
                    iAnchors["INDSELFCAST"]="TOPRIGHT"
                else
                    iAnchors["INDSELFCAST"]="BOTTOMLEFT"
                end
            elseif position == 3 then
                iAnchors["ICON"]="TOPLEFT"; iAnchors["BUTTON"]="TOPLEFT"; iAnchors["DOUBLE"]="BOTTOMLEFT"; iAnchors["RELATIVE"]="TOPRIGHT";
            --    iAnchors["TXTCOUNT"]="TOPRIGHT"; iAnchors["TXTEXPIRE"]="BOTTOMLEFT"; iAnchors["TXTEXPIREX"]=-2; iAnchors["TXTCOUNTX"]=2
                if HealBot_Skins_GetFrameVar("Indicators", "SANCHOR", b.frame) == 1 then
                    iAnchors["INDSELFCAST"]="TOPLEFT"
                else
                    iAnchors["INDSELFCAST"]="BOTTOMRIGHT"
                end
            elseif position == 4 then
                iAnchors["ICON"]="TOPRIGHT"; iAnchors["BUTTON"]="TOPRIGHT"; iAnchors["DOUBLE"]="BOTTOMRIGHT"; iAnchors["RELATIVE"]="TOPLEFT";
            --    iAnchors["TXTCOUNT"]="TOPLEFT"; iAnchors["TXTEXPIRE"]="BOTTOMRIGHT"; iAnchors["TXTEXPIREX"]=2; iAnchors["TXTCOUNTX"]=-1
                if HealBot_Skins_GetFrameVar("Indicators", "SANCHOR", b.frame) == 1 then
                    iAnchors["INDSELFCAST"]="TOPRIGHT"
                else
                    iAnchors["INDSELFCAST"]="BOTTOMLEFT"
                end
            elseif position == 5 then
                iAnchors["ICON"]="BOTTOMRIGHT"; iAnchors["BUTTON"]="BOTTOM"; iAnchors["DOUBLE"]="TOPRIGHT"; iAnchors["RELATIVE"]="BOTTOMLEFT";
            --    iAnchors["TXTCOUNT"]="TOPLEFT"; iAnchors["TXTEXPIRE"]="BOTTOMRIGHT"; iAnchors["TXTEXPIREX"]=2; iAnchors["TXTCOUNTX"]=-1
                if HealBot_Skins_GetFrameVar("Indicators", "SANCHOR", b.frame) == 1 then
                    iAnchors["INDSELFCAST"]="TOPRIGHT"
                else
                    iAnchors["INDSELFCAST"]="BOTTOMLEFT"
                end
            elseif position == 6 then
                iAnchors["ICON"]="BOTTOMLEFT"; iAnchors["BUTTON"]="BOTTOM"; iAnchors["DOUBLE"]="TOPLEFT"; iAnchors["RELATIVE"]="BOTTOMRIGHT";
            --    iAnchors["TXTCOUNT"]="TOPRIGHT"; iAnchors["TXTEXPIRE"]="BOTTOMLEFT"; iAnchors["TXTEXPIREX"]=-2; iAnchors["TXTCOUNTX"]=2
                if HealBot_Skins_GetFrameVar("Indicators", "SANCHOR", b.frame) == 1 then
                    iAnchors["INDSELFCAST"]="TOPLEFT"
                else
                    iAnchors["INDSELFCAST"]="BOTTOMRIGHT"
                end
            elseif position == 7 then
                iAnchors["ICON"]="TOPRIGHT"; iAnchors["BUTTON"]="TOP"; iAnchors["DOUBLE"]="BOTTOMRIGHT"; iAnchors["RELATIVE"]="TOPLEFT";
            --    iAnchors["TXTCOUNT"]="TOPLEFT"; iAnchors["TXTEXPIRE"]="BOTTOMRIGHT"; iAnchors["TXTEXPIREX"]=2; iAnchors["TXTCOUNTX"]=-1
                if HealBot_Skins_GetFrameVar("Indicators", "SANCHOR", b.frame) == 1 then
                    iAnchors["INDSELFCAST"]="TOPRIGHT"
                else
                    iAnchors["INDSELFCAST"]="BOTTOMLEFT"
                end
            else
                iAnchors["ICON"]="TOPLEFT"; iAnchors["BUTTON"]="TOP"; iAnchors["DOUBLE"]="BOTTOMLEFT"; iAnchors["RELATIVE"]="TOPRIGHT";
            --    iAnchors["TXTCOUNT"]="TOPRIGHT"; iAnchors["TXTEXPIRE"]="BOTTOMLEFT"; iAnchors["TXTEXPIREX"]=-2; iAnchors["TXTCOUNTX"]=2
                if HealBot_Skins_GetFrameVar("Indicators", "SANCHOR", b.frame) == 1 then
                    iAnchors["INDSELFCAST"]="TOPLEFT"
                else
                    iAnchors["INDSELFCAST"]="BOTTOMRIGHT"
                end
            end
        elseif onBar == 2 then
            if position == 1 then
                iAnchors["ICON"]="BOTTOMRIGHT"; iAnchors["BUTTON"]="BOTTOMLEFT"; iAnchors["DOUBLE"]="TOPRIGHT"; iAnchors["RELATIVE"]="BOTTOMLEFT";
            --    iAnchors["TXTCOUNT"]="TOPLEFT"; iAnchors["TXTEXPIRE"]="BOTTOMRIGHT"; iAnchors["TXTEXPIREX"]=2; iAnchors["TXTCOUNTX"]=-1
                if HealBot_Skins_GetFrameVar("Indicators", "SANCHOR", b.frame) == 1 then
                    iAnchors["INDSELFCAST"]="TOPRIGHT"
                else
                    iAnchors["INDSELFCAST"]="BOTTOMLEFT"
                end
            elseif position == 2 then
                iAnchors["ICON"]="BOTTOMLEFT"; iAnchors["BUTTON"]="BOTTOMRIGHT"; iAnchors["DOUBLE"]="TOPLEFT"; iAnchors["RELATIVE"]="BOTTOMRIGHT";
            --    iAnchors["TXTCOUNT"]="TOPRIGHT"; iAnchors["TXTEXPIRE"]="BOTTOMLEFT"; iAnchors["TXTEXPIREX"]=-2; iAnchors["TXTCOUNTX"]=2
                if HealBot_Skins_GetFrameVar("Indicators", "SANCHOR", b.frame) == 1 then
                    iAnchors["INDSELFCAST"]="TOPLEFT"
                else
                    iAnchors["INDSELFCAST"]="BOTTOMRIGHT"
                end
            elseif position == 3 then
                iAnchors["ICON"]="TOPRIGHT"; iAnchors["BUTTON"]="TOPLEFT"; iAnchors["DOUBLE"]="BOTTOMRIGHT"; iAnchors["RELATIVE"]="TOPLEFT";
            --    iAnchors["TXTCOUNT"]="TOPLEFT"; iAnchors["TXTEXPIRE"]="BOTTOMRIGHT";  iAnchors["TXTEXPIREX"]=2; iAnchors["TXTCOUNTX"]=-1
                if HealBot_Skins_GetFrameVar("Indicators", "SANCHOR", b.frame) == 1 then
                    iAnchors["INDSELFCAST"]="TOPRIGHT"
                else
                    iAnchors["INDSELFCAST"]="BOTTOMLEFT"
                end
            else
                iAnchors["ICON"]="TOPLEFT"; iAnchors["BUTTON"]="TOPRIGHT"; iAnchors["DOUBLE"]="BOTTOMLEFT"; iAnchors["RELATIVE"]="TOPRIGHT";
            --    iAnchors["TXTCOUNT"]="TOPRIGHT"; iAnchors["TXTEXPIRE"]="BOTTOMLEFT"; iAnchors["TXTEXPIREX"]=-2; iAnchors["TXTCOUNTX"]=2
                if HealBot_Skins_GetFrameVar("Indicators", "SANCHOR", b.frame) == 1 then
                    iAnchors["INDSELFCAST"]="TOPLEFT"
                else
                    iAnchors["INDSELFCAST"]="BOTTOMRIGHT"
                end
            end
        else
            if position == 1 then
                iAnchors["ICON"]="TOPLEFT"; iAnchors["BUTTON"]="BOTTOMLEFT"; iAnchors["DOUBLE"]="BOTTOMLEFT"; iAnchors["RELATIVE"]="TOPRIGHT";
            --    iAnchors["TXTCOUNT"]="TOPRIGHT"; iAnchors["TXTEXPIRE"]="BOTTOMLEFT"; iAnchors["TXTEXPIREX"]=-2; iAnchors["TXTCOUNTX"]=2
                if HealBot_Skins_GetFrameVar("Indicators", "SANCHOR", b.frame) == 1 then
                    iAnchors["INDSELFCAST"]="TOPLEFT"
                else
                    iAnchors["INDSELFCAST"]="BOTTOMRIGHT"
                end
            else
                iAnchors["ICON"]="TOPRIGHT"; iAnchors["BUTTON"]="BOTTOMRIGHT"; iAnchors["DOUBLE"]="BOTTOMRIGHT"; iAnchors["RELATIVE"]="TOPLEFT";
            --    iAnchors["TXTCOUNT"]="TOPLEFT"; iAnchors["TXTEXPIRE"]="BOTTOMRIGHT"; iAnchors["TXTEXPIREX"]=2; iAnchors["TXTCOUNTX"]=-1
                if HealBot_Skins_GetFrameVar("Indicators", "SANCHOR", b.frame) == 1 then
                    iAnchors["INDSELFCAST"]="TOPRIGHT"
                else
                    iAnchors["INDSELFCAST"]="BOTTOMLEFT"
                end
            end
        end
    end
end

function HealBot_Skins_setIconSpacer(anchor, space)
      --HealBot_setCall("HealBot_Skins_setIconSpacer")
    if anchor == 2 or anchor == 4 or anchor == 5 or anchor == 7 then
        iAnchors["ICONHSPACE"]=0-space
    else
        iAnchors["ICONHSPACE"]=space
    end
    if anchor == 3 or anchor == 4 or anchor == 7 or anchor == 8 then
        iAnchors["ICONVSPACE"]=0-space
    else
        iAnchors["ICONVSPACE"]=space
    end
end

local indOffset=0
function HealBot_Skins_IndicatorVOffset(anchor, offset, frame)
      --HealBot_setCall("HealBot_Skins_IndicatorVOffset")
    if anchor == 1 or anchor == 5 or anchor == 7 then
        indOffset=0+offset
    else
        indOffset=0-offset
    end
    return ceil(indOffset*HealBot_Skins_GetFrameVar("Frame", "SCALE", frame))
end

function HealBot_Skins_UpdateIconGlowSize(b, id)
    if HealBot_Globals.UseIconCommands then
        b.gref.iconf[id]:EnableMouse(true)
    else
        b.gref.iconf[id]:EnableMouse(false)
        if (HealBot_Globals.Tooltip_ShowBuffIconInfo and id<20) or (HealBot_Globals.Tooltip_ShowDebuffIconInfo and id>50 and id<70) then
            b.gref.iconf[id]:EnableMouseMotion(true)
        else
            b.gref.iconf[id]:EnableMouseMotion(false)
        end
    end
    if b.gref.iconf[id].size~=HealBot_Skins_luVars["IconGlowSize"] then
        b.gref.iconf[id].size=HealBot_Skins_luVars["IconGlowSize"]
        b.gref.iconf[id]:SetBackdrop({edgeFile="Interface\\Buttons\\WHITE8X8",
                                      edgeSize=b.gref.iconf[id].size,
                                      insets={ left=0, right=0, top=0, bottom=0}})
        b.gref.iconf[id]:SetBackdropBorderColor(0, 0, 0, 0)
    end
end

function HealBot_Skins_UpdateBuffIcon(b, id, set)
    if Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][b.frame][set]["BUFFDOUBLE"] then
        iScale=floor(((bheight*Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][b.frame][set]["BSCALE"])-2)*0.485)
    else
        iScale=(bheight*Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][b.frame][set]["BSCALE"])-2
    end
    iZoom=Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][b.frame][set]["BZOOM"] or 0
    b.gref.icon[id]:SetHeight(iScale);
    b.gref.icon[id]:SetWidth(iScale);
    b.gref.icon[id]:SetTexCoord(iZoom,1-iZoom,iZoom,1-iZoom)
    HealBot_Media_UpdateFont(b.gref.txt.expire[id],
                             HealBot_Skins_GetIconTextVar("BUFFFONT", b.frame, set),
                             HealBot_Skins_GetIconTextVar("BUFFHEIGHT", b.frame, set),
                             HealBot_Skins_GetIconTextVar("BUFFOUTLINE", b.frame, set),
                             "Skins_ResetSkin - IconSetsText")
    HealBot_Media_UpdateFont(b.gref.txt.count[id],
                             HealBot_Skins_GetIconTextVar("BUFFFONT", b.frame, set),
                             HealBot_Skins_GetIconTextVar("BUFFHEIGHT", b.frame, set),
                             HealBot_Skins_GetIconTextVar("BUFFOUTLINE", b.frame, set),
                             "Skins_ResetSkin - IconSetsText")
    b.gref.iconf[id]:SetHeight(iScale)
    b.gref.iconf[id]:SetWidth(iScale)
    HealBot_Skins_UpdateIconGlowSize(b, id)
end

function HealBot_Skins_UpdateDebuffIcon(b, id, set)
    if Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][b.frame][set]["DEBUFFDOUBLE"] then
        iScale=floor(((bheight*Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][b.frame][1]["DSCALE"])-2)*0.485)
    else
        iScale=(bheight*Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][b.frame][set]["DSCALE"])-2
    end
    iZoom=Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][b.frame][set]["DZOOM"] or 0
    b.gref.icon[id]:SetHeight(iScale);
    b.gref.icon[id]:SetWidth(iScale);
    b.gref.icon[id]:SetTexCoord(iZoom,1-iZoom,iZoom,1-iZoom)
    HealBot_Media_UpdateFont(b.gref.txt.expire[id],
                             HealBot_Skins_GetIconTextVar("DBFONT", b.frame, set),
                             HealBot_Skins_GetIconTextVar("DBHEIGHT", b.frame, set),
                             HealBot_Skins_GetIconTextVar("DBOUTLINE", b.frame, set),
                             "Skins_ResetSkin - IconSetsText")
    HealBot_Media_UpdateFont(b.gref.txt.count[id],
                             HealBot_Skins_GetIconTextVar("DBFONT", b.frame, set),
                             HealBot_Skins_GetIconTextVar("DBHEIGHT", b.frame, set),
                             HealBot_Skins_GetIconTextVar("DBOUTLINE", b.frame, set),
                             "Skins_ResetSkin - IconSetsText")
    b.gref.iconf[id]:SetHeight(iScale)
    b.gref.iconf[id]:SetWidth(iScale)
    HealBot_Skins_UpdateIconGlowSize(b, id)
end

local tmpHeightOffset=0
function HealBot_Skins_ResetSkin(barType,button,numcols)
      --HealBot_setCall("HealBot_Skins_Check", button)
    if button and button.frame then
        frameScale=HealBot_Skins_GetFrameVar("Frame", "SCALE", button.frame)
        framePad=HealBot_Skins_GetFrameVar("Frame", "PADDING", button.frame)
        bheight=ceil(Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][button.frame]["HEIGHT"]*frameScale);
        bWidth=ceil(Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][button.frame]["WIDTH"]*frameScale);
        bOutline=ceil(HealBot_Skins_GetFrameVar("BarCol", "BOUT", button.frame)*frameScale);
        btextheight=ceil(Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["HEIGHT"]*frameScale);
        btextheight2=ceil(Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["HHEIGHT"]*frameScale)
        btextheight3=ceil(Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["SHEIGHT"]*frameScale)
        btextheight4=ceil(Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["AHEIGHT"]*frameScale)
        btextoutline=Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["OUTLINE"];
        btextoutline2=Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["HOUTLINE"]
        btextoutline3=Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["SOUTLINE"]
        btextoutline4=Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["AOUTLINE"]
        auxHeight=0
        auxWidth=0
        auxOffsetBelow=0
        auxOffsetLeft=0
        auxOffsetRight=0

        for x=1,9 do
            if HealBot_Data_AuxGetBarVar("USE", button.frame, x)>1 then
                --if HealBot_Data_AuxGetBarVar("ANCHOR", button.framecol, x) == 9 then
                --    button.aux[x].sticky=true
                --else
                --    button.aux[x].sticky=false
                    if HealBot_Data_AuxGetBarVar("DEPTH", button.frame, x)+HealBot_Data_AuxGetBarVar("OFFSET", button.frame, x)>0 then
                        auxTmp=HealBot_Data_AuxGetBarVar("DEPTH", button.frame, x)+HealBot_Data_AuxGetBarVar("OFFSET", button.frame, x)
                    else
                        auxTmp=0
                    end
                    if HealBot_Data_AuxGetBarVar("ANCHOR", button.frame, x)<3 or HealBot_Data_AuxGetBarVar("ANCHOR", button.frame, x)>4 then
                        if HealBot_Data_AuxGetBarVar("ANCHOR", button.frame, x) == 1 or
                           HealBot_Data_AuxGetBarVar("ANCHOR", button.frame, x) == 5 or
                           HealBot_Data_AuxGetBarVar("ANCHOR", button.frame, x) == 6 then
                            auxOffsetBelow=auxOffsetBelow+auxTmp
                        end
                        auxHeight=auxHeight+auxTmp
                    else
                        if HealBot_Data_AuxGetBarVar("ANCHOR", button.frame, x) == 3 then
                            auxOffsetLeft=auxOffsetLeft+auxTmp
                        else
                            auxOffsetRight=auxOffsetRight+auxTmp
                        end
                        auxWidth=auxWidth+auxTmp
                    end
                --end
            end
        end
        if auxHeight<0 then auxHeight=0 end
        if auxWidth<0 then auxWidth=0 end
        if auxOffsetBelow<0 then auxOffsetBelow=0 end
        if auxOffsetRight<0 then auxOffsetRight=0 end
        auxOffsetBelow=ceil(auxOffsetBelow*frameScale)
        auxOffsetLeft=ceil(auxOffsetLeft*frameScale)
        auxOffsetRight=ceil(auxOffsetRight*frameScale)
        auxHeight=ceil(auxHeight*frameScale)
        auxWidth=ceil(auxWidth*frameScale)
    end

    if button then
        pWidth=bWidth
        zWidth=bWidth
        if button.frame == 10 then
            if HealBot_Panel_isSpecialUnit(button.unit)>0 then
                if HealBot_Panel_isSpecialUnit(button.unit) == 1 then
                    HealBot_Skins_AdjustSpecialBarWidth(button, true)
                else
                    HealBot_Skins_AdjustSpecialBarWidth(button, false)
                end
            end
        elseif HealBot_Panel_isSpecialPlayerUnit(button.unit)>1 then
            bWidth=ceil(bWidth*HealBot_Skins_GetVar("Enemy", "PLAYERTARGETSIZE"))
            if HealBot_Panel_isSpecialPlayerUnit(button.unit)>2 then
                if HealBot_Panel_isSpecialPlayerUnit(button.unit) == 3 then
                    HealBot_Skins_AdjustSpecialBarWidth(button, true)
                else
                    HealBot_Skins_AdjustSpecialBarWidth(button, false)
                end
            end
        end
    end

    if barType == "bar" then
        b=button
        if b.skinreset or b.enemyreset then
            if button.frame<10 and HealBot_Panel_isSpecialPlayerUnit(button.unit)>1 then
                pWidth=ceil(zWidth*HealBot_Skins_GetVar("Enemy", "PLAYERTARGETSIZE"))
                pWidth=pWidth+(bOutline*2)+auxWidth+Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][button.frame]["CMARGIN"]
                HealBot_Skins_ColAdjFrames[button.frame][button.id]=pWidth
                pWidth=pWidth+zWidth
             --   HealBot_Skins_ColAdjFrames[button.frame][button.id]=pWidth-zWidth
            else
                HealBot_Skins_ColAdjFrames[button.frame][button.id]=0
            end

            if HealBot_Action_SetBackBarHeightWidth(button.frame, (bheight+auxHeight+(bOutline*2)), (pWidth+auxWidth+(bOutline*2)), framePad, (zWidth+auxWidth+(bOutline*2))) then
                b.auxreset=true
            end

            b.enemyreset=false
--HealBot_AddDebug("Width  unit="..b.unit.."  pWidth="..pWidth.."  bWidth="..bWidth,"Enemy",true)
        end
        if b.skinreset then
            b.height=bheight
            b:SetHeight(bheight);
            b.width=bWidth
            b:SetWidth(bWidth)
            b.gref["Bar"]:SetHeight(bheight);
            b.gref["Bar"]:SetWidth(bWidth)
            b.gref["Top"]:SetHeight(bheight)
            b.gref["Top"]:SetWidth(bWidth)
            b.gref["IconTop"]:SetHeight(bheight)
            b.gref["IconTop"]:SetWidth(bWidth)

            b.gref["Back"]:SetHeight(bheight+auxHeight+(bOutline*2))
            b.gref["Back"]:SetWidth(bWidth+auxWidth+(bOutline*2))
            b.gref["InHeal"]:SetHeight(bheight);
            b.gref["InHeal"]:SetWidth(bWidth)
            b.gref["Absorb"]:SetHeight(bheight);
            b.gref["Absorb"]:SetWidth(bWidth)

            HealBot_Media_UpdateTexture(b.gref["InHeal"], Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][b.frame]["TEXTURE"], "Skins_ResetSkin - HealBar")
            b.gref["InHeal"]:GetStatusBarTexture():SetHorizTile(false)
            HealBot_Media_UpdateTexture(b.gref["Absorb"], Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][b.frame]["TEXTURE"], "Skins_ResetSkin - HealBar")
            b.gref["Absorb"]:GetStatusBarTexture():SetHorizTile(false)

            if Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][b.frame]["OFIX"] == 1 then
                b.gref["Bar"]:SetOrientation("HORIZONTAL");
                b.gref["InHeal"]:SetOrientation("HORIZONTAL");
                b.gref["Back"]:SetOrientation("HORIZONTAL");
                b.gref["Absorb"]:SetOrientation("HORIZONTAL");
            else
                b.gref["Bar"]:SetOrientation("VERTICAL");
                b.gref["InHeal"]:SetOrientation("VERTICAL");
                b.gref["Back"]:SetOrientation("VERTICAL");
                b.gref["Absorb"]:SetOrientation("VERTICAL");
            end

            erButton=HealBot_Emerg_Button[b.id]
            if b.frame<10 and Healbot_Config_Skins.Emerg[Healbot_Config_Skins.Current_Skin][b.frame]["USE"] then
                erButton.bar:SetHeight(ceil(bheight*Healbot_Config_Skins.Emerg[Healbot_Config_Skins.Current_Skin][b.frame]["HEIGHT"]))
                erButton.bar:SetWidth(ceil(bWidth*Healbot_Config_Skins.Emerg[Healbot_Config_Skins.Current_Skin][b.frame]["WIDTH"]))
                erButton:SetHeight(ceil(bheight*Healbot_Config_Skins.Emerg[Healbot_Config_Skins.Current_Skin][b.frame]["HEIGHT"]))
                erButton:SetWidth(ceil(bWidth*Healbot_Config_Skins.Emerg[Healbot_Config_Skins.Current_Skin][b.frame]["WIDTH"]))
                HealBot_Media_UpdateTexture(erButton.bar, Healbot_Config_Skins.Emerg[Healbot_Config_Skins.Current_Skin][b.frame]["TEXTURE"], "Skins_ResetSkin - Emerg")
                erButton.bar:GetStatusBarTexture():SetHorizTile(false)
                erButton:ClearAllPoints()
                erButton:SetPoint(HealBot_Skins_setEmergAnchor(Healbot_Config_Skins.Emerg[Healbot_Config_Skins.Current_Skin][b.frame]["ANCHOR"]),
                                 b.gref["Back"],
                                 HealBot_Skins_setEmergAnchor(Healbot_Config_Skins.Emerg[Healbot_Config_Skins.Current_Skin][b.frame]["ANCHOR"]),
                                 ceil(Healbot_Config_Skins.Emerg[Healbot_Config_Skins.Current_Skin][b.frame]["HOFFSET"]*frameScale),
                                 ceil(Healbot_Config_Skins.Emerg[Healbot_Config_Skins.Current_Skin][b.frame]["VOFFSET"]*frameScale))
                erButton.bar:ClearAllPoints()
                erButton.bar:SetPoint(HealBot_Skins_setEmergAnchor(Healbot_Config_Skins.Emerg[Healbot_Config_Skins.Current_Skin][b.frame]["ANCHOR"]),
                                     b.gref["Back"],
                                     HealBot_Skins_setEmergAnchor(Healbot_Config_Skins.Emerg[Healbot_Config_Skins.Current_Skin][b.frame]["ANCHOR"]),
                                     ceil(Healbot_Config_Skins.Emerg[Healbot_Config_Skins.Current_Skin][b.frame]["HOFFSET"]*frameScale),
                                     ceil(Healbot_Config_Skins.Emerg[Healbot_Config_Skins.Current_Skin][b.frame]["VOFFSET"]*frameScale))
                erButton:SetFrameLevel(b:GetFrameLevel()+20)
                erButton.bar:SetFrameLevel(b.gref["Top"]:GetFrameLevel()-1)
                erButton:EnableMouse(true)
                b.gref["EmergBorder"]:SetBackdrop({edgeFile="Interface\\Buttons\\WHITE8X8",
                                                   edgeSize=HealBot_Skins_luVars["IconGlowSize"],
                                                   insets={ left=0, right=0, top=0, bottom=0}})
                b.gref["EmergBorder"]:SetBackdropBorderColor(0, 0, 0, 0)
                erButton.used=true
                --erButton:Show()
            elseif erButton.used then
                erButton.bar:ClearAllPoints()
                erButton.bar:SetStatusBarColor(0,0,0,0)
                erButton:SetFrameLevel(1)
                erButton.bar:SetFrameLevel(1)
                erButton:EnableMouse(false)
                erButton:Hide()
                erButton.used=false
            end

			-- bgFile="Interface\\Addons\\HealBot\\Images\\WhiteLine",
			-- edgeFile="Interface\\Addons\\HealBot\\Images\\border",
            -- edgeFile="Interface\\Buttons\\WHITE8X8",

            tBarsConcat[1]="f"
            tBarsConcat[2]=b.frame
            tBarsConcat[3]="_HealBot_Action"
            local gaf=_G[HealBot_Skins_Concat(3)]
            HealBot_Media_UpdateTexture(b.gref["Bar"], Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][b.frame]["TEXTURE"], "Skins_ResetSkin - HealBar")
            b.gref["Bar"]:GetStatusBarTexture():SetHorizTile(false)
            b.gref["Bar"]:ClearAllPoints()
            b.gref["Bar"]:SetPoint("BOTTOMLEFT",b.gref["Back"],"BOTTOMLEFT",auxOffsetLeft+bOutline,auxOffsetBelow+bOutline)
            if b.gref["BackBorder"].size~=ceil(HealBot_Skins_GetFrameVar("BarCol", "BORSIZE", b.frame)*frameScale) then
                b.gref["BackBorder"].size=ceil(HealBot_Skins_GetFrameVar("BarCol", "BORSIZE", b.frame)*frameScale)
                b.gref["BackBorder"]:SetBackdrop({
                                            edgeFile="Interface\\Buttons\\WHITE8X8",
                                            edgeSize=b.gref["BackBorder"].size,
                                            })
                b.gref["BackBorder"]:SetPoint("TOPLEFT", b.gref["Back"], "TOPLEFT",0,0)
                b.gref["BackBorder"]:SetPoint("BOTTOMRIGHT", b.gref["Back"], "BOTTOMRIGHT",0,0)
                b.gref["BackBorder"]:SetBackdropBorderColor(0, 0, 0, 0)
            end
            HealBot_Action_UpdateBackgroundBorder(button)

            b.skinreset=false
        end

        if b.auxreset then
            AuxBelow,AuxAbove,AuxLeft,AuxRight=b.gref["Bar"],b.gref["Bar"],b.gref["Bar"],b.gref["Bar"]
            AuxOverlapOffset=0
            for x=1,9 do
                if HealBot_Data_AuxGetBarVar("USE", button.frame, x)>1 then
                    b.gref.aux[x]:ClearAllPoints()
                    if button.aux[x].sticky then
                        b.gref.aux[x]:SetOrientation("VERTICAL")
                        b.gref.aux[x]:SetHeight(ceil(bheight*HealBot_Data_AuxGetBarVar("SIZE", button.frame, x)))
                        if HealBot_Skins_GetFrameVar("Anchors", "BARS", button.frame)<3 then
                            b.gref.aux[x]:SetPoint("RIGHT",b.gref["Back"],"RIGHT",0,0)
                        else
                            b.gref.aux[x]:SetPoint("LEFT",b.gref["Back"],"LEFT",0,0)
                        end
                    elseif HealBot_Data_AuxGetBarVar("ANCHOR", button.frame, x)<5 then
                        if HealBot_Data_AuxGetBarVar("ANCHOR", button.frame, x)<3 then
                            b.gref.aux[x]:SetOrientation("HORIZONTAL")
                            if HealBot_Data_AuxGetOverlayVar("OVERLAP", button.frame) == 2 then
                                b.gref.aux[x]:SetWidth(ceil((bWidth+auxWidth)*HealBot_Data_AuxGetBarVar("SIZE", button.frame, x)))
                              --  AuxOverlapOffset=ceil(((bWidth+auxWidth)*(1-HealBot_Data_AuxGetBarVar("SIZE", button.frame, x)))/2)
                            else
                                b.gref.aux[x]:SetWidth(ceil(bWidth*HealBot_Data_AuxGetBarVar("SIZE", button.frame, x)))
                            end
                            b.gref.aux[x]:SetHeight(ceil(HealBot_Data_AuxGetBarVar("DEPTH", button.frame, x)*frameScale))
                            if HealBot_Data_AuxGetBarVar("ANCHOR", button.frame, x) == 1 then
                                b.gref.aux[x]:SetPoint("TOP",AuxBelow,"BOTTOM",0,-(ceil(HealBot_Data_AuxGetBarVar("OFFSET", button.frame, x))*frameScale))
                                AuxBelow=b.gref.aux[x]
                            else
                                b.gref.aux[x]:SetPoint("BOTTOM",AuxAbove,"TOP",0,ceil(HealBot_Data_AuxGetBarVar("OFFSET", button.frame, x)*frameScale))
                                AuxAbove=b.gref.aux[x]
                            end
                            --if HealBot_Data_AuxGetOverlayVar("OVERLAP", button.frame) == 2 then
                            --    b.gref.aux[x]:SetPoint("RIGHT",b.gref["Back"],"RIGHT",-(bOutline+AuxOverlapOffset),0)
                            --else
                            --    b.gref.aux[x]:SetPoint("CENTER",b.gref["Bar"],"CENTER",0,0)
                            --end
                        else
                            b.gref.aux[x]:SetOrientation("VERTICAL")
                            b.gref.aux[x]:SetWidth(ceil(HealBot_Data_AuxGetBarVar("DEPTH", button.frame, x)*frameScale))
                            if HealBot_Data_AuxGetOverlayVar("OVERLAP", button.frame) == 1 then
                                b.gref.aux[x]:SetHeight(ceil((bheight+auxHeight)*HealBot_Data_AuxGetBarVar("SIZE", button.frame, x)))
                                --b.gref.aux[x]:SetPoint("TOP",b.gref["Back"],"TOP",0,-(bOutline))
                            else
                                b.gref.aux[x]:SetHeight(ceil(bheight*HealBot_Data_AuxGetBarVar("SIZE", button.frame, x)))
                            end
                            if HealBot_Data_AuxGetBarVar("ANCHOR", button.frame, x) == 3 then
                                b.gref.aux[x]:SetPoint("RIGHT",AuxLeft,"LEFT",-(ceil(HealBot_Data_AuxGetBarVar("OFFSET", button.frame, x)*frameScale)),0)
                                AuxLeft=b.gref.aux[x]
                            else
                                b.gref.aux[x]:SetPoint("LEFT",AuxRight,"RIGHT",ceil(HealBot_Data_AuxGetBarVar("OFFSET", button.frame, x)*frameScale),0)
                                AuxRight=b.gref.aux[x]
                            end
                        end
                    else
                        b.gref.aux[x]:SetOrientation("HORIZONTAL")
                        if HealBot_Data_AuxGetOverlayVar("OVERLAP", button.frame) == 2 then
                            b.gref.aux[x]:SetWidth(ceil((bWidth+auxWidth)*HealBot_Data_AuxGetBarVar("SIZE", button.frame, x)))
                        else
                            b.gref.aux[x]:SetWidth(ceil(bWidth*HealBot_Data_AuxGetBarVar("SIZE", button.frame, x)))
                        end
                        b.gref.aux[x]:SetHeight(ceil(HealBot_Data_AuxGetBarVar("DEPTH", button.frame, x)*frameScale))
                        if HealBot_Data_AuxGetBarVar("ANCHOR", button.frame, x) == 5 then
                            b.gref.aux[x]:SetPoint("TOP",AuxBelow,"BOTTOM",0,-(ceil(HealBot_Data_AuxGetBarVar("OFFSET", button.frame, x))*frameScale))
                            if HealBot_Data_AuxGetOverlayVar("OVERLAP", button.frame) == 2 then
                                b.gref.aux[x]:SetPoint("LEFT",b.gref["Bar"],"LEFT",-auxOffsetLeft,0)
                            else
                                b.gref.aux[x]:SetPoint("LEFT",b.gref["Bar"],"LEFT",0,0)
                            end
                            AuxBelow=b.gref.aux[x]
                        elseif HealBot_Data_AuxGetBarVar("ANCHOR", button.frame, x) == 6 then
                            b.gref.aux[x]:SetPoint("TOP",AuxBelow,"BOTTOM",0,-(ceil(HealBot_Data_AuxGetBarVar("OFFSET", button.frame, x))*frameScale))
                            if HealBot_Data_AuxGetOverlayVar("OVERLAP", button.frame) == 2 then
                                b.gref.aux[x]:SetPoint("RIGHT",b.gref["Bar"],"RIGHT",auxOffsetRight,0)
                            else
                                b.gref.aux[x]:SetPoint("RIGHT",b.gref["Bar"],"RIGHT",0,0)
                            end
                            AuxBelow=b.gref.aux[x]
                        elseif HealBot_Data_AuxGetBarVar("ANCHOR", button.frame, x) == 7 then
                            b.gref.aux[x]:SetPoint("BOTTOM",AuxAbove,"TOP",0,ceil(HealBot_Data_AuxGetBarVar("OFFSET", button.frame, x)*frameScale))
                            if HealBot_Data_AuxGetOverlayVar("OVERLAP", button.frame) == 2 then
                                b.gref.aux[x]:SetPoint("LEFT",b.gref["Bar"],"LEFT",-auxOffsetLeft,0)
                            else
                                b.gref.aux[x]:SetPoint("LEFT",b.gref["Bar"],"LEFT",0,0)
                            end
                            AuxAbove=b.gref.aux[x]
                        else
                            b.gref.aux[x]:SetPoint("BOTTOM",AuxAbove,"TOP",0,ceil(HealBot_Data_AuxGetBarVar("OFFSET", button.frame, x)*frameScale))
                            if HealBot_Data_AuxGetOverlayVar("OVERLAP", button.frame) == 2 then
                                b.gref.aux[x]:SetPoint("RIGHT",b.gref["Bar"],"RIGHT",auxOffsetRight,0)
                            else
                                b.gref.aux[x]:SetPoint("RIGHT",b.gref["Bar"],"RIGHT",0,0)
                            end
                            AuxAbove=b.gref.aux[x]
                        end
                    end
                    b.gref.aux[x]:SetMinMaxValues(0,1000)
                    HealBot_Media_UpdateTexture(b.gref.aux[x], Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][b.frame]["TEXTURE"], "Skins_ResetSkin - HealBar")
                    b.gref.aux[x]:GetStatusBarTexture():SetHorizTile(false)
                else
                    b.gref.aux[x]:SetStatusBarColor(0,0,0,0)
                    b.gref.auxtxt[x]:SetText("")
                end
            end
            b.auxreset=false
        end

        if b.text.reset then
            HealBot_Media_UpdateFont(b.gref.txt["text"],
                                     Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.framecol]["FONT"],
                                     btextheight,
                                     btextoutline,
                                     "Skins_ResetSkin - BarText")
            HealBot_Media_UpdateFont(b.gref.txt["text2"],
                                     Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.framecol]["HFONT"],
                                     btextheight2,
                                     btextoutline2,
                                     "Skins_ResetSkin - BarText")
            HealBot_Media_UpdateFont(b.gref.txt["text3"],
                                     Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.framecol]["SFONT"],
                                     btextheight3,
                                     btextoutline3,
                                     "Skins_ResetSkin - BarText")
            HealBot_Media_UpdateFont(b.gref.txt["text4"],
                                     Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.framecol]["AFONT"],
                                     btextheight4,
                                     btextoutline4,
                                     "Skins_ResetSkin - BarText")
            if btextheight2-HealBot_Globals.VehicleFontSizeReduction<2 then
                HealBot_Media_UpdateFont(b.gref.txt["text5"],
                                         Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.framecol]["HFONT"],
                                         2,
                                         btextoutline2,
                                         "Skins_ResetSkin - BarText")
            else
                HealBot_Media_UpdateFont(b.gref.txt["text5"],
                                         Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.framecol]["HFONT"],
                                         btextheight2-HealBot_Globals.VehicleFontSizeReduction,
                                         btextoutline2,
                                         "Skins_ResetSkin - BarText")
            end

            zWidth=ceil(bWidth*1.05)
            b.gref.txt["text"]:SetWidth(zWidth)
            b.gref.txt["text2"]:SetWidth(zWidth)
            b.gref.txt["text3"]:SetWidth(zWidth)
            b.gref.txt["text4"]:SetWidth(zWidth)
            for x=1,9 do
                HealBot_Media_UpdateFont(b.gref.auxtxt[x],
                                         HealBot_Data_AuxGetBarTextVar("FONT", b.framecol, x),
                                         ceil(HealBot_Data_AuxGetBarTextVar("HEIGHT", b.framecol, x)*frameScale),
                                         HealBot_Data_AuxGetBarTextVar("OUTLINE", b.framecol, x),
                                         "Skins_ResetSkin - AuxBarText")
                b.gref.auxtxt[x]:ClearAllPoints();
                b.gref.auxtxt[x]:SetWidth(ceil((zWidth+auxWidth)*HealBot_Data_AuxGetBarVar("SIZE", b.frame, x)))
                if HealBot_Data_AuxGetBarVar("ANCHOR", b.frame, x)<3 or HealBot_Data_AuxGetBarVar("ANCHOR", b.frame, x)>4 then
                    b.gref.auxtxt[x]:SetWordWrap(false)
                else
                    b.gref.auxtxt[x]:SetWordWrap(true)
                end
                if HealBot_Data_AuxGetBarTextVar("ALIGN", b.framecol, x) == 1 then
                    b.gref.auxtxt[x]:SetPoint("LEFT",b.gref.aux[x],"LEFT",ceil(HealBot_Data_AuxGetBarTextVar("HOFFSET", b.framecol, x)*frameScale),ceil(HealBot_Data_AuxGetBarTextVar("OFFSET", b.framecol, x)*frameScale))
                    b.gref.auxtxt[x]:SetJustifyH("LEFT")
                elseif HealBot_Data_AuxGetBarTextVar("ALIGN", b.framecol, x) == 2 then
                    b.gref.auxtxt[x]:SetPoint("CENTER",b.gref.aux[x],"CENTER",ceil(HealBot_Data_AuxGetBarTextVar("HOFFSET", b.framecol, x)*frameScale),ceil(HealBot_Data_AuxGetBarTextVar("OFFSET", b.framecol, x)*frameScale))
                    b.gref.auxtxt[x]:SetJustifyH("CENTER")
                else
                    b.gref.auxtxt[x]:SetPoint("RIGHT",b.gref.aux[x],"RIGHT",ceil(HealBot_Data_AuxGetBarTextVar("HOFFSET", b.framecol, x)*frameScale),ceil(HealBot_Data_AuxGetBarTextVar("OFFSET", b.framecol, x)*frameScale))
                    b.gref.auxtxt[x]:SetJustifyH("RIGHT")
                end
            end
            b.gref.txt["text"]:ClearAllPoints();
            b.gref.txt["text2"]:ClearAllPoints();
            b.gref.txt["text3"]:ClearAllPoints();
            b.gref.txt["text4"]:ClearAllPoints();
            b.gref.txt["text5"]:ClearAllPoints();

            if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.framecol]["ALIGN"] == 1 then
                b.gref.txt["text"]:SetPoint("LEFT",b.gref["Bar"],"LEFT",ceil(Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.framecol]["OFFSET2"]*frameScale),ceil((5+Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.framecol]["OFFSET"])*frameScale))
                b.gref.txt["text"]:SetJustifyH("LEFT")
            elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.framecol]["ALIGN"] == 2 then
                b.gref.txt["text"]:SetPoint("CENTER",b.gref["Bar"],"CENTER",ceil(Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.framecol]["OFFSET2"]*frameScale),ceil((5+Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.framecol]["OFFSET"])*frameScale))
                b.gref.txt["text"]:SetJustifyH("CENTER")
            else
                b.gref.txt["text"]:SetPoint("RIGHT",b.gref["Bar"],"RIGHT",ceil(Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.framecol]["OFFSET2"]*frameScale),ceil((5+Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.framecol]["OFFSET"])*frameScale))
                b.gref.txt["text"]:SetJustifyH("RIGHT")
            end
            if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.framecol]["HLTHTXTANCHOR"]<4 then
                if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.framecol]["HLTHTXTANCHOR"] == 1 then
                b.gref.txt["text2"]:SetPoint("LEFT",b.gref["Bar"],"LEFT",ceil(Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.framecol]["HOFFSET2"]*frameScale),ceil((-7+Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.framecol]["HOFFSET"])*frameScale))
                    b.gref.txt["text2"]:SetJustifyH("LEFT")
                elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.framecol]["HLTHTXTANCHOR"] == 2 then
                b.gref.txt["text2"]:SetPoint("CENTER",b.gref["Bar"],"CENTER",ceil(Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.framecol]["HOFFSET2"]*frameScale),ceil((-7+Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.framecol]["HOFFSET"])*frameScale))
                    b.gref.txt["text2"]:SetJustifyH("CENTER")
                else
                b.gref.txt["text2"]:SetPoint("RIGHT",b.gref["Bar"],"RIGHT",ceil(Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.framecol]["HOFFSET2"]*frameScale),ceil((-7+Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.framecol]["HOFFSET"])*frameScale))
                    b.gref.txt["text2"]:SetJustifyH("RIGHT")
                end
            elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.framecol]["HLTHTXTANCHOR"]>4 then
                b.gref.txt["text2"]:SetPoint("TOP",b.gref.txt["text"],"BOTTOM",ceil(Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.framecol]["HOFFSET2"]*frameScale),ceil((-2+Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.framecol]["HOFFSET"])*frameScale))
                b.gref.txt["text2"]:SetJustifyH(b.gref.txt["text"]:GetJustifyH())
            end
            b.gref.txt["text5"]:SetPoint("TOP",b.gref.txt["text2"],"BOTTOM")
            if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.framecol]["STATETXTANCHOR"]<4 then
                if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.framecol]["STATETXTANCHOR"] == 1 then
                b.gref.txt["text3"]:SetPoint("TOPLEFT",b.gref["Bar"],"TOPLEFT",ceil(Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.framecol]["SOFFSET2"]*frameScale),ceil((-2+Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.framecol]["SOFFSET"])*frameScale))
                    b.gref.txt["text3"]:SetJustifyH("LEFT")
                elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.framecol]["STATETXTANCHOR"] == 2 then
                b.gref.txt["text3"]:SetPoint("TOP",b.gref["Bar"],"TOP",ceil(Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.framecol]["SOFFSET2"]*frameScale),ceil((-2+Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.framecol]["SOFFSET"])*frameScale))
                    b.gref.txt["text3"]:SetJustifyH("CENTER")
                else
                b.gref.txt["text3"]:SetPoint("TOPRIGHT",b.gref["Bar"],"TOPRIGHT",ceil(Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.framecol]["SOFFSET2"]*frameScale),ceil((-2+Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.framecol]["SOFFSET"])*frameScale))
                    b.gref.txt["text3"]:SetJustifyH("RIGHT")
                end
            elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.framecol]["STATETXTANCHOR"]>4 then
                b.gref.txt["text3"]:SetPoint("BOTTOM",b.gref.txt["text"],"TOP",ceil(Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.framecol]["SOFFSET2"]*frameScale),ceil((0+Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.framecol]["SOFFSET"])*frameScale))
                b.gref.txt["text3"]:SetJustifyH(b.gref.txt["text"]:GetJustifyH())
            end
            if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.framecol]["AGGROTXTANCHOR"]<4 then
                if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.framecol]["AGGROTXTANCHOR"] == 1 then
                b.gref.txt["text4"]:SetPoint("TOPLEFT",b.gref["Bar"],"TOPLEFT",ceil(Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.framecol]["AOFFSET2"]*frameScale),ceil((-2+Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.framecol]["AOFFSET"])*frameScale))
                    b.gref.txt["text4"]:SetJustifyH("LEFT")
                elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.framecol]["AGGROTXTANCHOR"] == 2 then
                b.gref.txt["text4"]:SetPoint("TOP",b.gref["Bar"],"TOP",ceil(Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.framecol]["AOFFSET2"]*frameScale),ceil((-2+Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.framecol]["AOFFSET"])*frameScale))
                    b.gref.txt["text4"]:SetJustifyH("CENTER")
                else
                b.gref.txt["text4"]:SetPoint("TOPRIGHT",b.gref["Bar"],"TOPRIGHT",ceil(Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.framecol]["AOFFSET2"]*frameScale),ceil((-2+Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.framecol]["AOFFSET"])*frameScale))
                    b.gref.txt["text4"]:SetJustifyH("RIGHT")
                end
            elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.framecol]["AGGROTXTANCHOR"] == 4 then
                b.gref.txt["text4"]:SetPoint("BOTTOM",b.gref.txt["text"],"TOP",ceil(Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.framecol]["AOFFSET2"]*frameScale),ceil((0+Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.framecol]["AOFFSET"])*frameScale))
                b.gref.txt["text4"]:SetJustifyH(b.gref.txt["text"]:GetJustifyH())
            else
                b.gref.txt["text4"]:SetPoint("TOP",b.gref.txt["text"],"BOTTOM",ceil(Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.framecol]["AOFFSET2"]*frameScale),ceil((0+Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.framecol]["AOFFSET"])*frameScale))
                b.gref.txt["text4"]:SetJustifyH(b.gref.txt["text"]:GetJustifyH())
            end
            if not testBarsOn and button.text.tag == HEALBOT_OPTIONS_TAB_STATETEXT then
                button.text.tag=""
                button.gref.txt["text3"]:SetText("")
                button.gref.txt["text4"]:SetText("")
            end
            b.text.reset=false
        end

        if b.icon.reset then
            for x=1,8 do
                HealBot_Skins_UpdateBuffIcon(b, x, 1)
            end
            for x=9,10 do
                HealBot_Skins_UpdateBuffIcon(b, x, 2)
            end
            for x=11,12 do
                HealBot_Skins_UpdateBuffIcon(b, x, 3)
            end

            for x=51,56 do
                HealBot_Skins_UpdateDebuffIcon(b, x, 1)
            end
            for x=57,58 do
                HealBot_Skins_UpdateDebuffIcon(b, x, 2)
            end
            for x=59,60 do
                HealBot_Skins_UpdateDebuffIcon(b, x, 3)
            end

            -- Buff IconSet 1
            HealBot_Skins_setIconAnchors(Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][b.frame][1]["BUFFONBAR"],
                                         Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][b.frame][1]["BUFFANCHOR"])
            HealBot_Skins_setIconSpacer(Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][b.frame][1]["BUFFANCHOR"],
                                        Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][b.frame][1]["BICONSPACER"])

            b.gref.icon[1]:ClearAllPoints();
            b.gref.icon[1]:SetPoint(iAnchors["ICON"],b,iAnchors["BUTTON"],
                                    ceil(Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][b.frame][1]["BHOFFSET"]*frameScale),
                                    ceil(Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][b.frame][1]["BVOFFSET"]*frameScale));
            b.gref.iconf[1]:ClearAllPoints()
            b.gref.iconf[1]:SetPoint("TOPLEFT",b.gref.icon[1],"TOPLEFT")
            b.gref.txt.expire[1]:ClearAllPoints()
            b.gref.txt.expire[1]:SetPoint(iAnchors["TXTEXPIRE"],b.gref.icon[1],iAnchors["TXTEXPIRE"],iAnchors["TXTEXPIREX"],0)
            b.gref.txt.count[1]:ClearAllPoints()
            b.gref.txt.count[1]:SetPoint(iAnchors["TXTCOUNT"],b.gref.icon[1],iAnchors["TXTCOUNT"],iAnchors["TXTCOUNTX"],0)
            for x=2,8 do
                b.gref.icon[x]:ClearAllPoints()
                if Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][b.frame][1]["BUFFDOUBLE"] then
                    if (x/2) == floor(x/2) then
                        b.gref.icon[x]:SetPoint(iAnchors["ICON"],b.gref.icon[x-1],iAnchors["DOUBLE"],0,iAnchors["ICONVSPACE"])
                    else
                        b.gref.icon[x]:SetPoint(iAnchors["ICON"],b.gref.icon[x-2],iAnchors["RELATIVE"],iAnchors["ICONHSPACE"],0)
                    end
                else
                    b.gref.icon[x]:SetPoint(iAnchors["ICON"],b.gref.icon[x-1],iAnchors["RELATIVE"],iAnchors["ICONHSPACE"],0)
                end
                b.gref.iconf[x]:ClearAllPoints()
                b.gref.iconf[x]:SetPoint("TOPLEFT",b.gref.icon[x],"TOPLEFT")
                b.gref.txt.expire[x]:ClearAllPoints()
                b.gref.txt.expire[x]:SetPoint(iAnchors["TXTEXPIRE"],b.gref.icon[x],iAnchors["TXTEXPIRE"],iAnchors["TXTEXPIREX"],0)
                b.gref.txt.count[x]:ClearAllPoints()
                b.gref.txt.count[x]:SetPoint(iAnchors["TXTCOUNT"],b.gref.icon[x],iAnchors["TXTCOUNT"],iAnchors["TXTCOUNTX"],0)
            end

            -- Buff IconSet 2
            HealBot_Skins_setIconAnchors(Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][b.frame][2]["BUFFONBAR"],
                                         Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][b.frame][2]["BUFFANCHOR"])
            HealBot_Skins_setIconSpacer(Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][b.frame][2]["BUFFANCHOR"],
                                        Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][b.frame][2]["BICONSPACER"])

            b.gref.icon[9]:ClearAllPoints();
            b.gref.icon[9]:SetPoint(iAnchors["ICON"],b,iAnchors["BUTTON"],
                                    ceil(Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][b.frame][2]["BHOFFSET"]*frameScale),
                                    ceil(Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][b.frame][2]["BVOFFSET"]*frameScale));
            b.gref.iconf[9]:ClearAllPoints()
            b.gref.iconf[9]:SetPoint("TOPLEFT",b.gref.icon[9],"TOPLEFT")
            b.gref.txt.expire[9]:ClearAllPoints()
            b.gref.txt.expire[9]:SetPoint(iAnchors["TXTEXPIRE"],b.gref.icon[9],iAnchors["TXTEXPIRE"],iAnchors["TXTEXPIREX"],0)
            b.gref.txt.count[9]:ClearAllPoints()
            b.gref.txt.count[9]:SetPoint(iAnchors["TXTCOUNT"],b.gref.icon[9],iAnchors["TXTCOUNT"],iAnchors["TXTCOUNTX"],0)
            b.gref.icon[10]:ClearAllPoints()
            if Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][b.frame][2]["BUFFDOUBLE"] then
                b.gref.icon[10]:SetPoint(iAnchors["ICON"],b.gref.icon[9],iAnchors["DOUBLE"],0,iAnchors["ICONVSPACE"])
            else
                b.gref.icon[10]:SetPoint(iAnchors["ICON"],b.gref.icon[9],iAnchors["RELATIVE"],iAnchors["ICONHSPACE"],0)
            end
            b.gref.iconf[10]:ClearAllPoints()
            b.gref.iconf[10]:SetPoint("TOPLEFT",b.gref.icon[10],"TOPLEFT")
            b.gref.txt.expire[10]:ClearAllPoints()
            b.gref.txt.expire[10]:SetPoint(iAnchors["TXTEXPIRE"],b.gref.icon[10],iAnchors["TXTEXPIRE"],iAnchors["TXTEXPIREX"],0)
            b.gref.txt.count[10]:ClearAllPoints()
            b.gref.txt.count[10]:SetPoint(iAnchors["TXTCOUNT"],b.gref.icon[10],iAnchors["TXTCOUNT"],iAnchors["TXTCOUNTX"],0)

            -- Buff IconSet 3
            HealBot_Skins_setIconAnchors(Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][b.frame][3]["BUFFONBAR"],
                                         Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][b.frame][3]["BUFFANCHOR"])
            HealBot_Skins_setIconSpacer(Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][b.frame][3]["BUFFANCHOR"],
                                        Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][b.frame][3]["BICONSPACER"])

            b.gref.icon[11]:ClearAllPoints();
            b.gref.icon[11]:SetPoint(iAnchors["ICON"],b,iAnchors["BUTTON"],
                                    ceil(Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][b.frame][3]["BHOFFSET"]*frameScale),
                                    ceil(Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][b.frame][3]["BVOFFSET"]*frameScale));
            b.gref.iconf[11]:ClearAllPoints()
            b.gref.iconf[11]:SetPoint("TOPLEFT",b.gref.icon[11],"TOPLEFT")
            b.gref.txt.expire[11]:ClearAllPoints()
            b.gref.txt.expire[11]:SetPoint(iAnchors["TXTEXPIRE"],b.gref.icon[11],iAnchors["TXTEXPIRE"],iAnchors["TXTEXPIREX"],0)
            b.gref.txt.count[11]:ClearAllPoints()
            b.gref.txt.count[11]:SetPoint(iAnchors["TXTCOUNT"],b.gref.icon[11],iAnchors["TXTCOUNT"],iAnchors["TXTCOUNTX"],0)
            b.gref.icon[12]:ClearAllPoints()
            if Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][b.frame][3]["BUFFDOUBLE"] then
                b.gref.icon[12]:SetPoint(iAnchors["ICON"],b.gref.icon[11],iAnchors["DOUBLE"],0,iAnchors["ICONVSPACE"])
            else
                b.gref.icon[12]:SetPoint(iAnchors["ICON"],b.gref.icon[11],iAnchors["RELATIVE"],iAnchors["ICONHSPACE"],0)
            end
            b.gref.iconf[12]:ClearAllPoints()
            b.gref.iconf[12]:SetPoint("TOPLEFT",b.gref.icon[12],"TOPLEFT")
            b.gref.txt.expire[12]:ClearAllPoints()
            b.gref.txt.expire[12]:SetPoint(iAnchors["TXTEXPIRE"],b.gref.icon[12],iAnchors["TXTEXPIRE"],iAnchors["TXTEXPIREX"],0)
            b.gref.txt.count[12]:ClearAllPoints()
            b.gref.txt.count[12]:SetPoint(iAnchors["TXTCOUNT"],b.gref.icon[12],iAnchors["TXTCOUNT"],iAnchors["TXTCOUNTX"],0)

            -- Debuff IconSet 1
            HealBot_Skins_setIconAnchors(Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][b.frame][1]["DEBUFFONBAR"],
                                         Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][b.frame][1]["DEBUFFANCHOR"])
            HealBot_Skins_setIconSpacer(Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][b.frame][1]["DEBUFFANCHOR"],
                                        Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][b.frame][1]["DICONSPACER"])

            b.gref.icon[51]:ClearAllPoints()
            b.gref.icon[51]:SetPoint(iAnchors["ICON"],b,iAnchors["BUTTON"],
                                     ceil(Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][b.frame][1]["DHOFFSET"]*frameScale),
                                     ceil(Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][b.frame][1]["DVOFFSET"]*frameScale))
            b.gref.iconf[51]:ClearAllPoints()
            b.gref.iconf[51]:SetPoint("TOPLEFT",b.gref.icon[51],"TOPLEFT")
            b.gref.txt.expire[51]:ClearAllPoints()
            b.gref.txt.expire[51]:SetPoint(iAnchors["TXTEXPIRE"],b.gref.icon[51],iAnchors["TXTEXPIRE"],iAnchors["TXTEXPIREX"],0)
            b.gref.txt.count[51]:ClearAllPoints()
            b.gref.txt.count[51]:SetPoint(iAnchors["TXTCOUNT"],b.gref.icon[51],iAnchors["TXTCOUNT"],iAnchors["TXTCOUNTX"],0)
            for x=52,56 do
                b.gref.icon[x]:ClearAllPoints()
                if Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][b.frame][1]["DEBUFFDOUBLE"] then
                    if (x/2) == floor(x/2) then
                        b.gref.icon[x]:SetPoint(iAnchors["ICON"],b.gref.icon[x-1],iAnchors["DOUBLE"],0,iAnchors["ICONVSPACE"])
                    else
                        b.gref.icon[x]:SetPoint(iAnchors["ICON"],b.gref.icon[x-2],iAnchors["RELATIVE"],iAnchors["ICONHSPACE"],0)
                    end
                else
                    b.gref.icon[x]:SetPoint(iAnchors["ICON"],b.gref.icon[x-1],iAnchors["RELATIVE"],iAnchors["ICONHSPACE"],0)
                end
                b.gref.iconf[x]:ClearAllPoints()
                b.gref.iconf[x]:SetPoint("TOPLEFT",b.gref.icon[x],"TOPLEFT")
                b.gref.txt.expire[x]:ClearAllPoints()
                b.gref.txt.expire[x]:SetPoint(iAnchors["TXTEXPIRE"],b.gref.icon[x],iAnchors["TXTEXPIRE"],iAnchors["TXTEXPIREX"],0)
                b.gref.txt.count[x]:ClearAllPoints()
                b.gref.txt.count[x]:SetPoint(iAnchors["TXTCOUNT"],b.gref.icon[x],iAnchors["TXTCOUNT"],iAnchors["TXTCOUNTX"],0)
            end

            -- Debuff IconSet 2
            HealBot_Skins_setIconAnchors(Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][b.frame][2]["DEBUFFONBAR"],
                                         Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][b.frame][2]["DEBUFFANCHOR"])
            HealBot_Skins_setIconSpacer(Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][b.frame][2]["DEBUFFANCHOR"],
                                        Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][b.frame][2]["DICONSPACER"])

            b.gref.icon[57]:ClearAllPoints()
            b.gref.icon[57]:SetPoint(iAnchors["ICON"],b,iAnchors["BUTTON"],
                                     ceil(Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][b.frame][2]["DHOFFSET"]*frameScale),
                                     ceil(Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][b.frame][2]["DVOFFSET"]*frameScale))
            b.gref.iconf[57]:ClearAllPoints()
            b.gref.iconf[57]:SetPoint("TOPLEFT",b.gref.icon[57],"TOPLEFT")
            b.gref.txt.expire[57]:ClearAllPoints()
            b.gref.txt.expire[57]:SetPoint(iAnchors["TXTEXPIRE"],b.gref.icon[57],iAnchors["TXTEXPIRE"],iAnchors["TXTEXPIREX"],0)
            b.gref.txt.count[57]:ClearAllPoints()
            b.gref.txt.count[57]:SetPoint(iAnchors["TXTCOUNT"],b.gref.icon[57],iAnchors["TXTCOUNT"],iAnchors["TXTCOUNTX"],0)
            b.gref.icon[58]:ClearAllPoints()
            if Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][b.frame][2]["DEBUFFDOUBLE"] then
                b.gref.icon[58]:SetPoint(iAnchors["ICON"],b.gref.icon[57],iAnchors["DOUBLE"],0,iAnchors["ICONVSPACE"])
            else
                b.gref.icon[58]:SetPoint(iAnchors["ICON"],b.gref.icon[57],iAnchors["RELATIVE"],iAnchors["ICONHSPACE"],0)
            end
            b.gref.iconf[58]:ClearAllPoints()
            b.gref.iconf[58]:SetPoint("TOPLEFT",b.gref.icon[58],"TOPLEFT")
            b.gref.txt.expire[58]:ClearAllPoints()
            b.gref.txt.expire[58]:SetPoint(iAnchors["TXTEXPIRE"],b.gref.icon[58],iAnchors["TXTEXPIRE"],iAnchors["TXTEXPIREX"],0)
            b.gref.txt.count[58]:ClearAllPoints()
            b.gref.txt.count[58]:SetPoint(iAnchors["TXTCOUNT"],b.gref.icon[58],iAnchors["TXTCOUNT"],iAnchors["TXTCOUNTX"],0)

            -- Debuff IconSet 3
            HealBot_Skins_setIconAnchors(Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][b.frame][3]["DEBUFFONBAR"],
                                         Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][b.frame][3]["DEBUFFANCHOR"])
            HealBot_Skins_setIconSpacer(Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][b.frame][3]["DEBUFFANCHOR"],
                                        Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][b.frame][3]["DICONSPACER"])

            b.gref.icon[59]:ClearAllPoints()
            b.gref.icon[59]:SetPoint(iAnchors["ICON"],b,iAnchors["BUTTON"],
                                     ceil(Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][b.frame][3]["DHOFFSET"]*frameScale),
                                     ceil(Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][b.frame][3]["DVOFFSET"]*frameScale))
            b.gref.iconf[59]:ClearAllPoints()
            b.gref.iconf[59]:SetPoint("TOPLEFT",b.gref.icon[59],"TOPLEFT")
            b.gref.txt.expire[59]:ClearAllPoints()
            b.gref.txt.expire[59]:SetPoint(iAnchors["TXTEXPIRE"],b.gref.icon[59],iAnchors["TXTEXPIRE"],iAnchors["TXTEXPIREX"],0)
            b.gref.txt.count[59]:ClearAllPoints()
            b.gref.txt.count[59]:SetPoint(iAnchors["TXTCOUNT"],b.gref.icon[59],iAnchors["TXTCOUNT"],iAnchors["TXTCOUNTX"],0)
            b.gref.icon[60]:ClearAllPoints()
            if Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][b.frame][3]["DEBUFFDOUBLE"] then
                b.gref.icon[60]:SetPoint(iAnchors["ICON"],b.gref.icon[59],iAnchors["DOUBLE"],0,iAnchors["ICONVSPACE"])
            else
                b.gref.icon[60]:SetPoint(iAnchors["ICON"],b.gref.icon[59],iAnchors["RELATIVE"],iAnchors["ICONHSPACE"],0)
            end
            b.gref.iconf[60]:ClearAllPoints()
            b.gref.iconf[60]:SetPoint("TOPLEFT",b.gref.icon[60],"TOPLEFT")
            b.gref.txt.expire[60]:ClearAllPoints()
            b.gref.txt.expire[60]:SetPoint(iAnchors["TXTEXPIRE"],b.gref.icon[60],iAnchors["TXTEXPIRE"],iAnchors["TXTEXPIREX"],0)
            b.gref.txt.count[60]:ClearAllPoints()
            b.gref.txt.count[60]:SetPoint(iAnchors["TXTCOUNT"],b.gref.icon[60],iAnchors["TXTCOUNT"],iAnchors["TXTCOUNTX"],0)

            -- Class/Role 91
            HealBot_Skins_setIconAnchors(Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["CLASSONBAR"],
                                         Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["CLASSANCHOR"], true)
            b.gref.icon[91]:ClearAllPoints()
            b.gref.icon[91]:SetPoint(iAnchors["ICON"],b,iAnchors["BUTTON"],
                                     ceil(Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["CLASSHOFFSET"]*frameScale),
                                     ceil(Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["CLASSVOFFSET"]*frameScale))
            b.gref.icon[91]:SetHeight((bheight*Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["CLASSSCALE"])-2)
            b.gref.icon[91]:SetWidth((bheight*Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["CLASSSCALE"])-2)
            iZoom=Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["CLASSZOOM"] or 0
            b.gref.icon[91]:SetTexCoord(iZoom,1-iZoom,iZoom,1-iZoom)
            -- Raid Target 92
            HealBot_Skins_setIconAnchors(Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["TARGETONBAR"],
                                         Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["TARGETANCHOR"], true)
            b.gref.icon[92]:ClearAllPoints()
            b.gref.icon[92]:SetPoint(iAnchors["ICON"],b,iAnchors["BUTTON"],
                                     ceil(Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["TARGETHOFFSET"]*frameScale),
                                     ceil(Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["TARGETVOFFSET"]*frameScale))
            b.gref.icon[92]:SetHeight((bheight*Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["TARGETSCALE"])-2)
            b.gref.icon[92]:SetWidth((bheight*Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["TARGETSCALE"])-2)
            iZoom=Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["TARGETZOOM"] or 0
            b.gref.icon[92]:SetTexCoord(iZoom,1-iZoom,iZoom,1-iZoom)
            -- Ready Check 93
            HealBot_Skins_setIconAnchors(Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["RCONBAR"],
                                         Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["RCANCHOR"], true)
            b.gref.icon[93]:ClearAllPoints()
            b.gref.icon[93]:SetPoint(iAnchors["ICON"],b,iAnchors["BUTTON"],
                                     ceil(Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["RCHOFFSET"]*frameScale),
                                     ceil(Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["RCVOFFSET"]*frameScale))
            b.gref.icon[93]:SetHeight((bheight*Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["RCSCALE"])-2)
            b.gref.icon[93]:SetWidth((bheight*Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["RCSCALE"])-2)
            iZoom=Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["RCZOOM"] or 0
            b.gref.icon[93]:SetTexCoord(iZoom,1-iZoom,iZoom,1-iZoom)
            -- Out of range 94
            HealBot_Skins_setIconAnchors(Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["OORONBAR"],
                                         Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["OORANCHOR"], true)
            b.gref.icon[94]:ClearAllPoints()
            b.gref.icon[94]:SetPoint(iAnchors["ICON"],b,iAnchors["BUTTON"],
                                     ceil(Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["OORHOFFSET"]*frameScale),
                                     ceil(Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["OORVOFFSET"]*frameScale))
            b.gref.icon[94]:SetHeight((bheight*Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["OORSCALE"])-2)
            b.gref.icon[94]:SetWidth((bheight*Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["OORSCALE"])-2)
            iZoom=Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["OORZOOM"] or 0
            b.gref.icon[94]:SetTexCoord(iZoom,1-iZoom,iZoom,1-iZoom)
            b.icon.reset=false
        end

        if b.indreset then
            local indCol=HealBot_Skins_GetFrameVar("Indicators", "ACOL", b.frame)
            if indCol == 1 then indCol=8 end
            b.gref.indicator.aggro["Iconal1"]:SetTexture(indTextures[indCol])
            b.gref.indicator.aggro["Iconal2"]:SetTexture(indTextures[indCol])
            b.gref.indicator.aggro["Iconal3"]:SetTexture(indTextures[indCol])
            b.gref.indicator.aggro["Iconar1"]:SetTexture(indTextures[indCol])
            b.gref.indicator.aggro["Iconar2"]:SetTexture(indTextures[indCol])
            b.gref.indicator.aggro["Iconar3"]:SetTexture(indTextures[indCol])

            indCol=HealBot_Skins_GetFrameVar("Indicators", "MCOL", b.frame)
            if indCol == 1 then indCol=10 end
            b.gref.indicator.mana[1]:SetTexture(indTextures[indCol])
            b.gref.indicator.mana[2]:SetTexture(indTextures[indCol])
            b.gref.indicator.mana[3]:SetTexture(indTextures[indCol])

            indCol=HealBot_Skins_GetFrameVar("Indicators", "SCOL", b.frame)
            if indCol == 1 then indCol=8 end
            for x=1,16 do
                b.gref.indicator.selfcast[x]:SetTexture(indTextures[indCol])
                --b.gref.indicator.selfcast[x]:SetAlpha(0)
            end

            indCol=HealBot_Skins_GetFrameVar("Indicators", "PCOL", b.frame)
            if indCol == 1 then indCol=12 end
            for x=1,5 do
                b.gref.indicator.power[x]:SetTexture(indTextures[indCol])
            end

            local indAnchor={[0]="TOPLEFT",[1]="TOPRIGHT"}
            if HealBot_Skins_GetFrameVar("Indicators", "AANCHOR", b.frame) == 2 then
                indAnchor[0]="BOTTOMLEFT"
                indAnchor[1]="BOTTOMRIGHT"
            end
            b.gref.indicator.aggro["Iconal1"]:ClearAllPoints()
            b.gref.indicator.aggro["Iconal2"]:ClearAllPoints()
            b.gref.indicator.aggro["Iconal3"]:ClearAllPoints()
            b.gref.indicator.aggro["Iconar1"]:ClearAllPoints()
            b.gref.indicator.aggro["Iconar2"]:ClearAllPoints()
            b.gref.indicator.aggro["Iconar3"]:ClearAllPoints()

            b.gref.indicator.aggro["Iconal1"]:SetPoint(indAnchor[0],b.gref["IconTop"],indAnchor[0],
                                                       ceil(0+HealBot_Skins_GetFrameVar("Indicators", "AHOFF", b.frame)*frameScale),
                                                              HealBot_Skins_IndicatorVOffset(HealBot_Skins_GetFrameVar("Indicators", "AANCHOR", b.frame),
                                                                                             HealBot_Skins_GetFrameVar("Indicators", "AVOFF", b.frame),
                                                                                              button.frame))
            b.gref.indicator.aggro["Iconal2"]:SetPoint("TOPLEFT",b.gref.indicator.aggro["Iconal1"],"TOPRIGHT",
                                                       ceil(0+(HealBot_Skins_GetFrameVar("Indicators", "ASPACE", b.frame))*frameScale),0)
            b.gref.indicator.aggro["Iconal3"]:SetPoint("TOPLEFT",b.gref.indicator.aggro["Iconal2"],"TOPRIGHT",
                                                       ceil(0+(HealBot_Skins_GetFrameVar("Indicators", "ASPACE", b.frame))*frameScale),0)
            b.gref.indicator.aggro["Iconar1"]:SetPoint(indAnchor[1],b.gref["IconTop"],indAnchor[1],
                                                       ceil(0-HealBot_Skins_GetFrameVar("Indicators", "AHOFF", b.frame)*frameScale),
                                                              HealBot_Skins_IndicatorVOffset(HealBot_Skins_GetFrameVar("Indicators", "AANCHOR", b.frame),
                                                                                             HealBot_Skins_GetFrameVar("Indicators", "AVOFF", b.frame),
                                                                                              button.frame))
            b.gref.indicator.aggro["Iconar2"]:SetPoint("TOPRIGHT",b.gref.indicator.aggro["Iconar1"],"TOPLEFT",
                                                       ceil(0-(HealBot_Skins_GetFrameVar("Indicators", "ASPACE", b.frame))*frameScale),0)
            b.gref.indicator.aggro["Iconar3"]:SetPoint("TOPRIGHT",b.gref.indicator.aggro["Iconar2"],"TOPLEFT",
                                                       ceil(0-(HealBot_Skins_GetFrameVar("Indicators", "ASPACE", b.frame))*frameScale),0)


            indAnchor[0]="TOP"
            if HealBot_Skins_GetFrameVar("Indicators", "MANCHOR", b.frame) == 2 then
                indAnchor[0]="BOTTOM"
            elseif HealBot_Skins_GetFrameVar("Indicators", "MANCHOR", b.frame) == 3 then
                indAnchor[0]="LEFT"
            elseif HealBot_Skins_GetFrameVar("Indicators", "MANCHOR", b.frame) == 4 then
                indAnchor[0]="RIGHT"
            elseif HealBot_Skins_GetFrameVar("Indicators", "MANCHOR", b.frame) == 5 then
                indAnchor[0]="TOPLEFT"
            elseif HealBot_Skins_GetFrameVar("Indicators", "MANCHOR", b.frame) == 6 then
                indAnchor[0]="BOTTOMLEFT"
            elseif HealBot_Skins_GetFrameVar("Indicators", "MANCHOR", b.frame) == 7 then
                indAnchor[0]="TOPRIGHT"
            elseif HealBot_Skins_GetFrameVar("Indicators", "MANCHOR", b.frame) == 8 then
                indAnchor[0]="BOTTOMRIGHT"
            end
            b.gref.indicator.mana[1]:ClearAllPoints()
            b.gref.indicator.mana[2]:ClearAllPoints()
            b.gref.indicator.mana[3]:ClearAllPoints()

            b.gref.indicator.mana[2]:SetPoint(indAnchor[0],b.gref["IconTop"],indAnchor[0],
                                              ceil(0+HealBot_Skins_GetFrameVar("Indicators", "MHOFF", b.frame)*frameScale),
                                                     HealBot_Skins_IndicatorVOffset(HealBot_Skins_GetFrameVar("Indicators", "MANCHOR", b.frame),
                                                                                    HealBot_Skins_GetFrameVar("Indicators", "MVOFF", b.frame),
                                                                                    button.frame))
            b.gref.indicator.mana[1]:SetPoint("TOPRIGHT",b.gref.indicator.mana[2],"TOPLEFT",
                                             (ceil(0-(HealBot_Skins_GetFrameVar("Indicators", "MSPACE", b.frame)*frameScale))),0)
            b.gref.indicator.mana[3]:SetPoint("TOPLEFT",b.gref.indicator.mana[2],"TOPRIGHT",
                                             (ceil(0+(HealBot_Skins_GetFrameVar("Indicators", "MSPACE", b.frame)*frameScale))),0)

            indAnchor[0]="TOP"
            if HealBot_Skins_GetFrameVar("Indicators", "PANCHOR", b.frame) == 2 then
                indAnchor[0]="BOTTOM"
            elseif HealBot_Skins_GetFrameVar("Indicators", "PANCHOR", b.frame) == 3 then
                indAnchor[0]="LEFT"
            elseif HealBot_Skins_GetFrameVar("Indicators", "PANCHOR", b.frame) == 4 then
                indAnchor[0]="RIGHT"
            elseif HealBot_Skins_GetFrameVar("Indicators", "PANCHOR", b.frame) == 5 then
                indAnchor[0]="TOPLEFT"
            elseif HealBot_Skins_GetFrameVar("Indicators", "PANCHOR", b.frame) == 6 then
                indAnchor[0]="BOTTOMLEFT"
            elseif HealBot_Skins_GetFrameVar("Indicators", "PANCHOR", b.frame) == 7 then
                indAnchor[0]="TOPRIGHT"
            elseif HealBot_Skins_GetFrameVar("Indicators", "PANCHOR", b.frame) == 8 then
                indAnchor[0]="BOTTOMRIGHT"
            end
            b.gref.indicator.power[1]:ClearAllPoints()
            b.gref.indicator.power[2]:ClearAllPoints()
            b.gref.indicator.power[3]:ClearAllPoints()
            b.gref.indicator.power[4]:ClearAllPoints()
            b.gref.indicator.power[5]:ClearAllPoints()

            b.gref.indicator.power[3]:SetPoint(indAnchor[0],b.gref["IconTop"],indAnchor[0],
                                               ceil(0+HealBot_Skins_GetFrameVar("Indicators", "PHOFF", b.frame)),
                                                      HealBot_Skins_IndicatorVOffset(HealBot_Skins_GetFrameVar("Indicators", "PANCHOR", b.frame),
                                                                                     HealBot_Skins_GetFrameVar("Indicators", "PVOFF", b.frame),
                                                                                      button.frame))
            b.gref.indicator.power[2]:SetPoint("TOPRIGHT",b.gref.indicator.power[3],"TOPLEFT",
                                              ceil(0-(HealBot_Skins_GetFrameVar("Indicators", "PSPACE", b.frame)*frameScale)),0)
            b.gref.indicator.power[1]:SetPoint("TOPRIGHT",b.gref.indicator.power[2],"TOPLEFT",
                                              ceil(0-(HealBot_Skins_GetFrameVar("Indicators", "PSPACE", b.frame)*frameScale)),0)
            b.gref.indicator.power[4]:SetPoint("TOPLEFT",b.gref.indicator.power[3],"TOPRIGHT",
                                              ceil(0+(HealBot_Skins_GetFrameVar("Indicators", "PSPACE", b.frame)*frameScale)),0)
            b.gref.indicator.power[5]:SetPoint("TOPLEFT",b.gref.indicator.power[4],"TOPRIGHT",
                                              ceil(0+(HealBot_Skins_GetFrameVar("Indicators", "PSPACE", b.frame)*frameScale)),0)

            HealBot_Skins_setIconAnchors(Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][b.frame][1]["BUFFONBAR"],
                                         Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][b.frame][1]["BUFFANCHOR"])

            b.gref.indicator.selfcast[1]:ClearAllPoints()
            b.gref.indicator.selfcast[1]:SetPoint(iAnchors["INDSELFCAST"],b.gref.icon[1],iAnchors["INDSELFCAST"],
                                                  0+HealBot_Skins_GetFrameVar("Indicators", "SHOFF", b.frame),
                                                  HealBot_Skins_IndicatorVOffset(HealBot_Skins_GetFrameVar("Indicators", "SANCHOR", b.frame),
                                                                                 HealBot_Skins_GetFrameVar("Indicators", "SVOFF", b.frame),
                                                                                 button.frame))
            for x=2,8 do
                b.gref.indicator.selfcast[x]:ClearAllPoints()
                b.gref.indicator.selfcast[x]:SetPoint(iAnchors["INDSELFCAST"],b.gref.icon[x],iAnchors["INDSELFCAST"],
                                                  0+HealBot_Skins_GetFrameVar("Indicators", "SHOFF", b.frame),
                                                  HealBot_Skins_IndicatorVOffset(HealBot_Skins_GetFrameVar("Indicators", "SANCHOR", b.frame),
                                                                                 HealBot_Skins_GetFrameVar("Indicators", "SVOFF", b.frame),
                                                                                 button.frame))
            end

            HealBot_Skins_setIconAnchors(Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][b.frame][2]["BUFFONBAR"],
                                         Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][b.frame][2]["BUFFANCHOR"])

            b.gref.indicator.selfcast[9]:ClearAllPoints()
            b.gref.indicator.selfcast[9]:SetPoint(iAnchors["INDSELFCAST"],b.gref.icon[9],iAnchors["INDSELFCAST"],
                                                  0+HealBot_Skins_GetFrameVar("Indicators", "SHOFF", b.frame),
                                                  HealBot_Skins_IndicatorVOffset(HealBot_Skins_GetFrameVar("Indicators", "SANCHOR", b.frame),
                                                                                 HealBot_Skins_GetFrameVar("Indicators", "SVOFF", b.frame),
                                                                                 button.frame))
            for x=10,12 do
                b.gref.indicator.selfcast[x]:ClearAllPoints()
                b.gref.indicator.selfcast[x]:SetPoint(iAnchors["INDSELFCAST"],b.gref.icon[x],iAnchors["INDSELFCAST"],
                                                  0+HealBot_Skins_GetFrameVar("Indicators", "SHOFF", b.frame),
                                                  HealBot_Skins_IndicatorVOffset(HealBot_Skins_GetFrameVar("Indicators", "SANCHOR", b.frame),
                                                                                 HealBot_Skins_GetFrameVar("Indicators", "SVOFF", b.frame),
                                                                                 button.frame))
            end

            HealBot_Skins_setIconAnchors(Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][b.frame][3]["BUFFONBAR"],
                                         Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][b.frame][3]["BUFFANCHOR"])

            b.gref.indicator.selfcast[13]:ClearAllPoints()
            b.gref.indicator.selfcast[13]:SetPoint(iAnchors["INDSELFCAST"],b.gref.icon[13],iAnchors["INDSELFCAST"],
                                                  0+HealBot_Skins_GetFrameVar("Indicators", "SHOFF", b.frame),
                                                  HealBot_Skins_IndicatorVOffset(HealBot_Skins_GetFrameVar("Indicators", "SANCHOR", b.frame),
                                                                                 HealBot_Skins_GetFrameVar("Indicators", "SVOFF", b.frame),
                                                                                 button.frame))
            for x=14,16 do
                b.gref.indicator.selfcast[x]:ClearAllPoints()
                b.gref.indicator.selfcast[x]:SetPoint(iAnchors["INDSELFCAST"],b.gref.icon[x],iAnchors["INDSELFCAST"],
                                                  0+HealBot_Skins_GetFrameVar("Indicators", "SHOFF", b.frame),
                                                  HealBot_Skins_IndicatorVOffset(HealBot_Skins_GetFrameVar("Indicators", "SANCHOR", b.frame),
                                                                                 HealBot_Skins_GetFrameVar("Indicators", "SVOFF", b.frame),
                                                                                 button.frame))
            end

            b.gref.indicator.aggro["Iconal1"]:SetWidth(ceil(HealBot_Skins_GetFrameVar("Indicators", "ASIZE", b.frame)*frameScale))
            b.gref.indicator.aggro["Iconal2"]:SetWidth(ceil(HealBot_Skins_GetFrameVar("Indicators", "ASIZE", b.frame)*frameScale))
            b.gref.indicator.aggro["Iconal3"]:SetWidth(ceil(HealBot_Skins_GetFrameVar("Indicators", "ASIZE", b.frame)*frameScale))
            b.gref.indicator.aggro["Iconar1"]:SetWidth(ceil(HealBot_Skins_GetFrameVar("Indicators", "ASIZE", b.frame)*frameScale))
            b.gref.indicator.aggro["Iconar2"]:SetWidth(ceil(HealBot_Skins_GetFrameVar("Indicators", "ASIZE", b.frame)*frameScale))
            b.gref.indicator.aggro["Iconar3"]:SetWidth(ceil(HealBot_Skins_GetFrameVar("Indicators", "ASIZE", b.frame)*frameScale))
            b.gref.indicator.aggro["Iconal1"]:SetHeight(ceil(HealBot_Skins_GetFrameVar("Indicators", "ASIZE", b.frame)*frameScale))
            b.gref.indicator.aggro["Iconal2"]:SetHeight(ceil(HealBot_Skins_GetFrameVar("Indicators", "ASIZE", b.frame)*frameScale))
            b.gref.indicator.aggro["Iconal3"]:SetHeight(ceil(HealBot_Skins_GetFrameVar("Indicators", "ASIZE", b.frame)*frameScale))
            b.gref.indicator.aggro["Iconar1"]:SetHeight(ceil(HealBot_Skins_GetFrameVar("Indicators", "ASIZE", b.frame)*frameScale))
            b.gref.indicator.aggro["Iconar2"]:SetHeight(ceil(HealBot_Skins_GetFrameVar("Indicators", "ASIZE", b.frame)*frameScale))
            b.gref.indicator.aggro["Iconar3"]:SetHeight(ceil(HealBot_Skins_GetFrameVar("Indicators", "ASIZE", b.frame)*frameScale))

            for x=1,3 do
                b.gref.indicator.mana[x]:SetWidth(ceil(HealBot_Skins_GetFrameVar("Indicators", "MSIZE", b.frame)*frameScale))
                b.gref.indicator.mana[x]:SetHeight(ceil(HealBot_Skins_GetFrameVar("Indicators", "MSIZE", b.frame)*frameScale))
            end
            for x=1,16 do
                b.gref.indicator.selfcast[x]:SetWidth(ceil(HealBot_Skins_GetFrameVar("Indicators", "SSIZE", b.frame)*frameScale))
                b.gref.indicator.selfcast[x]:SetHeight(ceil(HealBot_Skins_GetFrameVar("Indicators", "SSIZE", b.frame)*frameScale))
            end
            for x=1,5 do
                b.gref.indicator.power[x]:SetWidth(ceil(HealBot_Skins_GetFrameVar("Indicators", "PSIZE", b.frame)*frameScale))
                b.gref.indicator.power[x]:SetHeight(ceil(HealBot_Skins_GetFrameVar("Indicators", "PSIZE", b.frame)*frameScale))
            end

            if testBarsOn and b.frame<10 and HealBot_Skins_GetFrameBoolean("BarAggro", "SHOW", b.frame) and
                                             HealBot_Skins_GetFrameBoolean("BarAggro", "SHOWIND", b.frame) then
                b.gref.indicator.aggro["Iconal1"]:SetAlpha(1)
                b.gref.indicator.aggro["Iconal2"]:SetAlpha(1)
                b.gref.indicator.aggro["Iconal3"]:SetAlpha(1)
                b.gref.indicator.aggro["Iconar1"]:SetAlpha(1)
                b.gref.indicator.aggro["Iconar2"]:SetAlpha(1)
                b.gref.indicator.aggro["Iconar3"]:SetAlpha(1)
            else
                b.gref.indicator.aggro["Iconal1"]:SetAlpha(0)
                b.gref.indicator.aggro["Iconal2"]:SetAlpha(0)
                b.gref.indicator.aggro["Iconal3"]:SetAlpha(0)
                b.gref.indicator.aggro["Iconar1"]:SetAlpha(0)
                b.gref.indicator.aggro["Iconar2"]:SetAlpha(0)
                b.gref.indicator.aggro["Iconar3"]:SetAlpha(0)
            end

            if testBarsOn and b.frame<10 and Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][b.frame]["LOWMANA"]>1 then
                b.gref.indicator.mana[1]:SetAlpha(1)
                b.gref.indicator.mana[2]:SetAlpha(1)
                b.gref.indicator.mana[3]:SetAlpha(1)
            else
                b.gref.indicator.mana[1]:SetAlpha(0)
                b.gref.indicator.mana[2]:SetAlpha(0)
                b.gref.indicator.mana[3]:SetAlpha(0)
            end
            if testBarsOn then
                if Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][b.frame]["POWERCNT"] and testPowerOn>0 then
                    button.gref.indicator.power[1]:SetAlpha(1)
                    button.gref.indicator.power[2]:SetAlpha(1)
                    button.gref.indicator.power[3]:SetAlpha(1)
                    if testPowerOn>3 then button.gref.indicator.power[4]:SetAlpha(1) end
                    if testPowerOn>4 then button.gref.indicator.power[5]:SetAlpha(1) end
                else
                    button.gref.indicator.power[1]:SetAlpha(0)
                    button.gref.indicator.power[2]:SetAlpha(0)
                    button.gref.indicator.power[3]:SetAlpha(0)
                    button.gref.indicator.power[4]:SetAlpha(0)
                    button.gref.indicator.power[5]:SetAlpha(0)
                end
            end
            b.indreset=false
        end
    elseif barType == "header" then
        h=button
        --bar=_G[h:GetName().."Bar"]
        local back=_G[h:GetName().."Bar5"]
        hwidth=ceil((bWidth+auxWidth+(bOutline*2))*HealBot_Skins_GetFrameVar("HeadBar", "WIDTH", h.frame))
        hheight=ceil(HealBot_Skins_GetFrameVar("HeadBar", "HEIGHT", h.frame)*frameScale)
        h:SetHeight(hheight);
        h:SetWidth(hwidth);
        back:SetHeight(hheight)
        back:SetWidth(hwidth)
        HealBot_Action_SetBackHeaderHeightWidth(h.frame, hheight, hwidth)
        back:SetStatusBarColor(0,0,0,0)
        HealBot_Media_UpdateTexture(h.bar, HealBot_Skins_GetFrameVar("HeadBar", "TEXTURE", h.frame), "Skins_ResetSkin - HeadBar")
        h.bar:GetStatusBarTexture():SetHorizTile(false)
        h.bar:SetMinMaxValues(0,100);
        h.bar:SetValue(100);
        HealBot_Action_UpdateHeaderOpacity(h)
        h.bar:SetHeight(hheight);
        h.bar:SetWidth(hwidth);
        HealBot_Media_UpdateFont(h.bar.txt,
                                 Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin][h.frame]["FONT"],
                                 ceil(Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin][h.frame]["HEIGHT"]*frameScale),
                                 Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin][h.frame]["OUTLINE"],
                                 "Skins_ResetSkin - HeadText")
        h.bar.txt:SetPoint("CENTER",h.bar,"CENTER",0,Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin][h.frame]["OFFSET"])
        h.bar:EnableMouse(false)
        h.bar.txt2:SetTextColor(0,0,0,0);
        h.bar:ClearAllPoints()
        h.bar:SetPoint("CENTER",back,"CENTER",0,0)
        h:Disable();
    elseif barType == "hbfocus" then
        bar=_G["hbExtra_HealUnit999"]
        HealBot_Media_UpdateTexture(bar, Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][button.frame]["TEXTURE"], "Skins_ResetSkin - HealBar")
        bar:GetStatusBarTexture():SetHorizTile(false)

        bar:SetStatusBarColor(1,1,1,1);
        tBarsConcat[1]=bar:GetName()
        tBarsConcat[2]="_text"
        bar.txt=_G[HealBot_Skins_Concat(2)];
        tBarsConcat[2]="_text2"
        bar.txt2=_G[HealBot_Skins_Concat(2)];
        HealBot_Media_UpdateFont(bar.txt,
                                 Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["FONT"],
                                 btextheight,
                                 btextoutline,
                                 "Skins_ResetSkin - BarText")
        bar.txt:SetTextColor(0,0,0,1);
        HealBot_Media_UpdateFont(bar.txt2,
                                 Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["HFONT"],
                                 btextheight2,
                                 btextoutline2,
                                 "Skins_ResetSkin - BarText")
        bar.txt2:SetTextColor(0,0,0,1);
        iScale=0.84
        iScale=iScale+(numcols/10)
        bar:SetWidth(bWidth*iScale)
        button:SetWidth(bWidth*iScale)
        bar:SetHeight(bheight);
        button:SetHeight(bheight);
        bar.txt:SetText(HEALBOT_ACTION_HBFOCUS)
        barScale=bar:GetScale();
        bar:SetScale(barScale + 0.01);
        bar:SetScale(barScale);
    else
        HealBot_Panel_ResetHeaders()
        HealBot_Timers_SkinsFormat() -- HealBot_Timers_Set("SKINS","SkinsFormat")
        HealBot_Text_setExtraCustomCols() --HealBot_Timers_Set("SKINS","TextExtraCustomCols")

        HealBot_Timers_Set("SKINS","RaidTargetUpdate")
        HealBot_Timers_Set("SKINS","UpdateTextButtons")
    end
end

function HealBot_Skins_Check(SkinName)
      --HealBot_setCall("HealBot_Skins_Check")
    if not Healbot_Config_Skins.General[SkinName] or not Healbot_Config_Skins.General[SkinName]["VC"] or Healbot_Config_Skins.General[SkinName]["VC"]~=HealBot_Global_Version() then
        HealBot_Skins_Check_Skin(SkinName)
    end
end

local nVal={[1]="", [2]="", [3]=""}
local function HealBot_Skins_Check_IconSets(SkinName, frame, oVar, nVar, v1, v2, v3)
      --HealBot_setCall("HealBot_Skins_Check_IconSets")
    nVal[1]=v1
    nVal[2]=v2 or v1
    nVal[3]=v3 or v2 or v1
    for i=1,3 do
        if not Healbot_Config_Skins.IconSets[SkinName][frame][i][nVar] then
            if Healbot_Config_Skins.Icons[SkinName][frame][oVar] then
                if type(Healbot_Config_Skins.Icons[SkinName][frame][oVar]) == type(nVal[i]) then
                    Healbot_Config_Skins.IconSets[SkinName][frame][i][nVar]=Healbot_Config_Skins.Icons[SkinName][frame][oVar]
                else
                    Healbot_Config_Skins.IconSets[SkinName][frame][i][nVar]=nVal[i]
                end
                Healbot_Config_Skins.Icons[SkinName][frame][oVar]=nil
            elseif Healbot_Config_Skins.Icons[SkinName][frame][i] and Healbot_Config_Skins.Icons[SkinName][frame][i][oVar] then
                if type(Healbot_Config_Skins.Icons[SkinName][frame][i][oVar]) == type(nVal[i]) then
                    Healbot_Config_Skins.IconSets[SkinName][frame][i][nVar]=Healbot_Config_Skins.Icons[SkinName][frame][i][oVar]
                else
                    Healbot_Config_Skins.IconSets[SkinName][frame][i][nVar]=nVal[i]
                end
                Healbot_Config_Skins.Icons[SkinName][frame][i][oVar]=nil
            else
                Healbot_Config_Skins.IconSets[SkinName][frame][i][nVar]=nVal[i]
            end
        else
            if Healbot_Config_Skins.Icons[SkinName][frame][oVar] then
                Healbot_Config_Skins.Icons[SkinName][frame][oVar]=nil
            end
            if Healbot_Config_Skins.Icons[SkinName][frame][i] then
                Healbot_Config_Skins.Icons[SkinName][frame][i]=nil
            end
        end
    end
end

local function HealBot_Skins_Check_IconSetsText(SkinName, frame, oVar, nVar, v)
      --HealBot_setCall("HealBot_Skins_Check_IconSetsText")
    local n=0
    for i=1,3 do
        if type(v) == "number" then
            if Healbot_Config_Skins.IconSetsText[SkinName][frame] and Healbot_Config_Skins.IconSetsText[SkinName][frame][i] and (Healbot_Config_Skins.IconSetsText[SkinName][frame][i][nVar] or 99) == v then 
                Healbot_Config_Skins.IconSetsText[SkinName][frame][i][nVar]=nil 
                n=n+1
            else
                n=n+1
            end
        else
            if Healbot_Config_Skins.IconSetsText[SkinName][frame] and Healbot_Config_Skins.IconSetsText[SkinName][frame][i] and (Healbot_Config_Skins.IconSetsText[SkinName][frame][i][nVar] or "x") == v then 
                Healbot_Config_Skins.IconSetsText[SkinName][frame][i][nVar]=nil
                n=n+1
            else
                n=n+1
            end
        end
    end
    if n == 3 then Healbot_Config_Skins.IconSetsText[SkinName][frame]=nil end
    if Healbot_Config_Skins.IconText[SkinName][frame][oVar] then Healbot_Config_Skins.IconText[SkinName][frame][oVar]=nil end
end

function HealBot_Skins_Check_Aux(SkinName)
    if Healbot_Config_Skins.AuxBar and Healbot_Config_Skins.AuxBar[skinName] then
        if not Healbot_Config_Aux.Bar[skinName] then Healbot_Config_Aux.Bar[skinName]={} end
        for f=1,10 do
            for i=1,9 do
                table.foreach(Healbot_Config_Skins.AuxBar[skinName][i][f], function (key,val)
                    if key and val then
                        if key == "SIZE" and val == 0.98 then val=1 end
                        HealBot_Data_AuxSetBarSkin(val, skinName, key, f, i)
                    end
                end);
            end
        end
        Healbot_Config_Skins.AuxBar[skinName]=nil
    end
    if Healbot_Config_Skins.AuxBarText and Healbot_Config_Skins.AuxBarText[skinName] then
        if not Healbot_Config_Aux.BarText[skinName] then Healbot_Config_Aux.BarText[skinName]={} end
        for f=1,10 do
            for i=1,9 do
                table.foreach(Healbot_Config_Skins.AuxBarText[skinName][i][f], function (key,val)
                    if key and val then
                        if key == "COLA" and val == 0.98 then val=1 end
                        if key == "FONT" and val == "Friz Quadrata TT" then val=HealBot_Data_Default_FontName() end
                        HealBot_Data_AuxSetBarTextSkin(val, skinName, key, f, i)
                    end
                end);
            end
        end
        Healbot_Config_Skins.AuxBarText[skinName]=nil
    end
    if Healbot_Config_Skins.AuxBarFrame and Healbot_Config_Skins.AuxBarFrame[skinName] then
        if not Healbot_Config_Aux.Overlay[skinName] then Healbot_Config_Aux.Overlay[skinName]={} end
        for f=1,10 do
            table.foreach(Healbot_Config_Skins.AuxBarFrame[skinName][f], function (key,val)
                if key and val then
                    if key ~= "OFREQ" and key ~= "OMIN" and key ~= "OMAX" then
                        HealBot_Data_AuxSetBarTextSkin(val, skinName, key, f, i)
                    end
                end
            end);
        end
        Healbot_Config_Skins.AuxBarFrame[skinName]=nil
    end      
    for f=1,10 do
        for i=1,9 do
            if Healbot_Config_Aux.BarText[skinName][f] and Healbot_Config_Aux.BarText[skinName][f][i] then
                table.foreach(Healbot_Config_Aux.BarText[skinName][f][i], function (key,val)
                    if key and val then
                        if key == "OVERLAYRECENTHEALS" then Healbot_Config_Aux.BarText[skinName][f][i]["OVERLAYRECENTHEALS"]=nil end
                        if key == "OVERLAYTARGET" then Healbot_Config_Aux.BarText[skinName][f][i]["OVERLAYTARGET"]=nil end
                        if key == "OVERLAYHEALTHDROP" then Healbot_Config_Aux.BarText[skinName][f][i]["OVERLAYHEALTHDROP"]=nil end
                        if key == "OVERLAYHIGHLIGHT" then Healbot_Config_Aux.BarText[skinName][f][i]["OVERLAYHIGHLIGHT"]=nil end
                        if key == "OVERLAYBUFF" then Healbot_Config_Aux.BarText[skinName][f][i]["OVERLAYBUFF"]=nil end
                        if key == "OVERLAYOOR" then Healbot_Config_Aux.BarText[skinName][f][i]["OVERLAYOOR"]=nil end
                        if key == "OVERLAYDEBUFF" then Healbot_Config_Aux.BarText[skinName][f][i]["OVERLAYDEBUFF"]=nil end
                        if key == "OVERLAYAGGRO" then Healbot_Config_Aux.BarText[skinName][f][i]["OVERLAYAGGRO"]=nil end
                    end
                end);
            end
        end
    end
end

function HealBot_Skins_Check_Skin(SkinName, fromImport)
    HealBot_Skins_Check_Aux(SkinName)
      --HealBot_setCall("HealBot_Skins_Check_Skin")
    if Healbot_Config_Skins.ExtraIncGroup then Healbot_Config_Skins.ExtraIncGroup=nil end
    if Healbot_Config_Skins.BarsHide then Healbot_Config_Skins.BarsHide=nil end
    if Healbot_Config_Skins.EmergIncMonitor then Healbot_Config_Skins.EmergIncMonitor=nil end
    if Healbot_Config_Skins.IncludeGroup then Healbot_Config_Skins.IncludeGroup=nil end

    if not HealBot_Config.SkinDefault[SkinName] then HealBot_Config.SkinDefault[SkinName]={} end

    if not Healbot_Config_Skins.HealGroups[SkinName] then Healbot_Config_Skins.HealGroups[SkinName]={
        [1]={["NAME"]=HEALBOT_OPTIONS_SELFHEALS_en,["STATE"]=false,["FRAME"]=1},
        [2]={["NAME"]=HEALBOT_OPTIONS_TANKHEALS_en,["STATE"]=false,["FRAME"]=1},
        [3]={["NAME"]=HEALBOT_CLASSES_HEALERS_en,["STATE"]=false,["FRAME"]=1},
        [5]={["NAME"]=HEALBOT_OPTIONS_EMERGENCYHEALS_en,["STATE"]=true,["FRAME"]=1},
        [4]={["NAME"]=HEALBOT_OPTIONS_GROUPHEALS_en,["STATE"]=false,["FRAME"]=1},
        [6]={["NAME"]=HEALBOT_OPTIONS_MYTARGET_en,["STATE"]=false,["FRAME"]=1},
        [7]={["NAME"]=HEALBOT_VEHICLE_en,["STATE"]=false,["FRAME"]=6},
        [8]={["NAME"]=HEALBOT_OPTIONS_PETHEALS_en,["STATE"]=false,["FRAME"]=7},
        [9]={["NAME"]=HEALBOT_OPTIONS_TARGETHEALS_en,["STATE"]=false,["FRAME"]=8},
       [10]={["NAME"]=HEALBOT_FOCUS_en,["STATE"]=false,["FRAME"]=9},
       [11]={["NAME"]=HEALBOT_CUSTOM_CASTBY_ENEMY_en,["STATE"]=false,["FRAME"]=10},}
    else
        for id=1,11 do
            if Healbot_Config_Skins.HealGroups[SkinName][id]["NAME"] == "My Targets" then
                Healbot_Config_Skins.HealGroups[SkinName][id]["NAME"]=HEALBOT_OPTIONS_MYTARGET
            end
        end
        for gl=1,11 do
            if not Healbot_Config_Skins.HealGroups[SkinName][gl]["STATE"] then Healbot_Config_Skins.HealGroups[SkinName][gl]["STATE"]=false end
            if not Healbot_Config_Skins.HealGroups[SkinName][gl]["FRAME"] then
                if Healbot_Config_Skins.HealGroups[SkinName][gl]["NAME"] == HEALBOT_CUSTOM_CASTBY_ENEMY_en then
                    Healbot_Config_Skins.HealGroups[SkinName][gl]["FRAME"]=10
                elseif Healbot_Config_Skins.HealGroups[SkinName][gl]["NAME"] == HEALBOT_FOCUS_en then
                    Healbot_Config_Skins.HealGroups[SkinName][gl]["FRAME"]=9
                elseif Healbot_Config_Skins.HealGroups[SkinName][gl]["NAME"] == HEALBOT_OPTIONS_TARGETHEALS_en then
                    Healbot_Config_Skins.HealGroups[SkinName][gl]["FRAME"]=8
                elseif Healbot_Config_Skins.HealGroups[SkinName][gl]["NAME"] == HEALBOT_OPTIONS_PETHEALS_en then
                    Healbot_Config_Skins.HealGroups[SkinName][gl]["FRAME"]=7
                elseif Healbot_Config_Skins.HealGroups[SkinName][gl]["NAME"] == HEALBOT_VEHICLE_en then
                    Healbot_Config_Skins.HealGroups[SkinName][gl]["FRAME"]=6
                else
                    Healbot_Config_Skins.HealGroups[SkinName][gl]["FRAME"]=1
                end
            end
        end
    end
    if not Healbot_Config_Skins.HeadText[SkinName] then Healbot_Config_Skins.HeadText[SkinName]={} end
    if not Healbot_Config_Skins.HeadBar[SkinName] then Healbot_Config_Skins.HeadBar[SkinName]={} end
    if not Healbot_Config_Skins.Anchors[SkinName] then Healbot_Config_Skins.Anchors[SkinName]={} end
    if not Healbot_Config_Skins.FrameAlias[SkinName] then Healbot_Config_Skins.FrameAlias[SkinName]={} end
    if not Healbot_Config_Skins.FrameAliasBar[SkinName] then Healbot_Config_Skins.FrameAliasBar[SkinName]={} end
    if not Healbot_Config_Skins.HealBar[SkinName] then Healbot_Config_Skins.HealBar[SkinName]={} end
    if not Healbot_Config_Skins.BarCol[SkinName] then Healbot_Config_Skins.BarCol[SkinName]={} end
    if not Healbot_Config_Skins.BarIACol[SkinName] then Healbot_Config_Skins.BarIACol[SkinName]={} end
    if not Healbot_Config_Skins.BarText[SkinName] then Healbot_Config_Skins.BarText[SkinName]={} end
    if not Healbot_Config_Skins.BarTextCol[SkinName] then Healbot_Config_Skins.BarTextCol[SkinName]={} end
    if not Healbot_Config_Skins.Icons[SkinName] then Healbot_Config_Skins.Icons[SkinName]={} end
    if not Healbot_Config_Skins.RaidIcon[SkinName] then Healbot_Config_Skins.RaidIcon[SkinName]={} end
    if not Healbot_Config_Skins.IconText[SkinName] then Healbot_Config_Skins.IconText[SkinName]={} end
    if not Healbot_Config_Skins.IconSets[SkinName] then Healbot_Config_Skins.IconSets[SkinName]={} end
    if not Healbot_Config_Skins.IconSetsText[SkinName] then Healbot_Config_Skins.IconSetsText[SkinName]={} end
    if not Healbot_Config_Skins.Frame[SkinName] then Healbot_Config_Skins.Frame[SkinName]={} end
    if not Healbot_Config_Skins.StickyFrames[SkinName] then Healbot_Config_Skins.StickyFrames[SkinName]={} end
    if not Healbot_Config_Skins.Healing[SkinName] then Healbot_Config_Skins.Healing[SkinName]={} end
    if not Healbot_Config_Skins.General[SkinName] then Healbot_Config_Skins.General[SkinName]={} end
    if not Healbot_Config_Skins.BarSort[SkinName] then Healbot_Config_Skins.BarSort[SkinName]={} end
    if not Healbot_Config_Skins.Chat[SkinName] then Healbot_Config_Skins.Chat[SkinName]={} end
    if not Healbot_Config_Skins.Enemy[SkinName] then Healbot_Config_Skins.Enemy[SkinName]={} end
    if not Healbot_Config_Skins.FocusGroups[SkinName] then Healbot_Config_Skins.FocusGroups[SkinName]={} end
    if not Healbot_Config_Skins.BarVisibility[SkinName] then Healbot_Config_Skins.BarVisibility[SkinName]={} end
    if not Healbot_Config_Skins.BarAggro[SkinName] then Healbot_Config_Skins.BarAggro[SkinName]={} end
    if not Healbot_Config_Skins.Indicators[SkinName] then Healbot_Config_Skins.Indicators[SkinName]={} end
    if not Healbot_Config_Skins.Emerg[SkinName] then Healbot_Config_Skins.Emerg[SkinName]={} end
    if not Healbot_Config_Skins.CustomCols[SkinName] then Healbot_Config_Skins.CustomCols[SkinName]={} end
    if not Healbot_Config_Skins.Adaptive[SkinName] then Healbot_Config_Skins.Adaptive[SkinName]={} end
    if not Healbot_Config_Skins.AdaptiveOrder[SkinName] then Healbot_Config_Skins.AdaptiveOrder[SkinName]={} end
    if not Healbot_Config_Skins.AdaptiveCol[SkinName] then Healbot_Config_Skins.AdaptiveCol[SkinName]={} end
    if not Healbot_Config_Aux.Bar[SkinName] then Healbot_Config_Aux.Bar[SkinName]={} end
    if not Healbot_Config_Aux.BarText[SkinName] then Healbot_Config_Aux.BarText[SkinName]={} end
    if not Healbot_Config_Aux.Overlay[SkinName] then Healbot_Config_Aux.Overlay[SkinName]={} end
    if not HealBot_Skins_ActionIcons[SkinName] then HealBot_Skins_ActionIcons[SkinName]={} end
    if not HealBot_Skins_ActionIconsData[SkinName] then HealBot_Skins_ActionIconsData[SkinName]={} end

    for gl=1,10 do
        if not Healbot_Config_Skins.HeadText[SkinName][gl] then Healbot_Config_Skins.HeadText[SkinName][gl]={} end
        if not Healbot_Config_Skins.Anchors[SkinName][gl] then Healbot_Config_Skins.Anchors[SkinName][gl]={} end
        if not Healbot_Config_Skins.FrameAlias[SkinName][gl] then Healbot_Config_Skins.FrameAlias[SkinName][gl]={} end
        if not Healbot_Config_Skins.HealBar[SkinName][gl] then Healbot_Config_Skins.HealBar[SkinName][gl]={} end
        if not Healbot_Config_Skins.BarIACol[SkinName][gl] then Healbot_Config_Skins.BarIACol[SkinName][gl]={} end
        if not Healbot_Config_Skins.BarText[SkinName][gl] then Healbot_Config_Skins.BarText[SkinName][gl]={} end
        if not Healbot_Config_Skins.Icons[SkinName][gl] then Healbot_Config_Skins.Icons[SkinName][gl]={} end
        if not Healbot_Config_Skins.IconText[SkinName][gl] then Healbot_Config_Skins.IconText[SkinName][gl]={} end
        if not Healbot_Config_Skins.IconSets[SkinName][gl] then Healbot_Config_Skins.IconSets[SkinName][gl]={} end
        for g=1,3 do
            if not Healbot_Config_Skins.IconSets[SkinName][gl][g] then Healbot_Config_Skins.IconSets[SkinName][gl][g]={} end
        end
        if not Healbot_Config_Skins.RaidIcon[SkinName][gl] then Healbot_Config_Skins.RaidIcon[SkinName][gl]={} end
        if not Healbot_Config_Skins.StickyFrames[SkinName][gl] then Healbot_Config_Skins.StickyFrames[SkinName][gl]={} end
        if not Healbot_Config_Skins.BarVisibility[SkinName][gl] then Healbot_Config_Skins.BarVisibility[SkinName][gl]={} end
        if not Healbot_Config_Skins.Emerg[SkinName][gl] then Healbot_Config_Skins.Emerg[SkinName][gl]={} end
    end

    for g=1,8 do
        if Healbot_Config_Skins.FocusGroups[SkinName][g] == nil then Healbot_Config_Skins.FocusGroups[SkinName][g]=true end
    end
    for gl=1,10 do
        if Healbot_Config_Skins.Icons[SkinName][gl]["ONBAR"] then Healbot_Config_Skins.Icons[SkinName][gl]["ONBAR"]=nil end
        if Healbot_Config_Skins.Icons[SkinName][gl]["POSITION"] then Healbot_Config_Skins.Icons[SkinName][gl]["POSITION"]=nil end
        if Healbot_Config_Skins.Icons[SkinName][gl]["DOUBLE"] then Healbot_Config_Skins.Icons[SkinName][gl]["DOUBLE"]=nil end
        if Healbot_Config_Skins.Icons[SkinName][gl]["SHOWBUFF"] then Healbot_Config_Skins.Icons[SkinName][gl]["SHOWBUFF"]=nil end
        if Healbot_Config_Skins.Icons[SkinName][gl]["SHOWDEBUFF"] then Healbot_Config_Skins.Icons[SkinName][gl]["SHOWDEBUFF"]=nil end
        if Healbot_Config_Skins.BarText[SkinName][gl]["CLASSTYPE"] then
            if Healbot_Config_Skins.BarText[SkinName][gl]["CLASSONBAR"] and Healbot_Config_Skins.BarText[SkinName][gl]["CLASSTYPE"]<2 then
                Healbot_Config_Skins.Icons[SkinName][gl]["SHOWCLASS"]=true
                Healbot_Config_Skins.BarText[SkinName][gl]["CLASSONBAR"]=false
                Healbot_Config_Skins.Icons[SkinName][gl]["SHOWROLE"]=Healbot_Config_Skins.BarText[SkinName][gl]["SHOWROLE"]
            end
            Healbot_Config_Skins.BarText[SkinName][gl]["CLASSTYPE"]=nil
        end
        if Healbot_Config_Skins.BarVisibility[SkinName][gl]["ALERTIC"] == nil then
            Healbot_Config_Skins.BarVisibility[SkinName][gl]["ALERTIC"]=Healbot_Config_Skins.Healing[SkinName]["ALERTIC"] or 0.98
        end
        if Healbot_Config_Skins.BarVisibility[SkinName][gl]["ALERTOC"] == nil then
            Healbot_Config_Skins.BarVisibility[SkinName][gl]["ALERTOC"]=Healbot_Config_Skins.Healing[SkinName]["ALERTOC"] or 0.9
        end
        if Healbot_Config_Skins.BarSort[SkinName][gl] then
            if (Healbot_Config_Skins.BarSort[SkinName][gl]["RAIDORDER"] or 99) == 3 then Healbot_Config_Skins.BarSort[SkinName][gl]["RAIDORDER"]=nil end
            if (Healbot_Config_Skins.BarSort[SkinName][gl]["SUBORDER"] or 99) == 1 then Healbot_Config_Skins.BarSort[SkinName][gl]["SUBORDER"]=nil end
            if Healbot_Config_Skins.BarSort[SkinName][gl]["OORLAST"] == false then Healbot_Config_Skins.BarSort[SkinName][gl]["OORLAST"]=nil end
            if Healbot_Config_Skins.BarSort[SkinName][gl]["SUBPF"] then Healbot_Config_Skins.BarSort[SkinName][gl]["SUBPF"]=nil end
        end
        if Healbot_Config_Skins.BarText[SkinName][gl]["TAGAGGROONLYTIP"] == nil then Healbot_Config_Skins.BarText[SkinName][gl]["TAGAGGROONLYTIP"]=true end
        if Healbot_Config_Skins.BarText[SkinName][gl]["TAGSTATEONLYTIP"] == nil then Healbot_Config_Skins.BarText[SkinName][gl]["TAGSTATEONLYTIP"]=true end
        if Healbot_Config_Skins.BarAggro[SkinName][gl] then
            if (Healbot_Config_Skins.BarAggro[SkinName][gl]["ALERT"] or 99) == 2 then Healbot_Config_Skins.BarAggro[SkinName][gl]["ALERT"]=nil end
            if (Healbot_Config_Skins.BarAggro[SkinName][gl]["ALERTIND"] or 99) == 2 then Healbot_Config_Skins.BarAggro[SkinName][gl]["ALERTIND"]=nil end
            if (Healbot_Config_Skins.BarAggro[SkinName][gl]["R"] or 99) == 1 then Healbot_Config_Skins.BarAggro[SkinName][gl]["R"]=nil end
            if (Healbot_Config_Skins.BarAggro[SkinName][gl]["G"] or 99) == 0 then Healbot_Config_Skins.BarAggro[SkinName][gl]["G"]=nil end
            if (Healbot_Config_Skins.BarAggro[SkinName][gl]["B"] or 99) == 0 then Healbot_Config_Skins.BarAggro[SkinName][gl]["B"]=nil end
            if (Healbot_Config_Skins.BarAggro[SkinName][gl]["TEXTFORMAT"] or 99) == 3 then Healbot_Config_Skins.BarAggro[SkinName][gl]["TEXTFORMAT"]=nil end
            if (Healbot_Config_Skins.BarAggro[SkinName][gl]["SHOWTEXT"] or 99) == 1 then Healbot_Config_Skins.BarAggro[SkinName][gl]["SHOWTEXT"]=nil end
            if Healbot_Config_Skins.BarAggro[SkinName][gl]["SHOWBARSPCT"] == false then Healbot_Config_Skins.BarAggro[SkinName][gl]["SHOWBARSPCT"]=nil end
            if Healbot_Config_Skins.BarAggro[SkinName][gl]["SHOWIND"] then Healbot_Config_Skins.BarAggro[SkinName][gl]["SHOWIND"]=nil end
            if Healbot_Config_Skins.BarAggro[SkinName][gl]["SHOWBARS"] then Healbot_Config_Skins.BarAggro[SkinName][gl]["SHOWBARS"]=nil end
            if Healbot_Config_Skins.BarAggro[SkinName][gl]["SHOW"] then Healbot_Config_Skins.BarAggro[SkinName][gl]["SHOW"]=nil end
            if Healbot_Config_Skins.BarAggro[SkinName][gl]["HAZARD"] then Healbot_Config_Skins.BarAggro[SkinName][gl]["HAZARD"]=nil end
            Healbot_Config_Skins.BarAggro[SkinName][gl]["ALERTADAP"]=nil
            Healbot_Config_Skins.BarAggro[SkinName][gl]["SHOWBARSPCT"]=nil
            Healbot_Config_Skins.BarAggro[SkinName][gl]["SHOWBARS"]=nil
            Healbot_Config_Skins.BarAggro[SkinName][gl]["FREQ"]=nil
            Healbot_Config_Skins.BarAggro[SkinName][gl]["MINA"]=nil
            Healbot_Config_Skins.BarAggro[SkinName][gl]["MAXA"]=nil
            HealBot_Util_EmptyTable(Healbot_Config_Skins.BarAggro[SkinName], gl)
        end 
        if Healbot_Config_Skins.BarVisibility[SkinName][gl]["HIDEOOR"] == nil then Healbot_Config_Skins.BarVisibility[SkinName][gl]["HIDEOOR"]=false end
        if Healbot_Config_Skins.Frame[SkinName][gl] then
            if (Healbot_Config_Skins.Frame[SkinName][gl]["TIPLOC"] or 99) == 5 then Healbot_Config_Skins.Frame[SkinName][gl]["TIPLOC"]=nil end
            if (Healbot_Config_Skins.Frame[SkinName][gl]["AUTOCLOSE"] or 99) == 1 then Healbot_Config_Skins.Frame[SkinName][gl]["AUTOCLOSE"]=nil end
            if (Healbot_Config_Skins.Frame[SkinName][gl]["LOCKED"] or 99) == 1 then Healbot_Config_Skins.Frame[SkinName][gl]["LOCKED"]=nil end
            if (Healbot_Config_Skins.Frame[SkinName][gl]["SCALE"] or 99) == 1 then Healbot_Config_Skins.Frame[SkinName][gl]["SCALE"]=nil end
            if (Healbot_Config_Skins.Frame[SkinName][gl]["PADDING"] or 99) == 1 then Healbot_Config_Skins.Frame[SkinName][gl]["PADDING"]=nil end
            if (Healbot_Config_Skins.Frame[SkinName][gl]["GLOW"] or 99) == 3 then Healbot_Config_Skins.Frame[SkinName][gl]["GLOW"]=nil end
            if (Healbot_Config_Skins.Frame[SkinName][gl]["ICONGLOW"] or 99) == 2 then Healbot_Config_Skins.Frame[SkinName][gl]["ICONGLOW"]=nil end
            if (Healbot_Config_Skins.Frame[SkinName][gl]["BACKR"] or 99) == 0.2 then Healbot_Config_Skins.Frame[SkinName][gl]["BACKR"]=nil end
            if (Healbot_Config_Skins.Frame[SkinName][gl]["BACKG"] or 99) == 0.2 then Healbot_Config_Skins.Frame[SkinName][gl]["BACKG"]=nil end
            if (Healbot_Config_Skins.Frame[SkinName][gl]["BACKB"] or 99) == 0.7 then Healbot_Config_Skins.Frame[SkinName][gl]["BACKB"]=nil end
            if (Healbot_Config_Skins.Frame[SkinName][gl]["BACKA"] or 99) == 0.1 then Healbot_Config_Skins.Frame[SkinName][gl]["BACKA"]=nil end
            if (Healbot_Config_Skins.Frame[SkinName][gl]["BORDERR"] or 99) == 0.2 then Healbot_Config_Skins.Frame[SkinName][gl]["BORDERR"]=nil end
            if (Healbot_Config_Skins.Frame[SkinName][gl]["BORDERG"] or 99) == 0.2 then Healbot_Config_Skins.Frame[SkinName][gl]["BORDERG"]=nil end
            if (Healbot_Config_Skins.Frame[SkinName][gl]["BORDERB"] or 99) == 0.2 then Healbot_Config_Skins.Frame[SkinName][gl]["BORDERB"]=nil end
            if (Healbot_Config_Skins.Frame[SkinName][gl]["BORDERA"] or 99) == 0.4 then Healbot_Config_Skins.Frame[SkinName][gl]["BORDERA"]=nil end
            if (Healbot_Config_Skins.Frame[SkinName][gl]["SFOFFSETH"] or 99) == 0 then Healbot_Config_Skins.Frame[SkinName][gl]["SFOFFSETH"]=nil end
            if (Healbot_Config_Skins.Frame[SkinName][gl]["SFOFFSETV"] or 99) == 0 then Healbot_Config_Skins.Frame[SkinName][gl]["SFOFFSETV"]=nil end
            Healbot_Config_Skins.Frame[SkinName][gl]["EDGEPADDING"]=nil
            Healbot_Config_Skins.Frame[SkinName][gl]["OPENSOUND"]=nil
            HealBot_Util_EmptyTable(Healbot_Config_Skins.Frame[SkinName], gl)
        end
        if Healbot_Config_Skins.StickyFrames[SkinName][gl]["STUCK"] == nil then Healbot_Config_Skins.StickyFrames[SkinName][gl]["STUCK"]=false end
        if Healbot_Config_Skins.StickyFrames[SkinName][gl]["STUCKTO"] == nil then Healbot_Config_Skins.StickyFrames[SkinName][gl]["STUCKTO"]=0 end
        if Healbot_Config_Skins.StickyFrames[SkinName][gl]["STUCKPOINT"] == nil then Healbot_Config_Skins.StickyFrames[SkinName][gl]["STUCKPOINT"]="NONE" end
        if Healbot_Config_Skins.StickyFrames[SkinName][gl]["STUCKTOPOINT"] == nil then Healbot_Config_Skins.StickyFrames[SkinName][gl]["STUCKTOPOINT"]="NONE" end

        HealBot_Skins_Check_IconSetsText(SkinName, gl, "DURTHRH", "DBDURTHRH", 9)
        HealBot_Skins_Check_IconSetsText(SkinName, gl, "BUFFDURTHRH", "BUFFDURTHRH", 9)
        HealBot_Skins_Check_IconSetsText(SkinName, gl, "DURWARN", "DBDURWARN", 3)
        HealBot_Skins_Check_IconSetsText(SkinName, gl, "BUFFDURWARN", "BUFFDURWARN", 3)
        HealBot_Skins_Check_IconSetsText(SkinName, gl, "SCNT", "DBSCNT", true)
        HealBot_Skins_Check_IconSetsText(SkinName, gl, "BUFFSCNT", "BUFFSCNT", true)
        HealBot_Skins_Check_IconSetsText(SkinName, gl, "BUFFSSCNT", "BUFFSSCNT", false)
        HealBot_Skins_Check_IconSetsText(SkinName, gl, "SDUR", "DBSDUR", false)
        HealBot_Skins_Check_IconSetsText(SkinName, gl, "BUFFSDUR", "BUFFSDUR", true)
        HealBot_Skins_Check_IconSetsText(SkinName, gl, "BUFFSSDUR", "BUFFSSDUR", false)
        HealBot_Skins_Check_IconSetsText(SkinName, gl, "FONT", "DBFONT", HealBot_Data_Default_FontName())
        HealBot_Skins_Check_IconSetsText(SkinName, gl, "BUFFFONT", "BUFFFONT", HealBot_Data_Default_FontName())
        HealBot_Skins_Check_IconSetsText(SkinName, gl, "OUTLINE", "DBOUTLINE", 2)
        HealBot_Skins_Check_IconSetsText(SkinName, gl, "BUFFOUTLINE", "BUFFOUTLINE", 2)
        HealBot_Skins_Check_IconSetsText(SkinName, gl, "HEIGHT", "DBHEIGHT", 9)
        HealBot_Skins_Check_IconSetsText(SkinName, gl, "BUFFHEIGHT", "BUFFHEIGHT", 9)
        if Healbot_Config_Skins.IconText[SkinName][gl]["SELFIND"] == nil then Healbot_Config_Skins.IconText[SkinName][gl]["SELFIND"]=false end
        if Healbot_Config_Skins.RaidIcon[SkinName][gl]["SHOW"] == nil then Healbot_Config_Skins.RaidIcon[SkinName][gl]["SHOW"]=true end
        if Healbot_Config_Skins.RaidIcon[SkinName][gl]["STAR"] == nil then Healbot_Config_Skins.RaidIcon[SkinName][gl]["STAR"]=true end
        if Healbot_Config_Skins.RaidIcon[SkinName][gl]["CIRCLE"] == nil then Healbot_Config_Skins.RaidIcon[SkinName][gl]["CIRCLE"]=true end
        if Healbot_Config_Skins.RaidIcon[SkinName][gl]["DIAMOND"] == nil then Healbot_Config_Skins.RaidIcon[SkinName][gl]["DIAMOND"]=true end
        if Healbot_Config_Skins.RaidIcon[SkinName][gl]["TRIANGLE"] == nil then Healbot_Config_Skins.RaidIcon[SkinName][gl]["TRIANGLE"]=true end
        if Healbot_Config_Skins.RaidIcon[SkinName][gl]["MOON"] == nil then Healbot_Config_Skins.RaidIcon[SkinName][gl]["MOON"]=true end
        if Healbot_Config_Skins.RaidIcon[SkinName][gl]["SQUARE"] == nil then Healbot_Config_Skins.RaidIcon[SkinName][gl]["SQUARE"]=true end
        if Healbot_Config_Skins.RaidIcon[SkinName][gl]["CROSS"] == nil then Healbot_Config_Skins.RaidIcon[SkinName][gl]["CROSS"]=true end
        if Healbot_Config_Skins.RaidIcon[SkinName][gl]["SKULL"] == nil then Healbot_Config_Skins.RaidIcon[SkinName][gl]["SKULL"]=true end
        HealBot_Skins_Check_IconSets(SkinName, gl, "DEBUFFONBAR", "DEBUFFONBAR", 1)
        HealBot_Skins_Check_IconSets(SkinName, gl, "BUFFONBAR", "BUFFONBAR", 1)
        if fromImport then
            Healbot_Config_Skins.Icons[SkinName][gl]["CLASSONBAR"]=1
            Healbot_Config_Skins.Icons[SkinName][gl]["TARGETONBAR"]=1
            Healbot_Config_Skins.Icons[SkinName][gl]["RCONBAR"]=1
            Healbot_Config_Skins.Icons[SkinName][gl]["OORONBAR"]=1
        else
            if Healbot_Config_Skins.Icons[SkinName][gl]["CLASSONBAR"] == nil then Healbot_Config_Skins.Icons[SkinName][gl]["CLASSONBAR"]=1 end
            if Healbot_Config_Skins.Icons[SkinName][gl]["TARGETONBAR"] == nil then Healbot_Config_Skins.Icons[SkinName][gl]["TARGETONBAR"]=1 end
            if Healbot_Config_Skins.Icons[SkinName][gl]["RCONBAR"] == nil then Healbot_Config_Skins.Icons[SkinName][gl]["RCONBAR"]=1 end
            if Healbot_Config_Skins.Icons[SkinName][gl]["OORONBAR"] == nil then Healbot_Config_Skins.Icons[SkinName][gl]["OORONBAR"]=1 end
        end

        HealBot_Skins_Check_IconSets(SkinName, gl, "DEBUFFDOUBLE", "DEBUFFDOUBLE", false)
        HealBot_Skins_Check_IconSets(SkinName, gl, "BUFFDOUBLE", "BUFFDOUBLE", false)
        if Healbot_Config_Skins.Icons[SkinName][gl]["SHOWRC"] == nil then Healbot_Config_Skins.Icons[SkinName][gl]["SHOWRC"]=true end
        if Healbot_Config_Skins.Icons[SkinName][gl]["SHOWCOMBAT"] == nil then Healbot_Config_Skins.Icons[SkinName][gl]["SHOWCOMBAT"]=false end
        if Healbot_Config_Skins.Icons[SkinName][gl]["SHOWHOSTILE"] == nil then Healbot_Config_Skins.Icons[SkinName][gl]["SHOWHOSTILE"]=false end
        if Healbot_Config_Skins.Icons[SkinName][gl]["SHOWRESTING"] == nil then Healbot_Config_Skins.Icons[SkinName][gl]["SHOWRESTING"]=false end
        if Healbot_Config_Skins.Icons[SkinName][gl]["SHOWDIR"] == nil then Healbot_Config_Skins.Icons[SkinName][gl]["SHOWDIR"]=false end
        if Healbot_Config_Skins.Icons[SkinName][gl]["SHOWDIRMOUSE"] == nil then Healbot_Config_Skins.Icons[SkinName][gl]["SHOWDIRMOUSE"]=false end
        HealBot_Skins_Check_IconSets(SkinName, gl, "SCALE", "BSCALE", 0.3, 0.4)
        HealBot_Skins_Check_IconSets(SkinName, gl, "DSCALE", "DSCALE", 0.3, 0.4)
        HealBot_Skins_Check_IconSets(SkinName, gl, "I15EN", "DI15EN", true)
        HealBot_Skins_Check_IconSets(SkinName, gl, "BUFFI15EN", "BUFFI15EN", true)

        HealBot_Skins_Check_IconSets(SkinName, gl, "DEBUFFANCHOR", "DEBUFFANCHOR", 1, 3, 7)
        HealBot_Skins_Check_IconSets(SkinName, gl, "BUFFANCHOR", "BUFFANCHOR", 2, 4, 8)
        if Healbot_Config_Skins.Icons[SkinName][gl]["CLASSANCHOR"] == nil then Healbot_Config_Skins.Icons[SkinName][gl]["CLASSANCHOR"]=1 end
        if Healbot_Config_Skins.Icons[SkinName][gl]["TARGETANCHOR"] == nil then Healbot_Config_Skins.Icons[SkinName][gl]["TARGETANCHOR"]=1 end
        if Healbot_Config_Skins.Icons[SkinName][gl]["RCANCHOR"] == nil then Healbot_Config_Skins.Icons[SkinName][gl]["RCANCHOR"]=1 end
        if Healbot_Config_Skins.Icons[SkinName][gl]["OORANCHOR"] == nil then Healbot_Config_Skins.Icons[SkinName][gl]["OORANCHOR"]=1 end

        HealBot_Skins_Check_IconSets(SkinName, gl, "FADE", "DFADE", false)
        HealBot_Skins_Check_IconSets(SkinName, gl, "BUFFFADE", "BUFFFADE", false)
        HealBot_Skins_Check_IconSets(SkinName, gl, "FADESECS", "DFADESECS", 15)
        HealBot_Skins_Check_IconSets(SkinName, gl, "BUFFFADESECS", "BUFFFADESECS", 15)
        HealBot_Skins_Check_IconSets(SkinName, gl, "MAXDICONS", "MAXDICONS", 4, 1)
        HealBot_Skins_Check_IconSets(SkinName, gl, "MAXBICONS", "MAXBICONS", 4, 1)
        if Healbot_Config_Skins.IconSets[SkinName][gl][1]["MAXDICONS"]>6 then Healbot_Config_Skins.IconSets[SkinName][gl][1]["MAXDICONS"]=6 end
        if Healbot_Config_Skins.IconSets[SkinName][gl][1]["MAXBICONS"]>8 then Healbot_Config_Skins.IconSets[SkinName][gl][1]["MAXBICONS"]=8 end
        for mi=2,3 do
            if Healbot_Config_Skins.IconSets[SkinName][gl][mi]["MAXDICONS"]>2 then Healbot_Config_Skins.IconSets[SkinName][gl][mi]["MAXDICONS"]=2 end
            if Healbot_Config_Skins.IconSets[SkinName][gl][mi]["MAXBICONS"]>2 then Healbot_Config_Skins.IconSets[SkinName][gl][mi]["MAXBICONS"]=2 end
        end
        HealBot_Skins_Check_IconSets(SkinName, gl, "BICONSPACER", "BICONSPACER", 0)
        HealBot_Skins_Check_IconSets(SkinName, gl, "DICONSPACER", "DICONSPACER", 0)
        if Healbot_Config_Skins.Icons[SkinName][gl]["SHOWCLASS"] == nil then Healbot_Config_Skins.Icons[SkinName][gl]["SHOWCLASS"]=false end
        if Healbot_Config_Skins.Icons[SkinName][gl]["SHOWROLE"] == nil then Healbot_Config_Skins.Icons[SkinName][gl]["SHOWROLE"]=false end
        if not Healbot_Config_Skins.Icons[SkinName][gl]["CLASSVOFFSET"] then Healbot_Config_Skins.Icons[SkinName][gl]["CLASSVOFFSET"]=0 end
        if Healbot_Config_Skins.Icons[SkinName][gl]["CLASSHOFFSET"] == nil then Healbot_Config_Skins.Icons[SkinName][gl]["CLASSHOFFSET"]=0 end
        if Healbot_Config_Skins.Icons[SkinName][gl]["CLASSSCALE"] == nil then Healbot_Config_Skins.Icons[SkinName][gl]["CLASSSCALE"]=0.5 end
        if Healbot_Config_Skins.Icons[SkinName][gl]["CLASSZOOM"] == nil then Healbot_Config_Skins.Icons[SkinName][gl]["CLASSZOOM"]=0.05 end
        if Healbot_Config_Skins.Icons[SkinName][gl]["CLASSEN"] == nil then Healbot_Config_Skins.Icons[SkinName][gl]["CLASSEN"]=false end
        if not Healbot_Config_Skins.Icons[SkinName][gl]["TARGETVOFFSET"] then Healbot_Config_Skins.Icons[SkinName][gl]["TARGETVOFFSET"]=0 end
        if Healbot_Config_Skins.Icons[SkinName][gl]["TARGETHOFFSET"] == nil then Healbot_Config_Skins.Icons[SkinName][gl]["TARGETHOFFSET"]=0 end
        if Healbot_Config_Skins.Icons[SkinName][gl]["TARGETSCALE"] == nil then Healbot_Config_Skins.Icons[SkinName][gl]["TARGETSCALE"]=0.5 end
        if Healbot_Config_Skins.Icons[SkinName][gl]["TARGETZOOM"] == nil then Healbot_Config_Skins.Icons[SkinName][gl]["TARGETZOOM"]=0.05 end
        if Healbot_Config_Skins.Icons[SkinName][gl]["TARGETEN"] == nil then Healbot_Config_Skins.Icons[SkinName][gl]["TARGETEN"]=false end
        if not Healbot_Config_Skins.Icons[SkinName][gl]["RCVOFFSET"] then Healbot_Config_Skins.Icons[SkinName][gl]["RCVOFFSET"]=0 end
        if Healbot_Config_Skins.Icons[SkinName][gl]["RCHOFFSET"] == nil then Healbot_Config_Skins.Icons[SkinName][gl]["RCHOFFSET"]=0 end

        HealBot_Skins_Check_IconSets(SkinName, gl, "DVOFFSET", "DVOFFSET", 0)
        HealBot_Skins_Check_IconSets(SkinName, gl, "DHOFFSET", "DHOFFSET", 0)
        HealBot_Skins_Check_IconSets(SkinName, gl, "BVOFFSET", "BVOFFSET", 0)
        HealBot_Skins_Check_IconSets(SkinName, gl, "BHOFFSET", "BHOFFSET", 0)
        HealBot_Skins_Check_IconSets(SkinName, gl, "BZOOM", "BZOOM", 0.05)
        HealBot_Skins_Check_IconSets(SkinName, gl, "DZOOM", "DZOOM", 0.05)
        if Healbot_Config_Skins.Icons[SkinName][gl]["RCSCALE"] == nil then Healbot_Config_Skins.Icons[SkinName][gl]["RCSCALE"]=0.5 end
        if Healbot_Config_Skins.Icons[SkinName][gl]["RCZOOM"] == nil then Healbot_Config_Skins.Icons[SkinName][gl]["RCZOOM"]=0.05 end
        if Healbot_Config_Skins.Icons[SkinName][gl]["RCEN"] == nil then Healbot_Config_Skins.Icons[SkinName][gl]["RCEN"]=false end
        if not Healbot_Config_Skins.Icons[SkinName][gl]["OORVOFFSET"] then Healbot_Config_Skins.Icons[SkinName][gl]["OORVOFFSET"]=0 end
        if Healbot_Config_Skins.Icons[SkinName][gl]["OORHOFFSET"] == nil then Healbot_Config_Skins.Icons[SkinName][gl]["OORHOFFSET"]=0 end
        if Healbot_Config_Skins.Icons[SkinName][gl]["OORSCALE"] == nil then Healbot_Config_Skins.Icons[SkinName][gl]["OORSCALE"]=0.5 end
        if Healbot_Config_Skins.Icons[SkinName][gl]["OORZOOM"] == nil then Healbot_Config_Skins.Icons[SkinName][gl]["OORZOOM"]=0.05 end
        if Healbot_Config_Skins.Icons[SkinName][gl]["OOREN"] == nil then Healbot_Config_Skins.Icons[SkinName][gl]["OOREN"]=false end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl] then
            if (Healbot_Config_Skins.BarTextCol[SkinName][gl]["NCR"] or 99) == 0 then Healbot_Config_Skins.BarTextCol[SkinName][gl]["NCR"]=nil end
            if (Healbot_Config_Skins.BarTextCol[SkinName][gl]["NCG"] or 99) == 1 then Healbot_Config_Skins.BarTextCol[SkinName][gl]["NCG"]=nil end
            if (Healbot_Config_Skins.BarTextCol[SkinName][gl]["NCB"] or 99) == 0 then Healbot_Config_Skins.BarTextCol[SkinName][gl]["NCB"]=nil end
            if (Healbot_Config_Skins.BarTextCol[SkinName][gl]["NICR"] or 99) == 0 then Healbot_Config_Skins.BarTextCol[SkinName][gl]["NICR"]=nil end
            if (Healbot_Config_Skins.BarTextCol[SkinName][gl]["NICG"] or 99) == 1 then Healbot_Config_Skins.BarTextCol[SkinName][gl]["NICG"]=nil end
            if (Healbot_Config_Skins.BarTextCol[SkinName][gl]["NICB"] or 99) == 0 then Healbot_Config_Skins.BarTextCol[SkinName][gl]["NICB"]=nil end
            if (Healbot_Config_Skins.BarTextCol[SkinName][gl]["NCCR"] or 99) == 0 then Healbot_Config_Skins.BarTextCol[SkinName][gl]["NCCR"]=nil end
            if (Healbot_Config_Skins.BarTextCol[SkinName][gl]["NCCG"] or 99) == 1 then Healbot_Config_Skins.BarTextCol[SkinName][gl]["NCCG"]=nil end
            if (Healbot_Config_Skins.BarTextCol[SkinName][gl]["NCCB"] or 99) == 0 then Healbot_Config_Skins.BarTextCol[SkinName][gl]["NCCB"]=nil end
            if (Healbot_Config_Skins.BarTextCol[SkinName][gl]["NIT"] or 99) == 70 then Healbot_Config_Skins.BarTextCol[SkinName][gl]["NIT"]=nil end
            if (Healbot_Config_Skins.BarTextCol[SkinName][gl]["NCT"] or 99) == 40 then Healbot_Config_Skins.BarTextCol[SkinName][gl]["NCT"]=nil end
            if (Healbot_Config_Skins.BarTextCol[SkinName][gl]["NCA"] or 99) == 0.95 then Healbot_Config_Skins.BarTextCol[SkinName][gl]["NCA"]=nil end
            if (Healbot_Config_Skins.BarTextCol[SkinName][gl]["NCDA"] or 99) == 0.5 then Healbot_Config_Skins.BarTextCol[SkinName][gl]["NCDA"]=nil end
            if (Healbot_Config_Skins.BarTextCol[SkinName][gl]["NDCR"] or 99) == 1 then Healbot_Config_Skins.BarTextCol[SkinName][gl]["NDCR"]=nil end
            if (Healbot_Config_Skins.BarTextCol[SkinName][gl]["NDCG"] or 99) == 0.2 then Healbot_Config_Skins.BarTextCol[SkinName][gl]["NDCG"]=nil end
            if (Healbot_Config_Skins.BarTextCol[SkinName][gl]["NDCB"] or 99) == 0.2 then Healbot_Config_Skins.BarTextCol[SkinName][gl]["NDCB"]=nil end
            if (Healbot_Config_Skins.BarTextCol[SkinName][gl]["NRCR"] or 99) == 0.2 then Healbot_Config_Skins.BarTextCol[SkinName][gl]["NRCR"]=nil end
            if (Healbot_Config_Skins.BarTextCol[SkinName][gl]["NRCG"] or 99) == 1 then Healbot_Config_Skins.BarTextCol[SkinName][gl]["NRCG"]=nil end
            if (Healbot_Config_Skins.BarTextCol[SkinName][gl]["NRCB"] or 99) == 0.2 then Healbot_Config_Skins.BarTextCol[SkinName][gl]["NRCB"]=nil end
            if (Healbot_Config_Skins.BarTextCol[SkinName][gl]["NSCR"] or 99) == 0.4 then Healbot_Config_Skins.BarTextCol[SkinName][gl]["NSCR"]=nil end
            if (Healbot_Config_Skins.BarTextCol[SkinName][gl]["NSCG"] or 99) == 0.02 then Healbot_Config_Skins.BarTextCol[SkinName][gl]["NSCG"]=nil end
            if (Healbot_Config_Skins.BarTextCol[SkinName][gl]["NSCB"] or 99) == 0.4 then Healbot_Config_Skins.BarTextCol[SkinName][gl]["NSCB"]=nil end
            if (Healbot_Config_Skins.BarTextCol[SkinName][gl]["SCR"] or 99) == 1 then Healbot_Config_Skins.BarTextCol[SkinName][gl]["SCR"]=nil end
            if (Healbot_Config_Skins.BarTextCol[SkinName][gl]["SCG"] or 99) == 1 then Healbot_Config_Skins.BarTextCol[SkinName][gl]["SCG"]=nil end
            if (Healbot_Config_Skins.BarTextCol[SkinName][gl]["SCB"] or 99) == 0 then Healbot_Config_Skins.BarTextCol[SkinName][gl]["SCB"]=nil end
            if (Healbot_Config_Skins.BarTextCol[SkinName][gl]["SCA"] or 99) == 0.95 then Healbot_Config_Skins.BarTextCol[SkinName][gl]["SCA"]=nil end
            if (Healbot_Config_Skins.BarTextCol[SkinName][gl]["SICR"] or 99) == 1 then Healbot_Config_Skins.BarTextCol[SkinName][gl]["SICR"]=nil end
            if (Healbot_Config_Skins.BarTextCol[SkinName][gl]["SICG"] or 99) == 1 then Healbot_Config_Skins.BarTextCol[SkinName][gl]["SICG"]=nil end
            if (Healbot_Config_Skins.BarTextCol[SkinName][gl]["SICB"] or 99) == 0 then Healbot_Config_Skins.BarTextCol[SkinName][gl]["SICB"]=nil end
            if (Healbot_Config_Skins.BarTextCol[SkinName][gl]["SCCR"] or 99) == 1 then Healbot_Config_Skins.BarTextCol[SkinName][gl]["SCCR"]=nil end
            if (Healbot_Config_Skins.BarTextCol[SkinName][gl]["SCCG"] or 99) == 1 then Healbot_Config_Skins.BarTextCol[SkinName][gl]["SCCG"]=nil end
            if (Healbot_Config_Skins.BarTextCol[SkinName][gl]["SCCB"] or 99) == 0 then Healbot_Config_Skins.BarTextCol[SkinName][gl]["SCCB"]=nil end
            if (Healbot_Config_Skins.BarTextCol[SkinName][gl]["SIT"] or 99) == 70 then Healbot_Config_Skins.BarTextCol[SkinName][gl]["SIT"]=nil end
            if (Healbot_Config_Skins.BarTextCol[SkinName][gl]["SCT"] or 99) == 40 then Healbot_Config_Skins.BarTextCol[SkinName][gl]["SCT"]=nil end
            if (Healbot_Config_Skins.BarTextCol[SkinName][gl]["SCDA"] or 99) == 0.5 then Healbot_Config_Skins.BarTextCol[SkinName][gl]["SCDA"]=nil end
            if (Healbot_Config_Skins.BarTextCol[SkinName][gl]["SDCR"] or 99) == 1 then Healbot_Config_Skins.BarTextCol[SkinName][gl]["SDCR"]=nil end
            if (Healbot_Config_Skins.BarTextCol[SkinName][gl]["SDCG"] or 99) == 0.2 then Healbot_Config_Skins.BarTextCol[SkinName][gl]["SDCG"]=nil end
            if (Healbot_Config_Skins.BarTextCol[SkinName][gl]["SDCB"] or 99) == 0.2 then Healbot_Config_Skins.BarTextCol[SkinName][gl]["SDCB"]=nil end
            if (Healbot_Config_Skins.BarTextCol[SkinName][gl]["SRCR"] or 99) == 0.2 then Healbot_Config_Skins.BarTextCol[SkinName][gl]["SRCR"]=nil end
            if (Healbot_Config_Skins.BarTextCol[SkinName][gl]["SRCG"] or 99) == 1 then Healbot_Config_Skins.BarTextCol[SkinName][gl]["SRCG"]=nil end
            if (Healbot_Config_Skins.BarTextCol[SkinName][gl]["SRCB"] or 99) == 0.2 then Healbot_Config_Skins.BarTextCol[SkinName][gl]["SRCB"]=nil end
            if (Healbot_Config_Skins.BarTextCol[SkinName][gl]["SSCR"] or 99) == 0.4 then Healbot_Config_Skins.BarTextCol[SkinName][gl]["SSCR"]=nil end
            if (Healbot_Config_Skins.BarTextCol[SkinName][gl]["SSCG"] or 99) == 0.02 then Healbot_Config_Skins.BarTextCol[SkinName][gl]["SSCG"]=nil end
            if (Healbot_Config_Skins.BarTextCol[SkinName][gl]["SSCB"] or 99) == 0.4 then Healbot_Config_Skins.BarTextCol[SkinName][gl]["SSCB"]=nil end
            if (Healbot_Config_Skins.BarTextCol[SkinName][gl]["NAME"] or 99) == 2 then Healbot_Config_Skins.BarTextCol[SkinName][gl]["NAME"]=nil end
            if (Healbot_Config_Skins.BarTextCol[SkinName][gl]["STATE"] or 99) == 2 then Healbot_Config_Skins.BarTextCol[SkinName][gl]["STATE"]=nil end
            if (Healbot_Config_Skins.BarTextCol[SkinName][gl]["HECR"] or 99) == 0 then Healbot_Config_Skins.BarTextCol[SkinName][gl]["HECR"]=nil end
            if (Healbot_Config_Skins.BarTextCol[SkinName][gl]["HECG"] or 99) == 1 then Healbot_Config_Skins.BarTextCol[SkinName][gl]["HECG"]=nil end
            if (Healbot_Config_Skins.BarTextCol[SkinName][gl]["HECB"] or 99) == 0 then Healbot_Config_Skins.BarTextCol[SkinName][gl]["HECB"]=nil end
            if (Healbot_Config_Skins.BarTextCol[SkinName][gl]["HCR"] or 99) == 0 then Healbot_Config_Skins.BarTextCol[SkinName][gl]["HCR"]=nil end
            if (Healbot_Config_Skins.BarTextCol[SkinName][gl]["HCG"] or 99) == 1 then Healbot_Config_Skins.BarTextCol[SkinName][gl]["HCG"]=nil end
            if (Healbot_Config_Skins.BarTextCol[SkinName][gl]["HCB"] or 99) == 0 then Healbot_Config_Skins.BarTextCol[SkinName][gl]["HCB"]=nil end
            if (Healbot_Config_Skins.BarTextCol[SkinName][gl]["HCA"] or 99) == 0.95 then Healbot_Config_Skins.BarTextCol[SkinName][gl]["HCA"]=nil end
            if (Healbot_Config_Skins.BarTextCol[SkinName][gl]["HICR"] or 99) == 0 then Healbot_Config_Skins.BarTextCol[SkinName][gl]["HICR"]=nil end
            if (Healbot_Config_Skins.BarTextCol[SkinName][gl]["HICG"] or 99) == 1 then Healbot_Config_Skins.BarTextCol[SkinName][gl]["HICG"]=nil end
            if (Healbot_Config_Skins.BarTextCol[SkinName][gl]["HICB"] or 99) == 0 then Healbot_Config_Skins.BarTextCol[SkinName][gl]["HICB"]=nil end
            if (Healbot_Config_Skins.BarTextCol[SkinName][gl]["HCCR"] or 99) == 0 then Healbot_Config_Skins.BarTextCol[SkinName][gl]["HCCR"]=nil end
            if (Healbot_Config_Skins.BarTextCol[SkinName][gl]["HCCG"] or 99) == 1 then Healbot_Config_Skins.BarTextCol[SkinName][gl]["HCCG"]=nil end
            if (Healbot_Config_Skins.BarTextCol[SkinName][gl]["HCCB"] or 99) == 0 then Healbot_Config_Skins.BarTextCol[SkinName][gl]["HCCB"]=nil end
            if (Healbot_Config_Skins.BarTextCol[SkinName][gl]["HIT"] or 99) == 70 then Healbot_Config_Skins.BarTextCol[SkinName][gl]["HIT"]=nil end
            if (Healbot_Config_Skins.BarTextCol[SkinName][gl]["HCT"] or 99) == 40 then Healbot_Config_Skins.BarTextCol[SkinName][gl]["HCT"]=nil end
            if (Healbot_Config_Skins.BarTextCol[SkinName][gl]["HCDA"] or 99) == 0.5 then Healbot_Config_Skins.BarTextCol[SkinName][gl]["HCDA"]=nil end
            if (Healbot_Config_Skins.BarTextCol[SkinName][gl]["OCR"] or 99) == 0.1 then Healbot_Config_Skins.BarTextCol[SkinName][gl]["OCR"]=nil end
            if (Healbot_Config_Skins.BarTextCol[SkinName][gl]["OCG"] or 99) == 1 then Healbot_Config_Skins.BarTextCol[SkinName][gl]["OCG"]=nil end
            if (Healbot_Config_Skins.BarTextCol[SkinName][gl]["OCB"] or 99) == 0.1 then Healbot_Config_Skins.BarTextCol[SkinName][gl]["OCB"]=nil end
            if (Healbot_Config_Skins.BarTextCol[SkinName][gl]["ICR"] or 99) == 0.1 then Healbot_Config_Skins.BarTextCol[SkinName][gl]["ICR"]=nil end
            if (Healbot_Config_Skins.BarTextCol[SkinName][gl]["ICG"] or 99) == 1 then Healbot_Config_Skins.BarTextCol[SkinName][gl]["ICG"]=nil end
            if (Healbot_Config_Skins.BarTextCol[SkinName][gl]["ICB"] or 99) == 0.1 then Healbot_Config_Skins.BarTextCol[SkinName][gl]["ICB"]=nil end
            if (Healbot_Config_Skins.BarTextCol[SkinName][gl]["ACR"] or 99) == 1 then Healbot_Config_Skins.BarTextCol[SkinName][gl]["ACR"]=nil end
            if (Healbot_Config_Skins.BarTextCol[SkinName][gl]["ACG"] or 99) == 0.1 then Healbot_Config_Skins.BarTextCol[SkinName][gl]["ACG"]=nil end
            if (Healbot_Config_Skins.BarTextCol[SkinName][gl]["ACB"] or 99) == 0.1 then Healbot_Config_Skins.BarTextCol[SkinName][gl]["ACB"]=nil end
            if (Healbot_Config_Skins.BarTextCol[SkinName][gl]["ACA"] or 99) == 0.95 then Healbot_Config_Skins.BarTextCol[SkinName][gl]["ACA"]=nil end
            if (Healbot_Config_Skins.BarTextCol[SkinName][gl]["AICR"] or 99) == 1 then Healbot_Config_Skins.BarTextCol[SkinName][gl]["AICR"]=nil end
            if (Healbot_Config_Skins.BarTextCol[SkinName][gl]["AICG"] or 99) == 0.1 then Healbot_Config_Skins.BarTextCol[SkinName][gl]["AICG"]=nil end
            if (Healbot_Config_Skins.BarTextCol[SkinName][gl]["AICB"] or 99) == 0.1 then Healbot_Config_Skins.BarTextCol[SkinName][gl]["AICB"]=nil end
            if (Healbot_Config_Skins.BarTextCol[SkinName][gl]["ACCR"] or 99) == 1 then Healbot_Config_Skins.BarTextCol[SkinName][gl]["ACCR"]=nil end
            if (Healbot_Config_Skins.BarTextCol[SkinName][gl]["ACCG"] or 99) == 0.1 then Healbot_Config_Skins.BarTextCol[SkinName][gl]["ACCG"]=nil end
            if (Healbot_Config_Skins.BarTextCol[SkinName][gl]["ACCB"] or 99) == 0.1 then Healbot_Config_Skins.BarTextCol[SkinName][gl]["ACCB"]=nil end
            if (Healbot_Config_Skins.BarTextCol[SkinName][gl]["AIT"] or 99) == 70 then Healbot_Config_Skins.BarTextCol[SkinName][gl]["AIT"]=nil end
            if (Healbot_Config_Skins.BarTextCol[SkinName][gl]["ACT"] or 99) == 40 then Healbot_Config_Skins.BarTextCol[SkinName][gl]["ACT"]=nil end
            if (Healbot_Config_Skins.BarTextCol[SkinName][gl]["ACDA"] or 99) == 0.5 then Healbot_Config_Skins.BarTextCol[SkinName][gl]["ACDA"]=nil end
            if (Healbot_Config_Skins.BarTextCol[SkinName][gl]["HLTH"] or 99) == 2 then Healbot_Config_Skins.BarTextCol[SkinName][gl]["HLTH"]=nil end
            if (Healbot_Config_Skins.BarTextCol[SkinName][gl]["AGGRO"] or 99) == 2 then Healbot_Config_Skins.BarTextCol[SkinName][gl]["AGGRO"]=nil end
            if Healbot_Config_Skins.BarTextCol[SkinName][gl]["NDEBUFF"] == false then Healbot_Config_Skins.BarTextCol[SkinName][gl]["NDEBUFF"]=nil end
            if Healbot_Config_Skins.BarTextCol[SkinName][gl]["HDEBUFF"] == false then Healbot_Config_Skins.BarTextCol[SkinName][gl]["HDEBUFF"]=nil end
            if Healbot_Config_Skins.BarTextCol[SkinName][gl]["RIP"] then Healbot_Config_Skins.BarTextCol[SkinName][gl]["RIP"]=nil end
            if Healbot_Config_Skins.BarTextCol[SkinName][gl]["RES"] then Healbot_Config_Skins.BarTextCol[SkinName][gl]["RES"]=nil end
            if Healbot_Config_Skins.BarTextCol[SkinName][gl]["SUM"] == false then Healbot_Config_Skins.BarTextCol[SkinName][gl]["SUM"]=nil end
            if Healbot_Config_Skins.BarTextCol[SkinName][gl]["SRIP"] then Healbot_Config_Skins.BarTextCol[SkinName][gl]["SRIP"]=nil end
            if Healbot_Config_Skins.BarTextCol[SkinName][gl]["SRES"] then Healbot_Config_Skins.BarTextCol[SkinName][gl]["SRES"]=nil end
            if Healbot_Config_Skins.BarTextCol[SkinName][gl]["SSUM"] == false then Healbot_Config_Skins.BarTextCol[SkinName][gl]["SSUM"]=nil end
            Healbot_Config_Skins.BarTextCol[SkinName][gl]["EA"]=nil
            Healbot_Config_Skins.BarTextCol[SkinName][gl]["DA"]=nil
            Healbot_Config_Skins.BarTextCol[SkinName][gl]["CA"]=nil
            Healbot_Config_Skins.BarTextCol[SkinName][gl]["ER"]=nil
            Healbot_Config_Skins.BarTextCol[SkinName][gl]["EG"]=nil
            Healbot_Config_Skins.BarTextCol[SkinName][gl]["EB"]=nil
            Healbot_Config_Skins.BarTextCol[SkinName][gl]["DR"]=nil
            Healbot_Config_Skins.BarTextCol[SkinName][gl]["DG"]=nil
            Healbot_Config_Skins.BarTextCol[SkinName][gl]["DB"]=nil
            Healbot_Config_Skins.BarTextCol[SkinName][gl]["CR"]=nil
            Healbot_Config_Skins.BarTextCol[SkinName][gl]["CG"]=nil
            Healbot_Config_Skins.BarTextCol[SkinName][gl]["CB"]=nil
            HealBot_Util_EmptyTable(Healbot_Config_Skins.BarTextCol[SkinName], gl)
        end
        if Healbot_Config_Skins.BarText[SkinName][gl]["FONT"] == nil then Healbot_Config_Skins.BarText[SkinName][gl]["FONT"]=HealBot_Data_Default_FontName() end
        if Healbot_Config_Skins.BarText[SkinName][gl]["HFONT"] == nil then Healbot_Config_Skins.BarText[SkinName][gl]["HFONT"]=HealBot_Data_Default_FontName() end
        if Healbot_Config_Skins.BarText[SkinName][gl]["SFONT"] == nil then Healbot_Config_Skins.BarText[SkinName][gl]["SFONT"]=Healbot_Config_Skins.BarText[SkinName][gl]["FONT"] end
        if Healbot_Config_Skins.BarText[SkinName][gl]["AFONT"] == nil then Healbot_Config_Skins.BarText[SkinName][gl]["AFONT"]=Healbot_Config_Skins.BarText[SkinName][gl]["HFONT"] end
        if Healbot_Config_Skins.BarText[SkinName][gl]["HEIGHT"] == nil then Healbot_Config_Skins.BarText[SkinName][gl]["HEIGHT"]=10 end
        if Healbot_Config_Skins.BarText[SkinName][gl]["HHEIGHT"] == nil then Healbot_Config_Skins.BarText[SkinName][gl]["HHEIGHT"]=10 end
        if Healbot_Config_Skins.BarText[SkinName][gl]["SHEIGHT"] == nil then Healbot_Config_Skins.BarText[SkinName][gl]["SHEIGHT"]=Healbot_Config_Skins.BarText[SkinName][gl]["HEIGHT"] end
        if Healbot_Config_Skins.BarText[SkinName][gl]["AHEIGHT"] == nil then Healbot_Config_Skins.BarText[SkinName][gl]["AHEIGHT"]=Healbot_Config_Skins.BarText[SkinName][gl]["HHEIGHT"] end
        if Healbot_Config_Skins.BarText[SkinName][gl]["SHOWROLE"] == nil then Healbot_Config_Skins.BarText[SkinName][gl]["SHOWROLE"]=true end
        if Healbot_Config_Skins.BarText[SkinName][gl]["CLASSONBAR"] == nil then Healbot_Config_Skins.BarText[SkinName][gl]["CLASSONBAR"]=false end
        if Healbot_Config_Skins.BarText[SkinName][gl]["OFFSET"] == nil then Healbot_Config_Skins.BarText[SkinName][gl]["OFFSET"]=0 end
        if Healbot_Config_Skins.BarText[SkinName][gl]["OFFSET2"] == nil then Healbot_Config_Skins.BarText[SkinName][gl]["OFFSET2"]=0 end
        if Healbot_Config_Skins.BarText[SkinName][gl]["SOFFSET"] == nil then Healbot_Config_Skins.BarText[SkinName][gl]["SOFFSET"]=0 end
        if Healbot_Config_Skins.BarText[SkinName][gl]["AOFFSET"] == nil then Healbot_Config_Skins.BarText[SkinName][gl]["AOFFSET"]=0 end
        if Healbot_Config_Skins.BarText[SkinName][gl]["AOFFSET2"] == nil then Healbot_Config_Skins.BarText[SkinName][gl]["AOFFSET2"]=0 end
        if Healbot_Config_Skins.BarText[SkinName][gl]["HOFFSET"] == nil then Healbot_Config_Skins.BarText[SkinName][gl]["HOFFSET"]=0 end
        if Healbot_Config_Skins.BarText[SkinName][gl]["NAMEONBAR"] == nil then Healbot_Config_Skins.BarText[SkinName][gl]["NAMEONBAR"]=true end
        if Healbot_Config_Skins.BarText[SkinName][gl]["HLTHONBAR"] == nil then Healbot_Config_Skins.BarText[SkinName][gl]["HLTHONBAR"]=true end
        if Healbot_Config_Skins.BarText[SkinName][gl]["HLTHINVEHSHOWPLAYER"] == nil then Healbot_Config_Skins.BarText[SkinName][gl]["HLTHINVEHSHOWPLAYER"]=true end
        if Healbot_Config_Skins.BarText[SkinName][gl]["IGNOREONFULL"] == nil then Healbot_Config_Skins.BarText[SkinName][gl]["IGNOREONFULL"]=true end
        if Healbot_Config_Skins.BarText[SkinName][gl]["ALIGN"] == nil then Healbot_Config_Skins.BarText[SkinName][gl]["ALIGN"]=2 end
        if Healbot_Config_Skins.BarText[SkinName][gl]["HOFFSET2"] == nil then Healbot_Config_Skins.BarText[SkinName][gl]["HOFFSET2"]=0 end
        if Healbot_Config_Skins.BarText[SkinName][gl]["SOFFSET2"] == nil then Healbot_Config_Skins.BarText[SkinName][gl]["SOFFSET2"]=0 end
        if Healbot_Config_Skins.BarText[SkinName][gl]["INCHEALS"] == nil then Healbot_Config_Skins.BarText[SkinName][gl]["INCHEALS"]=2 end
        if Healbot_Config_Skins.BarText[SkinName][gl]["INCABSORBS"] == nil then Healbot_Config_Skins.BarText[SkinName][gl]["INCABSORBS"]=1 end
        if Healbot_Config_Skins.BarText[SkinName][gl]["OVERHEAL"] == nil then Healbot_Config_Skins.BarText[SkinName][gl]["OVERHEAL"]=1 end
        if Healbot_Config_Skins.BarText[SkinName][gl]["OVERHEALFORMAT"] == nil then Healbot_Config_Skins.BarText[SkinName][gl]["OVERHEALFORMAT"]=2 end
        if Healbot_Config_Skins.BarText[SkinName][gl]["OVERHEALCOL"] == nil then Healbot_Config_Skins.BarText[SkinName][gl]["OVERHEALCOL"]=1 end
        if Healbot_Config_Skins.BarText[SkinName][gl]["SEPARATEFORMAT"] == nil then Healbot_Config_Skins.BarText[SkinName][gl]["SEPARATEFORMAT"]=3 end
        if Healbot_Config_Skins.BarText[SkinName][gl]["SEPARATECOL"] == nil then Healbot_Config_Skins.BarText[SkinName][gl]["SEPARATECOL"]=1 end
        if Healbot_Config_Skins.BarText[SkinName][gl]["HEALEXTRACOL"] == nil then Healbot_Config_Skins.BarText[SkinName][gl]["HEALEXTRACOL"]=1 end
        if Healbot_Config_Skins.BarText[SkinName][gl]["HLTHTXTANCHOR"] == nil then Healbot_Config_Skins.BarText[SkinName][gl]["HLTHTXTANCHOR"]=2 end
        if Healbot_Config_Skins.BarText[SkinName][gl]["STATETXTANCHOR"] == nil then Healbot_Config_Skins.BarText[SkinName][gl]["STATETXTANCHOR"]=1 end
        if Healbot_Config_Skins.BarText[SkinName][gl]["AGGROTXTANCHOR"] == nil then Healbot_Config_Skins.BarText[SkinName][gl]["AGGROTXTANCHOR"]=3 end
        if Healbot_Config_Skins.BarText[SkinName][gl]["NUMFORMAT1"] == nil then Healbot_Config_Skins.BarText[SkinName][gl]["NUMFORMAT1"]=11 end
        if Healbot_Config_Skins.BarText[SkinName][gl]["NUMFORMAT2"] == nil then Healbot_Config_Skins.BarText[SkinName][gl]["NUMFORMAT2"]=1 end
        if Healbot_Config_Skins.BarText[SkinName][gl]["OUTLINE"] == nil then Healbot_Config_Skins.BarText[SkinName][gl]["OUTLINE"]=1 end
        if Healbot_Config_Skins.BarText[SkinName][gl]["HOUTLINE"] == nil then Healbot_Config_Skins.BarText[SkinName][gl]["HOUTLINE"]=1 end
        if Healbot_Config_Skins.BarText[SkinName][gl]["SOUTLINE"] == nil then Healbot_Config_Skins.BarText[SkinName][gl]["SOUTLINE"]=Healbot_Config_Skins.BarText[SkinName][gl]["OUTLINE"] end
        if Healbot_Config_Skins.BarText[SkinName][gl]["AOUTLINE"] == nil then Healbot_Config_Skins.BarText[SkinName][gl]["AOUTLINE"]=Healbot_Config_Skins.BarText[SkinName][gl]["HOUTLINE"] end
        if Healbot_Config_Skins.BarText[SkinName][gl]["HLTHTYPE"] == nil then Healbot_Config_Skins.BarText[SkinName][gl]["HLTHTYPE"]=1 end
        if Healbot_Config_Skins.BarText[SkinName][gl]["MAXCHARS"] == nil then Healbot_Config_Skins.BarText[SkinName][gl]["MAXCHARS"]=0 end
        if Healbot_Config_Skins.BarText[SkinName][gl]["HMAXCHARS"] == nil then Healbot_Config_Skins.BarText[SkinName][gl]["HMAXCHARS"]=0 end
        if Healbot_Config_Skins.BarText[SkinName][gl]["TAGDC"] == nil then Healbot_Config_Skins.BarText[SkinName][gl]["TAGDC"]=HEALBOT_DISCONNECTED_TAG end
        if Healbot_Config_Skins.BarText[SkinName][gl]["TAGRIP"] == nil then Healbot_Config_Skins.BarText[SkinName][gl]["TAGRIP"]=HEALBOT_DEAD_TAG end
        if Healbot_Config_Skins.BarText[SkinName][gl]["TAGOOR"] == nil then Healbot_Config_Skins.BarText[SkinName][gl]["TAGOOR"]=HEALBOT_OUTOFRANGE_TAG end
        if Healbot_Config_Skins.BarText[SkinName][gl]["TAGR"] == nil then Healbot_Config_Skins.BarText[SkinName][gl]["TAGR"]=HEALBOT_RESERVED_TAG end
        if Healbot_Config_Skins.BarText[SkinName][gl]["TAGDEBUFF"] == nil then Healbot_Config_Skins.BarText[SkinName][gl]["TAGDEBUFF"]=HEALBOT_WORD_DISPEL.." #n" end
        if Healbot_Config_Skins.BarText[SkinName][gl]["TAGBUFF"] == nil then Healbot_Config_Skins.BarText[SkinName][gl]["TAGBUFF"]=HEALBOT_WORD_MISSING.." #n" end
        if Healbot_Config_Skins.BarText[SkinName][gl]["TAGGROUP"] == nil then Healbot_Config_Skins.BarText[SkinName][gl]["TAGGROUP"]=HEALBOT_SORTBY_GROUP.." #g" end
        if Healbot_Config_Skins.BarText[SkinName][gl]["TAGRES"] == nil then
            if string.len(Healbot_Config_Skins.BarText[SkinName][gl]["TAGRIP"])>0 then
                Healbot_Config_Skins.BarText[SkinName][gl]["TAGRES"]=HEALBOT_RES_TAG
            else
                Healbot_Config_Skins.BarText[SkinName][gl]["TAGRES"]=""
            end
        end
        if Healbot_Config_Skins.BarText[SkinName][gl]["TAGSUM"] == nil then Healbot_Config_Skins.BarText[SkinName][gl]["TAGSUM"]=HEALBOT_SUMMONS_TAG end
        if Healbot_Config_Skins.BarIACol[SkinName][gl]["IC"] == nil then Healbot_Config_Skins.BarIACol[SkinName][gl]["IC"]=3 end
        if Healbot_Config_Skins.BarIACol[SkinName][gl]["IC"]>8 then Healbot_Config_Skins.BarIACol[SkinName][gl]["IC"]=8 end
        if Healbot_Config_Skins.BarIACol[SkinName][gl]["IR"] == nil then Healbot_Config_Skins.BarIACol[SkinName][gl]["IR"]=0.2 end
        if Healbot_Config_Skins.BarIACol[SkinName][gl]["IG"] == nil then Healbot_Config_Skins.BarIACol[SkinName][gl]["IG"]=1 end
        if Healbot_Config_Skins.BarIACol[SkinName][gl]["IB"] == nil then Healbot_Config_Skins.BarIACol[SkinName][gl]["IB"]=0.2 end
        if Healbot_Config_Skins.BarIACol[SkinName][gl]["IIR"] == nil then Healbot_Config_Skins.BarIACol[SkinName][gl]["IIR"]=Healbot_Config_Skins.BarIACol[SkinName][gl]["IR"] end
        if Healbot_Config_Skins.BarIACol[SkinName][gl]["IIG"] == nil then Healbot_Config_Skins.BarIACol[SkinName][gl]["IIG"]=Healbot_Config_Skins.BarIACol[SkinName][gl]["IG"] end
        if Healbot_Config_Skins.BarIACol[SkinName][gl]["IIB"] == nil then Healbot_Config_Skins.BarIACol[SkinName][gl]["IIB"]=Healbot_Config_Skins.BarIACol[SkinName][gl]["IB"] end
        if Healbot_Config_Skins.BarIACol[SkinName][gl]["ICR"] == nil then Healbot_Config_Skins.BarIACol[SkinName][gl]["ICR"]=Healbot_Config_Skins.BarIACol[SkinName][gl]["IIR"] end
        if Healbot_Config_Skins.BarIACol[SkinName][gl]["ICG"] == nil then Healbot_Config_Skins.BarIACol[SkinName][gl]["ICG"]=Healbot_Config_Skins.BarIACol[SkinName][gl]["IIG"] end
        if Healbot_Config_Skins.BarIACol[SkinName][gl]["ICB"] == nil then Healbot_Config_Skins.BarIACol[SkinName][gl]["ICB"]=Healbot_Config_Skins.BarIACol[SkinName][gl]["IIB"] end
        if Healbot_Config_Skins.BarIACol[SkinName][gl]["IIT"] == nil then Healbot_Config_Skins.BarIACol[SkinName][gl]["IIT"]=0.7 end
        if Healbot_Config_Skins.BarIACol[SkinName][gl]["ICT"] == nil then Healbot_Config_Skins.BarIACol[SkinName][gl]["ICT"]=0.4 end
        if Healbot_Config_Skins.BarIACol[SkinName][gl]["IA"] == nil then Healbot_Config_Skins.BarIACol[SkinName][gl]["IA"]=0.82 end
        if Healbot_Config_Skins.BarIACol[SkinName][gl]["AC"] == nil then Healbot_Config_Skins.BarIACol[SkinName][gl]["AC"]=3 end
        if Healbot_Config_Skins.BarIACol[SkinName][gl]["AC"]>8 then Healbot_Config_Skins.BarIACol[SkinName][gl]["AC"]=8 end
        if Healbot_Config_Skins.BarIACol[SkinName][gl]["AR"] == nil then Healbot_Config_Skins.BarIACol[SkinName][gl]["AR"]=1 end
        if Healbot_Config_Skins.BarIACol[SkinName][gl]["AG"] == nil then Healbot_Config_Skins.BarIACol[SkinName][gl]["AG"]=1 end
        if Healbot_Config_Skins.BarIACol[SkinName][gl]["AB"] == nil then Healbot_Config_Skins.BarIACol[SkinName][gl]["AB"]=1 end
        if Healbot_Config_Skins.BarIACol[SkinName][gl]["AIR"] == nil then Healbot_Config_Skins.BarIACol[SkinName][gl]["AIR"]=Healbot_Config_Skins.BarIACol[SkinName][gl]["AR"] end
        if Healbot_Config_Skins.BarIACol[SkinName][gl]["AIG"] == nil then Healbot_Config_Skins.BarIACol[SkinName][gl]["AIG"]=Healbot_Config_Skins.BarIACol[SkinName][gl]["AG"] end
        if Healbot_Config_Skins.BarIACol[SkinName][gl]["AIB"] == nil then Healbot_Config_Skins.BarIACol[SkinName][gl]["AIB"]=Healbot_Config_Skins.BarIACol[SkinName][gl]["AB"] end
        if Healbot_Config_Skins.BarIACol[SkinName][gl]["ACR"] == nil then Healbot_Config_Skins.BarIACol[SkinName][gl]["ACR"]=Healbot_Config_Skins.BarIACol[SkinName][gl]["AIR"] end
        if Healbot_Config_Skins.BarIACol[SkinName][gl]["ACG"] == nil then Healbot_Config_Skins.BarIACol[SkinName][gl]["ACG"]=Healbot_Config_Skins.BarIACol[SkinName][gl]["AIG"] end
        if Healbot_Config_Skins.BarIACol[SkinName][gl]["ACB"] == nil then Healbot_Config_Skins.BarIACol[SkinName][gl]["ACB"]=Healbot_Config_Skins.BarIACol[SkinName][gl]["AIB"] end
        if Healbot_Config_Skins.BarIACol[SkinName][gl]["AIT"] == nil then Healbot_Config_Skins.BarIACol[SkinName][gl]["AIT"]=0.7 end
        if Healbot_Config_Skins.BarIACol[SkinName][gl]["ACT"] == nil then Healbot_Config_Skins.BarIACol[SkinName][gl]["ACT"]=0.4 end
        if Healbot_Config_Skins.BarIACol[SkinName][gl]["AA"] == nil then Healbot_Config_Skins.BarIACol[SkinName][gl]["AA"]=0.78 end
        if Healbot_Config_Skins.BarCol[SkinName][gl] then
            if (Healbot_Config_Skins.BarCol[SkinName][gl]["HLTH"] or 99) == 5 then Healbot_Config_Skins.BarCol[SkinName][gl]["HLTH"]=nil end
            if (Healbot_Config_Skins.BarCol[SkinName][gl]["BACK"] or 99) == 1 then Healbot_Config_Skins.BarCol[SkinName][gl]["BACK"]=nil end
            if (Healbot_Config_Skins.BarCol[SkinName][gl]["BORDER"] or 99) == 1 then Healbot_Config_Skins.BarCol[SkinName][gl]["BORDER"]=nil end
            if (Healbot_Config_Skins.BarCol[SkinName][gl]["HR"] or 99) == 0.4 then Healbot_Config_Skins.BarCol[SkinName][gl]["HR"]=nil end
            if (Healbot_Config_Skins.BarCol[SkinName][gl]["HG"] or 99) == 0.7 then Healbot_Config_Skins.BarCol[SkinName][gl]["HG"]=nil end
            if (Healbot_Config_Skins.BarCol[SkinName][gl]["HB"] or 99) == 0.7 then Healbot_Config_Skins.BarCol[SkinName][gl]["HB"]=nil end
            if (Healbot_Config_Skins.BarCol[SkinName][gl]["HA"] or 99) == 1 then Healbot_Config_Skins.BarCol[SkinName][gl]["HA"]=nil end
            if (Healbot_Config_Skins.BarCol[SkinName][gl]["HIR"] or 99) == 0.4 then Healbot_Config_Skins.BarCol[SkinName][gl]["HIR"]=nil end
            if (Healbot_Config_Skins.BarCol[SkinName][gl]["HIG"] or 99) == 0.7 then Healbot_Config_Skins.BarCol[SkinName][gl]["HIG"]=nil end
            if (Healbot_Config_Skins.BarCol[SkinName][gl]["HIB"] or 99) == 0.7 then Healbot_Config_Skins.BarCol[SkinName][gl]["HIB"]=nil end
            if (Healbot_Config_Skins.BarCol[SkinName][gl]["HCR"] or 99) == 0.4 then Healbot_Config_Skins.BarCol[SkinName][gl]["HCR"]=nil end
            if (Healbot_Config_Skins.BarCol[SkinName][gl]["HCG"] or 99) == 0.7 then Healbot_Config_Skins.BarCol[SkinName][gl]["HCG"]=nil end
            if (Healbot_Config_Skins.BarCol[SkinName][gl]["HCB"] or 99) == 0.7 then Healbot_Config_Skins.BarCol[SkinName][gl]["HCB"]=nil end
            if (Healbot_Config_Skins.BarCol[SkinName][gl]["HCT"] or 99) == 0.4 then Healbot_Config_Skins.BarCol[SkinName][gl]["HCT"]=nil end
            if (Healbot_Config_Skins.BarCol[SkinName][gl]["HIT"] or 99) == 0.7 then Healbot_Config_Skins.BarCol[SkinName][gl]["HIT"]=nil end
            if (Healbot_Config_Skins.BarCol[SkinName][gl]["ORA"] or 99) == 0.4 then Healbot_Config_Skins.BarCol[SkinName][gl]["ORA"]=nil end
            if (Healbot_Config_Skins.BarCol[SkinName][gl]["DISA"] or 99) == 0.1 then Healbot_Config_Skins.BarCol[SkinName][gl]["DISA"]=nil end
            if (Healbot_Config_Skins.BarCol[SkinName][gl]["BR"] or 99) == 0.4 then Healbot_Config_Skins.BarCol[SkinName][gl]["BR"]=nil end
            if (Healbot_Config_Skins.BarCol[SkinName][gl]["BG"] or 99) == 0.7 then Healbot_Config_Skins.BarCol[SkinName][gl]["BG"]=nil end
            if (Healbot_Config_Skins.BarCol[SkinName][gl]["BB"] or 99) == 0.7 then Healbot_Config_Skins.BarCol[SkinName][gl]["BB"]=nil end
            if (Healbot_Config_Skins.BarCol[SkinName][gl]["BA"] or 99) == 0 then Healbot_Config_Skins.BarCol[SkinName][gl]["BA"]=nil end
            if (Healbot_Config_Skins.BarCol[SkinName][gl]["BIR"] or 99) == 0.4 then Healbot_Config_Skins.BarCol[SkinName][gl]["BIR"]=nil end
            if (Healbot_Config_Skins.BarCol[SkinName][gl]["BIG"] or 99) == 0.7 then Healbot_Config_Skins.BarCol[SkinName][gl]["BIG"]=nil end
            if (Healbot_Config_Skins.BarCol[SkinName][gl]["BIB"] or 99) == 0.7 then Healbot_Config_Skins.BarCol[SkinName][gl]["BIB"]=nil end
            if (Healbot_Config_Skins.BarCol[SkinName][gl]["BCR"] or 99) == 0.4 then Healbot_Config_Skins.BarCol[SkinName][gl]["BCR"]=nil end
            if (Healbot_Config_Skins.BarCol[SkinName][gl]["BCG"] or 99) == 0.7 then Healbot_Config_Skins.BarCol[SkinName][gl]["BCG"]=nil end
            if (Healbot_Config_Skins.BarCol[SkinName][gl]["BCB"] or 99) == 0.7 then Healbot_Config_Skins.BarCol[SkinName][gl]["BCB"]=nil end
            if (Healbot_Config_Skins.BarCol[SkinName][gl]["BCT"] or 99) == 0.4 then Healbot_Config_Skins.BarCol[SkinName][gl]["BCT"]=nil end
            if (Healbot_Config_Skins.BarCol[SkinName][gl]["BIT"] or 99) == 0.7 then Healbot_Config_Skins.BarCol[SkinName][gl]["BIT"]=nil end
            if (Healbot_Config_Skins.BarCol[SkinName][gl]["BOUT"] or 99) == 1 then Healbot_Config_Skins.BarCol[SkinName][gl]["BOUT"]=nil end
            if (Healbot_Config_Skins.BarCol[SkinName][gl]["BORR"] or 99) == 0.1 then Healbot_Config_Skins.BarCol[SkinName][gl]["BORR"]=nil end
            if (Healbot_Config_Skins.BarCol[SkinName][gl]["BORG"] or 99) == 0.1 then Healbot_Config_Skins.BarCol[SkinName][gl]["BORG"]=nil end
            if (Healbot_Config_Skins.BarCol[SkinName][gl]["BORB"] or 99) == 0.3 then Healbot_Config_Skins.BarCol[SkinName][gl]["BORB"]=nil end
            if (Healbot_Config_Skins.BarCol[SkinName][gl]["BORA"] or 99) == 1 then Healbot_Config_Skins.BarCol[SkinName][gl]["BORA"]=nil end
            if (Healbot_Config_Skins.BarCol[SkinName][gl]["BORIR"] or 99) == 0.1 then Healbot_Config_Skins.BarCol[SkinName][gl]["BORIR"]=nil end
            if (Healbot_Config_Skins.BarCol[SkinName][gl]["BORIG"] or 99) == 0.1 then Healbot_Config_Skins.BarCol[SkinName][gl]["BORIG"]=nil end
            if (Healbot_Config_Skins.BarCol[SkinName][gl]["BORIB"] or 99) == 0.3 then Healbot_Config_Skins.BarCol[SkinName][gl]["BORIB"]=nil end
            if (Healbot_Config_Skins.BarCol[SkinName][gl]["BORCR"] or 99) == 0.1 then Healbot_Config_Skins.BarCol[SkinName][gl]["BORCR"]=nil end
            if (Healbot_Config_Skins.BarCol[SkinName][gl]["BORCG"] or 99) == 0.1 then Healbot_Config_Skins.BarCol[SkinName][gl]["BORCG"]=nil end
            if (Healbot_Config_Skins.BarCol[SkinName][gl]["BORCB"] or 99) == 0.3 then Healbot_Config_Skins.BarCol[SkinName][gl]["BORCB"]=nil end
            if (Healbot_Config_Skins.BarCol[SkinName][gl]["BORCT"] or 99) == 0.4 then Healbot_Config_Skins.BarCol[SkinName][gl]["BORCT"]=nil end
            if (Healbot_Config_Skins.BarCol[SkinName][gl]["BORIT"] or 99) == 0.7 then Healbot_Config_Skins.BarCol[SkinName][gl]["BORIT"]=nil end
            if (Healbot_Config_Skins.BarCol[SkinName][gl]["BORSIZE"] or 99) == 2 then Healbot_Config_Skins.BarCol[SkinName][gl]["BORSIZE"]=nil end
            HealBot_Util_EmptyTable(Healbot_Config_Skins.BarCol[SkinName], gl)
        end
        if Healbot_Config_Skins.HeadText[SkinName][gl]["OUTLINE"] == nil then Healbot_Config_Skins.HeadText[SkinName][gl]["OUTLINE"]=1 end
        if Healbot_Config_Skins.HeadText[SkinName][gl]["FONT"] == nil then Healbot_Config_Skins.HeadText[SkinName][gl]["FONT"]=HealBot_Data_Default_FontName() end
        if Healbot_Config_Skins.HeadText[SkinName][gl]["HEIGHT"] == nil then Healbot_Config_Skins.HeadText[SkinName][gl]["HEIGHT"]=9 end
        if Healbot_Config_Skins.HeadText[SkinName][gl]["OFFSET"] == nil then Healbot_Config_Skins.HeadText[SkinName][gl]["OFFSET"]=0 end
        if Healbot_Config_Skins.HeadText[SkinName][gl]["R"] == nil then Healbot_Config_Skins.HeadText[SkinName][gl]["R"]=1 end
        if Healbot_Config_Skins.HeadText[SkinName][gl]["G"] == nil then Healbot_Config_Skins.HeadText[SkinName][gl]["G"]=1 end
        if Healbot_Config_Skins.HeadText[SkinName][gl]["B"] == nil then Healbot_Config_Skins.HeadText[SkinName][gl]["B"]=0.1 end
        if Healbot_Config_Skins.HeadText[SkinName][gl]["A"] == nil then Healbot_Config_Skins.HeadText[SkinName][gl]["A"]=0.7 end
        if Healbot_Config_Skins.HeadBar[SkinName][gl] then
            if Healbot_Config_Skins.HeadBar[SkinName][gl]["SHOW"] == false then Healbot_Config_Skins.HeadBar[SkinName][gl]["SHOW"]=nil end
            if (Healbot_Config_Skins.HeadBar[SkinName][gl]["TEXTURE"] or "x") == HealBot_Supplied_Textures[10].name then Healbot_Config_Skins.HeadBar[SkinName][gl]["TEXTURE"]=nil end
            if (Healbot_Config_Skins.HeadBar[SkinName][gl]["WIDTH"] or 99) == 0.7 then Healbot_Config_Skins.HeadBar[SkinName][gl]["WIDTH"]=nil end
            if (Healbot_Config_Skins.HeadBar[SkinName][gl]["HEIGHT"] or 99) == 20 then Healbot_Config_Skins.HeadBar[SkinName][gl]["HEIGHT"]=nil end
            if (Healbot_Config_Skins.HeadBar[SkinName][gl]["R"] or 99) == 0.1 then Healbot_Config_Skins.HeadBar[SkinName][gl]["R"]=nil end
            if (Healbot_Config_Skins.HeadBar[SkinName][gl]["G"] or 99) == 0.7 then Healbot_Config_Skins.HeadBar[SkinName][gl]["G"]=nil end
            if (Healbot_Config_Skins.HeadBar[SkinName][gl]["B"] or 99) == 0.1 then Healbot_Config_Skins.HeadBar[SkinName][gl]["B"]=nil end
            if (Healbot_Config_Skins.HeadBar[SkinName][gl]["A"] or 99) == 0.4 then Healbot_Config_Skins.HeadBar[SkinName][gl]["A"]=nil end
            HealBot_Util_EmptyTable(Healbot_Config_Skins.HeadBar[SkinName], gl)
        end
        if Healbot_Config_Skins.HealBar[SkinName][gl]["CMARGIN"] == nil then Healbot_Config_Skins.HealBar[SkinName][gl]["CMARGIN"]=2 end
        if Healbot_Config_Skins.HealBar[SkinName][gl]["GRPCOLS"] == nil then Healbot_Config_Skins.HealBar[SkinName][gl]["GRPCOLS"]=true end
        if Healbot_Config_Skins.HealBar[SkinName][gl]["POWERCNT"] == nil then Healbot_Config_Skins.HealBar[SkinName][gl]["POWERCNT"]=true end
        if Healbot_Config_Skins.HealBar[SkinName][gl]["TEXTURE"] == nil then Healbot_Config_Skins.HealBar[SkinName][gl]["TEXTURE"]=HealBot_Data_Default_TextureName() end
        if Healbot_Config_Skins.HealBar[SkinName][gl]["TEXTURE"] == "Empty" then Healbot_Config_Skins.HealBar[SkinName][gl]["TEXTURE"]="Smooth" end
        if Healbot_Config_Skins.HealBar[SkinName][gl]["HEIGHT"] == nil then Healbot_Config_Skins.HealBar[SkinName][gl]["HEIGHT"]=30 end
        if Healbot_Config_Skins.HealBar[SkinName][gl]["WIDTH"] == nil then Healbot_Config_Skins.HealBar[SkinName][gl]["WIDTH"]=80 end
        if Healbot_Config_Skins.HealBar[SkinName][gl]["NUMCOLS"] == nil then Healbot_Config_Skins.HealBar[SkinName][gl]["NUMCOLS"]=1 end
        if Healbot_Config_Skins.HealBar[SkinName][gl]["RMARGIN"] == nil then Healbot_Config_Skins.HealBar[SkinName][gl]["RMARGIN"]=1 end
        if Healbot_Config_Skins.HealBar[SkinName][gl]["OFIX"] == nil then Healbot_Config_Skins.HealBar[SkinName][gl]["OFIX"]=1 end
        
        if Healbot_Config_Skins.Indicators[SkinName][gl] then
            if (Healbot_Config_Skins.Indicators[SkinName][gl]["ACOL"] or 99) == 1 then Healbot_Config_Skins.Indicators[SkinName][gl]["ACOL"]=nil end
            if (Healbot_Config_Skins.Indicators[SkinName][gl]["AANCHOR"] or 99) == 1 then Healbot_Config_Skins.Indicators[SkinName][gl]["AANCHOR"]=nil end
            if (Healbot_Config_Skins.Indicators[SkinName][gl]["AVOFF"] or 99) == -2 then Healbot_Config_Skins.Indicators[SkinName][gl]["AVOFF"]=nil end
            if (Healbot_Config_Skins.Indicators[SkinName][gl]["AHOFF"] or 99) == 1 then Healbot_Config_Skins.Indicators[SkinName][gl]["AHOFF"]=nil end
            if (Healbot_Config_Skins.Indicators[SkinName][gl]["ASIZE"] or 99) == 3 then Healbot_Config_Skins.Indicators[SkinName][gl]["ASIZE"]=nil end
            if (Healbot_Config_Skins.Indicators[SkinName][gl]["ASPACE"] or 99) == 0 then Healbot_Config_Skins.Indicators[SkinName][gl]["ASPACE"]=nil end
            if (Healbot_Config_Skins.Indicators[SkinName][gl]["MCOL"] or 99) == 1 then Healbot_Config_Skins.Indicators[SkinName][gl]["MCOL"]=nil end
            if (Healbot_Config_Skins.Indicators[SkinName][gl]["MANCHOR"] or 99) == 1 then Healbot_Config_Skins.Indicators[SkinName][gl]["MANCHOR"]=nil end
            if (Healbot_Config_Skins.Indicators[SkinName][gl]["MVOFF"] or 99) == -2 then Healbot_Config_Skins.Indicators[SkinName][gl]["MVOFF"]=nil end
            if (Healbot_Config_Skins.Indicators[SkinName][gl]["MHOFF"] or 99) == 0 then Healbot_Config_Skins.Indicators[SkinName][gl]["MHOFF"]=nil end
            if (Healbot_Config_Skins.Indicators[SkinName][gl]["MSIZE"] or 99) == 3 then Healbot_Config_Skins.Indicators[SkinName][gl]["MSIZE"]=nil end
            if (Healbot_Config_Skins.Indicators[SkinName][gl]["MSPACE"] or 99) == 1 then Healbot_Config_Skins.Indicators[SkinName][gl]["MSPACE"]=nil end
            if (Healbot_Config_Skins.Indicators[SkinName][gl]["SCOL"] or 99) == 1 then Healbot_Config_Skins.Indicators[SkinName][gl]["SCOL"]=nil end
            if (Healbot_Config_Skins.Indicators[SkinName][gl]["SANCHOR"] or 99) == 1 then Healbot_Config_Skins.Indicators[SkinName][gl]["SANCHOR"]=nil end
            if (Healbot_Config_Skins.Indicators[SkinName][gl]["SVOFF"] or 99) == 1 then Healbot_Config_Skins.Indicators[SkinName][gl]["SVOFF"]=nil end
            if (Healbot_Config_Skins.Indicators[SkinName][gl]["SHOFF"] or 99) == 1 then Healbot_Config_Skins.Indicators[SkinName][gl]["SHOFF"]=nil end
            if (Healbot_Config_Skins.Indicators[SkinName][gl]["SSIZE"] or 99) == 4 then Healbot_Config_Skins.Indicators[SkinName][gl]["SSIZE"]=nil end
            if (Healbot_Config_Skins.Indicators[SkinName][gl]["PCOL"] or 99) == 1 then Healbot_Config_Skins.Indicators[SkinName][gl]["PCOL"]=nil end
            if (Healbot_Config_Skins.Indicators[SkinName][gl]["PANCHOR"] or 99) == 2 then Healbot_Config_Skins.Indicators[SkinName][gl]["PANCHOR"]=nil end
            if (Healbot_Config_Skins.Indicators[SkinName][gl]["PVOFF"] or 99) == 0 then Healbot_Config_Skins.Indicators[SkinName][gl]["PVOFF"]=nil end
            if (Healbot_Config_Skins.Indicators[SkinName][gl]["PHOFF"] or 99) == 0 then Healbot_Config_Skins.Indicators[SkinName][gl]["PHOFF"]=nil end
            if (Healbot_Config_Skins.Indicators[SkinName][gl]["PSIZE"] or 99) == 4 then Healbot_Config_Skins.Indicators[SkinName][gl]["PSIZE"]=nil end
            if (Healbot_Config_Skins.Indicators[SkinName][gl]["PSPACE"] or 99) == 1 then Healbot_Config_Skins.Indicators[SkinName][gl]["PSPACE"]=nil end
            HealBot_Util_EmptyTable(Healbot_Config_Skins.Indicators[SkinName], gl)
        end
        if Healbot_Config_Skins.Emerg[SkinName][gl]["USE"] == nil then Healbot_Config_Skins.Emerg[SkinName][gl]["USE"]=false end
        if not Healbot_Config_Skins.Emerg[SkinName][gl]["TEXTURE"] then Healbot_Config_Skins.Emerg[SkinName][gl]["TEXTURE"]=HealBot_Data_Default_TextureName() end
        if not Healbot_Config_Skins.Emerg[SkinName][gl]["ANCHOR"] then Healbot_Config_Skins.Emerg[SkinName][gl]["ANCHOR"]=3 end
        if not Healbot_Config_Skins.Emerg[SkinName][gl]["VOFFSET"] then Healbot_Config_Skins.Emerg[SkinName][gl]["VOFFSET"]=0 end
        if not Healbot_Config_Skins.Emerg[SkinName][gl]["HOFFSET"] then Healbot_Config_Skins.Emerg[SkinName][gl]["HOFFSET"]=0 end
        if not Healbot_Config_Skins.Emerg[SkinName][gl]["A"] then Healbot_Config_Skins.Emerg[SkinName][gl]["A"]=1 end
        if not Healbot_Config_Skins.Emerg[SkinName][gl]["OA"] then Healbot_Config_Skins.Emerg[SkinName][gl]["OA"]=0.5 end
        if not Healbot_Config_Skins.Emerg[SkinName][gl]["DA"] then Healbot_Config_Skins.Emerg[SkinName][gl]["DA"]=0.2 end
        if not Healbot_Config_Skins.Emerg[SkinName][gl]["CRITICAL"] then
            Healbot_Config_Skins.Emerg[SkinName][gl]["CRITICAL"]=0.25
        elseif Healbot_Config_Skins.Emerg[SkinName][gl]["CRITICAL"]>0.99 then
            Healbot_Config_Skins.Emerg[SkinName][gl]["CRITICAL"]=Healbot_Config_Skins.Emerg[SkinName][gl]["CRITICAL"]/100
        end
        if not Healbot_Config_Skins.Emerg[SkinName][gl]["INJURED"] then
            Healbot_Config_Skins.Emerg[SkinName][gl]["INJURED"]=0.5
        elseif Healbot_Config_Skins.Emerg[SkinName][gl]["INJURED"]>0.99 then
            Healbot_Config_Skins.Emerg[SkinName][gl]["INJURED"]=Healbot_Config_Skins.Emerg[SkinName][gl]["INJURED"]/100
        end
        if Healbot_Config_Skins.Emerg[SkinName][gl]["BUFFBARCOL"] == nil then
            Healbot_Config_Skins.Emerg[SkinName][gl]["BUFFBARCOL"]=false
        elseif type(Healbot_Config_Skins.Emerg[SkinName][gl]["BUFFBARCOL"]) == "number" then
            if Healbot_Config_Skins.Emerg[SkinName][gl]["BUFFBARCOL"]>1 then
                Healbot_Config_Skins.Emerg[SkinName][gl]["BUFFBARCOL"]=true
            else
                Healbot_Config_Skins.Emerg[SkinName][gl]["BUFFBARCOL"]=false
            end
        end
        if Healbot_Config_Skins.Emerg[SkinName][gl]["DEBUFFBARCOL"] == nil then
            Healbot_Config_Skins.Emerg[SkinName][gl]["DEBUFFBARCOL"]=false
        elseif type(Healbot_Config_Skins.Emerg[SkinName][gl]["DEBUFFBARCOL"]) == "number" then
            if Healbot_Config_Skins.Emerg[SkinName][gl]["DEBUFFBARCOL"]>1 then
                Healbot_Config_Skins.Emerg[SkinName][gl]["DEBUFFBARCOL"]=true
            else
                Healbot_Config_Skins.Emerg[SkinName][gl]["DEBUFFBARCOL"]=false
            end
        end
        if not Healbot_Config_Skins.Emerg[SkinName][gl]["CR"] then Healbot_Config_Skins.Emerg[SkinName][gl]["CR"]=1 end
        if not Healbot_Config_Skins.Emerg[SkinName][gl]["CG"] then Healbot_Config_Skins.Emerg[SkinName][gl]["CG"]=0.1 end
        if not Healbot_Config_Skins.Emerg[SkinName][gl]["CB"] then Healbot_Config_Skins.Emerg[SkinName][gl]["CB"]=0.1 end
        if not Healbot_Config_Skins.Emerg[SkinName][gl]["IR"] then Healbot_Config_Skins.Emerg[SkinName][gl]["IR"]=0.9 end
        if not Healbot_Config_Skins.Emerg[SkinName][gl]["IG"] then Healbot_Config_Skins.Emerg[SkinName][gl]["IG"]=0.9 end
        if not Healbot_Config_Skins.Emerg[SkinName][gl]["IB"] then Healbot_Config_Skins.Emerg[SkinName][gl]["IB"]=0.1 end
        if not Healbot_Config_Skins.Emerg[SkinName][gl]["HR"] then Healbot_Config_Skins.Emerg[SkinName][gl]["HR"]=0 end
        if not Healbot_Config_Skins.Emerg[SkinName][gl]["HG"] then Healbot_Config_Skins.Emerg[SkinName][gl]["HG"]=0.9 end
        if not Healbot_Config_Skins.Emerg[SkinName][gl]["HB"] then Healbot_Config_Skins.Emerg[SkinName][gl]["HB"]=0 end
        if not Healbot_Config_Skins.Emerg[SkinName][gl]["BARCOL"] then Healbot_Config_Skins.Emerg[SkinName][gl]["BARCOL"]=5 end
        if not Healbot_Config_Skins.Emerg[SkinName][gl]["BUFFGLOW"] then Healbot_Config_Skins.Emerg[SkinName][gl]["BUFFGLOW"]=1 end
        if not Healbot_Config_Skins.Emerg[SkinName][gl]["DEBUFFGLOW"] then Healbot_Config_Skins.Emerg[SkinName][gl]["DEBUFFGLOW"]=1 end
        if Healbot_Config_Skins.Emerg[SkinName][gl]["BARCOL"]>6 then Healbot_Config_Skins.Emerg[SkinName][gl]["BARCOL"]=6 end
        if not Healbot_Config_Skins.Emerg[SkinName][gl]["HEIGHT"] then
            if Healbot_Config_Skins.HealBar[SkinName][gl]["HEIGHT"]>40 then
                local d=0.5-(Healbot_Config_Skins.HealBar[SkinName][gl]["HEIGHT"]-40)/250
                if d<0.25 then d=0.25 end
                Healbot_Config_Skins.Emerg[SkinName][gl]["HEIGHT"]=d
            else
                Healbot_Config_Skins.Emerg[SkinName][gl]["HEIGHT"]=0.5
            end
        end
        if not Healbot_Config_Skins.Emerg[SkinName][gl]["WIDTH"] then
            if Healbot_Config_Skins.HealBar[SkinName][gl]["WIDTH"]>40 then
                local d=0.5-(Healbot_Config_Skins.HealBar[SkinName][gl]["WIDTH"]-40)/250
                if d<0.1 then d=0.1 end
                Healbot_Config_Skins.Emerg[SkinName][gl]["WIDTH"]=d
            else
                Healbot_Config_Skins.Emerg[SkinName][gl]["WIDTH"]=0.5
            end
        end
        if Healbot_Config_Skins.HealBar[SkinName][gl]["LOWMANA"] == nil then Healbot_Config_Skins.HealBar[SkinName][gl]["LOWMANA"]=1 end
        if Healbot_Config_Skins.HealBar[SkinName][gl]["LOWMANACOMBAT"] == nil then Healbot_Config_Skins.HealBar[SkinName][gl]["LOWMANACOMBAT"]=true end

        if (Healbot_Config_Skins.Anchors[SkinName][gl]["FRAME"] or 99) == 1 then Healbot_Config_Skins.Anchors[SkinName][gl]["FRAME"]=nil end
        if (Healbot_Config_Skins.Anchors[SkinName][gl]["BARS"] or 99) == 1 then Healbot_Config_Skins.Anchors[SkinName][gl]["BARS"]=nil end
        if (Healbot_Config_Skins.Anchors[SkinName][gl]["GROW"] or 99) == 2 then Healbot_Config_Skins.Anchors[SkinName][gl]["GROW"]=nil end
        if Healbot_Config_Skins.FrameAlias[SkinName][gl]["NAME"] == nil then Healbot_Config_Skins.FrameAlias[SkinName][gl]["NAME"]="" end
        if Healbot_Config_Skins.FrameAlias[SkinName][gl]["SHOW"] == nil then Healbot_Config_Skins.FrameAlias[SkinName][gl]["SHOW"]=false end
        if Healbot_Config_Skins.FrameAlias[SkinName][gl]["FONT"] == nil then Healbot_Config_Skins.FrameAlias[SkinName][gl]["FONT"]=HealBot_Data_Default_FontName() end
        if Healbot_Config_Skins.FrameAlias[SkinName][gl]["SIZE"] == nil then Healbot_Config_Skins.FrameAlias[SkinName][gl]["SIZE"]=12 end
        if Healbot_Config_Skins.FrameAlias[SkinName][gl]["OUTLINE"] == nil then Healbot_Config_Skins.FrameAlias[SkinName][gl]["OUTLINE"]=1 end
        if Healbot_Config_Skins.FrameAlias[SkinName][gl]["OFFSET"] == nil then Healbot_Config_Skins.FrameAlias[SkinName][gl]["OFFSET"]=0 end
        if Healbot_Config_Skins.FrameAlias[SkinName][gl]["R"] == nil then Healbot_Config_Skins.FrameAlias[SkinName][gl]["R"]=1 end
        if Healbot_Config_Skins.FrameAlias[SkinName][gl]["G"] == nil then Healbot_Config_Skins.FrameAlias[SkinName][gl]["G"]=1 end
        if Healbot_Config_Skins.FrameAlias[SkinName][gl]["B"] == nil then Healbot_Config_Skins.FrameAlias[SkinName][gl]["B"]=1 end
        if Healbot_Config_Skins.FrameAlias[SkinName][gl]["A"] == nil then Healbot_Config_Skins.FrameAlias[SkinName][gl]["A"]=1 end
        if Healbot_Config_Skins.FrameAliasBar[SkinName][gl] then
            if (Healbot_Config_Skins.FrameAliasBar[SkinName][gl]["TEXTURE"] or "") == HealBot_Data_Default_TextureName() then Healbot_Config_Skins.FrameAliasBar[SkinName][gl]["TEXTURE"]=nil end
            if (Healbot_Config_Skins.FrameAliasBar[SkinName][gl]["WIDTH"] or 999) == 0.99 then Healbot_Config_Skins.FrameAliasBar[SkinName][gl]["WIDTH"]=nil end
            if (Healbot_Config_Skins.FrameAliasBar[SkinName][gl]["HEIGHT"] or 999) == 14 then Healbot_Config_Skins.FrameAliasBar[SkinName][gl]["HEIGHT"]=nil end
            if (Healbot_Config_Skins.FrameAliasBar[SkinName][gl]["OFFSET"] or 999) == -4 then Healbot_Config_Skins.FrameAliasBar[SkinName][gl]["OFFSET"]=nil end
            if (Healbot_Config_Skins.FrameAliasBar[SkinName][gl]["R"] or 99) == 0.102 then Healbot_Config_Skins.FrameAliasBar[SkinName][gl]["R"]=nil end
            if (Healbot_Config_Skins.FrameAliasBar[SkinName][gl]["G"] or 99) == 0.102 then Healbot_Config_Skins.FrameAliasBar[SkinName][gl]["G"]=nil end
            if (Healbot_Config_Skins.FrameAliasBar[SkinName][gl]["B"] or 99) == 0.102 then Healbot_Config_Skins.FrameAliasBar[SkinName][gl]["B"]=nil end
            if (Healbot_Config_Skins.FrameAliasBar[SkinName][gl]["A"] or 99) == 0.7 then Healbot_Config_Skins.FrameAliasBar[SkinName][gl]["A"]=nil end
            HealBot_Util_EmptyTable(Healbot_Config_Skins.FrameAliasBar[SkinName], gl)
        end
        if Healbot_Config_Skins.Anchors[SkinName][gl]["Y"] == nil then Healbot_Config_Skins.Anchors[SkinName][gl]["Y"]=(49+gl) end
        if Healbot_Config_Skins.Anchors[SkinName][gl]["X"] == nil then Healbot_Config_Skins.Anchors[SkinName][gl]["X"]=(49+gl) end

        if Healbot_Config_Skins.BarText[SkinName][gl]["INCHEALS"]>3 then
            if Healbot_Config_Skins.BarText[SkinName][gl]["INCHEALS"] == 4 then
                Healbot_Config_Skins.BarText[SkinName][gl]["INCHEALS"]=2
                Healbot_Config_Skins.BarText[SkinName][gl]["IGNOREONFULL"]=false
            elseif Healbot_Config_Skins.BarText[SkinName][gl]["INCHEALS"] == 5 then
                Healbot_Config_Skins.BarText[SkinName][gl]["INCHEALS"]=3
                Healbot_Config_Skins.BarText[SkinName][gl]["IGNOREONFULL"]=false
            elseif Healbot_Config_Skins.BarText[SkinName][gl]["INCHEALS"] == 6 then
                Healbot_Config_Skins.BarText[SkinName][gl]["INCHEALS"]=2
                Healbot_Config_Skins.BarText[SkinName][gl]["INCABSORBS"]=2
            elseif Healbot_Config_Skins.BarText[SkinName][gl]["INCHEALS"] == 7 then
                Healbot_Config_Skins.BarText[SkinName][gl]["INCHEALS"]=3
                Healbot_Config_Skins.BarText[SkinName][gl]["INCABSORBS"]=3
            elseif Healbot_Config_Skins.BarText[SkinName][gl]["INCHEALS"] == 8 then
                Healbot_Config_Skins.BarText[SkinName][gl]["INCHEALS"]=2
                Healbot_Config_Skins.BarText[SkinName][gl]["INCABSORBS"]=2
                Healbot_Config_Skins.BarText[SkinName][gl]["IGNOREONFULL"]=false
            else
                Healbot_Config_Skins.BarText[SkinName][gl]["INCHEALS"]=3
                Healbot_Config_Skins.BarText[SkinName][gl]["INCABSORBS"]=3
                Healbot_Config_Skins.BarText[SkinName][gl]["IGNOREONFULL"]=false
            end
        end

        Healbot_Config_Skins.BarText[SkinName][gl]["DOUBLE"]=nil
        Healbot_Config_Skins.BarText[SkinName][gl]["CLASSCOL"]=nil
        Healbot_Config_Skins.BarText[SkinName][gl]["AGGROCOL"]=nil
        HealBot_Config_Buffs.CBshownAB=nil
        HealBot_Config_Buffs.HealBot_CBWarnRange_Aggro=nil
        HealBot_Config_Cures.CDCshownAB=nil
        HealBot_Config_Cures.HealBot_CDCWarnRange_Aggro=nil
        Healbot_Config_Skins.BarHighlight=nil
        Healbot_Config_Skins.HealBar[SkinName][gl]["POWERSIZE"]=nil
        Healbot_Config_Skins.HealBar[SkinName][gl]["AGGROSIZE"]=nil
    end

    if Healbot_Config_Skins.Healing[SkinName]["ALERTIC"] then Healbot_Config_Skins.Healing[SkinName]["ALERTIC"]=nil end
    if Healbot_Config_Skins.Healing[SkinName]["ALERTOC"] then Healbot_Config_Skins.Healing[SkinName]["ALERTOC"]=nil end
    if Healbot_Config_Skins.Sort then Healbot_Config_Skins.Sort=nil end
    if Healbot_Config_Skins.Aggro then Healbot_Config_Skins.Aggro=nil end
    if Healbot_Config_Skins.Highlight then Healbot_Config_Skins.Highlight=nil end

    if Healbot_Config_Skins.Author[SkinName] == nil then Healbot_Config_Skins.Author[SkinName]="Monti of Terenas" end
    if Healbot_Config_Skins.Healing[SkinName]["GROUPPETS"] == nil then Healbot_Config_Skins.Healing[SkinName]["GROUPPETS"]=true end
    if Healbot_Config_Skins.Healing[SkinName]["SELFPET"] == nil then Healbot_Config_Skins.Healing[SkinName]["SELFPET"]=false end
    if Healbot_Config_Skins.Healing[SkinName]["TALWAYSSHOW"] then
        Healbot_Config_Skins.Healing[SkinName]["TARGETINCOMBAT"]=3
        Healbot_Config_Skins.Healing[SkinName]["TALWAYSSHOW"]=nil
    end
    if Healbot_Config_Skins.Healing[SkinName]["TARGETINCOMBAT"] == nil then Healbot_Config_Skins.Healing[SkinName]["TARGETINCOMBAT"]=2 end
    if Healbot_Config_Skins.Healing[SkinName]["FALWAYSSHOW"] then
        Healbot_Config_Skins.Healing[SkinName]["FOCUSINCOMBAT"]=3
        Healbot_Config_Skins.Healing[SkinName]["FALWAYSSHOW"]=nil
    end
    if not Healbot_Config_Skins.Healing[SkinName]["FOCUSINCOMBAT"] then Healbot_Config_Skins.Healing[SkinName]["FOCUSINCOMBAT"]=2 end
    if Healbot_Config_Skins.Healing[SkinName]["TONLYFRIEND"] == nil then Healbot_Config_Skins.Healing[SkinName]["TONLYFRIEND"]=false end
    if Healbot_Config_Skins.Healing[SkinName]["FONLYFRIEND"] == nil then Healbot_Config_Skins.Healing[SkinName]["FONLYFRIEND"]=false end
    if Healbot_Config_Skins.Healing[SkinName]["TEXRAID"] == nil then Healbot_Config_Skins.Healing[SkinName]["TEXRAID"]=false end
    if Healbot_Config_Skins.Healing[SkinName]["FEXRAID"] == nil then Healbot_Config_Skins.Healing[SkinName]["FEXRAID"]=false end
    if Healbot_Config_Skins.General[SkinName]["HIDEPARTYF"] == false then Healbot_Config_Skins.General[SkinName]["HIDEPARTYF"]=nil end
    if Healbot_Config_Skins.General[SkinName]["RUNBLIZZEVENTS"] == false then Healbot_Config_Skins.General[SkinName]["RUNBLIZZEVENTS"]=nil end
    if Healbot_Config_Skins.General[SkinName]["HIDEPTF"] == false then Healbot_Config_Skins.General[SkinName]["HIDEPTF"]=nil end
    if Healbot_Config_Skins.General[SkinName]["HIDEBOSSF"] == false then Healbot_Config_Skins.General[SkinName]["HIDEBOSSF"]=nil end
    if Healbot_Config_Skins.General[SkinName]["HIDEFOCUSF"] == false then Healbot_Config_Skins.General[SkinName]["HIDEFOCUSF"]=nil end
    if Healbot_Config_Skins.General[SkinName]["STICKYFRAME"] == false then Healbot_Config_Skins.General[SkinName]["STICKYFRAME"]=nil end
    if Healbot_Config_Skins.General[SkinName]["HIDERAIDF"] then Healbot_Config_Skins.General[SkinName]["HIDERAIDF"]=nil end
    if Healbot_Config_Skins.General[SkinName]["FLUIDBARS"] == false then Healbot_Config_Skins.General[SkinName]["FLUIDBARS"]=nil end
    if Healbot_Config_Skins.General[SkinName]["HEALTHDROP"] == false then Healbot_Config_Skins.General[SkinName]["HEALTHDROP"]=nil end
    if (Healbot_Config_Skins.General[SkinName]["HEALTHDROPPCT"] or 99) == 400 then Healbot_Config_Skins.General[SkinName]["HEALTHDROPPCT"]=nil end
    if (Healbot_Config_Skins.General[SkinName]["UNITINCOMBAT"] or 99) == 2 then Healbot_Config_Skins.General[SkinName]["UNITINCOMBAT"]=nil end
    if (Healbot_Config_Skins.General[SkinName]["HEALTHDROPCANCEL"] or 99) == 200 then Healbot_Config_Skins.General[SkinName]["HEALTHDROPCANCEL"]=nil end
    if (Healbot_Config_Skins.General[SkinName]["HEALTHDROPTIME"] or 99) == 3 then Healbot_Config_Skins.General[SkinName]["HEALTHDROPTIME"]=nil end
    if (Healbot_Config_Skins.General[SkinName]["FLUIDFREQ"] or 99) == 10 then Healbot_Config_Skins.General[SkinName]["FLUIDFREQ"]=nil end
    if (Healbot_Config_Skins.General[SkinName]["HOTBARHLTH"] or 99) == 0 then Healbot_Config_Skins.General[SkinName]["HOTBARHLTH"]=nil end
    if (Healbot_Config_Skins.General[SkinName]["HOTBARDEBUFF"] or 99) == 1 then Healbot_Config_Skins.General[SkinName]["HOTBARDEBUFF"]=nil end
    if (Healbot_Config_Skins.General[SkinName]["HBDIMMING"] or 99) == 2.2 then Healbot_Config_Skins.General[SkinName]["HBDIMMING"]=nil end
    if (Healbot_Config_Skins.General[SkinName]["FOCUSGROUPS"] or 99) == 1 then Healbot_Config_Skins.General[SkinName]["FOCUSGROUPS"]=nil end
    if (Healbot_Config_Skins.General[SkinName]["FGDIMMING"] or 99) == 2.5 then Healbot_Config_Skins.General[SkinName]["FGDIMMING"]=nil end
    if (Healbot_Config_Skins.General[SkinName]["HAZARDFREQ"] or 99) == 0.3 then Healbot_Config_Skins.General[SkinName]["HAZARDFREQ"]=nil end
    if (Healbot_Config_Skins.General[SkinName]["HAZARDMINALPHA"] or 99) == 0.25 then Healbot_Config_Skins.General[SkinName]["HAZARDMINALPHA"]=nil end
    if (Healbot_Config_Skins.General[SkinName]["GLOBALDIMMING"] or 99) == 1 then Healbot_Config_Skins.General[SkinName]["GLOBALDIMMING"]=nil end
    if (Healbot_Config_Skins.General[SkinName]["OFREQ"] or 99) == 0.2 then Healbot_Config_Skins.General[SkinName]["OFREQ"]=nil end
    if (Healbot_Config_Skins.General[SkinName]["OMIN"] or 99) == 0.1 then Healbot_Config_Skins.General[SkinName]["OMIN"]=nil end
    if (Healbot_Config_Skins.General[SkinName]["OMAX"] or 99) == 0.95 then Healbot_Config_Skins.General[SkinName]["OMAX"]=nil end
    if (Healbot_Config_Skins.General[SkinName]["HAZARDFREQ"] or 99) == 0.3 then Healbot_Config_Skins.General[SkinName]["HAZARDFREQ"]=nil end
    if (Healbot_Config_Skins.General[SkinName]["HAZARDMINALPHA"] or 99) == 0.25 then Healbot_Config_Skins.General[SkinName]["HAZARDMINALPHA"]=nil end
    Healbot_Config_Skins.General[SkinName]["LOWMANA"]=nil
    Healbot_Config_Skins.General[SkinName]["LOWMANACOMBAT"]=nil
    if not Healbot_Config_Skins.Chat[SkinName]["NOTIFY"] then Healbot_Config_Skins.Chat[SkinName]["NOTIFY"]=1 end
    if Healbot_Config_Skins.Chat[SkinName]["MSG"] == nil then Healbot_Config_Skins.Chat[SkinName]["MSG"]=HEALBOT_NOTIFYOTHERMSG end
    if Healbot_Config_Skins.Chat[SkinName]["RESONLY"] == nil then Healbot_Config_Skins.Chat[SkinName]["RESONLY"]=true end
    if Healbot_Config_Skins.Chat[SkinName]["EOCOOM"] == nil then Healbot_Config_Skins.Chat[SkinName]["EOCOOM"]=false end
    if not Healbot_Config_Skins.Chat[SkinName]["EOCOOMV"] then Healbot_Config_Skins.Chat[SkinName]["EOCOOMV"]=20 end
    if Healbot_Config_Skins.DuplicateBars[SkinName] == nil then Healbot_Config_Skins.DuplicateBars[SkinName]=false end
    if Healbot_Config_Skins.Enemy[SkinName] then
        if Healbot_Config_Skins.Enemy[SkinName]["INCSELF"] == false then Healbot_Config_Skins.Enemy[SkinName]["INCSELF"]=nil end
        if Healbot_Config_Skins.Enemy[SkinName]["INCTANKS"] then Healbot_Config_Skins.Enemy[SkinName]["INCTANKS"]=nil end
        if Healbot_Config_Skins.Enemy[SkinName]["INCFOCUS"] then Healbot_Config_Skins.Enemy[SkinName]["INCFOCUS"]=nil end
        if Healbot_Config_Skins.Enemy[SkinName]["INCMYTAR"] == false then Healbot_Config_Skins.Enemy[SkinName]["INCMYTAR"]=nil end
        if Healbot_Config_Skins.Enemy[SkinName]["INCARENA"] then Healbot_Config_Skins.Enemy[SkinName]["INCARENA"]=nil end
        if Healbot_Config_Skins.Enemy[SkinName]["INCARENAPETS"] == false then Healbot_Config_Skins.Enemy[SkinName]["INCARENAPETS"]=nil end
        if (Healbot_Config_Skins.Enemy[SkinName]["NUMBOSS"] or 99) == 8 then Healbot_Config_Skins.Enemy[SkinName]["NUMBOSS"]=nil end
        if Healbot_Config_Skins.Enemy[SkinName]["SELFDEBUFFS"] then Healbot_Config_Skins.Enemy[SkinName]["SELFDEBUFFS"]=nil end
        if Healbot_Config_Skins.Enemy[SkinName]["SELFDEBUFFSPLAYERFRAMES"] then Healbot_Config_Skins.Enemy[SkinName]["SELFDEBUFFSPLAYERFRAMES"]=nil end
        if Healbot_Config_Skins.Enemy[SkinName]["SELFBUFFS"] then Healbot_Config_Skins.Enemy[SkinName]["SELFBUFFS"]=nil end
        if Healbot_Config_Skins.Enemy[SkinName]["SELFBUFFSPLAYERFRAMES"] then Healbot_Config_Skins.Enemy[SkinName]["SELFBUFFSPLAYERFRAMES"]=nil end
        if (Healbot_Config_Skins.Enemy[SkinName]["EXISTSHOWGROUP"] or 99) == 1 then Healbot_Config_Skins.Enemy[SkinName]["EXISTSHOWGROUP"]=nil end
        if (Healbot_Config_Skins.Enemy[SkinName]["EXISTSHOWRAID"] or 99) == 1 then Healbot_Config_Skins.Enemy[SkinName]["EXISTSHOWRAID"]=nil end
        if Healbot_Config_Skins.Enemy[SkinName]["EXISTSHOWBOSS"] then Healbot_Config_Skins.Enemy[SkinName]["EXISTSHOWBOSS"]=nil end
        if Healbot_Config_Skins.Enemy[SkinName]["ENEMYTARGET"] == false then Healbot_Config_Skins.Enemy[SkinName]["ENEMYTARGET"]=nil end
        if Healbot_Config_Skins.Enemy[SkinName]["TARUSEENEMYCOLS"] then Healbot_Config_Skins.Enemy[SkinName]["TARUSEENEMYCOLS"]=nil end
        if Healbot_Config_Skins.Enemy[SkinName]["TOTUSEENEMYCOLS"] == false then Healbot_Config_Skins.Enemy[SkinName]["TOTUSEENEMYCOLS"]=nil end
        if (Healbot_Config_Skins.Enemy[SkinName]["ENEMYTARGETSIZE"] or 99) == 0.4 then Healbot_Config_Skins.Enemy[SkinName]["ENEMYTARGETSIZE"]=nil end
        if (Healbot_Config_Skins.Enemy[SkinName]["ENEMYTARGETSIZEPLAYERFRAMES"] or 99) == 0.4 then Healbot_Config_Skins.Enemy[SkinName]["ENEMYTARGETSIZEPLAYERFRAMES"]=nil end
        if (Healbot_Config_Skins.Enemy[SkinName]["PLAYERTARGETSIZE"] or 99) == 0.5 then Healbot_Config_Skins.Enemy[SkinName]["PLAYERTARGETSIZE"]=nil end
        if (Healbot_Config_Skins.Enemy[SkinName]["INCOMBATSHOWSELF"] or 99) == 2 then Healbot_Config_Skins.Enemy[SkinName]["INCOMBATSHOWSELF"]=nil end
        if (Healbot_Config_Skins.Enemy[SkinName]["INCOMBATSHOWFOCUS"] or 99) == 2 then Healbot_Config_Skins.Enemy[SkinName]["INCOMBATSHOWFOCUS"]=nil end
        if (Healbot_Config_Skins.Enemy[SkinName]["INCOMBATSHOWTANK"] or 99) == 2 then Healbot_Config_Skins.Enemy[SkinName]["INCOMBATSHOWTANK"]=nil end
        if (Healbot_Config_Skins.Enemy[SkinName]["INCOMBATSHOWGROUP"] or 99) == 2 then Healbot_Config_Skins.Enemy[SkinName]["INCOMBATSHOWGROUP"]=nil end
        if (Healbot_Config_Skins.Enemy[SkinName]["INCOMBATSHOWRAID"] or 99) == 2 then Healbot_Config_Skins.Enemy[SkinName]["INCOMBATSHOWRAID"]=nil end
        if (Healbot_Config_Skins.Enemy[SkinName]["SELFUSEFRAME"] or 99) == 1 then Healbot_Config_Skins.Enemy[SkinName]["SELFUSEFRAME"]=nil end
        if (Healbot_Config_Skins.Enemy[SkinName]["PRIVATELISTUSEFRAME"] or 99) == 1 then Healbot_Config_Skins.Enemy[SkinName]["PRIVATELISTUSEFRAME"]=nil end
        if (Healbot_Config_Skins.Enemy[SkinName]["TANKUSEFRAME"] or 99) == 1 then Healbot_Config_Skins.Enemy[SkinName]["TANKUSEFRAME"]=nil end
        if (Healbot_Config_Skins.Enemy[SkinName]["GROUPUSEFRAME"] or 99) == 1 then Healbot_Config_Skins.Enemy[SkinName]["GROUPUSEFRAME"]=nil end
        if (Healbot_Config_Skins.Enemy[SkinName]["RAIDUSEFRAME"] or 99) == 1 then Healbot_Config_Skins.Enemy[SkinName]["RAIDUSEFRAME"]=nil end
        if (Healbot_Config_Skins.Enemy[SkinName]["INCOMBATSHOWLIST"] or 99) == 2 then Healbot_Config_Skins.Enemy[SkinName]["INCOMBATSHOWLIST"]=nil end
        if (Healbot_Config_Skins.Enemy[SkinName]["INCOMBATSHOWARENA"] or 99) == 2 then Healbot_Config_Skins.Enemy[SkinName]["INCOMBATSHOWARENA"]=nil end
        if (Healbot_Config_Skins.Enemy[SkinName]["EXISTSHOWPTAR"] or 99) == 1 then Healbot_Config_Skins.Enemy[SkinName]["EXISTSHOWPTAR"]=nil end
        if (Healbot_Config_Skins.Enemy[SkinName]["EXISTSHOWFOCUS"] or 99) == 1 then Healbot_Config_Skins.Enemy[SkinName]["EXISTSHOWFOCUS"]=nil end
        if (Healbot_Config_Skins.Enemy[SkinName]["EXISTSHOWARENA"] or 99) == 2 then Healbot_Config_Skins.Enemy[SkinName]["EXISTSHOWARENA"]=nil end
        if (Healbot_Config_Skins.Enemy[SkinName]["EXISTSHOWMYTAR"] or 99) == 1 then Healbot_Config_Skins.Enemy[SkinName]["EXISTSHOWMYTAR"]=nil end
        if (Healbot_Config_Skins.Enemy[SkinName]["EXISTSHOWTANK"] or 99) == 1 then Healbot_Config_Skins.Enemy[SkinName]["EXISTSHOWTANK"]=nil end
        
        if Healbot_Config_Skins.Enemy[SkinName]["INCDPS"] then Healbot_Config_Skins.Enemy[SkinName]["INCDPS"]=nil end
        if Healbot_Config_Skins.Enemy[SkinName]["FRAME"] then Healbot_Config_Skins.Enemy[SkinName]["FRAME"]=nil end
        if Healbot_Config_Skins.Enemy[SkinName]["HIDE"] ~= nil then Healbot_Config_Skins.Enemy[SkinName]["HIDE"]=nil end
    end

    if not Healbot_Config_Skins.CustomCols[SkinName]["TANK"] then HealBot_Skins_SetRoleCol(SkinName, "TANK", false) end
    if not Healbot_Config_Skins.CustomCols[SkinName]["HEALER"] then HealBot_Skins_SetRoleCol(SkinName, "HEALER", false) end
    if not Healbot_Config_Skins.CustomCols[SkinName]["DAMAGER"] then HealBot_Skins_SetRoleCol(SkinName, "DAMAGER", false) end
    if not Healbot_Config_Skins.CustomCols[SkinName]["DEMO"] then HealBot_Skins_SetClassCol(SkinName, "DEMO", false) end
    if not Healbot_Config_Skins.CustomCols[SkinName]["DRUI"] then HealBot_Skins_SetClassCol(SkinName, "DRUI", false) end
    if not Healbot_Config_Skins.CustomCols[SkinName]["HUNT"] then HealBot_Skins_SetClassCol(SkinName, "HUNT", false) end
    if not Healbot_Config_Skins.CustomCols[SkinName]["MAGE"] then HealBot_Skins_SetClassCol(SkinName, "MAGE", false) end
    if not Healbot_Config_Skins.CustomCols[SkinName]["MONK"] then HealBot_Skins_SetClassCol(SkinName, "MONK", false) end
    if not Healbot_Config_Skins.CustomCols[SkinName]["PALA"] then HealBot_Skins_SetClassCol(SkinName, "PALA", false) end
    if not Healbot_Config_Skins.CustomCols[SkinName]["PRIE"] then HealBot_Skins_SetClassCol(SkinName, "PRIE", false) end
    if not Healbot_Config_Skins.CustomCols[SkinName]["ROGU"] then HealBot_Skins_SetClassCol(SkinName, "ROGU", false) end
    if not Healbot_Config_Skins.CustomCols[SkinName]["SHAM"] then HealBot_Skins_SetClassCol(SkinName, "SHAM", false) end
    if not Healbot_Config_Skins.CustomCols[SkinName]["WARL"] then HealBot_Skins_SetClassCol(SkinName, "WARL", false) end
    if not Healbot_Config_Skins.CustomCols[SkinName]["DEAT"] then HealBot_Skins_SetClassCol(SkinName, "DEAT", false) end
    if not Healbot_Config_Skins.CustomCols[SkinName]["WARR"] then HealBot_Skins_SetClassCol(SkinName, "WARR", false) end
    if not Healbot_Config_Skins.CustomCols[SkinName]["EVOK"] then HealBot_Skins_SetClassCol(SkinName, "EVOK", false) end
    if not Healbot_Config_Skins.CustomCols[SkinName]["MANA"] then HealBot_Skins_SetPowerCol(SkinName, "MANA", false) end
    if not Healbot_Config_Skins.CustomCols[SkinName]["RAGE"] then HealBot_Skins_SetPowerCol(SkinName, "RAGE", false) end
    if not Healbot_Config_Skins.CustomCols[SkinName]["FOCUS"] then HealBot_Skins_SetPowerCol(SkinName, "FOCUS", false) end
    if not Healbot_Config_Skins.CustomCols[SkinName]["ENERGY"] then HealBot_Skins_SetPowerCol(SkinName, "ENERGY", false) end
    if not Healbot_Config_Skins.CustomCols[SkinName]["RUNIC_POWER"] then HealBot_Skins_SetPowerCol(SkinName, "RUNIC_POWER", false) end
    if not Healbot_Config_Skins.CustomCols[SkinName]["INSANITY"] then HealBot_Skins_SetPowerCol(SkinName, "INSANITY", false) end
    if not Healbot_Config_Skins.CustomCols[SkinName]["LUNAR_POWER"] then HealBot_Skins_SetPowerCol(SkinName, "LUNAR_POWER", false) end
    if not Healbot_Config_Skins.CustomCols[SkinName]["MAELSTROM"] then HealBot_Skins_SetPowerCol(SkinName, "MAELSTROM", false) end
    if not Healbot_Config_Skins.CustomCols[SkinName]["FURY"] then HealBot_Skins_SetPowerCol(SkinName, "FURY", false) end
    if Healbot_Config_Skins.Adaptive[SkinName]["Plugin"] == nil then Healbot_Config_Skins.Adaptive[SkinName]["Plugin"]=true end
    if Healbot_Config_Skins.Adaptive[SkinName]["RecentHeals"] == nil then Healbot_Config_Skins.Adaptive[SkinName]["RecentHeals"]=false end
    if Healbot_Config_Skins.Adaptive[SkinName]["Threat"] == nil then Healbot_Config_Skins.Adaptive[SkinName]["Threat"]=false end
    if Healbot_Config_Skins.Adaptive[SkinName]["Debuffs"] == nil then Healbot_Config_Skins.Adaptive[SkinName]["Debuffs"]=true end
    if Healbot_Config_Skins.Adaptive[SkinName]["Aggro"] == nil then Healbot_Config_Skins.Adaptive[SkinName]["Aggro"]=true end
    if Healbot_Config_Skins.Adaptive[SkinName]["Highlight"] == nil then Healbot_Config_Skins.Adaptive[SkinName]["Highlight"]=false end
    if Healbot_Config_Skins.Adaptive[SkinName]["Target"] == nil then Healbot_Config_Skins.Adaptive[SkinName]["Target"]=false end
    if Healbot_Config_Skins.Adaptive[SkinName]["OOR"] == nil then Healbot_Config_Skins.Adaptive[SkinName]["OOR"]=false end
    if Healbot_Config_Skins.Adaptive[SkinName]["Buffs"] == nil then Healbot_Config_Skins.Adaptive[SkinName]["Buffs"]=true end
    if Healbot_Config_Skins.Adaptive[SkinName]["Overheals"] == nil then Healbot_Config_Skins.Adaptive[SkinName]["Overheals"]=false end
    if Healbot_Config_Skins.Adaptive[SkinName]["Absorbs"] == nil then Healbot_Config_Skins.Adaptive[SkinName]["Absorbs"]=false end
    local setAllAdaptiveOrder=false
    for x=1,11 do
        if not Healbot_Config_Skins.AdaptiveOrder[SkinName][x] then
            setAllAdaptiveOrder=true
            break
        end
    end
    if setAllAdaptiveOrder then
        Healbot_Config_Skins.AdaptiveOrder[SkinName][1]="Plugin"
        Healbot_Config_Skins.AdaptiveOrder[SkinName][2]="RecentHeals"
        Healbot_Config_Skins.AdaptiveOrder[SkinName][3]="Debuffs"
        Healbot_Config_Skins.AdaptiveOrder[SkinName][4]="Aggro"
        Healbot_Config_Skins.AdaptiveOrder[SkinName][5]="Threat"
        Healbot_Config_Skins.AdaptiveOrder[SkinName][6]="Highlight"
        Healbot_Config_Skins.AdaptiveOrder[SkinName][7]="Target"
        Healbot_Config_Skins.AdaptiveOrder[SkinName][8]="OOR"
        Healbot_Config_Skins.AdaptiveOrder[SkinName][9]="Buffs"
        Healbot_Config_Skins.AdaptiveOrder[SkinName][10]="Overheals"
        Healbot_Config_Skins.AdaptiveOrder[SkinName][11]="Absorbs"
    end
    if Healbot_Config_Skins.AdaptiveCol[SkinName]["RecentHeals"] then
        if (Healbot_Config_Skins.AdaptiveCol[SkinName]["RecentHeals"].R or 99) == 0.1 then Healbot_Config_Skins.AdaptiveCol[SkinName]["RecentHeals"].R=nil end
        if (Healbot_Config_Skins.AdaptiveCol[SkinName]["RecentHeals"].G or 99) == 1 then Healbot_Config_Skins.AdaptiveCol[SkinName]["RecentHeals"].G=nil end
        if (Healbot_Config_Skins.AdaptiveCol[SkinName]["RecentHeals"].B or 99) == 0.2 then Healbot_Config_Skins.AdaptiveCol[SkinName]["RecentHeals"].B=nil end
        HealBot_Util_EmptyTable(Healbot_Config_Skins.AdaptiveCol[SkinName], "RecentHeals")
    end
    if Healbot_Config_Skins.AdaptiveCol[SkinName]["Threat"] then
        if (Healbot_Config_Skins.AdaptiveCol[SkinName]["Threat"].R or 99) == 1 then Healbot_Config_Skins.AdaptiveCol[SkinName]["Threat"].R=nil end
        if (Healbot_Config_Skins.AdaptiveCol[SkinName]["Threat"].G or 99) == 0.49 then Healbot_Config_Skins.AdaptiveCol[SkinName]["Threat"].G=nil end
        if (Healbot_Config_Skins.AdaptiveCol[SkinName]["Threat"].B or 99) == 0.04 then Healbot_Config_Skins.AdaptiveCol[SkinName]["Threat"].B=nil end
        HealBot_Util_EmptyTable(Healbot_Config_Skins.AdaptiveCol[SkinName], "Threat")
    end
    if Healbot_Config_Skins.AdaptiveCol[SkinName]["Aggro"] then
        if (Healbot_Config_Skins.AdaptiveCol[SkinName]["Aggro"].R or 99) == 1 then Healbot_Config_Skins.AdaptiveCol[SkinName]["Aggro"].R=nil end
        if (Healbot_Config_Skins.AdaptiveCol[SkinName]["Aggro"].G or 99) == 0 then Healbot_Config_Skins.AdaptiveCol[SkinName]["Aggro"].G=nil end
        if (Healbot_Config_Skins.AdaptiveCol[SkinName]["Aggro"].B or 99) == 0 then Healbot_Config_Skins.AdaptiveCol[SkinName]["Aggro"].B=nil end
        HealBot_Util_EmptyTable(Healbot_Config_Skins.AdaptiveCol[SkinName], "Aggro")
    end
    if Healbot_Config_Skins.AdaptiveCol[SkinName]["Highlight"] then
        if (Healbot_Config_Skins.AdaptiveCol[SkinName]["Highlight"].R or 99) == 0.4 then Healbot_Config_Skins.AdaptiveCol[SkinName]["Highlight"].R=nil end
        if (Healbot_Config_Skins.AdaptiveCol[SkinName]["Highlight"].G or 99) == 1 then Healbot_Config_Skins.AdaptiveCol[SkinName]["Highlight"].G=nil end
        if (Healbot_Config_Skins.AdaptiveCol[SkinName]["Highlight"].B or 99) == 1 then Healbot_Config_Skins.AdaptiveCol[SkinName]["Highlight"].B=nil end
        HealBot_Util_EmptyTable(Healbot_Config_Skins.AdaptiveCol[SkinName], "Highlight")
    end
    if Healbot_Config_Skins.AdaptiveCol[SkinName]["Target"] then
        if (Healbot_Config_Skins.AdaptiveCol[SkinName]["Target"].R or 99) == 1 then Healbot_Config_Skins.AdaptiveCol[SkinName]["Target"].R=nil end
        if (Healbot_Config_Skins.AdaptiveCol[SkinName]["Target"].G or 99) == 0.9 then Healbot_Config_Skins.AdaptiveCol[SkinName]["Target"].G=nil end
        if (Healbot_Config_Skins.AdaptiveCol[SkinName]["Target"].B or 99) == 0.2 then Healbot_Config_Skins.AdaptiveCol[SkinName]["Target"].B=nil end
        HealBot_Util_EmptyTable(Healbot_Config_Skins.AdaptiveCol[SkinName], "Target")
    end
    if Healbot_Config_Skins.AdaptiveCol[SkinName]["OOR"] then
        if (Healbot_Config_Skins.AdaptiveCol[SkinName]["OOR"].R or 99) == 0 then Healbot_Config_Skins.AdaptiveCol[SkinName]["OOR"].R=nil end
        if (Healbot_Config_Skins.AdaptiveCol[SkinName]["OOR"].G or 99) == 0 then Healbot_Config_Skins.AdaptiveCol[SkinName]["OOR"].G=nil end
        if (Healbot_Config_Skins.AdaptiveCol[SkinName]["OOR"].B or 99) == 0 then Healbot_Config_Skins.AdaptiveCol[SkinName]["OOR"].B=nil end
        HealBot_Util_EmptyTable(Healbot_Config_Skins.AdaptiveCol[SkinName], "OOR")
    end
    if Healbot_Config_Skins.AdaptiveCol[SkinName]["Overheals"] then
        if (Healbot_Config_Skins.AdaptiveCol[SkinName]["Overheals"].R or 99) == 1 then Healbot_Config_Skins.AdaptiveCol[SkinName]["Overheals"].R=nil end
        if (Healbot_Config_Skins.AdaptiveCol[SkinName]["Overheals"].G or 99) == 0.2 then Healbot_Config_Skins.AdaptiveCol[SkinName]["Overheals"].G=nil end
        if (Healbot_Config_Skins.AdaptiveCol[SkinName]["Overheals"].B or 99) == 0.2 then Healbot_Config_Skins.AdaptiveCol[SkinName]["Overheals"].B=nil end
        HealBot_Util_EmptyTable(Healbot_Config_Skins.AdaptiveCol[SkinName], "Overheals")
    end
    if Healbot_Config_Skins.AdaptiveCol[SkinName]["Absorbs"] then
        if (Healbot_Config_Skins.AdaptiveCol[SkinName]["Absorbs"].R or 99) == 1 then Healbot_Config_Skins.AdaptiveCol[SkinName]["Absorbs"].R=nil end
        if (Healbot_Config_Skins.AdaptiveCol[SkinName]["Absorbs"].G or 99) == 1 then Healbot_Config_Skins.AdaptiveCol[SkinName]["Absorbs"].G=nil end
        if (Healbot_Config_Skins.AdaptiveCol[SkinName]["Absorbs"].B or 99) == 1 then Healbot_Config_Skins.AdaptiveCol[SkinName]["Absorbs"].B=nil end
        HealBot_Util_EmptyTable(Healbot_Config_Skins.AdaptiveCol[SkinName], "Absorbs")
    end

    -- Fix Frames
    for id=1,10 do
        if Healbot_Config_Skins.HealGroups[SkinName][id]["NAME"] == HEALBOT_CUSTOM_CASTBY_ENEMY_en then
            HealBot_Options_HealGroupSwap(SkinName, 11, id)
            break
        end
    end
    for id=1,9 do
        if Healbot_Config_Skins.HealGroups[SkinName][id]["NAME"] == HEALBOT_FOCUS_en then
            HealBot_Options_HealGroupSwap(SkinName, 10, id)
            break
        end
    end
    for id=1,8 do
        if Healbot_Config_Skins.HealGroups[SkinName][id]["NAME"] == HEALBOT_OPTIONS_TARGETHEALS_en then
            HealBot_Options_HealGroupSwap(SkinName, 9, id)
            break
        end
    end
    for id=1,7 do
        if Healbot_Config_Skins.HealGroups[SkinName][id]["NAME"] == HEALBOT_OPTIONS_PETHEALS_en then
            HealBot_Options_HealGroupSwap(SkinName, 8, id)
            break
        end
    end
    for id=1,6 do
        if Healbot_Config_Skins.HealGroups[SkinName][id]["NAME"] == HEALBOT_VEHICLE_en then
            HealBot_Options_HealGroupSwap(SkinName, 7, id)
            break
        end
    end
    Healbot_Config_Skins.HealGroups[SkinName][11]["FRAME"]=10
    if Healbot_Config_Skins.HealGroups[SkinName][10]["FRAME"]>5 and Healbot_Config_Skins.HealGroups[SkinName][10]["FRAME"]~=9 then
        Healbot_Config_Skins.HealGroups[SkinName][10]["FRAME"]=9
    end
    if Healbot_Config_Skins.HealGroups[SkinName][9]["FRAME"]>5 and Healbot_Config_Skins.HealGroups[SkinName][9]["FRAME"]~=8 then
        Healbot_Config_Skins.HealGroups[SkinName][9]["FRAME"]=8
    end
    if Healbot_Config_Skins.HealGroups[SkinName][8]["FRAME"]>5 and Healbot_Config_Skins.HealGroups[SkinName][8]["FRAME"]~=7 then
        Healbot_Config_Skins.HealGroups[SkinName][8]["FRAME"]=7
    end
    if Healbot_Config_Skins.HealGroups[SkinName][7]["FRAME"]>6 then
        Healbot_Config_Skins.HealGroups[SkinName][7]["FRAME"]=6
    end
    Healbot_Config_Skins.FrameAlias[SkinName][6]["ALIAS"]=HEALBOT_VEHICLE_en
    Healbot_Config_Skins.FrameAlias[SkinName][7]["ALIAS"]=HEALBOT_OPTIONS_PETHEALS_en
    Healbot_Config_Skins.FrameAlias[SkinName][8]["ALIAS"]=HEALBOT_OPTIONS_TARGETHEALS_en
    Healbot_Config_Skins.FrameAlias[SkinName][9]["ALIAS"]=HEALBOT_FOCUS_en
    Healbot_Config_Skins.FrameAlias[SkinName][10]["ALIAS"]=HEALBOT_CUSTOM_CASTBY_ENEMY_en
    for id=1,6 do
        if Healbot_Config_Skins.HealGroups[SkinName][id]["FRAME"]>5 then
            Healbot_Config_Skins.HealGroups[SkinName][id]["FRAME"]=1
        end
    end
    Healbot_Config_Skins.General[SkinName]["VC"]=HealBot_Global_Version()
end
local hbRoleCols= {
          ["TANK"]=    {r=0.85, g=0.65,  b=0.50, },
          ["HEALER"]=  {r=0.30, g=0.90,  b=0.99, },
          ["DAMAGER"]= {r=1.0,  g=0.45,  b=0.05, },
      }
function HealBot_Skins_SetRoleCol(SkinName, role, override)
      --HealBot_setCall("HealBot_Skins_SetRoleCol")
    if override then
        HealBot_Globals.OverrideColours[role]={}
        HealBot_Globals.OverrideColours[role].r=hbRoleCols[role].r
        HealBot_Globals.OverrideColours[role].g=hbRoleCols[role].g
        HealBot_Globals.OverrideColours[role].b=hbRoleCols[role].b
    else
        Healbot_Config_Skins.CustomCols[SkinName][role]={}
        Healbot_Config_Skins.CustomCols[SkinName][role].r=hbRoleCols[role].r
        Healbot_Config_Skins.CustomCols[SkinName][role].g=hbRoleCols[role].g
        Healbot_Config_Skins.CustomCols[SkinName][role].b=hbRoleCols[role].b
    end
end

local hbClassCols={
          ["DEAT"]={r=0.78, g=0.04, b=0.04, },
          ["DEMO"]={r=0.8,  g=0.1,  b=0.8, },
          ["DRUI"]={r=1.0,  g=0.49, b=0.04, },
          ["EVOK"]={r=0.22, g=0.59, b=0.49, },
          ["HUNT"]={r=0.67, g=0.83, b=0.45, },
          ["MAGE"]={r=0.41, g=0.8,  b=0.94, },
          ["MONK"]={r=0.0,  g=1.0,  b=0.59, },
          ["PALA"]={r=0.96, g=0.55, b=0.73, },
          ["PRIE"]={r=1.0,  g=1.0,  b=1.0,  },
          ["ROGU"]={r=1.0,  g=0.96, b=0.41, },
          ["SHAM"]={r=0.14, g=0.35, b=1.0,  },
          ["WARL"]={r=0.58, g=0.51, b=0.79, },
          ["WARR"]={r=0.78, g=0.61, b=0.43, },
      }
function HealBot_Skins_SetClassCol(SkinName, class, override)
      --HealBot_setCall("HealBot_Skins_SetClassCol")
    if override then
        HealBot_Globals.OverrideColours[class]={}
        HealBot_Globals.OverrideColours[class].r=hbClassCols[class].r
        HealBot_Globals.OverrideColours[class].g=hbClassCols[class].g
        HealBot_Globals.OverrideColours[class].b=hbClassCols[class].b
    else
        Healbot_Config_Skins.CustomCols[SkinName][class]={}
        Healbot_Config_Skins.CustomCols[SkinName][class].r=hbClassCols[class].r
        Healbot_Config_Skins.CustomCols[SkinName][class].g=hbClassCols[class].g
        Healbot_Config_Skins.CustomCols[SkinName][class].b=hbClassCols[class].b
    end
end

function HealBot_Skins_RetClassCol(class)
    return hbClassCols[class]
end

local hbPowerCols= {
          ["ENERGY"]=      {r=1.0,  g=1.0,  b=0.0, },
          ["FOCUS"]=       {r=1.0,  g=0.5,  b=0.25, },
          ["FURY"]=        {r=0.79, g=0.26, b=0.99, },
          ["INSANITY"]=    {r=0.4,  g=0.0,  b=0.8, },
          ["LUNAR_POWER"]= {r=0.3,  g=0.52, b=0.9, },
          ["MAELSTROM"]=   {r=0.0,  g=0.5,  b=1.0, },
          ["MANA"]=        {r=0.0,  g=0.0,  b=1.0, },
          ["RAGE"]=        {r=1.0,  g=0.0,  b=0.0, },
          ["RUNIC_POWER"]= {r=0.0,  g=0.82, b=1.0,  },
      }
function HealBot_Skins_SetPowerCol(SkinName, powerType, override)
      --HealBot_setCall("HealBot_Skins_SetPowerCol")
    if override then
        HealBot_Globals.OverrideColours[powerType]={}
        HealBot_Globals.OverrideColours[powerType].r=hbPowerCols[powerType].r
        HealBot_Globals.OverrideColours[powerType].g=hbPowerCols[powerType].g
        HealBot_Globals.OverrideColours[powerType].b=hbPowerCols[powerType].b
    else
        Healbot_Config_Skins.CustomCols[SkinName][powerType]={}
        Healbot_Config_Skins.CustomCols[SkinName][powerType].r=hbPowerCols[powerType].r
        Healbot_Config_Skins.CustomCols[SkinName][powerType].g=hbPowerCols[powerType].g
        Healbot_Config_Skins.CustomCols[SkinName][powerType].b=hbPowerCols[powerType].b
    end
end
--          ["AMMOSLOT"]      ={r=0.8,  g=0.6,  b=0.0, },
--          ["ARCANE_CHARGES"]={r=0.1,  g=0.1,  b=0.98, },
--          ["CHI"]           ={r=0.71, g=1.0,  b=0.92, },
--          ["ECLIPSE"]       ={r=0.3,  g=0.52, b=0.9,  },
--          ["FUEL"]          ={r=0.0,  g=0.55, b=0.5, },
--          ["HAPPINESS"]     ={r=1.0,  g=0.96, b=0.41, },
--          ["HOLY_POWER"]    ={r=0.95, g=0.9,  b=0.6, },
--          ["PAIN"]          ={r=1.0,  g=0.61, b=0.0, },
--          ["RUNES"]         ={r=0.5,  g=0.5,  b=0.5, },
--          ["SOUL_SHARDS"]   ={r=0.5,  g=0.32, b=0.55, },
--          ["STAGGER"]       ={r=0.1,  g=0.98, b=0.72, },

local hbSkinColsDefaults={["AdaptiveCol"]={["RecentHeals"]={["R"]=0.1, ["G"]=1,    ["B"]=0.2,},
                                                ["Threat"]={["R"]=1,   ["G"]=0.49, ["B"]=0.04,},
                                                 ["Aggro"]={["R"]=1,   ["G"]=0,    ["B"]=0,},
                                             ["Highlight"]={["R"]=0.4, ["G"]=1,    ["B"]=1,},
                                                ["Target"]={["R"]=1,   ["G"]=0.9,  ["B"]=0.2,},
                                                   ["OOR"]={["R"]=0,   ["G"]=0,    ["B"]=0.2,},
                                             ["Overheals"]={["R"]=1,   ["G"]=0.2,  ["B"]=0.2,},
                                               ["Absorbs"]={["R"]=1,   ["G"]=1,    ["B"]=1,},
                                          },
}

function HealBot_Skins_ColVarExists(cat, key, c)
    if Healbot_Config_Skins[cat][Healbot_Config_Skins.Current_Skin][key] then
        return Healbot_Config_Skins[cat][Healbot_Config_Skins.Current_Skin][key][c]
    end
    return false
end

function HealBot_Skins_GetColVar(cat, key, c)
    if Healbot_Config_Skins[cat][Healbot_Config_Skins.Current_Skin][key] then
        return Healbot_Config_Skins[cat][Healbot_Config_Skins.Current_Skin][key][c] or hbSkinColsDefaults[cat][key][c]
    end
    return hbSkinColsDefaults[cat][key][c]
end

function HealBot_Skins_SetColVar(value, cat, key, c)
    if hbSkinColsDefaults[cat][key][c] == value then
        HealBot_Skins_NilColVar(cat, key, c)
    else
        if not Healbot_Config_Skins[cat][Healbot_Config_Skins.Current_Skin][key] then Healbot_Config_Skins[cat][Healbot_Config_Skins.Current_Skin][key]={} end
        Healbot_Config_Skins[cat][Healbot_Config_Skins.Current_Skin][key][c]=value
    end
end

function HealBot_Skins_NilColVar(cat, key, c)
    if Healbot_Config_Skins[cat][Healbot_Config_Skins.Current_Skin][key] and Healbot_Config_Skins[cat][Healbot_Config_Skins.Current_Skin][key][c] then
        Healbot_Config_Skins[cat][Healbot_Config_Skins.Current_Skin][key][c]=nil
        HealBot_Util_EmptyTable(Healbot_Config_Skins[cat][Healbot_Config_Skins.Current_Skin], key)
    end
end

local hbSkinDefaults={["Enemy"]={["INCSELF"]=false, ["INCTANKS"]=false, ["INCFOCUS"]=false,
                                 ["INCMYTAR"]=false, ["INCARENA"]=false, ["INCARENAPETS"]=false,
                                 ["SHOWDEBUFFS"]=false, ["SHOWDEBUFFSPLAYERFRAMES"]=false,
                                 ["NUMBOSS"]=8, ["SELFDEBUFFS"]=false, ["SELFDEBUFFSPLAYERFRAMES"]=false,
                                 ["SHOWBUFFS"]=false, ["SHOWBUFFSPLAYERFRAMES"]=false, 
                                 ["SELFBUFFS"]=false, ["SELFBUFFSPLAYERFRAMES"]=false, ["EXISTSHOWGROUP"]=1,
                                 ["EXISTSHOWRAID"]=1, ["EXISTSHOWBOSS"]=false, ["ENEMYTARGET"]=false,
                                 ["TARUSEENEMYCOLS"]=false, ["TOTUSEENEMYCOLS"]=false, ["ENEMYTARGETSIZE"]=0.4,
                                 ["ENEMYTARGETSIZEPLAYERFRAMES"]=0.4, ["PLAYERTARGETSIZE"]=0.5, ["INCOMBATSHOWSELF"]=2,
                                 ["INCOMBATSHOWFOCUS"]=2, ["INCOMBATSHOWTANK"]=2, ["INCOMBATSHOWGROUP"]=2,
                                 ["INCOMBATSHOWRAID"]=2, ["SELFUSEFRAME"]=1, ["PRIVATELISTUSEFRAME"]=1,
                                 ["TANKUSEFRAME"]=1, ["GROUPUSEFRAME"]=1, ["RAIDUSEFRAME"]=1,
                                 ["INCOMBATSHOWLIST"]=2, ["INCOMBATSHOWARENA"]=2, ["EXISTSHOWPTAR"]=1,
                                 ["EXISTSHOWFOCUS"]=1, ["EXISTSHOWARENA"]=2, ["EXISTSHOWMYTAR"]=1, ["EXISTSHOWTANK"]=1,
                                },
                    ["General"]={["HIDEPARTYF"]=false, ["RUNBLIZZEVENTS"]=false, ["HIDEPTF"]=false,
                                 ["HIDEBOSSF"]=false, ["HIDEFOCUSF"]=false, ["STICKYFRAME"]=false,
                                 ["HIDERAIDF"]=true, ["FLUIDBARS"]=false, ["HEALTHDROP"]=false,
                                 ["HEALTHDROPPCT"]=400, ["UNITINCOMBAT"]=2, ["HEALTHDROPCANCEL"]=200,
                                 ["HEALTHDROPTIME"]=3, ["FLUIDFREQ"]=10, ["HOTBARHLTH"]=0,
                                 ["HOTBARDEBUFF"]=1, ["HBDIMMING"]=2.2, ["FOCUSGROUPS"]=1,
                                 ["FGDIMMING"]=2.5, ["HAZARDFREQ"]=0.3, ["HAZARDMINALPHA"]=0.25,
                                 ["GLOBALDIMMING"]=1, ["OFREQ"]=0.2, ["OMIN"]=0.1, ["OMAX"]=0.95,
                                 ["HAZARDFREQ"]=0.3, ["HAZARDMINALPHA"]=0.25,
                                },
}

function HealBot_Skins_VarExists(cat, key)
    return Healbot_Config_Skins[cat][Healbot_Config_Skins.Current_Skin][key]
end

function HealBot_Skins_GetBoolean(cat, key)
    if Healbot_Config_Skins[cat][Healbot_Config_Skins.Current_Skin][key] == false then
        return false
    else
        return Healbot_Config_Skins[cat][Healbot_Config_Skins.Current_Skin][key] or hbSkinDefaults[cat][key]
    end
end

function HealBot_Skins_GetVar(cat, key)
    return Healbot_Config_Skins[cat][Healbot_Config_Skins.Current_Skin][key] or hbSkinDefaults[cat][key]
end

function HealBot_Skins_SetVarSkin(value, skin, cat, key)
    if hbSkinDefaults[cat] and hbSkinDefaults[cat][key] == value then
        HealBot_Skins_NilVar(cat, skin, key)
    else
        Healbot_Config_Skins[cat][skin][key]=value
    end
end

function HealBot_Skins_SetVar(value, cat, key)
    HealBot_Skins_SetVarSkin(value, Healbot_Config_Skins.Current_Skin, cat, key)
end

function HealBot_Skins_NilVar(cat, skin, key)
    Healbot_Config_Skins[cat][skin][key]=nil
end


local hbSkinFrameDefaults={["BarCol"]={["HLTH"]=5, ["BACK"]=1, ["BORDER"]=1,
                                       ["HR"]=0.4, ["HG"]=0.7, ["HB"]=0.7, ["HA"]=1,
                                       ["HIR"]=0.4, ["HIG"]=0.7, ["HIB"]=0.7, 
                                       ["HCR"]=0.4, ["HCG"]=0.7, ["HCB"]=0.7,
                                       ["HCT"]=0.4, ["HIT"]=0.7, ["ORA"]=0.4, ["DISA"]=0.1,
                                       ["BR"]=0.4, ["BG"]=0.7, ["BB"]=0.7, ["BA"]=0,
                                       ["BIR"]=0.4, ["BIG"]=0.7, ["BIB"]=0.7,
                                       ["BCR"]=0.4, ["BCG"]=0.7, ["BCB"]=0.7,
                                       ["BCT"]=0.4, ["BIT"]=0.7, ["BOUT"]=1,
                                       ["BORR"]=0.1, ["BORG"]=0.1, ["BORB"]=0.3, ["BORA"]=1,
                                       ["BORIR"]=0.1, ["BORIG"]=0.1, ["BORIB"]=0.3,
                                       ["BORCR"]=0.1, ["BORCG"]=0.1, ["BORCB"]=0.3,
                                       ["BORCT"]=0.4, ["BORIT"]=0.7, ["BORSIZE"]=2,
                                      },
                       ["Indicators"]={["ACOL"]=1, ["AANCHOR"]=1, ["AVOFF"]=-2, ["AHOFF"]=1, 
                                       ["ASIZE"]=3, ["ASPACE"]=0, ["MCOL"]=1, ["MANCHOR"]=1,
                                       ["MVOFF"]=-2, ["MHOFF"]=0, ["MSIZE"]=3, ["MSPACE"]=1, 
                                       ["SCOL"]=1, ["SANCHOR"]=1, ["SVOFF"]=1, ["SHOFF"]=1,
                                       ["SSIZE"]=4, ["PCOL"]=1, ["PANCHOR"]=2, ["PVOFF"]=0,
                                       ["PHOFF"]=0, ["PSIZE"]=4, ["PSPACE"]=1,
                                      },
                          ["HeadBar"]={["SHOW"]=false, ["WIDTH"]=0.7, ["HEIGHT"]=20,
                                       ["TEXTURE"]=HealBot_Supplied_Textures[10].name,
                                       ["R"]=0.1, ["G"]=0.7, ["B"]=0.1, ["A"]=0.4,
                                      },
                          ["BarSort"]={["RAIDORDER"]=3, ["SUBORDER"]=1, ["OORLAST"]=false, ["SUBPF"]=true,
                                      },
                    ["FrameAliasBar"]={["TEXTURE"]=HealBot_Data_Default_TextureName(),
                                       ["WIDTH"]=0.99, ["HEIGHT"]=14, ["OFFSET"]=-4,
                                       ["R"]=0.102, ["G"]=0.102, ["B"]=0.102, ["A"]=0.7,
                                      },
                          ["Anchors"]={["FRAME"]=1, ["BARS"]=1, ["GROW"]=2, ["RealFixed"]=false,
                                       ["X"]=0, ["Y"]=0, ["RealX"]=nil, ["RealY"]=nil,
                                       ["TOP"]=nil, ["LEFT"]=nil, ["BOTTOM"]=nil, ["RIGHT"]=nil,
                                      },
                         ["BarAggro"]={["ALERT"]=2, ["ALERTIND"]=2, ["TEXTFORMAT"]=3, ["SHOWBARSPCT"]=false,
                                       ["R"]=1, ["G"]=0, ["B"]=0, ["SHOWTEXT"]=1, ["SHOWIND"]=true,
                                       ["SHOWBARS"]=true, ["SHOW"]=true, ["HAZARD"]=true,
                                      },
                            ["Frame"]={["TIPLOC"]=5, ["LOCKED"]=1, ["SCALE"]=1, ["GLOW"]=3, ["PADDING"]=1, 
                                       ["ICONGLOW"]=2, ["AUTOCLOSE"]=1, ["SFOFFSETH"]=0, ["SFOFFSETV"]=0, 
                                       ["BACKR"]=0.2, ["BACKG"]=0.2, ["BACKB"]=0.7, ["BACKA"]=0.1,
                                       ["BORDERR"]=0.2, ["BORDERG"]=0.2, ["BORDERB"]=0.2, ["BORDERA"]=0.4,
                                      },
                       ["BarTextCol"]={["NCR"]=0, ["NCG"]=1, ["NCB"]=0, ["NICR"]=0, ["NICG"]=1, ["NICB"]=0, ["NCCR"]=0, ["NCCG"]=1, ["NCCB"]=0,
                                       ["NIT"]=70, ["NCT"]=40, ["NCA"]=0.95, ["NCDA"]=0.5, ["NDCR"]=1, ["NDCG"]=0.2, ["NDCB"]=0.2, ["NRCR"]=0.2, ["NRCG"]=1, ["NRCB"]=0.2,
                                       ["NSCR"]=0.4, ["NSCG"]=0.02, ["NSCB"]=0.4, ["SCR"]=1, ["SCG"]=1, ["SCB"]=0, ["SCA"]=0.95, ["SICR"]=1, ["SICG"]=1, ["SICB"]=0,
                                       ["SCCR"]=1, ["SCCG"]=1, ["SCCB"]=0, ["SIT"]=70, ["SCT"]=40, ["SCDA"]=0.5, ["SDCR"]=1, ["SDCG"]=0.2, ["SDCB"]=0.2, ["SRCR"]=0.2, ["SRCG"]=1, ["SRCB"]=0.2,
                                       ["SSCR"]=0.4, ["SSCG"]=0.02, ["SSCB"]=0.4, ["NAME"]=2, ["STATE"]=2, ["HECR"]=0, ["HECG"]=1, ["HECB"]=0, ["HCR"]=0, ["HCG"]=1, ["HCB"]=0, ["HCA"]=0.95,
                                       ["HICR"]=0, ["HICG"]=1, ["HICB"]=0, ["HCCR"]=0, ["HCCG"]=1, ["HCCB"]=0, ["HIT"]=70, ["HCT"]=40, ["HCDA"]=0.5, ["OCR"]=0.1, ["OCG"]=1, ["OCB"]=0.1,
                                       ["ICR"]=0.1, ["ICG"]=1, ["ICB"]=0.1, ["ACR"]=1, ["ACG"]=0.1, ["ACB"]=0.1, ["ACA"]=0.95, ["AICR"]=1, ["AICG"]=0.1, ["AICB"]=0.1,
                                       ["ACCR"]=1, ["ACCG"]=0.1, ["ACCB"]=0.1, ["AIT"]=70, ["ACT"]=40, ["ACDA"]=0.5, ["HLTH"]=2, ["AGGRO"]=2,
                                       ["NDEBUFF"]=false, ["HDEBUFF"]=false, ["RIP"]=true, ["RES"]=true, ["SUM"]=false, ["SRIP"]=true, ["SRES"]=true, ["SSUM"]=false,
                                      },
}

function HealBot_Skins_FrameVarExists(cat, key, frame)
    if Healbot_Config_Skins[cat][Healbot_Config_Skins.Current_Skin][frame] then
        return Healbot_Config_Skins[cat][Healbot_Config_Skins.Current_Skin][frame][key]
    end
    return false
end

function HealBot_Skins_GetFrameBoolean(cat, key, frame)
    if Healbot_Config_Skins[cat][Healbot_Config_Skins.Current_Skin][frame] then
        if Healbot_Config_Skins[cat][Healbot_Config_Skins.Current_Skin][frame][key] == false then
            return false
        else
            return Healbot_Config_Skins[cat][Healbot_Config_Skins.Current_Skin][frame][key] or hbSkinFrameDefaults[cat][key]
        end
    end
    return hbSkinFrameDefaults[cat][key]
end

function HealBot_Skins_GetFrameVar(cat, key, frame)
    if Healbot_Config_Skins[cat][Healbot_Config_Skins.Current_Skin][frame] then
        return Healbot_Config_Skins[cat][Healbot_Config_Skins.Current_Skin][frame][key] or hbSkinFrameDefaults[cat][key]
    end
    return hbSkinFrameDefaults[cat][key]
end

function HealBot_Skins_SetFrameVarSkin(value, skin, cat, key, frame)
    if hbSkinFrameDefaults[cat] and hbSkinFrameDefaults[cat][key] == value then
        HealBot_Skins_NilFrameVarSkin(skin, cat, key, frame)
    else
        if not Healbot_Config_Skins[cat][skin][frame] then Healbot_Config_Skins[cat][skin][frame]={} end
        Healbot_Config_Skins[cat][skin][frame][key]=value
    end
end

function HealBot_Skins_SetFrameVar(value, cat, key, frame)
    HealBot_Skins_SetFrameVarSkin(value, Healbot_Config_Skins.Current_Skin, cat, key, frame)
end

function HealBot_Skins_NilFrameVarSkin(skin, cat, key, frame)
    if Healbot_Config_Skins[cat][skin][frame] then
        Healbot_Config_Skins[cat][skin][frame][key]=nil
        HealBot_Util_EmptyTable(Healbot_Config_Skins[cat][skin], frame)
    end
end



local hbSkinIconTextDefaults={["DBDURTHRH"]=9, ["BUFFDURTHRH"]=9, ["DBDURWARN"]=3,
                              ["BUFFDURWARN"]=3, ["DBSCNT"]=true, ["BUFFSCNT"]=true,
                              ["BUFFSSCNT"]=false, ["DBSDUR"]=false, ["BUFFSDUR"]=true, 
                              ["BUFFSSDUR"]=false, ["DBFONT"]=HealBot_Data_Default_FontName(),
                              ["BUFFFONT"]=HealBot_Data_Default_FontName(), ["DBOUTLINE"]=2,
                              ["BUFFOUTLINE"]=2, ["DBHEIGHT"]=9, ["BUFFHEIGHT"]=9,
                             }

function HealBot_Skins_IconTextVarExists(key, frame, set)
    if Healbot_Config_Skins.IconSetsText[Healbot_Config_Skins.Current_Skin][frame] and Healbot_Config_Skins.IconSetsText[Healbot_Config_Skins.Current_Skin][frame][set] then
        return Healbot_Config_Skins.IconSetsText[Healbot_Config_Skins.Current_Skin][frame][set][key]
    end
    return false
end

function HealBot_Skins_GetIconTextBoolean(key, frame, set)
    if Healbot_Config_Skins.IconSetsText[Healbot_Config_Skins.Current_Skin][frame] and Healbot_Config_Skins.IconSetsText[Healbot_Config_Skins.Current_Skin][frame][set] then
        if Healbot_Config_Skins.IconSetsText[Healbot_Config_Skins.Current_Skin][frame][set][key] == false then
            return false
        else
            return Healbot_Config_Skins.IconSetsText[Healbot_Config_Skins.Current_Skin][frame][set][key] or hbSkinIconTextDefaults[key]
        end
    end
    return hbSkinIconTextDefaults[key]
end

function HealBot_Skins_GetIconTextVar(key, frame, set)
    if Healbot_Config_Skins.IconSetsText[Healbot_Config_Skins.Current_Skin][frame] and Healbot_Config_Skins.IconSetsText[Healbot_Config_Skins.Current_Skin][frame][set] then
        return Healbot_Config_Skins.IconSetsText[Healbot_Config_Skins.Current_Skin][frame][set][key] or hbSkinIconTextDefaults[key]
    end
    return hbSkinIconTextDefaults[key]
end

function HealBot_Skins_GetIconTextSkin(key, skin, frame, set)
    if hbSkinIconTextDefaults[key] and type(hbSkinIconTextDefaults[key])=="boolean" then
        if Healbot_Config_Skins.IconSetsText[skin][frame] and Healbot_Config_Skins.IconSetsText[skin][frame][set] then
            if Healbot_Config_Skins.IconSetsText[skin][frame][set][key] == false then
                return false
            else
                return Healbot_Config_Skins.IconSetsText[skin][frame][set][key] or hbSkinIconTextDefaults[key]
            end
        end
    elseif Healbot_Config_Skins.IconSetsText[Healbot_Config_Skins.Current_Skin][frame] and Healbot_Config_Skins.IconSetsText[Healbot_Config_Skins.Current_Skin][frame][set] then
        return Healbot_Config_Skins.IconSetsText[Healbot_Config_Skins.Current_Skin][frame][set][key] or hbSkinIconTextDefaults[key]
    end
    return hbSkinIconTextDefaults[key]
end

function HealBot_Skins_SetIconTextVar(value, key, frame, set)
    if hbSkinIconTextDefaults[key] == value then
        HealBot_Skins_NilIconTextVar(key, frame, set)
    else
        if not Healbot_Config_Skins.IconSetsText[Healbot_Config_Skins.Current_Skin][frame] then Healbot_Config_Skins.IconSetsText[Healbot_Config_Skins.Current_Skin][frame]={} end
        if not Healbot_Config_Skins.IconSetsText[Healbot_Config_Skins.Current_Skin][frame][set] then Healbot_Config_Skins.IconSetsText[Healbot_Config_Skins.Current_Skin][frame][set]={} end
        Healbot_Config_Skins.IconSetsText[Healbot_Config_Skins.Current_Skin][frame][set][key]=value
    end
end

function HealBot_Skins_NilIconTextVar(key, frame, set)
    if Healbot_Config_Skins.IconSetsText[Healbot_Config_Skins.Current_Skin][frame] and Healbot_Config_Skins.IconSetsText[Healbot_Config_Skins.Current_Skin][frame][set] then
        Healbot_Config_Skins.IconSetsText[Healbot_Config_Skins.Current_Skin][frame][set][key]=nil
        HealBot_Util_EmptyTable(Healbot_Config_Skins.IconSetsText[Healbot_Config_Skins.Current_Skin][frame], set)
        if not Healbot_Config_Skins.IconSetsText[Healbot_Config_Skins.Current_Skin][frame][set] then
            HealBot_Util_EmptyTable(Healbot_Config_Skins.IconSetsText[Healbot_Config_Skins.Current_Skin], frame)
        end
    end
end
