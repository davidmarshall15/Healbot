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

local indTextures={ [2]=[[Interface\Addons\HealBot\Images\indicators\indicator_gold]],
                    [3]=[[Interface\Addons\HealBot\Images\indicators\indicator_silver]],
                    [4]=[[Interface\Addons\HealBot\Images\indicators\indicator_white]],
                    [5]=[[Interface\Addons\HealBot\Images\indicators\indicator_yellow]],
                    [6]=[[Interface\Addons\HealBot\Images\indicators\indicator_orange]],
                    [7]=[[Interface\Addons\HealBot\Images\indicators\indicator_pink]],
                    [8]=[[Interface\Addons\HealBot\Images\indicators\indicator_red]],
                    [9]=[[Interface\Addons\HealBot\Images\indicators\indicator_purple]],
                   [10]=[[Interface\Addons\HealBot\Images\indicators\indicator_aqua]],
                   [11]=[[Interface\Addons\HealBot\Images\indicators\indicator_lime]],
                   [12]=[[Interface\Addons\HealBot\Images\indicators\indicator_green]],
                   [13]=[[Interface\Addons\HealBot\Images\indicators\indicator_blue]],
                   [14]=[[Interface\Addons\HealBot\Images\indicators\indicator_brown]],
                   [15]=[[Interface\Addons\HealBot\Images\indicators\indicator_black]],
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
            bWidth=bWidth*(1-hbv_Skins_GetVar("Enemy", "ENEMYTARGETSIZE"))
            bWidth=bWidth-(hbv_Skins_GetFrameVar("HealBar", "CMARGIN", button.frame)+bOutline)
            HealBot_Text_setEnemySizeWidth("EnemySizeWidth1", bWidth, hbv_Skins_GetVar("Enemy", "ENEMYTARGETSIZE"))
            HealBot_Action_SetBackSpecialWidth(button.frame, 0)
        else
            bWidth=bWidth*hbv_Skins_GetVar("Enemy", "ENEMYTARGETSIZE")
            bWidth=bWidth-bOutline
            HealBot_Text_setEnemySizeWidth("EnemySizeWidth2", bWidth, hbv_Skins_GetVar("Enemy", "ENEMYTARGETSIZE"))
            HealBot_Action_SetBackSpecialWidth(button.frame, bWidth+hbv_Skins_GetFrameVar("HealBar", "CMARGIN", button.frame))
        end
    else
        if primary then
            bWidth=bWidth*(1-hbv_Skins_GetVar("Enemy", "ENEMYTARGETSIZEPLAYERFRAMES"))
            bWidth=bWidth-(hbv_Skins_GetFrameVar("HealBar", "CMARGIN", button.frame)+bOutline)
            HealBot_Text_setEnemySizeWidth("EnemySizeWidth1", bWidth, hbv_Skins_GetVar("Enemy", "ENEMYTARGETSIZEPLAYERFRAMES"))
            HealBot_Action_SetBackSpecialWidth(button.frame, 0)
        else
            bWidth=bWidth*hbv_Skins_GetVar("Enemy", "ENEMYTARGETSIZEPLAYERFRAMES")
            bWidth=bWidth-bOutline
            HealBot_Text_setEnemySizeWidth("EnemySizeWidth2", bWidth, hbv_Skins_GetVar("Enemy", "ENEMYTARGETSIZEPLAYERFRAMES"))
            HealBot_Action_SetBackSpecialWidth(button.frame, bWidth+hbv_Skins_GetFrameVar("HealBar", "CMARGIN", button.frame))
        end
    end
end

function HealBot_Skins_ResetSkinWidth(button)
      --HealBot_setCall("HealBot_Skins_ResetSkinWidth", button)
    frameScale=hbv_Skins_GetFrameVar("Frame", "SCALE", button.frame)
    bWidth=ceil(hbv_Skins_GetFrameVar("HealBar", "WIDTH", button.frame)*frameScale);
    bOutline=ceil(hbv_Skins_GetFrameVar("BarCol", "BOUT", button.frame)*frameScale);
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
        if hbv_Aux_GetBarVar("USE", button.frame, x)>1 and
           hbv_Aux_GetOverlayVar("OVERLAP", button.frame) == 2 and
           hbv_Aux_GetBarVar("ANCHOR", button.frame, x)>2 and
           hbv_Aux_GetBarVar("ANCHOR", button.frame, x)<5 then
            auxTmp=auxWidth
            auxWidth=auxWidth+hbv_Aux_GetBarVar("DEPTH", button.frame, x)
            auxWidth=auxWidth+hbv_Aux_GetBarVar("OFFSET", button.frame, x)
            if auxWidth<auxTmp then auxWidth=auxTmp end
        end
    end
    auxWidth=ceil(auxWidth*frameScale)
    for x=1,9 do
        if hbv_Aux_GetBarVar("USE", button.frame, x)>1 then
            if hbv_Aux_GetBarVar("ANCHOR", button.frame, x)<3 or hbv_Aux_GetBarVar("ANCHOR", button.frame, x)>4 then
                if hbv_Aux_GetOverlayVar("OVERLAP", button.frame) == 2 then
                    button.gref.aux[x]:SetWidth(ceil((bWidth+auxWidth)*hbv_Aux_GetBarVar("SIZE", button.frame, x)))
                else
                    button.gref.aux[x]:SetWidth(ceil(bWidth*hbv_Aux_GetBarVar("SIZE", button.frame, x)))
                end
            else
                button.gref.aux[x]:SetWidth(hbv_Aux_GetBarVar("DEPTH", button.frame, x))
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
                if hbv_Skins_GetFrameVar("Indicators", "SANCHOR", b.frame) == 1 then
                    iAnchors["INDSELFCAST"]="TOPLEFT"
                else
                    iAnchors["INDSELFCAST"]="BOTTOMRIGHT"
                end
            elseif position == 2 then
                iAnchors["ICON"]="BOTTOMRIGHT"; iAnchors["BUTTON"]="BOTTOMRIGHT"; iAnchors["DOUBLE"]="TOPRIGHT"; iAnchors["RELATIVE"]="BOTTOMLEFT";
            --    iAnchors["TXTCOUNT"]="TOPLEFT"; iAnchors["TXTEXPIRE"]="BOTTOMRIGHT"; iAnchors["TXTEXPIREX"]=2; iAnchors["TXTCOUNTX"]=-1
                if hbv_Skins_GetFrameVar("Indicators", "SANCHOR", b.frame) == 1 then
                    iAnchors["INDSELFCAST"]="TOPRIGHT"
                else
                    iAnchors["INDSELFCAST"]="BOTTOMLEFT"
                end
            elseif position == 3 then
                iAnchors["ICON"]="TOPLEFT"; iAnchors["BUTTON"]="TOPLEFT"; iAnchors["DOUBLE"]="BOTTOMLEFT"; iAnchors["RELATIVE"]="TOPRIGHT";
            --    iAnchors["TXTCOUNT"]="TOPRIGHT"; iAnchors["TXTEXPIRE"]="BOTTOMLEFT"; iAnchors["TXTEXPIREX"]=-2; iAnchors["TXTCOUNTX"]=2
                if hbv_Skins_GetFrameVar("Indicators", "SANCHOR", b.frame) == 1 then
                    iAnchors["INDSELFCAST"]="TOPLEFT"
                else
                    iAnchors["INDSELFCAST"]="BOTTOMRIGHT"
                end
            elseif position == 4 then
                iAnchors["ICON"]="TOPRIGHT"; iAnchors["BUTTON"]="TOPRIGHT"; iAnchors["DOUBLE"]="BOTTOMRIGHT"; iAnchors["RELATIVE"]="TOPLEFT";
            --    iAnchors["TXTCOUNT"]="TOPLEFT"; iAnchors["TXTEXPIRE"]="BOTTOMRIGHT"; iAnchors["TXTEXPIREX"]=2; iAnchors["TXTCOUNTX"]=-1
                if hbv_Skins_GetFrameVar("Indicators", "SANCHOR", b.frame) == 1 then
                    iAnchors["INDSELFCAST"]="TOPRIGHT"
                else
                    iAnchors["INDSELFCAST"]="BOTTOMLEFT"
                end
            elseif position == 5 then
                iAnchors["ICON"]="BOTTOMRIGHT"; iAnchors["BUTTON"]="BOTTOM"; iAnchors["DOUBLE"]="TOPRIGHT"; iAnchors["RELATIVE"]="BOTTOMLEFT";
            --    iAnchors["TXTCOUNT"]="TOPLEFT"; iAnchors["TXTEXPIRE"]="BOTTOMRIGHT"; iAnchors["TXTEXPIREX"]=2; iAnchors["TXTCOUNTX"]=-1
                if hbv_Skins_GetFrameVar("Indicators", "SANCHOR", b.frame) == 1 then
                    iAnchors["INDSELFCAST"]="TOPRIGHT"
                else
                    iAnchors["INDSELFCAST"]="BOTTOMLEFT"
                end
            elseif position == 6 then
                iAnchors["ICON"]="BOTTOMLEFT"; iAnchors["BUTTON"]="BOTTOM"; iAnchors["DOUBLE"]="TOPLEFT"; iAnchors["RELATIVE"]="BOTTOMRIGHT";
            --    iAnchors["TXTCOUNT"]="TOPRIGHT"; iAnchors["TXTEXPIRE"]="BOTTOMLEFT"; iAnchors["TXTEXPIREX"]=-2; iAnchors["TXTCOUNTX"]=2
                if hbv_Skins_GetFrameVar("Indicators", "SANCHOR", b.frame) == 1 then
                    iAnchors["INDSELFCAST"]="TOPLEFT"
                else
                    iAnchors["INDSELFCAST"]="BOTTOMRIGHT"
                end
            elseif position == 7 then
                iAnchors["ICON"]="TOPRIGHT"; iAnchors["BUTTON"]="TOP"; iAnchors["DOUBLE"]="BOTTOMRIGHT"; iAnchors["RELATIVE"]="TOPLEFT";
            --    iAnchors["TXTCOUNT"]="TOPLEFT"; iAnchors["TXTEXPIRE"]="BOTTOMRIGHT"; iAnchors["TXTEXPIREX"]=2; iAnchors["TXTCOUNTX"]=-1
                if hbv_Skins_GetFrameVar("Indicators", "SANCHOR", b.frame) == 1 then
                    iAnchors["INDSELFCAST"]="TOPRIGHT"
                else
                    iAnchors["INDSELFCAST"]="BOTTOMLEFT"
                end
            else
                iAnchors["ICON"]="TOPLEFT"; iAnchors["BUTTON"]="TOP"; iAnchors["DOUBLE"]="BOTTOMLEFT"; iAnchors["RELATIVE"]="TOPRIGHT";
            --    iAnchors["TXTCOUNT"]="TOPRIGHT"; iAnchors["TXTEXPIRE"]="BOTTOMLEFT"; iAnchors["TXTEXPIREX"]=-2; iAnchors["TXTCOUNTX"]=2
                if hbv_Skins_GetFrameVar("Indicators", "SANCHOR", b.frame) == 1 then
                    iAnchors["INDSELFCAST"]="TOPLEFT"
                else
                    iAnchors["INDSELFCAST"]="BOTTOMRIGHT"
                end
            end
        elseif onBar == 2 then
            if position == 1 then
                iAnchors["ICON"]="BOTTOMRIGHT"; iAnchors["BUTTON"]="BOTTOMLEFT"; iAnchors["DOUBLE"]="TOPRIGHT"; iAnchors["RELATIVE"]="BOTTOMLEFT";
            --    iAnchors["TXTCOUNT"]="TOPLEFT"; iAnchors["TXTEXPIRE"]="BOTTOMRIGHT"; iAnchors["TXTEXPIREX"]=2; iAnchors["TXTCOUNTX"]=-1
                if hbv_Skins_GetFrameVar("Indicators", "SANCHOR", b.frame) == 1 then
                    iAnchors["INDSELFCAST"]="TOPRIGHT"
                else
                    iAnchors["INDSELFCAST"]="BOTTOMLEFT"
                end
            elseif position == 2 then
                iAnchors["ICON"]="BOTTOMLEFT"; iAnchors["BUTTON"]="BOTTOMRIGHT"; iAnchors["DOUBLE"]="TOPLEFT"; iAnchors["RELATIVE"]="BOTTOMRIGHT";
            --    iAnchors["TXTCOUNT"]="TOPRIGHT"; iAnchors["TXTEXPIRE"]="BOTTOMLEFT"; iAnchors["TXTEXPIREX"]=-2; iAnchors["TXTCOUNTX"]=2
                if hbv_Skins_GetFrameVar("Indicators", "SANCHOR", b.frame) == 1 then
                    iAnchors["INDSELFCAST"]="TOPLEFT"
                else
                    iAnchors["INDSELFCAST"]="BOTTOMRIGHT"
                end
            elseif position == 3 then
                iAnchors["ICON"]="TOPRIGHT"; iAnchors["BUTTON"]="TOPLEFT"; iAnchors["DOUBLE"]="BOTTOMRIGHT"; iAnchors["RELATIVE"]="TOPLEFT";
            --    iAnchors["TXTCOUNT"]="TOPLEFT"; iAnchors["TXTEXPIRE"]="BOTTOMRIGHT";  iAnchors["TXTEXPIREX"]=2; iAnchors["TXTCOUNTX"]=-1
                if hbv_Skins_GetFrameVar("Indicators", "SANCHOR", b.frame) == 1 then
                    iAnchors["INDSELFCAST"]="TOPRIGHT"
                else
                    iAnchors["INDSELFCAST"]="BOTTOMLEFT"
                end
            else
                iAnchors["ICON"]="TOPLEFT"; iAnchors["BUTTON"]="TOPRIGHT"; iAnchors["DOUBLE"]="BOTTOMLEFT"; iAnchors["RELATIVE"]="TOPRIGHT";
            --    iAnchors["TXTCOUNT"]="TOPRIGHT"; iAnchors["TXTEXPIRE"]="BOTTOMLEFT"; iAnchors["TXTEXPIREX"]=-2; iAnchors["TXTCOUNTX"]=2
                if hbv_Skins_GetFrameVar("Indicators", "SANCHOR", b.frame) == 1 then
                    iAnchors["INDSELFCAST"]="TOPLEFT"
                else
                    iAnchors["INDSELFCAST"]="BOTTOMRIGHT"
                end
            end
        else
            if position == 1 then
                iAnchors["ICON"]="TOPLEFT"; iAnchors["BUTTON"]="BOTTOMLEFT"; iAnchors["DOUBLE"]="BOTTOMLEFT"; iAnchors["RELATIVE"]="TOPRIGHT";
            --    iAnchors["TXTCOUNT"]="TOPRIGHT"; iAnchors["TXTEXPIRE"]="BOTTOMLEFT"; iAnchors["TXTEXPIREX"]=-2; iAnchors["TXTCOUNTX"]=2
                if hbv_Skins_GetFrameVar("Indicators", "SANCHOR", b.frame) == 1 then
                    iAnchors["INDSELFCAST"]="TOPLEFT"
                else
                    iAnchors["INDSELFCAST"]="BOTTOMRIGHT"
                end
            else
                iAnchors["ICON"]="TOPRIGHT"; iAnchors["BUTTON"]="BOTTOMRIGHT"; iAnchors["DOUBLE"]="BOTTOMRIGHT"; iAnchors["RELATIVE"]="TOPLEFT";
            --    iAnchors["TXTCOUNT"]="TOPLEFT"; iAnchors["TXTEXPIRE"]="BOTTOMRIGHT"; iAnchors["TXTEXPIREX"]=2; iAnchors["TXTCOUNTX"]=-1
                if hbv_Skins_GetFrameVar("Indicators", "SANCHOR", b.frame) == 1 then
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
    return ceil(indOffset*hbv_Skins_GetFrameVar("Frame", "SCALE", frame))
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
    if hbv_Skins_GetIconBoolean("BUFFDOUBLE", b.frame, set) then
        iScale=floor(((bheight*hbv_Skins_GetIconVar("BSCALE", b.frame, set))-2)*0.485)
    else
        iScale=(bheight*hbv_Skins_GetIconVar("BSCALE", b.frame, set))-2
    end
    iZoom=hbv_Skins_GetIconVar("BZOOM", b.frame, set)
    b.gref.icon[id]:SetHeight(iScale);
    b.gref.icon[id]:SetWidth(iScale);
    b.gref.icon[id]:SetTexCoord(iZoom,1-iZoom,iZoom,1-iZoom)
    HealBot_Media_UpdateFont(b.gref.txt.expire[id],
                             hbv_Skins_GetIconTextVar("BUFFFONT", b.frame, set),
                             hbv_Skins_GetIconTextVar("BUFFHEIGHT", b.frame, set),
                             hbv_Skins_GetIconTextVar("BUFFOUTLINE", b.frame, set),
                             "Skins_ResetSkin - IconSetsText")
    HealBot_Media_UpdateFont(b.gref.txt.count[id],
                             hbv_Skins_GetIconTextVar("BUFFFONT", b.frame, set),
                             hbv_Skins_GetIconTextVar("BUFFHEIGHT", b.frame, set),
                             hbv_Skins_GetIconTextVar("BUFFOUTLINE", b.frame, set),
                             "Skins_ResetSkin - IconSetsText")
    b.gref.iconf[id]:SetHeight(iScale)
    b.gref.iconf[id]:SetWidth(iScale)
    HealBot_Skins_UpdateIconGlowSize(b, id)
end

function HealBot_Skins_UpdateDebuffIcon(b, id, set)
    if hbv_Skins_GetIconBoolean("DEBUFFDOUBLE", b.frame, set) then
        iScale=floor(((bheight*hbv_Skins_GetIconVar("DSCALE", b.frame, set))-2)*0.485)
    else
        iScale=(bheight*hbv_Skins_GetIconVar("DSCALE", b.frame, set))-2
    end
    iZoom=hbv_Skins_GetIconVar("DZOOM", b.frame, set)
    b.gref.icon[id]:SetHeight(iScale);
    b.gref.icon[id]:SetWidth(iScale);
    b.gref.icon[id]:SetTexCoord(iZoom,1-iZoom,iZoom,1-iZoom)
    HealBot_Media_UpdateFont(b.gref.txt.expire[id],
                             hbv_Skins_GetIconTextVar("DBFONT", b.frame, set),
                             hbv_Skins_GetIconTextVar("DBHEIGHT", b.frame, set),
                             hbv_Skins_GetIconTextVar("DBOUTLINE", b.frame, set),
                             "Skins_ResetSkin - IconSetsText")
    HealBot_Media_UpdateFont(b.gref.txt.count[id],
                             hbv_Skins_GetIconTextVar("DBFONT", b.frame, set),
                             hbv_Skins_GetIconTextVar("DBHEIGHT", b.frame, set),
                             hbv_Skins_GetIconTextVar("DBOUTLINE", b.frame, set),
                             "Skins_ResetSkin - IconSetsText")
    b.gref.iconf[id]:SetHeight(iScale)
    b.gref.iconf[id]:SetWidth(iScale)
    HealBot_Skins_UpdateIconGlowSize(b, id)
end

local tmpHeightOffset=0
function HealBot_Skins_ResetSkin(barType,button,numcols)
      --HealBot_setCall("HealBot_Skins_Check", button)
    if button and button.frame then
        frameScale=hbv_Skins_GetFrameVar("Frame", "SCALE", button.frame)
        framePad=hbv_Skins_GetFrameVar("Frame", "PADDING", button.frame)
        bheight=ceil(hbv_Skins_GetFrameVar("HealBar", "HEIGHT", button.frame)*frameScale);
        bWidth=ceil(hbv_Skins_GetFrameVar("HealBar", "WIDTH", button.frame)*frameScale);
        bOutline=ceil(hbv_Skins_GetFrameVar("BarCol", "BOUT", button.frame)*frameScale);
        btextheight=ceil(hbv_Skins_GetFrameVar("BarText", "HEIGHT", button.frame)*frameScale);
        btextheight2=ceil(hbv_Skins_GetFrameVar("BarText", "HHEIGHT", button.frame)*frameScale)
        btextheight3=ceil(hbv_Skins_GetFrameVar("BarText", "SHEIGHT", button.frame)*frameScale)
        btextheight4=ceil(hbv_Skins_GetFrameVar("BarText", "AHEIGHT", button.frame)*frameScale)
        btextoutline=hbv_Skins_GetFrameVar("BarText", "OUTLINE", button.frame)
        btextoutline2=hbv_Skins_GetFrameVar("BarText", "HOUTLINE", button.frame)
        btextoutline3=hbv_Skins_GetFrameVar("BarText", "SOUTLINE", button.frame)
        btextoutline4=hbv_Skins_GetFrameVar("BarText", "AOUTLINE", button.frame)
        auxHeight=0
        auxWidth=0
        auxOffsetBelow=0
        auxOffsetLeft=0
        auxOffsetRight=0

        for x=1,9 do
            if hbv_Aux_GetBarVar("USE", button.frame, x)>1 then
                --if hbv_Aux_GetBarVar("ANCHOR", button.framecol, x) == 9 then
                --    button.aux[x].sticky=true
                --else
                --    button.aux[x].sticky=false
                    if hbv_Aux_GetBarVar("DEPTH", button.frame, x)+hbv_Aux_GetBarVar("OFFSET", button.frame, x)>0 then
                        auxTmp=hbv_Aux_GetBarVar("DEPTH", button.frame, x)+hbv_Aux_GetBarVar("OFFSET", button.frame, x)
                    else
                        auxTmp=0
                    end
                    if hbv_Aux_GetBarVar("ANCHOR", button.frame, x)<3 or hbv_Aux_GetBarVar("ANCHOR", button.frame, x)>4 then
                        if hbv_Aux_GetBarVar("ANCHOR", button.frame, x) == 1 or
                           hbv_Aux_GetBarVar("ANCHOR", button.frame, x) == 5 or
                           hbv_Aux_GetBarVar("ANCHOR", button.frame, x) == 6 then
                            auxOffsetBelow=auxOffsetBelow+auxTmp
                        end
                        auxHeight=auxHeight+auxTmp
                    else
                        if hbv_Aux_GetBarVar("ANCHOR", button.frame, x) == 3 then
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
            bWidth=ceil(bWidth*hbv_Skins_GetVar("Enemy", "PLAYERTARGETSIZE"))
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
                pWidth=ceil(zWidth*hbv_Skins_GetVar("Enemy", "PLAYERTARGETSIZE"))
                pWidth=pWidth+(bOutline*2)+auxWidth+hbv_Skins_GetFrameVar("HealBar", "CMARGIN", b.frame)
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
            if bWidth > 100 then
                button.gref["Shield"]:SetWidth(10)
            elseif bWidth < 50 then
                button.gref["Shield"]:SetWidth(5)
            else
                button.gref["Shield"]:SetWidth(ceil(bWidth/10))
            end
            b.gref["Back"]:SetHeight(bheight+auxHeight+(bOutline*2))
            b.gref["Back"]:SetWidth(bWidth+auxWidth+(bOutline*2))
            b.gref["InHeal"]:SetHeight(bheight);
            b.gref["InHeal"]:SetWidth(bWidth)
            b.gref["Absorb"]:SetHeight(bheight);
            b.gref["Absorb"]:SetWidth(bWidth)

            HealBot_Media_UpdateTexture(b.gref["InHeal"], hbv_Skins_GetFrameVar("HealBar", "TEXTURE", b.frame), "Skins_ResetSkin - HealBar")
            b.gref["InHeal"]:GetStatusBarTexture():SetHorizTile(false)
            HealBot_Media_UpdateTexture(b.gref["Absorb"], hbv_Skins_GetFrameVar("HealBar", "TEXTURE", b.frame), "Skins_ResetSkin - HealBar")
            b.gref["Absorb"]:GetStatusBarTexture():SetHorizTile(false)

            if hbv_Skins_GetFrameVar("HealBar", "OFIX", b.frame) == 1 then
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
            if b.frame<10 and hbv_Skins_GetFrameBoolean("Emerg", "USE", b.frame) then
                erButton.bar:SetHeight(ceil(bheight*hbv_Skins_GetFrameVar("Emerg", "HEIGHT", b.frame)))
                erButton.bar:SetWidth(ceil(bWidth*hbv_Skins_GetFrameVar("Emerg", "WIDTH", b.frame)))
                erButton:SetHeight(ceil(bheight*hbv_Skins_GetFrameVar("Emerg", "HEIGHT", b.frame)))
                erButton:SetWidth(ceil(bWidth*hbv_Skins_GetFrameVar("Emerg", "WIDTH", b.frame)))
                HealBot_Media_UpdateTexture(erButton.bar, hbv_Skins_GetFrameVar("Emerg", "TEXTURE", b.frame), "Skins_ResetSkin - Emerg")
                erButton.bar:GetStatusBarTexture():SetHorizTile(false)
                erButton:ClearAllPoints()
                erButton:SetPoint(HealBot_Skins_setEmergAnchor(hbv_Skins_GetFrameVar("Emerg", "ANCHOR", b.frame)),
                                 b.gref["Back"],
                                 HealBot_Skins_setEmergAnchor(hbv_Skins_GetFrameVar("Emerg", "ANCHOR", b.frame)),
                                 ceil(hbv_Skins_GetFrameVar("Emerg", "HOFFSET", b.frame)*frameScale),
                                 ceil(hbv_Skins_GetFrameVar("Emerg", "VOFFSET", b.frame)*frameScale))
                erButton.bar:ClearAllPoints()
                erButton.bar:SetPoint(HealBot_Skins_setEmergAnchor(hbv_Skins_GetFrameVar("Emerg", "ANCHOR", b.frame)),
                                     b.gref["Back"],
                                     HealBot_Skins_setEmergAnchor(hbv_Skins_GetFrameVar("Emerg", "ANCHOR", b.frame)),
                                     ceil(hbv_Skins_GetFrameVar("Emerg", "HOFFSET", b.frame)*frameScale),
                                     ceil(hbv_Skins_GetFrameVar("Emerg", "VOFFSET", b.frame)*frameScale))
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

			-- bgFile="Interface\\Addons\\HealBot\\Images\\frame\\WhiteLine.tga",
			-- edgeFile="Interface\\Addons\\HealBot\\Images\\frame\\border.tga",
            -- edgeFile="Interface\\Buttons\\WHITE8X8",

            tBarsConcat[1]="f"
            tBarsConcat[2]=b.frame
            tBarsConcat[3]="_HealBot_Action"
            local gaf=_G[HealBot_Skins_Concat(3)]
            HealBot_Media_UpdateTexture(b.gref["Bar"], hbv_Skins_GetFrameVar("HealBar", "TEXTURE", b.frame), "Skins_ResetSkin - HealBar")
            b.gref["Bar"]:GetStatusBarTexture():SetHorizTile(false)
            b.gref["Bar"]:ClearAllPoints()
            b.gref["Bar"]:SetPoint("BOTTOMLEFT",b.gref["Back"],"BOTTOMLEFT",auxOffsetLeft+bOutline,auxOffsetBelow+bOutline)
            button.gref["Shield"]:ClearAllPoints()
            if bheight > 35 then
                button.gref["Shield"]:SetPoint("TOPRIGHT", button.gref["Bar"], "TOPRIGHT",0,0)
                button.gref["Shield"]:SetPoint("BOTTOMRIGHT", button.gref["Bar"], "BOTTOMRIGHT",0,1)
            else
                button.gref["Shield"]:SetPoint("TOPRIGHT", button.gref["Bar"], "TOPRIGHT",0,0)
                button.gref["Shield"]:SetPoint("BOTTOMRIGHT", button.gref["Bar"], "BOTTOMRIGHT",0,0)
            end
            if b.gref["BackBorder"].size~=ceil(hbv_Skins_GetFrameVar("BarCol", "BORSIZE", b.frame)*frameScale) then
                b.gref["BackBorder"].size=ceil(hbv_Skins_GetFrameVar("BarCol", "BORSIZE", b.frame)*frameScale)
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
                if hbv_Aux_GetBarVar("USE", button.frame, x)>1 then
                    b.gref.aux[x]:ClearAllPoints()
                    if button.aux[x].sticky then
                        b.gref.aux[x]:SetOrientation("VERTICAL")
                        b.gref.aux[x]:SetHeight(ceil(bheight*hbv_Aux_GetBarVar("SIZE", button.frame, x)))
                        if hbv_Skins_GetFrameVar("Anchors", "BARS", button.frame)<3 then
                            b.gref.aux[x]:SetPoint("RIGHT",b.gref["Back"],"RIGHT",0,0)
                        else
                            b.gref.aux[x]:SetPoint("LEFT",b.gref["Back"],"LEFT",0,0)
                        end
                    elseif hbv_Aux_GetBarVar("ANCHOR", button.frame, x)<5 then
                        if hbv_Aux_GetBarVar("ANCHOR", button.frame, x)<3 then
                            b.gref.aux[x]:SetOrientation("HORIZONTAL")
                            if hbv_Aux_GetOverlayVar("OVERLAP", button.frame) == 2 then
                                b.gref.aux[x]:SetWidth(ceil((bWidth+auxWidth)*hbv_Aux_GetBarVar("SIZE", button.frame, x)))
                              --  AuxOverlapOffset=ceil(((bWidth+auxWidth)*(1-hbv_Aux_GetBarVar("SIZE", button.frame, x)))/2)
                            else
                                b.gref.aux[x]:SetWidth(ceil(bWidth*hbv_Aux_GetBarVar("SIZE", button.frame, x)))
                            end
                            b.gref.aux[x]:SetHeight(ceil(hbv_Aux_GetBarVar("DEPTH", button.frame, x)*frameScale))
                            if hbv_Aux_GetBarVar("ANCHOR", button.frame, x) == 1 then
                                b.gref.aux[x]:SetPoint("TOP",AuxBelow,"BOTTOM",0,-(ceil(hbv_Aux_GetBarVar("OFFSET", button.frame, x))*frameScale))
                                AuxBelow=b.gref.aux[x]
                            else
                                b.gref.aux[x]:SetPoint("BOTTOM",AuxAbove,"TOP",0,ceil(hbv_Aux_GetBarVar("OFFSET", button.frame, x)*frameScale))
                                AuxAbove=b.gref.aux[x]
                            end
                            --if hbv_Aux_GetOverlayVar("OVERLAP", button.frame) == 2 then
                            --    b.gref.aux[x]:SetPoint("RIGHT",b.gref["Back"],"RIGHT",-(bOutline+AuxOverlapOffset),0)
                            --else
                            --    b.gref.aux[x]:SetPoint("CENTER",b.gref["Bar"],"CENTER",0,0)
                            --end
                        else
                            b.gref.aux[x]:SetOrientation("VERTICAL")
                            b.gref.aux[x]:SetWidth(ceil(hbv_Aux_GetBarVar("DEPTH", button.frame, x)*frameScale))
                            if hbv_Aux_GetOverlayVar("OVERLAP", button.frame) == 1 then
                                b.gref.aux[x]:SetHeight(ceil((bheight+auxHeight)*hbv_Aux_GetBarVar("SIZE", button.frame, x)))
                                --b.gref.aux[x]:SetPoint("TOP",b.gref["Back"],"TOP",0,-(bOutline))
                            else
                                b.gref.aux[x]:SetHeight(ceil(bheight*hbv_Aux_GetBarVar("SIZE", button.frame, x)))
                            end
                            if hbv_Aux_GetBarVar("ANCHOR", button.frame, x) == 3 then
                                b.gref.aux[x]:SetPoint("RIGHT",AuxLeft,"LEFT",-(ceil(hbv_Aux_GetBarVar("OFFSET", button.frame, x)*frameScale)),0)
                                AuxLeft=b.gref.aux[x]
                            else
                                b.gref.aux[x]:SetPoint("LEFT",AuxRight,"RIGHT",ceil(hbv_Aux_GetBarVar("OFFSET", button.frame, x)*frameScale),0)
                                AuxRight=b.gref.aux[x]
                            end
                        end
                    else
                        b.gref.aux[x]:SetOrientation("HORIZONTAL")
                        if hbv_Aux_GetOverlayVar("OVERLAP", button.frame) == 2 then
                            b.gref.aux[x]:SetWidth(ceil((bWidth+auxWidth)*hbv_Aux_GetBarVar("SIZE", button.frame, x)))
                        else
                            b.gref.aux[x]:SetWidth(ceil(bWidth*hbv_Aux_GetBarVar("SIZE", button.frame, x)))
                        end
                        b.gref.aux[x]:SetHeight(ceil(hbv_Aux_GetBarVar("DEPTH", button.frame, x)*frameScale))
                        if hbv_Aux_GetBarVar("ANCHOR", button.frame, x) == 5 then
                            b.gref.aux[x]:SetPoint("TOP",AuxBelow,"BOTTOM",0,-(ceil(hbv_Aux_GetBarVar("OFFSET", button.frame, x))*frameScale))
                            if hbv_Aux_GetOverlayVar("OVERLAP", button.frame) == 2 then
                                b.gref.aux[x]:SetPoint("LEFT",b.gref["Bar"],"LEFT",-auxOffsetLeft,0)
                            else
                                b.gref.aux[x]:SetPoint("LEFT",b.gref["Bar"],"LEFT",0,0)
                            end
                            AuxBelow=b.gref.aux[x]
                        elseif hbv_Aux_GetBarVar("ANCHOR", button.frame, x) == 6 then
                            b.gref.aux[x]:SetPoint("TOP",AuxBelow,"BOTTOM",0,-(ceil(hbv_Aux_GetBarVar("OFFSET", button.frame, x))*frameScale))
                            if hbv_Aux_GetOverlayVar("OVERLAP", button.frame) == 2 then
                                b.gref.aux[x]:SetPoint("RIGHT",b.gref["Bar"],"RIGHT",auxOffsetRight,0)
                            else
                                b.gref.aux[x]:SetPoint("RIGHT",b.gref["Bar"],"RIGHT",0,0)
                            end
                            AuxBelow=b.gref.aux[x]
                        elseif hbv_Aux_GetBarVar("ANCHOR", button.frame, x) == 7 then
                            b.gref.aux[x]:SetPoint("BOTTOM",AuxAbove,"TOP",0,ceil(hbv_Aux_GetBarVar("OFFSET", button.frame, x)*frameScale))
                            if hbv_Aux_GetOverlayVar("OVERLAP", button.frame) == 2 then
                                b.gref.aux[x]:SetPoint("LEFT",b.gref["Bar"],"LEFT",-auxOffsetLeft,0)
                            else
                                b.gref.aux[x]:SetPoint("LEFT",b.gref["Bar"],"LEFT",0,0)
                            end
                            AuxAbove=b.gref.aux[x]
                        else
                            b.gref.aux[x]:SetPoint("BOTTOM",AuxAbove,"TOP",0,ceil(hbv_Aux_GetBarVar("OFFSET", button.frame, x)*frameScale))
                            if hbv_Aux_GetOverlayVar("OVERLAP", button.frame) == 2 then
                                b.gref.aux[x]:SetPoint("RIGHT",b.gref["Bar"],"RIGHT",auxOffsetRight,0)
                            else
                                b.gref.aux[x]:SetPoint("RIGHT",b.gref["Bar"],"RIGHT",0,0)
                            end
                            AuxAbove=b.gref.aux[x]
                        end
                    end
                    b.gref.aux[x]:SetMinMaxValues(0,1000)
                    HealBot_Media_UpdateTexture(b.gref.aux[x], hbv_Skins_GetFrameVar("HealBar", "TEXTURE", b.frame), "Skins_ResetSkin - HealBar")
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
                                     hbv_Skins_GetFrameVar("BarText", "FONT", b.framecol),
                                     btextheight,
                                     btextoutline,
                                     "Skins_ResetSkin - BarText")
            HealBot_Media_UpdateFont(b.gref.txt["text2"],
                                     hbv_Skins_GetFrameVar("BarText", "HFONT", b.framecol),
                                     btextheight2,
                                     btextoutline2,
                                     "Skins_ResetSkin - BarText")
            HealBot_Media_UpdateFont(b.gref.txt["text3"],
                                     hbv_Skins_GetFrameVar("BarText", "SFONT", b.framecol),
                                     btextheight3,
                                     btextoutline3,
                                     "Skins_ResetSkin - BarText")
            HealBot_Media_UpdateFont(b.gref.txt["text4"],
                                     hbv_Skins_GetFrameVar("BarText", "AFONT", b.framecol),
                                     btextheight4,
                                     btextoutline4,
                                     "Skins_ResetSkin - BarText")
            if btextheight2-HealBot_Globals.VehicleFontSizeReduction<2 then
                HealBot_Media_UpdateFont(b.gref.txt["text5"],
                                         hbv_Skins_GetFrameVar("BarText", "HFONT", b.framecol),
                                         2,
                                         btextoutline2,
                                         "Skins_ResetSkin - BarText")
            else
                HealBot_Media_UpdateFont(b.gref.txt["text5"],
                                         hbv_Skins_GetFrameVar("BarText", "HFONT", b.framecol),
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
                                         hbv_Aux_GetBarTextVar("FONT", b.framecol, x),
                                         ceil(hbv_Aux_GetBarTextVar("HEIGHT", b.framecol, x)*frameScale),
                                         hbv_Aux_GetBarTextVar("OUTLINE", b.framecol, x),
                                         "Skins_ResetSkin - AuxBarText")
                b.gref.auxtxt[x]:ClearAllPoints();
                b.gref.auxtxt[x]:SetWidth(ceil((zWidth+auxWidth)*hbv_Aux_GetBarVar("SIZE", b.frame, x)))
                if hbv_Aux_GetBarVar("ANCHOR", b.frame, x)<3 or hbv_Aux_GetBarVar("ANCHOR", b.frame, x)>4 then
                    b.gref.auxtxt[x]:SetWordWrap(false)
                else
                    b.gref.auxtxt[x]:SetWordWrap(true)
                end
                if hbv_Aux_GetBarTextVar("ALIGN", b.framecol, x) == 1 then
                    b.gref.auxtxt[x]:SetPoint("LEFT",b.gref.aux[x],"LEFT",ceil(hbv_Aux_GetBarTextVar("HOFFSET", b.framecol, x)*frameScale),ceil(hbv_Aux_GetBarTextVar("OFFSET", b.framecol, x)*frameScale))
                    b.gref.auxtxt[x]:SetJustifyH("LEFT")
                elseif hbv_Aux_GetBarTextVar("ALIGN", b.framecol, x) == 2 then
                    b.gref.auxtxt[x]:SetPoint("CENTER",b.gref.aux[x],"CENTER",ceil(hbv_Aux_GetBarTextVar("HOFFSET", b.framecol, x)*frameScale),ceil(hbv_Aux_GetBarTextVar("OFFSET", b.framecol, x)*frameScale))
                    b.gref.auxtxt[x]:SetJustifyH("CENTER")
                else
                    b.gref.auxtxt[x]:SetPoint("RIGHT",b.gref.aux[x],"RIGHT",ceil(hbv_Aux_GetBarTextVar("HOFFSET", b.framecol, x)*frameScale),ceil(hbv_Aux_GetBarTextVar("OFFSET", b.framecol, x)*frameScale))
                    b.gref.auxtxt[x]:SetJustifyH("RIGHT")
                end
            end
            b.gref.txt["text"]:ClearAllPoints();
            b.gref.txt["text2"]:ClearAllPoints();
            b.gref.txt["text3"]:ClearAllPoints();
            b.gref.txt["text4"]:ClearAllPoints();
            b.gref.txt["text5"]:ClearAllPoints();

            if hbv_Skins_GetFrameVar("BarText", "ALIGN", b.framecol) == 1 then
                b.gref.txt["text"]:SetPoint("LEFT",b.gref["Bar"],"LEFT",ceil(hbv_Skins_GetFrameVar("BarText", "OFFSET2", b.framecol)*frameScale),ceil((5+hbv_Skins_GetFrameVar("BarText", "OFFSET", b.framecol))*frameScale))
                b.gref.txt["text"]:SetJustifyH("LEFT")
            elseif hbv_Skins_GetFrameVar("BarText", "ALIGN", b.framecol) == 2 then
                b.gref.txt["text"]:SetPoint("CENTER",b.gref["Bar"],"CENTER",ceil(hbv_Skins_GetFrameVar("BarText", "OFFSET2", b.framecol)*frameScale),ceil((5+hbv_Skins_GetFrameVar("BarText", "OFFSET", b.framecol))*frameScale))
                b.gref.txt["text"]:SetJustifyH("CENTER")
            else
                b.gref.txt["text"]:SetPoint("RIGHT",b.gref["Bar"],"RIGHT",ceil(hbv_Skins_GetFrameVar("BarText", "OFFSET2", b.framecol)*frameScale),ceil((5+hbv_Skins_GetFrameVar("BarText", "OFFSET", b.framecol))*frameScale))
                b.gref.txt["text"]:SetJustifyH("RIGHT")
            end
            if hbv_Skins_GetFrameVar("BarText", "HLTHTXTANCHOR", b.framecol)<4 then
                if hbv_Skins_GetFrameVar("BarText", "HLTHTXTANCHOR", b.framecol) == 1 then
                b.gref.txt["text2"]:SetPoint("LEFT",b.gref["Bar"],"LEFT",ceil(hbv_Skins_GetFrameVar("BarText", "HOFFSET2", b.framecol)*frameScale),ceil((-7+hbv_Skins_GetFrameVar("BarText", "HOFFSET", b.framecol))*frameScale))
                    b.gref.txt["text2"]:SetJustifyH("LEFT")
                elseif hbv_Skins_GetFrameVar("BarText", "HLTHTXTANCHOR", b.framecol) == 2 then
                b.gref.txt["text2"]:SetPoint("CENTER",b.gref["Bar"],"CENTER",ceil(hbv_Skins_GetFrameVar("BarText", "HOFFSET2", b.framecol)*frameScale),ceil((-7+hbv_Skins_GetFrameVar("BarText", "HOFFSET", b.framecol))*frameScale))
                    b.gref.txt["text2"]:SetJustifyH("CENTER")
                else
                b.gref.txt["text2"]:SetPoint("RIGHT",b.gref["Bar"],"RIGHT",ceil(hbv_Skins_GetFrameVar("BarText", "HOFFSET2", b.framecol)*frameScale),ceil((-7+hbv_Skins_GetFrameVar("BarText", "HOFFSET", b.framecol))*frameScale))
                    b.gref.txt["text2"]:SetJustifyH("RIGHT")
                end
            elseif hbv_Skins_GetFrameVar("BarText", "HLTHTXTANCHOR", b.framecol)>4 then
                b.gref.txt["text2"]:SetPoint("TOP",b.gref.txt["text"],"BOTTOM",ceil(hbv_Skins_GetFrameVar("BarText", "HOFFSET2", b.framecol)*frameScale),ceil((-2+hbv_Skins_GetFrameVar("BarText", "HOFFSET", b.framecol))*frameScale))
                b.gref.txt["text2"]:SetJustifyH(b.gref.txt["text"]:GetJustifyH())
            end
            b.gref.txt["text5"]:SetPoint("TOP",b.gref.txt["text2"],"BOTTOM")
            if hbv_Skins_GetFrameVar("BarText", "STATETXTANCHOR", b.framecol)<4 then
                if hbv_Skins_GetFrameVar("BarText", "STATETXTANCHOR", b.framecol) == 1 then
                b.gref.txt["text3"]:SetPoint("TOPLEFT",b.gref["Bar"],"TOPLEFT",ceil(hbv_Skins_GetFrameVar("BarText", "SOFFSET2", b.framecol)*frameScale),ceil((-2+hbv_Skins_GetFrameVar("BarText", "SOFFSET", b.framecol))*frameScale))
                    b.gref.txt["text3"]:SetJustifyH("LEFT")
                elseif hbv_Skins_GetFrameVar("BarText", "STATETXTANCHOR", b.framecol) == 2 then
                b.gref.txt["text3"]:SetPoint("TOP",b.gref["Bar"],"TOP",ceil(hbv_Skins_GetFrameVar("BarText", "SOFFSET2", b.framecol)*frameScale),ceil((-2+hbv_Skins_GetFrameVar("BarText", "SOFFSET", b.framecol))*frameScale))
                    b.gref.txt["text3"]:SetJustifyH("CENTER")
                else
                b.gref.txt["text3"]:SetPoint("TOPRIGHT",b.gref["Bar"],"TOPRIGHT",ceil(hbv_Skins_GetFrameVar("BarText", "SOFFSET2", b.framecol)*frameScale),ceil((-2+hbv_Skins_GetFrameVar("BarText", "SOFFSET", b.framecol))*frameScale))
                    b.gref.txt["text3"]:SetJustifyH("RIGHT")
                end
            elseif hbv_Skins_GetFrameVar("BarText", "STATETXTANCHOR", b.framecol) == 5 then
                b.gref.txt["text3"]:SetPoint("BOTTOM",b.gref.txt["text"],"TOP",ceil(hbv_Skins_GetFrameVar("BarText", "SOFFSET2", b.framecol)*frameScale),ceil((0+hbv_Skins_GetFrameVar("BarText", "SOFFSET", b.framecol))*frameScale))
                b.gref.txt["text3"]:SetJustifyH(b.gref.txt["text"]:GetJustifyH())
            end
            if hbv_Skins_GetFrameVar("BarText", "AGGROTXTANCHOR", b.framecol)<4 then
                if hbv_Skins_GetFrameVar("BarText", "AGGROTXTANCHOR", b.framecol) == 1 then
                b.gref.txt["text4"]:SetPoint("TOPLEFT",b.gref["Bar"],"TOPLEFT",ceil(hbv_Skins_GetFrameVar("BarText", "AOFFSET2", b.framecol)*frameScale),ceil((-2+hbv_Skins_GetFrameVar("BarText", "AOFFSET", b.framecol))*frameScale))
                    b.gref.txt["text4"]:SetJustifyH("LEFT")
                elseif hbv_Skins_GetFrameVar("BarText", "AGGROTXTANCHOR", b.framecol) == 2 then
                b.gref.txt["text4"]:SetPoint("TOP",b.gref["Bar"],"TOP",ceil(hbv_Skins_GetFrameVar("BarText", "AOFFSET2", b.framecol)*frameScale),ceil((-2+hbv_Skins_GetFrameVar("BarText", "AOFFSET", b.framecol))*frameScale))
                    b.gref.txt["text4"]:SetJustifyH("CENTER")
                else
                b.gref.txt["text4"]:SetPoint("TOPRIGHT",b.gref["Bar"],"TOPRIGHT",ceil(hbv_Skins_GetFrameVar("BarText", "AOFFSET2", b.framecol)*frameScale),ceil((-2+hbv_Skins_GetFrameVar("BarText", "AOFFSET", b.framecol))*frameScale))
                    b.gref.txt["text4"]:SetJustifyH("RIGHT")
                end
            elseif hbv_Skins_GetFrameVar("BarText", "AGGROTXTANCHOR", b.framecol) == 4 then
                b.gref.txt["text4"]:SetPoint("BOTTOM",b.gref.txt["text"],"TOP",ceil(hbv_Skins_GetFrameVar("BarText", "AOFFSET2", b.framecol)*frameScale),ceil((0+hbv_Skins_GetFrameVar("BarText", "AOFFSET", b.framecol))*frameScale))
                b.gref.txt["text4"]:SetJustifyH(b.gref.txt["text"]:GetJustifyH())
            else
                b.gref.txt["text4"]:SetPoint("TOP",b.gref.txt["text"],"BOTTOM",ceil(hbv_Skins_GetFrameVar("BarText", "AOFFSET2", b.framecol)*frameScale),ceil((0+hbv_Skins_GetFrameVar("BarText", "AOFFSET", b.framecol))*frameScale))
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
            HealBot_Skins_setIconAnchors(hbv_Skins_GetIconVar("BUFFONBAR", b.frame, 1),
                                         hbv_Skins_GetIconVar("BUFFANCHOR", b.frame, 1))
            HealBot_Skins_setIconSpacer(hbv_Skins_GetIconVar("BUFFANCHOR", b.frame, 1),
                                        hbv_Skins_GetIconVar("BICONSPACER", b.frame, 1))

            b.gref.icon[1]:ClearAllPoints();
            b.gref.icon[1]:SetPoint(iAnchors["ICON"],b,iAnchors["BUTTON"],
                                    ceil(hbv_Skins_GetIconVar("BHOFFSET", b.frame, 1)*frameScale),
                                    ceil(hbv_Skins_GetIconVar("BVOFFSET", b.frame, 1)*frameScale));
            b.gref.iconf[1]:ClearAllPoints()
            b.gref.iconf[1]:SetPoint("TOPLEFT",b.gref.icon[1],"TOPLEFT")
            b.gref.txt.expire[1]:ClearAllPoints()
            b.gref.txt.expire[1]:SetPoint(iAnchors["TXTEXPIRE"],b.gref.icon[1],iAnchors["TXTEXPIRE"],iAnchors["TXTEXPIREX"],0)
            b.gref.txt.count[1]:ClearAllPoints()
            b.gref.txt.count[1]:SetPoint(iAnchors["TXTCOUNT"],b.gref.icon[1],iAnchors["TXTCOUNT"],iAnchors["TXTCOUNTX"],0)
            for x=2,8 do
                b.gref.icon[x]:ClearAllPoints()
                if hbv_Skins_GetIconBoolean("BUFFDOUBLE", b.frame, 1) then
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
            HealBot_Skins_setIconAnchors(hbv_Skins_GetIconVar("BUFFONBAR", b.frame, 2),
                                         hbv_Skins_GetIconVar("BUFFANCHOR", b.frame, 2))
            HealBot_Skins_setIconSpacer(hbv_Skins_GetIconVar("BUFFANCHOR", b.frame, 2),
                                        hbv_Skins_GetIconVar("BICONSPACER", b.frame, 2))

            b.gref.icon[9]:ClearAllPoints();
            b.gref.icon[9]:SetPoint(iAnchors["ICON"],b,iAnchors["BUTTON"],
                                    ceil(hbv_Skins_GetIconVar("BHOFFSET", b.frame, 2)*frameScale),
                                    ceil(hbv_Skins_GetIconVar("BVOFFSET", b.frame, 2)*frameScale));
            b.gref.iconf[9]:ClearAllPoints()
            b.gref.iconf[9]:SetPoint("TOPLEFT",b.gref.icon[9],"TOPLEFT")
            b.gref.txt.expire[9]:ClearAllPoints()
            b.gref.txt.expire[9]:SetPoint(iAnchors["TXTEXPIRE"],b.gref.icon[9],iAnchors["TXTEXPIRE"],iAnchors["TXTEXPIREX"],0)
            b.gref.txt.count[9]:ClearAllPoints()
            b.gref.txt.count[9]:SetPoint(iAnchors["TXTCOUNT"],b.gref.icon[9],iAnchors["TXTCOUNT"],iAnchors["TXTCOUNTX"],0)
            b.gref.icon[10]:ClearAllPoints()
            if hbv_Skins_GetIconBoolean("BUFFDOUBLE", b.frame, 2) then
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
            HealBot_Skins_setIconAnchors(hbv_Skins_GetIconVar("BUFFONBAR", b.frame, 3),
                                         hbv_Skins_GetIconVar("BUFFANCHOR", b.frame, 3))
            HealBot_Skins_setIconSpacer(hbv_Skins_GetIconVar("BUFFANCHOR", b.frame, 3),
                                        hbv_Skins_GetIconVar("BICONSPACER", b.frame, 3))

            b.gref.icon[11]:ClearAllPoints();
            b.gref.icon[11]:SetPoint(iAnchors["ICON"],b,iAnchors["BUTTON"],
                                    ceil(hbv_Skins_GetIconVar("BHOFFSET", b.frame, 3)*frameScale),
                                    ceil(hbv_Skins_GetIconVar("BVOFFSET", b.frame, 3)*frameScale));
            b.gref.iconf[11]:ClearAllPoints()
            b.gref.iconf[11]:SetPoint("TOPLEFT",b.gref.icon[11],"TOPLEFT")
            b.gref.txt.expire[11]:ClearAllPoints()
            b.gref.txt.expire[11]:SetPoint(iAnchors["TXTEXPIRE"],b.gref.icon[11],iAnchors["TXTEXPIRE"],iAnchors["TXTEXPIREX"],0)
            b.gref.txt.count[11]:ClearAllPoints()
            b.gref.txt.count[11]:SetPoint(iAnchors["TXTCOUNT"],b.gref.icon[11],iAnchors["TXTCOUNT"],iAnchors["TXTCOUNTX"],0)
            b.gref.icon[12]:ClearAllPoints()
            if hbv_Skins_GetIconBoolean("BUFFDOUBLE", b.frame, 3) then
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
            HealBot_Skins_setIconAnchors(hbv_Skins_GetIconVar("DEBUFFONBAR", b.frame, 1),
                                         hbv_Skins_GetIconVar("DEBUFFANCHOR", b.frame, 1))
            HealBot_Skins_setIconSpacer(hbv_Skins_GetIconVar("DEBUFFANCHOR", b.frame, 1),
                                        hbv_Skins_GetIconVar("DICONSPACER", b.frame, 1))

            b.gref.icon[51]:ClearAllPoints()
            b.gref.icon[51]:SetPoint(iAnchors["ICON"],b,iAnchors["BUTTON"],
                                     ceil(hbv_Skins_GetIconVar("DHOFFSET", b.frame, 1)*frameScale),
                                     ceil(hbv_Skins_GetIconVar("DVOFFSET", b.frame, 1)*frameScale))
            b.gref.iconf[51]:ClearAllPoints()
            b.gref.iconf[51]:SetPoint("TOPLEFT",b.gref.icon[51],"TOPLEFT")
            b.gref.txt.expire[51]:ClearAllPoints()
            b.gref.txt.expire[51]:SetPoint(iAnchors["TXTEXPIRE"],b.gref.icon[51],iAnchors["TXTEXPIRE"],iAnchors["TXTEXPIREX"],0)
            b.gref.txt.count[51]:ClearAllPoints()
            b.gref.txt.count[51]:SetPoint(iAnchors["TXTCOUNT"],b.gref.icon[51],iAnchors["TXTCOUNT"],iAnchors["TXTCOUNTX"],0)
            for x=52,56 do
                b.gref.icon[x]:ClearAllPoints()
                if hbv_Skins_GetIconBoolean("DEBUFFDOUBLE", b.frame, 1) then
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
            HealBot_Skins_setIconAnchors(hbv_Skins_GetIconVar("DEBUFFONBAR", b.frame, 2),
                                         hbv_Skins_GetIconVar("DEBUFFANCHOR", b.frame, 2))
            HealBot_Skins_setIconSpacer(hbv_Skins_GetIconVar("DEBUFFANCHOR", b.frame, 2),
                                        hbv_Skins_GetIconVar("DICONSPACER", b.frame, 2))

            b.gref.icon[57]:ClearAllPoints()
            b.gref.icon[57]:SetPoint(iAnchors["ICON"],b,iAnchors["BUTTON"],
                                     ceil(hbv_Skins_GetIconVar("DHOFFSET", b.frame, 2)*frameScale),
                                     ceil(hbv_Skins_GetIconVar("DVOFFSET", b.frame, 2)*frameScale))
            b.gref.iconf[57]:ClearAllPoints()
            b.gref.iconf[57]:SetPoint("TOPLEFT",b.gref.icon[57],"TOPLEFT")
            b.gref.txt.expire[57]:ClearAllPoints()
            b.gref.txt.expire[57]:SetPoint(iAnchors["TXTEXPIRE"],b.gref.icon[57],iAnchors["TXTEXPIRE"],iAnchors["TXTEXPIREX"],0)
            b.gref.txt.count[57]:ClearAllPoints()
            b.gref.txt.count[57]:SetPoint(iAnchors["TXTCOUNT"],b.gref.icon[57],iAnchors["TXTCOUNT"],iAnchors["TXTCOUNTX"],0)
            b.gref.icon[58]:ClearAllPoints()
            if hbv_Skins_GetIconBoolean("DEBUFFDOUBLE", b.frame, 2) then
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
            HealBot_Skins_setIconAnchors(hbv_Skins_GetIconVar("DEBUFFONBAR", b.frame, 3),
                                         hbv_Skins_GetIconVar("DEBUFFANCHOR", b.frame, 3))
            HealBot_Skins_setIconSpacer(hbv_Skins_GetIconVar("DEBUFFANCHOR", b.frame, 3),
                                        hbv_Skins_GetIconVar("DICONSPACER", b.frame, 3))

            b.gref.icon[59]:ClearAllPoints()
            b.gref.icon[59]:SetPoint(iAnchors["ICON"],b,iAnchors["BUTTON"],
                                     ceil(hbv_Skins_GetIconVar("DHOFFSET", b.frame, 3)*frameScale),
                                     ceil(hbv_Skins_GetIconVar("DVOFFSET", b.frame, 3)*frameScale))
            b.gref.iconf[59]:ClearAllPoints()
            b.gref.iconf[59]:SetPoint("TOPLEFT",b.gref.icon[59],"TOPLEFT")
            b.gref.txt.expire[59]:ClearAllPoints()
            b.gref.txt.expire[59]:SetPoint(iAnchors["TXTEXPIRE"],b.gref.icon[59],iAnchors["TXTEXPIRE"],iAnchors["TXTEXPIREX"],0)
            b.gref.txt.count[59]:ClearAllPoints()
            b.gref.txt.count[59]:SetPoint(iAnchors["TXTCOUNT"],b.gref.icon[59],iAnchors["TXTCOUNT"],iAnchors["TXTCOUNTX"],0)
            b.gref.icon[60]:ClearAllPoints()
            if hbv_Skins_GetIconBoolean("DEBUFFDOUBLE", b.frame, 3) then
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
            HealBot_Skins_setIconAnchors(hbv_Skins_GetFrameVar("Icons", "CLASSONBAR", b.frame),
                                         hbv_Skins_GetFrameVar("Icons", "CLASSANCHOR", b.frame), true)
            b.gref.icon[91]:ClearAllPoints()
            b.gref.icon[91]:SetPoint(iAnchors["ICON"],b,iAnchors["BUTTON"],
                                     ceil(hbv_Skins_GetFrameVar("Icons", "CLASSHOFFSET", b.frame)*frameScale),
                                     ceil(hbv_Skins_GetFrameVar("Icons", "CLASSVOFFSET", b.frame)*frameScale))
            b.gref.icon[91]:SetHeight((bheight*hbv_Skins_GetFrameVar("Icons", "CLASSSCALE", b.frame))-2)
            b.gref.icon[91]:SetWidth((bheight*hbv_Skins_GetFrameVar("Icons", "CLASSSCALE", b.frame))-2)
            iZoom=hbv_Skins_GetFrameVar("Icons", "CLASSZOOM", b.frame) or 0
            b.gref.icon[91]:SetTexCoord(iZoom,1-iZoom,iZoom,1-iZoom)
            -- Raid Target 92
            HealBot_Skins_setIconAnchors(hbv_Skins_GetFrameVar("Icons", "TARGETONBAR", b.frame),
                                         hbv_Skins_GetFrameVar("Icons", "TARGETANCHOR", b.frame), true)
            b.gref.icon[92]:ClearAllPoints()
            b.gref.icon[92]:SetPoint(iAnchors["ICON"],b,iAnchors["BUTTON"],
                                     ceil(hbv_Skins_GetFrameVar("Icons", "TARGETHOFFSET", b.frame)*frameScale),
                                     ceil(hbv_Skins_GetFrameVar("Icons", "TARGETVOFFSET", b.frame)*frameScale))
            b.gref.icon[92]:SetHeight((bheight*hbv_Skins_GetFrameVar("Icons", "TARGETSCALE", b.frame))-2)
            b.gref.icon[92]:SetWidth((bheight*hbv_Skins_GetFrameVar("Icons", "TARGETSCALE", b.frame))-2)
            iZoom=hbv_Skins_GetFrameVar("Icons", "TARGETZOOM", b.frame)
            b.gref.icon[92]:SetTexCoord(iZoom,1-iZoom,iZoom,1-iZoom)
            -- Ready Check 93
            HealBot_Skins_setIconAnchors(hbv_Skins_GetFrameVar("Icons", "RCONBAR", b.frame),
                                         hbv_Skins_GetFrameVar("Icons", "RCANCHOR", b.frame), true)
            b.gref.icon[93]:ClearAllPoints()
            b.gref.icon[93]:SetPoint(iAnchors["ICON"],b,iAnchors["BUTTON"],
                                     ceil(hbv_Skins_GetFrameVar("Icons", "RCHOFFSET", b.frame)*frameScale),
                                     ceil(hbv_Skins_GetFrameVar("Icons", "RCVOFFSET", b.frame)*frameScale))
            b.gref.icon[93]:SetHeight((bheight*hbv_Skins_GetFrameVar("Icons", "RCSCALE", b.frame))-2)
            b.gref.icon[93]:SetWidth((bheight*hbv_Skins_GetFrameVar("Icons", "RCSCALE", b.frame))-2)
            iZoom=hbv_Skins_GetFrameVar("Icons", "RCZOOM", b.frame)
            b.gref.icon[93]:SetTexCoord(iZoom,1-iZoom,iZoom,1-iZoom)
            -- Out of range 94
            HealBot_Skins_setIconAnchors(hbv_Skins_GetFrameVar("Icons", "OORONBAR", b.frame),
                                         hbv_Skins_GetFrameVar("Icons", "OORANCHOR", b.frame), true)
            b.gref.icon[94]:ClearAllPoints()
            b.gref.icon[94]:SetPoint(iAnchors["ICON"],b,iAnchors["BUTTON"],
                                     ceil(hbv_Skins_GetFrameVar("Icons", "OORHOFFSET", b.frame)*frameScale),
                                     ceil(hbv_Skins_GetFrameVar("Icons", "OORVOFFSET", b.frame)*frameScale))
            b.gref.icon[94]:SetHeight((bheight*hbv_Skins_GetFrameVar("Icons", "OORSCALE", b.frame))-2)
            b.gref.icon[94]:SetWidth((bheight*hbv_Skins_GetFrameVar("Icons", "OORSCALE", b.frame))-2)
            iZoom=hbv_Skins_GetFrameVar("Icons", "OORZOOM", b.frame)
            b.gref.icon[94]:SetTexCoord(iZoom,1-iZoom,iZoom,1-iZoom)

            -- Rank 95
            HealBot_Skins_setIconAnchors(hbv_Skins_GetFrameVar("Icons", "RANKONBAR", b.frame),
                                         hbv_Skins_GetFrameVar("Icons", "RANKANCHOR", b.frame), true)
            b.gref.icon[95]:ClearAllPoints()
            b.gref.icon[95]:SetPoint(iAnchors["ICON"],b,iAnchors["BUTTON"],
                                     ceil(hbv_Skins_GetFrameVar("Icons", "RANKHOFFSET", b.frame)*frameScale),
                                     ceil(hbv_Skins_GetFrameVar("Icons", "RANKVOFFSET", b.frame)*frameScale))
            b.gref.icon[95]:SetHeight((bheight*hbv_Skins_GetFrameVar("Icons", "RANKSCALE", b.frame))-2)
            b.gref.icon[95]:SetWidth((bheight*hbv_Skins_GetFrameVar("Icons", "RANKSCALE", b.frame))-2)
            iZoom=hbv_Skins_GetFrameVar("Icons", "RANKZOOM", b.frame)
            b.gref.icon[95]:SetTexCoord(iZoom,1-iZoom,iZoom,1-iZoom)

            -- Combat 96
            HealBot_Skins_setIconAnchors(hbv_Skins_GetFrameVar("Icons", "COMBATONBAR", b.frame),
                                         hbv_Skins_GetFrameVar("Icons", "COMBATANCHOR", b.frame), true)
            b.gref.icon[96]:ClearAllPoints()
            b.gref.icon[96]:SetPoint(iAnchors["ICON"],b,iAnchors["BUTTON"],
                                     ceil(hbv_Skins_GetFrameVar("Icons", "COMBATHOFFSET", b.frame)*frameScale),
                                     ceil(hbv_Skins_GetFrameVar("Icons", "COMBATVOFFSET", b.frame)*frameScale))
            b.gref.icon[96]:SetHeight((bheight*hbv_Skins_GetFrameVar("Icons", "COMBATSCALE", b.frame))-2)
            b.gref.icon[96]:SetWidth((bheight*hbv_Skins_GetFrameVar("Icons", "COMBATSCALE", b.frame))-2)
            iZoom=hbv_Skins_GetFrameVar("Icons", "COMBATZOOM", b.frame)
            b.gref.icon[96]:SetTexCoord(iZoom,1-iZoom,iZoom,1-iZoom)
            b.icon.reset=false
        end

        if b.indreset then
            local indCol=hbv_Skins_GetFrameVar("Indicators", "ACOL", b.frame)
            if indCol == 1 then indCol=8 end
            b.gref.indicator.aggro["Iconal1"]:SetTexture(indTextures[indCol])
            b.gref.indicator.aggro["Iconal2"]:SetTexture(indTextures[indCol])
            b.gref.indicator.aggro["Iconal3"]:SetTexture(indTextures[indCol])
            b.gref.indicator.aggro["Iconar1"]:SetTexture(indTextures[indCol])
            b.gref.indicator.aggro["Iconar2"]:SetTexture(indTextures[indCol])
            b.gref.indicator.aggro["Iconar3"]:SetTexture(indTextures[indCol])

            indCol=hbv_Skins_GetFrameVar("Indicators", "MCOL", b.frame)
            if indCol == 1 then indCol=10 end
            b.gref.indicator.mana[1]:SetTexture(indTextures[indCol])
            b.gref.indicator.mana[2]:SetTexture(indTextures[indCol])
            b.gref.indicator.mana[3]:SetTexture(indTextures[indCol])

            indCol=hbv_Skins_GetFrameVar("Indicators", "SCOL", b.frame)
            if indCol == 1 then indCol=8 end
            for x=1,16 do
                b.gref.indicator.selfcast[x]:SetTexture(indTextures[indCol])
                --b.gref.indicator.selfcast[x]:SetAlpha(0)
            end

            indCol=hbv_Skins_GetFrameVar("Indicators", "PCOL", b.frame)
            if indCol == 1 then indCol=12 end
            for x=1,5 do
                b.gref.indicator.power[x]:SetTexture(indTextures[indCol])
            end

            local indAnchor={[0]="TOPLEFT",[1]="TOPRIGHT"}
            if hbv_Skins_GetFrameVar("Indicators", "AANCHOR", b.frame) == 2 then
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
                                                       ceil(0+hbv_Skins_GetFrameVar("Indicators", "AHOFF", b.frame)*frameScale),
                                                              HealBot_Skins_IndicatorVOffset(hbv_Skins_GetFrameVar("Indicators", "AANCHOR", b.frame),
                                                                                             hbv_Skins_GetFrameVar("Indicators", "AVOFF", b.frame),
                                                                                              button.frame))
            b.gref.indicator.aggro["Iconal2"]:SetPoint("TOPLEFT",b.gref.indicator.aggro["Iconal1"],"TOPRIGHT",
                                                       ceil(0+(hbv_Skins_GetFrameVar("Indicators", "ASPACE", b.frame))*frameScale),0)
            b.gref.indicator.aggro["Iconal3"]:SetPoint("TOPLEFT",b.gref.indicator.aggro["Iconal2"],"TOPRIGHT",
                                                       ceil(0+(hbv_Skins_GetFrameVar("Indicators", "ASPACE", b.frame))*frameScale),0)
            b.gref.indicator.aggro["Iconar1"]:SetPoint(indAnchor[1],b.gref["IconTop"],indAnchor[1],
                                                       ceil(0-hbv_Skins_GetFrameVar("Indicators", "AHOFF", b.frame)*frameScale),
                                                              HealBot_Skins_IndicatorVOffset(hbv_Skins_GetFrameVar("Indicators", "AANCHOR", b.frame),
                                                                                             hbv_Skins_GetFrameVar("Indicators", "AVOFF", b.frame),
                                                                                              button.frame))
            b.gref.indicator.aggro["Iconar2"]:SetPoint("TOPRIGHT",b.gref.indicator.aggro["Iconar1"],"TOPLEFT",
                                                       ceil(0-(hbv_Skins_GetFrameVar("Indicators", "ASPACE", b.frame))*frameScale),0)
            b.gref.indicator.aggro["Iconar3"]:SetPoint("TOPRIGHT",b.gref.indicator.aggro["Iconar2"],"TOPLEFT",
                                                       ceil(0-(hbv_Skins_GetFrameVar("Indicators", "ASPACE", b.frame))*frameScale),0)


            indAnchor[0]="TOP"
            if hbv_Skins_GetFrameVar("Indicators", "MANCHOR", b.frame) == 2 then
                indAnchor[0]="BOTTOM"
            elseif hbv_Skins_GetFrameVar("Indicators", "MANCHOR", b.frame) == 3 then
                indAnchor[0]="LEFT"
            elseif hbv_Skins_GetFrameVar("Indicators", "MANCHOR", b.frame) == 4 then
                indAnchor[0]="RIGHT"
            elseif hbv_Skins_GetFrameVar("Indicators", "MANCHOR", b.frame) == 5 then
                indAnchor[0]="TOPLEFT"
            elseif hbv_Skins_GetFrameVar("Indicators", "MANCHOR", b.frame) == 6 then
                indAnchor[0]="BOTTOMLEFT"
            elseif hbv_Skins_GetFrameVar("Indicators", "MANCHOR", b.frame) == 7 then
                indAnchor[0]="TOPRIGHT"
            elseif hbv_Skins_GetFrameVar("Indicators", "MANCHOR", b.frame) == 8 then
                indAnchor[0]="BOTTOMRIGHT"
            end
            b.gref.indicator.mana[1]:ClearAllPoints()
            b.gref.indicator.mana[2]:ClearAllPoints()
            b.gref.indicator.mana[3]:ClearAllPoints()

            b.gref.indicator.mana[2]:SetPoint(indAnchor[0],b.gref["IconTop"],indAnchor[0],
                                              ceil(0+hbv_Skins_GetFrameVar("Indicators", "MHOFF", b.frame)*frameScale),
                                                     HealBot_Skins_IndicatorVOffset(hbv_Skins_GetFrameVar("Indicators", "MANCHOR", b.frame),
                                                                                    hbv_Skins_GetFrameVar("Indicators", "MVOFF", b.frame),
                                                                                    button.frame))
            b.gref.indicator.mana[1]:SetPoint("TOPRIGHT",b.gref.indicator.mana[2],"TOPLEFT",
                                             (ceil(0-(hbv_Skins_GetFrameVar("Indicators", "MSPACE", b.frame)*frameScale))),0)
            b.gref.indicator.mana[3]:SetPoint("TOPLEFT",b.gref.indicator.mana[2],"TOPRIGHT",
                                             (ceil(0+(hbv_Skins_GetFrameVar("Indicators", "MSPACE", b.frame)*frameScale))),0)

            indAnchor[0]="TOP"
            if hbv_Skins_GetFrameVar("Indicators", "PANCHOR", b.frame) == 2 then
                indAnchor[0]="BOTTOM"
            elseif hbv_Skins_GetFrameVar("Indicators", "PANCHOR", b.frame) == 3 then
                indAnchor[0]="LEFT"
            elseif hbv_Skins_GetFrameVar("Indicators", "PANCHOR", b.frame) == 4 then
                indAnchor[0]="RIGHT"
            elseif hbv_Skins_GetFrameVar("Indicators", "PANCHOR", b.frame) == 5 then
                indAnchor[0]="TOPLEFT"
            elseif hbv_Skins_GetFrameVar("Indicators", "PANCHOR", b.frame) == 6 then
                indAnchor[0]="BOTTOMLEFT"
            elseif hbv_Skins_GetFrameVar("Indicators", "PANCHOR", b.frame) == 7 then
                indAnchor[0]="TOPRIGHT"
            elseif hbv_Skins_GetFrameVar("Indicators", "PANCHOR", b.frame) == 8 then
                indAnchor[0]="BOTTOMRIGHT"
            end
            b.gref.indicator.power[1]:ClearAllPoints()
            b.gref.indicator.power[2]:ClearAllPoints()
            b.gref.indicator.power[3]:ClearAllPoints()
            b.gref.indicator.power[4]:ClearAllPoints()
            b.gref.indicator.power[5]:ClearAllPoints()

            b.gref.indicator.power[3]:SetPoint(indAnchor[0],b.gref["IconTop"],indAnchor[0],
                                               ceil(0+hbv_Skins_GetFrameVar("Indicators", "PHOFF", b.frame)),
                                                      HealBot_Skins_IndicatorVOffset(hbv_Skins_GetFrameVar("Indicators", "PANCHOR", b.frame),
                                                                                     hbv_Skins_GetFrameVar("Indicators", "PVOFF", b.frame),
                                                                                      button.frame))
            b.gref.indicator.power[2]:SetPoint("TOPRIGHT",b.gref.indicator.power[3],"TOPLEFT",
                                              ceil(0-(hbv_Skins_GetFrameVar("Indicators", "PSPACE", b.frame)*frameScale)),0)
            b.gref.indicator.power[1]:SetPoint("TOPRIGHT",b.gref.indicator.power[2],"TOPLEFT",
                                              ceil(0-(hbv_Skins_GetFrameVar("Indicators", "PSPACE", b.frame)*frameScale)),0)
            b.gref.indicator.power[4]:SetPoint("TOPLEFT",b.gref.indicator.power[3],"TOPRIGHT",
                                              ceil(0+(hbv_Skins_GetFrameVar("Indicators", "PSPACE", b.frame)*frameScale)),0)
            b.gref.indicator.power[5]:SetPoint("TOPLEFT",b.gref.indicator.power[4],"TOPRIGHT",
                                              ceil(0+(hbv_Skins_GetFrameVar("Indicators", "PSPACE", b.frame)*frameScale)),0)

            HealBot_Skins_setIconAnchors(hbv_Skins_GetIconVar("BUFFONBAR", b.frame, 1),
                                         hbv_Skins_GetIconVar("BUFFANCHOR", b.frame, 1))

            b.gref.indicator.selfcast[1]:ClearAllPoints()
            b.gref.indicator.selfcast[1]:SetPoint(iAnchors["INDSELFCAST"],b.gref.icon[1],iAnchors["INDSELFCAST"],
                                                  0+hbv_Skins_GetFrameVar("Indicators", "SHOFF", b.frame),
                                                  HealBot_Skins_IndicatorVOffset(hbv_Skins_GetFrameVar("Indicators", "SANCHOR", b.frame),
                                                                                 hbv_Skins_GetFrameVar("Indicators", "SVOFF", b.frame),
                                                                                 button.frame))
            for x=2,8 do
                b.gref.indicator.selfcast[x]:ClearAllPoints()
                b.gref.indicator.selfcast[x]:SetPoint(iAnchors["INDSELFCAST"],b.gref.icon[x],iAnchors["INDSELFCAST"],
                                                  0+hbv_Skins_GetFrameVar("Indicators", "SHOFF", b.frame),
                                                  HealBot_Skins_IndicatorVOffset(hbv_Skins_GetFrameVar("Indicators", "SANCHOR", b.frame),
                                                                                 hbv_Skins_GetFrameVar("Indicators", "SVOFF", b.frame),
                                                                                 button.frame))
            end

            HealBot_Skins_setIconAnchors(hbv_Skins_GetIconVar("BUFFONBAR", b.frame, 2),
                                         hbv_Skins_GetIconVar("BUFFANCHOR", b.frame, 2))

            b.gref.indicator.selfcast[9]:ClearAllPoints()
            b.gref.indicator.selfcast[9]:SetPoint(iAnchors["INDSELFCAST"],b.gref.icon[9],iAnchors["INDSELFCAST"],
                                                  0+hbv_Skins_GetFrameVar("Indicators", "SHOFF", b.frame),
                                                  HealBot_Skins_IndicatorVOffset(hbv_Skins_GetFrameVar("Indicators", "SANCHOR", b.frame),
                                                                                 hbv_Skins_GetFrameVar("Indicators", "SVOFF", b.frame),
                                                                                 button.frame))
            for x=10,12 do
                b.gref.indicator.selfcast[x]:ClearAllPoints()
                b.gref.indicator.selfcast[x]:SetPoint(iAnchors["INDSELFCAST"],b.gref.icon[x],iAnchors["INDSELFCAST"],
                                                  0+hbv_Skins_GetFrameVar("Indicators", "SHOFF", b.frame),
                                                  HealBot_Skins_IndicatorVOffset(hbv_Skins_GetFrameVar("Indicators", "SANCHOR", b.frame),
                                                                                 hbv_Skins_GetFrameVar("Indicators", "SVOFF", b.frame),
                                                                                 button.frame))
            end

            HealBot_Skins_setIconAnchors(hbv_Skins_GetIconVar("BUFFONBAR", b.frame, 3),
                                         hbv_Skins_GetIconVar("BUFFANCHOR", b.frame, 3))

            b.gref.indicator.selfcast[13]:ClearAllPoints()
            b.gref.indicator.selfcast[13]:SetPoint(iAnchors["INDSELFCAST"],b.gref.icon[13],iAnchors["INDSELFCAST"],
                                                  0+hbv_Skins_GetFrameVar("Indicators", "SHOFF", b.frame),
                                                  HealBot_Skins_IndicatorVOffset(hbv_Skins_GetFrameVar("Indicators", "SANCHOR", b.frame),
                                                                                 hbv_Skins_GetFrameVar("Indicators", "SVOFF", b.frame),
                                                                                 button.frame))
            for x=14,16 do
                b.gref.indicator.selfcast[x]:ClearAllPoints()
                b.gref.indicator.selfcast[x]:SetPoint(iAnchors["INDSELFCAST"],b.gref.icon[x],iAnchors["INDSELFCAST"],
                                                  0+hbv_Skins_GetFrameVar("Indicators", "SHOFF", b.frame),
                                                  HealBot_Skins_IndicatorVOffset(hbv_Skins_GetFrameVar("Indicators", "SANCHOR", b.frame),
                                                                                 hbv_Skins_GetFrameVar("Indicators", "SVOFF", b.frame),
                                                                                 button.frame))
            end

            b.gref.indicator.aggro["Iconal1"]:SetWidth(ceil(hbv_Skins_GetFrameVar("Indicators", "ASIZE", b.frame)*frameScale))
            b.gref.indicator.aggro["Iconal2"]:SetWidth(ceil(hbv_Skins_GetFrameVar("Indicators", "ASIZE", b.frame)*frameScale))
            b.gref.indicator.aggro["Iconal3"]:SetWidth(ceil(hbv_Skins_GetFrameVar("Indicators", "ASIZE", b.frame)*frameScale))
            b.gref.indicator.aggro["Iconar1"]:SetWidth(ceil(hbv_Skins_GetFrameVar("Indicators", "ASIZE", b.frame)*frameScale))
            b.gref.indicator.aggro["Iconar2"]:SetWidth(ceil(hbv_Skins_GetFrameVar("Indicators", "ASIZE", b.frame)*frameScale))
            b.gref.indicator.aggro["Iconar3"]:SetWidth(ceil(hbv_Skins_GetFrameVar("Indicators", "ASIZE", b.frame)*frameScale))
            b.gref.indicator.aggro["Iconal1"]:SetHeight(ceil(hbv_Skins_GetFrameVar("Indicators", "ASIZE", b.frame)*frameScale))
            b.gref.indicator.aggro["Iconal2"]:SetHeight(ceil(hbv_Skins_GetFrameVar("Indicators", "ASIZE", b.frame)*frameScale))
            b.gref.indicator.aggro["Iconal3"]:SetHeight(ceil(hbv_Skins_GetFrameVar("Indicators", "ASIZE", b.frame)*frameScale))
            b.gref.indicator.aggro["Iconar1"]:SetHeight(ceil(hbv_Skins_GetFrameVar("Indicators", "ASIZE", b.frame)*frameScale))
            b.gref.indicator.aggro["Iconar2"]:SetHeight(ceil(hbv_Skins_GetFrameVar("Indicators", "ASIZE", b.frame)*frameScale))
            b.gref.indicator.aggro["Iconar3"]:SetHeight(ceil(hbv_Skins_GetFrameVar("Indicators", "ASIZE", b.frame)*frameScale))

            for x=1,3 do
                b.gref.indicator.mana[x]:SetWidth(ceil(hbv_Skins_GetFrameVar("Indicators", "MSIZE", b.frame)*frameScale))
                b.gref.indicator.mana[x]:SetHeight(ceil(hbv_Skins_GetFrameVar("Indicators", "MSIZE", b.frame)*frameScale))
            end
            for x=1,16 do
                b.gref.indicator.selfcast[x]:SetWidth(ceil(hbv_Skins_GetFrameVar("Indicators", "SSIZE", b.frame)*frameScale))
                b.gref.indicator.selfcast[x]:SetHeight(ceil(hbv_Skins_GetFrameVar("Indicators", "SSIZE", b.frame)*frameScale))
            end
            for x=1,5 do
                b.gref.indicator.power[x]:SetWidth(ceil(hbv_Skins_GetFrameVar("Indicators", "PSIZE", b.frame)*frameScale))
                b.gref.indicator.power[x]:SetHeight(ceil(hbv_Skins_GetFrameVar("Indicators", "PSIZE", b.frame)*frameScale))
            end

            if testBarsOn and b.frame<10 and hbv_Skins_GetFrameBoolean("BarAggro", "SHOW", b.frame) and
                                             hbv_Skins_GetFrameBoolean("BarAggro", "SHOWIND", b.frame) then
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

            if testBarsOn and b.frame<10 and hbv_Skins_GetFrameVar("HealBar", "LOWMANA", b.frame)>1 then
                b.gref.indicator.mana[1]:SetAlpha(1)
                b.gref.indicator.mana[2]:SetAlpha(1)
                b.gref.indicator.mana[3]:SetAlpha(1)
            else
                b.gref.indicator.mana[1]:SetAlpha(0)
                b.gref.indicator.mana[2]:SetAlpha(0)
                b.gref.indicator.mana[3]:SetAlpha(0)
            end
            if testBarsOn then
                if hbv_Skins_GetFrameBoolean("HealBar", "POWERCNT", b.frame) and testPowerOn>0 then
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
        hwidth=ceil((bWidth+auxWidth+(bOutline*2))*hbv_Skins_GetFrameVar("HeadBar", "WIDTH", h.frame))
        hheight=ceil(hbv_Skins_GetFrameVar("HeadBar", "HEIGHT", h.frame)*frameScale)
        h:SetHeight(hheight);
        h:SetWidth(hwidth);
        back:SetHeight(hheight)
        back:SetWidth(hwidth)
        HealBot_Action_SetBackHeaderHeightWidth(h.frame, hheight, hwidth)
        back:SetStatusBarColor(0,0,0,0)
        HealBot_Media_UpdateTexture(h.bar, hbv_Skins_GetFrameVar("HeadBar", "TEXTURE", h.frame), "Skins_ResetSkin - HeadBar")
        h.bar:GetStatusBarTexture():SetHorizTile(false)
        h.bar:SetMinMaxValues(0,100);
        h.bar:SetValue(100);
        HealBot_Action_UpdateHeaderOpacity(h)
        h.bar:SetHeight(hheight);
        h.bar:SetWidth(hwidth);
        HealBot_Media_UpdateFont(h.bar.txt,
                                 hbv_Skins_GetFrameVar("HeadText", "FONT", h.frame),
                                 ceil(hbv_Skins_GetFrameVar("HeadText", "HEIGHT", h.frame)*frameScale),
                                 hbv_Skins_GetFrameVar("HeadText", "OUTLINE", h.frame),
                                 "Skins_ResetSkin - HeadText")
        h.bar.txt:SetPoint("CENTER",h.bar,"CENTER",0,hbv_Skins_GetFrameVar("HeadText", "OFFSET", h.frame))
        h.bar:EnableMouse(false)
        h.bar.txt2:SetTextColor(0,0,0,0);
        h.bar:ClearAllPoints()
        h.bar:SetPoint("CENTER",back,"CENTER",0,0)
        h:Disable();
    elseif barType == "hbfocus" then
        bar=_G["hbExtra_HealUnit999"]
        --HealBot_Media_UpdateDefaultTexture(_G["hbExtra_HealUnit999Bar"], "Skins_ResetSkin - HealBar")
        --HealBot_Media_UpdateTexture(bar, hbv_Skins_GetFrameVar("HealBar", "TEXTURE", button.frame), "Skins_ResetSkin - HealBar")

        iScale=0.84
        iScale=iScale+(numcols/10)
        bar:SetWidth(bWidth*iScale)
        button:SetWidth(bWidth*iScale)
        bar:SetHeight(bheight);
        button:SetHeight(bheight);
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

