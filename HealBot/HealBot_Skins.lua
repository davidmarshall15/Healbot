local LSM = HealBot_Libs_LSM() --LibStub("LibSharedMedia-3.0")
--local vResetSkinPrevSkin=""
local frameScale = 1
local bheight= 20
local bWidth = 120
local pWidth = 120
local EnemyTargetBarSize=40
local bOutline = 1
local btextheight,btextheight2=10,10
local btextoutline,btextoutline2=1,1
local b,bar,icon,txt,pIcon,expire,count=nil,nil,nil,nil,nil,nil,nil,nil
local Aux1,Aux2,Aux3,Aux4,Aux5,Aux6,Aux7,AuxBelow,AuxAbove,AuxLeft,AuxRight=nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil
local AuxIdx={[1]={},[2]={},[3]={},[4]={},[5]={},[6]={},[7]={},[8]={},[9]={}}
local icon1,expire1,count1,icon51,expire51,count51=nil,nil,nil,nil,nil,nil
local barScale,h,hwidth,hheight,iScale,diScale,itScale,x,hcpct=nil,nil,nil,nil,nil,nil,nil,nil,nil
local abtSize = {[0]=1,[1]=1,[2]=1,[3]=2,[4]=2,[5]=2,[6]=3,[7]=3,[8]=3,[9]=3,[10]=4,[11]=4,[12]=4,[13]=4,[14]=4,[15]=5}
local auxWidth,auxHeight, auxTmp=0,0,0
local lIconWidth,rIconWidth,bIconHeight=0,0,0
local barOffsetV, barOffsetH, barOffsetH2=0,0,0
local maxDebuffIcons=0
local AuxOverlapOffset=0
local tBarsConcat={}
local tabconcat=table.concat
local function HealBot_Skins_Concat(elements)
    return tabconcat(tBarsConcat,"",1,elements)
end

function HealBot_Skins_AdjustSpecialBarWidth(button)
    EnemyTargetBarSize=(Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["ENEMYTARGETSIZE"]/100)
    if HealBot_Panel_isSpecialUnit(button.unit)==1 then
        bWidth=bWidth*(1-EnemyTargetBarSize)
        bWidth=bWidth-(Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][button.frame]["CMARGIN"]+(bOutline*2))
        if Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["DOUBLEWIDTH"] then 
            bWidth=bWidth*2 
        end
        HealBot_Text_setEnemySizeWidth("EnemySizeWidth1", bWidth)
    else
        bWidth=bWidth*EnemyTargetBarSize
        if Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["DOUBLEWIDTH"] then bWidth=bWidth*2 end
        HealBot_Text_setEnemySizeWidth("EnemySizeWidth2", bWidth)
        HealBot_Action_SetBackSpecialWidth(10, bWidth)
    end
    
end

function HealBot_Skins_ResetSkinWidth(button)
    frameScale = Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][button.frame]["SCALE"]
    bWidth = ceil(Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][button.frame]["WIDTH"]*frameScale);
    bOutline = ceil(Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["BOUT"]*frameScale);
    if HealBot_Panel_isSpecialUnit(button.unit)>0 then
        HealBot_Skins_AdjustSpecialBarWidth(button)
    end
    button.gref["Bar"]:SetWidth(bWidth)
    button.gref["Back"]:SetWidth(bWidth+(bOutline*2))
    button.gref["InHeal"]:SetWidth(bWidth)
    button.gref["Absorb"]:SetWidth(bWidth)
    button.gref["DirArrow"]:SetWidth(bWidth)
    button:SetWidth(bWidth)
    for x=1,9 do
        button.gref.aux[x]:SetWidth(ceil(bWidth*Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["SIZE"]))
    end
end

