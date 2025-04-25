local HealBot_Fluid_TextNameAlpha={}
local HealBot_Fluid_TextStateAlpha={}
local HealBot_Fluid_TextHealthAlpha={}
local HealBot_Fluid_TextAggroAlpha={}
local hbBarTextLen={[1]=50,[2]=50,[3]=50,[4]=50,[5]=50,[6]=50,[7]=50,[8]=50,[9]=50,[10]=50}
local hbBarHealthTextLen={[1]=50,[2]=50,[3]=50,[4]=50,[5]=50,[6]=50,[7]=50,[8]=50,[9]=50,[10]=50}
local hbSeparateInHealsAbsorbs={[1]=false,[2]=false,[3]=false,[4]=false,[5]=false,[6]=false,[7]=false,[8]=false,[9]=false,[10]=false}
local hbOverHeal={[1]=false,[2]=false,[3]=false,[4]=false,[5]=false,[6]=false,[7]=false,[8]=false,[9]=false,[10]=false}

local hbNumFormats={["Places"]=       {[1]=-1, [2]=-1, [3]=-1, [4]=-1, [5]=-1, [6]=-1, [7]=-1, [8]=-1, [9]=-1, [10]=-1},
                      ["SurroundLeft"]= {[1]="(",[2]="(",[3]="(",[4]="(",[5]="(",[6]="(",[7]="(",[8]="(",[9]="(",[10]="("},
                      ["SurroundRight"]={[1]=")",[2]=")",[3]=")",[4]=")",[5]=")",[6]=")",[7]=")",[8]=")",[9]=")",[10]=")"},
                      ["SuffixK"]=      {[1]="", [2]="", [3]="", [4]="", [5]="", [6]="", [7]="", [8]="", [9]="", [10]=""},
                      ["SuffixM"]=      {[1]="", [2]="", [3]="", [4]="", [5]="", [6]="", [7]="", [8]="", [9]="", [10]=""},
                      ["OverHealLeft"]= {[1]="", [2]="", [3]="", [4]="", [5]="", [6]="", [7]="", [8]="", [9]="", [10]=""},
                      ["OverHealRight"]={[1]="", [2]="", [3]="", [4]="", [5]="", [6]="", [7]="", [8]="", [9]="", [10]=""},
                      ["InHealLeft"]=   {[1]="", [2]="", [3]="", [4]="", [5]="", [6]="", [7]="", [8]="", [9]="", [10]=""},
                      ["InHealRight"]=  {[1]="", [2]="", [3]="", [4]="", [5]="", [6]="", [7]="", [8]="", [9]="", [10]=""},
                     }
local hbNameFormats={["AggroLeft"]= {[1]="(",[2]="(",[3]="(",[4]="(",[5]="(",[6]="(",[7]="(",[8]="(",[9]="(",[10]="("},
                       ["AggroRight"]={[1]=")",[2]=")",[3]=")",[4]=")",[5]=")",[6]=")",[7]=")",[8]=")",[9]=")",[10]=")"},
                      }
local aggroNumFormatSurLa={[1]="[",[2]="[",[3]="[",[4]="[",[5]="[",[6]="[",[7]="[",[8]="[",[9]="[",}
local aggroNumFormatSurRa={[1]="]",[2]="]",[3]="]",[4]="]",[5]="]",[6]="]",[7]="]",[8]="]",[9]="]",}
local tagWithName={[1]=false,[2]=false,[3]=false,[4]=false,[5]=false,[6]=false,[7]=false,[8]=false,[9]=false,[10]=false}
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

local hbTagsInUse={}
for x=1,10 do
    hbTagsInUse[x]={}
    hbTagsInUse[x]["DC"]=false
    hbTagsInUse[x]["DEAD"]=false
    hbTagsInUse[x]["OOR"]=false
    hbTagsInUse[x]["RES"]=false
    hbTagsInUse[x]["SUM"]=false
    hbTagsInUse[x]["GROUP"]=false
    hbTagsInUse[x]["DEBUFF"]=false
    hbTagsInUse[x]["BUFF"]=false
end

function HealBot_Text_TagInUse(frame, id)
    return hbTagsInUse[frame][id]
end

function HealBot_Text_SetTagInUse()
    for x=1,10 do
        if string.len(hbv_Skins_GetFrameVar("BarText", "TAGDC", x))>0 then
            hbTagsInUse[x]["DC"]=true
        else
            hbTagsInUse[x]["DC"]=false
        end
        if string.len(hbv_Skins_GetFrameVar("BarText", "TAGSUM", x))>0 then
            hbTagsInUse[x]["SUM"]=true
        else
            hbTagsInUse[x]["SUM"]=false
        end
        if string.len(hbv_Skins_GetFrameVar("BarText", "TAGOOR", x))>0 then
            hbTagsInUse[x]["OOR"]=true
        else
            hbTagsInUse[x]["OOR"]=false
        end
        if string.len(hbv_Skins_GetFrameVar("BarText", "TAGRIP", x))>0 then
            hbTagsInUse[x]["DEAD"]=true
        else
            hbTagsInUse[x]["DEAD"]=false
        end
        if string.len(hbv_Skins_GetFrameVar("BarText", "TAGRES", x))>0 then
            hbTagsInUse[x]["RES"]=true
        else
            hbTagsInUse[x]["RES"]=false
        end
        if string.len(hbv_Skins_GetFrameVar("BarText", "TAGDEBUFF", x))>0 then
            hbTagsInUse[x]["DEBUFF"]=true
        else
            hbTagsInUse[x]["DEBUFF"]=false
        end
        if string.len(hbv_Skins_GetFrameVar("BarText", "TAGBUFF", x))>0 then
            hbTagsInUse[x]["BUFF"]=true
        else
            hbTagsInUse[x]["BUFF"]=false
        end
        if string.len(hbv_Skins_GetFrameVar("BarText", "TAGGROUP", x))>0 then
            hbTagsInUse[x]["GROUP"]=true
        else
            hbTagsInUse[x]["GROUP"]=false
        end
    end
    HealBot_Timers_Set("SKINS","TextUpdateState")
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
HealBot_Text_luVars["TestBarsOn"]=false

local hbCustomRoleCols={["TANK"]={}, ["HEALER"]={}, ["DAMAGER"]={}}
function HealBot_Text_SetCustomRoleCols()
      --HealBot_setCall("HealBot_Text_SetCustomRoleCols")
    hbCustomRoleCols["TANK"].r,hbCustomRoleCols["TANK"].g, hbCustomRoleCols["TANK"].b=hbv_Skins_GetRoleCol("TANK", HealBot_Globals.OverrideColours["USEROLE"])
    hbCustomRoleCols["HEALER"].r,hbCustomRoleCols["HEALER"].g, hbCustomRoleCols["HEALER"].b=hbv_Skins_GetRoleCol("HEALER", HealBot_Globals.OverrideColours["USEROLE"])
    hbCustomRoleCols["DAMAGER"].r,hbCustomRoleCols["DAMAGER"].g, hbCustomRoleCols["DAMAGER"].b=hbv_Skins_GetRoleCol("DAMAGER", HealBot_Globals.OverrideColours["USEROLE"])
end

function HealBot_Text_setAuxAssigns(vName, frame, vValue)
      --HealBot_setCall("HealBot_Text_setAuxAssigns - "..vName)
    HealBot_Text_AuxAssigns[vName][frame]=vValue
end

function HealBot_Text_setLuVars(vName, vValue)
      --HealBot_setCall("HealBot_Text_setLuVars - "..vName)
    HealBot_Text_luVars[vName]=vValue
end

function HealBot_Text_retLuVars(vName)
      --HealBot_setCall("HealBot_Text_retLuVars - "..vName)
    return HealBot_Text_luVars[vName]
end

function HealBot_Text_Len(v)
      --HealBot_setCall("HealBot_Text_Len")
    if "string" == type( v ) then
        return hbStringLen(v)
    else
        return 0
    end
end

function HealBot_Text_Sub(v,s,l)
      --HealBot_setCall("HealBot_Text_Sub")
    return hbStringSub(v,s,l)
end

local tConcat={}
local tabconcat=table.concat
function HealBot_Text_Concat(elements)
      --HealBot_setCall("HealBot_Text_Concat")
    return tabconcat(tConcat,"",1,elements)
end

local tHealthConcat={}
local tShortConcat={}
local tabconcat=table.concat
function HealBot_Text_HealthConcat(elements)
      --HealBot_setCall("HealBot_Text_HealthConcat")
    return tabconcat(tHealthConcat,"",1,elements)
end

function HealBot_Text_ShortConcat()
      --HealBot_setCall("HealBot_Text_ShortConcat")
    return tabconcat(tShortConcat,"",1,2)
end

local vSetTextLenAux=0
function HealBot_Text_setEnemyTextLen(bWidth, eBarID, tSize)
      --HealBot_setCall("HealBot_Text_setEnemyTextLen")
    if hbv_Skins_GetFrameVar("BarText", "MAXCHARS", 10) == 0 then
        HealBot_Text_EnemySizeWidth["NAME"][eBarID]=100
    elseif eBarID == 2 then
        HealBot_Text_EnemySizeWidth["NAME"][eBarID]=ceil(hbv_Skins_GetFrameVar("BarText", "MAXCHARS", 10)*tSize)+1
    else
        HealBot_Text_EnemySizeWidth["NAME"][eBarID]=hbv_Skins_GetFrameVar("BarText", "MAXCHARS", 10)
    end
    if hbv_Skins_GetFrameVar("BarText", "HMAXCHARS", 10) == 0 then
        HealBot_Text_EnemySizeWidth["HLTH"][eBarID]=100
    elseif eBarID == 2 then
        HealBot_Text_EnemySizeWidth["HLTH"][eBarID]=ceil(hbv_Skins_GetFrameVar("BarText", "HMAXCHARS", 10)*tSize)+1
    else
        HealBot_Text_EnemySizeWidth["HLTH"][eBarID]=hbv_Skins_GetFrameVar("BarText", "HMAXCHARS", 10)
    end
    for x=1,9 do
        if hbv_Aux_GetBarTextVar("MAXCHARS", 10, x) == 0 then
            vSetTextLenAux=100
        elseif eBarID == 2 then
            vSetTextLenAux=ceil(hbv_Aux_GetBarTextVar("MAXCHARS", 10, x)*tSize)+1
        else
            vSetTextLenAux=hbv_Aux_GetBarTextVar("MAXCHARS", 10, x)
        end
        HealBot_Aux_setTextMaxChars(10, vSetTextLenAux, x)
    end
end

