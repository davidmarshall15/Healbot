local hbBarTextLen={[1]=50,[2]=50,[3]=50,[4]=50,[5]=50,[6]=50,[7]=50,[8]=50,[9]=50,[10]=50}
local hbBarHealthTextLen={[1]=50,[2]=50,[3]=50,[4]=50,[5]=50,[6]=50,[7]=50,[8]=50,[9]=50,[10]=50}
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
                      ["SuffixK"]       = {[1]="", [2]="", [3]="", [4]="", [5]="", [6]="", [7]="", [8]="", [9]="", [10]=""},
                      ["SuffixM"]       = {[1]="", [2]="", [3]="", [4]="", [5]="", [6]="", [7]="", [8]="", [9]="", [10]=""},
                     }
local aggroNumFormatSurLa={[1]="[",[2]="[",[3]="[",[4]="[",[5]="[",[6]="[",[7]="[",[8]="[",[9]="[",}
local aggroNumFormatSurRa={[1]="]",[2]="]",[3]="]",[4]="]",[5]="]",[6]="]",[7]="]",[8]="]",[9]="]",}
local HealBot_Text_EnemySizeWidth={}
HealBot_Text_EnemySizeWidth["NAME"]={}
HealBot_Text_EnemySizeWidth["HLTH"]={}
HealBot_Text_EnemySizeWidth["NAME"][1]=10
HealBot_Text_EnemySizeWidth["NAME"][2]=10
HealBot_Text_EnemySizeWidth["HLTH"][1]=10
HealBot_Text_EnemySizeWidth["HLTH"][2]=10

local vShortChars={}
vShortChars["LowerK"]="k"
vShortChars["UpperK"]="K"
vShortChars["LowerM"]="m"
vShortChars["UpperM"]="M"

local vTextChars={}
vTextChars["Nothing"]=""
vTextChars["Space"]=" "
vTextChars["DoubleSpace"]="  "
vTextChars["Percent"]="%"
vTextChars["Plus"]="+"
vTextChars["Newline"]="\n"
vTextChars["Dot"]="."
vTextChars["Caret"]="^"
vTextChars["Colon"]=":"
vTextChars["AggroLeft"]=">"
vTextChars["AggroRight"]="<"

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
    if "string" == type( v ) then
        return hbStringLen(v)
    else
        return 0
    end
end

local tConcat={}
local tabconcat=table.concat
function HealBot_Text_Concat(elements)
    return tabconcat(tConcat,"",1,elements)
end

local tHealthConcat={}
local tabconcat=table.concat
function HealBot_Text_HealthConcat(elements)
    return tabconcat(tHealthConcat,"",1,elements)
end

local vSetTextLenWidthAdj,vSetTextLenFontAdj=1.1,0
function HealBot_Text_setEnemyTextLen(bWidth, eBarID)
    if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][10]["MAXCHARS"]==0 then
        vSetTextLenFontAdj=hbFontVal[Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][10]["FONT"]] or 2
        HealBot_Text_EnemySizeWidth["NAME"][eBarID] = floor((vSetTextLenFontAdj*2)+HealBot_Globals.tsadjmod+((bWidth*vSetTextLenWidthAdj)
                                /(Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][10]["HEIGHT"])
                                -(Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][10]["HEIGHT"]/vSetTextLenFontAdj)))
        vSetTextLenFontAdj=hbFontVal[Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][10]["HFONT"]] or 2
        HealBot_Text_EnemySizeWidth["HLTH"][eBarID] = floor((vSetTextLenFontAdj*2)+HealBot_Globals.tsadjmod+((bWidth*vSetTextLenWidthAdj)
                                /(Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][10]["HHEIGHT"])
                                -(Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][10]["HHEIGHT"]/vSetTextLenFontAdj)))
    else
        HealBot_Text_EnemySizeWidth["NAME"][eBarID] = Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][10]["MAXCHARS"]
        HealBot_Text_EnemySizeWidth["HLTH"][eBarID] = Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][10]["HMAXCHARS"]
    end
    if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][10]["HLTHTXTANCHOR"]==2 then
        HealBot_Text_EnemySizeWidth["HLTH"][eBarID] = floor(HealBot_Text_EnemySizeWidth["HLTH"][eBarID]*0.58)
    elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][10]["HLTHTXTANCHOR"]==3 then
        HealBot_Text_EnemySizeWidth["HLTH"][eBarID] = floor(HealBot_Text_EnemySizeWidth["HLTH"][eBarID]*0.52)
    end
