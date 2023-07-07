local HealBot_Fluid_TextNameAlpha={}
local HealBot_Fluid_TextStateAlpha={}
local HealBot_Fluid_TextHealthAlpha={}
local HealBot_Fluid_TextAggroAlpha={}
local hbBarTextLen={[1]=50,[2]=50,[3]=50,[4]=50,[5]=50,[6]=50,[7]=50,[8]=50,[9]=50,[10]=50}
local hbBarHealthTextLen={[1]=50,[2]=50,[3]=50,[4]=50,[5]=50,[6]=50,[7]=50,[8]=50,[9]=50,[10]=50}
local hbSeparateInHealsAbsorbs={[1]=false,[2]=false,[3]=false,[4]=false,[5]=false,[6]=false,[7]=false,[8]=false,[9]=false,[10]=false}
local hbOverHeal={[1]=false,[2]=false,[3]=false,[4]=false,[5]=false,[6]=false,[7]=false,[8]=false,[9]=false,[10]=false}

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
HealBot_Text_EnemySizeWidth["NAME"][1]=100
HealBot_Text_EnemySizeWidth["NAME"][2]=100
HealBot_Text_EnemySizeWidth["HLTH"][1]=100
HealBot_Text_EnemySizeWidth["HLTH"][2]=100

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
vTextCustomCols["Health"]={}
vTextCustomCols["OverHeal"]={}
vTextCustomCols["InHeal"]={}
for j=1,10 do
    vTextCustomCols["Health"][j]="|cff77c8ff"
    vTextCustomCols["OverHeal"][j]="|cff77c8ff"
    vTextCustomCols["InHeal"][j]="|cff77c8ff"
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
local HealBot_Text_AuxAssigns={}
HealBot_Text_AuxAssigns["Name"]={[0]=false,[1]=false,[2]=false,[3]=false,[4]=false,[5]=false,[6]=false,[7]=false,[8]=false,[9]=false,[10]=false}
HealBot_Text_AuxAssigns["Health"]={[0]=false,[1]=false,[2]=false,[3]=false,[4]=false,[5]=false,[6]=false,[7]=false,[8]=false,[9]=false,[10]=false}
HealBot_Text_AuxAssigns["State"]={[0]=false,[1]=false,[2]=false,[3]=false,[4]=false,[5]=false,[6]=false,[7]=false,[8]=false,[9]=false,[10]=false}

local HealBot_Text_luVars={}
HealBot_Text_luVars["FluidAlphaInUse"]=false
HealBot_Text_luVars["FluidTextAlphaUpdate"]=0.02
HealBot_Text_luVars["FluidTextAlphaFreq"]=0.088
HealBot_Text_luVars["TestBarsOn"]=false

local hbCustomRoleCols={}
function HealBot_Text_SetCustomRoleCols()
    if HealBot_Globals.OverrideColours["USEROLE"]==1 then
        hbCustomRoleCols["TANK"]=HealBot_Options_copyTable(Healbot_Config_Skins.CustomCols[Healbot_Config_Skins.Current_Skin]["TANK"])
        hbCustomRoleCols["HEALER"]=HealBot_Options_copyTable(Healbot_Config_Skins.CustomCols[Healbot_Config_Skins.Current_Skin]["HEALER"])
        hbCustomRoleCols["DAMAGER"]=HealBot_Options_copyTable(Healbot_Config_Skins.CustomCols[Healbot_Config_Skins.Current_Skin]["DAMAGER"])
    else
        hbCustomRoleCols["TANK"]=HealBot_Options_copyTable(HealBot_Globals.OverrideColours["TANK"])
        hbCustomRoleCols["HEALER"]=HealBot_Options_copyTable(HealBot_Globals.OverrideColours["HEALER"])
        hbCustomRoleCols["DAMAGER"]=HealBot_Options_copyTable(HealBot_Globals.OverrideColours["DAMAGER"])
    end
end

function HealBot_Text_setAuxAssigns(vName, frame, vValue)
    HealBot_Text_AuxAssigns[vName][frame]=vValue
end

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

local vSetTextLenAux=0
function HealBot_Text_setEnemyTextLen(bWidth, eBarID, tSize)
    if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][10]["MAXCHARS"]==0 then
        HealBot_Text_EnemySizeWidth["HLTH"][eBarID]=100
    elseif eBarID==2 then
        HealBot_Text_EnemySizeWidth["NAME"][eBarID] = ceil(Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][10]["MAXCHARS"]*tSize)+1
    else
        HealBot_Text_EnemySizeWidth["NAME"][eBarID] = Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][10]["MAXCHARS"]
    end
    if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][10]["HMAXCHARS"]==0 then
        HealBot_Text_EnemySizeWidth["HLTH"][eBarID]=100
    elseif eBarID==2 then
        HealBot_Text_EnemySizeWidth["HLTH"][eBarID] = ceil(Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][10]["HMAXCHARS"]*tSize)+1
    else
        HealBot_Text_EnemySizeWidth["HLTH"][eBarID] = Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][10]["HMAXCHARS"]
    end
    for x=1,9 do
        if Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Current_Skin][x][10]["MAXCHARS"]==0 then
            vSetTextLenAux=100
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
            hbBarTextLen[curFrame]=1000
        else
            hbBarTextLen[curFrame] = Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][curFrame]["MAXCHARS"]
        end
        if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][curFrame]["HMAXCHARS"]==0 then
            hbBarHealthTextLen[curFrame]=1000
        else
            hbBarHealthTextLen[curFrame] = Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][curFrame]["HMAXCHARS"]
        end
        for x=1,9 do
            if Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Current_Skin][x][curFrame]["MAXCHARS"]==0 then
                vSetTextLenAux=1000
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
        vHex=HealBot_Text_RGBPercToHex(Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][j]["HECR"] or 1,
                                       Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][j]["HECG"] or 1,
                                       Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][j]["HECB"] or 1)
        vTextCustomCols["Health"][j]="|cff"..vHex
        vHex=HealBot_Text_RGBPercToHex(Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][j]["OCR"] or 1,
                                       Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][j]["OCG"] or 1,
                                       Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][j]["OCB"] or 1)
        vTextCustomCols["OverHeal"][j]="|cff"..vHex
        vHex=HealBot_Text_RGBPercToHex(Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][j]["ICR"] or 1,
                                       Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][j]["ICG"] or 1,
                                       Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][j]["ICB"] or 1)
        vTextCustomCols["InHeal"][j]="|cff"..vHex
    end
