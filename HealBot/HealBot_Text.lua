local hbBarTextLen={[1]=50,[2]=50,[3]=50,[4]=50,[5]=50,[6]=50,[7]=50,[8]=50,[9]=50,[10]=50}
local hbFontVal={ ["Accidental Presidency"]=3,
                  ["Alba Super"]=1.4,
                  ["Anime Ace"]=1,
                  ["Ariel Narrow"]=3,
                  ["Blazed"]=1.1,
                  ["Designer Block"]=1.7,
                  ["DestructoBeam BB"]=1.4,
                  ["Diogenes"]=2.1,
                  ["Disko"]=1.9,
                  ["DreamSpeak"]=3,
                  ["Drummon"]=1.5,
                  ["Dustismo"]=1.9,
                  ["Electrofied"]=1.1,
                  ["Emblem"]=1.7,
                  ["Frakturika Spamless"]=2.4,
                  ["Friz Quadrata TT"]=1.6,
                  ["Impact"]=2,
                  ["Liberation Sans"]=1.6,
                  ["Liberation Serif"]=1.8,
                  ["Morpheus"]=1.9,
                  ["Mystic Orbs"]=1.2,
                  ["Pokemon Solid"]=1.9,
                  ["Rock Show Whiplash"]=2.4,
                  ["SF Diego Sans"]=1.5,
                  ["SF Laundromatic"]=3,
                  ["Skurri"]=2.2,
                  ["Solange"]=1.4,
                  ["Star Cine"]=1,
                  ["Trashco"]=1.6,
                  ["Waltograph UI"]=1,
                  ["X360"]=1.4,
                  ["Zekton"]=1.6,
 }
local hbNumFormats = {["Places"]        = {[1]=-1, [2]=-1, [3]=-1, [4]=-1, [5]=-1, [6]=-1, [7]=-1, [8]=-1, [9]=-1, [10]=-1},
                      ["SurroundLeft"]  = {[1]="(",[2]="(",[3]="(",[4]="(",[5]="(",[6]="(",[7]="(",[8]="(",[9]="(",[10]="("},
                      ["SurroundRight"] = {[1]=")",[2]=")",[3]=")",[4]=")",[5]=")",[6]=")",[7]=")",[8]=")",[9]=")",[10]=")"},
                      ["Suffix"]        = {[1]=1,  [2]=1,  [3]=1,  [4]=1,  [5]=1,  [6]=1,  [7]=1,  [8]=1,  [9]=1,  [10]=1},
                     }
local aggroNumFormatSurLa={[1]="[",[2]="[",[3]="[",[4]="[",[5]="[",[6]="[",[7]="[",[8]="[",[9]="[",}
local aggroNumFormatSurRa={[1]="]",[2]="]",[3]="]",[4]="]",[5]="]",[6]="]",[7]="]",[8]="]",[9]="]",}

local hbStringSub=nil
local hbutf8sub=string.gsub
local hbStringLen=nil
if HealBot_Globals.useUTF8 then
    hbStringSub=string.utf8sub
    hbStringLen=string.utf8len
else
    hbStringSub=string.sub
    hbStringLen=string.len
end
local floor=floor

function HealBot_Text_Len(v)
    return hbStringLen(v)
end

local tConcat={[1]="",[2]="",[3]="",[4]="",[5]="",[6]=""}
local tabconcat=table.concat
local function HealBot_Text_Concat(elements)
    return tabconcat(tConcat,"",1,elements)
end