end

function HealBot_Text_setTextLen(curFrame)
    if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][curFrame]["MAXCHARS"]==0 then
        vSetTextLenFontAdj=hbFontVal[Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][curFrame]["FONT"]] or 2
        hbBarTextLen[curFrame] = floor((vSetTextLenFontAdj*2)+HealBot_Globals.tsadjmod+((Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][curFrame]["WIDTH"]*vSetTextLenWidthAdj)
                                /(Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][curFrame]["HEIGHT"])
                                -(Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][curFrame]["HEIGHT"]/vSetTextLenFontAdj)))
    else
        hbBarTextLen[curFrame] = Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][curFrame]["MAXCHARS"]
    end
    if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][curFrame]["HMAXCHARS"]==0 then
        vSetTextLenFontAdj=hbFontVal[Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][curFrame]["HFONT"]] or 2
        hbBarHealthTextLen[curFrame] = floor((vSetTextLenFontAdj*2)+HealBot_Globals.tsadjmod+((Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][curFrame]["WIDTH"]*vSetTextLenWidthAdj)
                                /(Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][curFrame]["HHEIGHT"])
                                -(Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][curFrame]["HHEIGHT"]/vSetTextLenFontAdj)))
    else
        hbBarHealthTextLen[curFrame] = Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][curFrame]["HMAXCHARS"]
    end
    if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][curFrame]["MAXCHARS"]==0 then
        if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][curFrame]["HLTHTXTANCHOR"]==2 then
            hbBarTextLen[curFrame] = floor(hbBarTextLen[curFrame]*(0.82+(Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][curFrame]["HOFFSET2"]/100)))
            hbBarHealthTextLen[curFrame] = floor(hbBarHealthTextLen[curFrame]*(0.52+(Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][curFrame]["HOFFSET2"]/100)))
        elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][curFrame]["HLTHTXTANCHOR"]==3 then
            hbBarTextLen[curFrame] = floor(hbBarTextLen[curFrame]*(0.82+(Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][curFrame]["HOFFSET2"]/100)))
            hbBarHealthTextLen[curFrame] = floor(hbBarHealthTextLen[curFrame]*(0.52+(Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][curFrame]["HOFFSET2"]/100)))
        end
    end
      --HealBot_setCall("HealBot_Text_setTextLen")
end

function HealBot_Text_setEnemySizeWidth(vName, vValue)
    if vName=="EnemySizeWidth1" then
        HealBot_Text_setEnemyTextLen(vValue, 1)
    else
        HealBot_Text_setEnemyTextLen(vValue, 2)
    end
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
            hbNumFormats["SuffixK"][j]=vShortChars["UpperK"]
            hbNumFormats["SuffixM"][j]=vShortChars["UpperM"]
        elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][j]["NUMFORMAT1"]>4 and Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][j]["NUMFORMAT1"]<8 then
            hbNumFormats["SuffixK"][j]=vShortChars["LowerK"]
            hbNumFormats["SuffixM"][j]=vShortChars["LowerM"]
        elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][j]["NUMFORMAT1"]==11 then
            hbNumFormats["SuffixK"][j]=vShortChars["UpperK"]
            hbNumFormats["SuffixM"][j]=vShortChars["UpperM"]
        else
            hbNumFormats["SuffixK"][j]=vTextChars["Nothing"]
            hbNumFormats["SuffixM"][j]=vTextChars["Nothing"]
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
            hbNumFormats["SuffixK"][j]=vTextChars["Nothing"]
            hbNumFormats["SuffixM"][j]=vTextChars["Nothing"]
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
function HealBot_Text_TextNameColours(button)
    if button.status.current==9 then
        if UnitHasIncomingResurrection(button.unit) then
            atcR,atcG,atcB=0.2, 1.0, 0.2
        elseif UnitIsFriend("player",button.unit) and not hbGUID~=HealBot_Data["PGUID"] then
            if UnitIsUnit(button.unit, "player") then
                atcR,atcG,atcB=0.7, 0.4, 0.4
            elseif button.status.range > 0 or UnitInRange(button.unit) then
                atcR,atcG,atcB=1.0, 0.2, 0.2
            else
                atcR,atcG,atcB=0.5, 0.5, 0.5
            end
        else
            atcR,atcG,atcB=0.4, 0.4, 0.4
        end
    elseif Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["NAME"]==3 or
      ( Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["NDEBUFF"] and button.aura.debuff.type) then
        atcR=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["NCR"];
        atcG=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["NCG"];
        atcB=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["NCB"];
    elseif Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["NAME"]==2 then
        atcR=button.text.r
        atcG=button.text.g
        atcB=button.text.b
    else
        atcR=button.health.rcol
        atcG=button.health.gcol
        atcB=0
    end
      --HealBot_setCall("HealBot_Text_TextNameColours")
    return atcR,atcG,atcB