function HealBot_Skins_ResetSkin(barType,button,numcols)
    if button and button.frame then 
        frameScale = Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][button.frame]["SCALE"]
        bheight= ceil(Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][button.frame]["HEIGHT"]*frameScale);
        bWidth = ceil(Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][button.frame]["WIDTH"]*frameScale);
        bOutline = ceil(Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["BOUT"]*frameScale);
        btextheight=ceil(Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["HEIGHT"]*frameScale);
        btextheight2=ceil(Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["HHEIGHT"]*frameScale)
        btextoutline=Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["OUTLINE"];
        btextoutline2=Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["HOUTLINE"]

        auxHeight=0
        auxWidth=0
        lIconWidth=0
        rIconWidth=0
        bIconHeight=0
        barOffsetH2=0
        barOffsetV=bOutline
        barOffsetH=bOutline

        if 1==1 then  
            for x=1,9 do
                if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["USE"]>1 then
                    if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["ANCHOR"]<3 then
                        if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["ANCHOR"]==1 then
                            auxTmp=Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["DEPTH"]+Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["OFFSET"]
                            if auxTmp<0 then auxTmp=0 end
                            barOffsetV=barOffsetV+auxTmp
                        end
                        auxTmp=auxHeight
                        auxHeight=auxHeight+Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["DEPTH"]
                        auxHeight=auxHeight+Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["OFFSET"]
                        if auxHeight<auxTmp then auxHeight=auxTmp end
                    else
                        if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["ANCHOR"]==3 then
                            auxTmp=Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["DEPTH"]+barOffsetH+Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["OFFSET"]
                            if auxTmp<0 then auxTmp=0 end
                            barOffsetH=auxTmp--barOffsetH+auxTmp
                        else
                            auxTmp=Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["DEPTH"]+barOffsetH+Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["OFFSET"]
                            if auxTmp<0 then auxTmp=0 end
                            barOffsetH2=auxTmp
                        end
                        auxTmp=auxWidth
                        auxWidth=auxWidth+Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["DEPTH"]
                        auxWidth=auxWidth+Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["OFFSET"]
                        if auxWidth<auxTmp then auxWidth=auxTmp end
                    end
                end
            end
            auxHeight=ceil(auxHeight*frameScale)
            auxWidth=ceil(auxWidth*frameScale)

            if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["ONBAR"]>1 then
                if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["ONBAR"]==2 then
                    if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["SHOWDEBUFF"] then
                        maxDebuffIcons=Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["MAXDICONS"]
                    else
                        maxDebuffIcons=0
                    end
                    if Healbot_Config_Skins.RaidIcon[Healbot_Config_Skins.Current_Skin][button.frame]["SHOW"] then 
                        maxDebuffIcons=maxDebuffIcons+1 
                    end                           
                    if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["SHOWRC"] then 
                        maxDebuffIcons=maxDebuffIcons+1 
                    end
                    if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["CLASSONBAR"] and
                       Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["CLASSTYPE"]<2 then
                        maxDebuffIcons=maxDebuffIcons+1 
                    end
                    if maxDebuffIcons>5 then maxDebuffIcons=5 end
                    if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["POSITION"]==1 then
                        if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["DOUBLE"] then
                            if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["SHOWBUFF"] then
                                lIconWidth=lIconWidth+floor((floor(bheight*
                                               Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["SCALE"])/2)*
                                               ceil(Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["MAXBICONS"]/2))
                            end
                            if maxDebuffIcons>0 then
                                rIconWidth=rIconWidth+floor((floor(bheight*
                                               Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["DSCALE"])/2)*
                                               ceil(maxDebuffIcons/2))
                            end
                        else
                            if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["SHOWBUFF"] then
                                lIconWidth=lIconWidth+floor((bheight*
                                                Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["SCALE"])*
                                                Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["MAXBICONS"])
                            end
                            if maxDebuffIcons>0 then
                                rIconWidth=rIconWidth+floor((bheight*
                                                Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["DSCALE"])*maxDebuffIcons)
                            end
                        end
                    else
                        if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["DOUBLE"] then
                            if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["SHOWBUFF"] then
                                rIconWidth=rIconWidth+floor((floor(bheight*
                                               Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["SCALE"])/2)*
                                               ceil(Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["MAXBICONS"]/2))
                            end
                            if maxDebuffIcons>0 then
                                lIconWidth=lIconWidth+floor((floor(bheight*
                                               Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["DSCALE"])/2)*
                                               ceil(maxDebuffIcons/2))
                            end
                        else
                            if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["SHOWBUFF"] then
                                rIconWidth=rIconWidth+floor((bheight*
                                                Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["SCALE"])*
                                                Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["MAXBICONS"])
                            end
                            if maxDebuffIcons>0 then
                                lIconWidth=lIconWidth+floor((bheight*
                                                Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["DSCALE"])*maxDebuffIcons)
                            end
                        end
                    end
                    lIconWidth=ceil(lIconWidth*frameScale)
                    rIconWidth=ceil(rIconWidth*frameScale)
                elseif Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["ONBAR"]==3 then
                    local maxScale=Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["SCALE"]
                    if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["DSCALE"]>maxScale then
                        maxScale=Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["DSCALE"]
                    end
                    bIconHeight=bIconHeight+floor(bheight*maxScale)
                    bIconHeight=ceil(bIconHeight*frameScale)
                end
            end
            pWidth=bWidth
        end
        if HealBot_Panel_isSpecialUnit(button.unit)>0 then
            HealBot_Skins_AdjustSpecialBarWidth(button)        
            if Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["DOUBLEWIDTH"] then 
                pWidth=pWidth*(2-(pWidth/7800))
            end
        end
        HealBot_Action_SetBackBarHeightWidth(button.frame, (bheight+auxHeight+bIconHeight+(bOutline*2)), (pWidth+auxWidth+lIconWidth+rIconWidth+(bOutline*2)))
    end
  
    if barType=="bar" then
        b=button;
        
        b.gref["Bar"]:SetHeight(bheight);
        b.gref["Bar"]:SetWidth(bWidth)
        
        b.gref["Back"]:SetHeight(bheight+auxHeight+bIconHeight+(bOutline*2))
        b.gref["Back"]:SetWidth(bWidth+auxWidth+lIconWidth+rIconWidth+(bOutline*2))
        b.gref["InHeal"]:SetHeight(bheight);
        b.gref["InHeal"]:SetWidth(bWidth)
        b.gref["Absorb"]:SetHeight(bheight);
        b.gref["Absorb"]:SetWidth(bWidth)
        b.gref["DirArrow"]:SetHeight(bheight);
        b.gref["DirArrow"]:SetWidth(bWidth)

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

        tBarsConcat[1]="f"
        tBarsConcat[2]=b.frame
        tBarsConcat[3]="_HealBot_Action"
        local gaf = _G[HealBot_Skins_Concat(3)]
        b:SetFrameLevel(gaf:GetFrameLevel()+ 1); 
        b.gref["Back"]:SetFrameLevel(b:GetFrameLevel()+ 1);      -- Background
        for x=1,9 do
            b.gref.aux[x]:SetFrameLevel(b.gref["Back"]:GetFrameLevel()+ 1)
        end
        b.gref["Absorb"]:SetFrameLevel(button.gref["Back"]:GetFrameLevel()+ 1);   -- Absorbs
        b.gref["InHeal"]:SetFrameLevel(b.gref["Absorb"]:GetFrameLevel()+ 1);   -- Incoming Heal
        b.gref["Bar"]:SetFrameLevel(b.gref["InHeal"]:GetFrameLevel()+ 1);    -- Health
        b.gref["DirArrow"]:SetFrameLevel(b.gref["Bar"]:GetFrameLevel()+ 1); -- Direction Arrow
     --   b.gref["Bar"]:SetTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][b.frame]["TEXTURE"]),false);
        b.gref["Bar"]:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][b.frame]["TEXTURE"]));
        b.gref["Bar"]:GetStatusBarTexture():SetHorizTile(false)

        b.gref["Bar"]:ClearAllPoints()
        b.gref["Bar"]:SetPoint("BOTTOMLEFT",b.gref["Back"],"BOTTOMLEFT",barOffsetH+lIconWidth,barOffsetV+bIconHeight)

        AuxBelow,AuxAbove,AuxLeft,AuxRight=b.gref["Bar"],b.gref["Bar"],b.gref["Bar"],b.gref["Bar"]
        AuxOverlapOffset=0
        for x=1,9 do
            if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["USE"]>1 then
                b.gref.aux[x]:ClearAllPoints()
                if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["ANCHOR"]<3 then
                    b.gref.aux[x]:SetOrientation("HORIZONTAL")
                    if Healbot_Config_Skins.AuxBarFrame[Healbot_Config_Skins.Current_Skin][button.frame]["OVERLAP"]==2 then
                        b.gref.aux[x]:SetWidth(ceil((bWidth+auxWidth)*Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["SIZE"]))
                        AuxOverlapOffset=ceil((bWidth+auxWidth)*(1-Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["SIZE"]))/2
                    else
                        b.gref.aux[x]:SetWidth(ceil(bWidth*Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["SIZE"]))
                    end
                    b.gref.aux[x]:SetHeight(Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["DEPTH"])
                    if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["ANCHOR"]==1 then
                        b.gref.aux[x]:SetPoint("TOP",AuxBelow,"BOTTOM",0,0-Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["OFFSET"])
                        AuxBelow=b.gref.aux[x]
                    else
                        b.gref.aux[x]:SetPoint("BOTTOM",AuxAbove,"TOP",0,Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["OFFSET"])
                        AuxAbove=b.gref.aux[x]
                    end
                    if Healbot_Config_Skins.AuxBarFrame[Healbot_Config_Skins.Current_Skin][button.frame]["OVERLAP"]==2 then
                        b.gref.aux[x]:SetPoint("RIGHT",b.gref["Back"],"RIGHT",-(bOutline+AuxOverlapOffset),0)
                    end
                else
                    b.gref.aux[x]:SetOrientation("VERTICAL")
                    b.gref.aux[x]:SetWidth(Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["DEPTH"])
                    if Healbot_Config_Skins.AuxBarFrame[Healbot_Config_Skins.Current_Skin][button.frame]["OVERLAP"]==1 then
                        b.gref.aux[x]:SetHeight(ceil((bheight+auxHeight)*Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["SIZE"]))
                        b.gref.aux[x]:SetPoint("TOP",b.gref["Back"],"TOP",0,-(bOutline+1))
                    else
                        b.gref.aux[x]:SetHeight(ceil(bheight*Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["SIZE"]))
                    end
                    if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["ANCHOR"]==3 then
                        b.gref.aux[x]:SetPoint("RIGHT",AuxLeft,"LEFT",0-Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["OFFSET"],0)
                        AuxLeft=b.gref.aux[x]
                    else
                        b.gref.aux[x]:SetPoint("LEFT",AuxRight,"RIGHT",Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["OFFSET"],0)
                        AuxRight=b.gref.aux[x]
                    end
                end
                if HealBot_retLuVars("TestBarsOn") then
                    b.gref.aux[x]:SetValue(1000)
                    if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["USE"]==2 then
                        b.gref.aux[x]:SetStatusBarColor(0.8,1,0.8,1)
                    elseif Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["USE"]==3 then
                        b.gref.aux[x]:SetStatusBarColor(0.7,0.9,0.7,1)
                    elseif Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["USE"]==4 then
                        b.gref.aux[x]:SetStatusBarColor(0.8,0.8,0.9,1)
                    elseif Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["USE"]==5 then
                        b.gref.aux[x]:SetStatusBarColor(1,0,0,1)
                    elseif Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["USE"]==6 then
                        b.gref.aux[x]:SetStatusBarColor(1,1,0,1)
                    elseif Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["USE"]==7 then
                        b.gref.aux[x]:SetStatusBarColor(0.5,0.7,0.5,1)
                    elseif Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["USE"]==8 then
                        b.gref.aux[x]:SetStatusBarColor(0.5,0.5,1,1)
                    elseif Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["USE"]==9 then
                        b.gref.aux[x]:SetStatusBarColor(1,1,1,1)
                    elseif Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["USE"]==10 then
                        b.gref.aux[x]:SetStatusBarColor(0.2,0.2,1,1)
                    end
                end
            else
                b.gref.aux[x]:SetStatusBarColor(0,0,0,0)
            end
        end
        
        b.gref.txt["text"]:SetFont(LSM:Fetch('font',Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["FONT"]),
                        btextheight,
                        HealBot_Font_Outline[btextoutline]);
        b.gref.txt["text2"]:SetFont(LSM:Fetch('font',Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["HFONT"]),
                        btextheight2,
                        HealBot_Font_Outline[btextoutline2]);
        b.gref.txt["enemycast"]:SetFont(LSM:Fetch('font',Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["FONT"]),
                        btextheight,
                        HealBot_Font_Outline[btextoutline]);
        b.gref.txt["text"]:ClearAllPoints();
        b.gref.txt["text2"]:ClearAllPoints();
        b.gref["Back"]:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][b.frame]["TEXTURE"]));
        b.gref["Back"]:GetStatusBarTexture():SetHorizTile(false)
        b.gref["Absorb"]:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][b.frame]["TEXTURE"]));
        b.gref["Absorb"]:GetStatusBarTexture():SetHorizTile(false)
        if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["ALIGN"]==1 then
            if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["HLTHTXTANCHOR"]==3 then
                b.gref.txt["text2"]:SetPoint("LEFT",b.gref["Bar"],"LEFT",4+Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["HOFFSET2"],5+Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["HOFFSET"])
                b.gref.txt["text"]:SetPoint("LEFT",b.gref.txt["text2"],"RIGHT",4,Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["OFFSET"])
            elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["HLTHTXTANCHOR"]==2 then
                b.gref.txt["text"]:SetPoint("LEFT",b.gref["Bar"],"LEFT",4+Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["HOFFSET2"],5+Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["OFFSET"])
            else
                b.gref.txt["text"]:SetPoint("LEFT",b.gref["Bar"],"LEFT",4,5+Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["OFFSET"])
            end
        elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["ALIGN"]==2 then
            if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["HLTHTXTANCHOR"]==2 then
                b.gref.txt["text"]:SetPoint("RIGHT",b.gref["Bar"],"CENTER",0+Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["HOFFSET2"],5+Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["OFFSET"])
            elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["HLTHTXTANCHOR"]==3 then
                b.gref.txt["text"]:SetPoint("LEFT",b.gref["Bar"],"CENTER",0+Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["HOFFSET2"],5+Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["OFFSET"])
            else
                b.gref.txt["text"]:SetPoint("CENTER",b.gref["Bar"],"CENTER",0,5+Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["OFFSET"])
            end
        else
            if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["HLTHTXTANCHOR"]==2 then
                b.gref.txt["text2"]:SetPoint("RIGHT",b.gref["Bar"],"RIGHT",-4+Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["HOFFSET2"],5+Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["HOFFSET"])
                b.gref.txt["text"]:SetPoint("RIGHT",b.gref.txt["text2"],"LEFT",-4,Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["OFFSET"])
            elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["HLTHTXTANCHOR"]==3 then
                b.gref.txt["text"]:SetPoint("RIGHT",b.gref["Bar"],"RIGHT",-4+Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["HOFFSET2"],5+Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["OFFSET"])
            else
                b.gref.txt["text"]:SetPoint("RIGHT",b.gref["Bar"],"RIGHT",-4,5+Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["OFFSET"])
            end
        end
        if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["HLTHTXTANCHOR"]==1 then
            if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["HALIGN"]==1 then
                b.gref.txt["text2"]:SetPoint("LEFT",b.gref["Bar"],"LEFT",4,-7+Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["HOFFSET"])
            elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["HALIGN"]==2 then
                b.gref.txt["text2"]:SetPoint("CENTER",b.gref["Bar"],"CENTER",0,-7+Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["HOFFSET"])
            else
                b.gref.txt["text2"]:SetPoint("RIGHT",b.gref["Bar"],"RIGHT",-4,-7+Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["HOFFSET"])
            end
        elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["HLTHTXTANCHOR"]==2 and 
               Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["ALIGN"]<3 then
            b.gref.txt["text2"]:SetPoint("LEFT",b.gref.txt["text"],"RIGHT",4,Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["HOFFSET"])
        elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["HLTHTXTANCHOR"]==3 and 
               Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["ALIGN"]>1 then
            b.gref.txt["text2"]:SetPoint("RIGHT",b.gref.txt["text"],"LEFT",-4,Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["HOFFSET"])
        elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["HLTHTXTANCHOR"]==4 then
            b.gref.txt["text2"]:SetPoint("TOP",b.gref.txt["text"],"BOTTOM",0+Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["HOFFSET2"],-2+Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["HOFFSET"])
        elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["HLTHTXTANCHOR"]==5 then
            b.gref.txt["text2"]:SetPoint("BOTTOM",b.gref.txt["text"],"TOP",0+Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["HOFFSET2"],2+Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["HOFFSET"])
        end
        
        b.gref["InHeal"]:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][b.frame]["TEXTURE"]));
        b.gref["InHeal"]:GetStatusBarTexture():SetHorizTile(false)
        for x=1,9 do
            b.gref.aux[x]:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][b.frame]["TEXTURE"]))
            b.gref.aux[x]:GetStatusBarTexture():SetHorizTile(false)
        end

        b:SetHeight(bheight); 
        b:SetWidth(bWidth)
        iScale=(bheight*Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["SCALE"])-2
        button.gref.icon["IconDirArrow"]:SetHeight(iScale);
        button.gref.icon["IconDirArrow"]:SetWidth(iScale);
        b.gref["DirArrow"]:SetHeight(iScale);
        b.gref["DirArrow"]:SetWidth(iScale);
        button.gref.icon["IconDirArrow"]:Hide()
        if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["DOUBLE"] then
            iScale=floor(((bheight*Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["SCALE"])-2)*0.485)
        end
        for x=1,10 do
            b.gref.icon[x]:SetHeight(iScale);
            b.gref.icon[x]:SetWidth(iScale);
            b.gref.txt.expire[x]:SetFont(LSM:Fetch('font',Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][b.frame]["FONT"]),
                                            Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][b.frame]["HEIGHT"],
                                            HealBot_Font_Outline[Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][b.frame]["OUTLINE"]]);
            b.gref.txt.count[x]:SetFont(LSM:Fetch('font',Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][b.frame]["FONT"]),
                                            Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][b.frame]["HEIGHT"],
                                            HealBot_Font_Outline[Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][b.frame]["OUTLINE"]]);
        end
        if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["DOUBLE"] then
            diScale=floor(((bheight*Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["DSCALE"])-2)*0.485)
        else
            diScale=(bheight*Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["DSCALE"])-2
        end
        for x=51,55 do
            b.gref.icon[x]:SetHeight(diScale);
            b.gref.icon[x]:SetWidth(diScale);
            b.gref.txt.expire[x]:SetFont(LSM:Fetch('font',Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][b.frame]["FONT"]),
                                            Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][b.frame]["HEIGHT"],
                                            HealBot_Font_Outline[Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][b.frame]["OUTLINE"]]);
            b.gref.txt.count[x]:SetFont(LSM:Fetch('font',Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][b.frame]["FONT"]),
                                            Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][b.frame]["HEIGHT"],
                                            HealBot_Font_Outline[Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][b.frame]["OUTLINE"]]);
        end
        if diScale>iScale then iScale=diScale end

        button.gref.indicator.aggro["Iconal1"]:SetAlpha(0)
        button.gref.indicator.aggro["Iconal2"]:SetAlpha(0)
        button.gref.indicator.aggro["Iconal3"]:SetAlpha(0)
        button.gref.indicator.aggro["Iconar1"]:SetAlpha(0)
        button.gref.indicator.aggro["Iconar2"]:SetAlpha(0)
        button.gref.indicator.aggro["Iconar3"]:SetAlpha(0)
        button.gref.indicator.mana[1]:SetAlpha(0)
        button.gref.indicator.mana[2]:SetAlpha(0)
        button.gref.indicator.mana[3]:SetAlpha(0)
        for x=1,5 do
            button.gref.indicator.power[x]:SetAlpha(0);
        end
        if HealBot_Action_retLuVars("UnitPowerMax")==3 then
            button.gref.indicator.power[1]:SetPoint("BOTTOM",button.gref.aux[1],"BOTTOM","-9","1");
            button.gref.indicator.power[2]:SetPoint("BOTTOM",button.gref.aux[1],"BOTTOM","0","1");
            button.gref.indicator.power[3]:SetPoint("BOTTOM",button.gref.aux[1],"BOTTOM","9","1");
        elseif HealBot_Action_retLuVars("UnitPowerMax")==4 then
            button.gref.indicator.power[1]:SetPoint("BOTTOM",button.gref.aux[1],"BOTTOM","-12","1");
            button.gref.indicator.power[2]:SetPoint("BOTTOM",button.gref.aux[1],"BOTTOM","-4","1");
            button.gref.indicator.power[3]:SetPoint("BOTTOM",button.gref.aux[1],"BOTTOM","4","1");
            button.gref.indicator.power[4]:SetPoint("BOTTOM",button.gref.aux[1],"BOTTOM","12","1");
        else
            button.gref.indicator.power[1]:SetPoint("BOTTOM",button.gref.aux[1],"BOTTOM","-14","1");
            button.gref.indicator.power[2]:SetPoint("BOTTOM",button.gref.aux[1],"BOTTOM","-7","1");
            button.gref.indicator.power[3]:SetPoint("BOTTOM",button.gref.aux[1],"BOTTOM","0","1");
            button.gref.indicator.power[4]:SetPoint("BOTTOM",button.gref.aux[1],"BOTTOM","7","1");
            button.gref.indicator.power[5]:SetPoint("BOTTOM",button.gref.aux[1],"BOTTOM","14","1");
        end
        if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["ONBAR"]==1 then
            if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["POSITION"]==1 then
                b.gref.icon[1]:ClearAllPoints();
                b.gref.icon[1]:SetPoint("BOTTOMLEFT",b,"BOTTOMLEFT",1,1);
                b.gref.txt.expire[1]:ClearAllPoints();
                b.gref.txt.expire[1]:SetPoint("BOTTOMLEFT",b.gref.icon[1],"BOTTOMLEFT",0,0);
                b.gref.txt.count[1]:ClearAllPoints();
                b.gref.txt.count[1]:SetPoint("TOPRIGHT",b.gref.icon[1],"TOPRIGHT",2,0);
                for x=2,10 do
                    b.gref.icon[x]:ClearAllPoints();
                    if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["DOUBLE"] then
                        if (x/2)==floor(x/2) then
                            b.gref.icon[x]:SetPoint("BOTTOMLEFT",b.gref.icon[x-1],"TOPLEFT",0,1);
                        else
                            b.gref.icon[x]:SetPoint("BOTTOMLEFT",b.gref.icon[x-2],"BOTTOMRIGHT",1,0);
                        end
                    else
                        b.gref.icon[x]:SetPoint("BOTTOMLEFT",b.gref.icon[x-1],"BOTTOMRIGHT",1,0);
                    end
                    b.gref.txt.expire[x]:ClearAllPoints();
                    b.gref.txt.expire[x]:SetPoint("BOTTOMLEFT",b.gref.icon[x],"BOTTOMLEFT",0,0);
                    b.gref.txt.count[x]:ClearAllPoints();
                    b.gref.txt.count[x]:SetPoint("TOPRIGHT",b.gref.icon[x],"TOPRIGHT",2,0);
                end
                b.gref.icon[51]:ClearAllPoints();
                b.gref.icon[51]:SetPoint("BOTTOMRIGHT",b,"BOTTOMRIGHT",-1,1);
                b.gref.txt.expire[51]:ClearAllPoints();
                b.gref.txt.expire[51]:SetPoint("BOTTOMLEFT",b.gref.icon[51],"BOTTOMLEFT",0,0);
                b.gref.txt.count[51]:ClearAllPoints();
                b.gref.txt.count[51]:SetPoint("TOPRIGHT",b.gref.icon[51],"TOPRIGHT",2,0);
                for x=52,55 do
                    b.gref.icon[x]:ClearAllPoints();
                    if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["DOUBLE"] then
                        if (x/2)==floor(x/2) then
                            b.gref.icon[x]:SetPoint("BOTTOMRIGHT",b.gref.icon[x-1],"TOPRIGHT",0,1);
                        else
                            b.gref.icon[x]:SetPoint("BOTTOMRIGHT",b.gref.icon[x-2],"BOTTOMLEFT",1,0);
                        end
                    else
                        b.gref.icon[x]:SetPoint("BOTTOMRIGHT",b.gref.icon[x-1],"BOTTOMLEFT",1,0);
                    end
                    b.gref.txt.expire[x]:ClearAllPoints();
                    b.gref.txt.expire[x]:SetPoint("BOTTOMLEFT",b.gref.icon[x],"BOTTOMLEFT",0,0);
                    b.gref.txt.count[x]:ClearAllPoints();
                    b.gref.txt.count[x]:SetPoint("TOPRIGHT",b.gref.icon[x],"TOPRIGHT",2,0);
                end
            else
                b.gref.icon[1]:ClearAllPoints();
                b.gref.icon[1]:SetPoint("BOTTOMRIGHT",b,"BOTTOMRIGHT",-1,1);
                b.gref.txt.expire[1]:ClearAllPoints();
                b.gref.txt.expire[1]:SetPoint("BOTTOMRIGHT",b.gref.icon[1],"BOTTOMRIGHT",2,0);
                b.gref.txt.count[1]:ClearAllPoints();
                b.gref.txt.count[1]:SetPoint("TOPLEFT",b.gref.icon[1],"TOPLEFT",0,0);
                for x=2,10 do
                    b.gref.icon[x]:ClearAllPoints();
                    if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["DOUBLE"] then
                        if (x/2)==floor(x/2) then
                            b.gref.icon[x]:SetPoint("BOTTOMRIGHT",b.gref.icon[x-1],"TOPRIGHT",0,1);
                        else
                            b.gref.icon[x]:SetPoint("BOTTOMRIGHT",b.gref.icon[x-2],"BOTTOMLEFT",-1,0);
                        end
                    else
                        b.gref.icon[x]:SetPoint("BOTTOMRIGHT",b.gref.icon[x-1],"BOTTOMLEFT",-1,0);
                    end
                    b.gref.txt.expire[x]:ClearAllPoints();
                    b.gref.txt.expire[x]:SetPoint("BOTTOMRIGHT",b.gref.icon[x],"BOTTOMRIGHT",2,0);
                    b.gref.txt.count[x]:ClearAllPoints();
                    b.gref.txt.count[x]:SetPoint("TOPLEFT",b.gref.icon[x],"TOPLEFT",0,0);
                end
                b.gref.icon[51]:ClearAllPoints();
                b.gref.icon[51]:SetPoint("BOTTOMLEFT",b,"BOTTOMLEFT",1,1);
                b.gref.txt.expire[51]:ClearAllPoints();
                b.gref.txt.expire[51]:SetPoint("BOTTOMRIGHT",b.gref.icon[51],"BOTTOMRIGHT",2,0);
                b.gref.txt.count[51]:ClearAllPoints();
                b.gref.txt.count[51]:SetPoint("TOPLEFT",b.gref.icon[51],"TOPLEFT",0,0);
                for x=52,55 do
                    b.gref.icon[x]:ClearAllPoints();
                    if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["DOUBLE"] then
                        if (x/2)==floor(x/2) then
                            b.gref.icon[x]:SetPoint("BOTTOMLEFT",b.gref.icon[x-1],"TOPLEFT",0,1);
                        else
                            b.gref.icon[x]:SetPoint("BOTTOMLEFT",b.gref.icon[x-2],"BOTTOMRIGHT",-1,0);
                        end
                    else
                        b.gref.icon[x]:SetPoint("BOTTOMLEFT",b.gref.icon[x-1],"BOTTOMRIGHT",-1,0);
                    end
                    b.gref.txt.expire[x]:ClearAllPoints();
                    b.gref.txt.expire[x]:SetPoint("BOTTOMRIGHT",b.gref.icon[x],"BOTTOMRIGHT",2,0);
                    b.gref.txt.count[x]:ClearAllPoints();
                    b.gref.txt.count[x]:SetPoint("TOPLEFT",b.gref.icon[x],"TOPLEFT",0,0);
                end
            end
        elseif Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["ONBAR"]==2 then
            if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["POSITION"]==1 then
                b.gref.icon[1]:ClearAllPoints();
                b.gref.icon[1]:SetPoint("BOTTOMRIGHT",b,"BOTTOMLEFT",0-(1+barOffsetH),1);
                b.gref.txt.expire[1]:ClearAllPoints();
                b.gref.txt.expire[1]:SetPoint("BOTTOMRIGHT",b.gref.icon[1],"BOTTOMRIGHT",2,0);
                b.gref.txt.count[1]:ClearAllPoints();
                b.gref.txt.count[1]:SetPoint("TOPLEFT",b.gref.icon[1],"TOPLEFT",0,0);
                for x=2,10 do
                    b.gref.icon[x]:ClearAllPoints();
                    if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["DOUBLE"] then
                        if (x/2)==floor(x/2) then
                            b.gref.icon[x]:SetPoint("BOTTOMRIGHT",b.gref.icon[x-1],"TOPRIGHT",0,1);
                        else
                            b.gref.icon[x]:SetPoint("BOTTOMRIGHT",b.gref.icon[x-2],"BOTTOMLEFT",-1,0);
                        end
                    else
                        b.gref.icon[x]:SetPoint("BOTTOMRIGHT",b.gref.icon[x-1],"BOTTOMLEFT",-1,0);
                    end
                    b.gref.txt.expire[x]:ClearAllPoints();
                    b.gref.txt.expire[x]:SetPoint("BOTTOMRIGHT",b.gref.icon[x],"BOTTOMRIGHT",2,0);
                    b.gref.txt.count[x]:ClearAllPoints();
                    b.gref.txt.count[x]:SetPoint("TOPLEFT",b.gref.icon[x],"TOPLEFT",0,0);
                end
                b.gref.icon[51]:ClearAllPoints();
                b.gref.icon[51]:SetPoint("BOTTOMLEFT",b,"BOTTOMRIGHT",2+barOffsetH2,1);
                b.gref.txt.expire[51]:ClearAllPoints();
                b.gref.txt.expire[51]:SetPoint("BOTTOMRIGHT",b.gref.icon[51],"BOTTOMRIGHT",2,0);
                b.gref.txt.count[51]:ClearAllPoints();
                b.gref.txt.count[51]:SetPoint("TOPLEFT",b.gref.icon[51],"TOPLEFT",0,0);
                for x=52,55 do
                    b.gref.icon[x]:ClearAllPoints();
                    if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["DOUBLE"] then
                        if (x/2)==floor(x/2) then
                            b.gref.icon[x]:SetPoint("BOTTOMLEFT",b.gref.icon[x-1],"TOPLEFT",0,1);
                        else
                            b.gref.icon[x]:SetPoint("BOTTOMLEFT",b.gref.icon[x-2],"BOTTOMRIGHT",-1,0);
                        end
                    else
                        b.gref.icon[x]:SetPoint("BOTTOMLEFT",b.gref.icon[x-1],"BOTTOMRIGHT",-1,0);
                    end
                    b.gref.txt.expire[x]:ClearAllPoints();
                    b.gref.txt.expire[x]:SetPoint("BOTTOMRIGHT",b.gref.icon[x],"BOTTOMRIGHT",2,0);
                    b.gref.txt.count[x]:ClearAllPoints();
                    b.gref.txt.count[x]:SetPoint("TOPLEFT",b.gref.icon[x],"TOPLEFT",0,0);
                end
            else
                b.gref.icon[1]:ClearAllPoints();
                b.gref.icon[1]:SetPoint("BOTTOMLEFT",b,"BOTTOMRIGHT",2+barOffsetH2,1);
                b.gref.txt.expire[1]:ClearAllPoints();
                b.gref.txt.expire[1]:SetPoint("BOTTOMLEFT",b.gref.icon[1],"BOTTOMLEFT",0,0);
                b.gref.txt.count[1]:ClearAllPoints();
                b.gref.txt.count[1]:SetPoint("TOPRIGHT",b.gref.icon[1],"TOPRIGHT",2,0);
                for x=2,10 do
                    b.gref.icon[x]:ClearAllPoints();
                    if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["DOUBLE"] then
                        if (x/2)==floor(x/2) then
                            b.gref.icon[x]:SetPoint("BOTTOMLEFT",b.gref.icon[x-1],"TOPLEFT",0,1);
                        else
                            b.gref.icon[x]:SetPoint("BOTTOMLEFT",b.gref.icon[x-2],"BOTTOMRIGHT",1,0);
                        end
                    else
                        b.gref.icon[x]:SetPoint("BOTTOMLEFT",b.gref.icon[x-1],"BOTTOMRIGHT",1,0);
                    end
                    b.gref.txt.expire[x]:ClearAllPoints();
                    b.gref.txt.expire[x]:SetPoint("BOTTOMLEFT",b.gref.icon[x],"BOTTOMLEFT",0,0);
                    b.gref.txt.count[x]:ClearAllPoints();
                    b.gref.txt.count[x]:SetPoint("TOPRIGHT",b.gref.icon[x],"TOPRIGHT",2,0);
                end
                b.gref.icon[51]:ClearAllPoints();
                b.gref.icon[51]:SetPoint("BOTTOMRIGHT",b,"BOTTOMLEFT",0-(1+barOffsetH),1);
                b.gref.txt.expire[51]:ClearAllPoints();
                b.gref.txt.expire[51]:SetPoint("BOTTOMLEFT",b.gref.icon[51],"BOTTOMLEFT",0,0);
                b.gref.txt.count[51]:ClearAllPoints();
                b.gref.txt.count[51]:SetPoint("TOPRIGHT",b.gref.icon[51],"TOPRIGHT",2,0);
                for x=52,55 do
                    b.gref.icon[x]:ClearAllPoints();
                    if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["DOUBLE"] then
                        if (x/2)==floor(x/2) then
                            b.gref.icon[x]:SetPoint("BOTTOMRIGHT",b.gref.icon[x-1],"TOPRIGHT",0,1);
                        else
                            b.gref.icon[x]:SetPoint("BOTTOMRIGHT",b.gref.icon[x-2],"BOTTOMLEFT",1,0);
                        end
                    else
                        b.gref.icon[x]:SetPoint("BOTTOMRIGHT",b.gref.icon[x-1],"BOTTOMLEFT",1,0);
                    end
                    b.gref.txt.expire[x]:ClearAllPoints();
                    b.gref.txt.expire[x]:SetPoint("BOTTOMLEFT",b.gref.icon[x],"BOTTOMLEFT",0,0);
                    b.gref.txt.count[x]:ClearAllPoints();
                    b.gref.txt.count[x]:SetPoint("TOPRIGHT",b.gref.icon[x],"TOPRIGHT",2,0);
                end
            end
        else
            if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["POSITION"]==1 then
                b.gref.icon[1]:ClearAllPoints();
                b.gref.icon[1]:SetPoint("TOPLEFT",b,"BOTTOMLEFT",1,0-barOffsetV);
                b.gref.txt.expire[1]:ClearAllPoints();
                b.gref.txt.expire[1]:SetPoint("BOTTOMLEFT",b.gref.icon[1],"BOTTOMLEFT",0,0);
                b.gref.txt.count[1]:ClearAllPoints();
                b.gref.txt.count[1]:SetPoint("TOPRIGHT",b.gref.icon[1],"TOPRIGHT",2,0);
                for x=2,10 do
                    b.gref.icon[x]:ClearAllPoints();
                    if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["DOUBLE"] then
                        if (x/2)==floor(x/2) then
                            b.gref.icon[x]:SetPoint("TOPLEFT",b.gref.icon[x-1],"BOTTOMLEFT",0,-1);
                        else
                            b.gref.icon[x]:SetPoint("BOTTOMLEFT",b.gref.icon[x-2],"BOTTOMRIGHT",1,0);
                        end
                    else
                        b.gref.icon[x]:SetPoint("BOTTOMLEFT",b.gref.icon[x-1],"BOTTOMRIGHT",1,0);
                    end
                    b.gref.txt.expire[x]:ClearAllPoints();
                    b.gref.txt.expire[x]:SetPoint("BOTTOMLEFT",b.gref.icon[x],"BOTTOMLEFT",0,0);
                    b.gref.txt.count[x]:ClearAllPoints();
                    b.gref.txt.count[x]:SetPoint("TOPRIGHT",b.gref.icon[x],"TOPRIGHT",2,0);
                end
                b.gref.icon[51]:ClearAllPoints();
                b.gref.icon[51]:SetPoint("TOPRIGHT",b,"BOTTOMRIGHT",-1,0-barOffsetV);
                b.gref.txt.expire[51]:ClearAllPoints();
                b.gref.txt.expire[51]:SetPoint("BOTTOMLEFT",b.gref.icon[51],"BOTTOMLEFT",0,0);
                b.gref.txt.count[51]:ClearAllPoints();
                b.gref.txt.count[51]:SetPoint("TOPRIGHT",b.gref.icon[51],"TOPRIGHT",2,0);
                for x=52,55 do
                    b.gref.icon[x]:ClearAllPoints();
                    if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["DOUBLE"] then
                        if (x/2)==floor(x/2) then
                            b.gref.icon[x]:SetPoint("TOPRIGHT",b.gref.icon[x-1],"BOTTOMRIGHT",0,-1);
                        else
                            b.gref.icon[x]:SetPoint("BOTTOMRIGHT",b.gref.icon[x-2],"BOTTOMLEFT",1,0);
                        end
                    else
                        b.gref.icon[x]:SetPoint("BOTTOMRIGHT",b.gref.icon[x-1],"BOTTOMLEFT",1,0);
                    end
                    b.gref.txt.expire[x]:ClearAllPoints();
                    b.gref.txt.expire[x]:SetPoint("BOTTOMLEFT",b.gref.icon[x],"BOTTOMLEFT",0,0);
                    b.gref.txt.count[x]:ClearAllPoints();
                    b.gref.txt.count[x]:SetPoint("TOPRIGHT",b.gref.icon[x],"TOPRIGHT",2,0);
                end
            else
                b.gref.icon[1]:ClearAllPoints();
                b.gref.icon[1]:SetPoint("TOPRIGHT",b,"BOTTOMRIGHT",-1,0-barOffsetV);
                b.gref.txt.expire[1]:ClearAllPoints();
                b.gref.txt.expire[1]:SetPoint("BOTTOMRIGHT",b.gref.icon[1],"BOTTOMRIGHT",2,0);
                b.gref.txt.count[1]:ClearAllPoints();
                b.gref.txt.count[1]:SetPoint("TOPLEFT",b.gref.icon[1],"TOPLEFT",0,0);
                for x=2,10 do
                    b.gref.icon[x]:ClearAllPoints();
                    if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["DOUBLE"] then
                        if (x/2)==floor(x/2) then
                            b.gref.icon[x]:SetPoint("TOPRIGHT",b.gref.icon[x-1],"BOTTOMRIGHT",0,-1);
                        else
                            b.gref.icon[x]:SetPoint("BOTTOMRIGHT",b.gref.icon[x-2],"BOTTOMLEFT",-1,0);
                        end
                    else
                        b.gref.icon[x]:SetPoint("BOTTOMRIGHT",b.gref.icon[x-1],"BOTTOMLEFT",-1,0);
                    end
                    b.gref.txt.expire[x]:ClearAllPoints();
                    b.gref.txt.expire[x]:SetPoint("BOTTOMRIGHT",b.gref.icon[x],"BOTTOMRIGHT",2,0);
                    b.gref.txt.count[x]:ClearAllPoints();
                    b.gref.txt.count[x]:SetPoint("TOPLEFT",b.gref.icon[x],"TOPLEFT",0,0);
                end
                b.gref.icon[51]:ClearAllPoints();
                b.gref.icon[51]:SetPoint("TOPLEFT",b,"BOTTOMLEFT",1,0-barOffsetV);
                b.gref.txt.expire[51]:ClearAllPoints();
                b.gref.txt.expire[51]:SetPoint("BOTTOMRIGHT",b.gref.icon[51],"BOTTOMRIGHT",2,0);
                b.gref.txt.count[51]:ClearAllPoints();
                b.gref.txt.count[51]:SetPoint("TOPLEFT",b.gref.icon[51],"TOPLEFT",0,0);
                for x=52,55 do
                    b.gref.icon[x]:ClearAllPoints();
                    if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["DOUBLE"] then
                        if (x/2)==floor(x/2) then
                            b.gref.icon[x]:SetPoint("TOPLEFT",b.gref.icon[x-1],"BOTTOMLEFT",0,-1);
                        else
                            b.gref.icon[x]:SetPoint("BOTTOMLEFT",b.gref.icon[x-2],"BOTTOMRIGHT",-1,0);
                        end
                    else
                        b.gref.icon[x]:SetPoint("BOTTOMLEFT",b.gref.icon[x-1],"BOTTOMRIGHT",-1,0);
                    end
                    b.gref.txt.expire[x]:ClearAllPoints();
                    b.gref.txt.expire[x]:SetPoint("BOTTOMRIGHT",b.gref.icon[x],"BOTTOMRIGHT",2,0);
                    b.gref.txt.count[x]:ClearAllPoints();
                    b.gref.txt.count[x]:SetPoint("TOPLEFT",b.gref.icon[x],"TOPLEFT",0,0);
                end
            end
        end

        HealBot_Text_setTextLen(b.frame)
        HealBot_Text_setNameText(b)
        HealBot_Action_Refresh(b)
    elseif barType=="header" then
        h=button
        bar = _G[h:GetName().."Bar"]
        local back = _G[h:GetName().."Bar5"]
        hwidth = ceil((bWidth+(bOutline*2))*Healbot_Config_Skins.HeadBar[Healbot_Config_Skins.Current_Skin][h.frame]["WIDTH"])
        hheight = ceil(Healbot_Config_Skins.HeadBar[Healbot_Config_Skins.Current_Skin][h.frame]["HEIGHT"]*frameScale)
        h:SetHeight(hheight);
        h:SetWidth(hwidth);
        back:SetHeight(hheight)
        back:SetWidth(hwidth)
        HealBot_Action_SetBackHeaderHeightWidth(h.frame, hheight, hwidth)
        back:SetStatusBarColor(0,0,0,0)
        bar:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.HeadBar[Healbot_Config_Skins.Current_Skin][h.frame]["TEXTURE"]));
        bar:GetStatusBarTexture():SetHorizTile(false)
        bar:SetMinMaxValues(0,100);
        bar:SetValue(100);
        bar:SetStatusBarColor(Healbot_Config_Skins.HeadBar[Healbot_Config_Skins.Current_Skin][h.frame]["R"],
                              Healbot_Config_Skins.HeadBar[Healbot_Config_Skins.Current_Skin][h.frame]["G"],
                              Healbot_Config_Skins.HeadBar[Healbot_Config_Skins.Current_Skin][h.frame]["B"],
                              Healbot_Config_Skins.HeadBar[Healbot_Config_Skins.Current_Skin][h.frame]["A"]);
        bar:SetHeight(hheight);
        bar:SetWidth(hwidth);
        tBarsConcat[1]=bar:GetName()
        tBarsConcat[2]="_text"
        bar.txt = _G[HealBot_Skins_Concat(2)];
        tBarsConcat[2]="_text2"
        bar.txt2 = _G[HealBot_Skins_Concat(2)];
        bar.txt:SetFont(LSM:Fetch('font',Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin][h.frame]["FONT"]),
                                Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin][h.frame]["HEIGHT"],
                                HealBot_Font_Outline[Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin][h.frame]["OUTLINE"]]);
        bar.txt:SetTextColor(Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin][h.frame]["R"],
                             Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin][h.frame]["G"],
                             Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin][h.frame]["B"],
                             Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin][h.frame]["A"]);
        bar.txt:SetPoint("CENTER",bar,"CENTER",0,Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin][h.frame]["OFFSET"])
        bar:EnableMouse(false)
        bar.txt2:SetTextColor(0,0,0,0);
        bar:ClearAllPoints()
        bar:SetPoint("CENTER",back,"CENTER",0,0)
        h:Disable();
    elseif barType=="frameheader" then
        tBarsConcat[1]="f"
        tBarsConcat[2]=numcols
        tBarsConcat[3]="_HealBot_Action"
        local g=_G[HealBot_Skins_Concat(3)]
        if g:IsVisible() and g:GetRight() and g:GetLeft() then
            tBarsConcat[3]="_HealBot_Action_HeaderBar"
            bar = _G[HealBot_Skins_Concat(3)]
            if Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][numcols]["SHOW"] then
                local fWidth=g:GetRight()-g:GetLeft()
                --bar = _G[h:GetName().."Bar"]
                hwidth = ceil(fWidth*Healbot_Config_Skins.FrameAliasBar[Healbot_Config_Skins.Current_Skin][numcols]["WIDTH"])
                bar:SetHeight(ceil(Healbot_Config_Skins.FrameAliasBar[Healbot_Config_Skins.Current_Skin][numcols]["HEIGHT"]*frameScale));
                bar:SetWidth(hwidth);
                bar:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.FrameAliasBar[Healbot_Config_Skins.Current_Skin][numcols]["TEXTURE"]));
                bar:GetStatusBarTexture():SetHorizTile(false)
                bar:SetMinMaxValues(0,100);
                bar:SetValue(100);
                bar:SetStatusBarColor(Healbot_Config_Skins.FrameAliasBar[Healbot_Config_Skins.Current_Skin][numcols]["R"],
                                      Healbot_Config_Skins.FrameAliasBar[Healbot_Config_Skins.Current_Skin][numcols]["G"],
                                      Healbot_Config_Skins.FrameAliasBar[Healbot_Config_Skins.Current_Skin][numcols]["B"],
                                      Healbot_Config_Skins.FrameAliasBar[Healbot_Config_Skins.Current_Skin][numcols]["A"]);
            else
                bar:SetStatusBarColor(0,0,0,0);
            end
            bar:EnableMouse(false)
            barScale = bar:GetScale();
            bar:SetScale(barScale + 0.01);
            bar:SetScale(barScale);
        end
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
        HealBot_Panel_clearResetHeaderSkinDone()
        HealBot_Action_clearResetBarSkinDone()
        HealBot_setOptions_Timer(80)
        HealBot_setOptions_Timer(50)
        HealBot_setOptions_Timer(9970)
        --if vResetSkinPrevSkin~=Healbot_Config_Skins.Current_Skin then
        --    vResetSkinPrevSkin=Healbot_Config_Skins.Current_Skin
            --HealBot_setOptions_Timer(800)
        --end
    end
    --HealBot_setCall("HealBot_Skins_ResetSkin")
