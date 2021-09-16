local HealBot_Fluid_TextNameAlpha={}
local HealBot_Fluid_TextHealthAlpha={}
local HealBot_Fluid_TextHealthAlpha={}
local hbBarTextLen={[1]=50,[2]=50,[3]=50,[4]=50,[5]=50,[6]=50,[7]=50,[8]=50,[9]=50,[10]=50}
local hbBarHealthTextLen={[1]=50,[2]=50,[3]=50,[4]=50,[5]=50,[6]=50,[7]=50,[8]=50,[9]=50,[10]=50}
local hbSeparateInHealsAbsorbs={[1]=false,[2]=false,[3]=false,[4]=false,[5]=false,[6]=false,[7]=false,[8]=false,[9]=false,[10]=false}
local hbOverHeal={[1]=false,[2]=false,[3]=false,[4]=false,[5]=false,[6]=false,[7]=false,[8]=false,[9]=false,[10]=false}
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
                      ["OverHealLeft"]  = {[1]="", [2]="", [3]="", [4]="", [5]="", [6]="", [7]="", [8]="", [9]="", [10]=""},
                      ["OverHealRight"] = {[1]="", [2]="", [3]="", [4]="", [5]="", [6]="", [7]="", [8]="", [9]="", [10]=""},
                      ["InHealLeft"]  = {[1]="", [2]="", [3]="", [4]="", [5]="", [6]="", [7]="", [8]="", [9]="", [10]=""},
                      ["InHealRight"] = {[1]="", [2]="", [3]="", [4]="", [5]="", [6]="", [7]="", [8]="", [9]="", [10]=""},
                     }
local hbNameFormats = {["AggroLeft"]  = {[1]="(",[2]="(",[3]="(",[4]="(",[5]="(",[6]="(",[7]="(",[8]="(",[9]="(",[10]="("},
                       ["AggroRight"] = {[1]=")",[2]=")",[3]=")",[4]=")",[5]=")",[6]=")",[7]=")",[8]=")",[9]=")",[10]=")"},
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
vTextChars["GreaterThan"]=">"
vTextChars["LessThan"]="<"
vTextChars["Colon"]=":"

local vTextCustomCols={}
vTextCustomCols["Close"]=_G["FONT_COLOR_CODE_CLOSE"]
vTextCustomCols["OverHeal"]={}
vTextCustomCols["InHeal"]={}
vTextCustomCols["Aggro"]={}
for j=1,10 do
    vTextCustomCols["OverHeal"][j]="|cff77c8ff"
    vTextCustomCols["InHeal"][j]="|cff77c8ff"
    vTextCustomCols["Aggro"][j]="|cff77c8ff"
end

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
local HealBot_Text_luVars={}
HealBot_Text_luVars["FluidInUse"]=false
HealBot_Text_luVars["FluidTextAlphaUpdate"]=0.02
HealBot_Text_luVars["FluidTextAlphaFreq"]=0.088

function HealBot_Text_setLuVars(vName, vValue)
    HealBot_Text_luVars[vName]=vValue
      --HealBot_setCall("HealBot_Text_setLuVars - "..vName)
end

function HealBot_Text_retLuVars(vName)
    return HealBot_Text_luVars[vName]
end

function HealBot_Text_Len(v)
    if "string" == type( v ) then
        return hbStringLen(v)
    else
        return 0
    end
end

function HealBot_Text_Sub(v,s,l)
    return hbStringSub(v,s,l)
end

local tConcat={}
local tabconcat=table.concat
function HealBot_Text_Concat(elements)
    return tabconcat(tConcat,"",1,elements)
end

local tHealthConcat={}
local tShortConcat={}
local tabconcat=table.concat
function HealBot_Text_HealthConcat(elements)
    return tabconcat(tHealthConcat,"",1,elements)
end

function HealBot_Text_ShortConcat()
    return tabconcat(tShortConcat,"",1,2)
end

local vSetTextLenWidthAdj,vSetTextLenFontAdj,vSetTextLenAux=1.1,0
function HealBot_Text_setEnemyTextLen(bWidth, eBarID, tSize)
    if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][10]["MAXCHARS"]==0 then
        vSetTextLenFontAdj=hbFontVal[Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][10]["FONT"]] or 2
        HealBot_Text_EnemySizeWidth["NAME"][eBarID] = floor((vSetTextLenFontAdj*2)+HealBot_Globals.tsadjmod+((bWidth*vSetTextLenWidthAdj)
                                /(Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][10]["HEIGHT"])
                                -(Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][10]["HEIGHT"]/vSetTextLenFontAdj)))
    elseif eBarID==2 then
        HealBot_Text_EnemySizeWidth["NAME"][eBarID] = ceil(Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][10]["MAXCHARS"]*tSize)+1
    else
        HealBot_Text_EnemySizeWidth["NAME"][eBarID] = Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][10]["MAXCHARS"]
    end
    if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][10]["HMAXCHARS"]==0 then
        vSetTextLenFontAdj=hbFontVal[Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][10]["HFONT"]] or 2
        HealBot_Text_EnemySizeWidth["HLTH"][eBarID] = floor((vSetTextLenFontAdj*2)+HealBot_Globals.tsadjmod+((bWidth*vSetTextLenWidthAdj)
                                /(Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][10]["HHEIGHT"])
                                -(Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][10]["HHEIGHT"]/vSetTextLenFontAdj)))
    elseif eBarID==2 then
        HealBot_Text_EnemySizeWidth["HLTH"][eBarID] = ceil(Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][10]["HMAXCHARS"]*tSize)+1
    else
        HealBot_Text_EnemySizeWidth["HLTH"][eBarID] = Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][10]["HMAXCHARS"]
    end
    if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][10]["HLTHTXTANCHOR"]==2 then
        HealBot_Text_EnemySizeWidth["HLTH"][eBarID] = floor(HealBot_Text_EnemySizeWidth["HLTH"][eBarID]*0.58)
    elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][10]["HLTHTXTANCHOR"]==3 then
        HealBot_Text_EnemySizeWidth["HLTH"][eBarID] = floor(HealBot_Text_EnemySizeWidth["HLTH"][eBarID]*0.52)
    end
    for x=1,9 do
        if Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Current_Skin][x][10]["MAXCHARS"]==0 then
            vSetTextLenFontAdj=hbFontVal[Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Current_Skin][x][10]["FONT"]] or 2
            vSetTextLenAux=floor((vSetTextLenFontAdj*2)+HealBot_Globals.tsadjmod+((bWidth*vSetTextLenWidthAdj)
                                /(Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Current_Skin][x][10]["HEIGHT"])
                                -(Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Current_Skin][x][10]["HEIGHT"]/vSetTextLenFontAdj)))
        elseif eBarID==2 then
            vSetTextLenAux=ceil(Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Current_Skin][x][10]["MAXCHARS"]*tSize)+1
        else
            vSetTextLenAux=Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Current_Skin][x][10]["MAXCHARS"]
        end
        HealBot_Aux_setTextMaxChars(10, vSetTextLenAux, x)
    end