end
for j=1,10 do
    vHex=HealBot_Text_RGBPercToHex(1,1,1)
    vTextCustomCols["Health"][j]="|cff"..vHex
    vHex=HealBot_Text_RGBPercToHex(1,1,1)
    vTextCustomCols["OverHeal"][j]="|cff"..vHex
    vHex=HealBot_Text_RGBPercToHex(1,1,1)
    vTextCustomCols["InHeal"][j]="|cff"..vHex
end

local dR, dG, dB=0,0,0
function HealBot_Text_DeadColours(button)
    if UnitIsFriend("player",button.unit) then
        if button.status.current==HealBot_Unit_Status["RES"] and Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["RES"] then
            dR=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["NRCR"]
            dG=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["NRCG"]
            dB=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["NRCB"]
        elseif button.status.range>0 and Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["RIP"] then
            dR=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["NDCR"]
            dG=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["NDCG"]
            dB=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["NDCB"]
        else
            dR,dG,dB=0.5, 0.5, 0.5
        end
    else
        dR,dG,dB=0.4, 0.4, 0.4
    end
    return dR,dG,dB
end

local tr,tg,tb=1,1,1
function HealBot_Text_ColoursHealth(button, cType)
    tr,tg,tb=button.health.rcol,button.health.gcol,0
end

local htvUnit=false
function HealBot_Text_ColoursClass(button, cType)
    htvUnit=HealBot_retIsInVehicle(button.unit)
    if htvUnit and UnitExists(htvUnit) then
        tr,tg,tb=HealBot_Action_ClassColour(htvUnit)
    else
        tr,tg,tb=button.text.r, button.text.g, button.text.b
    end
end

function HealBot_Text_ColoursRole(button, cType)
    tr,tg,tb=hbCustomRoleCols[button.roletxt].r,hbCustomRoleCols[button.roletxt].g,hbCustomRoleCols[button.roletxt].b
end

function HealBot_Text_ColoursCustom(button, cType)
    if cType=="NAME" then
        if button.health.pct>Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["SIT"] then
            tr=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["NCR"]
            tg=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["NCG"]
            tb=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["NCB"]
        elseif button.health.pct>Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["SCT"] then
            tr=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["NICR"]
            tg=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["NICG"]
            tb=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["NICB"]
        else
            tr=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["NCCR"]
            tg=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["NCCG"]
            tb=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["NCCB"]
        end
    elseif cType=="HEALTH" then
        if button.health.pct>Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["SIT"] then
            tr=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["HCR"]
            tg=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["HCG"]
            tb=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["HCB"]
        elseif button.health.pct>Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["SCT"] then
            tr=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["HICR"]
            tg=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["HICG"]
            tb=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["HICB"]
        else
            tr=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["HCCR"]
            tg=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["HCCG"]
            tb=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["HCCB"]
        end
    elseif cType=="STATE" then
        if button.health.pct>Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["SIT"] then
            tr=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["SCR"]
            tg=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["SCG"]
            tb=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["SCB"]
        elseif button.health.pct>Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["SCT"] then
            tr=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["SICR"]
            tg=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["SICG"]
            tb=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["SICB"]
        else
            tr=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["SCCR"]
            tg=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["SCCG"]
            tb=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["SCCB"]
        end
    else
        if button.health.pct>Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["SIT"] then
            tr=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["ACR"]
            tg=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["ACG"]
            tb=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["ACB"]
        elseif button.health.pct>Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["SCT"] then
            tr=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["AICR"]
            tg=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["AICG"]
            tb=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["AICB"]
        else
            tr=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["ACCR"]
            tg=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["ACCG"]
            tb=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["ACCB"]
        end
    end
end

function HealBot_Text_ColoursClassHlthMix(button, cType)
    tr,tg,tb=button.health.mixcolr,button.health.mixcolg,button.health.mixcolb
end

function HealBot_Text_ColoursRoleHlthMix(button, cType)
    tr,tg,tb=button.health.rmixcolr,button.health.rmixcolg,button.health.rmixcolb
end

local HealBot_Text_StateColoursFuncs={[1]=HealBot_Text_ColoursHealth,
                                      [2]=HealBot_Text_ColoursClass,
                                      [3]=HealBot_Text_ColoursRole,
                                      [4]=HealBot_Text_ColoursCustom,
                                      [5]=HealBot_Text_ColoursClassHlthMix,
                                      [6]=HealBot_Text_ColoursRoleHlthMix}