function HealBot_Text_sethbNumberFormat()
    for j=1,10 do
        if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][j]["NUMFORMAT1"]==2 or Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][j]["NUMFORMAT1"]==5 or Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][j]["NUMFORMAT1"]==8 then
            hbNumFormats["Places"][j]=0
        elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][j]["NUMFORMAT1"]==3 or Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][j]["NUMFORMAT1"]==6 or Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][j]["NUMFORMAT1"]==9 then
            hbNumFormats["Places"][j]=1
        elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][j]["NUMFORMAT1"]==4 or Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][j]["NUMFORMAT1"]==7 or Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][j]["NUMFORMAT1"]==10 then
            hbNumFormats["Places"][j]=2
        elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][j]["NUMFORMAT1"]==11 then
            hbNumFormats["Places"][j]=3
        else
            hbNumFormats["Places"][j]=-1
        end
        if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][j]["NUMFORMAT1"]>1 and Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][j]["NUMFORMAT1"]<5 then
            hbNumFormats["Suffix"][j]=1
        elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][j]["NUMFORMAT1"]>4 and Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][j]["NUMFORMAT1"]<8 then
            hbNumFormats["Suffix"][j]=2
        elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][j]["NUMFORMAT1"]==11 then
            hbNumFormats["Suffix"][j]=1
        else
            hbNumFormats["Suffix"][j]=0
        end
        if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][j]["NUMFORMAT2"]==2 then
            hbNumFormats["SurroundLeft"][j]="("
            hbNumFormats["SurroundRight"][j]=")"
        elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][j]["NUMFORMAT2"]==3 then
            hbNumFormats["SurroundLeft"][j]="["
            hbNumFormats["SurroundRight"][j]="]"
        elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][j]["NUMFORMAT2"]==4 then
            hbNumFormats["SurroundLeft"][j]="{"
            hbNumFormats["SurroundRight"][j]="}"
        elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][j]["NUMFORMAT2"]==5 then
            hbNumFormats["SurroundLeft"][j]="<"
            hbNumFormats["SurroundRight"][j]=">"
        elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][j]["NUMFORMAT2"]==6 then
            hbNumFormats["SurroundLeft"][j]="~"
            hbNumFormats["SurroundRight"][j]=""
        elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][j]["NUMFORMAT2"]==7 then
            hbNumFormats["SurroundLeft"][j]=":"
            hbNumFormats["SurroundRight"][j]=":"
        elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][j]["NUMFORMAT2"]==8 then
            hbNumFormats["SurroundLeft"][j]="*"
            hbNumFormats["SurroundRight"][j]="*"
        else
            hbNumFormats["SurroundLeft"][j]=""
            hbNumFormats["SurroundRight"][j]=""
        end
        if hbNumFormats["Places"][j]==-1 then
            hbNumFormats["Suffix"][j]=0
        end
    end
    --HealBot_setCall("HealBot_Text_sethbNumberFormat")
end

function HealBot_Text_sethbAggroNumberFormat()
    for j=1,9 do
        if Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][j]["TEXTFORMAT"]==2 then
            aggroNumFormatSurLa[j]="("
            aggroNumFormatSurRa[j]=")"
        elseif Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][j]["TEXTFORMAT"]==3 then
            aggroNumFormatSurLa[j]="["
            aggroNumFormatSurRa[j]="]"
        elseif Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][j]["TEXTFORMAT"]==4 then
            aggroNumFormatSurLa[j]="{"
            aggroNumFormatSurRa[j]="}"
        elseif Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][j]["TEXTFORMAT"]==5 then
            aggroNumFormatSurLa[j]="<"
            aggroNumFormatSurRa[j]=">"
        elseif Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][j]["TEXTFORMAT"]==6 then
            aggroNumFormatSurLa[j]="~"
            aggroNumFormatSurRa[j]=""
        elseif Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][j]["TEXTFORMAT"]==7 then
            aggroNumFormatSurLa[j]=":"
            aggroNumFormatSurRa[j]=":"
        elseif Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][j]["TEXTFORMAT"]==8 then
            aggroNumFormatSurLa[j]="*"
            aggroNumFormatSurRa[j]="*"
        else
            aggroNumFormatSurLa[j]=""
            aggroNumFormatSurRa[j]=""
        end
    end
    --HealBot_setCall("HealBot_Text_sethbAggroNumberFormat")
end

local atcR, atcG, atcB=1,1,1
local function HealBot_Text_TextColours(button)
    if button.status.current==9 and not hbGUID~=HealBot_Data["PGUID"] then
        if UnitHasIncomingResurrection(button.unit) then
            atcR,atcG,atcB=0.2, 1.0, 0.2
        elseif UnitIsFriend(button.unit, "player") then
            if button.status.range > 0 or UnitInRange(button.unit) then
                atcR,atcG,atcB=1.0, 0.2, 0.2
            else
                atcR,atcG,atcB=0.5, 0.5, 0.5
            end
        else
            atcR,atcG,atcB=0.4, 0.4, 0.4
        end
    elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["CLASSCOL"] then
        atcR=button.text.r
        atcG=button.text.g
        atcB=button.text.b
    elseif button.aura.debuff.type then
        atcR=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["CR"];
        atcG=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["CG"];
        atcB=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["CB"];
    elseif button.status.range<1 then
        atcR=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["DR"]
        atcG=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["DG"]
        atcB=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["DB"]
    else
        atcR=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["ER"] or 1;
        atcG=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["EG"] or 1;
        atcB=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["EB"] or 1;
    end
    --HealBot_setCall("HealBot_Text_TextColours")
    return atcR,atcG,atcB