end

local athcR, athcG, athcB=1,1,1
function HealBot_Text_TextHealthColours(button)
    if Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["HLTH"]==3 or
      ( Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["HDEBUFF"] and button.aura.debuff.type) then
        athcR=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["HCR"];
        athcG=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["HCG"];
        athcB=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["HCB"];
    elseif Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["HLTH"]==2 then
        athcR=button.text.r
        athcG=button.text.g
        athcB=button.text.b
    else
        athcR=button.health.rcol
        athcG=button.health.gcol
        athcB=0
    end
      --HealBot_setCall("HealBot_Text_TextNameColours")
    return athcR,athcG,athcB
end

local vShortHealTxtIsK,vShortHealTxtAmount,vShortHealTxtSuffix,vShortHealTxtAbsNum=true,0,"",0
local hbAbs=math.abs
function HealBot_Text_shortHealTxt(amount, hbCurFrame)
    vShortHealTxtAbsNum=hbAbs(amount)
    if vShortHealTxtAbsNum>999 and hbNumFormats["Places"][hbCurFrame]>-1 then
        if hbNumFormats["Places"][hbCurFrame]<3 then 
            if vShortHealTxtAbsNum>999999 then
                vShortHealTxtAmount=HealBot_Comm_round(amount/1000000,hbNumFormats["Places"][hbCurFrame]) 
                vShortHealTxtSuffix=hbNumFormats["SuffixM"][hbCurFrame]
            else
                vShortHealTxtAmount=HealBot_Comm_round(amount/1000,hbNumFormats["Places"][hbCurFrame]) 
                vShortHealTxtSuffix=hbNumFormats["SuffixK"][hbCurFrame]
            end
        else
            if vShortHealTxtAbsNum>9999999 then
                vShortHealTxtAmount=HealBot_Comm_round(amount/1000000,0)
                vShortHealTxtSuffix=hbNumFormats["SuffixM"][hbCurFrame]
            elseif vShortHealTxtAbsNum>999999 then
                vShortHealTxtAmount=HealBot_Comm_round(amount/1000000,1)
                vShortHealTxtSuffix=hbNumFormats["SuffixM"][hbCurFrame]
            elseif vShortHealTxtAbsNum>9999 then
                vShortHealTxtAmount=HealBot_Comm_round(amount/1000,0)
                vShortHealTxtSuffix=hbNumFormats["SuffixK"][hbCurFrame]
            else
                vShortHealTxtAmount=HealBot_Comm_round(amount/1000,1)
                vShortHealTxtSuffix=hbNumFormats["SuffixK"][hbCurFrame]
            end
        end
        return vShortHealTxtAmount, vShortHealTxtSuffix
    else
        return amount, vTextChars["Nothing"]
    end
      --HealBot_setCall("HealBot_Text_shortHealTxt")
end