function HealBot_Text_StateColours(button)
    if HealBot_Action_IsUnitDead(button) then
        tr,tg,tb=HealBot_Text_DeadColours(button)
    elseif button.status.summons and Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["SSUM"] then
        tr=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["SSCR"]
        tg=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["SSCG"]
        tb=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["SSCB"]
    else
        HealBot_Text_StateColoursFuncs[Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["STATE"]](button, "STATE")
    end
      --HealBot_setCall("HealBot_Text_TextNameColours")
    return tr,tg,tb
end

function HealBot_Text_TextNameColours(button)
    if HealBot_Action_IsUnitDead(button) then
        tr,tg,tb=HealBot_Text_DeadColours(button)
    elseif button.status.summons and Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["SUM"] then
        tr=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["NSCR"]
        tg=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["NSCG"]
        tb=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["NSCB"]
    else
        HealBot_Text_StateColoursFuncs[Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["NAME"]](button, "NAME")
    end
      --HealBot_setCall("HealBot_Text_TextNameColours")
    return tr,tg,tb
end

function HealBot_Text_TextHealthColours(button)
    HealBot_Text_StateColoursFuncs[Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["HLTH"]](button, "HEALTH")
    return tr,tg,tb
end

function HealBot_Text_TextAggroColours(button)
    HealBot_Text_StateColoursFuncs[Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["AGGRO"]](button, "AGGRO")
    return tr,tg,tb
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
        return HealBot_Comm_round(amount, 0)
    end
      --HealBot_setCall("HealBot_Text_shortHealTxt")
end

local vHealthTextConcatIndex,vHealthTextConcatResult,vSetHealthTextStrLen,vSetHealthTextBtnLen=0,"",0,0
local vHealthTextTotal,sepHealTxt,absorbinTxt,ahtNumSuffix,ahitNumSuffix,ignoreInHeals,finalHealthTxt=0,0,0,"","",false,""
local vHealthTextVehiclePlayer=""
function HealBot_Text_ConcatHealthText(button)
    tHealthConcat[1]=button.text.health
    tHealthConcat[2]=button.text.inheal
    tHealthConcat[3]=button.text.overheal
    finalHealthTxt=HealBot_Text_HealthConcat(3)
    if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["HMAXCHARS"]>0 then
        vSetHealthTextStrLen=hbStringLen(hbutf8sub(button.text.health, "%s+", ""))
        if button.frame==10 and HealBot_Panel_isSpecialUnit(button.unit)>0 then
            vSetHealthTextBtnLen=HealBot_Text_EnemySizeWidth["HLTH"][HealBot_Panel_isSpecialUnit(button.unit)]
        else
            vSetHealthTextBtnLen=hbBarHealthTextLen[button.frame]
        end
        if (vSetHealthTextStrLen+button.text.inheallen+button.text.overheallen)<vSetHealthTextBtnLen then
            if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["HLTHTXTANCHOR"]==4 then
                button.text.namehealth=finalHealthTxt
            else
                button.text.healthcomplete=finalHealthTxt
            end
        elseif (vSetHealthTextStrLen+button.text.inheallen)<vSetHealthTextBtnLen then
            tHealthConcat[1]=button.text.health
            tHealthConcat[2]=button.text.inheal
            if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["HLTHTXTANCHOR"]==4 then
                button.text.namehealth=HealBot_Text_HealthConcat(2)
            else
                button.text.healthcomplete=HealBot_Text_HealthConcat(2)
            end
        elseif vSetHealthTextStrLen>vSetHealthTextBtnLen then
            if button.frame==10 and HealBot_Panel_isSpecialUnit(button.unit)>0 then
                tConcat[1]=hbStringSub(button.text.health,1,HealBot_Text_EnemySizeWidth["HLTH"][HealBot_Panel_isSpecialUnit(button.unit)])
            else
                tConcat[1]=hbStringSub(button.text.health,1,hbBarHealthTextLen[button.frame])
            end
            tConcat[2]=vTextChars["Dot"]
            if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["HLTHTXTANCHOR"]==4 then
                button.text.namehealth=HealBot_Text_Concat(2)
            else
                button.text.healthcomplete=HealBot_Text_Concat(2)
            end
        elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["HLTHTXTANCHOR"]==4 then
            button.text.namehealth=button.text.health
        else
            button.text.healthcomplete=button.text.health
        end
    elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["HLTHTXTANCHOR"]==4 then
        button.text.namehealth=finalHealthTxt
    else
        button.text.healthcomplete=finalHealthTxt
    end
    
    if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["HLTHTXTANCHOR"]==4 then
        if button.text.healthcomplete~=vTextChars["Nothing"] then
            button.text.healthcomplete=vTextChars["Nothing"]
            button.text.healthupdate=true
        end
        HealBot_Text_ConcatNameText(button)
    else
        if button.text.namehealth~=vTextChars["Nothing"] then
            button.text.namehealth=vTextChars["Nothing"]
            HealBot_Text_ConcatNameText(button)
        end
        button.text.healthupdate=true
        HealBot_Text_UpdateText(button)
    end
end