function HealBot_Skins_Check_Aux(skinName)
    if Healbot_Config_Skins.AuxBar and Healbot_Config_Skins.AuxBar[skinName] then
        if not Healbot_Config_Aux.Bar[skinName] then Healbot_Config_Aux.Bar[skinName]={} end
        for f=1,10 do
            for i=1,9 do
                table.foreach(Healbot_Config_Skins.AuxBar[skinName][i][f], function (key,val)
                    if key and val then
                        if key == "SIZE" and val == 0.98 then val=1 end
                        hbv_Aux_SetBarSkin(val, skinName, key, f, i)
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
                        if key == "FONT" and val == "Friz Quadrata TT" then val=hbv_Default_FontName() end
                        hbv_Aux_SetBarTextSkin(val, skinName, key, f, i)
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
                        hbv_Aux_SetOverlaySkin(val, skinName, key, f, i)
                    end
                end
            end);
        end
        Healbot_Config_Skins.AuxBarFrame[skinName]=nil
    end
    if Healbot_Config_Aux.Bar and Healbot_Config_Aux.Bar[skinName] then
        for f=1,10 do
            if Healbot_Config_Aux.Bar[skinName][f] then
                for i=1,9 do
                    if Healbot_Config_Aux.Bar[skinName][f][i] then
                        table.foreach(Healbot_Config_Aux.Bar[skinName][f][i], function (key,val)
                            if not hbv_Aux_BarHasDefault(key) then
                                Healbot_Config_Aux.Bar[skinName][f][i][key]=nil
                            else
                                hbv_Aux_SetBarSkin(val, skinName, key, f, i)
                            end
                        end);
                        HealBot_Util_EmptyTable(Healbot_Config_Aux.Bar[skinName][f], i)
                    end
                end
                HealBot_Util_EmptyTable(Healbot_Config_Aux.Bar[skinName], f)
            end
        end
    end
    if Healbot_Config_Aux.BarText and Healbot_Config_Aux.BarText[skinName] then
        for f=1,10 do
            if Healbot_Config_Aux.BarText[skinName][f] then
                for i=1,9 do
                    if Healbot_Config_Aux.BarText[skinName][f][i] then
                        table.foreach(Healbot_Config_Aux.BarText[skinName][f][i], function (key,val)
                            if not hbv_Aux_BarTextHasDefault(key) then
                                Healbot_Config_Aux.BarText[skinName][f][i][key]=nil
                            else
                                hbv_Aux_SetBarTextSkin(val, skinName, key, f, i)
                            end
                        end);
                        HealBot_Util_EmptyTable(Healbot_Config_Aux.BarText[skinName][f], i)
                    end
                end
                HealBot_Util_EmptyTable(Healbot_Config_Aux.BarText[skinName], f)
            end
        end
    end
    if Healbot_Config_Aux.Overlay and Healbot_Config_Aux.Overlay[skinName] then
        for f=1,10 do
            if Healbot_Config_Aux.Overlay[skinName][f] then
                table.foreach(Healbot_Config_Aux.Overlay[skinName][f], function (key,val)
                    if not hbv_Aux_OverlayHasDefault(key) then
                        Healbot_Config_Aux.Overlay[skinName][f][key]=nil
                    else
                        hbv_Aux_SetOverlaySkin(val, skinName, key, f)
                    end
                end);
                HealBot_Util_EmptyTable(Healbot_Config_Aux.Overlay[skinName], f)
            end
        end
    end
