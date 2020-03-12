local LSM = HealBot_Libs_LSM() --LibStub("LibSharedMedia-3.0")
--local vResetSkinPrevSkin=""
local frameScale = 1
local b2Size = 0
local abSize = 2
local bheight= 20
local bWidth = 120
local EnemySizeMod,EnemyTargetBarSize=2,40
local bOutline = 1
local btextheight,btextheight2=10,10
local btextoutline,btextoutline2=1,1
local b,bar,bar2,bar3,bar4,icon,txt,icon17,pIcon,expire,count=nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil
local icon1,expire1,count1,icon51,expire51,count51=nil,nil,nil,nil,nil,nil
local barScale,h,hwidth,hheight,iScale,diScale,itScale,x,hcpct,bar5,bar6,barDir=nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil
local abtSize = {[0]=1,[1]=1,[2]=1,[3]=2,[4]=2,[5]=2,[6]=3,[7]=3,[8]=3,[9]=3,[10]=4,[11]=4,[12]=4,[13]=4,[14]=4,[15]=5}


local tBarsConcat={}
local tabconcat=table.concat
local function HealBot_Skins_Concat(elements)
    return tabconcat(tBarsConcat,"",1,elements)
end

function HealBot_Skins_AdjustBarWidth(button)
    EnemyTargetBarSize=(Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["ENEMYTARGETSIZE"]/100)
    if HealBot_Panel_isSpecialUnit(button.unit)==1 then
        EnemySizeMod=1-(Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][button.frame]["CMARGIN"]/100)
        bWidth=bWidth*(EnemySizeMod-EnemyTargetBarSize)
        if Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["DOUBLEWIDTH"] then bWidth=bWidth*2 end
        HealBot_Text_setEnemySizeWidth("EnemySizeWidth1", bWidth)
    else
        bWidth=bWidth*EnemyTargetBarSize
        if Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["DOUBLEWIDTH"] then bWidth=bWidth*2 end
        HealBot_Text_setEnemySizeWidth("EnemySizeWidth2", bWidth)
    end
    
end

function HealBot_Skins_ResetSkinWidth(button)
    bWidth = ceil(Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][button.frame]["WIDTH"]*frameScale);
    bOutline = ceil(Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["BOUT"]*frameScale);
    if HealBot_Panel_isSpecialUnit(button.unit)>0 then
        HealBot_Skins_AdjustBarWidth(button)
    end
    tBarsConcat[1]="HealBot_Action_HealUnit"
    tBarsConcat[2]=button.id
    tBarsConcat[3]="Bar"
    bar = _G[HealBot_Skins_Concat(3)]
    tBarsConcat[3]="Bar2"
    bar2 = _G[HealBot_Skins_Concat(3)]
    tBarsConcat[3]="Bar3"
    bar3 = _G[HealBot_Skins_Concat(3)]
    tBarsConcat[3]="Bar4"
    bar4 = _G[HealBot_Skins_Concat(3)]
    tBarsConcat[3]="Bar5"
    bar5 = _G[HealBot_Skins_Concat(3)]
    tBarsConcat[3]="Bar6"
    bar6 = _G[HealBot_Skins_Concat(3)]
    tBarsConcat[3]="BarDir"
    barDir = _G[HealBot_Skins_Concat(3)]
    bar:SetWidth(bWidth)
    bar5:SetWidth(bWidth+(bOutline*2))
    bar2:SetWidth(bWidth)
    bar6:SetWidth(bWidth)
    barDir:SetWidth(bWidth)
    button:SetWidth(bWidth)
end