function HealBot_Text_DoSetHealthText(button, IgnoreInHeals, force)
    if button.health.current==0 then
        vHealthTextConcatResult=0
    else
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
        if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["HLTHINCPTC"] and 
           Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["HLTHTYPE"]<3 then
            tHealthConcat[vHealthTextConcatIndex+1]="  "
            tHealthConcat[vHealthTextConcatIndex+2]=hbNumFormats["SurroundLeft"][button.frame]
            tHealthConcat[vHealthTextConcatIndex+3]=floor((button.health.current/button.health.max)*100)
            tHealthConcat[vHealthTextConcatIndex+4]="%"
            tHealthConcat[vHealthTextConcatIndex+5]=hbNumFormats["SurroundRight"][button.frame]
            vHealthTextConcatIndex=vHealthTextConcatIndex+5
        end
        vHealthTextConcatResult=HealBot_Text_HealthConcat(vHealthTextConcatIndex)
        if button.text.health~=vHealthTextConcatResult then
            button.text.health=vHealthTextConcatResult
            force=true
        end
        htvUnit=HealBot_retIsInVehicle(button.unit)
        if htvUnit and Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["HLTHINVEHSHOWPLAYER"] and UnitExists(htvUnit) then
            tHealthConcat[1]=HEALBOT_WORD_PLAYER
            tHealthConcat[2]="  "
            if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["HLTHTYPE"]==1 then
                tHealthConcat[3]=HealBot_Text_shortHealTxt(UnitHealth(button.unit), button.frame)
            elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["HLTHTYPE"]==2 then
                tHealthConcat[3]=HealBot_Text_shortHealTxt(UnitHealth(button.unit)-UnitHealthMax(button.unit), button.frame)
            else
                vHealthTextTotal=floor((UnitHealth(button.unit)/UnitHealthMax(button.unit))*100)
                tHealthConcat[3]=vHealthTextTotal..vTextChars["Percent"]
            end
            vHealthTextVehiclePlayer=HealBot_Text_HealthConcat(3)
            if button.text.vphealth~=vHealthTextVehiclePlayer then
                button.text.vphealth=vHealthTextVehiclePlayer
                button.text.vphealthupdate=true
                force=true
            end
        elseif button.text.vphealth~=vTextChars["Nothing"] then
            button.text.vphealth=vTextChars["Nothing"]
            button.text.vphealthupdate=true
            force=true
        end
    end
    
    if force then
        if button.text.name~=vTextChars["Nothing"] and Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["NAME"]~=2 then
            button.text.nameupdate=true
        end
        if button.text.aggro~=vTextChars["Nothing"] and Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["AGGRO"]==2 then
            button.text.aggroupdate=true
        end
        if button.text.tag~=vTextChars["Nothing"] and Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["STATE"]~=2 then
            button.text.tagupdate=true
        end
        HealBot_Text_ConcatHealthText(button)
        if HealBot_Text_AuxAssigns["Health"][button.frame] then
            HealBot_Aux_DoUpdateHealthOverLay(button) 
        end
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
        if button.text.name~=vTextChars["Nothing"] and Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["NAME"]~=2 then
            button.text.nameupdate=true
        end
        if button.text.aggro~=vTextChars["Nothing"] and Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["AGGRO"]~=2 then
            button.text.aggroupdate=true
        end
        if button.text.tag~=vTextChars["Nothing"] and Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["STATE"]~=2 then
            button.text.tagupdate=true
        end
        if button.text.healthcomplete~=vTextChars["Nothing"] then
            button.text.healthcomplete=vTextChars["Nothing"]
            button.text.healthupdate=true
        end
        if button.text.namehealth~=vTextChars["Nothing"] then
            button.text.namehealth=vTextChars["Nothing"]
            HealBot_Text_ConcatNameText(button)
        end
        HealBot_Text_UpdateText(button)
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
            HealBot_Timers_Set("SKINS","TextUpdateHealth")
        else
            if hbSeparateInHealsAbsorbs[x] then
                HealBot_Timers_Set("SKINS","ClearSeparateInHealsAbsorbs")
            end
            hbSeparateInHealsAbsorbs[x]=false
        end
        if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][x]["OVERHEAL"]>1 then
            hbOverHeal[x]=true
        else
            if hbOverHeal[x] then
                HealBot_Timers_Set("SKINS","ClearOverHeals")
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
            elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["INCHEALS"]==3 then
                if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["INCABSORBS"]==3 then
                    sepHealTxt=button.health.incoming+button.health.absorbs
                else
                    sepHealTxt=button.health.incoming
                end
            else
                sepHealTxt=button.health.absorbs
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
      --HealBot_setCall("HealBot_Text_setInHealAbsorbsText")
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
      --HealBot_setCall("HealBot_Text_setOverHealText")
end

function HealBot_Text_AggroFormat(side, frame)
    if side=="Left" then
        return aggroNumFormatSurLa[frame]
    else
        return aggroNumFormatSurRa[frame]
    end
end

function HealBot_Text_setAggroText(button)
    if not Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["TAGAGGROONLYTIP"] and button.aggro.threatpct>0 then
        tHealthConcat[1]=aggroNumFormatSurLa[button.frame]
        tHealthConcat[2]=button.aggro.threatpct
        tHealthConcat[3]=vTextChars["Percent"]
        tHealthConcat[4]=aggroNumFormatSurRa[button.frame]
        vHealthTextConcatResult=HealBot_Text_HealthConcat(4)
        if button.text.aggro~=vHealthTextConcatResult then
            button.text.aggro=vHealthTextConcatResult
            button.text.aggroupdate=true
            HealBot_Text_UpdateText(button)
        end
    elseif button.text.aggro~=vTextChars["Nothing"] then
        button.text.aggro=vTextChars["Nothing"]
        button.text.aggroupdate=true
        HealBot_Text_UpdateText(button)
    end
      --HealBot_setCall("HealBot_Text_setAggroText")