function HealBot_Text_setTextLen(frame)
      --HealBot_setCall("HealBot_Text_setTextLen")
    if hbv_Skins_GetFrameVar("BarText", "MAXCHARS", frame) == 0 then
        hbBarTextLen[frame]=1000
    else
        hbBarTextLen[frame]=hbv_Skins_GetFrameVar("BarText", "MAXCHARS", frame)
    end
    if hbv_Skins_GetFrameVar("BarText", "HMAXCHARS", frame) == 0 then
        hbBarHealthTextLen[frame]=1000
    else
        hbBarHealthTextLen[frame]=hbv_Skins_GetFrameVar("BarText", "HMAXCHARS", frame)
    end
    for x=1,9 do
        if hbv_Aux_GetBarTextVar("MAXCHARS", frame, x) == 0 then
            vSetTextLenAux=1000
        else
            vSetTextLenAux=hbv_Aux_GetBarTextVar("MAXCHARS", frame, x)
        end
        HealBot_Aux_setTextMaxChars(frame, vSetTextLenAux, x)
    end
end

function HealBot_Text_setEnemySizeWidth(vName, vValue, tSize)
      --HealBot_setCall("HealBot_Text_setEnemySizeWidth")
    if vName == "EnemySizeWidth1" then
        HealBot_Text_setEnemyTextLen(vValue, 1, tSize)
    else
        HealBot_Text_setEnemyTextLen(vValue, 2, tSize)
    end
end

function HealBot_Text_sethbNumberFormat()
      --HealBot_setCall("HealBot_Text_sethbNumberFormat")
    for j=1,10 do
        if hbv_Skins_GetFrameVar("BarText", "NUMFORMAT1", j) == 2 or hbv_Skins_GetFrameVar("BarText", "NUMFORMAT1", j) == 5 or hbv_Skins_GetFrameVar("BarText", "NUMFORMAT1", j) == 8 then
            hbNumFormats["Places"][j]=0
        elseif hbv_Skins_GetFrameVar("BarText", "NUMFORMAT1", j) == 3 or hbv_Skins_GetFrameVar("BarText", "NUMFORMAT1", j) == 6 or hbv_Skins_GetFrameVar("BarText", "NUMFORMAT1", j) == 9 then
            hbNumFormats["Places"][j]=1
        elseif hbv_Skins_GetFrameVar("BarText", "NUMFORMAT1", j) == 4 or hbv_Skins_GetFrameVar("BarText", "NUMFORMAT1", j) == 7 or hbv_Skins_GetFrameVar("BarText", "NUMFORMAT1", j) == 10 then
            hbNumFormats["Places"][j]=2
        elseif hbv_Skins_GetFrameVar("BarText", "NUMFORMAT1", j) == 11 then
            hbNumFormats["Places"][j]=3
        else
            hbNumFormats["Places"][j]=-1
        end
        if hbv_Skins_GetFrameVar("BarText", "NUMFORMAT1", j)>1 and hbv_Skins_GetFrameVar("BarText", "NUMFORMAT1", j)<5 then
            hbNumFormats["SuffixK"][j]=vShortChars["UpperK"]
            hbNumFormats["SuffixM"][j]=vShortChars["UpperM"]
        elseif hbv_Skins_GetFrameVar("BarText", "NUMFORMAT1", j)>4 and hbv_Skins_GetFrameVar("BarText", "NUMFORMAT1", j)<8 then
            hbNumFormats["SuffixK"][j]=vShortChars["LowerK"]
            hbNumFormats["SuffixM"][j]=vShortChars["LowerM"]
        elseif hbv_Skins_GetFrameVar("BarText", "NUMFORMAT1", j) == 11 then
            hbNumFormats["SuffixK"][j]=vShortChars["UpperK"]
            hbNumFormats["SuffixM"][j]=vShortChars["UpperM"]
        else
            hbNumFormats["SuffixK"][j]=vTextChars["Nothing"]
            hbNumFormats["SuffixM"][j]=vTextChars["Nothing"]
        end
        if hbv_Skins_GetFrameVar("BarText", "NUMFORMAT2", j) == 2 then
            hbNumFormats["SurroundLeft"][j]="("
            hbNumFormats["SurroundRight"][j]=")"
        elseif hbv_Skins_GetFrameVar("BarText", "NUMFORMAT2", j) == 3 then
            hbNumFormats["SurroundLeft"][j]="["
            hbNumFormats["SurroundRight"][j]="]"
        elseif hbv_Skins_GetFrameVar("BarText", "NUMFORMAT2", j) == 4 then
            hbNumFormats["SurroundLeft"][j]="{"
            hbNumFormats["SurroundRight"][j]="}"
        elseif hbv_Skins_GetFrameVar("BarText", "NUMFORMAT2", j) == 5 then
            hbNumFormats["SurroundLeft"][j]=vTextChars["LessThan"]
            hbNumFormats["SurroundRight"][j]=vTextChars["GreaterThan"]
        elseif hbv_Skins_GetFrameVar("BarText", "NUMFORMAT2", j) == 6 then
            hbNumFormats["SurroundLeft"][j]="~"
            hbNumFormats["SurroundRight"][j]=vTextChars["Nothing"]
        elseif hbv_Skins_GetFrameVar("BarText", "NUMFORMAT2", j) == 7 then
            hbNumFormats["SurroundLeft"][j]=vTextChars["Colon"]
            hbNumFormats["SurroundRight"][j]=vTextChars["Colon"]
        elseif hbv_Skins_GetFrameVar("BarText", "NUMFORMAT2", j) == 8 then
            hbNumFormats["SurroundLeft"][j]="*"
            hbNumFormats["SurroundRight"][j]="*"
        else
            hbNumFormats["SurroundLeft"][j]=vTextChars["Nothing"]
            hbNumFormats["SurroundRight"][j]=vTextChars["Nothing"]
        end
        if hbNumFormats["Places"][j] == -1 then
            hbNumFormats["SuffixK"][j]=vTextChars["Nothing"]
            hbNumFormats["SuffixM"][j]=vTextChars["Nothing"]
        end

        hbNumFormats["OverHealLeft"][j]=vTextChars["Nothing"]
        hbNumFormats["OverHealRight"][j]=vTextChars["Nothing"]
        if hbv_Skins_GetFrameVar("BarText", "OVERHEALFORMAT", j) == 2 then
            hbNumFormats["OverHealLeft"][j]="^"
        elseif hbv_Skins_GetFrameVar("BarText", "OVERHEALFORMAT", j) == 3 then
            hbNumFormats["OverHealLeft"][j]=vTextChars["Plus"]
        elseif hbv_Skins_GetFrameVar("BarText", "OVERHEALFORMAT", j) == 4 then
            hbNumFormats["OverHealLeft"][j]=vTextChars["LessThan"]
        elseif hbv_Skins_GetFrameVar("BarText", "OVERHEALFORMAT", j) == 5 then
            hbNumFormats["OverHealLeft"][j]="("
            hbNumFormats["OverHealRight"][j]=")"
        elseif hbv_Skins_GetFrameVar("BarText", "OVERHEALFORMAT", j) == 6 then
            hbNumFormats["OverHealLeft"][j]="{"
            hbNumFormats["OverHealRight"][j]="}"
        elseif hbv_Skins_GetFrameVar("BarText", "OVERHEALFORMAT", j) == 7 then
            hbNumFormats["OverHealLeft"][j]="["
            hbNumFormats["OverHealRight"][j]="]"
        elseif hbv_Skins_GetFrameVar("BarText", "OVERHEALFORMAT", j) == 8 then
            hbNumFormats["OverHealLeft"][j]="<"
            hbNumFormats["OverHealRight"][j]=">"
        elseif hbv_Skins_GetFrameVar("BarText", "OVERHEALFORMAT", j) == 9 then
            hbNumFormats["OverHealLeft"][j]="="
            hbNumFormats["OverHealRight"][j]="="
        end
        
        hbNumFormats["InHealLeft"][j]=vTextChars["Nothing"]
        hbNumFormats["InHealRight"][j]=vTextChars["Nothing"]
        if hbv_Skins_GetFrameVar("BarText", "SEPARATEFORMAT", j) == 2 then
            hbNumFormats["InHealLeft"][j]="^"
        elseif hbv_Skins_GetFrameVar("BarText", "SEPARATEFORMAT", j) == 3 then
            hbNumFormats["InHealLeft"][j]=vTextChars["Plus"]
        elseif hbv_Skins_GetFrameVar("BarText", "SEPARATEFORMAT", j) == 4 then
            hbNumFormats["InHealLeft"][j]=vTextChars["LessThan"]
        elseif hbv_Skins_GetFrameVar("BarText", "SEPARATEFORMAT", j) == 5 then
            hbNumFormats["InHealLeft"][j]="("
            hbNumFormats["InHealRight"][j]=")"
        elseif hbv_Skins_GetFrameVar("BarText", "SEPARATEFORMAT", j) == 6 then
            hbNumFormats["InHealLeft"][j]="{"
            hbNumFormats["InHealRight"][j]="}"
        elseif hbv_Skins_GetFrameVar("BarText", "SEPARATEFORMAT", j) == 7 then
            hbNumFormats["InHealLeft"][j]="["
            hbNumFormats["InHealRight"][j]="]"
        elseif hbv_Skins_GetFrameVar("BarText", "SEPARATEFORMAT", j) == 8 then
            hbNumFormats["InHealLeft"][j]="<"
            hbNumFormats["InHealRight"][j]=">"
        elseif hbv_Skins_GetFrameVar("BarText", "SEPARATEFORMAT", j) == 9 then
            hbNumFormats["InHealLeft"][j]="="
            hbNumFormats["InHealRight"][j]="="
        end
    end
end