end

local vShortHealTxtIsK,vShortHealTxtAmount,vShortHealTxtSuffix=true,0,""
local function HealBot_Text_shortHealTxt(amount, hbCurFrame)
    vShortHealTxtAmount=amount
    vShortHealTxtSuffix=""
    if amount>999 and hbNumFormats["Places"][hbCurFrame]>-1 then
        vShortHealTxtIsK=true
        if hbNumFormats["Places"][hbCurFrame]<3 then 
            if amount>999999 then
                vShortHealTxtAmount=HealBot_Comm_round(amount/1000000,hbNumFormats["Places"][hbCurFrame]) 
                vShortHealTxtIsK=false
            else
                vShortHealTxtAmount=HealBot_Comm_round(amount/1000,hbNumFormats["Places"][hbCurFrame]) 
            end
        else
            if amount>9999999 then
                vShortHealTxtAmount=HealBot_Comm_round(amount/1000000,0)
                vShortHealTxtIsK=false
            elseif amount>999999 then
                vShortHealTxtAmount=HealBot_Comm_round(amount/1000000,1)
                vShortHealTxtIsK=false
            elseif amount>99999 then
                vShortHealTxtAmount=HealBot_Comm_round(amount/1000,0)
            else
                vShortHealTxtAmount=HealBot_Comm_round(amount/1000,1)
            end
        end
        if vShortHealTxtIsK then
            if hbNumFormats["Suffix"][hbCurFrame]==1 then
                vShortHealTxtSuffix="K"
            elseif hbNumFormats["Suffix"][hbCurFrame]==2 then
                vShortHealTxtSuffix="k"
            end
        else
            if hbNumFormats["Suffix"][hbCurFrame]==1 then
                vShortHealTxtSuffix="M"
            elseif hbNumFormats["Suffix"][hbCurFrame]==2 then
                vShortHealTxtSuffix="m"
            end
        end
    end
    --HealBot_setCall("HealBot_Text_shortHealTxt")
    return vShortHealTxtAmount, vShortHealTxtSuffix
end

local function HealBot_Text_addAggro(button)
    tConcat[2]="  "
    tConcat[3]=aggroNumFormatSurLa[button.frame]
    tConcat[4]=button.aggro.threatpct
    tConcat[5]="%"
    tConcat[6]=aggroNumFormatSurRa[button.frame]
end