end

local prevTag=""
function HealBot_Text_setNameTag(button)
    prevTag=button.text.tag
    if UnitExists(button.unit) and button.status.current<HealBot_Unit_Status["RESERVED"] then
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
        if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["STATETXTANCHOR"]==4 then
            if button.gref.txt["text3"]:GetText()~=vTextChars["Nothing"] then
                button.gref.txt["text3"]:SetText(vTextChars["Nothing"])
            end
            if not Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["TAGSTATEONLYTIP"] then
                button.text.nametag=button.text.tag
                HealBot_Text_setNameText(button)
            elseif button.text.nametag~=vTextChars["Nothing"] then
                button.text.nametag=vTextChars["Nothing"]
                HealBot_Text_setNameText(button)
            end
        else
            if button.text.nametag~=vTextChars["Nothing"] then
                button.text.nametag=vTextChars["Nothing"]
                HealBot_Text_setNameText(button)
            end
            button.text.tagupdate=true
            HealBot_Text_UpdateText(button)
        end
        if HealBot_Text_AuxAssigns["State"][button.frame] then
            if string.len(button.text.tag)>0 then
                HealBot_Aux_UpdateStateBar(button)
            else
                HealBot_Aux_ClearStateBar(button)
            end
        end
    end
      --HealBot_setCall("HealBot_Text_setNameTag")
end

local vSetNameTextName,vSetNameTextClass,vSetNameTextRole,vSetNameTextStrLen,vSetNameTextBtnLen,vHealthTextConcatIndex="","","",0,0,0
function HealBot_Text_ConcatNameText(button)
    if button.text.namehealth~=vTextChars["Nothing"] then
        if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["HEALEXTRACOL"]==2 then
            tConcat[1]=button.text.name
            tConcat[2]=vTextChars["Space"]
            tConcat[3]=vTextCustomCols["Health"][button.frame]
            tConcat[4]=button.text.namehealth
            button.text.namecomplete=HealBot_Text_Concat(4)
        else
            tConcat[1]=button.text.name
            tConcat[2]=vTextChars["Space"]
            tConcat[3]=button.text.namehealth
            button.text.namecomplete=HealBot_Text_Concat(3)
        end
    else
        button.text.namecomplete=button.text.name
    end

    button.text.nameupdate=true
    HealBot_Text_UpdateText(button)
end