function HealBot_Text_sethbAggroNumberFormat()
      --HealBot_setCall("HealBot_Text_sethbAggroNumberFormat")
    for j=1,9 do
        if hbv_Skins_GetFrameVar("BarAggro", "TEXTFORMAT", j) == 2 then
            aggroNumFormatSurLa[j]="("
            aggroNumFormatSurRa[j]=")"
        elseif hbv_Skins_GetFrameVar("BarAggro", "TEXTFORMAT", j) == 3 then
            aggroNumFormatSurLa[j]="["
            aggroNumFormatSurRa[j]="]"
        elseif hbv_Skins_GetFrameVar("BarAggro", "TEXTFORMAT", j) == 4 then
            aggroNumFormatSurLa[j]="{"
            aggroNumFormatSurRa[j]="}"
        elseif hbv_Skins_GetFrameVar("BarAggro", "TEXTFORMAT", j) == 5 then
            aggroNumFormatSurLa[j]="<"
            aggroNumFormatSurRa[j]=">"
        elseif hbv_Skins_GetFrameVar("BarAggro", "TEXTFORMAT", j) == 6 then
            aggroNumFormatSurLa[j]="~"
            aggroNumFormatSurRa[j]=""
        elseif hbv_Skins_GetFrameVar("BarAggro", "TEXTFORMAT", j) == 7 then
            aggroNumFormatSurLa[j]=":"
            aggroNumFormatSurRa[j]=":"
        elseif hbv_Skins_GetFrameVar("BarAggro", "TEXTFORMAT", j) == 8 then
            aggroNumFormatSurLa[j]="*"
            aggroNumFormatSurRa[j]="*"
        else
            aggroNumFormatSurLa[j]=""
            aggroNumFormatSurRa[j]=""
        end
        if hbv_Skins_GetFrameVar("BarAggro", "SHOWTEXT", j) == 1 then
            hbNameFormats["AggroLeft"][j]=vTextChars["Nothing"]
            hbNameFormats["AggroRight"][j]=vTextChars["Nothing"]
        elseif hbv_Skins_GetFrameVar("BarAggro", "SHOWTEXT", j) == 2 then
            hbNameFormats["AggroLeft"][j]=">>"
            hbNameFormats["AggroRight"][j]="<<"
        elseif hbv_Skins_GetFrameVar("BarAggro", "SHOWTEXT", j) == 3 then
            hbNameFormats["AggroLeft"][j]="!!"
            hbNameFormats["AggroRight"][j]="!!"
        elseif hbv_Skins_GetFrameVar("BarAggro", "SHOWTEXT", j) == 4 then
            hbNameFormats["AggroLeft"][j]="++"
            hbNameFormats["AggroRight"][j]="++"
        elseif hbv_Skins_GetFrameVar("BarAggro", "SHOWTEXT", j) == 5 then
            hbNameFormats["AggroLeft"][j]="**"
            hbNameFormats["AggroRight"][j]="**"
        elseif hbv_Skins_GetFrameVar("BarAggro", "SHOWTEXT", j) == 6 then
            hbNameFormats["AggroLeft"][j]="^^"
            hbNameFormats["AggroRight"][j]="^^"
        elseif hbv_Skins_GetFrameVar("BarAggro", "SHOWTEXT", j) == 7 then
            hbNameFormats["AggroLeft"][j]="--"
            hbNameFormats["AggroRight"][j]="--"
        elseif hbv_Skins_GetFrameVar("BarAggro", "SHOWTEXT", j) == 8 then
            hbNameFormats["AggroLeft"][j]="##"
            hbNameFormats["AggroRight"][j]="##"
        else
            hbNameFormats["AggroLeft"][j]=" == "
            hbNameFormats["AggroRight"][j]=" == "
        end
        
    end
end

local function HealBot_Text_RGBPercToHex(r, g, b)
	r=r <= 1 and r >= 0 and r or 0
	g=g <= 1 and g >= 0 and g or 0
	b=b <= 1 and b >= 0 and b or 0
	return string.format("%02x%02x%02x", r*255, g*255, b*255)
end

local vHex=""
function HealBot_Text_setExtraCustomCols()
      --HealBot_setCall("HealBot_Text_setExtraCustomCols")
    for j=1,10 do
        vHex=HealBot_Text_RGBPercToHex(hbv_Skins_GetFrameVar("BarTextCol", "HECR", j),
                                       hbv_Skins_GetFrameVar("BarTextCol", "HECG", j),
                                       hbv_Skins_GetFrameVar("BarTextCol", "HECB", j))
        vTextCustomCols["Health"][j]="|cff"..vHex
        vHex=HealBot_Text_RGBPercToHex(hbv_Skins_GetFrameVar("BarTextCol", "OCR", j),
                                       hbv_Skins_GetFrameVar("BarTextCol", "OCG", j),
                                       hbv_Skins_GetFrameVar("BarTextCol", "OCB", j))
        vTextCustomCols["OverHeal"][j]="|cff"..vHex
        vHex=HealBot_Text_RGBPercToHex(hbv_Skins_GetFrameVar("BarTextCol", "ICR", j),
                                       hbv_Skins_GetFrameVar("BarTextCol", "ICG", j),
                                       hbv_Skins_GetFrameVar("BarTextCol", "ICB", j))
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

function HealBot_Text_DeadInRange(range)
    if not HealBot_Data["UILOCK"] and HEALBOT_GAME_VERSION>3 and range>-1 then
        return true
    elseif range>0 then
        return true
    else
        return false
    end
end

local dR, dG, dB=0,0,0
function HealBot_Text_DeadColours(button)
      --HealBot_setCall("HealBot_Text_DeadColours", button)
    if UnitIsFriend("player",button.unit) then
        if button.status.current == HealBot_Unit_Status["RES"] and hbv_Skins_GetFrameBoolean("BarTextCol", "RES", button.framecol) then
            dR=hbv_Skins_GetFrameVar("BarTextCol", "NRCR", button.framecol)
            dG=hbv_Skins_GetFrameVar("BarTextCol", "NRCG", button.framecol)
            dB=hbv_Skins_GetFrameVar("BarTextCol", "NRCB", button.framecol)
        elseif HealBot_Text_DeadInRange(button.status.range) and hbv_Skins_GetFrameBoolean("BarTextCol", "RIP", button.framecol) then
            dR=hbv_Skins_GetFrameVar("BarTextCol", "NDCR", button.framecol)
            dG=hbv_Skins_GetFrameVar("BarTextCol", "NDCG", button.framecol)
            dB=hbv_Skins_GetFrameVar("BarTextCol", "NDCB", button.framecol)
        else
            dR,dG,dB=0.58, 0.58, 0.58
        end
    else
        dR,dG,dB=0.5, 0.5, 0.5
    end
    return dR,dG,dB
end

function HealBot_Text_StateDeadColours(button)
      --HealBot_setCall("HealBot_Text_StateDeadColours", button)
    if UnitIsFriend("player",button.unit) then
        if button.status.current == HealBot_Unit_Status["RES"] and hbv_Skins_GetFrameBoolean("BarTextCol", "SRES", button.framecol) then
            dR=hbv_Skins_GetFrameVar("BarTextCol", "SRCR", button.framecol)
            dG=hbv_Skins_GetFrameVar("BarTextCol", "SRCG", button.framecol)
            dB=hbv_Skins_GetFrameVar("BarTextCol", "SRCB", button.framecol)
        elseif button.status.range>0 and hbv_Skins_GetFrameBoolean("BarTextCol", "SRIP", button.framecol) then
            dR=hbv_Skins_GetFrameVar("BarTextCol", "SDCR", button.framecol)
            dG=hbv_Skins_GetFrameVar("BarTextCol", "SDCG", button.framecol)
            dB=hbv_Skins_GetFrameVar("BarTextCol", "SDCB", button.framecol)
        else
            dR,dG,dB=0.58, 0.58, 0.58
        end
    else
        dR,dG,dB=0.5, 0.5, 0.5
    end
    return dR,dG,dB
end

local tr,tg,tb=1,1,1
function HealBot_Text_ColoursHealth(button, cType)
      --HealBot_setCall("HealBot_Text_ColoursHealth", button)
    tr,tg,tb=button.health.rcol,button.health.gcol,0
end

local htvUnit=false
function HealBot_Text_ColoursClass(button, cType)
      --HealBot_setCall("HealBot_Text_ColoursClass", button)
    htvUnit=HealBot_retIsInVehicle(button.unit)
    if htvUnit and UnitExists(htvUnit) then
        tr,tg,tb=HealBot_Action_ClassColour(htvUnit)
    else
        tr,tg,tb=button.text.r, button.text.g, button.text.b
    end
end

function HealBot_Text_ColoursRole(button, cType)
      --HealBot_setCall("HealBot_Text_ColoursRole", button)
    tr,tg,tb=hbCustomRoleCols[button.roletxt].r,hbCustomRoleCols[button.roletxt].g,hbCustomRoleCols[button.roletxt].b
end