local vHealthTextConcatIndex,vHealthTextConcatResult,vSetHealthTextStrLen,vSetHealthTextBtnLen=0,"",0,0
local vHealthTextTotal,sepHealTxt,absorbinTxt,ahtNumSuffix,ahitNumSuffix,ignoreInHeals=0,0,0,"","",false
function HealBot_Text_setHealthText(button)
    if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["HLTHONBAR"] and button.health.max then
        tHealthConcat[1]=hbNumFormats["SurroundLeft"][button.frame]
        if button.status.current<9 and (Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["IGNOREONFULL"] and 
          button.health.current==button.health.max) then
            ignoreInHeals=true
        else
            ignoreInHeals=false
        end
        if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["HLTHTYPE"]==1 then
            if ignoreInHeals then
                vHealthTextTotal=button.health.current
            else
                if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["INCHEALS"]==2 then
                    if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["INCABSORBS"]==2 then
                        vHealthTextTotal=button.health.current+button.health.incoming+button.health.absorbs
                    else
                        vHealthTextTotal=button.health.current+button.health.incoming
                    end
                elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["INCABSORBS"]==2 then
                    vHealthTextTotal=button.health.current+button.health.absorbs
                else
                    vHealthTextTotal=button.health.current
                end
            end
            if ignoreInHeals then
                sepHealTxt=0
            else
                if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["INCHEALS"]==3 then
                    if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["INCABSORBS"]==3 then
                        sepHealTxt=button.health.incoming+button.health.absorbs
                    else
                        sepHealTxt=button.health.incoming
                    end
                elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["INCABSORBS"]==3 then
                    sepHealTxt=button.health.absorbs
                else
                    sepHealTxt=0
                end
            end
            vHealthTextTotal, ahtNumSuffix=HealBot_Text_shortHealTxt(vHealthTextTotal, button.frame)
            tHealthConcat[2]=vHealthTextTotal
            tHealthConcat[3]=ahtNumSuffix
            tHealthConcat[4]=hbNumFormats["SurroundRight"][button.frame]
            if sepHealTxt>0 then
                sepHealTxt, ahitNumSuffix=HealBot_Text_shortHealTxt(sepHealTxt, button.frame)
                tHealthConcat[5]=vTextChars["Space"]
                tHealthConcat[6]=vTextChars["Plus"]
                tHealthConcat[7]=sepHealTxt
                tHealthConcat[8]=ahitNumSuffix
                vHealthTextConcatIndex=8
            else
                vHealthTextConcatIndex=4
            end
            if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["OVERHEAL"]>1 and button.health.overheal>0 then
                sepHealTxt, ahitNumSuffix=HealBot_Text_shortHealTxt(button.health.overheal, button.frame)
                tHealthConcat[vHealthTextConcatIndex+1]=vTextChars["Space"]
                tHealthConcat[vHealthTextConcatIndex+2]=vTextChars["Caret"]
                tHealthConcat[vHealthTextConcatIndex+3]=sepHealTxt
                tHealthConcat[vHealthTextConcatIndex+4]=ahitNumSuffix
                vHealthTextConcatIndex=vHealthTextConcatIndex+4
            end
        elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["HLTHTYPE"]==2 then
            if ignoreInHeals then
                vHealthTextTotal=button.health.current-button.health.max
            else
                if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["INCHEALS"]==2 then
                    if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["INCABSORBS"]==2 then
                        vHealthTextTotal=(button.health.current+button.health.incoming+button.health.absorbs)-button.health.max
                    else
                        vHealthTextTotal=(button.health.current+button.health.incoming)-button.health.max
                    end
                elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["INCABSORBS"]==2 then
                    vHealthTextTotal=(button.health.current+button.health.absorbs)-button.health.max
                else
                    vHealthTextTotal=button.health.current-button.health.max
                end
            end
            if ignoreInHeals then
                sepHealTxt=0
            else
                if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["INCHEALS"]==3 then
                    if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["INCABSORBS"]==3 then
                        sepHealTxt=button.health.incoming+button.health.absorbs
                    else
                        sepHealTxt=button.health.incoming
                    end
                elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["INCABSORBS"]==3 then
                    sepHealTxt=button.health.absorbs
                else
                    sepHealTxt=0
                end
            end
            vHealthTextTotal, ahtNumSuffix=HealBot_Text_shortHealTxt(vHealthTextTotal, button.frame)
            if vHealthTextTotal>0 then
                tHealthConcat[2]=vTextChars["Plus"]
            else
                tHealthConcat[2]=vTextChars["Nothing"]
            end
            tHealthConcat[3]=vHealthTextTotal
            tHealthConcat[4]=ahtNumSuffix
            tHealthConcat[5]=hbNumFormats["SurroundRight"][button.frame]
            if sepHealTxt>0 then
                sepHealTxt, ahitNumSuffix=HealBot_Text_shortHealTxt(sepHealTxt, button.frame)
                tHealthConcat[6]=vTextChars["Space"]
                tHealthConcat[7]=vTextChars["Plus"]
                tHealthConcat[8]=sepHealTxt
                tHealthConcat[9]=ahitNumSuffix
                vHealthTextConcatIndex=9
            else
                vHealthTextConcatIndex=5
            end
            if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["OVERHEAL"]>1 and button.health.overheal>0 then
                sepHealTxt, ahitNumSuffix=HealBot_Text_shortHealTxt(button.health.overheal, button.frame)
                tHealthConcat[vHealthTextConcatIndex+1]=vTextChars["Space"]
                tHealthConcat[vHealthTextConcatIndex+2]=vTextChars["Caret"]
                tHealthConcat[vHealthTextConcatIndex+3]=sepHealTxt
                tHealthConcat[vHealthTextConcatIndex+4]=ahitNumSuffix
                vHealthTextConcatIndex=vHealthTextConcatIndex+4
            end
        else
            if ignoreInHeals then
                vHealthTextTotal=floor((button.health.current/button.health.max)*100)
            else
                if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["INCHEALS"]==2 then
                    if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["INCABSORBS"]==2 then
                        vHealthTextTotal=floor(((button.health.current+button.health.incoming+button.health.absorbs)/button.health.max)*100)
                    else
                        vHealthTextTotal=floor(((button.health.current+button.health.incoming)/button.health.max)*100)
                    end
                elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["INCABSORBS"]==2 then
                    vHealthTextTotal=floor(((button.health.current+button.health.absorbs)/button.health.max)*100)
                else
                    vHealthTextTotal=floor((button.health.current/button.health.max)*100)
                end
            end
            if ignoreInHeals then
                sepHealTxt=0
            else
                if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["INCHEALS"]==3 then
                    if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["INCABSORBS"]==3 then
                        sepHealTxt=button.health.incoming+button.health.absorbs
                    else
                        sepHealTxt=button.health.incoming
                    end
                elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["INCABSORBS"]==3 then
                    sepHealTxt=button.health.absorbs
                else
                    sepHealTxt=0
                end
            end
            tHealthConcat[2]=vHealthTextTotal
            tHealthConcat[3]=vTextChars["Percent"]
            tHealthConcat[4]=hbNumFormats["SurroundRight"][button.frame]
            if floor((sepHealTxt/button.health.max)*100)>0 then
                tHealthConcat[5]=vTextChars["Space"]
                tHealthConcat[6]=vTextChars["Plus"]
                tHealthConcat[7]=floor((sepHealTxt/button.health.max)*100)
                tHealthConcat[8]=vTextChars["Percent"]
                vHealthTextConcatIndex=8
            else
                vHealthTextConcatIndex=4
            end
            if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["OVERHEAL"]>1 and 
               floor((button.health.overheal/button.health.max)*100)>0 then
                tHealthConcat[vHealthTextConcatIndex+1]=vTextChars["Space"]
                tHealthConcat[vHealthTextConcatIndex+2]=vTextChars["Caret"]
                tHealthConcat[vHealthTextConcatIndex+3]=floor((button.health.overheal/button.health.max)*100)
                tHealthConcat[vHealthTextConcatIndex+4]=vTextChars["Percent"]
                vHealthTextConcatIndex=vHealthTextConcatIndex+4
            end
        end
        if button.frame<10 and Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][button.frame]["SHOWTEXTPCT"] and button.aggro.threatpct>0 then
            tHealthConcat[vHealthTextConcatIndex+1]=vTextChars["DoubleSpace"]
            tHealthConcat[vHealthTextConcatIndex+2]=aggroNumFormatSurLa[button.frame]
            tHealthConcat[vHealthTextConcatIndex+3]=button.aggro.threatpct
            tHealthConcat[vHealthTextConcatIndex+4]=vTextChars["Percent"]
            tHealthConcat[vHealthTextConcatIndex+5]=aggroNumFormatSurRa[button.frame]
            vHealthTextConcatIndex=vHealthTextConcatIndex+5
        end
        vHealthTextConcatResult=HealBot_Text_HealthConcat(vHealthTextConcatIndex)

        vSetHealthTextStrLen=hbStringLen(hbutf8sub(vHealthTextConcatResult, "%s+", ""))
        if HealBot_Panel_isSpecialUnit(button.unit)>0 then
            vSetHealthTextBtnLen=HealBot_Text_EnemySizeWidth["HLTH"][HealBot_Panel_isSpecialUnit(button.unit)]-vSetHealthTextStrLen
        else
            vSetHealthTextBtnLen=hbBarHealthTextLen[button.frame]-vSetHealthTextStrLen
        end
        if vSetHealthTextBtnLen<0 then
            if HealBot_Panel_isSpecialUnit(button.unit)>0 then
                tConcat[1]=hbStringSub(vHealthTextConcatResult,1,HealBot_Text_EnemySizeWidth["HLTH"][HealBot_Panel_isSpecialUnit(button.unit)])
            else
                tConcat[1]=hbStringSub(vHealthTextConcatResult,1,hbBarHealthTextLen[button.frame])
            end
            tConcat[2]=vTextChars["Dot"]
            vHealthTextConcatResult = HealBot_Text_Concat(2)
        end

        if button.text.health~=vHealthTextConcatResult then
            button.text.health=vHealthTextConcatResult
            button.text.healthupdate=true
            if Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["NAME"]==1 then
                button.text.nameupdate=true
            end
        end
    else
        if button.text.health~=vTextChars["Nothing"] then
            button.text.health=vTextChars["Nothing"]
            button.text.healthupdate=true
        end
        if Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["NAME"]==1 and 
           Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["NAMEONBAR"] then
            button.text.nameupdate=true
        end
    end
      --HealBot_setCall("HealBot_Text_setHealthText")