end

local OrphanedCheckVars={"Indicators", "HeadBar", "Enemy", "IconSetsText", "AdaptiveCol", "BarSort", "FrameAliasBar", "Anchors", "Author", "BarAggro", "Frame", "General",
                         "BarTextCol", "IconSets", "HealGroups", "HealBar", "FrameAlias", "Chat", "BarText", "BarIACol", "Emerg", "Adaptive", "StickyFrames", "HeadText",
                         "BarVisibility", "ToolTip", "Icons", "AdaptiveOrder", "FocusGroups", "CustomCols", "IconText", "Healing", "RaidIcon", "BarCol", "DuplicateBars"}
local hbCurOrphanedCheck=0
function HealBot_Skins_Clear_Orphaned()
    hbCurOrphanedCheck=hbCurOrphanedCheck+1
    if OrphanedCheckVars[hbCurOrphanedCheck] then
        for skin,_ in pairs(Healbot_Config_Skins[OrphanedCheckVars[hbCurOrphanedCheck]]) do
            local foundSkin=false
            for x in pairs (Healbot_Config_Skins.Skins) do
                if Healbot_Config_Skins.Skins[x] == skin then foundSkin=true end
            end
            if not foundSkin then
                Healbot_Config_Skins[OrphanedCheckVars[hbCurOrphanedCheck]][skin]=nil
            end
        end
        HealBot_Timers_Set("OOC","OrphanedCheck",true)
    end