end

function HealBot_Text_setTextLen(curFrame)
    if curFrame<10 or not Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["ENEMYTARGET"] then
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
        for x=1,9 do
            if Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Current_Skin][x][curFrame]["MAXCHARS"]==0 then
                vSetTextLenFontAdj=hbFontVal[Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Current_Skin][x][curFrame]["FONT"]] or 2
                vSetTextLenAux=floor((vSetTextLenFontAdj*2)+HealBot_Globals.tsadjmod+((Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][curFrame]["WIDTH"]*vSetTextLenWidthAdj)
                                    /(Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Current_Skin][x][curFrame]["HEIGHT"])
                                    -(Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Current_Skin][x][curFrame]["HEIGHT"]/vSetTextLenFontAdj)))
            else
                vSetTextLenAux=Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Current_Skin][x][curFrame]["MAXCHARS"]
            end
            HealBot_Aux_setTextMaxChars(curFrame, vSetTextLenAux, x)
        end
    end
      --HealBot_setCall("HealBot_Text_setTextLen")
end

function HealBot_Text_setEnemySizeWidth(vName, vValue, tSize)
    if vName=="EnemySizeWidth1" then
        HealBot_Text_setEnemyTextLen(vValue, 1, tSize)
    else
        HealBot_Text_setEnemyTextLen(vValue, 2, tSize)
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
            hbNumFormats["SurroundLeft"][j]=vTextChars["LessThan"]
            hbNumFormats["SurroundRight"][j]=vTextChars["GreaterThan"]
        elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][j]["NUMFORMAT2"]==6 then
            hbNumFormats["SurroundLeft"][j]="~"
            hbNumFormats["SurroundRight"][j]=vTextChars["Nothing"]
        elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][j]["NUMFORMAT2"]==7 then
            hbNumFormats["SurroundLeft"][j]=vTextChars["Colon"]
            hbNumFormats["SurroundRight"][j]=vTextChars["Colon"]
        elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][j]["NUMFORMAT2"]==8 then
            hbNumFormats["SurroundLeft"][j]="*"
            hbNumFormats["SurroundRight"][j]="*"
        else
            hbNumFormats["SurroundLeft"][j]=vTextChars["Nothing"]
            hbNumFormats["SurroundRight"][j]=vTextChars["Nothing"]
        end
        if hbNumFormats["Places"][j]==-1 then
            hbNumFormats["SuffixK"][j]=vTextChars["Nothing"]
            hbNumFormats["SuffixM"][j]=vTextChars["Nothing"]
        end

        hbNumFormats["OverHealLeft"][j]=vTextChars["Nothing"]
        hbNumFormats["OverHealRight"][j]=vTextChars["Nothing"]
        if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][j]["OVERHEALFORMAT"]==2 then
            hbNumFormats["OverHealLeft"][j]="^"
        elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][j]["OVERHEALFORMAT"]==3 then
            hbNumFormats["OverHealLeft"][j]=vTextChars["Plus"]
        elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][j]["OVERHEALFORMAT"]==4 then
            hbNumFormats["OverHealLeft"][j]=vTextChars["LessThan"]
        elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][j]["OVERHEALFORMAT"]==5 then
            hbNumFormats["OverHealLeft"][j]="("
            hbNumFormats["OverHealRight"][j]=")"
        elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][j]["OVERHEALFORMAT"]==6 then
            hbNumFormats["OverHealLeft"][j]="{"
            hbNumFormats["OverHealRight"][j]="}"
        elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][j]["OVERHEALFORMAT"]==7 then
            hbNumFormats["OverHealLeft"][j]="["
            hbNumFormats["OverHealRight"][j]="]"
        elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][j]["OVERHEALFORMAT"]==8 then
            hbNumFormats["OverHealLeft"][j]="<"
            hbNumFormats["OverHealRight"][j]=">"
        elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][j]["OVERHEALFORMAT"]==9 then
            hbNumFormats["OverHealLeft"][j]="="
            hbNumFormats["OverHealRight"][j]="="
        end
        
        hbNumFormats["InHealLeft"][j]=vTextChars["Nothing"]
        hbNumFormats["InHealRight"][j]=vTextChars["Nothing"]
        if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][j]["SEPARATEFORMAT"]==2 then
            hbNumFormats["InHealLeft"][j]="^"
        elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][j]["SEPARATEFORMAT"]==3 then
            hbNumFormats["InHealLeft"][j]=vTextChars["Plus"]
        elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][j]["SEPARATEFORMAT"]==4 then
            hbNumFormats["InHealLeft"][j]=vTextChars["LessThan"]
        elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][j]["SEPARATEFORMAT"]==5 then
            hbNumFormats["InHealLeft"][j]="("
            hbNumFormats["InHealRight"][j]=")"
        elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][j]["SEPARATEFORMAT"]==6 then
            hbNumFormats["InHealLeft"][j]="{"
            hbNumFormats["InHealRight"][j]="}"
        elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][j]["SEPARATEFORMAT"]==7 then
            hbNumFormats["InHealLeft"][j]="["
            hbNumFormats["InHealRight"][j]="]"
        elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][j]["SEPARATEFORMAT"]==8 then
            hbNumFormats["InHealLeft"][j]="<"
            hbNumFormats["InHealRight"][j]=">"
        elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][j]["SEPARATEFORMAT"]==9 then
            hbNumFormats["InHealLeft"][j]="="
            hbNumFormats["InHealRight"][j]="="
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
        if Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][j]["SHOWTEXT"]==1 then
            hbNameFormats["AggroLeft"][j]=vTextChars["Nothing"]
            hbNameFormats["AggroRight"][j]=vTextChars["Nothing"]
        elseif Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][j]["SHOWTEXT"]==2 then
            hbNameFormats["AggroLeft"][j]=">>"
            hbNameFormats["AggroRight"][j]="<<"
        elseif Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][j]["SHOWTEXT"]==3 then
            hbNameFormats["AggroLeft"][j]="!!"
            hbNameFormats["AggroRight"][j]="!!"
        elseif Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][j]["SHOWTEXT"]==4 then
            hbNameFormats["AggroLeft"][j]="++"
            hbNameFormats["AggroRight"][j]="++"
        elseif Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][j]["SHOWTEXT"]==5 then
            hbNameFormats["AggroLeft"][j]="**"
            hbNameFormats["AggroRight"][j]="**"
        elseif Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][j]["SHOWTEXT"]==6 then
            hbNameFormats["AggroLeft"][j]="^^"
            hbNameFormats["AggroRight"][j]="^^"
        elseif Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][j]["SHOWTEXT"]==7 then
            hbNameFormats["AggroLeft"][j]="--"
            hbNameFormats["AggroRight"][j]="--"
        elseif Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][j]["SHOWTEXT"]==8 then
            hbNameFormats["AggroLeft"][j]="##"
            hbNameFormats["AggroRight"][j]="##"
        else
            hbNameFormats["AggroLeft"][j]="=="
            hbNameFormats["AggroRight"][j]="=="
        end
        
    end
      --HealBot_setCall("HealBot_Text_sethbAggroNumberFormat")