end

local prevTag=""
function HealBot_Text_setNameTag(button)
    prevTag=button.text.tag
    if UnitExists(button.unit) then
        if UnitIsFriend("player",button.unit) then
            if button.status.offline then
                button.text.tag=Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["TAGDC"];
            elseif button.status.current==9 then
                button.text.tag=Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["TAGRIP"];
            elseif button.status.range<1 and button.status.range>-2 then
                button.text.tag=Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["TAGOOR"];
            else
                button.text.tag=vTextChars["Nothing"]
            end
        else
            button.text.tag=vTextChars["Nothing"]
        end
    else
        button.text.tag=Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["TAGR"]
    end
    if prevTag~=button.text.tag then
        HealBot_Text_setNameText(button)
    end
      --HealBot_setCall("HealBot_Text_setNameTag")
end

local vSetNameTextName,vSetNameTextClass,vSetNameTextRole,vSetNameTextStrLen,vSetNameTextBtnLen,vHealthTextConcatIndex="","","",0,0,0
function HealBot_Text_setNameText(button)
    if UnitExists(button.unit) then
        if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["CLASSONBAR"] and UnitClass(button.unit) then
            if button.text.tag then
                tConcat[1]=button.text.tag
                vHealthTextConcatIndex=1
            else
                vHealthTextConcatIndex=0
            end
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
                tConcat[vHealthTextConcatIndex+1]=vSetNameTextClass
                tConcat[vHealthTextConcatIndex+2]=vTextChars["Colon"]
                tConcat[vHealthTextConcatIndex+3]=HealBot_GetUnitName(button.unit, button.guid)
                vSetNameTextName=HealBot_Text_Concat(vHealthTextConcatIndex+3)
            elseif vHealthTextConcatIndex>0 then
                tConcat[2]=vSetNameTextClass
                vSetNameTextName=HealBot_Text_Concat(2)
            else
                vSetNameTextName=vSetNameTextClass;
            end
        elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["NAMEONBAR"] then
            if button.text.tag then
                tConcat[1]=button.text.tag
                vHealthTextConcatIndex=1
            else
                vHealthTextConcatIndex=0
            end
            if Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][button.frame]["SHOWTEXT"] and 
                   (button.aggro.status or 0)>Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][button.frame]["ALERT"] then
                tConcat[vHealthTextConcatIndex+1]=vTextChars["AggroLeft"]
                tConcat[vHealthTextConcatIndex+2]=HealBot_GetUnitName(button.unit, button.guid)
                tConcat[vHealthTextConcatIndex+3]=vTextChars["AggroRight"]
                vSetNameTextName=HealBot_Text_Concat(vHealthTextConcatIndex+3)
            elseif vHealthTextConcatIndex>0 then
                tConcat[2]=HealBot_GetUnitName(button.unit, button.guid)
                vSetNameTextName=HealBot_Text_Concat(2)
            else
                vSetNameTextName=HealBot_GetUnitName(button.unit, button.guid)
            end
        elseif button.text.tag then
            vSetNameTextName=button.text.tag
        else
            vSetNameTextName=vTextChars["Nothing"]
        end
    else
        if button.text.tag then
            tConcat[1]=button.text.tag
            tConcat[2]=button.unit
            vSetNameTextName=HealBot_Text_Concat(2)
        else
            vSetNameTextName=button.unit
        end
    end

    vSetNameTextStrLen=hbStringLen(hbutf8sub(vSetNameTextName, "%s+", ""))
    if HealBot_Panel_isSpecialUnit(button.unit)>0 then
        vSetNameTextBtnLen=HealBot_Text_EnemySizeWidth["NAME"][HealBot_Panel_isSpecialUnit(button.unit)]-vSetNameTextStrLen
    else
        vSetNameTextBtnLen=hbBarTextLen[button.frame]-vSetNameTextStrLen
    end
    if vSetNameTextBtnLen<0 then
        if HealBot_Panel_isSpecialUnit(button.unit)>0 then
            tConcat[1]=hbStringSub(vSetNameTextName,1,HealBot_Text_EnemySizeWidth["NAME"][HealBot_Panel_isSpecialUnit(button.unit)])
        else
            tConcat[1]=hbStringSub(vSetNameTextName,1,hbBarTextLen[button.frame])
        end
        tConcat[2]=vTextChars["Dot"]
        vSetNameTextName = HealBot_Text_Concat(2)
    end
    if button.text.name~=vSetNameTextName then
        button.text.name=vSetNameTextName
        button.text.nameupdate=true
    end
      --HealBot_setCall("HealBot_Text_setNameText")