end

local defaultFrame={}
local defaultFrameVars={"Indicators", "HeadBar", "IconSetsText", "BarSort", "FrameAliasBar", "BarAggro", "Frame",
                        "BarTextCol", "IconSets", "HealBar", "FrameAlias", "BarText", "BarIACol", "Emerg", "Anchors",
                        "StickyFrames", "HeadText", "BarVisibility", "Icons", "IconText", "RaidIcon", "BarCol"}
local defaultVars={"Enemy", "General", "Healing", "Adaptive", "Chat"}

function HealBot_Skins_DefaultUnusedFrames(skin)
    for j=1,10 do
        defaultFrame[j]=true
    end
    for j=1,15 do
        if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][j]["STATE"] then
            defaultFrame[Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][j]["FRAME"]]=false
        end
    end
    for j=1,10 do
        if defaultFrame[j] then
            for k=1,#defaultFrameVars do
                if Healbot_Config_Skins[defaultFrameVars[k]] and Healbot_Config_Skins[defaultFrameVars[k]][skin] and Healbot_Config_Skins[defaultFrameVars[k]][skin][j] then
                    Healbot_Config_Skins[defaultFrameVars[k]][skin][j]=nil
                end
            end
        end
    end
end

local uFVid=0
local uVid=0
local uFvSkin=""
local uFvSkinProcess=false
local uFvSkinQueue={}
local uFvSkinQueueList={}

