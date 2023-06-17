local LSM = HealBot_Libs_LSM() --LibStub("LibSharedMedia-3.0")
local frameScale = 1
local framePad = 1
local bheight = 20
local bWidth = 120
local pWidth = 120
local EnemyTargetBarSize = 40
local bOutline = 1
local btextheight,btextheight2,btextheight3,btextheight4=10,10,10,10
local btextoutline,btextoutline2,btextoutline3,btextoutline4=1,1,1,1
local b,bar,icon,txt,pIcon,expire,count=nil,nil,nil,nil,nil,nil,nil,nil
local Aux1,Aux2,Aux3,Aux4,Aux5,Aux6,Aux7,AuxBelow,AuxAbove,AuxLeft,AuxRight=nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil
local AuxIdx={[1]={},[2]={},[3]={},[4]={},[5]={},[6]={},[7]={},[8]={},[9]={}}
local icon1,expire1,count1,icon51,expire51,count51=nil,nil,nil,nil,nil,nil
local barScale,h,hwidth,hheight,iScale,diScale,itScale,x,hcpct=nil,nil,nil,nil,nil,nil,nil,nil,nil
local abtSize = {[0]=1,[1]=1,[2]=1,[3]=2,[4]=2,[5]=2,[6]=3,[7]=3,[8]=3,[9]=3,[10]=4,[11]=4,[12]=4,[13]=4,[14]=4,[15]=5}
local auxWidth,auxHeight,auxTmp,auxOffsetBelow,auxOffsetLeft,auxOffsetRight=0,0,0,0,0,0
local AuxOverlapOffset=0
local tBarsConcat={}
local erButton=nil
local iAnchors={["ICON"]="", ["BUTTON"]="", ["DOUBLE"]="", ["RELATIVE"]="", ["TXTCOUNT"]="", ["TXTEXPIRE"]="", ["INDSELFCAST"]="", ["TXTEXPIREX"]=1, ["TXTCOUNTX"]=1}
local HealBot_Skins_luVars={}
HealBot_Skins_luVars["AuxReset"]=false

function HealBot_Skins_setLuVars(vName, vValue)
    HealBot_Skins_luVars[vName]=vValue
      --HealBot_setCall("HealBot_Action_setLuVars - "..vName)
end

function HealBot_Skins_retLuVars(vName)
    --HealBot_setCall("HealBot_Action_retLuVars")
    return HealBot_Skins_luVars[vName]
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
    return tabconcat(tBarsConcat,"",1,elements)
end

local testBarsOn=false
function HealBot_Skins_isTestBars(state)
    testBarsOn=state
end

local testPowerOn=0
function HealBot_Skins_showPowerCounter(maxPower)
    testPowerOn=maxPower
end

function HealBot_Skins_AdjustSpecialBarWidth(button)
    EnemyTargetBarSize=(Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["ENEMYTARGETSIZE"]/100)
    if HealBot_Panel_isSpecialUnit(button.unit)==1 then
        bWidth=bWidth*(1-EnemyTargetBarSize)
        bWidth=bWidth-((Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][button.frame]["CMARGIN"])+(bOutline*2))
        if Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["DOUBLEWIDTH"] then bWidth=bWidth*2 end
        HealBot_Text_setEnemySizeWidth("EnemySizeWidth1", bWidth, EnemyTargetBarSize)
        HealBot_Action_SetBackSpecialWidth(10, 0)
    else
        bWidth=bWidth*EnemyTargetBarSize
        if Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["DOUBLEWIDTH"] then bWidth=bWidth*2 end
        HealBot_Text_setEnemySizeWidth("EnemySizeWidth2", bWidth, EnemyTargetBarSize)
        HealBot_Action_SetBackSpecialWidth(10, bWidth+Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][button.frame]["CMARGIN"])
    end
    
end

function HealBot_Skins_ResetSkinWidth(button)
    frameScale = Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][button.frame]["SCALE"]
    bWidth = ceil(Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][button.frame]["WIDTH"]*frameScale);
    bOutline = ceil(Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["BOUT"]*frameScale);
    if button.frame==10 and HealBot_Panel_isSpecialUnit(button.unit)>0 then
        HealBot_Skins_AdjustSpecialBarWidth(button)
    end
    button.gref["Bar"]:SetWidth(bWidth)
    button.gref["Back"]:SetWidth(bWidth+(bOutline*2))
    button.gref["InHeal"]:SetWidth(bWidth)
    button.gref["Absorb"]:SetWidth(bWidth)
    button:SetWidth(bWidth)
    auxWidth=0
    for x=1,9 do
        if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["USE"]>1 and 
           Healbot_Config_Skins.AuxBarFrame[Healbot_Config_Skins.Current_Skin][button.frame]["OVERLAP"]==2 and 
           Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["ANCHOR"]>2 and 
           Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["ANCHOR"]<5 then
            auxTmp=auxWidth
            auxWidth=auxWidth+Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["DEPTH"]
            auxWidth=auxWidth+Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["OFFSET"]
            if auxWidth<auxTmp then auxWidth=auxTmp end
        end
    end
    auxWidth=ceil(auxWidth*frameScale)
    for x=1,9 do
        if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["USE"]>1 then
            if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["ANCHOR"]<3 or Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["ANCHOR"]>4 then
                if Healbot_Config_Skins.AuxBarFrame[Healbot_Config_Skins.Current_Skin][button.frame]["OVERLAP"]==2 then
                    button.gref.aux[x]:SetWidth(ceil((bWidth+auxWidth)*Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["SIZE"]))
                else
                    button.gref.aux[x]:SetWidth(ceil(bWidth*Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["SIZE"]))
                end
            else
                button.gref.aux[x]:SetWidth(Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["DEPTH"])
            end
        end
    end
end

function HealBot_Skins_setEmergAnchor(position)
    if position==1 then
        return "TOPLEFT"
    elseif position==2 then
        return "BOTTOMLEFT"
    elseif position==3 then
        return "TOPRIGHT"
    elseif position==4 then
        return "BOTTOMRIGHT"
    elseif position==5 then
        return "TOP"
    elseif position==6 then
        return "LEFT"
    elseif position==7 then
        return "RIGHT"
    else
        return "BOTTOM"
    end
end

iAnchors["TXTCOUNT"]="TOPLEFT"; iAnchors["TXTEXPIRE"]="BOTTOMRIGHT"; iAnchors["TXTEXPIREX"]=2; iAnchors["TXTCOUNTX"]=-2
function HealBot_Skins_setIconAnchors(onBar, position, extra)
    if extra then
        if onBar==1 then
            if position==1 then
                iAnchors["ICON"]="LEFT"; iAnchors["BUTTON"]="LEFT";
            elseif position==2 then
                iAnchors["ICON"]="RIGHT"; iAnchors["BUTTON"]="RIGHT";
            elseif position==3 then
                iAnchors["ICON"]="TOP"; iAnchors["BUTTON"]="TOP";
            elseif position==4 then
                iAnchors["ICON"]="BOTTOM"; iAnchors["BUTTON"]="BOTTOM";
            elseif position==5 then
                iAnchors["ICON"]="TOPLEFT"; iAnchors["BUTTON"]="TOPLEFT";
            elseif position==6 then
                iAnchors["ICON"]="TOPRIGHT"; iAnchors["BUTTON"]="TOPRIGHT";
            elseif position==7 then
                iAnchors["ICON"]="BOTTOMLEFT"; iAnchors["BUTTON"]="BOTTOMLEFT";
            else
                iAnchors["ICON"]="BOTTOMRIGHT"; iAnchors["BUTTON"]="BOTTOMRIGHT";
            end
        elseif onBar==2 then
            if position==1 then
                iAnchors["ICON"]="RIGHT"; iAnchors["BUTTON"]="LEFT";
            else
                iAnchors["ICON"]="LEFT"; iAnchors["BUTTON"]="RIGHT";
            end
        else
            if position==1 then
                iAnchors["ICON"]="TOPLEFT"; iAnchors["BUTTON"]="BOTTOMLEFT";
            elseif position==2 then
                iAnchors["ICON"]="TOPRIGHT"; iAnchors["BUTTON"]="BOTTOMRIGHT";
            else
                iAnchors["ICON"]="TOP"; iAnchors["BUTTON"]="BOTTOM";
            end
        end
    else
        if onBar==1 then
            if position==1 then
                iAnchors["ICON"]="BOTTOMLEFT"; iAnchors["BUTTON"]="BOTTOMLEFT"; iAnchors["DOUBLE"]="TOPLEFT"; iAnchors["RELATIVE"]="BOTTOMRIGHT"; 
            --    iAnchors["TXTCOUNT"]="TOPRIGHT"; iAnchors["TXTEXPIRE"]="BOTTOMLEFT"; iAnchors["TXTEXPIREX"]=-2; iAnchors["TXTCOUNTX"]=2
                if Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["SANCHOR"]==1 then
                    iAnchors["INDSELFCAST"]="TOPLEFT"
                else
                    iAnchors["INDSELFCAST"]="BOTTOMRIGHT"
                end
            elseif position==2 then
                iAnchors["ICON"]="BOTTOMRIGHT"; iAnchors["BUTTON"]="BOTTOMRIGHT"; iAnchors["DOUBLE"]="TOPRIGHT"; iAnchors["RELATIVE"]="BOTTOMLEFT"; 
            --    iAnchors["TXTCOUNT"]="TOPLEFT"; iAnchors["TXTEXPIRE"]="BOTTOMRIGHT"; iAnchors["TXTEXPIREX"]=2; iAnchors["TXTCOUNTX"]=-1
                if Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["SANCHOR"]==1 then
                    iAnchors["INDSELFCAST"]="TOPRIGHT"
                else
                    iAnchors["INDSELFCAST"]="BOTTOMLEFT"
                end
            elseif position==3 then
                iAnchors["ICON"]="TOPLEFT"; iAnchors["BUTTON"]="TOPLEFT"; iAnchors["DOUBLE"]="BOTTOMLEFT"; iAnchors["RELATIVE"]="TOPRIGHT"; 
            --    iAnchors["TXTCOUNT"]="TOPRIGHT"; iAnchors["TXTEXPIRE"]="BOTTOMLEFT"; iAnchors["TXTEXPIREX"]=-2; iAnchors["TXTCOUNTX"]=2
                if Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["SANCHOR"]==1 then
                    iAnchors["INDSELFCAST"]="TOPLEFT"
                else
                    iAnchors["INDSELFCAST"]="BOTTOMRIGHT"
                end
            elseif position==4 then
                iAnchors["ICON"]="TOPRIGHT"; iAnchors["BUTTON"]="TOPRIGHT"; iAnchors["DOUBLE"]="BOTTOMRIGHT"; iAnchors["RELATIVE"]="TOPLEFT"; 
            --    iAnchors["TXTCOUNT"]="TOPLEFT"; iAnchors["TXTEXPIRE"]="BOTTOMRIGHT"; iAnchors["TXTEXPIREX"]=2; iAnchors["TXTCOUNTX"]=-1
                if Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["SANCHOR"]==1 then
                    iAnchors["INDSELFCAST"]="TOPRIGHT"
                else
                    iAnchors["INDSELFCAST"]="BOTTOMLEFT"
                end
            elseif position==5 then
                iAnchors["ICON"]="BOTTOMRIGHT"; iAnchors["BUTTON"]="BOTTOM"; iAnchors["DOUBLE"]="TOPRIGHT"; iAnchors["RELATIVE"]="BOTTOMLEFT"; 
            --    iAnchors["TXTCOUNT"]="TOPLEFT"; iAnchors["TXTEXPIRE"]="BOTTOMRIGHT"; iAnchors["TXTEXPIREX"]=2; iAnchors["TXTCOUNTX"]=-1
                if Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["SANCHOR"]==1 then
                    iAnchors["INDSELFCAST"]="TOPRIGHT"
                else
                    iAnchors["INDSELFCAST"]="BOTTOMLEFT"
                end
            elseif position==6 then
                iAnchors["ICON"]="BOTTOMLEFT"; iAnchors["BUTTON"]="BOTTOM"; iAnchors["DOUBLE"]="TOPLEFT"; iAnchors["RELATIVE"]="BOTTOMRIGHT"; 
            --    iAnchors["TXTCOUNT"]="TOPRIGHT"; iAnchors["TXTEXPIRE"]="BOTTOMLEFT"; iAnchors["TXTEXPIREX"]=-2; iAnchors["TXTCOUNTX"]=2
                if Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["SANCHOR"]==1 then
                    iAnchors["INDSELFCAST"]="TOPLEFT"
                else
                    iAnchors["INDSELFCAST"]="BOTTOMRIGHT"
                end
            elseif position==7 then
                iAnchors["ICON"]="TOPRIGHT"; iAnchors["BUTTON"]="TOP"; iAnchors["DOUBLE"]="BOTTOMRIGHT"; iAnchors["RELATIVE"]="TOPLEFT"; 
            --    iAnchors["TXTCOUNT"]="TOPLEFT"; iAnchors["TXTEXPIRE"]="BOTTOMRIGHT"; iAnchors["TXTEXPIREX"]=2; iAnchors["TXTCOUNTX"]=-1
                if Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["SANCHOR"]==1 then
                    iAnchors["INDSELFCAST"]="TOPRIGHT"
                else
                    iAnchors["INDSELFCAST"]="BOTTOMLEFT"
                end
            else
                iAnchors["ICON"]="TOPLEFT"; iAnchors["BUTTON"]="TOP"; iAnchors["DOUBLE"]="BOTTOMLEFT"; iAnchors["RELATIVE"]="TOPRIGHT"; 
            --    iAnchors["TXTCOUNT"]="TOPRIGHT"; iAnchors["TXTEXPIRE"]="BOTTOMLEFT"; iAnchors["TXTEXPIREX"]=-2; iAnchors["TXTCOUNTX"]=2
                if Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["SANCHOR"]==1 then
                    iAnchors["INDSELFCAST"]="TOPLEFT"
                else
                    iAnchors["INDSELFCAST"]="BOTTOMRIGHT"
                end
            end
        elseif onBar==2 then
            if position==1 then
                iAnchors["ICON"]="BOTTOMRIGHT"; iAnchors["BUTTON"]="BOTTOMLEFT"; iAnchors["DOUBLE"]="TOPRIGHT"; iAnchors["RELATIVE"]="BOTTOMLEFT"; 
            --    iAnchors["TXTCOUNT"]="TOPLEFT"; iAnchors["TXTEXPIRE"]="BOTTOMRIGHT"; iAnchors["TXTEXPIREX"]=2; iAnchors["TXTCOUNTX"]=-1
                if Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["SANCHOR"]==1 then
                    iAnchors["INDSELFCAST"]="TOPRIGHT"
                else
                    iAnchors["INDSELFCAST"]="BOTTOMLEFT"
                end
            elseif position==2 then
                iAnchors["ICON"]="BOTTOMLEFT"; iAnchors["BUTTON"]="BOTTOMRIGHT"; iAnchors["DOUBLE"]="TOPLEFT"; iAnchors["RELATIVE"]="BOTTOMRIGHT"; 
            --    iAnchors["TXTCOUNT"]="TOPRIGHT"; iAnchors["TXTEXPIRE"]="BOTTOMLEFT"; iAnchors["TXTEXPIREX"]=-2; iAnchors["TXTCOUNTX"]=2
                if Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["SANCHOR"]==1 then
                    iAnchors["INDSELFCAST"]="TOPLEFT"
                else
                    iAnchors["INDSELFCAST"]="BOTTOMRIGHT"
                end
            elseif position==3 then
                iAnchors["ICON"]="TOPRIGHT"; iAnchors["BUTTON"]="TOPLEFT"; iAnchors["DOUBLE"]="BOTTOMRIGHT"; iAnchors["RELATIVE"]="TOPLEFT"; 
            --    iAnchors["TXTCOUNT"]="TOPLEFT"; iAnchors["TXTEXPIRE"]="BOTTOMRIGHT";  iAnchors["TXTEXPIREX"]=2; iAnchors["TXTCOUNTX"]=-1
                if Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["SANCHOR"]==1 then
                    iAnchors["INDSELFCAST"]="TOPRIGHT"
                else
                    iAnchors["INDSELFCAST"]="BOTTOMLEFT"
                end
            else
                iAnchors["ICON"]="TOPLEFT"; iAnchors["BUTTON"]="TOPRIGHT"; iAnchors["DOUBLE"]="BOTTOMLEFT"; iAnchors["RELATIVE"]="TOPRIGHT"; 
            --    iAnchors["TXTCOUNT"]="TOPRIGHT"; iAnchors["TXTEXPIRE"]="BOTTOMLEFT"; iAnchors["TXTEXPIREX"]=-2; iAnchors["TXTCOUNTX"]=2
                if Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["SANCHOR"]==1 then
                    iAnchors["INDSELFCAST"]="TOPLEFT"
                else
                    iAnchors["INDSELFCAST"]="BOTTOMRIGHT"
                end
            end
        else
            if position==1 then
                iAnchors["ICON"]="TOPLEFT"; iAnchors["BUTTON"]="BOTTOMLEFT"; iAnchors["DOUBLE"]="BOTTOMLEFT"; iAnchors["RELATIVE"]="TOPRIGHT"; 
            --    iAnchors["TXTCOUNT"]="TOPRIGHT"; iAnchors["TXTEXPIRE"]="BOTTOMLEFT"; iAnchors["TXTEXPIREX"]=-2; iAnchors["TXTCOUNTX"]=2
                if Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["SANCHOR"]==1 then
                    iAnchors["INDSELFCAST"]="TOPLEFT"
                else
                    iAnchors["INDSELFCAST"]="BOTTOMRIGHT"
                end
            else
                iAnchors["ICON"]="TOPRIGHT"; iAnchors["BUTTON"]="BOTTOMRIGHT"; iAnchors["DOUBLE"]="BOTTOMRIGHT"; iAnchors["RELATIVE"]="TOPLEFT"; 
            --    iAnchors["TXTCOUNT"]="TOPLEFT"; iAnchors["TXTEXPIRE"]="BOTTOMRIGHT"; iAnchors["TXTEXPIREX"]=2; iAnchors["TXTCOUNTX"]=-1
                if Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["SANCHOR"]==1 then
                    iAnchors["INDSELFCAST"]="TOPRIGHT"
                else
                    iAnchors["INDSELFCAST"]="BOTTOMLEFT"
                end
            end
        end
    end
end

function HealBot_Skins_setIconSpacer(anchor, space)
    if anchor==2 or anchor==4 or anchor==5 or anchor==7 then
        iAnchors["ICONHSPACE"]=0-space
    else
        iAnchors["ICONHSPACE"]=space
    end
    if anchor==3 or anchor==4 or anchor==7 or anchor==8 then
        iAnchors["ICONVSPACE"]=0-space
    else
        iAnchors["ICONVSPACE"]=space
    end
end

local indOffset=0
function HealBot_Skins_IndicatorVOffset(anchor, offset, frame)
    if anchor==1 or anchor==5 or anchor==7 then
        indOffset=0+offset
    else
        indOffset=0-offset
    end
    return ceil(indOffset*Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][frame]["SCALE"])
end