end

local atR, atG, atB, atA=0, 0, 0, 0
function HealBot_Text_SetText(button)
    if button.text.nameupdate then
        button.text.nameupdate=false
        if UnitExists(button.unit) then
            if button.status.enabled then
                atA=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["NCA"]
            else
                atA=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["NCDA"]
            end
            atR, atG, atB = HealBot_Text_TextNameColours(button)
            button.gref.txt["text"]:SetTextColor(atR, atG, atB, atA)
        else
            button.gref.txt["text"]:SetTextColor(0.5, 0.5, 0.5, 0.8)
        end
        button.gref.txt["text"]:SetText(button.text.name);
    end
    if button.text.healthupdate then
        button.text.healthupdate=false
        if UnitExists(button.unit) then
            if button.status.enabled then
                atA=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["HCA"]
            else
                atA=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["HCDA"]
            end
            atR, atG, atB = HealBot_Text_TextHealthColours(button)
            button.gref.txt["text2"]:SetTextColor(atR, atG, atB, atA)
        else
            button.gref.txt["text2"]:SetTextColor(0, 0, 0, 0)
        end
        button.gref.txt["text2"]:SetText(button.text.health)
    end
      --HealBot_setCall("HealBot_Text_SetText")
end

function HealBot_Text_UpdateNames()
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_Text_setNameText(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_Text_setNameText(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_Text_setNameText(xButton)
    end
    for _,xButton in pairs(HealBot_Enemy_Button) do
        HealBot_Text_setNameText(xButton)
    end
end

function HealBot_Text_UpdateButton(button)
    button.text.nameupdate=true
    button.text.healthupdate=true
end

function HealBot_Text_UpdateButtons()
    for _,xButton in pairs(HealBot_Unit_Button) do
        xButton.text.nameupdate=true
        xButton.text.healthupdate=true
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        xButton.text.nameupdate=true
        xButton.text.healthupdate=true
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        xButton.text.nameupdate=true
        xButton.text.healthupdate=true
    end
    for _,xButton in pairs(HealBot_Enemy_Button) do
        xButton.text.nameupdate=true
        xButton.text.healthupdate=true
    end
end