end

local function HealBot_Text_RGBPercToHex(r, g, b)
	r = r <= 1 and r >= 0 and r or 0
	g = g <= 1 and g >= 0 and g or 0
	b = b <= 1 and b >= 0 and b or 0
	return string.format("%02x%02x%02x", r*255, g*255, b*255)
end

local vHex=""
function HealBot_Text_setExtraCustomCols()
    for j=1,10 do
        vHex=HealBot_Text_RGBPercToHex(Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][j]["OCR"],
                                       Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][j]["OCG"],
                                       Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][j]["OCB"])
        vTextCustomCols["OverHeal"][j]="|cff"..vHex
        vHex=HealBot_Text_RGBPercToHex(Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][j]["SCR"],
                                       Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][j]["SCG"],
                                       Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][j]["SCB"])
        vTextCustomCols["InHeal"][j]="|cff"..vHex
        vHex=HealBot_Text_RGBPercToHex(Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][j]["ACR"],
                                       Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][j]["ACG"],
                                       Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][j]["ACB"])
        vTextCustomCols["Aggro"][j]="|cff"..vHex
    end
end

local atcR, atcG, atcB=1,1,1
function HealBot_Text_TextNameColours(button)
    if HealBot_Action_IsUnitDead(button) then
        if UnitIsFriend("player",button.unit) then
            if button.status.current==HealBot_Unit_Status["RES"] and Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["RES"] then
                atcR=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["NRCR"]
                atcG=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["NRCG"]
                atcB=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["NRCB"]
            elseif not UnitIsUnit(button.unit, "player") and button.status.range>0 and Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["RIP"] then
                atcR=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["NDCR"]
                atcG=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["NDCG"]
                atcB=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["NDCB"]
            else
                atcR,atcG,atcB=0.5, 0.5, 0.5
            end
        else
            atcR,atcG,atcB=0.4, 0.4, 0.4
        end
    elseif button.status.summons and Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["SUM"] then
        atcR=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["NSCR"]
        atcG=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["NSCG"]
        atcB=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["NSCB"]
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