local tmpHeightOffset=0
function HealBot_Skins_ResetSkin(barType,button,numcols)
    if button and button.frame then 
        frameScale=Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][button.frame]["SCALE"]
        framePad=Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][button.frame]["PADDING"] or 1
        bheight=ceil(Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][button.frame]["HEIGHT"]*frameScale);
        bWidth=ceil(Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][button.frame]["WIDTH"]*frameScale);
        bOutline=ceil(Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["BOUT"]*frameScale);
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
            if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["USE"]>1 then
                auxTmp=Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["DEPTH"]+Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["OFFSET"]
                if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["ANCHOR"]<3 or Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["ANCHOR"]>4 then
                    if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["ANCHOR"]==1 or
                       Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["ANCHOR"]==5 or
                       Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["ANCHOR"]==6 then
                        auxOffsetBelow=auxOffsetBelow+auxTmp
                    end
                    auxHeight=auxHeight+auxTmp
                else
                    if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["ANCHOR"]==3 then
                        auxOffsetLeft=auxOffsetLeft+auxTmp
                    else
                        auxOffsetRight=auxOffsetRight+auxTmp
                    end
                    auxWidth=auxWidth+auxTmp
                end
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

    if barType=="bar" then
        b=button
        if b.skinreset then
            pWidth=bWidth
            if button.frame==10 and HealBot_Panel_isSpecialUnit(button.unit)>0 then
                HealBot_Skins_AdjustSpecialBarWidth(button)        
                if Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["DOUBLEWIDTH"] then 
                    pWidth=pWidth*(2-(pWidth/7800))
                end
            end
            if HealBot_Action_SetBackBarHeightWidth(button.frame, (bheight+auxHeight+(bOutline*2)), (pWidth+auxWidth+(bOutline*2)), framePad) then
                HealBot_Skins_luVars["AuxReset"]=true
            end
            if HealBot_Skins_luVars["AuxReset"] then
                b.auxreset=true
            end

            b:SetHeight(bheight); 
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
            
            b.gref["InHeal"]:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][b.frame]["TEXTURE"]));
            b.gref["InHeal"]:GetStatusBarTexture():SetHorizTile(false)
            b.gref["Absorb"]:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][b.frame]["TEXTURE"]));
            b.gref["Absorb"]:GetStatusBarTexture():SetHorizTile(false)

            if Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][b.frame]["OFIX"]==1 then
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
                erButton.bar:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.Emerg[Healbot_Config_Skins.Current_Skin][b.frame]["TEXTURE"]));
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
                --erButton:Show()
            else
                erButton.bar:ClearAllPoints()
                erButton.bar:SetStatusBarColor(0,0,0,0)
            end

            tBarsConcat[1]="f"
            tBarsConcat[2]=b.frame
            tBarsConcat[3]="_HealBot_Action"
            local gaf = _G[HealBot_Skins_Concat(3)]
            b.gref["Bar"]:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][b.frame]["TEXTURE"]));
            b.gref["Bar"]:GetStatusBarTexture():SetHorizTile(false)
            b.gref["Bar"]:ClearAllPoints()
            b.gref["Bar"]:SetPoint("BOTTOMLEFT",b.gref["Back"],"BOTTOMLEFT",auxOffsetLeft+bOutline,auxOffsetBelow+bOutline)
            if b.gref["BackBorder"].size~=ceil(Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][b.frame]["BORSIZE"]*frameScale) then
                b.gref["BackBorder"]:SetBackdrop({
                                            edgeFile = "Interface\\Buttons\\WHITE8X8",
                                            edgeSize = ceil(Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][b.frame]["BORSIZE"]*frameScale),
                                            })
                b.gref["BackBorder"]:SetPoint("TOPLEFT", b.gref["Back"], "TOPLEFT",0,0)
                b.gref["BackBorder"]:SetPoint("BOTTOMRIGHT", b.gref["Back"], "BOTTOMRIGHT",0,0)
                b.gref["BackBorder"]:SetBackdropBorderColor(0, 0, 0, 0)
                b.gref["BackBorder"].size=ceil(Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][b.frame]["BORSIZE"]*frameScale)
            end
            HealBot_Action_UpdateBackgroundBorder(button)

            b.skinreset=false
        end
        
        if b.auxreset then
            AuxBelow,AuxAbove,AuxLeft,AuxRight=b.gref["Bar"],b.gref["Bar"],b.gref["Bar"],b.gref["Bar"]
            AuxOverlapOffset=0
            for x=1,9 do
                if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["USE"]>1 then
                    b.gref.aux[x]:ClearAllPoints()
                    if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["ANCHOR"]<5 then
                        if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["ANCHOR"]<3 then
                            b.gref.aux[x]:SetOrientation("HORIZONTAL")
                            if Healbot_Config_Skins.AuxBarFrame[Healbot_Config_Skins.Current_Skin][button.frame]["OVERLAP"]==2 then
                                b.gref.aux[x]:SetWidth(ceil((bWidth+auxWidth)*Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["SIZE"]))
                                AuxOverlapOffset=ceil(((bWidth+auxWidth)*(1-Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["SIZE"]))/2)
                            else
                                b.gref.aux[x]:SetWidth(ceil(bWidth*Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["SIZE"]))
                            end
                            b.gref.aux[x]:SetHeight(ceil(Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["DEPTH"]*frameScale))
                            if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["ANCHOR"]==1 then
                                b.gref.aux[x]:SetPoint("TOP",AuxBelow,"BOTTOM",0,-(ceil(Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["OFFSET"])*frameScale))
                                AuxBelow=b.gref.aux[x]
                            else
                                b.gref.aux[x]:SetPoint("BOTTOM",AuxAbove,"TOP",0,ceil(Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["OFFSET"]*frameScale))
                                AuxAbove=b.gref.aux[x]
                            end
                            if Healbot_Config_Skins.AuxBarFrame[Healbot_Config_Skins.Current_Skin][button.frame]["OVERLAP"]==2 then
                                b.gref.aux[x]:SetPoint("RIGHT",b.gref["Back"],"RIGHT",-(bOutline+AuxOverlapOffset),0)
                            else
                                b.gref.aux[x]:SetPoint("CENTER",b.gref["Bar"],"CENTER",0,0)
                            end
                        else
                            b.gref.aux[x]:SetOrientation("VERTICAL")
                            b.gref.aux[x]:SetWidth(ceil(Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["DEPTH"]*frameScale))
                            if Healbot_Config_Skins.AuxBarFrame[Healbot_Config_Skins.Current_Skin][button.frame]["OVERLAP"]==1 then
                                b.gref.aux[x]:SetHeight(ceil((bheight+auxHeight)*Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["SIZE"]))
                                b.gref.aux[x]:SetPoint("TOP",b.gref["Back"],"TOP",0,-(bOutline))
                            else
                                b.gref.aux[x]:SetHeight(ceil(bheight*Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["SIZE"]))
                            end
                            if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["ANCHOR"]==3 then
                                b.gref.aux[x]:SetPoint("RIGHT",AuxLeft,"LEFT",-(ceil(Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["OFFSET"]*frameScale)),0)
                                AuxLeft=b.gref.aux[x]
                            else
                                b.gref.aux[x]:SetPoint("LEFT",AuxRight,"RIGHT",ceil(Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["OFFSET"]*frameScale),0)
                                AuxRight=b.gref.aux[x]
                            end
                        end
                    else
                        b.gref.aux[x]:SetOrientation("HORIZONTAL")
                        if Healbot_Config_Skins.AuxBarFrame[Healbot_Config_Skins.Current_Skin][button.frame]["OVERLAP"]==2 then
                            b.gref.aux[x]:SetWidth(ceil((bWidth+auxWidth)*Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["SIZE"]))
                        else
                            b.gref.aux[x]:SetWidth(ceil(bWidth*Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["SIZE"]))
                        end
                        b.gref.aux[x]:SetHeight(ceil(Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["DEPTH"]*frameScale))
                        if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["ANCHOR"]==5 then
                            b.gref.aux[x]:SetPoint("TOP",AuxBelow,"BOTTOM",0,-(ceil(Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["OFFSET"])*frameScale))
                            if Healbot_Config_Skins.AuxBarFrame[Healbot_Config_Skins.Current_Skin][button.frame]["OVERLAP"]==2 then
                                b.gref.aux[x]:SetPoint("LEFT",b.gref["Bar"],"LEFT",-auxOffsetLeft,0)
                            else
                                b.gref.aux[x]:SetPoint("LEFT",b.gref["Bar"],"LEFT",0,0)
                            end
                            AuxBelow=b.gref.aux[x]
                        elseif Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["ANCHOR"]==6 then
                            b.gref.aux[x]:SetPoint("TOP",AuxBelow,"BOTTOM",0,-(ceil(Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["OFFSET"])*frameScale))
                            if Healbot_Config_Skins.AuxBarFrame[Healbot_Config_Skins.Current_Skin][button.frame]["OVERLAP"]==2 then
                                b.gref.aux[x]:SetPoint("RIGHT",b.gref["Bar"],"RIGHT",auxOffsetRight,0)
                            else
                                b.gref.aux[x]:SetPoint("RIGHT",b.gref["Bar"],"RIGHT",0,0)
                            end
                            AuxBelow=b.gref.aux[x]
                        elseif Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["ANCHOR"]==7 then
                            b.gref.aux[x]:SetPoint("BOTTOM",AuxAbove,"TOP",0,ceil(Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["OFFSET"]*frameScale))
                            if Healbot_Config_Skins.AuxBarFrame[Healbot_Config_Skins.Current_Skin][button.frame]["OVERLAP"]==2 then
                                b.gref.aux[x]:SetPoint("LEFT",b.gref["Bar"],"LEFT",-auxOffsetLeft,0)
                            else
                                b.gref.aux[x]:SetPoint("LEFT",b.gref["Bar"],"LEFT",0,0)
                            end
                            AuxAbove=b.gref.aux[x]
                        else
                            b.gref.aux[x]:SetPoint("BOTTOM",AuxAbove,"TOP",0,ceil(Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["OFFSET"]*frameScale))
                            if Healbot_Config_Skins.AuxBarFrame[Healbot_Config_Skins.Current_Skin][button.frame]["OVERLAP"]==2 then
                                b.gref.aux[x]:SetPoint("RIGHT",b.gref["Bar"],"RIGHT",auxOffsetRight,0)
                            else
                                b.gref.aux[x]:SetPoint("RIGHT",b.gref["Bar"],"RIGHT",0,0)
                            end
                            AuxAbove=b.gref.aux[x]
                        end
                    end
                    b.gref.aux[x]:SetMinMaxValues(0,1000)
                    b.gref.aux[x]:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][b.frame]["TEXTURE"]))
                    b.gref.aux[x]:GetStatusBarTexture():SetHorizTile(false)
                else
                    b.gref.aux[x]:SetStatusBarColor(0,0,0,0)
                    b.gref.auxtxt[x]:SetText("")
                end 
            end
            b.auxreset=false
        end
        
        if b.text.reset then
            b.gref.txt["text"]:SetFont(LSM:Fetch('font',Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["FONT"]),
                            btextheight,
                            HealBot_Font_Outline[btextoutline]);
            b.gref.txt["text2"]:SetFont(LSM:Fetch('font',Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["HFONT"]),
                            btextheight2,
                            HealBot_Font_Outline[btextoutline2]);
            b.gref.txt["text3"]:SetFont(LSM:Fetch('font',Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["SFONT"]),
                            btextheight3,
                            HealBot_Font_Outline[btextoutline3]);
            b.gref.txt["text4"]:SetFont(LSM:Fetch('font',Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["AFONT"]),
                            btextheight4,
                            HealBot_Font_Outline[btextoutline4]);
            if btextheight2-HealBot_Globals.VehicleFontSizeReduction<2 then
                b.gref.txt["text5"]:SetFont(LSM:Fetch('font',Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["HFONT"]),
                                2,
                                HealBot_Font_Outline[btextoutline2]);
            else
                b.gref.txt["text5"]:SetFont(LSM:Fetch('font',Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["HFONT"]),
                                btextheight2-HealBot_Globals.VehicleFontSizeReduction,
                                HealBot_Font_Outline[btextoutline2]);
            end

            b.gref.txt["text"]:SetWidth(bWidth)
            b.gref.txt["text2"]:SetWidth(bWidth)
            b.gref.txt["text3"]:SetWidth(bWidth)
            b.gref.txt["text4"]:SetWidth(bWidth)
            for x=1,9 do
                b.gref.auxtxt[x]:SetFont(LSM:Fetch('font',Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Current_Skin][x][b.frame]["FONT"]),
                                ceil(Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Current_Skin][x][b.frame]["HEIGHT"]*frameScale),
                                HealBot_Font_Outline[Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Current_Skin][x][b.frame]["OUTLINE"]]);
                b.gref.auxtxt[x]:ClearAllPoints();
                b.gref.auxtxt[x]:SetWidth(ceil((bWidth+auxWidth)*Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][b.frame]["SIZE"]))
                if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][b.frame]["ANCHOR"]<3 or Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][b.frame]["ANCHOR"]>4 then
                    b.gref.auxtxt[x]:SetWordWrap(false)
                else
                    b.gref.auxtxt[x]:SetWordWrap(true)
                end
                if Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Current_Skin][x][b.frame]["ALIGN"]==1 then
                    b.gref.auxtxt[x]:SetPoint("LEFT",b.gref.aux[x],"LEFT",ceil(Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Current_Skin][x][b.frame]["HOFFSET"]*frameScale),ceil(Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Current_Skin][x][b.frame]["OFFSET"]*frameScale))
                    b.gref.auxtxt[x]:SetJustifyH("LEFT")
                elseif Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Current_Skin][x][b.frame]["ALIGN"]==2 then
                    b.gref.auxtxt[x]:SetPoint("CENTER",b.gref.aux[x],"CENTER",ceil(Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Current_Skin][x][b.frame]["HOFFSET"]*frameScale),ceil(Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Current_Skin][x][b.frame]["OFFSET"]*frameScale))
                    b.gref.auxtxt[x]:SetJustifyH("CENTER")
                else
                    b.gref.auxtxt[x]:SetPoint("RIGHT",b.gref.aux[x],"RIGHT",ceil(Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Current_Skin][x][b.frame]["HOFFSET"]*frameScale),ceil(Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Current_Skin][x][b.frame]["OFFSET"]*frameScale))
                    b.gref.auxtxt[x]:SetJustifyH("RIGHT")
                end
            end
            b.gref.txt["text"]:ClearAllPoints();
            b.gref.txt["text2"]:ClearAllPoints();
            b.gref.txt["text3"]:ClearAllPoints();
            b.gref.txt["text4"]:ClearAllPoints();
            b.gref.txt["text5"]:ClearAllPoints();

            b.gref.txt["text"]:SetPoint("CENTER",b.gref["Bar"],"CENTER",ceil(Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["OFFSET2"]*frameScale),ceil((5+Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["OFFSET"])*frameScale))
            if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["ALIGN"]==1 then
                b.gref.txt["text"]:SetJustifyH("LEFT")
            elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["ALIGN"]==2 then
                b.gref.txt["text"]:SetJustifyH("CENTER")
            else
                b.gref.txt["text"]:SetJustifyH("RIGHT")
            end
            if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["HLTHTXTANCHOR"]<4 then
                b.gref.txt["text2"]:SetPoint("CENTER",b.gref["Bar"],"CENTER",ceil(Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["HOFFSET2"]*frameScale),ceil((-7+Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["HOFFSET"])*frameScale))
                if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["HLTHTXTANCHOR"]==1 then
                    b.gref.txt["text2"]:SetJustifyH("LEFT")
                elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["HLTHTXTANCHOR"]==2 then
                    b.gref.txt["text2"]:SetJustifyH("CENTER")
                else
                    b.gref.txt["text2"]:SetJustifyH("RIGHT")
                end
            elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["HLTHTXTANCHOR"]>4 then
                b.gref.txt["text2"]:SetPoint("TOP",b.gref.txt["text"],"BOTTOM",ceil(Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["HOFFSET2"]*frameScale),ceil((-2+Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["HOFFSET"])*frameScale))
                b.gref.txt["text2"]:SetJustifyH(b.gref.txt["text"]:GetJustifyH())
            end
            b.gref.txt["text5"]:SetPoint("TOP",b.gref.txt["text2"],"BOTTOM")
            if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["STATETXTANCHOR"]<4 then
                b.gref.txt["text3"]:SetPoint("TOP",b.gref["Bar"],"TOP",ceil(Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["SOFFSET2"]*frameScale),ceil((-2+Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["SOFFSET"])*frameScale))
                if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["STATETXTANCHOR"]==1 then
                    b.gref.txt["text3"]:SetJustifyH("LEFT")
                elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["STATETXTANCHOR"]==2 then
                    b.gref.txt["text3"]:SetJustifyH("CENTER")
                else
                    b.gref.txt["text3"]:SetJustifyH("RIGHT")
                end
            elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["STATETXTANCHOR"]>4 then
                b.gref.txt["text3"]:SetPoint("BOTTOM",b.gref.txt["text"],"TOP",ceil(Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["SOFFSET2"]*frameScale),ceil((0+Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["SOFFSET"])*frameScale))
                b.gref.txt["text3"]:SetJustifyH(b.gref.txt["text"]:GetJustifyH())
            end
            if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["AGGROTXTANCHOR"]<4 then
                b.gref.txt["text4"]:SetPoint("TOP",b.gref["Bar"],"TOP",ceil(Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["AOFFSET2"]*frameScale),ceil((-2+Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["AOFFSET"])*frameScale))
                if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["AGGROTXTANCHOR"]==1 then
                    b.gref.txt["text4"]:SetJustifyH("LEFT")
                elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["AGGROTXTANCHOR"]==2 then
                    b.gref.txt["text4"]:SetJustifyH("CENTER")
                else
                    b.gref.txt["text4"]:SetJustifyH("RIGHT")
                end
            elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["AGGROTXTANCHOR"]==4 then
                b.gref.txt["text4"]:SetPoint("BOTTOM",b.gref.txt["text"],"TOP",ceil(Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["AOFFSET2"]*frameScale),ceil((0+Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["AOFFSET"])*frameScale))
                b.gref.txt["text4"]:SetJustifyH(b.gref.txt["text"]:GetJustifyH())
            else
                b.gref.txt["text4"]:SetPoint("TOP",b.gref.txt["text"],"BOTTOM",ceil(Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["AOFFSET2"]*frameScale),ceil((0+Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["AOFFSET"])*frameScale))
                b.gref.txt["text4"]:SetJustifyH(b.gref.txt["text"]:GetJustifyH())
            end
            if not testBarsOn and button.text.tag==HEALBOT_OPTIONS_TAB_STATETEXT then
                button.text.tag=""
                button.gref.txt["text3"]:SetText("")
                button.gref.txt["text4"]:SetText("")
            end
            b.text.reset=false
        end
        
        if b.icon.reset then
        
            -- Buff IconSet 1
            if Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][b.frame][1]["BUFFDOUBLE"] then
                iScale=floor(((bheight*Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][b.frame][1]["BSCALE"])-2)*0.485)
            else
                iScale=(bheight*Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][b.frame][1]["BSCALE"])-2
            end
            for x=1,8 do
                b.gref.icon[x]:SetHeight(iScale);
                b.gref.icon[x]:SetWidth(iScale);
                b.gref.txt.expire[x]:SetFont(LSM:Fetch('font',Healbot_Config_Skins.IconSetsText[Healbot_Config_Skins.Current_Skin][b.frame][1]["BUFFFONT"]),
                                                Healbot_Config_Skins.IconSetsText[Healbot_Config_Skins.Current_Skin][b.frame][1]["BUFFHEIGHT"],
                                                HealBot_Font_Outline[Healbot_Config_Skins.IconSetsText[Healbot_Config_Skins.Current_Skin][b.frame][1]["BUFFOUTLINE"]]);
                b.gref.txt.count[x]:SetFont(LSM:Fetch('font',Healbot_Config_Skins.IconSetsText[Healbot_Config_Skins.Current_Skin][b.frame][1]["BUFFFONT"]),
                                                Healbot_Config_Skins.IconSetsText[Healbot_Config_Skins.Current_Skin][b.frame][1]["BUFFHEIGHT"],
                                                HealBot_Font_Outline[Healbot_Config_Skins.IconSetsText[Healbot_Config_Skins.Current_Skin][b.frame][1]["BUFFOUTLINE"]]);
                b.gref.iconf[x]:SetHeight(iScale)
                b.gref.iconf[x]:SetWidth(iScale)
                if HealBot_Globals.UseIconCommands then
                    b.gref.iconf[x]:EnableMouse(true)
                else
                    b.gref.iconf[x]:EnableMouse(false)
                end
            end
            
            -- Buff IconSet 2
            if Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][b.frame][2]["BUFFDOUBLE"] then
                iScale=floor(((bheight*Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][b.frame][2]["BSCALE"])-2)*0.485)
            else
                iScale=(bheight*Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][b.frame][2]["BSCALE"])-2
            end
            for x=9,10 do
                b.gref.icon[x]:SetHeight(iScale);
                b.gref.icon[x]:SetWidth(iScale);
                b.gref.txt.expire[x]:SetFont(LSM:Fetch('font',Healbot_Config_Skins.IconSetsText[Healbot_Config_Skins.Current_Skin][b.frame][2]["BUFFFONT"]),
                                                Healbot_Config_Skins.IconSetsText[Healbot_Config_Skins.Current_Skin][b.frame][2]["BUFFHEIGHT"],
                                                HealBot_Font_Outline[Healbot_Config_Skins.IconSetsText[Healbot_Config_Skins.Current_Skin][b.frame][2]["BUFFOUTLINE"]]);
                b.gref.txt.count[x]:SetFont(LSM:Fetch('font',Healbot_Config_Skins.IconSetsText[Healbot_Config_Skins.Current_Skin][b.frame][2]["BUFFFONT"]),
                                                Healbot_Config_Skins.IconSetsText[Healbot_Config_Skins.Current_Skin][b.frame][2]["BUFFHEIGHT"],
                                                HealBot_Font_Outline[Healbot_Config_Skins.IconSetsText[Healbot_Config_Skins.Current_Skin][b.frame][2]["BUFFOUTLINE"]]);
                b.gref.iconf[x]:SetHeight(iScale)
                b.gref.iconf[x]:SetWidth(iScale)
                if HealBot_Globals.UseIconCommands then
                    b.gref.iconf[x]:EnableMouse(true)
                else
                    b.gref.iconf[x]:EnableMouse(false)
                end
            end
            
            -- Buff IconSet 3
            if Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][b.frame][3]["BUFFDOUBLE"] then
                iScale=floor(((bheight*Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][b.frame][3]["BSCALE"])-2)*0.485)
            else
                iScale=(bheight*Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][b.frame][3]["BSCALE"])-2
            end
            for x=11,12 do
                b.gref.icon[x]:SetHeight(iScale);
                b.gref.icon[x]:SetWidth(iScale);
                b.gref.txt.expire[x]:SetFont(LSM:Fetch('font',Healbot_Config_Skins.IconSetsText[Healbot_Config_Skins.Current_Skin][b.frame][3]["BUFFFONT"]),
                                                Healbot_Config_Skins.IconSetsText[Healbot_Config_Skins.Current_Skin][b.frame][3]["BUFFHEIGHT"],
                                                HealBot_Font_Outline[Healbot_Config_Skins.IconSetsText[Healbot_Config_Skins.Current_Skin][b.frame][3]["BUFFOUTLINE"]]);
                b.gref.txt.count[x]:SetFont(LSM:Fetch('font',Healbot_Config_Skins.IconSetsText[Healbot_Config_Skins.Current_Skin][b.frame][3]["BUFFFONT"]),
                                                Healbot_Config_Skins.IconSetsText[Healbot_Config_Skins.Current_Skin][b.frame][3]["BUFFHEIGHT"],
                                                HealBot_Font_Outline[Healbot_Config_Skins.IconSetsText[Healbot_Config_Skins.Current_Skin][b.frame][3]["BUFFOUTLINE"]]);
                b.gref.iconf[x]:SetHeight(iScale)
                b.gref.iconf[x]:SetWidth(iScale)
                if HealBot_Globals.UseIconCommands then
                    b.gref.iconf[x]:EnableMouse(true)
                else
                    b.gref.iconf[x]:EnableMouse(false)
                end
            end
            
            -- Debuff IconSet 1
            if Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][b.frame][1]["DEBUFFDOUBLE"] then
                diScale=floor(((bheight*Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][b.frame][1]["DSCALE"])-2)*0.485)
            else
                diScale=(bheight*Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][b.frame][1]["DSCALE"])-2
            end
            for x=51,56 do
                b.gref.icon[x]:SetHeight(diScale);
                b.gref.icon[x]:SetWidth(diScale);
                b.gref.txt.expire[x]:SetFont(LSM:Fetch('font',Healbot_Config_Skins.IconSetsText[Healbot_Config_Skins.Current_Skin][b.frame][1]["DBFONT"]),
                                                Healbot_Config_Skins.IconSetsText[Healbot_Config_Skins.Current_Skin][b.frame][1]["DBHEIGHT"],
                                                HealBot_Font_Outline[Healbot_Config_Skins.IconSetsText[Healbot_Config_Skins.Current_Skin][b.frame][1]["DBOUTLINE"]]);
                b.gref.txt.count[x]:SetFont(LSM:Fetch('font',Healbot_Config_Skins.IconSetsText[Healbot_Config_Skins.Current_Skin][b.frame][1]["DBFONT"]),
                                                Healbot_Config_Skins.IconSetsText[Healbot_Config_Skins.Current_Skin][b.frame][1]["DBHEIGHT"],
                                                HealBot_Font_Outline[Healbot_Config_Skins.IconSetsText[Healbot_Config_Skins.Current_Skin][b.frame][1]["DBOUTLINE"]]);
                b.gref.iconf[x]:SetHeight(diScale)
                b.gref.iconf[x]:SetWidth(diScale)
                if HealBot_Globals.UseIconCommands then
                    b.gref.iconf[x]:EnableMouse(true)
                else
                    b.gref.iconf[x]:EnableMouse(false)
                end
            end
            
            -- Debuff IconSet 2
            if Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][b.frame][2]["DEBUFFDOUBLE"] then
                diScale=floor(((bheight*Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][b.frame][2]["DSCALE"])-2)*0.485)
            else
                diScale=(bheight*Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][b.frame][2]["DSCALE"])-2
            end
            for x=57,58 do
                b.gref.icon[x]:SetHeight(diScale);
                b.gref.icon[x]:SetWidth(diScale);
                b.gref.txt.expire[x]:SetFont(LSM:Fetch('font',Healbot_Config_Skins.IconSetsText[Healbot_Config_Skins.Current_Skin][b.frame][2]["DBFONT"]),
                                                Healbot_Config_Skins.IconSetsText[Healbot_Config_Skins.Current_Skin][b.frame][2]["DBHEIGHT"],
                                                HealBot_Font_Outline[Healbot_Config_Skins.IconSetsText[Healbot_Config_Skins.Current_Skin][b.frame][2]["DBOUTLINE"]]);
                b.gref.txt.count[x]:SetFont(LSM:Fetch('font',Healbot_Config_Skins.IconSetsText[Healbot_Config_Skins.Current_Skin][b.frame][2]["DBFONT"]),
                                                Healbot_Config_Skins.IconSetsText[Healbot_Config_Skins.Current_Skin][b.frame][2]["DBHEIGHT"],
                                                HealBot_Font_Outline[Healbot_Config_Skins.IconSetsText[Healbot_Config_Skins.Current_Skin][b.frame][2]["DBOUTLINE"]]);
                b.gref.iconf[x]:SetHeight(diScale)
                b.gref.iconf[x]:SetWidth(diScale)
                if HealBot_Globals.UseIconCommands then
                    b.gref.iconf[x]:EnableMouse(true)
                else
                    b.gref.iconf[x]:EnableMouse(false)
                end
            end

            -- Debuff IconSet 3
            if Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][b.frame][3]["DEBUFFDOUBLE"] then
                diScale=floor(((bheight*Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][b.frame][3]["DSCALE"])-2)*0.485)
            else
                diScale=(bheight*Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][b.frame][3]["DSCALE"])-2
            end
            for x=59,60 do
                b.gref.icon[x]:SetHeight(diScale);
                b.gref.icon[x]:SetWidth(diScale);
                b.gref.txt.expire[x]:SetFont(LSM:Fetch('font',Healbot_Config_Skins.IconSetsText[Healbot_Config_Skins.Current_Skin][b.frame][3]["DBFONT"]),
                                                Healbot_Config_Skins.IconSetsText[Healbot_Config_Skins.Current_Skin][b.frame][3]["DBHEIGHT"],
                                                HealBot_Font_Outline[Healbot_Config_Skins.IconSetsText[Healbot_Config_Skins.Current_Skin][b.frame][3]["DBOUTLINE"]]);
                b.gref.txt.count[x]:SetFont(LSM:Fetch('font',Healbot_Config_Skins.IconSetsText[Healbot_Config_Skins.Current_Skin][b.frame][3]["DBFONT"]),
                                                Healbot_Config_Skins.IconSetsText[Healbot_Config_Skins.Current_Skin][b.frame][3]["DBHEIGHT"],
                                                HealBot_Font_Outline[Healbot_Config_Skins.IconSetsText[Healbot_Config_Skins.Current_Skin][b.frame][3]["DBOUTLINE"]]);
                b.gref.iconf[x]:SetHeight(diScale)
                b.gref.iconf[x]:SetWidth(diScale)
                if HealBot_Globals.UseIconCommands then
                    b.gref.iconf[x]:EnableMouse(true)
                else
                    b.gref.iconf[x]:EnableMouse(false)
                end
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
                    if (x/2)==floor(x/2) then
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
                    if (x/2)==floor(x/2) then
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
            -- Raid Target 92
            HealBot_Skins_setIconAnchors(Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["TARGETONBAR"],
                                         Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["TARGETANCHOR"], true)
            b.gref.icon[92]:ClearAllPoints()
            b.gref.icon[92]:SetPoint(iAnchors["ICON"],b,iAnchors["BUTTON"],
                                     ceil(Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["TARGETHOFFSET"]*frameScale),
                                     ceil(Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["TARGETVOFFSET"]*frameScale))
            b.gref.icon[92]:SetHeight((bheight*Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["TARGETSCALE"])-2)
            b.gref.icon[92]:SetWidth((bheight*Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["TARGETSCALE"])-2)
            -- Ready Check 93
            HealBot_Skins_setIconAnchors(Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["RCONBAR"],
                                         Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["RCANCHOR"], true)
            b.gref.icon[93]:ClearAllPoints()
            b.gref.icon[93]:SetPoint(iAnchors["ICON"],b,iAnchors["BUTTON"],
                                     ceil(Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["RCHOFFSET"]*frameScale),
                                     ceil(Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["RCVOFFSET"]*frameScale))
            b.gref.icon[93]:SetHeight((bheight*Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["RCSCALE"])-2)
            b.gref.icon[93]:SetWidth((bheight*Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["RCSCALE"])-2)
            -- Out of range 94
            HealBot_Skins_setIconAnchors(Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["OORONBAR"],
                                         Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["OORANCHOR"], true)
            b.gref.icon[94]:ClearAllPoints()
            b.gref.icon[94]:SetPoint(iAnchors["ICON"],b,iAnchors["BUTTON"],
                                     ceil(Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["OORHOFFSET"]*frameScale),
                                     ceil(Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["OORVOFFSET"]*frameScale))
            b.gref.icon[94]:SetHeight((bheight*Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["OORSCALE"])-2)
            b.gref.icon[94]:SetWidth((bheight*Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["OORSCALE"])-2)
            b.icon.reset=false
        end
        
        if b.indreset then 
            local indCol=Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["ACOL"]
            if indCol==1 then indCol=8 end
            b.gref.indicator.aggro["Iconal1"]:SetTexture(indTextures[indCol])
            b.gref.indicator.aggro["Iconal2"]:SetTexture(indTextures[indCol])
            b.gref.indicator.aggro["Iconal3"]:SetTexture(indTextures[indCol])
            b.gref.indicator.aggro["Iconar1"]:SetTexture(indTextures[indCol])
            b.gref.indicator.aggro["Iconar2"]:SetTexture(indTextures[indCol])
            b.gref.indicator.aggro["Iconar3"]:SetTexture(indTextures[indCol])
            
            indCol=Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["MCOL"]
            if indCol==1 then indCol=10 end
            b.gref.indicator.mana[1]:SetTexture(indTextures[indCol])
            b.gref.indicator.mana[2]:SetTexture(indTextures[indCol])
            b.gref.indicator.mana[3]:SetTexture(indTextures[indCol])
            
            indCol=Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["SCOL"]
            if indCol==1 then indCol=8 end
            for x=1,16 do
                b.gref.indicator.selfcast[x]:SetTexture(indTextures[indCol])
                --b.gref.indicator.selfcast[x]:SetAlpha(0)
            end
            
            indCol=Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["PCOL"]
            if indCol==1 then indCol=12 end
            for x=1,5 do
                b.gref.indicator.power[x]:SetTexture(indTextures[indCol])
            end
            
            local indAnchor={[0]="TOPLEFT",[1]="TOPRIGHT"}
            if Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["AANCHOR"]==2 then
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
                                                       ceil(0+Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["AHOFF"]*frameScale),
                                                              HealBot_Skins_IndicatorVOffset(Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["AANCHOR"], 
                                                                                             Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["AVOFF"],
                                                                                              button.frame))
            b.gref.indicator.aggro["Iconal2"]:SetPoint(indAnchor[0],b.gref["IconTop"],indAnchor[0],
                                                       ceil(0+(Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["AHOFF"]+
                                                               Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["ASIZE"]+
                                                               Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["ASPACE"])*frameScale),
                                                               HealBot_Skins_IndicatorVOffset(Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["AANCHOR"], 
                                                                                              Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["AVOFF"],
                                                                                              button.frame))
            b.gref.indicator.aggro["Iconal3"]:SetPoint(indAnchor[0],b.gref["IconTop"],indAnchor[0],
                                                       ceil(0+(Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["AHOFF"]+
                                                              (Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["ASIZE"]*2)+
                                                              (Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["ASPACE"]*2))*frameScale),
                                                               HealBot_Skins_IndicatorVOffset(Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["AANCHOR"], 
                                                                                              Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["AVOFF"],
                                                                                              button.frame))
            b.gref.indicator.aggro["Iconar1"]:SetPoint(indAnchor[1],b.gref["IconTop"],indAnchor[1],
                                                       ceil(0-Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["AHOFF"]*frameScale),
                                                              HealBot_Skins_IndicatorVOffset(Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["AANCHOR"], 
                                                                                             Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["AVOFF"],
                                                                                              button.frame))
            b.gref.indicator.aggro["Iconar2"]:SetPoint(indAnchor[1],b.gref["IconTop"],indAnchor[1],
                                                       ceil(0-(Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["AHOFF"]+
                                                               Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["ASIZE"]+
                                                               Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["ASPACE"])*frameScale),
                                                               HealBot_Skins_IndicatorVOffset(Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["AANCHOR"], 
                                                                                              Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["AVOFF"],
                                                                                              button.frame))
            b.gref.indicator.aggro["Iconar3"]:SetPoint(indAnchor[1],b.gref["IconTop"],indAnchor[1],
                                                       ceil(0-(Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["AHOFF"]+
                                                              (Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["ASIZE"]*2)+
                                                              (Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["ASPACE"]*2))*frameScale),
                                                               HealBot_Skins_IndicatorVOffset(Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["AANCHOR"], 
                                                                                              Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["AVOFF"],
                                                                                              button.frame))
            
            
            indAnchor[0]="TOP"
            if Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["MANCHOR"]==2 then
                indAnchor[0]="BOTTOM"
            elseif Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["MANCHOR"]==3 then
                indAnchor[0]="LEFT"
            elseif Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["MANCHOR"]==4 then
                indAnchor[0]="RIGHT"
            elseif Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["MANCHOR"]==5 then
                indAnchor[0]="TOPLEFT"
            elseif Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["MANCHOR"]==6 then
                indAnchor[0]="BOTTOMLEFT"
            elseif Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["MANCHOR"]==7 then
                indAnchor[0]="TOPRIGHT"
            elseif Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["MANCHOR"]==8 then
                indAnchor[0]="BOTTOMRIGHT"
            end
            b.gref.indicator.mana[1]:ClearAllPoints()
            b.gref.indicator.mana[2]:ClearAllPoints()
            b.gref.indicator.mana[3]:ClearAllPoints()
            
            b.gref.indicator.mana[1]:SetPoint(indAnchor[0],b.gref["IconTop"],indAnchor[0],
                                             (ceil(0+(Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["MHOFF"])
                                                   -(Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["MSIZE"]+
                                                     Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["MSPACE"]))*frameScale),
                                                     HealBot_Skins_IndicatorVOffset(Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["MANCHOR"], 
                                                                                    Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["MVOFF"],
                                                                                    button.frame))
            b.gref.indicator.mana[2]:SetPoint(indAnchor[0],b.gref["IconTop"],indAnchor[0],
                                              ceil(0+Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["MHOFF"]*frameScale),
                                                     HealBot_Skins_IndicatorVOffset(Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["MANCHOR"], 
                                                                                    Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["MVOFF"],
                                                                                    button.frame))
            b.gref.indicator.mana[3]:SetPoint(indAnchor[0],b.gref["IconTop"],indAnchor[0],
                                              ceil(0+(Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["MHOFF"]+
                                                      Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["MSIZE"]+
                                                      Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["MSPACE"])*frameScale),
                                                      HealBot_Skins_IndicatorVOffset(Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["MANCHOR"], 
                                                                                     Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["MVOFF"],
                                                                                     button.frame))

            indAnchor[0]="TOP"
            if Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["PANCHOR"]==2 then
                indAnchor[0]="BOTTOM"
            elseif Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["PANCHOR"]==3 then
                indAnchor[0]="LEFT"
            elseif Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["PANCHOR"]==4 then
                indAnchor[0]="RIGHT"
            elseif Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["PANCHOR"]==5 then
                indAnchor[0]="TOPLEFT"
            elseif Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["PANCHOR"]==6 then
                indAnchor[0]="BOTTOMLEFT"
            elseif Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["PANCHOR"]==7 then
                indAnchor[0]="TOPRIGHT"
            elseif Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["PANCHOR"]==8 then
                indAnchor[0]="BOTTOMRIGHT"
            end
            b.gref.indicator.power[1]:ClearAllPoints()
            b.gref.indicator.power[2]:ClearAllPoints()
            b.gref.indicator.power[3]:ClearAllPoints()
            b.gref.indicator.power[4]:ClearAllPoints()
            b.gref.indicator.power[5]:ClearAllPoints()

            b.gref.indicator.power[1]:SetPoint(indAnchor[0],b.gref["IconTop"],indAnchor[0],
                                              ceil(((0+Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["PHOFF"])
                                                    -((Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["PSIZE"]*2)+
                                                      (Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["PSPACE"]*2)))*frameScale),
                                                       HealBot_Skins_IndicatorVOffset(Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["PANCHOR"], 
                                                                                      Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["PVOFF"],
                                                                                      button.frame))
            b.gref.indicator.power[2]:SetPoint(indAnchor[0],b.gref["IconTop"],indAnchor[0],
                                              ceil(((0+Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["PHOFF"])
                                                    -(Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["PSIZE"]+
                                                      Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["PSPACE"]))*frameScale),
                                                      HealBot_Skins_IndicatorVOffset(Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["PANCHOR"], 
                                                                                     Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["PVOFF"],
                                                                                      button.frame))
            b.gref.indicator.power[3]:SetPoint(indAnchor[0],b.gref["IconTop"],indAnchor[0],
                                               ceil(0+Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["PHOFF"]*frameScale),
                                                      HealBot_Skins_IndicatorVOffset(Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["PANCHOR"], 
                                                                                     Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["PVOFF"],
                                                                                      button.frame))
            b.gref.indicator.power[4]:SetPoint(indAnchor[0],b.gref["IconTop"],indAnchor[0],
                                               ceil(0+(Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["PHOFF"]+
                                                       Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["PSIZE"]+
                                                       Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["PSPACE"])*frameScale),
                                                       HealBot_Skins_IndicatorVOffset(Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["PANCHOR"], 
                                                                                      Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["PVOFF"],
                                                                                      button.frame))
            b.gref.indicator.power[5]:SetPoint(indAnchor[0],b.gref["IconTop"],indAnchor[0],
                                               ceil(0+(Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["PHOFF"]+
                                                      (Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["PSIZE"]*2)+
                                                      (Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["PSPACE"]*2))*frameScale),
                                                       HealBot_Skins_IndicatorVOffset(Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["PANCHOR"], 
                                                                                      Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["PVOFF"],
                                                                                      button.frame))

            HealBot_Skins_setIconAnchors(Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][b.frame][1]["BUFFONBAR"],
                                         Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][b.frame][1]["BUFFANCHOR"])

            b.gref.indicator.selfcast[1]:ClearAllPoints()
            b.gref.indicator.selfcast[1]:SetPoint(iAnchors["INDSELFCAST"],b.gref.icon[1],iAnchors["INDSELFCAST"],
                                                  0+Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["SHOFF"],
                                                  HealBot_Skins_IndicatorVOffset(Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["SANCHOR"], 
                                                                                 Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["SVOFF"],
                                                                                 button.frame))
            for x=2,8 do
                b.gref.indicator.selfcast[x]:ClearAllPoints()
                b.gref.indicator.selfcast[x]:SetPoint(iAnchors["INDSELFCAST"],b.gref.icon[x],iAnchors["INDSELFCAST"],
                                                  0+Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["SHOFF"],
                                                  HealBot_Skins_IndicatorVOffset(Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["SANCHOR"], 
                                                                                 Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["SVOFF"],
                                                                                 button.frame))
            end

            HealBot_Skins_setIconAnchors(Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][b.frame][2]["BUFFONBAR"],
                                         Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][b.frame][2]["BUFFANCHOR"])

            b.gref.indicator.selfcast[9]:ClearAllPoints()
            b.gref.indicator.selfcast[9]:SetPoint(iAnchors["INDSELFCAST"],b.gref.icon[9],iAnchors["INDSELFCAST"],
                                                  0+Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["SHOFF"],
                                                  HealBot_Skins_IndicatorVOffset(Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["SANCHOR"], 
                                                                                 Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["SVOFF"],
                                                                                 button.frame))
            for x=10,12 do
                b.gref.indicator.selfcast[x]:ClearAllPoints()
                b.gref.indicator.selfcast[x]:SetPoint(iAnchors["INDSELFCAST"],b.gref.icon[x],iAnchors["INDSELFCAST"],
                                                  0+Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["SHOFF"],
                                                  HealBot_Skins_IndicatorVOffset(Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["SANCHOR"], 
                                                                                 Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["SVOFF"],
                                                                                 button.frame))
            end

            HealBot_Skins_setIconAnchors(Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][b.frame][3]["BUFFONBAR"],
                                         Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][b.frame][3]["BUFFANCHOR"])

            b.gref.indicator.selfcast[13]:ClearAllPoints()
            b.gref.indicator.selfcast[13]:SetPoint(iAnchors["INDSELFCAST"],b.gref.icon[13],iAnchors["INDSELFCAST"],
                                                  0+Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["SHOFF"],
                                                  HealBot_Skins_IndicatorVOffset(Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["SANCHOR"], 
                                                                                 Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["SVOFF"],
                                                                                 button.frame))
            for x=14,16 do
                b.gref.indicator.selfcast[x]:ClearAllPoints()
                b.gref.indicator.selfcast[x]:SetPoint(iAnchors["INDSELFCAST"],b.gref.icon[x],iAnchors["INDSELFCAST"],
                                                  0+Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["SHOFF"],
                                                  HealBot_Skins_IndicatorVOffset(Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["SANCHOR"], 
                                                                                 Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["SVOFF"],
                                                                                 button.frame))
            end
            
            b.gref.indicator.aggro["Iconal1"]:SetWidth(ceil(Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["ASIZE"]*frameScale))
            b.gref.indicator.aggro["Iconal2"]:SetWidth(ceil(Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["ASIZE"]*frameScale))
            b.gref.indicator.aggro["Iconal3"]:SetWidth(ceil(Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["ASIZE"]*frameScale))
            b.gref.indicator.aggro["Iconar1"]:SetWidth(ceil(Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["ASIZE"]*frameScale))
            b.gref.indicator.aggro["Iconar2"]:SetWidth(ceil(Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["ASIZE"]*frameScale))
            b.gref.indicator.aggro["Iconar3"]:SetWidth(ceil(Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["ASIZE"]*frameScale))
            b.gref.indicator.aggro["Iconal1"]:SetHeight(ceil(Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["ASIZE"]*frameScale))
            b.gref.indicator.aggro["Iconal2"]:SetHeight(ceil(Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["ASIZE"]*frameScale))
            b.gref.indicator.aggro["Iconal3"]:SetHeight(ceil(Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["ASIZE"]*frameScale))
            b.gref.indicator.aggro["Iconar1"]:SetHeight(ceil(Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["ASIZE"]*frameScale))
            b.gref.indicator.aggro["Iconar2"]:SetHeight(ceil(Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["ASIZE"]*frameScale))
            b.gref.indicator.aggro["Iconar3"]:SetHeight(ceil(Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["ASIZE"]*frameScale))

            for x=1,3 do
                b.gref.indicator.mana[x]:SetWidth(ceil(Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["MSIZE"]*frameScale))
                b.gref.indicator.mana[x]:SetHeight(ceil(Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["MSIZE"]*frameScale))
            end
            for x=1,16 do
                b.gref.indicator.selfcast[x]:SetWidth(ceil(Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["SSIZE"]*frameScale))
                b.gref.indicator.selfcast[x]:SetHeight(ceil(Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["SSIZE"]*frameScale))
            end
            for x=1,5 do
                b.gref.indicator.power[x]:SetWidth(ceil(Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["PSIZE"]*frameScale))
                b.gref.indicator.power[x]:SetHeight(ceil(Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][b.frame]["PSIZE"]*frameScale))
            end

            if testBarsOn and b.frame<10 and Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][b.frame]["SHOW"] and 
                                             Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][b.frame]["SHOWIND"] then
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
            
            if testBarsOn and Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][b.frame]["POWERCNT"] and testPowerOn>0 then
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
            b.indreset=false
        end
    elseif barType=="header" then
        h=button
        --bar = _G[h:GetName().."Bar"]
        local back = _G[h:GetName().."Bar5"]
        hwidth = ceil((bWidth+auxWidth+(bOutline*2))*Healbot_Config_Skins.HeadBar[Healbot_Config_Skins.Current_Skin][h.frame]["WIDTH"])
        hheight = ceil(Healbot_Config_Skins.HeadBar[Healbot_Config_Skins.Current_Skin][h.frame]["HEIGHT"]*frameScale)
        h:SetHeight(hheight);
        h:SetWidth(hwidth);
        back:SetHeight(hheight)
        back:SetWidth(hwidth)
        HealBot_Action_SetBackHeaderHeightWidth(h.frame, hheight, hwidth)
        back:SetStatusBarColor(0,0,0,0)
        h.bar:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.HeadBar[Healbot_Config_Skins.Current_Skin][h.frame]["TEXTURE"]));
        h.bar:GetStatusBarTexture():SetHorizTile(false)
        h.bar:SetMinMaxValues(0,100);
        h.bar:SetValue(100);
        HealBot_Action_UpdateHeaderOpacity(h)
        h.bar:SetHeight(hheight);
        h.bar:SetWidth(hwidth);
        h.bar.txt:SetFont(LSM:Fetch('font',Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin][h.frame]["FONT"]),
                                ceil(Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin][h.frame]["HEIGHT"]*frameScale),
                                HealBot_Font_Outline[Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin][h.frame]["OUTLINE"]]);
        h.bar.txt:SetPoint("CENTER",h.bar,"CENTER",0,Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin][h.frame]["OFFSET"])
        h.bar:EnableMouse(false)
        h.bar.txt2:SetTextColor(0,0,0,0);
        h.bar:ClearAllPoints()
        h.bar:SetPoint("CENTER",back,"CENTER",0,0)
        h:Disable();
    elseif barType=="hbfocus" then
        tBarsConcat[1]="HealBot_Action_HealUnit"
        tBarsConcat[2]=button.id
        tBarsConcat[3]="Bar"
        bar = _G[HealBot_Skins_Concat(3)]
        bar:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][button.frame]["TEXTURE"]));
        bar:GetStatusBarTexture():SetHorizTile(false)

        bar:SetStatusBarColor(1,1,1,1);
        tBarsConcat[1]=bar:GetName()
        tBarsConcat[2]="_text"
        bar.txt = _G[HealBot_Skins_Concat(2)];
        tBarsConcat[2]="_text2"
        bar.txt2 = _G[HealBot_Skins_Concat(2)];
        bar.txt:SetFont(LSM:Fetch('font',Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["FONT"]),
                                            btextheight,
                                            HealBot_Font_Outline[btextoutline]);
        bar.txt:SetTextColor(0,0,0,1);
        bar.txt2:SetFont(LSM:Fetch('font',Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["HFONT"]),
                                            btextheight2,
                                            HealBot_Font_Outline[btextoutline2]);
        bar.txt2:SetTextColor(0,0,0,1);
        iScale=0.84
        iScale=iScale+(numcols/10)
        bar:SetWidth(bWidth*iScale)
        button:SetWidth(bWidth*iScale)
        bar:SetHeight(bheight); 
        button:SetHeight(bheight); 
        bar.txt:SetText(HEALBOT_ACTION_HBFOCUS)
        barScale = bar:GetScale();
        bar:SetScale(barScale + 0.01);
        bar:SetScale(barScale);
    else
        HealBot_Panel_ResetHeaders()
        HealBot_Timers_SkinsFormat() -- HealBot_Timers_Set("SKINS","SkinsFormat")
        HealBot_Text_setExtraCustomCols() --HealBot_Timers_Set("SKINS","TextExtraCustomCols")

        HealBot_Timers_Set("SKINS","RaidTargetUpdate")
        HealBot_Timers_Set("SKINS","UpdateTextButtons")
    end
      --HealBot_setCall("HealBot_Skins_ResetSkin")