function HealBot_Skins_ResetSkin(barType,button,numcols)
    if button and button.frame then 
        frameScale = Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][button.frame]["SCALE"]
        b2Size = ceil(Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][button.frame]["POWERSIZE"]*frameScale)
        abSize = ceil(Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][button.frame]["AGGROSIZE"]*frameScale)
        bheight= ceil(Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][button.frame]["HEIGHT"]*frameScale);
        bWidth = ceil(Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][button.frame]["WIDTH"]*frameScale);
        bOutline = ceil(Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["BOUT"]*frameScale);
        btextheight=ceil(Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["HEIGHT"]*frameScale);
        btextheight2=ceil(Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["HHEIGHT"]*frameScale)
        btextoutline=Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["OUTLINE"];
        btextoutline2=Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["HOUTLINE"]
        if HealBot_Panel_isSpecialUnit(button.unit)>0 then
            HealBot_Skins_AdjustBarWidth(button)
        end
    end
  
    if barType=="bar" then
        b=button;
        if Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][b.frame]["SHOW"]==false and 
           Healbot_Config_Skins.BarHighlight[Healbot_Config_Skins.Current_Skin][b.frame]["CBAR"]==false and
           Healbot_Config_Skins.BarHighlight[Healbot_Config_Skins.Current_Skin][b.frame]["TBAR"]==false then 
            abSize=0 
        end
        tBarsConcat[1]="HealBot_Action_HealUnit"
        tBarsConcat[2]=b.id
        tBarsConcat[3]="Bar"
        bar = _G[HealBot_Skins_Concat(3)]
        tBarsConcat[3]="Bar2"
        bar2 = _G[HealBot_Skins_Concat(3)]
        tBarsConcat[3]="Bar3"
        bar3 = _G[HealBot_Skins_Concat(3)]
        tBarsConcat[3]="Bar4"
        bar4 = _G[HealBot_Skins_Concat(3)]
        tBarsConcat[3]="Bar5"
        bar5 = _G[HealBot_Skins_Concat(3)]
        tBarsConcat[3]="Bar6"
        bar6 = _G[HealBot_Skins_Concat(3)]
        tBarsConcat[3]="BarDir"
        barDir = _G[HealBot_Skins_Concat(3)]
        tBarsConcat[1]=bar:GetName()
        tBarsConcat[2]="_text"
        bar.txt = _G[HealBot_Skins_Concat(2)];
        tBarsConcat[2]="_text2"
        bar.txt2 = _G[HealBot_Skins_Concat(2)];
        tBarsConcat[1]=bar3:GetName()
        tBarsConcat[2]="Bar3Txt"
        bar3.txt = _G[HealBot_Skins_Concat(2)];
        bar:SetHeight(bheight);
        bar:SetWidth(bWidth)
        bar5:SetHeight(bheight+b2Size+(bOutline*2));
        bar5:SetWidth(bWidth+(bOutline*2))
        bar2:SetHeight(bheight);
        bar2:SetWidth(bWidth)
        bar6:SetHeight(bheight);
        bar6:SetWidth(bWidth)
        barDir:SetHeight(bheight);
        barDir:SetWidth(bWidth)
        if Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][b.frame]["OFIX"]==1 then
            bar:SetOrientation("HORIZONTAL");
            bar2:SetOrientation("HORIZONTAL");
            bar3:SetOrientation("HORIZONTAL");
            bar5:SetOrientation("HORIZONTAL");
            bar6:SetOrientation("HORIZONTAL");
        else
            bar:SetOrientation("VERTICAL");
            bar2:SetOrientation("VERTICAL");
            bar3:SetOrientation("VERTICAL");
            bar5:SetOrientation("VERTICAL");
            bar6:SetOrientation("VERTICAL");
        end
        bar5:SetPoint("TOPLEFT",bar,"TOPLEFT",-bOutline,bOutline);
        tBarsConcat[1]="f"
        tBarsConcat[2]=b.frame
        tBarsConcat[3]="_HealBot_Action"
        local gaf = _G[HealBot_Skins_Concat(3)]
        b:SetFrameLevel(gaf:GetFrameLevel()+ 1);    
        bar5:SetFrameLevel(b:GetFrameLevel()+ 1);      -- Background
        bar4:SetFrameLevel(bar5:GetFrameLevel()+ 1);   -- Aggro
        bar6:SetFrameLevel(bar4:GetFrameLevel()+ 1);   -- Absorbs
        bar2:SetFrameLevel(bar6:GetFrameLevel()+ 1);   -- Incoming Heal
        bar:SetFrameLevel(bar2:GetFrameLevel()+ 1);    -- Health
		bar3:SetFrameLevel(bar:GetFrameLevel()+ 1);    -- Mana
        barDir:SetFrameLevel(bar:GetFrameLevel()+ 1); -- Direction Arrow
     --   bar:SetTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][b.frame]["TEXTURE"]),false);
        bar:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][b.frame]["TEXTURE"]));
        bar:GetStatusBarTexture():SetHorizTile(false)
        bar.txt:SetFont(LSM:Fetch('font',Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["FONT"]),
                        btextheight,
                        HealBot_Font_Outline[btextoutline]);
        bar.txt2:SetFont(LSM:Fetch('font',Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["HFONT"]),
                        btextheight2,
                        HealBot_Font_Outline[btextoutline2]);
        bar3.txt:SetFont(LSM:Fetch('font',Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["FONT"]),
                        btextheight,
                        HealBot_Font_Outline[btextoutline]);
        bar.txt:ClearAllPoints();
        bar.txt2:ClearAllPoints();
        bar5:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][b.frame]["TEXTURE"]));
        bar5:GetStatusBarTexture():SetHorizTile(false)
        bar6:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][b.frame]["TEXTURE"]));
        bar6:GetStatusBarTexture():SetHorizTile(false)
        if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["ALIGN"]==1 then
            bar.txt:SetPoint("LEFT",bar,"LEFT",4,5+Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["OFFSET"])
        elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["ALIGN"]==2 then
            bar.txt:SetPoint("CENTER",bar,"CENTER",0,5+Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["OFFSET"])
        else
            bar.txt:SetPoint("RIGHT",bar,"RIGHT",-4,5+Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["OFFSET"])
        end
        if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["HALIGN"]==1 then
            bar.txt2:SetPoint("LEFT",bar,"LEFT",4,-7+Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["HOFFSET"])
        elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["HALIGN"]==2 then
            bar.txt2:SetPoint("CENTER",bar,"CENTER",0,-7+Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["HOFFSET"])
        else
            bar.txt2:SetPoint("RIGHT",bar,"RIGHT",-4,-7+Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["HOFFSET"])
        end
        bar2:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][b.frame]["TEXTURE"]));
        bar2:GetStatusBarTexture():SetHorizTile(false)
        if b2Size==0 then
            bar3:SetHeight(1)
        else
            bar3:SetHeight(b2Size);
        end
        bar3:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][b.frame]["TEXTURE"]));
        bar3:GetStatusBarTexture():SetHorizTile(false)
        bar4:ClearAllPoints();
        bar4:SetPoint("TOPLEFT",bar,"TOPLEFT",0,abSize);
        bar4:SetPoint("TOPRIGHT",bar,"TOPRIGHT",0,abSize);
        if b2Size==0 then
            bar4:SetHeight(bheight+(abSize*2))
        else
            bar4:SetHeight(b2Size+bheight+(abSize*2))
        end
        tBarsConcat[1]='Interface\\Addons\\HealBot\\Images\\aggro'
        tBarsConcat[2]=abtSize[abSize]
        tBarsConcat[3]='.tga'
        bar4:SetStatusBarTexture(HealBot_Skins_Concat(3))
        bar4:GetStatusBarTexture():SetHorizTile(false)
        b:SetHeight(bheight); 
        b:SetWidth(bWidth)
        iScale=(bheight*Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["SCALE"])-2
        tBarsConcat[1]=barDir:GetName()
        tBarsConcat[2]="Icon17"
        icon17=_G[HealBot_Skins_Concat(2)];
        icon17:SetHeight(iScale);
        icon17:SetWidth(iScale);
        barDir:SetHeight(iScale);
        barDir:SetWidth(iScale);
        icon17:Hide()
        tBarsConcat[1]=bar:GetName()
        tBarsConcat[2]="Icon1"
        icon1 = _G[HealBot_Skins_Concat(2)];
        tBarsConcat[2]="Expire1"
        expire1 = _G[HealBot_Skins_Concat(2)];
        tBarsConcat[2]="Count1"
        count1 = _G[HealBot_Skins_Concat(2)];
        tBarsConcat[2]="Icon51"
        icon51 = _G[HealBot_Skins_Concat(2)];
        tBarsConcat[2]="Expire51"
        expire51 = _G[HealBot_Skins_Concat(2)];
        tBarsConcat[2]="Count51"
        count51 = _G[HealBot_Skins_Concat(2)];
        if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["DOUBLE"] then
            iScale=floor(((bheight*Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["SCALE"])-2)*0.485)
        end
        tBarsConcat[1]=bar:GetName()
        for x=1,10 do
            tBarsConcat[2]="Icon"
            tBarsConcat[3]=x
            icon = _G[HealBot_Skins_Concat(3)];
            tBarsConcat[2]="Expire"
            expire=_G[HealBot_Skins_Concat(3)];
            tBarsConcat[2]="Count"
            count=_G[HealBot_Skins_Concat(3)];
            icon:SetHeight(iScale);
            icon:SetWidth(iScale);
            expire:SetFont(LSM:Fetch('font',Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][b.frame]["FONT"]),
                                            Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][b.frame]["HEIGHT"],
                                            HealBot_Font_Outline[Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][b.frame]["OUTLINE"]]);
            count:SetFont(LSM:Fetch('font',Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][b.frame]["FONT"]),
                                            Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][b.frame]["HEIGHT"],
                                            HealBot_Font_Outline[Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][b.frame]["OUTLINE"]]);
        end
        if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["DOUBLE"] then
            diScale=floor(((bheight*Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["DSCALE"])-2)*0.485)
        else
            diScale=(bheight*Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["DSCALE"])-2
        end
        tBarsConcat[1]=bar:GetName()
        for x=51,55 do
            tBarsConcat[2]="Icon"
            tBarsConcat[3]=x
            icon = _G[HealBot_Skins_Concat(3)];
            tBarsConcat[2]="Expire"
            expire=_G[HealBot_Skins_Concat(3)];
            tBarsConcat[2]="Count"
            count=_G[HealBot_Skins_Concat(3)];
            icon:SetHeight(diScale);
            icon:SetWidth(diScale);
            expire:SetFont(LSM:Fetch('font',Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][b.frame]["FONT"]),
                                            Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][b.frame]["HEIGHT"],
                                            HealBot_Font_Outline[Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][b.frame]["OUTLINE"]]);
            count:SetFont(LSM:Fetch('font',Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][b.frame]["FONT"]),
                                            Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][b.frame]["HEIGHT"],
                                            HealBot_Font_Outline[Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][b.frame]["OUTLINE"]]);
        end
        if diScale>iScale then iScale=diScale end
        tBarsConcat[1]=bar:GetName()
        for x=1,3 do
            tBarsConcat[2]="Iconal"
            tBarsConcat[3]=x
            pIcon = _G[HealBot_Skins_Concat(3)];
            pIcon:SetAlpha(0);
            tBarsConcat[2]="Iconar"
            pIcon = _G[HealBot_Skins_Concat(3)];
            pIcon:SetAlpha(0);
            tBarsConcat[2]="Icontm"
            pIcon = _G[HealBot_Skins_Concat(3)];
            pIcon:SetAlpha(0);
        end
        for x=1,5 do
            tBarsConcat[1]=bar3:GetName()
            tBarsConcat[2]="Icon"
            tBarsConcat[3]=x
            pIcon = _G[HealBot_Skins_Concat(3)];
            pIcon:SetAlpha(0);
        end
        if HealBot_Action_retLuVars("UnitPowerMax")==3 then
            tBarsConcat[1]=bar3:GetName()
            tBarsConcat[2]="Icon1"
            pIcon = _G[HealBot_Skins_Concat(2)];
            pIcon:SetPoint("BOTTOM",bar3,"BOTTOM","-9","1");
            tBarsConcat[2]="Icon2"
            pIcon = _G[HealBot_Skins_Concat(2)];
            pIcon:SetPoint("BOTTOM",bar3,"BOTTOM","0","1");
            tBarsConcat[2]="Icon3"
            pIcon = _G[HealBot_Skins_Concat(2)];
            pIcon:SetPoint("BOTTOM",bar3,"BOTTOM","9","1");
        elseif HealBot_Action_retLuVars("UnitPowerMax")==4 then
            tBarsConcat[1]=bar3:GetName()
            tBarsConcat[2]="Icon1"
            pIcon = _G[HealBot_Skins_Concat(2)];
            pIcon:SetPoint("BOTTOM",bar3,"BOTTOM","-12","1");
            tBarsConcat[2]="Icon2"
            pIcon = _G[HealBot_Skins_Concat(2)];
            pIcon:SetPoint("BOTTOM",bar3,"BOTTOM","-4","1");
            tBarsConcat[2]="Icon3"
            pIcon = _G[HealBot_Skins_Concat(2)];
            pIcon:SetPoint("BOTTOM",bar3,"BOTTOM","4","1");
            tBarsConcat[2]="Icon4"
            pIcon = _G[HealBot_Skins_Concat(2)];
            pIcon:SetPoint("BOTTOM",bar3,"BOTTOM","12","1");
        else
            tBarsConcat[1]=bar3:GetName()
            tBarsConcat[2]="Icon1"
            pIcon = _G[HealBot_Skins_Concat(2)];
            pIcon:SetPoint("BOTTOM",bar3,"BOTTOM","-14","1");
            tBarsConcat[2]="Icon2"
            pIcon = _G[HealBot_Skins_Concat(2)];
            pIcon:SetPoint("BOTTOM",bar3,"BOTTOM","-7","1");
            tBarsConcat[2]="Icon3"
            pIcon = _G[HealBot_Skins_Concat(2)];
            pIcon:SetPoint("BOTTOM",bar3,"BOTTOM","0","1");
            tBarsConcat[2]="Icon4"
            pIcon = _G[HealBot_Skins_Concat(2)];
            pIcon:SetPoint("BOTTOM",bar3,"BOTTOM","7","1");
            tBarsConcat[2]="Icon5"
            pIcon = _G[HealBot_Skins_Concat(2)];
            pIcon:SetPoint("BOTTOM",bar3,"BOTTOM","14","1");
        end
        if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["ONBAR"]==1 then
            HealBot_Panel_SetMultiColHoToffset(0)
            HealBot_Panel_SetMultiRowHoToffset(0)
            if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["POSITION"]==1 then
                icon1:ClearAllPoints();
                icon1:SetPoint("BOTTOMLEFT",b,"BOTTOMLEFT",1,1);
                expire1:ClearAllPoints();
                expire1:SetPoint("BOTTOMLEFT",icon1,"BOTTOMLEFT",0,0);
                count1:ClearAllPoints();
                count1:SetPoint("TOPRIGHT",icon1,"TOPRIGHT",2,0);
                tBarsConcat[1]=bar:GetName()
                for x=2,10 do
                    tBarsConcat[3]=x
                    tBarsConcat[2]="Expire"
                    expire=_G[HealBot_Skins_Concat(3)];
                    tBarsConcat[2]="Count"
                    count=_G[HealBot_Skins_Concat(3)];
                    tBarsConcat[2]="Icon"
                    icon = _G[HealBot_Skins_Concat(3)];
                    icon:ClearAllPoints();
                    if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["DOUBLE"] then
                        if (x/2)==floor(x/2) then
                            tBarsConcat[3]=x-1
                            icon:SetPoint("BOTTOMLEFT",HealBot_Skins_Concat(3),"TOPLEFT",0,1);
                        else
                            tBarsConcat[3]=x-2
                            icon:SetPoint("BOTTOMLEFT",HealBot_Skins_Concat(3),"BOTTOMRIGHT",1,0);
                        end
                    else
                        tBarsConcat[3]=x-1
                        icon:SetPoint("BOTTOMLEFT",HealBot_Skins_Concat(3),"BOTTOMRIGHT",1,0);
                    end
                    expire:ClearAllPoints();
                    expire:SetPoint("BOTTOMLEFT",icon,"BOTTOMLEFT",0,0);
                    count:ClearAllPoints();
                    count:SetPoint("TOPRIGHT",icon,"TOPRIGHT",2,0);
                end
                icon51:ClearAllPoints();
                icon51:SetPoint("BOTTOMRIGHT",b,"BOTTOMRIGHT",-1,1);
                expire51:ClearAllPoints();
                expire51:SetPoint("BOTTOMLEFT",icon51,"BOTTOMLEFT",0,0);
                count51:ClearAllPoints();
                count51:SetPoint("TOPRIGHT",icon51,"TOPRIGHT",2,0);
                tBarsConcat[1]=bar:GetName()
                for x=52,55 do
                    tBarsConcat[3]=x
                    tBarsConcat[2]="Expire"
                    expire=_G[HealBot_Skins_Concat(3)];
                    tBarsConcat[2]="Count"
                    count=_G[HealBot_Skins_Concat(3)];
                    tBarsConcat[2]="Icon"
                    icon = _G[HealBot_Skins_Concat(3)];
                    icon:ClearAllPoints();
                    if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["DOUBLE"] then
                        if (x/2)==floor(x/2) then
                            tBarsConcat[3]=x-1
                            icon:SetPoint("BOTTOMRIGHT",HealBot_Skins_Concat(3),"TOPRIGHT",0,1);
                        else
                            tBarsConcat[3]=x-2
                            icon:SetPoint("BOTTOMRIGHT",HealBot_Skins_Concat(3),"BOTTOMLEFT",1,0);
                        end
                    else
                        tBarsConcat[3]=x-1
                        icon:SetPoint("BOTTOMRIGHT",HealBot_Skins_Concat(3),"BOTTOMLEFT",1,0);
                    end
                    expire:ClearAllPoints();
                    expire:SetPoint("BOTTOMLEFT",icon,"BOTTOMLEFT",0,0);
                    count:ClearAllPoints();
                    count:SetPoint("TOPRIGHT",icon,"TOPRIGHT",2,0);
                end
            else
                icon1:ClearAllPoints();
                icon1:SetPoint("BOTTOMRIGHT",b,"BOTTOMRIGHT",-1,1);
                expire1:ClearAllPoints();
                expire1:SetPoint("BOTTOMRIGHT",icon1,"BOTTOMRIGHT",2,0);
                count1:ClearAllPoints();
                count1:SetPoint("TOPLEFT",icon1,"TOPLEFT",0,0);
                tBarsConcat[1]=bar:GetName()
                for x=2,10 do
                    tBarsConcat[3]=x
                    tBarsConcat[2]="Expire"
                    expire=_G[HealBot_Skins_Concat(3)];
                    tBarsConcat[2]="Count"
                    count=_G[HealBot_Skins_Concat(3)];
                    tBarsConcat[2]="Icon"
                    icon = _G[HealBot_Skins_Concat(3)];
                    icon:ClearAllPoints();
                    if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["DOUBLE"] then
                        if (x/2)==floor(x/2) then
                            tBarsConcat[3]=x-1
                            icon:SetPoint("BOTTOMRIGHT",HealBot_Skins_Concat(3),"TOPRIGHT",0,1);
                        else
                            tBarsConcat[3]=x-2
                            icon:SetPoint("BOTTOMRIGHT",HealBot_Skins_Concat(3),"BOTTOMLEFT",-1,0);
                        end
                    else
                        tBarsConcat[3]=x-1
                        icon:SetPoint("BOTTOMRIGHT",HealBot_Skins_Concat(3),"BOTTOMLEFT",-1,0);
                    end
                    expire:ClearAllPoints();
                    expire:SetPoint("BOTTOMRIGHT",icon,"BOTTOMRIGHT",2,0);
                    count:ClearAllPoints();
                    count:SetPoint("TOPLEFT",icon,"TOPLEFT",0,0);
                end
                icon51:ClearAllPoints();
                icon51:SetPoint("BOTTOMLEFT",b,"BOTTOMLEFT",1,1);
                expire51:ClearAllPoints();
                expire51:SetPoint("BOTTOMRIGHT",icon51,"BOTTOMRIGHT",2,0);
                count51:ClearAllPoints();
                count51:SetPoint("TOPLEFT",icon51,"TOPLEFT",0,0);
                tBarsConcat[1]=bar:GetName()
                for x=52,55 do
                    tBarsConcat[3]=x
                    tBarsConcat[2]="Expire"
                    expire=_G[HealBot_Skins_Concat(3)];
                    tBarsConcat[2]="Count"
                    count=_G[HealBot_Skins_Concat(3)];
                    tBarsConcat[2]="Icon"
                    icon = _G[HealBot_Skins_Concat(3)];
                    icon:ClearAllPoints();
                    if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["DOUBLE"] then
                        if (x/2)==floor(x/2) then
                            tBarsConcat[3]=x-1
                            icon:SetPoint("BOTTOMLEFT",HealBot_Skins_Concat(3),"TOPLEFT",0,1);
                        else
                            tBarsConcat[3]=x-2
                            icon:SetPoint("BOTTOMLEFT",HealBot_Skins_Concat(3),"BOTTOMRIGHT",-1,0);
                        end
                    else
                        tBarsConcat[3]=x-1
                        icon:SetPoint("BOTTOMLEFT",HealBot_Skins_Concat(3),"BOTTOMRIGHT",-1,0);
                    end
                    expire:ClearAllPoints();
                    expire:SetPoint("BOTTOMRIGHT",icon,"BOTTOMRIGHT",2,0);
                    count:ClearAllPoints();
                    count:SetPoint("TOPLEFT",icon,"TOPLEFT",0,0);
                end
            end
        elseif Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["ONBAR"]==2 then
            HealBot_Panel_SetMultiColHoToffset((iScale+1)*5)
            HealBot_Panel_SetMultiRowHoToffset(0)
            if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["POSITION"]==1 then
                icon1:ClearAllPoints();
                icon1:SetPoint("BOTTOMRIGHT",b,"BOTTOMLEFT",-1,1);
                expire1:ClearAllPoints();
                expire1:SetPoint("BOTTOMRIGHT",icon1,"BOTTOMRIGHT",2,0);
                count1:ClearAllPoints();
                count1:SetPoint("TOPLEFT",icon1,"TOPLEFT",0,0);
                tBarsConcat[1]=bar:GetName()
                for x=2,10 do
                    tBarsConcat[3]=x
                    tBarsConcat[2]="Expire"
                    expire=_G[HealBot_Skins_Concat(3)];
                    tBarsConcat[2]="Count"
                    count=_G[HealBot_Skins_Concat(3)];
                    tBarsConcat[2]="Icon"
                    icon = _G[HealBot_Skins_Concat(3)];
                    icon:ClearAllPoints();
                    if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["DOUBLE"] then
                        if (x/2)==floor(x/2) then
                            tBarsConcat[3]=x-1
                            icon:SetPoint("BOTTOMRIGHT",HealBot_Skins_Concat(3),"TOPRIGHT",0,1);
                        else
                            tBarsConcat[3]=x-2
                            icon:SetPoint("BOTTOMRIGHT",HealBot_Skins_Concat(3),"BOTTOMLEFT",-1,0);
                        end
                    else
                        tBarsConcat[3]=x-1
                        icon:SetPoint("BOTTOMRIGHT",HealBot_Skins_Concat(3),"BOTTOMLEFT",-1,0);
                    end
                    expire:ClearAllPoints();
                    expire:SetPoint("BOTTOMRIGHT",icon,"BOTTOMRIGHT",2,0);
                    count:ClearAllPoints();
                    count:SetPoint("TOPLEFT",icon,"TOPLEFT",0,0);
                end
                icon51:ClearAllPoints();
                icon51:SetPoint("BOTTOMLEFT",b,"BOTTOMRIGHT",1,1);
                expire51:ClearAllPoints();
                expire51:SetPoint("BOTTOMRIGHT",icon51,"BOTTOMRIGHT",2,0);
                count51:ClearAllPoints();
                count51:SetPoint("TOPLEFT",icon51,"TOPLEFT",0,0);
                tBarsConcat[1]=bar:GetName()
                for x=52,55 do
                    tBarsConcat[3]=x
                    tBarsConcat[2]="Expire"
                    expire=_G[HealBot_Skins_Concat(3)];
                    tBarsConcat[2]="Count"
                    count=_G[HealBot_Skins_Concat(3)];
                    tBarsConcat[2]="Icon"
                    icon = _G[HealBot_Skins_Concat(3)];
                    icon:ClearAllPoints();
                    if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["DOUBLE"] then
                        if (x/2)==floor(x/2) then
                            tBarsConcat[3]=x-1
                            icon:SetPoint("BOTTOMLEFT",HealBot_Skins_Concat(3),"TOPLEFT",0,1);
                        else
                            tBarsConcat[3]=x-2
                            icon:SetPoint("BOTTOMLEFT",HealBot_Skins_Concat(3),"BOTTOMRIGHT",-1,0);
                        end
                    else
                        tBarsConcat[3]=x-1
                        icon:SetPoint("BOTTOMLEFT",HealBot_Skins_Concat(3),"BOTTOMRIGHT",-1,0);
                    end
                    expire:ClearAllPoints();
                    expire:SetPoint("BOTTOMRIGHT",icon,"BOTTOMRIGHT",2,0);
                    count:ClearAllPoints();
                    count:SetPoint("TOPLEFT",icon,"TOPLEFT",0,0);
                end
            else
                icon1:ClearAllPoints();
                icon1:SetPoint("BOTTOMLEFT",b,"BOTTOMRIGHT",1,1);
                expire1:ClearAllPoints();
                expire1:SetPoint("BOTTOMLEFT",icon1,"BOTTOMLEFT",0,0);
                count1:ClearAllPoints();
                count1:SetPoint("TOPRIGHT",icon1,"TOPRIGHT",2,0);
                tBarsConcat[1]=bar:GetName()
                for x=2,10 do
                    tBarsConcat[3]=x
                    tBarsConcat[2]="Expire"
                    expire=_G[HealBot_Skins_Concat(3)];
                    tBarsConcat[2]="Count"
                    count=_G[HealBot_Skins_Concat(3)];
                    tBarsConcat[2]="Icon"
                    icon = _G[HealBot_Skins_Concat(3)];
                    icon:ClearAllPoints();
                    if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["DOUBLE"] then
                        if (x/2)==floor(x/2) then
                            tBarsConcat[3]=x-1
                            icon:SetPoint("BOTTOMLEFT",HealBot_Skins_Concat(3),"TOPLEFT",0,1);
                        else
                            tBarsConcat[3]=x-2
                            icon:SetPoint("BOTTOMLEFT",HealBot_Skins_Concat(3),"BOTTOMRIGHT",1,0);
                        end
                    else
                        tBarsConcat[3]=x-1
                        icon:SetPoint("BOTTOMLEFT",HealBot_Skins_Concat(3),"BOTTOMRIGHT",1,0);
                    end
                    expire:ClearAllPoints();
                    expire:SetPoint("BOTTOMLEFT",icon,"BOTTOMLEFT",0,0);
                    count:ClearAllPoints();
                    count:SetPoint("TOPRIGHT",icon,"TOPRIGHT",2,0);
                end
                icon51:ClearAllPoints();
                icon51:SetPoint("BOTTOMRIGHT",b,"BOTTOMLEFT",-1,1);
                expire51:ClearAllPoints();
                expire51:SetPoint("BOTTOMLEFT",icon51,"BOTTOMLEFT",0,0);
                count51:ClearAllPoints();
                count51:SetPoint("TOPRIGHT",icon51,"TOPRIGHT",2,0);
                tBarsConcat[1]=bar:GetName()
                for x=52,55 do
                    tBarsConcat[3]=x
                    tBarsConcat[2]="Expire"
                    expire=_G[HealBot_Skins_Concat(3)];
                    tBarsConcat[2]="Count"
                    count=_G[HealBot_Skins_Concat(3)];
                    tBarsConcat[2]="Icon"
                    icon = _G[HealBot_Skins_Concat(3)];
                    icon:ClearAllPoints();
                    if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["DOUBLE"] then
                        if (x/2)==floor(x/2) then
                            tBarsConcat[3]=x-1
                            icon:SetPoint("BOTTOMRIGHT",HealBot_Skins_Concat(3),"TOPRIGHT",0,1);
                        else
                            tBarsConcat[3]=x-2
                            icon:SetPoint("BOTTOMRIGHT",HealBot_Skins_Concat(3),"BOTTOMLEFT",1,0);
                        end
                    else
                        tBarsConcat[3]=x-1
                        icon:SetPoint("BOTTOMRIGHT",HealBot_Skins_Concat(3),"BOTTOMLEFT",1,0);
                    end
                    expire:ClearAllPoints();
                    expire:SetPoint("BOTTOMLEFT",icon,"BOTTOMLEFT",0,0);
                    count:ClearAllPoints();
                    count:SetPoint("TOPRIGHT",icon,"TOPRIGHT",2,0);
                end
            end
        else
            HealBot_Panel_SetMultiColHoToffset(0)
            if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["DOUBLE"] then
                HealBot_Panel_SetMultiRowHoToffset((iScale*2)+1)
            else
                HealBot_Panel_SetMultiRowHoToffset(iScale+1)
            end
            if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["POSITION"]==1 then
                icon1:ClearAllPoints();
                icon1:SetPoint("TOPLEFT",b,"BOTTOMLEFT",1,-1);
                expire1:ClearAllPoints();
                expire1:SetPoint("BOTTOMLEFT",icon1,"BOTTOMLEFT",0,0);
                count1:ClearAllPoints();
                count1:SetPoint("TOPRIGHT",icon1,"TOPRIGHT",2,0);
                tBarsConcat[1]=bar:GetName()
                for x=2,10 do
                    tBarsConcat[3]=x
                    tBarsConcat[2]="Expire"
                    expire=_G[HealBot_Skins_Concat(3)];
                    tBarsConcat[2]="Count"
                    count=_G[HealBot_Skins_Concat(3)];
                    tBarsConcat[2]="Icon"
                    icon = _G[HealBot_Skins_Concat(3)];
                    icon:ClearAllPoints();
                    if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["DOUBLE"] then
                        if (x/2)==floor(x/2) then
                            tBarsConcat[3]=x-1
                            icon:SetPoint("TOPLEFT",HealBot_Skins_Concat(3),"BOTTOMLEFT",0,-1);
                        else
                            tBarsConcat[3]=x-2
                            icon:SetPoint("BOTTOMLEFT",HealBot_Skins_Concat(3),"BOTTOMRIGHT",1,0);
                        end
                    else
                        tBarsConcat[3]=x-1
                        icon:SetPoint("BOTTOMLEFT",HealBot_Skins_Concat(3),"BOTTOMRIGHT",1,0);
                    end
                    expire:ClearAllPoints();
                    expire:SetPoint("BOTTOMLEFT",icon,"BOTTOMLEFT",0,0);
                    count:ClearAllPoints();
                    count:SetPoint("TOPRIGHT",icon,"TOPRIGHT",2,0);
                end
                icon51:ClearAllPoints();
                icon51:SetPoint("TOPRIGHT",b,"BOTTOMRIGHT",-1,-1);
                expire51:ClearAllPoints();
                expire51:SetPoint("BOTTOMLEFT",icon51,"BOTTOMLEFT",0,0);
                count51:ClearAllPoints();
                count51:SetPoint("TOPRIGHT",icon51,"TOPRIGHT",2,0);
                tBarsConcat[1]=bar:GetName()
                for x=52,55 do
                    tBarsConcat[3]=x
                    tBarsConcat[2]="Expire"
                    expire=_G[HealBot_Skins_Concat(3)];
                    tBarsConcat[2]="Count"
                    count=_G[HealBot_Skins_Concat(3)];
                    tBarsConcat[2]="Icon"
                    icon = _G[HealBot_Skins_Concat(3)];
                    icon:ClearAllPoints();
                    if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["DOUBLE"] then
                        if (x/2)==floor(x/2) then
                            tBarsConcat[3]=x-1
                            icon:SetPoint("TOPRIGHT",HealBot_Skins_Concat(3),"BOTTOMRIGHT",0,-1);
                        else
                            tBarsConcat[3]=x-2
                            icon:SetPoint("BOTTOMRIGHT",HealBot_Skins_Concat(3),"BOTTOMLEFT",1,0);
                        end
                    else
                        tBarsConcat[3]=x-1
                        icon:SetPoint("BOTTOMRIGHT",HealBot_Skins_Concat(3),"BOTTOMLEFT",1,0);
                    end
                    expire:ClearAllPoints();
                    expire:SetPoint("BOTTOMLEFT",icon,"BOTTOMLEFT",0,0);
                    count:ClearAllPoints();
                    count:SetPoint("TOPRIGHT",icon,"TOPRIGHT",2,0);
                end
            else
                icon1:ClearAllPoints();
                icon1:SetPoint("TOPRIGHT",b,"BOTTOMRIGHT",-1,-1);
                expire1:ClearAllPoints();
                expire1:SetPoint("BOTTOMRIGHT",icon1,"BOTTOMRIGHT",2,0);
                count1:ClearAllPoints();
                count1:SetPoint("TOPLEFT",icon1,"TOPLEFT",0,0);
                tBarsConcat[1]=bar:GetName()
                for x=2,10 do
                    tBarsConcat[3]=x
                    tBarsConcat[2]="Expire"
                    expire=_G[HealBot_Skins_Concat(3)];
                    tBarsConcat[2]="Count"
                    count=_G[HealBot_Skins_Concat(3)];
                    tBarsConcat[2]="Icon"
                    icon=_G[HealBot_Skins_Concat(3)];
                    icon:ClearAllPoints();
                    if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["DOUBLE"] then
                        if (x/2)==floor(x/2) then
                            tBarsConcat[3]=x-1
                            icon:SetPoint("TOPRIGHT",HealBot_Skins_Concat(3),"BOTTOMRIGHT",0,-1);
                        else
                            tBarsConcat[3]=x-2
                            icon:SetPoint("BOTTOMRIGHT",HealBot_Skins_Concat(3),"BOTTOMLEFT",-1,0);
                        end
                    else
                        tBarsConcat[3]=x-1
                        icon:SetPoint("BOTTOMRIGHT",HealBot_Skins_Concat(3),"BOTTOMLEFT",-1,0);
                    end
                    expire:ClearAllPoints();
                    expire:SetPoint("BOTTOMRIGHT",icon,"BOTTOMRIGHT",2,0);
                    count:ClearAllPoints();
                    count:SetPoint("TOPLEFT",icon,"TOPLEFT",0,0);
                end
                icon51:ClearAllPoints();
                icon51:SetPoint("TOPLEFT",b,"BOTTOMLEFT",1,-1);
                expire51:ClearAllPoints();
                expire51:SetPoint("BOTTOMRIGHT",icon51,"BOTTOMRIGHT",2,0);
                count51:ClearAllPoints();
                count51:SetPoint("TOPLEFT",icon51,"TOPLEFT",0,0);
                tBarsConcat[1]=bar:GetName()
                for x=52,55 do
                    tBarsConcat[3]=x
                    tBarsConcat[2]="Expire"
                    expire=_G[HealBot_Skins_Concat(3)];
                    tBarsConcat[2]="Count"
                    count=_G[HealBot_Skins_Concat(3)];
                    tBarsConcat[2]="Icon"
                    icon = _G[HealBot_Skins_Concat(3)];
                    icon:ClearAllPoints();
                    if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["DOUBLE"] then
                        if (x/2)==floor(x/2) then
                            tBarsConcat[3]=x-1
                            icon:SetPoint("TOPLEFT",HealBot_Skins_Concat(3),"BOTTOMLEFT",0,-1);
                        else
                            tBarsConcat[3]=x-2
                            icon:SetPoint("BOTTOMLEFT",HealBot_Skins_Concat(3),"BOTTOMRIGHT",-1,0);
                        end
                    else
                        tBarsConcat[3]=x-1
                        icon:SetPoint("BOTTOMLEFT",HealBot_Skins_Concat(3),"BOTTOMRIGHT",-1,0);
                    end
                    expire:ClearAllPoints();
                    expire:SetPoint("BOTTOMRIGHT",icon,"BOTTOMRIGHT",2,0);
                    count:ClearAllPoints();
                    count:SetPoint("TOPLEFT",icon,"TOPLEFT",0,0);
                end
            end
        end

        if Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][b.frame]["POWERSIZE"]==0 then
            bar3:SetValue(0);
            bar3:SetStatusBarColor(0,0,0,0)
        end
        if b.unit then 
            HealBot_Action_updBar3Value(b)
        end
        if not Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][b.frame]["SHOWBARS"] and 
           not Healbot_Config_Skins.BarHighlight[Healbot_Config_Skins.Current_Skin][b.frame]["CBAR"] and
           not Healbot_Config_Skins.BarHighlight[Healbot_Config_Skins.Current_Skin][b.frame]["TBAR"] then
            bar4:SetMinMaxValues(0,100)
            bar4:SetValue(0)
            bar4:SetStatusBarColor(0,0,0,0)
        end
        HealBot_Text_setTextLen(b.frame)
        HealBot_Text_setNameText(b)
        HealBot_Action_Refresh(b)
        --barScale = bar:GetScale();
        --bar:SetScale(barScale + 0.01);
        --bar:SetScale(barScale);
        --barScale = bar2:GetScale();
        --bar2:SetScale(barScale + 0.01);
        --bar2:SetScale(barScale);
        --barScale = bar3:GetScale();
        --bar3:SetScale(barScale + 0.01);
        --bar3:SetScale(barScale);
        --barScale = bar4:GetScale();
        --bar4:SetScale(barScale + 0.01);
        --bar4:SetScale(barScale);
        --barScale = bar5:GetScale();
        --bar5:SetScale(barScale + 0.01);
        --bar5:SetScale(barScale);
        --barScale = bar6:GetScale();
        --bar6:SetScale(barScale + 0.01);
        --bar6:SetScale(barScale);
    elseif barType=="header" then
        h=button
        bar = _G[h:GetName().."Bar"]
        hwidth = ceil(bWidth*Healbot_Config_Skins.HeadBar[Healbot_Config_Skins.Current_Skin][h.frame]["WIDTH"])
        h:SetHeight(ceil(Healbot_Config_Skins.HeadBar[Healbot_Config_Skins.Current_Skin][h.frame]["HEIGHT"]*frameScale));
        h:SetWidth(hwidth);
        bar:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.HeadBar[Healbot_Config_Skins.Current_Skin][h.frame]["TEXTURE"]));
        bar:GetStatusBarTexture():SetHorizTile(false)
        bar:SetMinMaxValues(0,100);
        bar:SetValue(100);
        bar:SetStatusBarColor(Healbot_Config_Skins.HeadBar[Healbot_Config_Skins.Current_Skin][button.frame]["R"],
                              Healbot_Config_Skins.HeadBar[Healbot_Config_Skins.Current_Skin][button.frame]["G"],
                              Healbot_Config_Skins.HeadBar[Healbot_Config_Skins.Current_Skin][button.frame]["B"],
                              Healbot_Config_Skins.HeadBar[Healbot_Config_Skins.Current_Skin][button.frame]["A"]);
        bar:SetHeight(ceil(Healbot_Config_Skins.HeadBar[Healbot_Config_Skins.Current_Skin][h.frame]["HEIGHT"]*frameScale));
        bar:SetWidth(hwidth);
        tBarsConcat[1]=bar:GetName()
        tBarsConcat[2]="_text"
        bar.txt = _G[HealBot_Skins_Concat(2)];
        tBarsConcat[2]="_text2"
        bar.txt2 = _G[HealBot_Skins_Concat(2)];
        bar.txt:SetFont(LSM:Fetch('font',Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin][h.frame]["FONT"]),
                                Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin][h.frame]["HEIGHT"],
                                HealBot_Font_Outline[Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin][h.frame]["OUTLINE"]]);
        bar.txt:SetTextColor(Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin][button.frame]["R"],
                             Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin][button.frame]["G"],
                             Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin][button.frame]["B"],
                             Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin][button.frame]["A"]);
        bar.txt:SetPoint("CENTER",bar,"CENTER",0,Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin][h.frame]["OFFSET"])
        bar:EnableMouse(false)
        bar.txt2:SetTextColor(0,0,0,0);
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
        HealBot_Action_SetAddHeightWidth()
        HealBot_Panel_clearResetHeaderSkinDone()
        HealBot_Action_clearResetBarSkinDone()
        HealBot_setOptions_Timer(80)
        HealBot_setOptions_Timer(50)
        --if vResetSkinPrevSkin~=Healbot_Config_Skins.Current_Skin then
        --    vResetSkinPrevSkin=Healbot_Config_Skins.Current_Skin
            --HealBot_setOptions_Timer(800)
        --end
        HealBot_setHighlightTargetBar()
    end
    --HealBot_setCall("HealBot_Skins_ResetSkin")
end