function HealBot_Text_readNumber(n)
    if n<9999 then
        n=tostring(n)
    elseif n<99999 then
        n=tostring(HealBot_Comm_round(n/1000,1)).."K"
    elseif n<999999 then
        n=tostring(ceil(n/1000)).."K"
    elseif n<9999999 then
        n=tostring(HealBot_Comm_round(n/1000000,2)).."M"
    elseif n<99999999 then
        n=tostring(HealBot_Comm_round(n/1000000,1)).."M"
    else
        n=tostring(ceil(n/1000000)).."M"
    end
    return n
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
        tShortConcat[1]=vShortHealTxtAmount
        tShortConcat[2]=vShortHealTxtSuffix
        return HealBot_Text_ShortConcat()
    else
        return amount
    end
      --HealBot_setCall("HealBot_Text_shortHealTxt")
end

local vHealthTextConcatIndex,vHealthTextConcatResult,vSetHealthTextStrLen,vSetHealthTextBtnLen=0,"",0,0
local vHealthTextTotal,sepHealTxt,absorbinTxt,ahtNumSuffix,ahitNumSuffix,ignoreInHeals=0,0,0,"","",false
function HealBot_Text_ConcatHealthText(button)
    vSetHealthTextStrLen=hbStringLen(hbutf8sub(button.text.health, "%s+", ""))
    if HealBot_Panel_isSpecialUnit(button.unit)>0 then
        vSetHealthTextBtnLen=HealBot_Text_EnemySizeWidth["HLTH"][HealBot_Panel_isSpecialUnit(button.unit)]
    else
        vSetHealthTextBtnLen=hbBarHealthTextLen[button.frame]
    end
    if (vSetHealthTextStrLen+button.text.inheallen+button.text.overheallen+button.text.aggrolen)<vSetHealthTextBtnLen then
        tHealthConcat[1]=button.text.health
        tHealthConcat[2]=button.text.inheal
        tHealthConcat[3]=button.text.overheal
        tHealthConcat[4]=button.text.aggro
        button.text.healthcomplete=HealBot_Text_HealthConcat(4)
    elseif (vSetHealthTextStrLen+button.text.inheallen+button.text.overheallen)<vSetHealthTextBtnLen then
        tHealthConcat[1]=button.text.health
        tHealthConcat[2]=button.text.inheal
        tHealthConcat[3]=button.text.overheal
        button.text.healthcomplete=HealBot_Text_HealthConcat(3)
    elseif (vSetHealthTextStrLen+button.text.inheallen)<vSetHealthTextBtnLen then
        tHealthConcat[1]=button.text.health
        tHealthConcat[2]=button.text.inheal
        button.text.healthcomplete=HealBot_Text_HealthConcat(2)
    elseif vSetHealthTextStrLen>vSetHealthTextBtnLen then
        if HealBot_Panel_isSpecialUnit(button.unit)>0 then
            tConcat[1]=hbStringSub(button.text.health,1,HealBot_Text_EnemySizeWidth["HLTH"][HealBot_Panel_isSpecialUnit(button.unit)])
        else
            tConcat[1]=hbStringSub(button.text.health,1,hbBarHealthTextLen[button.frame])
        end
        tConcat[2]=vTextChars["Dot"]
        button.text.healthcomplete=HealBot_Text_Concat(2)
    else
        button.text.healthcomplete=button.text.health
    end
    button.text.healthupdate=true
    HealBot_Text_UpdateText(button)
end

function HealBot_Text_DoSetHealthText(button, IgnoreInHeals, force)
    tHealthConcat[1]=hbNumFormats["SurroundLeft"][button.frame]
    if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["HLTHTYPE"]==1 then
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
        if IgnoreInHeals and vHealthTextTotal>button.health.max then
            vHealthTextTotal=button.health.max
        end
        tHealthConcat[2]=HealBot_Text_shortHealTxt(vHealthTextTotal, button.frame)
        tHealthConcat[3]=hbNumFormats["SurroundRight"][button.frame]
        vHealthTextConcatIndex=3
    elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["HLTHTYPE"]==2 then
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
        if IgnoreInHeals and vHealthTextTotal>0 then
            vHealthTextTotal=0
        end
        if vHealthTextTotal>0 then
            tHealthConcat[2]=vTextChars["Plus"]
        else
            tHealthConcat[2]=vTextChars["Nothing"]
        end
        tHealthConcat[3]=HealBot_Text_shortHealTxt(vHealthTextTotal, button.frame)
        tHealthConcat[4]=hbNumFormats["SurroundRight"][button.frame]
        vHealthTextConcatIndex=4
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
        if IgnoreInHeals and vHealthTextTotal>100 then
            vHealthTextTotal=100
        end
        tHealthConcat[2]=vHealthTextTotal
        tHealthConcat[3]=vTextChars["Percent"]
        tHealthConcat[4]=hbNumFormats["SurroundRight"][button.frame]
        vHealthTextConcatIndex=4
    end
    vHealthTextConcatResult=HealBot_Text_HealthConcat(vHealthTextConcatIndex)
    
    if button.text.health~=vHealthTextConcatResult or force then
        button.text.health=vHealthTextConcatResult
        if Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["NAME"]==1 then
            button.text.nameupdate=true
        end
        HealBot_Text_ConcatHealthText(button)
    end
      --HealBot_setCall("HealBot_Text_setHealthText")