end

function HealBot_Skins_Check_Skin(SkinName)
    if Healbot_Config_Skins.ExtraIncGroup then Healbot_Config_Skins.ExtraIncGroup=nil end
    if Healbot_Config_Skins.BarsHide then Healbot_Config_Skins.BarsHide=nil end
    if Healbot_Config_Skins.EmergIncMonitor then Healbot_Config_Skins.EmergIncMonitor=nil end
    
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
        [2] = {["NAME"]=HEALBOT_OPTIONS_TANKHEALS_en,["STATE"]=true,["FRAME"]=1},
        [3] = {["NAME"]=HEALBOT_CLASSES_HEALERS_en,["STATE"]=false,["FRAME"]=1}, 
        [4] = {["NAME"]=HEALBOT_OPTIONS_GROUPHEALS_en,["STATE"]=true,["FRAME"]=1}, 
        [5] = {["NAME"]=HEALBOT_OPTIONS_EMERGENCYHEALS_en,["STATE"]=true,["FRAME"]=1}, 
        [6] = {["NAME"]=HEALBOT_OPTIONS_MYTARGET_en,["STATE"]=true,["FRAME"]=1}, 
        [7] = {["NAME"]=HEALBOT_VEHICLE_en,["STATE"]=false,["FRAME"]=6},
        [8] = {["NAME"]=HEALBOT_OPTIONS_PETHEALS_en,["STATE"]=false,["FRAME"]=7},
        [9] = {["NAME"]=HEALBOT_OPTIONS_TARGETHEALS_en,["STATE"]=false,["FRAME"]=8},
       [10] = {["NAME"]=HEALBOT_FOCUS_en,["STATE"]=false,["FRAME"]=9}, 
       [11] = {["NAME"]=HEALBOT_CUSTOM_CASTBY_ENEMY_en,["STATE"]=false,["FRAME"]=10},}
    else
        for id=1,11 do
            if Healbot_Config_Skins.HealGroups[SkinName][id]["NAME"]=="Targets" then
                Healbot_Config_Skins.HealGroups[SkinName][id]["NAME"]=HEALBOT_OPTIONS_TARGETHEALS
                break
            end
            if Healbot_Config_Skins.HealGroups[SkinName][id]["NAME"]=="My Targets" then
                Healbot_Config_Skins.HealGroups[SkinName][id]["NAME"]=HEALBOT_OPTIONS_MYTARGET
                break
            end
        end
        local freeHealGroups={}
        table.insert(freeHealGroups,HEALBOT_OPTIONS_SELFHEALS_en)
        table.insert(freeHealGroups,HEALBOT_OPTIONS_TANKHEALS_en)
        table.insert(freeHealGroups,HEALBOT_CLASSES_HEALERS_en)
        table.insert(freeHealGroups,HEALBOT_OPTIONS_GROUPHEALS_en)
        table.insert(freeHealGroups,HEALBOT_OPTIONS_EMERGENCYHEALS_en)
        table.insert(freeHealGroups,HEALBOT_OPTIONS_MYTARGET_en)
        table.insert(freeHealGroups,HEALBOT_VEHICLE_en)
        table.insert(freeHealGroups,HEALBOT_OPTIONS_PETHEALS_en)
        table.insert(freeHealGroups,HEALBOT_OPTIONS_TARGETHEALS_en)
        table.insert(freeHealGroups,HEALBOT_FOCUS_en)
        table.insert(freeHealGroups,HEALBOT_CUSTOM_CASTBY_ENEMY_en)
        
        for gl=1,11 do
            if not Healbot_Config_Skins.HealGroups[SkinName][gl] then Healbot_Config_Skins.HealGroups[SkinName][gl]={} end
            if Healbot_Config_Skins.HealGroups[SkinName][gl]["NAME"] then
                local mti=0
                for z=1, #freeHealGroups do
                    if Healbot_Config_Skins.HealGroups[SkinName][gl]["NAME"]==freeHealGroups[z] then
                        mti=z
                    end
                end
                if mti>0 then
                    table.remove(freeHealGroups,mti)
                end
            end
        end
        for gl=1,11 do
            if not Healbot_Config_Skins.HealGroups[SkinName][gl]["NAME"] then
                Healbot_Config_Skins.HealGroups[SkinName][gl]["NAME"]=freeHealGroups[1]
                table.remove(freeHealGroups,1)
            end
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
    if not Healbot_Config_Skins.Protection[SkinName] then Healbot_Config_Skins.Protection[SkinName]={} end
    if not Healbot_Config_Skins.Frame[SkinName] then Healbot_Config_Skins.Frame[SkinName]={} end
    if not Healbot_Config_Skins.StickyFrames[SkinName] then Healbot_Config_Skins.StickyFrames[SkinName]={} end
    if not Healbot_Config_Skins.Healing[SkinName] then Healbot_Config_Skins.Healing[SkinName]={} end
    if not Healbot_Config_Skins.General[SkinName] then Healbot_Config_Skins.General[SkinName]={} end
    if not Healbot_Config_Skins.BarSort[SkinName] then Healbot_Config_Skins.BarSort[SkinName]={} end
    if not Healbot_Config_Skins.Chat[SkinName] then Healbot_Config_Skins.Chat[SkinName]={} end
    if not Healbot_Config_Skins.Enemy[SkinName] then Healbot_Config_Skins.Enemy[SkinName]={} end
    if not Healbot_Config_Skins.IncludeGroup[SkinName] then Healbot_Config_Skins.IncludeGroup[SkinName]={} end
    if not Healbot_Config_Skins.BarVisibility[SkinName] then Healbot_Config_Skins.BarVisibility[SkinName]={} end
    if not Healbot_Config_Skins.BarAggro[SkinName] then Healbot_Config_Skins.BarAggro[SkinName]={} end
    if not Healbot_Config_Skins.AuxBar[SkinName] then Healbot_Config_Skins.AuxBar[SkinName]={} end
    if not Healbot_Config_Skins.AuxBarFrame[SkinName] then Healbot_Config_Skins.AuxBarFrame[SkinName]={} end
    for g=1,9 do
        if not Healbot_Config_Skins.AuxBar[SkinName][g] then Healbot_Config_Skins.AuxBar[SkinName][g]={} end
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
        if not Healbot_Config_Skins.RaidIcon[SkinName][gl] then Healbot_Config_Skins.RaidIcon[SkinName][gl]={} end
        if not Healbot_Config_Skins.IconText[SkinName][gl] then Healbot_Config_Skins.IconText[SkinName][gl]={} end
        if not Healbot_Config_Skins.Frame[SkinName][gl] then Healbot_Config_Skins.Frame[SkinName][gl]={} end
        if not Healbot_Config_Skins.StickyFrames[SkinName][gl] then Healbot_Config_Skins.StickyFrames[SkinName][gl]={} end
        if not Healbot_Config_Skins.IncludeGroup[SkinName][gl] then Healbot_Config_Skins.IncludeGroup[SkinName][gl]={} end
        if not Healbot_Config_Skins.BarVisibility[SkinName][gl] then Healbot_Config_Skins.BarVisibility[SkinName][gl]={} end
        if not Healbot_Config_Skins.BarSort[SkinName][gl] then Healbot_Config_Skins.BarSort[SkinName][gl]={} end
        if not Healbot_Config_Skins.BarAggro[SkinName][gl] then Healbot_Config_Skins.BarAggro[SkinName][gl]={} end
        for g=1,9 do
            if not Healbot_Config_Skins.AuxBar[SkinName][g][gl] then Healbot_Config_Skins.AuxBar[SkinName][g][gl]={} end
        end
        if not Healbot_Config_Skins.AuxBarFrame[SkinName][gl] then Healbot_Config_Skins.AuxBarFrame[SkinName][gl]={} end
    end

    for gl=1,10 do
        for g=1,8 do
            if Healbot_Config_Skins.IncludeGroup[SkinName][gl][g]==nil then Healbot_Config_Skins.IncludeGroup[SkinName][gl][g]=true end
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
        if Healbot_Config_Skins.BarAggro[SkinName][gl]["SHOWTEXT"]==nil then 
            if Healbot_Config_Skins.Aggro and Healbot_Config_Skins.Aggro[SkinName] then 
                Healbot_Config_Skins.BarAggro[SkinName][gl]["SHOWTEXT"]=Healbot_Config_Skins.Aggro[SkinName]["SHOWTEXT"] or true
            else
                Healbot_Config_Skins.BarAggro[SkinName][gl]["SHOWTEXT"]=true
            end
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
        if Healbot_Config_Skins.BarAggro[SkinName][gl]["SHOWTEXTPCT"]==nil then 
            if Healbot_Config_Skins.Aggro and Healbot_Config_Skins.Aggro[SkinName] then 
                Healbot_Config_Skins.BarAggro[SkinName][gl]["SHOWTEXTPCT"]=Healbot_Config_Skins.Aggro[SkinName]["SHOWTEXTPCT"] or true
            else
                Healbot_Config_Skins.BarAggro[SkinName][gl]["SHOWTEXTPCT"]=true
            end
        end
        if not Healbot_Config_Skins.BarAggro[SkinName][gl]["ALERT"] then Healbot_Config_Skins.BarAggro[SkinName][gl]["ALERT"]=2 end
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
        if Healbot_Config_Skins.BarVisibility[SkinName][gl]["INCCLASSES"]==nil then Healbot_Config_Skins.BarVisibility[SkinName][gl]["INCCLASSES"]=1 end
        if Healbot_Config_Skins.Frame[SkinName][gl]["TIPLOC"]==nil then Healbot_Config_Skins.Frame[SkinName][gl]["TIPLOC"]=5 end
        if Healbot_Config_Skins.Frame[SkinName][gl]["AUTOCLOSE"]==nil then Healbot_Config_Skins.Frame[SkinName][gl]["AUTOCLOSE"]=false end
        if Healbot_Config_Skins.Frame[SkinName][gl]["OPENSOUND"]==nil then Healbot_Config_Skins.Frame[SkinName][gl]["OPENSOUND"]=false end
        if Healbot_Config_Skins.Frame[SkinName][gl]["LOCKED"]==nil then Healbot_Config_Skins.Frame[SkinName][gl]["LOCKED"]=false end
        if Healbot_Config_Skins.Frame[SkinName][gl]["SCALE"]==nil then Healbot_Config_Skins.Frame[SkinName][gl]["SCALE"]=1 end
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
        if Healbot_Config_Skins.IconText[SkinName][gl]["DURTHRH"]==nil then Healbot_Config_Skins.IconText[SkinName][gl]["DURTHRH"]=9 end
        if Healbot_Config_Skins.IconText[SkinName][gl]["DURWARN"]==nil then Healbot_Config_Skins.IconText[SkinName][gl]["DURWARN"]=3 end
        if Healbot_Config_Skins.IconText[SkinName][gl]["SCNT"]==nil then Healbot_Config_Skins.IconText[SkinName][gl]["SCNT"]=true end
        if Healbot_Config_Skins.IconText[SkinName][gl]["SSCNT"]==nil then Healbot_Config_Skins.IconText[SkinName][gl]["SSCNT"]=false end
        if Healbot_Config_Skins.IconText[SkinName][gl]["SDUR"]==nil then Healbot_Config_Skins.IconText[SkinName][gl]["SDUR"]=true end
        if Healbot_Config_Skins.IconText[SkinName][gl]["SSDUR"]==nil then Healbot_Config_Skins.IconText[SkinName][gl]["SSDUR"]=true end
        if Healbot_Config_Skins.IconText[SkinName][gl]["FONT"]==nil then Healbot_Config_Skins.IconText[SkinName][gl]["FONT"]=HealBot_Default_Font end
        if Healbot_Config_Skins.IconText[SkinName][gl]["OUTLINE"]==nil then Healbot_Config_Skins.IconText[SkinName][gl]["OUTLINE"]=2 end
        if Healbot_Config_Skins.RaidIcon[SkinName][gl]["SHOW"]==nil then Healbot_Config_Skins.RaidIcon[SkinName][gl]["SHOW"]=true end
        if Healbot_Config_Skins.RaidIcon[SkinName][gl]["STAR"]==nil then Healbot_Config_Skins.RaidIcon[SkinName][gl]["STAR"]=true end
        if Healbot_Config_Skins.RaidIcon[SkinName][gl]["CIRCLE"]==nil then Healbot_Config_Skins.RaidIcon[SkinName][gl]["CIRCLE"]=true end
        if Healbot_Config_Skins.RaidIcon[SkinName][gl]["DIAMOND"]==nil then Healbot_Config_Skins.RaidIcon[SkinName][gl]["DIAMOND"]=true end
        if Healbot_Config_Skins.RaidIcon[SkinName][gl]["TRIANGLE"]==nil then Healbot_Config_Skins.RaidIcon[SkinName][gl]["TRIANGLE"]=true end
        if Healbot_Config_Skins.RaidIcon[SkinName][gl]["MOON"]==nil then Healbot_Config_Skins.RaidIcon[SkinName][gl]["MOON"]=true end
        if Healbot_Config_Skins.RaidIcon[SkinName][gl]["SQUARE"]==nil then Healbot_Config_Skins.RaidIcon[SkinName][gl]["SQUARE"]=true end
        if Healbot_Config_Skins.RaidIcon[SkinName][gl]["CROSS"]==nil then Healbot_Config_Skins.RaidIcon[SkinName][gl]["CROSS"]=true end
        if Healbot_Config_Skins.RaidIcon[SkinName][gl]["SKULL"]==nil then Healbot_Config_Skins.RaidIcon[SkinName][gl]["SKULL"]=true end
        if Healbot_Config_Skins.Icons[SkinName][gl]["ONBAR"]==nil then Healbot_Config_Skins.Icons[SkinName][gl]["ONBAR"]=1 end
        if Healbot_Config_Skins.Icons[SkinName][gl]["DOUBLE"]==nil then Healbot_Config_Skins.Icons[SkinName][gl]["DOUBLE"]=false end
        if Healbot_Config_Skins.Icons[SkinName][gl]["SHOWDEBUFF"]==nil then Healbot_Config_Skins.Icons[SkinName][gl]["SHOWDEBUFF"]=true end
        if Healbot_Config_Skins.Icons[SkinName][gl]["SHOWRC"]==nil then Healbot_Config_Skins.Icons[SkinName][gl]["SHOWRC"]=true end
        if Healbot_Config_Skins.Icons[SkinName][gl]["SHOWDIR"]==nil then Healbot_Config_Skins.Icons[SkinName][gl]["SHOWDIR"]=false end
        if Healbot_Config_Skins.Icons[SkinName][gl]["SHOWDIRMOUSE"]==nil then Healbot_Config_Skins.Icons[SkinName][gl]["SHOWDIRMOUSE"]=false end
        if Healbot_Config_Skins.Icons[SkinName][gl]["SCALE"]==nil then Healbot_Config_Skins.Icons[SkinName][gl]["SCALE"]=0.7 end
        if Healbot_Config_Skins.Icons[SkinName][gl]["DSCALE"]==nil then 
            Healbot_Config_Skins.Icons[SkinName][gl]["DSCALE"]=Healbot_Config_Skins.Icons[SkinName][gl]["SCALE"]
        end
        if Healbot_Config_Skins.Icons[SkinName][gl]["I15EN"]==nil then Healbot_Config_Skins.Icons[SkinName][gl]["I15EN"]=true end
        if Healbot_Config_Skins.Icons[SkinName][gl]["SHOWBUFF"]==nil then Healbot_Config_Skins.Icons[SkinName][gl]["SHOWBUFF"]=true end
        if Healbot_Config_Skins.Icons[SkinName][gl]["POSITION"]==nil then Healbot_Config_Skins.Icons[SkinName][gl]["POSITION"]=2 end
        if Healbot_Config_Skins.Icons[SkinName][gl]["FADE"]==nil then Healbot_Config_Skins.Icons[SkinName][gl]["FADE"]=false end
        if not Healbot_Config_Skins.Icons[SkinName][gl]["FADESECS"] then Healbot_Config_Skins.Icons[SkinName][gl]["FADESECS"]=15 end
        if Healbot_Config_Skins.Icons[SkinName][gl]["MAXDICONS"]==nil then Healbot_Config_Skins.Icons[SkinName][gl]["MAXDICONS"]=3 end
        if Healbot_Config_Skins.Icons[SkinName][gl]["MAXBICONS"]==nil then Healbot_Config_Skins.Icons[SkinName][gl]["MAXBICONS"]=8 end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["NCR"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["NCR"]=1 end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["NCG"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["NCG"]=1 end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["NCB"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["NCB"]=0 end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["NCA"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["NCA"]=0.95 end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["NCDA"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["NCDA"]=0.5 end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["NAME"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["NAME"]=2 end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["HCR"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["HCR"]=1 end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["HCG"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["HCG"]=1 end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["HCB"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["HCB"]=0 end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["HCA"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["HCA"]=0.95 end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["HCDA"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["HCDA"]=0.5 end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["HLTH"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["HLTH"]=2 end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["NDEBUFF"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["NDEBUFF"]=false end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["HDEBUFF"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["HDEBUFF"]=false end
        if Healbot_Config_Skins.BarText[SkinName][gl]["FONT"]==nil then Healbot_Config_Skins.BarText[SkinName][gl]["FONT"]=HealBot_Default_Font end
        if Healbot_Config_Skins.BarText[SkinName][gl]["HFONT"]==nil then Healbot_Config_Skins.BarText[SkinName][gl]["HFONT"]=HealBot_Default_Font end
        if Healbot_Config_Skins.BarText[SkinName][gl]["HEIGHT"]==nil then Healbot_Config_Skins.BarText[SkinName][gl]["HEIGHT"]=10 end
        if Healbot_Config_Skins.BarText[SkinName][gl]["HHEIGHT"]==nil then Healbot_Config_Skins.BarText[SkinName][gl]["HHEIGHT"]=10 end
        if Healbot_Config_Skins.BarText[SkinName][gl]["CLASSTYPE"]==nil then Healbot_Config_Skins.BarText[SkinName][gl]["CLASSTYPE"]=1 end
        if Healbot_Config_Skins.BarText[SkinName][gl]["SHOWROLE"]==nil then Healbot_Config_Skins.BarText[SkinName][gl]["SHOWROLE"]=true end
        if Healbot_Config_Skins.BarText[SkinName][gl]["CLASSONBAR"]==nil then Healbot_Config_Skins.BarText[SkinName][gl]["CLASSONBAR"]=false end
        if Healbot_Config_Skins.BarText[SkinName][gl]["OFFSET"]==nil then Healbot_Config_Skins.BarText[SkinName][gl]["OFFSET"]=0 end
        if Healbot_Config_Skins.BarText[SkinName][gl]["HOFFSET"]==nil then Healbot_Config_Skins.BarText[SkinName][gl]["HOFFSET"]=0 end
        if Healbot_Config_Skins.BarText[SkinName][gl]["NAMEONBAR"]==nil then Healbot_Config_Skins.BarText[SkinName][gl]["NAMEONBAR"]=true end
        if Healbot_Config_Skins.BarText[SkinName][gl]["HLTHONBAR"]==nil then Healbot_Config_Skins.BarText[SkinName][gl]["HLTHONBAR"]=true end
        if Healbot_Config_Skins.BarText[SkinName][gl]["IGNOREONFULL"]==nil then Healbot_Config_Skins.BarText[SkinName][gl]["IGNOREONFULL"]=true end
        if Healbot_Config_Skins.BarText[SkinName][gl]["ALIGN"]==nil then Healbot_Config_Skins.BarText[SkinName][gl]["ALIGN"]=2 end
        if Healbot_Config_Skins.BarText[SkinName][gl]["HALIGN"]==nil then Healbot_Config_Skins.BarText[SkinName][gl]["HALIGN"]=2 end
        if Healbot_Config_Skins.BarText[SkinName][gl]["HOFFSET2"]==nil then Healbot_Config_Skins.BarText[SkinName][gl]["HOFFSET2"]=0 end
        if Healbot_Config_Skins.BarText[SkinName][gl]["INCHEALS"]==nil then Healbot_Config_Skins.BarText[SkinName][gl]["INCHEALS"]=2 end
        if Healbot_Config_Skins.BarText[SkinName][gl]["INCABSORBS"]==nil then Healbot_Config_Skins.BarText[SkinName][gl]["INCABSORBS"]=1 end
        if Healbot_Config_Skins.BarText[SkinName][gl]["OVERHEAL"]==nil then Healbot_Config_Skins.BarText[SkinName][gl]["OVERHEAL"]=1 end
        if Healbot_Config_Skins.BarText[SkinName][gl]["HLTHTXTANCHOR"]==nil then Healbot_Config_Skins.BarText[SkinName][gl]["HLTHTXTANCHOR"]=1 end
        if Healbot_Config_Skins.BarText[SkinName][gl]["NUMFORMAT1"]==nil then Healbot_Config_Skins.BarText[SkinName][gl]["NUMFORMAT1"]=1 end
        if Healbot_Config_Skins.BarText[SkinName][gl]["NUMFORMAT2"]==nil then Healbot_Config_Skins.BarText[SkinName][gl]["NUMFORMAT2"]=1 end
        if Healbot_Config_Skins.BarText[SkinName][gl]["OUTLINE"]==nil then Healbot_Config_Skins.BarText[SkinName][gl]["OUTLINE"]=1 end
        if Healbot_Config_Skins.BarText[SkinName][gl]["HOUTLINE"]==nil then Healbot_Config_Skins.BarText[SkinName][gl]["HOUTLINE"]=1 end
        if Healbot_Config_Skins.BarText[SkinName][gl]["HLTHTYPE"]==nil then Healbot_Config_Skins.BarText[SkinName][gl]["HLTHTYPE"]=1 end
        if Healbot_Config_Skins.BarText[SkinName][gl]["MAXCHARS"]==nil then Healbot_Config_Skins.BarText[SkinName][gl]["MAXCHARS"]=0 end
        if Healbot_Config_Skins.BarText[SkinName][gl]["HMAXCHARS"]==nil then Healbot_Config_Skins.BarText[SkinName][gl]["HMAXCHARS"]=0 end
        if Healbot_Config_Skins.BarText[SkinName][gl]["TAGDC"]==nil then Healbot_Config_Skins.BarText[SkinName][gl]["TAGDC"]=HEALBOT_DISCONNECTED_TAG end
        if Healbot_Config_Skins.BarText[SkinName][gl]["TAGRIP"]==nil then Healbot_Config_Skins.BarText[SkinName][gl]["TAGRIP"]=HEALBOT_DEAD_TAG end
        if Healbot_Config_Skins.BarText[SkinName][gl]["TAGOOR"]==nil then Healbot_Config_Skins.BarText[SkinName][gl]["TAGOOR"]=HEALBOT_OUTOFRANGE_TAG end
        if Healbot_Config_Skins.BarText[SkinName][gl]["TAGR"]==nil then Healbot_Config_Skins.BarText[SkinName][gl]["TAGR"]=HEALBOT_RESERVED_TAG end
        if Healbot_Config_Skins.BarIACol[SkinName][gl]["IC"]==nil then Healbot_Config_Skins.BarIACol[SkinName][gl]["IC"]=3 end
        if Healbot_Config_Skins.BarIACol[SkinName][gl]["IR"]==nil then Healbot_Config_Skins.BarIACol[SkinName][gl]["IR"]=0.2 end
        if Healbot_Config_Skins.BarIACol[SkinName][gl]["IG"]==nil then Healbot_Config_Skins.BarIACol[SkinName][gl]["IG"]=1 end
        if Healbot_Config_Skins.BarIACol[SkinName][gl]["IB"]==nil then Healbot_Config_Skins.BarIACol[SkinName][gl]["IB"]=0.2 end
        if Healbot_Config_Skins.BarIACol[SkinName][gl]["IA"]==nil then Healbot_Config_Skins.BarIACol[SkinName][gl]["IA"]=0.82 end
        if Healbot_Config_Skins.BarIACol[SkinName][gl]["AC"]==nil then Healbot_Config_Skins.BarIACol[SkinName][gl]["AC"]=3 end
        if Healbot_Config_Skins.BarIACol[SkinName][gl]["AR"]==nil then Healbot_Config_Skins.BarIACol[SkinName][gl]["AR"]=1 end
        if Healbot_Config_Skins.BarIACol[SkinName][gl]["AG"]==nil then Healbot_Config_Skins.BarIACol[SkinName][gl]["AG"]=1 end
        if Healbot_Config_Skins.BarIACol[SkinName][gl]["AB"]==nil then Healbot_Config_Skins.BarIACol[SkinName][gl]["AB"]=1 end
        if Healbot_Config_Skins.BarIACol[SkinName][gl]["AA"]==nil then Healbot_Config_Skins.BarIACol[SkinName][gl]["AA"]=0.78 end
        if Healbot_Config_Skins.BarCol[SkinName][gl]["HLTH"]==nil then Healbot_Config_Skins.BarCol[SkinName][gl]["HLTH"]=1 end
        if Healbot_Config_Skins.BarCol[SkinName][gl]["BACK"]==nil then Healbot_Config_Skins.BarCol[SkinName][gl]["BACK"]=1 end
        if Healbot_Config_Skins.BarCol[SkinName][gl]["HR"]==nil then Healbot_Config_Skins.BarCol[SkinName][gl]["HR"]=0.4 end
        if Healbot_Config_Skins.BarCol[SkinName][gl]["HG"]==nil then Healbot_Config_Skins.BarCol[SkinName][gl]["HG"]=0.7 end
        if Healbot_Config_Skins.BarCol[SkinName][gl]["HB"]==nil then Healbot_Config_Skins.BarCol[SkinName][gl]["HB"]=0.7 end
        if Healbot_Config_Skins.BarCol[SkinName][gl]["HA"]==nil then Healbot_Config_Skins.BarCol[SkinName][gl]["HA"]=1 end
        if Healbot_Config_Skins.BarCol[SkinName][gl]["ORA"]==nil then Healbot_Config_Skins.BarCol[SkinName][gl]["ORA"]=0.4 end
        if Healbot_Config_Skins.BarCol[SkinName][gl]["DISA"]==nil then Healbot_Config_Skins.BarCol[SkinName][gl]["DISA"]=0.1 end
        if Healbot_Config_Skins.BarCol[SkinName][gl]["BR"]==nil then Healbot_Config_Skins.BarCol[SkinName][gl]["BR"]=0.4 end
        if Healbot_Config_Skins.BarCol[SkinName][gl]["BG"]==nil then Healbot_Config_Skins.BarCol[SkinName][gl]["BG"]=0.7 end
        if Healbot_Config_Skins.BarCol[SkinName][gl]["BB"]==nil then Healbot_Config_Skins.BarCol[SkinName][gl]["BB"]=0.7 end
        if Healbot_Config_Skins.BarCol[SkinName][gl]["BA"]==nil then Healbot_Config_Skins.BarCol[SkinName][gl]["BA"]=0 end
        if Healbot_Config_Skins.BarCol[SkinName][gl]["BOUT"]==nil then Healbot_Config_Skins.BarCol[SkinName][gl]["BOUT"]=1 end
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
        if Healbot_Config_Skins.HealBar[SkinName][gl]["GRPCOLS"]==nil then Healbot_Config_Skins.HealBar[SkinName][gl]["GRPCOLS"]=false end
        if Healbot_Config_Skins.HealBar[SkinName][gl]["POWERCNT"]==nil then Healbot_Config_Skins.HealBar[SkinName][gl]["POWERCNT"]=true end
        if Healbot_Config_Skins.HealBar[SkinName][gl]["TEXTURE"]==nil then Healbot_Config_Skins.HealBar[SkinName][gl]["TEXTURE"]=HealBot_Default_Textures[8].name end
        if Healbot_Config_Skins.HealBar[SkinName][gl]["TEXTURE"]=="Empty" then Healbot_Config_Skins.HealBar[SkinName][gl]["TEXTURE"]="Smooth" end
        if Healbot_Config_Skins.HealBar[SkinName][gl]["HEIGHT"]==nil then Healbot_Config_Skins.HealBar[SkinName][gl]["HEIGHT"]=25 end
        if Healbot_Config_Skins.HealBar[SkinName][gl]["WIDTH"]==nil then Healbot_Config_Skins.HealBar[SkinName][gl]["WIDTH"]=144 end
        if Healbot_Config_Skins.HealBar[SkinName][gl]["NUMCOLS"]==nil then Healbot_Config_Skins.HealBar[SkinName][gl]["NUMCOLS"]=2 end
        if Healbot_Config_Skins.HealBar[SkinName][gl]["RMARGIN"]==nil then Healbot_Config_Skins.HealBar[SkinName][gl]["RMARGIN"]=1 end
        if Healbot_Config_Skins.HealBar[SkinName][gl]["OFIX"]==nil then Healbot_Config_Skins.HealBar[SkinName][gl]["OFIX"]=1 end
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
            if not Healbot_Config_Skins.AuxBar[SkinName][g][gl]["OTYPE"] then Healbot_Config_Skins.AuxBar[SkinName][g][gl]["OTYPE"]=1 end
            if Healbot_Config_Skins.AuxBar[SkinName][g][gl]["A"] then Healbot_Config_Skins.AuxBar[SkinName][g][gl]["A"]=nil end
        end
        if not Healbot_Config_Skins.AuxBarFrame[SkinName][gl]["OVERLAP"] then Healbot_Config_Skins.AuxBarFrame[SkinName][gl]["OVERLAP"]=1 end
        if not Healbot_Config_Skins.AuxBarFrame[SkinName][gl]["OFREQ"] then Healbot_Config_Skins.AuxBarFrame[SkinName][gl]["OFREQ"]=0.07 end
        if not Healbot_Config_Skins.AuxBarFrame[SkinName][gl]["OMIN"] then Healbot_Config_Skins.AuxBarFrame[SkinName][gl]["OMIN"]=0.1 end
        if not Healbot_Config_Skins.AuxBarFrame[SkinName][gl]["OMAX"] then Healbot_Config_Skins.AuxBarFrame[SkinName][gl]["OMAX"]=0.95 end
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
        if Healbot_Config_Skins.IconText[SkinName][gl]["HEIGHT"]==nil then 
            if Healbot_Config_Skins.IconText[SkinName][gl]["SCALE"] then
                local iScale=Healbot_Config_Skins.HealBar[SkinName][gl]["HEIGHT"]*(Healbot_Config_Skins.Icons[SkinName][gl]["SCALE"]*0.7)
                Healbot_Config_Skins.IconText[SkinName][gl]["HEIGHT"]=floor(iScale*Healbot_Config_Skins.IconText[SkinName][gl]["SCALE"])
                Healbot_Config_Skins.IconText[SkinName][gl]["SCALE"]=nil
                if Healbot_Config_Skins.IconText[SkinName][gl]["HEIGHT"]>12 then Healbot_Config_Skins.IconText[SkinName][gl]["HEIGHT"]=12 end
                if Healbot_Config_Skins.IconText[SkinName][gl]["HEIGHT"]<8 then Healbot_Config_Skins.IconText[SkinName][gl]["HEIGHT"]=8 end
            else
                Healbot_Config_Skins.IconText[SkinName][gl]["HEIGHT"]=10
            end
        end        
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
    end

    if Healbot_Config_Skins.Healing[SkinName]["ALERTIC"] then Healbot_Config_Skins.Healing[SkinName]["ALERTIC"]=nil end
    if Healbot_Config_Skins.Healing[SkinName]["ALERTOC"] then Healbot_Config_Skins.Healing[SkinName]["ALERTOC"]=nil end
    if Healbot_Config_Skins.Sort then Healbot_Config_Skins.Sort=nil end
    if Healbot_Config_Skins.Aggro then Healbot_Config_Skins.Aggro=nil end
    if Healbot_Config_Skins.Highlight then Healbot_Config_Skins.Highlight=nil end
    
    if Healbot_Config_Skins.Author[SkinName]==nil then Healbot_Config_Skins.Author[SkinName] = HEALBOT_WORDS_UNKNOWN end
    if Healbot_Config_Skins.Protection[SkinName]["CRASH"]==nil then Healbot_Config_Skins.Protection[SkinName]["CRASH"]=false end
    if Healbot_Config_Skins.Protection[SkinName]["GENERALMACRO"]==nil then Healbot_Config_Skins.Protection[SkinName]["GENERALMACRO"]=false end
    if Healbot_Config_Skins.Protection[SkinName]["COMBAT"]==nil then Healbot_Config_Skins.Protection[SkinName]["COMBAT"]=false end
    if Healbot_Config_Skins.Protection[SkinName]["COMBATPARTY"]==nil then Healbot_Config_Skins.Protection[SkinName]["COMBATPARTY"]=true end
    if Healbot_Config_Skins.Protection[SkinName]["COMBATRAID"]==nil then Healbot_Config_Skins.Protection[SkinName]["COMBATRAID"]=true end
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
    if Healbot_Config_Skins.General[SkinName]["HIDEPTF"]==nil then Healbot_Config_Skins.General[SkinName]["HIDEPTF"]=false end
    if Healbot_Config_Skins.General[SkinName]["HIDEBOSSF"]==nil then Healbot_Config_Skins.General[SkinName]["HIDEBOSSF"]=false end
    if Healbot_Config_Skins.General[SkinName]["HIDERAIDF"]==nil then Healbot_Config_Skins.General[SkinName]["HIDERAIDF"]=true end
    if Healbot_Config_Skins.General[SkinName]["FLUIDBARS"]==nil then Healbot_Config_Skins.General[SkinName]["FLUIDBARS"]=false end
    if Healbot_Config_Skins.General[SkinName]["FLUIDFREQ"]==nil then Healbot_Config_Skins.General[SkinName]["FLUIDFREQ"]=8 end
    if Healbot_Config_Skins.General[SkinName]["STICKYFRAME"]==nil then Healbot_Config_Skins.General[SkinName]["STICKYFRAME"]=false end
    if Healbot_Config_Skins.General[SkinName]["STICKYSENSITIVITY"]==nil then Healbot_Config_Skins.General[SkinName]["STICKYSENSITIVITY"]=30 end
    if Healbot_Config_Skins.Chat[SkinName]["NOTIFY"]==nil then Healbot_Config_Skins.Chat[SkinName]["NOTIFY"]=1 end
    if Healbot_Config_Skins.Chat[SkinName]["MSG"]==nil then Healbot_Config_Skins.Chat[SkinName]["MSG"]=HEALBOT_NOTIFYOTHERMSG end
    if Healbot_Config_Skins.Chat[SkinName]["RESONLY"]==nil then Healbot_Config_Skins.Chat[SkinName]["RESONLY"]=true end
    if Healbot_Config_Skins.Chat[SkinName]["EOCOOM"]==nil then Healbot_Config_Skins.Chat[SkinName]["EOCOOM"]=false end
    if not Healbot_Config_Skins.Chat[SkinName]["EOCOOMV"] then Healbot_Config_Skins.Chat[SkinName]["EOCOOMV"]=20 end
    if Healbot_Config_Skins.DuplicateBars[SkinName]==nil then Healbot_Config_Skins.DuplicateBars[SkinName]=false end
    if Healbot_Config_Skins.Enemy[SkinName]["INCSELF"]==nil then Healbot_Config_Skins.Enemy[SkinName]["INCSELF"]=false end
    if Healbot_Config_Skins.Enemy[SkinName]["INCTANKS"]==nil then Healbot_Config_Skins.Enemy[SkinName]["INCTANKS"]=true end
    if Healbot_Config_Skins.Enemy[SkinName]["INCMYTAR"]==nil then Healbot_Config_Skins.Enemy[SkinName]["INCMYTAR"]=false end
    if Healbot_Config_Skins.Enemy[SkinName]["INCARENA"]==nil then Healbot_Config_Skins.Enemy[SkinName]["INCARENA"]=true end
    if Healbot_Config_Skins.Enemy[SkinName]["INCARENAPETS"]==nil then Healbot_Config_Skins.Enemy[SkinName]["INCARENAPETS"]=false end
    if Healbot_Config_Skins.Enemy[SkinName]["NUMBOSS"]==nil then Healbot_Config_Skins.Enemy[SkinName]["NUMBOSS"]=2 end
    if Healbot_Config_Skins.Enemy[SkinName]["HIDE"]==nil then Healbot_Config_Skins.Enemy[SkinName]["HIDE"]=true end
    if Healbot_Config_Skins.Enemy[SkinName]["EXISTSHOWPTAR"]==nil then Healbot_Config_Skins.Enemy[SkinName]["EXISTSHOWPTAR"]=false end
    if Healbot_Config_Skins.Enemy[SkinName]["EXISTSHOWBOSS"]==nil then Healbot_Config_Skins.Enemy[SkinName]["EXISTSHOWBOSS"]=true end
    if Healbot_Config_Skins.Enemy[SkinName]["EXISTSHOWARENA"]==nil then Healbot_Config_Skins.Enemy[SkinName]["EXISTSHOWARENA"]=true end
    if Healbot_Config_Skins.Enemy[SkinName]["ENEMYTARGET"]==nil then Healbot_Config_Skins.Enemy[SkinName]["ENEMYTARGET"]=false end
    if Healbot_Config_Skins.Enemy[SkinName]["ENEMYTARGETSIZE"]==nil then Healbot_Config_Skins.Enemy[SkinName]["ENEMYTARGETSIZE"]=40 end
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
    Healbot_Config_Skins.HealGroups[SkinName][10]["FRAME"]=9
    Healbot_Config_Skins.HealGroups[SkinName][9]["FRAME"]=8
    if Healbot_Config_Skins.HealGroups[SkinName][8]["FRAME"]>7 or Healbot_Config_Skins.HealGroups[SkinName][8]["FRAME"]==6 then
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
    --HealBot_setCall("HealBot_Skins_Check_Skin")
end