function HealBot_Text_ColoursCustom(button, cType)
      --HealBot_setCall("HealBot_Text_ColoursCustom", button)
    if cType == "NAME" then
        if button.status.hostile then
            if button.health.pct>hbv_Skins_GetFrameVar("BarTextCol", "SIT", button.framecol) then
                tr=hbv_Skins_GetFrameVar("BarTextCol", "NCRE", button.framecol)
                tg=hbv_Skins_GetFrameVar("BarTextCol", "NCGE", button.framecol)
                tb=hbv_Skins_GetFrameVar("BarTextCol", "NCBE", button.framecol)
            elseif button.health.pct>hbv_Skins_GetFrameVar("BarTextCol", "SCT", button.framecol) then
                tr=hbv_Skins_GetFrameVar("BarTextCol", "NICRE", button.framecol)
                tg=hbv_Skins_GetFrameVar("BarTextCol", "NICGE", button.framecol)
                tb=hbv_Skins_GetFrameVar("BarTextCol", "NICBE", button.framecol)
            else
                tr=hbv_Skins_GetFrameVar("BarTextCol", "NCCRE", button.framecol)
                tg=hbv_Skins_GetFrameVar("BarTextCol", "NCCGE", button.framecol)
                tb=hbv_Skins_GetFrameVar("BarTextCol", "NCCBE", button.framecol)
            end
        else
            if button.health.pct>hbv_Skins_GetFrameVar("BarTextCol", "SIT", button.framecol) then
                tr=hbv_Skins_GetFrameVar("BarTextCol", "NCR", button.framecol)
                tg=hbv_Skins_GetFrameVar("BarTextCol", "NCG", button.framecol)
                tb=hbv_Skins_GetFrameVar("BarTextCol", "NCB", button.framecol)
            elseif button.health.pct>hbv_Skins_GetFrameVar("BarTextCol", "SCT", button.framecol) then
                tr=hbv_Skins_GetFrameVar("BarTextCol", "NICR", button.framecol)
                tg=hbv_Skins_GetFrameVar("BarTextCol", "NICG", button.framecol)
                tb=hbv_Skins_GetFrameVar("BarTextCol", "NICB", button.framecol)
            else
                tr=hbv_Skins_GetFrameVar("BarTextCol", "NCCR", button.framecol)
                tg=hbv_Skins_GetFrameVar("BarTextCol", "NCCG", button.framecol)
                tb=hbv_Skins_GetFrameVar("BarTextCol", "NCCB", button.framecol)
            end
        end
    elseif cType == "HEALTH" then
        if button.status.hostile then
            if button.health.pct>hbv_Skins_GetFrameVar("BarTextCol", "SIT", button.framecol) then
                tr=hbv_Skins_GetFrameVar("BarTextCol", "HCRE", button.framecol)
                tg=hbv_Skins_GetFrameVar("BarTextCol", "HCGE", button.framecol)
                tb=hbv_Skins_GetFrameVar("BarTextCol", "HCBE", button.framecol)
            elseif button.health.pct>hbv_Skins_GetFrameVar("BarTextCol", "SCT", button.framecol) then
                tr=hbv_Skins_GetFrameVar("BarTextCol", "HICRE", button.framecol)
                tg=hbv_Skins_GetFrameVar("BarTextCol", "HICGE", button.framecol)
                tb=hbv_Skins_GetFrameVar("BarTextCol", "HICBE", button.framecol)
            else
                tr=hbv_Skins_GetFrameVar("BarTextCol", "HCCRE", button.framecol)
                tg=hbv_Skins_GetFrameVar("BarTextCol", "HCCGE", button.framecol)
                tb=hbv_Skins_GetFrameVar("BarTextCol", "HCCBE", button.framecol)
            end
        else
            if button.health.pct>hbv_Skins_GetFrameVar("BarTextCol", "SIT", button.framecol) then
                tr=hbv_Skins_GetFrameVar("BarTextCol", "HCR", button.framecol)
                tg=hbv_Skins_GetFrameVar("BarTextCol", "HCG", button.framecol)
                tb=hbv_Skins_GetFrameVar("BarTextCol", "HCB", button.framecol)
            elseif button.health.pct>hbv_Skins_GetFrameVar("BarTextCol", "SCT", button.framecol) then
                tr=hbv_Skins_GetFrameVar("BarTextCol", "HICR", button.framecol)
                tg=hbv_Skins_GetFrameVar("BarTextCol", "HICG", button.framecol)
                tb=hbv_Skins_GetFrameVar("BarTextCol", "HICB", button.framecol)
            else
                tr=hbv_Skins_GetFrameVar("BarTextCol", "HCCR", button.framecol)
                tg=hbv_Skins_GetFrameVar("BarTextCol", "HCCG", button.framecol)
                tb=hbv_Skins_GetFrameVar("BarTextCol", "HCCB", button.framecol)
            end
        end
    elseif cType == "STATE" then
        if button.status.hostile then
            if button.health.pct>hbv_Skins_GetFrameVar("BarTextCol", "SIT", button.framecol) then
                tr=hbv_Skins_GetFrameVar("BarTextCol", "SCRE", button.framecol)
                tg=hbv_Skins_GetFrameVar("BarTextCol", "SCGE", button.framecol)
                tb=hbv_Skins_GetFrameVar("BarTextCol", "SCBE", button.framecol)
            elseif button.health.pct>hbv_Skins_GetFrameVar("BarTextCol", "SCT", button.framecol) then
                tr=hbv_Skins_GetFrameVar("BarTextCol", "SICRE", button.framecol)
                tg=hbv_Skins_GetFrameVar("BarTextCol", "SICGE", button.framecol)
                tb=hbv_Skins_GetFrameVar("BarTextCol", "SICBE", button.framecol)
            else
                tr=hbv_Skins_GetFrameVar("BarTextCol", "SCCRE", button.framecol)
                tg=hbv_Skins_GetFrameVar("BarTextCol", "SCCGE", button.framecol)
                tb=hbv_Skins_GetFrameVar("BarTextCol", "SCCBE", button.framecol)
            end
        else
            if button.health.pct>hbv_Skins_GetFrameVar("BarTextCol", "SIT", button.framecol) then
                tr=hbv_Skins_GetFrameVar("BarTextCol", "SCR", button.framecol)
                tg=hbv_Skins_GetFrameVar("BarTextCol", "SCG", button.framecol)
                tb=hbv_Skins_GetFrameVar("BarTextCol", "SCB", button.framecol)
            elseif button.health.pct>hbv_Skins_GetFrameVar("BarTextCol", "SCT", button.framecol) then
                tr=hbv_Skins_GetFrameVar("BarTextCol", "SICR", button.framecol)
                tg=hbv_Skins_GetFrameVar("BarTextCol", "SICG", button.framecol)
                tb=hbv_Skins_GetFrameVar("BarTextCol", "SICB", button.framecol)
            else
                tr=hbv_Skins_GetFrameVar("BarTextCol", "SCCR", button.framecol)
                tg=hbv_Skins_GetFrameVar("BarTextCol", "SCCG", button.framecol)
                tb=hbv_Skins_GetFrameVar("BarTextCol", "SCCB", button.framecol)
            end
        end
    else
        tr=hbv_Skins_GetFrameVar("BarTextCol", "ACR", button.framecol)
        tg=hbv_Skins_GetFrameVar("BarTextCol", "ACG", button.framecol)
        tb=hbv_Skins_GetFrameVar("BarTextCol", "ACB", button.framecol)
    end
end

function HealBot_Text_ColoursClassHlthMix(button, cType)
      --HealBot_setCall("HealBot_Text_ColoursClassHlthMix", button)
    tr,tg,tb=button.health.mixcolr,button.health.mixcolg,button.health.mixcolb
end

function HealBot_Text_ColoursRoleHlthMix(button, cType)
      --HealBot_setCall("HealBot_Text_ColoursRoleHlthMix", button)
    tr,tg,tb=button.health.rmixcolr,button.health.rmixcolg,button.health.rmixcolb
end

local HealBot_Text_StateColoursFuncs={[1]=HealBot_Text_ColoursHealth,
                                      [2]=HealBot_Text_ColoursClass,
                                      [3]=HealBot_Text_ColoursRole,
                                      [4]=HealBot_Text_ColoursCustom,
                                      [5]=HealBot_Text_ColoursClassHlthMix,
                                      [6]=HealBot_Text_ColoursRoleHlthMix}
function HealBot_Text_StateColours(button)
      --HealBot_setCall("HealBot_Text_StateColours", button)
    if button.status.isdead then
        tr,tg,tb=HealBot_Text_StateDeadColours(button)
    elseif button.status.summons and hbv_Skins_GetFrameBoolean("BarTextCol", "SSUM", button.framecol) then
        tr=hbv_Skins_GetFrameVar("BarTextCol", "SSCR", button.framecol)
        tg=hbv_Skins_GetFrameVar("BarTextCol", "SSCG", button.framecol)
        tb=hbv_Skins_GetFrameVar("BarTextCol", "SSCB", button.framecol)
    else
        HealBot_Text_StateColoursFuncs[hbv_Skins_GetFrameVar("BarTextCol", "STATE", button.framecol)](button, "STATE")
    end
    return tr,tg,tb
end

function HealBot_Text_TextNameColours(button)
      --HealBot_setCall("HealBot_Text_TextNameColours", button)
    if button.status.isdead then
        tr,tg,tb=HealBot_Text_DeadColours(button)
    elseif button.status.summons and hbv_Skins_GetFrameBoolean("BarTextCol", "SUM", button.framecol) then
        tr=hbv_Skins_GetFrameVar("BarTextCol", "NSCR", button.framecol)
        tg=hbv_Skins_GetFrameVar("BarTextCol", "NSCG", button.framecol)
        tb=hbv_Skins_GetFrameVar("BarTextCol", "NSCB", button.framecol)
    else
        HealBot_Text_StateColoursFuncs[hbv_Skins_GetFrameVar("BarTextCol", "NAME", button.framecol)](button, "NAME")
    end
    return tr,tg,tb
end

function HealBot_Text_TextHealthColours(button)
      --HealBot_setCall("HealBot_Text_TextHealthColours", button)
    HealBot_Text_StateColoursFuncs[hbv_Skins_GetFrameVar("BarTextCol", "HLTH", button.framecol)](button, "HEALTH")
    return tr,tg,tb
end

function HealBot_Text_TextAggroColours(button)
      --HealBot_setCall("HealBot_Text_TextAggroColours", button)
    HealBot_Text_StateColoursFuncs[hbv_Skins_GetFrameVar("BarTextCol", "AGGRO", button.framecol)](button, "AGGRO")
    return tr,tg,tb
end

function HealBot_Text_readNumber(n)
      --HealBot_setCall("HealBot_Text_readNumber")
    if n<9999 then
        n=tostring(n)
    elseif n<99999 then
        n=tostring(HealBot_Util_Round(n/1000,1)).."K"
    elseif n<999999 then
        n=tostring(ceil(n/1000)).."K"
    elseif n<9999999 then
        n=tostring(HealBot_Util_Round(n/1000000,2)).."M"
    elseif n<99999999 then
        n=tostring(HealBot_Util_Round(n/1000000,1)).."M"
    else
        n=tostring(ceil(n/1000000)).."M"
    end
    return n
end

local vShortHealTxtIsK,vShortHealTxtAmount,vShortHealTxtSuffix,vShortHealTxtAbsNum=true,0,"",0
local hbAbs=math.abs
function HealBot_Text_shortHealTxt(amount, frame)
      --HealBot_setCall("HealBot_Text_shortHealTxt")
    vShortHealTxtAbsNum=hbAbs(amount)
    if vShortHealTxtAbsNum>999 and hbNumFormats["Places"][frame]>-1 then
        if hbNumFormats["Places"][frame]<3 then 
            if vShortHealTxtAbsNum>999999 then
                vShortHealTxtAmount=HealBot_Util_Round(amount/1000000,hbNumFormats["Places"][frame]) 
                vShortHealTxtSuffix=hbNumFormats["SuffixM"][frame]
            else
                vShortHealTxtAmount=HealBot_Util_Round(amount/1000,hbNumFormats["Places"][frame]) 
                vShortHealTxtSuffix=hbNumFormats["SuffixK"][frame]
            end
        else
            if vShortHealTxtAbsNum>9999999 then
                vShortHealTxtAmount=HealBot_Util_Round(amount/1000000,0)
                vShortHealTxtSuffix=hbNumFormats["SuffixM"][frame]
            elseif vShortHealTxtAbsNum>999999 then
                vShortHealTxtAmount=HealBot_Util_Round(amount/1000000,1)
                vShortHealTxtSuffix=hbNumFormats["SuffixM"][frame]
            elseif vShortHealTxtAbsNum>9999 then
                vShortHealTxtAmount=HealBot_Util_Round(amount/1000,0)
                vShortHealTxtSuffix=hbNumFormats["SuffixK"][frame]
            else
                vShortHealTxtAmount=HealBot_Util_Round(amount/1000,1)
                vShortHealTxtSuffix=hbNumFormats["SuffixK"][frame]
            end
        end
        tShortConcat[1]=vShortHealTxtAmount
        tShortConcat[2]=vShortHealTxtSuffix
        return HealBot_Text_ShortConcat()
    else
        return HealBot_Util_Round(amount, 0)
    end