local ahtVInfo,btHBbarText,bthlthdelta,hbHealInTxt,healInTxt,ahtNumSuffix,vHealthTextPrev,vHealthTextHealInPct="","",0,"",0,"","",0
local vVehicleUnit,vVehicleName,vVehicleHealth,vVehicleMaxHealth,vVehicleHealthPct,vVehicleStrLen,vVehicleBtnLen="","",0,0,0,0,0
function HealBot_Text_setHealthText(button)
    vHealthTextPrev=button.text.health
    hbHealInTxt=Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["INCHEALS"]
    healInTxt=button.health.incoming
    if hbHealInTxt>3 then
        if hbHealInTxt>5 then
            if hbHealInTxt<8 and button.health.current==button.health.max then 
                healInTxt=0
            else
                healInTxt=button.health.incoming+button.health.absorbs 
            end
        end
        if hbHealInTxt==4 or hbHealInTxt==6 or hbHealInTxt==8 then hbHealInTxt=2 end
        if hbHealInTxt==5 or hbHealInTxt==7 or hbHealInTxt==9 then hbHealInTxt=3 end
    elseif button.health.current==button.health.max then 
        healInTxt=0
    end
    if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["HLTHONBAR"] and button.health.max then
        if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["HLTHTYPE"]==1 then
            if hbHealInTxt==2 then
                bthlthdelta=button.health.current+healInTxt
            else
                bthlthdelta=button.health.current;
            end
            if bthlthdelta>-2 and bthlthdelta<2 then bthlthdelta=0 end
            bthlthdelta, ahtNumSuffix=HealBot_Text_shortHealTxt(bthlthdelta, button.frame)
            if healInTxt>0 and hbHealInTxt==3 then
                tConcat[1]=" "
                tConcat[2]=hbNumFormats["SurroundLeft"][button.frame]
                tConcat[3]=bthlthdelta
                tConcat[4]=ahtNumSuffix
                tConcat[5]=hbNumFormats["SurroundRight"][button.frame]
                healInTxt, ahtNumSuffix=HealBot_Text_shortHealTxt(healInTxt, button.frame)
                tConcat[6]=" +"
                tConcat[7]=healInTxt
                tConcat[8]=ahtNumSuffix
                btHBbarText=HealBot_Text_Concat(4)
            else
                tConcat[1]=" "
                tConcat[2]=hbNumFormats["SurroundLeft"][button.frame]
                tConcat[3]=bthlthdelta
                tConcat[4]=ahtNumSuffix
                tConcat[5]=hbNumFormats["SurroundRight"][button.frame]
                btHBbarText=HealBot_Text_Concat(5)
            end
        elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["HLTHTYPE"]==2 then
            if hbHealInTxt==2 then
                bthlthdelta=(button.health.current+healInTxt)-button.health.max;
            else
                bthlthdelta=button.health.current-button.health.max;
            end
            bthlthdelta, ahtNumSuffix=HealBot_Text_shortHealTxt(bthlthdelta, button.frame)
            if bthlthdelta>0 then
                tConcat[1]=" "
                tConcat[2]=hbNumFormats["SurroundLeft"][button.frame]
                tConcat[3]="+"
                tConcat[4]=bthlthdelta
                tConcat[5]=ahtNumSuffix
                tConcat[6]=hbNumFormats["SurroundRight"][button.frame]
                btHBbarText=HealBot_Text_Concat(6)
            else
                tConcat[1]=" "
                tConcat[2]=hbNumFormats["SurroundLeft"][button.frame]
                tConcat[3]=bthlthdelta
                tConcat[4]=ahtNumSuffix
                tConcat[5]=hbNumFormats["SurroundRight"][button.frame]
                btHBbarText=HealBot_Text_Concat(5)
            end
            if hbHealInTxt==3 and healInTxt>0 then
                healInTxt, ahtNumSuffix=HealBot_Text_shortHealTxt(healInTxt, button.frame)
                tConcat[1]=btHBbarText
                tConcat[2]=" +"
                tConcat[3]=healInTxt
                tConcat[4]=ahtNumSuffix
                btHBbarText=HealBot_Text_Concat(4)
            end
        else
            if hbHealInTxt==2 then
                vHealthTextHealInPct=floor(((button.health.current+healInTxt)/button.health.max)*100)
            else
                vHealthTextHealInPct=floor((button.health.current/button.health.max)*100)
            end
            if hbHealInTxt==3 and floor((healInTxt/button.health.max)*100)>0 then
                tConcat[1]=" "
                tConcat[2]=hbNumFormats["SurroundLeft"][button.frame]
                tConcat[3]=vHealthTextHealInPct
                tConcat[4]="%"
                tConcat[5]=hbNumFormats["SurroundRight"][button.frame]
                tConcat[6]=" +"
                tConcat[7]=floor((healInTxt/button.health.max)*100)
                tConcat[8]="%"
                btHBbarText=HealBot_Text_Concat(4)
            else
                tConcat[1]=" "
                tConcat[2]=hbNumFormats["SurroundLeft"][button.frame]
                tConcat[3]=vHealthTextHealInPct
                tConcat[4]="%"
                tConcat[5]=hbNumFormats["SurroundRight"][button.frame]
                btHBbarText=HealBot_Text_Concat(5)
            end
        end

        ahtVInfo=""
        vVehicleUnit=false
        if HEALBOT_GAME_VERSION>3 and UnitInVehicle(button.unit) then
            vVehicleUnit=HealBot_UnitPet(button.unit)
            if vVehicleUnit then
                vVehicleName=UnitName(vVehicleUnit)
                if vVehicleName then
                    vVehicleHealth=UnitHealth(vVehicleUnit)
                    vVehicleMaxHealth=UnitHealthMax(vVehicleUnit)
                    vVehicleHealthPct = floor((vVehicleHealth/vVehicleMaxHealth)*100)
                    if vVehicleHealthPct < 1 then 
                        vVehicleHealthPct = 1
                    end
                    tConcat[1]="  "
                    tConcat[2]=vVehicleHealthPct
                    ahtVInfo=HealBot_Text_Concat(2)
                    vVehicleStrLen=hbStringLen(hbutf8sub(vVehicleName, "%s+", ""))+1
                    vVehicleBtnLen=hbBarTextLen[button.frame]-vVehicleStrLen
                    if vVehicleBtnLen<1 then
                        tConcat[1]=hbStringSub(vVehicleName,1,hbBarTextLen[button.frame])
                        tConcat[2]='.'
                        tConcat[2]=ahtVInfo
                        ahtVInfo = HealBot_Text_Concat(3)
                    else
                        tConcat[1]=vVehicleName
                        tConcat[2]=ahtVInfo
                        ahtVInfo = HealBot_Text_Concat(2)
                    end
                end
            end
        end
        if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["DOUBLE"] then
            if vVehicleUnit then
                if button.frame<10 and Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][button.frame]["SHOWTEXTPCT"] and button.aggro.threatpct>0 then
                    tConcat[1]=btHBbarText
                    HealBot_Text_addAggro(button)
                    tConcat[7]="\n"
                    tConcat[8]=ahtVInfo
                    btHBbarText=HealBot_Text_Concat(8)
                else
                    tConcat[1]=btHBbarText
                    tConcat[2]="\n"
                    tConcat[3]=ahtVInfo
                    btHBbarText = HealBot_Text_Concat(3)
                end
            elseif button.frame<10 and Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][button.frame]["SHOWTEXTPCT"] and button.aggro.threatpct>0 then
                tConcat[1]="\n"
                tConcat[2]=btHBbarText
                tConcat[3]="  "
                tConcat[4]=aggroNumFormatSurLa[button.frame]
                tConcat[5]=button.aggro.threatpct
                tConcat[6]="%"
                tConcat[7]=aggroNumFormatSurRa[button.frame]
                btHBbarText = HealBot_Text_Concat(7)
            else
                tConcat[1]="\n"
                tConcat[2]=btHBbarText
                btHBbarText = HealBot_Text_Concat(2)
            end
        elseif vVehicleUnit then
            if button.frame<10 and Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][button.frame]["SHOWTEXTPCT"] and button.aggro.threatpct>0 then
                tConcat[1]=btHBbarText
                HealBot_Text_addAggro(button)
                tConcat[7]="\n"
                tConcat[8]=ahtVInfo
                btHBbarText=HealBot_Text_Concat(8)
            else
                tConcat[1]=btHBbarText
                tConcat[2]="\n"
                tConcat[3]=ahtVInfo
                btHBbarText=HealBot_Text_Concat(3)
            end
        elseif button.frame<10 and Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][button.frame]["SHOWTEXTPCT"] and button.aggro.threatpct>0 then
            tConcat[1]=btHBbarText
            HealBot_Text_addAggro(button)
            btHBbarText=HealBot_Text_Concat(6)
        end
    else
        btHBbarText=""
    end
    if vHealthTextPrev~=btHBbarText then
        button.text.health=btHBbarText
        button.text.update=true
    end
    --HealBot_setCall("HealBot_Text_setHealthText")