end

function HealBot_Text_setHealthText(button)
    if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["HLTHONBAR"] and button.health.max then
        if button.status.current<HealBot_Unit_Status["DEAD"] and Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["IGNOREONFULL"] then
            ignoreInHeals=true
        else
            ignoreInHeals=false
        end
        HealBot_Text_DoSetHealthText(button, ignoreInHeals)
    else
        if button.text.health~=vTextChars["Nothing"] then
            button.text.health=vTextChars["Nothing"]
            if button.text.aggro~=vTextChars["Nothing"] then
                button.text.aggro=vTextChars["Nothing"]
            end
            HealBot_Text_ConcatHealthText(button)
        end
        if Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["NAME"]==1 and 
           Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["NAMEONBAR"] then
            button.text.nameupdate=true
            HealBot_Text_UpdateText(button)
        end
    end
end

function HealBot_Text_ClearOverHeals()
    for _,xButton in pairs(HealBot_Unit_Button) do
        xButton.text.overheal=vTextChars["Nothing"]
        xButton.text.overheallen=0
        HealBot_Text_ConcatHealthText(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        xButton.text.overheal=vTextChars["Nothing"]
        xButton.text.overheallen=0
        HealBot_Text_ConcatHealthText(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        xButton.text.overheal=vTextChars["Nothing"]
        xButton.text.overheallen=0
        HealBot_Text_ConcatHealthText(xButton)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        xButton.text.overheal=vTextChars["Nothing"]
        xButton.text.overheallen=0
        HealBot_Text_ConcatHealthText(xButton)
    end
    for _,xButton in pairs(HealBot_Enemy_Button) do
        xButton.text.overheal=vTextChars["Nothing"]
        xButton.text.overheallen=0
        HealBot_Text_ConcatHealthText(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        xButton.text.overheal=vTextChars["Nothing"]
        xButton.text.overheallen=0
        HealBot_Text_ConcatHealthText(xButton)
    end
end

function HealBot_Text_ClearSeparateInHealsAbsorbs()
    for _,xButton in pairs(HealBot_Unit_Button) do
        xButton.text.inheal=vTextChars["Nothing"]
        xButton.text.inheallen=0
        HealBot_Text_ConcatHealthText(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        xButton.text.inheal=vTextChars["Nothing"]
        xButton.text.inheallen=0
        HealBot_Text_ConcatHealthText(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        xButton.text.inheal=vTextChars["Nothing"]
        xButton.text.inheallen=0
        HealBot_Text_ConcatHealthText(xButton)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        xButton.text.inheal=vTextChars["Nothing"]
        xButton.text.inheallen=0
        HealBot_Text_ConcatHealthText(xButton)
    end
    for _,xButton in pairs(HealBot_Enemy_Button) do
        xButton.text.inheal=vTextChars["Nothing"]
        xButton.text.inheallen=0
        HealBot_Text_ConcatHealthText(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        xButton.text.inheal=vTextChars["Nothing"]
        xButton.text.inheallen=0
        HealBot_Text_ConcatHealthText(xButton)
    end
end

function HealBot_Text_setSeparateInHealsAbsorbs()
    for x=1,10 do
        if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][x]["INCHEALS"]==3 or 
           Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][x]["INCABSORBS"]==3 then
            hbSeparateInHealsAbsorbs[x]=true
            HealBot_setOptions_Timer(86)
        else
            if hbSeparateInHealsAbsorbs[x] then
                HealBot_setOptions_Timer(88)
            end
            hbSeparateInHealsAbsorbs[x]=false
        end
        if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][x]["OVERHEAL"]>1 then
            hbOverHeal[x]=true
        else
            if hbOverHeal[x] then
                HealBot_setOptions_Timer(87)
            end
            hbOverHeal[x]=false
        end
    end
end

local hbConcatLater=false
function HealBot_Text_setInHealAbsorbsText(button)
    if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["HLTHONBAR"] and button.health.max then
        if button.status.current<HealBot_Unit_Status["DEAD"] and Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["IGNOREONFULL"] then
            ignoreInHeals=true
        else
            ignoreInHeals=false
        end
        if hbSeparateInHealsAbsorbs[button.frame] then
            hbConcatLater=false
            if ignoreInHeals and button.health.current==button.health.max then
                sepHealTxt=0
            else
                if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["INCHEALS"]==3 then
                    if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["INCABSORBS"]==3 then
                        sepHealTxt=button.health.incoming+button.health.absorbs
                    else
                        sepHealTxt=button.health.incoming
                    end
                else
                    sepHealTxt=button.health.absorbs
                end
            end
            if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["HLTHTYPE"]==3 then
                if floor((sepHealTxt/button.health.max)*100)<1 then
                    sepHealTxt=0
                end
            end
            if sepHealTxt>0 then
                tHealthConcat[1]=vTextChars["Space"]
                if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["SEPARATECOL"]==1 then
                    tHealthConcat[2]=hbNumFormats["InHealLeft"][button.frame]
                    if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["HLTHTYPE"]<3 then
                        tHealthConcat[3]=HealBot_Text_shortHealTxt(sepHealTxt, button.frame)
                    else
                        tHealthConcat[3]=floor((sepHealTxt/button.health.max)*100)
                    end
                    tHealthConcat[4]=hbNumFormats["InHealRight"][button.frame]
                    vHealthTextConcatResult=HealBot_Text_HealthConcat(4)
                    button.text.inheallen=hbStringLen(hbutf8sub(vHealthTextConcatResult, "%s+", ""))
                else
                    tHealthConcat[2]=vTextCustomCols["InHeal"][button.frame]
                    tHealthConcat[3]=hbNumFormats["InHealLeft"][button.frame]
                    if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["HLTHTYPE"]<3 then
                        tHealthConcat[4]=HealBot_Text_shortHealTxt(sepHealTxt, button.frame)
                    else
                        tHealthConcat[4]=floor((sepHealTxt/button.health.max)*100)
                    end
                    tHealthConcat[5]=hbNumFormats["InHealRight"][button.frame]
                    tHealthConcat[6]=vTextCustomCols["Close"]
                    vHealthTextConcatResult=HealBot_Text_HealthConcat(6)
                    button.text.inheallen=(hbStringLen(hbutf8sub(vHealthTextConcatResult, "%s+", "")))-12
                end
                if button.text.inheal~=vHealthTextConcatResult then
                    button.text.inheal=vHealthTextConcatResult
                    hbConcatLater=true
                end
            elseif button.text.inheal~=vTextChars["Nothing"] then
                button.text.inheal=vTextChars["Nothing"]
                button.text.inheallen=0
                hbConcatLater=true
            end
            if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["INCHEALS"]==2 or
               Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["INCABSORBS"]==2 then
               HealBot_Text_DoSetHealthText(button, ignoreInHeals, hbConcatLater)
            elseif hbConcatLater then
                HealBot_Text_ConcatHealthText(button)
            end
        else
            HealBot_Text_DoSetHealthText(button, ignoreInHeals)
        end
    elseif button.text.inheal~=vTextChars["Nothing"] then
        button.text.inheal=vTextChars["Nothing"]
        button.text.inheallen=0
        HealBot_Text_ConcatHealthText(button)
    end
      --HealBot_setCall("HealBot_Text_setNameTag")
end

function HealBot_Text_setOverHealText(button)
    if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["HLTHONBAR"] and hbOverHeal[button.frame] and button.health.max and button.health.overheal>0 then
        if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["HLTHTYPE"]<3 or floor((button.health.overheal/button.health.max)*100)>0 then
            tHealthConcat[1]=vTextChars["Space"]
            if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["OVERHEALCOL"]==1 then
                tHealthConcat[2]=hbNumFormats["OverHealLeft"][button.frame]
                if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["HLTHTYPE"]<3 then
                    tHealthConcat[3]=HealBot_Text_shortHealTxt(button.health.overheal, button.frame)
                else
                    tHealthConcat[3]=floor((button.health.overheal/button.health.max)*100)
                end
                tHealthConcat[4]=hbNumFormats["OverHealRight"][button.frame]
                vHealthTextConcatResult=HealBot_Text_HealthConcat(4)
                button.text.overheallen=(hbStringLen(hbutf8sub(vHealthTextConcatResult, "%s+", "")))
            else
                tHealthConcat[2]=vTextCustomCols["OverHeal"][button.frame]
                tHealthConcat[3]=hbNumFormats["OverHealLeft"][button.frame]
                if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["HLTHTYPE"]<3 then
                    tHealthConcat[4]=HealBot_Text_shortHealTxt(button.health.overheal, button.frame)
                else
                    tHealthConcat[4]=floor((button.health.overheal/button.health.max)*100)
                end
                tHealthConcat[5]=hbNumFormats["OverHealRight"][button.frame]
                tHealthConcat[6]=vTextCustomCols["Close"]
                vHealthTextConcatResult=HealBot_Text_HealthConcat(6)
                button.text.overheallen=(hbStringLen(hbutf8sub(vHealthTextConcatResult, "%s+", "")))-12
            end
        else
            button.text.overheal=vTextChars["Nothing"]
            button.text.overheallen=0
        end
        if button.text.overheal~=vHealthTextConcatResult then
            button.text.overheal=vHealthTextConcatResult
            HealBot_Text_ConcatHealthText(button)
        end
    elseif button.text.overheal~=vTextChars["Nothing"] then
        button.text.overheal=vTextChars["Nothing"]
        button.text.overheallen=0
        HealBot_Text_ConcatHealthText(button)
    end
      --HealBot_setCall("HealBot_Text_setNameTag")
end

function HealBot_Text_setAggroText(button)
    if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["HLTHONBAR"] and button.health.max and button.frame<10 and 
       Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][button.frame]["SHOWTEXTPCT"] and button.aggro.threatpct>0 then
        tHealthConcat[1]=vTextChars["DoubleSpace"]
        if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["AGGROCOL"]==1 then
            tHealthConcat[2]=aggroNumFormatSurLa[button.frame]
            tHealthConcat[3]=button.aggro.threatpct
            tHealthConcat[4]=vTextChars["Percent"]
            tHealthConcat[5]=aggroNumFormatSurRa[button.frame]
            vHealthTextConcatResult=HealBot_Text_HealthConcat(5)
            button.text.aggrolenadj=(hbStringLen(hbutf8sub(vHealthTextConcatResult, "%s+", "")))
        else
            tHealthConcat[2]=vTextCustomCols["Aggro"][button.frame]
            tHealthConcat[3]=aggroNumFormatSurLa[button.frame]
            tHealthConcat[4]=button.aggro.threatpct
            tHealthConcat[5]=vTextChars["Percent"]
            tHealthConcat[6]=aggroNumFormatSurRa[button.frame]
            tHealthConcat[7]=vTextCustomCols["Close"]
            vHealthTextConcatResult=HealBot_Text_HealthConcat(7)
            button.text.aggrolenadj=(hbStringLen(hbutf8sub(vHealthTextConcatResult, "%s+", "")))-12
        end
        if button.text.aggro~=vHealthTextConcatResult then
            button.text.aggro=vHealthTextConcatResult
            HealBot_Text_ConcatHealthText(button)
        end
    elseif button.text.aggro~=vTextChars["Nothing"] then
        button.text.aggro=vTextChars["Nothing"]
        button.text.aggrolenadj=0
        HealBot_Text_ConcatHealthText(button)
    end
      --HealBot_setCall("HealBot_Text_setNameTag")
end

local prevTag=""
function HealBot_Text_setNameTag(button)
    prevTag=button.text.tag
    if button.status.current<HealBot_Unit_Status["RESERVED"] then
        if UnitIsFriend("player",button.unit) then
            if button.status.current==HealBot_Unit_Status["DC"] then
                button.text.tag=Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["TAGDC"];
            elseif button.status.current==HealBot_Unit_Status["DEAD"] then
                button.text.tag=Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["TAGRIP"];
            elseif button.status.current==HealBot_Unit_Status["RES"] then
                button.text.tag=Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["TAGRES"];
            elseif button.status.summons then
                button.text.tag=Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["TAGSUM"];
            elseif button.status.range<1 then
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
    if button.status.current<HealBot_Unit_Status["RESERVED"] then
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
            if Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][button.frame]["SHOWTEXT"]>1 and 
                   (button.aggro.status or 0)>Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][button.frame]["ALERT"] then
                tConcat[vHealthTextConcatIndex+1]=hbNameFormats["AggroLeft"][button.frame]
                tConcat[vHealthTextConcatIndex+2]=HealBot_GetUnitName(button.unit, button.guid)
                tConcat[vHealthTextConcatIndex+3]=hbNameFormats["AggroRight"][button.frame]
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
        HealBot_Text_UpdateText(button)
    end
      --HealBot_setCall("HealBot_Text_setNameText")