end

local vHealthTextConcatIndex,vHealthTextConcatResult,vSetHealthTextStrLen,vSetHealthTextBtnLen=0,"",0,0
local vHealthTextTotal,sepHealTxt,absorbinTxt,ahtNumSuffix,ahitNumSuffix,ignoreInHeals,finalHealthTxt=0,0,0,"","",false,""
local vHealthTextVehiclePlayer=""
function HealBot_Text_ConcatHealthText(button)
      --HealBot_setCall("HealBot_Text_ConcatHealthText", button)
    tHealthConcat[1]=button.text.health
    tHealthConcat[2]=button.text.inheal
    tHealthConcat[3]=button.text.overheal
    finalHealthTxt=HealBot_Text_HealthConcat(3)
    if hbv_Skins_GetFrameVar("BarText", "HMAXCHARS", button.framecol)>0 then
        vSetHealthTextStrLen=hbStringLen(hbutf8sub(button.text.health, "%s+", ""))
        if HealBot_Panel_isSpecialUnit(button.unit)>0 then
            vSetHealthTextBtnLen=HealBot_Text_EnemySizeWidth["HLTH"][HealBot_Panel_isSpecialUnit(button.unit)]
        else
            vSetHealthTextBtnLen=hbBarHealthTextLen[button.framecol]
        end
        if (vSetHealthTextStrLen+button.text.inheallen+button.text.overheallen)<vSetHealthTextBtnLen then
            if hbv_Skins_GetFrameVar("BarText", "HLTHTXTANCHOR", button.framecol) == 4 then
                button.text.namehealth=finalHealthTxt
            else
                button.text.healthcomplete=finalHealthTxt
            end
        elseif (vSetHealthTextStrLen+button.text.inheallen)<vSetHealthTextBtnLen then
            tHealthConcat[1]=button.text.health
            tHealthConcat[2]=button.text.inheal
            if hbv_Skins_GetFrameVar("BarText", "HLTHTXTANCHOR", button.framecol) == 4 then
                button.text.namehealth=HealBot_Text_HealthConcat(2)
            else
                button.text.healthcomplete=HealBot_Text_HealthConcat(2)
            end
        elseif vSetHealthTextStrLen>vSetHealthTextBtnLen then
            if HealBot_Panel_isSpecialUnit(button.unit)>0 then
                tConcat[1]=hbStringSub(button.text.health,1,HealBot_Text_EnemySizeWidth["HLTH"][HealBot_Panel_isSpecialUnit(button.unit)])
            else
                tConcat[1]=hbStringSub(button.text.health,1,hbBarHealthTextLen[button.framecol])
            end
            tConcat[2]=vTextChars["Dot"]
            if hbv_Skins_GetFrameVar("BarText", "HLTHTXTANCHOR", button.framecol) == 4 then
                button.text.namehealth=HealBot_Text_Concat(2)
            else
                button.text.healthcomplete=HealBot_Text_Concat(2)
            end
        elseif hbv_Skins_GetFrameVar("BarText", "HLTHTXTANCHOR", button.framecol) == 4 then
            button.text.namehealth=button.text.health
        else
            button.text.healthcomplete=button.text.health
        end
    elseif hbv_Skins_GetFrameVar("BarText", "HLTHTXTANCHOR", button.framecol) == 4 then
        button.text.namehealth=finalHealthTxt
    else
        button.text.healthcomplete=finalHealthTxt
    end
    
    if hbv_Skins_GetFrameVar("BarText", "HLTHTXTANCHOR", button.framecol) == 4 then
        if button.text.healthcomplete~=vTextChars["Nothing"] then
            button.text.healthcomplete=vTextChars["Nothing"]
            button.text.healthupdate=true
        end
        HealBot_Text_ConcatNameText(button)
    else
        button.text.healthupdate=true
        if button.text.namehealth~=vTextChars["Nothing"] then
            button.text.namehealth=vTextChars["Nothing"]
            HealBot_Text_ConcatNameText(button)
        else
            HealBot_Text_UpdateText(button)
        end
    end
end

function HealBot_Text_DoSetHealthText(button, IgnoreInHeals, force)
      --HealBot_setCall("HealBot_Text_DoSetHealthText", button)
    if button.health.current == 0 then
        button.text.health="0"
        force=true
    else
        tHealthConcat[1]=hbNumFormats["SurroundLeft"][button.framecol]
        if hbv_Skins_GetFrameVar("BarText", "HLTHTYPE", button.framecol) == 1 then
            if hbv_Skins_GetFrameVar("BarText", "INCHEALS", button.framecol) == 2 then
                if hbv_Skins_GetFrameVar("BarText", "INCABSORBS", button.framecol) == 2 then
                    vHealthTextTotal=button.health.current+button.health.incoming+button.health.absorbs
                else
                    vHealthTextTotal=button.health.current+button.health.incoming
                end
            elseif hbv_Skins_GetFrameVar("BarText", "INCABSORBS", button.framecol) == 2 then
                vHealthTextTotal=button.health.current+button.health.absorbs
            else
                vHealthTextTotal=button.health.current
            end
            if IgnoreInHeals and vHealthTextTotal>button.health.max then
                vHealthTextTotal=button.health.max
            end
            tHealthConcat[2]=HealBot_Text_shortHealTxt(vHealthTextTotal, button.framecol)
            tHealthConcat[3]=hbNumFormats["SurroundRight"][button.framecol]
            vHealthTextConcatIndex=3
        elseif hbv_Skins_GetFrameVar("BarText", "HLTHTYPE", button.framecol) == 2 then
            if hbv_Skins_GetFrameVar("BarText", "INCHEALS", button.framecol) == 2 then
                if hbv_Skins_GetFrameVar("BarText", "INCABSORBS", button.framecol) == 2 then
                    vHealthTextTotal=(button.health.current+button.health.incoming+button.health.absorbs)-button.health.max
                else
                    vHealthTextTotal=(button.health.current+button.health.incoming)-button.health.max
                end
            elseif hbv_Skins_GetFrameVar("BarText", "INCABSORBS", button.framecol) == 2 then
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
            tHealthConcat[3]=HealBot_Text_shortHealTxt(vHealthTextTotal, button.framecol)
            tHealthConcat[4]=hbNumFormats["SurroundRight"][button.framecol]
            vHealthTextConcatIndex=4
        else
            if hbv_Skins_GetFrameVar("BarText", "INCHEALS", button.framecol) == 2 then
                if hbv_Skins_GetFrameVar("BarText", "INCABSORBS", button.framecol) == 2 then
                    vHealthTextTotal=floor(((button.health.current+button.health.incoming+button.health.absorbs)/button.health.max)*100)
                else
                    vHealthTextTotal=floor(((button.health.current+button.health.incoming)/button.health.max)*100)
                end
            elseif hbv_Skins_GetFrameVar("BarText", "INCABSORBS", button.framecol) == 2 then
                vHealthTextTotal=floor(((button.health.current+button.health.absorbs)/button.health.max)*100)
            else
                vHealthTextTotal=floor((button.health.current/button.health.max)*100)
            end
            if IgnoreInHeals and vHealthTextTotal>100 then
                vHealthTextTotal=100
            end
            tHealthConcat[2]=vHealthTextTotal
            tHealthConcat[3]=vTextChars["Percent"]
            tHealthConcat[4]=hbNumFormats["SurroundRight"][button.framecol]
            vHealthTextConcatIndex=4
        end
        if hbv_Skins_GetFrameBoolean("BarText", "HLTHINCPTC", button.framecol) and 
           hbv_Skins_GetFrameVar("BarText", "HLTHTYPE", button.framecol)<3 then
            tHealthConcat[vHealthTextConcatIndex+1]="  "
            tHealthConcat[vHealthTextConcatIndex+2]=hbNumFormats["SurroundLeft"][button.framecol]
            tHealthConcat[vHealthTextConcatIndex+3]=floor((button.health.current/button.health.max)*100)
            tHealthConcat[vHealthTextConcatIndex+4]="%"
            tHealthConcat[vHealthTextConcatIndex+5]=hbNumFormats["SurroundRight"][button.framecol]
            vHealthTextConcatIndex=vHealthTextConcatIndex+5
        end
        vHealthTextConcatResult=HealBot_Text_HealthConcat(vHealthTextConcatIndex)
        if button.text.health~=vHealthTextConcatResult then
            button.text.health=vHealthTextConcatResult
            force=true
        end
        htvUnit=HealBot_retIsInVehicle(button.unit)
        if htvUnit and hbv_Skins_GetFrameBoolean("BarText", "HLTHINVEHSHOWPLAYER", button.framecol) and UnitExists(htvUnit) then
            tHealthConcat[1]=HEALBOT_WORD_PLAYER
            tHealthConcat[2]="  "
            if hbv_Skins_GetFrameVar("BarText", "HLTHTYPE", button.framecol) == 1 then
                tHealthConcat[3]=HealBot_Text_shortHealTxt(UnitHealth(button.unit), button.framecol)
            elseif hbv_Skins_GetFrameVar("BarText", "HLTHTYPE", button.framecol) == 2 then
                tHealthConcat[3]=HealBot_Text_shortHealTxt(UnitHealth(button.unit)-UnitHealthMax(button.unit), button.framecol)
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
        if button.text.name~=vTextChars["Nothing"] and hbv_Skins_GetFrameVar("BarTextCol", "NAME", button.framecol)~=2 then
            button.text.nameupdate=true
        end
        if button.text.aggro~=vTextChars["Nothing"] and hbv_Skins_GetFrameVar("BarTextCol", "AGGRO", button.framecol) == 2 then
            button.text.aggroupdate=true
        end
        if button.text.tag~=vTextChars["Nothing"] and hbv_Skins_GetFrameVar("BarTextCol", "STATE", button.framecol)~=2 then
            button.text.tagupdate=true
        end
        HealBot_Text_ConcatHealthText(button)
        if HealBot_Text_AuxAssigns["Health"][button.framecol] then
            HealBot_Aux_DoUpdateHealthOverLay(button) 
        end
    end
end