end

function HealBot_Skins_Check(SkinName)
    if not Healbot_Config_Skins.General[SkinName] or not Healbot_Config_Skins.General[SkinName]["VC"] or Healbot_Config_Skins.General[SkinName]["VC"]~=HealBot_Global_Version() then
        HealBot_Skins_Check_Skin(SkinName)
    end
end

local nVal={[1]="", [2]="", [3]=""}
local function HealBot_Skins_Check_IconSets(SkinName, frame, oVar, nVar, v1, v2, v3)
    nVal[1]=v1
    nVal[2]=v2 or v1
    nVal[3]=v3 or v2 or v1
    for i=1,3 do
        if not Healbot_Config_Skins.IconSets[SkinName][frame][i][nVar] then 
            if Healbot_Config_Skins.Icons[SkinName][frame][oVar] then
                if type(Healbot_Config_Skins.Icons[SkinName][frame][oVar])==type(nVal[i]) then
                    Healbot_Config_Skins.IconSets[SkinName][frame][i][nVar]=Healbot_Config_Skins.Icons[SkinName][frame][oVar]
                else
                    Healbot_Config_Skins.IconSets[SkinName][frame][i][nVar]=nVal[i]
                end
                Healbot_Config_Skins.Icons[SkinName][frame][oVar]=nil
            elseif Healbot_Config_Skins.Icons[SkinName][frame][i] and Healbot_Config_Skins.Icons[SkinName][frame][i][oVar] then
                if type(Healbot_Config_Skins.Icons[SkinName][frame][i][oVar])==type(nVal[i]) then
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

local function HealBot_Skins_Check_IconSetsText(SkinName, frame, oVar, nVar, v1, v2, v3)
    nVal[1]=v1
    nVal[2]=v2 or v1
    nVal[3]=v3 or v2 or v1
    for i=1,3 do
        if Healbot_Config_Skins.IconSetsText[SkinName][frame][i][nVar]==nil then 
            if Healbot_Config_Skins.IconText[SkinName][frame][oVar] then
                if type(Healbot_Config_Skins.IconText[SkinName][frame][oVar])==type(nVal[i]) then
                    Healbot_Config_Skins.IconSetsText[SkinName][frame][i][nVar]=Healbot_Config_Skins.IconText[SkinName][frame][oVar]
                else
                    Healbot_Config_Skins.IconSetsText[SkinName][frame][i][nVar]=nVal[i]
                end
                Healbot_Config_Skins.IconText[SkinName][frame][oVar]=nil
            elseif Healbot_Config_Skins.IconText[SkinName][frame][i] and Healbot_Config_Skins.IconText[SkinName][frame][i][oVar] then
                if type(Healbot_Config_Skins.IconText[SkinName][frame][i][oVar])==type(nVal[i]) then
                    Healbot_Config_Skins.IconSetsText[SkinName][frame][i][nVar]=Healbot_Config_Skins.IconText[SkinName][frame][i][oVar]
                else
                    Healbot_Config_Skins.IconSetsText[SkinName][frame][i][nVar]=nVal[i]
                end
                Healbot_Config_Skins.IconText[SkinName][frame][i][oVar]=nil
            else
                Healbot_Config_Skins.IconSetsText[SkinName][frame][i][nVar]=nVal[i]
            end
        else
            if Healbot_Config_Skins.IconText[SkinName][frame][oVar] then
                Healbot_Config_Skins.IconText[SkinName][frame][oVar]=nil
            end
            if Healbot_Config_Skins.IconText[SkinName][frame][i] then
                Healbot_Config_Skins.IconText[SkinName][frame][i]=nil
            end
        end
    end
end