end


local aufbButtonActive=false
local aufbSetValue,aufbAlphaValue=0,0
local aufbSetRValue,aufbSetGValue,aufbSetBValue=0,0,0
function HealBot_Text_UpdateFluidTextAlpha()
    HealBot_Text_luVars["FluidTextAlphaInUse"]=false
    
    for id,xButton in pairs(HealBot_Fluid_TextHealthAlpha) do
        aufbButtonActive=false
        aufbAlphaValue=xButton.gref.txt["text2"]:GetAlpha()
        aufbAlphaValue=HealBot_Comm_round(aufbAlphaValue, 2)
        if aufbAlphaValue>xButton.text.ha then
            aufbSetValue=aufbAlphaValue-HealBot_Text_luVars["FluidTextAlphaUpdate"]
            if aufbSetValue<xButton.text.ha then 
                aufbSetValue=xButton.text.ha
            else
                aufbButtonActive=true
            end
        elseif aufbAlphaValue<xButton.text.ha then
            aufbSetValue=aufbAlphaValue+HealBot_Text_luVars["FluidTextAlphaUpdate"]
            if aufbSetValue>xButton.text.ha then 
                aufbSetValue=xButton.text.ha
            else
                aufbButtonActive=true
            end
        else
            aufbSetValue=xButton.text.ha
        end
        xButton.gref.txt["text2"]:SetTextColor(xButton.text.hr, xButton.text.hg, xButton.text.hb, aufbSetValue)
        if not aufbButtonActive then
            HealBot_Fluid_TextHealthAlpha[id]=nil
        else
            HealBot_Text_luVars["FluidTextAlphaInUse"]=true
        end
    end
	
    for id,xButton in pairs(HealBot_Fluid_TextNameAlpha) do
        aufbButtonActive=false
        aufbAlphaValue=xButton.gref.txt["text"]:GetAlpha()
        aufbAlphaValue=HealBot_Comm_round(aufbAlphaValue, 2)
        if aufbAlphaValue>xButton.text.na then
            aufbSetValue=aufbAlphaValue-HealBot_Text_luVars["FluidTextAlphaUpdate"]
            if aufbSetValue<xButton.text.na then 
                aufbSetValue=xButton.text.na
            else
                aufbButtonActive=true
            end
        elseif aufbAlphaValue<xButton.text.na then
            aufbSetValue=aufbAlphaValue+HealBot_Text_luVars["FluidTextAlphaUpdate"]
            if aufbSetValue>xButton.text.na then 
                aufbSetValue=xButton.text.na
            else
                aufbButtonActive=true
            end
        else
            aufbSetValue=xButton.text.na
        end
        xButton.gref.txt["text"]:SetTextColor(xButton.text.nr, xButton.text.ng, xButton.text.nb, aufbSetValue)

        if not aufbButtonActive then
            HealBot_Fluid_TextNameAlpha[id]=nil
        else
            HealBot_Text_luVars["FluidTextAlphaInUse"]=true
        end
    end
    if HealBot_Text_luVars["FluidTextAlphaInUse"] then
        C_Timer.After(HealBot_Text_luVars["FluidTextAlphaFreq"], HealBot_Text_UpdateFluidTextAlpha)
    end
    --HealBot_Aux_setLuVars("FluidTextAlphaInUse", HealBot_Text_luVars["FluidTextAlphaInUse"])
      --HealBot_setCall("HealBot_Text_UpdateFluidTextAlpha")