function HealBot_Text_setHealthText(button)
      --HealBot_setCall("HealBot_Text_setHealthText", button)
    if hbv_Skins_GetFrameBoolean("BarText", "HLTHONBAR", button.framecol) and button.health.max then
        if button.status.current<HealBot_Unit_Status["DEAD"] and hbv_Skins_GetFrameBoolean("BarText", "IGNOREONFULL", button.framecol) then
            ignoreInHeals=true
        else
            ignoreInHeals=false
        end
        HealBot_Text_DoSetHealthText(button, ignoreInHeals)
    else
        if button.text.name~=vTextChars["Nothing"] and hbv_Skins_GetFrameVar("BarTextCol", "NAME", button.framecol)~=2 then
            button.text.nameupdate=true
        end
        if button.text.aggro~=vTextChars["Nothing"] and hbv_Skins_GetFrameVar("BarTextCol", "AGGRO", button.framecol)~=2 then
            button.text.aggroupdate=true
        end
        if button.text.tag~=vTextChars["Nothing"] and hbv_Skins_GetFrameVar("BarTextCol", "STATE", button.framecol)~=2 then
            button.text.tagupdate=true
        end
        if button.text.healthcomplete~=vTextChars["Nothing"] then
            button.text.healthcomplete=vTextChars["Nothing"]
            button.text.healthupdate=true
        end
        if button.text.namehealth~=vTextChars["Nothing"] then
            button.text.namehealth=vTextChars["Nothing"]
            HealBot_Text_ConcatNameText(button)
        else
            HealBot_Text_UpdateText(button)
        end
    end
end

function HealBot_Text_ClearOverHeals()
      --HealBot_setCall("HealBot_Text_ClearOverHeals")
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
    for _,xButton in pairs(HealBot_UnitTarget_Button) do
        xButton.text.overheal=vTextChars["Nothing"]
        xButton.text.overheallen=0
        HealBot_Text_ConcatHealthText(xButton)
    end
    for _,xButton in pairs(HealBot_PrivateTarget_Button) do
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
      --HealBot_setCall("HealBot_Text_ClearSeparateInHealsAbsorbs")
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
    for _,xButton in pairs(HealBot_UnitTarget_Button) do
        xButton.text.inheal=vTextChars["Nothing"]
        xButton.text.inheallen=0
        HealBot_Text_ConcatHealthText(xButton)
    end
    for _,xButton in pairs(HealBot_PrivateTarget_Button) do
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
      --HealBot_setCall("HealBot_Text_setSeparateInHealsAbsorbs")
    for x=1,10 do
        if hbv_Skins_GetFrameVar("BarText", "INCHEALS", x) == 3 or 
           hbv_Skins_GetFrameVar("BarText", "INCABSORBS", x) == 3 then
            hbSeparateInHealsAbsorbs[x]=true
            HealBot_Timers_Set("SKINS","TextUpdateHealth")
        else
            if hbSeparateInHealsAbsorbs[x] then
                HealBot_Timers_Set("SKINS","ClearSeparateInHealsAbsorbs")
            end
            hbSeparateInHealsAbsorbs[x]=false
        end
        if hbv_Skins_GetFrameVar("BarText", "OVERHEAL", x)>1 then
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
      --HealBot_setCall("HealBot_Text_setInHealAbsorbsText", button)
    if hbv_Skins_GetFrameBoolean("BarText", "HLTHONBAR", button.framecol) and button.health.max then
        if button.status.current<HealBot_Unit_Status["DEAD"] and hbv_Skins_GetFrameBoolean("BarText", "IGNOREONFULL", button.framecol) then
            ignoreInHeals=true
        else
            ignoreInHeals=false
        end
        if hbSeparateInHealsAbsorbs[button.framecol] then
            hbConcatLater=false
            if ignoreInHeals and button.health.current == button.health.max then
                sepHealTxt=0
            elseif hbv_Skins_GetFrameVar("BarText", "INCHEALS", button.framecol) == 3 then
                if hbv_Skins_GetFrameVar("BarText", "INCABSORBS", button.framecol) == 3 then
                    sepHealTxt=button.health.incoming+button.health.absorbs
                else
                    sepHealTxt=button.health.incoming
                end
            else
                sepHealTxt=button.health.absorbs
            end
            if hbv_Skins_GetFrameVar("BarText", "HLTHTYPE", button.framecol) == 3 then
                if floor((sepHealTxt/button.health.max)*100)<1 then
                    sepHealTxt=0
                end
            end
            if sepHealTxt>0 then
                tHealthConcat[1]=vTextChars["Space"]
                if hbv_Skins_GetFrameVar("BarText", "SEPARATECOL", button.framecol) == 1 then
                    tHealthConcat[2]=hbNumFormats["InHealLeft"][button.framecol]
                    if hbv_Skins_GetFrameVar("BarText", "HLTHTYPE", button.framecol)<3 then
                        tHealthConcat[3]=HealBot_Text_shortHealTxt(sepHealTxt, button.framecol)
                    else
                        tHealthConcat[3]=floor((sepHealTxt/button.health.max)*100)
                    end
                    tHealthConcat[4]=hbNumFormats["InHealRight"][button.framecol]
                    vHealthTextConcatResult=HealBot_Text_HealthConcat(4)
                    button.text.inheallen=hbStringLen(hbutf8sub(vHealthTextConcatResult, "%s+", ""))
                else
                    tHealthConcat[2]=vTextCustomCols["InHeal"][button.framecol]
                    tHealthConcat[3]=hbNumFormats["InHealLeft"][button.framecol]
                    if hbv_Skins_GetFrameVar("BarText", "HLTHTYPE", button.framecol)<3 then
                        tHealthConcat[4]=HealBot_Text_shortHealTxt(sepHealTxt, button.framecol)
                    else
                        tHealthConcat[4]=floor((sepHealTxt/button.health.max)*100)
                    end
                    tHealthConcat[5]=hbNumFormats["InHealRight"][button.framecol]
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
            if hbv_Skins_GetFrameVar("BarText", "INCHEALS", button.framecol) == 2 or
               hbv_Skins_GetFrameVar("BarText", "INCABSORBS", button.framecol) == 2 then
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
end

function HealBot_Text_setOverHealText(button)
      --HealBot_setCall("HealBot_Text_setOverHealText", button)
    if button.status.current<HealBot_Unit_Status["DEAD"] and button.status.range>-1 and 
       hbv_Skins_GetFrameBoolean("BarText", "HLTHONBAR", button.framecol) and hbOverHeal[button.framecol] and button.health.max and button.health.overheal>0 then
        if hbv_Skins_GetFrameVar("BarText", "HLTHTYPE", button.framecol)<3 or floor((button.health.overheal/button.health.max)*100)>0 then
            tHealthConcat[1]=vTextChars["Space"]
            if hbv_Skins_GetFrameVar("BarText", "OVERHEALCOL", button.framecol) == 1 then
                tHealthConcat[2]=hbNumFormats["OverHealLeft"][button.framecol]
                if hbv_Skins_GetFrameVar("BarText", "HLTHTYPE", button.framecol)<3 then
                    tHealthConcat[3]=HealBot_Text_shortHealTxt(button.health.overheal, button.framecol)
                else
                    tHealthConcat[3]=floor((button.health.overheal/button.health.max)*100)
                end
                tHealthConcat[4]=hbNumFormats["OverHealRight"][button.framecol]
                vHealthTextConcatResult=HealBot_Text_HealthConcat(4)
                button.text.overheallen=(hbStringLen(hbutf8sub(vHealthTextConcatResult, "%s+", "")))
            else
                tHealthConcat[2]=vTextCustomCols["OverHeal"][button.framecol]
                tHealthConcat[3]=hbNumFormats["OverHealLeft"][button.framecol]
                if hbv_Skins_GetFrameVar("BarText", "HLTHTYPE", button.framecol)<3 then
                    tHealthConcat[4]=HealBot_Text_shortHealTxt(button.health.overheal, button.framecol)
                else
                    tHealthConcat[4]=floor((button.health.overheal/button.health.max)*100)
                end
                tHealthConcat[5]=hbNumFormats["OverHealRight"][button.framecol]
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
end

function HealBot_Text_AggroFormat(side, frame)
      --HealBot_setCall("HealBot_Text_AggroFormat")
    if side == "Left" then
        return aggroNumFormatSurLa[frame]
    else
        return aggroNumFormatSurRa[frame]
    end
end

function HealBot_Text_setAggroText(button)
      --HealBot_setCall("HealBot_Text_setAggroText", button)
    if not hbv_Skins_GetFrameBoolean("BarText", "TAGAGGROONLYTIP", button.framecol) and button.aggro.threatpct>0 then
        tHealthConcat[1]=aggroNumFormatSurLa[button.framecol] or ""
        tHealthConcat[2]=button.aggro.threatpct
        tHealthConcat[3]=vTextChars["Percent"]
        tHealthConcat[4]=aggroNumFormatSurRa[button.framecol] or ""
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
end

function HealBot_Text_tagWithName()
    for x=1,10 do
        if hbv_Skins_GetFrameVar("BarText", "STATETXTANCHOR", x) == 4 or hbv_Skins_GetFrameVar("BarText", "STATETXTANCHOR", x) == 6 then
            tagWithName[x]=true
        else
            tagWithName[x]=false
        end
    end
end

local prevTag=""
function HealBot_Text_setNameTag(button)
      --HealBot_setCall("HealBot_Text_setNameTag", button)
    prevTag=button.text.tag
    if button.status.current<HealBot_Unit_Status["RESERVED"] then
        if UnitIsFriend("player",button.unit) then
            if hbTagsInUse[button.frame]["DC"] and button.status.current == HealBot_Unit_Status["DC"] then
                button.text.tag=hbv_Skins_GetFrameVar("BarText", "TAGDC", button.frame)
            elseif hbTagsInUse[button.frame]["SUM"] and button.status.summons then
                button.text.tag=hbv_Skins_GetFrameVar("BarText", "TAGSUM", button.frame)
            elseif hbTagsInUse[button.frame]["OOR"] and button.status.range<1 then
                button.text.tag=hbv_Skins_GetFrameVar("BarText", "TAGOOR", button.frame)
            elseif hbTagsInUse[button.frame]["DEAD"] and button.status.current == HealBot_Unit_Status["DEAD"] then
                if button.status.isspirit then
                    button.text.tag=HEALBOT_DEAD_SPIRIT
                else
                    button.text.tag=hbv_Skins_GetFrameVar("BarText", "TAGRIP", button.frame)
                end
            elseif hbTagsInUse[button.frame]["RES"] and button.status.current == HealBot_Unit_Status["RES"] then
                button.text.tag=hbv_Skins_GetFrameVar("BarText", "TAGRES", button.frame)
            elseif hbTagsInUse[button.frame]["DEBUFF"] and button.aura.debuff.dispellable then
                button.text.tag=gsub(hbv_Skins_GetFrameVar("BarText", "TAGDEBUFF", button.frame),"#n",button.aura.debuff.name)
                button.text.tagdebuff=true
            elseif hbTagsInUse[button.frame]["BUFF"] and button.aura.buff.missingbuff then
                button.text.tag=gsub(hbv_Skins_GetFrameVar("BarText", "TAGBUFF", button.frame),"#n",button.aura.buff.missingbuff)
                button.text.tagbuff=true
            elseif hbTagsInUse[button.frame]["GROUP"] and IsInRaid() then
                button.text.tag=gsub(hbv_Skins_GetFrameVar("BarText", "TAGGROUP", button.frame),"#g",button.group)
            else
                button.text.tag=vTextChars["Nothing"]
            end
        else
            button.text.tag=vTextChars["Nothing"]
        end
    else
        button.text.tag=hbv_Skins_GetFrameVar("BarText", "TAGR", button.frame)
    end

    if prevTag~=button.text.tag then
        if tagWithName[button.frame] then
            if not hbv_Skins_GetFrameBoolean("BarText", "TAGSTATEONLYTIP", button.frame) then
                button.text.nametag=button.text.tag
                HealBot_Text_setNameText(button)
            elseif button.text.nametag~=vTextChars["Nothing"] then
                button.text.nametag=vTextChars["Nothing"]
                HealBot_Text_setNameText(button)
            end
        elseif button.text.nametag~=vTextChars["Nothing"] then
            button.text.nametag=vTextChars["Nothing"]
            HealBot_Text_setNameText(button)
        end
        button.text.tagupdate=true
        HealBot_Text_UpdateText(button)
        if HealBot_Text_AuxAssigns["State"][button.frame] then
            if string.len(button.text.tag)>0 then
                HealBot_Aux_UpdateStateBar(button)
            else
                HealBot_Aux_ClearStateBar(button)
            end
        end
    end
