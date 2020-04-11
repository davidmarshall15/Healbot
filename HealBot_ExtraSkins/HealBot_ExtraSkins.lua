local HEALBOT_EXTRASKINS_GROUP="GROUP"
local HEALBOT_EXTRASKINS_SMALL_RAID="SMALL-RAID"
local HEALBOT_EXTRASKINS_LARGE_RAID="LARGE-RAID"

local HealBot_ExtraSkinNames={[1]="Aux Aggro",
                              [2]="Raid10",
                              [3]="Verena",
                              [4]="Aux Group",
                              [5]="Addydari",
                              [6]="Gridlike 40",
                              [7]="Full 25",
                              [8]="Full 40",
                              [9]="Aphrahat 2020/4",
                             }
local HealBot_ExtraSkinCats={[1]=HEALBOT_EXTRASKINS_GROUP,
                             [2]=HEALBOT_EXTRASKINS_SMALL_RAID,
                             [3]=HEALBOT_EXTRASKINS_LARGE_RAID,
                             [4]=HEALBOT_EXTRASKINS_GROUP,
                             [5]=HEALBOT_EXTRASKINS_GROUP,
                             [6]=HEALBOT_EXTRASKINS_LARGE_RAID,
                             [7]=HEALBOT_EXTRASKINS_LARGE_RAID,
                             [8]=HEALBOT_EXTRASKINS_LARGE_RAID,
                             [9]=HEALBOT_EXTRASKINS_GROUP,
                             }
local HealBot_ExtraSkinDesc={}
local HealBot_ExtraSkinData={}


function HealBot_ExtraSkins_retNames(id)
    return HealBot_ExtraSkinNames[id] or ""
end

function HealBot_ExtraSkins_retNamesForCat(cat)
    local esNames={}
    for j=1, getn(HealBot_ExtraSkinCats), 1 do
        if HealBot_ExtraSkinCats[j]==cat then
            table.insert(esNames, HealBot_ExtraSkinNames[j])
        end
    end
    table.sort(esNames)
    return esNames
end

function HealBot_ExtraSkins_retDesc(name)
    local esDesc=""
    for j=1, getn(HealBot_ExtraSkinNames), 1 do
        if HealBot_ExtraSkinNames[j]==name then
            esDesc=HealBot_ExtraSkinDesc[j]
            break
        end
    end
    return esDesc
end

function HealBot_ExtraSkins_copyData(name)
    for j=1, getn(HealBot_ExtraSkinNames), 1 do
        if HealBot_ExtraSkinNames[j]==name then
            HealBot_Options_ShareExternalEditBox:SetText(HealBot_ExtraSkinData[j])
            break
        end
    end
end

-- Desc format:  Date added - Group or Raid n
--               ============================
--               About the skin
HealBot_ExtraSkinDesc[1]=[[APR 2020 - Group Skin
==================
Aux Aggro is a 5 man skin using horizontal bars
with threat above and power below the health bar
then the whole wrapped in aggro bars.
The skin is placed on the right of the screen.]]
HealBot_ExtraSkinDesc[2]=[[APR 2020 - Small Raid Skin
=====================
Raid10 is a raid skin using horizontal bars
with buffs left of the health bar,
debuffs right of the health bar,
power below the health bar,
threat above the health bar
and aggro below and above threat and power.
The skin is placed on the right of the screen.]]
HealBot_ExtraSkinDesc[3]=[[APR 2020 - Large Raid Skin
=====================
Verena is a raid skin using horizontal bars
with power and aggro below the health bar.
The skin is placed on the bottom of the screen.]]
HealBot_ExtraSkinDesc[4]=[[APR 2020 - Group Skin
==================
Aux Group is a 5 man skin using horizontal bars
with threat and aggro left of the health bar,
incoming heals and overheals right of the health bar,
power below the health bar and buff/debuff above the health bar.
The skin is placed on the right of the screen.]]
HealBot_ExtraSkinDesc[5]=[[APR 2020 - Group Skin
==================
Aux Group is a 5 man skin using horizontal bars
with aggro above and below the health bar.
The skin is placed on the left of the screen.]]
HealBot_ExtraSkinDesc[6]=[[APR 2020 - Large Raid Skin
=====================
Gridlike 40 is a raid 40 grid like skin
with power below the health bar.
The skin is placed on the left of the screen.]]
HealBot_ExtraSkinDesc[7]=[[APR 2020 - Large Raid Skin
=====================
Full 25 is a raid 25 skin using horizontal bars.
The skin is placed on the right of the screen.]]
HealBot_ExtraSkinDesc[8]=[[APR 2020 - Large Raid Skin
=====================
Full 40 is a raid 40 skin using horizontal bars.
The skin is placed on the right of the screen.]]
HealBot_ExtraSkinDesc[9]=[[APR 2020 - Group Skin
==================
Aphrahat 2020/4 is a 5 man skin using horizontal bars
with an interesting use of Aux bar and text.
The skin is placed slightly to the right of the screen.]]