end

local function HealBot_Text_UpdateNameColour(button)
    if HealBot_Text_luVars["FluidInUse"] then
        HealBot_Fluid_TextNameAlpha[button.id]=button
        if not HealBot_Text_luVars["FluidTextAlphaInUse"] then
            HealBot_Text_UpdateFluidTextAlpha()
        end
        --HealBot_Aux_setLuVars("FluidTextAlphaInUse", true)
    else
        button.gref.txt["text"]:SetTextColor(button.text.nr, button.text.ng, button.text.nb, button.text.na)
    end
      --HealBot_setCall("HealBot_Text_UpdateNameColour")
end

local function HealBot_Text_UpdateHealthColour(button)
    if HealBot_Text_luVars["FluidInUse"] and button.status.current<HealBot_Unit_Status["DC"] then
        HealBot_Fluid_TextHealthAlpha[button.id]=button
        if not HealBot_Text_luVars["FluidTextAlphaInUse"] then
            HealBot_Text_UpdateFluidTextAlpha()
        end
        --HealBot_Aux_setLuVars("FluidTextAlphaInUse", true)
    else
        button.gref.txt["text2"]:SetTextColor(button.text.hr, button.text.hg, button.text.hb, button.text.ha)
    end
      --HealBot_setCall("HealBot_Text_UpdateHealthColour")