end

local vSetNameTextName,vSetNameTextClass,vSetNameTextRole,vSetNameTextStrLen,vSetNameTextBtnLen,vHealthTextConcatIndex="","","",0,0,0
function HealBot_Text_ConcatNameText(button)
      --HealBot_setCall("HealBot_Text_ConcatNameText", button)
    if button.text.namehealth~=vTextChars["Nothing"] then
        if hbv_Skins_GetFrameVar("BarText", "HEALEXTRACOL", button.framecol) == 2 then
            tConcat[1]=button.text.name
            tConcat[2]=vTextChars["Space"]
            tConcat[3]=vTextCustomCols["Health"][button.framecol]
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

function HealBot_Text_setNoNameText(button)
    if button.text.namecomplete~=vTextChars["Nothing"] then
        button.text.name=button.text.namecomplete
    end
    vSetNameTextName=vTextChars["Nothing"]
end

function HealBot_Text_setNameText(button)
      --HealBot_setCall("HealBot_Text_setNameText", button)
    button.text.nameonly=HealBot_GetUnitName(button)
    if button.status.current<HealBot_Unit_Status["RESERVED"] then
        if hbv_Skins_GetFrameVar("BarText", "STATETXTANCHOR", button.frame) == 6 and button.text.nametag~=vTextChars["Nothing"] then
            HealBot_Text_setNoNameText(button)
        else
            if hbv_Skins_GetFrameBoolean("BarText", "CLASSONBAR", button.framecol) then
                vSetNameTextClass=UnitClass(button.unit) or ""
                if hbv_Skins_GetFrameBoolean("BarText", "SHOWROLE", button.framecol) then
                    vSetNameTextRole=HealBot_Panel_UnitRole(button.unit, button.guid, button.isplayer)
                    if vSetNameTextRole == "DAMAGER" then
                        vSetNameTextClass=hbv_Skins_GetFrameVar("BarText", "ROLEDPS", button.framecol)
                    elseif vSetNameTextRole == "HEALER" then
                        vSetNameTextClass=hbv_Skins_GetFrameVar("BarText", "ROLEHEAL", button.framecol)
                    elseif vSetNameTextRole == "TANK" then
                        vSetNameTextClass=hbv_Skins_GetFrameVar("BarText", "ROLETANK", button.framecol)
                    end
                end
                if hbv_Skins_GetFrameBoolean("BarText", "NAMEONBAR", button.framecol) then
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
            elseif hbv_Skins_GetFrameBoolean("BarText", "NAMEONBAR", button.framecol) then
                if hbv_Skins_GetFrameVar("BarAggro", "SHOWTEXT", button.framecol)>1 and 
                       (button.aggro.status or 0)>hbv_Skins_GetFrameVar("BarAggro", "ALERT", button.framecol) then
                    tConcat[1]=hbNameFormats["AggroLeft"][button.framecol]
                    tConcat[2]=button.text.nameonly
                    tConcat[3]=hbNameFormats["AggroRight"][button.framecol]
                    vSetNameTextName=HealBot_Text_Concat(3)
                else
                    vSetNameTextName=button.text.nameonly
                end
            else
                HealBot_Text_setNoNameText(button)
            end
        end
    elseif hbv_Skins_GetFrameBoolean("BarText", "NAMEONBAR", button.framecol) then
        vSetNameTextName=button.unit
    else
        HealBot_Text_setNoNameText(button)
    end

    if button.text.nametag~=vTextChars["Nothing"] then
        tConcat[1]=button.text.nametag
        tConcat[2]=vTextChars["Space"]
        tConcat[3]=vSetNameTextName or ""
        vSetNameTextName=HealBot_Text_Concat(3)
    end
    if hbv_Skins_GetFrameVar("BarText", "MAXCHARS", button.framecol)>0 then
        vSetNameTextStrLen=hbStringLen(hbutf8sub(vSetNameTextName, "%s+", ""))
        if HealBot_Panel_isSpecialUnit(button.unit)>0 then
            vSetNameTextBtnLen=HealBot_Text_EnemySizeWidth["NAME"][HealBot_Panel_isSpecialUnit(button.unit)]-vSetNameTextStrLen
        else
            vSetNameTextBtnLen=hbBarTextLen[button.framecol]-vSetNameTextStrLen
        end
        if vSetNameTextBtnLen<0 then
            if HealBot_Panel_isSpecialUnit(button.unit)>0 then
                tConcat[1]=hbStringSub(vSetNameTextName,1,HealBot_Text_EnemySizeWidth["NAME"][HealBot_Panel_isSpecialUnit(button.unit)])
            else
                tConcat[1]=hbStringSub(vSetNameTextName,1,hbBarTextLen[button.framecol])
            end
            tConcat[2]=vTextChars["Dot"]
            vSetNameTextName=HealBot_Text_Concat(2)
        end
    end

    if button.text.name~=vSetNameTextName then
        button.text.name=vSetNameTextName
        HealBot_Text_ConcatNameText(button)
    end
    if HealBot_Text_AuxAssigns["Name"][button.framecol] then
        HealBot_Aux_DoUpdateNameOverLay(button)
    end
end

local function HealBot_Text_UpdateStateColour(button)
      --HealBot_setCall("HealBot_Text_UpdateStateColour", button)
    button.gref.txt["text3"]:SetTextColor(button.text.sr, button.text.sg, button.text.sb, button.text.sa)
end

local function HealBot_Text_UpdateNameColour(button)
      --HealBot_setCall("HealBot_Text_UpdateNameColour", button)
    button.gref.txt["text"]:SetTextColor(button.text.nr, button.text.ng, button.text.nb, button.text.na)
end

local function HealBot_Text_UpdateHealthColour(button)
      --HealBot_setCall("HealBot_Text_UpdateHealthColour", button)
    button.gref.txt["text2"]:SetTextColor(button.text.hr, button.text.hg, button.text.hb, button.text.ha)
end

function HealBot_Text_UpdateAggroColour(button)
      --HealBot_setCall("HealBot_Text_UpdateAggroColour", button)
    button.gref.txt["text4"]:SetTextColor(button.text.ar, button.text.ag, button.text.ab, button.text.aa)
end