end

local vSetTextLenWidthAdj,vSetTextLenFontAdj=0,0
function HealBot_Text_setTextLen(curFrame)
    if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][curFrame]["MAXCHARS"]==0 then
        vSetTextLenWidthAdj=0.8
        if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][curFrame]["DOUBLE"] then
            vSetTextLenWidthAdj=1.7
        end
        vSetTextLenFontAdj=hbFontVal[Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][curFrame]["FONT"]] or 2
        hbBarTextLen[curFrame] = floor((vSetTextLenFontAdj*2)+HealBot_Globals.tsadjmod+((Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][curFrame]["WIDTH"]*vSetTextLenWidthAdj)
                                /(Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][curFrame]["HEIGHT"])
                                -(Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][curFrame]["HEIGHT"]/vSetTextLenFontAdj)))
    else
        hbBarTextLen[curFrame] = Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][curFrame]["MAXCHARS"]
    end
    --HealBot_setCall("HealBot_Text_setTextLen")
end

local vNameTagPrev=""
function HealBot_Text_setNameTag(button)
    vNameTagPrev=button.text.tag
    if UnitExists(button.unit) then
        if UnitIsFriend("player",button.unit) then
            if button.status.offline then
                button.text.tag=Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["TAGDC"];
            elseif button.status.current==9 then
                button.text.tag=Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["TAGRIP"];
            elseif button.status.range<1 and button.status.range>-2 then
                button.text.tag=Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["TAGOOR"];
            else
                button.text.tag=""
            end
        else
            button.text.tag=""
        end
    else
        button.text.tag=Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["TAGR"]
    end
    if button.text.tag~=vNameTagPrev then
        button.text.update=true
    end
    --HealBot_setCall("HealBot_Text_setNameTag")