end

function HealBot_Text_UpdateText(button)
    if button.text.nameupdate then
        button.text.nameupdate=false
        if button.status.current<HealBot_Unit_Status["DC"] then
            if button.status.enabled or button.status.summons then
                button.text.na=HealBot_Action_BarColourAlpha(button, Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["NCA"], 1)
            else
                button.text.na=HealBot_Action_BarColourAlpha(button, Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["NCDA"], 1)
            end
            button.text.nr, button.text.ng, button.text.nb = HealBot_Text_TextNameColours(button)
        else
            button.text.nr, button.text.ng, button.text.nb, button.text.na = 0.5, 0.5, 0.5, 0.8
        end
        HealBot_Text_UpdateNameColour(button)
        button.gref.txt["text"]:SetText(button.text.name);
    end
    if button.text.healthupdate then
        button.text.healthupdate=false
        if button.status.current<HealBot_Unit_Status["DEAD"] then
            if button.status.enabled then
                button.text.ha=HealBot_Action_BarColourAlpha(button, Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["HCA"], 1)
            else
                button.text.ha=HealBot_Action_BarColourAlpha(button, Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["HCDA"], 1)
            end
            button.text.hr, button.text.hg, button.text.hb = HealBot_Text_TextHealthColours(button)
        else
            button.text.hr, button.text.hg, button.text.hb, button.text.ha = 0, 0, 0, 0
        end
        HealBot_Text_UpdateHealthColour(button)
        button.gref.txt["text2"]:SetText(button.text.healthcomplete)
    end
      --HealBot_setCall("HealBot_Text_UpdateText")
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
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_Text_setNameText(xButton)
    end
    for _,xButton in pairs(HealBot_Enemy_Button) do
        HealBot_Text_setNameText(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_Text_setNameText(xButton)
    end
end

function HealBot_Text_UpdateHealth()
    for _,xButton in pairs(HealBot_Unit_Button) do
        xButton.text.health=""
        HealBot_Text_setHealthText(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        xButton.text.health=""
        HealBot_Text_setHealthText(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        xButton.text.health=""
        HealBot_Text_setHealthText(xButton)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        xButton.text.health=""
        HealBot_Text_setHealthText(xButton)
    end
    for _,xButton in pairs(HealBot_Enemy_Button) do
        xButton.text.health=""
        HealBot_Text_setHealthText(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        xButton.text.health=""
        HealBot_Text_setHealthText(xButton)
    end
end

function HealBot_Text_UpdateButton(button)
    button.text.nameupdate=true
    button.text.healthupdate=true
    HealBot_Text_UpdateText(button)
end

function HealBot_Text_UpdateButtons()
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_Text_UpdateButton(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_Text_UpdateButton(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_Text_UpdateButton(xButton)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_Text_UpdateButton(xButton)
    end
    for _,xButton in pairs(HealBot_Enemy_Button) do
        HealBot_Text_UpdateButton(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_Text_UpdateButton(xButton)
    end
end