function HealBot_Text_setNameText(button)
    button.text.nameonly=HealBot_GetUnitName(button)
    if button.status.current<HealBot_Unit_Status["RESERVED"] then
        if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["CLASSONBAR"] then
            vSetNameTextClass=UnitClass(button.unit) or ""
            if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["SHOWROLE"] then
                vSetNameTextRole=HealBot_Panel_UnitRole(button.unit)
                if vSetNameTextRole=="DAMAGER" then
                    vSetNameTextClass=Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["ROLEDPS"] or HEALBOT_WORD_DAMAGER
                elseif vSetNameTextRole=="HEALER" then
                    vSetNameTextClass=Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["ROLEHEAL"] or HEALBOT_WORD_HEALER
                elseif vSetNameTextRole=="TANK" then
                    vSetNameTextClass=Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["ROLETANK"] or HEALBOT_WORD_TANK
                end
            end
            if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["NAMEONBAR"] then
                if string.len(vSetNameTextClass)<1 then
                    vSetNameTextName=button.text.nameonly
                else
                    tConcat[1]=vSetNameTextClass
                    tConcat[2]=vTextChars["Colon"]
                    tConcat[3]=button.text.nameonly
                    vSetNameTextName=HealBot_Text_Concat(3)
                end
            else
                vSetNameTextName=vSetNameTextClass;
            end
        elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["NAMEONBAR"] then
            if Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][button.frame]["SHOWTEXT"]>1 and 
                   (button.aggro.status or 0)>Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][button.frame]["ALERT"] then
                tConcat[1]=hbNameFormats["AggroLeft"][button.frame]
                tConcat[2]=button.text.nameonly
                tConcat[3]=hbNameFormats["AggroRight"][button.frame]
                vSetNameTextName=HealBot_Text_Concat(3)
            else
                vSetNameTextName=button.text.nameonly
            end
        else
            if button.text.namecomplete~=vTextChars["Nothing"] then
                button.text.name=button.text.namecomplete
            end
            vSetNameTextName=vTextChars["Nothing"]
        end
    elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["NAMEONBAR"] then
        vSetNameTextName=button.unit
    else
        if button.text.namecomplete~=vTextChars["Nothing"] then
            button.text.name=button.text.namecomplete
        end
        vSetNameTextName=vTextChars["Nothing"]
    end

    if button.text.nametag~=vTextChars["Nothing"] then
        tConcat[1]=button.text.nametag
        tConcat[2]=vTextChars["Space"]
        tConcat[3]=vSetNameTextName or ""
        vSetNameTextName=HealBot_Text_Concat(3)
    end
    if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["MAXCHARS"]>0 then
        vSetNameTextStrLen=hbStringLen(hbutf8sub(vSetNameTextName, "%s+", ""))
        if button.frame==10 and HealBot_Panel_isSpecialUnit(button.unit)>0 then
            vSetNameTextBtnLen=HealBot_Text_EnemySizeWidth["NAME"][HealBot_Panel_isSpecialUnit(button.unit)]-vSetNameTextStrLen
        else
            vSetNameTextBtnLen=hbBarTextLen[button.frame]-vSetNameTextStrLen
        end
        if vSetNameTextBtnLen<0 then
            if button.frame==10 and HealBot_Panel_isSpecialUnit(button.unit)>0 then
                tConcat[1]=hbStringSub(vSetNameTextName,1,HealBot_Text_EnemySizeWidth["NAME"][HealBot_Panel_isSpecialUnit(button.unit)])
            else
                tConcat[1]=hbStringSub(vSetNameTextName,1,hbBarTextLen[button.frame])
            end
            tConcat[2]=vTextChars["Dot"]
            vSetNameTextName = HealBot_Text_Concat(2)
        end
    end

    if button.text.name~=vSetNameTextName then
        button.text.name=vSetNameTextName
        HealBot_Text_ConcatNameText(button)
    end
    if HealBot_Text_AuxAssigns["Name"][button.frame] then
        HealBot_Aux_DoUpdateNameOverLay(button)
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
    
    for id,xButton in pairs(HealBot_Fluid_TextStateAlpha) do
        aufbButtonActive=false
        aufbAlphaValue=xButton.gref.txt["text3"]:GetAlpha()
        aufbAlphaValue=HealBot_Comm_round(aufbAlphaValue, 2)
        if aufbAlphaValue>xButton.text.sa then
            aufbSetValue=aufbAlphaValue-HealBot_Text_luVars["FluidTextAlphaUpdate"]
            if aufbSetValue<xButton.text.sa then 
                aufbSetValue=xButton.text.sa
            else
                aufbButtonActive=true
            end
        elseif aufbAlphaValue<xButton.text.sa then
            aufbSetValue=aufbAlphaValue+HealBot_Text_luVars["FluidTextAlphaUpdate"]
            if aufbSetValue>xButton.text.sa then 
                aufbSetValue=xButton.text.sa
            else
                aufbButtonActive=true
            end
        else
            aufbSetValue=xButton.text.sa
        end
        xButton.gref.txt["text3"]:SetTextColor(xButton.text.sr, xButton.text.sg, xButton.text.sb, aufbSetValue)

        if not aufbButtonActive then
            HealBot_Fluid_TextStateAlpha[id]=nil
        else
            HealBot_Text_luVars["FluidTextAlphaInUse"]=true
        end
    end
    
    for id,xButton in pairs(HealBot_Fluid_TextAggroAlpha) do
        aufbButtonActive=false
        aufbAlphaValue=xButton.gref.txt["text4"]:GetAlpha()
        aufbAlphaValue=HealBot_Comm_round(aufbAlphaValue, 2)
        if aufbAlphaValue>xButton.text.aa then
            aufbSetValue=aufbAlphaValue-HealBot_Text_luVars["FluidTextAlphaUpdate"]
            if aufbSetValue<xButton.text.aa then 
                aufbSetValue=xButton.text.aa
            else
                aufbButtonActive=true
            end
        elseif aufbAlphaValue<xButton.text.aa then
            aufbSetValue=aufbAlphaValue+HealBot_Text_luVars["FluidTextAlphaUpdate"]
            if aufbSetValue>xButton.text.aa then 
                aufbSetValue=xButton.text.aa
            else
                aufbButtonActive=true
            end
        else
            aufbSetValue=xButton.text.aa
        end
        xButton.gref.txt["text4"]:SetTextColor(xButton.text.ar, xButton.text.ag, xButton.text.ab, aufbSetValue)

        if not aufbButtonActive then
            HealBot_Fluid_TextAggroAlpha[id]=nil
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

local function HealBot_Text_UpdateStateColour(button)
    if HealBot_Text_luVars["FluidAlphaInUse"] then
        HealBot_Fluid_TextStateAlpha[button.id]=button
        if not HealBot_Text_luVars["FluidTextAlphaInUse"] then
            HealBot_Text_UpdateFluidTextAlpha()
        end
        --HealBot_Aux_setLuVars("FluidTextAlphaInUse", true)
    else
        button.gref.txt["text3"]:SetTextColor(button.text.sr, button.text.sg, button.text.sb, button.text.sa)
    end
      --HealBot_setCall("HealBot_Text_UpdateStateColour")
end

local function HealBot_Text_UpdateNameColour(button)
    if HealBot_Text_luVars["FluidAlphaInUse"] then
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
    if HealBot_Text_luVars["FluidAlphaInUse"] and button.status.current<HealBot_Unit_Status["DC"] then
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

function HealBot_Text_UpdateAggroColour(button)
    if HealBot_Text_luVars["FluidAlphaInUse"] and button.status.current<HealBot_Unit_Status["DC"] then
        HealBot_Fluid_TextAggroAlpha[button.id]=button
        if not HealBot_Text_luVars["FluidTextAlphaInUse"] then
            HealBot_Text_UpdateFluidTextAlpha()
        end
        --HealBot_Aux_setLuVars("FluidTextAlphaInUse", true)
    else
        button.gref.txt["text4"]:SetTextColor(button.text.ar, button.text.ag, button.text.ab, button.text.aa)
    end
      --HealBot_setCall("HealBot_Text_UpdateAggroColour")
end