HealBot_ExtraSkinData[1]=[[Skin
Aux Aggro
Author~v!Monti of Terenas
DuplicateBars~v!false
Chat~t!{EOCOOM="true",EOCOOMV=5,MSG="Casting #s on #n",RESONLY="true",CHAN="",NOTIFY=2}
General~t!{HIDEBOSSF="true",HIDEPARTYF="false",FLUIDFREQ=6,HIDERAIDF="true",STICKYFRAME="true",STICKYSENSITIVITY=20,FLUIDBARS="true",HIDEPTF="false"}
Healing~t!{TINCSELF="false",GROUPPETS="true",TARGETINCOMBAT=1,TINCRAID="true",FONLYFRIEND="true",SELFPET=0,TONLYFRIEND="false",FALWAYSSHOW="false",FOCUSINCOMBAT=2,TALWAYSSHOW="false",FEXRAID="false",TINCPET="false",TEXRAID="false",TINCGROUP="true"}
Protection~t!{COMBAT="false",GENERALMACRO="true",COMBATPARTY="true",CRASH="true",COMBATRAID="true"}
Enemy~t!{INCARENA="false",INCTANKS="true",INCMYTAR="false",ENEMYTARGET="true",INCARENAPETS="false",ENEMYTARGETSIZE=70,HIDE="true",NUMBOSS=4,EXISTSHOWPTAR="false",INCSELF="false",EXISTSHOWBOSS="true",DOUBLEWIDTH="false",EXISTSHOWARENA="false"}
IncludeGroup~f~1!{"true","true","true","true","true","true","true","true"}
IncludeGroup~f~2!{"true","true","true","true","true","true","true","true"}
IncludeGroup~f~3!{"true","true","true","true","true","true","true","true"}
IncludeGroup~f~4!{"true","true","true","true","true","true","true","true"}
IncludeGroup~f~5!{"true","true","true","true","true","true","true","true"}
IncludeGroup~f~6!{"true","true","true","true","true","true","true","true"}
IncludeGroup~f~7!{"true","true","true","true","true","true","true","true"}
IncludeGroup~f~8!{"true","true","true","true","true","true","true","true"}
IncludeGroup~f~9!{"true","true","true","true","true","true","true","true"}
IncludeGroup~f~10!{"true","true","true","true","true","true","true","true"}
FrameAlias~f~1!{SIZE=12,NAME="Party",R=1,ALIAS="Party",G=1,SHOW="true",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~2!{SIZE=12,NAME="Tank and Healer",R=1,ALIAS="Not Used",G=1,SHOW="true",OFFSET=1,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~3!{SIZE=12,NAME="Pets",R=1,ALIAS="Not Used 1",G=1,SHOW="true",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~4!{SIZE=12,NAME="Focus and Target",R=1,ALIAS="Not Used 2",G=1,SHOW="true",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~5!{SIZE=12,NAME="Enemy",R=1,ALIAS="Not Used 3",G=1,SHOW="true",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~6!{SIZE=12,NAME="",R=1,ALIAS="Vehicle",G=1,SHOW="true",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~7!{SIZE=12,NAME="Pets",R=1,ALIAS="Pets",G=1,SHOW="true",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~8!{SIZE=12,NAME="Target",R=1,ALIAS="Target",G=1,SHOW="true",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~9!{SIZE=12,NAME="",R=1,ALIAS="Focus",G=1,SHOW="true",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~10!{SIZE=12,NAME="Enemy",R=1,ALIAS="Enemy",G=1,SHOW="true",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAliasBar~f~1!{A=0.25,WIDTH=0.9,B=0.1,HEIGHT=20,R=0.1,G=0.1,TEXTURE="Diagonal"}
FrameAliasBar~d!2~3~4~5~6~7~8~9~10~
Frame~f~1!{BACKR=0.02,BORDERR=0.976,SFOFFSETH=0,BORDERG=0,LOCKED="false",OPENSOUND="false",BORDERA=0,SFOFFSETV=0,BACKG=0.016,BACKB=0.016,BACKA=0.33,SCALE=1,BORDERB=0,AUTOCLOSE="false",TIPLOC=2}
Frame~f~2!{BACKR=0.102,BORDERR=0.102,SFOFFSETH=2,BORDERG=0.102,LOCKED="true",OPENSOUND="false",BORDERA=0,SFOFFSETV=0,BACKG=0.102,BACKB=0.502,BACKA=0.04,SCALE=1,BORDERB=0.102,AUTOCLOSE="false",TIPLOC=1}
Frame~f~3!{BACKR=0.1,BORDERR=0.1,SFOFFSETH=0,BORDERG=0.1,LOCKED="false",OPENSOUND="false",BORDERA=0.5,SFOFFSETV=0,BACKG=0.1,BACKB=0.5,BACKA=0.2,SCALE=1,BORDERB=0.1,AUTOCLOSE="false",TIPLOC=2}
Frame~d!4~
Frame~f~5!{BACKR=0.1,BORDERR=0.1,SFOFFSETH=0,BORDERG=0.1,LOCKED="false",OPENSOUND="false",BORDERA=0.5,SFOFFSETV=0,BACKG=0.1,BACKB=0.5,BACKA=0.2,SCALE=1,BORDERB=0.1,AUTOCLOSE="false",TIPLOC=4}
Frame~f~6!{BACKR=0.1,BORDERR=0.1,SFOFFSETH=0,BORDERG=0.1,LOCKED="false",OPENSOUND="false",BORDERA=0.5,SFOFFSETV=0,BACKG=0.1,BACKB=0.5,BACKA=0.2,SCALE=1,BORDERB=0.1,AUTOCLOSE="false",TIPLOC=5}
Frame~f~7!{BACKR=0.102,BORDERR=0.102,SFOFFSETH=0,BORDERG=0.102,LOCKED="true",OPENSOUND="false",BORDERA=0.01,SFOFFSETV=7,BACKG=0.102,BACKB=0.502,BACKA=0.01,SCALE=1,BORDERB=0.102,AUTOCLOSE="false",TIPLOC=5}
Frame~f~8!{BACKR=0.102,BORDERR=0.102,SFOFFSETH=5,BORDERG=0.102,LOCKED="false",OPENSOUND="false",BORDERA=0,SFOFFSETV=0,BACKG=0.102,BACKB=0.502,BACKA=0,SCALE=1,BORDERB=0.102,AUTOCLOSE="false",TIPLOC=5}
Frame~f~9!{BACKR=0.102,BORDERR=0.102,SFOFFSETH=8,BORDERG=0.102,LOCKED="false",OPENSOUND="false",BORDERA=0,SFOFFSETV=0,BACKG=0.102,BACKB=0.502,BACKA=0,SCALE=1,BORDERB=0.102,AUTOCLOSE="false",TIPLOC=5}
Frame~f~10!{BACKR=0.102,BORDERR=0.102,SFOFFSETH=0,BORDERG=0.102,LOCKED="false",OPENSOUND="false",BORDERA=0.1,SFOFFSETV=0,BACKG=0.102,BACKB=0.502,BACKA=0.05,SCALE=1,BORDERB=0.102,AUTOCLOSE="false",TIPLOC=2}
StickyFrames~f~1!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~f~2!{STUCK="true",STUCKTOPOINT="TOPLEFT",STUCKTO=1,STUCKPOINT="TOPRIGHT"}
StickyFrames~f~3!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~d!4~5~6~
StickyFrames~f~7!{STUCK="true",STUCKTOPOINT="BOTTOMRIGHT",STUCKTO=1,STUCKPOINT="TOPRIGHT"}
StickyFrames~f~8!{STUCK="true",STUCKTOPOINT="TOPLEFT",STUCKTO=1,STUCKPOINT="TOPRIGHT"}
StickyFrames~f~9!{STUCK="true",STUCKTOPOINT="LEFT",STUCKTO=1,STUCKPOINT="RIGHT"}
StickyFrames~f~10!{STUCK="false",STUCKTOPOINT="TOPLEFT",STUCKTO=1,STUCKPOINT="BOTTOMLEFT"}
HealGroups~f~1!{FRAME=1,STATE="true",NAME="Main tanks"}
HealGroups~f~2!{FRAME=1,STATE="true",NAME="Self"}
HealGroups~f~3!{FRAME=1,STATE="true",NAME="Healers"}
HealGroups~f~4!{FRAME=1,STATE="false",NAME="Private List"}
HealGroups~f~5!{FRAME=1,STATE="true",NAME="Group"}
HealGroups~f~6!{FRAME=1,STATE="true",NAME="Raid"}
HealGroups~f~7!{FRAME=6,STATE="false",NAME="Vehicle"}
HealGroups~f~8!{FRAME=1,STATE="true",NAME="Pets"}
HealGroups~f~9!{FRAME=8,STATE="true",NAME="Target"}
HealGroups~f~10!{FRAME=9,STATE="false",NAME="Focus"}
HealGroups~f~11!{FRAME=10,STATE="true",NAME="Enemy"}
Anchors~f~1!{Y=68.67,GROW=2,BARS=1,FRAME=3,X=95.12}
Anchors~f~2!{Y=60.12,GROW=2,BARS=1,FRAME=3,X=88.68}
Anchors~f~3!{Y=55.37,GROW=2,BARS=3,FRAME=3,X=94.92}
Anchors~f~4!{Y=64.17,GROW=2,BARS=1,FRAME=1,X=83.17}
Anchors~f~5!{Y=65.23,GROW=2,BARS=2,FRAME=2,X=89.04}
Anchors~f~6!{Y=55,GROW=2,BARS=1,FRAME=1,X=55}
Anchors~f~7!{Y=56.02,GROW=2,BARS=1,FRAME=3,X=79.96}
Anchors~f~8!{Y=68.67,GROW=2,BARS=1,FRAME=3,X=88.63}
Anchors~f~9!{Y=63.76,GROW=2,BARS=1,FRAME=7,X=88.81}
Anchors~f~10!{Y=70.43,GROW=2,BARS=4,FRAME=2,X=88.35}
HeadBar~f~1!{SHOW="false",WIDTH=0.9,B=0.506,R=0.506,HEIGHT=30,A=0.4,G=0.506,TEXTURE="Diagonal"}
HeadBar~d!2~3~4~5~6~7~8~9~10~
HeadText~f~1!{A=0.7,B=0.8,OFFSET=0,R=0.2,FONT="Friz Quadrata TT",HEIGHT=10,G=0.8,OUTLINE=1}
HeadText~d!2~3~4~5~6~7~8~9~10~
HealBar~f~1!{HEIGHT=40,GRPCOLS="false",CMARGIN=4,TEXTURE="Smooth v2",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=3,NUMCOLS=1,OFIX=1,RMARGIN=0,WIDTH=175}
HealBar~f~2!{HEIGHT=40,GRPCOLS="false",CMARGIN=4,TEXTURE="Smooth v2",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=2,NUMCOLS=1,OFIX=1,RMARGIN=0,WIDTH=175}
HealBar~d!3~4~5~6~7~8~9~10~
BarCol~f~1!{BACK=3,BA=0.2,BB=0.02,DISA=0,BR=0.02,HB=0.9,BG=0.02,BOUT=0,HA=1,HG=0.2,ORA=0.25,HR=0.2,HLTH=2}
BarCol~d!2~3~4~5~6~7~8~9~10~
BarIACol~f~1!{AC=4,AB=0.969,AA=0.4,AR=1,AG=0.945,IC=2,IB=0.2,IA=0.4,IR=0.2,IG=0.9}
BarIACol~d!2~3~4~5~6~7~8~9~10~
BarText~f~1!{HHEIGHT=14,TAGOOR="OOR | ",OVERHEAL=1,MAXCHARS=0,HMAXCHARS=0,HLTHONBAR="true",HOUTLINE=1,FONT="Friz Quadrata TT",INCHEALS=2,HLTHTXTANCHOR=1,HLTHTYPE=1,CLASSONBAR="true",OUTLINE=1,NUMFORMAT2=1,IGNOREONFULL="true",TAGDC="[ DC ] ",OFFSET=0,TAGRIP="RIP | ",HEIGHT=13,INCABSORBS=1,SHOWROLE="true",HALIGN=2,HFONT="Friz Quadrata TT",NUMFORMAT1=11,NAMEONBAR="true",CLASSTYPE=1,HOFFSET2=0,ALIGN=2,TAGR="[ R ] ",HOFFSET=1}
BarText~f~2!{HHEIGHT=14,TAGOOR="OOR | ",OVERHEAL=1,MAXCHARS=0,HMAXCHARS=0,HLTHONBAR="true",HOUTLINE=1,FONT="Friz Quadrata TT",INCHEALS=2,HLTHTXTANCHOR=1,HLTHTYPE=1,CLASSONBAR="true",OUTLINE=1,NUMFORMAT2=1,IGNOREONFULL="false",TAGDC="[ DC ] ",OFFSET=0,TAGRIP="RIP | ",HEIGHT=13,INCABSORBS=1,SHOWROLE="true",HALIGN=2,HFONT="Friz Quadrata TT",NUMFORMAT1=11,NAMEONBAR="true",CLASSTYPE=1,HOFFSET2=0,ALIGN=2,TAGR="[ R ] ",HOFFSET=1}
BarText~f~3!{HLTHONBAR="true",TAGOOR="OOR | ",HOUTLINE=1,MAXCHARS=0,HMAXCHARS=0,HHEIGHT=10,OVERHEAL=1,IGNOREONFULL="true",OFFSET=0,HLTHTXTANCHOR=1,FONT="Friz Quadrata TT",CLASSONBAR="true",HOFFSET=0,NUMFORMAT2=1,INCHEALS=2,TAGDC="[ DC ] ",HLTHTYPE=1,TAGRIP="RIP | ",HEIGHT=13,INCABSORBS=1,SHOWROLE="true",HALIGN=2,HFONT="Friz Quadrata TT",NUMFORMAT1=11,NAMEONBAR="true",CLASSTYPE=1,HOFFSET2=0,ALIGN=2,TAGR="[ R ] ",OUTLINE=1}
BarText~f~4!{HLTHONBAR="true",TAGOOR="OOR | ",HOUTLINE=1,MAXCHARS=0,HMAXCHARS=0,HHEIGHT=14,IGNOREONFULL="true",INCHEALS=2,OFFSET=0,HLTHTXTANCHOR=1,HLTHTYPE=1,CLASSONBAR="true",HFONT="Friz Quadrata TT",NUMFORMAT2=1,OVERHEAL=1,TAGDC="[ DC ] ",FONT="Friz Quadrata TT",TAGRIP="RIP | ",HEIGHT=13,INCABSORBS=1,SHOWROLE="true",HALIGN=2,HOFFSET=1,NUMFORMAT1=11,NAMEONBAR="true",CLASSTYPE=1,HOFFSET2=0,ALIGN=2,TAGR="[ R ] ",OUTLINE=1}
BarText~f~5!{HLTHONBAR="true",TAGOOR="OOR | ",IGNOREONFULL="true",MAXCHARS=0,CLASSONBAR="true",HHEIGHT=14,OVERHEAL=1,NAMEONBAR="true",OFFSET=0,HLTHTXTANCHOR=1,FONT="Friz Quadrata TT",HMAXCHARS=0,OUTLINE=1,NUMFORMAT2=1,HOUTLINE=1,TAGDC="[ DC ] ",HLTHTYPE=1,TAGRIP="RIP | ",HEIGHT=13,INCHEALS=2,SHOWROLE="true",HALIGN=2,CLASSTYPE=1,NUMFORMAT1=11,HOFFSET=1,INCABSORBS=1,HOFFSET2=0,ALIGN=2,TAGR="[ R ] ",HFONT="Friz Quadrata TT"}
BarText~f~6!{HHEIGHT=14,TAGOOR="OOR | ",HOUTLINE=1,MAXCHARS=0,CLASSONBAR="true",HLTHONBAR="true",IGNOREONFULL="true",OVERHEAL=1,OFFSET=0,HLTHTXTANCHOR=1,FONT="Friz Quadrata TT",HMAXCHARS=0,OUTLINE=1,NUMFORMAT2=1,INCHEALS=2,NUMFORMAT1=1,HLTHTYPE=1,TAGRIP="RIP | ",HEIGHT=13,INCABSORBS=1,SHOWROLE="true",HALIGN=2,HOFFSET=0,TAGDC="[ DC ] ",NAMEONBAR="true",CLASSTYPE=1,HOFFSET2=0,ALIGN=2,TAGR="[ R ] ",HFONT="Friz Quadrata TT"}
BarText~d!7~8~9~
BarText~f~10!{HHEIGHT=14,TAGOOR="OOR | ",IGNOREONFULL="true",MAXCHARS=0,HMAXCHARS=0,HLTHONBAR="true",HOUTLINE=1,NAMEONBAR="true",OFFSET=0,HLTHTXTANCHOR=1,HLTHTYPE=1,CLASSONBAR="false",HFONT="Friz Quadrata TT",NUMFORMAT2=1,INCHEALS=2,NUMFORMAT1=1,FONT="Friz Quadrata TT",TAGRIP="RIP | ",HEIGHT=13,OVERHEAL=1,SHOWROLE="true",HALIGN=2,CLASSTYPE=1,TAGDC="[ DC ] ",HOFFSET=0,INCABSORBS=1,HOFFSET2=0,ALIGN=2,TAGR="[ R ] ",OUTLINE=1}
BarTextCol~f~1!{NCB=0,HCA=1,NAME=2,NCDA=0.8,HCG=0,NCR=0.996,HCB=0,NCA=1,NDEBUFF="true",NCG=0.91,HCR=0,HDEBUFF="false",HLTH=1,HCDA=0.5}
BarTextCol~d!2~3~4~5~6~7~8~9~10~
Icons~f~1!{SHOWBUFF="true",SHOWDEBUFF="true",I15EN="true",MAXDICONS=4,POSITION=2,FADE="false",ONBAR=1,SHOWDIRMOUSE="false",DSCALE=1,SHOWDIR="false",SHOWRC="true",SCALE=1,DOUBLE="true",FADESECS=15,MAXBICONS=8}
Icons~d!2~3~4~5~6~
Icons~f~7!{SHOWBUFF="true",SHOWDEBUFF="true",I15EN="true",MAXDICONS=2,POSITION=2,FADE="false",ONBAR=1,SHOWDIRMOUSE="false",DSCALE=1,SHOWDIR="false",SHOWRC="true",SCALE=1,DOUBLE="true",FADESECS=15,MAXBICONS=4}
Icons~f~8!{SHOWBUFF="true",SHOWDEBUFF="true",I15EN="true",MAXDICONS=4,POSITION=2,FADE="false",ONBAR=1,SHOWDIRMOUSE="false",DSCALE=1,SHOWDIR="false",SHOWRC="true",SCALE=1,DOUBLE="true",FADESECS=15,MAXBICONS=8}
Icons~d!9~10~
RaidIcon~f~1!{SQUARE="true",CIRCLE="true",DIAMOND="true",SHOW="true",MOON="true",TRIANGLE="true",STAR="true",SKULL="true",CROSS="true"}
RaidIcon~d!2~3~4~5~6~7~8~9~10~
IconText~f~1!{SDUR="true",HEIGHT=10,SSCNT="false",SCNT="true",DURTHRH=9,FONT="Friz Quadrata TT",DURWARN=3,SSDUR="true",OUTLINE=2}
IconText~d!2~3~4~5~6~7~8~9~10~
BarVisibility~f~1!{INCCLASSES=1,ALERTIC=1,ALERTOC=0.95,HIDEOOR="false"}
BarVisibility~d!2~3~4~5~6~7~8~9~10~
BarSort~f~1!{SUBORDER=1,OORLAST="false",RAIDORDER=1,SUBPF="true"}
BarSort~d!2~3~4~5~6~7~8~9~10~
BarAggro~f~1!{R=1,ALERTIND=2,G=0.024,TEXTFORMAT=3,SHOW="true",SHOWTEXTPCT="true",SHOWIND="true",B=0.024,SHOWTEXT="false",ALERT=1}
BarAggro~d!2~3~4~5~6~7~8~9~10~
AuxBarFrame~f~1!{OFREQ=0.07,OVERLAP=1,OMIN=0.2,OMAX=1}
AuxBarFrame~d!2~3~4~5~6~7~8~9~10~
AuxBar^1~f~1!{SIZE=1,USE=6,R=0.7,COLOUR=1,ANCHOR=2,OFFSET=0,DEPTH=3,B=0.2,OTYPE=1,A=1,G=0.7}
AuxBar^1~d!2~3~4~5~6~7~8~9~
AuxBar^1~f~10!{SIZE=1,USE=1,B=0.2,COLOUR=1,ANCHOR=2,OFFSET=0,DEPTH=3,G=0.7,A=1,OTYPE=1,R=0.7}
AuxBar^2~f~1!{SIZE=1,USE=4,R=0.067,COLOUR=1,ANCHOR=1,OFFSET=0,DEPTH=4,B=0.035,OTYPE=1,A=1,G=0.918}
AuxBar^2~d!2~3~4~5~6~7~8~9~
AuxBar^2~f~10!{SIZE=1,USE=1,B=0.035,COLOUR=1,ANCHOR=1,OFFSET=0,DEPTH=4,G=0.918,A=1,OTYPE=1,R=0.067}
AuxBar^3~f~1!{SIZE=0.58,USE=9,R=0.7,COLOUR=1,ANCHOR=2,OFFSET=-3,DEPTH=3,B=0.2,OTYPE=2,A=1,G=0.7}
AuxBar^3~d!2~3~4~5~6~7~8~9~
AuxBar^3~f~10!{SIZE=0.58,USE=1,B=0.2,COLOUR=1,ANCHOR=2,OFFSET=-3,DEPTH=3,G=0.7,A=1,OTYPE=2,R=0.7}
AuxBar^4~f~1!{SIZE=1,USE=5,R=1,COLOUR=1,ANCHOR=3,OFFSET=0,DEPTH=3,B=1,OTYPE=1,A=1,G=1}
AuxBar^4~d!2~3~4~5~6~7~8~9~
AuxBar^4~f~10!{SIZE=1,USE=1,B=1,COLOUR=1,ANCHOR=3,OFFSET=0,DEPTH=3,G=1,A=1,OTYPE=1,R=1}
AuxBar^5~f~1!{SIZE=1,USE=5,R=0.631,COLOUR=1,ANCHOR=4,OFFSET=0,DEPTH=3,B=0.247,OTYPE=1,A=1,G=0.247}
AuxBar^5~d!2~3~4~5~6~7~8~9~
AuxBar^5~f~10!{SIZE=1,USE=1,B=0.247,COLOUR=1,ANCHOR=4,OFFSET=0,DEPTH=3,G=0.247,A=1,OTYPE=1,R=0.631}
AuxBar^6~f~1!{SIZE=1,USE=5,R=1,COLOUR=1,ANCHOR=2,OFFSET=0,DEPTH=3,B=1,OTYPE=1,A=1,G=1}
AuxBar^6~d!2~3~4~5~6~7~8~9~
AuxBar^6~f~10!{SIZE=1,USE=1,B=1,COLOUR=1,ANCHOR=2,OFFSET=0,DEPTH=3,G=1,A=1,OTYPE=1,R=1}
AuxBar^7~f~1!{SIZE=1,USE=5,R=0.8,COLOUR=1,ANCHOR=1,OFFSET=0,DEPTH=3,B=0.8,OTYPE=1,A=1,G=0.2}
AuxBar^7~d!2~3~4~5~6~7~8~9~
AuxBar^7~f~10!{SIZE=1,USE=1,B=0.8,COLOUR=1,ANCHOR=1,OFFSET=0,DEPTH=3,G=0.2,A=1,OTYPE=1,R=0.8}
AuxBar^8~f~1!{SIZE=0.58,USE=1,R=0.078,COLOUR=1,ANCHOR=2,OFFSET=-3,DEPTH=3,B=0.875,OTYPE=2,A=1,G=0.737}
AuxBar^8~d!2~3~4~5~6~7~8~9~10~
AuxBar^9~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=2,DEPTH=5,B=1,OTYPE=1,A=1,G=1}
AuxBar^9~d!2~3~4~5~6~7~8~9~10~
Complete!]]
HealBot_ExtraSkinData[2]=[[Skin
Raid10
Author~v!Doco of Mirage Raceway
DuplicateBars~v!false
Chat~t!{EOCOOM="false",EOCOOMV=20,MSG="Casting #s on #n",RESONLY="true",CHAN="",NOTIFY=1}
General~t!{FLUIDFREQ=4,HIDEPTF="false",HIDEBOSSF="true",STICKYSENSITIVITY=30,HIDERAIDF="true",STICKYFRAME="true",FLUIDBARS="false",HIDEPARTYF="false"}
Healing~t!{TONLYFRIEND="false",FEXRAID="false",FOCUSINCOMBAT=2,GROUPPETS="true",SELFPET="false",TEXRAID="false",FONLYFRIEND="false",TARGETINCOMBAT=1}
Protection~t!{COMBAT="false",GENERALMACRO="true",COMBATPARTY="true",CRASH="true",COMBATRAID="true"}
Enemy~t!{ENEMYTARGET="true",INCTANKS="true",INCMYTAR="false",INCARENA="false",INCARENAPETS="false",ENEMYTARGETSIZE=70,HIDE="true",NUMBOSS=1,EXISTSHOWPTAR="false",INCSELF="false",EXISTSHOWBOSS="true",DOUBLEWIDTH="false",EXISTSHOWARENA="false"}
IncludeGroup~f~1!{"true","true","true","true","true","true","true","true"}
IncludeGroup~f~2!{"true","true","true","true","true","true","true","true"}
IncludeGroup~f~3!{"true","true","true","true","true","true","true","true"}
IncludeGroup~f~4!{"true","true","true","true","true","true","true","true"}
IncludeGroup~f~5!{"true","true","true","true","true","true","true","true"}
IncludeGroup~f~6!{"true","true","true","true","true","true","true","true"}
IncludeGroup~f~7!{"true","true","true","true","true","true","true","true"}
IncludeGroup~f~8!{"true","true","true","true","true","true","true","true"}
IncludeGroup~f~9!{"true","true","true","true","true","true","true","true"}
IncludeGroup~f~10!{"true","true","true","true","true","true","true","true"}
FrameAlias~f~1!{SIZE=12,NAME="",R=1,ALIAS="Raid",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~2!{A=1,NAME="",R=1,ALIAS="Tank and Healers",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~d!3~4~5~
FrameAlias~f~6!{SIZE=12,NAME="Vehicle",R=1,ALIAS="Vehicle",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~7!{SIZE=12,NAME="Pets",R=1,ALIAS="Pets",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~8!{SIZE=12,NAME="Target",R=1,ALIAS="Target",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~9!{SIZE=12,NAME="Focus",R=1,ALIAS="Focus",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~10!{SIZE=12,NAME="Enemy",R=1,ALIAS="Enemy",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAliasBar~f~1!{A=0.25,WIDTH=0.9,B=0.1,HEIGHT=20,R=0.1,G=0.1,TEXTURE="Skewed"}
FrameAliasBar~d!2~3~4~5~6~7~8~9~10~
Frame~f~1!{SFOFFSETH=0,BORDERR=0.1,BACKR=0.1,SFOFFSETV=0,LOCKED="false",OPENSOUND="false",BORDERA=0.04,BORDERG=0.1,TIPLOC=2,BORDERB=0.1,BACKA=0.1,SCALE=1,BACKB=0.7,BACKG=0.1,AUTOCLOSE="false"}
Frame~f~2!{SFOFFSETH=0,BORDERR=0.1,BACKR=0.1,SFOFFSETV=-8,LOCKED="true",OPENSOUND="false",BORDERA=0.04,BORDERG=0.1,TIPLOC=2,BORDERB=0.1,BACKA=0.1,SCALE=1,BACKB=0.7,BACKG=0.1,AUTOCLOSE="false"}
Frame~f~3!{SFOFFSETH=0,BORDERR=0.1,BACKR=0.1,SFOFFSETV=0,LOCKED="false",OPENSOUND="false",BORDERA=0.04,BORDERG=0.1,TIPLOC=5,BORDERB=0.1,BACKA=0.1,SCALE=1,BACKB=0.7,BACKG=0.1,AUTOCLOSE="false"}
Frame~d!4~5~6~
Frame~f~7!{SFOFFSETH=0,BORDERR=0.1,BACKR=0.1,SFOFFSETV=8,LOCKED="false",OPENSOUND="false",BORDERA=0.04,BORDERG=0.1,TIPLOC=5,BORDERB=0.1,BACKA=0.1,SCALE=1,BACKB=0.7,BACKG=0.1,AUTOCLOSE="false"}
Frame~f~8!{SFOFFSETH=9,BORDERR=0.1,BACKR=0.1,SFOFFSETV=1,LOCKED="false",OPENSOUND="false",BORDERA=0.04,BORDERG=0.1,TIPLOC=2,BORDERB=0.1,BACKA=0.1,SCALE=1,BACKB=0.7,BACKG=0.1,AUTOCLOSE="false"}
Frame~f~9!{SFOFFSETH=9,BORDERR=0.1,BACKR=0.1,SFOFFSETV=0,LOCKED="false",OPENSOUND="false",BORDERA=0.04,BORDERG=0.1,TIPLOC=2,BORDERB=0.1,BACKA=0.1,SCALE=1,BACKB=0.7,BACKG=0.1,AUTOCLOSE="false"}
Frame~f~10!{SFOFFSETH=0,BORDERR=0.1,BACKR=0.1,SFOFFSETV=0,LOCKED="true",OPENSOUND="false",BORDERA=0.04,BORDERG=0.1,TIPLOC=4,BORDERB=0.1,BACKA=0.1,SCALE=1,BACKB=0.7,BACKG=0.1,AUTOCLOSE="false"}
StickyFrames~f~1!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~f~2!{STUCK="true",STUCKTOPOINT="TOPLEFT",STUCKTO=1,STUCKPOINT="BOTTOMLEFT"}
StickyFrames~f~3!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~d!4~5~6~
StickyFrames~f~7!{STUCK="true",STUCKTOPOINT="BOTTOMRIGHT",STUCKTO=1,STUCKPOINT="TOPRIGHT"}
StickyFrames~f~8!{STUCK="true",STUCKTOPOINT="LEFT",STUCKTO=2,STUCKPOINT="RIGHT"}
StickyFrames~f~9!{STUCK="true",STUCKTOPOINT="LEFT",STUCKTO=1,STUCKPOINT="RIGHT"}
StickyFrames~f~10!{STUCK="true",STUCKTOPOINT="TOPLEFT",STUCKTO=2,STUCKPOINT="BOTTOMLEFT"}
HealGroups~f~1!{FRAME=2,STATE="true",NAME="Main tanks"}
HealGroups~f~2!{FRAME=2,STATE="true",NAME="Healers"}
HealGroups~f~3!{FRAME=1,STATE="false",NAME="Self"}
HealGroups~f~4!{FRAME=1,STATE="false",NAME="Group"}
HealGroups~f~5!{FRAME=1,STATE="true",NAME="Raid"}
HealGroups~f~6!{FRAME=1,STATE="true",NAME="Private List"}
HealGroups~f~7!{FRAME=6,STATE="false",NAME="Vehicle"}
HealGroups~f~8!{FRAME=7,STATE="true",NAME="Pets"}
HealGroups~f~9!{FRAME=8,STATE="true",NAME="Target"}
HealGroups~f~10!{FRAME=9,STATE="false",NAME="Focus"}
HealGroups~f~11!{FRAME=10,STATE="true",NAME="Enemy"}
Anchors~f~1!{Y=54.77,GROW=2,BARS=3,FRAME=3,X=94.81}
Anchors~f~2!{Y=54.1,GROW=2,BARS=1,FRAME=2,X=88.64}
Anchors~f~3!{Y=36.94,GROW=2,BARS=1,FRAME=1,X=92.3}
Anchors~f~4!{Y=53,GROW=2,BARS=1,FRAME=1,X=53}
Anchors~f~5!{Y=54,GROW=2,BARS=1,FRAME=1,X=54}
Anchors~f~6!{Y=55,GROW=2,BARS=1,FRAME=1,X=55}
Anchors~f~7!{Y=50.94,GROW=2,BARS=1,FRAME=3,X=94.81}
Anchors~f~8!{Y=56.43,GROW=2,BARS=1,FRAME=7,X=88.95}
Anchors~f~9!{Y=56.4,GROW=2,BARS=1,FRAME=1,X=74.21}
Anchors~f~10!{Y=58.6,GROW=2,BARS=4,FRAME=2,X=88.64}
HeadBar~f~1!{SHOW="false",WIDTH=0.9,B=0.1,R=0.1,HEIGHT=20,A=0.25,G=0.1,TEXTURE="Skewed"}
HeadBar~d!2~3~4~5~6~7~8~9~10~
HeadText~f~1!{A=0.55,B=0.1,OFFSET=0,R=1,FONT="Friz Quadrata TT",HEIGHT=9,G=1,OUTLINE=1}
HeadText~d!2~3~4~5~6~7~8~9~10~
HealBar~f~1!{HEIGHT=32,GRPCOLS="false",CMARGIN=1,TEXTURE="Smooth v2",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=1,NUMCOLS=2,OFIX=1,RMARGIN=0,WIDTH=75}
HealBar~f~2!{HEIGHT=32,GRPCOLS="false",CMARGIN=0,TEXTURE="Smooth v2",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=1,NUMCOLS=1,OFIX=1,RMARGIN=0,WIDTH=158}
HealBar~f~3!{HEIGHT=32,GRPCOLS="false",CMARGIN=2,TEXTURE="Tukui2",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=1,NUMCOLS=2,OFIX=1,RMARGIN=2,WIDTH=75}
HealBar~d!4~5~6~
HealBar~f~7!{HEIGHT=27,GRPCOLS="false",CMARGIN=1,TEXTURE="Smooth v2",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=1,NUMCOLS=3,OFIX=1,RMARGIN=0,WIDTH=49}
HealBar~f~8!{HEIGHT=32,GRPCOLS="false",CMARGIN=2,TEXTURE="Tukui2",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=1,NUMCOLS=2,OFIX=1,RMARGIN=0,WIDTH=75}
HealBar~d!9~
HealBar~f~10!{HEIGHT=32,GRPCOLS="false",CMARGIN=2,TEXTURE="Tukui2",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=1,NUMCOLS=1,OFIX=1,RMARGIN=2,WIDTH=158}
BarCol~f~1!{BACK=2,BA=0.05,BOUT=1,DISA=0.12,BR=0.2,HB=0.4,BG=0.4,BB=0.4,HA=0.95,HR=0.2,ORA=0.3,HG=0.4,HLTH=2}
BarCol~d!2~3~4~5~6~7~8~9~10~
BarIACol~f~1!{AC=4,AB=0.8,AA=0.5,AR=0.2,AG=0.8,IC=2,IB=1,IA=0.58,IR=1,IG=1}
BarIACol~d!2~
BarIACol~f~3!{AC=3,AB=1,AA=0.5,AR=1,AG=1,IC=2,IB=0.2,IA=0.58,IR=0.2,IG=0.8}
BarIACol~d!4~5~6~
BarIACol~f~7!{AC=4,AB=0.8,AA=0.5,AR=0.2,AG=0.8,IC=2,IB=1,IA=0.58,IR=1,IG=1}
BarIACol~f~8!{AC=3,AB=1,AA=0.5,AR=1,AG=1,IC=2,IB=0.2,IA=0.58,IR=0.2,IG=0.8}
BarIACol~d!9~
BarIACol~f~10!{AC=4,AB=0.8,AA=0.5,AR=0.2,AG=0.8,IC=2,IB=1,IA=0.58,IR=1,IG=1}
BarText~f~1!{HLTHONBAR="true",TAGOOR="r |",IGNOREONFULL="true",MAXCHARS=0,NAMEONBAR="true",CLASSONBAR="true",OVERHEAL=2,HLTHTYPE=1,NUMFORMAT1=1,INCHEALS=2,HLTHTXTANCHOR=1,FONT="Friz Quadrata TT",HMAXCHARS=0,OUTLINE=1,NUMFORMAT2=1,OFFSET=0,TAGDC="dc-",CLASSTYPE=1,TAGRIP="D | ",HEIGHT=10,HFONT="Friz Quadrata TT",SHOWROLE="true",HALIGN=2,HHEIGHT=10,HOUTLINE=1,INCABSORBS=1,HOFFSET2=0,ALIGN=2,TAGR="[ R ] ",HOFFSET=0}
BarText~f~2!{HHEIGHT=10,TAGOOR="r |",IGNOREONFULL="true",MAXCHARS=0,HOFFSET=0,CLASSONBAR="true",HLTHONBAR="true",HLTHTYPE=1,NUMFORMAT1=1,INCHEALS=2,HLTHTXTANCHOR=1,FONT="Friz Quadrata TT",HMAXCHARS=0,HOUTLINE=1,NUMFORMAT2=1,OFFSET=0,TAGDC="dc-",CLASSTYPE=1,TAGRIP="D | ",HEIGHT=10,HFONT="Friz Quadrata TT",SHOWROLE="true",HALIGN=2,OVERHEAL=2,NAMEONBAR="true",INCABSORBS=1,HOFFSET2=0,ALIGN=2,TAGR="[ R ] ",OUTLINE=1}
BarText~f~3!{HLTHONBAR="true",TAGOOR="[ OOR ] ",IGNOREONFULL="true",MAXCHARS=0,NAMEONBAR="true",CLASSONBAR="false",OVERHEAL=1,HLTHTYPE=1,NUMFORMAT1=1,INCHEALS=2,HLTHTXTANCHOR=1,FONT="Friz Quadrata TT",HMAXCHARS=0,OUTLINE=1,NUMFORMAT2=1,OFFSET=0,TAGDC="[ DC ] ",CLASSTYPE=1,TAGRIP="[ RIP ] ",HEIGHT=10,HFONT="Friz Quadrata TT",SHOWROLE="true",HALIGN=2,HHEIGHT=10,HOUTLINE=1,INCABSORBS=1,HOFFSET2=0,ALIGN=2,TAGR="[ R ] ",HOFFSET=0}
BarText~d!4~5~6~
BarText~f~7!{HLTHONBAR="true",TAGOOR="",IGNOREONFULL="true",MAXCHARS=8,NAMEONBAR="true",CLASSONBAR="false",OVERHEAL=1,HLTHTYPE=1,NUMFORMAT1=1,INCHEALS=2,HLTHTXTANCHOR=1,FONT="Friz Quadrata TT",HMAXCHARS=0,OUTLINE=1,NUMFORMAT2=1,OFFSET=0,TAGDC="",CLASSTYPE=1,TAGRIP="",HEIGHT=9,HFONT="Friz Quadrata TT",SHOWROLE="true",HALIGN=2,HHEIGHT=10,HOUTLINE=1,INCABSORBS=1,HOFFSET2=0,ALIGN=2,TAGR="[ R ] ",HOFFSET=0}
BarText~f~8!{HLTHONBAR="true",TAGOOR="",IGNOREONFULL="true",MAXCHARS=0,NAMEONBAR="true",CLASSONBAR="false",OVERHEAL=1,HLTHTYPE=1,NUMFORMAT1=1,INCHEALS=2,HLTHTXTANCHOR=1,FONT="Friz Quadrata TT",HMAXCHARS=0,OUTLINE=1,NUMFORMAT2=1,OFFSET=0,TAGDC="",CLASSTYPE=1,TAGRIP="",HEIGHT=10,HFONT="Friz Quadrata TT",SHOWROLE="true",HALIGN=2,HHEIGHT=10,HOUTLINE=1,INCABSORBS=1,HOFFSET2=0,ALIGN=2,TAGR="[ R ] ",HOFFSET=0}
BarText~d!9~
BarText~f~10!{HLTHONBAR="true",TAGOOR="[ OOR ] ",IGNOREONFULL="true",MAXCHARS=0,NAMEONBAR="true",CLASSONBAR="false",OVERHEAL=1,HLTHTYPE=1,NUMFORMAT1=1,INCHEALS=2,HLTHTXTANCHOR=1,FONT="Friz Quadrata TT",HMAXCHARS=0,OUTLINE=1,NUMFORMAT2=1,OFFSET=0,TAGDC="[ DC ] ",CLASSTYPE=1,TAGRIP="[ RIP ] ",HEIGHT=10,HFONT="Friz Quadrata TT",SHOWROLE="true",HALIGN=2,HHEIGHT=10,HOUTLINE=1,INCABSORBS=1,HOFFSET2=0,ALIGN=2,TAGR="[ R ] ",HOFFSET=0}
BarTextCol~f~1!{NCB=0,NDEBUFF="false",NAME=2,NCDA=0.7,HCG=1,HCA=1,NCG=1,NCA=1,NCR=1,HCB=0,HCR=1,HDEBUFF="false",HLTH=1,HCDA=0.7}
BarTextCol~d!2~
BarTextCol~f~3!{NCB=0,NDEBUFF="false",NAME=2,NCDA=0.7,HCG=1,HCA=1,NCG=1,NCA=1,NCR=1,HCB=0,HCR=1,HDEBUFF="false",HLTH=2,HCDA=0.7}
BarTextCol~d!4~5~6~
BarTextCol~f~7!{NCB=0,NDEBUFF="false",NAME=2,NCDA=0.7,HCG=1,HCA=1,NCG=1,NCA=1,NCR=1,HCB=0,HCR=1,HDEBUFF="false",HLTH=1,HCDA=0.81}
BarTextCol~f~8!{NCB=0,NDEBUFF="false",NAME=2,NCDA=0.7,HCG=1,HCA=1,NCG=1,NCA=1,NCR=1,HCB=0,HCR=1,HDEBUFF="false",HLTH=2,HCDA=0.7}
BarTextCol~d!9~10~
Icons~f~1!{SHOWBUFF="true",POSITION=2,MAXDICONS=2,FADE="false",I15EN="true",DOUBLE="true",SHOWDIR="false",SHOWDIRMOUSE="false",DSCALE=1,ONBAR=1,SHOWRC="true",SCALE=1,SHOWDEBUFF="true",FADESECS=15,MAXBICONS=6}
Icons~f~2!{SHOWBUFF="true",POSITION=2,MAXDICONS=4,FADE="false",I15EN="true",DOUBLE="true",SHOWDIR="true",SHOWDIRMOUSE="false",DSCALE=1,ONBAR=1,SHOWRC="true",SCALE=1,SHOWDEBUFF="true",FADESECS=15,MAXBICONS=8}
Icons~f~3!{SHOWBUFF="true",POSITION=2,MAXDICONS=3,FADE="true",I15EN="true",DOUBLE="true",SHOWDIR="true",SHOWDIRMOUSE="false",DSCALE=1,ONBAR=1,SHOWRC="true",SCALE=1,SHOWDEBUFF="true",FADESECS=15,MAXBICONS=8}
Icons~d!4~5~6~
Icons~f~7!{SHOWBUFF="true",POSITION=2,MAXDICONS=2,FADE="true",I15EN="true",DOUBLE="true",SHOWDIR="true",SHOWDIRMOUSE="false",DSCALE=1,ONBAR=1,SHOWRC="true",SCALE=1,SHOWDEBUFF="true",FADESECS=15,MAXBICONS=4}
Icons~f~8!{SHOWBUFF="true",POSITION=2,MAXDICONS=2,FADE="true",I15EN="true",DOUBLE="true",SHOWDIR="true",SHOWDIRMOUSE="false",DSCALE=1,ONBAR=1,SHOWRC="true",SCALE=1,SHOWDEBUFF="true",FADESECS=15,MAXBICONS=6}
Icons~d!9~
Icons~f~10!{SHOWBUFF="true",POSITION=2,MAXDICONS=3,FADE="true",I15EN="true",DOUBLE="true",SHOWDIR="true",SHOWDIRMOUSE="false",DSCALE=1,ONBAR=1,SHOWRC="true",SCALE=1,SHOWDEBUFF="true",FADESECS=15,MAXBICONS=8}
RaidIcon~f~1!{SQUARE="true",CIRCLE="true",DIAMOND="true",SHOW="true",SKULL="true",TRIANGLE="true",STAR="true",CROSS="true",MOON="true"}
RaidIcon~d!2~3~4~5~6~7~8~9~10~
IconText~f~1!{SDUR="true",HEIGHT=10,SSCNT="false",SCNT="true",DURTHRH=9,FONT="Friz Quadrata TT",DURWARN=3,SSDUR="true",OUTLINE=2}
IconText~d!2~3~4~5~6~7~8~9~10~
BarVisibility~f~1!{INCCLASSES=1,ALERTIC=1,ALERTOC=0.9,HIDEOOR="false"}
BarVisibility~d!2~
BarVisibility~f~3!{INCCLASSES=1,ALERTIC=0.98,ALERTOC=0.9,HIDEOOR="false"}
BarVisibility~d!4~5~
BarVisibility~f~6!{INCCLASSES=1,ALERTIC=0.9,ALERTOC=0.8,HIDEOOR="false"}
BarVisibility~d!7~
BarVisibility~f~8!{INCCLASSES=1,ALERTIC=0.98,ALERTOC=0.9,HIDEOOR="false"}
BarVisibility~d!9~10~
BarSort~f~1!{SUBORDER=1,OORLAST="false",RAIDORDER=3,SUBPF="true"}
BarSort~f~2!{SUBORDER=1,OORLAST="false",RAIDORDER=1,SUBPF="true"}
BarSort~f~3!{SUBORDER=1,OORLAST="false",RAIDORDER=3,SUBPF="true"}
BarSort~d!4~5~6~7~8~9~
BarSort~f~10!{SUBORDER=6,OORLAST="false",RAIDORDER=6,SUBPF="true"}
BarAggro~f~1!{R=1,SHOWTEXT="false",G=0,TEXTFORMAT=3,SHOW="true",SHOWTEXTPCT="true",B=0,SHOWIND="true",ALERTIND=2,ALERT=3}
BarAggro~d!2~3~4~5~6~7~8~9~10~
AuxBarFrame~f~1!{OFREQ=0.1,OVERLAP=1,OMIN=0.1,OMAX=0.95}
AuxBarFrame~f~2!{OFREQ=0.07,OVERLAP=1,OMIN=0.1,OMAX=0.95}
AuxBarFrame~d!3~4~5~6~7~8~9~10~
AuxBar^1~f~1!{SIZE=0.98,USE=4,R=1,COLOUR=1,ANCHOR=1,OFFSET=0,DEPTH=3,OTYPE=1,A=1,B=1,G=1}
AuxBar^1~d!2~3~4~5~6~7~8~9~10~
AuxBar^2~f~1!{SIZE=0.98,USE=6,R=1,COLOUR=1,ANCHOR=2,OFFSET=0,DEPTH=3,OTYPE=1,A=1,B=1,G=1}
AuxBar^2~d!2~3~4~5~6~7~8~9~10~
AuxBar^3~f~1!{SIZE=0.98,USE=5,R=1,COLOUR=1,ANCHOR=1,OFFSET=0,DEPTH=2,OTYPE=2,A=1,B=1,G=1}
AuxBar^3~d!2~3~4~5~6~7~8~9~10~
AuxBar^4~f~1!{SIZE=0.98,USE=5,R=1,COLOUR=1,ANCHOR=2,OFFSET=0,DEPTH=2,OTYPE=2,A=1,B=1,G=1}
AuxBar^4~d!2~3~4~5~6~7~8~9~10~
AuxBar^5~f~1!{SIZE=0.98,USE=9,R=1,COLOUR=1,ANCHOR=3,OFFSET=1,DEPTH=2,OTYPE=2,A=1,B=1,G=1}
AuxBar^5~d!2~3~4~5~6~7~8~9~10~
AuxBar^6~f~1!{SIZE=0.98,USE=10,R=1,COLOUR=1,ANCHOR=4,OFFSET=1,DEPTH=2,OTYPE=2,A=1,B=1,G=1}
AuxBar^6~d!2~3~4~5~6~7~8~9~10~
AuxBar^7~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,OTYPE=1,A=1,B=1,G=1}
AuxBar^7~d!2~3~4~5~6~7~8~9~10~
AuxBar^8~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,OTYPE=1,A=1,B=1,G=1}
AuxBar^8~d!2~3~4~5~6~7~8~9~10~
AuxBar^9~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,OTYPE=1,A=1,B=1,G=1}
AuxBar^9~d!2~3~4~5~6~7~8~9~10~
Complete!]]
HealBot_ExtraSkinData[3]=[[Skin
Verena
Author~v!Vayah von Lothar
DuplicateBars~v!false
Chat~t!{EOCOOM="false",EOCOOMV=20,MSG="Casting #s on #n",RESONLY="true",CHAN="",NOTIFY=0}
General~t!{FLUIDFREQ=4,HIDEPARTYF="false",HIDEPTF="false",STICKYSENSITIVITY=30,HIDERAIDF="false",STICKYFRAME="false",FLUIDBARS="false",HIDEBOSSF="false"}
Healing~t!{TINCSELF="false",GROUPPETS="true",TARGETINCOMBAT=2,FALWAYSSHOW="false",FONLYFRIEND="false",SELFPET=0,TONLYFRIEND="false",TINCGROUP="true",FOCUSINCOMBAT=2,TALWAYSSHOW="false",TINCPET="false",TINCRAID="true",TEXRAID="false",FEXRAID="false"}
Protection~t!{COMBAT="false",GENERALMACRO="false",COMBATPARTY="true",CRASH="false",COMBATRAID="true"}
Enemy~t!{INCARENA="true",INCTANKS="true",INCMYTAR="false",ENEMYTARGET="false",ENEMYTARGETSIZE=40,INCARENAPETS="false",HIDE="true",NUMBOSS=2,EXISTSHOWPTAR="false",INCSELF="false",EXISTSHOWBOSS="true",DOUBLEWIDTH="false",EXISTSHOWARENA="true"}
IncludeGroup~f~1!{"true","true","true","true","true","true","true","true"}
IncludeGroup~f~2!{"true","true","true","true","true","true","true","true"}
IncludeGroup~f~3!{"true","true","true","true","true","true","true","true"}
IncludeGroup~f~4!{"true","true","true","true","true","true","true","true"}
IncludeGroup~f~5!{"true","true","true","true","true","true","true","true"}
IncludeGroup~f~6!{"true","true","true","true","true","true","true","true"}
IncludeGroup~f~7!{"true","true","true","true","true","true","true","true"}
IncludeGroup~f~8!{"true","true","true","true","true","true","true","true"}
IncludeGroup~f~9!{"true","true","true","true","true","true","true","true"}
IncludeGroup~f~10!{"true","true","true","true","true","true","true","true"}
FrameAlias~f~1!{SIZE=12,NAME="",R=1,ALIAS="Rahmen 1",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~d!2~3~4~5~
FrameAlias~f~6!{SIZE=12,NAME="",R=1,ALIAS="Vehicle",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~7!{SIZE=12,NAME="",R=1,ALIAS="Pets",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~8!{SIZE=12,NAME="",R=1,ALIAS="Target",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~9!{SIZE=12,NAME="",R=1,ALIAS="Focus",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~10!{SIZE=12,NAME="",R=1,ALIAS="Enemy",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAliasBar~f~1!{A=0.4,TEXTURE="HealBot 10",B=0.1,HEIGHT=20,R=0.1,G=0.7,WIDTH=0.7}
FrameAliasBar~d!2~3~4~5~6~7~8~9~10~
Frame~f~1!{BACKR=0.1,BORDERR=0.2,TIPLOC=5,BORDERB=0.2,LOCKED="false",SCALE=1,BORDERA=0.2,SFOFFSETV=0,AUTOCLOSE="false",BACKB=0.1,BACKA=0.05,OPENSOUND="false",BACKG=0.1,BORDERG=0.2,SFOFFSETH=0}
Frame~d!2~3~4~5~6~7~8~9~10~
StickyFrames~f~1!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~d!2~3~4~5~6~7~8~9~10~
HealGroups~f~1!{FRAME=1,STATE="false",NAME="Self"}
HealGroups~f~2!{FRAME=1,STATE="true",NAME="Main tanks"}
HealGroups~f~3!{FRAME=1,STATE="false",NAME="Healers"}
HealGroups~f~4!{FRAME=1,STATE="true",NAME="Group"}
HealGroups~f~5!{FRAME=1,STATE="false",NAME="Private List"}
HealGroups~f~6!{FRAME=1,STATE="true",NAME="Raid"}
HealGroups~f~7!{FRAME=6,STATE="false",NAME="Vehicle"}
HealGroups~f~8!{FRAME=7,STATE="false",NAME="Pets"}
HealGroups~f~9!{FRAME=8,STATE="false",NAME="Target"}
HealGroups~f~10!{FRAME=9,STATE="false",NAME="Focus"}
HealGroups~f~11!{FRAME=10,STATE="false",NAME="Enemy"}
Anchors~f~1!{Y=34.54,GROW=2,BARS=1,FRAME=1,X=40.66}
Anchors~f~2!{Y=51,GROW=2,BARS=1,FRAME=1,X=51}
Anchors~f~3!{Y=52,GROW=2,BARS=1,FRAME=1,X=52}
Anchors~f~4!{Y=53,GROW=2,BARS=1,FRAME=1,X=53}
Anchors~f~5!{Y=54,GROW=2,BARS=1,FRAME=1,X=54}
Anchors~f~6!{Y=55,GROW=2,BARS=1,FRAME=1,X=55}
Anchors~f~7!{Y=56,GROW=2,BARS=1,FRAME=1,X=56}
Anchors~f~8!{Y=57,GROW=2,BARS=1,FRAME=1,X=57}
Anchors~f~9!{Y=58,GROW=2,BARS=1,FRAME=1,X=58}
Anchors~f~10!{Y=59,GROW=2,BARS=1,FRAME=1,X=59}
HeadBar~f~1!{SHOW="true",WIDTH=0.7,B=0.702,R=0.694,HEIGHT=15,A=0.4,G=0.188,TEXTURE="HealBot 10"}
HeadBar~f~2!{SHOW="true",WIDTH=0.7,B=0.1,R=0.1,HEIGHT=15,A=0.4,G=0.7,TEXTURE="HealBot 10"}
HeadBar~d!3~4~5~6~7~8~9~10~
HeadText~f~1!{A=0.74,B=1,OFFSET=0,R=1,FONT="Arial Narrow",HEIGHT=9,G=1,OUTLINE=1}
HeadText~f~2!{A=0.74,B=1,OFFSET=0,R=1,FONT="Friz Quadrata TT",HEIGHT=9,G=1,OUTLINE=1}
HeadText~d!3~4~5~6~7~8~9~10~
HealBar~f~1!{HEIGHT=25,GRPCOLS="false",CMARGIN=2,TEXTURE="Minimalist",POWERCNT="true",LOWMANACOMBAT="true",NUMCOLS=1,RMARGIN=0,OFIX=1,WIDTH=93,LOWMANA=2}
HealBar~d!2~3~4~5~6~7~8~9~10~
BarCol~f~1!{BACK=2,BA=0,BB=0.608,DISA=1,BR=0.494,HB=0.7,BOUT=0,BG=0.451,HA=1,HR=0.4,ORA=0.2,HG=0.4,HLTH=2}
BarCol~f~2!{BACK=1,BA=0,BB=0.7,DISA=0.1,BR=0.4,HB=0.7,BOUT=2,BG=0.4,HA=1,HR=0.4,ORA=0.4,HG=0.4,HLTH=1}
BarCol~d!3~4~5~6~7~8~9~10~
BarIACol~f~1!{AC=1,AB=1,AA=0.78,AR=1,AG=1,IC=4,IB=0.2,IA=0.9,IR=0.2,IG=1}
BarIACol~f~2!{AC=3,AB=1,AA=0.78,AR=1,AG=1,IC=3,IB=0.2,IA=0.82,IR=0.2,IG=1}
BarIACol~d!3~4~5~6~7~8~9~10~
BarText~f~1!{HLTHONBAR="true",TAGOOR="[ OOR ] ",IGNOREONFULL="true",MAXCHARS=0,HHEIGHT=10,CLASSONBAR="false",HFONT="Friz Quadrata TT",HOUTLINE=1,HOFFSET=0,INCHEALS=2,HLTHTXTANCHOR=1,HLTHTYPE=3,OVERHEAL=1,INCABSORBS=1,NUMFORMAT2=1,FONT="Arial Narrow",NUMFORMAT1=11,TAGDC="[ DC ] ",TAGRIP="[ RIP ] ",HEIGHT=10,HMAXCHARS=0,SHOWROLE="true",HALIGN=2,NAMEONBAR="true",OFFSET=0,CLASSTYPE=1,HOFFSET2=0,ALIGN=1,TAGR="[ R ] ",OUTLINE=1}
BarText~f~2!{HLTHONBAR="true",TAGOOR="[ OOR ] ",IGNOREONFULL="true",MAXCHARS=0,HHEIGHT=10,CLASSONBAR="false",HFONT="Friz Quadrata TT",HOUTLINE=1,HOFFSET=0,INCHEALS=2,HLTHTXTANCHOR=1,HLTHTYPE=1,OVERHEAL=1,INCABSORBS=1,NUMFORMAT2=1,FONT="Friz Quadrata TT",NUMFORMAT1=11,TAGDC="[ DC ] ",TAGRIP="[ RIP ] ",HEIGHT=10,HMAXCHARS=0,SHOWROLE="true",HALIGN=2,NAMEONBAR="true",OFFSET=0,CLASSTYPE=1,HOFFSET2=0,ALIGN=2,TAGR="[ R ] ",OUTLINE=1}
BarText~d!3~4~5~6~7~8~9~10~
BarTextCol~f~1!{NAME=3,NCR=1,HCG=1,NCDA=0.4,NCB=1,NDEBUFF="false",NCG=1,HCR=1,HCA=1,HCB=1,NCA=1,HDEBUFF="false",HCDA=0.4,HLTH=3}
BarTextCol~f~2!{NAME=2,NCR=1,HCG=1,NCDA=0.4,NCB=0,NDEBUFF="false",NCG=1,HCR=1,HCA=1,HCB=0,NCA=1,HDEBUFF="false",HCDA=0.4,HLTH=2}
BarTextCol~d!3~4~5~6~7~8~9~10~
Icons~f~1!{SHOWBUFF="true",SHOWDEBUFF="true",I15EN="true",FADESECS=15,MAXDICONS=3,POSITION=2,ONBAR=1,SHOWDIRMOUSE="false",DSCALE=0.7,SHOWDIR="false",SHOWRC="true",SCALE=0.7,FADE="true",DOUBLE="false",MAXBICONS=8}
Icons~f~2!{SHOWBUFF="true",SHOWDEBUFF="true",I15EN="true",FADESECS=15,MAXDICONS=3,POSITION=2,ONBAR=1,SHOWDIRMOUSE="false",DSCALE=0.7,SHOWDIR="true",SHOWRC="true",SCALE=0.7,FADE="true",DOUBLE="false",MAXBICONS=8}
Icons~d!3~4~5~6~7~8~9~10~
RaidIcon~f~1!{SQUARE="true",CIRCLE="true",DIAMOND="true",SHOW="true",MOON="true",TRIANGLE="true",STAR="true",SKULL="true",CROSS="true"}
RaidIcon~d!2~3~4~5~6~7~8~9~10~
IconText~f~1!{DURWARN=3,HEIGHT=9,SSCNT="false",SCNT="true",DURTHRH=9,FONT="Friz Quadrata TT",SDUR="true",SSDUR="true",OUTLINE=2}
IconText~d!2~3~4~5~6~7~8~9~10~
BarVisibility~f~1!{INCCLASSES=1,ALERTIC=0.98,ALERTOC=0.95,HIDEOOR="false"}
BarVisibility~d!2~3~4~5~6~7~8~9~10~
BarSort~f~1!{SUBORDER=3,OORLAST="false",RAIDORDER=3,SUBPF="true"}
BarSort~f~2!{SUBORDER=1,OORLAST="false",RAIDORDER=3,SUBPF="true"}
BarSort~d!3~4~5~6~7~8~9~10~
BarAggro~f~1!{SHOWTEXT="false",R=1,ALERTIND=2,G=0,TEXTFORMAT=3,SHOW="true",SHOWTEXTPCT="true",B=0,SHOWIND="true",ALERT=3}
BarAggro~d!2~3~4~5~6~7~8~9~10~
AuxBarFrame~f~1!{OFREQ=0.07,OVERLAP=1,OMIN=0.1,OMAX=0.95}
AuxBarFrame~d!2~3~4~5~6~7~8~9~10~
AuxBar^1~f~1!{SIZE=0.98,USE=4,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=4,A=1,B=1,G=1,OTYPE=1}
AuxBar^1~d!2~3~4~5~6~7~8~9~10~
AuxBar^2~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,A=1,B=1,G=1,OTYPE=1}
AuxBar^2~d!2~3~4~5~6~7~8~9~10~
AuxBar^3~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,A=1,B=1,G=1,OTYPE=1}
AuxBar^3~d!2~3~4~5~6~7~8~9~10~
AuxBar^4~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,A=1,B=1,G=1,OTYPE=1}
AuxBar^4~d!2~3~4~5~6~7~8~9~10~
AuxBar^5~f~1!{SIZE=0.98,USE=5,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=2,A=1,B=1,G=1,OTYPE=1}
AuxBar^5~d!2~3~4~5~6~7~8~9~10~
AuxBar^6~f~1!{SIZE=0.98,USE=8,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,A=1,B=1,G=1,OTYPE=1}
AuxBar^6~f~2!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,A=1,B=1,G=1,OTYPE=1}
AuxBar^6~d!3~4~5~6~7~8~9~10~
AuxBar^7~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,A=1,B=1,G=1,OTYPE=1}
AuxBar^7~d!2~3~4~5~6~7~8~9~10~
AuxBar^8~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,A=1,B=1,G=1,OTYPE=1}
AuxBar^8~d!2~3~4~5~6~7~8~9~10~
AuxBar^9~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,A=1,B=1,G=1,OTYPE=1}
AuxBar^9~d!2~3~4~5~6~7~8~9~10~
Complete!]]
HealBot_ExtraSkinData[4]=[[Skin
Aux Group
Author~v!Monti of Terenas
DuplicateBars~v!false
Chat~t!{EOCOOM="true",EOCOOMV=5,MSG="Casting #s on #n",RESONLY="true",CHAN="",NOTIFY=2}
General~t!{HIDEBOSSF="true",HIDEPTF="false",HIDEPARTYF="false",STICKYSENSITIVITY=20,HIDERAIDF="true",STICKYFRAME="true",FLUIDBARS="false",FLUIDFREQ=6}
Healing~t!{TINCSELF="false",GROUPPETS="true",TARGETINCOMBAT=1,FALWAYSSHOW="false",FONLYFRIEND="true",FEXRAID="false",TONLYFRIEND="false",TINCGROUP="true",FOCUSINCOMBAT=2,TALWAYSSHOW="false",SELFPET=0,TINCPET="false",TEXRAID="false",TINCRAID="true"}
Protection~t!{COMBAT="false",GENERALMACRO="true",COMBATPARTY="true",CRASH="true",COMBATRAID="true"}
Enemy~t!{ENEMYTARGET="true",INCTANKS="true",INCMYTAR="false",INCARENA="false",INCARENAPETS="false",ENEMYTARGETSIZE=70,INCSELF="false",NUMBOSS=4,EXISTSHOWPTAR="false",HIDE="true",EXISTSHOWBOSS="true",DOUBLEWIDTH="false",EXISTSHOWARENA="false"}
IncludeGroup~f~1!{"true","true","true","true","true","true","true","true"}
IncludeGroup~f~2!{"true","true","true","true","true","true","true","true"}
IncludeGroup~f~3!{"true","true","true","true","true","true","true","true"}
IncludeGroup~f~4!{"true","true","true","true","true","true","true","true"}
IncludeGroup~f~5!{"true","true","true","true","true","true","true","true"}
IncludeGroup~f~6!{"true","true","true","true","true","true","true","true"}
IncludeGroup~f~7!{"true","true","true","true","true","true","true","true"}
IncludeGroup~f~8!{"true","true","true","true","true","true","true","true"}
IncludeGroup~f~9!{"true","true","true","true","true","true","true","true"}
IncludeGroup~f~10!{"true","true","true","true","true","true","true","true"}
FrameAlias~f~1!{SIZE=12,NAME="Party",R=1,ALIAS="Party",G=1,SHOW="true",OFFSET=1,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~2!{SIZE=12,NAME="Tank and Healer",R=1,ALIAS="Not Used",G=1,SHOW="true",OFFSET=1,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~3!{SIZE=12,NAME="Pets",R=1,ALIAS="Not Used 1",G=1,SHOW="true",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~4!{SIZE=12,NAME="Focus and Target",R=1,ALIAS="Not Used 2",G=1,SHOW="true",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~5!{SIZE=12,NAME="Enemy",R=1,ALIAS="Not Used 3",G=0,SHOW="true",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=0.082,OUTLINE=1}
FrameAlias~f~6!{SIZE=12,NAME="",R=1,ALIAS="Vehicle",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~7!{SIZE=12,NAME="Pets",R=1,ALIAS="Pets",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~8!{SIZE=12,NAME="Target",R=1,ALIAS="Target",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~9!{SIZE=12,NAME="",R=1,ALIAS="Focus",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~10!{SIZE=12,NAME="",R=1,ALIAS="Enemy",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAliasBar~f~1!{A=0.25,TEXTURE="Diagonal",B=0.1,HEIGHT=20,R=0.1,G=0.1,WIDTH=0.9}
FrameAliasBar~d!2~3~4~5~6~7~8~9~10~
Frame~f~1!{BACKR=0.02,BACKG=0.016,TIPLOC=2,BORDERB=0,LOCKED="false",SCALE=1,BORDERA=0,BORDERG=0,AUTOCLOSE="false",BACKB=0.016,BACKA=0.33,OPENSOUND="false",SFOFFSETV=0,BORDERR=0.976,SFOFFSETH=0}
Frame~f~2!{BACKR=0.102,BACKG=0.102,TIPLOC=1,BORDERB=0.102,LOCKED="true",SCALE=1,BORDERA=0,BORDERG=0.102,AUTOCLOSE="false",BACKB=0.502,BACKA=0.04,OPENSOUND="false",SFOFFSETV=0,BORDERR=0.102,SFOFFSETH=2}
Frame~f~3!{BACKR=0.1,BACKG=0.1,TIPLOC=2,BORDERB=0.1,LOCKED="false",SCALE=1,BORDERA=0.5,BORDERG=0.1,AUTOCLOSE="false",BACKB=0.5,BACKA=0.2,OPENSOUND="false",SFOFFSETV=0,BORDERR=0.1,SFOFFSETH=0}
Frame~d!4~
Frame~f~5!{BACKR=0.1,BACKG=0.1,TIPLOC=4,BORDERB=0.1,LOCKED="false",SCALE=1,BORDERA=0.5,BORDERG=0.1,AUTOCLOSE="false",BACKB=0.5,BACKA=0.2,OPENSOUND="false",SFOFFSETV=0,BORDERR=0.1,SFOFFSETH=0}
Frame~f~6!{BACKR=0.1,BACKG=0.1,TIPLOC=5,BORDERB=0.1,LOCKED="false",SCALE=1,BORDERA=0.5,BORDERG=0.1,AUTOCLOSE="false",BACKB=0.5,BACKA=0.2,OPENSOUND="false",SFOFFSETV=0,BORDERR=0.1,SFOFFSETH=0}
Frame~f~7!{BACKR=0.102,BACKG=0.102,TIPLOC=5,BORDERB=0.102,LOCKED="true",SCALE=1,BORDERA=0.01,BORDERG=0.102,AUTOCLOSE="false",BACKB=0.502,BACKA=0.01,OPENSOUND="false",SFOFFSETV=7,BORDERR=0.102,SFOFFSETH=0}
Frame~f~8!{BACKR=0.102,BACKG=0.102,TIPLOC=5,BORDERB=0.102,LOCKED="false",SCALE=1,BORDERA=0,BORDERG=0.102,AUTOCLOSE="false",BACKB=0.502,BACKA=0,OPENSOUND="false",SFOFFSETV=4,BORDERR=0.102,SFOFFSETH=8}
Frame~f~9!{BACKR=0.102,BACKG=0.102,TIPLOC=5,BORDERB=0.102,LOCKED="false",SCALE=1,BORDERA=0,BORDERG=0.102,AUTOCLOSE="false",BACKB=0.502,BACKA=0,OPENSOUND="false",SFOFFSETV=0,BORDERR=0.102,SFOFFSETH=8}
Frame~f~10!{BACKR=0.102,BACKG=0.102,TIPLOC=2,BORDERB=0.102,LOCKED="false",SCALE=1,BORDERA=0.1,BORDERG=0.102,AUTOCLOSE="false",BACKB=0.502,BACKA=0.05,OPENSOUND="false",SFOFFSETV=0,BORDERR=0.102,SFOFFSETH=0}
StickyFrames~f~1!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~f~2!{STUCK="true",STUCKTOPOINT="TOPLEFT",STUCKTO=1,STUCKPOINT="TOPRIGHT"}
StickyFrames~f~3!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~d!4~5~6~
StickyFrames~f~7!{STUCK="true",STUCKTOPOINT="BOTTOMRIGHT",STUCKTO=1,STUCKPOINT="TOPRIGHT"}
StickyFrames~f~8!{STUCK="true",STUCKTOPOINT="TOPLEFT",STUCKTO=1,STUCKPOINT="TOPRIGHT"}
StickyFrames~f~9!{STUCK="true",STUCKTOPOINT="LEFT",STUCKTO=1,STUCKPOINT="RIGHT"}
StickyFrames~f~10!{STUCK="false",STUCKTOPOINT="TOPLEFT",STUCKTO=1,STUCKPOINT="BOTTOMLEFT"}
HealGroups~f~1!{FRAME=1,STATE="true",NAME="Main tanks"}
HealGroups~f~2!{FRAME=1,STATE="true",NAME="Self"}
HealGroups~f~3!{FRAME=1,STATE="true",NAME="Healers"}
HealGroups~f~4!{FRAME=1,STATE="false",NAME="Private List"}
HealGroups~f~5!{FRAME=1,STATE="true",NAME="Group"}
HealGroups~f~6!{FRAME=1,STATE="true",NAME="Raid"}
HealGroups~f~7!{FRAME=6,STATE="false",NAME="Vehicle"}
HealGroups~f~8!{FRAME=1,STATE="true",NAME="Pets"}
HealGroups~f~9!{FRAME=8,STATE="true",NAME="Target"}
HealGroups~f~10!{FRAME=9,STATE="true",NAME="Focus"}
HealGroups~f~11!{FRAME=10,STATE="true",NAME="Enemy"}
Anchors~f~1!{Y=67.5,GROW=2,BARS=1,FRAME=3,X=95.49}
Anchors~f~2!{Y=66.8,GROW=2,BARS=1,FRAME=3,X=88.74}
Anchors~f~3!{Y=65.52,GROW=2,BARS=3,FRAME=3,X=92.08}
Anchors~f~4!{Y=64.17,GROW=2,BARS=1,FRAME=1,X=83.17}
Anchors~f~5!{Y=65.23,GROW=2,BARS=2,FRAME=2,X=89.04}
Anchors~f~6!{Y=55,GROW=2,BARS=1,FRAME=1,X=55}
Anchors~f~7!{Y=59.35,GROW=2,BARS=1,FRAME=3,X=95.25}
Anchors~f~8!{Y=67.83,GROW=2,BARS=1,FRAME=3,X=88.69}
Anchors~f~9!{Y=64.5,GROW=2,BARS=1,FRAME=7,X=88.63}
Anchors~f~10!{Y=69.24,GROW=2,BARS=4,FRAME=2,X=88.58}
HeadBar~f~1!{SHOW="false",TEXTURE="Diagonal",R=0.506,B=0.506,HEIGHT=30,A=0.4,G=0.506,WIDTH=0.9}
HeadBar~f~2!{SHOW="false",TEXTURE="Diagonal",R=0.1,B=0.1,HEIGHT=30,A=0.25,G=0.1,WIDTH=0.9}
HeadBar~d!3~4~5~6~7~8~9~10~
HeadText~f~1!{A=0.7,R=0.2,OFFSET=0,B=0.8,FONT="Friz Quadrata TT",HEIGHT=10,G=0.8,OUTLINE=1}
HeadText~f~2!{A=0.7,R=1,OFFSET=0,B=0.1,FONT="Friz Quadrata TT",HEIGHT=10,G=1,OUTLINE=1}
HeadText~d!3~4~5~6~7~8~9~10~
HealBar~f~1!{HEIGHT=40,GRPCOLS="false",CMARGIN=4,TEXTURE="Smooth v2",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=175,RMARGIN=0,OFIX=1,NUMCOLS=1,LOWMANA=5}
HealBar~f~2!{HEIGHT=34,GRPCOLS="false",CMARGIN=4,TEXTURE="Smooth v2",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=172,RMARGIN=0,OFIX=1,NUMCOLS=1,LOWMANA=2}
HealBar~d!3~4~5~6~7~8~9~
HealBar~f~10!{HEIGHT=34,GRPCOLS="false",CMARGIN=1,TEXTURE="Smooth v2",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=172,RMARGIN=0,OFIX=1,NUMCOLS=1,LOWMANA=2}
BarCol~f~1!{BACK=3,BA=0.25,BOUT=1,DISA=0.25,BR=0,HB=0.9,BB=0,HR=0.2,HA=1,HG=0.2,ORA=0.7,BG=0,HLTH=2}
BarCol~d!2~3~4~5~6~7~8~9~10~
BarIACol~f~1!{AC=4,AB=0.969,AA=0.2,AR=1,AG=0.945,IC=2,IB=0.2,IA=0.5,IR=0.2,IG=0.9}
BarIACol~d!2~3~4~5~6~7~8~9~10~
BarText~f~1!{HHEIGHT=15,TAGOOR="OOR | ",HOUTLINE=1,MAXCHARS=0,OVERHEAL=2,HMAXCHARS=0,HOFFSET=0,HFONT="Friz Quadrata TT",IGNOREONFULL="true",INCHEALS=2,HLTHTXTANCHOR=1,HLTHTYPE=1,CLASSONBAR="true",CLASSTYPE=1,NUMFORMAT2=1,HLTHONBAR="true",TAGDC="DC | ",NUMFORMAT1=11,NAMEONBAR="true",HEIGHT=13,TAGRIP="RIP | ",SHOWROLE="true",HALIGN=2,OFFSET=2,FONT="Friz Quadrata TT",INCABSORBS=2,HOFFSET2=0,ALIGN=2,TAGR="R | ",OUTLINE=1}
BarText~f~2!{HHEIGHT=15,TAGOOR="OOR | ",HOUTLINE=1,MAXCHARS=0,OVERHEAL=2,HMAXCHARS=0,HOFFSET=0,HFONT="Friz Quadrata TT",IGNOREONFULL="false",INCHEALS=2,HLTHTXTANCHOR=1,HLTHTYPE=1,CLASSONBAR="true",CLASSTYPE=1,NUMFORMAT2=1,HLTHONBAR="true",TAGDC="DC | ",NUMFORMAT1=11,NAMEONBAR="true",HEIGHT=13,TAGRIP="RIP | ",SHOWROLE="true",HALIGN=2,OFFSET=2,FONT="Friz Quadrata TT",INCABSORBS=2,HOFFSET2=0,ALIGN=2,TAGR="R | ",OUTLINE=1}
BarText~d!3~
BarText~f~4!{HHEIGHT=15,TAGOOR="OOR | ",HOUTLINE=1,MAXCHARS=0,IGNOREONFULL="false",HMAXCHARS=0,HFONT="Friz Quadrata TT",HOFFSET=0,CLASSONBAR="true",INCHEALS=2,HLTHTXTANCHOR=1,FONT="Friz Quadrata TT",HLTHTYPE=1,CLASSTYPE=1,NUMFORMAT2=1,HLTHONBAR="true",NUMFORMAT1=11,OVERHEAL=2,NAMEONBAR="true",HEIGHT=13,TAGRIP="RIP | ",SHOWROLE="true",HALIGN=2,TAGDC="DC | ",OFFSET=2,INCABSORBS=2,HOFFSET2=0,ALIGN=2,TAGR="R | ",OUTLINE=1}
BarText~d!5~6~7~8~9~10~
BarTextCol~f~1!{NCB=0,NCR=0.996,HCG=0,NCDA=0.8,NAME=2,HCA=1,HCB=0,NCA=1,NDEBUFF="false",NCG=0.91,HCR=0,HDEBUFF="false",HCDA=0.5,HLTH=1}
BarTextCol~d!2~3~4~5~6~7~8~9~10~
Icons~f~1!{SHOWBUFF="true",SHOWDEBUFF="true",MAXDICONS=4,I15EN="true",FADE="false",FADESECS=15,SHOWDIR="false",SHOWDIRMOUSE="false",DSCALE=1,ONBAR=1,SHOWRC="true",SCALE=1,DOUBLE="true",POSITION=2,MAXBICONS=8}
Icons~d!2~3~4~5~6~
Icons~f~7!{SHOWBUFF="true",SHOWDEBUFF="true",MAXDICONS=2,I15EN="true",FADE="false",FADESECS=15,SHOWDIR="false",SHOWDIRMOUSE="false",DSCALE=1,ONBAR=1,SHOWRC="true",SCALE=1,DOUBLE="true",POSITION=2,MAXBICONS=4}
Icons~f~8!{SHOWBUFF="true",SHOWDEBUFF="true",MAXDICONS=4,I15EN="true",FADE="false",FADESECS=15,SHOWDIR="false",SHOWDIRMOUSE="false",DSCALE=1,ONBAR=1,SHOWRC="true",SCALE=1,DOUBLE="true",POSITION=2,MAXBICONS=8}
Icons~d!9~10~
RaidIcon~f~1!{SQUARE="true",CIRCLE="true",DIAMOND="true",SHOW="true",MOON="true",TRIANGLE="true",STAR="true",CROSS="true",SKULL="true"}
RaidIcon~d!2~3~4~5~6~7~8~9~10~
IconText~f~1!{DURWARN=3,HEIGHT=10,SSCNT="false",SCNT="true",DURTHRH=9,FONT="Friz Quadrata TT",SDUR="true",SSDUR="true",OUTLINE=2}
IconText~d!2~3~4~5~6~7~8~9~10~
BarVisibility~f~1!{INCCLASSES=1,ALERTIC=1,ALERTOC=0.95,HIDEOOR="false"}
BarVisibility~d!2~3~4~5~6~
BarVisibility~f~7!{INCCLASSES=1,ALERTIC=0.9,ALERTOC=0.75,HIDEOOR="false"}
BarVisibility~f~8!{INCCLASSES=1,ALERTIC=1,ALERTOC=0.95,HIDEOOR="false"}
BarVisibility~d!9~10~
BarSort~f~1!{SUBORDER=1,OORLAST="false",RAIDORDER=1,SUBPF="true"}
BarSort~f~2!{SUBORDER=1,OORLAST="false",RAIDORDER=3,SUBPF="true"}
BarSort~d!3~4~5~6~7~8~9~
BarSort~f~10!{SUBORDER=1,OORLAST="false",RAIDORDER=6,SUBPF="true"}
BarAggro~f~1!{R=1,ALERTIND=2,G=0.024,TEXTFORMAT=3,SHOW="true",SHOWTEXTPCT="true",B=0.024,SHOWIND="true",SHOWTEXT="false",ALERT=1}
BarAggro~f~2!{R=1,ALERTIND=2,G=0.024,TEXTFORMAT=3,SHOW="true",SHOWTEXTPCT="true",B=0.024,SHOWIND="true",SHOWTEXT="false",ALERT=2}
BarAggro~d!3~4~5~6~7~8~9~10~
AuxBarFrame~f~1!{OFREQ=0.09,OVERLAP=1,OMIN=0.4,OMAX=1}
AuxBarFrame~d!2~3~4~5~6~7~8~9~10~
AuxBar^1~f~1!{SIZE=1,USE=1,R=0.7,COLOUR=3,ANCHOR=4,OFFSET=0,DEPTH=4,G=0.7,A=1,OTYPE=1,B=0.2}
AuxBar^1~d!2~3~4~5~6~7~8~9~10~
AuxBar^2~f~1!{SIZE=1,USE=3,R=0.067,COLOUR=3,ANCHOR=4,OFFSET=1,DEPTH=4,G=0.918,A=1,OTYPE=1,B=0.035}
AuxBar^2~d!2~3~4~5~6~7~8~9~
AuxBar^2~f~10!{SIZE=1,USE=1,R=0.067,COLOUR=3,ANCHOR=4,OFFSET=1,DEPTH=4,G=0.918,A=1,OTYPE=1,B=0.035}
AuxBar^3~f~1!{SIZE=1,USE=7,R=0.918,COLOUR=3,ANCHOR=4,OFFSET=0,DEPTH=3,G=0.843,A=1,OTYPE=1,B=0}
AuxBar^3~d!2~3~4~5~6~7~8~9~
AuxBar^3~f~10!{SIZE=1,USE=1,R=0.918,COLOUR=3,ANCHOR=4,OFFSET=0,DEPTH=3,G=0.843,A=1,OTYPE=1,B=0}
AuxBar^4~f~1!{SIZE=1,USE=1,R=1,COLOUR=1,ANCHOR=3,OFFSET=0,DEPTH=2,G=1,A=1,OTYPE=1,B=1}
AuxBar^4~d!2~3~4~5~6~7~8~9~10~
AuxBar^5~f~1!{SIZE=1,USE=6,R=0.631,COLOUR=1,ANCHOR=3,OFFSET=1,DEPTH=4,G=0.247,A=1,OTYPE=1,B=0.247}
AuxBar^5~d!2~3~4~5~6~7~8~9~
AuxBar^5~f~10!{SIZE=1,USE=1,R=0.631,COLOUR=1,ANCHOR=3,OFFSET=1,DEPTH=4,G=0.247,A=1,OTYPE=1,B=0.247}
AuxBar^6~f~1!{SIZE=1,USE=5,R=1,COLOUR=1,ANCHOR=3,OFFSET=0,DEPTH=3,G=1,A=1,OTYPE=1,B=1}
AuxBar^6~d!2~3~4~5~6~7~8~9~
AuxBar^6~f~10!{SIZE=1,USE=1,R=1,COLOUR=1,ANCHOR=3,OFFSET=0,DEPTH=3,G=1,A=1,OTYPE=1,B=1}
AuxBar^7~f~1!{SIZE=0.58,USE=9,R=0.8,COLOUR=1,ANCHOR=2,OFFSET=1,DEPTH=3,G=0.2,A=1,OTYPE=2,B=0.8}
AuxBar^7~d!2~3~4~5~6~7~8~9~
AuxBar^7~f~10!{SIZE=0.58,USE=1,R=0.8,COLOUR=1,ANCHOR=2,OFFSET=1,DEPTH=3,G=0.2,A=1,OTYPE=2,B=0.8}
AuxBar^8~f~1!{SIZE=0.58,USE=10,R=0.078,COLOUR=1,ANCHOR=2,OFFSET=-3,DEPTH=3,G=0.737,A=1,OTYPE=2,B=0.875}
AuxBar^8~d!2~3~4~5~6~7~8~9~
AuxBar^8~f~10!{SIZE=0.58,USE=1,R=0.078,COLOUR=1,ANCHOR=2,OFFSET=-3,DEPTH=3,G=0.737,A=1,OTYPE=2,B=0.875}
AuxBar^9~f~1!{SIZE=0.98,USE=4,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=4,G=1,A=1,OTYPE=1,B=1}
AuxBar^9~d!2~3~4~5~6~7~8~9~
AuxBar^9~f~10!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=4,G=1,A=1,OTYPE=1,B=1}
Complete!]]

HealBot_ExtraSkinData[5]=[[Skin
Addydari
Author~v!ADDYDARI of HealBot Website
DuplicateBars~v!false
Chat~t!{EOCOOM="false",EOCOOMV=20,MSG="Casting #s on #n",RESONLY="true",NOTIFY=1}
General~t!{FLUIDFREQ=3,HIDEPARTYF="false",HIDEPTF="false",STICKYFRAME="true",STICKYSENSITIVITY=20,HIDERAIDF="true",FLUIDBARS="false",HIDEBOSSF="false"}
Healing~t!{TONLYFRIEND="false",SELFPET="false",FOCUSINCOMBAT=2,GROUPPETS="true",TARGETINCOMBAT=2,FONLYFRIEND="false",TEXRAID="false",FEXRAID="false"}
Protection~t!{COMBAT="false",GENERALMACRO="true",COMBATPARTY="true",CRASH="true",COMBATRAID="true"}
Enemy~t!{INCARENA="true",INCTANKS="true",INCMYTAR="false",HIDE="true",ENEMYTARGETSIZE=40,INCARENAPETS="false",ENEMYTARGET="false",NUMBOSS=2,EXISTSHOWPTAR="false",INCSELF="false",EXISTSHOWBOSS="true",DOUBLEWIDTH="false",EXISTSHOWARENA="true"}
IncludeGroup~f~1!{"true","true","true","true","true","true","true","true"}
IncludeGroup~f~2!{"true","true","true","true","true","true","true","true"}
IncludeGroup~f~3!{"true","true","true","true","true","true","true","true"}
IncludeGroup~f~4!{"true","true","true","true","true","true","true","true"}
IncludeGroup~f~5!{"true","true","true","true","true","true","true","true"}
IncludeGroup~f~6!{"true","true","true","true","true","true","true","true"}
IncludeGroup~f~7!{"true","true","true","true","true","true","true","true"}
IncludeGroup~f~8!{"true","true","true","true","true","true","true","true"}
IncludeGroup~f~9!{"true","true","true","true","true","true","true","true"}
IncludeGroup~f~10!{"true","true","true","true","true","true","true","true"}
FrameAlias~f~1!{SIZE=12,NAME="",R=1,ALIAS="Frame 1",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~2!{SIZE=12,NAME="",R=1,ALIAS="",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~d!3~4~5~
FrameAlias~f~6!{SIZE=12,NAME="Vehicle",R=1,ALIAS="Vehicle",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~7!{SIZE=12,NAME="Pets",R=1,ALIAS="Pets",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~8!{SIZE=12,NAME="Target",R=1,ALIAS="Target",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~9!{SIZE=12,NAME="Focus",R=1,ALIAS="Focus",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~10!{SIZE=12,NAME="Enemy",R=1,ALIAS="Enemy",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAliasBar~f~1!{A=0.4,TEXTURE="HealBot 10",B=0.1,HEIGHT=20,R=0.1,G=0.7,WIDTH=0.7}
FrameAliasBar~d!2~3~4~5~6~7~8~9~10~
Frame~f~1!{SFOFFSETH=0,TIPLOC=5,AUTOCLOSE="false",BORDERB=0.2,LOCKED="false",SCALE=1,BORDERA=0.2,BORDERG=0.2,BACKG=0.1,BACKB=0.1,BACKA=0.05,OPENSOUND="false",BACKR=0.1,SFOFFSETV=0,BORDERR=0.2}
Frame~d!2~3~4~5~6~7~
Frame~f~8!{SFOFFSETH=0,TIPLOC=5,AUTOCLOSE="false",BORDERB=0.2,LOCKED="false",SCALE=1,BORDERA=0.2,BORDERG=0.2,BACKG=0.1,BACKB=0.1,BACKA=0.05,OPENSOUND="false",BACKR=0.1,SFOFFSETV=-8,BORDERR=0.2}
Frame~d!9~
Frame~f~10!{SFOFFSETH=0,TIPLOC=5,AUTOCLOSE="false",BORDERB=0.2,LOCKED="false",SCALE=1,BORDERA=0.2,BORDERG=0.2,BACKG=0.1,BACKB=0.1,BACKA=0.05,OPENSOUND="false",BACKR=0.1,SFOFFSETV=0,BORDERR=0.2}
StickyFrames~f~1!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~d!2~3~4~5~6~7~
StickyFrames~f~8!{STUCK="true",STUCKTOPOINT="TOPLEFT",STUCKTO=1,STUCKPOINT="BOTTOMLEFT"}
StickyFrames~f~9!{STUCK="true",STUCKTOPOINT="TOPRIGHT",STUCKTO=1,STUCKPOINT="BOTTOMRIGHT"}
StickyFrames~f~10!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
HealGroups~f~1!{FRAME=1,STATE="false",NAME="Self"}
HealGroups~f~2!{FRAME=1,STATE="false",NAME="Main tanks"}
HealGroups~f~3!{FRAME=1,STATE="false",NAME="Healers"}
HealGroups~f~4!{FRAME=1,STATE="true",NAME="Group"}
HealGroups~f~5!{FRAME=1,STATE="false",NAME="Raid"}
HealGroups~f~6!{FRAME=1,STATE="false",NAME="Private List"}
HealGroups~f~7!{FRAME=6,STATE="false",NAME="Vehicle"}
HealGroups~f~8!{FRAME=7,STATE="false",NAME="Pets"}
HealGroups~f~9!{FRAME=8,STATE="false",NAME="Target"}
HealGroups~f~10!{FRAME=9,STATE="false",NAME="Focus"}
HealGroups~f~11!{FRAME=10,STATE="false",NAME="Enemy"}
Anchors~f~1!{Y=75.98,GROW=2,BARS=3,FRAME=3,X=30.34}
Anchors~f~2!{Y=100,GROW=2,BARS=3,FRAME=3,X=30.71}
Anchors~f~3!{Y=52,GROW=2,BARS=3,FRAME=3,X=52}
Anchors~f~4!{Y=53,GROW=2,BARS=3,FRAME=3,X=53}
Anchors~f~5!{Y=54,GROW=2,BARS=3,FRAME=3,X=54}
Anchors~f~6!{Y=55,GROW=2,BARS=3,FRAME=3,X=55}
Anchors~f~7!{Y=75.98,GROW=2,BARS=3,FRAME=3,X=32.92}
Anchors~f~8!{Y=75.31,GROW=2,BARS=3,FRAME=3,X=22.84}
Anchors~f~9!{Y=75.31,GROW=2,BARS=3,FRAME=3,X=30.34}
Anchors~f~10!{Y=59,GROW=2,BARS=3,FRAME=3,X=59}
HeadBar~f~1!{SHOW="true",TEXTURE="HealBot 10",R=0.2,B=0.2,HEIGHT=15,A=0.4,G=0.4,WIDTH=0.95}
HeadBar~d!2~3~4~5~6~7~8~9~10~
HeadText~f~1!{A=0.74,R=1,OFFSET=0,B=1,FONT="Friz Quadrata TT",HEIGHT=10,G=1,OUTLINE=1}
HeadText~d!2~3~4~5~6~7~8~9~10~
HealBar~f~1!{HEIGHT=34,GRPCOLS="false",CMARGIN=2,TEXTURE="Smooth",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=144,RMARGIN=1,OFIX=1,NUMCOLS=2,LOWMANA=2}
HealBar~d!2~3~4~5~6~7~8~9~10~
BarCol~f~1!{BACK=1,BA=0,BOUT=1,DISA=0.1,BR=0.4,HB=0.7,BG=0.4,HR=0.4,HA=1,HG=0.4,ORA=0.4,BB=0.7,HLTH=1}
BarCol~d!2~3~4~5~6~7~8~9~10~
BarIACol~f~1!{AC=3,AB=1,AA=0.78,AR=1,AG=1,IC=4,IB=0.2,IA=0.82,IR=0.2,IG=1}
BarIACol~d!2~3~4~5~6~7~8~9~10~
BarText~f~1!{HLTHONBAR="true",TAGOOR="[ OOR ] ",HMAXCHARS=0,IGNOREONFULL="true",MAXCHARS=0,HOUTLINE=1,CLASSONBAR="false",HLTHTYPE=1,OVERHEAL=1,INCABSORBS=1,INCHEALS=2,HLTHTXTANCHOR=1,FONT="Friz Quadrata TT",NAMEONBAR="true",HOFFSET=0,NUMFORMAT2=1,HHEIGHT=10,NUMFORMAT1=11,HFONT="Friz Quadrata TT",TAGRIP="[ RIP ] ",HEIGHT=10,OFFSET=0,SHOWROLE="true",HALIGN=2,TAGDC="[ DC ] ",CLASSTYPE=1,HOFFSET2=0,ALIGN=2,TAGR="[ R ] ",OUTLINE=1}
BarText~f~2!{HLTHONBAR="true",TAGOOR="[ OOR ] ",HMAXCHARS=0,IGNOREONFULL="true",MAXCHARS=0,HOUTLINE=1,CLASSONBAR="false",NUMFORMAT1=11,OVERHEAL=1,INCABSORBS=1,OFFSET=0,HLTHTXTANCHOR=1,FONT="Friz Quadrata TT",TAGRIP="[ RIP ] ",HOFFSET=0,NUMFORMAT2=1,HHEIGHT=10,TAGDC="[ DC ] ",HFONT="Friz Quadrata TT",NAMEONBAR="true",HEIGHT=10,INCHEALS=2,SHOWROLE="true",HALIGN=2,ALIGN=2,HLTHTYPE=1,CLASSTYPE=1,HOFFSET2=0,TAGR="[ R ] ",OUTLINE=1}
BarText~d!3~4~5~6~7~8~9~10~
BarTextCol~f~1!{NAME=2,NCG=1,HCR=1,HDEBUFF="false",HCDA=0.8,NCB=0,NDEBUFF="false",NCR=1,HCA=1,HCB=0,NCA=1,HCG=1,NCDA=0.8,HLTH=2}
BarTextCol~d!2~3~4~5~6~7~8~9~10~
Icons~f~1!{SHOWBUFF="true",POSITION=2,MAXDICONS=4,FADE="true",I15EN="true",SHOWDIRMOUSE="false",SHOWDIR="false",DOUBLE="true",DSCALE=1,ONBAR=1,SHOWRC="true",SCALE=1,SHOWDEBUFF="true",FADESECS=15,MAXBICONS=8}
Icons~d!2~3~4~5~6~7~8~9~10~
RaidIcon~f~1!{SQUARE="true",CIRCLE="true",DIAMOND="true",SHOW="true",SKULL="true",TRIANGLE="true",STAR="true",CROSS="true",MOON="true"}
RaidIcon~d!2~3~4~5~6~7~8~9~10~
IconText~f~1!{DURWARN=3,HEIGHT=12,SSCNT="false",SCNT="true",DURTHRH=9,FONT="Friz Quadrata TT",SDUR="false",SSDUR="true",OUTLINE=2}
IconText~d!2~3~4~5~6~7~8~9~10~
BarVisibility~f~1!{INCCLASSES=1,ALERTIC=0.98,ALERTOC=0.95,HIDEOOR="false"}
BarVisibility~d!2~3~4~5~6~7~8~9~10~
BarSort~f~1!{SUBORDER=1,OORLAST="false",RAIDORDER=3,SUBPF="true"}
BarSort~d!2~3~4~5~6~7~8~9~10~
BarAggro~f~1!{ALERT=3,ALERTIND=2,R=1,SHOWTEXT="false",G=0,TEXTFORMAT=3,SHOW="true",SHOWTEXTPCT="false",SHOWIND="true",B=0}
BarAggro~d!2~3~4~5~6~7~8~9~10~
AuxBarFrame~f~1!{OFREQ=0.07,OVERLAP=1,OMIN=0.1,OMAX=0.95}
AuxBarFrame~d!2~3~4~5~6~7~8~9~10~
AuxBar^1~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,OTYPE=1,A=1,B=1,G=1}
AuxBar^1~d!2~3~4~5~6~7~8~9~10~
AuxBar^2~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,OTYPE=1,A=1,B=1,G=1}
AuxBar^2~d!2~3~4~5~6~7~8~9~10~
AuxBar^3~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,OTYPE=1,A=1,B=1,G=1}
AuxBar^3~d!2~3~4~5~6~7~8~9~10~
AuxBar^4~f~1!{SIZE=0.98,USE=5,R=1,COLOUR=1,ANCHOR=2,OFFSET=0,DEPTH=2,OTYPE=1,A=1,B=1,G=1}
AuxBar^4~d!2~3~4~5~6~7~8~9~
AuxBar^4~f~10!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=2,OFFSET=0,DEPTH=2,OTYPE=1,A=1,B=1,G=1}
AuxBar^5~f~1!{SIZE=0.98,USE=5,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=2,OTYPE=1,A=1,B=1,G=1}
AuxBar^5~d!2~3~4~5~6~7~8~9~
AuxBar^5~f~10!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=2,OTYPE=1,A=1,B=1,G=1}
AuxBar^6~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,OTYPE=1,A=1,B=1,G=1}
AuxBar^6~d!2~3~4~5~6~7~8~9~10~
AuxBar^7~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,OTYPE=1,A=1,B=1,G=1}
AuxBar^7~d!2~3~4~5~6~7~8~9~10~
AuxBar^8~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,OTYPE=1,A=1,B=1,G=1}
AuxBar^8~d!2~3~4~5~6~7~8~9~10~
AuxBar^9~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,OTYPE=1,A=1,B=1,G=1}
AuxBar^9~d!2~3~4~5~6~7~8~9~10~
Complete!]]

HealBot_ExtraSkinData[6]=[[Skin
Gridlike 40
Author~v!jchap2k of HealBot Website
DuplicateBars~v!false
Chat~t!{EOCOOM="false",EOCOOMV=20,MSG="Casting #s on #n",RESONLY="true",CHAN="",NOTIFY=1}
General~t!{HIDEBOSSF="false",HIDEPTF="false",FLUIDFREQ=10,STICKYSENSITIVITY=30,HIDERAIDF="true",STICKYFRAME="true",FLUIDBARS="false",HIDEPARTYF="true"}
Healing~t!{TONLYFRIEND="false",FEXRAID="false",FOCUSINCOMBAT=2,GROUPPETS="true",SELFPET="false",TEXRAID="false",FONLYFRIEND="false",TARGETINCOMBAT=2}
Protection~t!{COMBAT="false",GENERALMACRO="true",COMBATPARTY="true",CRASH="false",COMBATRAID="true"}
Enemy~t!{INCARENA="true",INCTANKS="true",INCMYTAR="false",HIDE="true",ENEMYTARGETSIZE=40,INCARENAPETS="false",ENEMYTARGET="false",NUMBOSS=2,EXISTSHOWPTAR="false",INCSELF="false",EXISTSHOWBOSS="true",DOUBLEWIDTH="false",EXISTSHOWARENA="true"}
IncludeGroup~f~1!{"true","true","true","true","true","true","true","true"}
IncludeGroup~f~2!{"true","true","true","true","true","true","true","true"}
IncludeGroup~f~3!{"true","true","true","true","true","true","true","true"}
IncludeGroup~f~4!{"true","true","true","true","true","true","true","true"}
IncludeGroup~f~5!{"true","true","true","true","true","true","true","true"}
IncludeGroup~f~6!{"true","true","true","true","true","true","true","true"}
IncludeGroup~f~7!{"true","true","true","true","true","true","true","true"}
IncludeGroup~f~8!{"true","true","true","true","true","true","true","true"}
IncludeGroup~f~9!{"true","true","true","true","true","true","true","true"}
IncludeGroup~f~10!{"true","true","true","true","true","true","true","true"}
FrameAlias~f~1!{SIZE=12,NAME="",R=1,ALIAS="Frame 1",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~2!{SIZE=12,NAME="",R=1,ALIAS="Frame 2",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~3!{SIZE=12,NAME="",R=1,ALIAS="Frame 3",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~4!{SIZE=12,NAME="",R=1,ALIAS="Frame 4",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~d!5~
FrameAlias~f~6!{SIZE=12,NAME="Vehicle",R=1,ALIAS="Vehicle",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~7!{SIZE=12,NAME="Pets",R=1,ALIAS="Pets",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~8!{SIZE=12,NAME="Target",R=1,ALIAS="Target",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~9!{SIZE=12,NAME="Focus",R=1,ALIAS="Focus",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~10!{SIZE=12,NAME="Enemy",R=1,ALIAS="Enemy",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAliasBar~f~1!{A=0.2,WIDTH=0.9,B=0.1,HEIGHT=20,R=0.1,G=0.1,TEXTURE="Skewed"}
FrameAliasBar~d!2~3~4~5~6~7~8~9~10~
Frame~f~1!{BACKR=0.1,SFOFFSETH=0,BORDERR=0.1,BORDERG=0.1,LOCKED="false",OPENSOUND="false",BORDERA=0.04,SFOFFSETV=0,TIPLOC=5,BACKB=0.7,BACKA=0.1,SCALE=1,BORDERB=0.1,BACKG=0.1,AUTOCLOSE="false"}
Frame~f~2!{BACKR=0.1,SFOFFSETH=0,BORDERR=0.1,BORDERG=0.1,LOCKED="false",OPENSOUND="false",BORDERA=0.04,SFOFFSETV=-8,TIPLOC=5,BACKB=0.7,BACKA=0.1,SCALE=1,BORDERB=0.1,BACKG=0.1,AUTOCLOSE="false"}
Frame~f~3!{BACKR=0.1,SFOFFSETH=0,BORDERR=0.1,BORDERG=0.1,LOCKED="false",OPENSOUND="false",BORDERA=0.04,SFOFFSETV=0,TIPLOC=5,BACKB=0.7,BACKA=0.1,SCALE=1,BORDERB=0.1,BACKG=0.1,AUTOCLOSE="false"}
Frame~d!4~5~6~
Frame~f~7!{BACKR=0.1,SFOFFSETH=-8,BORDERR=0.1,BORDERG=0.1,LOCKED="false",OPENSOUND="false",BORDERA=0.04,SFOFFSETV=0,TIPLOC=3,BACKB=0.7,BACKA=0.1,SCALE=1,BORDERB=0.1,BACKG=0.1,AUTOCLOSE="false"}
Frame~f~8!{BACKR=0.1,SFOFFSETH=9,BORDERR=0.1,BORDERG=0.1,LOCKED="false",OPENSOUND="false",BORDERA=0.04,SFOFFSETV=1,TIPLOC=2,BACKB=0.7,BACKA=0.1,SCALE=1,BORDERB=0.1,BACKG=0.1,AUTOCLOSE="false"}
Frame~f~9!{BACKR=0.1,SFOFFSETH=9,BORDERR=0.1,BORDERG=0.1,LOCKED="false",OPENSOUND="false",BORDERA=0.04,SFOFFSETV=0,TIPLOC=2,BACKB=0.7,BACKA=0.1,SCALE=1,BORDERB=0.1,BACKG=0.1,AUTOCLOSE="false"}
Frame~f~10!{BACKR=0.1,SFOFFSETH=0,BORDERR=0.1,BORDERG=0.1,LOCKED="false",OPENSOUND="false",BORDERA=0.04,SFOFFSETV=0,TIPLOC=5,BACKB=0.7,BACKA=0.1,SCALE=1,BORDERB=0.1,BACKG=0.1,AUTOCLOSE="false"}
StickyFrames~f~1!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~f~2!{STUCK="true",STUCKTOPOINT="TOPRIGHT",STUCKTO=1,STUCKPOINT="BOTTOMRIGHT"}
StickyFrames~f~3!{STUCK="true",STUCKTOPOINT="TOPRIGHT",STUCKTO=2,STUCKPOINT="TOPLEFT"}
StickyFrames~f~4!{STUCK="true",STUCKTOPOINT="TOPRIGHT",STUCKTO=1,STUCKPOINT="TOPLEFT"}
StickyFrames~f~5!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~d!6~
StickyFrames~f~7!{STUCK="true",STUCKTOPOINT="TOPRIGHT",STUCKTO=1,STUCKPOINT="TOPLEFT"}
StickyFrames~f~8!{STUCK="true",STUCKTOPOINT="TOPLEFT",STUCKTO=1,STUCKPOINT="TOPRIGHT"}
StickyFrames~f~9!{STUCK="true",STUCKTOPOINT="LEFT",STUCKTO=1,STUCKPOINT="RIGHT"}
StickyFrames~f~10!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
HealGroups~f~1!{FRAME=2,STATE="true",NAME="Main tanks"}
HealGroups~f~2!{FRAME=1,STATE="true",NAME="Self"}
HealGroups~f~3!{FRAME=3,STATE="true",NAME="Private List"}
HealGroups~f~4!{FRAME=1,STATE="false",NAME="Healers"}
HealGroups~f~5!{FRAME=1,STATE="true",NAME="Group"}
HealGroups~f~6!{FRAME=4,STATE="true",NAME="Raid"}
HealGroups~f~7!{FRAME=6,STATE="false",NAME="Vehicle"}
HealGroups~f~8!{FRAME=7,STATE="false",NAME="Pets"}
HealGroups~f~9!{FRAME=8,STATE="false",NAME="Target"}
HealGroups~f~10!{FRAME=9,STATE="false",NAME="Focus"}
HealGroups~f~11!{FRAME=10,STATE="false",NAME="Enemy"}
Anchors~f~1!{Y=70.19,GROW=2,BARS=1,FRAME=1,X=8.31}
Anchors~f~2!{Y=69.52,GROW=2,BARS=1,FRAME=4,X=10.58}
Anchors~f~3!{Y=74.43,GROW=2,BARS=1,FRAME=1,X=11.94}
Anchors~f~4!{Y=70.19,GROW=2,BARS=1,FRAME=1,X=10.58}
Anchors~f~5!{Y=54,GROW=2,BARS=1,FRAME=1,X=54}
Anchors~f~6!{Y=55,GROW=2,BARS=1,FRAME=1,X=55}
Anchors~f~7!{Y=61.79,GROW=2,BARS=1,FRAME=1,X=38.78}
Anchors~f~8!{Y=64.1,GROW=2,BARS=1,FRAME=1,X=74.2}
Anchors~f~9!{Y=53.8,GROW=2,BARS=1,FRAME=1,X=74.2}
Anchors~f~10!{Y=59,GROW=2,BARS=1,FRAME=1,X=59}
HeadBar~f~1!{SHOW="true",WIDTH=0.25,B=0,R=0,HEIGHT=5,A=0,G=0,TEXTURE="HealBot 05"}
HeadBar~f~2!{SHOW="false",WIDTH=0.9,B=0.1,R=0.1,HEIGHT=20,A=0.2,G=0.1,TEXTURE="Skewed"}
HeadBar~d!3~4~5~6~7~8~9~10~
HeadText~f~1!{A=0.4,B=0.878,OFFSET=-4,R=1,FONT="Friz Quadrata TT",HEIGHT=7,G=1,OUTLINE=1}
HeadText~f~2!{A=0.4,B=0.1,OFFSET=0,R=1,FONT="Friz Quadrata TT",HEIGHT=9,G=1,OUTLINE=1}
HeadText~d!3~4~5~6~7~8~9~10~
HealBar~f~1!{HEIGHT=38,GRPCOLS="true",CMARGIN=0,TEXTURE="HealBot 10",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=2,NUMCOLS=1,OFIX=2,RMARGIN=0,WIDTH=55}
HealBar~f~2!{HEIGHT=38,GRPCOLS="false",CMARGIN=0,TEXTURE="HealBot 10",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=1,NUMCOLS=5,OFIX=2,RMARGIN=0,WIDTH=55}
HealBar~f~3!{HEIGHT=38,GRPCOLS="false",CMARGIN=0,TEXTURE="HealBot 10",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=1,NUMCOLS=7,OFIX=2,RMARGIN=0,WIDTH=55}
HealBar~f~4!{HEIGHT=38,GRPCOLS="false",CMARGIN=0,TEXTURE="HealBot 10",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=1,NUMCOLS=5,OFIX=2,RMARGIN=0,WIDTH=55}
HealBar~f~5!{HEIGHT=38,GRPCOLS="true",CMARGIN=0,TEXTURE="HealBot 10",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=1,NUMCOLS=1,OFIX=1,RMARGIN=0,WIDTH=55}
HealBar~d!6~7~8~9~10~
BarCol~f~1!{BACK=3,BA=0.65,BOUT=0,DISA=1,BR=0.094,HB=0,BB=0,BG=0.655,HA=1,HG=0,ORA=1,HR=0,HLTH=3}
BarCol~d!2~3~4~5~6~7~8~9~10~
BarIACol~f~1!{AC=3,AB=1,AA=0.5,AR=1,AG=1,IC=4,IB=0.2,IA=0.9,IR=0.2,IG=0.8}
BarIACol~d!2~3~4~5~6~7~8~9~10~
BarText~f~1!{HLTHONBAR="true",TAGOOR="",HMAXCHARS=0,IGNOREONFULL="false",MAXCHARS=8,HOUTLINE=1,CLASSONBAR="false",NUMFORMAT1=11,OVERHEAL=1,INCABSORBS=2,INCHEALS=2,HLTHTXTANCHOR=1,FONT="Friz Quadrata TT",NAMEONBAR="true",HOFFSET=0,NUMFORMAT2=1,HHEIGHT=10,TAGDC="[DC]",HFONT="Friz Quadrata TT",TAGRIP="[RIP]",HEIGHT=7,OFFSET=-2,SHOWROLE="true",HALIGN=2,ALIGN=1,HLTHTYPE=3,CLASSTYPE=1,HOFFSET2=0,TAGR="",OUTLINE=1}
BarText~f~2!{HLTHONBAR="true",TAGOOR="",OUTLINE=1,IGNOREONFULL="false",MAXCHARS=8,OVERHEAL=1,HMAXCHARS=0,HOUTLINE=1,CLASSTYPE=1,INCHEALS=2,HLTHTXTANCHOR=1,FONT="Friz Quadrata TT",HLTHTYPE=3,CLASSONBAR="false",NUMFORMAT2=1,HFONT="Friz Quadrata TT",NUMFORMAT1=11,TAGRIP="[RIP]",NAMEONBAR="true",HEIGHT=7,OFFSET=-2,SHOWROLE="true",HALIGN=2,TAGDC="[DC]",HHEIGHT=10,INCABSORBS=2,HOFFSET2=0,ALIGN=1,TAGR="",HOFFSET=0}
BarText~d!3~4~5~6~7~8~9~10~
BarTextCol~f~1!{NAME=2,NCG=1,HCR=0.937,HDEBUFF="false",HCDA=0.7,NCB=0.937,NDEBUFF="false",NCR=0.937,HCA=1,HCB=0.937,NCA=1,HCG=1,NCDA=0.7,HLTH=2}
BarTextCol~d!2~3~4~5~6~7~8~9~10~
Icons~f~1!{SHOWBUFF="true",SHOWDEBUFF="true",FADESECS=15,MAXDICONS=2,POSITION=2,FADE="true",SHOWDIR="false",SHOWDIRMOUSE="false",DSCALE=1,ONBAR=1,SHOWRC="true",SCALE=0.75,I15EN="true",DOUBLE="true",MAXBICONS=4}
Icons~f~2!{SHOWBUFF="true",SHOWDEBUFF="true",FADESECS=15,MAXDICONS=4,POSITION=2,FADE="true",SHOWDIR="false",SHOWDIRMOUSE="false",DSCALE=1,ONBAR=1,SHOWRC="true",SCALE=0.75,I15EN="true",DOUBLE="true",MAXBICONS=8}
Icons~f~3!{SHOWBUFF="true",SHOWDEBUFF="true",FADESECS=15,MAXDICONS=3,POSITION=2,FADE="true",SHOWDIR="false",SHOWDIRMOUSE="false",DSCALE=1,ONBAR=1,SHOWRC="true",SCALE=0.75,I15EN="true",DOUBLE="true",MAXBICONS=8}
Icons~d!4~5~
Icons~f~6!{SHOWBUFF="true",SHOWDEBUFF="true",FADESECS=15,MAXDICONS=3,POSITION=2,FADE="true",SHOWDIR="true",SHOWDIRMOUSE="false",DSCALE=1,ONBAR=1,SHOWRC="true",SCALE=0.75,I15EN="true",DOUBLE="true",MAXBICONS=8}
Icons~f~7!{SHOWBUFF="true",SHOWDEBUFF="true",FADESECS=15,MAXDICONS=2,POSITION=2,FADE="true",SHOWDIR="true",SHOWDIRMOUSE="false",DSCALE=1,ONBAR=1,SHOWRC="true",SCALE=0.75,I15EN="true",DOUBLE="true",MAXBICONS=4}
Icons~f~8!{SHOWBUFF="true",SHOWDEBUFF="true",FADESECS=15,MAXDICONS=2,POSITION=2,FADE="true",SHOWDIR="true",SHOWDIRMOUSE="false",DSCALE=1,ONBAR=1,SHOWRC="true",SCALE=0.75,I15EN="true",DOUBLE="true",MAXBICONS=6}
Icons~d!9~
Icons~f~10!{SHOWBUFF="true",SHOWDEBUFF="true",FADESECS=15,MAXDICONS=3,POSITION=2,FADE="true",SHOWDIR="true",SHOWDIRMOUSE="false",DSCALE=1,ONBAR=1,SHOWRC="true",SCALE=0.75,I15EN="true",DOUBLE="true",MAXBICONS=8}
RaidIcon~f~1!{SQUARE="true",CIRCLE="true",DIAMOND="true",SHOW="true",MOON="true",TRIANGLE="true",STAR="true",SKULL="true",CROSS="true"}
RaidIcon~d!2~3~4~5~6~7~8~9~10~
IconText~f~1!{DURWARN=3,HEIGHT=10,SSCNT="false",SCNT="true",DURTHRH=9,FONT="Friz Quadrata TT",SDUR="false",SSDUR="true",OUTLINE=2}
IconText~d!2~3~4~5~6~7~8~9~10~
BarVisibility~f~1!{INCCLASSES=1,ALERTIC=0.9,ALERTOC=0.85,HIDEOOR="true"}
BarVisibility~f~2!{INCCLASSES=1,ALERTIC=0.95,ALERTOC=0.85,HIDEOOR="false"}
BarVisibility~d!3~4~5~
BarVisibility~f~6!{INCCLASSES=1,ALERTIC=0.85,ALERTOC=0.7,HIDEOOR="false"}
BarVisibility~d!7~
BarVisibility~f~8!{INCCLASSES=1,ALERTIC=0.95,ALERTOC=0.85,HIDEOOR="false"}
BarVisibility~d!9~10~
BarSort~f~1!{SUBORDER=5,OORLAST="false",RAIDORDER=3,SUBPF="true"}
BarSort~f~2!{SUBORDER=1,OORLAST="false",RAIDORDER=3,SUBPF="true"}
BarSort~d!3~
BarSort~f~4!{SUBORDER=5,OORLAST="false",RAIDORDER=2,SUBPF="false"}
BarSort~f~5!{SUBORDER=1,OORLAST="false",RAIDORDER=3,SUBPF="true"}
BarSort~d!6~7~8~9~10~
BarAggro~f~1!{B=0,SHOWIND="false",G=0,TEXTFORMAT=3,SHOW="false",SHOWTEXTPCT="false",SHOWTEXT="false",R=1,ALERTIND=2,ALERT=3}
BarAggro~f~2!{B=0,SHOWIND="true",G=0,TEXTFORMAT=3,SHOW="false",SHOWTEXTPCT="true",SHOWTEXT="false",R=1,ALERTIND=2,ALERT=3}
BarAggro~f~3!{B=0,SHOWIND="true",G=0,TEXTFORMAT=3,SHOW="true",SHOWTEXTPCT="true",SHOWTEXT="false",R=1,ALERTIND=2,ALERT=3}
BarAggro~f~4!{B=0,SHOWIND="true",G=0,TEXTFORMAT=3,SHOW="false",SHOWTEXTPCT="true",SHOWTEXT="false",R=1,ALERTIND=2,ALERT=3}
BarAggro~f~5!{B=0,SHOWIND="true",G=0,TEXTFORMAT=3,SHOW="true",SHOWTEXTPCT="true",SHOWTEXT="false",R=1,ALERTIND=2,ALERT=3}
BarAggro~d!6~7~8~9~10~
AuxBarFrame~f~1!{OFREQ=0.07,OVERLAP=1,OMIN=0.1,OMAX=0.95}
AuxBarFrame~d!2~3~4~5~6~7~8~9~10~
AuxBar^1~f~1!{SIZE=0.98,USE=4,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,OTYPE=1,A=1,B=1,G=1}
AuxBar^1~d!2~3~4~5~6~7~8~9~10~
AuxBar^2~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,OTYPE=1,A=1,B=1,G=1}
AuxBar^2~d!2~3~4~5~6~7~8~9~10~
AuxBar^3~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,OTYPE=1,A=1,B=1,G=1}
AuxBar^3~d!2~3~4~5~6~7~8~9~10~
AuxBar^4~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,OTYPE=1,A=1,B=1,G=1}
AuxBar^4~d!2~3~4~5~6~7~8~9~10~
AuxBar^5~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,OTYPE=1,A=1,B=1,G=1}
AuxBar^5~d!2~3~4~5~6~7~8~9~10~
AuxBar^6~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,OTYPE=1,A=1,B=1,G=1}
AuxBar^6~d!2~3~4~5~6~7~8~9~10~
AuxBar^7~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,OTYPE=1,A=1,B=1,G=1}
AuxBar^7~d!2~3~4~5~6~7~8~9~10~
AuxBar^8~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,OTYPE=1,A=1,B=1,G=1}
AuxBar^8~d!2~3~4~5~6~7~8~9~10~
AuxBar^9~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,OTYPE=1,A=1,B=1,G=1}
AuxBar^9~d!2~3~4~5~6~7~8~9~10~
Complete!]]

HealBot_ExtraSkinData[7]=[[Skin
Full 25
Author~v!Monti of Terenas
DuplicateBars~v!true
Chat~t!{EOCOOM="false",EOCOOMV=20,MSG="Casting #s on #n",RESONLY="true",NOTIFY=1}
General~t!{FLUIDFREQ=3,HIDEPTF="false",HIDEBOSSF="true",STICKYFRAME="true",STICKYSENSITIVITY=40,HIDERAIDF="true",FLUIDBARS="false",HIDEPARTYF="false"}
Healing~t!{TONLYFRIEND="false",SELFPET="false",FOCUSINCOMBAT=2,GROUPPETS="true",TARGETINCOMBAT=1,TEXRAID="false",FONLYFRIEND="false",FEXRAID="false"}
Protection~t!{COMBAT="false",GENERALMACRO="true",COMBATPARTY="true",CRASH="false",COMBATRAID="true"}
Enemy~t!{INCARENA="false",INCTANKS="true",INCMYTAR="false",ENEMYTARGET="true",INCARENAPETS="false",ENEMYTARGETSIZE=70,HIDE="true",NUMBOSS=4,EXISTSHOWPTAR="false",INCSELF="false",EXISTSHOWBOSS="true",DOUBLEWIDTH="false",EXISTSHOWARENA="true"}
IncludeGroup~f~1!{"true","true","true","true","true","true","true","true"}
IncludeGroup~f~2!{"true","true","true","true","true","true","true","true"}
IncludeGroup~f~3!{"true","true","true","true","true","true","true","true"}
IncludeGroup~f~4!{"true","true","true","true","true","true","true","true"}
IncludeGroup~f~5!{"true","true","true","true","true","true","true","true"}
IncludeGroup~f~6!{"true","true","true","true","true","true","true","true"}
IncludeGroup~f~7!{"true","true","true","true","true","true","true","true"}
IncludeGroup~f~8!{"true","true","true","true","true","true","true","true"}
IncludeGroup~f~9!{"true","true","true","true","true","true","true","true"}
IncludeGroup~f~10!{"true","true","true","true","true","true","true","true"}
FrameAlias~f~1!{A=1,NAME="",R=1,ALIAS="Tanks",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~2!{A=1,NAME="",R=1,ALIAS="Raid",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~3!{SIZE=12,NAME="Healers",R=1,ALIAS="Healers",G=1,SHOW="true",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~4!{SIZE=12,NAME="",R=1,G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~d!5~
FrameAlias~f~6!{SIZE=12,NAME="Vehicle",R=1,ALIAS="Vehicle",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~7!{SIZE=12,NAME="Pets",R=1,ALIAS="Pets",G=1,SHOW="true",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~8!{SIZE=12,NAME="Target",R=1,ALIAS="Target",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~9!{SIZE=12,NAME="Focus",R=1,ALIAS="Focus",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~10!{SIZE=12,NAME="Enemy",R=1,ALIAS="Enemy",G=0,SHOW="true",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=0,OUTLINE=1}
FrameAliasBar~f~1!{A=0.2,WIDTH=0.9,B=0.1,HEIGHT=20,R=0.1,G=0.1,TEXTURE="Skewed"}
FrameAliasBar~d!2~
FrameAliasBar~f~3!{A=0.2,WIDTH=0.9,B=0.1,HEIGHT=15,R=0.1,G=0.1,TEXTURE="Skewed"}
FrameAliasBar~f~4!{A=0.2,WIDTH=0.9,B=0.1,HEIGHT=20,R=0.1,G=0.1,TEXTURE="Skewed"}
FrameAliasBar~d!5~6~
FrameAliasBar~f~7!{A=0,WIDTH=0.92,B=1,HEIGHT=20,R=1,G=1,TEXTURE="Aluminium"}
FrameAliasBar~f~8!{A=0.2,WIDTH=0.9,B=0.1,HEIGHT=20,R=0.1,G=0.1,TEXTURE="Skewed"}
FrameAliasBar~d!9~
FrameAliasBar~f~10!{A=0.2,WIDTH=0.9,B=0.1,HEIGHT=15,R=0.1,G=0.1,TEXTURE="Skewed"}
Frame~f~1!{SFOFFSETH=0,BORDERR=0.1,BACKR=0.1,BORDERG=0.1,LOCKED="false",OPENSOUND="false",BORDERA=0.04,SFOFFSETV=0,AUTOCLOSE="false",BACKB=0.7,BACKA=0.1,SCALE=1,BORDERB=0.1,TIPLOC=1,BACKG=0.1}
Frame~f~2!{SFOFFSETH=8,BORDERR=0.1,BACKR=0.102,BORDERG=0.1,LOCKED="true",OPENSOUND="false",BORDERA=0.04,SFOFFSETV=0,AUTOCLOSE="false",BACKB=0.702,BACKA=0,SCALE=1,BORDERB=0.1,TIPLOC=1,BACKG=0.102}
Frame~f~3!{SFOFFSETH=0,BORDERR=0.1,BACKR=0.1,BORDERG=0.1,LOCKED="false",OPENSOUND="false",BORDERA=0.04,SFOFFSETV=4,AUTOCLOSE="false",BACKB=0.7,BACKA=0.1,SCALE=1,BORDERB=0.1,TIPLOC=1,BACKG=0.1}
Frame~f~4!{SFOFFSETH=0,BORDERR=0.1,BACKR=0.1,BORDERG=0.1,LOCKED="false",OPENSOUND="false",BORDERA=0.04,SFOFFSETV=0,AUTOCLOSE="false",BACKB=0.7,BACKA=0.1,SCALE=1,BORDERB=0.1,TIPLOC=5,BACKG=0.1}
Frame~d!5~6~
Frame~f~7!{SFOFFSETH=-4,BORDERR=0.1,BACKR=0.102,BORDERG=0.1,LOCKED="true",OPENSOUND="false",BORDERA=0.04,SFOFFSETV=7,AUTOCLOSE="false",BACKB=0.702,BACKA=0,SCALE=1,BORDERB=0.1,TIPLOC=1,BACKG=0.102}
Frame~f~8!{SFOFFSETH=9,BORDERR=0.1,BACKR=0.1,BORDERG=0.1,LOCKED="true",OPENSOUND="false",BORDERA=0.04,SFOFFSETV=1,AUTOCLOSE="false",BACKB=0.7,BACKA=0.1,SCALE=1,BORDERB=0.1,TIPLOC=2,BACKG=0.1}
Frame~f~9!{SFOFFSETH=9,BORDERR=0.1,BACKR=0.1,BORDERG=0.1,LOCKED="true",OPENSOUND="false",BORDERA=0.04,SFOFFSETV=0,AUTOCLOSE="false",BACKB=0.7,BACKA=0.1,SCALE=1,BORDERB=0.1,TIPLOC=2,BACKG=0.1}
Frame~f~10!{SFOFFSETH=0,BORDERR=0.1,BACKR=0.1,BORDERG=0.1,LOCKED="false",OPENSOUND="false",BORDERA=0.04,SFOFFSETV=0,AUTOCLOSE="false",BACKB=0.7,BACKA=0.1,SCALE=1,BORDERB=0.1,TIPLOC=1,BACKG=0.1}
StickyFrames~f~1!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~f~2!{STUCK="true",STUCKTOPOINT="TOPLEFT",STUCKTO=1,STUCKPOINT="TOPRIGHT"}
StickyFrames~f~3!{STUCK="true",STUCKTOPOINT="BOTTOMRIGHT",STUCKTO=1,STUCKPOINT="TOPRIGHT"}
StickyFrames~f~4!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~d!5~6~
StickyFrames~f~7!{STUCK="true",STUCKTOPOINT="BOTTOMLEFT",STUCKTO=2,STUCKPOINT="TOPLEFT"}
StickyFrames~f~8!{STUCK="true",STUCKTOPOINT="TOPLEFT",STUCKTO=2,STUCKPOINT="TOPRIGHT"}
StickyFrames~f~9!{STUCK="true",STUCKTOPOINT="BOTTOMLEFT",STUCKTO=2,STUCKPOINT="BOTTOMRIGHT"}
StickyFrames~f~10!{STUCK="true",STUCKTOPOINT="TOPRIGHT",STUCKTO=1,STUCKPOINT="BOTTOMRIGHT"}
HealGroups~f~1!{FRAME=1,STATE="true",NAME="Main tanks"}
HealGroups~f~2!{FRAME=3,STATE="true",NAME="Healers"}
HealGroups~f~3!{FRAME=2,STATE="true",NAME="Raid"}
HealGroups~f~4!{FRAME=3,STATE="false",NAME="Self"}
HealGroups~f~5!{FRAME=2,STATE="false",NAME="Group"}
HealGroups~f~6!{FRAME=2,STATE="false",NAME="Private List"}
HealGroups~f~7!{FRAME=6,STATE="false",NAME="Vehicle"}
HealGroups~f~8!{FRAME=7,STATE="true",NAME="Pets"}
HealGroups~f~9!{FRAME=8,STATE="true",NAME="Target"}
HealGroups~f~10!{FRAME=9,STATE="false",NAME="Focus"}
HealGroups~f~11!{FRAME=10,STATE="true",NAME="Enemy"}
Anchors~f~1!{Y=66.35,GROW=2,BARS=3,FRAME=3,X=94.48}
Anchors~f~2!{Y=66.35,GROW=2,BARS=1,FRAME=3,X=89.39}
Anchors~f~3!{Y=57.68,GROW=2,BARS=1,FRAME=3,X=94.48}
Anchors~f~4!{Y=53,GROW=2,BARS=1,FRAME=1,X=53}
Anchors~f~5!{Y=54,GROW=2,BARS=1,FRAME=1,X=54}
Anchors~f~6!{Y=55,GROW=2,BARS=1,FRAME=1,X=55}
Anchors~f~7!{Y=60.35,GROW=2,BARS=2,FRAME=1,X=86.04}
Anchors~f~8!{Y=66.43,GROW=2,BARS=1,FRAME=3,X=86.49}
Anchors~f~9!{Y=60.92,GROW=2,BARS=1,FRAME=4,X=88.69}
Anchors~f~10!{Y=67.57,GROW=2,BARS=2,FRAME=4,X=95.52}
HeadBar~f~1!{SHOW="true",WIDTH=1,B=1,R=1,HEIGHT=15,A=0,G=1,TEXTURE="Aluminium"}
HeadBar~d!2~
HeadBar~f~3!{SHOW="false",WIDTH=0.9,B=0.102,R=0.102,HEIGHT=10,A=0,G=0.102,TEXTURE="Skewed"}
HeadBar~f~4!{SHOW="false",WIDTH=0.9,B=0.1,R=0.1,HEIGHT=20,A=0.2,G=0.1,TEXTURE="Skewed"}
HeadBar~d!5~6~
HeadBar~f~7!{SHOW="false",WIDTH=0.5,B=0.102,R=0.102,HEIGHT=20,A=0,G=0.102,TEXTURE="Aluminium"}
HeadBar~f~8!{SHOW="true",WIDTH=0.9,B=0.102,R=0.102,HEIGHT=15,A=0,G=0.102,TEXTURE="Skewed"}
HeadBar~d!9~
HeadBar~f~10!{SHOW="false",WIDTH=0.9,B=0.102,R=0.102,HEIGHT=20,A=0,G=0.102,TEXTURE="Skewed"}
HeadText~f~1!{A=1,B=1,OFFSET=0,R=1,FONT="Friz Quadrata TT",HEIGHT=11,G=1,OUTLINE=1}
HeadText~d!2~
HeadText~f~3!{A=0.4,B=0.1,OFFSET=0,R=1,FONT="Friz Quadrata TT",HEIGHT=9,G=1,OUTLINE=1}
HeadText~d!4~5~6~
HeadText~f~7!{A=1,B=1,OFFSET=0,R=1,FONT="Friz Quadrata TT",HEIGHT=11,G=1,OUTLINE=1}
HeadText~f~8!{A=1,B=0.957,OFFSET=0,R=0.957,FONT="Friz Quadrata TT",HEIGHT=11,G=0.957,OUTLINE=1}
HeadText~f~9!{A=1,B=1,OFFSET=0,R=1,FONT="Friz Quadrata TT",HEIGHT=11,G=1,OUTLINE=1}
HeadText~f~10!{A=0.4,B=0.1,OFFSET=0,R=1,FONT="Friz Quadrata TT",HEIGHT=9,G=1,OUTLINE=1}
HealBar~f~1!{HEIGHT=32,GRPCOLS="false",CMARGIN=0,TEXTURE="Smooth v2",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=1,NUMCOLS=1,OFIX=1,RMARGIN=0,WIDTH=142}
HealBar~f~2!{HEIGHT=32,GRPCOLS="false",CMARGIN=0,TEXTURE="Smooth v2",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=1,NUMCOLS=1,OFIX=1,RMARGIN=0,WIDTH=80}
HealBar~f~3!{HEIGHT=32,GRPCOLS="false",CMARGIN=0,TEXTURE="Smooth v2",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=1,NUMCOLS=2,OFIX=1,RMARGIN=0,WIDTH=70}
HealBar~f~4!{HEIGHT=32,GRPCOLS="false",CMARGIN=0,TEXTURE="Charcoal",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=1,NUMCOLS=1,OFIX=1,RMARGIN=0,WIDTH=80}
HealBar~d!5~6~
HealBar~f~7!{HEIGHT=28,GRPCOLS="false",CMARGIN=0,TEXTURE="Smooth v2",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=1,NUMCOLS=5,OFIX=1,RMARGIN=0,WIDTH=80}
HealBar~f~8!{HEIGHT=32,GRPCOLS="false",CMARGIN=0,TEXTURE="Charcoal",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=1,NUMCOLS=1,OFIX=1,RMARGIN=0,WIDTH=80}
HealBar~d!9~
HealBar~f~10!{HEIGHT=32,GRPCOLS="false",CMARGIN=0,TEXTURE="Smooth v2",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=1,NUMCOLS=3,OFIX=1,RMARGIN=0,WIDTH=184}
BarCol~f~1!{BACK=1,BA=0.25,BB=0.4,DISA=0.1,BR=0.2,HB=0.4,BG=0.4,BOUT=1,HA=0.95,HG=0.4,ORA=0.4,HR=0.2,HLTH=2}
BarCol~d!2~
BarCol~f~3!{BACK=1,BA=0.25,BB=0.4,DISA=0.12,BR=0.2,HB=0.4,BG=0.4,BOUT=1,HA=0.95,HG=0.4,ORA=0.3,HR=0.2,HLTH=2}
BarCol~f~4!{BACK=2,BA=0.05,BB=0.4,DISA=0.12,BR=0.2,HB=0.4,BG=0.4,BOUT=1,HA=0.95,HG=0.4,ORA=0.3,HR=0.2,HLTH=2}
BarCol~d!5~6~
BarCol~f~7!{BACK=1,BA=0.25,BB=0.4,DISA=0.1,BR=0.2,HB=0.4,BG=0.4,BOUT=1,HA=0.95,HG=0.4,ORA=0.4,HR=0.2,HLTH=2}
BarCol~f~8!{BACK=2,BA=0.05,BB=0.4,DISA=0.12,BR=0.2,HB=0.4,BG=0.4,BOUT=1,HA=0.95,HG=0.4,ORA=0.3,HR=0.2,HLTH=1}
BarCol~d!9~
BarCol~f~10!{BACK=2,BA=0.05,BB=0.4,DISA=0.12,BR=0.2,HB=0.051,BG=0.4,BOUT=1,HA=0.95,HG=0.102,ORA=0.3,HR=0.678,HLTH=3}
BarIACol~f~1!{AC=4,AB=0.8,AA=0.5,AR=0.2,AG=0.8,IC=2,IB=1,IA=0.58,IR=1,IG=1}
BarIACol~d!2~3~
BarIACol~f~4!{AC=3,AB=1,AA=0.5,AR=1,AG=1,IC=2,IB=0.2,IA=0.58,IR=0.2,IG=0.8}
BarIACol~d!5~6~
BarIACol~f~7!{AC=4,AB=0.8,AA=0.5,AR=0.2,AG=0.8,IC=2,IB=1,IA=0.58,IR=1,IG=1}
BarIACol~f~8!{AC=3,AB=1,AA=0.5,AR=1,AG=1,IC=2,IB=0.2,IA=0.58,IR=0.2,IG=0.8}
BarIACol~d!9~10~
BarText~f~1!{HLTHONBAR="true",TAGOOR="OOR-",HOUTLINE=1,MAXCHARS=10,CLASSONBAR="false",OUTLINE=1,OVERHEAL=2,HFONT="Friz Quadrata TT",INCHEALS=2,HLTHTXTANCHOR=1,HLTHTYPE=1,HMAXCHARS=0,INCABSORBS=2,NUMFORMAT2=1,FONT="Friz Quadrata TT",NUMFORMAT1=11,OFFSET=0,NAMEONBAR="true",HEIGHT=11,TAGRIP="",SHOWROLE="true",HALIGN=2,TAGDC="DC-",HHEIGHT=12,IGNOREONFULL="true",CLASSTYPE=1,HOFFSET2=0,ALIGN=2,TAGR="",HOFFSET=0}
BarText~f~2!{HLTHONBAR="true",TAGOOR="OOR-",HOUTLINE=1,MAXCHARS=0,CLASSONBAR="false",OUTLINE=1,OVERHEAL=2,HFONT="Friz Quadrata TT",INCHEALS=2,HLTHTXTANCHOR=1,HLTHTYPE=1,HMAXCHARS=0,INCABSORBS=2,NUMFORMAT2=1,FONT="Friz Quadrata TT",NUMFORMAT1=11,OFFSET=0,NAMEONBAR="true",HEIGHT=10,TAGRIP="",SHOWROLE="true",HALIGN=2,TAGDC="DC-",HHEIGHT=12,IGNOREONFULL="true",CLASSTYPE=1,HOFFSET2=0,ALIGN=2,TAGR="",HOFFSET=0}
BarText~d!3~
BarText~f~4!{HLTHONBAR="true",TAGOOR="[ OOR ] ",HOUTLINE=1,MAXCHARS=0,CLASSONBAR="false",OUTLINE=1,OVERHEAL=2,HFONT="Friz Quadrata TT",INCHEALS=2,HLTHTXTANCHOR=1,HLTHTYPE=1,HMAXCHARS=0,INCABSORBS=2,NUMFORMAT2=1,FONT="Friz Quadrata TT",NUMFORMAT1=11,OFFSET=0,NAMEONBAR="true",HEIGHT=10,TAGRIP="[ RIP ] ",SHOWROLE="true",HALIGN=2,TAGDC="[ DC ] ",HHEIGHT=12,IGNOREONFULL="true",CLASSTYPE=1,HOFFSET2=0,ALIGN=2,TAGR="[ R ] ",HOFFSET=0}
BarText~d!5~6~
BarText~f~7!{HLTHONBAR="true",TAGOOR="OOR-",HOUTLINE=1,MAXCHARS=8,CLASSONBAR="false",OUTLINE=1,OVERHEAL=2,HFONT="Friz Quadrata TT",INCHEALS=2,HLTHTXTANCHOR=1,HLTHTYPE=1,HMAXCHARS=0,INCABSORBS=2,NUMFORMAT2=1,FONT="Friz Quadrata TT",NUMFORMAT1=11,OFFSET=0,NAMEONBAR="true",HEIGHT=10,TAGRIP="",SHOWROLE="true",HALIGN=2,TAGDC="",HHEIGHT=12,IGNOREONFULL="true",CLASSTYPE=1,HOFFSET2=0,ALIGN=2,TAGR="",HOFFSET=0}
BarText~f~8!{HLTHONBAR="true",TAGOOR="",HOUTLINE=1,MAXCHARS=0,CLASSONBAR="false",OUTLINE=1,OVERHEAL=2,HFONT="Friz Quadrata TT",INCHEALS=2,HLTHTXTANCHOR=1,HLTHTYPE=1,HMAXCHARS=0,INCABSORBS=2,NUMFORMAT2=1,FONT="Friz Quadrata TT",NUMFORMAT1=11,OFFSET=0,NAMEONBAR="true",HEIGHT=10,TAGRIP="",SHOWROLE="true",HALIGN=2,TAGDC="",HHEIGHT=12,IGNOREONFULL="true",CLASSTYPE=1,HOFFSET2=0,ALIGN=2,TAGR="",HOFFSET=0}
BarText~d!9~
BarText~f~10!{HLTHONBAR="true",TAGOOR="OOR-",HOUTLINE=1,MAXCHARS=0,CLASSONBAR="false",OUTLINE=1,OVERHEAL=2,HFONT="Friz Quadrata TT",INCHEALS=2,HLTHTXTANCHOR=1,HLTHTYPE=1,HMAXCHARS=0,INCABSORBS=2,NUMFORMAT2=1,FONT="Friz Quadrata TT",NUMFORMAT1=11,OFFSET=0,NAMEONBAR="true",HEIGHT=10,TAGRIP="",SHOWROLE="true",HALIGN=2,TAGDC="",HHEIGHT=12,IGNOREONFULL="true",CLASSTYPE=1,HOFFSET2=0,ALIGN=2,TAGR="",HOFFSET=0}
BarTextCol~f~1!{NAME=2,NDEBUFF="false",HLTH=1,NCDA=0.7,NCB=0,HCA=1,HCB=0,NCA=1,HCR=1,NCG=1,NCR=1,HDEBUFF="false",HCG=1,HCDA=0.7}
BarTextCol~d!2~3~4~5~6~7~8~9~10~
Icons~f~1!{SHOWBUFF="true",POSITION=2,I15EN="true",FADESECS=15,MAXDICONS=2,SHOWDEBUFF="true",ONBAR=1,SHOWDIRMOUSE="false",DSCALE=1,SHOWDIR="false",SHOWRC="true",SCALE=1,FADE="false",DOUBLE="true",MAXBICONS=4}
Icons~f~2!{SHOWBUFF="true",POSITION=2,I15EN="true",FADESECS=15,MAXDICONS=4,SHOWDEBUFF="true",ONBAR=1,SHOWDIRMOUSE="false",DSCALE=1,SHOWDIR="false",SHOWRC="true",SCALE=1,FADE="false",DOUBLE="true",MAXBICONS=8}
Icons~f~3!{SHOWBUFF="true",POSITION=2,I15EN="true",FADESECS=15,MAXDICONS=3,SHOWDEBUFF="true",ONBAR=1,SHOWDIRMOUSE="false",DSCALE=1,SHOWDIR="false",SHOWRC="true",SCALE=1,FADE="false",DOUBLE="true",MAXBICONS=8}
Icons~d!4~5~6~
Icons~f~7!{SHOWBUFF="true",POSITION=2,I15EN="true",FADESECS=15,MAXDICONS=2,SHOWDEBUFF="true",ONBAR=1,SHOWDIRMOUSE="false",DSCALE=1,SHOWDIR="false",SHOWRC="true",SCALE=1,FADE="false",DOUBLE="true",MAXBICONS=4}
Icons~f~8!{SHOWBUFF="true",POSITION=2,I15EN="true",FADESECS=15,MAXDICONS=2,SHOWDEBUFF="true",ONBAR=1,SHOWDIRMOUSE="false",DSCALE=1,SHOWDIR="false",SHOWRC="true",SCALE=1,FADE="false",DOUBLE="true",MAXBICONS=6}
Icons~d!9~
Icons~f~10!{SHOWBUFF="true",POSITION=2,I15EN="true",FADESECS=15,MAXDICONS=3,SHOWDEBUFF="true",ONBAR=1,SHOWDIRMOUSE="false",DSCALE=1,SHOWDIR="false",SHOWRC="true",SCALE=1,FADE="false",DOUBLE="true",MAXBICONS=8}
RaidIcon~f~1!{SQUARE="true",CIRCLE="true",DIAMOND="true",SHOW="true",SKULL="true",TRIANGLE="true",STAR="true",MOON="true",CROSS="true"}
RaidIcon~d!2~3~4~5~6~7~8~9~10~
IconText~f~1!{SDUR="false",HEIGHT=10,SSCNT="false",SCNT="true",DURTHRH=9,FONT="Friz Quadrata TT",DURWARN=3,SSDUR="true",OUTLINE=2}
IconText~d!2~3~4~5~6~7~8~9~10~
BarVisibility~f~1!{INCCLASSES=1,ALERTIC=1,ALERTOC=0.9,HIDEOOR="false"}
BarVisibility~f~2!{INCCLASSES=1,ALERTIC=0.9,ALERTOC=0.8,HIDEOOR="false"}
BarVisibility~f~3!{INCCLASSES=1,ALERTIC=0.95,ALERTOC=0.85,HIDEOOR="false"}
BarVisibility~d!4~5~
BarVisibility~f~6!{INCCLASSES=1,ALERTIC=0.85,ALERTOC=0.7,HIDEOOR="false"}
BarVisibility~d!7~
BarVisibility~f~8!{INCCLASSES=1,ALERTIC=0.95,ALERTOC=0.85,HIDEOOR="false"}
BarVisibility~d!9~10~
BarSort~f~1!{SUBORDER=1,OORLAST="true",RAIDORDER=3,SUBPF="true"}
BarSort~d!2~
BarSort~f~3!{SUBORDER=1,OORLAST="true",RAIDORDER=1,SUBPF="true"}
BarSort~f~4!{SUBORDER=1,OORLAST="false",RAIDORDER=3,SUBPF="true"}
BarSort~d!5~6~
BarSort~f~7!{SUBORDER=1,OORLAST="true",RAIDORDER=3,SUBPF="true"}
BarSort~f~8!{SUBORDER=1,OORLAST="false",RAIDORDER=3,SUBPF="true"}
BarSort~d!9~10~
BarAggro~f~1!{R=1,ALERTIND=2,G=0,TEXTFORMAT=3,SHOW="true",SHOWTEXTPCT="true",B=0,SHOWTEXT="false",SHOWIND="true",ALERT=1}
BarAggro~f~2!{R=1,ALERTIND=2,G=0,TEXTFORMAT=3,SHOW="true",SHOWTEXTPCT="true",B=0,SHOWTEXT="false",SHOWIND="true",ALERT=3}
BarAggro~d!3~4~5~6~7~8~9~10~
AuxBarFrame~f~1!{OFREQ=0.1,OVERLAP=1,OMIN=0.1,OMAX=0.95}
AuxBarFrame~d!2~3~4~5~6~7~8~9~10~
AuxBar^1~f~1!{SIZE=1,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=3,B=1,OTYPE=1,A=1,G=1}
AuxBar^1~d!2~3~4~5~6~7~8~9~10~
AuxBar^2~f~1!{SIZE=1,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=2,B=1,OTYPE=2,A=1,G=1}
AuxBar^2~d!2~3~4~5~6~7~8~9~10~
AuxBar^3~f~1!{SIZE=1,USE=1,R=1,COLOUR=1,ANCHOR=2,OFFSET=1,DEPTH=3,B=1,OTYPE=2,A=1,G=1}
AuxBar^3~d!2~3~4~5~6~7~8~9~10~
AuxBar^4~f~1!{SIZE=1,USE=1,R=1,COLOUR=1,ANCHOR=3,OFFSET=1,DEPTH=3,B=1,OTYPE=1,A=1,G=1}
AuxBar^4~d!2~3~4~5~6~7~8~9~10~
AuxBar^5~f~1!{SIZE=1,USE=1,R=1,COLOUR=1,ANCHOR=4,OFFSET=1,DEPTH=3,B=1,OTYPE=1,A=1,G=1}
AuxBar^5~d!2~3~4~5~6~7~8~9~10~
AuxBar^6~f~1!{SIZE=1,USE=1,R=1,COLOUR=1,ANCHOR=2,OFFSET=-3,DEPTH=3,B=1,OTYPE=2,A=1,G=1}
AuxBar^6~d!2~3~4~5~6~7~8~9~10~
AuxBar^7~f~1!{SIZE=1,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,B=1,OTYPE=1,A=1,G=1}
AuxBar^7~d!2~3~4~5~6~7~8~9~10~
AuxBar^8~f~1!{SIZE=1,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,B=1,OTYPE=1,A=1,G=1}
AuxBar^8~d!2~3~4~5~6~7~8~9~10~
AuxBar^9~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,B=1,OTYPE=1,A=1,G=1}
AuxBar^9~d!2~3~4~5~6~7~8~9~10~
Complete!]]

HealBot_ExtraSkinData[8]=[[Skin
Full 40
Author~v!Monti of Terenas
DuplicateBars~v!true
Chat~t!{EOCOOM="false",EOCOOMV=20,MSG="Casting #s on #n",RESONLY="true",NOTIFY=1}
General~t!{FLUIDFREQ=3,HIDEPARTYF="false",HIDEPTF="false",STICKYSENSITIVITY=40,HIDERAIDF="true",STICKYFRAME="true",FLUIDBARS="false",HIDEBOSSF="true"}
Healing~t!{TONLYFRIEND="false",FEXRAID="false",FOCUSINCOMBAT=2,GROUPPETS="true",SELFPET="false",FONLYFRIEND="false",TEXRAID="false",TARGETINCOMBAT=2}
Protection~t!{COMBAT="false",GENERALMACRO="true",COMBATPARTY="true",CRASH="false",COMBATRAID="true"}
Enemy~t!{INCARENA="true",INCTANKS="true",INCMYTAR="false",ENEMYTARGET="false",INCARENAPETS="false",ENEMYTARGETSIZE=40,HIDE="false",NUMBOSS=2,EXISTSHOWPTAR="false",INCSELF="false",EXISTSHOWBOSS="true",DOUBLEWIDTH="false",EXISTSHOWARENA="true"}
IncludeGroup~f~1!{"true","true","true","true","true","true","true","true"}
IncludeGroup~f~2!{"true","true","true","true","true","true","true","true"}
IncludeGroup~f~3!{"true","true","true","true","true","true","true","true"}
IncludeGroup~f~4!{"true","true","true","true","true","true","true","true"}
IncludeGroup~f~5!{"true","true","true","true","true","true","true","true"}
IncludeGroup~f~6!{"true","true","true","true","true","true","true","true"}
IncludeGroup~f~7!{"true","true","true","true","true","true","true","true"}
IncludeGroup~f~8!{"true","true","true","true","true","true","true","true"}
IncludeGroup~f~9!{"true","true","true","true","true","true","true","true"}
IncludeGroup~f~10!{"true","true","true","true","true","true","true","true"}
FrameAlias~f~1!{A=1,NAME="Tanks",R=1,ALIAS="Tanks",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~2!{A=1,NAME="",R=1,ALIAS="Raid",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~3!{A=1,NAME="Healers",R=1,ALIAS="Healers",G=1,SHOW="true",OFFSET=0,FONT="Friz Quadrata TT",SIZE=11,B=1,OUTLINE=1}
FrameAlias~f~4!{A=1,NAME="",R=1,ALIAS="not used 1",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~5!{A=1,NAME="",R=1,ALIAS="not used 2",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~6!{SIZE=12,NAME="Vehicle",R=1,ALIAS="Vehicle",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~7!{SIZE=12,NAME="Pets",R=1,ALIAS="Pets",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~8!{SIZE=12,NAME="Target",R=1,ALIAS="Target",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~9!{SIZE=12,NAME="Focus",R=1,ALIAS="Focus",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~10!{SIZE=11,NAME="Enemy",R=1,ALIAS="Enemy",G=0,SHOW="true",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=0,OUTLINE=1}
FrameAliasBar~f~1!{A=0,TEXTURE="Skewed",B=0.102,HEIGHT=20,R=0.102,G=0.102,WIDTH=0.9}
FrameAliasBar~f~2!{A=0.2,TEXTURE="Skewed",B=0.1,HEIGHT=20,R=0.1,G=0.1,WIDTH=0.9}
FrameAliasBar~f~3!{A=0,TEXTURE="Skewed",B=0.102,HEIGHT=15,R=0.102,G=0.102,WIDTH=0.9}
FrameAliasBar~f~4!{A=0.2,TEXTURE="Skewed",B=0.1,HEIGHT=20,R=0.1,G=0.1,WIDTH=0.9}
FrameAliasBar~d!5~6~
FrameAliasBar~f~7!{A=0,TEXTURE="Aluminium",B=1,HEIGHT=20,R=1,G=1,WIDTH=0.92}
FrameAliasBar~f~8!{A=0.2,TEXTURE="Skewed",B=0.1,HEIGHT=20,R=0.1,G=0.1,WIDTH=0.9}
FrameAliasBar~d!9~
FrameAliasBar~f~10!{A=0,TEXTURE="Skewed",B=0.102,HEIGHT=15,R=0.102,G=0.102,WIDTH=0.9}
Frame~f~1!{SFOFFSETH=0,BACKG=0.102,TIPLOC=5,BORDERB=0.102,LOCKED="false",SCALE=1,BORDERA=0,BORDERG=0.102,AUTOCLOSE="false",BACKB=0.702,BACKA=0,OPENSOUND="false",SFOFFSETV=0,BACKR=0.102,BORDERR=0.102}
Frame~f~2!{SFOFFSETH=8,BACKG=0.102,TIPLOC=4,BORDERB=0.102,LOCKED="true",SCALE=1,BORDERA=0,BORDERG=0.102,AUTOCLOSE="false",BACKB=0.702,BACKA=0,OPENSOUND="false",SFOFFSETV=0,BACKR=0.102,BORDERR=0.102}
Frame~f~3!{SFOFFSETH=0,BACKG=0.1,TIPLOC=5,BORDERB=0.1,LOCKED="true",SCALE=1,BORDERA=0.04,BORDERG=0.1,AUTOCLOSE="false",BACKB=0.7,BACKA=0.1,OPENSOUND="false",SFOFFSETV=8,BACKR=0.1,BORDERR=0.1}
Frame~f~4!{SFOFFSETH=0,BACKG=0.1,TIPLOC=5,BORDERB=0.1,LOCKED="false",SCALE=1,BORDERA=0.04,BORDERG=0.1,AUTOCLOSE="false",BACKB=0.7,BACKA=0.1,OPENSOUND="false",SFOFFSETV=0,BACKR=0.1,BORDERR=0.1}
Frame~d!5~6~
Frame~f~7!{SFOFFSETH=-4,BACKG=0.102,TIPLOC=3,BORDERB=0.1,LOCKED="true",SCALE=1,BORDERA=0.04,BORDERG=0.1,AUTOCLOSE="false",BACKB=0.702,BACKA=0,OPENSOUND="false",SFOFFSETV=7,BACKR=0.102,BORDERR=0.1}
Frame~f~8!{SFOFFSETH=9,BACKG=0.1,TIPLOC=2,BORDERB=0.1,LOCKED="false",SCALE=1,BORDERA=0.04,BORDERG=0.1,AUTOCLOSE="false",BACKB=0.7,BACKA=0.1,OPENSOUND="false",SFOFFSETV=0,BACKR=0.1,BORDERR=0.1}
Frame~d!9~
Frame~f~10!{SFOFFSETH=0,BACKG=0.102,TIPLOC=5,BORDERB=0.102,LOCKED="true",SCALE=1,BORDERA=0,BORDERG=0.102,AUTOCLOSE="false",BACKB=0.702,BACKA=0,OPENSOUND="false",SFOFFSETV=0,BACKR=0.102,BORDERR=0.102}
StickyFrames~f~1!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~f~2!{STUCK="true",STUCKTOPOINT="TOPLEFT",STUCKTO=1,STUCKPOINT="TOPRIGHT"}
StickyFrames~f~3!{STUCK="true",STUCKTOPOINT="BOTTOMRIGHT",STUCKTO=1,STUCKPOINT="TOPRIGHT"}
StickyFrames~f~4!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~d!5~6~
StickyFrames~f~7!{STUCK="true",STUCKTOPOINT="BOTTOMLEFT",STUCKTO=2,STUCKPOINT="TOPLEFT"}
StickyFrames~f~8!{STUCK="true",STUCKTOPOINT="TOPLEFT",STUCKTO=2,STUCKPOINT="TOPRIGHT"}
StickyFrames~f~9!{STUCK="true",STUCKTOPOINT="BOTTOMLEFT",STUCKTO=2,STUCKPOINT="BOTTOMRIGHT"}
StickyFrames~f~10!{STUCK="true",STUCKTOPOINT="TOPLEFT",STUCKTO=2,STUCKPOINT="BOTTOMLEFT"}
HealGroups~f~1!{FRAME=1,STATE="true",NAME="Main tanks"}
HealGroups~f~2!{FRAME=2,STATE="true",NAME="Raid"}
HealGroups~f~3!{FRAME=1,STATE="false",NAME="Self"}
HealGroups~f~4!{FRAME=3,STATE="true",NAME="Healers"}
HealGroups~f~5!{FRAME=1,STATE="false",NAME="Group"}
HealGroups~f~6!{FRAME=2,STATE="false",NAME="Private List"}
HealGroups~f~7!{FRAME=6,STATE="false",NAME="Vehicle"}
HealGroups~f~8!{FRAME=7,STATE="true",NAME="Pets"}
HealGroups~f~9!{FRAME=8,STATE="false",NAME="Target"}
HealGroups~f~10!{FRAME=9,STATE="false",NAME="Focus"}
HealGroups~f~11!{FRAME=10,STATE="true",NAME="Enemy"}
Anchors~f~1!{Y=68.03,GROW=2,BARS=3,FRAME=3,X=95.1}
Anchors~f~2!{Y=68.03,GROW=2,BARS=1,FRAME=3,X=88.96}
Anchors~f~3!{Y=59.7,GROW=2,BARS=1,FRAME=3,X=95.1}
Anchors~f~4!{Y=53,GROW=2,BARS=1,FRAME=1,X=53}
Anchors~f~5!{Y=54,GROW=2,BARS=1,FRAME=1,X=54}
Anchors~f~6!{Y=55,GROW=2,BARS=1,FRAME=1,X=55}
Anchors~f~7!{Y=40.28,GROW=1,BARS=1,FRAME=1,X=77.73}
Anchors~f~8!{Y=68.11,GROW=2,BARS=1,FRAME=3,X=78.18}
Anchors~f~9!{Y=63.74,GROW=2,BARS=1,FRAME=4,X=88.96}
Anchors~f~10!{Y=68.03,GROW=2,BARS=2,FRAME=2,X=77.87}
HeadBar~f~1!{SHOW="true",TEXTURE="Aluminium",R=0,B=0,HEIGHT=15,A=0,G=0,WIDTH=1}
HeadBar~f~2!{SHOW="true",TEXTURE="Aluminium",R=1,B=1,HEIGHT=15,A=0,G=1,WIDTH=1}
HeadBar~f~3!{SHOW="false",TEXTURE="Skewed",R=0.1,B=0.1,HEIGHT=20,A=0.2,G=0.1,WIDTH=0.9}
HeadBar~d!4~5~6~
HeadBar~f~7!{SHOW="true",TEXTURE="Aluminium",R=0.102,B=0.102,HEIGHT=20,A=0,G=0.102,WIDTH=0.7}
HeadBar~f~8!{SHOW="true",TEXTURE="Skewed",R=0.102,B=0.102,HEIGHT=15,A=0,G=0.102,WIDTH=0.9}
HeadBar~d!9~
HeadBar~f~10!{SHOW="false",WIDTH=0.9,B=0.1,R=0.1,HEIGHT=20,A=0.2,G=0.1,TEXTURE="Skewed"}
HeadText~f~1!{A=1,R=1,OFFSET=0,B=1,FONT="Friz Quadrata TT",HEIGHT=11,G=1,OUTLINE=1}
HeadText~d!2~
HeadText~f~3!{A=0.4,R=1,OFFSET=0,B=0.1,FONT="Friz Quadrata TT",HEIGHT=9,G=1,OUTLINE=1}
HeadText~d!4~5~6~
HeadText~f~7!{A=1,R=1,OFFSET=0,B=1,FONT="Friz Quadrata TT",HEIGHT=11,G=1,OUTLINE=1}
HeadText~d!8~9~
HeadText~f~10!{A=0.4,B=0.1,OFFSET=0,R=1,FONT="Friz Quadrata TT",HEIGHT=9,G=1,OUTLINE=1}
HealBar~f~1!{HEIGHT=32,GRPCOLS="false",CMARGIN=0,TEXTURE="Charcoal",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=172,RMARGIN=0,OFIX=1,NUMCOLS=1,LOWMANA=1}
HealBar~f~2!{HEIGHT=28,GRPCOLS="false",CMARGIN=0,TEXTURE="Charcoal",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=75,RMARGIN=0,OFIX=1,NUMCOLS=2,LOWMANA=1}
HealBar~f~3!{HEIGHT=32,GRPCOLS="false",CMARGIN=1,TEXTURE="Charcoal",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=84,RMARGIN=0,OFIX=1,NUMCOLS=2,LOWMANA=1}
HealBar~f~4!{HEIGHT=32,GRPCOLS="false",CMARGIN=2,TEXTURE="Tukui2",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=75,RMARGIN=2,OFIX=1,NUMCOLS=2,LOWMANA=1}
HealBar~d!5~6~
HealBar~f~7!{HEIGHT=25,GRPCOLS="false",CMARGIN=0,TEXTURE="Charcoal",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=50,RMARGIN=0,OFIX=1,NUMCOLS=1,LOWMANA=1}
HealBar~f~8!{HEIGHT=28,GRPCOLS="false",CMARGIN=0,TEXTURE="Charcoal",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=75,RMARGIN=0,OFIX=1,NUMCOLS=2,LOWMANA=1}
HealBar~d!9~
HealBar~f~10!{HEIGHT=32,GRPCOLS="false",CMARGIN=1,TEXTURE="Armory",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=75,RMARGIN=0,OFIX=1,NUMCOLS=4,LOWMANA=1}
BarCol~f~1!{BACK=1,BA=0.25,BB=0.4,DISA=0.1,BR=0.2,HB=0.4,BG=0.4,HR=0.2,HA=0.95,HG=0.4,ORA=0.4,BOUT=1,HLTH=2}
BarCol~d!2~3~4~5~6~7~8~9~
BarCol~f~10!{BACK=2,BA=0.25,BB=0.4,DISA=0.1,BR=0.2,HB=0.059,BG=0.4,BOUT=1,HA=0.95,HR=0.914,ORA=0.4,HG=0.059,HLTH=3}
BarIACol~f~1!{AC=4,AB=1,AA=0.5,AR=1,AG=1,IC=2,IB=0.2,IA=0.58,IR=0.2,IG=0.8}
BarIACol~d!2~3~4~5~6~7~8~9~10~
BarText~f~1!{HLTHONBAR="true",TAGOOR="OOR-",HOUTLINE=1,MAXCHARS=10,HMAXCHARS=0,HFONT="Friz Quadrata TT",CLASSONBAR="false",HHEIGHT=10,INCHEALS=2,HLTHTXTANCHOR=1,HLTHTYPE=3,HOFFSET=0,INCABSORBS=1,NUMFORMAT2=1,OFFSET=0,TAGDC="DC-",NUMFORMAT1=11,NAMEONBAR="true",HEIGHT=10,TAGRIP="",SHOWROLE="true",HALIGN=2,FONT="Friz Quadrata TT",OVERHEAL=1,IGNOREONFULL="true",CLASSTYPE=1,HOFFSET2=0,ALIGN=2,TAGR="",OUTLINE=1}
BarText~f~2!{HLTHONBAR="true",TAGOOR="OOR-",HOUTLINE=1,MAXCHARS=10,CLASSONBAR="false",OUTLINE=1,OVERHEAL=1,HFONT="Friz Quadrata TT",INCHEALS=2,HLTHTXTANCHOR=1,HLTHTYPE=3,HMAXCHARS=0,INCABSORBS=1,NUMFORMAT2=1,FONT="Friz Quadrata TT",NUMFORMAT1=11,OFFSET=0,NAMEONBAR="true",HEIGHT=10,TAGRIP="",SHOWROLE="true",HALIGN=2,TAGDC="DC-",HHEIGHT=10,IGNOREONFULL="true",CLASSTYPE=1,HOFFSET2=0,ALIGN=2,TAGR="",HOFFSET=0}
BarText~d!3~
BarText~f~4!{HLTHONBAR="true",TAGOOR="",HOUTLINE=1,MAXCHARS=10,CLASSONBAR="false",OUTLINE=1,OVERHEAL=1,HFONT="Friz Quadrata TT",INCHEALS=2,HLTHTXTANCHOR=1,HLTHTYPE=3,HMAXCHARS=0,INCABSORBS=1,NUMFORMAT2=1,FONT="Friz Quadrata TT",NUMFORMAT1=11,OFFSET=0,NAMEONBAR="true",HEIGHT=10,TAGRIP="",SHOWROLE="true",HALIGN=2,TAGDC="",HHEIGHT=10,IGNOREONFULL="true",CLASSTYPE=1,HOFFSET2=0,ALIGN=2,TAGR="",HOFFSET=0}
BarText~f~5!{HLTHONBAR="true",TAGOOR="",HOUTLINE=1,MAXCHARS=10,HMAXCHARS=0,HFONT="Friz Quadrata TT",CLASSONBAR="false",HHEIGHT=10,INCHEALS=2,HLTHTXTANCHOR=1,HLTHTYPE=3,HOFFSET=0,INCABSORBS=1,NUMFORMAT2=1,OFFSET=0,NUMFORMAT1=11,TAGDC="",NAMEONBAR="true",HEIGHT=10,TAGRIP="",SHOWROLE="true",HALIGN=2,FONT="Friz Quadrata TT",OVERHEAL=1,IGNOREONFULL="true",CLASSTYPE=1,HOFFSET2=0,ALIGN=2,TAGR="",OUTLINE=1}
BarText~d!6~
BarText~f~7!{HLTHONBAR="true",TAGOOR="OOR-",HOUTLINE=1,MAXCHARS=10,CLASSONBAR="false",OUTLINE=1,OVERHEAL=1,HFONT="Friz Quadrata TT",INCHEALS=2,HLTHTXTANCHOR=1,HLTHTYPE=3,HMAXCHARS=0,INCABSORBS=1,NUMFORMAT2=1,FONT="Friz Quadrata TT",NUMFORMAT1=11,OFFSET=0,NAMEONBAR="true",HEIGHT=10,TAGRIP="",SHOWROLE="true",HALIGN=2,TAGDC="",HHEIGHT=10,IGNOREONFULL="true",CLASSTYPE=1,HOFFSET2=0,ALIGN=2,TAGR="",HOFFSET=0}
BarText~f~8!{HLTHONBAR="true",TAGOOR="",HOUTLINE=1,MAXCHARS=10,CLASSONBAR="false",OUTLINE=1,OVERHEAL=1,HFONT="Friz Quadrata TT",INCHEALS=2,HLTHTXTANCHOR=1,HLTHTYPE=3,HMAXCHARS=0,INCABSORBS=1,NUMFORMAT2=1,FONT="Friz Quadrata TT",NUMFORMAT1=11,OFFSET=0,NAMEONBAR="true",HEIGHT=10,TAGRIP="",SHOWROLE="true",HALIGN=2,TAGDC="",HHEIGHT=10,IGNOREONFULL="true",CLASSTYPE=1,HOFFSET2=0,ALIGN=2,TAGR="",HOFFSET=0}
BarText~d!9~10~
BarTextCol~f~1!{NAME=2,NDEBUFF="false",HLTH=2,NCDA=0.7,NCB=0,HCA=1,HCB=0,NCA=1,HCR=1,NCG=1,NCR=1,HDEBUFF="false",HCG=1,HCDA=0.7}
BarTextCol~d!2~3~4~5~6~7~8~9~10~
Icons~f~1!{SHOWBUFF="true",POSITION=2,FADESECS=15,MAXDICONS=2,I15EN="true",FADE="false",SHOWDIR="false",DOUBLE="true",DSCALE=1,ONBAR=1,SHOWRC="true",SCALE=1,SHOWDIRMOUSE="false",SHOWDEBUFF="true",MAXBICONS=4}
Icons~f~2!{SHOWBUFF="true",POSITION=2,FADESECS=15,MAXDICONS=4,I15EN="true",FADE="false",SHOWDIR="false",DOUBLE="true",DSCALE=1,ONBAR=1,SHOWRC="true",SCALE=1,SHOWDIRMOUSE="false",SHOWDEBUFF="true",MAXBICONS=8}
Icons~f~3!{SHOWBUFF="true",POSITION=2,FADESECS=15,MAXDICONS=3,I15EN="true",FADE="false",SHOWDIR="false",DOUBLE="true",DSCALE=1,ONBAR=1,SHOWRC="true",SCALE=1,SHOWDIRMOUSE="false",SHOWDEBUFF="true",MAXBICONS=8}
Icons~d!4~5~6~
Icons~f~7!{SHOWBUFF="true",POSITION=2,FADESECS=15,MAXDICONS=2,I15EN="true",FADE="false",SHOWDIR="false",DOUBLE="true",DSCALE=1,ONBAR=1,SHOWRC="true",SCALE=1,SHOWDIRMOUSE="false",SHOWDEBUFF="true",MAXBICONS=4}
Icons~f~8!{SHOWBUFF="true",POSITION=2,FADESECS=15,MAXDICONS=2,I15EN="true",FADE="false",SHOWDIR="false",DOUBLE="true",DSCALE=1,ONBAR=1,SHOWRC="true",SCALE=1,SHOWDIRMOUSE="false",SHOWDEBUFF="true",MAXBICONS=6}
Icons~d!9~
Icons~f~10!{SHOWBUFF="true",POSITION=2,FADESECS=15,MAXDICONS=3,I15EN="true",FADE="false",SHOWDIR="false",DOUBLE="true",DSCALE=1,ONBAR=1,SHOWRC="true",SCALE=1,SHOWDIRMOUSE="false",SHOWDEBUFF="true",MAXBICONS=8}
RaidIcon~f~1!{SQUARE="true",CIRCLE="true",DIAMOND="true",SHOW="true",SKULL="true",TRIANGLE="true",STAR="true",CROSS="true",MOON="true"}
RaidIcon~d!2~3~4~5~6~7~8~9~10~
IconText~f~1!{DURWARN=3,HEIGHT=10,SSCNT="false",SCNT="true",DURTHRH=9,FONT="Friz Quadrata TT",SDUR="false",SSDUR="true",OUTLINE=2}
IconText~d!2~3~4~5~6~7~8~9~10~
BarVisibility~f~1!{INCCLASSES=1,ALERTIC=0.98,ALERTOC=0.9,HIDEOOR="false"}
BarVisibility~f~2!{INCCLASSES=1,ALERTIC=0.95,ALERTOC=0.85,HIDEOOR="false"}
BarVisibility~d!3~4~5~6~
BarVisibility~f~7!{INCCLASSES=1,ALERTIC=0.9,ALERTOC=0.75,HIDEOOR="false"}
BarVisibility~f~8!{INCCLASSES=1,ALERTIC=0.95,ALERTOC=0.85,HIDEOOR="false"}
BarVisibility~d!9~10~
BarSort~f~1!{SUBORDER=1,OORLAST="true",RAIDORDER=2,SUBPF="true"}
BarSort~f~2!{SUBORDER=2,OORLAST="true",RAIDORDER=3,SUBPF="true"}
BarSort~f~3!{SUBORDER=1,OORLAST="true",RAIDORDER=2,SUBPF="true"}
BarSort~f~4!{SUBORDER=1,OORLAST="false",RAIDORDER=3,SUBPF="true"}
BarSort~d!5~6~
BarSort~f~7!{SUBORDER=1,OORLAST="false",RAIDORDER=2,SUBPF="true"}
BarSort~f~8!{SUBORDER=1,OORLAST="false",RAIDORDER=3,SUBPF="true"}
BarSort~d!9~
BarSort~f~10!{SUBORDER=1,OORLAST="false",RAIDORDER=1,SUBPF="true"}
BarAggro~f~1!{R=1,SHOWTEXT="false",G=0,TEXTFORMAT=3,SHOW="true",SHOWTEXTPCT="true",B=0,ALERTIND=2,SHOWIND="true",ALERT=3}
BarAggro~d!2~3~4~5~6~7~8~9~10~
AuxBarFrame~f~1!{OFREQ=0.07,OVERLAP=1,OMIN=0.1,OMAX=0.95}
AuxBarFrame~d!2~3~4~5~6~7~8~9~10~
AuxBar^1~f~1!{SIZE=1,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,B=1,OTYPE=1,A=1,G=1}
AuxBar^1~d!2~3~4~5~6~7~8~9~10~
AuxBar^2~f~1!{SIZE=1,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,B=1,OTYPE=1,A=1,G=1}
AuxBar^2~d!2~3~4~5~6~7~8~9~10~
AuxBar^3~f~1!{SIZE=1,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,B=1,OTYPE=1,A=1,G=1}
AuxBar^3~d!2~3~4~5~6~7~8~9~10~
AuxBar^4~f~1!{SIZE=1,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,B=1,OTYPE=1,A=1,G=1}
AuxBar^4~d!2~3~4~5~6~7~8~9~10~
AuxBar^5~f~1!{SIZE=1,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,B=1,OTYPE=1,A=1,G=1}
AuxBar^5~d!2~3~4~5~6~7~8~9~10~
AuxBar^6~f~1!{SIZE=1,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,B=1,OTYPE=1,A=1,G=1}
AuxBar^6~d!2~3~4~5~6~7~8~9~10~
AuxBar^7~f~1!{SIZE=1,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,B=1,OTYPE=1,A=1,G=1}
AuxBar^7~d!2~3~4~5~6~7~8~9~10~
AuxBar^8~f~1!{SIZE=1,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,B=1,OTYPE=1,A=1,G=1}
AuxBar^8~d!2~3~4~5~6~7~8~9~10~
AuxBar^9~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,B=1,OTYPE=1,A=1,G=1}
AuxBar^9~d!2~3~4~5~6~7~8~9~10~
Complete!]]
HealBot_ExtraSkinData[9]=[[Skin
Aphrahat 2020/4
Author~v!Aphrahat von Kazzak
DuplicateBars~v!false
Chat~t!{EOCOOM="true",EOCOOMV=15,MSG="† #n lasse Dich vom Blute Christi erlösen! †",RESONLY="true",NOTIFY=5}
General~t!{HIDEBOSSF="true",HIDEPTF="true",HIDEPARTYF="true",STICKYFRAME="true",STICKYSENSITIVITY=15,HIDERAIDF="true",FLUIDBARS="false",FLUIDFREQ=5}
Healing~t!{TONLYFRIEND="false",SELFPET="false",FOCUSINCOMBAT=2,GROUPPETS="true",TARGETINCOMBAT=2,FONLYFRIEND="false",TEXRAID="false",FEXRAID="false"}
Protection~t!{COMBAT="false",GENERALMACRO="true",COMBATPARTY="true",CRASH="true",COMBATRAID="true"}
Enemy~t!{ENEMYTARGET="false",INCTANKS="true",INCMYTAR="false",INCARENA="true",ENEMYTARGETSIZE=40,INCARENAPETS="false",HIDE="true",NUMBOSS=2,EXISTSHOWPTAR="false",INCSELF="false",EXISTSHOWBOSS="true",DOUBLEWIDTH="false",EXISTSHOWARENA="true"}
IncludeGroup~f~1!{"true","true","true","true","true","true","true","true"}
IncludeGroup~f~2!{"true","true","true","true","true","true","true","true"}
IncludeGroup~f~3!{"true","true","true","true","true","true","true","true"}
IncludeGroup~f~4!{"true","true","true","true","true","true","true","true"}
IncludeGroup~f~5!{"true","true","true","true","true","true","true","true"}
IncludeGroup~f~6!{"true","true","true","true","true","true","true","true"}
IncludeGroup~f~7!{"true","true","true","true","true","true","true","true"}
IncludeGroup~f~8!{"true","true","true","true","true","true","true","true"}
IncludeGroup~f~9!{"true","true","true","true","true","true","true","true"}
IncludeGroup~f~10!{"true","true","true","true","true","true","true","true"}
FrameAlias~f~1!{SIZE=7,NAME="",R=0.988,ALIAS="Rahmen 1",G=0.988,SHOW="false",OFFSET=0,FONT="Swansea",A=0,B=0.988,OUTLINE=1}
FrameAlias~f~2!{A=1,NAME="",R=1,ALIAS="Rahmen 2",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",SIZE=7,B=1,OUTLINE=1}
FrameAlias~d!3~4~5~
FrameAlias~f~6!{SIZE=7,NAME="Vehicle",R=1,ALIAS="Vehicle",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~7!{SIZE=7,NAME="Pets",R=1,ALIAS="Pets",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~8!{SIZE=7,NAME="Target",R=1,ALIAS="Target",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~9!{SIZE=7,NAME="Focus",R=1,ALIAS="Focus",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~10!{SIZE=7,NAME="Enemy",R=1,ALIAS="Enemy",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAliasBar~f~1!{A=0,TEXTURE="HealBot 10",B=0.988,HEIGHT=20,R=0.988,G=0.988,WIDTH=0.85}
FrameAliasBar~f~2!{A=0.4,TEXTURE="HealBot 10",B=0.1,HEIGHT=20,R=0.1,G=0.7,WIDTH=0.7}
FrameAliasBar~d!3~4~5~6~7~8~9~10~
Frame~f~1!{BORDERR=0.988,TIPLOC=5,AUTOCLOSE="false",BORDERB=0.988,LOCKED="true",SCALE=1,BORDERA=0,BORDERG=0.988,BACKG=0.988,BACKB=0.988,BACKA=0,OPENSOUND="false",SFOFFSETV=0,SFOFFSETH=0,BACKR=0.988}
Frame~f~2!{BORDERR=0.004,TIPLOC=5,AUTOCLOSE="false",BORDERB=0.004,LOCKED="true",SCALE=1,BORDERA=0,BORDERG=0.004,BACKG=0.004,BACKB=0.004,BACKA=0,OPENSOUND="false",SFOFFSETV=0,SFOFFSETH=0,BACKR=0.004}
Frame~d!3~4~5~6~7~
Frame~f~8!{BORDERR=0.004,TIPLOC=5,AUTOCLOSE="false",BORDERB=0.004,LOCKED="true",SCALE=1,BORDERA=0,BORDERG=0.004,BACKG=0.004,BACKB=0.004,BACKA=0,OPENSOUND="false",SFOFFSETV=-8,SFOFFSETH=0,BACKR=0.004}
Frame~d!9~
Frame~f~10!{BORDERR=0.004,TIPLOC=5,AUTOCLOSE="false",BORDERB=0.004,LOCKED="true",SCALE=1,BORDERA=0,BORDERG=0.004,BACKG=0.004,BACKB=0.004,BACKA=0,OPENSOUND="false",SFOFFSETV=0,SFOFFSETH=0,BACKR=0.004}
StickyFrames~f~1!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~d!2~3~4~5~6~7~
StickyFrames~f~8!{STUCK="true",STUCKTOPOINT="TOPLEFT",STUCKTO=1,STUCKPOINT="BOTTOMLEFT"}
StickyFrames~f~9!{STUCK="true",STUCKTOPOINT="TOPRIGHT",STUCKTO=1,STUCKPOINT="BOTTOMRIGHT"}
StickyFrames~f~10!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
HealGroups~f~1!{FRAME=1,STATE="true",NAME="Main tanks"}
HealGroups~f~2!{FRAME=1,STATE="true",NAME="Group"}
HealGroups~f~3!{FRAME=1,STATE="true",NAME="Raid"}
HealGroups~f~4!{FRAME=1,STATE="false",NAME="Self"}
HealGroups~f~5!{FRAME=1,STATE="false",NAME="Healers"}
HealGroups~f~6!{FRAME=1,STATE="false",NAME="Private List"}
HealGroups~f~7!{FRAME=6,STATE="false",NAME="Vehicle"}
HealGroups~f~8!{FRAME=7,STATE="false",NAME="Pets"}
HealGroups~f~9!{FRAME=8,STATE="false",NAME="Target"}
HealGroups~f~10!{FRAME=9,STATE="false",NAME="Focus"}
HealGroups~f~11!{FRAME=10,STATE="false",NAME="Enemy"}
Anchors~f~1!{Y=57.59,GROW=2,BARS=1,FRAME=1,X=66.62}
Anchors~f~2!{Y=51,GROW=2,BARS=1,FRAME=1,X=51}
Anchors~f~3!{Y=52,GROW=2,BARS=1,FRAME=1,X=52}
Anchors~f~4!{Y=53,GROW=2,BARS=1,FRAME=1,X=53}
Anchors~f~5!{Y=54,GROW=2,BARS=1,FRAME=1,X=54}
Anchors~f~6!{Y=55,GROW=2,BARS=1,FRAME=1,X=55}
Anchors~f~7!{Y=56,GROW=2,BARS=1,FRAME=1,X=56}
Anchors~f~8!{Y=63,GROW=2,BARS=1,FRAME=1,X=15.8}
Anchors~f~9!{Y=63,GROW=2,BARS=1,FRAME=1,X=21}
Anchors~f~10!{Y=59,GROW=2,BARS=1,FRAME=1,X=59}
HeadBar~f~1!{SHOW="true",TEXTURE="Details Vidro",R=0.988,B=0.988,HEIGHT=5,A=0,G=0.988,WIDTH=0.25}
HeadBar~f~2!{SHOW="true",TEXTURE="HealBot 10",R=0.2,B=0.2,HEIGHT=15,A=0.4,G=0.4,WIDTH=0.95}
HeadBar~d!3~4~5~6~7~8~9~10~
HeadText~f~1!{A=0.21,R=1,OFFSET=0,B=1,FONT="Swansea",HEIGHT=7,G=1,OUTLINE=1}
HeadText~f~2!{A=0.74,R=1,OFFSET=0,B=1,FONT="Friz Quadrata TT",HEIGHT=10,G=1,OUTLINE=1}
HeadText~d!3~4~5~6~7~8~9~10~
HealBar~f~1!{HEIGHT=35,GRPCOLS="false",CMARGIN=1,TEXTURE="Details Flat",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=175,RMARGIN=1,OFIX=1,NUMCOLS=2,LOWMANA=1}
HealBar~f~2!{HEIGHT=35,GRPCOLS="false",CMARGIN=1,TEXTURE="Details Flat",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=170,RMARGIN=1,OFIX=1,NUMCOLS=2,LOWMANA=2}
HealBar~d!3~4~5~6~7~8~9~10~
BarCol~f~1!{BACK=2,BA=0,BB=1,DISA=0,BR=1,HB=1,BG=1,HR=1,HA=1,HG=1,ORA=0.45,BOUT=0,HLTH=2}
BarCol~d!2~3~4~5~6~7~8~9~10~
BarIACol~f~1!{AC=4,AB=0.988,AA=0.9,AR=0.988,AG=0.988,IC=4,IB=0.988,IA=0.9,IR=0.988,IG=0.988}
BarIACol~f~2!{AC=4,AB=0.992,AA=0.9,AR=0.992,AG=0.992,IC=3,IB=0.992,IA=0.9,IR=0.992,IG=0.992}
BarIACol~d!3~4~5~6~7~8~9~10~
BarText~f~1!{HLTHONBAR="true",TAGOOR="®      ",OVERHEAL=1,MAXCHARS=0,HMAXCHARS=0,HOFFSET=2,OUTLINE=2,OFFSET=3,INCHEALS=1,HLTHTXTANCHOR=2,FONT="Swansea",CLASSONBAR="false",CLASSTYPE=2,NUMFORMAT2=8,HHEIGHT=8,NUMFORMAT1=1,HOUTLINE=1,TAGRIP="††      ",HEIGHT=10,NAMEONBAR="true",SHOWROLE="false",HALIGN=2,HLTHTYPE=1,TAGDC="©      ",IGNOREONFULL="false",INCABSORBS=1,HOFFSET2=-1,ALIGN=1,TAGR="r.",HFONT="Swansea Bold"}
BarText~f~2!{HLTHONBAR="true",TAGOOR="[ OOR ] ",OVERHEAL=1,MAXCHARS=0,HMAXCHARS=0,HOFFSET=0,OUTLINE=1,OFFSET=0,INCHEALS=1,HLTHTXTANCHOR=2,FONT="Friz Quadrata TT",CLASSONBAR="false",CLASSTYPE=1,NUMFORMAT2=1,HHEIGHT=11,NUMFORMAT1=1,HOUTLINE=1,TAGRIP="[ RIP ] ",HEIGHT=10,NAMEONBAR="true",SHOWROLE="true",HALIGN=2,HLTHTYPE=1,TAGDC="[ DC ] ",IGNOREONFULL="true",INCABSORBS=1,HOFFSET2=0,ALIGN=2,TAGR="[ R ] ",HFONT="Swansea"}
BarText~d!3~4~5~6~7~8~9~10~
BarTextCol~f~1!{NAME=2,NCR=1,HLTH=2,NCDA=0.2,HCG=0.988,NDEBUFF="false",NCG=1,HCR=0.988,NCA=1,HCB=0.282,HCA=1,HDEBUFF="true",NCB=1,HCDA=0.1}
BarTextCol~f~2!{NAME=2,NCR=1,HLTH=3,NCDA=0.5,HCG=1,NDEBUFF="false",NCG=1,HCR=0.98,NCA=0.95,HCB=0.984,HCA=1,HDEBUFF="false",NCB=0,HCDA=0.3}
BarTextCol~d!3~4~5~6~7~8~9~10~
Icons~f~1!{SHOWBUFF="true",SHOWDEBUFF="true",FADESECS=5,MAXDICONS=5,DOUBLE="false",SHOWDIRMOUSE="false",SHOWDIR="false",FADE="true",DSCALE=0.45,ONBAR=1,SHOWRC="true",SCALE=0.5,POSITION=2,I15EN="true",MAXBICONS=10}
Icons~f~2!{SHOWBUFF="true",SHOWDEBUFF="true",FADESECS=15,MAXDICONS=4,DOUBLE="false",SHOWDIRMOUSE="false",SHOWDIR="false",FADE="true",DSCALE=0.5,ONBAR=1,SHOWRC="true",SCALE=0.5,POSITION=2,I15EN="true",MAXBICONS=8}
Icons~d!3~4~5~6~7~8~9~10~
RaidIcon~f~1!{SQUARE="false",CIRCLE="false",DIAMOND="false",SHOW="false",MOON="false",TRIANGLE="false",STAR="false",CROSS="false",SKULL="false"}
RaidIcon~d!2~3~4~5~6~7~8~9~10~
IconText~f~1!{DURWARN=5,HEIGHT=9,SSCNT="true",SCNT="true",DURTHRH=9,FONT="Swansea Bold",SDUR="true",SSDUR="true",OUTLINE=2}
IconText~f~2!{DURWARN=4,HEIGHT=10,SSCNT="true",SCNT="true",DURTHRH=9,FONT="Swansea",SDUR="true",SSDUR="true",OUTLINE=2}
IconText~d!3~4~5~6~7~8~9~10~
BarVisibility~f~1!{INCCLASSES=1,ALERTIC=1,ALERTOC=0.99,HIDEOOR="false"}
BarVisibility~f~2!{INCCLASSES=1,ALERTIC=0.98,ALERTOC=0.95,HIDEOOR="false"}
BarVisibility~d!3~4~5~6~7~8~9~10~
BarSort~f~1!{SUBORDER=5,OORLAST="false",RAIDORDER=3,SUBPF="true"}
BarSort~f~2!{SUBORDER=1,OORLAST="false",RAIDORDER=3,SUBPF="true"}
BarSort~d!3~4~5~6~7~8~9~10~
BarAggro~f~1!{R=0.992,SHOWTEXT="false",G=0,TEXTFORMAT=6,SHOW="true",SHOWTEXTPCT="false",ALERTIND=1,SHOWIND="false",B=0.071,ALERT=2}
BarAggro~f~2!{R=0.992,SHOWTEXT="false",G=0.22,TEXTFORMAT=3,SHOW="true",SHOWTEXTPCT="false",ALERTIND=2,SHOWIND="true",B=0.22,ALERT=2}
BarAggro~d!3~4~5~6~7~8~9~10~
AuxBarFrame~f~1!{OFREQ=0.2,OVERLAP=2,OMIN=0.1,OMAX=0.95}
AuxBarFrame~f~2!{OFREQ=0.07,OVERLAP=1,OMIN=0.1,OMAX=0.95}
AuxBarFrame~d!3~4~5~6~7~8~9~10~
AuxBar^1~f~1!{SIZE=0.25,USE=5,R=0.9,COLOUR=1,ANCHOR=2,OFFSET=1,DEPTH=2,G=0.2,B=0.2,A=1,OTYPE=1}
AuxBar^1~f~2!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,A=1,OTYPE=1}
AuxBar^1~d!3~4~5~6~7~8~9~10~
AuxBar^2~f~1!{SIZE=0.98,USE=8,R=1,COLOUR=3,ANCHOR=2,OFFSET=1,DEPTH=1,G=1,B=1,A=1,OTYPE=1}
AuxBar^2~f~2!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,A=1,OTYPE=1}
AuxBar^2~d!3~4~5~6~7~8~9~10~
AuxBar^3~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,A=1,OTYPE=1}
AuxBar^3~d!2~3~4~5~6~7~8~9~10~
AuxBar^4~f~1!{SIZE=0.98,USE=6,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,A=1,OTYPE=1}
AuxBar^4~f~2!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,A=1,OTYPE=1}
AuxBar^4~d!3~4~5~6~7~8~9~10~
AuxBar^5~f~1!{SIZE=0.98,USE=5,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=1,G=1,B=1,A=1,OTYPE=1}
AuxBar^5~f~2!{SIZE=0.98,USE=5,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=2,G=1,B=1,A=1,OTYPE=1}
AuxBar^5~d!3~4~5~6~7~8~9~10~
AuxBar^6~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,A=1,OTYPE=1}
AuxBar^6~d!2~3~4~5~6~7~8~9~10~
AuxBar^7~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,A=1,OTYPE=1}
AuxBar^7~d!2~3~4~5~6~7~8~9~10~
AuxBar^8~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,A=1,OTYPE=1}
AuxBar^8~d!2~3~4~5~6~7~8~9~10~
AuxBar^9~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,A=1,OTYPE=1}
AuxBar^9~d!2~3~4~5~6~7~8~9~10~
Complete!]]