function HealBot_Skins_Check_Skin(SkinName, fromImport)
    if Healbot_Config_Skins.ExtraIncGroup then Healbot_Config_Skins.ExtraIncGroup=nil end
    if Healbot_Config_Skins.BarsHide then Healbot_Config_Skins.BarsHide=nil end
    if Healbot_Config_Skins.EmergIncMonitor then Healbot_Config_Skins.EmergIncMonitor=nil end
    if Healbot_Config_Skins.IncludeGroup then Healbot_Config_Skins.IncludeGroup=nil end
    
    if not HealBot_Config.SkinDefault[SkinName] then HealBot_Config.SkinDefault[SkinName]={} end
    
    if HealBot_Config.SkinDefault[SkinName][HEALBOT_WORD_SOLO]==nil then HealBot_Config.SkinDefault[SkinName][HEALBOT_WORD_SOLO]=false end
    if HealBot_Config.SkinDefault[SkinName][HEALBOT_WORD_PARTY]==nil then HealBot_Config.SkinDefault[SkinName][HEALBOT_WORD_PARTY]=false end
    if HealBot_Config.SkinDefault[SkinName][HEALBOT_OPTIONS_RAID10]==nil then HealBot_Config.SkinDefault[SkinName][HEALBOT_OPTIONS_RAID10]=false end
    if HealBot_Config.SkinDefault[SkinName][HEALBOT_OPTIONS_RAID25]==nil then HealBot_Config.SkinDefault[SkinName][HEALBOT_OPTIONS_RAID25]=false end
    if HealBot_Config.SkinDefault[SkinName][HEALBOT_OPTIONS_RAID40]==nil then HealBot_Config.SkinDefault[SkinName][HEALBOT_OPTIONS_RAID40]=false end
    if HealBot_Config.SkinDefault[SkinName][HEALBOT_WORD_ARENA]==nil then HealBot_Config.SkinDefault[SkinName][HEALBOT_WORD_ARENA]=false end
    if HealBot_Config.SkinDefault[SkinName][HEALBOT_WORD_BG10]==nil then HealBot_Config.SkinDefault[SkinName][HEALBOT_WORD_BG10]=false end
    if HealBot_Config.SkinDefault[SkinName][HEALBOT_WORD_BG15]==nil then HealBot_Config.SkinDefault[SkinName][HEALBOT_WORD_BG15]=false end
    if HealBot_Config.SkinDefault[SkinName][HEALBOT_WORD_BG40]==nil then HealBot_Config.SkinDefault[SkinName][HEALBOT_WORD_BG40]=false end
    if HealBot_Config.SkinDefault[SkinName][HEALBOT_WORD_PETBATTLE]==nil then HealBot_Config.SkinDefault[SkinName][HEALBOT_WORD_PETBATTLE]=false end
    
    if not Healbot_Config_Skins.HealGroups[SkinName] then Healbot_Config_Skins.HealGroups[SkinName]={
        [1] = {["NAME"]=HEALBOT_OPTIONS_SELFHEALS_en,["STATE"]=false,["FRAME"]=1}, 
        [2] = {["NAME"]=HEALBOT_OPTIONS_TANKHEALS_en,["STATE"]=false,["FRAME"]=1},
        [3] = {["NAME"]=HEALBOT_CLASSES_HEALERS_en,["STATE"]=false,["FRAME"]=1}, 
        [5] = {["NAME"]=HEALBOT_OPTIONS_EMERGENCYHEALS_en,["STATE"]=true,["FRAME"]=1}, 
        [4] = {["NAME"]=HEALBOT_OPTIONS_GROUPHEALS_en,["STATE"]=false,["FRAME"]=1}, 
        [6] = {["NAME"]=HEALBOT_OPTIONS_MYTARGET_en,["STATE"]=false,["FRAME"]=1}, 
        [7] = {["NAME"]=HEALBOT_VEHICLE_en,["STATE"]=false,["FRAME"]=6},
        [8] = {["NAME"]=HEALBOT_OPTIONS_PETHEALS_en,["STATE"]=false,["FRAME"]=7},
        [9] = {["NAME"]=HEALBOT_OPTIONS_TARGETHEALS_en,["STATE"]=false,["FRAME"]=8},
       [10] = {["NAME"]=HEALBOT_FOCUS_en,["STATE"]=false,["FRAME"]=9}, 
       [11] = {["NAME"]=HEALBOT_CUSTOM_CASTBY_ENEMY_en,["STATE"]=false,["FRAME"]=10},}
    else
        for id=1,11 do
            if Healbot_Config_Skins.HealGroups[SkinName][id]["NAME"]=="My Targets" then
                Healbot_Config_Skins.HealGroups[SkinName][id]["NAME"]=HEALBOT_OPTIONS_MYTARGET
            end
        end
        for gl=1,11 do
            if not Healbot_Config_Skins.HealGroups[SkinName][gl]["STATE"] then Healbot_Config_Skins.HealGroups[SkinName][gl]["STATE"]=false end
            if not Healbot_Config_Skins.HealGroups[SkinName][gl]["FRAME"] then 
                if Healbot_Config_Skins.HealGroups[SkinName][gl]["NAME"]==HEALBOT_CUSTOM_CASTBY_ENEMY_en then
                    Healbot_Config_Skins.HealGroups[SkinName][gl]["FRAME"]=10
                elseif Healbot_Config_Skins.HealGroups[SkinName][gl]["NAME"]==HEALBOT_FOCUS_en then
                    Healbot_Config_Skins.HealGroups[SkinName][gl]["FRAME"]=9
                elseif Healbot_Config_Skins.HealGroups[SkinName][gl]["NAME"]==HEALBOT_OPTIONS_TARGETHEALS_en then
                    Healbot_Config_Skins.HealGroups[SkinName][gl]["FRAME"]=8
                elseif Healbot_Config_Skins.HealGroups[SkinName][gl]["NAME"]==HEALBOT_OPTIONS_PETHEALS_en then
                    Healbot_Config_Skins.HealGroups[SkinName][gl]["FRAME"]=7
                elseif Healbot_Config_Skins.HealGroups[SkinName][gl]["NAME"]==HEALBOT_VEHICLE_en then
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
    if not Healbot_Config_Skins.AuxBar[SkinName] then Healbot_Config_Skins.AuxBar[SkinName]={} end
    if not Healbot_Config_Skins.AuxBarText[SkinName] then Healbot_Config_Skins.AuxBarText[SkinName]={} end
    if not Healbot_Config_Skins.AuxBarFrame[SkinName] then Healbot_Config_Skins.AuxBarFrame[SkinName]={} end
    if not Healbot_Config_Skins.Indicators[SkinName] then Healbot_Config_Skins.Indicators[SkinName]={} end
    if not Healbot_Config_Skins.Emerg[SkinName] then Healbot_Config_Skins.Emerg[SkinName]={} end
    if not Healbot_Config_Skins.CustomCols[SkinName] then Healbot_Config_Skins.CustomCols[SkinName]={} end
    
    for g=1,9 do
        if not Healbot_Config_Skins.AuxBar[SkinName][g] then Healbot_Config_Skins.AuxBar[SkinName][g]={} end
        if not Healbot_Config_Skins.AuxBarText[SkinName][g] then Healbot_Config_Skins.AuxBarText[SkinName][g]={} end
    end
    for gl=1,10 do
        if not Healbot_Config_Skins.HeadText[SkinName][gl] then Healbot_Config_Skins.HeadText[SkinName][gl]={} end
        if not Healbot_Config_Skins.HeadBar[SkinName][gl] then Healbot_Config_Skins.HeadBar[SkinName][gl]={} end
        if not Healbot_Config_Skins.Anchors[SkinName][gl] then Healbot_Config_Skins.Anchors[SkinName][gl]={} end
        if not Healbot_Config_Skins.FrameAlias[SkinName][gl] then Healbot_Config_Skins.FrameAlias[SkinName][gl]={} end
        if not Healbot_Config_Skins.FrameAliasBar[SkinName][gl] then Healbot_Config_Skins.FrameAliasBar[SkinName][gl]={} end
        if not Healbot_Config_Skins.HealBar[SkinName][gl] then Healbot_Config_Skins.HealBar[SkinName][gl]={} end
        if not Healbot_Config_Skins.BarCol[SkinName][gl] then Healbot_Config_Skins.BarCol[SkinName][gl]={} end
        if not Healbot_Config_Skins.BarIACol[SkinName][gl] then Healbot_Config_Skins.BarIACol[SkinName][gl]={} end
        if not Healbot_Config_Skins.BarText[SkinName][gl] then Healbot_Config_Skins.BarText[SkinName][gl]={} end
        if not Healbot_Config_Skins.BarTextCol[SkinName][gl] then Healbot_Config_Skins.BarTextCol[SkinName][gl]={} end
        if not Healbot_Config_Skins.Icons[SkinName][gl] then Healbot_Config_Skins.Icons[SkinName][gl]={} end
        if not Healbot_Config_Skins.IconText[SkinName][gl] then Healbot_Config_Skins.IconText[SkinName][gl]={} end
        if not Healbot_Config_Skins.IconSets[SkinName][gl] then Healbot_Config_Skins.IconSets[SkinName][gl]={} end
        if not Healbot_Config_Skins.IconSetsText[SkinName][gl] then Healbot_Config_Skins.IconSetsText[SkinName][gl]={} end
        for g=1,3 do
            if not Healbot_Config_Skins.IconSets[SkinName][gl][g] then Healbot_Config_Skins.IconSets[SkinName][gl][g]={} end
            if not Healbot_Config_Skins.IconSetsText[SkinName][gl][g] then Healbot_Config_Skins.IconSetsText[SkinName][gl][g]={} end
        end
        if not Healbot_Config_Skins.RaidIcon[SkinName][gl] then Healbot_Config_Skins.RaidIcon[SkinName][gl]={} end
        if not Healbot_Config_Skins.Frame[SkinName][gl] then Healbot_Config_Skins.Frame[SkinName][gl]={} end
        if not Healbot_Config_Skins.StickyFrames[SkinName][gl] then Healbot_Config_Skins.StickyFrames[SkinName][gl]={} end
        if not Healbot_Config_Skins.BarVisibility[SkinName][gl] then Healbot_Config_Skins.BarVisibility[SkinName][gl]={} end
        if not Healbot_Config_Skins.BarSort[SkinName][gl] then Healbot_Config_Skins.BarSort[SkinName][gl]={} end
        if not Healbot_Config_Skins.BarAggro[SkinName][gl] then Healbot_Config_Skins.BarAggro[SkinName][gl]={} end
        for g=1,9 do
            if not Healbot_Config_Skins.AuxBar[SkinName][g][gl] then Healbot_Config_Skins.AuxBar[SkinName][g][gl]={} end
            if not Healbot_Config_Skins.AuxBarText[SkinName][g][gl] then Healbot_Config_Skins.AuxBarText[SkinName][g][gl]={} end
        end
        if not Healbot_Config_Skins.AuxBarFrame[SkinName][gl] then Healbot_Config_Skins.AuxBarFrame[SkinName][gl]={} end
        if not Healbot_Config_Skins.Indicators[SkinName][gl] then Healbot_Config_Skins.Indicators[SkinName][gl]={} end
        if not Healbot_Config_Skins.Emerg[SkinName][gl] then Healbot_Config_Skins.Emerg[SkinName][gl]={} end
    end

    for g=1,8 do
        if Healbot_Config_Skins.FocusGroups[SkinName][g]==nil then Healbot_Config_Skins.FocusGroups[SkinName][g]=true end
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
        if Healbot_Config_Skins.BarVisibility[SkinName][gl]["ALERTIC"]==nil then
            Healbot_Config_Skins.BarVisibility[SkinName][gl]["ALERTIC"]=Healbot_Config_Skins.Healing[SkinName]["ALERTIC"] or 0.98
        end
        if Healbot_Config_Skins.BarVisibility[SkinName][gl]["ALERTOC"]==nil then
            Healbot_Config_Skins.BarVisibility[SkinName][gl]["ALERTOC"]=Healbot_Config_Skins.Healing[SkinName]["ALERTOC"] or 0.9
        end
        if Healbot_Config_Skins.BarSort[SkinName][gl]["RAIDORDER"]==nil then 
            if Healbot_Config_Skins.Sort and Healbot_Config_Skins.Sort[SkinName] then
                Healbot_Config_Skins.BarSort[SkinName][gl]["RAIDORDER"]=Healbot_Config_Skins.Sort[SkinName]["RAIDORDER"] or 3
            else
                Healbot_Config_Skins.BarSort[SkinName][gl]["RAIDORDER"]=3
            end
        end
        if Healbot_Config_Skins.BarSort[SkinName][gl]["SUBORDER"]==nil then 
            if Healbot_Config_Skins.Sort and Healbot_Config_Skins.Sort[SkinName] then
                Healbot_Config_Skins.BarSort[SkinName][gl]["SUBORDER"]=Healbot_Config_Skins.Sort[SkinName]["SUBORDER"] or 1
            else
                Healbot_Config_Skins.BarSort[SkinName][gl]["SUBORDER"]=1
            end
        end
        if Healbot_Config_Skins.BarSort[SkinName][gl]["OORLAST"]==nil then 
            if Healbot_Config_Skins.Sort and Healbot_Config_Skins.Sort[SkinName] then
                Healbot_Config_Skins.BarSort[SkinName][gl]["OORLAST"]=Healbot_Config_Skins.Sort[SkinName]["OORLAST"] or false
            else
                Healbot_Config_Skins.BarSort[SkinName][gl]["OORLAST"]=false
            end
        end
        if Healbot_Config_Skins.BarSort[SkinName][gl]["SUBPF"]==nil then 
            if Healbot_Config_Skins.Sort and Healbot_Config_Skins.Sort[SkinName] then
                Healbot_Config_Skins.BarSort[SkinName][gl]["SUBPF"]=Healbot_Config_Skins.Sort[SkinName]["SUBPF"] or true
            else
                Healbot_Config_Skins.BarSort[SkinName][gl]["SUBPF"]=true
            end
        end
        if Healbot_Config_Skins.BarAggro[SkinName][gl]["SHOW"]==nil then 
            if Healbot_Config_Skins.Aggro and Healbot_Config_Skins.Aggro[SkinName] then 
                Healbot_Config_Skins.BarAggro[SkinName][gl]["SHOW"]=Healbot_Config_Skins.Aggro[SkinName]["SHOW"] or true
            else
                Healbot_Config_Skins.BarAggro[SkinName][gl]["SHOW"]=true
            end
        end
        if Healbot_Config_Skins.BarAggro[SkinName][gl]["SHOWBARS"]==nil then 
            if Healbot_Config_Skins.Aggro and Healbot_Config_Skins.Aggro[SkinName] then 
                Healbot_Config_Skins.BarAggro[SkinName][gl]["SHOWBARS"]=Healbot_Config_Skins.Aggro[SkinName]["SHOWBARS"] or true
            else
                Healbot_Config_Skins.BarAggro[SkinName][gl]["SHOWBARS"]=true
            end
        end
        if not Healbot_Config_Skins.BarAggro[SkinName][gl]["SHOWTEXT"] then
            Healbot_Config_Skins.BarAggro[SkinName][gl]["SHOWTEXT"]=1
        elseif Healbot_Config_Skins.BarAggro[SkinName][gl]["SHOWTEXT"]==true then
            Healbot_Config_Skins.BarAggro[SkinName][gl]["SHOWTEXT"]=2
        end
        if Healbot_Config_Skins.BarAggro[SkinName][gl]["SHOWIND"]==nil then 
            if Healbot_Config_Skins.Aggro and Healbot_Config_Skins.Aggro[SkinName] then 
                Healbot_Config_Skins.BarAggro[SkinName][gl]["SHOWIND"]=Healbot_Config_Skins.Aggro[SkinName]["SHOWIND"] or true
            else
                Healbot_Config_Skins.BarAggro[SkinName][gl]["SHOWIND"]=true
            end
        end
        if Healbot_Config_Skins.BarAggro[SkinName][gl]["SHOWBARSPCT"]==nil then 
            if Healbot_Config_Skins.Aggro and Healbot_Config_Skins.Aggro[SkinName] then 
                Healbot_Config_Skins.BarAggro[SkinName][gl]["SHOWBARSPCT"]=Healbot_Config_Skins.Aggro[SkinName]["SHOWBARSPCT"] or false
            else
                Healbot_Config_Skins.BarAggro[SkinName][gl]["SHOWBARSPCT"]=false
            end
        end
        if Healbot_Config_Skins.BarText[SkinName][gl]["TAGAGGROONLYTIP"]==nil then Healbot_Config_Skins.BarText[SkinName][gl]["TAGAGGROONLYTIP"]=true end
        if Healbot_Config_Skins.BarText[SkinName][gl]["TAGSTATEONLYTIP"]==nil then Healbot_Config_Skins.BarText[SkinName][gl]["TAGSTATEONLYTIP"]=true end
        if not Healbot_Config_Skins.BarAggro[SkinName][gl]["ALERT"] then Healbot_Config_Skins.BarAggro[SkinName][gl]["ALERT"]=2 end
        if not Healbot_Config_Skins.BarAggro[SkinName][gl]["ALERTADAP"] then Healbot_Config_Skins.BarAggro[SkinName][gl]["ALERTADAP"]=2 end
        if not Healbot_Config_Skins.BarAggro[SkinName][gl]["ALERTIND"] then 
            if Healbot_Config_Skins.Aggro and Healbot_Config_Skins.Aggro[SkinName] then 
                Healbot_Config_Skins.BarAggro[SkinName][gl]["ALERTIND"]=Healbot_Config_Skins.Aggro[SkinName]["ALERTIND"] or 2
            else
                Healbot_Config_Skins.BarAggro[SkinName][gl]["ALERTIND"]=2
            end
        end
        if not Healbot_Config_Skins.BarAggro[SkinName][gl]["R"] then 
            if Healbot_Config_Skins.Aggro and Healbot_Config_Skins.Aggro[SkinName] then 
                Healbot_Config_Skins.BarAggro[SkinName][gl]["R"]=Healbot_Config_Skins.Aggro[SkinName]["R"] or 1
            else
                Healbot_Config_Skins.BarAggro[SkinName][gl]["R"]=1
            end
        end
        if not Healbot_Config_Skins.BarAggro[SkinName][gl]["G"] then 
            if Healbot_Config_Skins.Aggro and Healbot_Config_Skins.Aggro[SkinName] then 
                Healbot_Config_Skins.BarAggro[SkinName][gl]["G"]=Healbot_Config_Skins.Aggro[SkinName]["G"] or 0
            else
                Healbot_Config_Skins.BarAggro[SkinName][gl]["G"]=0
            end
        end
        if not Healbot_Config_Skins.BarAggro[SkinName][gl]["B"] then 
            if Healbot_Config_Skins.Aggro and Healbot_Config_Skins.Aggro[SkinName] then 
                Healbot_Config_Skins.BarAggro[SkinName][gl]["B"]=Healbot_Config_Skins.Aggro[SkinName]["B"] or 0
            else
                Healbot_Config_Skins.BarAggro[SkinName][gl]["B"]=0
            end
        end
        if not Healbot_Config_Skins.BarAggro[SkinName][gl]["TEXTFORMAT"] then 
            if Healbot_Config_Skins.Aggro and Healbot_Config_Skins.Aggro[SkinName] then 
                Healbot_Config_Skins.BarAggro[SkinName][gl]["TEXTFORMAT"]=Healbot_Config_Skins.Aggro[SkinName]["TEXTFORMAT"] or 3
            else
                Healbot_Config_Skins.BarAggro[SkinName][gl]["TEXTFORMAT"]=3
            end
        end
        if Healbot_Config_Skins.BarVisibility[SkinName][gl]["HIDEOOR"]==nil then Healbot_Config_Skins.BarVisibility[SkinName][gl]["HIDEOOR"]=false end
        if Healbot_Config_Skins.Frame[SkinName][gl]["TIPLOC"]==nil then Healbot_Config_Skins.Frame[SkinName][gl]["TIPLOC"]=5 end
        if not Healbot_Config_Skins.Frame[SkinName][gl]["AUTOCLOSE"] then 
            Healbot_Config_Skins.Frame[SkinName][gl]["AUTOCLOSE"]=1
        elseif Healbot_Config_Skins.Frame[SkinName][gl]["AUTOCLOSE"]==true then
            Healbot_Config_Skins.Frame[SkinName][gl]["AUTOCLOSE"]=2
        end
        if Healbot_Config_Skins.Frame[SkinName][gl]["OPENSOUND"]~=nil then Healbot_Config_Skins.Frame[SkinName][gl]["OPENSOUND"]=nil end
        if not Healbot_Config_Skins.Frame[SkinName][gl]["LOCKED"] then 
            Healbot_Config_Skins.Frame[SkinName][gl]["LOCKED"]=1 
        elseif Healbot_Config_Skins.Frame[SkinName][gl]["LOCKED"]==true then
            Healbot_Config_Skins.Frame[SkinName][gl]["LOCKED"]=2
        end
        if Healbot_Config_Skins.Frame[SkinName][gl]["SCALE"]==nil then Healbot_Config_Skins.Frame[SkinName][gl]["SCALE"]=1 end
        if Healbot_Config_Skins.Frame[SkinName][gl]["PADDING"]==nil then Healbot_Config_Skins.Frame[SkinName][gl]["PADDING"]=1 end
        if Healbot_Config_Skins.Frame[SkinName][gl]["EDGEPADDING"]~=nil then
            Healbot_Config_Skins.Frame[SkinName][gl]["EDGEPADDING"]=nil
        end
        if Healbot_Config_Skins.Frame[SkinName][gl]["GLOW"]==nil then Healbot_Config_Skins.Frame[SkinName][gl]["GLOW"]=3 end
        if Healbot_Config_Skins.Frame[SkinName][gl]["BACKR"]==nil then Healbot_Config_Skins.Frame[SkinName][gl]["BACKR"]=0.2 end
        if Healbot_Config_Skins.Frame[SkinName][gl]["BACKG"]==nil then Healbot_Config_Skins.Frame[SkinName][gl]["BACKG"]=0.2 end
        if Healbot_Config_Skins.Frame[SkinName][gl]["BACKB"]==nil then Healbot_Config_Skins.Frame[SkinName][gl]["BACKB"]=0.7 end
        if Healbot_Config_Skins.Frame[SkinName][gl]["BACKA"]==nil then Healbot_Config_Skins.Frame[SkinName][gl]["BACKA"]=0.1 end
        if Healbot_Config_Skins.Frame[SkinName][gl]["BORDERR"]==nil then Healbot_Config_Skins.Frame[SkinName][gl]["BORDERR"]=0.2 end
        if Healbot_Config_Skins.Frame[SkinName][gl]["BORDERG"]==nil then Healbot_Config_Skins.Frame[SkinName][gl]["BORDERG"]=0.2 end
        if Healbot_Config_Skins.Frame[SkinName][gl]["BORDERB"]==nil then Healbot_Config_Skins.Frame[SkinName][gl]["BORDERB"]=0.2 end
        if Healbot_Config_Skins.Frame[SkinName][gl]["BORDERA"]==nil then Healbot_Config_Skins.Frame[SkinName][gl]["BORDERA"]=0.4 end
        if Healbot_Config_Skins.Frame[SkinName][gl]["SFOFFSETH"]==nil then Healbot_Config_Skins.Frame[SkinName][gl]["SFOFFSETH"]=0 end
        if Healbot_Config_Skins.Frame[SkinName][gl]["SFOFFSETV"]==nil then Healbot_Config_Skins.Frame[SkinName][gl]["SFOFFSETV"]=0 end
        if Healbot_Config_Skins.StickyFrames[SkinName][gl]["STUCK"]==nil then Healbot_Config_Skins.StickyFrames[SkinName][gl]["STUCK"]=false end
        if Healbot_Config_Skins.StickyFrames[SkinName][gl]["STUCKTO"]==nil then Healbot_Config_Skins.StickyFrames[SkinName][gl]["STUCKTO"]=0 end
        if Healbot_Config_Skins.StickyFrames[SkinName][gl]["STUCKPOINT"]==nil then Healbot_Config_Skins.StickyFrames[SkinName][gl]["STUCKPOINT"]="NONE" end
        if Healbot_Config_Skins.StickyFrames[SkinName][gl]["STUCKTOPOINT"]==nil then Healbot_Config_Skins.StickyFrames[SkinName][gl]["STUCKTOPOINT"]="NONE" end

        HealBot_Skins_Check_IconSetsText(SkinName, gl, "DURTHRH", "DBDURTHRH", 9)
        HealBot_Skins_Check_IconSetsText(SkinName, gl, "BUFFDURTHRH", "BUFFDURTHRH", 9)
        HealBot_Skins_Check_IconSetsText(SkinName, gl, "DURWARN", "DBDURWARN", 3)
        HealBot_Skins_Check_IconSetsText(SkinName, gl, "BUFFDURWARN", "BUFFDURWARN", 3)
        HealBot_Skins_Check_IconSetsText(SkinName, gl, "SCNT", "DBSCNT", true)
        HealBot_Skins_Check_IconSetsText(SkinName, gl, "BUFFSCNT", "BUFFSCNT", true)
        HealBot_Skins_Check_IconSetsText(SkinName, gl, "BUFFSSCNT", "BUFFSSCNT", false)
        HealBot_Skins_Check_IconSetsText(SkinName, gl, "SDUR", "DBSDUR", false)
        HealBot_Skins_Check_IconSetsText(SkinName, gl, "BUFFSDUR", "BUFFSDUR", true)
        if Healbot_Config_Skins.IconText[SkinName][gl]["SELFIND"]==nil then Healbot_Config_Skins.IconText[SkinName][gl]["SELFIND"]=false end

        HealBot_Skins_Check_IconSetsText(SkinName, gl, "BUFFSSDUR", "BUFFSSDUR", false)
        HealBot_Skins_Check_IconSetsText(SkinName, gl, "FONT", "DBFONT", HealBot_Default_Font)
        HealBot_Skins_Check_IconSetsText(SkinName, gl, "BUFFFONT", "BUFFFONT", HealBot_Default_Font)
        HealBot_Skins_Check_IconSetsText(SkinName, gl, "OUTLINE", "DBOUTLINE", 2)
        HealBot_Skins_Check_IconSetsText(SkinName, gl, "BUFFOUTLINE", "BUFFOUTLINE", 2)
        if Healbot_Config_Skins.RaidIcon[SkinName][gl]["SHOW"]==nil then Healbot_Config_Skins.RaidIcon[SkinName][gl]["SHOW"]=true end
        if Healbot_Config_Skins.RaidIcon[SkinName][gl]["STAR"]==nil then Healbot_Config_Skins.RaidIcon[SkinName][gl]["STAR"]=true end
        if Healbot_Config_Skins.RaidIcon[SkinName][gl]["CIRCLE"]==nil then Healbot_Config_Skins.RaidIcon[SkinName][gl]["CIRCLE"]=true end
        if Healbot_Config_Skins.RaidIcon[SkinName][gl]["DIAMOND"]==nil then Healbot_Config_Skins.RaidIcon[SkinName][gl]["DIAMOND"]=true end
        if Healbot_Config_Skins.RaidIcon[SkinName][gl]["TRIANGLE"]==nil then Healbot_Config_Skins.RaidIcon[SkinName][gl]["TRIANGLE"]=true end
        if Healbot_Config_Skins.RaidIcon[SkinName][gl]["MOON"]==nil then Healbot_Config_Skins.RaidIcon[SkinName][gl]["MOON"]=true end
        if Healbot_Config_Skins.RaidIcon[SkinName][gl]["SQUARE"]==nil then Healbot_Config_Skins.RaidIcon[SkinName][gl]["SQUARE"]=true end
        if Healbot_Config_Skins.RaidIcon[SkinName][gl]["CROSS"]==nil then Healbot_Config_Skins.RaidIcon[SkinName][gl]["CROSS"]=true end
        if Healbot_Config_Skins.RaidIcon[SkinName][gl]["SKULL"]==nil then Healbot_Config_Skins.RaidIcon[SkinName][gl]["SKULL"]=true end
        HealBot_Skins_Check_IconSets(SkinName, gl, "DEBUFFONBAR", "DEBUFFONBAR", 1)
        HealBot_Skins_Check_IconSets(SkinName, gl, "BUFFONBAR", "BUFFONBAR", 1)
        if fromImport then
            Healbot_Config_Skins.Icons[SkinName][gl]["CLASSONBAR"]=1 
            Healbot_Config_Skins.Icons[SkinName][gl]["TARGETONBAR"]=1 
            Healbot_Config_Skins.Icons[SkinName][gl]["RCONBAR"]=1 
            Healbot_Config_Skins.Icons[SkinName][gl]["OORONBAR"]=1
        else
            if Healbot_Config_Skins.Icons[SkinName][gl]["CLASSONBAR"]==nil then Healbot_Config_Skins.Icons[SkinName][gl]["CLASSONBAR"]=1 end
            if Healbot_Config_Skins.Icons[SkinName][gl]["TARGETONBAR"]==nil then Healbot_Config_Skins.Icons[SkinName][gl]["TARGETONBAR"]=1 end
            if Healbot_Config_Skins.Icons[SkinName][gl]["RCONBAR"]==nil then Healbot_Config_Skins.Icons[SkinName][gl]["RCONBAR"]=1 end
            if Healbot_Config_Skins.Icons[SkinName][gl]["OORONBAR"]==nil then Healbot_Config_Skins.Icons[SkinName][gl]["OORONBAR"]=1 end
        end

        HealBot_Skins_Check_IconSets(SkinName, gl, "DEBUFFDOUBLE", "DEBUFFDOUBLE", false)
        HealBot_Skins_Check_IconSets(SkinName, gl, "BUFFDOUBLE", "BUFFDOUBLE", false)
        if Healbot_Config_Skins.Icons[SkinName][gl]["SHOWRC"]==nil then Healbot_Config_Skins.Icons[SkinName][gl]["SHOWRC"]=true end
        if Healbot_Config_Skins.Icons[SkinName][gl]["SHOWCOMBAT"]==nil then Healbot_Config_Skins.Icons[SkinName][gl]["SHOWCOMBAT"]=false end
        if Healbot_Config_Skins.Icons[SkinName][gl]["SHOWHOSTILE"]==nil then Healbot_Config_Skins.Icons[SkinName][gl]["SHOWHOSTILE"]=false end
        if Healbot_Config_Skins.Icons[SkinName][gl]["SHOWRESTING"]==nil then Healbot_Config_Skins.Icons[SkinName][gl]["SHOWRESTING"]=false end
        if Healbot_Config_Skins.Icons[SkinName][gl]["SHOWDIR"]==nil then Healbot_Config_Skins.Icons[SkinName][gl]["SHOWDIR"]=false end
        if Healbot_Config_Skins.Icons[SkinName][gl]["SHOWDIRMOUSE"]==nil then Healbot_Config_Skins.Icons[SkinName][gl]["SHOWDIRMOUSE"]=false end
        HealBot_Skins_Check_IconSets(SkinName, gl, "SCALE", "BSCALE", 0.3, 0.4)
        HealBot_Skins_Check_IconSets(SkinName, gl, "DSCALE", "DSCALE", 0.3, 0.4)
        HealBot_Skins_Check_IconSets(SkinName, gl, "I15EN", "DI15EN", true)
        HealBot_Skins_Check_IconSets(SkinName, gl, "BUFFI15EN", "BUFFI15EN", true)

        HealBot_Skins_Check_IconSets(SkinName, gl, "DEBUFFANCHOR", "DEBUFFANCHOR", 1, 3, 7)
        HealBot_Skins_Check_IconSets(SkinName, gl, "BUFFANCHOR", "BUFFANCHOR", 2, 4, 8)
        if Healbot_Config_Skins.Icons[SkinName][gl]["CLASSANCHOR"]==nil then Healbot_Config_Skins.Icons[SkinName][gl]["CLASSANCHOR"]=1 end
        if Healbot_Config_Skins.Icons[SkinName][gl]["TARGETANCHOR"]==nil then Healbot_Config_Skins.Icons[SkinName][gl]["TARGETANCHOR"]=1 end
        if Healbot_Config_Skins.Icons[SkinName][gl]["RCANCHOR"]==nil then Healbot_Config_Skins.Icons[SkinName][gl]["RCANCHOR"]=1 end
        if Healbot_Config_Skins.Icons[SkinName][gl]["OORANCHOR"]==nil then Healbot_Config_Skins.Icons[SkinName][gl]["OORANCHOR"]=1 end

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
        if Healbot_Config_Skins.Icons[SkinName][gl]["SHOWCLASS"]==nil then Healbot_Config_Skins.Icons[SkinName][gl]["SHOWCLASS"]=false end
        if Healbot_Config_Skins.Icons[SkinName][gl]["SHOWROLE"]==nil then Healbot_Config_Skins.Icons[SkinName][gl]["SHOWROLE"]=false end
        if not Healbot_Config_Skins.Icons[SkinName][gl]["CLASSVOFFSET"] then Healbot_Config_Skins.Icons[SkinName][gl]["CLASSVOFFSET"]=0 end
        if Healbot_Config_Skins.Icons[SkinName][gl]["CLASSHOFFSET"]==nil then Healbot_Config_Skins.Icons[SkinName][gl]["CLASSHOFFSET"]=0 end
        if Healbot_Config_Skins.Icons[SkinName][gl]["CLASSSCALE"]==nil then Healbot_Config_Skins.Icons[SkinName][gl]["CLASSSCALE"]=0.5 end
        if Healbot_Config_Skins.Icons[SkinName][gl]["CLASSEN"]==nil then Healbot_Config_Skins.Icons[SkinName][gl]["CLASSEN"]=false end
        if not Healbot_Config_Skins.Icons[SkinName][gl]["TARGETVOFFSET"] then Healbot_Config_Skins.Icons[SkinName][gl]["TARGETVOFFSET"]=0 end
        if Healbot_Config_Skins.Icons[SkinName][gl]["TARGETHOFFSET"]==nil then Healbot_Config_Skins.Icons[SkinName][gl]["TARGETHOFFSET"]=0 end
        if Healbot_Config_Skins.Icons[SkinName][gl]["TARGETSCALE"]==nil then Healbot_Config_Skins.Icons[SkinName][gl]["TARGETSCALE"]=0.5 end
        if Healbot_Config_Skins.Icons[SkinName][gl]["TARGETEN"]==nil then Healbot_Config_Skins.Icons[SkinName][gl]["TARGETEN"]=false end
        if not Healbot_Config_Skins.Icons[SkinName][gl]["RCVOFFSET"] then Healbot_Config_Skins.Icons[SkinName][gl]["RCVOFFSET"]=0 end
        if Healbot_Config_Skins.Icons[SkinName][gl]["RCHOFFSET"]==nil then Healbot_Config_Skins.Icons[SkinName][gl]["RCHOFFSET"]=0 end

        HealBot_Skins_Check_IconSets(SkinName, gl, "DVOFFSET", "DVOFFSET", 0)
        HealBot_Skins_Check_IconSets(SkinName, gl, "DHOFFSET", "DHOFFSET", 0)
        HealBot_Skins_Check_IconSets(SkinName, gl, "BVOFFSET", "BVOFFSET", 0)
        HealBot_Skins_Check_IconSets(SkinName, gl, "BHOFFSET", "BHOFFSET", 0)
        if Healbot_Config_Skins.Icons[SkinName][gl]["RCSCALE"]==nil then Healbot_Config_Skins.Icons[SkinName][gl]["RCSCALE"]=0.5 end
        if Healbot_Config_Skins.Icons[SkinName][gl]["RCEN"]==nil then Healbot_Config_Skins.Icons[SkinName][gl]["RCEN"]=false end
        if not Healbot_Config_Skins.Icons[SkinName][gl]["OORVOFFSET"] then Healbot_Config_Skins.Icons[SkinName][gl]["OORVOFFSET"]=0 end
        if Healbot_Config_Skins.Icons[SkinName][gl]["OORHOFFSET"]==nil then Healbot_Config_Skins.Icons[SkinName][gl]["OORHOFFSET"]=0 end
        if Healbot_Config_Skins.Icons[SkinName][gl]["OORSCALE"]==nil then Healbot_Config_Skins.Icons[SkinName][gl]["OORSCALE"]=0.5 end
        if Healbot_Config_Skins.Icons[SkinName][gl]["OOREN"]==nil then Healbot_Config_Skins.Icons[SkinName][gl]["OOREN"]=false end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["NCR"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["NCR"]=0 end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["NCG"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["NCG"]=1 end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["NCB"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["NCB"]=0 end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["NICR"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["NICR"]=Healbot_Config_Skins.BarTextCol[SkinName][gl]["NCR"] end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["NICG"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["NICG"]=Healbot_Config_Skins.BarTextCol[SkinName][gl]["NCG"] end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["NICB"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["NICB"]=Healbot_Config_Skins.BarTextCol[SkinName][gl]["NCB"] end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["NCCR"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["NCCR"]=Healbot_Config_Skins.BarTextCol[SkinName][gl]["NCR"] end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["NCCG"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["NCCG"]=Healbot_Config_Skins.BarTextCol[SkinName][gl]["NCG"] end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["NCCB"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["NCCB"]=Healbot_Config_Skins.BarTextCol[SkinName][gl]["NCB"] end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["NIT"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["NIT"]=70 end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["NCT"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["NCT"]=40 end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["NCA"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["NCA"]=0.95 end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["NCDA"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["NCDA"]=0.5 end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["NDCR"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["NDCR"]=1 end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["NDCG"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["NDCG"]=0.2 end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["NDCB"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["NDCB"]=0.2 end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["NRCR"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["NRCR"]=0.2 end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["NRCG"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["NRCG"]=1 end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["NRCB"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["NRCB"]=0.2 end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["NSCR"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["NSCR"]=0.4 end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["NSCG"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["NSCG"]=0.02 end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["NSCB"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["NSCB"]=0.4 end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["SCR"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["SCR"]=1 end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["SCG"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["SCG"]=1 end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["SCB"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["SCB"]=0 end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["SCA"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["SCA"]=0.95 end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["SICR"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["SICR"]=Healbot_Config_Skins.BarTextCol[SkinName][gl]["SCR"] end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["SICG"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["SICG"]=Healbot_Config_Skins.BarTextCol[SkinName][gl]["SCG"] end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["SICB"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["SICB"]=Healbot_Config_Skins.BarTextCol[SkinName][gl]["SCB"] end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["SCCR"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["SCCR"]=Healbot_Config_Skins.BarTextCol[SkinName][gl]["SCR"] end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["SCCG"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["SCCG"]=Healbot_Config_Skins.BarTextCol[SkinName][gl]["SCG"] end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["SCCB"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["SCCB"]=Healbot_Config_Skins.BarTextCol[SkinName][gl]["SCB"] end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["SIT"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["SIT"]=70 end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["SCT"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["SCT"]=40 end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["SCDA"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["SCDA"]=0.5 end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["SDCR"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["SDCR"]=1 end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["SDCG"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["SDCG"]=0.2 end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["SDCB"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["SDCB"]=0.2 end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["SRCR"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["SRCR"]=0.2 end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["SRCG"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["SRCG"]=1 end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["SRCB"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["SRCB"]=0.2 end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["SSCR"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["SSCR"]=0.4 end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["SSCG"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["SSCG"]=0.02 end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["SSCB"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["SSCB"]=0.4 end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["NAME"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["NAME"]=2 end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["STATE"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["STATE"]=2 end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["HECR"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["HECR"]=0 end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["HECG"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["HECG"]=1 end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["HECB"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["HECB"]=0 end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["HCR"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["HCR"]=0 end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["HCG"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["HCG"]=1 end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["HCB"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["HCB"]=0 end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["HCA"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["HCA"]=0.95 end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["HICR"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["HICR"]=Healbot_Config_Skins.BarTextCol[SkinName][gl]["HCR"] end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["HICG"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["HICG"]=Healbot_Config_Skins.BarTextCol[SkinName][gl]["HCG"] end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["HICB"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["HICB"]=Healbot_Config_Skins.BarTextCol[SkinName][gl]["HCB"] end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["HCCR"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["HCCR"]=Healbot_Config_Skins.BarTextCol[SkinName][gl]["HCR"] end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["HCCG"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["HCCG"]=Healbot_Config_Skins.BarTextCol[SkinName][gl]["HCG"] end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["HCCB"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["HCCB"]=Healbot_Config_Skins.BarTextCol[SkinName][gl]["HCB"] end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["HIT"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["HIT"]=70 end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["HCT"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["HCT"]=40 end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["HCDA"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["HCDA"]=0.5 end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["OCR"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["OCR"]=0.1 end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["OCG"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["OCG"]=1 end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["OCB"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["OCB"]=0.1 end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["ICR"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["ICR"]=0.1 end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["ICG"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["ICG"]=1 end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["ICB"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["ICB"]=0.1 end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["ACR"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["ACR"]=1 end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["ACG"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["ACG"]=0.1 end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["ACB"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["ACB"]=0.1 end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["ACA"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["ACA"]=0.95 end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["AICR"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["AICR"]=Healbot_Config_Skins.BarTextCol[SkinName][gl]["ACR"] end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["AICG"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["AICG"]=Healbot_Config_Skins.BarTextCol[SkinName][gl]["ACG"] end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["AICB"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["AICB"]=Healbot_Config_Skins.BarTextCol[SkinName][gl]["ACB"] end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["ACCR"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["ACCR"]=Healbot_Config_Skins.BarTextCol[SkinName][gl]["ACR"] end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["ACCG"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["ACCG"]=Healbot_Config_Skins.BarTextCol[SkinName][gl]["ACG"] end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["ACCB"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["ACCB"]=Healbot_Config_Skins.BarTextCol[SkinName][gl]["ACB"] end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["AIT"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["AIT"]=70 end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["ACT"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["ACT"]=40 end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["ACDA"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["ACDA"]=0.5 end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["HLTH"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["HLTH"]=2 end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["AGGRO"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["AGGRO"]=2 end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["NDEBUFF"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["NDEBUFF"]=false end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["HDEBUFF"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["HDEBUFF"]=false end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["RIP"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["RIP"]=true end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["RES"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["RES"]=true end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["SUM"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["SUM"]=false end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["SRIP"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["SRIP"]=true end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["SRES"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["SRES"]=true end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["SSUM"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["SSUM"]=false end
        if Healbot_Config_Skins.BarText[SkinName][gl]["FONT"]==nil then Healbot_Config_Skins.BarText[SkinName][gl]["FONT"]=HealBot_Default_Font end
        if Healbot_Config_Skins.BarText[SkinName][gl]["HFONT"]==nil then Healbot_Config_Skins.BarText[SkinName][gl]["HFONT"]=HealBot_Default_Font end
        if Healbot_Config_Skins.BarText[SkinName][gl]["SFONT"]==nil then Healbot_Config_Skins.BarText[SkinName][gl]["SFONT"]=Healbot_Config_Skins.BarText[SkinName][gl]["FONT"] end
        if Healbot_Config_Skins.BarText[SkinName][gl]["AFONT"]==nil then Healbot_Config_Skins.BarText[SkinName][gl]["AFONT"]=Healbot_Config_Skins.BarText[SkinName][gl]["HFONT"] end
        if Healbot_Config_Skins.BarText[SkinName][gl]["HEIGHT"]==nil then Healbot_Config_Skins.BarText[SkinName][gl]["HEIGHT"]=10 end
        if Healbot_Config_Skins.BarText[SkinName][gl]["HHEIGHT"]==nil then Healbot_Config_Skins.BarText[SkinName][gl]["HHEIGHT"]=10 end
        if Healbot_Config_Skins.BarText[SkinName][gl]["SHEIGHT"]==nil then Healbot_Config_Skins.BarText[SkinName][gl]["SHEIGHT"]=Healbot_Config_Skins.BarText[SkinName][gl]["HEIGHT"] end
        if Healbot_Config_Skins.BarText[SkinName][gl]["AHEIGHT"]==nil then Healbot_Config_Skins.BarText[SkinName][gl]["AHEIGHT"]=Healbot_Config_Skins.BarText[SkinName][gl]["HHEIGHT"] end
        if Healbot_Config_Skins.BarText[SkinName][gl]["SHOWROLE"]==nil then Healbot_Config_Skins.BarText[SkinName][gl]["SHOWROLE"]=true end
        if Healbot_Config_Skins.BarText[SkinName][gl]["CLASSONBAR"]==nil then Healbot_Config_Skins.BarText[SkinName][gl]["CLASSONBAR"]=false end
        if Healbot_Config_Skins.BarText[SkinName][gl]["OFFSET"]==nil then Healbot_Config_Skins.BarText[SkinName][gl]["OFFSET"]=0 end
        if Healbot_Config_Skins.BarText[SkinName][gl]["OFFSET2"]==nil then Healbot_Config_Skins.BarText[SkinName][gl]["OFFSET2"]=0 end
        if Healbot_Config_Skins.BarText[SkinName][gl]["SOFFSET"]==nil then Healbot_Config_Skins.BarText[SkinName][gl]["SOFFSET"]=0 end
        if Healbot_Config_Skins.BarText[SkinName][gl]["AOFFSET"]==nil then Healbot_Config_Skins.BarText[SkinName][gl]["AOFFSET"]=0 end
        if Healbot_Config_Skins.BarText[SkinName][gl]["AOFFSET2"]==nil then Healbot_Config_Skins.BarText[SkinName][gl]["AOFFSET2"]=0 end
        if Healbot_Config_Skins.BarText[SkinName][gl]["HOFFSET"]==nil then Healbot_Config_Skins.BarText[SkinName][gl]["HOFFSET"]=0 end
        if Healbot_Config_Skins.BarText[SkinName][gl]["NAMEONBAR"]==nil then Healbot_Config_Skins.BarText[SkinName][gl]["NAMEONBAR"]=true end
        if Healbot_Config_Skins.BarText[SkinName][gl]["HLTHONBAR"]==nil then Healbot_Config_Skins.BarText[SkinName][gl]["HLTHONBAR"]=true end
        if Healbot_Config_Skins.BarText[SkinName][gl]["HLTHINVEHSHOWPLAYER"]==nil then Healbot_Config_Skins.BarText[SkinName][gl]["HLTHINVEHSHOWPLAYER"]=true end
        if Healbot_Config_Skins.BarText[SkinName][gl]["IGNOREONFULL"]==nil then Healbot_Config_Skins.BarText[SkinName][gl]["IGNOREONFULL"]=true end
        if Healbot_Config_Skins.BarText[SkinName][gl]["ALIGN"]==nil then Healbot_Config_Skins.BarText[SkinName][gl]["ALIGN"]=2 end
        if Healbot_Config_Skins.BarText[SkinName][gl]["HOFFSET2"]==nil then Healbot_Config_Skins.BarText[SkinName][gl]["HOFFSET2"]=0 end
        if Healbot_Config_Skins.BarText[SkinName][gl]["SOFFSET2"]==nil then Healbot_Config_Skins.BarText[SkinName][gl]["SOFFSET2"]=0 end
        if Healbot_Config_Skins.BarText[SkinName][gl]["INCHEALS"]==nil then Healbot_Config_Skins.BarText[SkinName][gl]["INCHEALS"]=2 end
        if Healbot_Config_Skins.BarText[SkinName][gl]["INCABSORBS"]==nil then Healbot_Config_Skins.BarText[SkinName][gl]["INCABSORBS"]=1 end
        if Healbot_Config_Skins.BarText[SkinName][gl]["OVERHEAL"]==nil then Healbot_Config_Skins.BarText[SkinName][gl]["OVERHEAL"]=1 end
        if Healbot_Config_Skins.BarText[SkinName][gl]["OVERHEALFORMAT"]==nil then Healbot_Config_Skins.BarText[SkinName][gl]["OVERHEALFORMAT"]=2 end
        if Healbot_Config_Skins.BarText[SkinName][gl]["OVERHEALCOL"]==nil then Healbot_Config_Skins.BarText[SkinName][gl]["OVERHEALCOL"]=1 end
        if Healbot_Config_Skins.BarText[SkinName][gl]["SEPARATEFORMAT"]==nil then Healbot_Config_Skins.BarText[SkinName][gl]["SEPARATEFORMAT"]=3 end
        if Healbot_Config_Skins.BarText[SkinName][gl]["SEPARATECOL"]==nil then Healbot_Config_Skins.BarText[SkinName][gl]["SEPARATECOL"]=1 end
        if Healbot_Config_Skins.BarText[SkinName][gl]["HEALEXTRACOL"]==nil then Healbot_Config_Skins.BarText[SkinName][gl]["HEALEXTRACOL"]=1 end
        if Healbot_Config_Skins.BarText[SkinName][gl]["HLTHTXTANCHOR"]==nil then Healbot_Config_Skins.BarText[SkinName][gl]["HLTHTXTANCHOR"]=1 end
        if Healbot_Config_Skins.BarText[SkinName][gl]["STATETXTANCHOR"]==nil then Healbot_Config_Skins.BarText[SkinName][gl]["STATETXTANCHOR"]=1 end
        if Healbot_Config_Skins.BarText[SkinName][gl]["AGGROTXTANCHOR"]==nil then Healbot_Config_Skins.BarText[SkinName][gl]["AGGROTXTANCHOR"]=3 end
        if Healbot_Config_Skins.BarText[SkinName][gl]["NUMFORMAT1"]==nil then Healbot_Config_Skins.BarText[SkinName][gl]["NUMFORMAT1"]=1 end
        if Healbot_Config_Skins.BarText[SkinName][gl]["NUMFORMAT2"]==nil then Healbot_Config_Skins.BarText[SkinName][gl]["NUMFORMAT2"]=1 end
        if Healbot_Config_Skins.BarText[SkinName][gl]["OUTLINE"]==nil then Healbot_Config_Skins.BarText[SkinName][gl]["OUTLINE"]=1 end
        if Healbot_Config_Skins.BarText[SkinName][gl]["HOUTLINE"]==nil then Healbot_Config_Skins.BarText[SkinName][gl]["HOUTLINE"]=1 end
        if Healbot_Config_Skins.BarText[SkinName][gl]["SOUTLINE"]==nil then Healbot_Config_Skins.BarText[SkinName][gl]["SOUTLINE"]=Healbot_Config_Skins.BarText[SkinName][gl]["OUTLINE"] end
        if Healbot_Config_Skins.BarText[SkinName][gl]["AOUTLINE"]==nil then Healbot_Config_Skins.BarText[SkinName][gl]["AOUTLINE"]=Healbot_Config_Skins.BarText[SkinName][gl]["HOUTLINE"] end
        if Healbot_Config_Skins.BarText[SkinName][gl]["HLTHTYPE"]==nil then Healbot_Config_Skins.BarText[SkinName][gl]["HLTHTYPE"]=1 end
        if Healbot_Config_Skins.BarText[SkinName][gl]["MAXCHARS"]==nil then Healbot_Config_Skins.BarText[SkinName][gl]["MAXCHARS"]=0 end
        if Healbot_Config_Skins.BarText[SkinName][gl]["HMAXCHARS"]==nil then Healbot_Config_Skins.BarText[SkinName][gl]["HMAXCHARS"]=0 end
        if Healbot_Config_Skins.BarText[SkinName][gl]["TAGDC"]==nil then Healbot_Config_Skins.BarText[SkinName][gl]["TAGDC"]=HEALBOT_DISCONNECTED_TAG end
        if Healbot_Config_Skins.BarText[SkinName][gl]["TAGRIP"]==nil then Healbot_Config_Skins.BarText[SkinName][gl]["TAGRIP"]=HEALBOT_DEAD_TAG end
        if Healbot_Config_Skins.BarText[SkinName][gl]["TAGOOR"]==nil then Healbot_Config_Skins.BarText[SkinName][gl]["TAGOOR"]=HEALBOT_OUTOFRANGE_TAG end
        if Healbot_Config_Skins.BarText[SkinName][gl]["TAGR"]==nil then Healbot_Config_Skins.BarText[SkinName][gl]["TAGR"]=HEALBOT_RESERVED_TAG end
        if Healbot_Config_Skins.BarText[SkinName][gl]["TAGRES"]==nil then 
            if string.len(Healbot_Config_Skins.BarText[SkinName][gl]["TAGRIP"])>0 then
                Healbot_Config_Skins.BarText[SkinName][gl]["TAGRES"]=HEALBOT_RES_TAG
            else
                Healbot_Config_Skins.BarText[SkinName][gl]["TAGRES"]=""
            end
        end
        if Healbot_Config_Skins.BarText[SkinName][gl]["TAGSUM"]==nil then Healbot_Config_Skins.BarText[SkinName][gl]["TAGSUM"]=HEALBOT_SUMMONS_TAG end
        if Healbot_Config_Skins.BarIACol[SkinName][gl]["IC"]==nil then Healbot_Config_Skins.BarIACol[SkinName][gl]["IC"]=3 end
        if Healbot_Config_Skins.BarIACol[SkinName][gl]["IR"]==nil then Healbot_Config_Skins.BarIACol[SkinName][gl]["IR"]=0.2 end
        if Healbot_Config_Skins.BarIACol[SkinName][gl]["IG"]==nil then Healbot_Config_Skins.BarIACol[SkinName][gl]["IG"]=1 end
        if Healbot_Config_Skins.BarIACol[SkinName][gl]["IB"]==nil then Healbot_Config_Skins.BarIACol[SkinName][gl]["IB"]=0.2 end
        if Healbot_Config_Skins.BarIACol[SkinName][gl]["IIR"]==nil then Healbot_Config_Skins.BarIACol[SkinName][gl]["IIR"]=Healbot_Config_Skins.BarIACol[SkinName][gl]["IR"] end
        if Healbot_Config_Skins.BarIACol[SkinName][gl]["IIG"]==nil then Healbot_Config_Skins.BarIACol[SkinName][gl]["IIG"]=Healbot_Config_Skins.BarIACol[SkinName][gl]["IG"] end
        if Healbot_Config_Skins.BarIACol[SkinName][gl]["IIB"]==nil then Healbot_Config_Skins.BarIACol[SkinName][gl]["IIB"]=Healbot_Config_Skins.BarIACol[SkinName][gl]["IB"] end
        if Healbot_Config_Skins.BarIACol[SkinName][gl]["ICR"]==nil then Healbot_Config_Skins.BarIACol[SkinName][gl]["ICR"]=Healbot_Config_Skins.BarIACol[SkinName][gl]["IIR"] end
        if Healbot_Config_Skins.BarIACol[SkinName][gl]["ICG"]==nil then Healbot_Config_Skins.BarIACol[SkinName][gl]["ICG"]=Healbot_Config_Skins.BarIACol[SkinName][gl]["IIG"] end
        if Healbot_Config_Skins.BarIACol[SkinName][gl]["ICB"]==nil then Healbot_Config_Skins.BarIACol[SkinName][gl]["ICB"]=Healbot_Config_Skins.BarIACol[SkinName][gl]["IIB"] end
        if Healbot_Config_Skins.BarIACol[SkinName][gl]["IIT"]==nil then Healbot_Config_Skins.BarIACol[SkinName][gl]["IIT"]=0.7 end
        if Healbot_Config_Skins.BarIACol[SkinName][gl]["ICT"]==nil then Healbot_Config_Skins.BarIACol[SkinName][gl]["ICT"]=0.4 end
        if Healbot_Config_Skins.BarIACol[SkinName][gl]["IA"]==nil then Healbot_Config_Skins.BarIACol[SkinName][gl]["IA"]=0.82 end
        if Healbot_Config_Skins.BarIACol[SkinName][gl]["AC"]==nil then Healbot_Config_Skins.BarIACol[SkinName][gl]["AC"]=3 end
        if Healbot_Config_Skins.BarIACol[SkinName][gl]["AR"]==nil then Healbot_Config_Skins.BarIACol[SkinName][gl]["AR"]=1 end
        if Healbot_Config_Skins.BarIACol[SkinName][gl]["AG"]==nil then Healbot_Config_Skins.BarIACol[SkinName][gl]["AG"]=1 end
        if Healbot_Config_Skins.BarIACol[SkinName][gl]["AB"]==nil then Healbot_Config_Skins.BarIACol[SkinName][gl]["AB"]=1 end
        if Healbot_Config_Skins.BarIACol[SkinName][gl]["AIR"]==nil then Healbot_Config_Skins.BarIACol[SkinName][gl]["AIR"]=Healbot_Config_Skins.BarIACol[SkinName][gl]["AR"] end
        if Healbot_Config_Skins.BarIACol[SkinName][gl]["AIG"]==nil then Healbot_Config_Skins.BarIACol[SkinName][gl]["AIG"]=Healbot_Config_Skins.BarIACol[SkinName][gl]["AG"] end
        if Healbot_Config_Skins.BarIACol[SkinName][gl]["AIB"]==nil then Healbot_Config_Skins.BarIACol[SkinName][gl]["AIB"]=Healbot_Config_Skins.BarIACol[SkinName][gl]["AB"] end
        if Healbot_Config_Skins.BarIACol[SkinName][gl]["ACR"]==nil then Healbot_Config_Skins.BarIACol[SkinName][gl]["ACR"]=Healbot_Config_Skins.BarIACol[SkinName][gl]["AIR"] end
        if Healbot_Config_Skins.BarIACol[SkinName][gl]["ACG"]==nil then Healbot_Config_Skins.BarIACol[SkinName][gl]["ACG"]=Healbot_Config_Skins.BarIACol[SkinName][gl]["AIG"] end
        if Healbot_Config_Skins.BarIACol[SkinName][gl]["ACB"]==nil then Healbot_Config_Skins.BarIACol[SkinName][gl]["ACB"]=Healbot_Config_Skins.BarIACol[SkinName][gl]["AIB"] end
        if Healbot_Config_Skins.BarIACol[SkinName][gl]["AIT"]==nil then Healbot_Config_Skins.BarIACol[SkinName][gl]["AIT"]=0.7 end
        if Healbot_Config_Skins.BarIACol[SkinName][gl]["ACT"]==nil then Healbot_Config_Skins.BarIACol[SkinName][gl]["ACT"]=0.4 end
        if Healbot_Config_Skins.BarIACol[SkinName][gl]["AA"]==nil then Healbot_Config_Skins.BarIACol[SkinName][gl]["AA"]=0.78 end
        if Healbot_Config_Skins.BarCol[SkinName][gl]["HLTH"]==nil then Healbot_Config_Skins.BarCol[SkinName][gl]["HLTH"]=4 end
        if Healbot_Config_Skins.BarCol[SkinName][gl]["BACK"]==nil then Healbot_Config_Skins.BarCol[SkinName][gl]["BACK"]=1 end
        if Healbot_Config_Skins.BarCol[SkinName][gl]["BORDER"]==nil then Healbot_Config_Skins.BarCol[SkinName][gl]["BORDER"]=1 end
        if Healbot_Config_Skins.BarCol[SkinName][gl]["HR"]==nil then Healbot_Config_Skins.BarCol[SkinName][gl]["HR"]=0.4 end
        if Healbot_Config_Skins.BarCol[SkinName][gl]["HG"]==nil then Healbot_Config_Skins.BarCol[SkinName][gl]["HG"]=0.7 end
        if Healbot_Config_Skins.BarCol[SkinName][gl]["HB"]==nil then Healbot_Config_Skins.BarCol[SkinName][gl]["HB"]=0.7 end
        if Healbot_Config_Skins.BarCol[SkinName][gl]["HA"]==nil then Healbot_Config_Skins.BarCol[SkinName][gl]["HA"]=1 end
        if Healbot_Config_Skins.BarCol[SkinName][gl]["HIR"]==nil then Healbot_Config_Skins.BarCol[SkinName][gl]["HIR"]=Healbot_Config_Skins.BarCol[SkinName][gl]["HR"] end
        if Healbot_Config_Skins.BarCol[SkinName][gl]["HIG"]==nil then Healbot_Config_Skins.BarCol[SkinName][gl]["HIG"]=Healbot_Config_Skins.BarCol[SkinName][gl]["HG"] end
        if Healbot_Config_Skins.BarCol[SkinName][gl]["HIB"]==nil then Healbot_Config_Skins.BarCol[SkinName][gl]["HIB"]=Healbot_Config_Skins.BarCol[SkinName][gl]["HB"] end
        if Healbot_Config_Skins.BarCol[SkinName][gl]["HCR"]==nil then Healbot_Config_Skins.BarCol[SkinName][gl]["HCR"]=Healbot_Config_Skins.BarCol[SkinName][gl]["HIR"] end
        if Healbot_Config_Skins.BarCol[SkinName][gl]["HCG"]==nil then Healbot_Config_Skins.BarCol[SkinName][gl]["HCG"]=Healbot_Config_Skins.BarCol[SkinName][gl]["HIG"] end
        if Healbot_Config_Skins.BarCol[SkinName][gl]["HCB"]==nil then Healbot_Config_Skins.BarCol[SkinName][gl]["HCB"]=Healbot_Config_Skins.BarCol[SkinName][gl]["HIB"] end
        if Healbot_Config_Skins.BarCol[SkinName][gl]["HCT"]==nil then Healbot_Config_Skins.BarCol[SkinName][gl]["HCT"]=0.4 end
        if Healbot_Config_Skins.BarCol[SkinName][gl]["HIT"]==nil then Healbot_Config_Skins.BarCol[SkinName][gl]["HIT"]=0.7 end
        if Healbot_Config_Skins.BarCol[SkinName][gl]["ORA"]==nil then Healbot_Config_Skins.BarCol[SkinName][gl]["ORA"]=0.4 end
        if Healbot_Config_Skins.BarCol[SkinName][gl]["DISA"]==nil then Healbot_Config_Skins.BarCol[SkinName][gl]["DISA"]=0.1 end
        if Healbot_Config_Skins.BarCol[SkinName][gl]["BR"]==nil then Healbot_Config_Skins.BarCol[SkinName][gl]["BR"]=0.4 end
        if Healbot_Config_Skins.BarCol[SkinName][gl]["BG"]==nil then Healbot_Config_Skins.BarCol[SkinName][gl]["BG"]=0.7 end
        if Healbot_Config_Skins.BarCol[SkinName][gl]["BB"]==nil then Healbot_Config_Skins.BarCol[SkinName][gl]["BB"]=0.7 end
        if Healbot_Config_Skins.BarCol[SkinName][gl]["BA"]==nil then Healbot_Config_Skins.BarCol[SkinName][gl]["BA"]=0 end
        if Healbot_Config_Skins.BarCol[SkinName][gl]["BIR"]==nil then Healbot_Config_Skins.BarCol[SkinName][gl]["BIR"]=Healbot_Config_Skins.BarCol[SkinName][gl]["BR"] end
        if Healbot_Config_Skins.BarCol[SkinName][gl]["BIG"]==nil then Healbot_Config_Skins.BarCol[SkinName][gl]["BIG"]=Healbot_Config_Skins.BarCol[SkinName][gl]["BG"] end
        if Healbot_Config_Skins.BarCol[SkinName][gl]["BIB"]==nil then Healbot_Config_Skins.BarCol[SkinName][gl]["BIB"]=Healbot_Config_Skins.BarCol[SkinName][gl]["BB"] end
        if Healbot_Config_Skins.BarCol[SkinName][gl]["BCR"]==nil then Healbot_Config_Skins.BarCol[SkinName][gl]["BCR"]=Healbot_Config_Skins.BarCol[SkinName][gl]["BIR"] end
        if Healbot_Config_Skins.BarCol[SkinName][gl]["BCG"]==nil then Healbot_Config_Skins.BarCol[SkinName][gl]["BCG"]=Healbot_Config_Skins.BarCol[SkinName][gl]["BIG"] end
        if Healbot_Config_Skins.BarCol[SkinName][gl]["BCB"]==nil then Healbot_Config_Skins.BarCol[SkinName][gl]["BCB"]=Healbot_Config_Skins.BarCol[SkinName][gl]["BIB"] end
        if Healbot_Config_Skins.BarCol[SkinName][gl]["BCT"]==nil then Healbot_Config_Skins.BarCol[SkinName][gl]["BCT"]=0.4 end
        if Healbot_Config_Skins.BarCol[SkinName][gl]["BIT"]==nil then Healbot_Config_Skins.BarCol[SkinName][gl]["BIT"]=0.7 end
        if Healbot_Config_Skins.BarCol[SkinName][gl]["BOUT"]==nil then Healbot_Config_Skins.BarCol[SkinName][gl]["BOUT"]=1 end
        if Healbot_Config_Skins.BarCol[SkinName][gl]["BORR"]==nil then Healbot_Config_Skins.BarCol[SkinName][gl]["BORR"]=0.1 end
        if Healbot_Config_Skins.BarCol[SkinName][gl]["BORG"]==nil then Healbot_Config_Skins.BarCol[SkinName][gl]["BORG"]=0.1 end
        if Healbot_Config_Skins.BarCol[SkinName][gl]["BORB"]==nil then Healbot_Config_Skins.BarCol[SkinName][gl]["BORB"]=0.3 end
        if Healbot_Config_Skins.BarCol[SkinName][gl]["BORA"]==nil then Healbot_Config_Skins.BarCol[SkinName][gl]["BORA"]=1 end
        if Healbot_Config_Skins.BarCol[SkinName][gl]["BORIR"]==nil then Healbot_Config_Skins.BarCol[SkinName][gl]["BORIR"]=Healbot_Config_Skins.BarCol[SkinName][gl]["BORR"] end
        if Healbot_Config_Skins.BarCol[SkinName][gl]["BORIG"]==nil then Healbot_Config_Skins.BarCol[SkinName][gl]["BORIG"]=Healbot_Config_Skins.BarCol[SkinName][gl]["BORG"] end
        if Healbot_Config_Skins.BarCol[SkinName][gl]["BORIB"]==nil then Healbot_Config_Skins.BarCol[SkinName][gl]["BORIB"]=Healbot_Config_Skins.BarCol[SkinName][gl]["BORB"] end
        if Healbot_Config_Skins.BarCol[SkinName][gl]["BORCR"]==nil then Healbot_Config_Skins.BarCol[SkinName][gl]["BORCR"]=Healbot_Config_Skins.BarCol[SkinName][gl]["BORIR"] end
        if Healbot_Config_Skins.BarCol[SkinName][gl]["BORCG"]==nil then Healbot_Config_Skins.BarCol[SkinName][gl]["BORCG"]=Healbot_Config_Skins.BarCol[SkinName][gl]["BORIG"] end
        if Healbot_Config_Skins.BarCol[SkinName][gl]["BORCB"]==nil then Healbot_Config_Skins.BarCol[SkinName][gl]["BORCB"]=Healbot_Config_Skins.BarCol[SkinName][gl]["BORIB"] end
        if Healbot_Config_Skins.BarCol[SkinName][gl]["BORCT"]==nil then Healbot_Config_Skins.BarCol[SkinName][gl]["BORCT"]=0.4 end
        if Healbot_Config_Skins.BarCol[SkinName][gl]["BORIT"]==nil then Healbot_Config_Skins.BarCol[SkinName][gl]["BORIT"]=0.7 end
        if Healbot_Config_Skins.BarCol[SkinName][gl]["BORSIZE"]==nil then Healbot_Config_Skins.BarCol[SkinName][gl]["BORSIZE"]=2 end
        for x=1,9 do
            if not Healbot_Config_Skins.AuxBarText[SkinName][x][gl]["FONT"] then Healbot_Config_Skins.AuxBarText[SkinName][x][gl]["FONT"]=HealBot_Default_Font end
            if not Healbot_Config_Skins.AuxBarText[SkinName][x][gl]["HEIGHT"] then Healbot_Config_Skins.AuxBarText[SkinName][x][gl]["HEIGHT"]=9 end
            if not Healbot_Config_Skins.AuxBarText[SkinName][x][gl]["OFFSET"] then Healbot_Config_Skins.AuxBarText[SkinName][x][gl]["OFFSET"]=0 end
            if not Healbot_Config_Skins.AuxBarText[SkinName][x][gl]["HOFFSET"] then Healbot_Config_Skins.AuxBarText[SkinName][x][gl]["HOFFSET"]=0 end
            if not Healbot_Config_Skins.AuxBarText[SkinName][x][gl]["ALIGN"] then Healbot_Config_Skins.AuxBarText[SkinName][x][gl]["ALIGN"]=2 end
            if not Healbot_Config_Skins.AuxBarText[SkinName][x][gl]["OUTLINE"] then Healbot_Config_Skins.AuxBarText[SkinName][x][gl]["OUTLINE"]=1 end
            if not Healbot_Config_Skins.AuxBarText[SkinName][x][gl]["MAXCHARS"] then Healbot_Config_Skins.AuxBarText[SkinName][x][gl]["MAXCHARS"]=0 end
            if not Healbot_Config_Skins.AuxBarText[SkinName][x][gl]["COLTYPE"] then Healbot_Config_Skins.AuxBarText[SkinName][x][gl]["COLTYPE"]=1 end
            if not Healbot_Config_Skins.AuxBarText[SkinName][x][gl]["COLR"] then Healbot_Config_Skins.AuxBarText[SkinName][x][gl]["COLR"]=1 end
            if not Healbot_Config_Skins.AuxBarText[SkinName][x][gl]["COLG"] then Healbot_Config_Skins.AuxBarText[SkinName][x][gl]["COLG"]=1 end
            if not Healbot_Config_Skins.AuxBarText[SkinName][x][gl]["COLB"] then Healbot_Config_Skins.AuxBarText[SkinName][x][gl]["COLB"]=1 end
            if not Healbot_Config_Skins.AuxBarText[SkinName][x][gl]["COLA"] then Healbot_Config_Skins.AuxBarText[SkinName][x][gl]["COLA"]=0.98 end
            if not Healbot_Config_Skins.AuxBarText[SkinName][x][gl]["COLDA"] then Healbot_Config_Skins.AuxBarText[SkinName][x][gl]["COLDA"]=0.5 end
            if Healbot_Config_Skins.AuxBar[SkinName][x][gl]["MANAONLY"]==nil then Healbot_Config_Skins.AuxBar[SkinName][x][gl]["MANAONLY"]=false end
            if Healbot_Config_Skins.AuxBar[SkinName][x][gl]["HEALERSMANAONLY"]==nil then Healbot_Config_Skins.AuxBar[SkinName][x][gl]["HEALERSMANAONLY"]=false end
        end
        if Healbot_Config_Skins.AuxBarFrame[SkinName][gl]["OVERLAYRECENTHEALS"]==nil then Healbot_Config_Skins.AuxBarFrame[SkinName][gl]["OVERLAYRECENTHEALS"]=false end
        if Healbot_Config_Skins.AuxBarFrame[SkinName][gl]["OVERLAYHEALTHDROP"]==nil then Healbot_Config_Skins.AuxBarFrame[SkinName][gl]["OVERLAYHEALTHDROP"]=false end
        if Healbot_Config_Skins.AuxBarFrame[SkinName][gl]["OVERLAYAGGRO"]==nil then Healbot_Config_Skins.AuxBarFrame[SkinName][gl]["OVERLAYAGGRO"]=false end
        if Healbot_Config_Skins.AuxBarFrame[SkinName][gl]["OVERLAYDEBUFF"]==nil then Healbot_Config_Skins.AuxBarFrame[SkinName][gl]["OVERLAYDEBUFF"]=false end
        if Healbot_Config_Skins.AuxBarFrame[SkinName][gl]["OVERLAYHIGHLIGHT"]==nil then Healbot_Config_Skins.AuxBarFrame[SkinName][gl]["OVERLAYHIGHLIGHT"]=false end
        if Healbot_Config_Skins.AuxBarFrame[SkinName][gl]["OVERLAYTARGET"]==nil then Healbot_Config_Skins.AuxBarFrame[SkinName][gl]["OVERLAYTARGET"]=false end
        if Healbot_Config_Skins.AuxBarFrame[SkinName][gl]["OVERLAYOOR"]==nil then Healbot_Config_Skins.AuxBarFrame[SkinName][gl]["OVERLAYOOR"]=false end
        if Healbot_Config_Skins.AuxBarFrame[SkinName][gl]["OVERLAYBUFF"]==nil then Healbot_Config_Skins.AuxBarFrame[SkinName][gl]["OVERLAYBUFF"]=false end
        if Healbot_Config_Skins.HeadText[SkinName][gl]["OUTLINE"]==nil then Healbot_Config_Skins.HeadText[SkinName][gl]["OUTLINE"]=1 end
        if Healbot_Config_Skins.HeadText[SkinName][gl]["FONT"]==nil then Healbot_Config_Skins.HeadText[SkinName][gl]["FONT"]=HealBot_Default_Font end
        if Healbot_Config_Skins.HeadText[SkinName][gl]["HEIGHT"]==nil then Healbot_Config_Skins.HeadText[SkinName][gl]["HEIGHT"]=9 end
        if Healbot_Config_Skins.HeadText[SkinName][gl]["OFFSET"]==nil then Healbot_Config_Skins.HeadText[SkinName][gl]["OFFSET"]=0 end
        if Healbot_Config_Skins.HeadText[SkinName][gl]["R"]==nil then Healbot_Config_Skins.HeadText[SkinName][gl]["R"]=1 end
        if Healbot_Config_Skins.HeadText[SkinName][gl]["G"]==nil then Healbot_Config_Skins.HeadText[SkinName][gl]["G"]=1 end
        if Healbot_Config_Skins.HeadText[SkinName][gl]["B"]==nil then Healbot_Config_Skins.HeadText[SkinName][gl]["B"]=0.1 end
        if Healbot_Config_Skins.HeadText[SkinName][gl]["A"]==nil then Healbot_Config_Skins.HeadText[SkinName][gl]["A"]=0.7 end
        if Healbot_Config_Skins.HeadBar[SkinName][gl]["SHOW"]==nil then Healbot_Config_Skins.HeadBar[SkinName][gl]["SHOW"]=false end
        if Healbot_Config_Skins.HeadBar[SkinName][gl]["TEXTURE"]==nil then Healbot_Config_Skins.HeadBar[SkinName][gl]["TEXTURE"]=HealBot_Default_Textures[10].name end
        if Healbot_Config_Skins.HeadBar[SkinName][gl]["WIDTH"]==nil then Healbot_Config_Skins.HeadBar[SkinName][gl]["WIDTH"]=0.7 end
        if Healbot_Config_Skins.HeadBar[SkinName][gl]["HEIGHT"]==nil then 
            Healbot_Config_Skins.HeadBar[SkinName][gl]["HEIGHT"]=20 
        elseif Healbot_Config_Skins.HeadBar[SkinName][gl]["HEIGHT"]<2 then
            local bheight=(Healbot_Config_Skins.HealBar[SkinName][gl]["HEIGHT"])
            Healbot_Config_Skins.HeadBar[SkinName][gl]["HEIGHT"]=ceil(bheight*Healbot_Config_Skins.HeadBar[SkinName][gl]["HEIGHT"])
        end
        if Healbot_Config_Skins.HeadBar[SkinName][gl]["R"]==nil then Healbot_Config_Skins.HeadBar[SkinName][gl]["R"]=0.1 end
        if Healbot_Config_Skins.HeadBar[SkinName][gl]["G"]==nil then Healbot_Config_Skins.HeadBar[SkinName][gl]["G"]=0.7 end
        if Healbot_Config_Skins.HeadBar[SkinName][gl]["B"]==nil then Healbot_Config_Skins.HeadBar[SkinName][gl]["B"]=0.1 end
        if Healbot_Config_Skins.HeadBar[SkinName][gl]["A"]==nil then Healbot_Config_Skins.HeadBar[SkinName][gl]["A"]=0.4 end
        if Healbot_Config_Skins.HealBar[SkinName][gl]["CMARGIN"]==nil then Healbot_Config_Skins.HealBar[SkinName][gl]["CMARGIN"]=2 end 
        if Healbot_Config_Skins.HealBar[SkinName][gl]["GRPCOLS"]==nil then Healbot_Config_Skins.HealBar[SkinName][gl]["GRPCOLS"]=true end
        if Healbot_Config_Skins.HealBar[SkinName][gl]["POWERCNT"]==nil then Healbot_Config_Skins.HealBar[SkinName][gl]["POWERCNT"]=true end
        if Healbot_Config_Skins.HealBar[SkinName][gl]["TEXTURE"]==nil then Healbot_Config_Skins.HealBar[SkinName][gl]["TEXTURE"]=HealBot_Default_Textures[8].name end
        if Healbot_Config_Skins.HealBar[SkinName][gl]["TEXTURE"]=="Empty" then Healbot_Config_Skins.HealBar[SkinName][gl]["TEXTURE"]="Smooth" end
        if Healbot_Config_Skins.HealBar[SkinName][gl]["HEIGHT"]==nil then Healbot_Config_Skins.HealBar[SkinName][gl]["HEIGHT"]=30 end
        if Healbot_Config_Skins.HealBar[SkinName][gl]["WIDTH"]==nil then Healbot_Config_Skins.HealBar[SkinName][gl]["WIDTH"]=80 end
        if Healbot_Config_Skins.HealBar[SkinName][gl]["NUMCOLS"]==nil then Healbot_Config_Skins.HealBar[SkinName][gl]["NUMCOLS"]=1 end
        if Healbot_Config_Skins.HealBar[SkinName][gl]["RMARGIN"]==nil then Healbot_Config_Skins.HealBar[SkinName][gl]["RMARGIN"]=1 end
        if Healbot_Config_Skins.HealBar[SkinName][gl]["OFIX"]==nil then Healbot_Config_Skins.HealBar[SkinName][gl]["OFIX"]=1 end
        if not Healbot_Config_Skins.Indicators[SkinName][gl]["ACOL"] then Healbot_Config_Skins.Indicators[SkinName][gl]["ACOL"]=1 end
        if not Healbot_Config_Skins.Indicators[SkinName][gl]["AANCHOR"] then Healbot_Config_Skins.Indicators[SkinName][gl]["AANCHOR"]=1 end
        if not Healbot_Config_Skins.Indicators[SkinName][gl]["AVOFF"] then Healbot_Config_Skins.Indicators[SkinName][gl]["AVOFF"]=-2 end
        if not Healbot_Config_Skins.Indicators[SkinName][gl]["AHOFF"] then Healbot_Config_Skins.Indicators[SkinName][gl]["AHOFF"]=1 end
        if not Healbot_Config_Skins.Indicators[SkinName][gl]["ASIZE"] then Healbot_Config_Skins.Indicators[SkinName][gl]["ASIZE"]=3 end
        if not Healbot_Config_Skins.Indicators[SkinName][gl]["ASPACE"] then Healbot_Config_Skins.Indicators[SkinName][gl]["ASPACE"]=0 end
        if not Healbot_Config_Skins.Indicators[SkinName][gl]["MCOL"] then Healbot_Config_Skins.Indicators[SkinName][gl]["MCOL"]=1 end
        if not Healbot_Config_Skins.Indicators[SkinName][gl]["MANCHOR"] then Healbot_Config_Skins.Indicators[SkinName][gl]["MANCHOR"]=1 end
        if not Healbot_Config_Skins.Indicators[SkinName][gl]["MVOFF"] then Healbot_Config_Skins.Indicators[SkinName][gl]["MVOFF"]=-2 end
        if not Healbot_Config_Skins.Indicators[SkinName][gl]["MHOFF"] then Healbot_Config_Skins.Indicators[SkinName][gl]["MHOFF"]=0 end
        if not Healbot_Config_Skins.Indicators[SkinName][gl]["MSIZE"] then Healbot_Config_Skins.Indicators[SkinName][gl]["MSIZE"]=3 end
        if not Healbot_Config_Skins.Indicators[SkinName][gl]["MSPACE"] then Healbot_Config_Skins.Indicators[SkinName][gl]["MSPACE"]=1 end
        if not Healbot_Config_Skins.Indicators[SkinName][gl]["SCOL"] then Healbot_Config_Skins.Indicators[SkinName][gl]["SCOL"]=1 end
        if not Healbot_Config_Skins.Indicators[SkinName][gl]["SANCHOR"] then Healbot_Config_Skins.Indicators[SkinName][gl]["SANCHOR"]=1 end
        if not Healbot_Config_Skins.Indicators[SkinName][gl]["SVOFF"] then Healbot_Config_Skins.Indicators[SkinName][gl]["SVOFF"]=1 end
        if not Healbot_Config_Skins.Indicators[SkinName][gl]["SHOFF"] then Healbot_Config_Skins.Indicators[SkinName][gl]["SHOFF"]=1 end
        if not Healbot_Config_Skins.Indicators[SkinName][gl]["SSIZE"] then Healbot_Config_Skins.Indicators[SkinName][gl]["SSIZE"]=4 end
        if not Healbot_Config_Skins.Indicators[SkinName][gl]["PCOL"] then Healbot_Config_Skins.Indicators[SkinName][gl]["PCOL"]=1 end
        if not Healbot_Config_Skins.Indicators[SkinName][gl]["PANCHOR"] then Healbot_Config_Skins.Indicators[SkinName][gl]["PANCHOR"]=2 end
        if not Healbot_Config_Skins.Indicators[SkinName][gl]["PVOFF"] then Healbot_Config_Skins.Indicators[SkinName][gl]["PVOFF"]=0 end
        if not Healbot_Config_Skins.Indicators[SkinName][gl]["PHOFF"] then Healbot_Config_Skins.Indicators[SkinName][gl]["PHOFF"]=0 end
        if not Healbot_Config_Skins.Indicators[SkinName][gl]["PSIZE"] then Healbot_Config_Skins.Indicators[SkinName][gl]["PSIZE"]=4 end
        if not Healbot_Config_Skins.Indicators[SkinName][gl]["PSPACE"] then Healbot_Config_Skins.Indicators[SkinName][gl]["PSPACE"]=1 end
        if Healbot_Config_Skins.Emerg[SkinName][gl]["USE"]==nil then Healbot_Config_Skins.Emerg[SkinName][gl]["USE"]=false end
        if not Healbot_Config_Skins.Emerg[SkinName][gl]["TEXTURE"] then Healbot_Config_Skins.Emerg[SkinName][gl]["TEXTURE"]=HealBot_Default_Textures[8].name end
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
        if Healbot_Config_Skins.Emerg[SkinName][gl]["BUFFBARCOL"]==nil then 
            Healbot_Config_Skins.Emerg[SkinName][gl]["BUFFBARCOL"]=false 
        elseif type(Healbot_Config_Skins.Emerg[SkinName][gl]["BUFFBARCOL"])=="number" then
            if Healbot_Config_Skins.Emerg[SkinName][gl]["BUFFBARCOL"]>1 then
                Healbot_Config_Skins.Emerg[SkinName][gl]["BUFFBARCOL"]=true
            else
                Healbot_Config_Skins.Emerg[SkinName][gl]["BUFFBARCOL"]=false
            end
        end
        if Healbot_Config_Skins.Emerg[SkinName][gl]["DEBUFFBARCOL"]==nil then 
            Healbot_Config_Skins.Emerg[SkinName][gl]["DEBUFFBARCOL"]=false 
        elseif type(Healbot_Config_Skins.Emerg[SkinName][gl]["DEBUFFBARCOL"])=="number" then
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
        if not Healbot_Config_Skins.Emerg[SkinName][gl]["BARCOL"] then 
            Healbot_Config_Skins.Emerg[SkinName][gl]["BARCOL"]=Healbot_Config_Skins.BarCol[SkinName][gl]["HLTH"]
        end
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
        if Healbot_Config_Skins.HealBar[SkinName][gl]["LOWMANA"]==nil then 
            if Healbot_Config_Skins.General[SkinName]["LOWMANA"] then
                Healbot_Config_Skins.HealBar[SkinName][gl]["LOWMANA"]=Healbot_Config_Skins.General[SkinName]["LOWMANA"]
            else
                Healbot_Config_Skins.HealBar[SkinName][gl]["LOWMANA"]=1
            end
        end
        if Healbot_Config_Skins.HealBar[SkinName][gl]["LOWMANACOMBAT"]==nil then 
            if Healbot_Config_Skins.General[SkinName]["LOWMANACOMBAT"] then
                Healbot_Config_Skins.HealBar[SkinName][gl]["LOWMANACOMBAT"]=Healbot_Config_Skins.General[SkinName]["LOWMANACOMBAT"]
            else
                Healbot_Config_Skins.HealBar[SkinName][gl]["LOWMANACOMBAT"]=true
            end
        end
        for g=1,9 do
            if not Healbot_Config_Skins.AuxBar[SkinName][g][gl]["COLOUR"] then Healbot_Config_Skins.AuxBar[SkinName][g][gl]["COLOUR"]=1 end
            if not Healbot_Config_Skins.AuxBar[SkinName][g][gl]["ANCHOR"] then Healbot_Config_Skins.AuxBar[SkinName][g][gl]["ANCHOR"]=1 end
            if not Healbot_Config_Skins.AuxBar[SkinName][g][gl]["OFFSET"] then Healbot_Config_Skins.AuxBar[SkinName][g][gl]["OFFSET"]=1 end
            if not Healbot_Config_Skins.AuxBar[SkinName][g][gl]["DEPTH"] then Healbot_Config_Skins.AuxBar[SkinName][g][gl]["DEPTH"]=5 end
            if not Healbot_Config_Skins.AuxBar[SkinName][g][gl]["SIZE"] then Healbot_Config_Skins.AuxBar[SkinName][g][gl]["SIZE"]=0.98 end
            if not Healbot_Config_Skins.AuxBar[SkinName][g][gl]["USE"] then Healbot_Config_Skins.AuxBar[SkinName][g][gl]["USE"]=1 end
            if not Healbot_Config_Skins.AuxBar[SkinName][g][gl]["R"] then Healbot_Config_Skins.AuxBar[SkinName][g][gl]["R"]=1 end
            if not Healbot_Config_Skins.AuxBar[SkinName][g][gl]["G"] then Healbot_Config_Skins.AuxBar[SkinName][g][gl]["G"]=1 end
            if not Healbot_Config_Skins.AuxBar[SkinName][g][gl]["B"] then Healbot_Config_Skins.AuxBar[SkinName][g][gl]["B"]=1 end
            if not Healbot_Config_Skins.AuxBar[SkinName][g][gl]["A"] then Healbot_Config_Skins.AuxBar[SkinName][g][gl]["A"]=1 end
            if not Healbot_Config_Skins.AuxBar[SkinName][g][gl]["OTYPE"] then Healbot_Config_Skins.AuxBar[SkinName][g][gl]["OTYPE"]=1 end
            if Healbot_Config_Skins.AuxBar[SkinName][g][gl]["TEXT"]==nil then Healbot_Config_Skins.AuxBar[SkinName][g][gl]["TEXT"]=false end
        end
        if not Healbot_Config_Skins.AuxBarFrame[SkinName][gl]["OVERLAP"] then Healbot_Config_Skins.AuxBarFrame[SkinName][gl]["OVERLAP"]=1 end
        if Healbot_Config_Skins.AuxBarFrame[SkinName][gl]["OFREQ"] then
            if not Healbot_Config_Skins.General[SkinName]["OFREQ"] then
                for g=1,9 do
                    if Healbot_Config_Skins.AuxBar[SkinName][g][gl]["OTYPE"]==2 then
                        Healbot_Config_Skins.General[SkinName]["OFREQ"]=Healbot_Config_Skins.AuxBarFrame[SkinName][gl]["OFREQ"]
                    end
                end
            end
            Healbot_Config_Skins.AuxBarFrame[SkinName][gl]["OFREQ"]=nil
        end
        if Healbot_Config_Skins.AuxBarFrame[SkinName][gl]["OMIN"] then
            if not Healbot_Config_Skins.General[SkinName]["OMIN"] then
                for g=1,9 do
                    if Healbot_Config_Skins.AuxBar[SkinName][g][gl]["OTYPE"]==2 then
                        Healbot_Config_Skins.General[SkinName]["OMIN"]=Healbot_Config_Skins.AuxBarFrame[SkinName][gl]["OMIN"]
                    end
                end
            end
            Healbot_Config_Skins.AuxBarFrame[SkinName][gl]["OMIN"]=nil
        end
        if Healbot_Config_Skins.AuxBarFrame[SkinName][gl]["OMAX"] then
            if not Healbot_Config_Skins.General[SkinName]["OMAX"] then
                for g=1,9 do
                    if Healbot_Config_Skins.AuxBar[SkinName][g][gl]["OTYPE"]==2 then
                        Healbot_Config_Skins.General[SkinName]["OMAX"]=Healbot_Config_Skins.AuxBarFrame[SkinName][gl]["OMAX"]
                    end
                end
            end
            Healbot_Config_Skins.AuxBarFrame[SkinName][gl]["OMAX"]=nil
        end
        if Healbot_Config_Skins.Anchors[SkinName][gl]["FRAME"]==nil then Healbot_Config_Skins.Anchors[SkinName][gl]["FRAME"]=1 end
        if Healbot_Config_Skins.Anchors[SkinName][gl]["BARS"]==nil then Healbot_Config_Skins.Anchors[SkinName][gl]["BARS"]=1 end
        if Healbot_Config_Skins.Anchors[SkinName][gl]["GROW"]==nil then Healbot_Config_Skins.Anchors[SkinName][gl]["GROW"]=2 end
        if Healbot_Config_Skins.FrameAlias[SkinName][gl]["NAME"]==nil then Healbot_Config_Skins.FrameAlias[SkinName][gl]["NAME"]="" end
        if Healbot_Config_Skins.FrameAlias[SkinName][gl]["SHOW"]==nil then Healbot_Config_Skins.FrameAlias[SkinName][gl]["SHOW"]=false end
        if Healbot_Config_Skins.FrameAlias[SkinName][gl]["FONT"]==nil then Healbot_Config_Skins.FrameAlias[SkinName][gl]["FONT"]=HealBot_Default_Font end
        if Healbot_Config_Skins.FrameAlias[SkinName][gl]["SIZE"]==nil then Healbot_Config_Skins.FrameAlias[SkinName][gl]["SIZE"]=12 end
        if Healbot_Config_Skins.FrameAlias[SkinName][gl]["OUTLINE"]==nil then Healbot_Config_Skins.FrameAlias[SkinName][gl]["OUTLINE"]=1 end
        if Healbot_Config_Skins.FrameAlias[SkinName][gl]["OFFSET"]==nil then Healbot_Config_Skins.FrameAlias[SkinName][gl]["OFFSET"]=0 end
        if Healbot_Config_Skins.FrameAlias[SkinName][gl]["R"]==nil then Healbot_Config_Skins.FrameAlias[SkinName][gl]["R"]=1 end
        if Healbot_Config_Skins.FrameAlias[SkinName][gl]["G"]==nil then Healbot_Config_Skins.FrameAlias[SkinName][gl]["G"]=1 end
        if Healbot_Config_Skins.FrameAlias[SkinName][gl]["B"]==nil then Healbot_Config_Skins.FrameAlias[SkinName][gl]["B"]=1 end
        if Healbot_Config_Skins.FrameAlias[SkinName][gl]["A"]==nil then Healbot_Config_Skins.FrameAlias[SkinName][gl]["A"]=1 end
        if Healbot_Config_Skins.FrameAliasBar[SkinName][gl]["TEXTURE"]==nil then Healbot_Config_Skins.FrameAliasBar[SkinName][gl]["TEXTURE"]=HealBot_Default_Textures[10].name end
        if Healbot_Config_Skins.FrameAliasBar[SkinName][gl]["WIDTH"]==nil then Healbot_Config_Skins.FrameAliasBar[SkinName][gl]["WIDTH"]=0.7 end
        if Healbot_Config_Skins.FrameAliasBar[SkinName][gl]["HEIGHT"]==nil then Healbot_Config_Skins.FrameAliasBar[SkinName][gl]["HEIGHT"]=20 end
        if Healbot_Config_Skins.FrameAliasBar[SkinName][gl]["OFFSET"]==nil then Healbot_Config_Skins.FrameAliasBar[SkinName][gl]["OFFSET"]=-4 end
        if Healbot_Config_Skins.FrameAliasBar[SkinName][gl]["R"]==nil then Healbot_Config_Skins.FrameAliasBar[SkinName][gl]["R"]=0.1 end
        if Healbot_Config_Skins.FrameAliasBar[SkinName][gl]["G"]==nil then Healbot_Config_Skins.FrameAliasBar[SkinName][gl]["G"]=0.25 end
        if Healbot_Config_Skins.FrameAliasBar[SkinName][gl]["B"]==nil then Healbot_Config_Skins.FrameAliasBar[SkinName][gl]["B"]=0.25 end
        if Healbot_Config_Skins.FrameAliasBar[SkinName][gl]["A"]==nil then Healbot_Config_Skins.FrameAliasBar[SkinName][gl]["A"]=0.5 end
        if Healbot_Config_Skins.Anchors[SkinName][gl]["Y"]==nil then Healbot_Config_Skins.Anchors[SkinName][gl]["Y"]=(49+gl) end
        if Healbot_Config_Skins.Anchors[SkinName][gl]["X"]==nil then Healbot_Config_Skins.Anchors[SkinName][gl]["X"]=(49+gl) end
        if Healbot_Config_Skins.Anchors[SkinName][gl]["Y"]>100 or Healbot_Config_Skins.Anchors[SkinName][gl]["X"]>100 then
            Healbot_Config_Skins.Anchors[SkinName][gl]["Y"]=HealBot_Comm_round(((Healbot_Config_Skins.Anchors[SkinName][gl]["Y"]/GetScreenHeight())*100),2)
            Healbot_Config_Skins.Anchors[SkinName][gl]["X"]=HealBot_Comm_round(((Healbot_Config_Skins.Anchors[SkinName][gl]["X"]/GetScreenWidth())*100),2)
        end

        HealBot_Skins_Check_IconSetsText(SkinName, gl, "HEIGHT", "DBHEIGHT", 9)
        HealBot_Skins_Check_IconSetsText(SkinName, gl, "BUFFHEIGHT", "BUFFHEIGHT", 9)
        if Healbot_Config_Skins.BarText[SkinName][gl]["INCHEALS"]>3 then
            if Healbot_Config_Skins.BarText[SkinName][gl]["INCHEALS"]==4 then
                Healbot_Config_Skins.BarText[SkinName][gl]["INCHEALS"]=2
                Healbot_Config_Skins.BarText[SkinName][gl]["IGNOREONFULL"]=false
            elseif Healbot_Config_Skins.BarText[SkinName][gl]["INCHEALS"]==5 then
                Healbot_Config_Skins.BarText[SkinName][gl]["INCHEALS"]=3
                Healbot_Config_Skins.BarText[SkinName][gl]["IGNOREONFULL"]=false
            elseif Healbot_Config_Skins.BarText[SkinName][gl]["INCHEALS"]==6 then
                Healbot_Config_Skins.BarText[SkinName][gl]["INCHEALS"]=2
                Healbot_Config_Skins.BarText[SkinName][gl]["INCABSORBS"]=2
            elseif Healbot_Config_Skins.BarText[SkinName][gl]["INCHEALS"]==7 then
                Healbot_Config_Skins.BarText[SkinName][gl]["INCHEALS"]=3
                Healbot_Config_Skins.BarText[SkinName][gl]["INCABSORBS"]=3
            elseif Healbot_Config_Skins.BarText[SkinName][gl]["INCHEALS"]==8 then
                Healbot_Config_Skins.BarText[SkinName][gl]["INCHEALS"]=2
                Healbot_Config_Skins.BarText[SkinName][gl]["INCABSORBS"]=2
                Healbot_Config_Skins.BarText[SkinName][gl]["IGNOREONFULL"]=false
            else
                Healbot_Config_Skins.BarText[SkinName][gl]["INCHEALS"]=3
                Healbot_Config_Skins.BarText[SkinName][gl]["INCABSORBS"]=3
                Healbot_Config_Skins.BarText[SkinName][gl]["IGNOREONFULL"]=false
            end
        elseif Healbot_Config_Skins.BarTextCol[SkinName][gl]["ER"] then
            Healbot_Config_Skins.BarText[SkinName][gl]["INCABSORBS"]=1
        end
        
        Healbot_Config_Skins.BarText[SkinName][gl]["DOUBLE"]=nil
        if Healbot_Config_Skins.BarText[SkinName][gl]["CLASSCOL"]~=nil then
            if not Healbot_Config_Skins.BarText[SkinName][gl]["CLASSCOL"] then
                Healbot_Config_Skins.BarTextCol[SkinName][gl]["NAME"]=3
                Healbot_Config_Skins.BarTextCol[SkinName][gl]["HLTH"]=3
            else
                Healbot_Config_Skins.BarTextCol[SkinName][gl]["NAME"]=2
                Healbot_Config_Skins.BarTextCol[SkinName][gl]["HLTH"]=2
            end
        end
        Healbot_Config_Skins.BarText[SkinName][gl]["CLASSCOL"]=nil
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["EA"] then
            Healbot_Config_Skins.BarTextCol[SkinName][gl]["NCA"]=Healbot_Config_Skins.BarTextCol[SkinName][gl]["EA"]
            Healbot_Config_Skins.BarTextCol[SkinName][gl]["HCA"]=Healbot_Config_Skins.BarTextCol[SkinName][gl]["EA"]
        end
        Healbot_Config_Skins.BarTextCol[SkinName][gl]["EA"]=nil
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["DA"] then
            Healbot_Config_Skins.BarTextCol[SkinName][gl]["NCDA"]=Healbot_Config_Skins.BarTextCol[SkinName][gl]["DA"]
            Healbot_Config_Skins.BarTextCol[SkinName][gl]["HCDA"]=Healbot_Config_Skins.BarTextCol[SkinName][gl]["DA"]
        end
        Healbot_Config_Skins.BarTextCol[SkinName][gl]["DA"]=nil
        Healbot_Config_Skins.BarTextCol[SkinName][gl]["CA"]=nil
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["ER"] then
            Healbot_Config_Skins.BarTextCol[SkinName][gl]["NCR"]=Healbot_Config_Skins.BarTextCol[SkinName][gl]["ER"]
            Healbot_Config_Skins.BarTextCol[SkinName][gl]["HCR"]=Healbot_Config_Skins.BarTextCol[SkinName][gl]["ER"]
            Healbot_Config_Skins.BarTextCol[SkinName][gl]["NCG"]=Healbot_Config_Skins.BarTextCol[SkinName][gl]["EG"]
            Healbot_Config_Skins.BarTextCol[SkinName][gl]["HCG"]=Healbot_Config_Skins.BarTextCol[SkinName][gl]["EG"]
            Healbot_Config_Skins.BarTextCol[SkinName][gl]["NCB"]=Healbot_Config_Skins.BarTextCol[SkinName][gl]["EB"]
            Healbot_Config_Skins.BarTextCol[SkinName][gl]["HCB"]=Healbot_Config_Skins.BarTextCol[SkinName][gl]["EB"]
        end
        Healbot_Config_Skins.BarTextCol[SkinName][gl]["ER"]=nil
        Healbot_Config_Skins.BarTextCol[SkinName][gl]["EG"]=nil
        Healbot_Config_Skins.BarTextCol[SkinName][gl]["EB"]=nil
        Healbot_Config_Skins.BarTextCol[SkinName][gl]["DR"]=nil
        Healbot_Config_Skins.BarTextCol[SkinName][gl]["DG"]=nil
        Healbot_Config_Skins.BarTextCol[SkinName][gl]["DB"]=nil
        Healbot_Config_Skins.BarTextCol[SkinName][gl]["CR"]=nil
        Healbot_Config_Skins.BarTextCol[SkinName][gl]["CG"]=nil
        Healbot_Config_Skins.BarTextCol[SkinName][gl]["CB"]=nil
        Healbot_Config_Skins.BarText[SkinName][gl]["AGGROCOL"]=nil
        
        if HealBot_Config_Buffs.CBshownAB then
            for x=1,9 do
                Healbot_Config_Skins.AuxBar[SkinName][7][x]["USE"]=9
                Healbot_Config_Skins.AuxBar[SkinName][7][x]["DEPTH"]=1
                Healbot_Config_Skins.AuxBar[SkinName][7][x]["ANCHOR"]=2
            end
        end
        HealBot_Config_Buffs.CBshownAB=nil
        HealBot_Config_Buffs.HealBot_CBWarnRange_Aggro=nil
        if HealBot_Config_Buffs.CDCshownAB then
            for x=1,9 do
                Healbot_Config_Skins.AuxBar[SkinName][8][x]["USE"]=10
                Healbot_Config_Skins.AuxBar[SkinName][8][x]["DEPTH"]=1
                Healbot_Config_Skins.AuxBar[SkinName][8][x]["ANCHOR"]=2
            end
        end
        HealBot_Config_Cures.CDCshownAB=nil
        HealBot_Config_Cures.HealBot_CDCWarnRange_Aggro=nil

        if Healbot_Config_Skins.BarHighlight and Healbot_Config_Skins.BarHighlight[SkinName] and Healbot_Config_Skins.BarHighlight[SkinName][gl]["CBAR"] then
            Healbot_Config_Skins.AuxBar[SkinName][6][gl]["USE"]=8
            Healbot_Config_Skins.AuxBar[SkinName][6][gl]["DEPTH"]=1
            Healbot_Config_Skins.AuxBar[SkinName][6][gl]["ANCHOR"]=2
        end
        if Healbot_Config_Skins.BarAggro[SkinName][gl]["SHOW"] and Healbot_Config_Skins.HealBar[SkinName][gl]["AGGROSIZE"] and
                                                                   Healbot_Config_Skins.HealBar[SkinName][gl]["AGGROSIZE"]>0 then
            Healbot_Config_Skins.AuxBar[SkinName][5][gl]["USE"]=5
            if Healbot_Config_Skins.HealBar[SkinName][gl]["AGGROSIZE"]>1 then
                Healbot_Config_Skins.AuxBar[SkinName][5][gl]["DEPTH"]=ceil(Healbot_Config_Skins.HealBar[SkinName][gl]["AGGROSIZE"]/1.5)
            else
                Healbot_Config_Skins.AuxBar[SkinName][5][gl]["DEPTH"]=1
            end
        end
        if Healbot_Config_Skins.BarAggro[SkinName][gl]["SHOWBARSPCT"] then
            Healbot_Config_Skins.AuxBar[SkinName][4][gl]["USE"]=6
            Healbot_Config_Skins.AuxBar[SkinName][4][gl]["DEPTH"]=2
        end
        Healbot_Config_Skins.BarAggro[SkinName][gl]["SHOWBARSPCT"]=nil
        Healbot_Config_Skins.BarAggro[SkinName][gl]["SHOWBARS"]=nil
        Healbot_Config_Skins.BarHighlight=nil
        if Healbot_Config_Skins.HealBar[SkinName][gl]["POWERSIZE"] and Healbot_Config_Skins.HealBar[SkinName][gl]["POWERSIZE"]>0 then
            Healbot_Config_Skins.AuxBar[SkinName][1][gl]["USE"]=4
            if Healbot_Config_Skins.HealBar[SkinName][gl]["POWERSIZE"]>1 then
                Healbot_Config_Skins.AuxBar[SkinName][1][gl]["DEPTH"]=ceil(Healbot_Config_Skins.HealBar[SkinName][gl]["POWERSIZE"]/1.5)
            else
                Healbot_Config_Skins.AuxBar[SkinName][1][gl]["DEPTH"]=1
            end
        end
        Healbot_Config_Skins.HealBar[SkinName][gl]["POWERSIZE"]=nil
        Healbot_Config_Skins.HealBar[SkinName][gl]["AGGROSIZE"]=nil
        Healbot_Config_Skins.BarAggro[SkinName][gl]["FREQ"]=nil
        Healbot_Config_Skins.BarAggro[SkinName][gl]["MINA"]=nil
        Healbot_Config_Skins.BarAggro[SkinName][gl]["MAXA"]=nil
        if Healbot_Config_Skins.AuxBarText[SkinName][gl] and Healbot_Config_Skins.AuxBarText[SkinName][gl]["SHOW"]~=nil then Healbot_Config_Skins.AuxBarText[SkinName][gl]["SHOW"]=nil end
    end

    if Healbot_Config_Skins.Healing[SkinName]["ALERTIC"] then Healbot_Config_Skins.Healing[SkinName]["ALERTIC"]=nil end
    if Healbot_Config_Skins.Healing[SkinName]["ALERTOC"] then Healbot_Config_Skins.Healing[SkinName]["ALERTOC"]=nil end
    if Healbot_Config_Skins.Sort then Healbot_Config_Skins.Sort=nil end
    if Healbot_Config_Skins.Aggro then Healbot_Config_Skins.Aggro=nil end
    if Healbot_Config_Skins.Highlight then Healbot_Config_Skins.Highlight=nil end
    
    if Healbot_Config_Skins.Author[SkinName]==nil then Healbot_Config_Skins.Author[SkinName] = HEALBOT_WORDS_UNKNOWN end
    if Healbot_Config_Skins.Healing[SkinName]["GROUPPETS"]==nil then Healbot_Config_Skins.Healing[SkinName]["GROUPPETS"]=true end
    if Healbot_Config_Skins.Healing[SkinName]["SELFPET"]==nil then Healbot_Config_Skins.Healing[SkinName]["SELFPET"]=false end
    if Healbot_Config_Skins.Healing[SkinName]["TALWAYSSHOW"] then 
        Healbot_Config_Skins.Healing[SkinName]["TARGETINCOMBAT"]=3
        Healbot_Config_Skins.Healing[SkinName]["TALWAYSSHOW"]=nil
    end
    if Healbot_Config_Skins.Healing[SkinName]["TARGETINCOMBAT"]==nil then Healbot_Config_Skins.Healing[SkinName]["TARGETINCOMBAT"]=2 end
    if Healbot_Config_Skins.Healing[SkinName]["FALWAYSSHOW"] then 
        Healbot_Config_Skins.Healing[SkinName]["FOCUSINCOMBAT"]=3
        Healbot_Config_Skins.Healing[SkinName]["FALWAYSSHOW"]=nil
    end
    if not Healbot_Config_Skins.Healing[SkinName]["FOCUSINCOMBAT"] then Healbot_Config_Skins.Healing[SkinName]["FOCUSINCOMBAT"]=2 end
    if Healbot_Config_Skins.Healing[SkinName]["TONLYFRIEND"]==nil then Healbot_Config_Skins.Healing[SkinName]["TONLYFRIEND"]=false end
    if Healbot_Config_Skins.Healing[SkinName]["FONLYFRIEND"]==nil then Healbot_Config_Skins.Healing[SkinName]["FONLYFRIEND"]=false end
    if Healbot_Config_Skins.Healing[SkinName]["TEXRAID"]==nil then Healbot_Config_Skins.Healing[SkinName]["TEXRAID"]=false end
    if Healbot_Config_Skins.Healing[SkinName]["FEXRAID"]==nil then Healbot_Config_Skins.Healing[SkinName]["FEXRAID"]=false end
    if Healbot_Config_Skins.General[SkinName]["HIDEPARTYF"]==nil then Healbot_Config_Skins.General[SkinName]["HIDEPARTYF"]=false end
    if Healbot_Config_Skins.General[SkinName]["RUNBLIZZEVENTS"]==nil then Healbot_Config_Skins.General[SkinName]["RUNBLIZZEVENTS"]=false end
    if Healbot_Config_Skins.General[SkinName]["HIDEPTF"]==nil then Healbot_Config_Skins.General[SkinName]["HIDEPTF"]=false end
    if Healbot_Config_Skins.General[SkinName]["HIDEBOSSF"]==nil then Healbot_Config_Skins.General[SkinName]["HIDEBOSSF"]=false end
    if Healbot_Config_Skins.General[SkinName]["HIDEFOCUSF"]==nil then Healbot_Config_Skins.General[SkinName]["HIDEFOCUSF"]=false end
    if not Healbot_Config_Skins.General[SkinName]["UNITINCOMBAT"] then Healbot_Config_Skins.General[SkinName]["UNITINCOMBAT"]=2 end
    if Healbot_Config_Skins.General[SkinName]["HIDERAIDF"]==nil then Healbot_Config_Skins.General[SkinName]["HIDERAIDF"]=true end
    if Healbot_Config_Skins.General[SkinName]["FLUIDBARS"]==nil then Healbot_Config_Skins.General[SkinName]["FLUIDBARS"]=false end
    if Healbot_Config_Skins.General[SkinName]["FLUIDALPHA"]==nil then Healbot_Config_Skins.General[SkinName]["FLUIDALPHA"]=false end
    if Healbot_Config_Skins.General[SkinName]["HEALTHDROP"]==nil then Healbot_Config_Skins.General[SkinName]["HEALTHDROP"]=false end
    if not Healbot_Config_Skins.General[SkinName]["HEALTHDROPPCT"] then Healbot_Config_Skins.General[SkinName]["HEALTHDROPPCT"]=350 end
    if not Healbot_Config_Skins.General[SkinName]["HEALTHDROPSPEED"] then Healbot_Config_Skins.General[SkinName]["HEALTHDROPSPEED"]=40 end
    if not Healbot_Config_Skins.General[SkinName]["FLUIDFREQ"] then Healbot_Config_Skins.General[SkinName]["FLUIDFREQ"]=10 end
    if not Healbot_Config_Skins.General[SkinName]["HOTBARHLTH"] then Healbot_Config_Skins.General[SkinName]["HOTBARHLTH"]=0 end
    if not Healbot_Config_Skins.General[SkinName]["HOTBARDEBUFF"] then Healbot_Config_Skins.General[SkinName]["HOTBARDEBUFF"]=1 end
    if not Healbot_Config_Skins.General[SkinName]["HBDIMMING"] then Healbot_Config_Skins.General[SkinName]["HBDIMMING"]=2.2 end
    if Healbot_Config_Skins.General[SkinName]["STICKYFRAME"]==nil then Healbot_Config_Skins.General[SkinName]["STICKYFRAME"]=false end
    if not Healbot_Config_Skins.General[SkinName]["FOCUSGROUPS"] then Healbot_Config_Skins.General[SkinName]["FOCUSGROUPS"]=1 end
    if not Healbot_Config_Skins.General[SkinName]["FGDIMMING"] then Healbot_Config_Skins.General[SkinName]["FGDIMMING"]=2.5 end
    if not Healbot_Config_Skins.General[SkinName]["HAZARDFREQ"] then Healbot_Config_Skins.General[SkinName]["HAZARDFREQ"]=0.3 end
    if not Healbot_Config_Skins.General[SkinName]["HAZARDMINALPHA"] then Healbot_Config_Skins.General[SkinName]["HAZARDMINALPHA"]=0.25 end
    if not Healbot_Config_Skins.General[SkinName]["GLOBALDIMMING"] then Healbot_Config_Skins.General[SkinName]["GLOBALDIMMING"]=1 end
    if not Healbot_Config_Skins.General[SkinName]["OFREQ"] then Healbot_Config_Skins.General[SkinName]["OFREQ"]=0.07 end
    if not Healbot_Config_Skins.General[SkinName]["OMIN"] then Healbot_Config_Skins.General[SkinName]["OMIN"]=0.1 end
    if not Healbot_Config_Skins.General[SkinName]["OMAX"] then Healbot_Config_Skins.General[SkinName]["OMAX"]=0.95 end
    if not Healbot_Config_Skins.Chat[SkinName]["NOTIFY"] then Healbot_Config_Skins.Chat[SkinName]["NOTIFY"]=1 end
    if Healbot_Config_Skins.Chat[SkinName]["MSG"]==nil then Healbot_Config_Skins.Chat[SkinName]["MSG"]=HEALBOT_NOTIFYOTHERMSG end
    if Healbot_Config_Skins.Chat[SkinName]["RESONLY"]==nil then Healbot_Config_Skins.Chat[SkinName]["RESONLY"]=true end
    if Healbot_Config_Skins.Chat[SkinName]["EOCOOM"]==nil then Healbot_Config_Skins.Chat[SkinName]["EOCOOM"]=false end
    if not Healbot_Config_Skins.Chat[SkinName]["EOCOOMV"] then Healbot_Config_Skins.Chat[SkinName]["EOCOOMV"]=20 end
    if Healbot_Config_Skins.DuplicateBars[SkinName]==nil then Healbot_Config_Skins.DuplicateBars[SkinName]=false end
    if Healbot_Config_Skins.Enemy[SkinName]["INCSELF"]==nil then Healbot_Config_Skins.Enemy[SkinName]["INCSELF"]=false end
    if Healbot_Config_Skins.Enemy[SkinName]["INCTANKS"]==nil then Healbot_Config_Skins.Enemy[SkinName]["INCTANKS"]=true end
    if Healbot_Config_Skins.Enemy[SkinName]["INCFOCUS"]==nil then Healbot_Config_Skins.Enemy[SkinName]["INCFOCUS"]=true end
    if Healbot_Config_Skins.Enemy[SkinName]["INCMYTAR"]==nil then Healbot_Config_Skins.Enemy[SkinName]["INCMYTAR"]=false end
    if Healbot_Config_Skins.Enemy[SkinName]["INCARENA"]==nil then Healbot_Config_Skins.Enemy[SkinName]["INCARENA"]=true end
    if Healbot_Config_Skins.Enemy[SkinName]["INCARENAPETS"]==nil then Healbot_Config_Skins.Enemy[SkinName]["INCARENAPETS"]=false end
    if not Healbot_Config_Skins.Enemy[SkinName]["NUMBOSS"] then Healbot_Config_Skins.Enemy[SkinName]["NUMBOSS"]=8 end
    if Healbot_Config_Skins.Enemy[SkinName]["HIDE"] then 
        Healbot_Config_Skins.Frame[SkinName][10]["AUTOCLOSE"]=2
        Healbot_Config_Skins.Enemy[SkinName]["HIDE"]=nil
    elseif Healbot_Config_Skins.Enemy[SkinName]["HIDE"]==false then
        Healbot_Config_Skins.Enemy[SkinName]["HIDE"]=nil
    end
    if not Healbot_Config_Skins.Enemy[SkinName]["INCOMBATSHOWSELF"] then 
        Healbot_Config_Skins.Enemy[SkinName]["INCOMBATSHOWSELF"]=2 
    elseif Healbot_Config_Skins.Enemy[SkinName]["INCOMBATSHOWSELF"]==true then
        Healbot_Config_Skins.Enemy[SkinName]["INCOMBATSHOWSELF"]=1
    end
    if not Healbot_Config_Skins.Enemy[SkinName]["INCOMBATSHOWFOCUS"] then Healbot_Config_Skins.Enemy[SkinName]["INCOMBATSHOWFOCUS"]=2 end
    if not Healbot_Config_Skins.Enemy[SkinName]["INCOMBATSHOWTANK"] then 
        Healbot_Config_Skins.Enemy[SkinName]["INCOMBATSHOWTANK"]=2 
    elseif Healbot_Config_Skins.Enemy[SkinName]["INCOMBATSHOWTANK"]==true then
        Healbot_Config_Skins.Enemy[SkinName]["INCOMBATSHOWTANK"]=1
    end
    if not Healbot_Config_Skins.Enemy[SkinName]["INCOMBATSHOWLIST"] then 
        Healbot_Config_Skins.Enemy[SkinName]["INCOMBATSHOWLIST"]=2 
    elseif Healbot_Config_Skins.Enemy[SkinName]["INCOMBATSHOWLIST"]==true then
        Healbot_Config_Skins.Enemy[SkinName]["INCOMBATSHOWLIST"]=1
    end
    if not Healbot_Config_Skins.Enemy[SkinName]["INCOMBATSHOWARENA"] then 
        Healbot_Config_Skins.Enemy[SkinName]["INCOMBATSHOWARENA"]=2 
    elseif Healbot_Config_Skins.Enemy[SkinName]["INCOMBATSHOWARENA"]==true then
        Healbot_Config_Skins.Enemy[SkinName]["INCOMBATSHOWARENA"]=1
    end
    if not Healbot_Config_Skins.Enemy[SkinName]["EXISTSHOWPTAR"] then 
        Healbot_Config_Skins.Enemy[SkinName]["EXISTSHOWPTAR"]=1
    elseif Healbot_Config_Skins.Enemy[SkinName]["EXISTSHOWPTAR"]==true then
        Healbot_Config_Skins.Enemy[SkinName]["EXISTSHOWPTAR"]=2
    end
    if not Healbot_Config_Skins.Enemy[SkinName]["EXISTSHOWFOCUS"] then Healbot_Config_Skins.Enemy[SkinName]["EXISTSHOWFOCUS"]=1 end 
    if not Healbot_Config_Skins.Enemy[SkinName]["EXISTSHOWARENA"] then 
        Healbot_Config_Skins.Enemy[SkinName]["EXISTSHOWARENA"]=2
    elseif Healbot_Config_Skins.Enemy[SkinName]["EXISTSHOWARENA"]==true then
        Healbot_Config_Skins.Enemy[SkinName]["EXISTSHOWARENA"]=3
    end
    if not Healbot_Config_Skins.Enemy[SkinName]["EXISTSHOWMYTAR"] then 
        Healbot_Config_Skins.Enemy[SkinName]["EXISTSHOWMYTAR"]=1
    elseif Healbot_Config_Skins.Enemy[SkinName]["EXISTSHOWMYTAR"]==true then
        Healbot_Config_Skins.Enemy[SkinName]["EXISTSHOWMYTAR"]=2
    end
    if not Healbot_Config_Skins.Enemy[SkinName]["EXISTSHOWTANK"] then 
        Healbot_Config_Skins.Enemy[SkinName]["EXISTSHOWTANK"]=1
    elseif Healbot_Config_Skins.Enemy[SkinName]["EXISTSHOWTANK"]==true then
        Healbot_Config_Skins.Enemy[SkinName]["EXISTSHOWTANK"]=2
    end
    if Healbot_Config_Skins.Enemy[SkinName]["EXISTSHOWBOSS"]==nil then Healbot_Config_Skins.Enemy[SkinName]["EXISTSHOWBOSS"]=true end
    if Healbot_Config_Skins.Enemy[SkinName]["ENEMYTARGET"]==nil then Healbot_Config_Skins.Enemy[SkinName]["ENEMYTARGET"]=false end
    if not Healbot_Config_Skins.Enemy[SkinName]["ENEMYTARGETSIZE"] then Healbot_Config_Skins.Enemy[SkinName]["ENEMYTARGETSIZE"]=40 end
    if Healbot_Config_Skins.Enemy[SkinName]["DOUBLEWIDTH"]==nil then Healbot_Config_Skins.Enemy[SkinName]["DOUBLEWIDTH"]=false end
    if Healbot_Config_Skins.Enemy[SkinName]["INCDPS"] then Healbot_Config_Skins.Enemy[SkinName]["INCDPS"]=nil end
    if Healbot_Config_Skins.Enemy[SkinName]["FRAME"] then Healbot_Config_Skins.Enemy[SkinName]["FRAME"]=nil end
    if Healbot_Config_Skins.General[SkinName]["LOWMANA"] then Healbot_Config_Skins.General[SkinName]["LOWMANA"]=nil end
    if Healbot_Config_Skins.General[SkinName]["LOWMANACOMBAT"] then Healbot_Config_Skins.General[SkinName]["LOWMANACOMBAT"]=nil end
    -- Fix Frames
    for id=1,10 do
        if Healbot_Config_Skins.HealGroups[SkinName][id]["NAME"]==HEALBOT_CUSTOM_CASTBY_ENEMY_en then
            HealBot_Options_HealGroupSwap(SkinName, 11, id)
            break
        end
    end
    for id=1,9 do
        if Healbot_Config_Skins.HealGroups[SkinName][id]["NAME"]==HEALBOT_FOCUS_en then
            HealBot_Options_HealGroupSwap(SkinName, 10, id)
            break
        end
    end
    for id=1,8 do
        if Healbot_Config_Skins.HealGroups[SkinName][id]["NAME"]==HEALBOT_OPTIONS_TARGETHEALS_en then
            HealBot_Options_HealGroupSwap(SkinName, 9, id)
            break
        end
    end
    for id=1,7 do
        if Healbot_Config_Skins.HealGroups[SkinName][id]["NAME"]==HEALBOT_OPTIONS_PETHEALS_en then
            HealBot_Options_HealGroupSwap(SkinName, 8, id)
            break
        end
    end
    for id=1,6 do
        if Healbot_Config_Skins.HealGroups[SkinName][id]["NAME"]==HEALBOT_VEHICLE_en then
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
      --HealBot_setCall("HealBot_Skins_Check_Skin")
end