local testNameTxt,vpR,vpG,vpB="",0,0,0
function HealBot_Text_UpdateText(button)
    if button.text.tagupdate then
        button.text.tagupdate=false
        if not Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["TAGSTATEONLYTIP"] then
            button.text.sr, button.text.sg, button.text.sb = HealBot_Text_StateColours(button)
            if button.status.enabled or button.status.summons then
                button.text.sa=HealBot_Action_BarColourAlpha(button, Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["SCA"], 1)
            else
                button.text.sa=HealBot_Action_BarColourAlpha(button, Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["SCDA"], 1)
            end
            HealBot_Text_UpdateStateColour(button)
            button.gref.txt["text3"]:SetText(button.text.tag)
        end
    end
    if button.text.aggroupdate then
        button.text.aggroupdate=false
        if button.status.current<HealBot_Unit_Status["DEAD"] then
            if button.status.enabled then
                button.text.aa=HealBot_Action_BarColourAlpha(button, Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["ACA"], 1)
            else
                button.text.aa=HealBot_Action_BarColourAlpha(button, Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["ACDA"], 1)
            end
            button.text.ar, button.text.ag, button.text.ab = HealBot_Text_TextAggroColours(button)
        else
            button.text.ar, button.text.ag, button.text.ab, button.text.aa = 0, 0, 0, 0
        end
        HealBot_Text_UpdateAggroColour(button)
        button.gref.txt["text4"]:SetText(button.text.aggro)
    end
    if button.text.nameupdate then
        button.text.nameupdate=false
        if button.status.current<HealBot_Unit_Status["DC"] then
            button.text.nr, button.text.ng, button.text.nb = HealBot_Text_TextNameColours(button)
        else
            button.text.nr, button.text.ng, button.text.nb= 0.5, 0.5, 0.5
        end
        if button.status.enabled or button.status.summons then
            button.text.na=HealBot_Action_BarColourAlpha(button, Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["NCA"], 1)
        else
            button.text.na=HealBot_Action_BarColourAlpha(button, Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["NCDA"], 1)
        end
        HealBot_Text_UpdateNameColour(button)
        button.gref.txt["text"]:SetText(button.text.namecomplete);
    end
    if button.text.healthupdate then
        button.text.healthupdate=false
        if button.health.current>0 then
            if button.status.enabled then
                button.text.ha=HealBot_Action_BarColourAlpha(button, Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["HCA"], 1)
            else
                button.text.ha=HealBot_Action_BarColourAlpha(button, Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["HCDA"], 1)
            end
            button.text.hr, button.text.hg, button.text.hb = HealBot_Text_TextHealthColours(button)
            HealBot_Text_UpdateHealthColour(button)
            button.gref.txt["text2"]:SetText(button.text.healthcomplete)
        elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["TAGSTATEONLYTIP"] then
            if HealBot_Action_IsUnitDead(button) then
                if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["NAMEONBAR"] then
                    button.text.hr, button.text.hg, button.text.hb=0.4, 0.4, 0.4
                else
                    button.text.hr, button.text.hg, button.text.hb=HealBot_Text_DeadColours(button)
                end
                button.text.ha = HealBot_Action_BarColourAlpha(button, 0.7, 1)
                HealBot_Text_UpdateHealthColour(button)
                if string.len(Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["TAGRIP"])>0 then
                    button.gref.txt["text2"]:SetText(Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["TAGRIP"])
                else
                    button.gref.txt["text2"]:SetText(HEALBOT_DEAD_LABEL)
                end
            elseif not Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["NAMEONBAR"] then
                button.text.hr, button.text.hg, button.text.hb=0.5, 0.5, 0.5
                button.text.ha = HealBot_Action_BarColourAlpha(button, 0.7, 1)
                HealBot_Text_UpdateHealthColour(button)
                if button.status.current==HealBot_Unit_Status["DC"] then
                    if string.len(Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["TAGDC"])>0 then
                        button.gref.txt["text2"]:SetText(Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["TAGDC"])
                    else
                        button.gref.txt["text2"]:SetText(HEALBOT_DISCONNECTED_TAG)
                    end
                elseif button.status.current==HealBot_Unit_Status["RESERVED"] then
                    if string.len(Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["TAGR"])>0 then
                        button.gref.txt["text2"]:SetText(Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["TAGR"].." "..button.unit)
                    else
                        button.gref.txt["text2"]:SetText(button.unit)
                    end
                elseif button.health.current==0 then
                    if string.len(Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["TAGRIP"])>0 then
                        button.gref.txt["text2"]:SetText(Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["TAGRIP"])
                    else
                        button.gref.txt["text2"]:SetText(HEALBOT_DEAD_LABEL)
                    end
                else
                    button.gref.txt["text2"]:SetText("")
                end
            else
                button.gref.txt["text2"]:SetText("")
            end
        else
            button.gref.txt["text2"]:SetText("")
        end
    end
    if button.text.vphealthupdate then
        button.text.vphealthupdate=false
        if button.status.enabled then
            button.text.ha=HealBot_Action_BarColourAlpha(button, Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["HCA"], 1)
        else
            button.text.ha=HealBot_Action_BarColourAlpha(button, Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["HCDA"], 1)
        end
        button.text.hr, button.text.hg, button.text.hb = HealBot_Text_TextHealthColours(button)
        button.gref.txt["text5"]:SetTextColor(button.text.hr, button.text.hg, button.text.hb, button.text.ha)
        button.gref.txt["text5"]:SetText(button.text.vphealth)
    end
      --HealBot_setCall("HealBot_Text_UpdateText")
end