function HealBot_Skins_Clear_UnusedSkin(skinName)
    if not uFvSkinProcess then
        uFvSkinProcess=true
        uFvSkin=skinName
        uVid=0
        uFVid=0
        HealBot_Timers_Set("OOC","UnusedFramesVarsCheck",true)
    elseif not uFvSkinQueueList[skinName] then
        uFvSkinQueueList[skinName]=true
        table.insert(uFvSkinQueue, skinName)
    end
end

function HealBot_Skins_Clear_UnusedFramesVars()
    uFVid=uFVid+1
    if defaultFrameVars[uFVid] then
        for f=1,10 do
            if defaultFrameVars[uFVid] == "IconSetsText" or defaultFrameVars[uFVid] == "IconSets" then
                if defaultFrameVars[uFVid] == "IconSetsText" then
                    if Healbot_Config_Skins.IconSetsText[uFvSkin] and Healbot_Config_Skins.IconSetsText[uFvSkin][f] then
                        for i=1,3 do
                            if Healbot_Config_Skins.IconSetsText[uFvSkin][f][i] then
                                table.foreach(Healbot_Config_Skins.IconSetsText[uFvSkin][f][i], function (key,val)
                                    if not hbv_Skins_IconTextHasDefault(key) then
                                        Healbot_Config_Skins.IconSetsText[uFvSkin][f][i][key]=nil
                                    else
                                        hbv_Skins_SetIconTextVarSkin(val, uFvSkin, key, f, i)
                                    end
                                end);
                                HealBot_Util_EmptyTable(Healbot_Config_Skins.IconSetsText[uFvSkin][f], i)
                            end
                        end
                        HealBot_Util_EmptyTable(Healbot_Config_Skins.IconSetsText[uFvSkin], f)
                    end
                else
                    if Healbot_Config_Skins.IconSets[uFvSkin] and Healbot_Config_Skins.IconSets[uFvSkin][f] then
                        for i=1,3 do
                            if Healbot_Config_Skins.IconSets[uFvSkin][f][i] then
                                table.foreach(Healbot_Config_Skins.IconSets[uFvSkin][f][i], function (key,val)
                                    if not hbv_Skins_IconHasDefault(key) then
                                        Healbot_Config_Skins.IconSets[uFvSkin][f][i][key]=nil
                                    else
                                        hbv_Skins_SetIconVarSkin(val, uFvSkin, key, f, i)
                                    end
                                end);
                                HealBot_Util_EmptyTable(Healbot_Config_Skins.IconSets[uFvSkin][f], i)
                            end
                        end
                        HealBot_Util_EmptyTable(Healbot_Config_Skins.IconSets[uFvSkin], f)
                    end
                end
            elseif Healbot_Config_Skins[defaultFrameVars[uFVid]] and Healbot_Config_Skins[defaultFrameVars[uFVid]][uFvSkin] and Healbot_Config_Skins[defaultFrameVars[uFVid]][uFvSkin][f] then
                table.foreach(Healbot_Config_Skins[defaultFrameVars[uFVid]][uFvSkin][f], function (key,val)
                    if not hbv_Skins_FrameHasDefault(defaultFrameVars[uFVid], key) then
                        Healbot_Config_Skins[defaultFrameVars[uFVid]][uFvSkin][f][key]=nil
                    else
                        hbv_Skins_SetFrameVarSkin(val, uFvSkin, defaultFrameVars[uFVid], key, f)
                    end
                end);
                HealBot_Util_EmptyTable(Healbot_Config_Skins[defaultFrameVars[uFVid]][uFvSkin], f)
            end
        end
        HealBot_Timers_Set("OOC","UnusedFramesVarsCheck",true)
    else
        HealBot_Timers_Set("OOC","UnusedVarsCheck",true,true)
    end