local testNameTxt,vpR,vpG,vpB="",0,0,0
function HealBot_Text_UpdateText(button)
      --HealBot_setCall("HealBot_Text_UpdateText", button)
    if button.text.tagupdate then
        button.text.tagupdate=false
        if not hbv_Skins_GetFrameBoolean("BarText", "TAGSTATEONLYTIP", button.framecol) then
            if not tagWithName[button.frame] then
                button.text.sr, button.text.sg, button.text.sb=HealBot_Text_StateColours(button)
                if button.status.enabled or button.status.summons then
                    if button.status.range>0 then
                        button.text.sa=HealBot_Action_BarColourAlpha(button, hbv_Skins_GetFrameVar("BarTextCol", "SCA", button.framecol), 1)
                    else
                        button.text.sa=HealBot_Action_BarColourAlpha(button, hbv_Skins_GetFrameVar("BarTextCol", "SCOA", button.framecol), 1)
                    end
                else
                    button.text.sa=HealBot_Action_BarColourAlpha(button, hbv_Skins_GetFrameVar("BarTextCol", "SCDA", button.framecol), 1)
                end
                HealBot_Text_UpdateStateColour(button)
                button.gref.txt["text3"]:SetText(button.text.tag)
            else
                button.gref.txt["text3"]:SetText("")
            end
        end
    end
    if button.text.aggroupdate then
        button.text.aggroupdate=false
        if button.status.current<HealBot_Unit_Status["DEAD"] then
            if button.status.enabled then
                if button.status.range>0 then
                    button.text.aa=HealBot_Action_BarColourAlpha(button, hbv_Skins_GetFrameVar("BarTextCol", "ACA", button.framecol), 1)
                else
                    button.text.aa=HealBot_Action_BarColourAlpha(button, hbv_Skins_GetFrameVar("BarTextCol", "ACOA", button.framecol), 1)
                end
            else
                button.text.aa=HealBot_Action_BarColourAlpha(button, hbv_Skins_GetFrameVar("BarTextCol", "ACDA", button.framecol), 1)
            end
            button.text.ar, button.text.ag, button.text.ab=HealBot_Text_TextAggroColours(button)
        else
            button.text.ar, button.text.ag, button.text.ab, button.text.aa=0, 0, 0, 0
        end
        HealBot_Text_UpdateAggroColour(button)
        button.gref.txt["text4"]:SetText(button.text.aggro)
    end
    if button.text.nameupdate then
        button.text.nameupdate=false
        if button.status.current<HealBot_Unit_Status["DC"] then
            button.text.nr, button.text.ng, button.text.nb=HealBot_Text_TextNameColours(button)
            if button.status.enabled or button.status.summons then
                if button.status.range>0 then
                    button.text.na=HealBot_Action_BarColourAlpha(button, hbv_Skins_GetFrameVar("BarTextCol", "NCA", button.framecol), 1)
                else
                    button.text.na=HealBot_Action_BarColourAlpha(button, hbv_Skins_GetFrameVar("BarTextCol", "NCOA", button.framecol), 1)
                end
            else
                button.text.na=HealBot_Action_BarColourAlpha(button, hbv_Skins_GetFrameVar("BarTextCol", "NCDA", button.framecol), 1)
                --button.text.na=1
            end
        else
            button.text.nr, button.text.ng, button.text.nb, button.text.na= 0.58, 0.58, 0.58, 0.7
        end
        HealBot_Text_UpdateNameColour(button)
        button.gref.txt["text"]:SetText(button.text.namecomplete);
    end
    if button.text.healthupdate then
        button.text.healthupdate=false
        if button.health.current>0 then
            if button.status.enabled then
                if button.status.range>0 then
                    button.text.ha=HealBot_Action_BarColourAlpha(button, hbv_Skins_GetFrameVar("BarTextCol", "HCA", button.framecol), 1)
                else
                    button.text.ha=HealBot_Action_BarColourAlpha(button, hbv_Skins_GetFrameVar("BarTextCol", "HCOA", button.framecol), 1)
                end
            else
                button.text.ha=HealBot_Action_BarColourAlpha(button, hbv_Skins_GetFrameVar("BarTextCol", "HCDA", button.framecol), 1)
            end
            button.text.hr, button.text.hg, button.text.hb=HealBot_Text_TextHealthColours(button)
            HealBot_Text_UpdateHealthColour(button)
            button.gref.txt["text2"]:SetText(button.text.healthcomplete)
        elseif hbv_Skins_GetFrameBoolean("BarText", "TAGSTATEONLYTIP", button.framecol) then
            if button.status.isdead then
                --if hbv_Skins_GetFrameBoolean("BarText", "NAMEONBAR", button.framecol) then
                --    button.text.hr, button.text.hg, button.text.hb=0.4, 0.4, 0.4
                --else
                    button.text.hr, button.text.hg, button.text.hb=HealBot_Text_DeadColours(button)
                --end
                button.text.ha=HealBot_Action_BarColourAlpha(button, 0.7, 1)
                HealBot_Text_UpdateHealthColour(button)
                if button.status.isspirit then
                    button.gref.txt["text2"]:SetText(HEALBOT_DEAD_SPIRIT)
                elseif hbTagsInUse[button.framecol]["DEAD"] then
                    button.gref.txt["text2"]:SetText(hbv_Skins_GetFrameVar("BarText", "TAGRIP", button.framecol))
                else
                    button.gref.txt["text2"]:SetText(HEALBOT_DEAD_LABEL)
                end
            elseif not hbv_Skins_GetFrameBoolean("BarText", "NAMEONBAR", button.framecol) then
                button.text.hr, button.text.hg, button.text.hb=0.5, 0.5, 0.5
                button.text.ha=HealBot_Action_BarColourAlpha(button, 0.7, 1)
                HealBot_Text_UpdateHealthColour(button)
                if button.status.current == HealBot_Unit_Status["DC"] then
                    if hbTagsInUse[button.framecol]["DC"] then
                        button.gref.txt["text2"]:SetText(hbv_Skins_GetFrameVar("BarText", "TAGDC", button.framecol))
                    else
                        button.gref.txt["text2"]:SetText(HEALBOT_DISCONNECTED_TAG)
                    end
                elseif button.status.current == HealBot_Unit_Status["RESERVED"] then
                    if string.len(hbv_Skins_GetFrameVar("BarText", "TAGR", button.framecol))>0 then
                        button.gref.txt["text2"]:SetText(hbv_Skins_GetFrameVar("BarText", "TAGR", button.framecol).." "..button.unit)
                    else
                        button.gref.txt["text2"]:SetText(button.unit)
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
            if button.status.range>0 then
                button.text.ha=HealBot_Action_BarColourAlpha(button, hbv_Skins_GetFrameVar("BarTextCol", "HCA", button.framecol), 1)
            else
                button.text.ha=HealBot_Action_BarColourAlpha(button, hbv_Skins_GetFrameVar("BarTextCol", "HCOA", button.framecol), 1)
            end
        else
            button.text.ha=HealBot_Action_BarColourAlpha(button, hbv_Skins_GetFrameVar("BarTextCol", "HCDA", button.framecol), 1)
        end
        button.text.hr, button.text.hg, button.text.hb=HealBot_Text_TextHealthColours(button)
        button.gref.txt["text5"]:SetTextColor(button.text.hr, button.text.hg, button.text.hb, button.text.ha)
        button.gref.txt["text5"]:SetText(button.text.vphealth)
    end
end

function HealBot_Text_UpdateTestText(button)
      --HealBot_setCall("HealBot_Text_UpdateTestText", button)
    button.gref.txt["text"]:SetText("")
    button.gref.txt["text2"]:SetText("")
    button.gref.txt["text3"]:SetText("")
    button.gref.txt["text4"]:SetText("")
    if hbv_Skins_GetFrameBoolean("BarText", "NAMEONBAR", button.framecol) or 
       hbv_Skins_GetFrameBoolean("BarText", "CLASSONBAR", button.framecol) then
        if not hbv_Skins_GetFrameBoolean("BarText", "TAGSTATEONLYTIP", button.frame) and hbv_Skins_GetFrameVar("BarText", "STATETXTANCHOR", button.frame) == 4 then
            testNameTxt=HEALBOT_OPTIONS_TAB_STATETEXT.."  "..button.unit
        else
            testNameTxt=button.unit
        end
        if hbv_Skins_GetFrameBoolean("BarText", "HLTHONBAR", button.framecol) and hbv_Skins_GetFrameVar("BarText", "HLTHTXTANCHOR", button.framecol) == 4 then
            if hbv_Skins_GetFrameVar("BarText", "HLTHTYPE", button.framecol) == 1 then
                testNameTxt=testNameTxt.." 10K"
            elseif hbv_Skins_GetFrameVar("BarText", "HLTHTYPE", button.framecol) == 2 then
                testNameTxt=testNameTxt.." (0)"
            else
                testNameTxt=testNameTxt.." (100%)"
            end
        end
        button.gref.txt["text"]:SetText(testNameTxt)
    end
    if hbv_Skins_GetFrameBoolean("BarText", "HLTHONBAR", button.framecol) and hbv_Skins_GetFrameVar("BarText", "HLTHTXTANCHOR", button.framecol)~=4 then
        if hbv_Skins_GetFrameVar("BarText", "HLTHTYPE", button.framecol) == 1 then
            button.gref.txt["text2"]:SetText("10K") --  "..button.id.. "  "..button.unit);
        elseif hbv_Skins_GetFrameVar("BarText", "HLTHTYPE", button.framecol) == 2 then
            button.gref.txt["text2"]:SetText("(0)");
        else
            button.gref.txt["text2"]:SetText("(100%)");
        end
    end
    if button.framecol<10 then
        if not hbv_Skins_GetFrameBoolean("BarText", "TAGSTATEONLYTIP", button.framecol) and not tagWithName[button.frame] then
            button.text.tag=HEALBOT_OPTIONS_TAB_STATETEXT
            button.gref.txt["text3"]:SetText(HEALBOT_OPTIONS_TAB_STATETEXT)
        end
        if not hbv_Skins_GetFrameBoolean("BarText", "TAGAGGROONLYTIP", button.framecol) then
            if button.id<101 then
                button.gref.txt["text4"]:SetText(HealBot_Text_AggroFormat("Left", button.framecol)..button.id.."%"..HealBot_Text_AggroFormat("Right", button.framecol))
            else
                button.gref.txt["text4"]:SetText(HealBot_Text_AggroFormat("Left", button.framecol).."99%"..HealBot_Text_AggroFormat("Right", button.framecol))
            end
        end
    end
end

local cText=""
function HealBot_Text_UpdateNameButton(button)
      --HealBot_setCall("HealBot_Text_UpdateNameButton", button)
    cText=button.text.namecomplete or "."
    button.gref.txt["text"]:SetText(cText.." ")
    --button.gref.txt["text"]:SetText(cText)
    button.text.name=button.text.name.." "
    HealBot_Text_setNameText(button)
end

function HealBot_Text_UpdateHealthButton(button)
      --HealBot_setCall("HealBot_Text_UpdateHealthButton", button)
    cText=button.text.healthcomplete or "."
    button.gref.txt["text2"]:SetText(cText.." ")
    button.gref.txt["text2"]:SetText(cText)
    button.text.health=button.text.health.." "
    HealBot_Text_setHealthText(button)
end

function HealBot_Text_UpdateStateButton(button)
      --HealBot_setCall("HealBot_Text_UpdateStateButton", button)
    if not hbv_Skins_GetFrameBoolean("BarText", "TAGSTATEONLYTIP", button.framecol) and not tagWithName[button.frame] then 
        cText=button.gref.txt["text3"]:GetText() or button.text.tag or "."
        button.gref.txt["text3"]:SetText(cText.." ")
        button.gref.txt["text3"]:SetText(cText)
    else
        button.gref.txt["text3"]:SetText("")
    end
    button.text.tag=button.text.tag.." "
    HealBot_Text_setNameTag(button)
end

function HealBot_Text_UpdateAggroButton(button)
      --HealBot_setCall("HealBot_Text_UpdateAggroButton", button)
    if not hbv_Skins_GetFrameBoolean("BarText", "TAGAGGROONLYTIP", button.framecol) then
        cText=button.gref.txt["text4"]:GetText() or button.text.aggro or "."
        button.gref.txt["text4"]:SetText(cText.." ")
        button.gref.txt["text4"]:SetText(cText)
    else
        button.gref.txt["text4"]:SetText("")
    end
    button.text.aggro=button.text.aggro.." "
    HealBot_Text_setAggroText(button)
end

function HealBot_Text_UpdateAuxButton(button, id)
      --HealBot_setCall("HealBot_Text_UpdateStateButton", button)
    cText=button.gref.auxtxt[id]:GetText() or ""
    button.gref.auxtxt[id]:SetText(cText.." ")
    button.gref.auxtxt[id]:SetText(cText)
end

function HealBot_Text_UpdateButton(button)
      --HealBot_setCall("HealBot_Text_UpdateButton", button)
    button.text.nameupdate=true
    if not tagWithName[button.frame] then 
        button.text.tagupdate=true 
    end
    if hbv_Skins_GetFrameVar("BarText", "HLTHTXTANCHOR", button.framecol)~=4 then button.text.healthupdate=true end
    HealBot_Text_UpdateText(button)
end

function HealBot_Text_Update(button)
    HealBot_Text_setNameTag(button)
    HealBot_Text_UpdateHealthButton(button)
    HealBot_Text_UpdateNameButton(button)
end