function HealBot_Text_UpdateTestText(button)
    --HealBot_AddDebug("UpdateTestText unit="..button.unit,"Text",true)
    button.gref.txt["text"]:SetText("")
    button.gref.txt["text2"]:SetText("")
    button.gref.txt["text3"]:SetText("")
    button.gref.txt["text4"]:SetText("")
    if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["NAMEONBAR"] or 
       Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["CLASSONBAR"] then
        if not Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["TAGSTATEONLYTIP"] and Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["STATETXTANCHOR"]==4 then
            testNameTxt=HEALBOT_OPTIONS_TAB_STATETEXT.."  "..button.unit
        else
            testNameTxt=button.unit
        end
        if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["HLTHONBAR"] and Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["HLTHTXTANCHOR"]==4 then
            if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["HLTHTYPE"]==1 then
                testNameTxt=testNameTxt.." 10K"
            elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["HLTHTYPE"]==2 then
                testNameTxt=testNameTxt.." (0)"
            else
                testNameTxt=testNameTxt.." (100%)"
            end
        end
        button.gref.txt["text"]:SetText(testNameTxt)
        --HealBot_AddDebug("testNameTxt="..testNameTxt,"Text",true)
    end
    if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["HLTHONBAR"] and Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["HLTHTXTANCHOR"]~=4 then
        if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["HLTHTYPE"]==1 then
            button.gref.txt["text2"]:SetText("10K") --  "..button.id.. "  "..button.unit);
        elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["HLTHTYPE"]==2 then
            button.gref.txt["text2"]:SetText("(0)");
        else
            button.gref.txt["text2"]:SetText("(100%)");
        end
    end
    if button.frame<10 then
        if not Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["TAGSTATEONLYTIP"] and Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["STATETXTANCHOR"]~=4 then
            button.text.tag=HEALBOT_OPTIONS_TAB_STATETEXT
            button.gref.txt["text3"]:SetText(HEALBOT_OPTIONS_TAB_STATETEXT)
        end
        if not Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["TAGAGGROONLYTIP"] then
            if button.id<101 then
                button.gref.txt["text4"]:SetText(HealBot_Text_AggroFormat("Left", button.frame)..button.id.."%"..HealBot_Text_AggroFormat("Right", button.frame))
            else
                button.gref.txt["text4"]:SetText(HealBot_Text_AggroFormat("Left", button.frame).."99%"..HealBot_Text_AggroFormat("Right", button.frame))
            end
        end
    end
end

local cText=""
function HealBot_Text_UpdateNameButton(button)
    cText=button.gref.txt["text"]:GetText() or button.text.namecomplete or "."
    button.gref.txt["text"]:SetText(cText.." ")
    button.gref.txt["text"]:SetText(cText)
    HealBot_Text_setNameText(button)
end

function HealBot_Text_UpdateNames()
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_Text_UpdateNameButton(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_Text_UpdateNameButton(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_Text_UpdateNameButton(xButton)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_Text_UpdateNameButton(xButton)
    end
    for _,xButton in pairs(HealBot_Enemy_Button) do
        HealBot_Text_UpdateNameButton(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_Text_UpdateNameButton(xButton)
    end
   -- HealBot_Timers_Set("LAST","ResetUnitStatus")
end

function HealBot_Text_UpdateHealthButton(button)
    cText=button.gref.txt["text2"]:GetText() or button.text.healthcomplete or "."
    button.gref.txt["text2"]:SetText(cText.." ")
    button.gref.txt["text2"]:SetText(cText)
    HealBot_Text_setHealthText(button)
end

function HealBot_Text_UpdateHealth()
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_Text_UpdateHealthButton(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_Text_UpdateHealthButton(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_Text_UpdateHealthButton(xButton)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_Text_UpdateHealthButton(xButton)
    end
    for _,xButton in pairs(HealBot_Enemy_Button) do
        HealBot_Text_UpdateHealthButton(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_Text_UpdateHealthButton(xButton)
    end
   -- HealBot_Timers_Set("LAST","ResetUnitStatus")
end

function HealBot_Text_UpdateStateButton(button)
    if not Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["TAGSTATEONLYTIP"] then
        cText=button.gref.txt["text3"]:GetText() or button.text.tag or "."
        button.gref.txt["text3"]:SetText(cText.." ")
        button.gref.txt["text3"]:SetText(cText)
    else
        button.gref.txt["text3"]:SetText("")
    end
    HealBot_Text_setNameTag(button)
end

function HealBot_Text_UpdateState()
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_Text_UpdateStateButton(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_Text_UpdateStateButton(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_Text_UpdateStateButton(xButton)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_Text_UpdateStateButton(xButton)
    end
    for _,xButton in pairs(HealBot_Enemy_Button) do
        HealBot_Text_UpdateStateButton(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_Text_UpdateStateButton(xButton)
    end
   -- HealBot_Timers_Set("LAST","ResetUnitStatus")
end

function HealBot_Text_UpdateButton(button)
    button.text.nameupdate=true
    if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["STATETXTANCHOR"]~=4 then button.text.tagupdate=true end
    if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["HLTHTXTANCHOR"]~=4 then button.text.healthupdate=true end
    HealBot_Text_UpdateText(button)
end

function HealBot_Text_UpdateButtons()
    if not HealBot_Text_luVars["TestBarsOn"] then
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
    else
        for _,xButton in pairs(HealBot_Test_Button) do
            HealBot_Text_UpdateTestText(xButton)
        end
    end
end