end

function HealBot_Skins_Clear_UnusedVars()
    uVid=uVid+1
    if defaultVars[uVid] and Healbot_Config_Skins[defaultVars[uVid]][uFvSkin] then
        table.foreach(Healbot_Config_Skins[defaultVars[uVid]][uFvSkin], function (key,val)
            if not hbv_Skins_HasDefault(defaultVars[uVid], key) then
                Healbot_Config_Skins[defaultVars[uVid]][uFvSkin][key]=nil
            else
                hbv_Skins_SetVarSkin(val, uFvSkin, defaultVars[uVid], key)
            end
        end);
        HealBot_Timers_Set("OOC","UnusedVarsCheck",true)
    else
        HealBot_Skins_Check_Aux(uFvSkin)
        uFvSkinProcess=false
        uFvSkinQueueList[uFvSkin]=false
        if uFvSkinQueue[1] then
            HealBot_Skins_Clear_UnusedSkin(uFvSkinQueue[1])
            table.remove(uFvSkinQueue, 1)
        end
    end
end

function HealBot_Skins_ResetHealGroups(SkinName)
    Healbot_Config_Skins.HealGroups[SkinName]={
        [1]={["NAME"]=HEALBOT_OPTIONS_SELFHEALS_en,["STATE"]=false,["FRAME"]=1},
        [2]={["NAME"]=HEALBOT_OPTIONS_TANKHEALS_en,["STATE"]=false,["FRAME"]=1},
        [3]={["NAME"]=HEALBOT_CLASSES_HEALERS_en,["STATE"]=false,["FRAME"]=1},
        [5]={["NAME"]=HEALBOT_OPTIONS_EMERGENCYHEALS_en,["STATE"]=true,["FRAME"]=1},
        [4]={["NAME"]=HEALBOT_OPTIONS_GROUPHEALS_en,["STATE"]=false,["FRAME"]=1},
        [6]={["NAME"]=HEALBOT_OPTIONS_MYTARGET_en,["STATE"]=false,["FRAME"]=1},
        [7]={["NAME"]=HEALBOT_OPTIONS_PRIVFOCUS_en,["STATE"]=false,["FRAME"]=1},
        [8]={["NAME"]=HEALBOT_OPTIONS_TARGETOFPRIVFOCUSTARGET_en,["STATE"]=false,["FRAME"]=5},
        [9]={["NAME"]=HEALBOT_VEHICLE_en,["STATE"]=false,["FRAME"]=6},
       [10]={["NAME"]=HEALBOT_OPTIONS_PETHEALS_en,["STATE"]=false,["FRAME"]=7},
       [11]={["NAME"]=HEALBOT_OPTIONS_TARGETHEALS_en,["STATE"]=false,["FRAME"]=8},
       [12]={["NAME"]=HEALBOT_OPTIONS_TARGETOFTARGET_en,["STATE"]=false,["FRAME"]=8},
       [13]={["NAME"]=HEALBOT_FOCUS_en,["STATE"]=false,["FRAME"]=9},
       [14]={["NAME"]=HEALBOT_OPTIONS_TARGETOFFOCUS_en,["STATE"]=false,["FRAME"]=9},
       [15]={["NAME"]=HEALBOT_CUSTOM_CASTBY_ENEMY_en,["STATE"]=false,["FRAME"]=10},
   }