end

local vSetNameTextName,vSetNameTextClass,vSetNameTextRole,vSetNameTextStrLen,vSetNameTextBtnLen="","","",0,0
function HealBot_Text_setNameText(button)
    if UnitExists(button.unit) then
        if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["CLASSONBAR"] and Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["CLASSTYPE"]==2 and UnitClass(button.unit) then
            vSetNameTextClass=UnitClass(button.unit)
            if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["SHOWROLE"] then
                vSetNameTextRole=HealBot_Panel_UnitRole(button.unit, button.guid)
                if vSetNameTextRole=="DAMAGER" then
                    vSetNameTextClass=HEALBOT_WORD_DAMAGER
                elseif vSetNameTextRole=="HEALER" then
                    vSetNameTextClass=HEALBOT_WORD_HEALER
                elseif vSetNameTextRole=="TANK" then
                    vSetNameTextClass=HEALBOT_WORD_TANK
                end
            end
            if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["NAMEONBAR"] then
                tConcat[1]=vSetNameTextClass
                tConcat[2]=":"
                tConcat[3]=HealBot_GetUnitName(button.unit, button.guid)
                vSetNameTextName=HealBot_Text_Concat(3)
            else
                vSetNameTextName=vSetNameTextClass;
            end
        elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["NAMEONBAR"] then
            if Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][button.frame]["SHOWTEXT"] and button.aggro.status<4 and 
                   (button.aggro.status or 0)>Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][button.frame]["ALERT"] and vSetNameTextName then
                tConcat[1]=">> "
                tConcat[2]=HealBot_GetUnitName(button.unit, button.guid)
                tConcat[3]=" <<"
                vSetNameTextName=HealBot_Text_Concat(3)
            else
                vSetNameTextName=HealBot_GetUnitName(button.unit, button.guid)
            end
        end
    else
        vSetNameTextName=button.unit
        HealBot_Action_Refresh(button)
    end

    vSetNameTextStrLen=hbStringLen(hbutf8sub(vSetNameTextName, "%s+", ""))+1
    vSetNameTextBtnLen=hbBarTextLen[button.frame]-vSetNameTextStrLen
    if vSetNameTextBtnLen<1 then
        tConcat[1]=hbStringSub(vSetNameTextName,1,hbBarTextLen[button.frame])
        tConcat[2]='.'
        vSetNameTextName = HealBot_Text_Concat(2)
    end
    if button.text.name~=vSetNameTextName then
        button.text.name=vSetNameTextName
        button.text.update=true
    end
    --HealBot_setCall("HealBot_Text_setNameText")
end

local atR, atG, atB, atA, atBar, atBatText, atConcat=0, 0, 0, 0, "", "", ""
function HealBot_Text_SetText(button)
    if button.text.update then
        button.text.update=false
        tConcat[1]="HealBot_Action_HealUnit"
        tConcat[2]=button.id
        tConcat[3]="Bar"
        tConcat[4]="_text"
        atConcat=HealBot_Text_Concat(4)
        atBatText = _G[atConcat];
        if button.status.enabled then
            atA=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["EA"]
        else
            atA=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["DA"]
        end
        atR, atG, atB = HealBot_Text_TextColours(button)
        if UnitExists(button.unit) and atR then
            atBatText:SetTextColor(atR, atG, atB, atA)
        else
            atBatText:SetTextColor(0.5, 0.5, 0.5, 0.8)
        end
        if UnitExists(button.unit) then
            tConcat[1]=button.text.tag
            tConcat[2]=button.text.name
            tConcat[3]=button.text.health
            atConcat=HealBot_Text_Concat(3)
            atBatText:SetText(atConcat);
        else
            tConcat[1]=button.text.tag
            tConcat[2]=button.text.name
            atConcat=HealBot_Text_Concat(2)
            atBatText:SetText(atConcat)
        end
    end
    --HealBot_setCall("HealBot_Text_SetText")
end

function HealBot_Text_UpdateButtons()
    for _,xButton in pairs(HealBot_Unit_Button) do
        xButton.text.update=true
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        xButton.text.update=true
    end
    for _,xButton in pairs(HealBot_Enemy_Button) do
        xButton.text.update=true
    end
end
