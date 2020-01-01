local LSM = HealBot_Libs_LSM() --LibStub("LibSharedMedia-3.0")
--local vResetSkinPrevSkin=""
local frameScale = 1
local b2Size = 0
local abSize = 2
local bheight= 20
local bWidth = 120
local bOutline = 1
local btextheight=10
local btextoutline=1
local b,bar,bar2,bar3,bar4,icon,txt,icon17,pIcon,expire,count=nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil
local icon1,expire1,count1,icon51,expire51,count51=nil,nil,nil,nil,nil,nil
local barScale,h,hwidth,hheight,iScale,diScale,itScale,x,hcpct,bar5,bar6,barDir=nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil
local abtSize = {[0]=1,[1]=1,[2]=1,[3]=2,[4]=2,[5]=2,[6]=3,[7]=3,[8]=3,[9]=3,[10]=4,[11]=4,[12]=4,[13]=4,[14]=4,[15]=5}
function HealBot_Skins_ResetSkin(barType,button,numcols)
    if button and button.frame then 
        frameScale = Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][button.frame]["SCALE"]
        b2Size = ceil(Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][button.frame]["POWERSIZE"]*frameScale)
        abSize = ceil(Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][button.frame]["AGGROSIZE"]*frameScale)
        bheight= ceil(Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][button.frame]["HEIGHT"]*frameScale);
        bWidth = ceil(Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][button.frame]["WIDTH"]*frameScale);
        bOutline = ceil(Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["BOUT"]*frameScale);
        btextheight=ceil(Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["HEIGHT"]*frameScale);
        btextoutline=Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["OUTLINE"];
    end
  
    if barType=="bar" then
        b=button;
        if Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][b.frame]["SHOW"]==false and 
           Healbot_Config_Skins.BarHighlight[Healbot_Config_Skins.Current_Skin][b.frame]["CBAR"]==false and
           Healbot_Config_Skins.BarHighlight[Healbot_Config_Skins.Current_Skin][b.frame]["TBAR"]==false then 
            abSize=0 
        end
        bar = _G["HealBot_Action_HealUnit"..b.id.."Bar"]
        bar2 = _G["HealBot_Action_HealUnit"..b.id.."Bar2"]
        bar3 = _G["HealBot_Action_HealUnit"..b.id.."Bar3"]
        bar4 = _G["HealBot_Action_HealUnit"..b.id.."Bar4"]
        bar5 = _G["HealBot_Action_HealUnit"..b.id.."Bar5"]
        bar6 = _G["HealBot_Action_HealUnit"..b.id.."Bar6"]
        barDir = _G["HealBot_Action_HealUnit"..b.id.."BarDir"];
        bar.txt = _G[bar:GetName().."_text"];
        bar3.txt=_G[bar3:GetName().."Bar3Txt"];
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
        local gaf = _G["f"..b.frame.."_HealBot_Action"]
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
        bar3.txt:SetFont(LSM:Fetch('font',Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["FONT"]),
                        btextheight,
                        HealBot_Font_Outline[btextoutline]);
        bar.txt:ClearAllPoints();
        bar5:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][b.frame]["TEXTURE"]));
        bar5:GetStatusBarTexture():SetHorizTile(false)
        bar6:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][b.frame]["TEXTURE"]));
        bar6:GetStatusBarTexture():SetHorizTile(false)
        if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["ALIGN"]==1 then
            bar.txt:SetPoint("LEFT",bar,"LEFT",4,Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["OFFSET"])
        elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["ALIGN"]==2 then
            bar.txt:SetPoint("CENTER",bar,"CENTER",0,Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["OFFSET"])
        else
            bar.txt:SetPoint("RIGHT",bar,"RIGHT",-4,Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["OFFSET"])
        end
        bar2:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][b.frame]["TEXTURE"]));
        bar2:GetStatusBarTexture():SetHorizTile(false)
        bar3:SetHeight(b2Size);
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
        bar4:SetStatusBarTexture('Interface\\Addons\\HealBot\\Images\\aggro'..abtSize[abSize]..'.tga')
        bar4:GetStatusBarTexture():SetHorizTile(false)
        b:SetHeight(bheight); 
        b:SetWidth(bWidth)
        iScale=(bheight*Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["SCALE"])-2
        icon17 = _G[barDir:GetName().."Icon17"];
        icon17:SetHeight(iScale);
        icon17:SetWidth(iScale);
        barDir:SetHeight(iScale);
        barDir:SetWidth(iScale);
        icon17:Hide()
        icon1=_G[bar:GetName().."Icon1"];
        expire1=_G[bar:GetName().."Expire1"];
        count1=_G[bar:GetName().."Count1"];
        icon51=_G[bar:GetName().."Icon51"];
        expire51=_G[bar:GetName().."Expire51"];
        count51=_G[bar:GetName().."Count51"];
        if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["DOUBLE"] then
            iScale=floor(((bheight*Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["SCALE"])-2)*0.485)
        end
        for x=1,10 do
            icon=_G[bar:GetName().."Icon"..x];
            expire=_G[bar:GetName().."Expire"..x];
            count=_G[bar:GetName().."Count"..x];
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
        for x=51,55 do
            icon=_G[bar:GetName().."Icon"..x];
            expire=_G[bar:GetName().."Expire"..x];
            count=_G[bar:GetName().."Count"..x];
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
        for x=1,3 do
            pIcon = _G[bar:GetName().."Iconal"..x];
            pIcon:SetAlpha(0);
            pIcon = _G[bar:GetName().."Iconar"..x];
            pIcon:SetAlpha(0);
            pIcon = _G[bar:GetName().."Icontm"..x];
            pIcon:SetAlpha(0);
        end
        for x=1,5 do
            pIcon = _G[bar3:GetName().."Icon"..x];
            pIcon:SetAlpha(0);
        end
        if HealBot_Action_retLuVars("UnitPowerMax")==3 then
            pIcon = _G[bar3:GetName().."Icon1"];
            pIcon:SetPoint("BOTTOM",bar3,"BOTTOM","-9","0");
            pIcon = _G[bar3:GetName().."Icon2"];
            pIcon:SetPoint("BOTTOM",bar3,"BOTTOM","0","0");
            pIcon = _G[bar3:GetName().."Icon3"];
            pIcon:SetPoint("BOTTOM",bar3,"BOTTOM","9","0");
        elseif HealBot_Action_retLuVars("UnitPowerMax")==4 then
            pIcon = _G[bar3:GetName().."Icon1"];
            pIcon:SetPoint("BOTTOM",bar3,"BOTTOM","-12","0");
            pIcon = _G[bar3:GetName().."Icon2"];
            pIcon:SetPoint("BOTTOM",bar3,"BOTTOM","-4","0");
            pIcon = _G[bar3:GetName().."Icon3"];
            pIcon:SetPoint("BOTTOM",bar3,"BOTTOM","4","0");
            pIcon = _G[bar3:GetName().."Icon4"];
            pIcon:SetPoint("BOTTOM",bar3,"BOTTOM","12","0");
        else
            pIcon = _G[bar3:GetName().."Icon1"];
            pIcon:SetPoint("BOTTOM",bar3,"BOTTOM","-14","0");
            pIcon = _G[bar3:GetName().."Icon2"];
            pIcon:SetPoint("BOTTOM",bar3,"BOTTOM","-7","0");
            pIcon = _G[bar3:GetName().."Icon3"];
            pIcon:SetPoint("BOTTOM",bar3,"BOTTOM","0","0");
            pIcon = _G[bar3:GetName().."Icon4"];
            pIcon:SetPoint("BOTTOM",bar3,"BOTTOM","7","0");
            pIcon = _G[bar3:GetName().."Icon5"];
            pIcon:SetPoint("BOTTOM",bar3,"BOTTOM","14","0");
        end
        if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["ONBAR"]==1 then
            HealBot_Panel_SetMultiColHoToffset(0)
            HealBot_Panel_SetMultiRowHoToffset(0)
            if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["POSITION"]==1 then
                icon1:ClearAllPoints();
                icon1:SetPoint("BOTTOMLEFT",b,"BOTTOMLEFT",1,0);
                expire1:ClearAllPoints();
                expire1:SetPoint("BOTTOMLEFT",icon1,"BOTTOMLEFT",0,0);
                count1:ClearAllPoints();
                count1:SetPoint("TOPRIGHT",icon1,"TOPRIGHT",2,0);
                for x=2,10 do
                    icon=_G[bar:GetName().."Icon"..x];
                    expire=_G[bar:GetName().."Expire"..x];
                    count=_G[bar:GetName().."Count"..x];
                    icon:ClearAllPoints();
                    if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["DOUBLE"] then
                        if (x/2)==floor(x/2) then
                            icon:SetPoint("BOTTOMLEFT",bar:GetName().."Icon"..x-1,"TOPLEFT",0,1);
                        else
                            icon:SetPoint("BOTTOMLEFT",bar:GetName().."Icon"..x-2,"BOTTOMRIGHT",1,0);
                        end
                    else
                        icon:SetPoint("BOTTOMLEFT",bar:GetName().."Icon"..x-1,"BOTTOMRIGHT",1,0);
                    end
                    expire:ClearAllPoints();
                    expire:SetPoint("BOTTOMLEFT",icon,"BOTTOMLEFT",0,0);
                    count:ClearAllPoints();
                    count:SetPoint("TOPRIGHT",icon,"TOPRIGHT",2,0);
                end
                icon51:ClearAllPoints();
                icon51:SetPoint("BOTTOMRIGHT",b,"BOTTOMRIGHT",1,0);
                expire51:ClearAllPoints();
                expire51:SetPoint("BOTTOMLEFT",icon51,"BOTTOMLEFT",0,0);
                count51:ClearAllPoints();
                count51:SetPoint("TOPRIGHT",icon51,"TOPRIGHT",2,0);
                for x=52,55 do
                    icon=_G[bar:GetName().."Icon"..x];
                    expire=_G[bar:GetName().."Expire"..x];
                    count=_G[bar:GetName().."Count"..x];
                    icon:ClearAllPoints();
                    if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["DOUBLE"] then
                        if (x/2)==floor(x/2) then
                            icon:SetPoint("BOTTOMRIGHT",bar:GetName().."Icon"..x-1,"TOPRIGHT",0,1);
                        else
                            icon:SetPoint("BOTTOMRIGHT",bar:GetName().."Icon"..x-2,"BOTTOMLEFT",1,0);
                        end
                    else
                        icon:SetPoint("BOTTOMRIGHT",bar:GetName().."Icon"..x-1,"BOTTOMLEFT",1,0);
                    end
                    expire:ClearAllPoints();
                    expire:SetPoint("BOTTOMLEFT",icon,"BOTTOMLEFT",0,0);
                    count:ClearAllPoints();
                    count:SetPoint("TOPRIGHT",icon,"TOPRIGHT",2,0);
                end
            else
                icon1:ClearAllPoints();
                icon1:SetPoint("BOTTOMRIGHT",b,"BOTTOMRIGHT",-1,0);
                expire1:ClearAllPoints();
                expire1:SetPoint("BOTTOMRIGHT",icon1,"BOTTOMRIGHT",2,0);
                count1:ClearAllPoints();
                count1:SetPoint("TOPLEFT",icon1,"TOPLEFT",0,0);
                for x=2,10 do
                    icon=_G[bar:GetName().."Icon"..x];
                    expire=_G[bar:GetName().."Expire"..x];
                    count=_G[bar:GetName().."Count"..x];
                    icon:ClearAllPoints();
                    if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["DOUBLE"] then
                        if (x/2)==floor(x/2) then
                            icon:SetPoint("BOTTOMRIGHT",bar:GetName().."Icon"..x-1,"TOPRIGHT",0,1);
                        else
                            icon:SetPoint("BOTTOMRIGHT",bar:GetName().."Icon"..x-2,"BOTTOMLEFT",-1,0);
                        end
                    else
                        icon:SetPoint("BOTTOMRIGHT",bar:GetName().."Icon"..x-1,"BOTTOMLEFT",-1,0);
                    end
                    expire:ClearAllPoints();
                    expire:SetPoint("BOTTOMRIGHT",icon,"BOTTOMRIGHT",2,0);
                    count:ClearAllPoints();
                    count:SetPoint("TOPLEFT",icon,"TOPLEFT",0,0);
                end
                icon51:ClearAllPoints();
                icon51:SetPoint("BOTTOMLEFT",b,"BOTTOMLEFT",-1,0);
                expire51:ClearAllPoints();
                expire51:SetPoint("BOTTOMRIGHT",icon51,"BOTTOMRIGHT",2,0);
                count51:ClearAllPoints();
                count51:SetPoint("TOPLEFT",icon51,"TOPLEFT",0,0);
                for x=52,55 do
                    icon=_G[bar:GetName().."Icon"..x];
                    expire=_G[bar:GetName().."Expire"..x];
                    count=_G[bar:GetName().."Count"..x];
                    icon:ClearAllPoints();
                    if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["DOUBLE"] then
                        if (x/2)==floor(x/2) then
                            icon:SetPoint("BOTTOMLEFT",bar:GetName().."Icon"..x-1,"TOPLEFT",0,1);
                        else
                            icon:SetPoint("BOTTOMLEFT",bar:GetName().."Icon"..x-2,"BOTTOMRIGHT",-1,0);
                        end
                    else
                        icon:SetPoint("BOTTOMLEFT",bar:GetName().."Icon"..x-1,"BOTTOMRIGHT",-1,0);
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
                icon1:SetPoint("BOTTOMRIGHT",b,"BOTTOMLEFT",-1,0);
                expire1:ClearAllPoints();
                expire1:SetPoint("BOTTOMRIGHT",icon1,"BOTTOMRIGHT",2,0);
                count1:ClearAllPoints();
                count1:SetPoint("TOPLEFT",icon1,"TOPLEFT",0,0);
                for x=2,10 do
                    icon=_G[bar:GetName().."Icon"..x];
                    expire=_G[bar:GetName().."Expire"..x];
                    count=_G[bar:GetName().."Count"..x];
                    icon:ClearAllPoints();
                    if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["DOUBLE"] then
                        if (x/2)==floor(x/2) then
                            icon:SetPoint("BOTTOMRIGHT",bar:GetName().."Icon"..x-1,"TOPRIGHT",0,1);
                        else
                            icon:SetPoint("BOTTOMRIGHT",bar:GetName().."Icon"..x-2,"BOTTOMLEFT",-1,0);
                        end
                    else
                        icon:SetPoint("BOTTOMRIGHT",bar:GetName().."Icon"..x-1,"BOTTOMLEFT",-1,0);
                    end
                    expire:ClearAllPoints();
                    expire:SetPoint("BOTTOMRIGHT",icon,"BOTTOMRIGHT",2,0);
                    count:ClearAllPoints();
                    count:SetPoint("TOPLEFT",icon,"TOPLEFT",0,0);
                end
                icon51:ClearAllPoints();
                icon51:SetPoint("BOTTOMLEFT",b,"BOTTOMRIGHT",-1,0);
                expire51:ClearAllPoints();
                expire51:SetPoint("BOTTOMRIGHT",icon51,"BOTTOMRIGHT",2,0);
                count51:ClearAllPoints();
                count51:SetPoint("TOPLEFT",icon51,"TOPLEFT",0,0);
                for x=52,55 do
                    icon=_G[bar:GetName().."Icon"..x];
                    expire=_G[bar:GetName().."Expire"..x];
                    count=_G[bar:GetName().."Count"..x];
                    icon:ClearAllPoints();
                    if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["DOUBLE"] then
                        if (x/2)==floor(x/2) then
                            icon:SetPoint("BOTTOMLEFT",bar:GetName().."Icon"..x-1,"TOPLEFT",0,1);
                        else
                            icon:SetPoint("BOTTOMLEFT",bar:GetName().."Icon"..x-2,"BOTTOMRIGHT",-1,0);
                        end
                    else
                        icon:SetPoint("BOTTOMLEFT",bar:GetName().."Icon"..x-1,"BOTTOMRIGHT",-1,0);
                    end
                    expire:ClearAllPoints();
                    expire:SetPoint("BOTTOMRIGHT",icon,"BOTTOMRIGHT",2,0);
                    count:ClearAllPoints();
                    count:SetPoint("TOPLEFT",icon,"TOPLEFT",0,0);
                end
            else
                icon1:ClearAllPoints();
                icon1:SetPoint("BOTTOMLEFT",b,"BOTTOMRIGHT",2,0);
                expire1:ClearAllPoints();
                expire1:SetPoint("BOTTOMLEFT",icon1,"BOTTOMLEFT",0,0);
                count1:ClearAllPoints();
                count1:SetPoint("TOPRIGHT",icon1,"TOPRIGHT",2,0);
                for x=2,10 do
                    icon=_G[bar:GetName().."Icon"..x];
                    expire=_G[bar:GetName().."Expire"..x];
                    count=_G[bar:GetName().."Count"..x];
                    icon:ClearAllPoints();
                    if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["DOUBLE"] then
                        if (x/2)==floor(x/2) then
                            icon:SetPoint("BOTTOMLEFT",bar:GetName().."Icon"..x-1,"TOPLEFT",0,1);
                        else
                            icon:SetPoint("BOTTOMLEFT",bar:GetName().."Icon"..x-2,"BOTTOMRIGHT",1,0);
                        end
                    else
                        icon:SetPoint("BOTTOMLEFT",bar:GetName().."Icon"..x-1,"BOTTOMRIGHT",1,0);
                    end
                    expire:ClearAllPoints();
                    expire:SetPoint("BOTTOMLEFT",icon,"BOTTOMLEFT",0,0);
                    count:ClearAllPoints();
                    count:SetPoint("TOPRIGHT",icon,"TOPRIGHT",2,0);
                end
                icon51:ClearAllPoints();
                icon51:SetPoint("BOTTOMRIGHT",b,"BOTTOMLEFT",2,0);
                expire51:ClearAllPoints();
                expire51:SetPoint("BOTTOMLEFT",icon51,"BOTTOMLEFT",0,0);
                count51:ClearAllPoints();
                count51:SetPoint("TOPRIGHT",icon51,"TOPRIGHT",2,0);
                for x=52,55 do
                    icon=_G[bar:GetName().."Icon"..x];
                    expire=_G[bar:GetName().."Expire"..x];
                    count=_G[bar:GetName().."Count"..x];
                    icon:ClearAllPoints();
                    if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["DOUBLE"] then
                        if (x/2)==floor(x/2) then
                            icon:SetPoint("BOTTOMRIGHT",bar:GetName().."Icon"..x-1,"TOPRIGHT",0,1);
                        else
                            icon:SetPoint("BOTTOMRIGHT",bar:GetName().."Icon"..x-2,"BOTTOMLEFT",1,0);
                        end
                    else
                        icon:SetPoint("BOTTOMRIGHT",bar:GetName().."Icon"..x-1,"BOTTOMLEFT",1,0);
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
                for x=2,10 do
                    icon=_G[bar:GetName().."Icon"..x];
                    expire=_G[bar:GetName().."Expire"..x];
                    count=_G[bar:GetName().."Count"..x];
                    icon:ClearAllPoints();
                    if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["DOUBLE"] then
                        if (x/2)==floor(x/2) then
                            icon:SetPoint("TOPLEFT",bar:GetName().."Icon"..x-1,"BOTTOMLEFT",0,-1);
                        else
                            icon:SetPoint("BOTTOMLEFT",bar:GetName().."Icon"..x-2,"BOTTOMRIGHT",1,0);
                        end
                    else
                        icon:SetPoint("BOTTOMLEFT",bar:GetName().."Icon"..x-1,"BOTTOMRIGHT",1,0);
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
                for x=52,55 do
                    icon=_G[bar:GetName().."Icon"..x];
                    expire=_G[bar:GetName().."Expire"..x];
                    count=_G[bar:GetName().."Count"..x];
                    icon:ClearAllPoints();
                    if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["DOUBLE"] then
                        if (x/2)==floor(x/2) then
                            icon:SetPoint("TOPRIGHT",bar:GetName().."Icon"..x-1,"BOTTOMRIGHT",0,-1);
                        else
                            icon:SetPoint("BOTTOMRIGHT",bar:GetName().."Icon"..x-2,"BOTTOMLEFT",1,0);
                        end
                    else
                        icon:SetPoint("BOTTOMRIGHT",bar:GetName().."Icon"..x-1,"BOTTOMLEFT",1,0);
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
                for x=2,10 do
                    icon=_G[bar:GetName().."Icon"..x];
                    expire=_G[bar:GetName().."Expire"..x];
                    count=_G[bar:GetName().."Count"..x];
                    icon:ClearAllPoints();
                    if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["DOUBLE"] then
                        if (x/2)==floor(x/2) then
                            icon:SetPoint("TOPRIGHT",bar:GetName().."Icon"..x-1,"BOTTOMRIGHT",0,-1);
                        else
                            icon:SetPoint("BOTTOMRIGHT",bar:GetName().."Icon"..x-2,"BOTTOMLEFT",-1,0);
                        end
                    else
                        icon:SetPoint("BOTTOMRIGHT",bar:GetName().."Icon"..x-1,"BOTTOMLEFT",-1,0);
                    end
                    expire:ClearAllPoints();
                    expire:SetPoint("BOTTOMRIGHT",icon,"BOTTOMRIGHT",2,0);
                    count:ClearAllPoints();
                    count:SetPoint("TOPLEFT",icon,"TOPLEFT",0,0);
                end
                icon51:ClearAllPoints();
                icon51:SetPoint("TOPLEFT",b,"BOTTOMLEFT",-1,-1);
                expire51:ClearAllPoints();
                expire51:SetPoint("BOTTOMRIGHT",icon51,"BOTTOMRIGHT",2,0);
                count51:ClearAllPoints();
                count51:SetPoint("TOPLEFT",icon51,"TOPLEFT",0,0);
                for x=52,55 do
                    icon=_G[bar:GetName().."Icon"..x];
                    expire=_G[bar:GetName().."Expire"..x];
                    count=_G[bar:GetName().."Count"..x];
                    icon:ClearAllPoints();
                    if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["DOUBLE"] then
                        if (x/2)==floor(x/2) then
                            icon:SetPoint("TOPLEFT",bar:GetName().."Icon"..x-1,"BOTTOMLEFT",0,-1);
                        else
                            icon:SetPoint("BOTTOMLEFT",bar:GetName().."Icon"..x-2,"BOTTOMRIGHT",-1,0);
                        end
                    else
                        icon:SetPoint("BOTTOMLEFT",bar:GetName().."Icon"..x-1,"BOTTOMRIGHT",-1,0);
                    end
                    expire:ClearAllPoints();
                    expire:SetPoint("BOTTOMRIGHT",icon,"BOTTOMRIGHT",2,0);
                    count:ClearAllPoints();
                    count:SetPoint("TOPLEFT",icon,"TOPLEFT",0,0);
                end
            end
        end

        if Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][b.frame]["POWERSIZE"]==0 then
            bar3:SetHeight(0);
            bar3:SetValue(0);
            bar3:SetStatusBarColor(0,0,0,0)
        elseif b.unit then 
            HealBot_Action_SetBar3Value(b)
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
        bar.txt = _G[bar:GetName().."_text"];
        bar.txt:SetFont(LSM:Fetch('font',Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin][h.frame]["FONT"]),
                                Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin][h.frame]["HEIGHT"],
                                HealBot_Font_Outline[Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin][h.frame]["OUTLINE"]]);
        bar.txt:SetTextColor(Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin][button.frame]["R"],
                             Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin][button.frame]["G"],
                             Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin][button.frame]["B"],
                             Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin][button.frame]["A"]);
        bar.txt:SetPoint("CENTER",bar,"CENTER",0,Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin][h.frame]["OFFSET"])
        bar:EnableMouse(false)
        h:Disable();
    elseif barType=="frameheader" then
        local g=_G["f"..numcols.."_HealBot_Action"]
        if g:IsVisible() and g:GetRight() and g:GetLeft() then
            bar=_G["f"..numcols.."_HealBot_Action_HeaderBar"]
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
        bar = _G["HealBot_Action_HealUnit"..button.id.."Bar"]
        bar:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][button.frame]["TEXTURE"]));
        bar:GetStatusBarTexture():SetHorizTile(false)

        bar:SetStatusBarColor(1,1,1,1);
        bar.txt = _G[bar:GetName().."_text"];
        bar.txt:SetFont(LSM:Fetch('font',Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["FONT"]),
                                            btextheight,
                                            HealBot_Font_Outline[btextoutline]);
        bar.txt:SetTextColor(0,0,0,1);
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
        --if vResetSkinPrevSkin~=Healbot_Config_Skins.Current_Skin then
        --    vResetSkinPrevSkin=Healbot_Config_Skins.Current_Skin
            --HealBot_setOptions_Timer(800)
        --end
        HealBot_setHighlightTargetBar()
    end
    --HealBot_setCall("HealBot_Skins_ResetSkin")
end