end

function HealBot_Skins_Check_Skin(SkinName)
    HealBot_Skins_Check_Aux(SkinName)
      --HealBot_setCall("HealBot_Skins_Check_Skin")
    if Healbot_Config_Skins.ExtraIncGroup then Healbot_Config_Skins.ExtraIncGroup=nil end
    if Healbot_Config_Skins.BarsHide then Healbot_Config_Skins.BarsHide=nil end
    if Healbot_Config_Skins.EmergIncMonitor then Healbot_Config_Skins.EmergIncMonitor=nil end
    if Healbot_Config_Skins.IncludeGroup then Healbot_Config_Skins.IncludeGroup=nil end

    if not HealBot_Config.SkinDefault[SkinName] then HealBot_Config.SkinDefault[SkinName]={} end

    if not Healbot_Config_Skins.HealGroups[SkinName] then 
        HealBot_Skins_ResetHealGroups(SkinName)
    else
        for id=1,5 do
            if Healbot_Config_Skins.HealGroups[SkinName][id]["NAME"] == "My Targets" then
                Healbot_Config_Skins.HealGroups[SkinName][id]["NAME"]=HEALBOT_OPTIONS_MYTARGET
            end
        end
        if not Healbot_Config_Skins.HealGroups[SkinName][15] then 
            for gl=1,15 do
                if not Healbot_Config_Skins.HealGroups[SkinName][gl] then 
                    Healbot_Config_Skins.HealGroups[SkinName][gl]={}
                    Healbot_Config_Skins.HealGroups[SkinName][gl]["STATE"]=false
                end
            end
            Healbot_Config_Skins.HealGroups[SkinName][15]=HealBot_Options_copyTable(Healbot_Config_Skins.HealGroups[SkinName][11])
            Healbot_Config_Skins.HealGroups[SkinName][13]=HealBot_Options_copyTable(Healbot_Config_Skins.HealGroups[SkinName][10])
            Healbot_Config_Skins.HealGroups[SkinName][11]=HealBot_Options_copyTable(Healbot_Config_Skins.HealGroups[SkinName][9])
            Healbot_Config_Skins.HealGroups[SkinName][10]=HealBot_Options_copyTable(Healbot_Config_Skins.HealGroups[SkinName][8])
            Healbot_Config_Skins.HealGroups[SkinName][9]=HealBot_Options_copyTable(Healbot_Config_Skins.HealGroups[SkinName][7])
            Healbot_Config_Skins.HealGroups[SkinName][7]["NAME"]=HEALBOT_OPTIONS_PRIVFOCUS_en
            Healbot_Config_Skins.HealGroups[SkinName][7]["FRAME"]=1
            Healbot_Config_Skins.HealGroups[SkinName][7]["STATE"]=false
            Healbot_Config_Skins.HealGroups[SkinName][8]["FRAME"]=5
            Healbot_Config_Skins.HealGroups[SkinName][8]["STATE"]=false
            Healbot_Config_Skins.HealGroups[SkinName][12]["FRAME"]=8
            Healbot_Config_Skins.HealGroups[SkinName][14]["FRAME"]=9
            Healbot_Config_Skins.HealGroups[SkinName][15]["FRAME"]=10
        end
        Healbot_Config_Skins.HealGroups[SkinName][8]["NAME"]=HEALBOT_OPTIONS_TARGETOFPRIVFOCUSTARGET_en
        Healbot_Config_Skins.HealGroups[SkinName][9]["NAME"]=HEALBOT_VEHICLE_en
        Healbot_Config_Skins.HealGroups[SkinName][10]["NAME"]=HEALBOT_OPTIONS_PETHEALS_en
        Healbot_Config_Skins.HealGroups[SkinName][11]["NAME"]=HEALBOT_OPTIONS_TARGETHEALS_en
        Healbot_Config_Skins.HealGroups[SkinName][12]["NAME"]=HEALBOT_OPTIONS_TARGETOFTARGET_en
        Healbot_Config_Skins.HealGroups[SkinName][13]["NAME"]=HEALBOT_FOCUS_en
        Healbot_Config_Skins.HealGroups[SkinName][14]["NAME"]=HEALBOT_OPTIONS_TARGETOFFOCUS_en
        Healbot_Config_Skins.HealGroups[SkinName][15]["NAME"]=HEALBOT_CUSTOM_CASTBY_ENEMY_en
        for gl=1,15 do
            if not Healbot_Config_Skins.HealGroups[SkinName][gl] then Healbot_Config_Skins.HealGroups[SkinName][gl]={} end
            if not Healbot_Config_Skins.HealGroups[SkinName][gl]["STATE"] then Healbot_Config_Skins.HealGroups[SkinName][gl]["STATE"]=false end
            if not Healbot_Config_Skins.HealGroups[SkinName][gl]["FRAME"] then
                if Healbot_Config_Skins.HealGroups[SkinName][gl]["NAME"] == HEALBOT_CUSTOM_CASTBY_ENEMY_en then
                    Healbot_Config_Skins.HealGroups[SkinName][gl]["FRAME"]=10
                elseif Healbot_Config_Skins.HealGroups[SkinName][gl]["NAME"] == HEALBOT_FOCUS_en or 
                       Healbot_Config_Skins.HealGroups[SkinName][gl]["NAME"] == HEALBOT_OPTIONS_TARGETOFFOCUS_en then
                    Healbot_Config_Skins.HealGroups[SkinName][gl]["FRAME"]=9
                elseif Healbot_Config_Skins.HealGroups[SkinName][gl]["NAME"] == HEALBOT_OPTIONS_TARGETHEALS_en or
                       Healbot_Config_Skins.HealGroups[SkinName][gl]["NAME"] == HEALBOT_OPTIONS_TARGETOFTARGET_en then
                    Healbot_Config_Skins.HealGroups[SkinName][gl]["FRAME"]=8
                elseif  Healbot_Config_Skins.HealGroups[SkinName][gl]["NAME"] == HEALBOT_OPTIONS_TARGETOFPRIVFOCUSTARGET_en then
                    Healbot_Config_Skins.HealGroups[SkinName][gl]["FRAME"]=5
                elseif Healbot_Config_Skins.HealGroups[SkinName][gl]["NAME"] == HEALBOT_OPTIONS_PETHEALS_en then
                    Healbot_Config_Skins.HealGroups[SkinName][gl]["FRAME"]=7
                elseif Healbot_Config_Skins.HealGroups[SkinName][gl]["NAME"] == HEALBOT_VEHICLE_en then
                    Healbot_Config_Skins.HealGroups[SkinName][gl]["FRAME"]=6
                else
                    Healbot_Config_Skins.HealGroups[SkinName][gl]["FRAME"]=1
                end
            elseif Healbot_Config_Skins.HealGroups[SkinName][gl]["NAME"] == HEALBOT_OPTIONS_TARGETOFPRIVFOCUSTARGET_en and Healbot_Config_Skins.HealGroups[SkinName][gl]["FRAME"]>5 then
                Healbot_Config_Skins.HealGroups[SkinName][gl]["FRAME"]=5
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
    if not Healbot_Config_Skins.IconSet[SkinName] then Healbot_Config_Skins.IconSet[SkinName]={} end
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
        if not Healbot_Config_Skins.Anchors[SkinName][gl] then Healbot_Config_Skins.Anchors[SkinName][gl]={} end
    end
    for g=1,8 do
        if Healbot_Config_Skins.FocusGroups[SkinName][g] then Healbot_Config_Skins.FocusGroups[SkinName][g]=nil end
    end
    for gl=1,10 do
        if Healbot_Config_Skins.Icons[SkinName][gl] then
            if Healbot_Config_Skins.Icons[SkinName][gl]["ONBAR"] then Healbot_Config_Skins.Icons[SkinName][gl]["ONBAR"]=nil end
            if Healbot_Config_Skins.Icons[SkinName][gl]["POSITION"] then Healbot_Config_Skins.Icons[SkinName][gl]["POSITION"]=nil end
            if Healbot_Config_Skins.Icons[SkinName][gl]["DOUBLE"] then Healbot_Config_Skins.Icons[SkinName][gl]["DOUBLE"]=nil end
            if Healbot_Config_Skins.Icons[SkinName][gl]["SHOWBUFF"] then Healbot_Config_Skins.Icons[SkinName][gl]["SHOWBUFF"]=nil end
            if Healbot_Config_Skins.Icons[SkinName][gl]["SHOWDEBUFF"] then Healbot_Config_Skins.Icons[SkinName][gl]["SHOWDEBUFF"]=nil end
        end

        if Healbot_Config_Skins.Anchors[SkinName][gl]["Y"] == nil then Healbot_Config_Skins.Anchors[SkinName][gl]["Y"]=(49+gl) end
        if Healbot_Config_Skins.Anchors[SkinName][gl]["X"] == nil then Healbot_Config_Skins.Anchors[SkinName][gl]["X"]=(49+gl) end

        HealBot_Config_Buffs.CBshownAB=nil
        HealBot_Config_Buffs.HealBot_CBWarnRange_Aggro=nil
        HealBot_Config_Cures.CDCshownAB=nil
        HealBot_Config_Cures.HealBot_CDCWarnRange_Aggro=nil
        Healbot_Config_Skins.BarHighlight=nil
    end

    if Healbot_Config_Skins.Sort then Healbot_Config_Skins.Sort=nil end
    if Healbot_Config_Skins.Aggro then Healbot_Config_Skins.Aggro=nil end
    if Healbot_Config_Skins.Highlight then Healbot_Config_Skins.Highlight=nil end

    if Healbot_Config_Skins.Author[SkinName] == nil then Healbot_Config_Skins.Author[SkinName]="Monti of Terenas" end
    if Healbot_Config_Skins.DuplicateBars[SkinName] == nil then Healbot_Config_Skins.DuplicateBars[SkinName]=false end
    if Healbot_Config_Skins.DupBarsPrivList[SkinName] == nil then Healbot_Config_Skins.DupBarsPrivList[SkinName]=true end

    hbv_Skins_CheckRoleCol(SkinName, "TANK", false)
    hbv_Skins_CheckRoleCol(SkinName, "HEALER", false)
    hbv_Skins_CheckRoleCol(SkinName, "DAMAGER", false)
    hbv_Skins_CheckClassCol(SkinName, "DEMO", false)
    hbv_Skins_CheckClassCol(SkinName, "DRUI", false)
    hbv_Skins_CheckClassCol(SkinName, "HUNT", false)
    hbv_Skins_CheckClassCol(SkinName, "MAGE", false)
    hbv_Skins_CheckClassCol(SkinName, "MONK", false)
    hbv_Skins_CheckClassCol(SkinName, "PALA", false)
    hbv_Skins_CheckClassCol(SkinName, "PRIE", false)
    hbv_Skins_CheckClassCol(SkinName, "ROGU", false)
    hbv_Skins_CheckClassCol(SkinName, "SHAM", false)
    hbv_Skins_CheckClassCol(SkinName, "WARL", false)
    hbv_Skins_CheckClassCol(SkinName, "DEAT", false)
    hbv_Skins_CheckClassCol(SkinName, "WARR", false)
    hbv_Skins_CheckClassCol(SkinName, "EVOK", false)
    hbv_Skins_CheckPowerCol(SkinName, "MANA", false)
    hbv_Skins_CheckPowerCol(SkinName, "RAGE", false)
    hbv_Skins_CheckPowerCol(SkinName, "FOCUS", false)
    hbv_Skins_CheckPowerCol(SkinName, "ENERGY", false)
    hbv_Skins_CheckPowerCol(SkinName, "RUNIC_POWER", false)
    hbv_Skins_CheckPowerCol(SkinName, "INSANITY", false)
    hbv_Skins_CheckPowerCol(SkinName, "LUNAR_POWER", false)
    hbv_Skins_CheckPowerCol(SkinName, "MAELSTROM", false)
    hbv_Skins_CheckPowerCol(SkinName, "FURY", false)

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
    Healbot_Config_Skins.HealGroups[SkinName][15]["FRAME"]=10
    if Healbot_Config_Skins.HealGroups[SkinName][14]["FRAME"]>5 and Healbot_Config_Skins.HealGroups[SkinName][14]["FRAME"]~=9 then
        Healbot_Config_Skins.HealGroups[SkinName][14]["FRAME"]=9
    end
    if Healbot_Config_Skins.HealGroups[SkinName][13]["FRAME"]>5 and Healbot_Config_Skins.HealGroups[SkinName][13]["FRAME"]~=9 then
        Healbot_Config_Skins.HealGroups[SkinName][13]["FRAME"]=9
    end
    if Healbot_Config_Skins.HealGroups[SkinName][11]["FRAME"]>5 and Healbot_Config_Skins.HealGroups[SkinName][11]["FRAME"]~=8 then
        Healbot_Config_Skins.HealGroups[SkinName][11]["FRAME"]=8
    end
    if Healbot_Config_Skins.HealGroups[SkinName][12]["FRAME"]>5 and Healbot_Config_Skins.HealGroups[SkinName][12]["FRAME"]~=8 then
        Healbot_Config_Skins.HealGroups[SkinName][12]["FRAME"]=8
    end
    if Healbot_Config_Skins.HealGroups[SkinName][10]["FRAME"]>5 and Healbot_Config_Skins.HealGroups[SkinName][10]["FRAME"]~=7 then
        Healbot_Config_Skins.HealGroups[SkinName][10]["FRAME"]=7
    end
    if Healbot_Config_Skins.HealGroups[SkinName][9]["FRAME"]>6 then
        Healbot_Config_Skins.HealGroups[SkinName][9]["FRAME"]=6
    end
    hbv_Skins_SetFrameVar(HEALBOT_WORD_VEHICLE, "FrameAlias", "ALIAS", 6)
    hbv_Skins_SetFrameVar(HEALBOT_OPTIONS_PETHEALS, "FrameAlias", "ALIAS", 7)
    hbv_Skins_SetFrameVar(HEALBOT_OPTIONS_TARGETHEALS, "FrameAlias", "ALIAS", 8)
    hbv_Skins_SetFrameVar(HEALBOT_WORD_FOCUS, "FrameAlias", "ALIAS", 9)
    hbv_Skins_SetFrameVar(HEALBOT_CUSTOM_CASTBY_ENEMY, "FrameAlias", "ALIAS", 10)

    for id=1,8 do
        if Healbot_Config_Skins.HealGroups[SkinName][id]["FRAME"]>5 then
            Healbot_Config_Skins.HealGroups[SkinName][id]["FRAME"]=1
        end
    end
    HealBot_Skins_Clear_UnusedSkin(SkinName)
    hbv_Skins_VarsHasSkin()
    Healbot_Config_Skins.General[SkinName]["VC"]=HealBot_Global_Version()
end
