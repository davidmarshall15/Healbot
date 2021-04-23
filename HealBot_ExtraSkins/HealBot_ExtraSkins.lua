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
                              [9]="Aphrahat 2020_10³",
                             [10]="Maddy's Large Raid Skin",
                             [11]="Maddy Disc",
                             [12]="Maddy's Classic Skin",
                             [13]="Vivid",
                             [14]="Square",
                             [15]="Ranged",
                             [16]="Magic",
                             [17]="Standard Original",
                             [18]="Group Original",
                             [19]="Raid Original",
                             [20]="Alterac Valley",
                             [21]="Bottoms Up cRaid 25",
                             [22]="Bottoms Up hRaid 25",
                             [23]="Bottoms Up cGroup",
                             [24]="Bottoms Up hGroup",
                             [25]="Bottoms Up hRaid 40",
                             [26]="Bottoms Up cRaid 40",
                             [27]="Bottoms Up cRaid 10",
                             [28]="Bottoms Up hRaid 10",
                             [29]="Bottoms Up Compact Group",
                             [30]="Bottoms Up Compact Small Raid",
                             [31]="Bottoms Up Compact Large Raid",
                             [32]="Aux Party",
                             [33]="Clarity Party",
                             [34]="Clarity Raid 10",
                             [35]="Clarity Raid 25",
                             [36]="Clarity Raid 40",
                             [37]="Compact Raid 40",
                             [38]="Compact Raid 25",
                             [39]="Compact Raid 10",
                             [40]="Compact Party",
                             [41]="Raid 40 Ravera",
                             [42]="Group 5",
                             [43]="cRaid25",
                             [44]="cRaid40",
                             [45]="B&W-Group",
                             [46]="B&W-Raid25",
                             [47]="B&W-Raid40",
                             [48]="High-Vis",
                             [49]="Retro-Raid",
                             [50]="Blended-Group",
                             [51]="Blended-Raid",
                             [52]="Kalimdor-5",
                             [53]="Kalimdor-25",
                             [54]="Kalimdor-40",
                             [55]="Kalimdor-10",
                             [56]="Dark Efficient 5",
                             [57]="Dark Efficient 25",
                             [58]="Dark Efficient 40",
                             [59]="Mirandinn Party",
                             [60]="Mirandinn Raid",
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
                            [10]=HEALBOT_EXTRASKINS_LARGE_RAID,
                            [11]=HEALBOT_EXTRASKINS_GROUP,
                            [12]=HEALBOT_EXTRASKINS_GROUP,
                            [13]=HEALBOT_EXTRASKINS_LARGE_RAID,
                            [14]=HEALBOT_EXTRASKINS_LARGE_RAID,
                            [15]=HEALBOT_EXTRASKINS_LARGE_RAID,
                            [16]=HEALBOT_EXTRASKINS_LARGE_RAID,
                            [17]=HEALBOT_EXTRASKINS_GROUP,
                            [18]=HEALBOT_EXTRASKINS_GROUP,
                            [19]=HEALBOT_EXTRASKINS_LARGE_RAID,
                            [20]=HEALBOT_EXTRASKINS_LARGE_RAID,
                            [21]=HEALBOT_EXTRASKINS_LARGE_RAID,
                            [22]=HEALBOT_EXTRASKINS_LARGE_RAID,
                            [23]=HEALBOT_EXTRASKINS_GROUP,
                            [24]=HEALBOT_EXTRASKINS_GROUP,
                            [25]=HEALBOT_EXTRASKINS_LARGE_RAID,
                            [26]=HEALBOT_EXTRASKINS_LARGE_RAID,
                            [27]=HEALBOT_EXTRASKINS_SMALL_RAID,
                            [28]=HEALBOT_EXTRASKINS_SMALL_RAID,
                            [29]=HEALBOT_EXTRASKINS_GROUP,
                            [30]=HEALBOT_EXTRASKINS_SMALL_RAID,
                            [31]=HEALBOT_EXTRASKINS_LARGE_RAID,
                            [32]=HEALBOT_EXTRASKINS_GROUP,
                            [33]=HEALBOT_EXTRASKINS_GROUP,
                            [34]=HEALBOT_EXTRASKINS_SMALL_RAID,
                            [35]=HEALBOT_EXTRASKINS_LARGE_RAID,
                            [36]=HEALBOT_EXTRASKINS_LARGE_RAID,
                            [37]=HEALBOT_EXTRASKINS_LARGE_RAID,
                            [38]=HEALBOT_EXTRASKINS_LARGE_RAID,
                            [39]=HEALBOT_EXTRASKINS_SMALL_RAID,
                            [40]=HEALBOT_EXTRASKINS_GROUP,
                            [41]=HEALBOT_EXTRASKINS_LARGE_RAID,
                            [42]=HEALBOT_EXTRASKINS_GROUP,
                            [43]=HEALBOT_EXTRASKINS_LARGE_RAID,
                            [44]=HEALBOT_EXTRASKINS_LARGE_RAID,
                            [45]=HEALBOT_EXTRASKINS_GROUP,
                            [46]=HEALBOT_EXTRASKINS_LARGE_RAID,
                            [47]=HEALBOT_EXTRASKINS_LARGE_RAID,
                            [48]=HEALBOT_EXTRASKINS_GROUP,
                            [49]=HEALBOT_EXTRASKINS_LARGE_RAID,
                            [50]=HEALBOT_EXTRASKINS_GROUP,
                            [51]=HEALBOT_EXTRASKINS_LARGE_RAID,
                            [52]=HEALBOT_EXTRASKINS_GROUP,
                            [53]=HEALBOT_EXTRASKINS_LARGE_RAID,
                            [54]=HEALBOT_EXTRASKINS_LARGE_RAID,
                            [55]=HEALBOT_EXTRASKINS_SMALL_RAID,
                            [56]=HEALBOT_EXTRASKINS_GROUP,
                            [57]=HEALBOT_EXTRASKINS_LARGE_RAID,
                            [58]=HEALBOT_EXTRASKINS_LARGE_RAID,
                            [59]=HEALBOT_EXTRASKINS_GROUP,
                            [60]=HEALBOT_EXTRASKINS_LARGE_RAID,
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
HealBot_ExtraSkinDesc[1]=[[Group Skin
==================
Aux Aggro is a 5 man skin using horizontal bars
with threat above and power below the health bar
then the whole wrapped in aggro bars.
The skin is placed on the right of the screen.]]
HealBot_ExtraSkinDesc[2]=[[Small Raid Skin
=====================
Raid10 is a raid skin using horizontal bars
with buffs left of the health bar,
debuffs right of the health bar,
power below the health bar,
threat above the health bar
and aggro below and above threat and power.
The skin is placed on the right of the screen.]]
HealBot_ExtraSkinDesc[3]=[[Large Raid Skin
=====================
Verena is a raid skin using horizontal bars
with power and aggro below the health bar.
The skin is placed on the bottom of the screen.]]
HealBot_ExtraSkinDesc[4]=[[Group Skin
==================
Aux Group is a 5 man skin using horizontal bars
with threat and aggro left of the health bar,
incoming heals and overheals right of the health bar,
power below the health bar and buff/debuff above the health bar.
The skin is placed on the right of the screen.]]
HealBot_ExtraSkinDesc[5]=[[Group Skin
==================
Aux Group is a 5 man skin using horizontal bars
with aggro above and below the health bar.
The skin is placed on the left of the screen.]]
HealBot_ExtraSkinDesc[6]=[[Large Raid Skin
=====================
Gridlike 40 is a raid 40 grid like skin
with power below the health bar.
The skin is placed on the left of the screen.]]
HealBot_ExtraSkinDesc[7]=[[Large Raid Skin
=====================
Full 25 is a raid 25 skin using horizontal bars.
The skin is placed on the right of the screen.]]
HealBot_ExtraSkinDesc[8]=[[Large Raid Skin
=====================
Full 40 is a raid 40 skin using horizontal bars.
The skin is placed on the right of the screen.]]
HealBot_ExtraSkinDesc[9]=[[Group Skin
==================
Aphrahat 2020_10³ is a 5 man skin using horizontal bars
with an interesting use of Aux bar and text.
The skin is placed slightly to the right of the screen.]]
HealBot_ExtraSkinDesc[10]=[[Large Raid Skin
=====================
Maddy's Large Raid Skin is a raid skin using 
horizontal bars with aggro below the health bar.
The skin is placed on the left of the screen.]]
HealBot_ExtraSkinDesc[11]=[[Group Skin
==================
Maddy Disc is a 5 man skin using horizontal 
bars with aggro below the health bar.
The skin is placed on the left of the screen.]]
HealBot_ExtraSkinDesc[12]=[[Group Skin
==================
Maddy's Classic Skin is a 5 man skin using horizontal 
bars with aggro below the health bar.
The skin is placed on the left of the screen.]]
HealBot_ExtraSkinDesc[13]=[[Large Raid Skin
=====================
Vivid is a raid skin using horizontal bars
with aggro below the health bar.
This is a very old Healbot Skins, removed before 5.1.0.0, 
slightly updated to use Frames and Sticky Frames.
The skin is placed on the left of the screen.]]
HealBot_ExtraSkinDesc[14]=[[Large Raid Skin
=====================
Square is a raid skin using horizontal bars.
This is a very old Healbot Skins, removed in 5.1.0.2.
The skin is placed on the left of the screen.]]
HealBot_ExtraSkinDesc[15]=[[Large Raid Skin
=====================
Ranged is a raid skin using horizontal bars.
This is a very old Healbot Skins, removed in 5.1.0.2.
The skin is placed on the left of the screen.]]
HealBot_ExtraSkinDesc[16]=[[Large Raid Skin
=====================
Magic is a raid skin using horizontal bars.
This is a very old Healbot Skins, removed in 5.1.0.2.
The skin is placed on the left of the screen.]]
HealBot_ExtraSkinDesc[17]=[[Group Skin
==================
Standard Original is a 5 man skin using horizontal bars
with aggro above and below the health bar.
This is the original standard skin that was replaced in 8.2.
The skin is placed on the left of the screen.]]
HealBot_ExtraSkinDesc[18]=[[Group Skin
==================
Group Original is a 5 man skin using horizontal bars
with aggro above the health bar and power below the health bar.
This is the original group skin that was replaced in 8.2.
The skin is placed on the right of the screen.]]
HealBot_ExtraSkinDesc[19]=[[Large Raid Skin
=====================
Raid Original is a raid skin using horizontal bars
with aggro above the health bar and power below the health bar.
This is the original group skin that was replaced in 8.2.
The skin is placed on the right of the screen.]]
HealBot_ExtraSkinDesc[20]=[[Large Raid Skin
=====================
Alterac Valley is a raid skin using horizontal bars
with aggro above and below the health bar.
This is an original skin that was replaced in 8.2.
The skin is placed on the right of the screen.]]
HealBot_ExtraSkinDesc[21]=[[Large Raid Skin
=====================
Bottoms Up cRaid 25 is a raid skin using vertical bars
with aggro above and below the health bar, Incoming heals 
and absorbs on the left and right sides of the health bar.
Bottoms Up cRaid 25 is class colours themed.
The skin is placed on the right of the screen.]]
HealBot_ExtraSkinDesc[22]=[[Large Raid Skin
=====================
Bottoms Up hRaid 25 is a raid skin using vertical bars
with aggro surronding the health bar, Incoming heals 
and a large power bar right sides of the health bar.
Bottoms Up hRaid 25 is class colours themed.
The skin is placed on the right of the screen.]]
HealBot_ExtraSkinDesc[23]=[[Group Skin
==================
Bottoms Up cGroup is a group skin using vertical bars
with aggro above and below the health bar, Incoming heals 
and absorbs on the left and right sides of the health bar.
Bottoms Up cGroup is class colours themed.
The skin is placed on the right of the screen.]]
HealBot_ExtraSkinDesc[24]=[[Group Skin
==================
Bottoms Up hGroup is a group skin using vertical bars
with aggro surronding the health bar, Incoming heals 
and a large power bar right sides of the health bar.
Bottoms Up hGroup is class colours themed.
The skin is placed on the right of the screen.]]
HealBot_ExtraSkinDesc[25]=[[Large Raid Skin
=====================
Bottoms Up hRaid 40 is a raid skin using vertical bars
with aggro surronding the health bar, Incoming heals 
and a large power bar right sides of the health bar.
Bottoms Up hRaid 40 is class colours themed.
The skin is placed on the right of the screen.]]
HealBot_ExtraSkinDesc[26]=[[Large Raid Skin
=====================
Bottoms Up cRaid 40 is a raid skin using vertical bars
with aggro above and below the health bar, Incoming heals 
and absorbs on the left and right sides of the health bar.
Bottoms Up cRaid 40 is class colours themed.
The skin is placed on the right of the screen.]]
HealBot_ExtraSkinDesc[27]=[[Large Raid Skin
=====================
Bottoms Up cRaid 10 is a raid skin using vertical bars
with aggro above and below the health bar, Incoming heals 
and absorbs on the left and right sides of the health bar.
Bottoms Up cRaid 10 is class colours themed.
The skin is placed on the right of the screen.]]
HealBot_ExtraSkinDesc[28]=[[Small Raid Skin
=====================
Bottoms Up hRaid 10 is a raid skin using vertical bars
with aggro surronding the health bar, Incoming heals 
and a large power bar right sides of the health bar.
Bottoms Up hRaid 10 is class colours themed.
The skin is placed on the right of the screen.]]
HealBot_ExtraSkinDesc[29]=[[Group Skin
==================
Bottoms Up Compact Group is a group skin using vertical bars
with aggro surrounding the health bar, threat on the left 
and power on the right sides of the health bar.
Bottoms Up Compact Group is class colours themed.
The skin is placed on the right of the screen.]]
HealBot_ExtraSkinDesc[30]=[[Small Raid Skin
=====================
Bottoms Up Compact Small Raid is a raid skin using vertical bars
with aggro surrounding the health bar, threat on the left 
and power on the right sides of the health bar.
Bottoms Up Compact Small Raid is class colours themed.
The skin is placed on the right of the screen.]]
HealBot_ExtraSkinDesc[31]=[[Large Raid Skin
=====================
Bottoms Up Compact Large Raid is a raid skin using vertical bars
with aggro surrounding the health bar, threat on the left 
and power on the right sides of the health bar.
Bottoms Up Compact Large Raid is class colours themed.
The skin is placed on the right of the screen.]]
HealBot_ExtraSkinDesc[32]=[[Group Skin
==================
Aux Party is a 5 man skin using horizontal bars
with threat left of the health bar,  overheals right of the 
health bar, aggro left and right of the health bar,
power below the health bar and buff/debuff above the health bar.
The skin is placed on the right of the screen.]]
HealBot_ExtraSkinDesc[33]=[[Group Skin
==================
Clarity Party is a 5 man skin using horizontal bars
with threat left of the health bar, overheals right of the 
health bar, power below the health bar and buff/debuff/aggro 
above the health bar. This skin turns bars,text and icons
transparent when the player doesn't needs a heal, buff, etc.
The skin is placed on the left of the screen.]]
HealBot_ExtraSkinDesc[34]=[[Small Raid Skin
=====================
Clarity Raid 10 is a 10 man skin using horizontal bars
with threat left of the health bar, overheals right of the 
health bar, power below the health bar and buff/debuff/aggro 
above the health bar. This skin turns bars,text and icons
transparent when the player doesn't needs a heal, buff, etc.
The skin is placed on the left of the screen.]]
HealBot_ExtraSkinDesc[35]=[[Large Raid Skin
=====================
Clarity Raid 25 is a 25 man skin using horizontal bars
with threat left of the health bar, overheals right of the 
health bar, power below the health bar and buff/debuff/aggro 
above the health bar. This skin turns bars,text and icons
transparent when the player doesn't needs a heal, buff, etc.
The skin is placed on the left of the screen.]]
HealBot_ExtraSkinDesc[36]=[[Large Raid Skin
=====================
Clarity Raid 40 is a 40 man skin using horizontal bars
with threat left of the health bar, overheals right of the 
health bar, power below the health bar and buff/debuff/aggro 
above the health bar. This skin turns bars,text and icons
transparent when the player doesn't needs a heal, buff, etc.
The skin is placed on the left of the screen.]]
HealBot_ExtraSkinDesc[37]=[[Large Raid Skin
=====================
Compact Raid 40 is a 40 man skin using horizontal bars
with power below the health bar and buff/debuff/aggro 
above the health bar. This is a compact skin.
The skin is placed on the left of the screen.]]
HealBot_ExtraSkinDesc[38]=[[Large Raid Skin
=====================
Compact Raid 25 is a 25 man skin using horizontal bars
with power below the health bar and buff/debuff/aggro 
above the health bar. This is a compact skin.
The skin is placed on the left of the screen.]]
HealBot_ExtraSkinDesc[39]=[[Small Raid Skin
=====================
Compact Raid 10 is a 10 man skin using horizontal bars
with power below the health bar and buff/debuff/aggro 
above the health bar. This is a compact skin.
The skin is placed on the left of the screen.]]
HealBot_ExtraSkinDesc[40]=[[Group Skin
==================
Compact Party is a 5 man skin using horizontal bars
with power below the health bar and buff/debuff/aggro 
above the health bar. This is a compact skin.
The skin is placed on the left of the screen.]]
HealBot_ExtraSkinDesc[41]=[[Large Raid Skin
=====================
Raid 40 Ravera is a 40 man skin using horizontal bars
with power below the health bar. This is a compact skin.
The skin is placed at the bottom of the screen.]]
HealBot_ExtraSkinDesc[42]=[[Group Skin
==================
Group 5 is a 5 man skin using horizontal bars.
The skin is placed on the right of the screen.]]
HealBot_ExtraSkinDesc[43]=[[Large Raid Skin
=====================
cRaid25 is a 25 man skin using horizontal bars
with power below the health bar.
The skin is placed on the right of the screen.]]
HealBot_ExtraSkinDesc[44]=[[Large Raid Skin
=====================
cRaid40 is a 40 man skin using horizontal bars
with power below the health bar.
The skin is placed on the right of the screen.]]
HealBot_ExtraSkinDesc[45]=[[Group Skin
=====================
B&W-Group is a group skin using horizontal bars
with aggro bars above and below the health bar.
The skin is placed on the left of the screen.]]
HealBot_ExtraSkinDesc[46]=[[Large Raid Skin
=====================
B&W-Raid25 is a 25 man raid skin using horizontal bars
with aggro bars above and below the health bar.
The skin is placed on the left of the screen.]]
HealBot_ExtraSkinDesc[47]=[[Large Raid Skin
=====================
B&W-Raid40 is a 40 man raid skin using horizontal bars
with aggro bars above and below the health bar.
The skin is placed on the left of the screen.]]
HealBot_ExtraSkinDesc[48]=[[Group Skin
=====================
High-Vis is a group skin using horizontal bars
with aggro bars above and below the health bar.
The skin is placed on the right of the screen.]]
HealBot_ExtraSkinDesc[49]=[[Large Raid Skin
=====================
Retro Raid is a 25 or 40 man raid skin using horizontal bars
with a power bar below the health bar.
The skin is placed on the left of the screen.]]
HealBot_ExtraSkinDesc[50]=[[Group Skin
==================
Blended-Group is a group skin using horizontal bars
with aggro above and below the health bar.
The skin is placed on the right of the screen.]]
HealBot_ExtraSkinDesc[51]=[[Large Raid Skin
==================
Blended-Raid is a raid skin using horizontal bars
with aggro above and below the health bar.
The skin is placed on the right of the screen.]]
HealBot_ExtraSkinDesc[52]=[[Group Skin
==================
Kalimdor-5 is a group skin using horizontal bars
with aggro below the health bar.
The skin is placed on the right of the screen.]]
HealBot_ExtraSkinDesc[53]=[[Large Raid Skin
==================
Kalimdor-25 is a 25 man raid skin using horizontal
bars with aggro below the health bar.
The skin is placed on the right of the screen.]]
HealBot_ExtraSkinDesc[54]=[[Large Raid Skin
==================
Kalimdor-40 is a 40 man raid skin using horizontal
bars with aggro below the health bar.
The skin is placed on the right of the screen.]]
HealBot_ExtraSkinDesc[55]=[[Small Raid Skin
==================
Kalimdor-10 is a 10 man raid skin using horizontal
bars with aggro below the health bar.
The skin is placed on the right of the screen.]]
HealBot_ExtraSkinDesc[56]=[[Group Skin
==================
Dark Efficient 5 is a dark themed group skin 
using horizontal bars with aggro below the health bar.
The skin options are set to use minimal cpu.
The skin is placed on the right of the screen.]]
HealBot_ExtraSkinDesc[57]=[[Large Raid Skin
==================
Dark Efficient 25 is a dark themed 25 man raid skin
using horizontal bars surrounded with aggro bars.
The skin options are set to use minimal cpu.
The skin is placed on the right of the screen.]]
HealBot_ExtraSkinDesc[58]=[[Large Raid Skin
==================
Dark Efficient 40 is a dark themed 40 man raid skin
using horizontal bars surrounded with aggro bars.
The skin options are set to use minimal cpu.
The skin is placed on the right of the screen.]]
HealBot_ExtraSkinDesc[59]=[[Group Skin
=====================
Mirandinn Party is a group skin using horizontal bars
with power and aggro bars below the health bar.
The skin is placed on the left of the screen.]]
HealBot_ExtraSkinDesc[60]=[[Large Raid Skin
=====================
Mirandinn Raid is a 25 man raid skin using horizontal bars
with an aggro bar below the health bar.
The skin is placed on the left of the screen.]]

HealBot_ExtraSkinData[1]=[[Skin
Aux Aggro
Author~v!Monti of Terenas
DuplicateBars~v!false
Chat~t!{EOCOOM="true",EOCOOMV=5,MSG="Casting #s on #n",RESONLY="true",CHAN="",NOTIFY=2}
General~t!{OFREQ=0.07,STICKYSENSITIVITY=25,FLUIDBARS="true",HIDEBOSSF="true",HIDEPARTYF="false",OMAX=1,HIDERAIDF="true",HIDEPTF="false",STICKYFRAME="true",OMIN=0.2,FLUIDFREQ=10}
Healing~t!{TINCSELF="false",GROUPPETS="true",TARGETINCOMBAT=1,TINCGROUP="true",FONLYFRIEND="true",FEXRAID="false",TONLYFRIEND="false",FALWAYSSHOW="false",FOCUSINCOMBAT=2,TALWAYSSHOW="false",SELFPET=0,TINCPET="false",TEXRAID="false",TINCRAID="true"}
Enemy~t!{INCARENA="false",INCTANKS="true",INCMYTAR="false",ENEMYTARGET="true",ENEMYTARGETSIZE=58,INCARENAPETS="false",INCSELF="false",NUMBOSS=4,EXISTSHOWPTAR=1,HIDE="true",EXISTSHOWBOSS="true",DOUBLEWIDTH="false",EXISTSHOWARENA=2}
FrameAlias~f~1!{SIZE=12,NAME="Party",R=1,ALIAS="Party",G=1,SHOW="true",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~2!{SIZE=12,NAME="Tank and Healer",R=1,ALIAS="Not Used",G=1,SHOW="true",OFFSET=1,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~3!{SIZE=12,NAME="Pets",R=1,ALIAS="Not Used 1",G=1,SHOW="true",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~4!{SIZE=12,NAME="Focus and Target",R=1,ALIAS="Not Used 2",G=1,SHOW="true",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~5!{SIZE=12,NAME="Enemy",R=1,ALIAS="Not Used 3",G=1,SHOW="true",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~6!{SIZE=12,NAME="",R=1,ALIAS="Vehicle",G=1,SHOW="true",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~7!{SIZE=12,NAME="Pets",R=1,ALIAS="Pets",G=1,SHOW="true",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~8!{SIZE=12,NAME="Target",R=1,ALIAS="Target",G=1,SHOW="true",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~9!{SIZE=12,NAME="",R=1,ALIAS="Focus",G=1,SHOW="true",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~10!{SIZE=12,NAME="Enemy",R=1,ALIAS="Enemy",G=0,SHOW="true",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=0,OUTLINE=1}
FrameAliasBar~f~1!{A=0.25,TEXTURE="Diagonal",B=0.1,HEIGHT=20,R=0.1,G=0.1,WIDTH=0.9}
FrameAliasBar~d!2~3~4~5~6~7~8~9~10~
Frame~f~1!{BACKR=0.02,AUTOCLOSE="false",BACKG=0.016,BORDERB=0,LOCKED="false",SCALE=1,BORDERA=0,BORDERG=0,TIPLOC=2,BACKB=0.016,BACKA=0.33,OPENSOUND="false",SFOFFSETV=0,BORDERR=0.976,SFOFFSETH=0}
Frame~f~2!{BACKR=0.102,AUTOCLOSE="false",BACKG=0.102,BORDERB=0.102,LOCKED="true",SCALE=1,BORDERA=0,BORDERG=0.102,TIPLOC=1,BACKB=0.502,BACKA=0.04,OPENSOUND="false",SFOFFSETV=0,BORDERR=0.102,SFOFFSETH=2}
Frame~f~3!{BACKR=0.1,AUTOCLOSE="false",BACKG=0.1,BORDERB=0.1,LOCKED="false",SCALE=1,BORDERA=0.5,BORDERG=0.1,TIPLOC=2,BACKB=0.5,BACKA=0.2,OPENSOUND="false",SFOFFSETV=0,BORDERR=0.1,SFOFFSETH=0}
Frame~d!4~
Frame~f~5!{BACKR=0.1,AUTOCLOSE="false",BACKG=0.1,BORDERB=0.1,LOCKED="false",SCALE=1,BORDERA=0.5,BORDERG=0.1,TIPLOC=4,BACKB=0.5,BACKA=0.2,OPENSOUND="false",SFOFFSETV=0,BORDERR=0.1,SFOFFSETH=0}
Frame~f~6!{BACKR=0.1,AUTOCLOSE="false",BACKG=0.1,BORDERB=0.1,LOCKED="false",SCALE=1,BORDERA=0.5,BORDERG=0.1,TIPLOC=5,BACKB=0.5,BACKA=0.2,OPENSOUND="false",SFOFFSETV=0,BORDERR=0.1,SFOFFSETH=0}
Frame~f~7!{BACKR=0.102,AUTOCLOSE="false",BACKG=0.102,BORDERB=0.102,LOCKED="true",SCALE=1,BORDERA=0.01,BORDERG=0.102,TIPLOC=5,BACKB=0.502,BACKA=0.01,OPENSOUND="false",SFOFFSETV=7,BORDERR=0.102,SFOFFSETH=0}
Frame~f~8!{BACKR=0.102,AUTOCLOSE="false",BACKG=0.102,BORDERB=0.102,LOCKED="false",SCALE=1,BORDERA=0,BORDERG=0.102,TIPLOC=5,BACKB=0.502,BACKA=0,OPENSOUND="false",SFOFFSETV=0,BORDERR=0.102,SFOFFSETH=5}
Frame~f~9!{BACKR=0.102,AUTOCLOSE="false",BACKG=0.102,BORDERB=0.102,LOCKED="false",SCALE=1,BORDERA=0,BORDERG=0.102,TIPLOC=5,BACKB=0.502,BACKA=0,OPENSOUND="false",SFOFFSETV=0,BORDERR=0.102,SFOFFSETH=8}
Frame~f~10!{BACKR=0.102,AUTOCLOSE="false",BACKG=0.102,BORDERB=0.102,LOCKED="false",SCALE=1,BORDERA=0.1,BORDERG=0.102,TIPLOC=2,BACKB=0.502,BACKA=0.05,OPENSOUND="false",SFOFFSETV=-4,BORDERR=0.102,SFOFFSETH=0}
StickyFrames~f~1!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~f~2!{STUCK="true",STUCKTOPOINT="TOPLEFT",STUCKTO=1,STUCKPOINT="TOPRIGHT"}
StickyFrames~f~3!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~d!4~5~6~
StickyFrames~f~7!{STUCK="true",STUCKTOPOINT="BOTTOMRIGHT",STUCKTO=1,STUCKPOINT="TOPRIGHT"}
StickyFrames~f~8!{STUCK="true",STUCKTOPOINT="TOPLEFT",STUCKTO=1,STUCKPOINT="TOPRIGHT"}
StickyFrames~f~9!{STUCK="true",STUCKTOPOINT="LEFT",STUCKTO=1,STUCKPOINT="RIGHT"}
StickyFrames~f~10!{STUCK="true",STUCKTOPOINT="TOPLEFT",STUCKTO=1,STUCKPOINT="BOTTOMLEFT"}
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
Anchors~f~1!{Y=69.03,GROW=2,BARS=1,FRAME=3,X=95.99}
Anchors~f~2!{Y=60.12,GROW=2,BARS=1,FRAME=3,X=88.68}
Anchors~f~3!{Y=55.37,GROW=2,BARS=3,FRAME=3,X=94.92}
Anchors~f~4!{Y=64.17,GROW=2,BARS=1,FRAME=1,X=83.17}
Anchors~f~5!{Y=65.23,GROW=2,BARS=2,FRAME=2,X=89.04}
Anchors~f~6!{Y=55,GROW=2,BARS=1,FRAME=1,X=55}
Anchors~f~7!{Y=56.02,GROW=2,BARS=1,FRAME=3,X=79.96}
Anchors~f~8!{Y=69.03,GROW=2,BARS=1,FRAME=3,X=89.5}
Anchors~f~9!{Y=66.66,GROW=2,BARS=1,FRAME=7,X=89.61}
Anchors~f~10!{Y=70.36,GROW=2,BARS=4,FRAME=2,X=89.33}
HeadBar~f~1!{SHOW="false",TEXTURE="Diagonal",R=0.506,B=0.506,HEIGHT=30,A=0.4,G=0.506,WIDTH=0.9}
HeadBar~d!2~3~4~5~6~7~8~9~10~
HeadText~f~1!{A=0.7,R=0.2,OFFSET=0,B=0.8,FONT="Friz Quadrata TT",HEIGHT=10,G=0.8,OUTLINE=1}
HeadText~d!2~3~4~5~6~7~8~9~10~
HealBar~f~1!{HEIGHT=40,GRPCOLS="false",CMARGIN=4,TEXTURE="Smooth v2",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=175,RMARGIN=0,OFIX=1,NUMCOLS=1,LOWMANA=3}
HealBar~f~2!{HEIGHT=40,GRPCOLS="false",CMARGIN=4,TEXTURE="Smooth v2",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=175,RMARGIN=0,OFIX=1,NUMCOLS=1,LOWMANA=2}
HealBar~d!3~4~5~6~7~8~9~10~
BarCol~f~1!{BACK=3,BA=0.2,BB=0.02,DISA=0,BR=0.02,HB=0.9,BG=0.02,HR=0.2,HA=1,HG=0.2,ORA=0.25,BOUT=0,HLTH=2}
BarCol~d!2~3~4~5~6~7~8~9~10~
BarIACol~f~1!{AC=4,AB=0.969,AA=0.4,AR=1,AG=0.945,IC=2,IB=0.2,IA=0.4,IR=0.2,IG=0.9}
BarIACol~d!2~3~4~5~6~7~8~9~10~
BarText~f~1!{HLTHONBAR="true",TAGOOR="OOR-",OVERHEAL=1,MAXCHARS=0,HMAXCHARS=0,OFFSET=2,HOFFSET=1,IGNOREONFULL="true",INCHEALS=2,HLTHTXTANCHOR=1,HLTHTYPE=1,FONT="Friz Quadrata TT",CLASSONBAR="false",NUMFORMAT2=1,HOUTLINE=1,TAGDC="[ DC ]",NUMFORMAT1=11,NAMEONBAR="true",HEIGHT=13,HFONT="Friz Quadrata TT",SHOWROLE="true",HALIGN=2,TAGRIP="RIP-",HHEIGHT=14,INCABSORBS=1,HOFFSET2=0,ALIGN=2,TAGR="[ R ] ",OUTLINE=1}
BarText~f~2!{HLTHONBAR="true",TAGOOR="OOR-",OVERHEAL=1,MAXCHARS=0,HMAXCHARS=0,OFFSET=2,HOFFSET=1,IGNOREONFULL="false",INCHEALS=2,HLTHTXTANCHOR=1,HLTHTYPE=1,FONT="Friz Quadrata TT",CLASSONBAR="false",NUMFORMAT2=1,HOUTLINE=1,TAGDC="[ DC ]",NUMFORMAT1=11,NAMEONBAR="true",HEIGHT=13,HFONT="Friz Quadrata TT",SHOWROLE="true",HALIGN=2,TAGRIP="RIP-",HHEIGHT=14,INCABSORBS=1,HOFFSET2=0,ALIGN=2,TAGR="[ R ] ",OUTLINE=1}
BarText~f~3!{HHEIGHT=14,TAGOOR="OOR-",IGNOREONFULL="true",MAXCHARS=0,HMAXCHARS=0,HLTHTYPE=1,OUTLINE=1,HOUTLINE=1,INCHEALS=2,HLTHTXTANCHOR=1,FONT="Friz Quadrata TT",OFFSET=2,CLASSONBAR="false",NUMFORMAT2=1,OVERHEAL=1,TAGDC="[ DC ]",NUMFORMAT1=11,NAMEONBAR="true",HEIGHT=13,HFONT="Friz Quadrata TT",SHOWROLE="true",HALIGN=2,TAGRIP="RIP-",HLTHONBAR="true",INCABSORBS=1,HOFFSET2=0,ALIGN=2,TAGR="[ R ] ",HOFFSET=1}
BarText~d!4~5~6~7~8~9~10~
BarTextCol~f~1!{NAME=2,NDEBUFF="false",NCB=0,NCDA=0.8,HCG=0,HCA=1,HCB=0,NCA=1,NCR=0.996,NCG=0.91,HCR=0,HDEBUFF="false",HCDA=0.5,HLTH=1}
BarTextCol~d!2~3~4~5~6~7~8~9~10~
Icons~f~1!{RCEN="true",I15EN="false",CLASSEN="false",BUFFANCHOR=2,BUFFFADE="false",DEBUFFANCHOR=1,RCVOFFSET=-2,OORVOFFSET=0,DEBUFFDOUBLE="false",TARGETVOFFSET=0,BUFFONBAR=1,SHOWDIR="false",SHOWRC="true",TARGETANCHOR=6,RCSCALE=0.55,MAXBICONS=8,FADESECS=15,RCHOFFSET=0,TARGETHOFFSET=-25,CLASSONBAR=3,CLASSVOFFSET=0,FADE="false",DSCALE=0.4,OORHOFFSET=0,SHOWCLASS="true",BUFFDOUBLE="false",TARGETONBAR=3,TARGETEN="true",TARGETSCALE=0.4,RCANCHOR=3,CLASSSCALE=0.4,RCONBAR=3,MAXDICONS=4,OORANCHOR=1,SHOWDIRMOUSE="false",CLASSANCHOR=5,CLASSHOFFSET=25,DEBUFFONBAR=1,OORONBAR=3,BUFFI15EN="false",BUFFFADESECS=15,OORSCALE=0.5,SCALE=0.4,OOREN="false",SHOWROLE="true"}
Icons~f~2!{RCEN="true",I15EN="false",CLASSEN="false",FADE="false",BUFFFADE="false",DEBUFFANCHOR=1,RCVOFFSET=-2,OORVOFFSET=0,DEBUFFDOUBLE="false",TARGETVOFFSET=0,BUFFONBAR=1,SHOWDIR="false",SHOWRC="true",TARGETANCHOR=6,RCSCALE=0.55,MAXBICONS=8,FADESECS=15,RCHOFFSET=0,TARGETHOFFSET=-25,CLASSONBAR=3,CLASSVOFFSET=0,SHOWCLASS="false",DSCALE=0.4,OORHOFFSET=0,SHOWROLE="true",SCALE=0.4,TARGETONBAR=3,TARGETEN="true",TARGETSCALE=0.4,RCANCHOR=3,CLASSSCALE=0.4,RCONBAR=3,MAXDICONS=4,OORANCHOR=1,OORONBAR=3,CLASSANCHOR=5,CLASSHOFFSET=25,DEBUFFONBAR=1,BUFFANCHOR=2,BUFFI15EN="false",BUFFFADESECS=15,OORSCALE=0.5,BUFFDOUBLE="false",OOREN="false",SHOWDIRMOUSE="false"}
Icons~d!3~4~5~6~
Icons~f~7!{RCEN="true",I15EN="false",CLASSEN="false",BUFFANCHOR=2,BUFFFADE="false",DEBUFFANCHOR=1,RCVOFFSET=-2,OORVOFFSET=0,DEBUFFDOUBLE="false",TARGETVOFFSET=0,BUFFONBAR=1,SHOWDIR="false",SHOWRC="true",TARGETANCHOR=6,RCSCALE=0.55,MAXBICONS=4,FADESECS=15,RCHOFFSET=0,TARGETHOFFSET=-25,CLASSONBAR=3,CLASSVOFFSET=0,FADE="false",DSCALE=0.4,OORHOFFSET=0,SHOWCLASS="false",BUFFDOUBLE="false",TARGETONBAR=3,TARGETEN="true",TARGETSCALE=0.4,RCANCHOR=3,CLASSSCALE=0.4,RCONBAR=3,MAXDICONS=2,OORANCHOR=1,SHOWDIRMOUSE="false",CLASSANCHOR=5,CLASSHOFFSET=25,DEBUFFONBAR=1,OORONBAR=3,BUFFI15EN="false",BUFFFADESECS=15,OORSCALE=0.5,SCALE=0.4,OOREN="false",SHOWROLE="true"}
Icons~f~8!{RCEN="true",I15EN="false",CLASSEN="false",BUFFANCHOR=2,BUFFFADE="false",DEBUFFANCHOR=1,RCVOFFSET=-2,OORVOFFSET=0,DEBUFFDOUBLE="false",TARGETVOFFSET=0,BUFFONBAR=1,SHOWDIR="false",SHOWRC="true",TARGETANCHOR=6,RCSCALE=0.55,MAXBICONS=8,FADESECS=15,RCHOFFSET=0,TARGETHOFFSET=-25,CLASSONBAR=3,CLASSVOFFSET=0,FADE="false",DSCALE=0.4,OORHOFFSET=0,SHOWCLASS="false",BUFFDOUBLE="false",TARGETONBAR=3,TARGETEN="true",TARGETSCALE=0.4,RCANCHOR=3,CLASSSCALE=0.4,RCONBAR=3,MAXDICONS=4,OORANCHOR=1,SHOWDIRMOUSE="false",CLASSANCHOR=5,CLASSHOFFSET=25,DEBUFFONBAR=1,OORONBAR=3,BUFFI15EN="false",BUFFFADESECS=15,OORSCALE=0.5,SCALE=0.4,OOREN="false",SHOWROLE="true"}
Icons~d!9~10~
RaidIcon~f~1!{SQUARE="true",CIRCLE="true",DIAMOND="true",SHOW="true",MOON="true",TRIANGLE="true",STAR="true",CROSS="true",SKULL="true"}
RaidIcon~d!2~3~4~5~6~7~8~9~10~
IconText~f~1!{DURWARN=3,BUFFSSDUR="true",BUFFOUTLINE=2,BUFFDURTHRH=9,SCNT="true",DURTHRH=9,FONT="Friz Quadrata TT",BUFFFONT="Friz Quadrata TT",BUFFSCNT="true",SSCNT="false",OUTLINE=2,BUFFDURWARN=3,SDUR="true",BUFFSSCNT="false",HEIGHT=10,BUFFHEIGHT=10,SSDUR="true",BUFFSDUR="true"}
IconText~d!2~3~4~5~6~7~8~9~10~
BarVisibility~f~1!{INCCLASSES=1,ALERTIC=1,ALERTOC=0.95,HIDEOOR="false"}
BarVisibility~d!2~3~4~5~6~7~8~9~10~
BarSort~f~1!{SUBORDER=1,OORLAST="false",RAIDORDER=1,SUBPF="true"}
BarSort~d!2~3~4~5~6~7~8~9~10~
BarAggro~f~1!{R=1,ALERTIND=2,G=0.024,TEXTFORMAT=3,SHOW="true",SHOWTEXTPCT="true",SHOWIND="true",SHOWTEXT="false",B=0.024,ALERT=2}
BarAggro~d!2~3~4~5~6~7~8~9~10~
AuxBarFrame~f~1!{OVERLAP=1}
AuxBarFrame~d!2~3~4~5~6~7~8~9~10~
AuxBar^1~f~1!{SIZE=1,USE=6,R=0.906,COLOUR=3,ANCHOR=2,OFFSET=0,DEPTH=3,G=0.294,OTYPE=1,B=0.102}
AuxBar^1~d!2~3~4~5~6~7~8~9~
AuxBar^1~f~10!{SIZE=1,USE=1,B=0.102,COLOUR=3,ANCHOR=2,OFFSET=0,DEPTH=3,R=0.906,OTYPE=1,G=0.294}
AuxBar^2~f~1!{SIZE=1,USE=4,R=0.067,COLOUR=1,ANCHOR=1,OFFSET=0,DEPTH=4,G=0.918,OTYPE=1,B=0.035}
AuxBar^2~d!2~3~4~5~6~7~8~9~10~
AuxBar^3~f~1!{SIZE=0.58,USE=1,R=0.7,COLOUR=1,ANCHOR=4,OFFSET=-2,DEPTH=2,G=0.7,OTYPE=1,B=0.2}
AuxBar^3~d!2~3~4~5~6~7~8~9~10~
AuxBar^4~f~1!{SIZE=1,USE=1,R=1,COLOUR=1,ANCHOR=3,OFFSET=0,DEPTH=2,G=1,OTYPE=1,B=1}
AuxBar^4~d!2~3~4~5~6~7~8~9~10~
AuxBar^5~f~1!{SIZE=1,USE=1,R=0.631,COLOUR=1,ANCHOR=4,OFFSET=0,DEPTH=2,G=0.247,OTYPE=1,B=0.247}
AuxBar^5~d!2~3~4~5~6~7~8~9~10~
AuxBar^6~f~1!{SIZE=1,USE=5,R=0.906,COLOUR=3,ANCHOR=3,OFFSET=0,DEPTH=3,G=0.294,OTYPE=2,B=0.102}
AuxBar^6~d!2~3~4~5~6~7~8~9~
AuxBar^6~f~10!{SIZE=1,USE=1,B=0.102,COLOUR=3,ANCHOR=3,OFFSET=0,DEPTH=3,R=0.906,OTYPE=2,G=0.294}
AuxBar^7~f~1!{SIZE=1,USE=5,R=0.906,COLOUR=3,ANCHOR=4,OFFSET=0,DEPTH=3,G=0.294,OTYPE=2,B=0.102}
AuxBar^7~d!2~3~4~5~6~7~8~9~
AuxBar^7~f~10!{SIZE=1,USE=1,B=0.102,COLOUR=3,ANCHOR=4,OFFSET=0,DEPTH=3,R=0.906,OTYPE=2,G=0.294}
AuxBar^8~f~1!{SIZE=0.58,USE=1,R=0.078,COLOUR=1,ANCHOR=2,OFFSET=-3,DEPTH=3,G=0.737,OTYPE=2,B=0.875}
AuxBar^8~d!2~3~4~5~6~7~8~9~10~
AuxBar^9~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=2,DEPTH=5,G=1,OTYPE=1,B=1}
AuxBar^9~d!2~3~4~5~6~7~8~9~10~
Complete!]]
HealBot_ExtraSkinData[2]=[[Skin
Raid10
Author~v!Doco of Mirage Raceway
DuplicateBars~v!false
Chat~t!{EOCOOM="false",EOCOOMV=20,MSG="Casting #s on #n",RESONLY="true",CHAN="",NOTIFY=1}
General~t!{OFREQ=0.07,STICKYSENSITIVITY=30,FLUIDBARS="false",FLUIDFREQ=10,HIDEPARTYF="false",OMIN=0.2,STICKYFRAME="true",HIDEPTF="false",HIDERAIDF="true",OMAX=1,HIDEBOSSF="true"}
Healing~t!{TONLYFRIEND="false",TARGETINCOMBAT=1,FOCUSINCOMBAT=2,GROUPPETS="true",FEXRAID="false",TEXRAID="false",FONLYFRIEND="false",SELFPET="false"}
Enemy~t!{ENEMYTARGET="true",INCTANKS="true",INCMYTAR="false",INCARENA="false",INCARENAPETS="false",ENEMYTARGETSIZE=70,HIDE="true",NUMBOSS=1,EXISTSHOWPTAR=1,INCSELF="false",EXISTSHOWBOSS="true",DOUBLEWIDTH="false",EXISTSHOWARENA=2}
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
Frame~f~1!{BORDERR=0.1,BACKR=0.1,SFOFFSETH=0,SFOFFSETV=0,LOCKED="false",OPENSOUND="false",BORDERA=0.04,BORDERG=0.1,BACKG=0.1,BORDERB=0.1,BACKA=0.1,SCALE=1,BACKB=0.7,AUTOCLOSE="false",TIPLOC=2}
Frame~f~2!{BORDERR=0.1,BACKR=0.1,SFOFFSETH=0,SFOFFSETV=-8,LOCKED="true",OPENSOUND="false",BORDERA=0.04,BORDERG=0.1,BACKG=0.1,BORDERB=0.1,BACKA=0.1,SCALE=1,BACKB=0.7,AUTOCLOSE="false",TIPLOC=2}
Frame~f~3!{BORDERR=0.1,BACKR=0.1,SFOFFSETH=0,SFOFFSETV=0,LOCKED="false",OPENSOUND="false",BORDERA=0.04,BORDERG=0.1,BACKG=0.1,BORDERB=0.1,BACKA=0.1,SCALE=1,BACKB=0.7,AUTOCLOSE="false",TIPLOC=5}
Frame~d!4~5~6~
Frame~f~7!{BORDERR=0.1,BACKR=0.1,SFOFFSETH=0,SFOFFSETV=8,LOCKED="false",OPENSOUND="false",BORDERA=0.04,BORDERG=0.1,BACKG=0.1,BORDERB=0.1,BACKA=0.1,SCALE=1,BACKB=0.7,AUTOCLOSE="false",TIPLOC=5}
Frame~f~8!{BORDERR=0.1,BACKR=0.1,SFOFFSETH=9,SFOFFSETV=1,LOCKED="false",OPENSOUND="false",BORDERA=0.04,BORDERG=0.1,BACKG=0.1,BORDERB=0.1,BACKA=0.1,SCALE=1,BACKB=0.7,AUTOCLOSE="false",TIPLOC=2}
Frame~f~9!{BORDERR=0.1,BACKR=0.1,SFOFFSETH=9,SFOFFSETV=0,LOCKED="false",OPENSOUND="false",BORDERA=0.04,BORDERG=0.1,BACKG=0.1,BORDERB=0.1,BACKA=0.1,SCALE=1,BACKB=0.7,AUTOCLOSE="false",TIPLOC=2}
Frame~f~10!{BORDERR=0.1,BACKR=0.1,SFOFFSETH=0,SFOFFSETV=-4,LOCKED="true",OPENSOUND="false",BORDERA=0.04,BORDERG=0.1,BACKG=0.1,BORDERB=0.1,BACKA=0.1,SCALE=1,BACKB=0.7,AUTOCLOSE="false",TIPLOC=4}
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
HealGroups~f~6!{FRAME=1,STATE="false",NAME="Private List"}
HealGroups~f~7!{FRAME=6,STATE="false",NAME="Vehicle"}
HealGroups~f~8!{FRAME=7,STATE="true",NAME="Pets"}
HealGroups~f~9!{FRAME=8,STATE="true",NAME="Target"}
HealGroups~f~10!{FRAME=9,STATE="true",NAME="Focus"}
HealGroups~f~11!{FRAME=10,STATE="true",NAME="Enemy"}
Anchors~f~1!{Y=50.32,GROW=2,BARS=3,FRAME=3,X=92.58}
Anchors~f~2!{Y=49.65,GROW=2,BARS=1,FRAME=2,X=86.68}
Anchors~f~3!{Y=36.94,GROW=2,BARS=1,FRAME=1,X=92.3}
Anchors~f~4!{Y=53,GROW=2,BARS=1,FRAME=1,X=53}
Anchors~f~5!{Y=54,GROW=2,BARS=1,FRAME=1,X=54}
Anchors~f~6!{Y=55,GROW=2,BARS=1,FRAME=1,X=55}
Anchors~f~7!{Y=46.9,GROW=2,BARS=1,FRAME=3,X=92.58}
Anchors~f~8!{Y=51.78,GROW=2,BARS=1,FRAME=7,X=86.99}
Anchors~f~9!{Y=66.66,GROW=2,BARS=1,FRAME=7,X=89.64}
Anchors~f~10!{Y=53.4,GROW=2,BARS=4,FRAME=2,X=86.68}
HeadBar~f~1!{SHOW="false",WIDTH=0.9,B=0.1,R=0.1,HEIGHT=20,A=0.25,G=0.1,TEXTURE="Skewed"}
HeadBar~d!2~3~4~5~6~7~8~9~10~
HeadText~f~1!{A=0.55,B=0.1,OFFSET=0,R=1,FONT="Friz Quadrata TT",HEIGHT=9,G=1,OUTLINE=1}
HeadText~d!2~3~4~5~6~7~8~9~10~
HealBar~f~1!{HEIGHT=32,GRPCOLS="false",CMARGIN=1,TEXTURE="Smooth v2",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=1,NUMCOLS=2,OFIX=1,RMARGIN=0,WIDTH=75}
HealBar~f~2!{HEIGHT=32,GRPCOLS="false",CMARGIN=0,TEXTURE="Smooth v2",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=1,NUMCOLS=1,OFIX=1,RMARGIN=0,WIDTH=158}
HealBar~f~3!{HEIGHT=32,GRPCOLS="false",CMARGIN=2,TEXTURE="Tukui2",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=1,NUMCOLS=2,OFIX=1,RMARGIN=2,WIDTH=75}
HealBar~d!4~5~6~
HealBar~f~7!{HEIGHT=27,GRPCOLS="false",CMARGIN=1,TEXTURE="Smooth v2",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=1,NUMCOLS=3,OFIX=1,RMARGIN=0,WIDTH=47}
HealBar~f~8!{HEIGHT=32,GRPCOLS="false",CMARGIN=2,TEXTURE="Tukui2",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=1,NUMCOLS=2,OFIX=1,RMARGIN=0,WIDTH=75}
HealBar~d!9~
HealBar~f~10!{HEIGHT=32,GRPCOLS="false",CMARGIN=2,TEXTURE="Tukui2",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=1,NUMCOLS=1,OFIX=1,RMARGIN=2,WIDTH=158}
BarCol~f~1!{BACK=2,BA=0.05,BB=0.4,DISA=0.12,BR=0.2,HB=0.4,BG=0.4,BOUT=1,HA=0.95,HR=0.2,ORA=0.3,HG=0.4,HLTH=2}
BarCol~d!2~3~4~5~6~7~8~9~10~
BarIACol~f~1!{AC=4,AB=0.8,AA=0.5,AR=0.2,AG=0.8,IC=2,IB=1,IA=0.58,IR=1,IG=1}
BarIACol~d!2~
BarIACol~f~3!{AC=3,AB=1,AA=0.5,AR=1,AG=1,IC=2,IB=0.2,IA=0.58,IR=0.2,IG=0.8}
BarIACol~d!4~5~6~
BarIACol~f~7!{AC=4,AB=0.8,AA=0.5,AR=0.2,AG=0.8,IC=2,IB=1,IA=0.58,IR=1,IG=1}
BarIACol~f~8!{AC=3,AB=1,AA=0.5,AR=1,AG=1,IC=2,IB=0.2,IA=0.58,IR=0.2,IG=0.8}
BarIACol~d!9~
BarIACol~f~10!{AC=4,AB=0.8,AA=0.5,AR=0.2,AG=0.8,IC=2,IB=1,IA=0.58,IR=1,IG=1}
BarText~f~1!{HLTHONBAR="true",TAGOOR="r |",IGNOREONFULL="true",MAXCHARS=0,CLASSONBAR="false",OUTLINE=1,OVERHEAL=2,INCHEALS=2,HLTHTXTANCHOR=1,HLTHTYPE=1,FONT="Friz Quadrata TT",HMAXCHARS=0,NUMFORMAT2=1,TAGDC="dc-",NUMFORMAT1=1,OFFSET=0,NAMEONBAR="true",HEIGHT=10,TAGRIP="D | ",SHOWROLE="true",HALIGN=2,HFONT="Friz Quadrata TT",HHEIGHT=10,HOUTLINE=1,INCABSORBS=1,HOFFSET2=0,ALIGN=2,TAGR="[ R ] ",HOFFSET=0}
BarText~d!2~
BarText~f~3!{HLTHONBAR="true",TAGOOR="[ OOR ] ",IGNOREONFULL="true",MAXCHARS=0,CLASSONBAR="false",OUTLINE=1,OVERHEAL=1,INCHEALS=2,HLTHTXTANCHOR=1,HLTHTYPE=1,FONT="Friz Quadrata TT",HMAXCHARS=0,NUMFORMAT2=1,TAGDC="[ DC ] ",NUMFORMAT1=1,OFFSET=0,NAMEONBAR="true",HEIGHT=10,TAGRIP="[ RIP ] ",SHOWROLE="true",HALIGN=2,HFONT="Friz Quadrata TT",HHEIGHT=10,HOUTLINE=1,INCABSORBS=1,HOFFSET2=0,ALIGN=2,TAGR="[ R ] ",HOFFSET=0}
BarText~d!4~5~6~
BarText~f~7!{HLTHONBAR="true",TAGOOR="",IGNOREONFULL="true",MAXCHARS=8,CLASSONBAR="false",OUTLINE=1,OVERHEAL=1,INCHEALS=2,HLTHTXTANCHOR=1,HLTHTYPE=1,FONT="Friz Quadrata TT",HMAXCHARS=0,NUMFORMAT2=1,TAGDC="",NUMFORMAT1=1,OFFSET=0,NAMEONBAR="true",HEIGHT=9,TAGRIP="",SHOWROLE="true",HALIGN=2,HFONT="Friz Quadrata TT",HHEIGHT=10,HOUTLINE=1,INCABSORBS=1,HOFFSET2=0,ALIGN=2,TAGR="[ R ] ",HOFFSET=0}
BarText~f~8!{HLTHONBAR="true",TAGOOR="",IGNOREONFULL="true",MAXCHARS=0,CLASSONBAR="false",OUTLINE=1,OVERHEAL=1,INCHEALS=2,HLTHTXTANCHOR=1,HLTHTYPE=1,FONT="Friz Quadrata TT",HMAXCHARS=0,NUMFORMAT2=1,TAGDC="",NUMFORMAT1=1,OFFSET=0,NAMEONBAR="true",HEIGHT=10,TAGRIP="",SHOWROLE="true",HALIGN=2,HFONT="Friz Quadrata TT",HHEIGHT=10,HOUTLINE=1,INCABSORBS=1,HOFFSET2=0,ALIGN=2,TAGR="[ R ] ",HOFFSET=0}
BarText~d!9~
BarText~f~10!{HLTHONBAR="true",TAGOOR="[ OOR ] ",IGNOREONFULL="true",MAXCHARS=0,CLASSONBAR="false",OUTLINE=1,OVERHEAL=1,INCHEALS=2,HLTHTXTANCHOR=1,HLTHTYPE=1,FONT="Friz Quadrata TT",HMAXCHARS=0,NUMFORMAT2=1,TAGDC="[ DC ] ",NUMFORMAT1=1,OFFSET=0,NAMEONBAR="true",HEIGHT=10,TAGRIP="[ RIP ] ",SHOWROLE="true",HALIGN=2,HFONT="Friz Quadrata TT",HHEIGHT=10,HOUTLINE=1,INCABSORBS=1,HOFFSET2=0,ALIGN=2,TAGR="[ R ] ",HOFFSET=0}
BarTextCol~f~1!{HCG=1,HCA=1,HLTH=1,NCDA=0.7,NAME=2,NCR=1,NCG=1,NCA=1,NDEBUFF="false",HCB=0,HCR=1,HDEBUFF="false",NCB=0,HCDA=0.7}
BarTextCol~d!2~
BarTextCol~f~3!{HCG=1,HCA=1,HLTH=2,NCDA=0.7,NAME=2,NCR=1,NCG=1,NCA=1,NDEBUFF="false",HCB=0,HCR=1,HDEBUFF="false",NCB=0,HCDA=0.7}
BarTextCol~d!4~5~6~
BarTextCol~f~7!{HCG=1,HCA=1,HLTH=1,NCDA=0.7,NAME=2,NCR=1,NCG=1,NCA=1,NDEBUFF="false",HCB=0,HCR=1,HDEBUFF="false",NCB=0,HCDA=0.81}
BarTextCol~f~8!{HCG=1,HCA=1,HLTH=2,NCDA=0.7,NAME=2,NCR=1,NCG=1,NCA=1,NDEBUFF="false",HCB=0,HCR=1,HDEBUFF="false",NCB=0,HCDA=0.7}
BarTextCol~d!9~10~
Icons~f~1!{RCEN="true",I15EN="true",CLASSEN="false",BUFFANCHOR=2,BUFFFADE="false",DEBUFFANCHOR=1,RCVOFFSET=-2,OORVOFFSET=0,DEBUFFDOUBLE="true",TARGETVOFFSET=0,BUFFONBAR=1,SHOWDIR="false",SHOWRC="true",TARGETANCHOR=6,RCSCALE=0.5,MAXBICONS=6,FADESECS=15,RCHOFFSET=0,TARGETHOFFSET=0,CLASSONBAR=3,CLASSVOFFSET=0,SHOWDIRMOUSE="false",DSCALE=0.8,OORHOFFSET=0,SCALE=0.8,BUFFDOUBLE="true",TARGETONBAR=3,TARGETEN="false",TARGETSCALE=0.4,RCANCHOR=3,FADE="false",RCONBAR=3,MAXDICONS=2,OORANCHOR=1,OORONBAR=3,CLASSHOFFSET=0,CLASSANCHOR=5,DEBUFFONBAR=1,CLASSSCALE=0.4,BUFFI15EN="true",BUFFFADESECS=15,OORSCALE=0.5,SHOWROLE="true",OOREN="false",SHOWCLASS="true"}
Icons~f~2!{RCEN="true",I15EN="true",CLASSEN="false",BUFFANCHOR=2,BUFFFADE="false",DEBUFFANCHOR=1,RCVOFFSET=-2,OORVOFFSET=0,DEBUFFDOUBLE="true",TARGETVOFFSET=0,BUFFONBAR=1,SHOWDIR="false",SHOWRC="true",TARGETANCHOR=6,RCSCALE=0.5,MAXBICONS=8,FADESECS=15,RCHOFFSET=0,TARGETHOFFSET=0,CLASSONBAR=3,CLASSVOFFSET=0,SHOWDIRMOUSE="false",DSCALE=0.8,OORHOFFSET=0,SCALE=0.8,BUFFDOUBLE="true",TARGETONBAR=3,TARGETEN="false",TARGETSCALE=0.4,RCANCHOR=3,FADE="false",RCONBAR=3,MAXDICONS=4,OORANCHOR=1,OORONBAR=3,CLASSHOFFSET=0,CLASSANCHOR=5,DEBUFFONBAR=1,CLASSSCALE=0.4,BUFFI15EN="true",BUFFFADESECS=15,OORSCALE=0.5,SHOWROLE="true",OOREN="false",SHOWCLASS="true"}
Icons~f~3!{RCEN="true",I15EN="true",CLASSEN="false",BUFFANCHOR=2,BUFFFADE="false",DEBUFFANCHOR=1,RCVOFFSET=-2,OORVOFFSET=0,DEBUFFDOUBLE="true",TARGETVOFFSET=0,BUFFONBAR=1,SHOWDIR="false",SHOWRC="true",TARGETANCHOR=6,RCSCALE=0.5,MAXBICONS=8,FADESECS=15,RCHOFFSET=0,TARGETHOFFSET=0,RCANCHOR=3,CLASSVOFFSET=0,FADE="false",DSCALE=0.8,OORHOFFSET=0,BUFFDOUBLE="true",SCALE=0.8,OORONBAR=3,TARGETEN="false",TARGETSCALE=0.4,SHOWCLASS="true",CLASSONBAR=3,RCONBAR=3,MAXDICONS=3,OORANCHOR=1,SHOWROLE="true",CLASSHOFFSET=0,CLASSANCHOR=5,DEBUFFONBAR=1,CLASSSCALE=0.4,BUFFI15EN="true",BUFFFADESECS=15,OORSCALE=0.5,TARGETONBAR=3,OOREN="false",SHOWDIRMOUSE="false"}
Icons~d!4~5~6~
Icons~f~7!{RCEN="true",I15EN="true",CLASSEN="false",BUFFANCHOR=2,BUFFFADE="false",DEBUFFANCHOR=1,RCVOFFSET=-2,OORVOFFSET=0,DEBUFFDOUBLE="true",TARGETVOFFSET=0,BUFFONBAR=1,SHOWDIR="false",SHOWRC="true",TARGETANCHOR=6,RCSCALE=0.5,MAXBICONS=4,FADESECS=15,RCHOFFSET=0,TARGETHOFFSET=0,RCANCHOR=3,CLASSVOFFSET=0,FADE="false",DSCALE=0.8,OORHOFFSET=0,BUFFDOUBLE="true",SCALE=0.8,OORONBAR=3,TARGETEN="false",TARGETSCALE=0.4,SHOWCLASS="true",CLASSONBAR=3,RCONBAR=3,MAXDICONS=2,OORANCHOR=1,SHOWROLE="true",CLASSHOFFSET=0,CLASSANCHOR=5,DEBUFFONBAR=1,CLASSSCALE=0.4,BUFFI15EN="true",BUFFFADESECS=15,OORSCALE=0.5,TARGETONBAR=3,OOREN="false",SHOWDIRMOUSE="false"}
Icons~f~8!{RCEN="true",I15EN="true",CLASSEN="false",BUFFANCHOR=2,BUFFFADE="false",DEBUFFANCHOR=1,RCVOFFSET=-2,OORVOFFSET=0,DEBUFFDOUBLE="true",TARGETVOFFSET=0,BUFFONBAR=1,SHOWDIR="false",SHOWRC="true",TARGETANCHOR=6,RCSCALE=0.5,MAXBICONS=6,FADESECS=15,RCHOFFSET=0,TARGETHOFFSET=0,RCANCHOR=3,CLASSVOFFSET=0,FADE="false",DSCALE=0.8,OORHOFFSET=0,BUFFDOUBLE="true",SCALE=0.8,OORONBAR=3,TARGETEN="false",TARGETSCALE=0.4,SHOWCLASS="true",CLASSONBAR=3,RCONBAR=3,MAXDICONS=2,OORANCHOR=1,SHOWROLE="true",CLASSHOFFSET=0,CLASSANCHOR=5,DEBUFFONBAR=1,CLASSSCALE=0.4,BUFFI15EN="true",BUFFFADESECS=15,OORSCALE=0.5,TARGETONBAR=3,OOREN="false",SHOWDIRMOUSE="false"}
Icons~d!9~
Icons~f~10!{RCEN="true",I15EN="true",CLASSEN="false",BUFFANCHOR=2,BUFFFADE="false",DEBUFFANCHOR=1,RCVOFFSET=-2,OORVOFFSET=0,DEBUFFDOUBLE="true",TARGETVOFFSET=0,BUFFONBAR=1,SHOWDIR="false",SHOWRC="true",TARGETANCHOR=6,RCSCALE=0.5,MAXBICONS=8,FADESECS=15,RCHOFFSET=0,TARGETHOFFSET=0,RCANCHOR=3,CLASSVOFFSET=0,FADE="false",DSCALE=0.8,OORHOFFSET=0,BUFFDOUBLE="true",SCALE=0.8,OORONBAR=3,TARGETEN="false",TARGETSCALE=0.4,SHOWCLASS="true",CLASSONBAR=3,RCONBAR=3,MAXDICONS=3,OORANCHOR=1,SHOWROLE="true",CLASSHOFFSET=0,CLASSANCHOR=5,DEBUFFONBAR=1,CLASSSCALE=0.4,BUFFI15EN="true",BUFFFADESECS=15,OORSCALE=0.5,TARGETONBAR=3,OOREN="false",SHOWDIRMOUSE="false"}
RaidIcon~f~1!{SQUARE="true",CIRCLE="true",DIAMOND="true",SHOW="true",MOON="true",TRIANGLE="true",STAR="true",CROSS="true",SKULL="true"}
RaidIcon~d!2~3~4~5~6~7~8~9~10~
IconText~f~1!{DURWARN=3,BUFFSSDUR="true",BUFFOUTLINE=2,BUFFDURTHRH=9,SCNT="true",DURTHRH=9,FONT="Friz Quadrata TT",BUFFFONT="Friz Quadrata TT",BUFFSCNT="true",SSCNT="false",BUFFSDUR="true",BUFFDURWARN=3,SDUR="true",BUFFHEIGHT=10,HEIGHT=10,BUFFSSCNT="false",SSDUR="true",OUTLINE=2}
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
BarAggro~f~1!{B=0,SHOWTEXT="false",G=0,TEXTFORMAT=3,SHOW="true",SHOWTEXTPCT="true",SHOWIND="true",ALERTIND=2,R=1,ALERT=2}
BarAggro~d!2~3~4~5~6~
BarAggro~f~7!{B=0,SHOWTEXT="false",G=0,TEXTFORMAT=3,SHOW="true",SHOWTEXTPCT="false",SHOWIND="false",R=1,ALERTIND=2,ALERT=2}
BarAggro~f~8!{B=0,SHOWTEXT="false",G=0,TEXTFORMAT=3,SHOW="true",SHOWTEXTPCT="true",SHOWIND="true",R=1,ALERTIND=2,ALERT=2}
BarAggro~d!9~10~
AuxBarFrame~f~1!{OVERLAP=2}
AuxBarFrame~d!2~3~4~5~6~7~8~9~10~
AuxBar^1~f~1!{SIZE=0.98,USE=4,R=1,COLOUR=1,ANCHOR=1,OFFSET=0,DEPTH=3,OTYPE=1,B=1,G=1}
AuxBar^1~d!2~3~4~5~6~7~8~9~10~
AuxBar^2~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=2,OFFSET=0,DEPTH=3,OTYPE=1,B=1,G=1}
AuxBar^2~d!2~3~4~5~6~7~8~9~10~
AuxBar^3~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=0,DEPTH=2,OTYPE=2,B=1,G=1}
AuxBar^3~d!2~3~4~5~6~7~8~9~10~
AuxBar^4~f~1!{SIZE=1,USE=5,R=1,COLOUR=1,ANCHOR=2,OFFSET=0,DEPTH=2,OTYPE=2,B=1,G=1}
AuxBar^4~d!2~3~4~5~6~7~8~9~
AuxBar^4~f~10!{SIZE=1,USE=1,R=1,COLOUR=1,ANCHOR=2,OFFSET=0,DEPTH=2,G=1,B=1,OTYPE=2}
AuxBar^5~f~1!{SIZE=1,USE=5,R=1,COLOUR=1,ANCHOR=3,OFFSET=0,DEPTH=1,OTYPE=2,B=1,G=1}
AuxBar^5~d!2~3~4~5~6~7~8~9~
AuxBar^5~f~10!{SIZE=1,USE=1,R=1,COLOUR=1,ANCHOR=3,OFFSET=0,DEPTH=1,G=1,B=1,OTYPE=2}
AuxBar^6~f~1!{SIZE=1,USE=5,R=1,COLOUR=1,ANCHOR=4,OFFSET=0,DEPTH=1,OTYPE=2,B=1,G=1}
AuxBar^6~d!2~3~4~5~6~7~8~9~
AuxBar^6~f~10!{SIZE=1,USE=1,R=1,COLOUR=1,ANCHOR=4,OFFSET=0,DEPTH=1,G=1,B=1,OTYPE=2}
AuxBar^7~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,OTYPE=1,B=1,G=1}
AuxBar^7~d!2~3~4~5~6~7~8~9~10~
AuxBar^8~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,OTYPE=1,B=1,G=1}
AuxBar^8~d!2~3~4~5~6~7~8~9~10~
AuxBar^9~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,OTYPE=1,B=1,G=1}
AuxBar^9~d!2~3~4~5~6~7~8~9~10~
Complete!]]
HealBot_ExtraSkinData[3]=[[Skin
Verena
Author~v!Vayah von Lothar
DuplicateBars~v!false
Chat~t!{EOCOOM="false",EOCOOMV=20,MSG="Casting #s on #n",RESONLY="true",CHAN="",NOTIFY=0}
General~t!{OFREQ=0.07,OMIN=0.1,OMAX=0.95,FLUIDFREQ=10,HIDEPARTYF="false",HIDEPTF="false",STICKYSENSITIVITY=30,HIDERAIDF="false",STICKYFRAME="false",FLUIDBARS="false",HIDEBOSSF="false"}
Healing~t!{TINCSELF="false",GROUPPETS="true",TARGETINCOMBAT=2,FALWAYSSHOW="false",FONLYFRIEND="false",SELFPET=0,TONLYFRIEND="false",TINCGROUP="true",FOCUSINCOMBAT=2,TALWAYSSHOW="false",TINCPET="false",TINCRAID="true",TEXRAID="false",FEXRAID="false"}
Enemy~t!{INCARENA="true",INCTANKS="true",INCMYTAR="false",ENEMYTARGET="false",ENEMYTARGETSIZE=40,INCARENAPETS="false",HIDE="true",NUMBOSS=2,EXISTSHOWPTAR=1,INCSELF="false",EXISTSHOWBOSS="true",DOUBLEWIDTH="false",EXISTSHOWARENA=3}
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
AuxBarFrame~f~1!{OVERLAP=1}
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
General~t!{OFREQ=0.07,STICKYSENSITIVITY=22,FLUIDBARS="false",FLUIDFREQ=10,HIDEPARTYF="false",OMIN=0.1,STICKYFRAME="true",HIDEBOSSF="true",HIDERAIDF="true",OMAX=0.95,HIDEPTF="false"}
Healing~t!{TINCSELF="false",GROUPPETS="true",TARGETINCOMBAT=1,TINCRAID="true",FONLYFRIEND="true",SELFPET=0,TONLYFRIEND="false",TINCGROUP="true",FOCUSINCOMBAT=2,TALWAYSSHOW="false",FEXRAID="false",TINCPET="false",TEXRAID="false",FALWAYSSHOW="false"}
Enemy~t!{INCARENA="false",INCTANKS="true",INCMYTAR="false",ENEMYTARGET="true",INCARENAPETS="false",ENEMYTARGETSIZE=58,HIDE="true",NUMBOSS=4,EXISTSHOWPTAR=1,INCSELF="false",EXISTSHOWBOSS="true",DOUBLEWIDTH="false",EXISTSHOWARENA=2}
FrameAlias~f~1!{SIZE=12,NAME="Party",R=1,ALIAS="Party",G=1,SHOW="true",OFFSET=-1,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~2!{SIZE=12,NAME="Tank and Healer",R=1,ALIAS="Not Used",G=1,SHOW="true",OFFSET=1,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~3!{SIZE=12,NAME="Pets",R=1,ALIAS="Not Used 1",G=1,SHOW="true",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~4!{SIZE=12,NAME="Focus and Target",R=1,ALIAS="Not Used 2",G=1,SHOW="true",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~5!{SIZE=12,NAME="Enemy",R=1,ALIAS="Not Used 3",G=0,SHOW="true",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=0.082,OUTLINE=1}
FrameAlias~f~6!{SIZE=12,NAME="",R=1,ALIAS="Vehicle",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~7!{SIZE=12,NAME="Pets",R=1,ALIAS="Pets",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~8!{SIZE=12,NAME="Target",R=1,ALIAS="Target",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~9!{SIZE=12,NAME="",R=1,ALIAS="Focus",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~10!{SIZE=12,NAME="",R=1,ALIAS="Enemy",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAliasBar~f~1!{A=0.25,WIDTH=0.9,B=0.1,HEIGHT=20,R=0.1,G=0.1,TEXTURE="Diagonal"}
FrameAliasBar~d!2~3~4~5~6~7~8~9~10~
Frame~f~1!{BACKR=0.02,BORDERR=0.976,SFOFFSETH=0,SFOFFSETV=0,LOCKED="false",OPENSOUND="false",BORDERA=0,BORDERG=0,BACKG=0.016,BORDERB=0,BACKA=0.33,SCALE=1,BACKB=0.016,AUTOCLOSE="false",TIPLOC=2}
Frame~f~2!{BACKR=0.102,BORDERR=0.102,SFOFFSETH=2,SFOFFSETV=0,LOCKED="true",OPENSOUND="false",BORDERA=0,BORDERG=0.102,BACKG=0.102,BORDERB=0.102,BACKA=0.04,SCALE=1,BACKB=0.502,AUTOCLOSE="false",TIPLOC=1}
Frame~f~3!{BACKR=0.1,BORDERR=0.1,SFOFFSETH=0,SFOFFSETV=0,LOCKED="false",OPENSOUND="false",BORDERA=0.5,BORDERG=0.1,BACKG=0.1,BORDERB=0.1,BACKA=0.2,SCALE=1,BACKB=0.5,AUTOCLOSE="false",TIPLOC=2}
Frame~d!4~
Frame~f~5!{BACKR=0.1,BORDERR=0.1,SFOFFSETH=0,SFOFFSETV=0,LOCKED="false",OPENSOUND="false",BORDERA=0.5,BORDERG=0.1,BACKG=0.1,BORDERB=0.1,BACKA=0.2,SCALE=1,BACKB=0.5,AUTOCLOSE="false",TIPLOC=4}
Frame~f~6!{BACKR=0.1,BORDERR=0.1,SFOFFSETH=0,SFOFFSETV=0,LOCKED="false",OPENSOUND="false",BORDERA=0.5,BORDERG=0.1,BACKG=0.1,BORDERB=0.1,BACKA=0.2,SCALE=1,BACKB=0.5,AUTOCLOSE="false",TIPLOC=5}
Frame~f~7!{BACKR=0.102,BORDERR=0.102,SFOFFSETH=0,SFOFFSETV=7,LOCKED="true",OPENSOUND="false",BORDERA=0.01,BORDERG=0.102,BACKG=0.102,BORDERB=0.102,BACKA=0.01,SCALE=1,BACKB=0.502,AUTOCLOSE="false",TIPLOC=5}
Frame~f~8!{BACKR=0.102,BORDERR=0.102,SFOFFSETH=8,SFOFFSETV=0,LOCKED="false",OPENSOUND="false",BORDERA=0,BORDERG=0.102,BACKG=0.102,BORDERB=0.102,BACKA=0,SCALE=1,BACKB=0.502,AUTOCLOSE="false",TIPLOC=5}
Frame~d!9~
Frame~f~10!{BACKR=0.102,BORDERR=0.102,SFOFFSETH=4,SFOFFSETV=-4,LOCKED="false",OPENSOUND="false",BORDERA=0.1,BORDERG=0.102,BACKG=0.102,BORDERB=0.102,BACKA=0.05,SCALE=1,BACKB=0.502,AUTOCLOSE="false",TIPLOC=2}
StickyFrames~f~1!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~f~2!{STUCK="true",STUCKTOPOINT="TOPLEFT",STUCKTO=1,STUCKPOINT="TOPRIGHT"}
StickyFrames~f~3!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~d!4~5~6~
StickyFrames~f~7!{STUCK="true",STUCKTOPOINT="BOTTOMRIGHT",STUCKTO=1,STUCKPOINT="TOPRIGHT"}
StickyFrames~f~8!{STUCK="true",STUCKTOPOINT="TOPLEFT",STUCKTO=1,STUCKPOINT="TOPRIGHT"}
StickyFrames~f~9!{STUCK="true",STUCKTOPOINT="LEFT",STUCKTO=1,STUCKPOINT="RIGHT"}
StickyFrames~f~10!{STUCK="true",STUCKTOPOINT="TOPLEFT",STUCKTO=1,STUCKPOINT="BOTTOMLEFT"}
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
Anchors~f~1!{Y=65.21,GROW=2,BARS=1,FRAME=3,X=91.33}
Anchors~f~2!{Y=66.8,GROW=2,BARS=1,FRAME=3,X=88.74}
Anchors~f~3!{Y=65.52,GROW=2,BARS=3,FRAME=3,X=92.08}
Anchors~f~4!{Y=64.17,GROW=2,BARS=1,FRAME=1,X=83.17}
Anchors~f~5!{Y=65.23,GROW=2,BARS=2,FRAME=2,X=89.04}
Anchors~f~6!{Y=55,GROW=2,BARS=1,FRAME=1,X=55}
Anchors~f~7!{Y=59.19,GROW=2,BARS=1,FRAME=3,X=98}
Anchors~f~8!{Y=65.21,GROW=2,BARS=1,FRAME=3,X=84.74}
Anchors~f~9!{Y=62.92,GROW=2,BARS=1,FRAME=7,X=84.74}
Anchors~f~10!{Y=66.54,GROW=2,BARS=4,FRAME=2,X=84.6}
HeadBar~f~1!{SHOW="false",WIDTH=0.9,B=0.506,R=0.506,HEIGHT=30,A=0.4,G=0.506,TEXTURE="Diagonal"}
HeadBar~f~2!{SHOW="false",WIDTH=0.9,B=0.1,R=0.1,HEIGHT=30,A=0.25,G=0.1,TEXTURE="Diagonal"}
HeadBar~d!3~4~5~6~7~8~9~10~
HeadText~f~1!{A=0.7,B=0.8,OFFSET=0,R=0.2,FONT="Friz Quadrata TT",HEIGHT=10,G=0.8,OUTLINE=1}
HeadText~f~2!{A=0.7,B=0.1,OFFSET=0,R=1,FONT="Friz Quadrata TT",HEIGHT=10,G=1,OUTLINE=1}
HeadText~d!3~4~5~6~7~8~9~10~
HealBar~f~1!{HEIGHT=40,GRPCOLS="false",CMARGIN=4,TEXTURE="Smooth v2",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=5,NUMCOLS=1,OFIX=1,RMARGIN=0,WIDTH=175}
HealBar~f~2!{HEIGHT=34,GRPCOLS="false",CMARGIN=4,TEXTURE="Smooth v2",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=2,NUMCOLS=1,OFIX=1,RMARGIN=0,WIDTH=172}
HealBar~d!3~4~5~6~7~
HealBar~f~8!{HEIGHT=40,GRPCOLS="false",CMARGIN=4,TEXTURE="Smooth v2",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=172,RMARGIN=0,OFIX=1,NUMCOLS=1,LOWMANA=2}
HealBar~d!9~
HealBar~f~10!{HEIGHT=34,GRPCOLS="false",CMARGIN=1,TEXTURE="Smooth v2",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=2,NUMCOLS=1,OFIX=1,RMARGIN=0,WIDTH=180}
BarCol~f~1!{BACK=3,BA=0.25,BB=0,DISA=0.25,BR=0,HB=0.9,BG=0,BOUT=1,HA=1,HR=0.2,ORA=0.7,HG=0.2,HLTH=2}
BarCol~d!2~3~4~5~6~7~8~9~10~
BarIACol~f~1!{AC=4,AB=0.969,AA=0.2,AR=1,AG=0.945,IC=2,IB=0.2,IA=0.5,IR=0.2,IG=0.9}
BarIACol~d!2~3~4~5~6~7~8~9~10~
BarText~f~1!{HLTHONBAR="true",TAGOOR="OOR | ",OVERHEAL=2,MAXCHARS=0,HMAXCHARS=0,OUTLINE=1,HOUTLINE=1,OFFSET=3,HLTHTXTANCHOR=1,HLTHTYPE=1,HFONT="Friz Quadrata TT",FONT="Friz Quadrata TT",NUMFORMAT2=1,CLASSONBAR="false",NUMFORMAT1=11,IGNOREONFULL="true",TAGRIP="RIP | ",HEIGHT=13,NAMEONBAR="true",SHOWROLE="true",HALIGN=2,TAGDC="DC | ",HHEIGHT=15,INCHEALS=2,INCABSORBS=2,HOFFSET2=0,ALIGN=2,TAGR="R | ",HOFFSET=0}
BarText~f~2!{HLTHONBAR="true",TAGOOR="OOR | ",OVERHEAL=2,MAXCHARS=0,HMAXCHARS=0,OUTLINE=1,HOUTLINE=1,OFFSET=3,HLTHTXTANCHOR=1,HLTHTYPE=1,HFONT="Friz Quadrata TT",FONT="Friz Quadrata TT",NUMFORMAT2=1,CLASSONBAR="false",NUMFORMAT1=11,IGNOREONFULL="false",TAGRIP="RIP | ",HEIGHT=13,NAMEONBAR="true",SHOWROLE="true",HALIGN=2,TAGDC="DC | ",HHEIGHT=15,INCHEALS=2,INCABSORBS=2,HOFFSET2=0,ALIGN=2,TAGR="R | ",HOFFSET=0}
BarText~d!3~4~5~6~7~8~9~10~
BarTextCol~f~1!{HCG=0,HCA=1,HLTH=1,NCDA=0.8,NCB=0,NCR=0.996,NCG=0.91,HCR=0,NCA=1,HCB=0,NDEBUFF="false",HDEBUFF="false",NAME=2,HCDA=0.5}
BarTextCol~d!2~3~4~5~6~7~8~9~10~
Icons~f~1!{RCEN="false",I15EN="false",CLASSEN="false",FADE="false",BUFFFADE="false",DEBUFFANCHOR=1,RCVOFFSET=-2,OORVOFFSET=0,DEBUFFDOUBLE="true",TARGETVOFFSET=0,BUFFONBAR=1,SHOWDIR="false",SHOWRC="true",TARGETANCHOR=6,RCSCALE=0.55,MAXBICONS=8,FADESECS=15,RCHOFFSET=0,TARGETHOFFSET=0,RCANCHOR=3,CLASSVOFFSET=0,SHOWCLASS="true",DSCALE=0.8,TARGETSCALE=0.4,SHOWROLE="true",BUFFDOUBLE="true",TARGETONBAR=3,BUFFANCHOR=2,SCALE=0.7,CLASSONBAR=3,OORONBAR=3,RCONBAR=3,MAXDICONS=4,CLASSSCALE=0.4,SHOWDIRMOUSE="false",CLASSHOFFSET=0,CLASSANCHOR=5,DEBUFFONBAR=1,OORANCHOR=1,BUFFI15EN="false",BUFFFADESECS=15,OORSCALE=0.5,TARGETEN="false",OOREN="false",OORHOFFSET=0}
Icons~f~2!{RCEN="false",I15EN="false",CLASSEN="false",TARGETEN="false",BUFFFADE="false",DEBUFFANCHOR=1,RCVOFFSET=-2,OORVOFFSET=0,DEBUFFDOUBLE="true",TARGETVOFFSET=0,BUFFONBAR=1,SHOWDIR="false",SHOWRC="true",TARGETANCHOR=6,RCSCALE=0.55,MAXBICONS=8,FADESECS=15,RCHOFFSET=0,TARGETHOFFSET=0,RCANCHOR=3,CLASSVOFFSET=0,OORHOFFSET=0,DSCALE=0.8,TARGETSCALE=0.4,FADE="false",SCALE=0.8,TARGETONBAR=3,SHOWDIRMOUSE="false",BUFFDOUBLE="false",CLASSONBAR=3,BUFFANCHOR=2,RCONBAR=3,MAXDICONS=4,CLASSSCALE=0.4,OORONBAR=3,CLASSHOFFSET=0,CLASSANCHOR=5,DEBUFFONBAR=1,OORANCHOR=1,BUFFI15EN="false",BUFFFADESECS=15,OORSCALE=0.5,SHOWROLE="true",OOREN="false",SHOWCLASS="false"}
Icons~d!3~4~5~6~
Icons~f~7!{RCEN="false",I15EN="false",CLASSEN="false",FADE="false",BUFFFADE="false",DEBUFFANCHOR=1,RCVOFFSET=-2,OORVOFFSET=0,DEBUFFDOUBLE="true",TARGETVOFFSET=0,BUFFONBAR=1,SHOWDIR="false",SHOWRC="true",TARGETANCHOR=6,RCSCALE=0.55,MAXBICONS=4,FADESECS=15,RCHOFFSET=0,TARGETHOFFSET=0,RCANCHOR=3,CLASSVOFFSET=0,SHOWCLASS="false",DSCALE=0.8,TARGETSCALE=0.4,SHOWROLE="false",BUFFDOUBLE="true",TARGETONBAR=3,BUFFANCHOR=2,SCALE=0.7,CLASSONBAR=3,OORONBAR=3,RCONBAR=3,MAXDICONS=2,CLASSSCALE=0.4,SHOWDIRMOUSE="false",CLASSHOFFSET=0,CLASSANCHOR=5,DEBUFFONBAR=1,OORANCHOR=1,BUFFI15EN="false",BUFFFADESECS=15,OORSCALE=0.5,TARGETEN="false",OOREN="false",OORHOFFSET=0}
Icons~f~8!{RCEN="false",I15EN="false",CLASSEN="false",FADE="false",BUFFFADE="false",DEBUFFANCHOR=1,RCVOFFSET=-2,OORVOFFSET=0,DEBUFFDOUBLE="true",TARGETVOFFSET=0,BUFFONBAR=1,SHOWDIR="false",SHOWRC="true",TARGETANCHOR=6,RCSCALE=0.55,MAXBICONS=8,FADESECS=15,RCHOFFSET=0,TARGETHOFFSET=0,RCANCHOR=3,CLASSVOFFSET=0,SHOWCLASS="false",DSCALE=0.8,TARGETSCALE=0.4,SHOWROLE="false",BUFFDOUBLE="true",TARGETONBAR=3,BUFFANCHOR=2,SCALE=0.7,CLASSONBAR=3,OORONBAR=3,RCONBAR=3,MAXDICONS=4,CLASSSCALE=0.4,SHOWDIRMOUSE="false",CLASSHOFFSET=0,CLASSANCHOR=5,DEBUFFONBAR=1,OORANCHOR=1,BUFFI15EN="false",BUFFFADESECS=15,OORSCALE=0.5,TARGETEN="false",OOREN="false",OORHOFFSET=0}
Icons~d!9~10~
RaidIcon~f~1!{SQUARE="true",CIRCLE="true",DIAMOND="true",SHOW="true",MOON="true",TRIANGLE="true",STAR="true",SKULL="true",CROSS="true"}
RaidIcon~d!2~3~4~5~6~7~8~9~10~
IconText~f~1!{DURWARN=3,BUFFHEIGHT=10,BUFFOUTLINE=2,BUFFDURTHRH=9,SCNT="true",DURTHRH=9,FONT="Friz Quadrata TT",BUFFFONT="Friz Quadrata TT",BUFFSCNT="true",SSCNT="false",BUFFSDUR="true",BUFFDURWARN=3,BUFFSSCNT="false",SDUR="true",BUFFSSDUR="true",HEIGHT=10,SSDUR="true",OUTLINE=2}
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
BarAggro~f~1!{R=1,ALERTIND=2,G=0.024,TEXTFORMAT=3,SHOW="true",SHOWTEXTPCT="true",SHOWIND="true",B=0.024,SHOWTEXT="false",ALERT=1}
BarAggro~f~2!{R=1,ALERTIND=2,G=0.024,TEXTFORMAT=3,SHOW="true",SHOWTEXTPCT="true",SHOWIND="true",B=0.024,SHOWTEXT="false",ALERT=2}
BarAggro~d!3~4~5~6~7~8~9~10~
AuxBarFrame~f~1!{OVERLAP=1}
AuxBarFrame~d!2~3~4~5~6~7~8~9~10~
AuxBar^1~f~1!{SIZE=1,USE=1,R=0.7,COLOUR=3,ANCHOR=4,OFFSET=0,DEPTH=4,B=0.2,OTYPE=1,G=0.7}
AuxBar^1~d!2~3~4~5~6~7~8~9~10~
AuxBar^2~f~1!{SIZE=1,USE=3,R=0.067,COLOUR=3,ANCHOR=4,OFFSET=0,DEPTH=3,B=0.035,OTYPE=1,G=0.918}
AuxBar^2~d!2~3~4~5~6~7~8~9~
AuxBar^2~f~10!{SIZE=1,USE=1,R=0.067,COLOUR=3,ANCHOR=4,OFFSET=0,DEPTH=3,B=0.035,OTYPE=1,G=0.918}
AuxBar^3~f~1!{SIZE=1,USE=7,R=0.918,COLOUR=3,ANCHOR=4,OFFSET=0,DEPTH=2,B=0,OTYPE=1,G=0.843}
AuxBar^3~d!2~3~4~5~6~7~8~9~
AuxBar^3~f~10!{SIZE=1,USE=1,R=0.918,COLOUR=3,ANCHOR=4,OFFSET=0,DEPTH=2,B=0,OTYPE=1,G=0.843}
AuxBar^4~f~1!{SIZE=1,USE=1,R=1,COLOUR=1,ANCHOR=3,OFFSET=0,DEPTH=2,B=1,OTYPE=1,G=1}
AuxBar^4~d!2~3~4~5~6~7~8~9~10~
AuxBar^5~f~1!{SIZE=1,USE=6,R=0.631,COLOUR=1,ANCHOR=3,OFFSET=0,DEPTH=3,B=0.247,OTYPE=1,G=0.247}
AuxBar^5~d!2~3~4~5~6~7~8~9~
AuxBar^5~f~10!{SIZE=1,USE=1,R=0.631,COLOUR=1,ANCHOR=3,OFFSET=0,DEPTH=3,B=0.247,OTYPE=1,G=0.247}
AuxBar^6~f~1!{SIZE=1,USE=5,R=1,COLOUR=1,ANCHOR=3,OFFSET=0,DEPTH=2,B=1,OTYPE=1,G=1}
AuxBar^6~d!2~3~4~5~6~7~8~9~
AuxBar^6~f~10!{SIZE=1,USE=1,R=1,COLOUR=1,ANCHOR=3,OFFSET=0,DEPTH=2,B=1,OTYPE=1,G=1}
AuxBar^7~f~1!{SIZE=0.58,USE=1,R=0.8,COLOUR=1,ANCHOR=2,OFFSET=1,DEPTH=2,B=0.8,OTYPE=2,G=0.2}
AuxBar^7~d!2~3~4~5~6~7~8~9~10~
AuxBar^8~f~1!{SIZE=0.95,USE=1,R=0.078,COLOUR=1,ANCHOR=2,OFFSET=-2,DEPTH=2,B=0.875,OTYPE=2,G=0.737}
AuxBar^8~d!2~3~4~5~6~7~8~9~10~
AuxBar^9~f~1!{SIZE=1,USE=4,R=1,COLOUR=1,ANCHOR=1,OFFSET=0,DEPTH=3,B=1,OTYPE=1,G=1}
AuxBar^9~d!2~3~4~5~6~7~8~9~
AuxBar^9~f~10!{SIZE=1,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=0,DEPTH=3,B=1,OTYPE=1,G=1}
Complete!]]

HealBot_ExtraSkinData[5]=[[Skin
Addydari
Author~v!ADDYDARI of HealBot Website
DuplicateBars~v!false
Chat~t!{EOCOOM="false",EOCOOMV=20,MSG="Casting #s on #n",RESONLY="true",NOTIFY=1}
General~t!{OFREQ=0.07,OMIN=0.1,OMAX=0.95,HIDEBOSSF="false",HIDEPTF="false",HIDEPARTYF="false",HIDERAIDF="true",STICKYFRAME="true",STICKYSENSITIVITY=20,FLUIDBARS="false",FLUIDFREQ=10}
Healing~t!{TONLYFRIEND="false",TARGETINCOMBAT=2,FOCUSINCOMBAT=2,GROUPPETS="true",FEXRAID="false",FONLYFRIEND="false",TEXRAID="false",SELFPET="false"}
Enemy~t!{ENEMYTARGET="false",INCTANKS="true",INCMYTAR="false",INCARENA="true",ENEMYTARGETSIZE=40,INCARENAPETS="false",HIDE="true",NUMBOSS=2,EXISTSHOWPTAR=1,INCSELF="false",EXISTSHOWBOSS="true",DOUBLEWIDTH="false",EXISTSHOWARENA=3}
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
Frame~f~1!{BACKR=0.1,AUTOCLOSE="false",BACKG=0.1,BACKB=0.1,LOCKED="false",SCALE=1,BORDERA=0.2,SFOFFSETV=0,TIPLOC=5,BORDERB=0.2,BACKA=0.05,OPENSOUND="false",SFOFFSETH=0,BORDERG=0.2,BORDERR=0.2}
Frame~d!2~3~4~5~6~7~
Frame~f~8!{BACKR=0.1,AUTOCLOSE="false",BACKG=0.1,BACKB=0.1,LOCKED="false",SCALE=1,BORDERA=0.2,SFOFFSETV=-8,TIPLOC=5,BORDERB=0.2,BACKA=0.05,OPENSOUND="false",SFOFFSETH=0,BORDERG=0.2,BORDERR=0.2}
Frame~d!9~
Frame~f~10!{BACKR=0.1,AUTOCLOSE="false",BACKG=0.1,BACKB=0.1,LOCKED="false",SCALE=1,BORDERA=0.2,SFOFFSETV=0,TIPLOC=5,BORDERB=0.2,BACKA=0.05,OPENSOUND="false",SFOFFSETH=0,BORDERG=0.2,BORDERR=0.2}
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
BarCol~f~1!{BACK=1,BA=0,BB=0.7,DISA=0.1,BR=0.4,HB=0.7,BG=0.4,HG=0.4,HA=1,HR=0.4,ORA=0.4,BOUT=1,HLTH=1}
BarCol~d!2~3~4~5~6~7~8~9~10~
BarIACol~f~1!{AC=3,AB=1,AA=0.78,AR=1,AG=1,IC=4,IB=0.2,IA=0.82,IR=0.2,IG=1}
BarIACol~d!2~3~4~5~6~7~8~9~10~
BarText~f~1!{HLTHONBAR="true",TAGOOR="[ OOR ] ",OVERHEAL=1,MAXCHARS=0,NAMEONBAR="true",CLASSONBAR="false",HOFFSET=0,OUTLINE=1,HLTHTYPE=1,INCHEALS=2,HLTHTXTANCHOR=1,FONT="Friz Quadrata TT",HMAXCHARS=0,INCABSORBS=1,NUMFORMAT2=1,HOUTLINE=1,TAGDC="[ DC ] ",HHEIGHT=10,TAGRIP="[ RIP ] ",HEIGHT=10,OFFSET=0,SHOWROLE="true",HALIGN=2,NUMFORMAT1=11,IGNOREONFULL="true",CLASSTYPE=1,HOFFSET2=0,ALIGN=2,TAGR="[ R ] ",HFONT="Friz Quadrata TT"}
BarText~d!2~3~4~5~6~7~8~9~10~
BarTextCol~f~1!{NCB=0,NCR=1,HCG=1,NCDA=0.8,NAME=2,HCA=1,NCG=1,NCA=1,NDEBUFF="false",HCB=0,HCR=1,HDEBUFF="false",HCDA=0.8,HLTH=2}
BarTextCol~d!2~3~4~5~6~7~8~9~10~
Icons~f~1!{SHOWBUFF="true",SHOWDEBUFF="true",FADESECS=15,I15EN="true",MAXDICONS=4,FADE="true",SHOWDIR="false",SHOWDIRMOUSE="false",DSCALE=1,ONBAR=1,SHOWRC="true",SCALE=1,DOUBLE="true",POSITION=2,MAXBICONS=8}
Icons~d!2~3~4~5~6~7~8~9~10~
RaidIcon~f~1!{SQUARE="true",CIRCLE="true",DIAMOND="true",SHOW="true",MOON="true",TRIANGLE="true",STAR="true",CROSS="true",SKULL="true"}
RaidIcon~d!2~3~4~5~6~7~8~9~10~
IconText~f~1!{DURWARN=3,HEIGHT=12,SSCNT="false",SCNT="true",DURTHRH=9,FONT="Friz Quadrata TT",SDUR="false",SSDUR="true",OUTLINE=2}
IconText~d!2~3~4~5~6~7~8~9~10~
BarVisibility~f~1!{INCCLASSES=1,ALERTIC=0.98,ALERTOC=0.95,HIDEOOR="false"}
BarVisibility~d!2~3~4~5~6~7~8~9~10~
BarSort~f~1!{SUBORDER=1,OORLAST="false",RAIDORDER=3,SUBPF="true"}
BarSort~d!2~3~4~5~6~7~8~9~10~
BarAggro~f~1!{R=1,ALERTIND=2,G=0,TEXTFORMAT=3,SHOW="true",SHOWTEXTPCT="false",B=0,SHOWTEXT="false",SHOWIND="true",ALERT=3}
BarAggro~d!2~3~4~5~6~7~8~9~10~
AuxBarFrame~f~1!{OVERLAP=1}
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
General~t!{OFREQ=0.07,OMIN=0.1,OMAX=0.95,HIDEBOSSF="false",HIDEPTF="false",FLUIDFREQ=10,STICKYSENSITIVITY=30,HIDERAIDF="true",STICKYFRAME="true",FLUIDBARS="false",HIDEPARTYF="true"}
Healing~t!{TONLYFRIEND="false",FEXRAID="false",FOCUSINCOMBAT=2,GROUPPETS="true",SELFPET="false",TEXRAID="false",FONLYFRIEND="false",TARGETINCOMBAT=2}
Enemy~t!{INCARENA="true",INCTANKS="true",INCMYTAR="false",HIDE="true",ENEMYTARGETSIZE=40,INCARENAPETS="false",ENEMYTARGET="false",NUMBOSS=2,EXISTSHOWPTAR=1,INCSELF="false",EXISTSHOWBOSS="true",DOUBLEWIDTH="false",EXISTSHOWARENA=3}
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
AuxBarFrame~f~1!{OVERLAP=1}
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
General~t!{HIDEBOSSF="true",STICKYSENSITIVITY=40,FLUIDBARS="false",HIDEPARTYF="false",HIDEPTF="false",OMIN=0.1,HIDERAIDF="true",OFREQ=0.07,STICKYFRAME="true",OMAX=0.95,FLUIDFREQ=10}
Healing~t!{TONLYFRIEND="false",TARGETINCOMBAT=1,FOCUSINCOMBAT=2,GROUPPETS="true",FEXRAID="false",FONLYFRIEND="false",TEXRAID="false",SELFPET="false"}
Enemy~t!{ENEMYTARGET="true",INCTANKS="true",INCMYTAR="false",INCARENA="false",INCARENAPETS="false",ENEMYTARGETSIZE=70,INCSELF="false",NUMBOSS=4,EXISTSHOWPTAR=1,HIDE="true",EXISTSHOWBOSS="true",DOUBLEWIDTH="false",EXISTSHOWARENA=3}
FrameAlias~f~1!{A=1,NAME="",R=1,ALIAS="Tanks",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~2!{A=1,NAME="",R=1,ALIAS="Raid",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~3!{SIZE=12,NAME="Healers",R=1,ALIAS="Healers",G=1,SHOW="true",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~4!{A=1,NAME="",R=1,G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~d!5~
FrameAlias~f~6!{SIZE=12,NAME="Vehicle",R=1,ALIAS="Vehicle",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~7!{SIZE=12,NAME="Pets",R=1,ALIAS="Pets",G=1,SHOW="true",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~8!{SIZE=12,NAME="Target",R=1,ALIAS="Target",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~9!{SIZE=12,NAME="Focus",R=1,ALIAS="Focus",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~10!{SIZE=12,NAME="Enemy",R=1,ALIAS="Enemy",G=0,SHOW="true",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=0,OUTLINE=1}
FrameAliasBar~f~1!{A=0.2,TEXTURE="Skewed",B=0.1,HEIGHT=20,R=0.1,G=0.1,WIDTH=0.9}
FrameAliasBar~d!2~
FrameAliasBar~f~3!{A=0.2,TEXTURE="Skewed",B=0.1,HEIGHT=15,R=0.1,G=0.1,WIDTH=0.9}
FrameAliasBar~f~4!{A=0.2,TEXTURE="Skewed",B=0.1,HEIGHT=20,R=0.1,G=0.1,WIDTH=0.9}
FrameAliasBar~d!5~6~
FrameAliasBar~f~7!{A=0,TEXTURE="Aluminium",B=1,HEIGHT=20,R=1,G=1,WIDTH=0.92}
FrameAliasBar~f~8!{A=0.2,TEXTURE="Skewed",B=0.1,HEIGHT=20,R=0.1,G=0.1,WIDTH=0.9}
FrameAliasBar~d!9~
FrameAliasBar~f~10!{A=0.2,TEXTURE="Skewed",B=0.1,HEIGHT=15,R=0.1,G=0.1,WIDTH=0.9}
Frame~f~1!{BORDERR=0.1,AUTOCLOSE="false",BACKG=0.1,BORDERB=0.1,LOCKED="false",SCALE=1,BORDERA=0.04,BORDERG=0.1,TIPLOC=1,BACKB=0.7,BACKA=0.1,OPENSOUND="false",SFOFFSETV=0,SFOFFSETH=0,BACKR=0.1}
Frame~f~2!{BORDERR=0.1,AUTOCLOSE="false",BACKG=0.102,BORDERB=0.1,LOCKED="true",SCALE=1,BORDERA=0.04,BORDERG=0.1,TIPLOC=1,BACKB=0.702,BACKA=0,OPENSOUND="false",SFOFFSETV=0,SFOFFSETH=8,BACKR=0.102}
Frame~f~3!{BORDERR=0.1,AUTOCLOSE="false",BACKG=0.1,BORDERB=0.1,LOCKED="false",SCALE=1,BORDERA=0.04,BORDERG=0.1,TIPLOC=1,BACKB=0.7,BACKA=0.1,OPENSOUND="false",SFOFFSETV=4,SFOFFSETH=0,BACKR=0.1}
Frame~f~4!{BORDERR=0.1,AUTOCLOSE="false",BACKG=0.1,BORDERB=0.1,LOCKED="false",SCALE=1,BORDERA=0.04,BORDERG=0.1,TIPLOC=5,BACKB=0.7,BACKA=0.1,OPENSOUND="false",SFOFFSETV=0,SFOFFSETH=0,BACKR=0.1}
Frame~d!5~6~
Frame~f~7!{BORDERR=0.1,AUTOCLOSE="false",BACKG=0.102,BORDERB=0.1,LOCKED="true",SCALE=1,BORDERA=0.04,BORDERG=0.1,TIPLOC=1,BACKB=0.702,BACKA=0,OPENSOUND="false",SFOFFSETV=7,SFOFFSETH=-4,BACKR=0.102}
Frame~f~8!{BORDERR=0.1,AUTOCLOSE="false",BACKG=0.1,BORDERB=0.1,LOCKED="true",SCALE=1,BORDERA=0.04,BORDERG=0.1,TIPLOC=2,BACKB=0.7,BACKA=0.1,OPENSOUND="false",SFOFFSETV=1,SFOFFSETH=9,BACKR=0.1}
Frame~f~9!{BORDERR=0.1,AUTOCLOSE="false",BACKG=0.1,BORDERB=0.1,LOCKED="true",SCALE=1,BORDERA=0.04,BORDERG=0.1,TIPLOC=2,BACKB=0.7,BACKA=0.1,OPENSOUND="false",SFOFFSETV=0,SFOFFSETH=9,BACKR=0.1}
Frame~f~10!{BORDERR=0.1,AUTOCLOSE="false",BACKG=0.1,BORDERB=0.1,LOCKED="false",SCALE=1,BORDERA=0.04,BORDERG=0.1,TIPLOC=1,BACKB=0.7,BACKA=0.1,OPENSOUND="false",SFOFFSETV=0,SFOFFSETH=0,BACKR=0.1}
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
Anchors~f~10!{Y=66.35,GROW=2,BARS=2,FRAME=4,X=94.48}
HeadBar~f~1!{SHOW="true",TEXTURE="Aluminium",R=1,B=1,HEIGHT=15,A=0,G=1,WIDTH=1}
HeadBar~d!2~
HeadBar~f~3!{SHOW="false",TEXTURE="Skewed",R=0.102,B=0.102,HEIGHT=10,A=0,G=0.102,WIDTH=0.9}
HeadBar~f~4!{SHOW="false",TEXTURE="Skewed",R=0.1,B=0.1,HEIGHT=20,A=0.2,G=0.1,WIDTH=0.9}
HeadBar~d!5~6~
HeadBar~f~7!{SHOW="false",TEXTURE="Aluminium",R=0.102,B=0.102,HEIGHT=20,A=0,G=0.102,WIDTH=0.5}
HeadBar~f~8!{SHOW="true",TEXTURE="Skewed",R=0.102,B=0.102,HEIGHT=15,A=0,G=0.102,WIDTH=0.9}
HeadBar~d!9~
HeadBar~f~10!{SHOW="false",TEXTURE="Skewed",R=0.102,B=0.102,HEIGHT=20,A=0,G=0.102,WIDTH=0.9}
HeadText~f~1!{A=1,R=1,OFFSET=0,B=1,FONT="Friz Quadrata TT",HEIGHT=11,G=1,OUTLINE=1}
HeadText~d!2~
HeadText~f~3!{A=0.4,R=1,OFFSET=0,B=0.1,FONT="Friz Quadrata TT",HEIGHT=9,G=1,OUTLINE=1}
HeadText~d!4~5~6~
HeadText~f~7!{A=1,R=1,OFFSET=0,B=1,FONT="Friz Quadrata TT",HEIGHT=11,G=1,OUTLINE=1}
HeadText~f~8!{A=1,R=0.957,OFFSET=0,B=0.957,FONT="Friz Quadrata TT",HEIGHT=11,G=0.957,OUTLINE=1}
HeadText~f~9!{A=1,R=1,OFFSET=0,B=1,FONT="Friz Quadrata TT",HEIGHT=11,G=1,OUTLINE=1}
HeadText~f~10!{A=0.4,R=1,OFFSET=0,B=0.1,FONT="Friz Quadrata TT",HEIGHT=9,G=1,OUTLINE=1}
HealBar~f~1!{HEIGHT=32,GRPCOLS="false",CMARGIN=0,TEXTURE="Smooth v2",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=142,RMARGIN=0,OFIX=1,NUMCOLS=1,LOWMANA=1}
HealBar~f~2!{HEIGHT=32,GRPCOLS="false",CMARGIN=0,TEXTURE="Smooth v2",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=80,RMARGIN=0,OFIX=1,NUMCOLS=1,LOWMANA=1}
HealBar~f~3!{HEIGHT=32,GRPCOLS="false",CMARGIN=0,TEXTURE="Smooth v2",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=70,RMARGIN=0,OFIX=1,NUMCOLS=2,LOWMANA=1}
HealBar~f~4!{HEIGHT=32,GRPCOLS="false",CMARGIN=0,TEXTURE="Charcoal",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=80,RMARGIN=0,OFIX=1,NUMCOLS=1,LOWMANA=1}
HealBar~d!5~6~
HealBar~f~7!{HEIGHT=28,GRPCOLS="false",CMARGIN=0,TEXTURE="Smooth v2",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=80,RMARGIN=0,OFIX=1,NUMCOLS=5,LOWMANA=1}
HealBar~f~8!{HEIGHT=32,GRPCOLS="false",CMARGIN=0,TEXTURE="Charcoal",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=80,RMARGIN=0,OFIX=1,NUMCOLS=1,LOWMANA=1}
HealBar~d!9~
HealBar~f~10!{HEIGHT=32,GRPCOLS="false",CMARGIN=0,TEXTURE="Smooth v2",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=184,RMARGIN=0,OFIX=1,NUMCOLS=3,LOWMANA=1}
BarCol~f~1!{BACK=1,BA=0.25,BOUT=1,DISA=0.1,BR=0.2,HB=0.4,BG=0.4,HR=0.2,HA=0.95,HG=0.4,ORA=0.4,BB=0.4,HLTH=2}
BarCol~d!2~
BarCol~f~3!{BACK=1,BA=0.25,BOUT=1,DISA=0.12,BR=0.2,HB=0.4,BG=0.4,HR=0.2,HA=0.95,HG=0.4,ORA=0.3,BB=0.4,HLTH=2}
BarCol~f~4!{BACK=2,BA=0.05,BOUT=1,DISA=0.12,BR=0.2,HB=0.4,BG=0.4,HR=0.2,HA=0.95,HG=0.4,ORA=0.3,BB=0.4,HLTH=2}
BarCol~d!5~6~
BarCol~f~7!{BACK=1,BA=0.25,BOUT=1,DISA=0.1,BR=0.2,HB=0.4,BG=0.4,HR=0.2,HA=0.95,HG=0.4,ORA=0.4,BB=0.4,HLTH=2}
BarCol~f~8!{BACK=2,BA=0.05,BOUT=1,DISA=0.12,BR=0.2,HB=0.4,BG=0.4,HR=0.2,HA=0.95,HG=0.4,ORA=0.3,BB=0.4,HLTH=1}
BarCol~d!9~
BarCol~f~10!{BACK=2,BA=0.05,BOUT=1,DISA=0.12,BR=0.2,HB=0.051,BG=0.4,HR=0.678,HA=0.95,HG=0.102,ORA=0.3,BB=0.4,HLTH=3}
BarIACol~f~1!{AC=4,AB=0.8,AA=0.5,AR=0.2,AG=0.8,IC=2,IB=1,IA=0.58,IR=1,IG=1}
BarIACol~d!2~3~
BarIACol~f~4!{AC=3,AB=1,AA=0.5,AR=1,AG=1,IC=2,IB=0.2,IA=0.58,IR=0.2,IG=0.8}
BarIACol~d!5~6~
BarIACol~f~7!{AC=4,AB=0.8,AA=0.5,AR=0.2,AG=0.8,IC=2,IB=1,IA=0.58,IR=1,IG=1}
BarIACol~f~8!{AC=3,AB=1,AA=0.5,AR=1,AG=1,IC=2,IB=0.2,IA=0.58,IR=0.2,IG=0.8}
BarIACol~d!9~10~
BarText~f~1!{HLTHONBAR="true",TAGOOR="OOR-",HOUTLINE=1,MAXCHARS=10,HMAXCHARS=0,HOFFSET=0,HFONT="Friz Quadrata TT",INCHEALS=2,HLTHTXTANCHOR=1,HLTHTYPE=1,CLASSONBAR="false",FONT="Friz Quadrata TT",NUMFORMAT2=1,IGNOREONFULL="true",TAGDC="DC-",NUMFORMAT1=11,NAMEONBAR="true",HEIGHT=11,HHEIGHT=12,SHOWROLE="true",HALIGN=2,OFFSET=0,TAGRIP="",OVERHEAL=2,INCABSORBS=2,HOFFSET2=0,ALIGN=2,TAGR="",OUTLINE=1}
BarText~f~2!{HLTHONBAR="true",TAGOOR="OOR-",HOUTLINE=1,MAXCHARS=0,HMAXCHARS=0,HOFFSET=0,HFONT="Friz Quadrata TT",INCHEALS=2,HLTHTXTANCHOR=1,HLTHTYPE=1,CLASSONBAR="false",FONT="Friz Quadrata TT",NUMFORMAT2=1,IGNOREONFULL="true",TAGDC="DC-",NUMFORMAT1=11,NAMEONBAR="true",HEIGHT=10,HHEIGHT=12,SHOWROLE="true",HALIGN=2,OFFSET=0,TAGRIP="",OVERHEAL=2,INCABSORBS=2,HOFFSET2=0,ALIGN=2,TAGR="",OUTLINE=1}
BarText~d!3~
BarText~f~4!{HLTHONBAR="true",TAGOOR="[ OOR ] ",HOUTLINE=1,MAXCHARS=0,HMAXCHARS=0,HOFFSET=0,HFONT="Friz Quadrata TT",INCHEALS=2,HLTHTXTANCHOR=1,HLTHTYPE=1,CLASSONBAR="false",FONT="Friz Quadrata TT",NUMFORMAT2=1,IGNOREONFULL="true",TAGDC="[ DC ] ",NUMFORMAT1=11,NAMEONBAR="true",HEIGHT=10,HHEIGHT=12,SHOWROLE="true",HALIGN=2,OFFSET=0,TAGRIP="[ RIP ] ",OVERHEAL=2,INCABSORBS=2,HOFFSET2=0,ALIGN=2,TAGR="[ R ] ",OUTLINE=1}
BarText~d!5~6~
BarText~f~7!{HLTHONBAR="true",TAGOOR="OOR-",HOUTLINE=1,MAXCHARS=8,HMAXCHARS=0,HOFFSET=0,HFONT="Friz Quadrata TT",INCHEALS=2,HLTHTXTANCHOR=1,HLTHTYPE=1,CLASSONBAR="false",FONT="Friz Quadrata TT",NUMFORMAT2=1,IGNOREONFULL="true",TAGDC="",NUMFORMAT1=11,NAMEONBAR="true",HEIGHT=10,HHEIGHT=12,SHOWROLE="true",HALIGN=2,OFFSET=0,TAGRIP="",OVERHEAL=2,INCABSORBS=2,HOFFSET2=0,ALIGN=2,TAGR="",OUTLINE=1}
BarText~f~8!{HLTHONBAR="true",TAGOOR="",HOUTLINE=1,MAXCHARS=0,HMAXCHARS=0,HOFFSET=0,HFONT="Friz Quadrata TT",INCHEALS=2,HLTHTXTANCHOR=1,HLTHTYPE=1,CLASSONBAR="false",FONT="Friz Quadrata TT",NUMFORMAT2=1,IGNOREONFULL="true",TAGDC="",NUMFORMAT1=11,NAMEONBAR="true",HEIGHT=10,HHEIGHT=12,SHOWROLE="true",HALIGN=2,OFFSET=0,TAGRIP="",OVERHEAL=2,INCABSORBS=2,HOFFSET2=0,ALIGN=2,TAGR="",OUTLINE=1}
BarText~d!9~
BarText~f~10!{HLTHONBAR="true",TAGOOR="OOR-",HOUTLINE=1,MAXCHARS=0,HMAXCHARS=0,HOFFSET=0,HFONT="Friz Quadrata TT",INCHEALS=2,HLTHTXTANCHOR=1,HLTHTYPE=1,CLASSONBAR="false",FONT="Friz Quadrata TT",NUMFORMAT2=1,IGNOREONFULL="true",TAGDC="",NUMFORMAT1=11,NAMEONBAR="true",HEIGHT=10,HHEIGHT=12,SHOWROLE="true",HALIGN=2,OFFSET=0,TAGRIP="",OVERHEAL=2,INCABSORBS=2,HOFFSET2=0,ALIGN=2,TAGR="",OUTLINE=1}
BarTextCol~f~1!{NAME=2,NCR=1,HCDA=0.7,NCDA=0.7,HCG=1,NDEBUFF="false",NCG=1,HCR=1,NCA=1,HCB=0,HCA=1,HDEBUFF="false",NCB=0,HLTH=1}
BarTextCol~d!2~3~4~5~6~7~8~9~10~
Icons~f~1!{RCEN="false",I15EN="true",CLASSEN="false",BUFFANCHOR=2,BUFFFADE="false",DEBUFFANCHOR=1,RCVOFFSET=-2,OORVOFFSET=0,DEBUFFDOUBLE="true",TARGETVOFFSET=2,BUFFONBAR=1,SHOWDIR="false",SHOWRC="true",TARGETANCHOR=5,RCSCALE=0.5,MAXBICONS=4,FADESECS=15,RCHOFFSET=0,TARGETHOFFSET=10,RCANCHOR=3,CLASSVOFFSET=0,FADE="false",DSCALE=0.8,OORHOFFSET=0,SCALE=0.8,BUFFDOUBLE="true",TARGETONBAR=3,TARGETEN="false",TARGETSCALE=0.45,SHOWCLASS="false",CLASSONBAR=1,RCONBAR=3,MAXDICONS=2,CLASSSCALE=0.5,SHOWROLE="false",CLASSHOFFSET=0,CLASSANCHOR=1,DEBUFFONBAR=1,OORANCHOR=1,BUFFI15EN="true",BUFFFADESECS=15,OORSCALE=0.5,OORONBAR=3,OOREN="false",SHOWDIRMOUSE="false"}
Icons~f~2!{RCEN="false",I15EN="true",CLASSEN="false",BUFFANCHOR=2,BUFFFADE="false",DEBUFFANCHOR=1,RCVOFFSET=-2,OORVOFFSET=0,DEBUFFDOUBLE="true",TARGETVOFFSET=2,BUFFONBAR=1,SHOWDIR="false",SHOWRC="true",TARGETANCHOR=5,RCSCALE=0.5,MAXBICONS=8,FADESECS=15,RCHOFFSET=0,TARGETHOFFSET=10,RCANCHOR=3,CLASSVOFFSET=0,FADE="false",DSCALE=0.8,OORHOFFSET=0,SCALE=0.8,BUFFDOUBLE="true",TARGETONBAR=3,TARGETEN="false",TARGETSCALE=0.45,SHOWCLASS="false",CLASSONBAR=1,RCONBAR=3,MAXDICONS=4,CLASSSCALE=0.5,SHOWROLE="false",CLASSHOFFSET=0,CLASSANCHOR=1,DEBUFFONBAR=1,OORANCHOR=1,BUFFI15EN="true",BUFFFADESECS=15,OORSCALE=0.5,OORONBAR=3,OOREN="false",SHOWDIRMOUSE="false"}
Icons~f~3!{RCEN="false",I15EN="true",CLASSEN="false",BUFFANCHOR=2,BUFFFADE="false",DEBUFFANCHOR=1,RCVOFFSET=-2,OORVOFFSET=0,DEBUFFDOUBLE="true",TARGETVOFFSET=2,BUFFONBAR=1,SHOWDIR="false",SHOWRC="true",TARGETANCHOR=5,RCSCALE=0.5,MAXBICONS=8,FADESECS=15,RCHOFFSET=0,TARGETHOFFSET=10,RCANCHOR=3,CLASSVOFFSET=0,FADE="false",DSCALE=0.8,OORHOFFSET=0,SCALE=0.8,BUFFDOUBLE="true",TARGETONBAR=3,TARGETEN="false",TARGETSCALE=0.45,SHOWCLASS="false",CLASSONBAR=1,RCONBAR=3,MAXDICONS=3,CLASSSCALE=0.5,SHOWROLE="false",CLASSHOFFSET=0,CLASSANCHOR=1,DEBUFFONBAR=1,OORANCHOR=1,BUFFI15EN="true",BUFFFADESECS=15,OORSCALE=0.5,OORONBAR=3,OOREN="false",SHOWDIRMOUSE="false"}
Icons~d!4~5~6~
Icons~f~7!{RCEN="false",I15EN="true",CLASSEN="false",BUFFANCHOR=2,BUFFFADE="false",DEBUFFANCHOR=1,RCVOFFSET=-2,OORVOFFSET=0,DEBUFFDOUBLE="true",TARGETVOFFSET=2,BUFFONBAR=1,SHOWDIR="false",SHOWRC="true",TARGETANCHOR=5,RCSCALE=0.5,MAXBICONS=4,FADESECS=15,RCHOFFSET=0,TARGETHOFFSET=10,RCANCHOR=3,CLASSVOFFSET=0,FADE="false",DSCALE=0.8,OORHOFFSET=0,SCALE=0.8,BUFFDOUBLE="true",TARGETONBAR=3,TARGETEN="false",TARGETSCALE=0.45,SHOWCLASS="false",CLASSONBAR=1,RCONBAR=3,MAXDICONS=2,CLASSSCALE=0.5,SHOWROLE="false",CLASSHOFFSET=0,CLASSANCHOR=1,DEBUFFONBAR=1,OORANCHOR=1,BUFFI15EN="true",BUFFFADESECS=15,OORSCALE=0.5,OORONBAR=3,OOREN="false",SHOWDIRMOUSE="false"}
Icons~f~8!{RCEN="false",I15EN="true",CLASSEN="false",BUFFANCHOR=2,BUFFFADE="false",DEBUFFANCHOR=1,RCVOFFSET=-2,OORVOFFSET=0,DEBUFFDOUBLE="true",TARGETVOFFSET=2,BUFFONBAR=1,SHOWDIR="false",SHOWRC="true",TARGETANCHOR=5,RCSCALE=0.5,MAXBICONS=6,FADESECS=15,RCHOFFSET=0,TARGETHOFFSET=10,RCANCHOR=3,CLASSVOFFSET=0,FADE="false",DSCALE=0.8,OORHOFFSET=0,SCALE=0.8,BUFFDOUBLE="true",TARGETONBAR=3,TARGETEN="false",TARGETSCALE=0.45,SHOWCLASS="false",CLASSONBAR=1,RCONBAR=3,MAXDICONS=2,CLASSSCALE=0.5,SHOWROLE="false",CLASSHOFFSET=0,CLASSANCHOR=1,DEBUFFONBAR=1,OORANCHOR=1,BUFFI15EN="true",BUFFFADESECS=15,OORSCALE=0.5,OORONBAR=3,OOREN="false",SHOWDIRMOUSE="false"}
Icons~d!9~
Icons~f~10!{RCEN="false",I15EN="true",CLASSEN="false",BUFFANCHOR=2,BUFFFADE="false",DEBUFFANCHOR=1,RCVOFFSET=-2,OORVOFFSET=0,DEBUFFDOUBLE="true",TARGETVOFFSET=2,BUFFONBAR=1,SHOWDIR="false",SHOWRC="true",TARGETANCHOR=5,RCSCALE=0.5,MAXBICONS=8,FADESECS=15,RCHOFFSET=0,TARGETHOFFSET=10,RCANCHOR=3,CLASSVOFFSET=0,FADE="false",DSCALE=0.8,OORHOFFSET=0,SCALE=0.8,BUFFDOUBLE="true",TARGETONBAR=3,TARGETEN="false",TARGETSCALE=0.45,SHOWCLASS="false",CLASSONBAR=1,RCONBAR=3,MAXDICONS=3,CLASSSCALE=0.5,SHOWROLE="false",CLASSHOFFSET=0,CLASSANCHOR=1,DEBUFFONBAR=1,OORANCHOR=1,BUFFI15EN="true",BUFFFADESECS=15,OORSCALE=0.5,OORONBAR=3,OOREN="false",SHOWDIRMOUSE="false"}
RaidIcon~f~1!{SQUARE="true",CIRCLE="true",DIAMOND="true",SHOW="true",MOON="true",TRIANGLE="true",STAR="true",CROSS="true",SKULL="true"}
RaidIcon~d!2~3~4~5~6~7~8~9~10~
IconText~f~1!{SDUR="false",BUFFSSDUR="true",BUFFOUTLINE=2,BUFFDURTHRH=9,SCNT="true",DURTHRH=9,FONT="Friz Quadrata TT",BUFFFONT="Friz Quadrata TT",BUFFSCNT="true",SSCNT="false",BUFFSDUR="false",BUFFDURWARN=3,DURWARN=3,BUFFHEIGHT=10,HEIGHT=10,BUFFSSCNT="false",SSDUR="true",OUTLINE=2}
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
BarAggro~f~1!{B=0,ALERTIND=2,G=0,TEXTFORMAT=3,SHOW="true",SHOWTEXTPCT="false",SHOWTEXT="false",R=1,SHOWIND="true",ALERT=2}
BarAggro~d!2~3~4~5~6~7~8~9~10~
AuxBarFrame~f~1!{OVERLAP=1}
AuxBarFrame~d!2~3~4~5~6~7~8~9~10~
AuxBar^1~f~1!{SIZE=1,USE=1,B=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=3,G=1,OTYPE=1,R=1}
AuxBar^1~d!2~3~4~5~6~7~8~9~10~
AuxBar^2~f~1!{SIZE=1,USE=1,B=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=2,G=1,OTYPE=2,R=1}
AuxBar^2~d!2~3~4~5~6~7~8~9~10~
AuxBar^3~f~1!{SIZE=1,USE=1,B=1,COLOUR=1,ANCHOR=2,OFFSET=1,DEPTH=3,G=1,OTYPE=2,R=1}
AuxBar^3~d!2~3~4~5~6~7~8~9~10~
AuxBar^4~f~1!{SIZE=1,USE=1,B=1,COLOUR=1,ANCHOR=3,OFFSET=1,DEPTH=3,G=1,OTYPE=1,R=1}
AuxBar^4~d!2~3~4~5~6~7~8~9~10~
AuxBar^5~f~1!{SIZE=1,USE=1,B=1,COLOUR=1,ANCHOR=4,OFFSET=1,DEPTH=3,G=1,OTYPE=1,R=1}
AuxBar^5~d!2~3~4~5~6~7~8~9~10~
AuxBar^6~f~1!{SIZE=1,USE=1,B=1,COLOUR=1,ANCHOR=2,OFFSET=-3,DEPTH=3,G=1,OTYPE=2,R=1}
AuxBar^6~d!2~3~4~5~6~7~8~9~10~
AuxBar^7~f~1!{SIZE=1,USE=1,B=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,OTYPE=1,R=1}
AuxBar^7~d!2~3~4~5~6~7~8~9~10~
AuxBar^8~f~1!{SIZE=1,USE=1,B=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,OTYPE=1,R=1}
AuxBar^8~d!2~3~4~5~6~7~8~9~10~
AuxBar^9~f~1!{SIZE=0.98,USE=1,B=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,OTYPE=1,R=1}
AuxBar^9~d!2~3~4~5~6~7~8~9~10~
Complete!]]

HealBot_ExtraSkinData[8]=[[Skin
Full 40
Author~v!Monti of Terenas
DuplicateBars~v!true
Chat~t!{EOCOOM="false",EOCOOMV=20,MSG="Casting #s on #n",RESONLY="true",NOTIFY=1}
General~t!{OFREQ=0.07,STICKYSENSITIVITY=40,FLUIDBARS="false",FLUIDFREQ=10,HIDEPTF="false",OMAX=0.95,HIDERAIDF="true",HIDEPARTYF="false",STICKYFRAME="true",OMIN=0.1,HIDEBOSSF="true"}
Healing~t!{TONLYFRIEND="false",TARGETINCOMBAT=2,FOCUSINCOMBAT=2,GROUPPETS="true",FEXRAID="false",FONLYFRIEND="false",TEXRAID="false",SELFPET="false"}
Enemy~t!{ENEMYTARGET="false",INCTANKS="true",INCMYTAR="false",INCARENA="true",ENEMYTARGETSIZE=40,INCARENAPETS="false",HIDE="true",NUMBOSS=2,EXISTSHOWPTAR=1,INCSELF="false",EXISTSHOWBOSS="true",DOUBLEWIDTH="false",EXISTSHOWARENA=3}
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
Frame~f~1!{SFOFFSETH=0,AUTOCLOSE="false",BACKG=0.102,BORDERB=0.102,LOCKED="false",SCALE=1,BORDERA=0,BORDERG=0.102,TIPLOC=4,BACKB=0.702,BACKA=0,OPENSOUND="false",SFOFFSETV=0,BACKR=0.102,BORDERR=0.102}
Frame~f~2!{SFOFFSETH=8,AUTOCLOSE="false",BACKG=0.102,BORDERB=0.102,LOCKED="true",SCALE=1,BORDERA=0,BORDERG=0.102,TIPLOC=2,BACKB=0.702,BACKA=0,OPENSOUND="false",SFOFFSETV=0,BACKR=0.102,BORDERR=0.102}
Frame~f~3!{SFOFFSETH=0,AUTOCLOSE="false",BACKG=0.1,BORDERB=0.1,LOCKED="true",SCALE=1,BORDERA=0.04,BORDERG=0.1,TIPLOC=5,BACKB=0.7,BACKA=0.1,OPENSOUND="false",SFOFFSETV=8,BACKR=0.1,BORDERR=0.1}
Frame~f~4!{SFOFFSETH=0,AUTOCLOSE="false",BACKG=0.1,BORDERB=0.1,LOCKED="false",SCALE=1,BORDERA=0.04,BORDERG=0.1,TIPLOC=5,BACKB=0.7,BACKA=0.1,OPENSOUND="false",SFOFFSETV=0,BACKR=0.1,BORDERR=0.1}
Frame~d!5~6~
Frame~f~7!{SFOFFSETH=-4,AUTOCLOSE="false",BACKG=0.102,BORDERB=0.1,LOCKED="true",SCALE=1,BORDERA=0.04,BORDERG=0.1,TIPLOC=5,BACKB=0.702,BACKA=0,OPENSOUND="false",SFOFFSETV=7,BACKR=0.102,BORDERR=0.1}
Frame~f~8!{SFOFFSETH=9,AUTOCLOSE="false",BACKG=0.1,BORDERB=0.1,LOCKED="false",SCALE=1,BORDERA=0.04,BORDERG=0.1,TIPLOC=2,BACKB=0.7,BACKA=0.1,OPENSOUND="false",SFOFFSETV=0,BACKR=0.1,BORDERR=0.1}
Frame~d!9~
Frame~f~10!{SFOFFSETH=0,AUTOCLOSE="false",BACKG=0.102,BORDERB=0.102,LOCKED="true",SCALE=1,BORDERA=0,BORDERG=0.102,TIPLOC=2,BACKB=0.702,BACKA=0,OPENSOUND="false",SFOFFSETV=0,BACKR=0.102,BORDERR=0.102}
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
Anchors~f~2!{Y=68.03,GROW=2,BARS=1,FRAME=3,X=88.86}
Anchors~f~3!{Y=59.57,GROW=2,BARS=1,FRAME=3,X=95.1}
Anchors~f~4!{Y=53,GROW=2,BARS=1,FRAME=1,X=53}
Anchors~f~5!{Y=54,GROW=2,BARS=1,FRAME=1,X=54}
Anchors~f~6!{Y=55,GROW=2,BARS=1,FRAME=1,X=55}
Anchors~f~7!{Y=63.97,GROW=1,BARS=1,FRAME=1,X=85.64}
Anchors~f~8!{Y=2.37,GROW=2,BARS=1,FRAME=3,X=96.13}
Anchors~f~9!{Y=63.74,GROW=2,BARS=1,FRAME=4,X=88.96}
Anchors~f~10!{Y=68.03,GROW=2,BARS=2,FRAME=2,X=85.78}
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
BarCol~f~10!{BACK=2,BA=0.25,BOUT=1,DISA=0.1,BR=0.2,HB=0.059,BG=0.4,BB=0.4,HA=0.95,HR=0.914,ORA=0.4,HG=0.059,HLTH=3}
BarIACol~f~1!{AC=4,AB=1,AA=0.5,AR=1,AG=1,IC=2,IB=0.2,IA=0.58,IR=0.2,IG=0.8}
BarIACol~d!2~3~4~5~6~7~8~9~10~
BarText~f~1!{HLTHONBAR="true",TAGOOR="OOR-",HOUTLINE=1,MAXCHARS=10,CLASSONBAR="false",HFONT="Friz Quadrata TT",HOFFSET=0,INCHEALS=2,HLTHTXTANCHOR=1,HLTHTYPE=3,HMAXCHARS=0,OFFSET=0,NUMFORMAT2=1,IGNOREONFULL="true",TAGDC="DC-",HHEIGHT=10,TAGRIP="",HEIGHT=10,NUMFORMAT1=11,SHOWROLE="true",HALIGN=2,FONT="Friz Quadrata TT",NAMEONBAR="true",OVERHEAL=1,INCABSORBS=1,HOFFSET2=0,ALIGN=2,TAGR="",OUTLINE=1}
BarText~d!2~3~
BarText~f~4!{HLTHONBAR="true",TAGOOR="",HOUTLINE=1,MAXCHARS=10,HMAXCHARS=0,OUTLINE=1,HFONT="Friz Quadrata TT",INCHEALS=2,HLTHTXTANCHOR=1,HLTHTYPE=3,CLASSONBAR="false",FONT="Friz Quadrata TT",NUMFORMAT2=1,IGNOREONFULL="true",NUMFORMAT1=11,OVERHEAL=1,TAGRIP="",HEIGHT=10,OFFSET=0,SHOWROLE="true",HALIGN=2,TAGDC="",NAMEONBAR="true",HHEIGHT=10,INCABSORBS=1,HOFFSET2=0,ALIGN=2,TAGR="",HOFFSET=0}
BarText~d!5~6~
BarText~f~7!{HLTHONBAR="true",TAGOOR="OOR-",HOUTLINE=1,MAXCHARS=10,HMAXCHARS=0,OUTLINE=1,HFONT="Friz Quadrata TT",INCHEALS=2,HLTHTXTANCHOR=1,HLTHTYPE=3,CLASSONBAR="false",FONT="Friz Quadrata TT",NUMFORMAT2=1,IGNOREONFULL="true",NUMFORMAT1=11,OVERHEAL=1,TAGRIP="",HEIGHT=10,OFFSET=0,SHOWROLE="true",HALIGN=2,TAGDC="",NAMEONBAR="true",HHEIGHT=10,INCABSORBS=1,HOFFSET2=0,ALIGN=2,TAGR="",HOFFSET=0}
BarText~f~8!{HLTHONBAR="true",TAGOOR="",HOUTLINE=1,MAXCHARS=10,HMAXCHARS=0,OUTLINE=1,HFONT="Friz Quadrata TT",INCHEALS=2,HLTHTXTANCHOR=1,HLTHTYPE=3,CLASSONBAR="false",FONT="Friz Quadrata TT",NUMFORMAT2=1,IGNOREONFULL="true",NUMFORMAT1=11,OVERHEAL=1,TAGRIP="",HEIGHT=10,OFFSET=0,SHOWROLE="true",HALIGN=2,TAGDC="",NAMEONBAR="true",HHEIGHT=10,INCABSORBS=1,HOFFSET2=0,ALIGN=2,TAGR="",HOFFSET=0}
BarText~d!9~10~
BarTextCol~f~1!{NCB=0,NCR=1,HLTH=2,NCDA=0.7,HCG=1,NDEBUFF="false",NCG=1,HCR=1,NCA=1,HCB=0,HCA=1,HDEBUFF="false",NAME=2,HCDA=0.7}
BarTextCol~d!2~3~4~5~6~7~8~9~10~
Icons~f~1!{RCEN="true",I15EN="true",CLASSEN="false",BUFFANCHOR=2,BUFFFADE="false",DEBUFFANCHOR=1,RCVOFFSET=-2,OORVOFFSET=0,DEBUFFDOUBLE="true",TARGETVOFFSET=1,BUFFONBAR=1,SHOWDIR="false",SHOWRC="true",TARGETANCHOR=5,RCSCALE=0.55,MAXBICONS=4,FADESECS=15,RCHOFFSET=0,TARGETHOFFSET=20,RCANCHOR=3,CLASSVOFFSET=0,FADE="false",DSCALE=0.85,OORHOFFSET=0,BUFFDOUBLE="true",SCALE=0.85,OORONBAR=3,TARGETEN="true",TARGETSCALE=0.45,SHOWCLASS="false",CLASSSCALE=0.5,RCONBAR=3,MAXDICONS=2,OORANCHOR=1,SHOWROLE="false",CLASSANCHOR=1,CLASSHOFFSET=0,DEBUFFONBAR=1,CLASSONBAR=1,BUFFI15EN="true",BUFFFADESECS=15,OORSCALE=0.5,TARGETONBAR=3,OOREN="false",SHOWDIRMOUSE="false"}
Icons~f~2!{RCEN="true",I15EN="true",CLASSEN="false",BUFFANCHOR=2,BUFFFADE="false",DEBUFFANCHOR=1,RCVOFFSET=-2,OORVOFFSET=0,DEBUFFDOUBLE="true",TARGETVOFFSET=1,BUFFONBAR=1,SHOWDIR="false",SHOWRC="true",TARGETANCHOR=5,RCSCALE=0.55,MAXBICONS=8,FADESECS=15,RCHOFFSET=0,TARGETHOFFSET=20,RCANCHOR=3,CLASSVOFFSET=0,FADE="false",DSCALE=0.85,OORHOFFSET=0,BUFFDOUBLE="true",SCALE=0.85,OORONBAR=3,TARGETEN="true",TARGETSCALE=0.45,SHOWCLASS="false",CLASSSCALE=0.5,RCONBAR=3,MAXDICONS=4,OORANCHOR=1,SHOWROLE="false",CLASSANCHOR=1,CLASSHOFFSET=0,DEBUFFONBAR=1,CLASSONBAR=1,BUFFI15EN="true",BUFFFADESECS=15,OORSCALE=0.5,TARGETONBAR=3,OOREN="false",SHOWDIRMOUSE="false"}
Icons~f~3!{RCEN="true",I15EN="true",CLASSEN="false",BUFFANCHOR=2,BUFFFADE="false",DEBUFFANCHOR=1,RCVOFFSET=-2,OORVOFFSET=0,DEBUFFDOUBLE="true",TARGETVOFFSET=1,BUFFONBAR=1,SHOWDIR="false",SHOWRC="true",TARGETANCHOR=5,RCSCALE=0.55,MAXBICONS=8,FADESECS=15,RCHOFFSET=0,TARGETHOFFSET=20,RCANCHOR=3,CLASSVOFFSET=0,FADE="false",DSCALE=0.85,OORHOFFSET=0,BUFFDOUBLE="true",SCALE=0.85,OORONBAR=3,TARGETEN="true",TARGETSCALE=0.45,SHOWCLASS="false",CLASSSCALE=0.5,RCONBAR=3,MAXDICONS=3,OORANCHOR=1,SHOWROLE="false",CLASSANCHOR=1,CLASSHOFFSET=0,DEBUFFONBAR=1,CLASSONBAR=1,BUFFI15EN="true",BUFFFADESECS=15,OORSCALE=0.5,TARGETONBAR=3,OOREN="false",SHOWDIRMOUSE="false"}
Icons~d!4~5~6~
Icons~f~7!{RCEN="true",I15EN="true",CLASSEN="false",BUFFANCHOR=2,BUFFFADE="false",DEBUFFANCHOR=1,RCVOFFSET=-2,OORVOFFSET=0,DEBUFFDOUBLE="true",TARGETVOFFSET=1,BUFFONBAR=1,SHOWDIR="false",SHOWRC="true",TARGETANCHOR=5,RCSCALE=0.55,MAXBICONS=4,FADESECS=15,RCHOFFSET=0,TARGETHOFFSET=20,RCANCHOR=3,CLASSVOFFSET=0,FADE="false",DSCALE=0.85,OORHOFFSET=0,BUFFDOUBLE="true",SCALE=0.85,OORONBAR=3,TARGETEN="true",TARGETSCALE=0.45,SHOWCLASS="false",CLASSSCALE=0.5,RCONBAR=3,MAXDICONS=2,OORANCHOR=1,SHOWROLE="false",CLASSANCHOR=1,CLASSHOFFSET=0,DEBUFFONBAR=1,CLASSONBAR=1,BUFFI15EN="true",BUFFFADESECS=15,OORSCALE=0.5,TARGETONBAR=3,OOREN="false",SHOWDIRMOUSE="false"}
Icons~f~8!{RCEN="true",I15EN="true",CLASSEN="false",BUFFANCHOR=2,BUFFFADE="false",DEBUFFANCHOR=1,RCVOFFSET=-2,OORVOFFSET=0,DEBUFFDOUBLE="true",TARGETVOFFSET=1,BUFFONBAR=1,SHOWDIR="false",SHOWRC="true",TARGETANCHOR=5,RCSCALE=0.55,MAXBICONS=6,FADESECS=15,RCHOFFSET=0,TARGETHOFFSET=20,RCANCHOR=3,CLASSVOFFSET=0,FADE="false",DSCALE=0.85,OORHOFFSET=0,BUFFDOUBLE="true",SCALE=0.85,OORONBAR=3,TARGETEN="true",TARGETSCALE=0.45,SHOWCLASS="false",CLASSSCALE=0.5,RCONBAR=3,MAXDICONS=2,OORANCHOR=1,SHOWROLE="false",CLASSANCHOR=1,CLASSHOFFSET=0,DEBUFFONBAR=1,CLASSONBAR=1,BUFFI15EN="true",BUFFFADESECS=15,OORSCALE=0.5,TARGETONBAR=3,OOREN="false",SHOWDIRMOUSE="false"}
Icons~d!9~
Icons~f~10!{RCEN="true",I15EN="true",CLASSEN="false",BUFFANCHOR=2,BUFFFADE="false",DEBUFFANCHOR=1,RCVOFFSET=-2,OORVOFFSET=0,DEBUFFDOUBLE="true",TARGETVOFFSET=1,BUFFONBAR=1,SHOWDIR="false",SHOWRC="true",TARGETANCHOR=5,RCSCALE=0.55,MAXBICONS=8,FADESECS=15,RCHOFFSET=0,TARGETHOFFSET=20,RCANCHOR=3,CLASSVOFFSET=0,FADE="false",DSCALE=0.85,OORHOFFSET=0,BUFFDOUBLE="true",SCALE=0.85,OORONBAR=3,TARGETEN="true",TARGETSCALE=0.45,SHOWCLASS="false",CLASSSCALE=0.5,RCONBAR=3,MAXDICONS=3,OORANCHOR=1,SHOWROLE="false",CLASSANCHOR=1,CLASSHOFFSET=0,DEBUFFONBAR=1,CLASSONBAR=1,BUFFI15EN="true",BUFFFADESECS=15,OORSCALE=0.5,TARGETONBAR=3,OOREN="false",SHOWDIRMOUSE="false"}
RaidIcon~f~1!{SQUARE="true",CIRCLE="true",DIAMOND="true",SHOW="true",SKULL="true",TRIANGLE="true",STAR="true",CROSS="true",MOON="true"}
RaidIcon~d!2~3~4~5~6~7~8~9~10~
IconText~f~1!{DURWARN=3,BUFFSSDUR="true",BUFFOUTLINE=2,BUFFDURTHRH=9,SCNT="true",DURTHRH=9,FONT="Friz Quadrata TT",BUFFFONT="Friz Quadrata TT",BUFFSCNT="true",SSCNT="false",OUTLINE=2,BUFFDURWARN=3,SDUR="false",BUFFSSCNT="false",HEIGHT=10,BUFFHEIGHT=10,SSDUR="true",BUFFSDUR="false"}
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
BarAggro~f~1!{B=0,SHOWTEXT="false",G=0,TEXTFORMAT=3,SHOW="true",SHOWTEXTPCT="true",ALERTIND=2,SHOWIND="true",R=1,ALERT=2}
BarAggro~d!2~3~4~5~6~7~8~9~10~
AuxBarFrame~f~1!{OVERLAP=1}
AuxBarFrame~d!2~3~4~5~6~7~8~9~10~
AuxBar^1~f~1!{SIZE=1,USE=1,B=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,R=1,OTYPE=1,G=1}
AuxBar^1~d!2~3~4~5~6~7~8~9~10~
AuxBar^2~f~1!{SIZE=1,USE=1,B=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,R=1,OTYPE=1,G=1}
AuxBar^2~d!2~3~4~5~6~7~8~9~10~
AuxBar^3~f~1!{SIZE=1,USE=1,B=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,R=1,OTYPE=1,G=1}
AuxBar^3~d!2~3~4~5~6~7~8~9~10~
AuxBar^4~f~1!{SIZE=1,USE=1,B=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,R=1,OTYPE=1,G=1}
AuxBar^4~d!2~3~4~5~6~7~8~9~10~
AuxBar^5~f~1!{SIZE=1,USE=1,B=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,R=1,OTYPE=1,G=1}
AuxBar^5~d!2~3~4~5~6~7~8~9~10~
AuxBar^6~f~1!{SIZE=1,USE=1,B=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,R=1,OTYPE=1,G=1}
AuxBar^6~d!2~3~4~5~6~7~8~9~10~
AuxBar^7~f~1!{SIZE=1,USE=1,B=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,R=1,OTYPE=1,G=1}
AuxBar^7~d!2~3~4~5~6~7~8~9~10~
AuxBar^8~f~1!{SIZE=1,USE=1,B=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,R=1,OTYPE=1,G=1}
AuxBar^8~d!2~3~4~5~6~7~8~9~10~
AuxBar^9~f~1!{SIZE=0.98,USE=1,B=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,R=1,OTYPE=1,G=1}
AuxBar^9~d!2~3~4~5~6~7~8~9~10~
Complete!]]
HealBot_ExtraSkinData[9]=[[Skin
Aphrahat 2020_10³
Author~v!Aphrahat von Tarren Mill
DuplicateBars~v!false
Chat~t!{EOCOOM="true",EOCOOMV=18,MSG="† #n lasse Dich vom Blute Christi erlösen! †",RESONLY="true",NOTIFY=4}
General~t!{OFREQ=0.07,STICKYSENSITIVITY=15,FLUIDBARS="false",FLUIDFREQ=10,HIDEPARTYF="true",OMAX=1,STICKYFRAME="true",HIDEBOSSF="true",HIDERAIDF="true",OMIN=0.05,HIDEPTF="true"}
Healing~t!{TONLYFRIEND="false",TARGETINCOMBAT=2,FOCUSINCOMBAT=2,GROUPPETS="true",FEXRAID="false",TEXRAID="false",FONLYFRIEND="false",SELFPET="false"}
Enemy~t!{INCARENA="true",INCTANKS="true",INCMYTAR="false",ENEMYTARGET="false",ENEMYTARGETSIZE=40,INCARENAPETS="false",INCSELF="false",NUMBOSS=2,EXISTSHOWPTAR=1,HIDE="true",EXISTSHOWBOSS="true",DOUBLEWIDTH="false",EXISTSHOWARENA=3}
FrameAlias~f~1!{SIZE=7,NAME="",R=0.988,ALIAS="Rahmen 1",G=0.988,SHOW="false",OFFSET=0,FONT="Swansea",A=0,B=0.988,OUTLINE=1}
FrameAlias~f~2!{A=1,NAME="",R=1,ALIAS="Rahmen 2",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",SIZE=7,B=1,OUTLINE=1}
FrameAlias~d!3~4~5~
FrameAlias~f~6!{SIZE=7,NAME="Vehicle",R=1,ALIAS="Vehicle",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~7!{SIZE=7,NAME="Pets",R=1,ALIAS="Pets",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~8!{SIZE=7,NAME="Target",R=1,ALIAS="Target",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~9!{SIZE=7,NAME="Focus",R=1,ALIAS="Focus",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~10!{SIZE=7,NAME="Enemy",R=1,ALIAS="Enemy",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAliasBar~f~1!{A=0,WIDTH=0.85,B=0.988,HEIGHT=20,R=0.988,G=0.988,TEXTURE="HealBot 10"}
FrameAliasBar~f~2!{A=0.4,WIDTH=0.7,B=0.1,HEIGHT=20,R=0.1,G=0.7,TEXTURE="HealBot 10"}
FrameAliasBar~d!3~4~5~6~7~8~9~10~
Frame~f~1!{SFOFFSETH=0,BORDERR=0.988,BACKR=0.988,SFOFFSETV=0,LOCKED="true",OPENSOUND="false",BORDERA=0,BORDERG=0.988,BACKG=0.988,BORDERB=0.988,BACKA=0,SCALE=1,BACKB=0.988,AUTOCLOSE="false",TIPLOC=5}
Frame~d!2~3~4~5~6~7~
Frame~f~8!{SFOFFSETH=0,BORDERR=0.988,BACKR=0.988,SFOFFSETV=-8,LOCKED="true",OPENSOUND="false",BORDERA=0,BORDERG=0.988,BACKG=0.988,BORDERB=0.988,BACKA=0,SCALE=1,BACKB=0.988,AUTOCLOSE="false",TIPLOC=5}
Frame~d!9~
Frame~f~10!{SFOFFSETH=0,BORDERR=0.988,BACKR=0.988,SFOFFSETV=0,LOCKED="true",OPENSOUND="false",BORDERA=0,BORDERG=0.988,BACKG=0.988,BORDERB=0.988,BACKA=0,SCALE=1,BACKB=0.988,AUTOCLOSE="false",TIPLOC=5}
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
HeadBar~f~1!{SHOW="true",WIDTH=0.25,B=0.988,R=0.988,HEIGHT=5,A=0,G=0.988,TEXTURE="Smooth"}
HeadBar~f~2!{SHOW="true",WIDTH=0.95,B=0.2,R=0.2,HEIGHT=15,A=0.4,G=0.4,TEXTURE="HealBot 10"}
HeadBar~d!3~4~5~6~7~8~9~10~
HeadText~f~1!{A=0.21,B=1,OFFSET=0,R=1,FONT="Swansea",HEIGHT=7,G=1,OUTLINE=1}
HeadText~f~2!{A=0.74,B=1,OFFSET=0,R=1,FONT="Friz Quadrata TT",HEIGHT=10,G=1,OUTLINE=1}
HeadText~d!3~4~5~6~7~8~9~10~
HealBar~f~1!{HEIGHT=35,GRPCOLS="false",CMARGIN=1,TEXTURE="Details Flat",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=1,NUMCOLS=2,OFIX=1,RMARGIN=1,WIDTH=175}
HealBar~f~2!{HEIGHT=35,GRPCOLS="false",CMARGIN=1,TEXTURE="Smooth",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=2,NUMCOLS=2,OFIX=1,RMARGIN=1,WIDTH=170}
HealBar~d!3~4~5~6~7~8~9~10~
BarCol~f~1!{BACK=2,BA=0,BB=1,DISA=0,BR=1,HB=1,BG=1,BOUT=0,HA=1,HR=1,ORA=0.4,HG=1,HLTH=2}
BarCol~f~2!{BACK=2,BA=0,BOUT=0,DISA=0,BR=1,HB=1,BG=1,HG=1,HA=1,HR=1,ORA=0.45,BB=1,HLTH=2}
BarCol~d!3~4~5~6~7~8~9~10~
BarIACol~f~1!{AC=4,AB=0.988,AA=0.9,AR=0.988,AG=0.988,IC=2,IB=0.988,IA=0.9,IR=0.988,IG=0.988}
BarIACol~f~2!{AC=4,AB=0.992,AA=0.9,AR=0.992,AG=0.992,IC=2,IB=0.992,IA=0.9,IR=0.992,IG=0.992}
BarIACol~d!3~4~5~6~7~8~9~10~
BarText~f~1!{HLTHONBAR="true",TAGOOR="®   ",IGNOREONFULL="false",MAXCHARS=0,HMAXCHARS=0,HFONT="Swansea Bold",OUTLINE=2,OFFSET=3,HLTHTXTANCHOR=2,HLTHTYPE=1,FONT="Swansea",CLASSONBAR="false",NUMFORMAT2=8,HOUTLINE=1,TAGDC="©   ",OVERHEAL=1,TAGRIP="††   ",HEIGHT=10,INCHEALS=1,SHOWROLE="false",HALIGN=2,NUMFORMAT1=1,NAMEONBAR="true",HHEIGHT=8,INCABSORBS=1,HOFFSET2=-1,ALIGN=1,TAGR="r.   ",HOFFSET=2}
BarText~f~2!{HLTHONBAR="true",TAGOOR="[ OOR ] ",IGNOREONFULL="true",MAXCHARS=0,HMAXCHARS=0,HFONT="Swansea",OUTLINE=1,OFFSET=0,HLTHTXTANCHOR=2,HLTHTYPE=1,FONT="Friz Quadrata TT",CLASSONBAR="false",NUMFORMAT2=1,HOUTLINE=1,TAGDC="[ DC ] ",OVERHEAL=1,TAGRIP="[ RIP ] ",HEIGHT=10,INCHEALS=1,SHOWROLE="true",HALIGN=2,NUMFORMAT1=1,NAMEONBAR="true",HHEIGHT=11,INCABSORBS=1,HOFFSET2=0,ALIGN=2,TAGR="[ R ] ",HOFFSET=0}
BarText~d!3~4~5~6~7~8~9~10~
BarTextCol~f~1!{NAME=2,NDEBUFF="false",HCDA=0.1,NCDA=0.35,HCG=0.988,NCB=1,NCG=1,HCR=0.988,NCA=1,HCB=0.282,HCA=1,HDEBUFF="true",NCR=1,HLTH=2}
BarTextCol~f~2!{NAME=2,NDEBUFF="false",HCDA=0.3,NCDA=0.5,HCG=1,NCB=0,NCG=1,HCR=0.98,NCA=0.95,HCB=0.984,HCA=1,HDEBUFF="false",NCR=1,HLTH=3}
BarTextCol~d!3~4~5~6~7~8~9~10~
Icons~f~1!{RCEN="false",I15EN="true",CLASSEN="false",TARGETEN="false",BUFFFADE="true",DEBUFFANCHOR=1,RCVOFFSET=0,OORVOFFSET=0,DEBUFFDOUBLE="false",TARGETVOFFSET=0,BUFFONBAR=1,SHOWDIR="false",SHOWRC="true",TARGETANCHOR=1,RCSCALE=0.5,MAXBICONS=10,FADE="true",FADESECS=5,RCHOFFSET=0,OORHOFFSET=0,CLASSONBAR=1,CLASSVOFFSET=0,TARGETSCALE=0.5,DSCALE=0.45,BUFFDOUBLE="false",SHOWROLE="false",SCALE=0.5,TARGETONBAR=1,BUFFANCHOR=2,RCANCHOR=1,SHOWCLASS="false",DEBUFFONBAR=1,RCONBAR=1,MAXDICONS=8,OORANCHOR=1,CLASSANCHOR=1,SHOWDIRMOUSE="false",CLASSHOFFSET=0,DOUBLE="false",CLASSSCALE=0.5,BUFFI15EN="true",BUFFFADESECS=5,OORSCALE=0.5,OORONBAR=3,OOREN="false",TARGETHOFFSET=0}
Icons~f~2!{RCEN="false",I15EN="true",CLASSEN="false",TARGETEN="false",BUFFFADE="true",DEBUFFANCHOR=1,RCVOFFSET=0,OORVOFFSET=0,DEBUFFDOUBLE="false",TARGETVOFFSET=0,BUFFONBAR=1,SHOWDIR="false",SHOWRC="true",TARGETANCHOR=1,RCSCALE=0.5,MAXBICONS=8,FADE="true",FADESECS=15,RCHOFFSET=0,OORHOFFSET=0,CLASSONBAR=1,CLASSVOFFSET=0,TARGETSCALE=0.5,DSCALE=0.5,BUFFDOUBLE="false",SHOWROLE="false",SCALE=0.5,TARGETONBAR=1,BUFFANCHOR=2,RCANCHOR=1,SHOWCLASS="false",DEBUFFONBAR=1,RCONBAR=1,MAXDICONS=4,OORANCHOR=1,CLASSANCHOR=1,SHOWDIRMOUSE="false",CLASSHOFFSET=0,DOUBLE="false",CLASSSCALE=0.5,BUFFI15EN="true",BUFFFADESECS=15,OORSCALE=0.5,OORONBAR=3,OOREN="false",TARGETHOFFSET=0}
Icons~d!3~4~5~6~7~8~9~10~
RaidIcon~f~1!{SQUARE="false",CIRCLE="false",DIAMOND="false",SHOW="false",MOON="false",TRIANGLE="false",STAR="false",SKULL="false",CROSS="false"}
RaidIcon~d!2~3~4~5~6~7~8~9~10~
IconText~f~1!{DURWARN=5,BUFFHEIGHT=9,BUFFOUTLINE=2,BUFFDURTHRH=9,SCNT="true",DURTHRH=9,FONT="Swansea Bold",BUFFFONT="Swansea Bold",BUFFSCNT="true",SSCNT="true",OUTLINE=2,BUFFDURWARN=5,HEIGHT=9,SDUR="true",BUFFSSDUR="true",BUFFSSCNT="true",SSDUR="true",BUFFSDUR="true"}
IconText~d!2~3~4~5~6~7~8~9~10~
BarVisibility~f~1!{INCCLASSES=1,ALERTIC=1,ALERTOC=0.99,HIDEOOR="false"}
BarVisibility~f~2!{INCCLASSES=1,ALERTIC=0.98,ALERTOC=0.95,HIDEOOR="false"}
BarVisibility~d!3~4~5~6~7~8~9~10~
BarSort~f~1!{SUBORDER=5,OORLAST="false",RAIDORDER=3,SUBPF="true"}
BarSort~f~2!{SUBORDER=1,OORLAST="false",RAIDORDER=3,SUBPF="true"}
BarSort~d!3~4~5~6~7~8~9~10~
BarAggro~f~1!{B=0.071,SHOWTEXT="true",G=0,TEXTFORMAT=6,SHOW="true",SHOWTEXTPCT="true",ALERTIND=2,R=0.992,SHOWIND="false",ALERT=2}
BarAggro~f~2!{B=0.22,SHOWTEXT="false",G=0.22,TEXTFORMAT=1,SHOW="true",SHOWTEXTPCT="true",R=0.992,SHOWIND="false",ALERTIND=1,ALERT=2}
BarAggro~d!3~4~5~6~7~8~9~10~
AuxBarFrame~f~1!{OVERLAP=2}
AuxBarFrame~d!2~3~4~5~6~7~8~9~10~
AuxBar^1~f~1!{SIZE=0.99,USE=8,R=1,COLOUR=3,ANCHOR=2,OFFSET=0,DEPTH=1,OTYPE=2,B=1,G=1}
AuxBar^1~f~2!{SIZE=0.95,USE=5,R=0.9,COLOUR=3,ANCHOR=1,OFFSET=0,DEPTH=2,OTYPE=2,B=0.2,G=0.2}
AuxBar^1~d!3~4~5~6~7~8~9~
AuxBar^1~f~10!{SIZE=0.95,USE=1,R=0.9,COLOUR=3,ANCHOR=1,OFFSET=0,DEPTH=2,OTYPE=2,B=0.2,G=0.2}
AuxBar^2~f~1!{SIZE=0.99,USE=8,R=1,COLOUR=3,ANCHOR=1,OFFSET=0,DEPTH=1,OTYPE=2,B=1,G=1}
AuxBar^2~f~2!{SIZE=1,USE=8,R=1,COLOUR=3,ANCHOR=2,OFFSET=1,DEPTH=1,OTYPE=2,B=1,G=1}
AuxBar^2~d!3~4~5~6~7~8~9~
AuxBar^2~f~10!{SIZE=1,USE=1,R=1,COLOUR=3,ANCHOR=2,OFFSET=1,DEPTH=1,OTYPE=2,B=1,G=1}
AuxBar^3~f~1!{SIZE=0.99,USE=6,R=0.9,COLOUR=3,ANCHOR=3,OFFSET=-1,DEPTH=3,OTYPE=1,B=0.2,G=0.2}
AuxBar^3~f~2!{SIZE=1,USE=6,R=0.9,COLOUR=3,ANCHOR=3,OFFSET=-1,DEPTH=2,OTYPE=2,B=0.2,G=0.2}
AuxBar^3~d!3~4~5~6~7~8~9~
AuxBar^3~f~10!{SIZE=1,USE=1,R=0.9,COLOUR=3,ANCHOR=3,OFFSET=-1,DEPTH=2,OTYPE=2,B=0.2,G=0.2}
AuxBar^4~f~1!{SIZE=0.99,USE=4,R=1,COLOUR=1,ANCHOR=4,OFFSET=0,DEPTH=1,OTYPE=1,B=1,G=1}
AuxBar^4~f~2!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,OTYPE=1,B=1,G=1}
AuxBar^4~d!3~4~5~6~7~8~9~10~
AuxBar^5~f~1!{SIZE=0.99,USE=5,R=0.9,COLOUR=1,ANCHOR=1,OFFSET=0,DEPTH=2,OTYPE=1,B=0.2,G=0.2}
AuxBar^5~f~2!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=1,OTYPE=1,B=1,G=1}
AuxBar^5~d!3~4~5~6~7~8~9~10~
AuxBar^6~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,OTYPE=1,B=1,G=1}
AuxBar^6~d!2~3~4~5~6~7~8~9~10~
AuxBar^7~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,OTYPE=1,B=1,G=1}
AuxBar^7~d!2~3~4~5~6~7~8~9~10~
AuxBar^8~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,OTYPE=1,B=1,G=1}
AuxBar^8~d!2~3~4~5~6~7~8~9~10~
AuxBar^9~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,OTYPE=1,B=1,G=1}
AuxBar^9~d!2~3~4~5~6~7~8~9~10~
Complete!]]
HealBot_ExtraSkinData[10]=[[Skin
Maddy's Large Raid Skin
Author~v!Madaleine of HealBot Website
DuplicateBars~v!false
Chat~t!{EOCOOM="false",EOCOOMV=20,MSG="Casting #s on #n",RESONLY="true",CHAN="",NOTIFY=1}
General~t!{OFREQ=0.07,OMIN=0.1,OMAX=0.95,FLUIDFREQ=10,HIDEPARTYF="false",HIDEPTF="false",STICKYFRAME="false",STICKYSENSITIVITY=30,HIDERAIDF="false",FLUIDBARS="false",HIDEBOSSF="false"}
Healing~t!{TINCSELF="false",GROUPPETS="true",TARGETINCOMBAT=2,TINCRAID="true",FONLYFRIEND="false",SELFPET=0,TONLYFRIEND="false",TINCGROUP="true",FOCUSINCOMBAT=2,TALWAYSSHOW="false",FEXRAID="false",FALWAYSSHOW="false",TEXRAID="false",TINCPET="false"}
Enemy~t!{INCARENA="true",INCTANKS="true",INCMYTAR="false",INCARENAPETS="false",ENEMYTARGET="false",ENEMYTARGETSIZE=40,INCSELF="false",NUMBOSS=2,EXISTSHOWPTAR=1,HIDE="true",EXISTSHOWBOSS="true",DOUBLEWIDTH="false",EXISTSHOWARENA=3}
FrameAlias~f~1!{SIZE=12,NAME="",R=1,ALIAS="Frame 1",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~d!2~3~4~5~
FrameAlias~f~6!{SIZE=12,NAME="Vehicle",R=1,ALIAS="Vehicle",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~7!{SIZE=12,NAME="Pets",R=1,ALIAS="Pets",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~8!{SIZE=12,NAME="Targets",R=1,ALIAS="Target",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~9!{SIZE=12,NAME="Focus",R=1,ALIAS="Focus",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~10!{SIZE=12,NAME="Enemy",R=1,ALIAS="Enemy",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAliasBar~f~1!{A=0.4,TEXTURE="HealBot 10",B=0.1,HEIGHT=20,R=0.1,G=0.7,WIDTH=0.7}
FrameAliasBar~d!2~3~4~5~6~7~8~9~10~
Frame~f~1!{BACKR=0.1,AUTOCLOSE="false",TIPLOC=5,BORDERB=0.2,LOCKED="true",OPENSOUND="false",BORDERA=0.2,SFOFFSETV=0,BACKG=0.1,BACKB=0.1,BACKA=0.05,SCALE=1,BORDERG=0.2,BORDERR=0.2,SFOFFSETH=0}
Frame~d!2~3~4~5~6~7~8~9~10~
StickyFrames~f~1!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~d!2~3~4~5~6~7~8~9~10~
HealGroups~f~1!{FRAME=1,STATE="false",NAME="Self"}
HealGroups~f~2!{FRAME=1,STATE="true",NAME="Main tanks"}
HealGroups~f~3!{FRAME=1,STATE="true",NAME="Healers"}
HealGroups~f~4!{FRAME=1,STATE="true",NAME="Group"}
HealGroups~f~5!{FRAME=1,STATE="true",NAME="Raid"}
HealGroups~f~6!{FRAME=1,STATE="false",NAME="Private List"}
HealGroups~f~7!{FRAME=6,STATE="false",NAME="Vehicle"}
HealGroups~f~8!{FRAME=7,STATE="false",NAME="Pets"}
HealGroups~f~9!{FRAME=8,STATE="false",NAME="Target"}
HealGroups~f~10!{FRAME=9,STATE="false",NAME="Focus"}
HealGroups~f~11!{FRAME=10,STATE="false",NAME="Enemy"}
Anchors~f~1!{Y=68.25,GROW=2,BARS=3,FRAME=3,X=37.37}
Anchors~f~2!{Y=51,GROW=2,BARS=3,FRAME=3,X=51}
Anchors~f~3!{Y=66.58,GROW=2,BARS=3,FRAME=3,X=37.37}
Anchors~f~4!{Y=53,GROW=2,BARS=3,FRAME=3,X=53}
Anchors~f~5!{Y=54,GROW=2,BARS=3,FRAME=3,X=54}
Anchors~f~6!{Y=55,GROW=2,BARS=3,FRAME=3,X=55}
Anchors~f~7!{Y=59.86,GROW=2,BARS=3,FRAME=3,X=97.58}
Anchors~f~8!{Y=68.11,GROW=2,BARS=3,FRAME=3,X=86.24}
Anchors~f~9!{Y=58,GROW=2,BARS=3,FRAME=3,X=58}
Anchors~f~10!{Y=71.7,GROW=2,BARS=3,FRAME=3,X=91.68}
HeadBar~f~1!{SHOW="true",TEXTURE="HealBot 10",R=0.1,B=0.1,HEIGHT=18,A=0.4,G=0.7,WIDTH=0.7}
HeadBar~f~2!{SHOW="true",TEXTURE="HealBot 10",R=0.1,B=0.1,HEIGHT=13,A=0.4,G=0.7,WIDTH=0.7}
HeadBar~d!3~4~5~6~7~8~9~10~
HeadText~f~1!{A=0.74,R=1,OFFSET=0,B=1,FONT="Friz Quadrata TT",HEIGHT=9,G=1,OUTLINE=1}
HeadText~d!2~3~4~5~6~7~8~9~10~
HealBar~f~1!{HEIGHT=35,GRPCOLS="false",CMARGIN=2,TEXTURE="Smooth",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=150,RMARGIN=1,OFIX=1,NUMCOLS=2,LOWMANA=2}
HealBar~f~2!{HEIGHT=25,GRPCOLS="false",CMARGIN=2,TEXTURE="Smooth",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=144,RMARGIN=1,OFIX=1,NUMCOLS=2,LOWMANA=2}
HealBar~d!3~4~5~6~7~8~9~10~
BarCol~f~1!{BACK=3,BA=0.75,BOUT=0,DISA=0.1,BR=0,HB=0.7,BB=0,HR=0.4,HA=1,HG=0.4,ORA=0.4,BG=0,HLTH=2}
BarCol~f~2!{BACK=1,BA=0,BOUT=2,DISA=0.1,BR=0.4,HB=0.7,BB=0.7,HR=0.4,HA=1,HG=0.4,ORA=0.4,BG=0.4,HLTH=1}
BarCol~d!3~4~5~6~7~8~9~10~
BarIACol~f~1!{AC=3,AB=1,AA=0.78,AR=1,AG=1,IC=1,IB=0.2,IA=0.82,IR=0.2,IG=1}
BarIACol~f~2!{AC=3,AB=1,AA=0.78,AR=1,AG=1,IC=3,IB=0.2,IA=0.82,IR=0.2,IG=1}
BarIACol~d!3~4~5~6~7~8~9~10~
BarText~f~1!{HLTHONBAR="true",TAGOOR="[ OOR ] ",IGNOREONFULL="true",MAXCHARS=0,HFONT="Friz Quadrata TT",HMAXCHARS=0,OUTLINE=1,CLASSONBAR="true",FONT="Friz Quadrata TT",OFFSET=0,HLTHTXTANCHOR=1,HLTHTYPE=3,CLASSTYPE=1,TAGDC="[ DC ] ",NUMFORMAT2=1,OVERHEAL=1,NUMFORMAT1=11,TAGRIP="[ RIP ] ",NAMEONBAR="true",HEIGHT=13,INCHEALS=1,SHOWROLE="true",HALIGN=2,HHEIGHT=10,HOUTLINE=1,INCABSORBS=1,HOFFSET2=0,ALIGN=1,TAGR="[ R ] ",HOFFSET=0}
BarText~f~2!{HLTHONBAR="true",TAGOOR="[ OOR ] ",IGNOREONFULL="true",MAXCHARS=0,HFONT="Friz Quadrata TT",HMAXCHARS=0,OUTLINE=1,CLASSONBAR="false",FONT="Friz Quadrata TT",OFFSET=0,HLTHTXTANCHOR=1,HLTHTYPE=1,CLASSTYPE=1,TAGDC="[ DC ] ",NUMFORMAT2=1,OVERHEAL=1,NUMFORMAT1=11,TAGRIP="[ RIP ] ",NAMEONBAR="true",HEIGHT=10,INCHEALS=2,SHOWROLE="true",HALIGN=2,HHEIGHT=10,HOUTLINE=1,INCABSORBS=1,HOFFSET2=0,ALIGN=2,TAGR="[ R ] ",HOFFSET=0}
BarText~f~3!{HLTHONBAR="true",TAGOOR="[ OOR ] ",IGNOREONFULL="true",MAXCHARS=0,HFONT="Friz Quadrata TT",HMAXCHARS=0,OUTLINE=1,CLASSONBAR="false",OVERHEAL=1,INCHEALS=2,HLTHTXTANCHOR=1,FONT="Friz Quadrata TT",HOUTLINE=1,CLASSTYPE=1,NUMFORMAT2=1,HLTHTYPE=1,NUMFORMAT1=11,NAMEONBAR="true",TAGRIP="[ RIP ] ",HEIGHT=10,OFFSET=0,SHOWROLE="true",HALIGN=2,TAGDC="[ DC ] ",HHEIGHT=10,INCABSORBS=1,HOFFSET2=0,ALIGN=2,TAGR="[ R ] ",HOFFSET=0}
BarText~d!4~5~6~7~8~9~10~
BarTextCol~f~1!{NCB=1,HCA=1,NAME=3,NCDA=0.8,HCG=0.969,NCR=0.957,HCB=1,HCR=0.957,NDEBUFF="false",NCG=0.969,NCA=1,HDEBUFF="false",HLTH=3,HCDA=0.8}
BarTextCol~f~2!{NCB=0,HCA=1,NAME=2,NCDA=0.8,HCG=1,NCR=1,HCB=0,HCR=1,NDEBUFF="false",NCG=1,NCA=1,HDEBUFF="false",HLTH=2,HCDA=0.8}
BarTextCol~d!3~4~5~6~7~8~9~10~
Icons~f~1!{SHOWBUFF="true",SHOWDEBUFF="true",MAXDICONS=3,FADESECS=15,SHOWDIRMOUSE="false",I15EN="true",ONBAR=1,DOUBLE="true",DSCALE=1,SHOWDIR="true",SHOWRC="true",SCALE=1,FADE="true",POSITION=2,MAXBICONS=8}
Icons~f~2!{SHOWBUFF="true",SHOWDEBUFF="true",MAXDICONS=3,FADESECS=15,SHOWDIRMOUSE="false",I15EN="true",ONBAR=1,DOUBLE="false",DSCALE=0.7,SHOWDIR="true",SHOWRC="true",SCALE=0.7,FADE="true",POSITION=2,MAXBICONS=8}
Icons~d!3~4~5~6~7~8~9~10~
RaidIcon~f~1!{SQUARE="true",CIRCLE="true",DIAMOND="true",SHOW="true",MOON="true",TRIANGLE="true",STAR="true",CROSS="true",SKULL="true"}
RaidIcon~d!2~3~4~5~6~7~8~9~10~
IconText~f~1!{SDUR="true",HEIGHT=12,SSCNT="false",SCNT="true",DURTHRH=9,FONT="Friz Quadrata TT",DURWARN=3,SSDUR="true",OUTLINE=2}
IconText~f~2!{SDUR="true",HEIGHT=9,SSCNT="false",SCNT="true",DURTHRH=9,FONT="Friz Quadrata TT",DURWARN=3,SSDUR="true",OUTLINE=2}
IconText~d!3~4~5~6~7~8~9~10~
BarVisibility~f~1!{INCCLASSES=1,ALERTIC=1,ALERTOC=1,HIDEOOR="false"}
BarVisibility~f~2!{INCCLASSES=1,ALERTIC=0.98,ALERTOC=0.95,HIDEOOR="false"}
BarVisibility~d!3~4~5~6~7~8~9~10~
BarSort~f~1!{SUBORDER=1,OORLAST="false",RAIDORDER=3,SUBPF="true"}
BarSort~d!2~3~4~5~6~7~8~9~10~
BarAggro~f~1!{R=1,ALERTIND=2,G=0,TEXTFORMAT=3,SHOW="true",SHOWTEXTPCT="true",SHOWTEXT="false",B=0,SHOWIND="true",ALERT=3}
BarAggro~d!2~3~4~5~6~7~8~9~10~
AuxBarFrame~f~1!{OVERLAP=1}
AuxBarFrame~d!2~3~4~5~6~7~8~9~10~
AuxBar^1~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,A=1,OTYPE=1}
AuxBar^1~d!2~3~4~5~6~7~8~9~10~
AuxBar^2~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,A=1,OTYPE=1}
AuxBar^2~d!2~3~4~5~6~7~8~9~10~
AuxBar^3~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,A=1,OTYPE=1}
AuxBar^3~d!2~3~4~5~6~7~8~9~10~
AuxBar^4~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,A=1,OTYPE=1}
AuxBar^4~d!2~3~4~5~6~7~8~9~10~
AuxBar^5~f~1!{SIZE=0.98,USE=5,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=2,G=1,B=1,A=1,OTYPE=1}
AuxBar^5~d!2~3~4~5~6~7~8~9~10~
AuxBar^6~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,A=1,OTYPE=1}
AuxBar^6~d!2~3~4~5~6~7~8~9~10~
AuxBar^7~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,A=1,OTYPE=1}
AuxBar^7~d!2~3~4~5~6~7~8~9~10~
AuxBar^8~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,A=1,OTYPE=1}
AuxBar^8~d!2~3~4~5~6~7~8~9~10~
AuxBar^9~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,A=1,OTYPE=1}
AuxBar^9~d!2~3~4~5~6~7~8~9~10~
Complete!]]
HealBot_ExtraSkinData[11]=[[Skin
Maddy Disc
Author~v!Madaleine of Runetotem
DuplicateBars~v!false
Chat~t!{EOCOOM="false",EOCOOMV=20,MSG="Casting #s on #n",RESONLY="true",CHAN="",NOTIFY=0}
General~t!{OFREQ=0.07,OMIN=0.1,OMAX=0.95,FLUIDFREQ=10,HIDEPARTYF="false",HIDEPTF="false",STICKYSENSITIVITY=30,HIDERAIDF="false",STICKYFRAME="false",FLUIDBARS="false",HIDEBOSSF="false"}
Healing~t!{TINCRAID=1,GROUPPETS="true",TARGETINCOMBAT=2,FALWAYSSHOW="false",FONLYFRIEND="false",SELFPET=0,TONLYFRIEND="false",TINCGROUP=1,FOCUSINCOMBAT=2,TALWAYSSHOW="false",TINCPET=1,TINCSELF="false",TEXRAID="false",FEXRAID="false"}
Enemy~t!{ENEMYTARGET="false",INCTANKS="true",INCMYTAR="false",INCARENA="true",ENEMYTARGETSIZE=40,INCARENAPETS="false",HIDE="true",NUMBOSS=2,EXISTSHOWPTAR=1,INCSELF="false",EXISTSHOWBOSS="true",DOUBLEWIDTH="false",EXISTSHOWARENA=3}
FrameAlias~f~1!{SIZE=12,NAME="",R=1,ALIAS="Frame 1",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~d!2~3~4~5~
FrameAlias~f~6!{SIZE=12,NAME="",R=1,ALIAS="Vehicle",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~7!{SIZE=12,NAME="",R=1,ALIAS="Pets",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~8!{SIZE=12,NAME="",R=1,ALIAS="Target",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~9!{SIZE=12,NAME="",R=1,ALIAS="Focus",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~10!{SIZE=12,NAME="",R=1,ALIAS="Enemy",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAliasBar~f~1!{A=0.5,TEXTURE="HealBot 10",B=0.25,HEIGHT=20,R=0.1,G=0.25,WIDTH=0.7}
FrameAliasBar~d!2~3~4~5~6~7~8~9~10~
Frame~f~1!{BORDERR=0.2,BACKR=0.2,TIPLOC=5,BORDERB=0.2,LOCKED="false",OPENSOUND="false",BORDERA=0.2,BORDERG=0.2,BACKG=0.2,BACKB=0.7,BACKA=0.1,SCALE=1,AUTOCLOSE="false",SFOFFSETV=0,SFOFFSETH=0}
Frame~d!2~3~4~5~6~7~8~9~10~
StickyFrames~f~1!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~d!2~3~4~5~6~7~8~9~10~
HealGroups~f~1!{FRAME=1,STATE="false",NAME="Self"}
HealGroups~f~2!{FRAME=1,STATE="false",NAME="Main tanks"}
HealGroups~f~3!{FRAME=1,STATE="false",NAME="Healers"}
HealGroups~f~4!{FRAME=1,STATE="true",NAME="Group"}
HealGroups~f~5!{FRAME=1,STATE="false",NAME="Private List"}
HealGroups~f~6!{FRAME=1,STATE="true",NAME="Raid"}
HealGroups~f~7!{FRAME=4,STATE="false",NAME="Vehicle"}
HealGroups~f~8!{FRAME=4,STATE="false",NAME="Pets"}
HealGroups~f~9!{FRAME=8,STATE="false",NAME="Target"}
HealGroups~f~10!{FRAME=9,STATE="false",NAME="Focus"}
HealGroups~f~11!{FRAME=10,STATE="false",NAME="Enemy"}
Anchors~f~1!{Y=79.55,GROW=2,BARS=3,FRAME=3,X=26.95}
Anchors~f~2!{Y=51,GROW=2,BARS=3,FRAME=3,X=51}
Anchors~f~3!{Y=52,GROW=2,BARS=3,FRAME=3,X=52}
Anchors~f~4!{Y=53,GROW=2,BARS=3,FRAME=3,X=53}
Anchors~f~5!{Y=54,GROW=2,BARS=3,FRAME=3,X=54}
Anchors~f~6!{Y=55,GROW=2,BARS=3,FRAME=3,X=55}
Anchors~f~7!{Y=56,GROW=2,BARS=3,FRAME=3,X=56}
Anchors~f~8!{Y=84.13,GROW=2,BARS=3,FRAME=3,X=27.96}
Anchors~f~9!{Y=84.13,GROW=2,BARS=3,FRAME=3,X=26.95}
Anchors~f~10!{Y=59,GROW=2,BARS=3,FRAME=3,X=59}
HeadBar~f~1!{SHOW="false",WIDTH=0.7,B=0.10196078431373,R=0.10196078431373,HEIGHT=15,A=0.40000003576279,G=0.70196078431373,TEXTURE="HealBot 10"}
HeadBar~f~2!{SHOW="false",WIDTH=0.69999998807907,B=0.10196078431373,R=0.10196078431373,HEIGHT=15,A=0.40000003576279,G=0.70196078431373,TEXTURE="HealBot 10"}
HeadBar~d!3~4~5~6~7~8~9~10~
HeadText~f~1!{A=0.74,R=1,OFFSET=0,B=1,HEIGHT=9,FONT="Friz Quadrata TT",G=1,OUTLINE=1}
HeadText~d!2~3~4~5~6~7~8~9~10~
HealBar~f~1!{HEIGHT=30,GRPCOLS="false",CMARGIN=2,TEXTURE="HealBot 03",POWERCNT="true",LOWMANACOMBAT="true",RMARGIN=1,NUMCOLS=1,OFIX=1,WIDTH=115,LOWMANA=2}
HealBar~f~2!{HEIGHT=30,GRPCOLS="false",CMARGIN=2,TEXTURE="HealBot 03",POWERCNT="true",LOWMANACOMBAT="true",RMARGIN=1,NUMCOLS=3,OFIX=1,WIDTH=115,LOWMANA=2}
HealBar~d!3~4~5~6~7~8~9~10~
BarCol~f~1!{BACK=1,BA=0,BOUT=2,DISA=0.22,BG=0.4,HB=1,BB=0.702,HG=0.4,HA=1,HR=0.4,ORA=0.52,BR=0.4,HLTH=2}
BarCol~f~2!{BACK=1,BA=0,BOUT=2,DISA=0.21999999880791,BG=0.4,HB=1,BB=0.7,HG=0.4,HA=1,HR=0.4,ORA=0.51999998092651,BR=0.4,HLTH=2}
BarCol~d!3~4~5~6~7~8~9~10~
BarIACol~f~1!{AC=2,AB=0.902,AA=0.9,AR=0,AG=0.102,IC=1,IB=0.2,IA=0.82,IR=0.2,IG=1}
BarIACol~f~2!{AC=2,AB=0.9,AA=0.94999998807907,AR=0,AG=0.1,IC=1,IB=0.2,IA=0.81999999284744,IR=0.2,IG=1}
BarIACol~d!3~4~5~6~7~8~9~10~
BarText~f~1!{HHEIGHT=10,TAGOOR="[ OOR ] ",IGNOREONFULL="true",MAXCHARS=0,NAMEONBAR="true",CLASSONBAR="false",OUTLINE=1,OVERHEAL=1,OFFSET=0,INCHEALS=1,HLTHTXTANCHOR=1,HLTHTYPE=1,HFONT="Friz Quadrata TT",CLASSTYPE=1,NUMFORMAT2=1,HOUTLINE=1,TAGDC="[ DC ] ",HLTHONBAR="true",TAGRIP="[ RIP ] ",HEIGHT=11,HMAXCHARS=0,SHOWROLE="true",HALIGN=2,NUMFORMAT1=1,FONT="MoK",INCABSORBS=1,HOFFSET2=0,ALIGN=2,TAGR="[ R ] ",HOFFSET=0}
BarText~d!2~3~4~5~6~7~8~9~10~
BarTextCol~f~1!{NCB=0,NDEBUFF="false",NAME=2,NCDA=0.4,HCG=1,NCR=1,HCB=0,HCR=1,HCA=1,NCG=1,NCA=1,HDEBUFF="false",HLTH=2,HCDA=0.4}
BarTextCol~d!2~3~4~5~6~7~8~9~10~
Icons~f~1!{SHOWBUFF="true",SHOWDEBUFF="true",MAXDICONS=3,FADESECS=15,I15EN="true",POSITION=2,SHOWDIR="true",FADE="false",DSCALE=0.7,ONBAR=1,SHOWRC="true",SCALE=0.7,SHOWDIRMOUSE="false",DOUBLE="false",MAXBICONS=8}
Icons~d!2~3~4~5~6~7~8~9~10~
RaidIcon~f~1!{SQUARE="true",CIRCLE="true",DIAMOND="true",SHOW="true",MOON="true",TRIANGLE="true",STAR="true",SKULL="true",CROSS="true"}
RaidIcon~d!2~3~4~5~6~7~8~9~10~
IconText~f~1!{SDUR="true",HEIGHT=11,SSCNT="false",SCNT="true",DURTHRH=9,FONT="Friz Quadrata TT",DURWARN=3,SSDUR="true",OUTLINE=2}
IconText~d!2~3~4~5~6~7~8~9~10~
BarVisibility~f~1!{INCCLASSES=1,ALERTIC=1,ALERTOC=1,HIDEOOR="false"}
BarVisibility~d!2~3~4~5~6~7~8~9~10~
BarSort~f~1!{SUBORDER=1,OORLAST="false",RAIDORDER=3,SUBPF="true"}
BarSort~d!2~3~4~5~6~7~8~9~10~
BarAggro~f~1!{R=1,SHOWIND="true",G=0,TEXTFORMAT=3,SHOW="true",SHOWTEXTPCT="true",ALERTIND=2,B=0,SHOWTEXT="true",ALERT=2}
BarAggro~d!2~3~4~5~6~7~8~9~10~
AuxBarFrame~f~1!{OVERLAP=1}
AuxBarFrame~d!2~3~4~5~6~7~8~9~10~
AuxBar^1~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,A=1,OTYPE=1}
AuxBar^1~d!2~3~4~5~6~7~8~9~10~
AuxBar^2~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,A=1,OTYPE=1}
AuxBar^2~d!2~3~4~5~6~7~8~9~10~
AuxBar^3~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,A=1,OTYPE=1}
AuxBar^3~d!2~3~4~5~6~7~8~9~10~
AuxBar^4~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,A=1,OTYPE=1}
AuxBar^4~d!2~3~4~5~6~7~8~9~10~
AuxBar^5~f~1!{SIZE=0.98,USE=5,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=2,G=1,B=1,A=1,OTYPE=1}
AuxBar^5~d!2~3~4~5~6~7~8~9~10~
AuxBar^6~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,A=1,OTYPE=1}
AuxBar^6~d!2~3~4~5~6~7~8~9~10~
AuxBar^7~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,A=1,OTYPE=1}
AuxBar^7~d!2~3~4~5~6~7~8~9~10~
AuxBar^8~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,A=1,OTYPE=1}
AuxBar^8~d!2~3~4~5~6~7~8~9~10~
AuxBar^9~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,A=1,OTYPE=1}
AuxBar^9~d!2~3~4~5~6~7~8~9~10~
Complete!]]
HealBot_ExtraSkinData[12]=[[Skin
Maddy's Classic Skin
Author~v!Madaleine of HealBot Website
DuplicateBars~v!false
Chat~t!{EOCOOM="false",EOCOOMV=20,MSG="Casting #s on #n",RESONLY="true",CHAN="",NOTIFY=1}
General~t!{OFREQ=0.07,OMIN=0.1,OMAX=0.95,HIDEBOSSF="false",HIDEPTF="false",HIDEPARTYF="false",STICKYFRAME="false",STICKYSENSITIVITY=20,HIDERAIDF="true",FLUIDBARS="false",FLUIDFREQ=10}
Healing~t!{TONLYFRIEND="false",SELFPET="false",FOCUSINCOMBAT=2,GROUPPETS="true",TARGETINCOMBAT=2,FONLYFRIEND="false",TEXRAID="false",FEXRAID="false"}
Enemy~t!{INCARENA="true",INCTANKS="true",INCMYTAR="false",ENEMYTARGET="false",ENEMYTARGETSIZE=40,INCARENAPETS="false",INCSELF="false",NUMBOSS=2,EXISTSHOWPTAR=1,HIDE="true",EXISTSHOWBOSS="true",DOUBLEWIDTH="false",EXISTSHOWARENA=3}
FrameAlias~f~1!{SIZE=12,NAME="",R=1,ALIAS="Frame 1",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~d!2~3~4~5~
FrameAlias~f~6!{SIZE=12,NAME="Vehicle",R=1,ALIAS="Vehicle",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~7!{SIZE=12,NAME="Pets",R=1,ALIAS="Pets",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~8!{SIZE=12,NAME="Target",R=1,ALIAS="Target",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~9!{SIZE=12,NAME="Focus",R=1,ALIAS="Focus",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~10!{SIZE=12,NAME="Enemy",R=1,ALIAS="Enemy",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAliasBar~f~1!{A=0.4,TEXTURE="HealBot 10",B=0.1,HEIGHT=20,R=0.1,G=0.7,WIDTH=0.7}
FrameAliasBar~d!2~3~4~5~6~7~8~9~10~
Frame~f~1!{SFOFFSETH=0,TIPLOC=5,AUTOCLOSE="false",BACKB=0.1,LOCKED="false",SCALE=1,BORDERA=0.2,SFOFFSETV=0,BACKG=0.1,BORDERB=0.2,BACKA=0.05,OPENSOUND="false",BORDERG=0.2,BACKR=0.1,BORDERR=0.2}
Frame~d!2~3~4~5~6~7~
Frame~f~8!{SFOFFSETH=0,TIPLOC=4,AUTOCLOSE="false",BACKB=0.1,LOCKED="false",SCALE=1,BORDERA=0.2,SFOFFSETV=-8,BACKG=0.1,BORDERB=0.2,BACKA=0.05,OPENSOUND="false",BORDERG=0.2,BACKR=0.1,BORDERR=0.2}
Frame~d!9~
Frame~f~10!{SFOFFSETH=0,TIPLOC=5,AUTOCLOSE="false",BACKB=0.1,LOCKED="false",SCALE=1,BORDERA=0.2,SFOFFSETV=0,BACKG=0.1,BORDERB=0.2,BACKA=0.05,OPENSOUND="false",BORDERG=0.2,BACKR=0.1,BORDERR=0.2}
StickyFrames~f~1!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~d!2~3~4~5~6~7~
StickyFrames~f~8!{STUCK="false",STUCKTOPOINT="TOPLEFT",STUCKTO=1,STUCKPOINT="BOTTOMLEFT"}
StickyFrames~f~9!{STUCK="false",STUCKTOPOINT="TOPRIGHT",STUCKTO=1,STUCKPOINT="BOTTOMRIGHT"}
StickyFrames~f~10!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
HealGroups~f~1!{FRAME=1,STATE="false",NAME="Self"}
HealGroups~f~2!{FRAME=1,STATE="false",NAME="Main tanks"}
HealGroups~f~3!{FRAME=1,STATE="false",NAME="Healers"}
HealGroups~f~4!{FRAME=1,STATE="true",NAME="Group"}
HealGroups~f~5!{FRAME=1,STATE="true",NAME="Raid"}
HealGroups~f~6!{FRAME=1,STATE="false",NAME="Private List"}
HealGroups~f~7!{FRAME=6,STATE="false",NAME="Vehicle"}
HealGroups~f~8!{FRAME=7,STATE="false",NAME="Pets"}
HealGroups~f~9!{FRAME=8,STATE="false",NAME="Target"}
HealGroups~f~10!{FRAME=9,STATE="true",NAME="Focus"}
HealGroups~f~11!{FRAME=10,STATE="false",NAME="Enemy"}
Anchors~f~1!{Y=74.39,GROW=2,BARS=3,FRAME=3,X=32.92}
Anchors~f~2!{Y=51,GROW=2,BARS=3,FRAME=3,X=51}
Anchors~f~3!{Y=52,GROW=2,BARS=3,FRAME=3,X=52}
Anchors~f~4!{Y=53,GROW=2,BARS=3,FRAME=3,X=53}
Anchors~f~5!{Y=54,GROW=2,BARS=3,FRAME=3,X=54}
Anchors~f~6!{Y=55,GROW=2,BARS=3,FRAME=3,X=55}
Anchors~f~7!{Y=56,GROW=2,BARS=3,FRAME=3,X=56}
Anchors~f~8!{Y=44.02,GROW=2,BARS=3,FRAME=3,X=44.6}
Anchors~f~9!{Y=78.97,GROW=2,BARS=3,FRAME=3,X=32.92}
Anchors~f~10!{Y=59,GROW=2,BARS=3,FRAME=3,X=59}
HeadBar~f~1!{SHOW="false",TEXTURE="HealBot 10",R=0.2,B=0.9,HEIGHT=15,A=1,G=0.2,WIDTH=0.95}
HeadBar~f~2!{SHOW="true",TEXTURE="HealBot 10",R=0.2,B=0.2,HEIGHT=15,A=0.4,G=0.4,WIDTH=0.95}
HeadBar~d!3~4~5~6~7~8~9~10~
HeadText~f~1!{A=0.74,R=1,OFFSET=0,B=1,FONT="Friz Quadrata TT",HEIGHT=10,G=1,OUTLINE=1}
HeadText~d!2~3~4~5~6~7~8~9~10~
HealBar~f~1!{HEIGHT=36,GRPCOLS="false",CMARGIN=2,TEXTURE="HealBot 03",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=124,RMARGIN=1,OFIX=1,NUMCOLS=1,LOWMANA=2}
HealBar~d!2~3~4~5~6~7~8~9~10~
BarCol~f~1!{BACK=2,BA=0.2,BB=0.7,DISA=0.96,BR=0.4,HB=0.7,BG=0.4,HG=0.4,HA=1,HR=0.4,ORA=0.4,BOUT=2,HLTH=2}
BarCol~d!2~3~4~5~6~7~8~9~10~
BarIACol~f~1!{AC=2,AB=1,AA=0.78,AR=1,AG=1,IC=1,IB=0.2,IA=0.82,IR=0.2,IG=1}
BarIACol~d!2~3~4~5~6~7~8~9~10~
BarText~f~1!{HLTHONBAR="true",TAGOOR="[ OOR ] ",OVERHEAL=1,MAXCHARS=0,HHEIGHT=10,HMAXCHARS=0,HFONT="Friz Quadrata TT",HOUTLINE=1,HLTHTYPE=1,INCHEALS=1,HLTHTXTANCHOR=1,FONT="Friz Quadrata TT",CLASSONBAR="false",CLASSTYPE=1,NUMFORMAT2=1,IGNOREONFULL="true",NUMFORMAT1=11,TAGDC="[ DC ] ",NAMEONBAR="true",HEIGHT=10,OUTLINE=1,SHOWROLE="true",HALIGN=2,TAGRIP="[ RIP ] ",OFFSET=0,INCABSORBS=1,HOFFSET2=0,ALIGN=2,TAGR="[ R ] ",HOFFSET=0}
BarText~f~2!{HLTHONBAR="true",TAGOOR="[ OOR ] ",OVERHEAL=1,MAXCHARS=0,HHEIGHT=10,HMAXCHARS=0,HFONT="Friz Quadrata TT",HOUTLINE=1,HLTHTYPE=1,INCHEALS=2,HLTHTXTANCHOR=1,FONT="Friz Quadrata TT",CLASSONBAR="false",CLASSTYPE=1,NUMFORMAT2=1,IGNOREONFULL="true",NUMFORMAT1=11,TAGDC="[ DC ] ",NAMEONBAR="true",HEIGHT=10,OUTLINE=1,SHOWROLE="true",HALIGN=2,TAGRIP="[ RIP ] ",OFFSET=0,INCABSORBS=1,HOFFSET2=0,ALIGN=2,TAGR="[ R ] ",HOFFSET=0}
BarText~d!3~4~5~6~7~8~9~10~
BarTextCol~f~1!{NCB=0,HCA=1,HCG=1,NCDA=0.8,NAME=2,NDEBUFF="false",HCB=0,HCR=1,NCR=1,NCG=1,NCA=1,HDEBUFF="false",HLTH=2,HCDA=0.8}
BarTextCol~d!2~3~4~5~6~7~8~9~10~
Icons~f~1!{SHOWBUFF="true",POSITION=2,FADESECS=15,MAXDICONS=4,I15EN="true",FADE="true",ONBAR=1,SHOWDIRMOUSE="false",DSCALE=1,SHOWDIR="true",SHOWRC="true",SCALE=1,DOUBLE="true",SHOWDEBUFF="true",MAXBICONS=10}
Icons~f~2!{SHOWBUFF="true",POSITION=2,FADESECS=15,MAXDICONS=4,I15EN="true",FADE="true",ONBAR=1,SHOWDIRMOUSE="false",DSCALE=1,SHOWDIR="true",SHOWRC="true",SCALE=1,DOUBLE="true",SHOWDEBUFF="true",MAXBICONS=8}
Icons~d!3~4~5~6~7~8~9~10~
RaidIcon~f~1!{SQUARE="true",CIRCLE="true",DIAMOND="true",SHOW="true",SKULL="true",TRIANGLE="true",STAR="true",CROSS="true",MOON="true"}
RaidIcon~d!2~3~4~5~6~7~8~9~10~
IconText~f~1!{SDUR="false",HEIGHT=12,SSCNT="false",SCNT="true",DURTHRH=9,FONT="Friz Quadrata TT",DURWARN=3,SSDUR="true",OUTLINE=2}
IconText~d!2~3~4~5~6~7~8~9~10~
BarVisibility~f~1!{INCCLASSES=1,ALERTIC=0.98,ALERTOC=0.95,HIDEOOR="false"}
BarVisibility~d!2~3~4~5~6~7~8~9~10~
BarSort~f~1!{SUBORDER=5,OORLAST="false",RAIDORDER=3,SUBPF="true"}
BarSort~d!2~3~4~5~6~7~8~9~10~
BarAggro~f~1!{R=1,SHOWTEXT="false",G=0,TEXTFORMAT=3,SHOW="true",SHOWTEXTPCT="true",B=0,ALERTIND=2,SHOWIND="true",ALERT=3}
BarAggro~d!2~3~4~5~6~7~8~9~10~
AuxBarFrame~f~1!{OVERLAP=1}
AuxBarFrame~d!2~3~4~5~6~7~8~9~10~
AuxBar^1~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,A=1,OTYPE=1}
AuxBar^1~d!2~3~4~5~6~7~8~9~10~
AuxBar^2~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,A=1,OTYPE=1}
AuxBar^2~d!2~3~4~5~6~7~8~9~10~
AuxBar^3~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,A=1,OTYPE=1}
AuxBar^3~d!2~3~4~5~6~7~8~9~10~
AuxBar^4~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,A=1,OTYPE=1}
AuxBar^4~d!2~3~4~5~6~7~8~9~10~
AuxBar^5~f~1!{SIZE=0.98,USE=5,R=1,COLOUR=1,ANCHOR=1,OFFSET=0,DEPTH=1,G=1,B=1,A=1,OTYPE=1}
AuxBar^5~d!2~3~4~5~6~7~8~9~
AuxBar^5~f~10!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=0,DEPTH=1,OTYPE=1,A=1,B=1,G=1}
AuxBar^6~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,A=1,OTYPE=1}
AuxBar^6~d!2~3~4~5~6~7~8~9~10~
AuxBar^7~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,A=1,OTYPE=1}
AuxBar^7~d!2~3~4~5~6~7~8~9~10~
AuxBar^8~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,A=1,OTYPE=1}
AuxBar^8~d!2~3~4~5~6~7~8~9~10~
AuxBar^9~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,A=1,OTYPE=1}
AuxBar^9~d!2~3~4~5~6~7~8~9~10~
Complete!]]
HealBot_ExtraSkinData[13]=[[Skin
Vivid
Author~v!Monti of Terenasa
DuplicateBars~v!true
Chat~t!{EOCOOM="false",EOCOOMV=20,MSG="Casting #s on #n",RESONLY="true",CHAN="",NOTIFY=1}
General~t!{OFREQ=0.07,STICKYSENSITIVITY=30,FLUIDBARS="false",OMAX=0.95,HIDEPTF="false",FLUIDFREQ=10,STICKYFRAME="true",HIDEPARTYF="true",HIDERAIDF="true",OMIN=0.1,HIDEBOSSF="true"}
Healing~t!{TINCRAID="true",TINCSELF="false",GROUPPETS="true",TARGETINCOMBAT=2,FALWAYSSHOW="false",FONLYFRIEND="false",TINCPET="false",TONLYFRIEND="false",TINCGROUP="true",FOCUSINCOMBAT=2,TALWAYSSHOW="false",FEXRAID="false",SELFPET=0,TEXRAID="false",ALERT=1}
Enemy~t!{ENEMYTARGET="false",INCTANKS="true",INCMYTAR="false",INCARENA="true",ENEMYTARGETSIZE=40,INCARENAPETS="false",HIDE="true",NUMBOSS=2,EXISTSHOWPTAR=1,INCSELF="false",EXISTSHOWBOSS="true",DOUBLEWIDTH="false",EXISTSHOWARENA=3}
FrameAlias~f~1!{SIZE=15,NAME="Tanks",R=1,ALIAS="Tanks",G=0.925,SHOW="true",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=0.592,OUTLINE=3}
FrameAlias~f~2!{SIZE=12,NAME="Everyone Else",R=1,ALIAS="Everyone",G=1,SHOW="true",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=3}
FrameAlias~f~3!{A=1,NAME="",R=1,ALIAS="Frame 3",G=1,SHOW="true",OFFSET=9,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=3}
FrameAlias~d!4~5~
FrameAlias~f~6!{A=1,NAME="",R=1,ALIAS="Vehicle",G=1,SHOW="true",OFFSET=9,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=3}
FrameAlias~f~7!{A=1,NAME="",R=1,ALIAS="Pets",G=1,SHOW="true",OFFSET=9,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=3}
FrameAlias~f~8!{A=1,NAME="Target",R=1,ALIAS="Target",G=1,SHOW="true",OFFSET=0,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=3}
FrameAlias~f~9!{A=1,NAME="Focus",R=1,ALIAS="Focus",G=1,SHOW="true",OFFSET=0,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=3}
FrameAlias~f~10!{A=1,NAME="",R=1,ALIAS="Enemy",G=1,SHOW="true",OFFSET=9,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=3}
FrameAliasBar~f~1!{A=0.5,TEXTURE="HealBot 10",B=0.25,HEIGHT=20,R=0.1,G=0.25,WIDTH=1}
FrameAliasBar~d!2~
FrameAliasBar~f~3!{A=0.5,TEXTURE="HealBot 10",B=0.25,HEIGHT=20,R=0.1,G=0.25,WIDTH=0.7}
FrameAliasBar~d!4~5~6~7~
FrameAliasBar~f~8!{A=0.5,TEXTURE="HealBot 10",B=0.25,HEIGHT=20,R=0.1,G=0.25,WIDTH=1}
FrameAliasBar~d!9~
FrameAliasBar~f~10!{A=0.5,TEXTURE="HealBot 10",B=0.25,HEIGHT=20,R=0.1,G=0.25,WIDTH=0.7}
Frame~f~1!{BORDERR=0.8,SFOFFSETH=0,BACKG=0.2,BACKB=0.702,LOCKED="false",SCALE=1,BORDERA=1,BORDERG=0.2,TIPLOC=5,BORDERB=0.8,BACKA=0.1,OPENSOUND="false",AUTOCLOSE="false",SFOFFSETV=0,BACKR=0.2}
Frame~d!2~
Frame~f~3!{BORDERR=0.875,SFOFFSETH=0,TIPLOC=5,BORDERB=0.875,LOCKED="false",SCALE=1,BORDERA=0.76,BORDERG=0.875,BACKG=0.2,BACKB=0.702,BACKA=0.1,OPENSOUND="false",AUTOCLOSE="false",SFOFFSETV=0,BACKR=0.2}
Frame~d!4~5~6~7~
Frame~f~8!{BORDERR=0.8,SFOFFSETH=0,TIPLOC=5,BORDERB=0.8,LOCKED="false",SCALE=1,BORDERA=1,BORDERG=0.2,BACKG=0.2,BACKB=0.702,BACKA=0.1,OPENSOUND="false",AUTOCLOSE="false",SFOFFSETV=0,BACKR=0.2}
Frame~d!9~
Frame~f~10!{BORDERR=0.875,SFOFFSETH=0,TIPLOC=5,BORDERB=0.875,LOCKED="false",SCALE=1,BORDERA=0.76,BORDERG=0.875,BACKG=0.2,BACKB=0.702,BACKA=0.1,OPENSOUND="false",AUTOCLOSE="false",SFOFFSETV=0,BACKR=0.2}
StickyFrames~f~1!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~f~2!{STUCK="true",STUCKTOPOINT="BOTTOM",STUCKTO=1,STUCKPOINT="TOP"}
StickyFrames~f~3!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~d!4~5~6~7~
StickyFrames~f~8!{STUCK="true",STUCKTOPOINT="TOPLEFT",STUCKTO=1,STUCKPOINT="TOPRIGHT"}
StickyFrames~f~9!{STUCK="true",STUCKTOPOINT="TOPRIGHT",STUCKTO=1,STUCKPOINT="TOPLEFT"}
StickyFrames~f~10!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
HealGroups~f~1!{FRAME=2,STATE="false",NAME="Self"}
HealGroups~f~2!{FRAME=1,STATE="true",NAME="Main tanks"}
HealGroups~f~3!{FRAME=2,STATE="false",NAME="Healers"}
HealGroups~f~4!{FRAME=2,STATE="false",NAME="Group"}
HealGroups~f~5!{FRAME=2,STATE="false",NAME="Private List"}
HealGroups~f~6!{FRAME=2,STATE="true",NAME="Raid"}
HealGroups~f~7!{FRAME=2,STATE="false",NAME="Vehicle"}
HealGroups~f~8!{FRAME=2,STATE="false",NAME="Pets"}
HealGroups~f~9!{FRAME=8,STATE="true",NAME="Target"}
HealGroups~f~10!{FRAME=9,STATE="true",NAME="Focus"}
HealGroups~f~11!{FRAME=10,STATE="false",NAME="Enemy"}
Anchors~f~1!{Y=71.62,GROW=2,BARS=1,FRAME=1,X=15.05}
Anchors~f~2!{Y=61.12,GROW=2,BARS=1,FRAME=5,X=20.84}
Anchors~f~3!{Y=33.85,GROW=2,BARS=1,FRAME=1,X=30.49}
Anchors~f~4!{Y=33.01,GROW=2,BARS=1,FRAME=1,X=29.96}
Anchors~f~5!{Y=32.16,GROW=2,BARS=1,FRAME=1,X=29.43}
Anchors~f~6!{Y=31.32,GROW=2,BARS=1,FRAME=1,X=28.9}
Anchors~f~7!{Y=30.47,GROW=2,BARS=1,FRAME=1,X=28.37}
Anchors~f~8!{Y=71.62,GROW=2,BARS=1,FRAME=3,X=15.05}
Anchors~f~9!{Y=71.62,GROW=2,BARS=1,FRAME=1,X=26.63}
Anchors~f~10!{Y=27.93,GROW=2,BARS=1,FRAME=1,X=26.79}
HeadBar~f~1!{SHOW="false",WIDTH=0.8,B=0.702,R=0.376,HEIGHT=19,A=0.4,G=0.427,TEXTURE="HealBot 10"}
HeadBar~f~2!{SHOW="true",WIDTH=0.8,B=0.702,R=0.376,HEIGHT=19,A=0.4,G=0.427,TEXTURE="HealBot 10"}
HeadBar~f~3!{SHOW="false",TEXTURE="HealBot 10",R=0.376,B=0.702,HEIGHT=19,A=0.4,G=0.427,WIDTH=0.8}
HeadBar~d!4~5~6~7~8~9~10~
HeadText~f~1!{A=0.92,B=1,OFFSET=0,R=1,HEIGHT=10,FONT="Friz Quadrata TT",G=1,OUTLINE=2}
HeadText~f~2!{A=0.92,R=1,OFFSET=0,B=1,HEIGHT=11,FONT="Friz Quadrata TT",G=1,OUTLINE=2}
HeadText~f~3!{A=0.92,R=1,OFFSET=0,B=1,HEIGHT=10,FONT="Friz Quadrata TT",G=1,OUTLINE=2}
HeadText~d!4~5~6~7~8~9~10~
HealBar~f~1!{HEIGHT=38,GRPCOLS="false",CMARGIN=4,TEXTURE="Marble",POWERCNT="true",LOWMANACOMBAT="true",RMARGIN=0,NUMCOLS=2,OFIX=1,WIDTH=155,LOWMANA=2}
HealBar~f~2!{HEIGHT=25,GRPCOLS="false",CMARGIN=4,TEXTURE="Marble",POWERCNT="true",LOWMANACOMBAT="true",RMARGIN=0,NUMCOLS=2,OFIX=1,WIDTH=118,LOWMANA=2}
HealBar~f~3!{HEIGHT=35,GRPCOLS="false",CMARGIN=4,TEXTURE="Marble",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=172,NUMCOLS=1,OFIX=1,RMARGIN=0,LOWMANA=2}
HealBar~d!4~5~6~7~
HealBar~f~8!{HEIGHT=35,GRPCOLS="false",CMARGIN=4,TEXTURE="Marble",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=2,RMARGIN=0,OFIX=1,NUMCOLS=1,WIDTH=80}
HealBar~d!9~
HealBar~f~10!{HEIGHT=35,GRPCOLS="false",CMARGIN=4,TEXTURE="Marble",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=2,RMARGIN=0,OFIX=1,NUMCOLS=1,WIDTH=172}
BarCol~f~1!{BACK=3,BA=0.72,BOUT=2,DISA=0.05,BR=0.008,HB=0,BG=0.016,HG=0,HA=1,HR=0,ORA=0.6,BB=0.016,HLTH=2}
BarCol~f~2!{BACK=3,BA=0.72,BOUT=3,DISA=0.05,BR=0.008,HB=0,BG=0.016,BB=0.016,HA=1,HG=0,ORA=0.6,HR=0,HLTH=2}
BarCol~f~3!{BACK=3,BA=0.72,BOUT=4,DISA=0.05,BR=0.008,HB=0,BG=0.016,BB=0.016,HA=1,HG=0,ORA=0.6,HR=0,HLTH=2}
BarCol~d!4~5~6~7~
BarCol~f~8!{BACK=3,BA=0.72,BOUT=2,DISA=0.05,BR=0.008,HB=0,BG=0.016,BB=0.016,HA=1,HG=0,ORA=0.6,HR=0,HLTH=2}
BarCol~d!9~
BarCol~f~10!{BACK=3,BA=0.72,BOUT=4,DISA=0.05,BR=0.008,HB=0,BG=0.016,BB=0.016,HA=1,HG=0,ORA=0.6,HR=0,HLTH=2}
BarIACol~f~1!{AC=4,AB=1,AA=0.75,AR=1,AG=1,IC=3,IB=0.102,IA=0.44,IR=0.102,IG=1}
BarIACol~d!2~3~4~5~6~7~8~9~10~
BarText~f~1!{HLTHONBAR="true",TAGOOR="[ OOR ] ",HOUTLINE=2,MAXCHARS=0,HMAXCHARS=0,OUTLINE=2,IGNOREONFULL="true",INCHEALS=2,HLTHTXTANCHOR=4,HLTHTYPE=1,OVERHEAL=1,HFONT="Friz Quadrata TT",NUMFORMAT2=1,NUMFORMAT1=11,TAGDC="[ DC ] ",CLASSONBAR="false",NAMEONBAR="true",HEIGHT=12,HHEIGHT=10,SHOWROLE="true",HALIGN=2,TAGRIP="[ RIP ] ",OFFSET=0,FONT="Friz Quadrata TT",INCABSORBS=1,HOFFSET2=0,ALIGN=2,TAGR="[ R ] ",HOFFSET=0}
BarText~f~2!{HLTHONBAR="true",TAGOOR="[ OOR ] ",HOUTLINE=2,MAXCHARS=0,HMAXCHARS=0,OUTLINE=2,IGNOREONFULL="true",INCHEALS=2,HLTHTXTANCHOR=4,FONT="Friz Quadrata TT",OVERHEAL=1,HFONT="Friz Quadrata TT",NUMFORMAT2=1,NUMFORMAT1=11,TAGDC="[ DC ] ",CLASSONBAR="false",NAMEONBAR="true",HEIGHT=12,HHEIGHT=10,SHOWROLE="true",HALIGN=2,TAGRIP="[ RIP ] ",OFFSET=0,HLTHTYPE=1,INCABSORBS=1,HOFFSET2=0,ALIGN=2,TAGR="[ R ] ",HOFFSET=2}
BarText~d!3~
BarText~f~4!{HHEIGHT=10,TAGOOR="[ OOR ] ",HOUTLINE=2,MAXCHARS=0,HMAXCHARS=0,OUTLINE=2,HOFFSET=0,INCHEALS=2,HLTHTXTANCHOR=4,HLTHTYPE=1,CLASSONBAR="false",OVERHEAL=1,NUMFORMAT2=1,TAGDC="[ DC ] ",NUMFORMAT1=11,OFFSET=0,NAMEONBAR="true",HEIGHT=12,FONT="Friz Quadrata TT",SHOWROLE="true",HALIGN=2,TAGRIP="[ RIP ] ",IGNOREONFULL="true",HLTHONBAR="true",INCABSORBS=1,HOFFSET2=0,ALIGN=2,TAGR="[ R ] ",HFONT="Friz Quadrata TT"}
BarText~d!5~6~7~8~9~10~
BarTextCol~f~1!{NCB=0,HCA=1,HLTH=2,NCDA=0.78,HCG=1,NCR=1,NCG=1,NCA=1,HCR=1,HCB=0,NDEBUFF="false",HDEBUFF="false",NAME=2,HCDA=0.78}
BarTextCol~d!2~3~4~5~6~7~8~9~10~
Icons~f~1!{RCEN="true",I15EN="true",CLASSEN="false",BUFFANCHOR=2,BUFFFADE="true",DEBUFFANCHOR=1,RCVOFFSET=0,OORVOFFSET=0,DEBUFFDOUBLE="false",TARGETVOFFSET=1,BUFFONBAR=1,SHOWDIR="true",SHOWRC="true",TARGETANCHOR=5,RCSCALE=0.95,MAXBICONS=5,FADE="true",FADESECS=15,RCHOFFSET=0,TARGETHOFFSET=5,RCANCHOR=3,CLASSVOFFSET=0,TARGETEN="true",DSCALE=0.45,TARGETONBAR=3,TARGETSCALE=0.55,BUFFDOUBLE="false",OORONBAR=3,CLASSONBAR=1,OORANCHOR=1,SHOWDIRMOUSE="false",DOUBLE="false",RCONBAR=3,MAXDICONS=3,CLASSSCALE=0.5,CLASSANCHOR=1,SHOWCLASS="false",CLASSHOFFSET=0,DEBUFFONBAR=1,SHOWROLE="false",BUFFI15EN="true",BUFFFADESECS=15,OORSCALE=0.5,SCALE=0.45,OOREN="false",OORHOFFSET=0}
Icons~f~2!{RCEN="true",I15EN="true",CLASSEN="false",BUFFANCHOR=2,BUFFFADE="true",DEBUFFANCHOR=1,RCVOFFSET=0,OORVOFFSET=0,DEBUFFDOUBLE="false",TARGETVOFFSET=1,BUFFONBAR=1,SHOWDIR="true",SHOWRC="true",TARGETANCHOR=5,RCSCALE=0.95,MAXBICONS=5,FADE="true",FADESECS=15,RCHOFFSET=0,TARGETHOFFSET=5,RCANCHOR=3,CLASSVOFFSET=0,TARGETEN="true",DSCALE=0.55,TARGETONBAR=3,TARGETSCALE=0.55,BUFFDOUBLE="false",OORONBAR=3,CLASSONBAR=1,OORANCHOR=1,SHOWDIRMOUSE="false",DOUBLE="false",RCONBAR=3,MAXDICONS=3,CLASSSCALE=0.5,CLASSANCHOR=1,SHOWCLASS="false",CLASSHOFFSET=0,DEBUFFONBAR=1,SHOWROLE="false",BUFFI15EN="true",BUFFFADESECS=15,OORSCALE=0.5,SCALE=0.55,OOREN="false",OORHOFFSET=0}
Icons~f~3!{RCEN="true",I15EN="true",CLASSEN="false",BUFFANCHOR=2,BUFFFADE="true",DEBUFFANCHOR=1,RCVOFFSET=0,OORVOFFSET=0,DEBUFFDOUBLE="false",TARGETVOFFSET=1,BUFFONBAR=1,SHOWDIR="true",SHOWRC="true",TARGETANCHOR=5,RCSCALE=0.95,MAXBICONS=8,FADE="true",FADESECS=15,RCHOFFSET=0,TARGETHOFFSET=5,RCANCHOR=3,CLASSVOFFSET=0,TARGETEN="true",DSCALE=0.5,TARGETONBAR=3,TARGETSCALE=0.55,BUFFDOUBLE="false",OORONBAR=3,CLASSONBAR=1,OORANCHOR=1,SHOWDIRMOUSE="false",DOUBLE="false",RCONBAR=3,MAXDICONS=3,CLASSSCALE=0.5,CLASSANCHOR=1,SHOWCLASS="false",CLASSHOFFSET=0,DEBUFFONBAR=1,SHOWROLE="false",BUFFI15EN="true",BUFFFADESECS=15,OORSCALE=0.5,SCALE=0.5,OOREN="false",OORHOFFSET=0}
Icons~d!4~5~6~7~
Icons~f~8!{RCEN="true",I15EN="true",CLASSEN="false",BUFFANCHOR=2,BUFFFADE="true",DEBUFFANCHOR=1,RCVOFFSET=0,OORVOFFSET=0,DEBUFFDOUBLE="false",TARGETVOFFSET=1,BUFFONBAR=1,SHOWDIR="true",SHOWRC="true",TARGETANCHOR=5,RCSCALE=0.95,MAXBICONS=4,SHOWDIRMOUSE="false",FADESECS=15,RCHOFFSET=0,TARGETHOFFSET=5,RCANCHOR=3,CLASSVOFFSET=0,TARGETEN="true",DSCALE=0.4,DEBUFFONBAR=1,OORONBAR=3,BUFFDOUBLE="false",TARGETONBAR=3,TARGETSCALE=0.55,SHOWROLE="false",CLASSONBAR=1,SHOWCLASS="false",RCONBAR=3,MAXDICONS=3,CLASSSCALE=0.5,CLASSANCHOR=1,FADE="true",CLASSHOFFSET=0,DOUBLE="false",OORANCHOR=1,BUFFI15EN="true",BUFFFADESECS=15,OORSCALE=0.5,SCALE=0.4,OOREN="false",OORHOFFSET=0}
Icons~d!9~
Icons~f~10!{RCEN="true",I15EN="true",CLASSEN="false",BUFFANCHOR=2,BUFFFADE="true",DEBUFFANCHOR=1,RCVOFFSET=0,OORVOFFSET=0,DEBUFFDOUBLE="false",TARGETVOFFSET=1,BUFFONBAR=1,SHOWDIR="true",SHOWRC="true",TARGETANCHOR=5,RCSCALE=0.95,MAXBICONS=8,SHOWDIRMOUSE="false",FADESECS=15,RCHOFFSET=0,TARGETHOFFSET=5,RCANCHOR=3,CLASSVOFFSET=0,TARGETEN="true",DSCALE=0.5,DEBUFFONBAR=1,OORONBAR=3,BUFFDOUBLE="false",TARGETONBAR=3,TARGETSCALE=0.55,SHOWROLE="false",CLASSONBAR=1,SHOWCLASS="false",RCONBAR=3,MAXDICONS=3,CLASSSCALE=0.5,CLASSANCHOR=1,FADE="true",CLASSHOFFSET=0,DOUBLE="false",OORANCHOR=1,BUFFI15EN="true",BUFFFADESECS=15,OORSCALE=0.5,SCALE=0.5,OOREN="false",OORHOFFSET=0}
RaidIcon~f~1!{SQUARE="true",CIRCLE="true",DIAMOND="true",SHOW="true",SKULL="true",TRIANGLE="true",STAR="true",CROSS="true",MOON="true"}
RaidIcon~d!2~3~4~5~6~7~8~9~10~
IconText~f~1!{DURWARN=3,BUFFSSDUR="true",BUFFOUTLINE=2,BUFFDURTHRH=9,SCNT="true",DURTHRH=9,FONT="Friz Quadrata TT",BUFFFONT="Friz Quadrata TT",BUFFSCNT="true",SSCNT="false",OUTLINE=2,BUFFDURWARN=3,SDUR="true",BUFFSSCNT="false",HEIGHT=10,BUFFHEIGHT=10,SSDUR="true",BUFFSDUR="true"}
IconText~f~2!{DURWARN=3,BUFFSSDUR="true",BUFFOUTLINE=2,BUFFDURTHRH=9,SCNT="true",DURTHRH=9,FONT="Friz Quadrata TT",BUFFFONT="Friz Quadrata TT",BUFFSCNT="true",SSCNT="false",OUTLINE=2,BUFFDURWARN=3,SDUR="true",BUFFSSCNT="false",HEIGHT=8,BUFFHEIGHT=8,SSDUR="true",BUFFSDUR="true"}
IconText~f~3!{DURWARN=3,BUFFSSDUR="true",BUFFOUTLINE=2,BUFFDURTHRH=9,SCNT="true",DURTHRH=9,FONT="Friz Quadrata TT",BUFFFONT="Friz Quadrata TT",BUFFSCNT="true",SSCNT="false",OUTLINE=2,BUFFDURWARN=3,SDUR="true",BUFFSSCNT="false",HEIGHT=9,BUFFHEIGHT=9,SSDUR="true",BUFFSDUR="true"}
IconText~d!4~5~6~7~8~9~10~
BarVisibility~f~1!{INCCLASSES=1,ALERTIC=0.98,ALERTOC=0.95,HIDEOOR="false"}
BarVisibility~f~2!{INCCLASSES=1,ALERTIC=0.95,ALERTOC=0.85,HIDEOOR="false"}
BarVisibility~d!3~4~5~6~7~8~9~10~
BarSort~f~1!{SUBORDER=1,OORLAST="false",RAIDORDER=3,SUBPF="true"}
BarSort~d!2~3~4~5~6~7~8~9~10~
BarAggro~f~1!{B=0,ALERTIND=2,G=0,TEXTFORMAT=3,SHOW="true",SHOWTEXTPCT="true",SHOWTEXT="true",R=1,SHOWIND="true",ALERT=2}
BarAggro~d!2~3~4~5~6~7~8~9~10~
AuxBarFrame~f~1!{OVERLAP=1}
AuxBarFrame~d!2~3~4~5~6~7~8~9~10~
AuxBar^1~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,OTYPE=1}
AuxBar^1~d!2~3~4~5~6~7~8~9~10~
AuxBar^2~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,OTYPE=1}
AuxBar^2~d!2~3~4~5~6~7~8~9~10~
AuxBar^3~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,OTYPE=1}
AuxBar^3~d!2~3~4~5~6~7~8~9~10~
AuxBar^4~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,OTYPE=1}
AuxBar^4~d!2~3~4~5~6~7~8~9~10~
AuxBar^5~f~1!{SIZE=0.98,USE=5,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=2,G=1,B=1,OTYPE=1}
AuxBar^5~d!2~3~4~5~6~7~8~9~
AuxBar^5~f~10!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=2,G=1,B=1,OTYPE=1}
AuxBar^6~f~1!{SIZE=0.98,USE=5,R=1,COLOUR=1,ANCHOR=2,OFFSET=1,DEPTH=2,G=1,B=1,OTYPE=1}
AuxBar^6~d!2~3~4~5~6~7~8~9~
AuxBar^6~f~10!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=2,OFFSET=1,DEPTH=2,G=1,B=1,OTYPE=1}
AuxBar^7~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,OTYPE=1}
AuxBar^7~d!2~3~4~5~6~7~8~9~10~
AuxBar^8~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,OTYPE=1}
AuxBar^8~d!2~3~4~5~6~7~8~9~10~
AuxBar^9~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,OTYPE=1}
AuxBar^9~d!2~3~4~5~6~7~8~9~10~
Complete!]]
HealBot_ExtraSkinData[14]=[[Skin
Square
Author~v!Monti of Terenas
DuplicateBars~v!false
Chat~t!{EOCOOM="false",EOCOOMV=20,MSG="Casting #s on #n",RESONLY="true",CHAN="",NOTIFY=1}
General~t!{OFREQ=0.07,STICKYSENSITIVITY=30,FLUIDBARS="false",STICKYFRAME="true",HIDEPARTYF="true",FLUIDFREQ=10,HIDEPTF="false",HIDEBOSSF="true",HIDERAIDF="true",OMIN=0.1,OMAX=0.95}
Healing~t!{TINCSELF="false",TINCRAID="true",GROUPPETS="true",TARGETINCOMBAT=2,TINCGROUP="true",FONLYFRIEND="false",SELFPET=0,TONLYFRIEND="false",FALWAYSSHOW="false",FOCUSINCOMBAT=2,TALWAYSSHOW="false",TINCPET="false",FEXRAID="false",TEXRAID="false",ALERT=0.87999999523163}
Enemy~t!{ENEMYTARGET="false",INCTANKS="true",INCMYTAR="false",INCARENA="true",INCARENAPETS="false",ENEMYTARGETSIZE=40,INCSELF="false",NUMBOSS=2,EXISTSHOWPTAR=1,HIDE="true",EXISTSHOWBOSS="true",DOUBLEWIDTH="false",EXISTSHOWARENA=3}
FrameAlias~f~1!{A=1,NAME="",R=1,ALIAS="Frame 1",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~2!{A=1,NAME="",R=1,ALIAS="Not Used 1",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~3!{A=1,NAME="",R=1,ALIAS="Not Used 2",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~4!{A=1,NAME="",R=1,ALIAS="Not Used 3",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~5!{A=1,NAME="",R=1,ALIAS="Not Used 4",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~6!{A=1,NAME="",R=1,ALIAS="Vehicle",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~7!{A=1,NAME="",R=1,ALIAS="Pets",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~8!{A=1,NAME="",R=1,ALIAS="Target",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~9!{A=1,NAME="",R=1,ALIAS="Focus",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~10!{A=1,NAME="",R=1,ALIAS="Enemy",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAliasBar~f~1!{A=0.5,WIDTH=0.7,B=0.25,HEIGHT=20,R=0.1,G=0.25,TEXTURE="HealBot 10"}
FrameAliasBar~d!2~3~4~5~6~7~8~9~10~
Frame~f~1!{BORDERR=1,SFOFFSETH=0,BORDERG=1,AUTOCLOSE="false",LOCKED="false",OPENSOUND="false",BORDERA=0.12,SFOFFSETV=0,TIPLOC=5,BORDERB=1,BACKA=0.1,SCALE=1,BACKB=0.702,BACKG=0.2,BACKR=0.2}
Frame~d!2~3~4~5~6~7~
Frame~f~8!{BORDERR=1,SFOFFSETH=9,BORDERG=1,AUTOCLOSE="false",LOCKED="false",SCALE=1,BORDERA=0.12,SFOFFSETV=1,BACKG=0.2,BACKB=0.702,BACKA=0.1,OPENSOUND="false",BORDERB=1,TIPLOC=5,BACKR=0.2}
Frame~f~9!{BORDERR=1,SFOFFSETH=0,BORDERG=1,AUTOCLOSE="false",LOCKED="false",SCALE=1,BORDERA=0.12,SFOFFSETV=0,BACKG=0.2,BACKB=0.702,BACKA=0.1,OPENSOUND="false",BORDERB=1,TIPLOC=5,BACKR=0.2}
Frame~d!10~
StickyFrames~f~1!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~d!2~3~4~5~6~7~
StickyFrames~f~8!{STUCK="true",STUCKTOPOINT="TOPLEFT",STUCKTO=1,STUCKPOINT="TOPRIGHT"}
StickyFrames~f~9!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~d!10~
HealGroups~f~1!{FRAME=1,STATE="false",NAME="Self"}
HealGroups~f~2!{FRAME=1,STATE="true",NAME="Main tanks"}
HealGroups~f~3!{FRAME=1,STATE="false",NAME="Healers"}
HealGroups~f~4!{FRAME=1,STATE="true",NAME="Group"}
HealGroups~f~5!{FRAME=1,STATE="true",NAME="Private List"}
HealGroups~f~6!{FRAME=1,STATE="true",NAME="Raid"}
HealGroups~f~7!{FRAME=1,STATE="false",NAME="Vehicle"}
HealGroups~f~8!{FRAME=1,STATE="false",NAME="Pets"}
HealGroups~f~9!{FRAME=8,STATE="true",NAME="Target"}
HealGroups~f~10!{FRAME=9,STATE="false",NAME="Focus"}
HealGroups~f~11!{FRAME=10,STATE="false",NAME="Enemy"}
Anchors~f~1!{Y=75.4,GROW=2,BARS=1,FRAME=1,X=12}
Anchors~f~2!{Y=35.89,GROW=2,BARS=1,FRAME=1,X=34.62}
Anchors~f~3!{Y=35.04,GROW=2,BARS=1,FRAME=1,X=34.09}
Anchors~f~4!{Y=34.19,GROW=2,BARS=1,FRAME=1,X=33.56}
Anchors~f~5!{Y=33.35,GROW=2,BARS=1,FRAME=1,X=33.03}
Anchors~f~6!{Y=32.5,GROW=2,BARS=1,FRAME=1,X=32.5}
Anchors~f~7!{Y=31.65,GROW=2,BARS=1,FRAME=1,X=31.97}
Anchors~f~8!{Y=75.48,GROW=2,BARS=1,FRAME=3,X=12.31}
Anchors~f~9!{Y=75.4,GROW=2,BARS=1,FRAME=1,X=27.7}
Anchors~f~10!{Y=29.11,GROW=2,BARS=1,FRAME=1,X=30.38}
HeadBar~f~1!{SHOW="false",WIDTH=0.8,B=0.8,R=0.8,HEIGHT=14,A=0.15,G=0.8,TEXTURE="HealBot 10"}
HeadBar~d!2~3~4~5~6~7~8~9~10~
HeadText~f~1!{A=1,R=1,OFFSET=0,B=1,HEIGHT=10,FONT="Friz Quadrata TT",G=1,OUTLINE=1}
HeadText~d!2~3~4~5~6~7~8~9~10~
HealBar~f~1!{HEIGHT=55,GRPCOLS="false",CMARGIN=0,TEXTURE="Tukui2",POWERCNT="false",LOWMANACOMBAT="true",LOWMANA=1,WIDTH=55,OFIX=1,NUMCOLS=8,RMARGIN=0}
HealBar~f~2!{HEIGHT=55,GRPCOLS="false",CMARGIN=3,TEXTURE="Minimalist",POWERCNT="false",LOWMANACOMBAT="true",LOWMANA=1,RMARGIN=4,OFIX=1,NUMCOLS=8,WIDTH=55}
HealBar~d!3~4~5~6~7~8~9~10~
BarCol~f~1!{BACK=1,BA=0,BB=0.702,DISA=0.1,BR=0.4,HB=0,BG=0.702,BOUT=0,HA=1,HG=0,ORA=0.4,HR=0,HLTH=2}
BarCol~f~2!{BACK=2,BA=0.25,BOUT=1,DISA=0.1,BR=0.4,HB=0,BG=0.702,HR=0,HA=0.99,HG=0,ORA=0.4,BB=0.702,HLTH=2}
BarCol~d!3~4~5~6~7~8~9~10~
BarIACol~f~1!{AC=3,AB=1,AA=0.38,AR=1,AG=1,IC=3,IB=1,IA=0.58,IR=0,IG=0}
BarIACol~f~2!{AC=3,AB=1,AA=0.74,AR=1,AG=1,IC=3,IB=1,IA=0.4,IR=0,IG=0}
BarIACol~d!3~4~5~6~7~8~9~10~
BarText~f~1!{HLTHONBAR="true",TAGOOR="[ OOR ] ",OVERHEAL=1,MAXCHARS=0,TAGRIP="[ RIP ] ",CLASSONBAR="false",HOFFSET=0,OUTLINE=1,FONT="Friz Quadrata TT",OFFSET=0,HLTHTXTANCHOR=1,HLTHTYPE=1,HMAXCHARS=0,INCABSORBS=1,NUMFORMAT2=1,HOUTLINE=1,NUMFORMAT1=11,HHEIGHT=10,NAMEONBAR="true",HEIGHT=8,INCHEALS=3,SHOWROLE="true",HALIGN=2,TAGDC="[ DC ] ",IGNOREONFULL="true",HOFFSET2=0,ALIGN=2,TAGR="[ R ] ",HFONT="Friz Quadrata TT"}
BarText~d!2~3~4~5~6~7~8~9~10~
BarTextCol~f~1!{NAME=2,NDEBUFF="false",HCG=1,NCDA=0.27,NCB=0,HCA=1,NCG=1,NCA=1,NCR=1,HCB=0,HCR=1,HDEBUFF="false",HCDA=0.27,HLTH=2}
BarTextCol~d!2~3~4~5~6~7~8~9~10~
Icons~f~1!{RCEN="true",I15EN="true",CLASSEN="false",BUFFANCHOR=2,BUFFFADE="true",DEBUFFANCHOR=1,RCVOFFSET=-8,OORVOFFSET=0,DEBUFFDOUBLE="true",TARGETVOFFSET=0,BUFFONBAR=1,SHOWDIR="false",SHOWRC="true",TARGETANCHOR=6,RCSCALE=0.75,MAXBICONS=6,FADESECS=15,RCHOFFSET=0,TARGETHOFFSET=-10,RCANCHOR=3,CLASSVOFFSET=0,TARGETONBAR=3,DSCALE=0.5,FADE="true",OORHOFFSET=0,BUFFDOUBLE="true",OORONBAR=3,TARGETEN="true",TARGETSCALE=0.35,CLASSSCALE=0.5,CLASSHOFFSET=0,RCONBAR=3,MAXDICONS=4,OORANCHOR=1,CLASSONBAR=1,SHOWROLE="false",CLASSANCHOR=1,DEBUFFONBAR=1,SHOWCLASS="false",BUFFI15EN="true",BUFFFADESECS=15,OORSCALE=0.5,SCALE=0.5,OOREN="false",SHOWDIRMOUSE="false"}
Icons~f~2!{RCEN="true",I15EN="true",CLASSEN="false",BUFFANCHOR=2,BUFFFADE="true",DEBUFFANCHOR=1,RCVOFFSET=-8,OORVOFFSET=0,DEBUFFDOUBLE="true",TARGETVOFFSET=0,BUFFONBAR=1,SHOWDIR="false",SHOWRC="true",TARGETANCHOR=6,RCSCALE=0.75,MAXBICONS=8,FADESECS=15,RCHOFFSET=0,TARGETHOFFSET=-10,RCANCHOR=3,CLASSVOFFSET=0,SCALE=0.5,DSCALE=0.5,SHOWDIRMOUSE="false",OORHOFFSET=0,BUFFDOUBLE="true",TARGETONBAR=3,TARGETEN="true",TARGETSCALE=0.35,CLASSSCALE=0.5,CLASSHOFFSET=0,RCONBAR=3,MAXDICONS=3,OORANCHOR=1,CLASSONBAR=1,SHOWROLE="false",CLASSANCHOR=1,DEBUFFONBAR=1,SHOWCLASS="false",BUFFI15EN="true",BUFFFADESECS=15,OORSCALE=0.5,OORONBAR=3,OOREN="false",FADE="true"}
Icons~d!3~4~5~6~7~8~9~10~
RaidIcon~f~1!{SQUARE="true",CIRCLE="true",DIAMOND="true",SHOW="true",MOON="true",TRIANGLE="true",STAR="true",SKULL="true",CROSS="true"}
RaidIcon~d!2~3~4~5~6~7~8~9~10~
IconText~f~1!{DURWARN=3,BUFFSSDUR="true",BUFFOUTLINE=2,BUFFDURTHRH=9,SCNT="false",DURTHRH=9,FONT="Friz Quadrata TT",BUFFFONT="Friz Quadrata TT",BUFFSCNT="false",SSCNT="false",BUFFHEIGHT=10,BUFFDURWARN=3,SDUR="false",BUFFSDUR="false",HEIGHT=10,BUFFSSCNT="false",SSDUR="true",OUTLINE=2}
IconText~d!2~3~4~5~6~7~8~9~10~
BarVisibility~f~1!{INCCLASSES=1,ALERTIC=1,ALERTOC=0.95,HIDEOOR="false"}
BarVisibility~d!2~3~4~5~6~7~8~9~10~
BarSort~f~1!{SUBORDER=1,OORLAST="false",RAIDORDER=3,SUBPF="true"}
BarSort~d!2~3~4~5~6~7~8~9~10~
BarAggro~f~1!{B=0,ALERTIND=2,G=0,TEXTFORMAT=3,SHOW="true",SHOWTEXTPCT="true",SHOWTEXT="true",SHOWIND="true",R=1,ALERT=2}
BarAggro~d!2~3~4~5~6~7~8~9~10~
AuxBarFrame~f~1!{OVERLAP=1}
AuxBarFrame~d!2~3~4~5~6~7~8~9~10~
AuxBar^1~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,OTYPE=1,B=1,G=1}
AuxBar^1~d!2~3~4~5~6~7~8~9~10~
AuxBar^2~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,OTYPE=1,B=1,G=1}
AuxBar^2~d!2~3~4~5~6~7~8~9~10~
AuxBar^3~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,OTYPE=1,B=1,G=1}
AuxBar^3~d!2~3~4~5~6~7~8~9~10~
AuxBar^4~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,OTYPE=1,B=1,G=1}
AuxBar^4~d!2~3~4~5~6~7~8~9~10~
AuxBar^5~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,OTYPE=1,B=1,G=1}
AuxBar^5~d!2~3~4~5~6~7~8~9~10~
AuxBar^6~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,OTYPE=1,B=1,G=1}
AuxBar^6~d!2~3~4~5~6~7~8~9~10~
AuxBar^7~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,OTYPE=1,B=1,G=1}
AuxBar^7~d!2~3~4~5~6~7~8~9~10~
AuxBar^8~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,OTYPE=1,B=1,G=1}
AuxBar^8~d!2~3~4~5~6~7~8~9~10~
AuxBar^9~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,OTYPE=1,B=1,G=1}
AuxBar^9~d!2~3~4~5~6~7~8~9~10~
Complete!]]
HealBot_ExtraSkinData[15]=[[Skin
Ranged
Author~v!Monti of Terenas
DuplicateBars~v!true
Chat~t!{EOCOOM="false",EOCOOMV=20,MSG="Casting #s on #n",RESONLY="true",CHAN="",NOTIFY=1}
General~t!{HIDEBOSSF="true",STICKYSENSITIVITY=30,FLUIDBARS="false",OMAX=0.95,HIDEPTF="false",HIDEPARTYF="true",HIDERAIDF="true",OFREQ=0.07,STICKYFRAME="true",OMIN=0.1,FLUIDFREQ=10}
Healing~t!{TINCSELF="false",TINCRAID="true",GROUPPETS="true",TARGETINCOMBAT=2,TINCGROUP="true",FONLYFRIEND="false",FEXRAID="false",TONLYFRIEND="false",FALWAYSSHOW="false",FOCUSINCOMBAT=2,TALWAYSSHOW="false",TINCPET="false",SELFPET=0,TEXRAID="false",ALERT=1}
Enemy~t!{INCARENA="true",INCTANKS="true",INCMYTAR="false",ENEMYTARGET="false",INCARENAPETS="false",ENEMYTARGETSIZE=40,HIDE="true",NUMBOSS=2,EXISTSHOWPTAR=1,INCSELF="false",EXISTSHOWBOSS="true",DOUBLEWIDTH="false",EXISTSHOWARENA=3}
FrameAlias~f~1!{SIZE=12,NAME="",R=1,ALIAS="Frame 1",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~2!{SIZE=9,NAME="Tanks",R=1,ALIAS="Frame 2",G=1,SHOW="true",OFFSET=1,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~3!{SIZE=12,NAME="",R=1,ALIAS="Not Used",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~d!4~5~
FrameAlias~f~6!{SIZE=12,NAME="",R=1,ALIAS="Vehicle",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~7!{SIZE=12,NAME="",R=1,ALIAS="Pets",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~8!{SIZE=12,NAME="",R=1,ALIAS="Target",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~9!{SIZE=12,NAME="",R=1,ALIAS="Focus",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~10!{SIZE=12,NAME="",R=1,ALIAS="Enemy",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAliasBar~f~1!{A=0.5,TEXTURE="HealBot 10",B=0.25,HEIGHT=20,R=0.1,G=0.25,WIDTH=0.7}
FrameAliasBar~f~2!{A=0.5,WIDTH=0.95,B=0.102,HEIGHT=12,R=0.102,G=0.702,TEXTURE="HealBot 10"}
FrameAliasBar~f~3!{A=0.5,WIDTH=0.7,B=0.25,HEIGHT=20,R=0.1,G=0.25,TEXTURE="HealBot 10"}
FrameAliasBar~d!4~5~6~7~8~9~10~
Frame~f~1!{SFOFFSETH=0,BACKR=0.2,BACKG=0.2,BACKB=0.7,LOCKED="false",OPENSOUND="false",BORDERA=0.2,BORDERG=0.7,TIPLOC=5,BORDERB=0.2,BACKA=0.1,SCALE=1,AUTOCLOSE="false",BORDERR=0.2,SFOFFSETV=0}
Frame~d!2~3~4~5~6~7~8~9~10~
StickyFrames~f~1!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~f~2!{STUCK="true",STUCKTOPOINT="TOPRIGHT",STUCKTO=1,STUCKPOINT="BOTTOMRIGHT"}
StickyFrames~f~3!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~d!4~5~6~7~
StickyFrames~f~8!{STUCK="true",STUCKTOPOINT="TOPLEFT",STUCKTO=1,STUCKPOINT="TOPRIGHT"}
StickyFrames~f~9!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~d!10~
HealGroups~f~1!{FRAME=2,STATE="true",NAME="Main tanks"}
HealGroups~f~2!{FRAME=1,STATE="true",NAME="Raid"}
HealGroups~f~3!{FRAME=1,STATE="false",NAME="Self"}
HealGroups~f~4!{FRAME=1,STATE="false",NAME="Healers"}
HealGroups~f~5!{FRAME=1,STATE="false",NAME="Group"}
HealGroups~f~6!{FRAME=1,STATE="false",NAME="Private List"}
HealGroups~f~7!{FRAME=1,STATE="false",NAME="Vehicle"}
HealGroups~f~8!{FRAME=1,STATE="false",NAME="Pets"}
HealGroups~f~9!{FRAME=8,STATE="true",NAME="Target"}
HealGroups~f~10!{FRAME=9,STATE="false",NAME="Focus"}
HealGroups~f~11!{FRAME=10,STATE="false",NAME="Enemy"}
Anchors~f~1!{Y=54.82,GROW=2,BARS=1,FRAME=1,X=21.15}
Anchors~f~2!{Y=54.82,GROW=2,BARS=1,FRAME=4,X=37.06}
Anchors~f~3!{Y=35.04,GROW=2,BARS=1,FRAME=1,X=34.09}
Anchors~f~4!{Y=34.19,GROW=2,BARS=1,FRAME=1,X=33.56}
Anchors~f~5!{Y=33.35,GROW=2,BARS=1,FRAME=1,X=33.03}
Anchors~f~6!{Y=32.5,GROW=2,BARS=1,FRAME=1,X=32.5}
Anchors~f~7!{Y=31.65,GROW=2,BARS=1,FRAME=1,X=31.97}
Anchors~f~8!{Y=54.82,GROW=2,BARS=1,FRAME=3,X=21.15}
Anchors~f~9!{Y=29.96,GROW=2,BARS=1,FRAME=1,X=30.91}
Anchors~f~10!{Y=29.11,GROW=2,BARS=1,FRAME=1,X=30.38}
HeadBar~f~1!{SHOW="true",TEXTURE="HealBot 10",A=0.4,B=0.1,HEIGHT=12,R=0.1,G=0.7,WIDTH=0.95}
HeadBar~f~2!{A=0.4,WIDTH=0.7,SHOW="false",B=0.1,HEIGHT=12,R=0.1,G=0.7,TEXTURE="HealBot 10"}
HeadBar~f~3!{SHOW="true",TEXTURE="HealBot 10",A=0.4,B=0.1,HEIGHT=12,R=0.1,G=0.7,WIDTH=0.69999998807907}
HeadBar~d!4~5~6~7~
HeadBar~f~8!{SHOW="true",TEXTURE="HealBot 10",A=0.4,B=0.1,HEIGHT=12,R=0.1,G=0.7,WIDTH=0.95}
HeadBar~f~9!{SHOW="true",TEXTURE="HealBot 10",A=0.4,B=0.1,HEIGHT=12,R=0.1,G=0.7,WIDTH=0.69999998807907}
HeadBar~f~10!{SHOW="true",TEXTURE="HealBot 10",A=0.4,B=0.1,HEIGHT=12,R=0.1,G=0.7,WIDTH=0.7}
HeadText~f~1!{A=1,R=1,OFFSET=1,B=1,HEIGHT=9,FONT="Friz Quadrata TT",G=1,OUTLINE=1}
HeadText~f~2!{A=0.74,B=1,OFFSET=0,R=1,HEIGHT=9,FONT="Friz Quadrata TT",G=1,OUTLINE=1}
HeadText~d!3~4~5~6~7~
HeadText~f~8!{A=1,B=1,OFFSET=1,R=1,HEIGHT=9,FONT="Friz Quadrata TT",G=1,OUTLINE=1}
HeadText~f~9!{A=0.74,B=1,OFFSET=0,R=1,HEIGHT=9,FONT="Friz Quadrata TT",G=1,OUTLINE=1}
HeadText~d!10~
HealBar~f~1!{HEIGHT=24,GRPCOLS="false",CMARGIN=2,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",RMARGIN=1,NUMCOLS=2,OFIX=1,WIDTH=110,LOWMANA=1}
HealBar~f~2!{HEIGHT=25,GRPCOLS="false",CMARGIN=2,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=1,WIDTH=148,OFIX=1,NUMCOLS=3,RMARGIN=1}
HealBar~f~3!{HEIGHT=24,GRPCOLS="false",CMARGIN=2,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=1,WIDTH=110,OFIX=1,NUMCOLS=2,RMARGIN=1}
HealBar~d!4~5~6~7~8~9~10~
BarCol~f~1!{BACK=1,BA=0,BOUT=0,DISA=0.05,BR=0.4,HB=1,BG=0.7,BB=0.7,HA=1,HR=0.4,ORA=0.4,HG=0.4,HLTH=1}
BarCol~d!2~3~4~5~6~7~8~9~10~
BarIACol~f~1!{AC=4,AB=1,AA=0.28,AR=1,AG=1,IC=3,IB=0.4,IA=0.28,IR=0.4,IG=0.8}
BarIACol~d!2~3~4~5~6~7~8~9~10~
BarText~f~1!{HLTHONBAR="true",TAGOOR="[ OOR ] ",OVERHEAL=1,MAXCHARS=0,HMAXCHARS=0,TAGRIP="[ RIP ] ",OUTLINE=1,FONT="Friz Quadrata TT",INCHEALS=2,HLTHTXTANCHOR=1,HLTHTYPE=2,IGNOREONFULL="true",CLASSONBAR="false",NUMFORMAT2=1,HHEIGHT=10,NUMFORMAT1=11,TAGDC="[ DC ] ",NAMEONBAR="true",HEIGHT=10,HFONT="Friz Quadrata TT",SHOWROLE="true",HALIGN=2,OFFSET=0,HOUTLINE=1,INCABSORBS=1,HOFFSET2=0,ALIGN=2,TAGR="[ R ] ",HOFFSET=2}
BarText~d!2~3~4~5~6~7~8~9~10~
BarTextCol~f~1!{HCG=1,NCR=1,NCB=0,NCDA=0.5,NAME=2,NDEBUFF="false",HCB=0,HCR=1,HCA=1,NCG=1,NCA=1,HDEBUFF="false",HLTH=2,HCDA=0.5}
BarTextCol~d!2~3~4~5~6~7~8~9~10~
Icons~f~1!{RCEN="true",I15EN="true",CLASSEN="false",FADE="false",BUFFFADE="false",DEBUFFANCHOR=1,RCVOFFSET=-5,OORVOFFSET=0,DEBUFFDOUBLE="true",TARGETVOFFSET=0,BUFFONBAR=1,SHOWDIR="false",SHOWRC="true",TARGETANCHOR=3,RCSCALE=0.8,MAXBICONS=8,FADESECS=15,RCHOFFSET=30,TARGETHOFFSET=0,RCANCHOR=1,CLASSVOFFSET=0,TARGETEN="true",DSCALE=1,TARGETSCALE=0.5,BUFFANCHOR=2,BUFFDOUBLE="true",OORONBAR=3,SCALE=0.7,SHOWDIRMOUSE="false",OORANCHOR=1,SHOWCLASS="false",RCONBAR=3,MAXDICONS=4,CLASSSCALE=0.5,SHOWROLE="false",CLASSANCHOR=1,CLASSHOFFSET=0,DEBUFFONBAR=1,CLASSONBAR=1,BUFFI15EN="true",BUFFFADESECS=15,OORSCALE=0.5,TARGETONBAR=3,OOREN="false",OORHOFFSET=0}
Icons~f~2!{RCEN="true",I15EN="true",CLASSEN="false",SHOWDIRMOUSE="false",BUFFFADE="false",DEBUFFANCHOR=1,RCVOFFSET=-5,OORVOFFSET=0,DEBUFFDOUBLE="true",TARGETVOFFSET=0,BUFFONBAR=1,SHOWDIR="false",SHOWRC="true",TARGETANCHOR=3,RCSCALE=0.8,MAXBICONS=8,FADESECS=15,RCHOFFSET=30,TARGETHOFFSET=0,RCANCHOR=1,CLASSVOFFSET=0,TARGETEN="true",DSCALE=1,TARGETSCALE=0.5,BUFFANCHOR=2,BUFFDOUBLE="true",TARGETONBAR=3,FADE="false",OORONBAR=3,OORANCHOR=1,SHOWCLASS="false",RCONBAR=3,MAXDICONS=3,CLASSSCALE=0.5,SHOWROLE="false",CLASSANCHOR=1,CLASSHOFFSET=0,DEBUFFONBAR=1,CLASSONBAR=1,BUFFI15EN="true",BUFFFADESECS=15,OORSCALE=0.5,SCALE=1,OOREN="false",OORHOFFSET=0}
Icons~d!3~4~5~6~7~8~9~10~
RaidIcon~f~1!{SQUARE="true",CIRCLE="true",DIAMOND="true",SHOW="true",SKULL="true",TRIANGLE="true",STAR="true",MOON="true",CROSS="true"}
RaidIcon~d!2~3~4~5~6~7~8~9~10~
IconText~f~1!{SDUR="true",BUFFHEIGHT=8,BUFFOUTLINE=2,BUFFDURTHRH=9,SCNT="true",DURTHRH=9,FONT="Friz Quadrata TT",BUFFFONT="Friz Quadrata TT",BUFFSCNT="true",SSCNT="false",OUTLINE=2,BUFFDURWARN=3,HEIGHT=8,DURWARN=3,BUFFSSDUR="true",BUFFSSCNT="false",SSDUR="true",BUFFSDUR="true"}
IconText~d!2~3~4~5~6~7~8~9~10~
BarVisibility~f~1!{INCCLASSES=1,ALERTIC=1,ALERTOC=0.9,HIDEOOR="false"}
BarVisibility~f~2!{INCCLASSES=1,ALERTIC=1,ALERTOC=0.95,HIDEOOR="false"}
BarVisibility~d!3~4~5~6~7~8~9~10~
BarSort~f~1!{SUBORDER=1,OORLAST="false",RAIDORDER=3,SUBPF="true"}
BarSort~d!2~3~4~5~6~7~8~9~10~
BarAggro~f~1!{B=0,ALERTIND=2,G=0,TEXTFORMAT=3,SHOW="true",SHOWTEXTPCT="true",SHOWIND="true",SHOWTEXT="true",R=1,ALERT=2}
BarAggro~d!2~3~4~5~6~7~8~9~10~
AuxBarFrame~f~1!{OVERLAP=1}
AuxBarFrame~d!2~3~4~5~6~7~8~9~10~
AuxBar^1~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,OTYPE=1}
AuxBar^1~d!2~3~4~5~6~7~8~9~10~
AuxBar^2~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,OTYPE=1}
AuxBar^2~d!2~3~4~5~6~7~8~9~10~
AuxBar^3~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,OTYPE=1}
AuxBar^3~d!2~3~4~5~6~7~8~9~10~
AuxBar^4~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,OTYPE=1}
AuxBar^4~d!2~3~4~5~6~7~8~9~10~
AuxBar^5~f~1!{SIZE=0.98,USE=4,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=3,G=1,B=1,OTYPE=1}
AuxBar^5~d!2~3~4~5~6~7~8~9~10~
AuxBar^6~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,OTYPE=1}
AuxBar^6~d!2~3~4~5~6~7~8~9~10~
AuxBar^7~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,OTYPE=1}
AuxBar^7~d!2~3~4~5~6~7~8~9~10~
AuxBar^8~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,OTYPE=1}
AuxBar^8~d!2~3~4~5~6~7~8~9~10~
AuxBar^9~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,OTYPE=1}
AuxBar^9~d!2~3~4~5~6~7~8~9~10~
Complete!]]
HealBot_ExtraSkinData[16]=[[Skin
Magic
Author~v!Monti of Terenas
DuplicateBars~v!false
Chat~t!{EOCOOM="false",EOCOOMV=20,MSG="Casting #s on #n",RESONLY="true",CHAN="",NOTIFY=1}
General~t!{FLUIDFREQ=10,STICKYSENSITIVITY=30,FLUIDBARS="false",OMAX=0.95,HIDEPTF="false",HIDEPARTYF="true",HIDERAIDF="true",OFREQ=0.07,STICKYFRAME="true",OMIN=0.1,HIDEBOSSF="true"}
Healing~t!{TINCRAID="true",TINCSELF="false",GROUPPETS="true",TARGETINCOMBAT=2,TINCGROUP="true",FONLYFRIEND="false",FEXRAID="false",TONLYFRIEND="false",FALWAYSSHOW="false",FOCUSINCOMBAT=2,TALWAYSSHOW="false",SELFPET=0,TINCPET="false",TEXRAID="false",ALERT=0.88}
Enemy~t!{USE=0,INCARENA="true",INCTANKS="true",INCMYTAR="false",ENEMYTARGET="false",INCARENAPETS="false",ENEMYTARGETSIZE=40,INCSELF="true",NUMBOSS=2,EXISTSHOWPTAR=2,HIDE="true",EXISTSHOWBOSS="false",DOUBLEWIDTH="false",EXISTSHOWARENA=3}
FrameAlias~f~1!{SIZE=12,NAME="",R=1,ALIAS="OneFrame",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~2!{SIZE=12,NAME="",R=1,ALIAS="Not Used 1",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~3!{SIZE=12,NAME="",R=1,ALIAS="Not Used 2",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~4!{SIZE=12,NAME="",R=1,ALIAS="Not Used 3",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~5!{SIZE=12,NAME="",R=1,ALIAS="Not Used 4",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~6!{SIZE=12,NAME="",R=1,ALIAS="Vehicle",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~7!{SIZE=12,NAME="",R=1,ALIAS="Pets",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~8!{SIZE=12,NAME="",R=1,ALIAS="Target",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~9!{SIZE=12,NAME="",R=1,ALIAS="Focus",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~10!{SIZE=12,NAME="",R=1,ALIAS="Enemy",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAliasBar~f~1!{A=0.5,TEXTURE="HealBot 10",B=0.25,HEIGHT=20,R=0.1,G=0.25,WIDTH=0.7}
FrameAliasBar~d!2~3~4~5~6~7~8~9~10~
Frame~f~1!{SFOFFSETH=0,BACKR=0.063,TIPLOC=5,BACKB=0.22,LOCKED="false",OPENSOUND="false",BORDERA=0.25,BORDERG=0.2,AUTOCLOSE="false",BORDERB=0.2,BACKA=0.6,SCALE=1,BACKG=0.063,BORDERR=0.2,SFOFFSETV=0}
Frame~d!2~3~4~5~6~7~8~9~10~
StickyFrames~f~1!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~d!2~3~4~5~6~7~
StickyFrames~f~8!{STUCK="true",STUCKTOPOINT="TOPLEFT",STUCKTO=1,STUCKPOINT="TOPRIGHT"}
StickyFrames~f~9!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~d!10~
HealGroups~f~1!{FRAME=1,STATE="false",NAME="Self"}
HealGroups~f~2!{FRAME=1,STATE="true",NAME="Main tanks"}
HealGroups~f~3!{FRAME=1,STATE="false",NAME="Healers"}
HealGroups~f~4!{FRAME=1,STATE="true",NAME="Group"}
HealGroups~f~5!{FRAME=1,STATE="true",NAME="Private List"}
HealGroups~f~6!{FRAME=1,STATE="true",NAME="Raid"}
HealGroups~f~7!{FRAME=1,STATE="false",NAME="Vehicle"}
HealGroups~f~8!{FRAME=1,STATE="false",NAME="Pets"}
HealGroups~f~9!{FRAME=8,STATE="true",NAME="Target"}
HealGroups~f~10!{FRAME=9,STATE="false",NAME="Focus"}
HealGroups~f~11!{FRAME=10,STATE="false",NAME="Enemy"}
Anchors~f~1!{Y=70.4,GROW=2,BARS=3,FRAME=3,X=95.88}
Anchors~f~2!{Y=79.05,GROW=2,BARS=3,FRAME=3,X=18.43}
Anchors~f~3!{Y=78.2,GROW=2,BARS=3,FRAME=3,X=17.9}
Anchors~f~4!{Y=77.36,GROW=2,BARS=3,FRAME=3,X=17.37}
Anchors~f~5!{Y=76.51,GROW=2,BARS=3,FRAME=3,X=16.84}
Anchors~f~6!{Y=75.66,GROW=2,BARS=3,FRAME=3,X=16.31}
Anchors~f~7!{Y=74.82,GROW=2,BARS=3,FRAME=3,X=15.78}
Anchors~f~8!{Y=70.4,GROW=2,BARS=3,FRAME=3,X=77.25}
Anchors~f~9!{Y=73.13,GROW=2,BARS=3,FRAME=3,X=14.73}
Anchors~f~10!{Y=72.28,GROW=2,BARS=3,FRAME=3,X=14.2}
HeadBar~f~1!{A=0.4,TEXTURE="HealBot 10",SHOW="false",B=0.502,HEIGHT=15,R=0.702,G=0.502,WIDTH=0.95}
HeadBar~d!2~3~4~5~6~7~8~9~10~
HeadText~f~1!{A=0.8,B=1,OFFSET=0,R=1,HEIGHT=10,FONT="Friz Quadrata TT",G=1,OUTLINE=1}
HeadText~d!2~3~4~5~6~7~8~9~10~
HealBar~f~1!{HEIGHT=32,GRPCOLS="false",CMARGIN=4,TEXTURE="Smooth",POWERCNT="true",LOWMANACOMBAT="true",RMARGIN=0,NUMCOLS=3,OFIX=1,WIDTH=172,LOWMANA=2}
HealBar~d!2~3~4~5~6~7~8~9~10~
BarCol~f~1!{BACK=2,BA=0.15,BB=0.702,DISA=0.15,BR=0.4,HB=0,BG=0.702,HG=0,HA=0.98,HR=0,ORA=0.43,BOUT=0,HLTH=1}
BarCol~d!2~3~4~5~6~7~8~9~10~
BarIACol~f~1!{AC=3,AB=1,AA=0.52,AR=1,AG=1,IC=3,IB=0.102,IA=0.4,IR=0.102,IG=1}
BarIACol~d!2~3~4~5~6~7~8~9~10~
BarText~f~1!{HLTHONBAR="true",TAGOOR="[ OOR ] ",OVERHEAL=1,MAXCHARS=0,HMAXCHARS=0,TAGRIP="[ RIP ] ",OUTLINE=1,HLTHTYPE=1,INCHEALS=2,HLTHTXTANCHOR=1,FONT="Friz Quadrata TT",IGNOREONFULL="true",CLASSONBAR="false",NUMFORMAT2=1,HHEIGHT=10,NUMFORMAT1=1,TAGDC="[ DC ] ",NAMEONBAR="true",HEIGHT=10,HFONT="Friz Quadrata TT",SHOWROLE="true",HALIGN=2,OFFSET=0,HOUTLINE=1,INCABSORBS=1,HOFFSET2=0,ALIGN=2,TAGR="[ R ] ",HOFFSET=0}
BarText~d!2~3~4~5~6~7~8~9~10~
BarTextCol~f~1!{HCG=1,NCR=1,NCB=0,NCDA=0.4,NAME=2,NDEBUFF="false",HCB=0,HCR=1,HCA=1,NCG=1,NCA=1,HDEBUFF="false",HLTH=2,HCDA=0.4}
BarTextCol~d!2~3~4~5~6~7~8~9~10~
Icons~f~1!{RCEN="true",I15EN="true",CLASSEN="false",FADE="false",BUFFFADE="false",DEBUFFANCHOR=1,RCVOFFSET=-4,OORVOFFSET=0,DEBUFFDOUBLE="true",TARGETVOFFSET=0,BUFFONBAR=1,SHOWDIR="false",SHOWRC="true",TARGETANCHOR=5,RCSCALE=0.8,MAXBICONS=8,FADESECS=15,RCHOFFSET=0,TARGETHOFFSET=25,RCANCHOR=3,CLASSVOFFSET=0,TARGETEN="true",DSCALE=0.9,TARGETSCALE=0.5,BUFFANCHOR=2,BUFFDOUBLE="true",OORONBAR=3,SCALE=0.9,SHOWDIRMOUSE="false",OORANCHOR=1,SHOWCLASS="false",RCONBAR=3,MAXDICONS=4,CLASSSCALE=0.5,SHOWROLE="false",CLASSANCHOR=1,CLASSHOFFSET=0,DEBUFFONBAR=1,CLASSONBAR=1,BUFFI15EN="false",BUFFFADESECS=15,OORSCALE=0.5,TARGETONBAR=3,OOREN="false",OORHOFFSET=0}
Icons~f~2!{RCEN="true",I15EN="true",CLASSEN="false",SHOWDIRMOUSE="false",BUFFFADE="false",DEBUFFANCHOR=1,RCVOFFSET=-4,OORVOFFSET=0,DEBUFFDOUBLE="true",TARGETVOFFSET=0,BUFFONBAR=1,SHOWDIR="false",SHOWRC="true",TARGETANCHOR=5,RCSCALE=0.8,MAXBICONS=8,FADESECS=15,RCHOFFSET=0,TARGETHOFFSET=25,RCANCHOR=3,CLASSVOFFSET=0,TARGETEN="true",DSCALE=0.9,TARGETSCALE=0.5,BUFFANCHOR=2,BUFFDOUBLE="true",TARGETONBAR=3,FADE="false",OORONBAR=3,OORANCHOR=1,SHOWCLASS="false",RCONBAR=3,MAXDICONS=3,CLASSSCALE=0.5,SHOWROLE="false",CLASSANCHOR=1,CLASSHOFFSET=0,DEBUFFONBAR=1,CLASSONBAR=1,BUFFI15EN="false",BUFFFADESECS=15,OORSCALE=0.5,SCALE=0.9,OOREN="false",OORHOFFSET=0}
Icons~d!3~4~5~6~7~8~9~10~
RaidIcon~f~1!{SQUARE="true",CIRCLE="true",DIAMOND="true",SHOW="true",MOON="true",TRIANGLE="true",STAR="true",CROSS="true",SKULL="true"}
RaidIcon~d!2~3~4~5~6~7~8~9~10~
IconText~f~1!{SDUR="true",BUFFHEIGHT=8,BUFFOUTLINE=2,BUFFDURTHRH=9,SCNT="true",DURTHRH=9,FONT="Friz Quadrata TT",BUFFFONT="Friz Quadrata TT",BUFFSCNT="true",SSCNT="false",OUTLINE=2,BUFFDURWARN=3,HEIGHT=8,DURWARN=3,BUFFSSDUR="true",BUFFSSCNT="false",SSDUR="true",BUFFSDUR="true"}
IconText~d!2~3~4~5~6~7~8~9~10~
BarVisibility~f~1!{INCCLASSES=1,ALERTIC=0.98,ALERTOC=0.88,HIDEOOR="false"}
BarVisibility~d!2~3~4~5~6~7~8~9~10~
BarSort~f~1!{SUBORDER=5,OORLAST="false",RAIDORDER=2,SUBPF="true"}
BarSort~d!2~3~4~5~6~7~8~9~10~
BarAggro~f~1!{B=0,ALERTIND=2,G=0,TEXTFORMAT=3,SHOW="true",SHOWTEXTPCT="true",SHOWIND="true",SHOWTEXT="true",R=1,ALERT=2}
BarAggro~d!2~3~4~5~6~7~8~9~10~
AuxBarFrame~f~1!{OVERLAP=1}
AuxBarFrame~d!2~3~4~5~6~7~8~9~10~
AuxBar^1~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,OTYPE=1}
AuxBar^1~d!2~3~4~5~6~7~8~9~10~
AuxBar^2~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,OTYPE=1}
AuxBar^2~d!2~3~4~5~6~7~8~9~10~
AuxBar^3~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,OTYPE=1}
AuxBar^3~d!2~3~4~5~6~7~8~9~10~
AuxBar^4~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,OTYPE=1}
AuxBar^4~d!2~3~4~5~6~7~8~9~10~
AuxBar^5~f~1!{SIZE=1,USE=4,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=4,G=1,B=1,OTYPE=1}
AuxBar^5~d!2~3~4~5~6~7~8~9~10~
AuxBar^6~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,OTYPE=1}
AuxBar^6~d!2~3~4~5~6~7~8~9~10~
AuxBar^7~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,OTYPE=1}
AuxBar^7~d!2~3~4~5~6~7~8~9~10~
AuxBar^8~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,OTYPE=1}
AuxBar^8~d!2~3~4~5~6~7~8~9~10~
AuxBar^9~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,OTYPE=1}
AuxBar^9~d!2~3~4~5~6~7~8~9~10~
Complete!]]
HealBot_ExtraSkinData[17]=[[Skin
Standard Original
Author~v!Monti of Terenas
DuplicateBars~v!false
Chat~t!{EOCOOM="false",EOCOOMV=20,MSG="Casting #s on #n",RESONLY="true",CHAN="",NOTIFY=1}
General~t!{OFREQ=0.07,STICKYSENSITIVITY=30,FLUIDBARS="false",OMAX=0.95,HIDEPARTYF="false",HIDEPTF="false",HIDERAIDF="true",FLUIDFREQ=10,STICKYFRAME="false",OMIN=0.1,HIDEBOSSF="false"}
Healing~t!{TONLYFRIEND="false",FEXRAID="false",FOCUSINCOMBAT=2,GROUPPETS="true",SELFPET="false",FONLYFRIEND="false",TEXRAID="false",TARGETINCOMBAT=2}
Enemy~t!{INCARENA="true",INCTANKS="true",INCMYTAR="false",ENEMYTARGET="false",INCARENAPETS="false",ENEMYTARGETSIZE=40,HIDE="true",NUMBOSS=2,EXISTSHOWPTAR=1,INCSELF="false",EXISTSHOWBOSS="true",DOUBLEWIDTH="false",EXISTSHOWARENA=3}
FrameAlias~f~1!{SIZE=12,NAME="",R=1,ALIAS="Frame 1",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~d!2~3~4~5~
FrameAlias~f~6!{SIZE=12,NAME="Vehicle",R=1,ALIAS="Vehicle",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~7!{SIZE=12,NAME="Pets",R=1,ALIAS="Pets",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~8!{SIZE=12,NAME="Target",R=1,ALIAS="Target",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~9!{SIZE=12,NAME="Focus",R=1,ALIAS="Focus",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~10!{SIZE=12,NAME="Enemy",R=1,ALIAS="Enemy",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAliasBar~f~1!{A=0.4,TEXTURE="HealBot 10",B=0.1,HEIGHT=20,R=0.1,G=0.7,WIDTH=0.7}
FrameAliasBar~d!2~3~4~5~6~7~8~9~10~
Frame~f~1!{SFOFFSETH=0,BACKG=0.1,TIPLOC=5,BACKB=0.1,LOCKED="false",SCALE=1,BORDERA=0.2,SFOFFSETV=0,AUTOCLOSE="false",BORDERB=0.2,BACKA=0.05,OPENSOUND="false",BACKR=0.1,BORDERG=0.2,BORDERR=0.2}
Frame~d!2~3~4~5~6~7~8~9~10~
StickyFrames~f~1!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~d!2~3~4~5~6~7~8~9~10~
HealGroups~f~1!{FRAME=1,STATE="true",NAME="Self"}
HealGroups~f~2!{FRAME=1,STATE="true",NAME="Main tanks"}
HealGroups~f~3!{FRAME=1,STATE="false",NAME="Healers"}
HealGroups~f~4!{FRAME=1,STATE="true",NAME="Group"}
HealGroups~f~5!{FRAME=1,STATE="true",NAME="Raid"}
HealGroups~f~6!{FRAME=1,STATE="true",NAME="Private List"}
HealGroups~f~7!{FRAME=6,STATE="false",NAME="Vehicle"}
HealGroups~f~8!{FRAME=7,STATE="false",NAME="Pets"}
HealGroups~f~9!{FRAME=8,STATE="true",NAME="Target"}
HealGroups~f~10!{FRAME=9,STATE="false",NAME="Focus"}
HealGroups~f~11!{FRAME=10,STATE="false",NAME="Enemy"}
Anchors~f~1!{Y=61.41,GROW=2,BARS=3,FRAME=3,X=33.92}
Anchors~f~2!{Y=51,GROW=2,BARS=3,FRAME=3,X=51}
Anchors~f~3!{Y=52,GROW=2,BARS=3,FRAME=3,X=52}
Anchors~f~4!{Y=53,GROW=2,BARS=3,FRAME=3,X=53}
Anchors~f~5!{Y=54,GROW=2,BARS=3,FRAME=3,X=54}
Anchors~f~6!{Y=55,GROW=2,BARS=3,FRAME=3,X=55}
Anchors~f~7!{Y=56.74,GROW=2,BARS=3,FRAME=3,X=33.92}
Anchors~f~8!{Y=54.16,GROW=2,BARS=3,FRAME=3,X=23.04}
Anchors~f~9!{Y=65.99,GROW=2,BARS=3,FRAME=3,X=33.92}
Anchors~f~10!{Y=68.74,GROW=2,BARS=3,FRAME=3,X=34.76}
HeadBar~f~1!{SHOW="true",TEXTURE="HealBot 10",R=0.1,B=0.1,HEIGHT=20,A=0.4,G=0.7,WIDTH=0.7}
HeadBar~d!2~3~4~5~6~7~8~9~10~
HeadText~f~1!{A=0.74,R=1,OFFSET=0,B=1,FONT="Friz Quadrata TT",HEIGHT=9,G=1,OUTLINE=1}
HeadText~d!2~3~4~5~6~7~8~9~10~
HealBar~f~1!{HEIGHT=25,GRPCOLS="false",CMARGIN=2,TEXTURE="Smooth",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=144,RMARGIN=1,OFIX=1,NUMCOLS=2,LOWMANA=2}
HealBar~d!2~3~4~5~6~7~8~9~10~
BarCol~f~1!{BACK=1,BA=0,BB=0.7,DISA=0.1,BR=0.4,HB=0.7,BG=0.4,HG=0.4,HA=1,HR=0.4,ORA=0.4,BOUT=2,HLTH=1}
BarCol~d!2~3~4~5~6~7~8~9~10~
BarIACol~f~1!{AC=3,AB=1,AA=0.78,AR=1,AG=1,IC=2,IB=0.2,IA=0.82,IR=0.2,IG=1}
BarIACol~d!2~3~4~5~6~7~8~9~10~
BarText~f~1!{HHEIGHT=10,TAGOOR="[ OOR ] ",IGNOREONFULL="true",MAXCHARS=0,HMAXCHARS=0,TAGRIP="[ RIP ] ",HOFFSET=0,HOUTLINE=1,INCHEALS=2,HLTHTXTANCHOR=1,HLTHTYPE=1,OFFSET=0,CLASSONBAR="false",NUMFORMAT2=1,OVERHEAL=1,TAGDC="[ DC ] ",HLTHONBAR="true",NAMEONBAR="true",HEIGHT=10,FONT="Friz Quadrata TT",SHOWROLE="true",HALIGN=2,HFONT="Friz Quadrata TT",NUMFORMAT1=11,INCABSORBS=1,HOFFSET2=0,ALIGN=2,TAGR="[ R ] ",OUTLINE=1}
BarText~d!2~3~4~5~6~7~8~9~10~
BarTextCol~f~1!{NCB=0,NCR=1,HCG=1,NCDA=0.8,NAME=2,HCA=1,NCG=1,HCR=1,NDEBUFF="false",HCB=0,NCA=1,HDEBUFF="false",HCDA=0.8,HLTH=2}
BarTextCol~d!2~3~4~5~6~7~8~9~10~
Icons~f~1!{RCEN="true",I15EN="true",CLASSEN="false",TARGETEN="true",BUFFFADE="true",DEBUFFANCHOR=1,RCVOFFSET=0,OORVOFFSET=0,DEBUFFDOUBLE="false",TARGETVOFFSET=0,BUFFONBAR=1,SHOWDIR="true",SHOWRC="true",TARGETANCHOR=5,RCSCALE=0.7,MAXBICONS=8,BUFFDOUBLE="false",FADESECS=15,RCHOFFSET=0,TARGETHOFFSET=15,RCANCHOR=3,CLASSVOFFSET=0,BUFFANCHOR=2,DSCALE=0.55,CLASSONBAR=1,FADE="false",SCALE=0.55,OORONBAR=3,OORANCHOR=1,TARGETONBAR=3,SHOWDIRMOUSE="false",DOUBLE="false",RCONBAR=3,MAXDICONS=3,CLASSSCALE=0.5,CLASSANCHOR=1,SHOWCLASS="false",CLASSHOFFSET=0,DEBUFFONBAR=1,SHOWROLE="false",BUFFI15EN="true",BUFFFADESECS=15,OORSCALE=0.5,TARGETSCALE=0.5,OOREN="false",OORHOFFSET=0}
Icons~d!2~3~4~5~6~7~8~9~10~
RaidIcon~f~1!{SQUARE="true",CIRCLE="true",DIAMOND="true",SHOW="true",SKULL="true",TRIANGLE="true",STAR="true",CROSS="true",MOON="true"}
RaidIcon~d!2~3~4~5~6~7~8~9~10~
IconText~f~1!{DURWARN=3,BUFFHEIGHT=10,BUFFOUTLINE=2,BUFFDURTHRH=9,SCNT="true",DURTHRH=9,FONT="Friz Quadrata TT",BUFFFONT="Friz Quadrata TT",BUFFSCNT="true",SSCNT="false",OUTLINE=2,BUFFDURWARN=3,HEIGHT=10,SDUR="true",BUFFSSDUR="true",BUFFSSCNT="false",SSDUR="true",BUFFSDUR="true"}
IconText~d!2~3~4~5~6~7~8~9~10~
BarVisibility~f~1!{INCCLASSES=1,ALERTIC=0.98,ALERTOC=0.95,HIDEOOR="false"}
BarVisibility~d!2~3~4~5~6~7~8~9~10~
BarSort~f~1!{SUBORDER=1,OORLAST="false",RAIDORDER=3,SUBPF="true"}
BarSort~d!2~3~4~5~6~7~8~9~10~
BarAggro~f~1!{B=0,SHOWIND="true",G=0,TEXTFORMAT=3,SHOW="true",SHOWTEXTPCT="true",ALERTIND=2,R=1,SHOWTEXT="false",ALERT=3}
BarAggro~d!2~3~4~5~6~7~8~9~10~
AuxBarFrame~f~1!{OVERLAP=1}
AuxBarFrame~d!2~3~4~5~6~7~8~9~10~
AuxBar^1~f~1!{SIZE=0.98,USE=1,B=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,OTYPE=1,G=1,R=1}
AuxBar^1~d!2~3~4~5~6~7~8~9~10~
AuxBar^2~f~1!{SIZE=0.98,USE=1,B=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,OTYPE=1,G=1,R=1}
AuxBar^2~d!2~3~4~5~6~7~8~9~10~
AuxBar^3~f~1!{SIZE=0.98,USE=1,B=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,OTYPE=1,G=1,R=1}
AuxBar^3~d!2~3~4~5~6~7~8~9~10~
AuxBar^4~f~1!{SIZE=0.98,USE=1,B=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,OTYPE=1,G=1,R=1}
AuxBar^4~d!2~3~4~5~6~7~8~9~10~
AuxBar^5~f~1!{SIZE=0.98,USE=5,B=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=1,OTYPE=2,G=1,R=1}
AuxBar^5~d!2~3~4~5~6~7~8~9~
AuxBar^5~f~10!{SIZE=0.98,USE=1,B=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=1,OTYPE=2,G=1,R=1}
AuxBar^6~f~1!{SIZE=0.98,USE=5,B=1,COLOUR=1,ANCHOR=2,OFFSET=1,DEPTH=1,OTYPE=2,G=1,R=1}
AuxBar^6~d!2~3~4~5~6~7~8~9~
AuxBar^6~f~10!{SIZE=0.98,USE=1,B=1,COLOUR=1,ANCHOR=2,OFFSET=1,DEPTH=1,OTYPE=2,G=1,R=1}
AuxBar^7~f~1!{SIZE=0.98,USE=1,B=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,OTYPE=1,G=1,R=1}
AuxBar^7~d!2~3~4~5~6~7~8~9~10~
AuxBar^8~f~1!{SIZE=0.98,USE=1,B=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,OTYPE=1,G=1,R=1}
AuxBar^8~d!2~3~4~5~6~7~8~9~10~
AuxBar^9~f~1!{SIZE=0.98,USE=1,B=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,OTYPE=1,G=1,R=1}
AuxBar^9~d!2~3~4~5~6~7~8~9~10~
Complete!]]
HealBot_ExtraSkinData[18]=[[Skin
Group Original
Author~v!Monti of Terenas
DuplicateBars~v!false
Chat~t!{EOCOOM="false",EOCOOMV=20,MSG="Casting #s on #n",RESONLY="true",CHAN="",NOTIFY=1}
General~t!{HIDEBOSSF="false",STICKYSENSITIVITY=30,FLUIDBARS="true",OMAX=0.95,HIDEPTF="false",HIDEPARTYF="false",HIDERAIDF="true",FLUIDFREQ=10,STICKYFRAME="true",OMIN=0.1,OFREQ=0.07}
Healing~t!{TONLYFRIEND="false",TARGETINCOMBAT=2,FOCUSINCOMBAT=2,GROUPPETS="true",FEXRAID="false",TEXRAID="false",FONLYFRIEND="false",SELFPET="false"}
Enemy~t!{INCARENA="true",INCTANKS="true",INCMYTAR="false",ENEMYTARGET="false",INCARENAPETS="false",ENEMYTARGETSIZE=40,HIDE="true",NUMBOSS=2,EXISTSHOWPTAR=1,INCSELF="false",EXISTSHOWBOSS="true",DOUBLEWIDTH="false",EXISTSHOWARENA=3}
FrameAlias~f~1!{A=1,NAME="",R=1,ALIAS="Frame 1",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~d!2~3~4~5~
FrameAlias~f~6!{SIZE=12,NAME="Vehicle",R=1,ALIAS="Vehicle",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~7!{SIZE=12,NAME="Pets",R=1,ALIAS="Pets",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~8!{SIZE=12,NAME="Target",R=1,ALIAS="Target",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~9!{SIZE=12,NAME="Focus",R=1,ALIAS="Focus",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~10!{SIZE=12,NAME="Enemy",R=1,ALIAS="Enemy",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAliasBar~f~1!{A=0.25,WIDTH=0.9,B=0.1,HEIGHT=20,R=0.1,G=0.1,TEXTURE="Diagonal"}
FrameAliasBar~d!2~3~4~5~6~7~8~9~10~
Frame~f~1!{BACKR=0.1,BORDERR=0.1,BORDERG=0.1,SFOFFSETH=0,LOCKED="false",OPENSOUND="false",BORDERA=0.5,SFOFFSETV=0,TIPLOC=5,BACKB=0.5,BACKA=0.2,SCALE=1,BORDERB=0.1,BACKG=0.1,AUTOCLOSE="false"}
Frame~d!2~3~4~5~6~7~
Frame~f~8!{BORDERR=0.1,AUTOCLOSE="false",BACKG=0.1,BORDERB=0.1,LOCKED="false",SCALE=1,BORDERA=0.5,BORDERG=0.1,TIPLOC=5,BACKB=0.5,BACKA=0.2,OPENSOUND="false",SFOFFSETH=0,SFOFFSETV=-8,BACKR=0.1}
Frame~f~9!{BORDERR=0.1,AUTOCLOSE="false",BACKG=0.1,BORDERB=0.1,LOCKED="false",SCALE=1,BORDERA=0.5,BORDERG=0.1,TIPLOC=5,BACKB=0.5,BACKA=0.2,OPENSOUND="false",SFOFFSETH=0,SFOFFSETV=0,BACKR=0.1}
Frame~d!10~
StickyFrames~f~1!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~d!2~3~4~5~6~7~
StickyFrames~f~8!{STUCK="true",STUCKTOPOINT="TOPLEFT",STUCKTO=1,STUCKPOINT="BOTTOMLEFT"}
StickyFrames~f~9!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~d!10~
HealGroups~f~1!{FRAME=1,STATE="false",NAME="Self"}
HealGroups~f~2!{FRAME=1,STATE="true",NAME="Main tanks"}
HealGroups~f~3!{FRAME=1,STATE="false",NAME="Healers"}
HealGroups~f~4!{FRAME=1,STATE="true",NAME="Group"}
HealGroups~f~5!{FRAME=1,STATE="false",NAME="Raid"}
HealGroups~f~6!{FRAME=1,STATE="true",NAME="Private List"}
HealGroups~f~7!{FRAME=6,STATE="false",NAME="Vehicle"}
HealGroups~f~8!{FRAME=7,STATE="false",NAME="Pets"}
HealGroups~f~9!{FRAME=8,STATE="true",NAME="Target"}
HealGroups~f~10!{FRAME=9,STATE="false",NAME="Focus"}
HealGroups~f~11!{FRAME=10,STATE="false",NAME="Enemy"}
Anchors~f~1!{Y=64.91,GROW=2,BARS=1,FRAME=1,X=68.39}
Anchors~f~2!{Y=51,GROW=2,BARS=1,FRAME=1,X=51}
Anchors~f~3!{Y=52,GROW=2,BARS=1,FRAME=1,X=52}
Anchors~f~4!{Y=53,GROW=2,BARS=1,FRAME=1,X=53}
Anchors~f~5!{Y=54,GROW=2,BARS=1,FRAME=1,X=54}
Anchors~f~6!{Y=55,GROW=2,BARS=1,FRAME=1,X=55}
Anchors~f~7!{Y=35.66,GROW=2,BARS=1,FRAME=1,X=68.39}
Anchors~f~8!{Y=64.24,GROW=2,BARS=1,FRAME=2,X=68.39}
Anchors~f~9!{Y=69.49,GROW=2,BARS=1,FRAME=1,X=68.81}
Anchors~f~10!{Y=72.99,GROW=2,BARS=1,FRAME=1,X=68.39}
HeadBar~f~1!{SHOW="false",WIDTH=0.9,B=0.1,R=0.1,HEIGHT=20,A=0.25,G=0.1,TEXTURE="Diagonal"}
HeadBar~d!2~3~4~5~6~7~8~9~10~
HeadText~f~1!{A=0.7,B=0.1,OFFSET=0,R=1,FONT="Friz Quadrata TT",HEIGHT=10,G=1,OUTLINE=1}
HeadText~d!2~3~4~5~6~7~8~9~10~
HealBar~f~1!{HEIGHT=28,GRPCOLS="true",CMARGIN=4,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=2,NUMCOLS=4,OFIX=1,RMARGIN=0,WIDTH=158}
HealBar~d!2~3~4~5~6~7~8~9~10~
BarCol~f~1!{BACK=1,BA=0.1,BOUT=1,DISA=0.05,BR=1,HB=1,BG=1,BB=1,HA=0.98,HG=1,ORA=0.35,HR=1,HLTH=1}
BarCol~f~2!{BACK=1,BA=0.1,BOUT=2,DISA=0.05,BR=1,HB=1,BG=1,HR=1,HA=0.98,HG=1,ORA=0.35,BB=1,HLTH=1}
BarCol~d!3~4~5~6~7~8~9~10~
BarIACol~f~1!{AC=3,AB=1,AA=0.7,AR=1,AG=1,IC=3,IB=0.4,IA=0.75,IR=0.4,IG=1}
BarIACol~d!2~3~4~5~6~7~8~9~10~
BarText~f~1!{HHEIGHT=10,TAGOOR="[ OOR ] ",IGNOREONFULL="true",MAXCHARS=0,HMAXCHARS=0,OFFSET=1,HOFFSET=1,OUTLINE=1,INCHEALS=2,HLTHTXTANCHOR=1,FONT="Friz Quadrata TT",OVERHEAL=1,HOUTLINE=1,NUMFORMAT2=1,HLTHTYPE=1,NUMFORMAT1=11,HLTHONBAR="true",TAGRIP="[ RIP ] ",HEIGHT=10,TAGDC="[ DC ] ",SHOWROLE="true",HALIGN=2,NAMEONBAR="true",CLASSONBAR="false",INCABSORBS=1,HOFFSET2=0,ALIGN=2,TAGR="[ R ] ",HFONT="Friz Quadrata TT"}
BarText~d!2~3~4~5~6~7~8~9~10~
BarTextCol~f~1!{NCB=0,NCR=1,HCG=1,NCDA=0.8,NAME=2,NDEBUFF="false",NCG=1,NCA=1,HCA=1,HCB=0,HCR=1,HDEBUFF="false",HCDA=0.8,HLTH=2}
BarTextCol~d!2~3~4~5~6~7~8~9~10~
Icons~f~1!{RCEN="true",I15EN="true",CLASSEN="false",TARGETEN="true",BUFFFADE="true",DEBUFFANCHOR=1,RCVOFFSET=-2,OORVOFFSET=0,DEBUFFDOUBLE="false",TARGETVOFFSET=0,BUFFONBAR=1,SHOWDIR="true",SHOWRC="true",TARGETANCHOR=5,RCSCALE=0.75,MAXBICONS=8,BUFFDOUBLE="false",FADESECS=15,RCHOFFSET=0,TARGETHOFFSET=20,RCANCHOR=3,CLASSVOFFSET=0,BUFFANCHOR=2,DSCALE=0.55,CLASSONBAR=1,OORANCHOR=1,SCALE=0.55,OORONBAR=3,SHOWDIRMOUSE="false",TARGETONBAR=3,FADE="true",DOUBLE="false",RCONBAR=3,MAXDICONS=3,CLASSSCALE=0.5,CLASSANCHOR=1,SHOWCLASS="false",CLASSHOFFSET=0,DEBUFFONBAR=1,SHOWROLE="false",BUFFI15EN="true",BUFFFADESECS=15,OORSCALE=0.5,TARGETSCALE=0.5,OOREN="false",OORHOFFSET=0}
Icons~d!2~3~4~5~6~7~8~9~10~
RaidIcon~f~1!{SQUARE="true",CIRCLE="true",DIAMOND="true",SHOW="true",MOON="true",TRIANGLE="true",STAR="true",SKULL="true",CROSS="true"}
RaidIcon~d!2~3~4~5~6~7~8~9~10~
IconText~f~1!{DURWARN=3,BUFFHEIGHT=10,BUFFOUTLINE=2,BUFFDURTHRH=9,SCNT="true",DURTHRH=9,FONT="Friz Quadrata TT",BUFFFONT="Friz Quadrata TT",BUFFSCNT="true",SSCNT="false",OUTLINE=2,BUFFDURWARN=3,HEIGHT=10,SDUR="true",BUFFSSDUR="true",BUFFSSCNT="false",SSDUR="true",BUFFSDUR="true"}
IconText~d!2~3~4~5~6~7~8~9~10~
BarVisibility~f~1!{INCCLASSES=1,ALERTIC=1,ALERTOC=0.95,HIDEOOR="false"}
BarVisibility~d!2~3~4~5~6~7~8~9~10~
BarSort~f~1!{SUBORDER=1,OORLAST="false",RAIDORDER=3,SUBPF="true"}
BarSort~d!2~3~4~5~6~7~8~9~10~
BarAggro~f~1!{B=0,SHOWTEXT="false",G=0,TEXTFORMAT=3,SHOW="true",SHOWTEXTPCT="true",ALERTIND=2,R=1,SHOWIND="true",ALERT=3}
BarAggro~d!2~3~4~5~6~7~8~9~10~
AuxBarFrame~f~1!{OVERLAP=1}
AuxBarFrame~d!2~3~4~5~6~7~8~9~10~
AuxBar^1~f~1!{SIZE=1,USE=4,R=1,COLOUR=1,ANCHOR=1,OFFSET=0,DEPTH=3,OTYPE=1,B=1,G=1}
AuxBar^1~d!2~3~4~5~6~7~8~9~10~
AuxBar^2~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,OTYPE=1,B=1,G=1}
AuxBar^2~d!2~3~4~5~6~7~8~9~10~
AuxBar^3~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,OTYPE=1,B=1,G=1}
AuxBar^3~d!2~3~4~5~6~7~8~9~10~
AuxBar^4~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,OTYPE=1,B=1,G=1}
AuxBar^4~d!2~3~4~5~6~7~8~9~10~
AuxBar^5~f~1!{SIZE=1,USE=5,R=1,COLOUR=1,ANCHOR=3,OFFSET=0,DEPTH=2,OTYPE=1,B=1,G=1}
AuxBar^5~d!2~3~4~5~6~7~8~9~
AuxBar^5~f~10!{SIZE=1,USE=1,R=1,COLOUR=1,ANCHOR=3,OFFSET=0,DEPTH=2,OTYPE=1,B=1,G=1}
AuxBar^6~f~1!{SIZE=1,USE=5,R=1,COLOUR=1,ANCHOR=4,OFFSET=0,DEPTH=2,OTYPE=1,B=1,G=1}
AuxBar^6~d!2~3~4~5~6~7~8~9~
AuxBar^6~f~10!{SIZE=1,USE=1,R=1,COLOUR=1,ANCHOR=4,OFFSET=0,DEPTH=2,G=1,B=1,OTYPE=1}
AuxBar^7~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,OTYPE=1,B=1,G=1}
AuxBar^7~d!2~3~4~5~6~7~8~9~10~
AuxBar^8~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,OTYPE=1,B=1,G=1}
AuxBar^8~d!2~3~4~5~6~7~8~9~10~
AuxBar^9~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,OTYPE=1,B=1,G=1}
AuxBar^9~d!2~3~4~5~6~7~8~9~10~
Complete!]]
HealBot_ExtraSkinData[19]=[[Skin
Raid Original
Author~v!Monti of Terenas
DuplicateBars~v!false
Chat~t!{EOCOOM="false",EOCOOMV=20,MSG="Casting #s on #n",RESONLY="true",CHAN="",NOTIFY=1}
General~t!{HIDEBOSSF="false",STICKYSENSITIVITY=30,FLUIDBARS="false",FLUIDFREQ=10,HIDEPTF="false",OMIN=0.1,STICKYFRAME="true",OFREQ=0.07,HIDERAIDF="true",OMAX=0.95,HIDEPARTYF="false"}
Healing~t!{TONLYFRIEND="false",TARGETINCOMBAT=2,FOCUSINCOMBAT=2,GROUPPETS="true",FEXRAID="false",TEXRAID="false",FONLYFRIEND="false",SELFPET="false"}
Enemy~t!{INCARENA="true",INCTANKS="true",INCMYTAR="false",ENEMYTARGET="false",INCARENAPETS="false",ENEMYTARGETSIZE=40,HIDE="true",NUMBOSS=2,EXISTSHOWPTAR=1,INCSELF="false",EXISTSHOWBOSS="true",DOUBLEWIDTH="false",EXISTSHOWARENA=3}
FrameAlias~f~1!{A=1,NAME="",R=1,ALIAS="Frame 1",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~2!{A=1,NAME="",R=1,ALIAS="Frame 2",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~3!{A=1,NAME="",R=1,ALIAS="Frame 3",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~4!{A=1,NAME="",R=1,ALIAS="Frame 4",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~5!{A=1,NAME="",R=1,ALIAS="Frame 5",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~6!{SIZE=12,NAME="Vehicle",R=1,ALIAS="Vehicle",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~7!{SIZE=12,NAME="Pets",R=1,ALIAS="Pets",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~8!{SIZE=12,NAME="Target",R=1,ALIAS="Target",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~9!{SIZE=12,NAME="Focus",R=1,ALIAS="Focus",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~10!{SIZE=12,NAME="Enemy",R=1,ALIAS="Enemy",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAliasBar~f~1!{A=0.25,WIDTH=0.9,B=0.1,HEIGHT=20,R=0.1,G=0.1,TEXTURE="Skewed"}
FrameAliasBar~d!2~3~4~5~6~7~8~9~10~
Frame~f~1!{SFOFFSETH=0,BORDERR=0.1,BACKR=0.1,BORDERG=0.1,LOCKED="false",OPENSOUND="false",BORDERA=0.04,SFOFFSETV=0,TIPLOC=5,BACKB=0.7,BACKA=0.1,SCALE=1,BORDERB=0.1,BACKG=0.1,AUTOCLOSE="false"}
Frame~d!2~3~4~5~6~7~
Frame~f~8!{SFOFFSETH=4,AUTOCLOSE="false",BACKG=0.1,BORDERB=0.1,LOCKED="true",SCALE=1,BORDERA=0.04,BORDERG=0.1,TIPLOC=5,BACKB=0.7,BACKA=0.1,OPENSOUND="false",BACKR=0.1,SFOFFSETV=0,BORDERR=0.1}
Frame~f~9!{SFOFFSETH=-4,AUTOCLOSE="false",BACKG=0.1,BORDERB=0.1,LOCKED="true",SCALE=1,BORDERA=0.04,BORDERG=0.1,TIPLOC=5,BACKB=0.7,BACKA=0.1,OPENSOUND="false",BACKR=0.1,SFOFFSETV=0,BORDERR=0.1}
Frame~f~10!{SFOFFSETH=0,AUTOCLOSE="false",BACKG=0.1,BORDERB=0.1,LOCKED="false",SCALE=1,BORDERA=0.04,BORDERG=0.1,TIPLOC=5,BACKB=0.7,BACKA=0.1,OPENSOUND="false",BACKR=0.1,SFOFFSETV=0,BORDERR=0.1}
StickyFrames~f~1!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~f~2!{STUCK="true",STUCKTOPOINT="TOPRIGHT",STUCKTO=1,STUCKPOINT="TOPLEFT"}
StickyFrames~f~3!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~d!4~5~6~7~
StickyFrames~f~8!{STUCK="true",STUCKTOPOINT="TOPLEFT",STUCKTO=1,STUCKPOINT="TOPRIGHT"}
StickyFrames~f~9!{STUCK="true",STUCKTOPOINT="TOPRIGHT",STUCKTO=1,STUCKPOINT="TOPLEFT"}
StickyFrames~f~10!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
HealGroups~f~1!{FRAME=1,STATE="false",NAME="Self"}
HealGroups~f~2!{FRAME=1,STATE="true",NAME="Main tanks"}
HealGroups~f~3!{FRAME=1,STATE="true",NAME="Healers"}
HealGroups~f~4!{FRAME=1,STATE="true",NAME="Raid"}
HealGroups~f~5!{FRAME=1,STATE="true",NAME="Group"}
HealGroups~f~6!{FRAME=1,STATE="false",NAME="Private List"}
HealGroups~f~7!{FRAME=6,STATE="false",NAME="Vehicle"}
HealGroups~f~8!{FRAME=7,STATE="false",NAME="Pets"}
HealGroups~f~9!{FRAME=8,STATE="true",NAME="Target"}
HealGroups~f~10!{FRAME=9,STATE="true",NAME="Focus"}
HealGroups~f~11!{FRAME=10,STATE="false",NAME="Enemy"}
Anchors~f~1!{Y=54.79,GROW=2,BARS=1,FRAME=1,X=55.81}
Anchors~f~2!{Y=54.79,GROW=2,BARS=1,FRAME=1,X=58.78}
Anchors~f~3!{Y=52,GROW=2,BARS=1,FRAME=1,X=52}
Anchors~f~4!{Y=53,GROW=2,BARS=1,FRAME=1,X=53}
Anchors~f~5!{Y=54,GROW=2,BARS=1,FRAME=1,X=54}
Anchors~f~6!{Y=55,GROW=2,BARS=1,FRAME=1,X=55}
Anchors~f~7!{Y=56,GROW=2,BARS=1,FRAME=1,X=56}
Anchors~f~8!{Y=54.79,GROW=2,BARS=1,FRAME=3,X=55.95}
Anchors~f~9!{Y=54.79,GROW=2,BARS=1,FRAME=1,X=69.38}
Anchors~f~10!{Y=59,GROW=2,BARS=1,FRAME=1,X=59}
HeadBar~f~1!{SHOW="true",WIDTH=0.9,B=0.1,R=0.1,HEIGHT=20,A=0.25,G=0.1,TEXTURE="Skewed"}
HeadBar~d!2~3~4~5~6~7~8~9~10~
HeadText~f~1!{A=0.55,B=0.1,OFFSET=0,R=1,FONT="Friz Quadrata TT",HEIGHT=9,G=1,OUTLINE=1}
HeadText~d!2~3~4~5~6~7~8~9~10~
HealBar~f~1!{HEIGHT=32,GRPCOLS="true",CMARGIN=2,TEXTURE="Tukui2",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=1,NUMCOLS=2,OFIX=1,RMARGIN=2,WIDTH=75}
HealBar~d!2~3~4~5~6~7~8~9~10~
BarCol~f~1!{BACK=2,BA=0.05,BB=0.4,DISA=0.12,BR=0.2,HB=0.4,BG=0.4,BOUT=0,HA=0.95,HG=0.4,ORA=0.3,HR=0.2,HLTH=2}
BarCol~d!2~3~4~5~6~7~8~9~10~
BarIACol~f~1!{AC=3,AB=1,AA=0.5,AR=1,AG=1,IC=4,IB=0.2,IA=0.58,IR=0.2,IG=0.8}
BarIACol~d!2~3~4~5~6~7~8~9~10~
BarText~f~1!{HLTHONBAR="true",TAGOOR="[ OOR ] ",HOUTLINE=1,MAXCHARS=0,CLASSONBAR="false",TAGRIP="[ RIP ] ",HOFFSET=0,OUTLINE=1,INCHEALS=2,HLTHTXTANCHOR=1,HLTHTYPE=1,FONT="Friz Quadrata TT",HMAXCHARS=0,NUMFORMAT2=1,IGNOREONFULL="true",NUMFORMAT1=11,HHEIGHT=10,NAMEONBAR="true",HEIGHT=10,TAGDC="[ DC ] ",SHOWROLE="true",HALIGN=2,OVERHEAL=1,OFFSET=0,INCABSORBS=1,HOFFSET2=0,ALIGN=2,TAGR="[ R ] ",HFONT="Friz Quadrata TT"}
BarText~d!2~3~4~5~6~7~8~9~10~
BarTextCol~f~1!{HCG=1,NDEBUFF="false",NAME=3,NCDA=0.7,NCB=0,NCR=1,HCB=0,HCR=1,HCA=1,NCG=1,NCA=1,HDEBUFF="false",HCDA=0.7,HLTH=3}
BarTextCol~d!2~3~4~5~6~7~8~9~10~
Icons~f~1!{RCEN="true",I15EN="true",CLASSEN="false",SHOWDIRMOUSE="false",BUFFFADE="true",DEBUFFANCHOR=1,RCVOFFSET=-1,OORVOFFSET=0,DEBUFFDOUBLE="true",TARGETVOFFSET=0,BUFFONBAR=1,SHOWDIR="true",SHOWRC="true",TARGETANCHOR=5,RCSCALE=0.8,MAXBICONS=8,FADESECS=15,RCHOFFSET=0,TARGETHOFFSET=20,RCANCHOR=3,CLASSVOFFSET=0,TARGETEN="true",DSCALE=0.75,TARGETSCALE=0.4,BUFFANCHOR=2,SCALE=0.75,TARGETONBAR=3,FADE="false",BUFFDOUBLE="true",SHOWCLASS="false",CLASSONBAR=1,RCONBAR=3,MAXDICONS=4,OORANCHOR=1,SHOWROLE="false",CLASSHOFFSET=0,CLASSANCHOR=1,DEBUFFONBAR=1,CLASSSCALE=0.5,BUFFI15EN="true",BUFFFADESECS=15,OORSCALE=0.5,OORONBAR=3,OOREN="false",OORHOFFSET=0}
Icons~f~2!{RCEN="true",I15EN="true",CLASSEN="false",SHOWDIRMOUSE="false",BUFFFADE="true",DEBUFFANCHOR=1,RCVOFFSET=-1,OORVOFFSET=0,DEBUFFDOUBLE="true",TARGETVOFFSET=0,BUFFONBAR=1,SHOWDIR="true",SHOWRC="true",TARGETANCHOR=5,RCSCALE=0.8,MAXBICONS=8,FADESECS=15,RCHOFFSET=0,TARGETHOFFSET=20,CLASSONBAR=1,CLASSVOFFSET=0,SHOWROLE="false",DSCALE=0.75,CLASSANCHOR=1,CLASSSCALE=0.5,SCALE=0.75,TARGETONBAR=3,FADE="false",BUFFDOUBLE="true",OORHOFFSET=0,TARGETEN="true",RCONBAR=3,MAXDICONS=3,OORANCHOR=1,OORONBAR=3,TARGETSCALE=0.4,CLASSHOFFSET=0,DEBUFFONBAR=1,BUFFANCHOR=2,BUFFI15EN="true",BUFFFADESECS=15,OORSCALE=0.5,RCANCHOR=3,OOREN="false",SHOWCLASS="false"}
Icons~d!3~4~5~6~7~8~9~10~
RaidIcon~f~1!{SQUARE="true",CIRCLE="true",DIAMOND="true",SHOW="true",SKULL="true",TRIANGLE="true",STAR="true",MOON="true",CROSS="true"}
RaidIcon~d!2~3~4~5~6~7~8~9~10~
IconText~f~1!{DURWARN=3,BUFFHEIGHT=10,BUFFOUTLINE=2,BUFFDURTHRH=9,SCNT="true",DURTHRH=9,FONT="Friz Quadrata TT",BUFFFONT="Friz Quadrata TT",BUFFSCNT="true",SSCNT="false",BUFFSDUR="true",BUFFDURWARN=3,BUFFSSCNT="false",SDUR="true",BUFFSSDUR="true",HEIGHT=10,SSDUR="true",OUTLINE=2}
IconText~d!2~3~4~5~6~7~8~9~10~
BarVisibility~f~1!{INCCLASSES=1,ALERTIC=0.98,ALERTOC=0.9,HIDEOOR="false"}
BarVisibility~d!2~3~4~5~
BarVisibility~f~6!{INCCLASSES=1,ALERTIC=0.9,ALERTOC=0.8,HIDEOOR="false"}
BarVisibility~d!7~
BarVisibility~f~8!{INCCLASSES=1,ALERTIC=0.98,ALERTOC=0.9,HIDEOOR="false"}
BarVisibility~d!9~10~
BarSort~f~1!{SUBORDER=1,OORLAST="false",RAIDORDER=3,SUBPF="true"}
BarSort~d!2~3~4~5~6~7~8~9~10~
BarAggro~f~1!{B=0,SHOWTEXT="false",G=0,TEXTFORMAT=3,SHOW="true",SHOWTEXTPCT="true",SHOWIND="true",ALERTIND=2,R=1,ALERT=3}
BarAggro~d!2~3~4~5~6~7~8~9~10~
AuxBarFrame~f~1!{OVERLAP=1}
AuxBarFrame~d!2~3~4~5~6~7~8~9~10~
AuxBar^1~f~1!{SIZE=1,USE=4,R=1,COLOUR=1,ANCHOR=1,OFFSET=0,DEPTH=3,OTYPE=1,B=1,G=1}
AuxBar^1~d!2~3~4~5~6~7~8~9~10~
AuxBar^2~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,OTYPE=1,B=1,G=1}
AuxBar^2~d!2~3~4~5~6~7~8~9~10~
AuxBar^3~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,OTYPE=1,B=1,G=1}
AuxBar^3~d!2~3~4~5~6~7~8~9~10~
AuxBar^4~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,OTYPE=1,B=1,G=1}
AuxBar^4~d!2~3~4~5~6~7~8~9~10~
AuxBar^5~f~1!{SIZE=1,USE=5,R=1,COLOUR=1,ANCHOR=2,OFFSET=0,DEPTH=2,OTYPE=1,B=1,G=1}
AuxBar^5~d!2~3~4~5~6~7~8~9~
AuxBar^5~f~10!{SIZE=1,USE=1,R=1,COLOUR=1,ANCHOR=2,OFFSET=0,DEPTH=2,G=1,B=1,OTYPE=1}
AuxBar^6~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=4,OFFSET=0,DEPTH=2,OTYPE=1,B=1,G=1}
AuxBar^6~d!2~3~4~5~6~7~8~9~10~
AuxBar^7~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,OTYPE=1,B=1,G=1}
AuxBar^7~d!2~3~4~5~6~7~8~9~10~
AuxBar^8~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,OTYPE=1,B=1,G=1}
AuxBar^8~d!2~3~4~5~6~7~8~9~10~
AuxBar^9~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,OTYPE=1,B=1,G=1}
AuxBar^9~d!2~3~4~5~6~7~8~9~10~
Complete!]]
HealBot_ExtraSkinData[20]=[[Skin
Alterac Valley
Author~v!Monti of Terenas
DuplicateBars~v!false
Chat~t!{EOCOOM="false",EOCOOMV=20,MSG="Casting #s on #n",RESONLY="true",CHAN="",NOTIFY=1}
General~t!{OFREQ=0.07,STICKYSENSITIVITY=30,FLUIDBARS="false",HIDEBOSSF="false",HIDEPARTYF="false",OMIN=0.1,HIDERAIDF="true",FLUIDFREQ=10,STICKYFRAME="true",OMAX=0.95,HIDEPTF="false"}
Healing~t!{TONLYFRIEND="false",FEXRAID="false",FOCUSINCOMBAT=2,GROUPPETS="true",SELFPET="false",FONLYFRIEND="false",TEXRAID="false",TARGETINCOMBAT=2}
Enemy~t!{INCARENA="true",INCTANKS="true",INCMYTAR="false",ENEMYTARGET="false",ENEMYTARGETSIZE=40,INCARENAPETS="false",INCSELF="false",NUMBOSS=2,EXISTSHOWPTAR=1,HIDE="true",EXISTSHOWBOSS="true",DOUBLEWIDTH="false",EXISTSHOWARENA=3}
FrameAlias~f~1!{SIZE=12,NAME="",R=1,ALIAS="Frame 1",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~d!2~3~4~5~
FrameAlias~f~6!{SIZE=12,NAME="Vehicle",R=1,ALIAS="Vehicle",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~7!{SIZE=12,NAME="Pets",R=1,ALIAS="Pets",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~8!{SIZE=12,NAME="Target",R=1,ALIAS="Target",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~9!{SIZE=12,NAME="Focus",R=1,ALIAS="Focus",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~10!{SIZE=12,NAME="Enemy",R=1,ALIAS="Enemy",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAliasBar~f~1!{A=0.2,TEXTURE="Skewed",B=0.1,HEIGHT=20,R=0.1,G=0.1,WIDTH=0.9}
FrameAliasBar~d!2~3~4~5~6~7~8~9~10~
Frame~f~1!{BACKR=0.2,TIPLOC=5,AUTOCLOSE="false",BACKB=0.2,LOCKED="false",SCALE=1,BORDERA=0.5,SFOFFSETV=0,BACKG=0.2,BORDERB=0.2,BACKA=0.1,OPENSOUND="false",SFOFFSETH=0,BORDERG=0.2,BORDERR=0.2}
Frame~d!2~3~4~5~6~7~
Frame~f~8!{BACKR=0.2,BORDERR=0.2,BORDERG=0.2,SFOFFSETH=0,LOCKED="false",OPENSOUND="false",BORDERA=0.5,SFOFFSETV=-8,TIPLOC=5,BACKB=0.2,BACKA=0.1,SCALE=1,BORDERB=0.2,BACKG=0.2,AUTOCLOSE="false"}
Frame~d!9~
Frame~f~10!{BACKR=0.2,BORDERR=0.2,BORDERG=0.2,SFOFFSETH=0,LOCKED="false",OPENSOUND="false",BORDERA=0.5,SFOFFSETV=0,TIPLOC=5,BACKB=0.2,BACKA=0.1,SCALE=1,BORDERB=0.2,BACKG=0.2,AUTOCLOSE="false"}
StickyFrames~f~1!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~d!2~3~4~5~6~7~
StickyFrames~f~8!{STUCK="true",STUCKTOPOINT="TOPLEFT",STUCKTO=1,STUCKPOINT="BOTTOMLEFT"}
StickyFrames~f~9!{STUCK="true",STUCKTOPOINT="TOPRIGHT",STUCKTO=1,STUCKPOINT="BOTTOMRIGHT"}
StickyFrames~f~10!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
HealGroups~f~1!{FRAME=1,STATE="true",NAME="Self"}
HealGroups~f~2!{FRAME=1,STATE="true",NAME="Main tanks"}
HealGroups~f~3!{FRAME=1,STATE="true",NAME="Healers"}
HealGroups~f~4!{FRAME=1,STATE="true",NAME="Group"}
HealGroups~f~5!{FRAME=1,STATE="true",NAME="Raid"}
HealGroups~f~6!{FRAME=1,STATE="true",NAME="Private List"}
HealGroups~f~7!{FRAME=6,STATE="false",NAME="Vehicle"}
HealGroups~f~8!{FRAME=7,STATE="false",NAME="Pets"}
HealGroups~f~9!{FRAME=8,STATE="true",NAME="Target"}
HealGroups~f~10!{FRAME=9,STATE="true",NAME="Focus"}
HealGroups~f~11!{FRAME=10,STATE="false",NAME="Enemy"}
Anchors~f~1!{Y=56.32,GROW=2,BARS=1,FRAME=1,X=57.44}
Anchors~f~2!{Y=51,GROW=2,BARS=1,FRAME=1,X=51}
Anchors~f~3!{Y=52,GROW=2,BARS=1,FRAME=1,X=52}
Anchors~f~4!{Y=53,GROW=2,BARS=1,FRAME=1,X=53}
Anchors~f~5!{Y=54,GROW=2,BARS=1,FRAME=1,X=54}
Anchors~f~6!{Y=55,GROW=2,BARS=1,FRAME=1,X=55}
Anchors~f~7!{Y=56,GROW=2,BARS=1,FRAME=1,X=56}
Anchors~f~8!{Y=55.65,GROW=2,BARS=1,FRAME=2,X=57.44}
Anchors~f~9!{Y=55.65,GROW=2,BARS=1,FRAME=4,X=65.39}
Anchors~f~10!{Y=59,GROW=2,BARS=1,FRAME=1,X=59}
HeadBar~f~1!{SHOW="false",TEXTURE="Skewed",R=0.1,B=0.1,HEIGHT=20,A=0.2,G=0.1,WIDTH=0.9}
HeadBar~d!2~3~4~5~6~7~8~9~10~
HeadText~f~1!{A=0.4,R=1,OFFSET=0,B=0.1,FONT="Friz Quadrata TT",HEIGHT=9,G=1,OUTLINE=1}
HeadText~d!2~3~4~5~6~7~8~9~10~
HealBar~f~1!{HEIGHT=20,GRPCOLS="false",CMARGIN=1,TEXTURE="Charcoal",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=72,RMARGIN=1,OFIX=1,NUMCOLS=3,LOWMANA=1}
HealBar~d!2~3~4~5~6~7~8~9~10~
BarCol~f~1!{BACK=1,BA=0,BOUT=0,DISA=0.04,BR=0,HB=0.2,BG=0.2,HG=0.2,HA=0.88,HR=0,ORA=0.25,BB=0.2,HLTH=1}
BarCol~d!2~3~4~5~6~7~8~9~10~
BarIACol~f~1!{AC=3,AB=1,AA=0.4,AR=1,AG=1,IC=4,IB=0,IA=0.52,IR=0,IG=0.5}
BarIACol~d!2~3~4~5~6~7~8~9~10~
BarText~f~1!{HLTHONBAR="true",TAGOOR="[ OOR ] ",HOUTLINE=1,MAXCHARS=0,HMAXCHARS=0,TAGDC="[ DC ] ",HFONT="Friz Quadrata TT",OUTLINE=1,INCHEALS=2,HLTHTXTANCHOR=1,FONT="Friz Quadrata TT",OFFSET=0,HLTHTYPE=3,NUMFORMAT2=1,CLASSONBAR="false",NUMFORMAT1=11,IGNOREONFULL="true",TAGRIP="[ RIP ] ",HEIGHT=9,NAMEONBAR="true",SHOWROLE="true",HALIGN=2,HHEIGHT=10,OVERHEAL=1,INCABSORBS=1,HOFFSET2=0,ALIGN=2,TAGR="[ R ] ",HOFFSET=2}
BarText~d!2~3~4~5~6~7~8~9~10~
BarTextCol~f~1!{HCG=1,NDEBUFF="false",NAME=3,NCDA=0.5,NCB=0,NCR=1,HCB=0,HCR=1,HCA=1,NCG=1,NCA=1,HDEBUFF="false",HLTH=3,HCDA=0.5}
BarTextCol~d!2~3~4~5~6~7~8~9~10~
Icons~f~1!{RCEN="false",I15EN="true",CLASSEN="false",FADE="false",SHOWBUFF="false",DEBUFFANCHOR=1,RCVOFFSET=0,OORVOFFSET=-1,DEBUFFDOUBLE="false",TARGETVOFFSET=0,TARGETSCALE=0.5,SHOWDIR="true",SHOWRC="false",TARGETANCHOR=5,RCSCALE=0.5,MAXBICONS=4,BUFFFADE="false",TARGETEN="false",FADESECS=15,RCHOFFSET=0,TARGETHOFFSET=10,CLASSONBAR=1,CLASSVOFFSET=0,OORHOFFSET=0,DSCALE=0.55,RCANCHOR=1,OORANCHOR=1,BUFFDOUBLE="false",OORONBAR=3,TARGETONBAR=3,SCALE=0.55,DEBUFFONBAR=1,CLASSHOFFSET=0,RCONBAR=1,MAXDICONS=2,CLASSSCALE=0.5,SHOWCLASS="false",SHOWDIRMOUSE="false",CLASSANCHOR=1,DOUBLE="false",BUFFANCHOR=2,BUFFI15EN="true",BUFFFADESECS=15,OORSCALE=0.5,SHOWROLE="false",OOREN="false",BUFFONBAR=1}
Icons~f~2!{RCEN="false",I15EN="true",CLASSEN="false",BUFFANCHOR=2,SHOWBUFF="false",DEBUFFANCHOR=1,RCVOFFSET=0,OORVOFFSET=-1,DEBUFFDOUBLE="false",TARGETVOFFSET=0,TARGETSCALE=0.5,SHOWDIR="true",SHOWRC="false",TARGETANCHOR=5,RCSCALE=0.5,MAXBICONS=8,SHOWROLE="false",TARGETONBAR=3,FADESECS=15,RCHOFFSET=0,TARGETHOFFSET=10,CLASSONBAR=1,CLASSVOFFSET=0,OORHOFFSET=0,DSCALE=0.55,SHOWCLASS="false",TARGETEN="false",SCALE=0.55,OORONBAR=3,RCANCHOR=1,BUFFDOUBLE="false",DOUBLE="false",CLASSHOFFSET=0,RCONBAR=1,MAXDICONS=3,OORANCHOR=3,FADE="false",BUFFFADE="false",CLASSANCHOR=1,DEBUFFONBAR=1,CLASSSCALE=0.5,BUFFI15EN="true",BUFFFADESECS=15,OORSCALE=0.5,SHOWDIRMOUSE="false",OOREN="false",BUFFONBAR=1}
Icons~d!3~4~5~6~7~
Icons~f~8!{RCEN="false",I15EN="true",CLASSEN="false",BUFFANCHOR=2,SHOWBUFF="false",DEBUFFANCHOR=1,RCVOFFSET=0,OORVOFFSET=-1,DEBUFFDOUBLE="false",TARGETVOFFSET=0,TARGETSCALE=0.5,SHOWDIR="true",SHOWRC="false",TARGETANCHOR=5,RCSCALE=0.5,MAXBICONS=8,SHOWROLE="false",TARGETONBAR=3,FADESECS=15,RCHOFFSET=0,TARGETHOFFSET=10,CLASSONBAR=1,CLASSVOFFSET=0,OORHOFFSET=0,DSCALE=0.55,SHOWCLASS="false",TARGETEN="false",SCALE=0.55,OORONBAR=3,RCANCHOR=1,BUFFDOUBLE="false",DOUBLE="false",CLASSHOFFSET=0,RCONBAR=1,MAXDICONS=2,OORANCHOR=3,FADE="false",BUFFFADE="false",CLASSANCHOR=1,DEBUFFONBAR=1,CLASSSCALE=0.5,BUFFI15EN="true",BUFFFADESECS=15,OORSCALE=0.5,SHOWDIRMOUSE="false",OOREN="false",BUFFONBAR=1}
Icons~f~9!{RCEN="false",I15EN="true",CLASSEN="false",BUFFANCHOR=2,SHOWBUFF="false",DEBUFFANCHOR=1,RCVOFFSET=0,OORVOFFSET=-1,DEBUFFDOUBLE="false",TARGETVOFFSET=0,TARGETSCALE=0.5,SHOWDIR="true",SHOWRC="false",TARGETANCHOR=5,RCSCALE=0.5,MAXBICONS=8,SHOWROLE="false",TARGETONBAR=3,FADESECS=15,RCHOFFSET=0,TARGETHOFFSET=10,CLASSONBAR=1,CLASSVOFFSET=0,OORHOFFSET=0,DSCALE=0.55,SHOWCLASS="false",TARGETEN="false",SCALE=0.55,OORONBAR=3,RCANCHOR=1,BUFFDOUBLE="false",DOUBLE="false",CLASSHOFFSET=0,RCONBAR=1,MAXDICONS=3,OORANCHOR=3,FADE="false",BUFFFADE="false",CLASSANCHOR=1,DEBUFFONBAR=1,CLASSSCALE=0.5,BUFFI15EN="true",BUFFFADESECS=15,OORSCALE=0.5,SHOWDIRMOUSE="false",OOREN="false",BUFFONBAR=1}
Icons~d!10~
RaidIcon~f~1!{SQUARE="true",CIRCLE="true",DIAMOND="true",SHOW="true",MOON="true",TRIANGLE="true",STAR="true",CROSS="true",SKULL="true"}
RaidIcon~d!2~3~4~5~6~7~8~9~10~
IconText~f~1!{DURWARN=3,BUFFSSDUR="true",BUFFOUTLINE=2,BUFFDURTHRH=9,SCNT="true",DURTHRH=9,FONT="Friz Quadrata TT",BUFFFONT="Friz Quadrata TT",HEIGHT=10,SSCNT="false",BUFFSDUR="false",BUFFDURWARN=3,BUFFSCNT="true",SDUR="false",BUFFHEIGHT=10,BUFFSSCNT="false",SSDUR="true",OUTLINE=2}
IconText~d!2~3~4~5~6~7~8~9~10~
BarVisibility~f~1!{INCCLASSES=1,ALERTIC=0.95,ALERTOC=0.85,HIDEOOR="true"}
BarVisibility~d!2~3~4~5~6~7~8~9~10~
BarSort~f~1!{SUBORDER=1,OORLAST="false",RAIDORDER=3,SUBPF="true"}
BarSort~d!2~3~4~5~6~7~8~9~10~
BarAggro~f~1!{B=0,SHOWTEXT="false",G=0,TEXTFORMAT=3,SHOW="true",SHOWTEXTPCT="true",R=1,ALERTIND=2,SHOWIND="true",ALERT=3}
BarAggro~d!2~3~4~5~6~7~8~9~10~
AuxBarFrame~f~1!{OVERLAP=1}
AuxBarFrame~d!2~3~4~5~6~7~8~9~10~
AuxBar^1~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,OTYPE=1}
AuxBar^1~d!2~3~4~5~6~7~8~9~10~
AuxBar^2~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,OTYPE=1}
AuxBar^2~d!2~3~4~5~6~7~8~9~10~
AuxBar^3~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,OTYPE=1}
AuxBar^3~d!2~3~4~5~6~7~8~9~10~
AuxBar^4~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,OTYPE=1}
AuxBar^4~d!2~3~4~5~6~7~8~9~10~
AuxBar^5~f~1!{SIZE=0.98,USE=5,R=1,COLOUR=1,ANCHOR=1,OFFSET=0,DEPTH=1,G=1,B=1,OTYPE=1}
AuxBar^5~d!2~3~4~5~6~7~8~9~
AuxBar^5~f~10!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=0,DEPTH=1,G=1,B=1,OTYPE=1}
AuxBar^6~f~1!{SIZE=0.98,USE=5,R=1,COLOUR=1,ANCHOR=2,OFFSET=0,DEPTH=1,G=1,B=1,OTYPE=1}
AuxBar^6~d!2~3~4~5~6~7~8~9~
AuxBar^6~f~10!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=2,OFFSET=0,DEPTH=1,G=1,B=1,OTYPE=1}
AuxBar^7~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,OTYPE=1}
AuxBar^7~d!2~3~4~5~6~7~8~9~10~
AuxBar^8~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,OTYPE=1}
AuxBar^8~d!2~3~4~5~6~7~8~9~10~
AuxBar^9~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,OTYPE=1}
AuxBar^9~d!2~3~4~5~6~7~8~9~10~
Complete!]]
HealBot_ExtraSkinData[21]=[[Skin
Bottoms Up cRaid 25
Author~v!Monti of Terenas
DuplicateBars~v!true
Chat~t!{EOCOOM="false",EOCOOMV=20,MSG="Casting #s on #n",RESONLY="true",CHAN="",NOTIFY=0}
General~t!{FLUIDFREQ=10,OFREQ=0.07,FLUIDBARS="false",OMAX=0.95,HIDERAIDF="true",HIDEPTF="false",FGDIMMING=2.5,HIDEBOSSF="false",FOCUSGROUPS=1,STICKYFRAME="true",OMIN=0.1,HIDEPARTYF="false"}
Healing~t!{TINCSELF="false",GROUPPETS="true",TARGETINCOMBAT=2,TINCPET="false",FONLYFRIEND="false",FEXRAID="false",TONLYFRIEND="false",FALWAYSSHOW="false",FOCUSINCOMBAT=2,TALWAYSSHOW="false",SELFPET=0,TINCGROUP=1,TEXRAID="false",TINCRAID=1}
Enemy~t!{INCOMBATSHOWARENA=2,INCOMBATSHOWSELF=2,INCARENA="true",EXISTSHOWTANK=1,EXISTSHOWBOSS="true",ENEMYTARGET="true",INCTANKS="true",INCMYTAR="false",EXISTSHOWARENA=3,ENEMYTARGETSIZE=40,INCARENAPETS="false",INCOMBATSHOWLIST=2,NUMBOSS=2,EXISTSHOWPTAR=1,INCSELF="false",EXISTSHOWMYTAR=1,DOUBLEWIDTH="false",INCOMBATSHOWTANK=2}
FocusGroups~t!{"true","true","true","true","true","true","true","true"}
FrameAlias~f~1!{SIZE=12,NAME="",R=1,ALIAS="Raid",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~2!{A=1,NAME="Tanks",R=1,ALIAS="Tanks",G=1,SHOW="true",OFFSET=0,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~3!{A=1,NAME="",R=1,ALIAS="Not Used",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~4!{A=1,NAME="",R=1,ALIAS="NotUsed",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~5!{A=1,NAME="",R=1,ALIAS="Not Used",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~6!{A=1,NAME="",R=1,ALIAS="Vehicle",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~7!{A=1,NAME="Pets",R=1,ALIAS="Pets",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~8!{A=1,NAME="",R=1,ALIAS="Target",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~9!{A=1,NAME="",R=1,ALIAS="Focus",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~10!{A=1,NAME="Enemy",R=0.988,ALIAS="Enemy",G=0.471,SHOW="true",OFFSET=0,FONT="Friz Quadrata TT",SIZE=12,B=0,OUTLINE=1}
FrameAliasBar~f~1!{A=0.5,WIDTH=0.7,B=0.25,HEIGHT=20,R=0.1,G=0.25,TEXTURE="HealBot 10"}
FrameAliasBar~f~2!{A=0,TEXTURE="HealBot 10",B=0.251,HEIGHT=20,R=0.102,G=0.251,WIDTH=0.95}
FrameAliasBar~f~3!{A=0.5,TEXTURE="HealBot 10",B=0.25,HEIGHT=20,R=0.1,G=0.25,WIDTH=0.7}
FrameAliasBar~d!4~5~6~7~8~9~
FrameAliasBar~f~10!{A=0,TEXTURE="HealBot 10",B=0.251,HEIGHT=20,R=0.102,G=0.251,WIDTH=0.7}
Frame~f~1!{SFOFFSETH=0,BORDERR=0.1,BACKR=0.102,LOCKED=5,BORDERG=0.1,BORDERA=0.04,SFOFFSETV=0,AUTOCLOSE=1,BORDERB=0.1,BACKA=0,SCALE=1,BACKB=0.702,BACKG=0.102,TIPLOC=2}
Frame~f~2!{BORDERR=0.1,BACKR=0.102,BORDERG=0.1,LOCKED=5,AUTOCLOSE=1,BORDERA=0.04,SFOFFSETV=-21,BACKG=0.102,BORDERB=0.1,BACKA=0,SCALE=1,BACKB=0.702,TIPLOC=1,SFOFFSETH=0}
Frame~f~3!{SFOFFSETH=0,BORDERR=0.1,BACKR=0.1,LOCKED=1,BORDERG=0.1,BORDERA=0.04,SFOFFSETV=0,AUTOCLOSE=1,BORDERB=0.1,BACKA=0.1,SCALE=1,BACKB=0.7,BACKG=0.1,TIPLOC=5}
Frame~d!4~
Frame~f~5!{BORDERR=0.1,BACKR=0.1,BORDERG=0.1,LOCKED=2,AUTOCLOSE=1,BORDERA=0.04,SFOFFSETV=0,BACKG=0.1,BORDERB=0.1,BACKA=0.1,SCALE=1,BACKB=0.7,TIPLOC=2,SFOFFSETH=0}
Frame~f~6!{BORDERR=0.1,BACKR=0.1,BORDERG=0.1,LOCKED=1,AUTOCLOSE=1,BORDERA=0.04,SFOFFSETV=0,BACKG=0.1,BORDERB=0.1,BACKA=0.1,SCALE=1,BACKB=0.7,TIPLOC=5,SFOFFSETH=0}
Frame~f~7!{BORDERR=0.1,BACKR=0.1,BORDERG=0.1,LOCKED=5,AUTOCLOSE=1,BORDERA=0.04,SFOFFSETV=5,BACKG=0.1,BORDERB=0.1,BACKA=0.1,SCALE=1,BACKB=0.7,TIPLOC=5,SFOFFSETH=5}
Frame~f~8!{SFOFFSETH=0,BORDERR=0.1,BACKG=0.1,LOCKED=1,BACKB=0.7,BORDERA=0.04,BORDERG=0.1,TIPLOC=5,BORDERB=0.1,BACKA=0.1,SCALE=1,AUTOCLOSE=1,SFOFFSETV=0,BACKR=0.1}
Frame~d!9~
Frame~f~10!{SFOFFSETH=2,BORDERR=1,BACKG=0.1,LOCKED=5,BACKB=0.7,BORDERA=1,BORDERG=0,TIPLOC=4,BORDERB=0,BACKA=0.1,SCALE=1,AUTOCLOSE=2,SFOFFSETV=-5,BACKR=0.1}
StickyFrames~f~1!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~f~2!{STUCK="true",STUCKTOPOINT="TOPRIGHT",STUCKTO=1,STUCKPOINT="TOPLEFT"}
StickyFrames~f~3!{STUCK="false",STUCKTOPOINT="RIGHT",STUCKTO=2,STUCKPOINT="LEFT"}
StickyFrames~f~4!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~d!5~6~
StickyFrames~f~7!{STUCK="true",STUCKTOPOINT="BOTTOMLEFT",STUCKTO=1,STUCKPOINT="TOPLEFT"}
StickyFrames~f~8!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~d!9~
StickyFrames~f~10!{STUCK="true",STUCKTOPOINT="TOPLEFT",STUCKTO=1,STUCKPOINT="BOTTOMLEFT"}
HealGroups~f~1!{FRAME=1,STATE="false",NAME="Self"}
HealGroups~f~2!{FRAME=2,STATE="true",NAME="Main tanks"}
HealGroups~f~3!{FRAME=1,STATE="false",NAME="Healers"}
HealGroups~f~4!{FRAME=1,STATE="false",NAME="Group"}
HealGroups~f~5!{FRAME=1,STATE="false",NAME="Private List"}
HealGroups~f~6!{FRAME=1,STATE="true",NAME="Raid"}
HealGroups~f~7!{FRAME=1,STATE="false",NAME="Vehicle"}
HealGroups~f~8!{FRAME=7,STATE="true",NAME="Pets"}
HealGroups~f~9!{FRAME=8,STATE="false",NAME="Target"}
HealGroups~f~10!{FRAME=9,STATE="false",NAME="Focus"}
HealGroups~f~11!{FRAME=10,STATE="true",NAME="Enemy"}
Anchors~f~1!{Y=61.47,GROW=2,BARS=1,FRAME=1,X=76.35}
Anchors~f~2!{Y=59.72,GROW=2,BARS=1,FRAME=1,X=91.7}
Anchors~f~3!{Y=22.89,GROW=1,BARS=1,FRAME=6,X=31.19}
Anchors~f~4!{Y=53,GROW=2,BARS=1,FRAME=1,X=53}
Anchors~f~5!{Y=50.59,GROW=2,BARS=1,FRAME=1,X=58.13}
Anchors~f~6!{Y=55,GROW=2,BARS=1,FRAME=1,X=55}
Anchors~f~7!{Y=34.8,GROW=1,BARS=2,FRAME=1,X=76.52}
Anchors~f~8!{Y=57,GROW=2,BARS=1,FRAME=1,X=57}
Anchors~f~9!{Y=58,GROW=2,BARS=1,FRAME=1,X=58}
Anchors~f~10!{Y=61.05,GROW=2,BARS=1,FRAME=2,X=76.42}
HeadBar~f~1!{SHOW="true",WIDTH=0.95,B=0.102,R=0.102,HEIGHT=20,A=0,G=0.102,TEXTURE="Tukui"}
HeadBar~f~2!{SHOW="false",TEXTURE="Tukui",R=0.102,B=0.102,HEIGHT=62,A=0.4,G=0.102,WIDTH=0.7}
HeadBar~f~3!{SHOW="true",TEXTURE="Tukui2",R=0.102,B=0.102,HEIGHT=60,A=0.4,G=0.102,WIDTH=0.95}
HeadBar~d!4~5~6~
HeadBar~f~7!{SHOW="true",TEXTURE="Tukui",R=0.102,B=0.102,HEIGHT=28,A=0.4,G=0.102,WIDTH=0.95}
HeadBar~f~8!{SHOW="true",TEXTURE="Tukui2",R=0.102,B=0.102,HEIGHT=60,A=0.4,G=0.102,WIDTH=0.95}
HeadBar~d!9~
HeadBar~f~10!{SHOW="false",WIDTH=0.95,B=0.102,R=0.102,HEIGHT=28,A=0.4,G=0.102,TEXTURE="Tukui2"}
HeadText~f~1!{A=1,B=0.961,OFFSET=0,R=1,FONT="Friz Quadrata TT",HEIGHT=11,G=0.996,OUTLINE=1}
HeadText~d!2~3~4~5~6~7~8~9~10~
HealBar~f~1!{HEIGHT=55,GRPCOLS="false",CMARGIN=0,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=1,NUMCOLS=1,OFIX=2,RMARGIN=0,WIDTH=70}
HealBar~f~2!{HEIGHT=80,GRPCOLS="false",CMARGIN=0,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=1,NUMCOLS=1,OFIX=2,RMARGIN=0,WIDTH=115}
HealBar~f~3!{HEIGHT=60,GRPCOLS="false",CMARGIN=2,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=1,NUMCOLS=2,OFIX=1,RMARGIN=2,WIDTH=80}
HealBar~f~4!{HEIGHT=60,GRPCOLS="false",CMARGIN=2,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=80,RMARGIN=2,OFIX=1,NUMCOLS=3,LOWMANA=1}
HealBar~d!5~6~
HealBar~f~7!{HEIGHT=25,GRPCOLS="false",CMARGIN=0,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",NUMCOLS=1,RMARGIN=0,OFIX=2,WIDTH=55,LOWMANA=1}
HealBar~f~8!{HEIGHT=60,GRPCOLS="false",CMARGIN=2,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",NUMCOLS=3,RMARGIN=2,OFIX=1,WIDTH=80,LOWMANA=1}
HealBar~d!9~
HealBar~f~10!{HEIGHT=55,GRPCOLS="false",CMARGIN=14,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=1,WIDTH=250,OFIX=1,RMARGIN=0,NUMCOLS=2}
BarCol~f~1!{BACK=3,BA=0.75,BOUT=2,DISA=0.1,BR=0,HB=0.4,BG=0,BB=0,HA=1,HG=0.4,ORA=0.25,HR=0.2,HLTH=2}
BarCol~d!2~
BarCol~f~3!{BACK=3,BA=0.75,BOUT=1,DISA=0.2,BR=0,HB=0.4,BG=0,HR=0.2,HA=1,HG=0.4,ORA=0.5,BB=0,HLTH=2}
BarCol~d!4~5~6~
BarCol~f~7!{BACK=3,BA=0.75,BOUT=1,DISA=0.1,BR=0,HB=0.4,BG=0,BB=0,HA=1,HR=0.2,ORA=0.5,HG=0.4,HLTH=2}
BarCol~f~8!{BACK=3,BA=0.75,BOUT=1,DISA=0.2,BR=0,HB=0.4,BG=0,BB=0,HA=1,HR=0.2,ORA=0.5,HG=0.4,HLTH=2}
BarCol~d!9~
BarCol~f~10!{BACK=3,BA=0,BOUT=1,DISA=0.2,BR=0,HB=0.4,BG=0,BB=0,HA=1,HR=0.2,ORA=0.5,HG=0.4,HLTH=2}
BarIACol~f~1!{AC=3,AB=1,AA=0.75,AR=1,AG=1,IC=2,IB=0.2,IA=0.75,IR=0.2,IG=0.8}
BarIACol~d!2~
BarIACol~f~3!{AC=3,AB=1,AA=0.6,AR=1,AG=1,IC=2,IB=0.2,IA=0.6,IR=0.2,IG=0.8}
BarIACol~d!4~5~6~
BarIACol~f~7!{AC=3,AB=1,AA=0.75,AR=1,AG=1,IC=2,IB=0.2,IA=0.75,IR=0.2,IG=0.8}
BarIACol~f~8!{AC=3,AB=1,AA=0.6,AR=1,AG=1,IC=2,IB=0.2,IA=0.6,IR=0.2,IG=0.8}
BarIACol~d!9~
BarIACol~f~10!{AC=3,AB=1,AA=0.55,AR=1,AG=1,IC=2,IB=0.2,IA=0.55,IR=0.2,IG=0.8}
BarText~f~1!{HHEIGHT=10,TAGOOR="",OVERHEAL=1,MAXCHARS=12,CLASSONBAR="false",HFONT="Friz Quadrata TT",HMAXCHARS=0,OFFSET=0,HLTHTXTANCHOR=1,FONT="Friz Quadrata TT",HLTHONBAR="false",IGNOREONFULL="true",NUMFORMAT2=1,HOUTLINE=1,TAGDC="",NUMFORMAT1=11,TAGRIP="",HEIGHT=10,HLTHTYPE=3,SHOWROLE="true",HALIGN=2,NAMEONBAR="true",INCHEALS=2,OUTLINE=2,INCABSORBS=1,HOFFSET2=0,ALIGN=2,TAGR="[ R ] ",HOFFSET=0}
BarText~d!2~3~4~5~6~
BarText~f~7!{HHEIGHT=10,TAGOOR="",HOUTLINE=1,MAXCHARS=0,HMAXCHARS=0,OUTLINE=2,IGNOREONFULL="true",OFFSET=0,HLTHTXTANCHOR=1,FONT="Friz Quadrata TT",HLTHONBAR="false",HLTHTYPE=3,NUMFORMAT2=1,HFONT="Friz Quadrata TT",NUMFORMAT1=11,TAGDC="",NAMEONBAR="true",HEIGHT=10,OVERHEAL=1,SHOWROLE="true",HALIGN=2,TAGRIP="",CLASSONBAR="false",INCHEALS=2,INCABSORBS=1,HOFFSET2=0,ALIGN=2,TAGR="[ R ] ",HOFFSET=0}
BarText~f~8!{HHEIGHT=10,TAGOOR="",HOUTLINE=1,MAXCHARS=12,HMAXCHARS=0,OUTLINE=2,IGNOREONFULL="true",OFFSET=0,HLTHTXTANCHOR=1,FONT="Friz Quadrata TT",HLTHONBAR="false",HLTHTYPE=3,NUMFORMAT2=1,HFONT="Friz Quadrata TT",NUMFORMAT1=11,TAGDC="",NAMEONBAR="true",HEIGHT=10,OVERHEAL=1,SHOWROLE="true",HALIGN=2,TAGRIP="",CLASSONBAR="false",INCHEALS=2,INCABSORBS=1,HOFFSET2=0,ALIGN=2,TAGR="[ R ] ",HOFFSET=0}
BarText~d!9~10~
BarTextCol~f~1!{HCG=1,HCA=1,HCDA=0.7,NCDA=0.7,NAME=2,NDEBUFF="false",HCB=0,HCR=0.929,NCR=0.929,NCG=1,NCA=1,HDEBUFF="false",NCB=0,HLTH=3}
BarTextCol~d!2~3~4~5~6~7~8~9~10~
Icons~f~1!{RCEN="true",I15EN="true",CLASSEN="false",FADE="true",BUFFFADE="true",DEBUFFANCHOR=1,RCVOFFSET=0,OORVOFFSET=0,DEBUFFDOUBLE="true",TARGETVOFFSET=0,BUFFONBAR=1,SHOWDIR="false",SHOWRC="true",TARGETANCHOR=3,RCSCALE=0.5,MAXBICONS=6,FADESECS=15,RCHOFFSET=0,TARGETHOFFSET=20,RCANCHOR=3,CLASSVOFFSET=0,SHOWCLASS="false",DSCALE=0.45,OORHOFFSET=0,TARGETONBAR=1,SCALE=0.45,OORONBAR=1,BUFFDOUBLE="true",BUFFANCHOR=2,CLASSONBAR=1,OORANCHOR=1,RCONBAR=1,MAXDICONS=4,CLASSSCALE=0.5,SHOWROLE="false",CLASSANCHOR=1,CLASSHOFFSET=0,DEBUFFONBAR=1,TARGETEN="true",BUFFI15EN="true",BUFFFADESECS=15,OORSCALE=0.5,SHOWDIRMOUSE="false",OOREN="false",TARGETSCALE=0.3}
Icons~f~2!{RCEN="true",I15EN="true",CLASSEN="false",FADE="true",BUFFFADE="true",DEBUFFANCHOR=1,RCVOFFSET=0,OORVOFFSET=0,DEBUFFDOUBLE="true",TARGETVOFFSET=0,BUFFONBAR=1,SHOWDIR="false",SHOWRC="true",TARGETANCHOR=3,RCSCALE=0.5,MAXBICONS=10,FADESECS=15,RCHOFFSET=0,TARGETHOFFSET=20,RCANCHOR=3,CLASSVOFFSET=0,SHOWCLASS="false",DSCALE=0.4,OORHOFFSET=0,TARGETONBAR=1,SCALE=0.4,OORONBAR=1,BUFFDOUBLE="true",BUFFANCHOR=2,CLASSONBAR=1,OORANCHOR=1,RCONBAR=1,MAXDICONS=5,CLASSSCALE=0.5,SHOWROLE="false",CLASSANCHOR=1,CLASSHOFFSET=0,DEBUFFONBAR=1,TARGETEN="true",BUFFI15EN="true",BUFFFADESECS=15,OORSCALE=0.5,SHOWDIRMOUSE="false",OOREN="false",TARGETSCALE=0.3}
Icons~f~3!{RCEN="false",I15EN="true",CLASSEN="false",FADE="true",BUFFFADE="true",DEBUFFANCHOR=1,RCVOFFSET=0,OORVOFFSET=0,DEBUFFDOUBLE="true",TARGETVOFFSET=0,BUFFONBAR=1,SHOWDIR="false",SHOWRC="true",TARGETANCHOR=3,RCSCALE=0.5,MAXBICONS=8,FADESECS=15,RCHOFFSET=0,TARGETHOFFSET=20,RCANCHOR=1,CLASSVOFFSET=0,SHOWCLASS="false",DSCALE=0.55,OORHOFFSET=0,TARGETONBAR=1,SCALE=0.55,OORONBAR=1,BUFFDOUBLE="true",BUFFANCHOR=2,CLASSONBAR=1,OORANCHOR=1,RCONBAR=1,MAXDICONS=3,CLASSSCALE=0.5,SHOWROLE="false",CLASSANCHOR=1,CLASSHOFFSET=0,DEBUFFONBAR=1,TARGETEN="true",BUFFI15EN="true",BUFFFADESECS=15,OORSCALE=0.5,SHOWDIRMOUSE="false",OOREN="false",TARGETSCALE=0.3}
Icons~d!4~5~6~
Icons~f~7!{RCEN="false",I15EN="true",CLASSEN="false",SHOWDIRMOUSE="false",BUFFFADE="true",DEBUFFANCHOR=1,RCVOFFSET=0,OORVOFFSET=0,DEBUFFDOUBLE="false",TARGETVOFFSET=0,BUFFONBAR=1,SHOWDIR="false",SHOWRC="true",TARGETANCHOR=3,RCSCALE=0.5,MAXBICONS=3,TARGETEN="true",FADESECS=9,RCHOFFSET=0,TARGETHOFFSET=20,CLASSONBAR=1,CLASSVOFFSET=0,TARGETSCALE=0.3,DSCALE=0.45,SCALE=0.45,TARGETONBAR=1,BUFFDOUBLE="false",OORONBAR=1,BUFFANCHOR=2,RCANCHOR=1,OORANCHOR=1,DOUBLE="false",RCONBAR=1,MAXDICONS=2,CLASSSCALE=0.5,CLASSANCHOR=1,SHOWCLASS="false",CLASSHOFFSET=0,DEBUFFONBAR=1,SHOWROLE="false",BUFFI15EN="true",BUFFFADESECS=9,OORSCALE=0.5,FADE="true",OOREN="false",OORHOFFSET=0}
Icons~f~8!{RCEN="false",I15EN="true",CLASSEN="false",SHOWDIRMOUSE="false",BUFFFADE="true",DEBUFFANCHOR=1,RCVOFFSET=0,OORVOFFSET=0,DEBUFFDOUBLE="true",TARGETVOFFSET=0,BUFFONBAR=1,SHOWDIR="false",SHOWRC="true",TARGETANCHOR=3,RCSCALE=0.5,MAXBICONS=8,FADESECS=15,RCHOFFSET=0,TARGETHOFFSET=20,RCANCHOR=1,CLASSVOFFSET=0,SHOWCLASS="false",DSCALE=0.55,OORHOFFSET=0,TARGETONBAR=1,SCALE=0.55,OORONBAR=1,BUFFDOUBLE="true",BUFFANCHOR=2,CLASSONBAR=1,OORANCHOR=1,RCONBAR=1,MAXDICONS=3,CLASSSCALE=0.5,SHOWROLE="false",CLASSANCHOR=1,CLASSHOFFSET=0,DEBUFFONBAR=1,TARGETEN="true",BUFFI15EN="true",BUFFFADESECS=15,OORSCALE=0.5,FADE="true",OOREN="false",TARGETSCALE=0.3}
Icons~d!9~
Icons~f~10!{RCEN="false",I15EN="true",CLASSEN="false",SHOWDIRMOUSE="false",BUFFFADE="true",DEBUFFANCHOR=1,RCVOFFSET=0,OORVOFFSET=0,DEBUFFDOUBLE="false",TARGETVOFFSET=0,BUFFONBAR=1,SHOWDIR="false",SHOWRC="true",TARGETANCHOR=3,RCSCALE=0.5,MAXBICONS=8,FADESECS=15,RCHOFFSET=0,TARGETHOFFSET=25,RCANCHOR=1,CLASSVOFFSET=0,SHOWCLASS="false",DSCALE=0.3,OORHOFFSET=0,TARGETONBAR=1,SCALE=0.3,OORONBAR=1,BUFFDOUBLE="false",BUFFANCHOR=2,CLASSONBAR=1,OORANCHOR=1,RCONBAR=1,MAXDICONS=4,CLASSSCALE=0.5,SHOWROLE="false",CLASSANCHOR=1,CLASSHOFFSET=0,DEBUFFONBAR=1,TARGETEN="true",BUFFI15EN="true",BUFFFADESECS=15,OORSCALE=0.5,FADE="true",OOREN="false",TARGETSCALE=0.3}
RaidIcon~f~1!{SQUARE="true",CIRCLE="true",DIAMOND="true",SHOW="true",SKULL="true",TRIANGLE="true",STAR="true",MOON="true",CROSS="true"}
RaidIcon~d!2~3~4~5~6~7~8~9~10~
IconText~f~1!{DURWARN=3,BUFFSSDUR="false",BUFFOUTLINE=2,BUFFDURTHRH=9,SCNT="true",DURTHRH=9,FONT="Swansea",BUFFFONT="Swansea",BUFFSCNT="true",SSCNT="false",OUTLINE=2,SCALE=0.8,BUFFDURWARN=3,HEIGHT=10,BUFFSSCNT="false",SDUR="true",BUFFHEIGHT=10,SSDUR="false",BUFFSDUR="true"}
IconText~f~2!{DURWARN=3,BUFFSSDUR="false",BUFFOUTLINE=2,BUFFDURTHRH=9,SCNT="true",DURTHRH=9,FONT="Swansea",BUFFFONT="Swansea",BUFFSCNT="true",SSCNT="false",OUTLINE=2,SCALE=0.7,BUFFDURWARN=3,HEIGHT=10,BUFFSSCNT="false",SDUR="true",BUFFHEIGHT=10,SSDUR="false",BUFFSDUR="true"}
IconText~d!3~4~5~6~7~8~9~10~
BarVisibility~f~1!{ALERTIC=1,ALERTOC=0.9,HIDEOOR="false"}
BarVisibility~d!2~3~4~5~6~
BarVisibility~f~7!{ALERTIC=0.95,ALERTOC=0.75,HIDEOOR="false"}
BarVisibility~f~8!{ALERTIC=1,ALERTOC=0.9,HIDEOOR="false"}
BarVisibility~d!9~10~
BarSort~f~1!{SUBORDER=2,OORLAST="false",RAIDORDER=3,SUBPF="true"}
BarSort~f~2!{SUBORDER=1,OORLAST="false",RAIDORDER=3,SUBPF="true"}
BarSort~d!3~4~5~6~7~8~9~10~
BarAggro~f~1!{R=1,ALERTIND=2,G=0,TEXTFORMAT=3,SHOW="true",SHOWTEXTPCT="true",B=0,SHOWTEXT="true",SHOWIND="true",ALERT=2}
BarAggro~d!2~3~4~5~6~7~8~9~10~
AuxBarFrame~f~1!{OVERLAP=1}
AuxBarFrame~d!2~3~4~5~6~7~8~9~10~
AuxBar^1~f~1!{SIZE=1,USE=5,R=1,COLOUR=1,ANCHOR=2,DEPTH=2,OFFSET=-2,OTYPE=1,A=1,B=1,G=1,TEXT="false"}
AuxBar^1~d!2~3~4~5~6~7~8~9~
AuxBar^1~f~10!{SIZE=1,USE=5,R=1,COLOUR=1,ANCHOR=2,TEXT="true",OFFSET=-10,DEPTH=10,A=1,B=1,G=1,OTYPE=1}
AuxBar^2~f~1!{SIZE=1,USE=5,R=1,COLOUR=1,ANCHOR=1,DEPTH=2,OFFSET=-2,OTYPE=1,A=1,B=1,G=1,TEXT="false"}
AuxBar^2~d!2~3~4~5~6~7~8~9~
AuxBar^2~f~10!{SIZE=1,USE=1,R=1,COLOUR=1,ANCHOR=1,TEXT="false",OFFSET=-2,DEPTH=2,A=1,B=1,G=1,OTYPE=1}
AuxBar^3~f~1!{SIZE=1,USE=4,R=1,COLOUR=1,ANCHOR=4,DEPTH=8,OFFSET=0,OTYPE=1,A=1,B=1,G=1,TEXT="true"}
AuxBar^3~d!2~
AuxBar^3~f~3!{SIZE=1,USE=4,R=1,COLOUR=2,ANCHOR=4,TEXT="true",OFFSET=0,DEPTH=8,G=1,B=1,A=1,OTYPE=1}
AuxBar^3~d!4~5~6~
AuxBar^3~f~7!{SIZE=1,USE=1,R=1,COLOUR=2,G=1,ANCHOR=4,OFFSET=0,TEXT="false",B=1,A=1,OTYPE=1,DEPTH=8}
AuxBar^3~f~8!{SIZE=1,USE=4,R=1,COLOUR=2,G=1,ANCHOR=4,OFFSET=0,TEXT="true",B=1,A=1,OTYPE=1,DEPTH=8}
AuxBar^3~d!9~
AuxBar^3~f~10!{SIZE=1,USE=1,R=1,COLOUR=2,ANCHOR=4,TEXT="false",OFFSET=0,DEPTH=8,A=1,B=1,G=1,OTYPE=1}
AuxBar^4~f~1!{SIZE=1,USE=10,R=0.42,COLOUR=1,ANCHOR=2,DEPTH=14,OFFSET=-14,OTYPE=3,A=0.1,B=0.192,G=0.192,TEXT="true"}
AuxBar^4~d!2~
AuxBar^4~f~3!{SIZE=1,USE=9,R=0.42,COLOUR=1,ANCHOR=2,TEXT="true",OFFSET=-10,DEPTH=10,G=0.192,B=0.192,A=0.7,OTYPE=3}
AuxBar^4~d!4~5~6~
AuxBar^4~f~7!{SIZE=1,USE=1,R=0.42,COLOUR=1,G=0.192,ANCHOR=2,OFFSET=-10,TEXT="false",B=0.192,A=0.7,OTYPE=3,DEPTH=10}
AuxBar^4~f~8!{SIZE=1,USE=9,R=0.42,COLOUR=1,G=0.192,ANCHOR=2,OFFSET=-10,TEXT="true",B=0.192,A=0.7,OTYPE=3,DEPTH=10}
AuxBar^4~d!9~
AuxBar^4~f~10!{SIZE=1,USE=1,R=0.42,COLOUR=1,ANCHOR=2,TEXT="true",OFFSET=-10,DEPTH=10,A=0.7,B=0.192,G=0.192,OTYPE=3}
AuxBar^5~f~1!{SIZE=1,USE=11,R=1,COLOUR=1,ANCHOR=1,DEPTH=10,OFFSET=-10,OTYPE=3,A=0.7,B=1,G=1,TEXT="true"}
AuxBar^5~d!2~3~4~5~6~
AuxBar^5~f~7!{SIZE=1,USE=1,R=1,COLOUR=1,G=1,ANCHOR=1,OFFSET=-10,TEXT="false",B=1,A=0.7,OTYPE=3,DEPTH=10}
AuxBar^5~f~8!{SIZE=1,USE=11,R=1,COLOUR=1,G=1,ANCHOR=1,OFFSET=-10,TEXT="true",B=1,A=0.7,OTYPE=3,DEPTH=10}
AuxBar^5~d!9~
AuxBar^5~f~10!{SIZE=1,USE=1,R=1,COLOUR=1,ANCHOR=1,TEXT="true",OFFSET=-10,DEPTH=10,A=0.7,B=1,G=1,OTYPE=3}
AuxBar^6~f~1!{SIZE=1,USE=6,R=1,COLOUR=2,ANCHOR=3,DEPTH=2,OFFSET=0,OTYPE=1,A=1,B=1,G=1,TEXT="false"}
AuxBar^6~d!2~
AuxBar^6~f~3!{SIZE=1,USE=1,R=1,COLOUR=2,ANCHOR=4,TEXT="false",OFFSET=0,DEPTH=5,G=1,B=1,A=1,OTYPE=1}
AuxBar^6~d!4~5~6~7~8~9~10~
AuxBar^7~f~1!{SIZE=0.98,USE=6,R=1,COLOUR=1,ANCHOR=4,DEPTH=2,OFFSET=0,OTYPE=1,A=1,B=1,G=1,TEXT="false"}
AuxBar^7~d!2~
AuxBar^7~f~3!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=4,TEXT="false",OFFSET=0,DEPTH=2,G=1,B=1,A=1,OTYPE=1}
AuxBar^7~d!4~5~6~7~8~9~10~
AuxBar^8~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,DEPTH=5,OFFSET=1,OTYPE=1,A=1,B=1,G=1,TEXT="false"}
AuxBar^8~d!2~3~4~5~6~7~8~9~10~
AuxBar^9~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,DEPTH=5,OFFSET=1,OTYPE=1,A=1,B=1,G=1,TEXT="false"}
AuxBar^9~d!2~3~4~5~6~7~8~9~10~
AuxBarText^1~f~1!{COLB=1,MAXCHARS=0,COLDA=0.5,OUTLINE=1,COLTYPE=1,HEIGHT=9,OFFSET=0,ALIGN=2,FONT="Friz Quadrata TT",COLG=1,COLA=1,COLR=1}
AuxBarText^1~d!2~3~4~5~6~7~8~9~
AuxBarText^1~f~10!{COLB=1,MAXCHARS=0,COLDA=0.5,COLR=1,COLTYPE=1,HEIGHT=9,OFFSET=0,COLG=1,FONT="Friz Quadrata TT",ALIGN=2,COLA=1,OUTLINE=2}
AuxBarText^2~f~1!{COLB=1,MAXCHARS=0,COLDA=0.5,OUTLINE=1,COLTYPE=1,HEIGHT=9,OFFSET=0,ALIGN=2,FONT="Friz Quadrata TT",COLG=1,COLA=0.98,COLR=1}
AuxBarText^2~d!2~3~4~5~6~7~8~9~10~
AuxBarText^3~f~1!{COLB=1,MAXCHARS=0,COLDA=0.5,OUTLINE=1,COLTYPE=1,HEIGHT=9,OFFSET=0,ALIGN=2,FONT="Friz Quadrata TT",COLG=1,COLA=0.98,COLR=1}
AuxBarText^3~d!2~3~4~5~6~7~8~9~10~
AuxBarText^4~f~1!{COLB=1,MAXCHARS=10,COLDA=0.5,OUTLINE=2,COLTYPE=3,HEIGHT=9,OFFSET=0,ALIGN=2,FONT="Mystic Orbs",COLG=1,COLA=1,COLR=1}
AuxBarText^4~d!2~3~4~5~6~7~8~9~10~
AuxBarText^5~f~1!{COLB=1,MAXCHARS=10,COLDA=0.5,OUTLINE=2,COLTYPE=1,HEIGHT=9,OFFSET=0,ALIGN=2,FONT="Mystic Orbs",COLG=1,COLA=1,COLR=1}
AuxBarText^5~d!2~3~4~5~6~7~8~9~10~
AuxBarText^6~f~1!{COLB=1,MAXCHARS=0,COLDA=0.5,OUTLINE=1,COLTYPE=1,HEIGHT=9,OFFSET=0,ALIGN=2,FONT="Friz Quadrata TT",COLG=1,COLA=0.98,COLR=1}
AuxBarText^6~d!2~3~4~5~6~7~8~9~10~
AuxBarText^7~f~1!{COLB=1,MAXCHARS=0,COLDA=0.5,OUTLINE=1,COLTYPE=1,HEIGHT=9,OFFSET=0,ALIGN=2,FONT="Friz Quadrata TT",COLG=1,COLA=0.98,COLR=1}
AuxBarText^7~d!2~3~4~5~6~7~8~9~10~
AuxBarText^8~f~1!{COLB=1,MAXCHARS=0,COLDA=0.5,OUTLINE=1,COLTYPE=1,HEIGHT=9,OFFSET=0,ALIGN=2,FONT="Friz Quadrata TT",COLG=1,COLA=0.98,COLR=1}
AuxBarText^8~d!2~3~4~5~6~7~8~9~10~
AuxBarText^9~f~1!{COLB=1,MAXCHARS=0,COLDA=0.5,OUTLINE=1,COLTYPE=1,HEIGHT=9,OFFSET=0,ALIGN=2,FONT="Friz Quadrata TT",COLG=1,COLA=0.98,COLR=1}
AuxBarText^9~d!2~3~4~5~6~7~8~9~10~
Complete!]]
HealBot_ExtraSkinData[22]=[[Skin
Bottoms Up hRaid 25
Author~v!Monti of Terenas
DuplicateBars~v!true
Chat~t!{EOCOOM="false",EOCOOMV=20,MSG="Casting #s on #n",RESONLY="true",CHAN="",NOTIFY=0}
General~t!{OFREQ=0.07,OMIN=0.1,OMAX=0.95,HIDEBOSSF="true",HIDEPARTYF="false",FLUIDFREQ=10,STICKYFRAME="true",STICKYSENSITIVITY=35,HIDERAIDF="true",FLUIDBARS="true",HIDEPTF="false"}
Healing~t!{TINCSELF="false",GROUPPETS="true",TARGETINCOMBAT=2,TINCPET="false",FONLYFRIEND="false",FEXRAID="false",TONLYFRIEND="false",FALWAYSSHOW="false",FOCUSINCOMBAT=2,TALWAYSSHOW="false",SELFPET=0,TINCGROUP=1,TEXRAID="false",TINCRAID=1}
Enemy~t!{ENEMYTARGET="false",INCTANKS="true",INCMYTAR="false",INCARENA="true",INCARENAPETS="false",ENEMYTARGETSIZE=40,INCSELF="false",NUMBOSS=2,EXISTSHOWPTAR=1,HIDE="true",EXISTSHOWBOSS="true",DOUBLEWIDTH="false",EXISTSHOWARENA=3}
FrameAlias~f~1!{SIZE=12,NAME="",R=1,ALIAS="Raid",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~2!{A=1,NAME="Tanks",R=1,ALIAS="Tanks",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~3!{A=1,NAME="",R=1,ALIAS="Not Used",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~4!{A=1,NAME="",R=1,ALIAS="NotUsed",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~5!{A=1,NAME="",R=1,ALIAS="Not Used",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~6!{A=1,NAME="",R=1,ALIAS="Vehicle",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~7!{A=1,NAME="Pets",R=1,ALIAS="Pets",G=1,SHOW="true",OFFSET=0,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~8!{A=1,NAME="",R=1,ALIAS="Target",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~9!{A=1,NAME="",R=1,ALIAS="Focus",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~10!{A=1,NAME="Enemy",R=1,ALIAS="Enemy",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAliasBar~f~1!{A=0.5,WIDTH=0.7,B=0.25,HEIGHT=20,R=0.1,G=0.25,TEXTURE="HealBot 10"}
FrameAliasBar~d!2~3~4~5~6~
FrameAliasBar~f~7!{A=0.4,TEXTURE="HealBot 10",B=0,HEIGHT=15,R=0,G=0,WIDTH=0.9}
FrameAliasBar~f~8!{A=0.5,TEXTURE="HealBot 10",B=0.25,HEIGHT=20,R=0.1,G=0.25,WIDTH=0.7}
FrameAliasBar~d!9~
FrameAliasBar~f~10!{A=0.4,TEXTURE="HealBot 10",B=0.078,HEIGHT=15,R=0.494,G=0.078,WIDTH=0.9}
Frame~f~1!{BACKR=0.102,SFOFFSETH=0,BORDERR=0.1,SFOFFSETV=0,LOCKED="false",OPENSOUND="false",BORDERA=0.04,BORDERG=0.1,TIPLOC=3,BACKB=0.702,BACKA=0,SCALE=1,BORDERB=0.1,AUTOCLOSE="false",BACKG=0.102}
Frame~f~2!{BACKR=0.102,BORDERR=0.1,SFOFFSETV=-5,TIPLOC=4,LOCKED="true",SCALE=1,BORDERA=0.04,BORDERG=0.1,BACKG=0.102,BACKB=0.702,BACKA=0,OPENSOUND="false",BORDERB=0.1,AUTOCLOSE="false",SFOFFSETH=0}
Frame~f~3!{BACKR=0.1,SFOFFSETH=0,BORDERR=0.1,SFOFFSETV=0,LOCKED="false",OPENSOUND="false",BORDERA=0.04,BORDERG=0.1,TIPLOC=5,BACKB=0.7,BACKA=0.1,SCALE=1,BORDERB=0.1,AUTOCLOSE="false",BACKG=0.1}
Frame~d!4~
Frame~f~5!{BACKR=0.1,BORDERR=0.1,SFOFFSETV=0,TIPLOC=2,LOCKED="true",SCALE=1,BORDERA=0.04,BORDERG=0.1,BACKG=0.1,BACKB=0.7,BACKA=0.1,OPENSOUND="false",BORDERB=0.1,AUTOCLOSE="false",SFOFFSETH=0}
Frame~f~6!{BACKR=0.1,BORDERR=0.1,SFOFFSETV=0,TIPLOC=5,LOCKED="false",SCALE=1,BORDERA=0.04,BORDERG=0.1,BACKG=0.1,BACKB=0.7,BACKA=0.1,OPENSOUND="false",BORDERB=0.1,AUTOCLOSE="false",SFOFFSETH=0}
Frame~f~7!{BACKR=0.1,BORDERR=0.1,SFOFFSETV=6,TIPLOC=5,LOCKED="false",SCALE=1,BORDERA=0.04,BORDERG=0.1,BACKG=0.1,BACKB=0.7,BACKA=0.1,OPENSOUND="false",BORDERB=0.1,AUTOCLOSE="false",SFOFFSETH=5}
Frame~f~8!{BORDERR=0.1,SFOFFSETH=0,AUTOCLOSE="false",BORDERB=0.1,LOCKED="false",OPENSOUND="false",BORDERA=0.04,SFOFFSETV=0,TIPLOC=5,BACKB=0.7,BACKA=0.1,SCALE=1,BACKG=0.1,BORDERG=0.1,BACKR=0.1}
Frame~d!9~
Frame~f~10!{BORDERR=1,SFOFFSETH=4,AUTOCLOSE="false",BORDERB=0,LOCKED="false",OPENSOUND="false",BORDERA=1,SFOFFSETV=0,TIPLOC=2,BACKB=0.7,BACKA=0.1,SCALE=1,BACKG=0.1,BORDERG=0,BACKR=0.1}
StickyFrames~f~1!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~f~2!{STUCK="true",STUCKTOPOINT="TOPLEFT",STUCKTO=1,STUCKPOINT="BOTTOMLEFT"}
StickyFrames~f~3!{STUCK="false",STUCKTOPOINT="RIGHT",STUCKTO=2,STUCKPOINT="LEFT"}
StickyFrames~f~4!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~d!5~6~
StickyFrames~f~7!{STUCK="true",STUCKTOPOINT="BOTTOMLEFT",STUCKTO=1,STUCKPOINT="TOPLEFT"}
StickyFrames~f~8!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~d!9~
StickyFrames~f~10!{STUCK="true",STUCKTOPOINT="TOPLEFT",STUCKTO=1,STUCKPOINT="TOPRIGHT"}
HealGroups~f~1!{FRAME=1,STATE="false",NAME="Self"}
HealGroups~f~2!{FRAME=2,STATE="true",NAME="Main tanks"}
HealGroups~f~3!{FRAME=1,STATE="false",NAME="Healers"}
HealGroups~f~4!{FRAME=1,STATE="false",NAME="Group"}
HealGroups~f~5!{FRAME=1,STATE="false",NAME="Private List"}
HealGroups~f~6!{FRAME=1,STATE="true",NAME="Raid"}
HealGroups~f~7!{FRAME=1,STATE="false",NAME="Vehicle"}
HealGroups~f~8!{FRAME=7,STATE="true",NAME="Pets"}
HealGroups~f~9!{FRAME=8,STATE="false",NAME="Target"}
HealGroups~f~10!{FRAME=9,STATE="false",NAME="Focus"}
HealGroups~f~11!{FRAME=10,STATE="true",NAME="Enemy"}
Anchors~f~1!{Y=64.24,GROW=2,BARS=1,FRAME=1,X=72.6}
Anchors~f~2!{Y=63.82,GROW=1,BARS=1,FRAME=2,X=72.6}
Anchors~f~3!{Y=22.89,GROW=1,BARS=1,FRAME=6,X=31.19}
Anchors~f~4!{Y=53,GROW=2,BARS=1,FRAME=1,X=53}
Anchors~f~5!{Y=50.59,GROW=2,BARS=1,FRAME=1,X=58.13}
Anchors~f~6!{Y=55,GROW=2,BARS=1,FRAME=1,X=55}
Anchors~f~7!{Y=54.66,GROW=2,BARS=1,FRAME=1,X=72.77}
Anchors~f~8!{Y=54.07,GROW=2,BARS=1,FRAME=1,X=69.39}
Anchors~f~9!{Y=55.81,GROW=2,BARS=1,FRAME=1,X=62.21}
Anchors~f~10!{Y=64.24,GROW=2,BARS=1,FRAME=3,X=72.74}
HeadBar~f~1!{SHOW="true",WIDTH=0.95,B=0.102,R=0.102,HEIGHT=28,A=0.4,G=0.102,TEXTURE="Tukui"}
HeadBar~f~2!{SHOW="true",TEXTURE="Tukui",R=0.102,B=0.102,HEIGHT=62,A=0.4,G=0.102,WIDTH=0.7}
HeadBar~f~3!{SHOW="true",TEXTURE="Tukui2",R=0.102,B=0.102,HEIGHT=60,A=0.4,G=0.102,WIDTH=0.95}
HeadBar~d!4~5~6~
HeadBar~f~7!{SHOW="false",TEXTURE="Tukui",R=0.102,B=0.102,HEIGHT=28,A=0.4,G=0.102,WIDTH=0.95}
HeadBar~f~8!{SHOW="true",TEXTURE="Tukui2",R=0.102,B=0.102,HEIGHT=60,A=0.4,G=0.102,WIDTH=0.95}
HeadBar~d!9~
HeadBar~f~10!{SHOW="true",WIDTH=0.95,B=0.102,R=0.102,HEIGHT=28,A=0.4,G=0.102,TEXTURE="Tukui2"}
HeadText~f~1!{A=1,B=0.961,OFFSET=0,R=1,FONT="Friz Quadrata TT",HEIGHT=11,G=0.996,OUTLINE=1}
HeadText~d!2~3~4~5~6~7~8~9~10~
HealBar~f~1!{HEIGHT=60,GRPCOLS="false",CMARGIN=0,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=1,NUMCOLS=1,OFIX=2,RMARGIN=0,WIDTH=70}
HealBar~f~2!{HEIGHT=60,GRPCOLS="false",CMARGIN=0,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=1,NUMCOLS=1,OFIX=2,RMARGIN=0,WIDTH=150}
HealBar~f~3!{HEIGHT=60,GRPCOLS="false",CMARGIN=2,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=1,NUMCOLS=2,OFIX=1,RMARGIN=2,WIDTH=80}
HealBar~f~4!{HEIGHT=60,GRPCOLS="false",CMARGIN=2,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=80,RMARGIN=2,OFIX=1,NUMCOLS=3,LOWMANA=1}
HealBar~d!5~6~
HealBar~f~7!{HEIGHT=25,GRPCOLS="false",CMARGIN=0,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",NUMCOLS=6,RMARGIN=0,OFIX=2,WIDTH=71,LOWMANA=1}
HealBar~f~8!{HEIGHT=60,GRPCOLS="false",CMARGIN=2,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",NUMCOLS=3,RMARGIN=2,OFIX=1,WIDTH=80,LOWMANA=1}
HealBar~d!9~
HealBar~f~10!{HEIGHT=50,GRPCOLS="false",CMARGIN=0,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=1,WIDTH=70,OFIX=2,RMARGIN=0,NUMCOLS=2}
BarCol~f~1!{BACK=3,BA=0.4,BB=0,DISA=0.1,BR=0,HB=0.4,BG=0,BOUT=2,HA=1,HR=0.2,ORA=0.4,HG=0.4,HLTH=2}
BarCol~d!2~3~4~5~6~7~8~9~10~
BarIACol~f~1!{AC=3,AB=1,AA=0.6,AR=1,AG=1,IC=2,IB=0.2,IA=0.6,IR=0.2,IG=0.8}
BarIACol~d!2~3~4~5~6~7~8~9~10~
BarText~f~1!{HHEIGHT=10,TAGOOR="",IGNOREONFULL="true",MAXCHARS=12,CLASSONBAR="false",HFONT="Friz Quadrata TT",OVERHEAL=1,HOUTLINE=1,INCHEALS=2,HLTHTXTANCHOR=1,HLTHTYPE=3,HMAXCHARS=0,INCABSORBS=1,NUMFORMAT2=1,HLTHONBAR="false",NUMFORMAT1=11,OUTLINE=2,TAGRIP="",HEIGHT=10,NAMEONBAR="true",SHOWROLE="true",HALIGN=2,TAGDC="",OFFSET=5,FONT="Friz Quadrata TT",CLASSTYPE=1,HOFFSET2=0,ALIGN=2,TAGR="[ R ] ",HOFFSET=0}
BarText~d!2~3~4~5~6~
BarText~f~7!{HLTHONBAR="false",TAGOOR="",OVERHEAL=1,MAXCHARS=12,HMAXCHARS=0,HOFFSET=0,HOUTLINE=1,IGNOREONFULL="true",INCHEALS=2,HLTHTXTANCHOR=1,HLTHTYPE=3,CLASSONBAR="false",CLASSTYPE=1,NUMFORMAT2=1,HHEIGHT=10,NUMFORMAT1=11,TAGDC="",TAGRIP="",HEIGHT=10,NAMEONBAR="true",SHOWROLE="true",HALIGN=2,OFFSET=0,OUTLINE=2,FONT="Friz Quadrata TT",INCABSORBS=1,HOFFSET2=0,ALIGN=2,TAGR="[ R ] ",HFONT="Friz Quadrata TT"}
BarText~f~8!{HLTHONBAR="false",TAGOOR="",OVERHEAL=1,MAXCHARS=12,HMAXCHARS=0,HOFFSET=0,HOUTLINE=1,IGNOREONFULL="true",INCHEALS=2,HLTHTXTANCHOR=1,HLTHTYPE=3,CLASSONBAR="false",CLASSTYPE=1,NUMFORMAT2=1,HHEIGHT=10,NUMFORMAT1=11,TAGDC="",TAGRIP="",HEIGHT=10,NAMEONBAR="true",SHOWROLE="true",HALIGN=2,OFFSET=5,OUTLINE=2,FONT="Friz Quadrata TT",INCABSORBS=1,HOFFSET2=0,ALIGN=2,TAGR="[ R ] ",HFONT="Friz Quadrata TT"}
BarText~d!9~
BarText~f~10!{HLTHONBAR="false",TAGOOR="",OVERHEAL=1,MAXCHARS=12,HMAXCHARS=0,HOFFSET=0,HOUTLINE=1,IGNOREONFULL="true",INCHEALS=2,HLTHTXTANCHOR=1,HLTHTYPE=3,CLASSONBAR="false",CLASSTYPE=1,NUMFORMAT2=1,HHEIGHT=10,NUMFORMAT1=11,TAGDC="",TAGRIP="",HEIGHT=10,NAMEONBAR="true",SHOWROLE="true",HALIGN=2,OFFSET=0,OUTLINE=2,FONT="Friz Quadrata TT",INCABSORBS=1,HOFFSET2=0,ALIGN=2,TAGR="[ R ] ",HFONT="Friz Quadrata TT"}
BarTextCol~f~1!{HCG=1,NDEBUFF="false",HCDA=0.7,NCDA=0.7,NCB=0,NCR=0.929,NCG=1,NCA=1,HCA=1,HCB=0,HCR=0.929,HDEBUFF="false",NAME=1,HLTH=3}
BarTextCol~d!2~3~4~5~6~7~8~9~10~
Icons~f~1!{SHOWBUFF="true",SHOWDEBUFF="true",FADESECS=15,I15EN="false",MAXDICONS=4,SHOWDIRMOUSE="false",SHOWDIR="false",FADE="false",DSCALE=0.55,ONBAR=1,SHOWRC="true",SCALE=0.55,DOUBLE="true",POSITION=2,MAXBICONS=6}
Icons~f~2!{SHOWBUFF="true",SHOWDEBUFF="true",FADESECS=15,I15EN="false",MAXDICONS=5,SHOWDIRMOUSE="false",SHOWDIR="false",FADE="false",DSCALE=0.55,ONBAR=1,SHOWRC="true",SCALE=0.55,DOUBLE="true",POSITION=2,MAXBICONS=10}
Icons~f~3!{SHOWBUFF="true",SHOWDEBUFF="true",FADESECS=15,I15EN="false",MAXDICONS=3,SHOWDIRMOUSE="false",SHOWDIR="false",FADE="false",DSCALE=0.55,ONBAR=1,SHOWRC="true",SCALE=0.55,DOUBLE="true",POSITION=2,MAXBICONS=8}
Icons~d!4~5~6~
Icons~f~7!{SHOWBUFF="true",SHOWDEBUFF="true",I15EN="false",FADESECS=15,POSITION=2,FADE="false",SHOWDIR="false",SHOWDIRMOUSE="false",DSCALE=0.55,ONBAR=1,SHOWRC="true",SCALE=0.55,DOUBLE="true",MAXDICONS=2,MAXBICONS=3}
Icons~f~8!{SHOWBUFF="true",SHOWDEBUFF="true",I15EN="false",FADESECS=15,POSITION=2,FADE="false",SHOWDIR="false",SHOWDIRMOUSE="false",DSCALE=0.55,ONBAR=1,SHOWRC="true",SCALE=0.55,DOUBLE="true",MAXDICONS=3,MAXBICONS=8}
Icons~d!9~
Icons~f~10!{SHOWBUFF="true",SHOWDEBUFF="true",I15EN="false",FADESECS=15,POSITION=2,FADE="false",SHOWDIR="false",SHOWDIRMOUSE="false",DSCALE=0.55,ONBAR=1,SHOWRC="true",SCALE=0.55,DOUBLE="true",MAXDICONS=4,MAXBICONS=8}
RaidIcon~f~1!{SQUARE="true",CIRCLE="true",DIAMOND="true",SHOW="true",MOON="true",TRIANGLE="true",STAR="true",SKULL="true",CROSS="true"}
RaidIcon~d!2~3~4~5~6~7~8~9~10~
IconText~f~1!{DURWARN=3,HEIGHT=10,SSCNT="false",FONT="Swansea",SCNT="true",DURTHRH=9,SCALE=0.8,SDUR="true",SSDUR="false",OUTLINE=2}
IconText~f~2!{DURWARN=3,HEIGHT=10,SSCNT="false",FONT="Swansea",SCNT="true",DURTHRH=9,SCALE=0.7,SDUR="true",SSDUR="false",OUTLINE=2}
IconText~d!3~4~5~6~7~8~9~10~
BarVisibility~f~1!{INCCLASSES=1,ALERTIC=1,ALERTOC=0.9,HIDEOOR="false"}
BarVisibility~d!2~3~4~5~6~7~8~9~10~
BarSort~f~1!{SUBORDER=1,OORLAST="false",RAIDORDER=3,SUBPF="true"}
BarSort~d!2~3~4~5~6~7~8~9~10~
BarAggro~f~1!{B=0,ALERTIND=2,G=0,TEXTFORMAT=3,SHOW="true",SHOWTEXTPCT="true",R=1,SHOWTEXT="true",SHOWIND="true",ALERT=2}
BarAggro~d!2~3~4~5~6~7~8~9~10~
AuxBarFrame~f~1!{OVERLAP=2}
AuxBarFrame~d!2~3~4~5~6~7~8~9~10~
AuxBar^1~f~1!{SIZE=1,USE=5,R=1,COLOUR=1,ANCHOR=2,OFFSET=0,DEPTH=2,OTYPE=1,B=1,G=1}
AuxBar^1~d!2~3~4~5~6~7~8~9~
AuxBar^1~f~10!{SIZE=1,USE=1,R=1,COLOUR=1,ANCHOR=2,OFFSET=0,DEPTH=2,OTYPE=1,B=1,G=1}
AuxBar^2~f~1!{SIZE=1,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=2,OTYPE=1,B=1,G=1}
AuxBar^2~d!2~3~4~5~6~7~8~9~10~
AuxBar^3~f~1!{SIZE=1,USE=1,R=1,COLOUR=2,ANCHOR=3,OFFSET=1,DEPTH=5,OTYPE=1,B=1,G=1}
AuxBar^3~d!2~3~4~5~6~7~8~9~10~
AuxBar^4~f~1!{SIZE=1,USE=1,R=1,COLOUR=2,ANCHOR=3,OFFSET=0,DEPTH=5,OTYPE=1,B=1,G=1}
AuxBar^4~d!2~3~4~5~6~7~8~9~10~
AuxBar^5~f~1!{SIZE=1,USE=4,R=1,COLOUR=1,ANCHOR=4,OFFSET=2,DEPTH=14,OTYPE=1,B=1,G=1}
AuxBar^5~d!2~3~4~5~6~
AuxBar^5~f~7!{SIZE=1,USE=1,R=1,COLOUR=1,ANCHOR=4,OFFSET=2,DEPTH=14,G=1,B=1,OTYPE=1}
AuxBar^5~f~8!{SIZE=1,USE=4,R=1,COLOUR=1,ANCHOR=4,OFFSET=2,DEPTH=14,G=1,B=1,OTYPE=1}
AuxBar^5~d!9~
AuxBar^5~f~10!{SIZE=1,USE=1,R=1,COLOUR=1,ANCHOR=4,OFFSET=2,DEPTH=14,OTYPE=1,B=1,G=1}
AuxBar^6~f~1!{SIZE=1,USE=1,R=1,COLOUR=2,ANCHOR=4,OFFSET=0,DEPTH=5,OTYPE=1,B=1,G=1}
AuxBar^6~d!2~3~4~5~6~7~8~9~10~
AuxBar^7~f~1!{SIZE=1,USE=5,R=1,COLOUR=1,ANCHOR=4,OFFSET=0,DEPTH=2,OTYPE=1,B=1,G=1}
AuxBar^7~d!2~3~4~5~6~7~8~9~
AuxBar^7~f~10!{SIZE=1,USE=1,R=1,COLOUR=1,ANCHOR=4,OFFSET=0,DEPTH=2,G=1,B=1,OTYPE=1}
AuxBar^8~f~1!{SIZE=1,USE=5,R=1,COLOUR=1,ANCHOR=1,OFFSET=0,DEPTH=2,OTYPE=1,B=1,G=1}
AuxBar^8~d!2~3~4~5~6~7~8~9~
AuxBar^8~f~10!{SIZE=1,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=0,DEPTH=2,G=1,B=1,OTYPE=1}
AuxBar^9~f~1!{SIZE=1,USE=5,R=1,COLOUR=1,ANCHOR=3,OFFSET=0,DEPTH=2,OTYPE=1,B=1,G=1}
AuxBar^9~d!2~3~4~5~6~7~8~9~
AuxBar^9~f~10!{SIZE=1,USE=1,R=1,COLOUR=1,ANCHOR=3,OFFSET=0,DEPTH=2,G=1,B=1,OTYPE=1}
Complete!]]
HealBot_ExtraSkinData[23]=[[Skin
Bottoms Up cGroup
Author~v!Monti of Terenas
DuplicateBars~v!false
Chat~t!{EOCOOM="false",EOCOOMV=20,MSG="Casting #s on #n",RESONLY="true",CHAN="",NOTIFY=0}
General~t!{OFREQ=0.07,OMIN=0.1,OMAX=0.95,HIDEBOSSF="false",HIDEPTF="false",HIDEPARTYF="false",HIDERAIDF="true",STICKYFRAME="true",STICKYSENSITIVITY=35,FLUIDBARS="false",FLUIDFREQ=10}
Healing~t!{TINCSELF="false",GROUPPETS="true",TARGETINCOMBAT=2,TINCRAID=1,FONLYFRIEND="false",SELFPET=0,TONLYFRIEND="false",FALWAYSSHOW="false",FOCUSINCOMBAT=2,TALWAYSSHOW="false",FEXRAID="false",TINCGROUP=1,TEXRAID="false",TINCPET="false"}
Enemy~t!{INCARENA="true",INCTANKS="true",INCMYTAR="false",ENEMYTARGET="false",INCARENAPETS="false",ENEMYTARGETSIZE=40,HIDE="true",NUMBOSS=2,EXISTSHOWPTAR=1,INCSELF="false",EXISTSHOWBOSS="true",DOUBLEWIDTH="false",EXISTSHOWARENA=3}
FrameAlias~f~1!{SIZE=12,NAME="",R=1,ALIAS="Group",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~2!{A=1,NAME="Tanks",R=1,ALIAS="Not Used",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~3!{A=1,NAME="",R=1,ALIAS="Not Used",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~4!{A=1,NAME="",R=1,ALIAS="NotUsed",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~5!{A=1,NAME="",R=1,ALIAS="Not Used",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~6!{A=1,NAME="",R=1,ALIAS="Vehicle",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~7!{A=1,NAME="",R=1,ALIAS="Pets",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~8!{A=1,NAME="",R=1,ALIAS="Target",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~9!{A=1,NAME="",R=1,ALIAS="Focus",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~10!{A=1,NAME="",R=1,ALIAS="Enemy",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAliasBar~f~1!{A=0.5,TEXTURE="HealBot 10",B=0.25,HEIGHT=20,R=0.1,G=0.25,WIDTH=0.7}
FrameAliasBar~d!2~3~4~5~6~7~8~9~10~
Frame~f~1!{SFOFFSETH=0,TIPLOC=2,BACKG=0.102,BACKB=0.702,LOCKED="false",SCALE=1,BORDERA=0.04,BORDERG=0.1,AUTOCLOSE="false",BORDERB=0.1,BACKA=0,OPENSOUND="false",SFOFFSETV=0,BACKR=0.102,BORDERR=0.1}
Frame~f~2!{SFOFFSETH=0,BACKR=0.102,BACKG=0.102,BACKB=0.702,LOCKED="false",OPENSOUND="false",BORDERA=0.04,BORDERG=0.1,AUTOCLOSE="false",BORDERB=0.1,BACKA=0,SCALE=1,TIPLOC=2,SFOFFSETV=-5,BORDERR=0.1}
Frame~f~3!{SFOFFSETH=0,TIPLOC=2,BACKG=0.102,BACKB=0.702,LOCKED="false",SCALE=1,BORDERA=0.04,BORDERG=0.1,AUTOCLOSE="false",BORDERB=0.1,BACKA=0,OPENSOUND="false",SFOFFSETV=0,BACKR=0.102,BORDERR=0.1}
Frame~d!4~5~6~
Frame~f~7!{SFOFFSETH=0,BACKR=0.102,BACKG=0.102,BACKB=0.702,LOCKED="false",OPENSOUND="false",BORDERA=0.04,BORDERG=0.1,AUTOCLOSE="false",BORDERB=0.1,BACKA=0,SCALE=1,TIPLOC=2,SFOFFSETV=9,BORDERR=0.1}
Frame~f~8!{BACKR=0.102,SFOFFSETV=0,BORDERR=0.1,TIPLOC=2,LOCKED="false",SCALE=1,BORDERA=0.04,BORDERG=0.1,BACKG=0.102,BACKB=0.702,BACKA=0,OPENSOUND="false",BORDERB=0.1,AUTOCLOSE="false",SFOFFSETH=0}
Frame~d!9~
Frame~f~10!{BACKR=0.102,SFOFFSETV=0,BORDERR=0.1,TIPLOC=2,LOCKED="false",SCALE=1,BORDERA=0.04,BORDERG=0.1,BACKG=0.102,BACKB=0.702,BACKA=0,OPENSOUND="false",BORDERB=0.1,AUTOCLOSE="false",SFOFFSETH=-2}
StickyFrames~f~1!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~f~2!{STUCK="false",STUCKTOPOINT="TOPLEFT",STUCKTO=1,STUCKPOINT="BOTTOMLEFT"}
StickyFrames~f~3!{STUCK="false",STUCKTOPOINT="RIGHT",STUCKTO=2,STUCKPOINT="LEFT"}
StickyFrames~f~4!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~d!5~6~
StickyFrames~f~7!{STUCK="true",STUCKTOPOINT="BOTTOMLEFT",STUCKTO=1,STUCKPOINT="TOPLEFT"}
StickyFrames~f~8!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~d!9~
StickyFrames~f~10!{STUCK="true",STUCKTOPOINT="TOPLEFT",STUCKTO=1,STUCKPOINT="BOTTOMLEFT"}
HealGroups~f~1!{FRAME=1,STATE="false",NAME="Self"}
HealGroups~f~2!{FRAME=1,STATE="true",NAME="Main tanks"}
HealGroups~f~3!{FRAME=1,STATE="true",NAME="Healers"}
HealGroups~f~4!{FRAME=1,STATE="true",NAME="Group"}
HealGroups~f~5!{FRAME=1,STATE="false",NAME="Private List"}
HealGroups~f~6!{FRAME=1,STATE="true",NAME="Raid"}
HealGroups~f~7!{FRAME=1,STATE="false",NAME="Vehicle"}
HealGroups~f~8!{FRAME=7,STATE="true",NAME="Pets"}
HealGroups~f~9!{FRAME=8,STATE="false",NAME="Target"}
HealGroups~f~10!{FRAME=9,STATE="false",NAME="Focus"}
HealGroups~f~11!{FRAME=10,STATE="true",NAME="Enemy"}
Anchors~f~1!{Y=68.88,GROW=2,BARS=1,FRAME=1,X=88.64}
Anchors~f~2!{Y=69.71,GROW=2,BARS=1,FRAME=2,X=88.66}
Anchors~f~3!{Y=22.89,GROW=2,BARS=1,FRAME=2,X=31.19}
Anchors~f~4!{Y=53,GROW=2,BARS=1,FRAME=2,X=53}
Anchors~f~5!{Y=50.59,GROW=2,BARS=1,FRAME=2,X=58.13}
Anchors~f~6!{Y=55,GROW=2,BARS=1,FRAME=2,X=55}
Anchors~f~7!{Y=36.3,GROW=2,BARS=1,FRAME=1,X=88.64}
Anchors~f~8!{Y=68.21,GROW=2,BARS=1,FRAME=2,X=88.64}
Anchors~f~9!{Y=68.21,GROW=2,BARS=1,FRAME=2,X=88.19}
Anchors~f~10!{Y=68.88,GROW=2,BARS=2,FRAME=2,X=88.57}
HeadBar~f~1!{SHOW="false",TEXTURE="Tukui2",R=0.102,B=0.102,HEIGHT=28,A=0.4,G=0.102,WIDTH=0.95}
HeadBar~d!2~3~4~5~6~7~8~9~10~
HeadText~f~1!{A=1,R=1,OFFSET=0,B=0.961,FONT="Friz Quadrata TT",HEIGHT=11,G=0.996,OUTLINE=1}
HeadText~d!2~3~4~5~6~7~8~9~10~
HealBar~f~1!{HEIGHT=70,GRPCOLS="false",CMARGIN=0,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=100,RMARGIN=0,OFIX=2,NUMCOLS=1,LOWMANA=1}
HealBar~f~2!{HEIGHT=60,GRPCOLS="false",CMARGIN=0,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=150,RMARGIN=0,OFIX=2,NUMCOLS=1,LOWMANA=1}
HealBar~f~3!{HEIGHT=60,GRPCOLS="false",CMARGIN=0,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=150,RMARGIN=0,OFIX=1,NUMCOLS=1,LOWMANA=1}
HealBar~d!4~5~6~
HealBar~f~7!{HEIGHT=40,GRPCOLS="false",CMARGIN=0,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=1,WIDTH=65,OFIX=2,RMARGIN=0,NUMCOLS=2}
HealBar~f~8!{HEIGHT=60,GRPCOLS="false",CMARGIN=0,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=1,WIDTH=150,OFIX=1,RMARGIN=0,NUMCOLS=1}
HealBar~d!9~
HealBar~f~10!{HEIGHT=45,GRPCOLS="false",CMARGIN=0,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",NUMCOLS=2,RMARGIN=0,OFIX=2,WIDTH=66,LOWMANA=1}
BarCol~f~1!{BACK=3,BA=0.75,BB=0,DISA=0.2,BR=0,HB=0.4,BG=0,HR=0.2,HA=1,HG=0.4,ORA=0.5,BOUT=1,HLTH=2}
BarCol~d!2~3~4~5~6~7~8~9~10~
BarIACol~f~1!{AC=3,AB=1,AA=0.6,AR=1,AG=1,IC=2,IB=0.2,IA=0.6,IR=0.2,IG=0.8}
BarIACol~d!2~3~4~5~6~7~8~9~10~
BarText~f~1!{HLTHONBAR="false",TAGOOR="",HOUTLINE=1,MAXCHARS=12,TAGRIP="",CLASSONBAR="false",OUTLINE=2,HOFFSET=0,OFFSET=5,INCHEALS=2,HLTHTXTANCHOR=1,HLTHTYPE=3,FONT="Friz Quadrata TT",CLASSTYPE=1,NUMFORMAT2=1,IGNOREONFULL="true",TAGDC="",NUMFORMAT1=11,NAMEONBAR="true",HEIGHT=10,HHEIGHT=10,SHOWROLE="true",HALIGN=2,OVERHEAL=1,HMAXCHARS=0,INCABSORBS=1,HOFFSET2=0,ALIGN=2,TAGR="",HFONT="Friz Quadrata TT"}
BarText~f~2!{HLTHONBAR="false",TAGOOR="",HOUTLINE=1,MAXCHARS=0,TAGRIP="",CLASSONBAR="false",OUTLINE=2,HOFFSET=0,OFFSET=5,INCHEALS=2,HLTHTXTANCHOR=1,HLTHTYPE=3,FONT="Friz Quadrata TT",CLASSTYPE=1,NUMFORMAT2=1,IGNOREONFULL="true",TAGDC="",NUMFORMAT1=11,NAMEONBAR="true",HEIGHT=10,HHEIGHT=10,SHOWROLE="true",HALIGN=2,OVERHEAL=1,HMAXCHARS=0,INCABSORBS=1,HOFFSET2=0,ALIGN=2,TAGR="",HFONT="Friz Quadrata TT"}
BarText~f~3!{HLTHONBAR="false",TAGOOR="",HOUTLINE=1,MAXCHARS=12,TAGRIP="",CLASSONBAR="false",OUTLINE=2,HOFFSET=0,OFFSET=10,INCHEALS=2,HLTHTXTANCHOR=1,HLTHTYPE=3,FONT="Friz Quadrata TT",CLASSTYPE=1,NUMFORMAT2=1,IGNOREONFULL="true",TAGDC="",NUMFORMAT1=11,NAMEONBAR="true",HEIGHT=10,HHEIGHT=10,SHOWROLE="true",HALIGN=2,OVERHEAL=1,HMAXCHARS=0,INCABSORBS=1,HOFFSET2=0,ALIGN=2,TAGR="",HFONT="Friz Quadrata TT"}
BarText~d!4~5~6~
BarText~f~7!{HHEIGHT=10,TAGOOR="",HOUTLINE=1,MAXCHARS=12,NUMFORMAT1=11,HMAXCHARS=0,HFONT="Friz Quadrata TT",OUTLINE=2,INCHEALS=2,OFFSET=2,HLTHTXTANCHOR=1,FONT="Friz Quadrata TT",HLTHTYPE=3,CLASSTYPE=1,NUMFORMAT2=1,IGNOREONFULL="true",TAGDC="",OVERHEAL=1,TAGRIP="",HEIGHT=10,NAMEONBAR="true",SHOWROLE="true",HALIGN=2,HLTHONBAR="false",CLASSONBAR="false",INCABSORBS=1,HOFFSET2=0,ALIGN=2,TAGR="",HOFFSET=0}
BarText~f~8!{HHEIGHT=10,TAGOOR="",HOUTLINE=1,MAXCHARS=12,NUMFORMAT1=11,HMAXCHARS=0,HFONT="Friz Quadrata TT",OUTLINE=2,INCHEALS=2,OFFSET=10,HLTHTXTANCHOR=1,FONT="Friz Quadrata TT",HLTHTYPE=3,CLASSTYPE=1,NUMFORMAT2=1,IGNOREONFULL="true",TAGDC="",OVERHEAL=1,TAGRIP="",HEIGHT=10,NAMEONBAR="true",SHOWROLE="true",HALIGN=2,HLTHONBAR="false",CLASSONBAR="false",INCABSORBS=1,HOFFSET2=0,ALIGN=2,TAGR="",HOFFSET=0}
BarText~d!9~
BarText~f~10!{HLTHONBAR="false",TAGOOR="",HOUTLINE=1,MAXCHARS=12,HHEIGHT=10,HMAXCHARS=0,HFONT="Friz Quadrata TT",OUTLINE=2,OFFSET=2,INCHEALS=2,HLTHTXTANCHOR=1,HLTHTYPE=3,FONT="Friz Quadrata TT",CLASSTYPE=1,NUMFORMAT2=1,IGNOREONFULL="true",TAGDC="",NUMFORMAT1=11,NAMEONBAR="true",HEIGHT=10,TAGRIP="",SHOWROLE="true",HALIGN=2,OVERHEAL=1,CLASSONBAR="false",INCABSORBS=1,HOFFSET2=0,ALIGN=2,TAGR="",HOFFSET=0}
BarTextCol~f~1!{HCG=1,HCA=1,NCB=0,NCDA=0.7,NAME=3,NCR=0.929,NCG=1,NCA=1,NDEBUFF="false",HCB=0,HCR=0.929,HDEBUFF="false",HLTH=3,HCDA=0.7}
BarTextCol~d!2~3~4~5~6~7~8~9~10~
Icons~f~1!{SHOWBUFF="true",POSITION=2,I15EN="true",FADESECS=15,MAXDICONS=4,SHOWDEBUFF="true",ONBAR=1,DOUBLE="true",DSCALE=0.55,SHOWDIR="false",SHOWRC="true",SCALE=0.55,SHOWDIRMOUSE="false",FADE="true",MAXBICONS=6}
Icons~f~2!{SHOWBUFF="true",POSITION=2,I15EN="true",FADESECS=15,MAXDICONS=5,SHOWDEBUFF="true",ONBAR=1,DOUBLE="true",DSCALE=0.55,SHOWDIR="false",SHOWRC="true",SCALE=0.55,SHOWDIRMOUSE="false",FADE="true",MAXBICONS=10}
Icons~f~3!{SHOWBUFF="true",POSITION=2,I15EN="true",FADESECS=15,MAXDICONS=3,SHOWDEBUFF="true",ONBAR=1,DOUBLE="true",DSCALE=0.55,SHOWDIR="false",SHOWRC="true",SCALE=0.55,SHOWDIRMOUSE="false",FADE="true",MAXBICONS=8}
Icons~d!4~5~6~
Icons~f~7!{SHOWBUFF="true",SHOWDEBUFF="true",FADESECS=15,MAXDICONS=2,DOUBLE="false",I15EN="true",ONBAR=1,FADE="true",DSCALE=0.45,SHOWDIR="false",SHOWRC="true",SCALE=0.45,SHOWDIRMOUSE="false",POSITION=2,MAXBICONS=3}
Icons~f~8!{SHOWBUFF="true",SHOWDEBUFF="true",FADESECS=15,MAXDICONS=3,DOUBLE="true",I15EN="true",ONBAR=1,FADE="true",DSCALE=0.55,SHOWDIR="false",SHOWRC="true",SCALE=0.55,SHOWDIRMOUSE="false",POSITION=2,MAXBICONS=8}
Icons~d!9~
Icons~f~10!{SHOWBUFF="true",SHOWDEBUFF="true",FADESECS=15,MAXDICONS=4,DOUBLE="true",I15EN="true",ONBAR=1,FADE="true",DSCALE=0.55,SHOWDIR="false",SHOWRC="true",SCALE=0.55,SHOWDIRMOUSE="false",POSITION=2,MAXBICONS=8}
RaidIcon~f~1!{SQUARE="true",CIRCLE="true",DIAMOND="true",SHOW="true",MOON="true",TRIANGLE="true",STAR="true",CROSS="true",SKULL="true"}
RaidIcon~d!2~3~4~5~6~7~8~9~10~
IconText~f~1!{SDUR="true",HEIGHT=10,SSCNT="false",FONT="Swansea",SCNT="true",DURTHRH=9,SCALE=0.8,DURWARN=3,SSDUR="false",OUTLINE=2}
IconText~f~2!{SDUR="true",HEIGHT=10,SSCNT="false",FONT="Swansea",SCNT="true",DURTHRH=9,SCALE=0.7,DURWARN=3,SSDUR="false",OUTLINE=2}
IconText~d!3~4~5~6~7~8~9~10~
BarVisibility~f~1!{INCCLASSES=1,ALERTIC=1,ALERTOC=0.9,HIDEOOR="false"}
BarVisibility~d!2~3~4~5~6~7~8~9~10~
BarSort~f~1!{SUBORDER=1,OORLAST="false",RAIDORDER=3,SUBPF="true"}
BarSort~d!2~3~4~5~6~7~8~9~10~
BarAggro~f~1!{B=0,ALERTIND=2,G=0,TEXTFORMAT=3,SHOW="true",SHOWTEXTPCT="true",SHOWTEXT="true",R=1,SHOWIND="true",ALERT=2}
BarAggro~d!2~3~4~5~6~7~8~9~10~
AuxBarFrame~f~1!{OVERLAP=2}
AuxBarFrame~d!2~3~4~5~6~7~8~9~10~
AuxBar^1~f~1!{SIZE=1,USE=5,R=1,COLOUR=1,ANCHOR=2,OFFSET=1,DEPTH=2,G=1,B=1,A=1,OTYPE=1}
AuxBar^1~d!2~3~4~5~6~7~8~9~
AuxBar^1~f~10!{SIZE=1,USE=1,R=1,COLOUR=1,ANCHOR=2,OFFSET=1,DEPTH=2,G=1,B=1,A=1,OTYPE=1}
AuxBar^2~f~1!{SIZE=1,USE=5,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=2,G=1,B=1,A=1,OTYPE=1}
AuxBar^2~d!2~3~4~5~6~7~8~9~
AuxBar^2~f~10!{SIZE=1,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=2,G=1,B=1,A=1,OTYPE=1}
AuxBar^3~f~1!{SIZE=1,USE=3,R=1,COLOUR=2,ANCHOR=3,OFFSET=0,DEPTH=8,G=1,B=1,A=1,OTYPE=1}
AuxBar^3~f~2!{SIZE=1,USE=1,R=1,COLOUR=2,ANCHOR=3,OFFSET=1,DEPTH=8,G=1,B=1,A=1,OTYPE=1}
AuxBar^3~d!3~4~5~6~7~8~9~10~
AuxBar^4~f~1!{SIZE=1,USE=2,R=1,COLOUR=2,ANCHOR=3,OFFSET=0,DEPTH=8,G=1,B=1,A=1,OTYPE=1}
AuxBar^4~f~2!{SIZE=1,USE=1,R=1,COLOUR=2,ANCHOR=3,OFFSET=0,DEPTH=8,G=1,B=1,A=1,OTYPE=1}
AuxBar^4~d!3~4~5~6~7~8~9~10~
AuxBar^5~f~1!{SIZE=1,USE=3,R=1,COLOUR=2,ANCHOR=4,OFFSET=0,DEPTH=8,G=1,B=1,A=1,OTYPE=1}
AuxBar^5~f~2!{SIZE=1,USE=1,R=1,COLOUR=2,ANCHOR=4,OFFSET=0,DEPTH=8,G=1,B=1,A=1,OTYPE=1}
AuxBar^5~d!3~4~5~6~7~8~9~10~
AuxBar^6~f~1!{SIZE=1,USE=2,R=1,COLOUR=2,ANCHOR=4,OFFSET=0,DEPTH=8,G=1,B=1,A=1,OTYPE=1}
AuxBar^6~f~2!{SIZE=1,USE=1,R=1,COLOUR=2,ANCHOR=4,OFFSET=0,DEPTH=8,G=1,B=1,A=1,OTYPE=1}
AuxBar^6~d!3~4~5~6~7~8~9~10~
AuxBar^7~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=4,OFFSET=0,DEPTH=2,G=1,B=1,A=1,OTYPE=1}
AuxBar^7~d!2~3~4~5~6~7~8~9~10~
AuxBar^8~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,A=1,OTYPE=1}
AuxBar^8~d!2~3~4~5~6~7~8~9~10~
AuxBar^9~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,A=1,OTYPE=1}
AuxBar^9~d!2~3~4~5~6~7~8~9~10~
Complete!]]
HealBot_ExtraSkinData[24]=[[Skin
Bottoms Up hGroup
Author~v!Monti of Terenas
DuplicateBars~v!false
Chat~t!{EOCOOM="false",EOCOOMV=20,MSG="Casting #s on #n",RESONLY="true",CHAN="",NOTIFY=0}
General~t!{OFREQ=0.07,OMIN=0.1,OMAX=0.95,HIDEBOSSF="false",HIDEPTF="false",HIDEPARTYF="false",STICKYSENSITIVITY=35,HIDERAIDF="true",STICKYFRAME="true",FLUIDBARS="false",FLUIDFREQ=10}
Healing~t!{TINCSELF="false",GROUPPETS="true",TARGETINCOMBAT=2,TINCRAID=1,FONLYFRIEND="false",SELFPET=0,TONLYFRIEND="false",FALWAYSSHOW="false",FOCUSINCOMBAT=2,TALWAYSSHOW="false",TINCPET="false",TINCGROUP=1,TEXRAID="false",FEXRAID="false"}
Enemy~t!{INCARENA="true",INCTANKS="true",INCMYTAR="false",ENEMYTARGET="false",INCARENAPETS="false",ENEMYTARGETSIZE=40,HIDE="true",NUMBOSS=2,EXISTSHOWPTAR=1,INCSELF="false",EXISTSHOWBOSS="true",DOUBLEWIDTH="false",EXISTSHOWARENA=3}
FrameAlias~f~1!{SIZE=12,NAME="",R=1,ALIAS="Group",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~2!{A=1,NAME="Tanks",R=1,ALIAS="Not Used",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~3!{A=1,NAME="",R=1,ALIAS="Not Used",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~4!{A=1,NAME="",R=1,ALIAS="NotUsed",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~5!{A=1,NAME="",R=1,ALIAS="Not Used",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~6!{A=1,NAME="",R=1,ALIAS="Vehicle",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~7!{A=1,NAME="",R=1,ALIAS="Pets",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~8!{A=1,NAME="",R=1,ALIAS="Target",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~9!{A=1,NAME="",R=1,ALIAS="Focus",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~10!{A=1,NAME="",R=1,ALIAS="Enemy",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAliasBar~f~1!{A=0.5,TEXTURE="HealBot 10",B=0.25,HEIGHT=20,R=0.1,G=0.25,WIDTH=0.7}
FrameAliasBar~d!2~3~4~5~6~7~8~9~10~
Frame~f~1!{SFOFFSETH=0,BACKG=0.102,AUTOCLOSE="false",BORDERB=0.1,LOCKED="false",SCALE=1,BORDERA=0.04,SFOFFSETV=0,TIPLOC=2,BACKB=0.702,BACKA=0,OPENSOUND="false",BORDERR=0.1,BORDERG=0.1,BACKR=0.102}
Frame~f~2!{SFOFFSETH=0,BACKR=0.102,AUTOCLOSE="false",BORDERB=0.1,LOCKED="false",OPENSOUND="false",BORDERA=0.04,SFOFFSETV=-5,TIPLOC=2,BACKB=0.702,BACKA=0,SCALE=1,BACKG=0.102,BORDERR=0.1,BORDERG=0.1}
Frame~f~3!{SFOFFSETH=0,BACKG=0.102,AUTOCLOSE="false",BORDERB=0.1,LOCKED="false",SCALE=1,BORDERA=0.04,SFOFFSETV=0,TIPLOC=2,BACKB=0.702,BACKA=0,OPENSOUND="false",BORDERR=0.1,BORDERG=0.1,BACKR=0.102}
Frame~d!4~5~6~
Frame~f~7!{SFOFFSETH=0,BACKR=0.102,AUTOCLOSE="false",BORDERB=0.1,LOCKED="false",OPENSOUND="false",BORDERA=0.04,SFOFFSETV=9,TIPLOC=2,BACKB=0.702,BACKA=0,SCALE=1,BACKG=0.102,BORDERR=0.1,BORDERG=0.1}
Frame~f~8!{BACKR=0.102,BORDERR=0.1,BORDERG=0.1,BACKG=0.102,LOCKED="false",SCALE=1,BORDERA=0.04,SFOFFSETV=0,AUTOCLOSE="false",BORDERB=0.1,BACKA=0,OPENSOUND="false",BACKB=0.702,TIPLOC=2,SFOFFSETH=0}
Frame~d!9~
Frame~f~10!{BACKR=0.102,BORDERR=0.1,BORDERG=0.1,BACKG=0.102,LOCKED="false",SCALE=1,BORDERA=0.04,SFOFFSETV=-7,AUTOCLOSE="false",BORDERB=0.1,BACKA=0,OPENSOUND="false",BACKB=0.702,TIPLOC=2,SFOFFSETH=2}
StickyFrames~f~1!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~f~2!{STUCK="false",STUCKTOPOINT="TOPLEFT",STUCKTO=1,STUCKPOINT="BOTTOMLEFT"}
StickyFrames~f~3!{STUCK="false",STUCKTOPOINT="RIGHT",STUCKTO=2,STUCKPOINT="LEFT"}
StickyFrames~f~4!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~d!5~6~
StickyFrames~f~7!{STUCK="true",STUCKTOPOINT="BOTTOMLEFT",STUCKTO=1,STUCKPOINT="TOPLEFT"}
StickyFrames~f~8!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~d!9~
StickyFrames~f~10!{STUCK="true",STUCKTOPOINT="TOPLEFT",STUCKTO=1,STUCKPOINT="BOTTOMLEFT"}
HealGroups~f~1!{FRAME=1,STATE="false",NAME="Self"}
HealGroups~f~2!{FRAME=1,STATE="true",NAME="Main tanks"}
HealGroups~f~3!{FRAME=1,STATE="true",NAME="Healers"}
HealGroups~f~4!{FRAME=1,STATE="true",NAME="Group"}
HealGroups~f~5!{FRAME=1,STATE="false",NAME="Private List"}
HealGroups~f~6!{FRAME=1,STATE="true",NAME="Raid"}
HealGroups~f~7!{FRAME=1,STATE="false",NAME="Vehicle"}
HealGroups~f~8!{FRAME=7,STATE="true",NAME="Pets"}
HealGroups~f~9!{FRAME=8,STATE="false",NAME="Target"}
HealGroups~f~10!{FRAME=9,STATE="false",NAME="Focus"}
HealGroups~f~11!{FRAME=10,STATE="true",NAME="Enemy"}
Anchors~f~1!{Y=68.88,GROW=2,BARS=1,FRAME=1,X=88.73}
Anchors~f~2!{Y=69.71,GROW=2,BARS=1,FRAME=2,X=88.78}
Anchors~f~3!{Y=22.89,GROW=2,BARS=1,FRAME=2,X=31.19}
Anchors~f~4!{Y=53,GROW=2,BARS=1,FRAME=2,X=53}
Anchors~f~5!{Y=50.59,GROW=2,BARS=1,FRAME=2,X=58.13}
Anchors~f~6!{Y=55,GROW=2,BARS=1,FRAME=2,X=55}
Anchors~f~7!{Y=37.13,GROW=2,BARS=1,FRAME=1,X=88.73}
Anchors~f~8!{Y=30.55,GROW=2,BARS=1,FRAME=2,X=86.92}
Anchors~f~9!{Y=50.09,GROW=2,BARS=1,FRAME=2,X=82.03}
Anchors~f~10!{Y=68.3,GROW=2,BARS=2,FRAME=2,X=88.8}
HeadBar~f~1!{SHOW="false",TEXTURE="Tukui2",R=0.102,B=0.102,HEIGHT=28,A=0.4,G=0.102,WIDTH=0.95}
HeadBar~d!2~3~4~5~6~7~8~9~10~
HeadText~f~1!{A=1,R=1,OFFSET=0,B=0.961,FONT="Friz Quadrata TT",HEIGHT=11,G=0.996,OUTLINE=1}
HeadText~d!2~3~4~5~6~7~8~9~10~
HealBar~f~1!{HEIGHT=70,GRPCOLS="false",CMARGIN=0,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=115,RMARGIN=0,OFIX=2,NUMCOLS=1,LOWMANA=1}
HealBar~f~2!{HEIGHT=60,GRPCOLS="false",CMARGIN=0,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=150,RMARGIN=0,OFIX=2,NUMCOLS=1,LOWMANA=1}
HealBar~f~3!{HEIGHT=60,GRPCOLS="false",CMARGIN=0,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=150,RMARGIN=0,OFIX=1,NUMCOLS=1,LOWMANA=1}
HealBar~d!4~5~6~
HealBar~f~7!{HEIGHT=40,GRPCOLS="false",CMARGIN=0,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=1,WIDTH=62,OFIX=2,RMARGIN=0,NUMCOLS=2}
HealBar~f~8!{HEIGHT=60,GRPCOLS="false",CMARGIN=0,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=1,WIDTH=150,OFIX=1,RMARGIN=0,NUMCOLS=1}
HealBar~d!9~
HealBar~f~10!{HEIGHT=45,GRPCOLS="false",CMARGIN=0,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",NUMCOLS=2,RMARGIN=0,OFIX=2,WIDTH=64,LOWMANA=1}
BarCol~f~1!{BACK=3,BA=0.75,BB=0,DISA=0.2,BR=0,HB=0.4,BG=0,HG=0.4,HA=1,HR=0.2,ORA=0.5,BOUT=1,HLTH=2}
BarCol~d!2~3~4~5~6~7~8~9~10~
BarIACol~f~1!{AC=3,AB=1,AA=0.6,AR=1,AG=1,IC=2,IB=0.2,IA=0.6,IR=0.2,IG=0.8}
BarIACol~d!2~3~4~5~6~7~8~9~10~
BarText~f~1!{HLTHONBAR="false",TAGOOR="",HOUTLINE=1,MAXCHARS=0,OVERHEAL=1,CLASSONBAR="false",OUTLINE=2,HOFFSET=0,OFFSET=7,INCHEALS=2,HLTHTXTANCHOR=1,HLTHTYPE=3,HMAXCHARS=0,CLASSTYPE=1,NUMFORMAT2=1,FONT="Friz Quadrata TT",NUMFORMAT1=11,IGNOREONFULL="true",TAGRIP="",HEIGHT=10,NAMEONBAR="true",SHOWROLE="true",HALIGN=2,TAGDC="",HHEIGHT=10,INCABSORBS=1,HOFFSET2=0,ALIGN=2,TAGR="",HFONT="Friz Quadrata TT"}
BarText~d!2~3~4~5~6~
BarText~f~7!{HLTHONBAR="false",TAGOOR="",IGNOREONFULL="true",MAXCHARS=0,TAGDC="",HMAXCHARS=0,HOFFSET=0,OUTLINE=2,INCHEALS=2,OFFSET=2,HLTHTXTANCHOR=1,HLTHTYPE=3,FONT="Friz Quadrata TT",INCABSORBS=1,NUMFORMAT2=1,CLASSONBAR="false",NUMFORMAT1=11,HOUTLINE=1,TAGRIP="",HEIGHT=10,NAMEONBAR="true",SHOWROLE="true",HALIGN=2,HHEIGHT=10,OVERHEAL=1,CLASSTYPE=1,HOFFSET2=0,ALIGN=2,TAGR="",HFONT="Friz Quadrata TT"}
BarText~d!8~9~10~
BarTextCol~f~1!{HCG=1,HCA=1,NAME=1,NCDA=0.7,NCB=0,NCR=0.929,HCB=0,HCR=0.929,NDEBUFF="false",NCG=1,NCA=1,HDEBUFF="false",HLTH=3,HCDA=0.7}
BarTextCol~d!2~3~4~5~6~7~8~9~10~
Icons~f~1!{SHOWBUFF="true",POSITION=2,MAXDICONS=4,I15EN="true",SHOWDEBUFF="true",DOUBLE="true",ONBAR=1,SHOWDIRMOUSE="false",DSCALE=0.55,SHOWDIR="false",SHOWRC="true",SCALE=0.55,FADESECS=15,FADE="true",MAXBICONS=6}
Icons~f~2!{SHOWBUFF="true",POSITION=2,MAXDICONS=5,I15EN="true",SHOWDEBUFF="true",DOUBLE="true",ONBAR=1,SHOWDIRMOUSE="false",DSCALE=0.55,SHOWDIR="false",SHOWRC="true",SCALE=0.55,FADESECS=15,FADE="true",MAXBICONS=10}
Icons~f~3!{SHOWBUFF="true",POSITION=2,MAXDICONS=3,I15EN="true",SHOWDEBUFF="true",DOUBLE="true",ONBAR=1,SHOWDIRMOUSE="false",DSCALE=0.55,SHOWDIR="false",SHOWRC="true",SCALE=0.55,FADESECS=15,FADE="true",MAXBICONS=8}
Icons~d!4~5~6~
Icons~f~7!{SHOWBUFF="true",SHOWDEBUFF="true",I15EN="true",FADESECS=15,DOUBLE="false",FADE="true",ONBAR=1,SHOWDIRMOUSE="false",DSCALE=0.45,SHOWDIR="false",SHOWRC="true",SCALE=0.45,POSITION=2,MAXDICONS=2,MAXBICONS=3}
Icons~f~8!{SHOWBUFF="true",SHOWDEBUFF="true",I15EN="true",FADESECS=15,DOUBLE="true",FADE="true",ONBAR=1,SHOWDIRMOUSE="false",DSCALE=0.55,SHOWDIR="false",SHOWRC="true",SCALE=0.55,POSITION=2,MAXDICONS=3,MAXBICONS=8}
Icons~d!9~
Icons~f~10!{SHOWBUFF="true",SHOWDEBUFF="true",I15EN="true",FADESECS=15,DOUBLE="true",FADE="true",ONBAR=1,SHOWDIRMOUSE="false",DSCALE=0.55,SHOWDIR="false",SHOWRC="true",SCALE=0.55,POSITION=2,MAXDICONS=4,MAXBICONS=8}
RaidIcon~f~1!{SQUARE="true",CIRCLE="true",DIAMOND="true",SHOW="true",MOON="true",TRIANGLE="true",STAR="true",CROSS="true",SKULL="true"}
RaidIcon~d!2~3~4~5~6~7~8~9~10~
IconText~f~1!{SDUR="true",HEIGHT=10,SSCNT="false",FONT="Swansea",SCNT="true",DURTHRH=9,SCALE=0.8,DURWARN=3,SSDUR="false",OUTLINE=2}
IconText~f~2!{SDUR="true",HEIGHT=10,SSCNT="false",FONT="Swansea",SCNT="true",DURTHRH=9,SCALE=0.7,DURWARN=3,SSDUR="false",OUTLINE=2}
IconText~d!3~4~5~6~7~8~9~10~
BarVisibility~f~1!{INCCLASSES=1,ALERTIC=1,ALERTOC=0.9,HIDEOOR="false"}
BarVisibility~d!2~3~4~5~6~7~8~9~10~
BarSort~f~1!{SUBORDER=1,OORLAST="false",RAIDORDER=3,SUBPF="true"}
BarSort~d!2~3~4~5~6~7~8~9~10~
BarAggro~f~1!{B=0,ALERTIND=2,G=0,TEXTFORMAT=3,SHOW="true",SHOWTEXTPCT="true",SHOWIND="false",SHOWTEXT="false",R=1,ALERT=2}
BarAggro~d!2~3~4~5~6~7~8~9~10~
AuxBarFrame~f~1!{OVERLAP=2}
AuxBarFrame~d!2~3~4~5~6~7~8~9~10~
AuxBar^1~f~1!{SIZE=1,USE=1,R=1,COLOUR=1,ANCHOR=2,OFFSET=1,DEPTH=2,G=1,B=1,OTYPE=1}
AuxBar^1~d!2~3~4~5~6~7~8~9~10~
AuxBar^2~f~1!{SIZE=1,USE=5,R=1,COLOUR=1,ANCHOR=2,OFFSET=0,DEPTH=2,G=1,B=1,OTYPE=1}
AuxBar^2~d!2~3~4~5~6~7~8~9~
AuxBar^2~f~10!{SIZE=1,USE=1,R=1,COLOUR=1,ANCHOR=2,OFFSET=0,DEPTH=2,G=1,B=1,OTYPE=1}
AuxBar^3~f~1!{SIZE=1,USE=1,R=1,COLOUR=2,ANCHOR=2,OFFSET=-3,DEPTH=2,G=1,B=1,OTYPE=1}
AuxBar^3~d!2~3~4~5~6~7~8~9~10~
AuxBar^4~f~1!{SIZE=1,USE=1,R=1,COLOUR=2,ANCHOR=3,OFFSET=0,DEPTH=8,G=1,B=1,OTYPE=1}
AuxBar^4~d!2~3~4~5~6~7~8~9~10~
AuxBar^5~f~1!{SIZE=1,USE=4,R=1,COLOUR=1,ANCHOR=4,OFFSET=1,DEPTH=15,G=1,B=1,OTYPE=1}
AuxBar^5~d!2~3~4~5~6~
AuxBar^5~f~7!{SIZE=1,USE=1,R=1,COLOUR=1,ANCHOR=4,OFFSET=1,DEPTH=15,G=1,B=1,OTYPE=1}
AuxBar^5~f~8!{SIZE=1,USE=4,R=1,COLOUR=1,ANCHOR=4,OFFSET=1,DEPTH=15,G=1,B=1,OTYPE=1}
AuxBar^5~d!9~
AuxBar^5~f~10!{SIZE=1,USE=1,R=1,COLOUR=1,ANCHOR=4,OFFSET=1,DEPTH=15,G=1,B=1,OTYPE=1}
AuxBar^6~f~1!{SIZE=1,USE=1,R=1,COLOUR=2,ANCHOR=4,OFFSET=0,DEPTH=8,G=1,B=1,OTYPE=1}
AuxBar^6~d!2~3~4~5~6~7~8~9~10~
AuxBar^7~f~1!{SIZE=0.98,USE=5,R=1,COLOUR=1,ANCHOR=4,OFFSET=0,DEPTH=2,G=1,B=1,OTYPE=1}
AuxBar^7~d!2~3~4~5~6~7~8~9~
AuxBar^7~f~10!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=4,OFFSET=0,DEPTH=2,G=1,B=1,OTYPE=1}
AuxBar^8~f~1!{SIZE=0.98,USE=5,R=1,COLOUR=1,ANCHOR=3,OFFSET=0,DEPTH=2,G=1,B=1,OTYPE=1}
AuxBar^8~d!2~3~4~5~6~7~8~9~
AuxBar^8~f~10!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=3,OFFSET=0,DEPTH=2,G=1,B=1,OTYPE=1}
AuxBar^9~f~1!{SIZE=0.98,USE=5,R=1,COLOUR=1,ANCHOR=1,OFFSET=0,DEPTH=2,G=1,B=1,OTYPE=1}
AuxBar^9~d!2~3~4~5~6~7~8~9~
AuxBar^9~f~10!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=0,DEPTH=2,G=1,B=1,OTYPE=1}
Complete!]]
HealBot_ExtraSkinData[25]=[[Skin
Buttoms Up hRaid 40
Author~v!Monti of Terenas
DuplicateBars~v!true
Chat~t!{EOCOOM="false",EOCOOMV=20,MSG="Casting #s on #n",RESONLY="true",CHAN="",NOTIFY=0}
General~t!{OFREQ=0.07,OMIN=0.1,OMAX=0.95,FLUIDFREQ=10,HIDEPTF="false",HIDEPARTYF="false",HIDERAIDF="true",STICKYFRAME="true",STICKYSENSITIVITY=35,FLUIDBARS="true",HIDEBOSSF="false"}
Healing~t!{TINCSELF="false",GROUPPETS="true",TARGETINCOMBAT=2,TINCRAID=1,FONLYFRIEND="false",SELFPET=0,TONLYFRIEND="false",FALWAYSSHOW="false",FOCUSINCOMBAT=2,TALWAYSSHOW="false",FEXRAID="false",TINCGROUP=1,TEXRAID="false",TINCPET="false"}
Enemy~t!{ENEMYTARGET="false",INCTANKS="true",INCMYTAR="false",INCARENA="true",ENEMYTARGETSIZE=40,INCARENAPETS="false",HIDE="true",NUMBOSS=2,EXISTSHOWPTAR=1,INCSELF="false",EXISTSHOWBOSS="true",DOUBLEWIDTH="false",EXISTSHOWARENA=3}
FrameAlias~f~1!{SIZE=12,NAME="",R=1,ALIAS="Raid",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~2!{A=1,NAME="Tanks",R=1,ALIAS="Tanks",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~3!{A=1,NAME="",R=1,ALIAS="Not Used",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~4!{A=1,NAME="",R=1,ALIAS="NotUsed",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~5!{A=1,NAME="",R=1,ALIAS="Not Used",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~6!{A=1,NAME="",R=1,ALIAS="Vehicle",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~7!{A=1,NAME="Pets",R=1,ALIAS="Pets",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~8!{A=1,NAME="",R=1,ALIAS="Target",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~9!{A=1,NAME="",R=1,ALIAS="Focus",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~10!{A=1,NAME="",R=1,ALIAS="Enemy",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAliasBar~f~1!{A=0.5,TEXTURE="HealBot 10",B=0.25,HEIGHT=20,R=0.1,G=0.25,WIDTH=0.7}
FrameAliasBar~d!2~3~4~5~6~7~8~9~10~
Frame~f~1!{BORDERR=0.1,TIPLOC=3,BACKG=0.102,BORDERB=0.1,LOCKED="false",SCALE=1,BORDERA=0.04,SFOFFSETV=0,AUTOCLOSE="false",BACKB=0.702,BACKA=0,OPENSOUND="false",BORDERG=0.1,SFOFFSETH=0,BACKR=0.102}
Frame~f~2!{SFOFFSETH=0,BORDERR=0.1,BACKG=0.102,BORDERB=0.1,LOCKED="true",OPENSOUND="false",BORDERA=0.04,SFOFFSETV=-7,AUTOCLOSE="false",BACKB=0.702,BACKA=0,SCALE=1,TIPLOC=4,BORDERG=0.1,BACKR=0.102}
Frame~f~3!{BORDERR=0.1,TIPLOC=5,BACKG=0.1,BORDERB=0.1,LOCKED="false",SCALE=1,BORDERA=0.04,SFOFFSETV=0,AUTOCLOSE="false",BACKB=0.7,BACKA=0.1,OPENSOUND="false",BORDERG=0.1,SFOFFSETH=0,BACKR=0.1}
Frame~d!4~
Frame~f~5!{SFOFFSETH=0,BORDERR=0.1,BACKG=0.1,BORDERB=0.1,LOCKED="true",OPENSOUND="false",BORDERA=0.04,SFOFFSETV=0,AUTOCLOSE="false",BACKB=0.7,BACKA=0.1,SCALE=1,TIPLOC=2,BORDERG=0.1,BACKR=0.1}
Frame~f~6!{SFOFFSETH=0,BORDERR=0.1,BACKG=0.1,BORDERB=0.1,LOCKED="false",OPENSOUND="false",BORDERA=0.04,SFOFFSETV=0,AUTOCLOSE="false",BACKB=0.7,BACKA=0.1,SCALE=1,TIPLOC=5,BORDERG=0.1,BACKR=0.1}
Frame~f~7!{SFOFFSETH=5,BORDERR=0.1,BACKG=0.1,BORDERB=0.1,LOCKED="true",OPENSOUND="false",BORDERA=0.04,SFOFFSETV=7,AUTOCLOSE="false",BACKB=0.7,BACKA=0.1,SCALE=1,TIPLOC=5,BORDERG=0.1,BACKR=0.1}
Frame~f~8!{BACKR=0.1,SFOFFSETH=0,BORDERG=0.1,TIPLOC=5,LOCKED="false",SCALE=1,BORDERA=0.04,SFOFFSETV=0,BACKG=0.1,BORDERB=0.1,BACKA=0.1,OPENSOUND="false",BACKB=0.7,AUTOCLOSE="false",BORDERR=0.1}
Frame~f~9!{BORDERR=0.1,BACKR=0.1,AUTOCLOSE="false",BACKB=0.7,LOCKED="true",OPENSOUND="false",BORDERA=0.04,BORDERG=0.1,TIPLOC=5,BORDERB=0.1,BACKA=0.1,SCALE=1,BACKG=0.1,SFOFFSETV=3,SFOFFSETH=0}
Frame~f~10!{BACKR=0.1,SFOFFSETH=4,BORDERG=0,TIPLOC=2,LOCKED="true",SCALE=1,BORDERA=1,SFOFFSETV=-4,BACKG=0.1,BORDERB=0,BACKA=0.1,OPENSOUND="false",BACKB=0.7,AUTOCLOSE="false",BORDERR=1}
StickyFrames~f~1!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~f~2!{STUCK="true",STUCKTOPOINT="TOPLEFT",STUCKTO=1,STUCKPOINT="BOTTOMLEFT"}
StickyFrames~f~3!{STUCK="false",STUCKTOPOINT="RIGHT",STUCKTO=2,STUCKPOINT="LEFT"}
StickyFrames~f~4!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~d!5~6~
StickyFrames~f~7!{STUCK="true",STUCKTOPOINT="BOTTOMLEFT",STUCKTO=1,STUCKPOINT="TOPLEFT"}
StickyFrames~f~8!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~d!9~
StickyFrames~f~10!{STUCK="true",STUCKTOPOINT="TOPLEFT",STUCKTO=1,STUCKPOINT="TOPRIGHT"}
HealGroups~f~1!{FRAME=1,STATE="false",NAME="Self"}
HealGroups~f~2!{FRAME=2,STATE="true",NAME="Main tanks"}
HealGroups~f~3!{FRAME=1,STATE="false",NAME="Healers"}
HealGroups~f~4!{FRAME=1,STATE="false",NAME="Group"}
HealGroups~f~5!{FRAME=1,STATE="false",NAME="Private List"}
HealGroups~f~6!{FRAME=1,STATE="true",NAME="Raid"}
HealGroups~f~7!{FRAME=1,STATE="false",NAME="Vehicle"}
HealGroups~f~8!{FRAME=7,STATE="true",NAME="Pets"}
HealGroups~f~9!{FRAME=8,STATE="false",NAME="Target"}
HealGroups~f~10!{FRAME=9,STATE="false",NAME="Focus"}
HealGroups~f~11!{FRAME=10,STATE="true",NAME="Enemy"}
Anchors~f~1!{Y=68.41,GROW=1,BARS=3,FRAME=1,X=78.94}
Anchors~f~2!{Y=67.83,GROW=1,BARS=1,FRAME=2,X=78.94}
Anchors~f~3!{Y=22.89,GROW=1,BARS=1,FRAME=6,X=31.19}
Anchors~f~4!{Y=53,GROW=2,BARS=1,FRAME=1,X=53}
Anchors~f~5!{Y=50.59,GROW=2,BARS=1,FRAME=1,X=58.13}
Anchors~f~6!{Y=55,GROW=2,BARS=1,FRAME=1,X=55}
Anchors~f~7!{Y=63.66,GROW=1,BARS=1,FRAME=1,X=79.11}
Anchors~f~8!{Y=63.24,GROW=2,BARS=1,FRAME=1,X=52.49}
Anchors~f~9!{Y=58,GROW=2,BARS=1,FRAME=1,X=58}
Anchors~f~10!{Y=68.08,GROW=2,BARS=1,FRAME=3,X=79.08}
HeadBar~f~1!{SHOW="true",TEXTURE="Tukui",R=0.102,B=0.102,HEIGHT=28,A=0.4,G=0.102,WIDTH=0.95}
HeadBar~f~2!{SHOW="true",WIDTH=0.7,B=0.102,R=0.102,HEIGHT=62,A=0.4,G=0.102,TEXTURE="Tukui"}
HeadBar~f~3!{SHOW="true",WIDTH=0.95,B=0.102,R=0.102,HEIGHT=60,A=0.4,G=0.102,TEXTURE="Tukui2"}
HeadBar~d!4~5~6~
HeadBar~f~7!{SHOW="true",WIDTH=0.95,B=0.102,R=0.102,HEIGHT=28,A=0.4,G=0.102,TEXTURE="Tukui"}
HeadBar~f~8!{SHOW="true",WIDTH=0.95,B=0.102,R=0.102,HEIGHT=60,A=0.4,G=0.102,TEXTURE="Tukui2"}
HeadBar~d!9~
HeadBar~f~10!{SHOW="true",TEXTURE="Tukui2",R=0.102,B=0.102,HEIGHT=28,A=0.4,G=0.102,WIDTH=0.95}
HeadText~f~1!{A=1,R=1,OFFSET=0,B=0.961,FONT="Friz Quadrata TT",HEIGHT=11,G=0.996,OUTLINE=1}
HeadText~d!2~3~4~5~6~7~8~9~10~
HealBar~f~1!{HEIGHT=50,GRPCOLS="false",CMARGIN=0,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=55,RMARGIN=0,OFIX=2,NUMCOLS=1,LOWMANA=1}
HealBar~f~2!{HEIGHT=50,GRPCOLS="false",CMARGIN=0,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=115,RMARGIN=0,OFIX=2,NUMCOLS=1,LOWMANA=1}
HealBar~f~3!{HEIGHT=60,GRPCOLS="false",CMARGIN=2,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=80,RMARGIN=2,OFIX=1,NUMCOLS=2,LOWMANA=1}
HealBar~f~4!{HEIGHT=60,GRPCOLS="false",CMARGIN=2,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=1,NUMCOLS=3,OFIX=1,RMARGIN=2,WIDTH=80}
HealBar~d!5~6~
HealBar~f~7!{HEIGHT=25,GRPCOLS="false",CMARGIN=0,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=1,WIDTH=52,OFIX=2,RMARGIN=0,NUMCOLS=1}
HealBar~f~8!{HEIGHT=60,GRPCOLS="false",CMARGIN=2,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=1,WIDTH=80,OFIX=1,RMARGIN=2,NUMCOLS=3}
HealBar~d!9~
HealBar~f~10!{HEIGHT=50,GRPCOLS="false",CMARGIN=0,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",NUMCOLS=3,RMARGIN=0,OFIX=2,WIDTH=58,LOWMANA=1}
BarCol~f~1!{BACK=3,BA=0.75,BOUT=0,DISA=0.2,BR=0,HB=0.4,BG=0,HG=0.4,HA=1,HR=0.2,ORA=0.5,BB=0,HLTH=2}
BarCol~d!2~
BarCol~f~3!{BACK=3,BA=0.75,BB=0,DISA=0.2,BR=0,HB=0.4,BG=0,BOUT=1,HA=1,HG=0.4,ORA=0.5,HR=0.2,HLTH=2}
BarCol~d!4~5~6~
BarCol~f~7!{BACK=3,BA=0.75,BB=0,DISA=0.2,BR=0,HB=0.4,BG=0,BOUT=0,HA=1,HG=0.4,ORA=0.5,HR=0.2,HLTH=2}
BarCol~f~8!{BACK=3,BA=0.75,BB=0,DISA=0.2,BR=0,HB=0.4,BG=0,BOUT=1,HA=1,HG=0.4,ORA=0.5,HR=0.2,HLTH=2}
BarCol~d!9~10~
BarIACol~f~1!{AC=3,AB=1,AA=0.6,AR=1,AG=1,IC=2,IB=0.2,IA=0.6,IR=0.2,IG=0.8}
BarIACol~d!2~3~4~5~6~7~8~9~10~
BarText~f~1!{HLTHONBAR="false",TAGOOR="",HOUTLINE=1,MAXCHARS=12,CLASSONBAR="false",OUTLINE=2,INCHEALS=2,FONT="Friz Quadrata TT",OFFSET=5,HLTHTXTANCHOR=1,HLTHTYPE=3,HMAXCHARS=0,CLASSTYPE=1,NUMFORMAT2=1,IGNOREONFULL="true",TAGDC="",NUMFORMAT1=11,TAGRIP="",HEIGHT=10,NAMEONBAR="true",SHOWROLE="true",HALIGN=2,HHEIGHT=10,HOFFSET=0,OVERHEAL=1,INCABSORBS=1,HOFFSET2=0,ALIGN=2,TAGR="[ R ] ",HFONT="Friz Quadrata TT"}
BarText~d!2~3~
BarText~f~4!{HLTHONBAR="false",TAGOOR="",HOUTLINE=1,MAXCHARS=12,CLASSONBAR="false",HFONT="Friz Quadrata TT",INCHEALS=2,FONT="Friz Quadrata TT",OFFSET=5,HLTHTXTANCHOR=1,HLTHTYPE=3,HMAXCHARS=0,CLASSTYPE=1,NUMFORMAT2=1,IGNOREONFULL="true",NUMFORMAT1=11,TAGDC="",NAMEONBAR="true",HEIGHT=10,TAGRIP="",SHOWROLE="true",HALIGN=2,HHEIGHT=10,HOFFSET=0,OVERHEAL=1,INCABSORBS=1,HOFFSET2=0,ALIGN=2,TAGR="[ R ] ",OUTLINE=2}
BarText~f~5!{HLTHONBAR="false",TAGOOR="",HOUTLINE=1,MAXCHARS=12,CLASSONBAR="false",HOFFSET=0,OUTLINE=2,FONT="Friz Quadrata TT",INCHEALS=2,HLTHTXTANCHOR=1,HLTHTYPE=3,HMAXCHARS=0,CLASSTYPE=1,NUMFORMAT2=1,OVERHEAL=1,TAGDC="",OFFSET=5,TAGRIP="",HEIGHT=10,NAMEONBAR="true",SHOWROLE="true",HALIGN=2,HHEIGHT=10,NUMFORMAT1=11,IGNOREONFULL="true",INCABSORBS=1,HOFFSET2=0,ALIGN=2,TAGR="[ R ] ",HFONT="Friz Quadrata TT"}
BarText~d!6~7~8~9~10~
BarTextCol~f~1!{NCB=0,HCA=1,HLTH=3,NCDA=0.7,NAME=1,HCG=1,HCB=0,HCR=0.929,NCR=0.929,NCG=1,NCA=1,HDEBUFF="false",NDEBUFF="false",HCDA=0.7}
BarTextCol~d!2~3~4~5~6~7~8~9~10~
Icons~f~1!{SHOWBUFF="true",POSITION=2,I15EN="true",MAXDICONS=4,FADESECS=15,SHOWDEBUFF="true",ONBAR=1,FADE="true",DSCALE=0.55,SHOWDIR="false",SHOWRC="true",SCALE=0.55,DOUBLE="true",SHOWDIRMOUSE="false",MAXBICONS=6}
Icons~f~2!{SHOWBUFF="true",POSITION=2,I15EN="true",MAXDICONS=5,FADESECS=15,SHOWDEBUFF="true",ONBAR=1,FADE="true",DSCALE=0.55,SHOWDIR="false",SHOWRC="true",SCALE=0.55,DOUBLE="true",SHOWDIRMOUSE="false",MAXBICONS=10}
Icons~f~3!{SHOWBUFF="true",POSITION=2,I15EN="true",MAXDICONS=3,FADESECS=15,SHOWDEBUFF="true",ONBAR=1,FADE="true",DSCALE=0.55,SHOWDIR="false",SHOWRC="true",SCALE=0.55,DOUBLE="true",SHOWDIRMOUSE="false",MAXBICONS=8}
Icons~d!4~5~6~
Icons~f~7!{SHOWBUFF="true",POSITION=2,MAXDICONS=2,FADESECS=15,I15EN="true",SHOWDIRMOUSE="false",ONBAR=1,FADE="true",DSCALE=0.45,SHOWDIR="false",SHOWRC="true",SCALE=0.45,DOUBLE="false",SHOWDEBUFF="true",MAXBICONS=3}
Icons~f~8!{SHOWBUFF="true",POSITION=2,MAXDICONS=3,FADESECS=15,I15EN="true",SHOWDIRMOUSE="false",ONBAR=1,FADE="true",DSCALE=0.55,SHOWDIR="false",SHOWRC="true",SCALE=0.55,DOUBLE="true",SHOWDEBUFF="true",MAXBICONS=8}
Icons~d!9~
Icons~f~10!{SHOWBUFF="true",POSITION=2,MAXDICONS=4,FADESECS=15,I15EN="true",SHOWDIRMOUSE="false",ONBAR=1,FADE="true",DSCALE=0.55,SHOWDIR="false",SHOWRC="true",SCALE=0.55,DOUBLE="true",SHOWDEBUFF="true",MAXBICONS=8}
RaidIcon~f~1!{SQUARE="true",CIRCLE="true",DIAMOND="true",SHOW="true",SKULL="true",TRIANGLE="true",STAR="true",CROSS="true",MOON="true"}
RaidIcon~d!2~3~4~5~6~7~8~9~10~
IconText~f~1!{DURWARN=3,HEIGHT=10,SSCNT="false",SCALE=0.8,SCNT="true",DURTHRH=9,FONT="Swansea",SDUR="true",SSDUR="false",OUTLINE=2}
IconText~f~2!{DURWARN=3,HEIGHT=10,SSCNT="false",SCALE=0.7,SCNT="true",DURTHRH=9,FONT="Swansea",SDUR="true",SSDUR="false",OUTLINE=2}
IconText~d!3~4~5~6~7~8~9~10~
BarVisibility~f~1!{INCCLASSES=1,ALERTIC=1,ALERTOC=0.9,HIDEOOR="false"}
BarVisibility~d!2~3~4~5~6~7~8~9~10~
BarSort~f~1!{SUBORDER=1,OORLAST="false",RAIDORDER=3,SUBPF="true"}
BarSort~d!2~3~4~5~6~7~8~9~10~
BarAggro~f~1!{R=1,ALERTIND=2,G=0,TEXTFORMAT=3,SHOW="true",SHOWTEXTPCT="true",B=0,SHOWIND="true",SHOWTEXT="true",ALERT=2}
BarAggro~d!2~3~4~5~6~7~8~9~10~
AuxBarFrame~f~1!{OVERLAP=2}
AuxBarFrame~d!2~3~4~5~6~7~8~9~10~
AuxBar^1~f~1!{SIZE=1,USE=5,R=1,COLOUR=1,ANCHOR=2,OFFSET=0,DEPTH=2,G=1,B=1,A=1,OTYPE=1}
AuxBar^1~d!2~3~4~5~6~7~8~9~
AuxBar^1~f~10!{SIZE=1,USE=1,R=1,COLOUR=1,ANCHOR=2,OFFSET=0,DEPTH=2,G=1,B=1,A=1,OTYPE=1}
AuxBar^2~f~1!{SIZE=1,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=2,G=1,B=1,A=1,OTYPE=1}
AuxBar^2~d!2~3~4~5~6~7~8~9~10~
AuxBar^3~f~1!{SIZE=1,USE=1,R=1,COLOUR=2,ANCHOR=3,OFFSET=1,DEPTH=5,G=1,B=1,A=1,OTYPE=1}
AuxBar^3~d!2~3~4~5~6~7~8~9~10~
AuxBar^4~f~1!{SIZE=1,USE=1,R=1,COLOUR=2,ANCHOR=3,OFFSET=0,DEPTH=5,G=1,B=1,A=1,OTYPE=1}
AuxBar^4~d!2~3~4~5~6~7~8~9~10~
AuxBar^5~f~1!{SIZE=1,USE=4,R=1,COLOUR=1,ANCHOR=4,OFFSET=2,DEPTH=8,G=1,B=1,A=1,OTYPE=1}
AuxBar^5~d!2~
AuxBar^5~f~3!{SIZE=1,USE=4,R=1,COLOUR=1,ANCHOR=4,OFFSET=2,DEPTH=14,OTYPE=1,A=1,B=1,G=1}
AuxBar^5~d!4~5~6~
AuxBar^5~f~7!{SIZE=1,USE=1,R=1,COLOUR=1,ANCHOR=4,OFFSET=2,DEPTH=14,OTYPE=1,A=1,B=1,G=1}
AuxBar^5~f~8!{SIZE=1,USE=4,R=1,COLOUR=1,ANCHOR=4,OFFSET=2,DEPTH=14,OTYPE=1,A=1,B=1,G=1}
AuxBar^5~d!9~
AuxBar^5~f~10!{SIZE=1,USE=1,R=1,COLOUR=1,ANCHOR=4,OFFSET=2,DEPTH=14,G=1,B=1,A=1,OTYPE=1}
AuxBar^6~f~1!{SIZE=1,USE=1,R=1,COLOUR=2,ANCHOR=4,OFFSET=0,DEPTH=5,G=1,B=1,A=1,OTYPE=1}
AuxBar^6~d!2~3~4~5~6~7~8~9~10~
AuxBar^7~f~1!{SIZE=1,USE=5,R=1,COLOUR=1,ANCHOR=4,OFFSET=0,DEPTH=2,G=1,B=1,A=1,OTYPE=1}
AuxBar^7~d!2~3~4~5~6~7~8~9~
AuxBar^7~f~10!{SIZE=1,USE=1,R=1,COLOUR=1,ANCHOR=4,OFFSET=0,DEPTH=2,OTYPE=1,A=1,B=1,G=1}
AuxBar^8~f~1!{SIZE=1,USE=5,R=1,COLOUR=1,ANCHOR=1,OFFSET=0,DEPTH=2,G=1,B=1,A=1,OTYPE=1}
AuxBar^8~d!2~3~4~5~6~7~8~9~
AuxBar^8~f~10!{SIZE=1,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=0,DEPTH=2,OTYPE=1,A=1,B=1,G=1}
AuxBar^9~f~1!{SIZE=1,USE=5,R=1,COLOUR=1,ANCHOR=3,OFFSET=0,DEPTH=2,G=1,B=1,A=1,OTYPE=1}
AuxBar^9~d!2~3~4~5~6~7~8~9~
AuxBar^9~f~10!{SIZE=1,USE=1,R=1,COLOUR=1,ANCHOR=3,OFFSET=0,DEPTH=2,OTYPE=1,A=1,B=1,G=1}
Complete!]]
HealBot_ExtraSkinData[26]=[[Skin
Bottoms Up cRaid 40
Author~v!Monti of Terenas
DuplicateBars~v!true
Chat~t!{EOCOOM="false",EOCOOMV=20,MSG="Casting #s on #n",RESONLY="true",CHAN="",NOTIFY=0}
General~t!{HIDEBOSSF="false",FOCUSGROUPS=1,FLUIDBARS="false",OMIN=0.1,STICKYFRAME="true",HIDEPARTYF="false",FGDIMMING=2.5,HIDEPTF="false",OFREQ=0.07,HIDERAIDF="true",OMAX=0.95,FLUIDFREQ=10}
Healing~t!{TINCSELF="false",GROUPPETS="true",TARGETINCOMBAT=2,TINCRAID=1,FONLYFRIEND="false",SELFPET=0,TONLYFRIEND="false",FALWAYSSHOW="false",FOCUSINCOMBAT=2,TALWAYSSHOW="false",TINCPET="false",TINCGROUP=1,TEXRAID="false",FEXRAID="false"}
Enemy~t!{INCOMBATSHOWARENA=2,INCOMBATSHOWSELF=2,INCARENA="true",EXISTSHOWTANK=1,EXISTSHOWBOSS="true",ENEMYTARGET="true",INCTANKS="true",INCMYTAR="false",INCOMBATSHOWTANK=1,INCOMBATSHOWLIST=2,ENEMYTARGETSIZE=40,EXISTSHOWMYTAR=1,NUMBOSS=2,EXISTSHOWPTAR=1,INCSELF="false",INCARENAPETS="false",DOUBLEWIDTH="false",EXISTSHOWARENA=3}
FocusGroups~t!{"true","true","true","true","true","true","true","true"}
FrameAlias~f~1!{SIZE=12,NAME="",R=1,ALIAS="Raid",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~2!{A=1,NAME="Tanks",R=1,ALIAS="Tanks",G=1,SHOW="true",OFFSET=0,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~3!{A=1,NAME="",R=1,ALIAS="Self",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~4!{A=1,NAME="",R=1,ALIAS="NotUsed",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~5!{A=1,NAME="",R=1,ALIAS="Not Used",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~6!{A=1,NAME="",R=1,ALIAS="Vehicle",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~7!{A=1,NAME="Pets",R=1,ALIAS="Pets",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~8!{A=1,NAME="",R=1,ALIAS="Target",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~9!{A=1,NAME="",R=1,ALIAS="Focus",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~10!{A=1,NAME="Enemy",R=0.988,ALIAS="Enemy",G=0.471,SHOW="true",OFFSET=0,FONT="Friz Quadrata TT",SIZE=12,B=0,OUTLINE=1}
FrameAliasBar~f~1!{A=0.5,TEXTURE="HealBot 10",B=0.25,HEIGHT=20,R=0.1,G=0.25,WIDTH=0.7}
FrameAliasBar~f~2!{A=0,WIDTH=0.95,B=0.251,HEIGHT=20,R=0.102,G=0.251,TEXTURE="HealBot 10"}
FrameAliasBar~f~3!{A=0.5,WIDTH=0.7,B=0.25,HEIGHT=20,R=0.1,G=0.25,TEXTURE="HealBot 10"}
FrameAliasBar~d!4~5~6~7~8~9~
FrameAliasBar~f~10!{A=0,WIDTH=0.7,B=0.251,HEIGHT=20,R=0.102,G=0.251,TEXTURE="HealBot 10"}
Frame~f~1!{BACKR=0.102,TIPLOC=1,BACKG=0.102,LOCKED=5,BORDERB=0.1,BORDERA=0.04,SFOFFSETV=0,AUTOCLOSE=1,BACKB=0.702,BACKA=0,SCALE=1,BORDERG=0.1,BORDERR=0.1,SFOFFSETH=0}
Frame~f~2!{BACKR=0.102,SFOFFSETH=0,BACKG=0.102,LOCKED=5,BORDERB=0.1,BORDERA=0.04,SFOFFSETV=-21,AUTOCLOSE=1,BACKB=0.702,BACKA=0,SCALE=1,TIPLOC=1,BORDERG=0.1,BORDERR=0.1}
Frame~f~3!{BACKR=0.1,TIPLOC=5,BACKG=0.1,LOCKED=5,BORDERB=0.1,BORDERA=0.04,SFOFFSETV=5,AUTOCLOSE=1,BACKB=0.7,BACKA=0.1,SCALE=1,BORDERG=0.1,BORDERR=0.1,SFOFFSETH=0}
Frame~f~4!{BORDERR=0.1,BACKR=0.1,SFOFFSETH=0,LOCKED=1,BORDERG=0.1,BORDERA=0.04,SFOFFSETV=0,BACKG=0.1,BORDERB=0.1,BACKA=0.1,SCALE=1,BACKB=0.7,AUTOCLOSE=1,TIPLOC=5}
Frame~f~5!{BACKR=0.1,SFOFFSETH=0,BACKG=0.1,LOCKED=2,BORDERB=0.1,BORDERA=0.04,SFOFFSETV=0,AUTOCLOSE=1,BACKB=0.7,BACKA=0.1,SCALE=1,TIPLOC=2,BORDERG=0.1,BORDERR=0.1}
Frame~f~6!{BACKR=0.1,SFOFFSETH=0,BACKG=0.1,LOCKED=1,BORDERB=0.1,BORDERA=0.04,SFOFFSETV=0,AUTOCLOSE=1,BACKB=0.7,BACKA=0.1,SCALE=1,TIPLOC=5,BORDERG=0.1,BORDERR=0.1}
Frame~f~7!{BACKR=0.1,SFOFFSETH=5,BACKG=0.1,LOCKED=5,BORDERB=0.1,BORDERA=0.04,SFOFFSETV=4,AUTOCLOSE=1,BACKB=0.7,BACKA=0.1,SCALE=1,TIPLOC=5,BORDERG=0.1,BORDERR=0.1}
Frame~f~8!{BORDERR=0.1,BACKR=0.1,BORDERG=0.1,LOCKED=1,TIPLOC=5,BORDERA=0.04,SFOFFSETV=0,BACKG=0.1,BORDERB=0.1,BACKA=0.1,SCALE=1,BACKB=0.7,AUTOCLOSE=1,SFOFFSETH=0}
Frame~d!9~
Frame~f~10!{BORDERR=1,BACKR=0.1,BORDERG=0,LOCKED=5,TIPLOC=4,BORDERA=1,SFOFFSETV=-5,BACKG=0.1,BORDERB=0,BACKA=0.1,SCALE=1,BACKB=0.7,AUTOCLOSE=2,SFOFFSETH=2}
StickyFrames~f~1!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~f~2!{STUCK="true",STUCKTOPOINT="TOPRIGHT",STUCKTO=1,STUCKPOINT="TOPLEFT"}
StickyFrames~f~3!{STUCK="true",STUCKTOPOINT="BOTTOM",STUCKTO=2,STUCKPOINT="TOP"}
StickyFrames~f~4!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~d!5~6~
StickyFrames~f~7!{STUCK="true",STUCKTOPOINT="BOTTOMLEFT",STUCKTO=1,STUCKPOINT="TOPLEFT"}
StickyFrames~f~8!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~d!9~
StickyFrames~f~10!{STUCK="true",STUCKTOPOINT="TOPLEFT",STUCKTO=1,STUCKPOINT="BOTTOMLEFT"}
HealGroups~f~1!{FRAME=3,STATE="false",NAME="Self"}
HealGroups~f~2!{FRAME=2,STATE="true",NAME="Main tanks"}
HealGroups~f~3!{FRAME=1,STATE="false",NAME="Healers"}
HealGroups~f~4!{FRAME=1,STATE="false",NAME="Group"}
HealGroups~f~5!{FRAME=1,STATE="false",NAME="Private List"}
HealGroups~f~6!{FRAME=1,STATE="true",NAME="Raid"}
HealGroups~f~7!{FRAME=1,STATE="false",NAME="Vehicle"}
HealGroups~f~8!{FRAME=7,STATE="true",NAME="Pets"}
HealGroups~f~9!{FRAME=8,STATE="false",NAME="Target"}
HealGroups~f~10!{FRAME=9,STATE="false",NAME="Focus"}
HealGroups~f~11!{FRAME=10,STATE="true",NAME="Enemy"}
Anchors~f~1!{Y=62.93,GROW=2,BARS=1,FRAME=1,X=63.16}
Anchors~f~2!{Y=61.15,GROW=2,BARS=1,FRAME=1,X=66.42}
Anchors~f~3!{Y=49.72,GROW=1,BARS=1,FRAME=5,X=71.71}
Anchors~f~4!{Y=53,GROW=2,BARS=1,FRAME=1,X=53}
Anchors~f~5!{Y=50.59,GROW=2,BARS=1,FRAME=1,X=58.13}
Anchors~f~6!{Y=55,GROW=2,BARS=1,FRAME=1,X=55}
Anchors~f~7!{Y=55.74,GROW=1,BARS=1,FRAME=1,X=63.34}
Anchors~f~8!{Y=34.07,GROW=2,BARS=1,FRAME=1,X=63.16}
Anchors~f~9!{Y=58,GROW=2,BARS=1,FRAME=1,X=58}
Anchors~f~10!{Y=62.51,GROW=2,BARS=1,FRAME=2,X=63.23}
HeadBar~f~1!{SHOW="true",TEXTURE="Tukui",R=0.102,B=0.102,HEIGHT=20,A=0,G=0.102,WIDTH=0.95}
HeadBar~f~2!{SHOW="false",WIDTH=0.7,B=0.102,R=0.102,HEIGHT=62,A=0.4,G=0.102,TEXTURE="Tukui"}
HeadBar~f~3!{SHOW="false",WIDTH=0.95,B=0.102,R=0.102,HEIGHT=25,A=0.4,G=0.102,TEXTURE="Tukui2"}
HeadBar~f~4!{SHOW="true",TEXTURE="Tukui2",R=0.102,B=0.102,HEIGHT=60,A=0.4,G=0.102,WIDTH=0.95}
HeadBar~d!5~6~
HeadBar~f~7!{SHOW="true",WIDTH=0.95,B=0.102,R=0.102,HEIGHT=28,A=0.4,G=0.102,TEXTURE="Tukui"}
HeadBar~f~8!{SHOW="true",WIDTH=0.95,B=0.102,R=0.102,HEIGHT=60,A=0.4,G=0.102,TEXTURE="Tukui2"}
HeadBar~d!9~
HeadBar~f~10!{SHOW="false",TEXTURE="Tukui2",R=0.102,B=0.102,HEIGHT=28,A=0.4,G=0.102,WIDTH=0.95}
HeadText~f~1!{A=1,R=1,OFFSET=0,B=0.961,FONT="Friz Quadrata TT",HEIGHT=11,G=0.996,OUTLINE=1}
HeadText~d!2~3~4~5~6~7~8~9~10~
HealBar~f~1!{HEIGHT=55,GRPCOLS="false",CMARGIN=0,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=70,RMARGIN=0,OFIX=2,NUMCOLS=1,LOWMANA=1}
HealBar~f~2!{HEIGHT=68,GRPCOLS="false",CMARGIN=0,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=115,RMARGIN=0,OFIX=2,NUMCOLS=2,LOWMANA=1}
HealBar~f~3!{HEIGHT=30,GRPCOLS="false",CMARGIN=2,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=90,RMARGIN=2,OFIX=1,NUMCOLS=2,LOWMANA=1}
HealBar~f~4!{HEIGHT=60,GRPCOLS="false",CMARGIN=2,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=1,NUMCOLS=3,OFIX=1,RMARGIN=2,WIDTH=80}
HealBar~d!5~6~
HealBar~f~7!{HEIGHT=25,GRPCOLS="false",CMARGIN=0,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=1,WIDTH=55,OFIX=2,RMARGIN=0,NUMCOLS=1}
HealBar~f~8!{HEIGHT=60,GRPCOLS="false",CMARGIN=2,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=1,WIDTH=80,OFIX=1,RMARGIN=2,NUMCOLS=3}
HealBar~d!9~
HealBar~f~10!{HEIGHT=55,GRPCOLS="false",CMARGIN=14,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",NUMCOLS=2,RMARGIN=0,OFIX=1,WIDTH=300,LOWMANA=1}
BarCol~f~1!{BACK=3,BA=0.75,BB=0,DISA=0.1,BR=0,HB=0.4,BG=0,HG=0.4,HA=1,HR=0.2,ORA=0.25,BOUT=2,HLTH=2}
BarCol~d!2~
BarCol~f~3!{BACK=3,BA=0.75,BOUT=1,DISA=0.2,BR=0,HB=0.4,BG=0,BB=0,HA=1,HG=0.4,ORA=0.5,HR=0.2,HLTH=2}
BarCol~d!4~5~6~
BarCol~f~7!{BACK=3,BA=0.75,BB=0,DISA=0.1,BR=0,HB=0.4,BG=0,HR=0.2,HA=1,HG=0.4,ORA=0.25,BOUT=1,HLTH=2}
BarCol~f~8!{BACK=3,BA=0.75,BB=0,DISA=0.2,BR=0,HB=0.4,BG=0,HR=0.2,HA=1,HG=0.4,ORA=0.5,BOUT=1,HLTH=2}
BarCol~d!9~
BarCol~f~10!{BACK=3,BA=0.75,BB=0,DISA=0.1,BR=0,HB=0.4,BG=0,HR=0.2,HA=1,HG=0.4,ORA=0.25,BOUT=1,HLTH=2}
BarIACol~f~1!{AC=4,AB=1,AA=0.45,AR=1,AG=1,IC=4,IB=1,IA=0.45,IR=1,IG=1}
BarIACol~d!2~
BarIACol~f~3!{AC=3,AB=1,AA=0.6,AR=1,AG=1,IC=2,IB=0.2,IA=0.6,IR=0.2,IG=0.8}
BarIACol~d!4~5~6~
BarIACol~f~7!{AC=3,AB=1,AA=0.75,AR=1,AG=1,IC=2,IB=0.2,IA=0.75,IR=0.2,IG=0.8}
BarIACol~f~8!{AC=3,AB=1,AA=0.6,AR=1,AG=1,IC=2,IB=0.2,IA=0.6,IR=0.2,IG=0.8}
BarIACol~d!9~
BarIACol~f~10!{AC=3,AB=1,AA=0.75,AR=1,AG=1,IC=2,IB=0.2,IA=0.75,IR=0.2,IG=0.8}
BarText~f~1!{HHEIGHT=10,TAGOOR="",IGNOREONFULL="true",MAXCHARS=12,HMAXCHARS=0,HOFFSET=0,HOUTLINE=1,OFFSET=-4,HLTHTXTANCHOR=1,FONT="Friz Quadrata TT",CLASSONBAR="false",OVERHEAL=1,NUMFORMAT2=1,OUTLINE=2,NUMFORMAT1=11,HLTHONBAR="false",TAGRIP="RIP-",HEIGHT=10,INCHEALS=2,SHOWROLE="true",HALIGN=2,HLTHTYPE=3,NAMEONBAR="true",TAGDC="DC-",INCABSORBS=1,HOFFSET2=0,ALIGN=2,TAGR="R-",HFONT="Friz Quadrata TT"}
BarText~d!2~
BarText~f~3!{HLTHONBAR="false",TAGOOR="",OVERHEAL=1,MAXCHARS=12,HMAXCHARS=0,HFONT="Friz Quadrata TT",CLASSONBAR="false",INCHEALS=2,HLTHTXTANCHOR=1,FONT="Friz Quadrata TT",HOUTLINE=1,OUTLINE=2,NUMFORMAT2=1,IGNOREONFULL="true",NUMFORMAT1=11,HHEIGHT=10,NAMEONBAR="true",HEIGHT=10,HLTHTYPE=3,SHOWROLE="true",HALIGN=2,TAGRIP="",OFFSET=-3,TAGDC="",INCABSORBS=1,HOFFSET2=0,ALIGN=2,TAGR="[ R ] ",HOFFSET=0}
BarText~f~4!{HLTHONBAR="false",TAGOOR="",OVERHEAL=1,MAXCHARS=12,HMAXCHARS=0,HFONT="Friz Quadrata TT",CLASSONBAR="false",INCHEALS=2,HLTHTXTANCHOR=1,FONT="Friz Quadrata TT",HOUTLINE=1,OUTLINE=2,NUMFORMAT2=1,IGNOREONFULL="true",NUMFORMAT1=11,HHEIGHT=10,NAMEONBAR="true",HEIGHT=10,HLTHTYPE=3,SHOWROLE="true",HALIGN=2,TAGRIP="",OFFSET=0,TAGDC="",INCABSORBS=1,HOFFSET2=0,ALIGN=2,TAGR="[ R ] ",HOFFSET=0}
BarText~d!5~6~7~8~9~10~
BarTextCol~f~1!{NCB=0,HCA=1,HLTH=3,NCDA=0.7,NAME=2,NDEBUFF="false",NCG=1,NCA=1,HCR=0.929,HCB=0,NCR=0.929,HDEBUFF="false",HCG=1,HCDA=0.7}
BarTextCol~d!2~3~4~5~6~7~8~9~10~
Icons~f~1!{RCEN="true",I15EN="true",CLASSEN="false",BUFFANCHOR=2,BUFFFADE="false",DEBUFFANCHOR=1,RCVOFFSET=0,OORVOFFSET=0,DEBUFFDOUBLE="true",TARGETVOFFSET=0,BUFFONBAR=1,SHOWDIR="false",SHOWRC="true",TARGETANCHOR=3,RCSCALE=0.5,MAXBICONS=6,FADESECS=15,RCHOFFSET=0,TARGETHOFFSET=20,CLASSONBAR=1,CLASSVOFFSET=0,TARGETSCALE=0.3,DSCALE=0.4,OORHOFFSET=0,SHOWCLASS="false",BUFFDOUBLE="true",TARGETONBAR=1,OORONBAR=1,SHOWDIRMOUSE="false",RCANCHOR=3,TARGETEN="true",RCONBAR=1,MAXDICONS=4,CLASSSCALE=0.5,SHOWROLE="false",CLASSHOFFSET=0,CLASSANCHOR=1,DEBUFFONBAR=1,OORANCHOR=1,BUFFI15EN="true",BUFFFADESECS=15,OORSCALE=0.5,SCALE=0.45,OOREN="false",FADE="false"}
Icons~f~2!{RCEN="true",I15EN="true",CLASSEN="false",BUFFANCHOR=2,BUFFFADE="false",DEBUFFANCHOR=1,RCVOFFSET=0,OORVOFFSET=0,DEBUFFDOUBLE="true",TARGETVOFFSET=0,BUFFONBAR=1,SHOWDIR="false",SHOWRC="true",TARGETANCHOR=3,RCSCALE=0.5,MAXBICONS=10,FADESECS=15,RCHOFFSET=0,TARGETHOFFSET=20,CLASSONBAR=1,CLASSVOFFSET=0,TARGETSCALE=0.3,DSCALE=0.4,OORHOFFSET=0,SHOWCLASS="false",BUFFDOUBLE="true",TARGETONBAR=1,OORONBAR=1,SHOWDIRMOUSE="false",RCANCHOR=3,TARGETEN="true",RCONBAR=1,MAXDICONS=5,CLASSSCALE=0.5,SHOWROLE="false",CLASSHOFFSET=0,CLASSANCHOR=1,DEBUFFONBAR=1,OORANCHOR=1,BUFFI15EN="true",BUFFFADESECS=15,OORSCALE=0.5,SCALE=0.4,OOREN="false",FADE="false"}
Icons~f~3!{RCEN="false",I15EN="true",CLASSEN="false",BUFFANCHOR=2,BUFFFADE="false",DEBUFFANCHOR=1,RCVOFFSET=0,OORVOFFSET=0,DEBUFFDOUBLE="true",TARGETVOFFSET=0,BUFFONBAR=1,SHOWDIR="false",SHOWRC="true",TARGETANCHOR=3,RCSCALE=0.5,MAXBICONS=8,FADESECS=15,RCHOFFSET=0,TARGETHOFFSET=20,CLASSONBAR=1,CLASSVOFFSET=0,TARGETSCALE=0.3,DSCALE=0.4,OORHOFFSET=0,SHOWCLASS="false",BUFFDOUBLE="true",TARGETONBAR=1,OORONBAR=1,SHOWDIRMOUSE="false",RCANCHOR=1,TARGETEN="true",RCONBAR=1,MAXDICONS=3,CLASSSCALE=0.5,SHOWROLE="false",CLASSHOFFSET=0,CLASSANCHOR=1,DEBUFFONBAR=1,OORANCHOR=1,BUFFI15EN="true",BUFFFADESECS=15,OORSCALE=0.5,SCALE=0.4,OOREN="false",FADE="false"}
Icons~d!4~5~6~
Icons~f~7!{RCEN="false",I15EN="true",CLASSEN="false",SHOWDIRMOUSE="false",BUFFFADE="false",DEBUFFANCHOR=1,RCVOFFSET=0,OORVOFFSET=0,DEBUFFDOUBLE="false",TARGETVOFFSET=0,BUFFONBAR=1,SHOWDIR="false",SHOWRC="true",TARGETANCHOR=3,RCSCALE=0.5,MAXBICONS=3,TARGETHOFFSET=20,FADESECS=9,RCHOFFSET=0,OORHOFFSET=0,RCANCHOR=1,CLASSVOFFSET=0,TARGETSCALE=0.5,DSCALE=0.45,SCALE=0.45,TARGETONBAR=1,BUFFDOUBLE="false",OORONBAR=1,TARGETEN="true",CLASSONBAR=1,SHOWROLE="false",DEBUFFONBAR=1,RCONBAR=1,MAXDICONS=2,CLASSSCALE=0.5,CLASSHOFFSET=0,SHOWCLASS="false",CLASSANCHOR=1,DOUBLE="false",OORANCHOR=1,BUFFI15EN="true",BUFFFADESECS=9,OORSCALE=0.5,BUFFANCHOR=2,OOREN="false",FADE="false"}
Icons~f~8!{RCEN="false",I15EN="true",CLASSEN="false",BUFFANCHOR=2,BUFFFADE="false",DEBUFFANCHOR=1,RCVOFFSET=0,OORVOFFSET=0,DEBUFFDOUBLE="true",TARGETVOFFSET=0,BUFFONBAR=1,SHOWDIR="false",SHOWRC="true",TARGETANCHOR=3,RCSCALE=0.5,MAXBICONS=8,FADESECS=15,RCHOFFSET=0,TARGETHOFFSET=20,CLASSONBAR=1,CLASSVOFFSET=0,TARGETSCALE=0.3,DSCALE=0.4,OORHOFFSET=0,SHOWCLASS="false",BUFFDOUBLE="true",TARGETONBAR=1,OORONBAR=1,FADE="false",RCANCHOR=1,TARGETEN="true",RCONBAR=1,MAXDICONS=3,CLASSSCALE=0.5,SHOWROLE="false",CLASSHOFFSET=0,CLASSANCHOR=1,DEBUFFONBAR=1,OORANCHOR=1,BUFFI15EN="true",BUFFFADESECS=15,OORSCALE=0.5,SCALE=0.4,OOREN="false",SHOWDIRMOUSE="false"}
Icons~d!9~
Icons~f~10!{RCEN="false",I15EN="true",CLASSEN="false",BUFFANCHOR=2,BUFFFADE="false",DEBUFFANCHOR=1,RCVOFFSET=0,OORVOFFSET=0,DEBUFFDOUBLE="true",TARGETVOFFSET=0,BUFFONBAR=1,SHOWDIR="false",SHOWRC="true",TARGETANCHOR=3,RCSCALE=0.5,MAXBICONS=8,FADESECS=15,RCHOFFSET=0,TARGETHOFFSET=25,CLASSONBAR=1,CLASSVOFFSET=0,TARGETSCALE=0.3,DSCALE=0.4,OORHOFFSET=0,SHOWCLASS="false",BUFFDOUBLE="true",TARGETONBAR=1,OORONBAR=1,FADE="false",RCANCHOR=1,TARGETEN="true",RCONBAR=1,MAXDICONS=4,CLASSSCALE=0.5,SHOWROLE="false",CLASSHOFFSET=0,CLASSANCHOR=1,DEBUFFONBAR=1,OORANCHOR=1,BUFFI15EN="true",BUFFFADESECS=15,OORSCALE=0.5,SCALE=0.4,OOREN="false",SHOWDIRMOUSE="false"}
RaidIcon~f~1!{SQUARE="true",CIRCLE="true",DIAMOND="true",SHOW="true",MOON="true",TRIANGLE="true",STAR="true",CROSS="true",SKULL="true"}
RaidIcon~d!2~3~4~5~6~7~8~9~10~
IconText~f~1!{BUFFSSCNT="false",BUFFSSDUR="false",BUFFOUTLINE=2,BUFFDURTHRH=9,SCNT="true",DURTHRH=9,FONT="Swansea",BUFFFONT="Swansea",HEIGHT=10,SSCNT="false",BUFFSDUR="true",BUFFSCNT="true",BUFFDURWARN=3,SDUR="true",BUFFHEIGHT=10,DURWARN=3,SCALE=0.8,SSDUR="false",OUTLINE=2}
IconText~f~2!{BUFFSSCNT="false",BUFFSSDUR="false",BUFFOUTLINE=2,BUFFDURTHRH=9,SCNT="true",DURTHRH=9,FONT="Swansea",BUFFFONT="Swansea",HEIGHT=10,SSCNT="false",BUFFSDUR="true",BUFFSCNT="true",BUFFDURWARN=3,SDUR="true",BUFFHEIGHT=10,DURWARN=3,SCALE=0.7,SSDUR="false",OUTLINE=2}
IconText~d!3~4~5~6~7~8~9~10~
BarVisibility~f~1!{ALERTIC=0.9,ALERTOC=0.8,HIDEOOR="false"}
BarVisibility~f~2!{ALERTIC=0.98,ALERTOC=0.95,HIDEOOR="false"}
BarVisibility~f~3!{ALERTIC=1,ALERTOC=0.9,HIDEOOR="false"}
BarVisibility~d!4~5~6~7~8~9~10~
BarSort~f~1!{SUBORDER=2,OORLAST="false",RAIDORDER=3,SUBPF="true"}
BarSort~f~2!{SUBORDER=1,OORLAST="false",RAIDORDER=3,SUBPF="true"}
BarSort~d!3~4~5~6~7~8~9~10~
BarAggro~f~1!{B=0,ALERTIND=2,G=0,TEXTFORMAT=3,SHOW="true",SHOWTEXTPCT="false",SHOWIND="false",SHOWTEXT="true",R=1,ALERT=1}
BarAggro~d!2~
BarAggro~f~3!{R=1,ALERTIND=2,G=0,TEXTFORMAT=3,SHOW="true",SHOWTEXTPCT="true",B=0,SHOWTEXT="true",SHOWIND="true",ALERT=2}
BarAggro~d!4~5~6~7~8~9~10~
AuxBarFrame~f~1!{OVERLAP=1}
AuxBarFrame~d!2~3~4~5~6~7~8~9~10~
AuxBar^1~f~1!{SIZE=1,USE=5,R=1,COLOUR=1,ANCHOR=2,TEXT="false",OFFSET=-2,DEPTH=2,G=1,B=1,A=1,OTYPE=1}
AuxBar^1~d!2~
AuxBar^1~f~3!{SIZE=1,USE=1,R=1,COLOUR=1,ANCHOR=2,OTYPE=1,OFFSET=-2,TEXT="false",A=1,B=1,G=1,DEPTH=2}
AuxBar^1~f~4!{SIZE=1,USE=5,R=1,COLOUR=1,ANCHOR=2,DEPTH=2,OFFSET=-2,OTYPE=1,G=1,B=1,A=1,TEXT="false"}
AuxBar^1~d!5~6~7~8~9~
AuxBar^1~f~10!{SIZE=1,USE=5,R=1,COLOUR=1,ANCHOR=2,OTYPE=1,OFFSET=-10,TEXT="true",G=1,B=1,A=1,DEPTH=10}
AuxBar^2~f~1!{SIZE=1,USE=5,R=1,COLOUR=1,ANCHOR=1,TEXT="false",OFFSET=-2,DEPTH=2,G=1,B=1,A=1,OTYPE=1}
AuxBar^2~d!2~
AuxBar^2~f~3!{SIZE=1,USE=1,R=1,COLOUR=1,ANCHOR=1,OTYPE=1,OFFSET=-2,TEXT="false",A=1,B=1,G=1,DEPTH=2}
AuxBar^2~f~4!{SIZE=1,USE=5,R=1,COLOUR=1,ANCHOR=1,DEPTH=2,OFFSET=-2,OTYPE=1,G=1,B=1,A=1,TEXT="false"}
AuxBar^2~d!5~6~7~8~9~
AuxBar^2~f~10!{SIZE=1,USE=1,R=1,COLOUR=1,ANCHOR=1,OTYPE=1,OFFSET=-2,TEXT="false",G=1,B=1,A=1,DEPTH=2}
AuxBar^3~f~1!{SIZE=1,USE=4,R=1,COLOUR=1,ANCHOR=4,TEXT="true",OFFSET=0,DEPTH=8,G=1,B=1,A=1,OTYPE=3}
AuxBar^3~d!2~
AuxBar^3~f~3!{SIZE=1,USE=1,R=1,COLOUR=2,ANCHOR=4,OTYPE=1,OFFSET=0,TEXT="false",A=1,B=1,G=1,DEPTH=8}
AuxBar^3~f~4!{SIZE=1,USE=4,R=1,COLOUR=2,ANCHOR=4,DEPTH=8,OFFSET=0,OTYPE=1,G=1,B=1,A=1,TEXT="true"}
AuxBar^3~d!5~6~
AuxBar^3~f~7!{SIZE=1,USE=1,R=1,COLOUR=2,ANCHOR=4,TEXT="false",OFFSET=0,DEPTH=8,OTYPE=1,A=1,B=1,G=1}
AuxBar^3~f~8!{SIZE=1,USE=4,R=1,COLOUR=2,ANCHOR=4,TEXT="true",OFFSET=0,DEPTH=8,OTYPE=1,A=1,B=1,G=1}
AuxBar^3~d!9~
AuxBar^3~f~10!{SIZE=1,USE=1,R=1,COLOUR=2,ANCHOR=4,OTYPE=1,OFFSET=0,TEXT="false",G=1,B=1,A=1,DEPTH=8}
AuxBar^4~f~1!{SIZE=1,USE=10,R=0.086,COLOUR=1,ANCHOR=2,TEXT="true",OFFSET=-10,DEPTH=10,G=0.086,B=0.086,A=0.2,OTYPE=3}
AuxBar^4~d!2~
AuxBar^4~f~3!{SIZE=1,USE=1,R=0.42,COLOUR=1,ANCHOR=2,OTYPE=3,OFFSET=-10,TEXT="false",A=0.7,B=0.192,G=0.192,DEPTH=10}
AuxBar^4~f~4!{SIZE=1,USE=9,R=0.42,COLOUR=1,ANCHOR=2,DEPTH=10,OFFSET=-10,OTYPE=3,G=0.192,B=0.192,A=0.7,TEXT="true"}
AuxBar^4~d!5~6~
AuxBar^4~f~7!{SIZE=1,USE=1,R=0.42,COLOUR=1,ANCHOR=2,TEXT="false",OFFSET=-10,DEPTH=10,OTYPE=3,A=0.7,B=0.192,G=0.192}
AuxBar^4~f~8!{SIZE=1,USE=9,R=0.42,COLOUR=1,ANCHOR=2,TEXT="true",OFFSET=-10,DEPTH=10,OTYPE=3,A=0.7,B=0.192,G=0.192}
AuxBar^4~d!9~
AuxBar^4~f~10!{SIZE=1,USE=1,R=0.42,COLOUR=1,ANCHOR=2,OTYPE=3,OFFSET=-10,TEXT="true",G=0.192,B=0.192,A=0.7,DEPTH=10}
AuxBar^5~f~1!{SIZE=1,USE=11,R=1,COLOUR=3,ANCHOR=1,TEXT="true",OFFSET=-10,DEPTH=10,G=0.643,B=0,A=0.9,OTYPE=3}
AuxBar^5~d!2~
AuxBar^5~f~3!{SIZE=1,USE=1,R=1,COLOUR=1,ANCHOR=1,OTYPE=3,OFFSET=-10,TEXT="false",A=0.7,B=1,G=1,DEPTH=10}
AuxBar^5~f~4!{SIZE=1,USE=11,R=1,COLOUR=1,ANCHOR=1,OTYPE=3,OFFSET=-10,TEXT="true",A=0.7,B=1,G=1,DEPTH=10}
AuxBar^5~d!5~6~
AuxBar^5~f~7!{SIZE=1,USE=1,R=1,COLOUR=1,ANCHOR=1,TEXT="false",OFFSET=-10,DEPTH=10,OTYPE=3,A=0.7,B=1,G=1}
AuxBar^5~f~8!{SIZE=1,USE=11,R=1,COLOUR=1,ANCHOR=1,TEXT="true",OFFSET=-10,DEPTH=10,OTYPE=3,A=0.7,B=1,G=1}
AuxBar^5~d!9~
AuxBar^5~f~10!{SIZE=1,USE=1,R=1,COLOUR=1,ANCHOR=1,OTYPE=3,OFFSET=-10,TEXT="true",G=1,B=1,A=0.7,DEPTH=10}
AuxBar^6~f~1!{SIZE=1,USE=1,R=1,COLOUR=2,ANCHOR=3,TEXT="false",OFFSET=-2,DEPTH=2,G=1,B=1,A=1,OTYPE=1}
AuxBar^6~d!2~
AuxBar^6~f~3!{SIZE=1,USE=1,R=1,COLOUR=2,ANCHOR=4,OTYPE=1,OFFSET=0,TEXT="false",A=1,B=1,G=1,DEPTH=5}
AuxBar^6~d!4~5~6~7~8~9~10~
AuxBar^7~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=4,TEXT="false",OFFSET=-2,DEPTH=2,G=1,B=1,A=1,OTYPE=1}
AuxBar^7~d!2~
AuxBar^7~f~3!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=4,OTYPE=1,OFFSET=0,TEXT="false",A=1,B=1,G=1,DEPTH=2}
AuxBar^7~d!4~5~6~7~8~9~10~
AuxBar^8~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,TEXT="false",OFFSET=1,DEPTH=5,G=1,B=1,A=1,OTYPE=1}
AuxBar^8~d!2~3~4~5~6~7~8~9~10~
AuxBar^9~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,TEXT="false",OFFSET=1,DEPTH=5,G=1,B=1,A=1,OTYPE=1}
AuxBar^9~d!2~3~4~5~6~7~8~9~10~
AuxBarText^1~f~1!{COLB=1,HEIGHT=9,COLDA=0.5,OUTLINE=1,COLTYPE=1,MAXCHARS=0,OFFSET=0,ALIGN=2,FONT="Friz Quadrata TT",COLG=1,COLA=0.98,COLR=1}
AuxBarText^1~d!2~3~4~5~6~7~8~9~10~
AuxBarText^2~f~1!{COLB=1,HEIGHT=9,COLDA=0.5,OUTLINE=1,COLTYPE=1,MAXCHARS=0,OFFSET=0,ALIGN=2,FONT="Friz Quadrata TT",COLG=1,COLA=0.98,COLR=1}
AuxBarText^2~d!2~3~4~5~6~7~8~9~10~
AuxBarText^3~f~1!{COLB=1,HEIGHT=9,COLDA=0.5,OUTLINE=1,COLTYPE=1,MAXCHARS=0,OFFSET=0,ALIGN=2,FONT="Friz Quadrata TT",COLG=1,COLA=0.98,COLR=1}
AuxBarText^3~d!2~3~4~5~6~7~8~9~10~
AuxBarText^4~f~1!{COLB=1,HEIGHT=9,COLDA=0.5,OUTLINE=1,COLTYPE=1,MAXCHARS=0,OFFSET=0,ALIGN=2,FONT="Friz Quadrata TT",COLG=1,COLA=0.98,COLR=1}
AuxBarText^4~d!2~3~4~5~6~7~8~9~10~
AuxBarText^5~f~1!{COLB=1,HEIGHT=9,COLDA=0.5,OUTLINE=1,COLTYPE=1,MAXCHARS=0,OFFSET=0,ALIGN=2,FONT="Friz Quadrata TT",COLG=1,COLA=0.98,COLR=1}
AuxBarText^5~d!2~3~4~5~6~7~8~9~10~
AuxBarText^6~f~1!{COLB=1,HEIGHT=9,COLDA=0.5,OUTLINE=1,COLTYPE=1,MAXCHARS=0,OFFSET=0,ALIGN=2,FONT="Friz Quadrata TT",COLG=1,COLA=0.98,COLR=1}
AuxBarText^6~d!2~3~4~5~6~7~8~9~10~
AuxBarText^7~f~1!{COLB=1,HEIGHT=9,COLDA=0.5,OUTLINE=1,COLTYPE=1,MAXCHARS=0,OFFSET=0,ALIGN=2,FONT="Friz Quadrata TT",COLG=1,COLA=0.98,COLR=1}
AuxBarText^7~d!2~3~4~5~6~7~8~9~10~
AuxBarText^8~f~1!{COLB=1,HEIGHT=9,COLDA=0.5,OUTLINE=1,COLTYPE=1,MAXCHARS=0,OFFSET=0,ALIGN=2,FONT="Friz Quadrata TT",COLG=1,COLA=0.98,COLR=1}
AuxBarText^8~d!2~3~4~5~6~7~8~9~10~
AuxBarText^9~f~1!{COLB=1,HEIGHT=9,COLDA=0.5,OUTLINE=1,COLTYPE=1,MAXCHARS=0,OFFSET=0,ALIGN=2,FONT="Friz Quadrata TT",COLG=1,COLA=0.98,COLR=1}
AuxBarText^9~d!2~3~4~5~6~7~8~9~10~
Complete!]]
HealBot_ExtraSkinData[27]=[[Skin
Bottoms Up cRaid 10
Author~v!Monti of Terenas
DuplicateBars~v!false
Chat~t!{EOCOOM="false",EOCOOMV=20,MSG="Casting #s on #n",RESONLY="true",CHAN="",NOTIFY=0}
General~t!{OFREQ=0.07,OMIN=0.1,OMAX=0.95,FLUIDFREQ=10,HIDEPTF="false",HIDEPARTYF="false",STICKYFRAME="true",STICKYSENSITIVITY=35,HIDERAIDF="true",FLUIDBARS="true",HIDEBOSSF="false"}
Healing~t!{TINCSELF="false",GROUPPETS="true",TARGETINCOMBAT=2,TINCRAID=1,FONLYFRIEND="false",SELFPET=0,TONLYFRIEND="false",FALWAYSSHOW="false",FOCUSINCOMBAT=2,TALWAYSSHOW="false",FEXRAID="false",TINCGROUP=1,TEXRAID="false",TINCPET="false"}
Enemy~t!{ENEMYTARGET="false",INCTANKS="true",INCMYTAR="false",INCARENA="true",ENEMYTARGETSIZE=40,INCARENAPETS="false",HIDE="true",NUMBOSS=2,EXISTSHOWPTAR=1,INCSELF="false",EXISTSHOWBOSS="true",DOUBLEWIDTH="false",EXISTSHOWARENA=3}
FrameAlias~f~1!{SIZE=12,NAME="",R=1,ALIAS="Group",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~2!{A=1,NAME="Tanks",R=1,ALIAS="Not Used",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~3!{A=1,NAME="",R=1,ALIAS="Not Used",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~4!{A=1,NAME="",R=1,ALIAS="NotUsed",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~5!{A=1,NAME="",R=1,ALIAS="Not Used",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~6!{A=1,NAME="",R=1,ALIAS="Vehicle",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~7!{A=1,NAME="",R=1,ALIAS="Pets",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~8!{A=1,NAME="",R=1,ALIAS="Target",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~9!{A=1,NAME="",R=1,ALIAS="Focus",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~10!{A=1,NAME="",R=1,ALIAS="Enemy",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAliasBar~f~1!{A=0.5,TEXTURE="HealBot 10",B=0.25,HEIGHT=20,R=0.1,G=0.25,WIDTH=0.7}
FrameAliasBar~d!2~3~4~5~6~7~8~9~10~
Frame~f~1!{BORDERR=0.1,AUTOCLOSE="false",TIPLOC=2,BORDERB=0.1,LOCKED="false",SCALE=1,BORDERA=0.04,SFOFFSETV=0,BACKG=0.102,BACKB=0.702,BACKA=0,OPENSOUND="false",BORDERG=0.1,SFOFFSETH=0,BACKR=0.102}
Frame~f~2!{SFOFFSETH=0,BORDERR=0.1,TIPLOC=2,BORDERB=0.1,LOCKED="false",OPENSOUND="false",BORDERA=0.04,SFOFFSETV=-5,BACKG=0.102,BACKB=0.702,BACKA=0,SCALE=1,AUTOCLOSE="false",BORDERG=0.1,BACKR=0.102}
Frame~f~3!{BORDERR=0.1,AUTOCLOSE="false",TIPLOC=2,BORDERB=0.1,LOCKED="false",SCALE=1,BORDERA=0.04,SFOFFSETV=0,BACKG=0.102,BACKB=0.702,BACKA=0,OPENSOUND="false",BORDERG=0.1,SFOFFSETH=0,BACKR=0.102}
Frame~d!4~5~6~
Frame~f~7!{SFOFFSETH=0,BORDERR=0.1,TIPLOC=2,BORDERB=0.1,LOCKED="false",OPENSOUND="false",BORDERA=0.04,SFOFFSETV=9,BACKG=0.102,BACKB=0.702,BACKA=0,SCALE=1,AUTOCLOSE="false",BORDERG=0.1,BACKR=0.102}
Frame~f~8!{BACKR=0.102,BORDERG=0.1,SFOFFSETH=0,AUTOCLOSE="false",LOCKED="false",SCALE=1,BORDERA=0.04,SFOFFSETV=0,TIPLOC=2,BORDERB=0.1,BACKA=0,OPENSOUND="false",BACKB=0.702,BACKG=0.102,BORDERR=0.1}
Frame~d!9~
Frame~f~10!{BACKR=0.102,BORDERG=0.1,SFOFFSETH=-2,AUTOCLOSE="false",LOCKED="false",SCALE=1,BORDERA=0.04,SFOFFSETV=-7,TIPLOC=2,BORDERB=0.1,BACKA=0,OPENSOUND="false",BACKB=0.702,BACKG=0.102,BORDERR=0.1}
StickyFrames~f~1!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~f~2!{STUCK="false",STUCKTOPOINT="TOPLEFT",STUCKTO=1,STUCKPOINT="BOTTOMLEFT"}
StickyFrames~f~3!{STUCK="false",STUCKTOPOINT="RIGHT",STUCKTO=2,STUCKPOINT="LEFT"}
StickyFrames~f~4!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~d!5~6~
StickyFrames~f~7!{STUCK="true",STUCKTOPOINT="BOTTOMLEFT",STUCKTO=1,STUCKPOINT="TOPLEFT"}
StickyFrames~f~8!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~d!9~
StickyFrames~f~10!{STUCK="true",STUCKTOPOINT="TOPLEFT",STUCKTO=1,STUCKPOINT="BOTTOMLEFT"}
HealGroups~f~1!{FRAME=1,STATE="false",NAME="Self"}
HealGroups~f~2!{FRAME=1,STATE="true",NAME="Main tanks"}
HealGroups~f~3!{FRAME=1,STATE="true",NAME="Healers"}
HealGroups~f~4!{FRAME=1,STATE="true",NAME="Group"}
HealGroups~f~5!{FRAME=1,STATE="false",NAME="Private List"}
HealGroups~f~6!{FRAME=1,STATE="true",NAME="Raid"}
HealGroups~f~7!{FRAME=1,STATE="false",NAME="Vehicle"}
HealGroups~f~8!{FRAME=7,STATE="true",NAME="Pets"}
HealGroups~f~9!{FRAME=8,STATE="false",NAME="Target"}
HealGroups~f~10!{FRAME=9,STATE="false",NAME="Focus"}
HealGroups~f~11!{FRAME=10,STATE="true",NAME="Enemy"}
Anchors~f~1!{Y=67.14,GROW=2,BARS=1,FRAME=1,X=85.93}
Anchors~f~2!{Y=67.97,GROW=2,BARS=1,FRAME=2,X=83.17}
Anchors~f~3!{Y=22.89,GROW=2,BARS=1,FRAME=2,X=31.19}
Anchors~f~4!{Y=53,GROW=2,BARS=1,FRAME=2,X=53}
Anchors~f~5!{Y=50.59,GROW=2,BARS=1,FRAME=2,X=58.13}
Anchors~f~6!{Y=55,GROW=2,BARS=1,FRAME=2,X=55}
Anchors~f~7!{Y=34.56,GROW=2,BARS=1,FRAME=1,X=85.93}
Anchors~f~8!{Y=62.89,GROW=2,BARS=1,FRAME=2,X=79.23}
Anchors~f~9!{Y=61.18,GROW=2,BARS=1,FRAME=2,X=79.23}
Anchors~f~10!{Y=60.14,GROW=2,BARS=2,FRAME=2,X=81.4}
HeadBar~f~1!{SHOW="false",TEXTURE="Tukui2",R=0.102,B=0.102,HEIGHT=28,A=0.4,G=0.102,WIDTH=0.95}
HeadBar~d!2~3~4~5~6~7~8~9~10~
HeadText~f~1!{A=1,R=1,OFFSET=0,B=0.961,FONT="Friz Quadrata TT",HEIGHT=11,G=0.996,OUTLINE=1}
HeadText~d!2~3~4~5~6~7~8~9~10~
HealBar~f~1!{HEIGHT=70,GRPCOLS="false",CMARGIN=0,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=75,RMARGIN=0,OFIX=2,NUMCOLS=2,LOWMANA=1}
HealBar~f~2!{HEIGHT=60,GRPCOLS="false",CMARGIN=0,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=150,RMARGIN=0,OFIX=2,NUMCOLS=1,LOWMANA=1}
HealBar~f~3!{HEIGHT=60,GRPCOLS="false",CMARGIN=0,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=150,RMARGIN=0,OFIX=1,NUMCOLS=1,LOWMANA=1}
HealBar~d!4~5~6~
HealBar~f~7!{HEIGHT=40,GRPCOLS="false",CMARGIN=0,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=1,WIDTH=71,OFIX=2,RMARGIN=0,NUMCOLS=3}
HealBar~f~8!{HEIGHT=60,GRPCOLS="false",CMARGIN=0,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=1,WIDTH=150,OFIX=1,RMARGIN=0,NUMCOLS=1}
HealBar~d!9~
HealBar~f~10!{HEIGHT=45,GRPCOLS="false",CMARGIN=0,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",NUMCOLS=3,RMARGIN=0,OFIX=2,WIDTH=72,LOWMANA=1}
BarCol~f~1!{BACK=3,BA=0.75,BOUT=1,DISA=0.2,BR=0,HB=0.4,BG=0,HG=0.4,HA=1,HR=0.2,ORA=0.5,BB=0,HLTH=2}
BarCol~d!2~3~4~5~6~7~8~9~10~
BarIACol~f~1!{AC=3,AB=1,AA=0.6,AR=1,AG=1,IC=2,IB=0.2,IA=0.6,IR=0.2,IG=0.8}
BarIACol~d!2~3~4~5~6~7~8~9~10~
BarText~f~1!{HLTHONBAR="false",TAGOOR="",HOUTLINE=1,MAXCHARS=12,TAGRIP="",CLASSONBAR="false",OUTLINE=2,HOFFSET=0,INCHEALS=2,OFFSET=5,HLTHTXTANCHOR=1,HLTHTYPE=3,FONT="Friz Quadrata TT",CLASSTYPE=1,NUMFORMAT2=1,IGNOREONFULL="true",TAGDC="",NUMFORMAT1=11,NAMEONBAR="true",HEIGHT=10,HHEIGHT=10,SHOWROLE="true",HALIGN=2,OVERHEAL=1,HMAXCHARS=0,INCABSORBS=1,HOFFSET2=0,ALIGN=2,TAGR="",HFONT="Friz Quadrata TT"}
BarText~f~2!{HLTHONBAR="false",TAGOOR="",HOUTLINE=1,MAXCHARS=0,TAGRIP="",CLASSONBAR="false",OUTLINE=2,HOFFSET=0,INCHEALS=2,OFFSET=5,HLTHTXTANCHOR=1,HLTHTYPE=3,FONT="Friz Quadrata TT",CLASSTYPE=1,NUMFORMAT2=1,IGNOREONFULL="true",TAGDC="",NUMFORMAT1=11,NAMEONBAR="true",HEIGHT=10,HHEIGHT=10,SHOWROLE="true",HALIGN=2,OVERHEAL=1,HMAXCHARS=0,INCABSORBS=1,HOFFSET2=0,ALIGN=2,TAGR="",HFONT="Friz Quadrata TT"}
BarText~f~3!{HLTHONBAR="false",TAGOOR="",HOUTLINE=1,MAXCHARS=12,TAGRIP="",CLASSONBAR="false",OUTLINE=2,HOFFSET=0,INCHEALS=2,OFFSET=10,HLTHTXTANCHOR=1,HLTHTYPE=3,FONT="Friz Quadrata TT",CLASSTYPE=1,NUMFORMAT2=1,IGNOREONFULL="true",TAGDC="",NUMFORMAT1=11,NAMEONBAR="true",HEIGHT=10,HHEIGHT=10,SHOWROLE="true",HALIGN=2,OVERHEAL=1,HMAXCHARS=0,INCABSORBS=1,HOFFSET2=0,ALIGN=2,TAGR="",HFONT="Friz Quadrata TT"}
BarText~d!4~5~6~
BarText~f~7!{HLTHONBAR="false",TAGOOR="",HOUTLINE=1,MAXCHARS=12,NUMFORMAT1=11,CLASSONBAR="false",HFONT="Friz Quadrata TT",OUTLINE=2,INCHEALS=2,OFFSET=-2,HLTHTXTANCHOR=1,HLTHTYPE=3,FONT="Friz Quadrata TT",CLASSTYPE=1,NUMFORMAT2=1,IGNOREONFULL="true",TAGDC="",OVERHEAL=1,TAGRIP="",HEIGHT=10,NAMEONBAR="true",SHOWROLE="true",HALIGN=2,HHEIGHT=10,HMAXCHARS=0,INCABSORBS=1,HOFFSET2=0,ALIGN=2,TAGR="",HOFFSET=0}
BarText~f~8!{HLTHONBAR="false",TAGOOR="",HOUTLINE=1,MAXCHARS=12,NUMFORMAT1=11,CLASSONBAR="false",HFONT="Friz Quadrata TT",OUTLINE=2,INCHEALS=2,OFFSET=10,HLTHTXTANCHOR=1,HLTHTYPE=3,FONT="Friz Quadrata TT",CLASSTYPE=1,NUMFORMAT2=1,IGNOREONFULL="true",TAGDC="",OVERHEAL=1,TAGRIP="",HEIGHT=10,NAMEONBAR="true",SHOWROLE="true",HALIGN=2,HHEIGHT=10,HMAXCHARS=0,INCABSORBS=1,HOFFSET2=0,ALIGN=2,TAGR="",HOFFSET=0}
BarText~d!9~
BarText~f~10!{HLTHONBAR="false",TAGOOR="",HOUTLINE=1,MAXCHARS=12,HHEIGHT=10,CLASSONBAR="false",HFONT="Friz Quadrata TT",OUTLINE=2,OFFSET=5,INCHEALS=2,HLTHTXTANCHOR=1,FONT="Friz Quadrata TT",HLTHTYPE=3,CLASSTYPE=1,NUMFORMAT2=1,OVERHEAL=1,TAGDC="",NUMFORMAT1=11,NAMEONBAR="true",HEIGHT=10,TAGRIP="",SHOWROLE="true",HALIGN=2,IGNOREONFULL="true",HMAXCHARS=0,INCABSORBS=1,HOFFSET2=0,ALIGN=2,TAGR="",HOFFSET=0}
BarTextCol~f~1!{NAME=3,NCR=0.929,HCG=1,NCDA=0.7,NCB=0,NDEBUFF="false",NCG=1,NCA=1,HCA=1,HCB=0,HCR=0.929,HDEBUFF="false",HLTH=3,HCDA=0.7}
BarTextCol~d!2~3~4~5~6~7~8~9~10~
Icons~f~1!{SHOWBUFF="true",POSITION=2,FADESECS=15,DOUBLE="true",I15EN="true",SHOWDEBUFF="true",ONBAR=1,SHOWDIRMOUSE="false",DSCALE=0.55,SHOWDIR="false",SHOWRC="true",SCALE=0.55,FADE="true",MAXDICONS=4,MAXBICONS=6}
Icons~f~2!{SHOWBUFF="true",POSITION=2,FADESECS=15,DOUBLE="true",I15EN="true",SHOWDEBUFF="true",ONBAR=1,SHOWDIRMOUSE="false",DSCALE=0.55,SHOWDIR="false",SHOWRC="true",SCALE=0.55,FADE="true",MAXDICONS=5,MAXBICONS=10}
Icons~f~3!{SHOWBUFF="true",POSITION=2,FADESECS=15,DOUBLE="true",I15EN="true",SHOWDEBUFF="true",ONBAR=1,SHOWDIRMOUSE="false",DSCALE=0.55,SHOWDIR="false",SHOWRC="true",SCALE=0.55,FADE="true",MAXDICONS=3,MAXBICONS=8}
Icons~d!4~5~6~
Icons~f~7!{SHOWBUFF="true",POSITION=2,MAXDICONS=2,I15EN="true",FADESECS=15,DOUBLE="false",ONBAR=1,SHOWDIRMOUSE="false",DSCALE=0.45,SHOWDIR="false",SHOWRC="true",SCALE=0.45,FADE="true",SHOWDEBUFF="true",MAXBICONS=3}
Icons~f~8!{SHOWBUFF="true",POSITION=2,MAXDICONS=3,I15EN="true",FADESECS=15,DOUBLE="true",ONBAR=1,SHOWDIRMOUSE="false",DSCALE=0.55,SHOWDIR="false",SHOWRC="true",SCALE=0.55,FADE="true",SHOWDEBUFF="true",MAXBICONS=8}
Icons~d!9~
Icons~f~10!{SHOWBUFF="true",POSITION=2,MAXDICONS=4,I15EN="true",FADESECS=15,DOUBLE="true",ONBAR=1,SHOWDIRMOUSE="false",DSCALE=0.55,SHOWDIR="false",SHOWRC="true",SCALE=0.55,FADE="true",SHOWDEBUFF="true",MAXBICONS=8}
RaidIcon~f~1!{SQUARE="true",CIRCLE="true",DIAMOND="true",SHOW="true",SKULL="true",TRIANGLE="true",STAR="true",CROSS="true",MOON="true"}
RaidIcon~d!2~3~4~5~6~7~8~9~10~
IconText~f~1!{DURWARN=3,HEIGHT=10,SSCNT="false",SCALE=0.8,SCNT="true",DURTHRH=9,FONT="Swansea",SDUR="true",SSDUR="false",OUTLINE=2}
IconText~f~2!{DURWARN=3,HEIGHT=10,SSCNT="false",SCALE=0.7,SCNT="true",DURTHRH=9,FONT="Swansea",SDUR="true",SSDUR="false",OUTLINE=2}
IconText~d!3~4~5~6~7~8~9~10~
BarVisibility~f~1!{INCCLASSES=1,ALERTIC=1,ALERTOC=0.9,HIDEOOR="false"}
BarVisibility~d!2~3~4~5~6~7~8~9~10~
BarSort~f~1!{SUBORDER=1,OORLAST="false",RAIDORDER=3,SUBPF="true"}
BarSort~d!2~3~4~5~6~7~8~9~10~
BarAggro~f~1!{B=0,ALERTIND=2,G=0,TEXTFORMAT=3,SHOW="true",SHOWTEXTPCT="true",SHOWTEXT="true",R=1,SHOWIND="true",ALERT=2}
BarAggro~d!2~3~4~5~6~7~8~9~10~
AuxBarFrame~f~1!{OVERLAP=2}
AuxBarFrame~d!2~3~4~5~6~7~8~9~10~
AuxBar^1~f~1!{SIZE=1,USE=5,R=1,COLOUR=1,ANCHOR=2,OFFSET=1,DEPTH=2,G=1,B=1,A=1,OTYPE=1}
AuxBar^1~d!2~3~4~5~6~7~8~9~
AuxBar^1~f~10!{SIZE=1,USE=1,R=1,COLOUR=1,ANCHOR=2,OFFSET=1,DEPTH=2,G=1,B=1,A=1,OTYPE=1}
AuxBar^2~f~1!{SIZE=1,USE=5,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=2,G=1,B=1,A=1,OTYPE=1}
AuxBar^2~d!2~3~4~5~6~7~8~9~
AuxBar^2~f~10!{SIZE=1,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=2,G=1,B=1,A=1,OTYPE=1}
AuxBar^3~f~1!{SIZE=1,USE=3,R=1,COLOUR=2,ANCHOR=3,OFFSET=0,DEPTH=8,G=1,B=1,A=1,OTYPE=1}
AuxBar^3~f~2!{SIZE=1,USE=1,R=1,COLOUR=2,ANCHOR=3,OFFSET=1,DEPTH=8,G=1,B=1,A=1,OTYPE=1}
AuxBar^3~d!3~4~5~6~7~8~9~10~
AuxBar^4~f~1!{SIZE=1,USE=2,R=1,COLOUR=2,ANCHOR=3,OFFSET=0,DEPTH=8,G=1,B=1,A=1,OTYPE=1}
AuxBar^4~f~2!{SIZE=1,USE=1,R=1,COLOUR=2,ANCHOR=3,OFFSET=0,DEPTH=8,G=1,B=1,A=1,OTYPE=1}
AuxBar^4~d!3~4~5~6~7~8~9~10~
AuxBar^5~f~1!{SIZE=1,USE=3,R=1,COLOUR=2,ANCHOR=4,OFFSET=0,DEPTH=8,G=1,B=1,A=1,OTYPE=1}
AuxBar^5~f~2!{SIZE=1,USE=1,R=1,COLOUR=2,ANCHOR=4,OFFSET=0,DEPTH=8,G=1,B=1,A=1,OTYPE=1}
AuxBar^5~d!3~4~5~6~7~8~9~10~
AuxBar^6~f~1!{SIZE=1,USE=2,R=1,COLOUR=2,ANCHOR=4,OFFSET=0,DEPTH=8,G=1,B=1,A=1,OTYPE=1}
AuxBar^6~f~2!{SIZE=1,USE=1,R=1,COLOUR=2,ANCHOR=4,OFFSET=0,DEPTH=8,G=1,B=1,A=1,OTYPE=1}
AuxBar^6~d!3~4~5~6~7~8~9~10~
AuxBar^7~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=4,OFFSET=0,DEPTH=2,G=1,B=1,A=1,OTYPE=1}
AuxBar^7~d!2~3~4~5~6~7~8~9~10~
AuxBar^8~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,A=1,OTYPE=1}
AuxBar^8~d!2~3~4~5~6~7~8~9~10~
AuxBar^9~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,A=1,OTYPE=1}
AuxBar^9~d!2~3~4~5~6~7~8~9~10~
Complete!]]
HealBot_ExtraSkinData[28]=[[Skin
Bottoms Up hRaid 10
Author~v!Monti of Terenas
DuplicateBars~v!false
Chat~t!{EOCOOM="false",EOCOOMV=20,MSG="Casting #s on #n",RESONLY="true",CHAN="",NOTIFY=0}
General~t!{OFREQ=0.07,OMIN=0.1,OMAX=0.95,FLUIDFREQ=10,HIDEPARTYF="false",HIDEBOSSF="false",STICKYFRAME="true",STICKYSENSITIVITY=35,HIDERAIDF="true",FLUIDBARS="false",HIDEPTF="false"}
Healing~t!{TINCSELF="false",GROUPPETS="true",TARGETINCOMBAT=2,FEXRAID="false",FONLYFRIEND="false",TINCPET="false",TONLYFRIEND="false",FALWAYSSHOW="false",FOCUSINCOMBAT=2,TALWAYSSHOW="false",SELFPET=0,TINCGROUP=1,TEXRAID="false",TINCRAID=1}
Enemy~t!{INCARENA="true",INCTANKS="true",INCMYTAR="false",ENEMYTARGET="false",ENEMYTARGETSIZE=40,INCARENAPETS="false",INCSELF="false",NUMBOSS=2,EXISTSHOWPTAR=1,HIDE="true",EXISTSHOWBOSS="true",DOUBLEWIDTH="false",EXISTSHOWARENA=3}
FrameAlias~f~1!{SIZE=12,NAME="",R=1,ALIAS="Group",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~2!{A=1,NAME="Tanks",R=1,ALIAS="Not Used",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~3!{A=1,NAME="",R=1,ALIAS="Not Used",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~4!{A=1,NAME="",R=1,ALIAS="NotUsed",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~5!{A=1,NAME="",R=1,ALIAS="Not Used",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~6!{A=1,NAME="",R=1,ALIAS="Vehicle",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~7!{A=1,NAME="",R=1,ALIAS="Pets",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~8!{A=1,NAME="",R=1,ALIAS="Target",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~9!{A=1,NAME="",R=1,ALIAS="Focus",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~10!{A=1,NAME="",R=1,ALIAS="Enemy",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAliasBar~f~1!{A=0.5,WIDTH=0.7,B=0.25,HEIGHT=20,R=0.1,G=0.25,TEXTURE="HealBot 10"}
FrameAliasBar~d!2~3~4~5~6~7~8~9~10~
Frame~f~1!{BORDERR=0.1,BACKR=0.102,SFOFFSETV=0,SFOFFSETH=0,LOCKED="false",OPENSOUND="false",BORDERA=0.04,BORDERG=0.1,TIPLOC=2,BACKB=0.702,BACKA=0,SCALE=1,BORDERB=0.1,AUTOCLOSE="false",BACKG=0.102}
Frame~f~2!{BACKR=0.102,SFOFFSETV=-5,SFOFFSETH=0,TIPLOC=2,LOCKED="false",SCALE=1,BORDERA=0.04,BORDERG=0.1,BACKG=0.102,BACKB=0.702,BACKA=0,OPENSOUND="false",BORDERB=0.1,AUTOCLOSE="false",BORDERR=0.1}
Frame~f~3!{BORDERR=0.1,BACKR=0.102,SFOFFSETV=0,SFOFFSETH=0,LOCKED="false",OPENSOUND="false",BORDERA=0.04,BORDERG=0.1,TIPLOC=2,BACKB=0.702,BACKA=0,SCALE=1,BORDERB=0.1,AUTOCLOSE="false",BACKG=0.102}
Frame~d!4~5~6~
Frame~f~7!{BACKR=0.102,SFOFFSETV=9,SFOFFSETH=0,TIPLOC=2,LOCKED="false",SCALE=1,BORDERA=0.04,BORDERG=0.1,BACKG=0.102,BACKB=0.702,BACKA=0,OPENSOUND="false",BORDERB=0.1,AUTOCLOSE="false",BORDERR=0.1}
Frame~f~8!{BORDERR=0.1,BACKR=0.102,AUTOCLOSE="false",BORDERB=0.1,LOCKED="false",OPENSOUND="false",BORDERA=0.04,SFOFFSETV=0,TIPLOC=2,BACKB=0.702,BACKA=0,SCALE=1,BACKG=0.102,SFOFFSETH=0,BORDERG=0.1}
Frame~d!9~
Frame~f~10!{BORDERR=0.1,BACKR=0.102,AUTOCLOSE="false",BORDERB=0.1,LOCKED="false",OPENSOUND="false",BORDERA=0.04,SFOFFSETV=-7,TIPLOC=2,BACKB=0.702,BACKA=0,SCALE=1,BACKG=0.102,SFOFFSETH=0,BORDERG=0.1}
StickyFrames~f~1!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~f~2!{STUCK="false",STUCKTOPOINT="TOPLEFT",STUCKTO=1,STUCKPOINT="BOTTOMLEFT"}
StickyFrames~f~3!{STUCK="false",STUCKTOPOINT="RIGHT",STUCKTO=2,STUCKPOINT="LEFT"}
StickyFrames~f~4!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~d!5~6~
StickyFrames~f~7!{STUCK="true",STUCKTOPOINT="BOTTOMLEFT",STUCKTO=1,STUCKPOINT="TOPLEFT"}
StickyFrames~f~8!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~d!9~
StickyFrames~f~10!{STUCK="true",STUCKTOPOINT="TOPLEFT",STUCKTO=1,STUCKPOINT="BOTTOMLEFT"}
HealGroups~f~1!{FRAME=1,STATE="false",NAME="Self"}
HealGroups~f~2!{FRAME=1,STATE="true",NAME="Main tanks"}
HealGroups~f~3!{FRAME=1,STATE="true",NAME="Healers"}
HealGroups~f~4!{FRAME=1,STATE="true",NAME="Group"}
HealGroups~f~5!{FRAME=1,STATE="false",NAME="Private List"}
HealGroups~f~6!{FRAME=1,STATE="true",NAME="Raid"}
HealGroups~f~7!{FRAME=1,STATE="false",NAME="Vehicle"}
HealGroups~f~8!{FRAME=7,STATE="true",NAME="Pets"}
HealGroups~f~9!{FRAME=8,STATE="false",NAME="Target"}
HealGroups~f~10!{FRAME=9,STATE="false",NAME="Focus"}
HealGroups~f~11!{FRAME=10,STATE="true",NAME="Enemy"}
Anchors~f~1!{Y=67.42,GROW=2,BARS=1,FRAME=1,X=85.56}
Anchors~f~2!{Y=68.46,GROW=2,BARS=1,FRAME=2,X=88.73}
Anchors~f~3!{Y=22.89,GROW=2,BARS=1,FRAME=2,X=31.19}
Anchors~f~4!{Y=53,GROW=2,BARS=1,FRAME=2,X=53}
Anchors~f~5!{Y=50.59,GROW=2,BARS=1,FRAME=2,X=58.13}
Anchors~f~6!{Y=55,GROW=2,BARS=1,FRAME=2,X=55}
Anchors~f~7!{Y=35.67,GROW=2,BARS=1,FRAME=1,X=85.56}
Anchors~f~8!{Y=64.7,GROW=2,BARS=1,FRAME=2,X=81.97}
Anchors~f~9!{Y=58,GROW=2,BARS=1,FRAME=2,X=58}
Anchors~f~10!{Y=66.84,GROW=2,BARS=2,FRAME=2,X=85.56}
HeadBar~f~1!{SHOW="false",WIDTH=0.95,B=0.102,R=0.102,HEIGHT=28,A=0.4,G=0.102,TEXTURE="Tukui2"}
HeadBar~d!2~3~4~5~6~7~8~9~10~
HeadText~f~1!{A=1,B=0.961,OFFSET=0,R=1,FONT="Friz Quadrata TT",HEIGHT=11,G=0.996,OUTLINE=1}
HeadText~d!2~3~4~5~6~7~8~9~10~
HealBar~f~1!{HEIGHT=70,GRPCOLS="false",CMARGIN=0,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=1,NUMCOLS=2,OFIX=2,RMARGIN=0,WIDTH=90}
HealBar~f~2!{HEIGHT=60,GRPCOLS="false",CMARGIN=0,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=1,NUMCOLS=1,OFIX=2,RMARGIN=0,WIDTH=150}
HealBar~f~3!{HEIGHT=60,GRPCOLS="false",CMARGIN=0,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=1,NUMCOLS=1,OFIX=1,RMARGIN=0,WIDTH=150}
HealBar~d!4~5~6~
HealBar~f~7!{HEIGHT=40,GRPCOLS="false",CMARGIN=0,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",NUMCOLS=3,RMARGIN=0,OFIX=2,WIDTH=65,LOWMANA=1}
HealBar~f~8!{HEIGHT=60,GRPCOLS="false",CMARGIN=0,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",NUMCOLS=1,RMARGIN=0,OFIX=1,WIDTH=150,LOWMANA=1}
HealBar~d!9~
HealBar~f~10!{HEIGHT=45,GRPCOLS="false",CMARGIN=0,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=1,WIDTH=69,OFIX=2,RMARGIN=0,NUMCOLS=3}
BarCol~f~1!{BACK=3,BA=0.75,BOUT=1,DISA=0.2,BR=0,HB=0.4,BG=0,BB=0,HA=1,HR=0.2,ORA=0.5,HG=0.4,HLTH=2}
BarCol~d!2~3~4~5~6~7~8~9~10~
BarIACol~f~1!{AC=3,AB=1,AA=0.6,AR=1,AG=1,IC=2,IB=0.2,IA=0.6,IR=0.2,IG=0.8}
BarIACol~d!2~3~4~5~6~7~8~9~10~
BarText~f~1!{HLTHONBAR="false",TAGOOR="",HOUTLINE=1,MAXCHARS=0,CLASSONBAR="false",HFONT="Friz Quadrata TT",OUTLINE=1,FONT="Friz Quadrata TT",OFFSET=7,HLTHTXTANCHOR=1,HLTHTYPE=3,INCHEALS=2,INCABSORBS=1,NUMFORMAT2=1,HMAXCHARS=0,NUMFORMAT1=1,OVERHEAL=1,NAMEONBAR="true",HEIGHT=10,IGNOREONFULL="true",SHOWROLE="true",HALIGN=2,TAGRIP="",TAGDC="",HHEIGHT=10,CLASSTYPE=1,HOFFSET2=0,ALIGN=2,TAGR="[ R ] ",HOFFSET=0}
BarText~f~2!{HHEIGHT=10,TAGOOR="",HOUTLINE=1,MAXCHARS=0,HMAXCHARS=0,HOFFSET=0,OUTLINE=1,FONT="Friz Quadrata TT",OFFSET=7,HLTHTXTANCHOR=1,HLTHTYPE=3,CLASSONBAR="false",INCABSORBS=1,NUMFORMAT2=1,INCHEALS=2,NUMFORMAT1=1,OVERHEAL=1,NAMEONBAR="true",HEIGHT=10,IGNOREONFULL="true",SHOWROLE="true",HALIGN=2,TAGRIP="",TAGDC="",HLTHONBAR="false",CLASSTYPE=1,HOFFSET2=0,ALIGN=2,TAGR="[ R ] ",HFONT="Friz Quadrata TT"}
BarText~d!3~
BarText~f~4!{HLTHONBAR="false",TAGOOR="",OVERHEAL=1,MAXCHARS=0,HMAXCHARS=0,HOFFSET=0,FONT="Friz Quadrata TT",INCHEALS=2,OFFSET=7,HLTHTXTANCHOR=1,HLTHTYPE=1,CLASSONBAR="false",INCABSORBS=1,NUMFORMAT2=1,HOUTLINE=1,TAGDC="[ DC ] ",HHEIGHT=10,NAMEONBAR="true",HEIGHT=10,HFONT="Friz Quadrata TT",SHOWROLE="true",HALIGN=2,TAGRIP="",IGNOREONFULL="true",NUMFORMAT1=11,CLASSTYPE=1,HOFFSET2=0,ALIGN=2,TAGR="[ R ] ",OUTLINE=2}
BarText~f~5!{HHEIGHT=10,TAGOOR="",HOUTLINE=1,MAXCHARS=0,HMAXCHARS=0,OUTLINE=2,FONT="Friz Quadrata TT",CLASSONBAR="false",OFFSET=7,HLTHTXTANCHOR=1,HLTHTYPE=1,OVERHEAL=1,INCABSORBS=1,NUMFORMAT2=1,INCHEALS=2,TAGDC="[ DC ] ",NAMEONBAR="true",TAGRIP="",HEIGHT=10,HFONT="Friz Quadrata TT",SHOWROLE="true",HALIGN=2,IGNOREONFULL="true",NUMFORMAT1=11,HLTHONBAR="false",CLASSTYPE=1,HOFFSET2=0,ALIGN=2,TAGR="[ R ] ",HOFFSET=0}
BarText~d!6~7~8~9~10~
BarTextCol~f~1!{NAME=1,HCA=1,HCDA=0.7,NCDA=0.7,NCB=0,HCG=1,HCB=0,HCR=0.929,NCA=1,NCG=1,NDEBUFF="false",HDEBUFF="false",NCR=0.929,HLTH=3}
BarTextCol~d!2~3~4~5~6~7~8~9~10~
Icons~f~1!{SHOWBUFF="true",SHOWDEBUFF="true",MAXDICONS=4,FADESECS=15,SHOWDIRMOUSE="false",I15EN="true",SHOWDIR="false",DOUBLE="true",DSCALE=0.55,ONBAR=1,SHOWRC="true",SCALE=0.55,FADE="true",POSITION=2,MAXBICONS=6}
Icons~f~2!{SHOWBUFF="true",SHOWDEBUFF="true",MAXDICONS=5,FADESECS=15,SHOWDIRMOUSE="false",I15EN="true",SHOWDIR="false",DOUBLE="true",DSCALE=0.55,ONBAR=1,SHOWRC="true",SCALE=0.55,FADE="true",POSITION=2,MAXBICONS=10}
Icons~f~3!{SHOWBUFF="true",SHOWDEBUFF="true",MAXDICONS=3,FADESECS=15,SHOWDIRMOUSE="false",I15EN="true",SHOWDIR="false",DOUBLE="true",DSCALE=0.55,ONBAR=1,SHOWRC="true",SCALE=0.55,FADE="true",POSITION=2,MAXBICONS=8}
Icons~d!4~5~6~
Icons~f~7!{SHOWBUFF="true",POSITION=2,I15EN="true",FADE="true",FADESECS=15,SHOWDEBUFF="true",SHOWDIR="false",DOUBLE="false",DSCALE=0.45,ONBAR=1,SHOWRC="true",SCALE=0.45,SHOWDIRMOUSE="false",MAXDICONS=2,MAXBICONS=3}
Icons~f~8!{SHOWBUFF="true",POSITION=2,I15EN="true",FADE="true",FADESECS=15,SHOWDEBUFF="true",SHOWDIR="false",DOUBLE="true",DSCALE=0.55,ONBAR=1,SHOWRC="true",SCALE=0.55,SHOWDIRMOUSE="false",MAXDICONS=3,MAXBICONS=8}
Icons~d!9~
Icons~f~10!{SHOWBUFF="true",POSITION=2,I15EN="true",FADE="true",FADESECS=15,SHOWDEBUFF="true",SHOWDIR="false",DOUBLE="true",DSCALE=0.55,ONBAR=1,SHOWRC="true",SCALE=0.55,SHOWDIRMOUSE="false",MAXDICONS=4,MAXBICONS=8}
RaidIcon~f~1!{SQUARE="true",CIRCLE="true",DIAMOND="true",SHOW="true",SKULL="true",TRIANGLE="true",STAR="true",MOON="true",CROSS="true"}
RaidIcon~d!2~3~4~5~6~7~8~9~10~
IconText~f~1!{SDUR="true",HEIGHT=10,SSCNT="false",SCALE=0.8,SCNT="true",DURTHRH=9,FONT="Swansea",DURWARN=3,SSDUR="false",OUTLINE=2}
IconText~f~2!{SDUR="true",HEIGHT=10,SSCNT="false",SCALE=0.7,SCNT="true",DURTHRH=9,FONT="Swansea",DURWARN=3,SSDUR="false",OUTLINE=2}
IconText~d!3~4~5~6~7~8~9~10~
BarVisibility~f~1!{INCCLASSES=1,ALERTIC=1,ALERTOC=0.9,HIDEOOR="false"}
BarVisibility~d!2~3~4~5~6~7~8~9~10~
BarSort~f~1!{SUBORDER=1,OORLAST="false",RAIDORDER=3,SUBPF="true"}
BarSort~d!2~3~4~5~6~7~8~9~10~
BarAggro~f~1!{B=0,ALERTIND=2,G=0,TEXTFORMAT=3,SHOW="true",SHOWTEXTPCT="true",SHOWIND="false",R=1,SHOWTEXT="false",ALERT=2}
BarAggro~d!2~3~4~5~6~7~8~9~10~
AuxBarFrame~f~1!{OVERLAP=2}
AuxBarFrame~d!2~3~4~5~6~7~8~9~10~
AuxBar^1~f~1!{SIZE=1,USE=1,R=1,COLOUR=1,ANCHOR=2,OFFSET=1,DEPTH=2,OTYPE=1,A=1,B=1,G=1}
AuxBar^1~d!2~3~4~5~6~7~8~9~10~
AuxBar^2~f~1!{SIZE=1,USE=5,R=1,COLOUR=1,ANCHOR=2,OFFSET=0,DEPTH=2,OTYPE=1,A=1,B=1,G=1}
AuxBar^2~d!2~3~4~5~6~7~8~9~
AuxBar^2~f~10!{SIZE=1,USE=1,R=1,COLOUR=1,ANCHOR=2,OFFSET=0,DEPTH=2,OTYPE=1,A=1,B=1,G=1}
AuxBar^3~f~1!{SIZE=1,USE=1,R=1,COLOUR=2,ANCHOR=2,OFFSET=-3,DEPTH=2,OTYPE=1,A=1,B=1,G=1}
AuxBar^3~d!2~3~4~5~6~7~8~9~10~
AuxBar^4~f~1!{SIZE=1,USE=1,R=1,COLOUR=2,ANCHOR=3,OFFSET=0,DEPTH=8,OTYPE=1,A=1,B=1,G=1}
AuxBar^4~d!2~3~4~5~6~7~8~9~10~
AuxBar^5~f~1!{SIZE=1,USE=4,R=1,COLOUR=1,ANCHOR=4,OFFSET=1,DEPTH=10,OTYPE=1,A=1,B=1,G=1}
AuxBar^5~f~2!{SIZE=1,USE=4,R=1,COLOUR=1,ANCHOR=4,OFFSET=1,DEPTH=15,G=1,B=1,A=1,OTYPE=1}
AuxBar^5~d!3~4~5~6~
AuxBar^5~f~7!{SIZE=1,USE=1,R=1,COLOUR=1,ANCHOR=4,OFFSET=1,DEPTH=15,OTYPE=1,A=1,B=1,G=1}
AuxBar^5~f~8!{SIZE=1,USE=4,R=1,COLOUR=1,ANCHOR=4,OFFSET=1,DEPTH=15,OTYPE=1,A=1,B=1,G=1}
AuxBar^5~d!9~
AuxBar^5~f~10!{SIZE=1,USE=1,R=1,COLOUR=1,ANCHOR=4,OFFSET=1,DEPTH=15,OTYPE=1,A=1,B=1,G=1}
AuxBar^6~f~1!{SIZE=1,USE=1,R=1,COLOUR=2,ANCHOR=4,OFFSET=0,DEPTH=8,OTYPE=1,A=1,B=1,G=1}
AuxBar^6~d!2~3~4~5~6~7~8~9~10~
AuxBar^7~f~1!{SIZE=0.98,USE=5,R=1,COLOUR=1,ANCHOR=4,OFFSET=0,DEPTH=2,OTYPE=1,A=1,B=1,G=1}
AuxBar^7~d!2~3~4~5~6~7~8~9~
AuxBar^7~f~10!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=4,OFFSET=0,DEPTH=2,OTYPE=1,A=1,B=1,G=1}
AuxBar^8~f~1!{SIZE=0.98,USE=5,R=1,COLOUR=1,ANCHOR=3,OFFSET=0,DEPTH=2,OTYPE=1,A=1,B=1,G=1}
AuxBar^8~d!2~3~4~5~6~7~8~9~
AuxBar^8~f~10!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=3,OFFSET=0,DEPTH=2,OTYPE=1,A=1,B=1,G=1}
AuxBar^9~f~1!{SIZE=0.98,USE=5,R=1,COLOUR=1,ANCHOR=1,OFFSET=0,DEPTH=2,OTYPE=1,A=1,B=1,G=1}
AuxBar^9~d!2~3~4~5~6~7~8~9~
AuxBar^9~f~10!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=0,DEPTH=2,OTYPE=1,A=1,B=1,G=1}
Complete!]]
HealBot_ExtraSkinData[29]=[[Skin
Bottoms Up Compact Group
Author~v!Monti of Terenas
DuplicateBars~v!true
Chat~t!{EOCOOM="false",EOCOOMV=20,MSG="Casting #s on #n",RESONLY="true",CHAN="",NOTIFY=0}
General~t!{OFREQ=0.07,OMIN=0.1,OMAX=0.95,HIDEBOSSF="false",HIDEPTF="false",FLUIDFREQ=10,STICKYFRAME="true",STICKYSENSITIVITY=35,HIDERAIDF="true",FLUIDBARS="false",HIDEPARTYF="false"}
Healing~t!{TINCSELF="false",GROUPPETS="true",TARGETINCOMBAT=2,TINCPET="false",FONLYFRIEND="false",FEXRAID="false",TONLYFRIEND="false",FALWAYSSHOW="false",FOCUSINCOMBAT=2,TALWAYSSHOW="false",SELFPET=0,TINCGROUP=1,TEXRAID="false",TINCRAID=1}
Enemy~t!{INCARENA="true",INCTANKS="true",INCMYTAR="false",ENEMYTARGET="false",ENEMYTARGETSIZE=40,INCARENAPETS="false",INCSELF="false",NUMBOSS=2,EXISTSHOWPTAR=1,HIDE="true",EXISTSHOWBOSS="true",DOUBLEWIDTH="false",EXISTSHOWARENA=3}
FrameAlias~f~1!{SIZE=12,NAME="Group",R=1,ALIAS="Group",G=1,SHOW="true",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~2!{A=1,NAME="Tanks",R=1,ALIAS="Tanks",G=1,SHOW="true",OFFSET=0,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~3!{A=1,NAME="",R=1,ALIAS="Not Used",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~4!{A=1,NAME="",R=1,ALIAS="NotUsed",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~5!{A=1,NAME="",R=1,ALIAS="Not Used",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~6!{A=1,NAME="",R=1,ALIAS="Vehicle",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~7!{A=1,NAME="Pets",R=1,ALIAS="Pets",G=1,SHOW="true",OFFSET=0,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~8!{A=1,NAME="",R=1,ALIAS="Target",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~9!{A=1,NAME="",R=1,ALIAS="Focus",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~10!{A=1,NAME="Enemy",R=1,ALIAS="Enemy",G=1,SHOW="true",OFFSET=0,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAliasBar~f~1!{A=0.78,WIDTH=0.95,B=0.129,HEIGHT=15,R=0.149,G=0.129,TEXTURE="HealBot 10"}
FrameAliasBar~d!2~
FrameAliasBar~f~3!{A=0.5,TEXTURE="HealBot 10",B=0.25,HEIGHT=20,R=0.1,G=0.25,WIDTH=0.7}
FrameAliasBar~d!4~5~6~
FrameAliasBar~f~7!{A=0.78,TEXTURE="HealBot 10",B=0.129,HEIGHT=15,R=0.149,G=0.129,WIDTH=0.9}
FrameAliasBar~f~8!{A=0.5,TEXTURE="HealBot 10",B=0.25,HEIGHT=20,R=0.1,G=0.25,WIDTH=0.7}
FrameAliasBar~d!9~
FrameAliasBar~f~10!{A=0.8,TEXTURE="HealBot 10",B=0.086,HEIGHT=15,R=0.263,G=0.086,WIDTH=0.9}
Frame~f~1!{BACKR=0.102,SFOFFSETH=0,SFOFFSETV=0,BORDERR=0.1,LOCKED="false",OPENSOUND="false",BORDERA=0.04,BORDERG=0.1,TIPLOC=3,BACKB=0.702,BACKA=0,SCALE=1,BORDERB=0.1,AUTOCLOSE="false",BACKG=0.102}
Frame~f~2!{SFOFFSETH=0,SFOFFSETV=-5,BORDERR=0.1,TIPLOC=4,LOCKED="false",SCALE=1,BORDERA=0.04,BORDERG=0.1,BACKG=0.102,BACKB=0.702,BACKA=0,OPENSOUND="false",BORDERB=0.1,AUTOCLOSE="false",BACKR=0.102}
Frame~f~3!{BACKR=0.1,SFOFFSETH=0,SFOFFSETV=0,BORDERR=0.1,LOCKED="false",OPENSOUND="false",BORDERA=0.04,BORDERG=0.1,TIPLOC=5,BACKB=0.7,BACKA=0.1,SCALE=1,BORDERB=0.1,AUTOCLOSE="false",BACKG=0.1}
Frame~d!4~
Frame~f~5!{SFOFFSETH=0,SFOFFSETV=0,BORDERR=0.1,TIPLOC=2,LOCKED="true",SCALE=1,BORDERA=0.04,BORDERG=0.1,BACKG=0.1,BACKB=0.7,BACKA=0.1,OPENSOUND="false",BORDERB=0.1,AUTOCLOSE="false",BACKR=0.1}
Frame~f~6!{SFOFFSETH=0,SFOFFSETV=0,BORDERR=0.1,TIPLOC=5,LOCKED="false",SCALE=1,BORDERA=0.04,BORDERG=0.1,BACKG=0.1,BACKB=0.7,BACKA=0.1,OPENSOUND="false",BORDERB=0.1,AUTOCLOSE="false",BACKR=0.1}
Frame~f~7!{SFOFFSETH=-5,SFOFFSETV=0,BORDERR=0.1,TIPLOC=5,LOCKED="false",SCALE=1,BORDERA=0.04,BORDERG=0.1,BACKG=0.1,BACKB=0.7,BACKA=0.1,OPENSOUND="false",BORDERB=0.1,AUTOCLOSE="false",BACKR=0.1}
Frame~f~8!{BACKR=0.1,SFOFFSETH=0,AUTOCLOSE="false",BORDERB=0.1,LOCKED="false",OPENSOUND="false",BORDERA=0.04,SFOFFSETV=0,TIPLOC=5,BACKB=0.7,BACKA=0.1,SCALE=1,BACKG=0.1,BORDERG=0.1,BORDERR=0.1}
Frame~f~9!{BORDERR=0.1,BORDERG=0.1,BACKR=0.1,BACKG=0.1,LOCKED="true",SCALE=1,BORDERA=0.04,SFOFFSETV=3,AUTOCLOSE="false",BORDERB=0.1,BACKA=0.1,OPENSOUND="false",BACKB=0.7,TIPLOC=5,SFOFFSETH=0}
Frame~f~10!{BACKR=0.1,SFOFFSETH=0,AUTOCLOSE="false",BORDERB=0,LOCKED="false",OPENSOUND="false",BORDERA=1,SFOFFSETV=4,TIPLOC=2,BACKB=0.7,BACKA=0.1,SCALE=1,BACKG=0.1,BORDERG=0,BORDERR=1}
StickyFrames~f~1!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~f~2!{STUCK="true",STUCKTOPOINT="TOP",STUCKTO=1,STUCKPOINT="BOTTOM"}
StickyFrames~f~3!{STUCK="false",STUCKTOPOINT="RIGHT",STUCKTO=2,STUCKPOINT="LEFT"}
StickyFrames~f~4!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~d!5~6~
StickyFrames~f~7!{STUCK="true",STUCKTOPOINT="BOTTOMRIGHT",STUCKTO=1,STUCKPOINT="BOTTOMLEFT"}
StickyFrames~f~8!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~d!9~
StickyFrames~f~10!{STUCK="true",STUCKTOPOINT="BOTTOMLEFT",STUCKTO=1,STUCKPOINT="BOTTOMRIGHT"}
HealGroups~f~1!{FRAME=1,STATE="false",NAME="Self"}
HealGroups~f~2!{FRAME=2,STATE="true",NAME="Main tanks"}
HealGroups~f~3!{FRAME=1,STATE="false",NAME="Healers"}
HealGroups~f~4!{FRAME=1,STATE="true",NAME="Group"}
HealGroups~f~5!{FRAME=1,STATE="false",NAME="Private List"}
HealGroups~f~6!{FRAME=1,STATE="false",NAME="Raid"}
HealGroups~f~7!{FRAME=1,STATE="false",NAME="Vehicle"}
HealGroups~f~8!{FRAME=7,STATE="true",NAME="Pets"}
HealGroups~f~9!{FRAME=8,STATE="false",NAME="Target"}
HealGroups~f~10!{FRAME=9,STATE="false",NAME="Focus"}
HealGroups~f~11!{FRAME=10,STATE="true",NAME="Enemy"}
Anchors~f~1!{Y=43.08,GROW=2,BARS=3,FRAME=1,X=61.56}
Anchors~f~2!{Y=43.91,GROW=2,BARS=1,FRAME=8,X=68.01}
Anchors~f~3!{Y=22.89,GROW=1,BARS=1,FRAME=6,X=31.19}
Anchors~f~4!{Y=53,GROW=2,BARS=1,FRAME=1,X=53}
Anchors~f~5!{Y=50.59,GROW=2,BARS=1,FRAME=1,X=58.13}
Anchors~f~6!{Y=55,GROW=2,BARS=1,FRAME=1,X=55}
Anchors~f~7!{Y=37.33,GROW=2,BARS=2,FRAME=2,X=74.29}
Anchors~f~8!{Y=47.66,GROW=2,BARS=1,FRAME=1,X=61.56}
Anchors~f~9!{Y=47.66,GROW=2,BARS=1,FRAME=1,X=68.96}
Anchors~f~10!{Y=37.66,GROW=2,BARS=1,FRAME=4,X=61.56}
HeadBar~f~1!{SHOW="false",WIDTH=0.95,B=0.129,R=0.149,HEIGHT=20,A=0.78,G=0.129,TEXTURE="Tukui"}
HeadBar~f~2!{SHOW="false",TEXTURE="Tukui",R=0.102,B=0.102,HEIGHT=20,A=0.4,G=0.102,WIDTH=0.95}
HeadBar~f~3!{SHOW="true",TEXTURE="Tukui",R=0.102,B=0.102,HEIGHT=20,A=0.4,G=0.102,WIDTH=0.95}
HeadBar~d!4~5~6~
HeadBar~f~7!{SHOW="false",TEXTURE="Tukui",R=0.149,B=0.129,HEIGHT=20,A=0.78,G=0.129,WIDTH=0.95}
HeadBar~f~8!{SHOW="true",TEXTURE="Tukui",R=0.102,B=0.102,HEIGHT=20,A=0.4,G=0.102,WIDTH=0.95}
HeadBar~d!9~
HeadBar~f~10!{SHOW="false",WIDTH=0.95,B=0.102,R=0.102,HEIGHT=20,A=0.4,G=0.102,TEXTURE="Tukui"}
HeadText~f~1!{A=1,B=0.961,OFFSET=0,R=1,FONT="Friz Quadrata TT",HEIGHT=11,G=0.996,OUTLINE=1}
HeadText~d!2~3~4~5~6~7~8~9~10~
HealBar~f~1!{HEIGHT=55,GRPCOLS="false",CMARGIN=0,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=1,NUMCOLS=5,OFIX=2,RMARGIN=0,WIDTH=58}
HealBar~f~2!{HEIGHT=40,GRPCOLS="false",CMARGIN=0,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=1,NUMCOLS=2,OFIX=2,RMARGIN=0,WIDTH=120}
HealBar~f~3!{HEIGHT=60,GRPCOLS="false",CMARGIN=2,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=1,NUMCOLS=2,OFIX=1,RMARGIN=2,WIDTH=80}
HealBar~f~4!{HEIGHT=60,GRPCOLS="false",CMARGIN=2,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=80,RMARGIN=2,OFIX=1,NUMCOLS=3,LOWMANA=1}
HealBar~d!5~6~
HealBar~f~7!{HEIGHT=25,GRPCOLS="false",CMARGIN=0,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",NUMCOLS=2,RMARGIN=0,OFIX=2,WIDTH=52,LOWMANA=1}
HealBar~f~8!{HEIGHT=60,GRPCOLS="false",CMARGIN=2,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",NUMCOLS=3,RMARGIN=2,OFIX=1,WIDTH=80,LOWMANA=1}
HealBar~d!9~
HealBar~f~10!{HEIGHT=25,GRPCOLS="false",CMARGIN=0,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=1,WIDTH=58,OFIX=2,RMARGIN=0,NUMCOLS=2}
BarCol~f~1!{BACK=3,BA=0.75,BB=0,DISA=0.2,BR=0,HB=0.4,BG=0,BOUT=0,HA=1,HR=0.2,ORA=0.5,HG=0.4,HLTH=2}
BarCol~d!2~
BarCol~f~3!{BACK=3,BA=0.75,BB=0,DISA=0.2,BR=0,HB=0.4,BG=0,HG=0.4,HA=1,HR=0.2,ORA=0.5,BOUT=1,HLTH=2}
BarCol~d!4~5~6~
BarCol~f~7!{BACK=3,BA=0.75,BB=0,DISA=0.2,BR=0,HB=0.4,BG=0,HG=0.4,HA=1,HR=0.2,ORA=0.5,BOUT=0,HLTH=2}
BarCol~f~8!{BACK=3,BA=0.75,BB=0,DISA=0.2,BR=0,HB=0.4,BG=0,HG=0.4,HA=1,HR=0.2,ORA=0.5,BOUT=1,HLTH=2}
BarCol~d!9~10~
BarIACol~f~1!{AC=3,AB=1,AA=0.6,AR=1,AG=1,IC=2,IB=0.2,IA=0.6,IR=0.2,IG=0.8}
BarIACol~d!2~3~4~5~6~7~8~9~10~
BarText~f~1!{HLTHONBAR="false",TAGOOR="",HOUTLINE=1,MAXCHARS=12,NUMFORMAT1=11,HMAXCHARS=0,HFONT="Friz Quadrata TT",HHEIGHT=10,HOFFSET=0,INCHEALS=2,HLTHTXTANCHOR=1,FONT="Friz Quadrata TT",OFFSET=5,INCABSORBS=1,NUMFORMAT2=1,CLASSONBAR="false",TAGDC="",IGNOREONFULL="true",NAMEONBAR="true",HEIGHT=10,TAGRIP="",SHOWROLE="true",HALIGN=2,OVERHEAL=1,HLTHTYPE=3,CLASSTYPE=1,HOFFSET2=0,ALIGN=2,TAGR="[ R ] ",OUTLINE=2}
BarText~f~2!{HLTHONBAR="false",TAGOOR="",HOUTLINE=1,MAXCHARS=12,FONT="Friz Quadrata TT",HMAXCHARS=0,HFONT="Friz Quadrata TT",HHEIGHT=10,HOFFSET=0,INCHEALS=2,HLTHTXTANCHOR=1,HLTHTYPE=3,OFFSET=2,INCABSORBS=1,NUMFORMAT2=1,IGNOREONFULL="true",NUMFORMAT1=11,TAGDC="",NAMEONBAR="true",HEIGHT=10,TAGRIP="",SHOWROLE="true",HALIGN=2,OVERHEAL=1,CLASSONBAR="false",CLASSTYPE=1,HOFFSET2=0,ALIGN=2,TAGR="[ R ] ",OUTLINE=2}
BarText~f~3!{HLTHONBAR="false",TAGOOR="",OVERHEAL=1,MAXCHARS=12,NAMEONBAR="true",CLASSONBAR="false",OUTLINE=2,HOFFSET=0,OFFSET=0,INCHEALS=2,HLTHTXTANCHOR=1,HLTHTYPE=3,HMAXCHARS=0,CLASSTYPE=1,NUMFORMAT2=1,HOUTLINE=1,NUMFORMAT1=11,FONT="Friz Quadrata TT",TAGRIP="",HEIGHT=10,HHEIGHT=10,SHOWROLE="true",HALIGN=2,TAGDC="",IGNOREONFULL="true",INCABSORBS=1,HOFFSET2=0,ALIGN=2,TAGR="[ R ] ",HFONT="Friz Quadrata TT"}
BarText~d!4~5~6~7~8~9~10~
BarTextCol~f~1!{HCG=1,NCR=0.929,NAME=1,NCDA=0.7,NCB=0,NDEBUFF="false",HCB=0,HCR=0.929,HCA=1,NCG=1,NCA=1,HDEBUFF="false",HCDA=0.7,HLTH=3}
BarTextCol~d!2~3~4~5~6~7~8~9~10~
Icons~f~1!{SHOWBUFF="true",POSITION=2,MAXDICONS=4,I15EN="true",DOUBLE="true",FADESECS=15,SHOWDIR="false",FADE="true",DSCALE=0.55,ONBAR=1,SHOWRC="true",SCALE=0.55,SHOWDIRMOUSE="false",SHOWDEBUFF="true",MAXBICONS=6}
Icons~f~2!{SHOWBUFF="true",POSITION=2,MAXDICONS=5,I15EN="true",DOUBLE="true",FADESECS=15,SHOWDIR="false",FADE="true",DSCALE=0.55,ONBAR=1,SHOWRC="true",SCALE=0.55,SHOWDIRMOUSE="false",SHOWDEBUFF="true",MAXBICONS=10}
Icons~f~3!{SHOWBUFF="true",POSITION=2,MAXDICONS=3,I15EN="true",DOUBLE="true",FADESECS=15,SHOWDIR="false",FADE="true",DSCALE=0.55,ONBAR=1,SHOWRC="true",SCALE=0.55,SHOWDIRMOUSE="false",SHOWDEBUFF="true",MAXBICONS=8}
Icons~d!4~5~6~
Icons~f~7!{SHOWBUFF="true",SHOWDEBUFF="true",MAXDICONS=2,I15EN="true",FADESECS=15,POSITION=2,SHOWDIR="false",SHOWDIRMOUSE="false",DSCALE=0.45,ONBAR=1,SHOWRC="true",SCALE=0.45,DOUBLE="false",FADE="true",MAXBICONS=3}
Icons~f~8!{SHOWBUFF="true",SHOWDEBUFF="true",MAXDICONS=3,I15EN="true",FADESECS=15,POSITION=2,SHOWDIR="false",SHOWDIRMOUSE="false",DSCALE=0.55,ONBAR=1,SHOWRC="true",SCALE=0.55,DOUBLE="true",FADE="true",MAXBICONS=8}
Icons~d!9~
Icons~f~10!{SHOWBUFF="true",SHOWDEBUFF="true",MAXDICONS=4,I15EN="true",FADESECS=15,POSITION=2,SHOWDIR="false",SHOWDIRMOUSE="false",DSCALE=0.55,ONBAR=1,SHOWRC="true",SCALE=0.55,DOUBLE="true",FADE="true",MAXBICONS=8}
RaidIcon~f~1!{SQUARE="true",CIRCLE="true",DIAMOND="true",SHOW="true",MOON="true",TRIANGLE="true",STAR="true",SKULL="true",CROSS="true"}
RaidIcon~d!2~3~4~5~6~7~8~9~10~
IconText~f~1!{SDUR="true",HEIGHT=10,SSCNT="false",SCALE=0.8,SCNT="true",DURTHRH=9,FONT="Swansea",DURWARN=3,SSDUR="false",OUTLINE=2}
IconText~f~2!{SDUR="true",HEIGHT=10,SSCNT="false",SCALE=0.7,SCNT="true",DURTHRH=9,FONT="Swansea",DURWARN=3,SSDUR="false",OUTLINE=2}
IconText~d!3~4~5~6~7~8~9~10~
BarVisibility~f~1!{INCCLASSES=1,ALERTIC=1,ALERTOC=0.9,HIDEOOR="false"}
BarVisibility~d!2~3~4~5~6~7~8~9~10~
BarSort~f~1!{SUBORDER=1,OORLAST="false",RAIDORDER=3,SUBPF="true"}
BarSort~d!2~3~4~5~6~7~8~9~10~
BarAggro~f~1!{B=0,ALERTIND=2,G=0,TEXTFORMAT=3,SHOW="true",SHOWTEXTPCT="true",SHOWTEXT="false",SHOWIND="false",R=1,ALERT=2}
BarAggro~d!2~3~4~5~6~7~8~9~10~
AuxBarFrame~f~1!{OVERLAP=2}
AuxBarFrame~d!2~3~4~5~6~7~8~9~10~
AuxBar^1~f~1!{SIZE=1,USE=5,R=1,COLOUR=1,ANCHOR=2,OFFSET=0,DEPTH=2,OTYPE=1,A=1,B=1,G=1}
AuxBar^1~d!2~3~4~5~6~7~8~9~
AuxBar^1~f~10!{SIZE=1,USE=1,R=1,COLOUR=1,ANCHOR=2,OFFSET=0,DEPTH=2,OTYPE=1,A=1,B=1,G=1}
AuxBar^2~f~1!{SIZE=1,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=2,OTYPE=1,A=1,B=1,G=1}
AuxBar^2~d!2~3~4~5~6~7~8~9~10~
AuxBar^3~f~1!{SIZE=1,USE=1,R=1,COLOUR=2,ANCHOR=3,OFFSET=1,DEPTH=5,OTYPE=1,A=1,B=1,G=1}
AuxBar^3~d!2~3~4~5~6~7~8~9~10~
AuxBar^4~f~1!{SIZE=1,USE=6,R=1,COLOUR=1,ANCHOR=3,OFFSET=0,DEPTH=5,OTYPE=1,A=1,B=1,G=1}
AuxBar^4~d!2~
AuxBar^4~f~3!{SIZE=1,USE=6,R=1,COLOUR=2,ANCHOR=3,OFFSET=0,DEPTH=5,G=1,B=1,A=1,OTYPE=1}
AuxBar^4~d!4~5~6~
AuxBar^4~f~7!{SIZE=1,USE=1,R=1,COLOUR=2,ANCHOR=3,OFFSET=0,DEPTH=5,G=1,B=1,A=1,OTYPE=1}
AuxBar^4~f~8!{SIZE=1,USE=6,R=1,COLOUR=2,ANCHOR=3,OFFSET=0,DEPTH=5,G=1,B=1,A=1,OTYPE=1}
AuxBar^4~d!9~
AuxBar^4~f~10!{SIZE=1,USE=1,R=1,COLOUR=2,ANCHOR=3,OFFSET=0,DEPTH=5,G=1,B=1,A=1,OTYPE=1}
AuxBar^5~f~1!{SIZE=1,USE=4,R=1,COLOUR=1,ANCHOR=4,OFFSET=0,DEPTH=5,OTYPE=1,A=1,B=1,G=1}
AuxBar^5~d!2~3~4~5~6~
AuxBar^5~f~7!{SIZE=1,USE=1,R=1,COLOUR=1,ANCHOR=4,OFFSET=0,DEPTH=5,G=1,B=1,A=1,OTYPE=1}
AuxBar^5~f~8!{SIZE=1,USE=4,R=1,COLOUR=1,ANCHOR=4,OFFSET=0,DEPTH=5,G=1,B=1,A=1,OTYPE=1}
AuxBar^5~d!9~
AuxBar^5~f~10!{SIZE=1,USE=1,R=1,COLOUR=1,ANCHOR=4,OFFSET=0,DEPTH=5,OTYPE=1,A=1,B=1,G=1}
AuxBar^6~f~1!{SIZE=1,USE=1,R=1,COLOUR=2,ANCHOR=4,OFFSET=0,DEPTH=5,OTYPE=1,A=1,B=1,G=1}
AuxBar^6~d!2~3~4~5~6~7~8~9~10~
AuxBar^7~f~1!{SIZE=1,USE=5,R=1,COLOUR=1,ANCHOR=4,OFFSET=0,DEPTH=2,OTYPE=1,A=1,B=1,G=1}
AuxBar^7~d!2~3~4~5~6~7~8~9~
AuxBar^7~f~10!{SIZE=1,USE=1,R=1,COLOUR=1,ANCHOR=4,OFFSET=0,DEPTH=2,G=1,B=1,A=1,OTYPE=1}
AuxBar^8~f~1!{SIZE=1,USE=5,R=1,COLOUR=1,ANCHOR=1,OFFSET=0,DEPTH=2,OTYPE=1,A=1,B=1,G=1}
AuxBar^8~d!2~3~4~5~6~7~8~9~
AuxBar^8~f~10!{SIZE=1,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=0,DEPTH=2,G=1,B=1,A=1,OTYPE=1}
AuxBar^9~f~1!{SIZE=1,USE=5,R=1,COLOUR=1,ANCHOR=3,OFFSET=0,DEPTH=2,OTYPE=1,A=1,B=1,G=1}
AuxBar^9~d!2~3~4~5~6~7~8~9~
AuxBar^9~f~10!{SIZE=1,USE=1,R=1,COLOUR=1,ANCHOR=3,OFFSET=0,DEPTH=2,G=1,B=1,A=1,OTYPE=1}
Complete!]]
HealBot_ExtraSkinData[30]=[[Skin
Bottoms Up Compact Small Raid
Author~v!Monti of Terenas
DuplicateBars~v!true
Chat~t!{EOCOOM="false",EOCOOMV=20,MSG="Casting #s on #n",RESONLY="true",CHAN="",NOTIFY=0}
General~t!{OFREQ=0.07,OMIN=0.1,OMAX=0.95,HIDEBOSSF="false",HIDEPARTYF="false",HIDEPTF="false",HIDERAIDF="true",STICKYFRAME="true",STICKYSENSITIVITY=35,FLUIDBARS="true",FLUIDFREQ=10}
Healing~t!{TINCSELF="false",GROUPPETS="true",TARGETINCOMBAT=2,TINCRAID=1,FONLYFRIEND="false",SELFPET=0,TONLYFRIEND="false",FALWAYSSHOW="false",FOCUSINCOMBAT=2,TALWAYSSHOW="false",FEXRAID="false",TINCGROUP=1,TEXRAID="false",TINCPET="false"}
Enemy~t!{ENEMYTARGET="false",INCTANKS="true",INCMYTAR="false",INCARENA="true",ENEMYTARGETSIZE=40,INCARENAPETS="false",HIDE="true",NUMBOSS=2,EXISTSHOWPTAR=1,INCSELF="false",EXISTSHOWBOSS="true",DOUBLEWIDTH="false",EXISTSHOWARENA=3}
FrameAlias~f~1!{SIZE=12,NAME="Raid",R=1,ALIAS="Raid",G=1,SHOW="true",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~2!{A=1,NAME="Tanks",R=1,ALIAS="Tanks",G=1,SHOW="true",OFFSET=0,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~3!{A=1,NAME="",R=1,ALIAS="Not Used",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~4!{A=1,NAME="",R=1,ALIAS="NotUsed",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~5!{A=1,NAME="",R=1,ALIAS="Not Used",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~6!{A=1,NAME="",R=1,ALIAS="Vehicle",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~7!{A=1,NAME="Pets",R=1,ALIAS="Pets",G=1,SHOW="true",OFFSET=0,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~8!{A=1,NAME="",R=1,ALIAS="Target",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~9!{A=1,NAME="",R=1,ALIAS="Focus",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~10!{A=1,NAME="Enemy",R=1,ALIAS="Enemy",G=1,SHOW="true",OFFSET=0,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAliasBar~f~1!{A=0.78,TEXTURE="HealBot 10",B=0.129,HEIGHT=15,R=0.149,G=0.129,WIDTH=0.95}
FrameAliasBar~d!2~
FrameAliasBar~f~3!{A=0.5,WIDTH=0.7,B=0.25,HEIGHT=20,R=0.1,G=0.25,TEXTURE="HealBot 10"}
FrameAliasBar~d!4~5~6~
FrameAliasBar~f~7!{A=0.78,WIDTH=0.9,B=0.129,HEIGHT=15,R=0.149,G=0.129,TEXTURE="HealBot 10"}
FrameAliasBar~f~8!{A=0.5,WIDTH=0.7,B=0.25,HEIGHT=20,R=0.1,G=0.25,TEXTURE="HealBot 10"}
FrameAliasBar~d!9~
FrameAliasBar~f~10!{A=0.8,WIDTH=0.9,B=0.086,HEIGHT=15,R=0.263,G=0.086,TEXTURE="HealBot 10"}
Frame~f~1!{BACKR=0.102,TIPLOC=3,BACKG=0.102,BACKB=0.702,LOCKED="false",SCALE=1,BORDERA=0.04,BORDERG=0.1,AUTOCLOSE="false",BORDERB=0.1,BACKA=0,OPENSOUND="false",SFOFFSETV=0,BORDERR=0.1,SFOFFSETH=0}
Frame~f~2!{BACKR=0.102,SFOFFSETH=0,BACKG=0.102,BACKB=0.702,LOCKED="false",OPENSOUND="false",BORDERA=0.04,BORDERG=0.1,AUTOCLOSE="false",BORDERB=0.1,BACKA=0,SCALE=1,TIPLOC=4,SFOFFSETV=-5,BORDERR=0.1}
Frame~f~3!{BACKR=0.1,TIPLOC=5,BACKG=0.1,BACKB=0.7,LOCKED="false",SCALE=1,BORDERA=0.04,BORDERG=0.1,AUTOCLOSE="false",BORDERB=0.1,BACKA=0.1,OPENSOUND="false",SFOFFSETV=0,BORDERR=0.1,SFOFFSETH=0}
Frame~d!4~
Frame~f~5!{BACKR=0.1,SFOFFSETH=0,BACKG=0.1,BACKB=0.7,LOCKED="true",OPENSOUND="false",BORDERA=0.04,BORDERG=0.1,AUTOCLOSE="false",BORDERB=0.1,BACKA=0.1,SCALE=1,TIPLOC=2,SFOFFSETV=0,BORDERR=0.1}
Frame~f~6!{BACKR=0.1,SFOFFSETH=0,BACKG=0.1,BACKB=0.7,LOCKED="false",OPENSOUND="false",BORDERA=0.04,BORDERG=0.1,AUTOCLOSE="false",BORDERB=0.1,BACKA=0.1,SCALE=1,TIPLOC=5,SFOFFSETV=0,BORDERR=0.1}
Frame~f~7!{BACKR=0.1,SFOFFSETH=-5,BACKG=0.1,BACKB=0.7,LOCKED="false",OPENSOUND="false",BORDERA=0.04,BORDERG=0.1,AUTOCLOSE="false",BORDERB=0.1,BACKA=0.1,SCALE=1,TIPLOC=5,SFOFFSETV=0,BORDERR=0.1}
Frame~f~8!{BORDERR=0.1,SFOFFSETV=0,BACKR=0.1,TIPLOC=5,LOCKED="false",SCALE=1,BORDERA=0.04,BORDERG=0.1,BACKG=0.1,BACKB=0.7,BACKA=0.1,OPENSOUND="false",BORDERB=0.1,AUTOCLOSE="false",SFOFFSETH=0}
Frame~f~9!{SFOFFSETH=0,BORDERR=0.1,AUTOCLOSE="false",BORDERB=0.1,LOCKED="true",OPENSOUND="false",BORDERA=0.04,SFOFFSETV=3,TIPLOC=5,BACKB=0.7,BACKA=0.1,SCALE=1,BACKG=0.1,BORDERG=0.1,BACKR=0.1}
Frame~f~10!{BORDERR=1,SFOFFSETV=4,BACKR=0.1,TIPLOC=2,LOCKED="false",SCALE=1,BORDERA=1,BORDERG=0,BACKG=0.1,BACKB=0.7,BACKA=0.1,OPENSOUND="false",BORDERB=0,AUTOCLOSE="false",SFOFFSETH=0}
StickyFrames~f~1!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~f~2!{STUCK="true",STUCKTOPOINT="TOP",STUCKTO=1,STUCKPOINT="BOTTOM"}
StickyFrames~f~3!{STUCK="false",STUCKTOPOINT="RIGHT",STUCKTO=2,STUCKPOINT="LEFT"}
StickyFrames~f~4!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~d!5~6~
StickyFrames~f~7!{STUCK="true",STUCKTOPOINT="BOTTOMRIGHT",STUCKTO=1,STUCKPOINT="BOTTOMLEFT"}
StickyFrames~f~8!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~d!9~
StickyFrames~f~10!{STUCK="true",STUCKTOPOINT="BOTTOMLEFT",STUCKTO=1,STUCKPOINT="BOTTOMRIGHT"}
HealGroups~f~1!{FRAME=1,STATE="false",NAME="Self"}
HealGroups~f~2!{FRAME=2,STATE="true",NAME="Main tanks"}
HealGroups~f~3!{FRAME=1,STATE="false",NAME="Healers"}
HealGroups~f~4!{FRAME=1,STATE="false",NAME="Group"}
HealGroups~f~5!{FRAME=1,STATE="false",NAME="Private List"}
HealGroups~f~6!{FRAME=1,STATE="true",NAME="Raid"}
HealGroups~f~7!{FRAME=1,STATE="false",NAME="Vehicle"}
HealGroups~f~8!{FRAME=7,STATE="true",NAME="Pets"}
HealGroups~f~9!{FRAME=8,STATE="false",NAME="Target"}
HealGroups~f~10!{FRAME=9,STATE="false",NAME="Focus"}
HealGroups~f~11!{FRAME=10,STATE="true",NAME="Enemy"}
Anchors~f~1!{Y=43.69,GROW=2,BARS=3,FRAME=1,X=59.99}
Anchors~f~2!{Y=44.52,GROW=2,BARS=1,FRAME=8,X=66.44}
Anchors~f~3!{Y=22.89,GROW=1,BARS=1,FRAME=6,X=31.19}
Anchors~f~4!{Y=53,GROW=2,BARS=1,FRAME=1,X=53}
Anchors~f~5!{Y=50.59,GROW=2,BARS=1,FRAME=1,X=58.13}
Anchors~f~6!{Y=55,GROW=2,BARS=1,FRAME=1,X=55}
Anchors~f~7!{Y=34.69,GROW=2,BARS=2,FRAME=2,X=72.72}
Anchors~f~8!{Y=19.3,GROW=2,BARS=1,FRAME=1,X=37.04}
Anchors~f~9!{Y=16.76,GROW=2,BARS=1,FRAME=1,X=37.04}
Anchors~f~10!{Y=35.02,GROW=2,BARS=1,FRAME=4,X=59.99}
HeadBar~f~1!{SHOW="false",TEXTURE="Tukui",R=0.149,B=0.129,HEIGHT=20,A=0.78,G=0.129,WIDTH=0.95}
HeadBar~f~2!{SHOW="false",WIDTH=0.95,B=0.102,R=0.102,HEIGHT=20,A=0.4,G=0.102,TEXTURE="Tukui"}
HeadBar~f~3!{SHOW="true",WIDTH=0.95,B=0.102,R=0.102,HEIGHT=20,A=0.4,G=0.102,TEXTURE="Tukui"}
HeadBar~d!4~5~6~
HeadBar~f~7!{SHOW="false",WIDTH=0.95,B=0.129,R=0.149,HEIGHT=20,A=0.78,G=0.129,TEXTURE="Tukui"}
HeadBar~f~8!{SHOW="true",WIDTH=0.95,B=0.102,R=0.102,HEIGHT=20,A=0.4,G=0.102,TEXTURE="Tukui"}
HeadBar~d!9~
HeadBar~f~10!{SHOW="false",TEXTURE="Tukui",R=0.102,B=0.102,HEIGHT=20,A=0.4,G=0.102,WIDTH=0.95}
HeadText~f~1!{A=1,R=1,OFFSET=0,B=0.961,FONT="Friz Quadrata TT",HEIGHT=11,G=0.996,OUTLINE=1}
HeadText~d!2~3~4~5~6~7~8~9~10~
HealBar~f~1!{HEIGHT=45,GRPCOLS="false",CMARGIN=0,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=58,RMARGIN=0,OFIX=2,NUMCOLS=5,LOWMANA=1}
HealBar~f~2!{HEIGHT=40,GRPCOLS="false",CMARGIN=0,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=120,RMARGIN=0,OFIX=2,NUMCOLS=2,LOWMANA=1}
HealBar~f~3!{HEIGHT=60,GRPCOLS="false",CMARGIN=2,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=80,RMARGIN=2,OFIX=1,NUMCOLS=2,LOWMANA=1}
HealBar~f~4!{HEIGHT=60,GRPCOLS="false",CMARGIN=2,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=1,NUMCOLS=3,OFIX=1,RMARGIN=2,WIDTH=80}
HealBar~d!5~6~
HealBar~f~7!{HEIGHT=28,GRPCOLS="false",CMARGIN=0,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=1,WIDTH=52,OFIX=2,RMARGIN=0,NUMCOLS=2}
HealBar~f~8!{HEIGHT=60,GRPCOLS="false",CMARGIN=2,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=1,WIDTH=80,OFIX=1,RMARGIN=2,NUMCOLS=3}
HealBar~d!9~
HealBar~f~10!{HEIGHT=28,GRPCOLS="false",CMARGIN=0,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",NUMCOLS=2,RMARGIN=0,OFIX=2,WIDTH=58,LOWMANA=1}
BarCol~f~1!{BACK=3,BA=0.75,BB=0,DISA=0.2,BR=0,HB=0.4,BG=0,HR=0.2,HA=1,HG=0.4,ORA=0.5,BOUT=0,HLTH=2}
BarCol~d!2~
BarCol~f~3!{BACK=3,BA=0.75,BOUT=1,DISA=0.2,BR=0,HB=0.4,BG=0,BB=0,HA=1,HR=0.2,ORA=0.5,HG=0.4,HLTH=2}
BarCol~d!4~5~6~
BarCol~f~7!{BACK=3,BA=0.75,BOUT=0,DISA=0.2,BR=0,HB=0.4,BG=0,BB=0,HA=1,HR=0.2,ORA=0.5,HG=0.4,HLTH=2}
BarCol~f~8!{BACK=3,BA=0.75,BOUT=1,DISA=0.2,BR=0,HB=0.4,BG=0,BB=0,HA=1,HR=0.2,ORA=0.5,HG=0.4,HLTH=2}
BarCol~d!9~10~
BarIACol~f~1!{AC=3,AB=1,AA=0.6,AR=1,AG=1,IC=2,IB=0.2,IA=0.6,IR=0.2,IG=0.8}
BarIACol~d!2~3~4~5~6~7~8~9~10~
BarText~f~1!{HLTHONBAR="false",TAGOOR="",IGNOREONFULL="true",MAXCHARS=12,TAGRIP="",CLASSONBAR="false",OUTLINE=2,HOUTLINE=1,OFFSET=0,INCHEALS=2,HLTHTXTANCHOR=1,FONT="Friz Quadrata TT",HMAXCHARS=0,CLASSTYPE=1,NUMFORMAT2=1,OVERHEAL=1,TAGDC="",NUMFORMAT1=11,NAMEONBAR="true",HEIGHT=10,HFONT="Friz Quadrata TT",SHOWROLE="true",HALIGN=2,HHEIGHT=10,HLTHTYPE=3,INCABSORBS=1,HOFFSET2=0,ALIGN=2,TAGR="[ R ] ",HOFFSET=0}
BarText~d!2~3~4~
BarText~f~5!{HLTHONBAR="false",TAGOOR="",IGNOREONFULL="true",MAXCHARS=12,TAGRIP="",CLASSONBAR="false",HOFFSET=0,HOUTLINE=1,HLTHTYPE=3,INCHEALS=2,HLTHTXTANCHOR=1,FONT="Friz Quadrata TT",HMAXCHARS=0,CLASSTYPE=1,NUMFORMAT2=1,OVERHEAL=1,NUMFORMAT1=1,OFFSET=0,NAMEONBAR="true",HEIGHT=10,HFONT="Friz Quadrata TT",SHOWROLE="true",HALIGN=2,HHEIGHT=10,TAGDC="",INCABSORBS=1,HOFFSET2=0,ALIGN=2,TAGR="[ R ] ",OUTLINE=2}
BarText~d!6~7~8~9~10~
BarTextCol~f~1!{NCB=0,NCR=0.929,HCG=1,NCDA=0.7,NAME=1,HCA=1,HCB=0,HCR=0.929,NDEBUFF="false",NCG=1,NCA=1,HDEBUFF="false",HLTH=3,HCDA=0.7}
BarTextCol~d!2~3~4~5~6~7~8~9~10~
Icons~f~1!{SHOWBUFF="true",SHOWDEBUFF="true",FADESECS=15,MAXDICONS=4,I15EN="true",POSITION=2,ONBAR=1,FADE="true",DSCALE=0.55,SHOWDIR="false",SHOWRC="true",SCALE=0.55,DOUBLE="true",SHOWDIRMOUSE="false",MAXBICONS=6}
Icons~f~2!{SHOWBUFF="true",SHOWDEBUFF="true",FADESECS=15,MAXDICONS=5,I15EN="true",POSITION=2,ONBAR=1,FADE="true",DSCALE=0.55,SHOWDIR="false",SHOWRC="true",SCALE=0.55,DOUBLE="true",SHOWDIRMOUSE="false",MAXBICONS=10}
Icons~f~3!{SHOWBUFF="true",SHOWDEBUFF="true",FADESECS=15,MAXDICONS=3,I15EN="true",POSITION=2,ONBAR=1,FADE="true",DSCALE=0.55,SHOWDIR="false",SHOWRC="true",SCALE=0.55,DOUBLE="true",SHOWDIRMOUSE="false",MAXBICONS=8}
Icons~d!4~5~6~
Icons~f~7!{SHOWBUFF="true",SHOWDEBUFF="true",FADESECS=15,I15EN="true",DOUBLE="false",MAXDICONS=2,ONBAR=1,FADE="true",DSCALE=0.45,SHOWDIR="false",SHOWRC="true",SCALE=0.45,SHOWDIRMOUSE="false",POSITION=2,MAXBICONS=3}
Icons~f~8!{SHOWBUFF="true",SHOWDEBUFF="true",FADESECS=15,I15EN="true",DOUBLE="true",MAXDICONS=3,ONBAR=1,FADE="true",DSCALE=0.55,SHOWDIR="false",SHOWRC="true",SCALE=0.55,SHOWDIRMOUSE="false",POSITION=2,MAXBICONS=8}
Icons~d!9~
Icons~f~10!{SHOWBUFF="true",SHOWDEBUFF="true",FADESECS=15,I15EN="true",DOUBLE="true",MAXDICONS=4,ONBAR=1,FADE="true",DSCALE=0.55,SHOWDIR="false",SHOWRC="true",SCALE=0.55,SHOWDIRMOUSE="false",POSITION=2,MAXBICONS=8}
RaidIcon~f~1!{SQUARE="true",CIRCLE="true",DIAMOND="true",SHOW="true",MOON="true",TRIANGLE="true",STAR="true",CROSS="true",SKULL="true"}
RaidIcon~d!2~3~4~5~6~7~8~9~10~
IconText~f~1!{DURWARN=3,HEIGHT=10,SSCNT="false",SCALE=0.8,SCNT="true",DURTHRH=9,FONT="Swansea",SDUR="true",SSDUR="false",OUTLINE=2}
IconText~f~2!{DURWARN=3,HEIGHT=10,SSCNT="false",SCALE=0.7,SCNT="true",DURTHRH=9,FONT="Swansea",SDUR="true",SSDUR="false",OUTLINE=2}
IconText~d!3~4~5~6~7~8~9~10~
BarVisibility~f~1!{INCCLASSES=1,ALERTIC=1,ALERTOC=0.9,HIDEOOR="false"}
BarVisibility~d!2~3~4~5~6~7~8~9~10~
BarSort~f~1!{SUBORDER=1,OORLAST="false",RAIDORDER=3,SUBPF="true"}
BarSort~d!2~3~4~5~6~7~8~9~10~
BarAggro~f~1!{R=1,ALERTIND=2,G=0,TEXTFORMAT=3,SHOW="true",SHOWTEXTPCT="true",B=0,SHOWIND="true",SHOWTEXT="true",ALERT=2}
BarAggro~d!2~3~4~5~6~7~8~9~10~
AuxBarFrame~f~1!{OVERLAP=2}
AuxBarFrame~d!2~3~4~5~6~7~8~9~10~
AuxBar^1~f~1!{SIZE=1,USE=5,R=1,COLOUR=1,ANCHOR=2,OFFSET=0,DEPTH=2,G=1,B=1,A=1,OTYPE=1}
AuxBar^1~d!2~3~4~5~6~7~8~9~
AuxBar^1~f~10!{SIZE=1,USE=1,R=1,COLOUR=1,ANCHOR=2,OFFSET=0,DEPTH=2,G=1,B=1,A=1,OTYPE=1}
AuxBar^2~f~1!{SIZE=1,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=2,G=1,B=1,A=1,OTYPE=1}
AuxBar^2~d!2~3~4~5~6~7~8~9~10~
AuxBar^3~f~1!{SIZE=1,USE=1,R=1,COLOUR=2,ANCHOR=3,OFFSET=1,DEPTH=5,G=1,B=1,A=1,OTYPE=1}
AuxBar^3~d!2~3~4~5~6~7~8~9~10~
AuxBar^4~f~1!{SIZE=1,USE=6,R=1,COLOUR=2,ANCHOR=3,OFFSET=0,DEPTH=5,G=1,B=1,A=1,OTYPE=1}
AuxBar^4~d!2~3~4~5~6~
AuxBar^4~f~7!{SIZE=1,USE=1,R=1,COLOUR=2,ANCHOR=3,OFFSET=0,DEPTH=5,OTYPE=1,A=1,B=1,G=1}
AuxBar^4~f~8!{SIZE=1,USE=6,R=1,COLOUR=2,ANCHOR=3,OFFSET=0,DEPTH=5,OTYPE=1,A=1,B=1,G=1}
AuxBar^4~d!9~
AuxBar^4~f~10!{SIZE=1,USE=1,R=1,COLOUR=2,ANCHOR=3,OFFSET=0,DEPTH=5,OTYPE=1,A=1,B=1,G=1}
AuxBar^5~f~1!{SIZE=1,USE=4,R=1,COLOUR=1,ANCHOR=4,OFFSET=0,DEPTH=5,G=1,B=1,A=1,OTYPE=1}
AuxBar^5~d!2~3~4~5~6~
AuxBar^5~f~7!{SIZE=1,USE=1,R=1,COLOUR=1,ANCHOR=4,OFFSET=0,DEPTH=5,OTYPE=1,A=1,B=1,G=1}
AuxBar^5~f~8!{SIZE=1,USE=4,R=1,COLOUR=1,ANCHOR=4,OFFSET=0,DEPTH=5,OTYPE=1,A=1,B=1,G=1}
AuxBar^5~d!9~
AuxBar^5~f~10!{SIZE=1,USE=1,R=1,COLOUR=1,ANCHOR=4,OFFSET=0,DEPTH=5,G=1,B=1,A=1,OTYPE=1}
AuxBar^6~f~1!{SIZE=1,USE=1,R=1,COLOUR=2,ANCHOR=4,OFFSET=0,DEPTH=5,G=1,B=1,A=1,OTYPE=1}
AuxBar^6~d!2~3~4~5~6~7~8~9~10~
AuxBar^7~f~1!{SIZE=1,USE=5,R=1,COLOUR=1,ANCHOR=4,OFFSET=0,DEPTH=2,G=1,B=1,A=1,OTYPE=1}
AuxBar^7~d!2~3~4~5~6~7~8~9~
AuxBar^7~f~10!{SIZE=1,USE=1,R=1,COLOUR=1,ANCHOR=4,OFFSET=0,DEPTH=2,OTYPE=1,A=1,B=1,G=1}
AuxBar^8~f~1!{SIZE=1,USE=5,R=1,COLOUR=1,ANCHOR=1,OFFSET=0,DEPTH=2,G=1,B=1,A=1,OTYPE=1}
AuxBar^8~d!2~3~4~5~6~7~8~9~
AuxBar^8~f~10!{SIZE=1,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=0,DEPTH=2,OTYPE=1,A=1,B=1,G=1}
AuxBar^9~f~1!{SIZE=1,USE=5,R=1,COLOUR=1,ANCHOR=3,OFFSET=0,DEPTH=2,G=1,B=1,A=1,OTYPE=1}
AuxBar^9~d!2~3~4~5~6~7~8~9~
AuxBar^9~f~10!{SIZE=1,USE=1,R=1,COLOUR=1,ANCHOR=3,OFFSET=0,DEPTH=2,OTYPE=1,A=1,B=1,G=1}
Complete!]]
HealBot_ExtraSkinData[31]=[[Skin
Bottoms Up Compact Large Raid
Author~v!Monti of Terenas
DuplicateBars~v!true
Chat~t!{EOCOOM="false",EOCOOMV=20,MSG="Casting #s on #n",RESONLY="true",CHAN="",NOTIFY=0}
General~t!{OFREQ=0.07,OMIN=0.1,OMAX=0.95,FLUIDFREQ=10,HIDEPARTYF="false",HIDEPTF="false",HIDERAIDF="true",STICKYFRAME="true",STICKYSENSITIVITY=35,FLUIDBARS="false",HIDEBOSSF="true"}
Healing~t!{TINCSELF="false",GROUPPETS="true",TARGETINCOMBAT=2,TINCRAID=1,FONLYFRIEND="false",SELFPET=0,TONLYFRIEND="false",FALWAYSSHOW="false",FOCUSINCOMBAT=2,TALWAYSSHOW="false",TINCPET="false",TINCGROUP=1,TEXRAID="false",FEXRAID="false"}
Enemy~t!{INCARENA="true",INCTANKS="true",INCMYTAR="false",ENEMYTARGET="false",INCARENAPETS="false",ENEMYTARGETSIZE=40,HIDE="true",NUMBOSS=2,EXISTSHOWPTAR=1,INCSELF="false",EXISTSHOWBOSS="true",DOUBLEWIDTH="false",EXISTSHOWARENA=3}
FrameAlias~f~1!{SIZE=12,NAME="",R=1,ALIAS="Raid",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~2!{A=1,NAME="Tanks",R=1,ALIAS="Tanks",G=1,SHOW="true",OFFSET=0,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~3!{A=1,NAME="",R=1,ALIAS="Not Used",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~4!{A=1,NAME="",R=1,ALIAS="NotUsed",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~5!{A=1,NAME="",R=1,ALIAS="Not Used",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~6!{A=1,NAME="",R=1,ALIAS="Vehicle",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~7!{A=1,NAME="Pets",R=1,ALIAS="Pets",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~8!{A=1,NAME="",R=1,ALIAS="Target",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~9!{A=1,NAME="",R=1,ALIAS="Focus",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~10!{A=1,NAME="Enemy",R=1,ALIAS="Enemy",G=1,SHOW="true",OFFSET=0,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAliasBar~f~1!{A=0.5,TEXTURE="HealBot 10",B=0.25,HEIGHT=20,R=0.1,G=0.25,WIDTH=0.7}
FrameAliasBar~f~2!{A=0,WIDTH=0.95,B=0.129,HEIGHT=15,R=0.149,G=0.129,TEXTURE="HealBot 10"}
FrameAliasBar~f~3!{A=0.5,WIDTH=0.7,B=0.25,HEIGHT=20,R=0.1,G=0.25,TEXTURE="HealBot 10"}
FrameAliasBar~d!4~5~6~7~8~9~
FrameAliasBar~f~10!{A=0,WIDTH=0.9,B=0.086,HEIGHT=15,R=0.263,G=0.086,TEXTURE="HealBot 10"}
Frame~f~1!{BORDERR=0.1,TIPLOC=3,BACKG=0.102,BACKB=0.702,LOCKED="false",SCALE=1,BORDERA=0.04,BORDERG=0.1,AUTOCLOSE="false",BORDERB=0.1,BACKA=0,OPENSOUND="false",SFOFFSETV=0,BACKR=0.102,SFOFFSETH=0}
Frame~f~2!{BORDERR=0.1,SFOFFSETH=0,BACKG=0.102,BACKB=0.702,LOCKED="true",OPENSOUND="false",BORDERA=0.04,BORDERG=0.1,AUTOCLOSE="false",BORDERB=0.1,BACKA=0,SCALE=1,TIPLOC=4,SFOFFSETV=-7,BACKR=0.102}
Frame~f~3!{BORDERR=0.1,TIPLOC=5,BACKG=0.1,BACKB=0.7,LOCKED="false",SCALE=1,BORDERA=0.04,BORDERG=0.1,AUTOCLOSE="false",BORDERB=0.1,BACKA=0.1,OPENSOUND="false",SFOFFSETV=0,BACKR=0.1,SFOFFSETH=0}
Frame~d!4~
Frame~f~5!{BORDERR=0.1,SFOFFSETH=0,BACKG=0.1,BACKB=0.7,LOCKED="true",OPENSOUND="false",BORDERA=0.04,BORDERG=0.1,AUTOCLOSE="false",BORDERB=0.1,BACKA=0.1,SCALE=1,TIPLOC=2,SFOFFSETV=0,BACKR=0.1}
Frame~f~6!{BORDERR=0.1,SFOFFSETH=0,BACKG=0.1,BACKB=0.7,LOCKED="false",OPENSOUND="false",BORDERA=0.04,BORDERG=0.1,AUTOCLOSE="false",BORDERB=0.1,BACKA=0.1,SCALE=1,TIPLOC=5,SFOFFSETV=0,BACKR=0.1}
Frame~f~7!{BORDERR=0.1,SFOFFSETH=-5,BACKG=0.1,BACKB=0.7,LOCKED="true",OPENSOUND="false",BORDERA=0.04,BORDERG=0.1,AUTOCLOSE="false",BORDERB=0.1,BACKA=0.1,SCALE=1,TIPLOC=5,SFOFFSETV=0,BACKR=0.1}
Frame~f~8!{SFOFFSETH=0,BACKR=0.1,SFOFFSETV=0,TIPLOC=5,LOCKED="false",SCALE=1,BORDERA=0.04,BORDERG=0.1,BACKG=0.1,BACKB=0.7,BACKA=0.1,OPENSOUND="false",BORDERB=0.1,AUTOCLOSE="false",BORDERR=0.1}
Frame~f~9!{BACKR=0.1,BORDERR=0.1,AUTOCLOSE="false",BORDERB=0.1,LOCKED="true",OPENSOUND="false",BORDERA=0.04,SFOFFSETV=3,TIPLOC=5,BACKB=0.7,BACKA=0.1,SCALE=1,BACKG=0.1,BORDERG=0.1,SFOFFSETH=0}
Frame~f~10!{SFOFFSETH=0,BACKR=0.1,SFOFFSETV=-20,TIPLOC=2,LOCKED="true",SCALE=1,BORDERA=1,BORDERG=0,BACKG=0.1,BACKB=0.7,BACKA=0.1,OPENSOUND="false",BORDERB=0,AUTOCLOSE="false",BORDERR=1}
StickyFrames~f~1!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~f~2!{STUCK="true",STUCKTOPOINT="TOP",STUCKTO=1,STUCKPOINT="BOTTOM"}
StickyFrames~f~3!{STUCK="false",STUCKTOPOINT="RIGHT",STUCKTO=2,STUCKPOINT="LEFT"}
StickyFrames~f~4!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~d!5~6~
StickyFrames~f~7!{STUCK="true",STUCKTOPOINT="TOPRIGHT",STUCKTO=1,STUCKPOINT="TOPLEFT"}
StickyFrames~f~8!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~d!9~
StickyFrames~f~10!{STUCK="true",STUCKTOPOINT="TOPLEFT",STUCKTO=1,STUCKPOINT="TOPRIGHT"}
HealGroups~f~1!{FRAME=1,STATE="false",NAME="Self"}
HealGroups~f~2!{FRAME=2,STATE="true",NAME="Main tanks"}
HealGroups~f~3!{FRAME=1,STATE="false",NAME="Healers"}
HealGroups~f~4!{FRAME=1,STATE="false",NAME="Group"}
HealGroups~f~5!{FRAME=1,STATE="false",NAME="Private List"}
HealGroups~f~6!{FRAME=1,STATE="true",NAME="Raid"}
HealGroups~f~7!{FRAME=1,STATE="false",NAME="Vehicle"}
HealGroups~f~8!{FRAME=7,STATE="true",NAME="Pets"}
HealGroups~f~9!{FRAME=8,STATE="false",NAME="Target"}
HealGroups~f~10!{FRAME=9,STATE="false",NAME="Focus"}
HealGroups~f~11!{FRAME=10,STATE="true",NAME="Enemy"}
Anchors~f~1!{Y=65.84,GROW=2,BARS=3,FRAME=1,X=70.51}
Anchors~f~2!{Y=65.25,GROW=2,BARS=1,FRAME=8,X=71.82}
Anchors~f~3!{Y=56.22,GROW=1,BARS=1,FRAME=6,X=67.49}
Anchors~f~4!{Y=53,GROW=2,BARS=1,FRAME=1,X=53}
Anchors~f~5!{Y=50.59,GROW=2,BARS=1,FRAME=1,X=58.13}
Anchors~f~6!{Y=55,GROW=2,BARS=1,FRAME=1,X=55}
Anchors~f~7!{Y=65.84,GROW=2,BARS=1,FRAME=1,X=72.95}
Anchors~f~8!{Y=43.33,GROW=2,BARS=1,FRAME=1,X=82.13}
Anchors~f~9!{Y=22.31,GROW=2,BARS=1,FRAME=1,X=34.19}
Anchors~f~10!{Y=64.15,GROW=2,BARS=1,FRAME=3,X=70.51}
HeadBar~f~1!{SHOW="true",TEXTURE="Tukui",R=0.149,B=0.129,HEIGHT=20,A=0,G=0.129,WIDTH=1}
HeadBar~f~2!{SHOW="false",WIDTH=1,B=0.129,R=0.149,HEIGHT=20,A=0,G=0.129,TEXTURE="Tukui"}
HeadBar~f~3!{SHOW="true",WIDTH=1,B=0.129,R=0.149,HEIGHT=20,A=0,G=0.129,TEXTURE="Tukui"}
HeadBar~d!4~5~6~7~8~9~
HeadBar~f~10!{SHOW="false",TEXTURE="Tukui",R=0.149,B=0.129,HEIGHT=20,A=0,G=0.129,WIDTH=1}
HeadText~f~1!{A=1,R=1,OFFSET=0,B=0.961,FONT="Friz Quadrata TT",HEIGHT=11,G=0.996,OUTLINE=1}
HeadText~d!2~3~4~5~6~7~8~9~10~
HealBar~f~1!{HEIGHT=40,GRPCOLS="false",CMARGIN=0,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=50,RMARGIN=0,OFIX=2,NUMCOLS=1,LOWMANA=1}
HealBar~f~2!{HEIGHT=40,GRPCOLS="false",CMARGIN=0,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=88,RMARGIN=0,OFIX=2,NUMCOLS=5,LOWMANA=1}
HealBar~f~3!{HEIGHT=60,GRPCOLS="false",CMARGIN=2,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=80,RMARGIN=2,OFIX=1,NUMCOLS=2,LOWMANA=1}
HealBar~f~4!{HEIGHT=60,GRPCOLS="false",CMARGIN=2,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=1,NUMCOLS=3,OFIX=1,RMARGIN=2,WIDTH=80}
HealBar~d!5~6~
HealBar~f~7!{HEIGHT=25,GRPCOLS="false",CMARGIN=0,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=1,WIDTH=52,OFIX=2,RMARGIN=0,NUMCOLS=1}
HealBar~f~8!{HEIGHT=60,GRPCOLS="false",CMARGIN=2,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=1,WIDTH=80,OFIX=1,RMARGIN=2,NUMCOLS=3}
HealBar~d!9~
HealBar~f~10!{HEIGHT=25,GRPCOLS="false",CMARGIN=0,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",NUMCOLS=1,RMARGIN=0,OFIX=2,WIDTH=58,LOWMANA=1}
BarCol~f~1!{BACK=3,BA=0.75,BOUT=0,DISA=0.2,BR=0,HB=0.4,BG=0,HR=0.2,HA=1,HG=0.4,ORA=0.5,BB=0,HLTH=2}
BarCol~d!2~
BarCol~f~3!{BACK=3,BA=0.75,BOUT=1,DISA=0.2,BR=0,HB=0.4,BG=0,BB=0,HA=1,HR=0.2,ORA=0.5,HG=0.4,HLTH=2}
BarCol~d!4~5~6~
BarCol~f~7!{BACK=3,BA=0.75,BOUT=0,DISA=0.2,BR=0,HB=0.4,BG=0,BB=0,HA=1,HR=0.2,ORA=0.5,HG=0.4,HLTH=2}
BarCol~f~8!{BACK=3,BA=0.75,BOUT=1,DISA=0.2,BR=0,HB=0.4,BG=0,BB=0,HA=1,HR=0.2,ORA=0.5,HG=0.4,HLTH=2}
BarCol~d!9~10~
BarIACol~f~1!{AC=3,AB=1,AA=0.6,AR=1,AG=1,IC=2,IB=0.2,IA=0.6,IR=0.2,IG=0.8}
BarIACol~d!2~3~4~5~6~7~8~9~10~
BarText~f~1!{HHEIGHT=10,TAGOOR="",OVERHEAL=1,MAXCHARS=12,TAGDC="",HMAXCHARS=0,HOFFSET=0,HFONT="Friz Quadrata TT",HOUTLINE=1,OFFSET=0,HLTHTXTANCHOR=1,HLTHTYPE=3,HLTHONBAR="false",CLASSTYPE=1,NUMFORMAT2=1,INCHEALS=2,NUMFORMAT1=11,CLASSONBAR="false",NAMEONBAR="true",HEIGHT=10,TAGRIP="",SHOWROLE="true",HALIGN=2,FONT="Friz Quadrata TT",IGNOREONFULL="true",INCABSORBS=1,HOFFSET2=0,ALIGN=2,TAGR="[ R ] ",OUTLINE=2}
BarText~d!2~3~4~
BarText~f~5!{HHEIGHT=10,TAGOOR="",OVERHEAL=1,MAXCHARS=12,NUMFORMAT1=1,CLASSONBAR="false",OUTLINE=2,HFONT="Friz Quadrata TT",HLTHONBAR="false",INCHEALS=2,HLTHTXTANCHOR=1,FONT="Friz Quadrata TT",IGNOREONFULL="true",CLASSTYPE=1,NUMFORMAT2=1,OFFSET=0,TAGDC="",HMAXCHARS=0,NAMEONBAR="true",HEIGHT=10,TAGRIP="",SHOWROLE="true",HALIGN=2,HOUTLINE=1,HLTHTYPE=3,INCABSORBS=1,HOFFSET2=0,ALIGN=2,TAGR="[ R ] ",HOFFSET=0}
BarText~d!6~7~8~9~10~
BarTextCol~f~1!{NCB=0,NDEBUFF="false",HCG=1,NCDA=0.7,NAME=2,NCR=0.929,NCG=1,NCA=1,HCA=1,HCB=0,HCR=0.929,HDEBUFF="false",HLTH=3,HCDA=0.7}
BarTextCol~d!2~3~4~5~6~7~8~9~10~
Icons~f~1!{SHOWBUFF="true",SHOWDEBUFF="true",I15EN="false",MAXDICONS=4,POSITION=2,FADE="false",ONBAR=1,DOUBLE="true",DSCALE=0.55,SHOWDIR="false",SHOWRC="true",SCALE=0.55,SHOWDIRMOUSE="false",FADESECS=15,MAXBICONS=6}
Icons~f~2!{SHOWBUFF="true",SHOWDEBUFF="true",I15EN="false",MAXDICONS=5,POSITION=2,FADE="false",ONBAR=1,DOUBLE="true",DSCALE=0.55,SHOWDIR="false",SHOWRC="true",SCALE=0.55,SHOWDIRMOUSE="false",FADESECS=15,MAXBICONS=10}
Icons~f~3!{SHOWBUFF="true",SHOWDEBUFF="true",I15EN="false",MAXDICONS=3,POSITION=2,FADE="false",ONBAR=1,DOUBLE="true",DSCALE=0.55,SHOWDIR="false",SHOWRC="true",SCALE=0.55,SHOWDIRMOUSE="false",FADESECS=15,MAXBICONS=8}
Icons~d!4~5~6~
Icons~f~7!{SHOWBUFF="true",POSITION=2,FADESECS=15,I15EN="false",MAXDICONS=2,SHOWDIRMOUSE="false",ONBAR=1,FADE="false",DSCALE=0.55,SHOWDIR="false",SHOWRC="true",SCALE=0.55,DOUBLE="true",SHOWDEBUFF="true",MAXBICONS=3}
Icons~f~8!{SHOWBUFF="true",POSITION=2,FADESECS=15,I15EN="false",MAXDICONS=3,SHOWDIRMOUSE="false",ONBAR=1,FADE="false",DSCALE=0.55,SHOWDIR="false",SHOWRC="true",SCALE=0.55,DOUBLE="true",SHOWDEBUFF="true",MAXBICONS=8}
Icons~d!9~
Icons~f~10!{SHOWBUFF="true",POSITION=2,FADESECS=15,I15EN="false",MAXDICONS=4,SHOWDIRMOUSE="false",ONBAR=1,FADE="false",DSCALE=0.55,SHOWDIR="false",SHOWRC="true",SCALE=0.55,DOUBLE="true",SHOWDEBUFF="true",MAXBICONS=8}
RaidIcon~f~1!{SQUARE="true",CIRCLE="true",DIAMOND="true",SHOW="true",SKULL="true",TRIANGLE="true",STAR="true",CROSS="true",MOON="true"}
RaidIcon~d!2~3~4~5~6~7~8~9~10~
IconText~f~1!{SDUR="true",HEIGHT=10,SSCNT="false",FONT="Swansea",SCNT="true",DURTHRH=9,SCALE=0.8,DURWARN=3,SSDUR="false",OUTLINE=2}
IconText~f~2!{SDUR="true",HEIGHT=10,SSCNT="false",FONT="Swansea",SCNT="true",DURTHRH=9,SCALE=0.7,DURWARN=3,SSDUR="false",OUTLINE=2}
IconText~d!3~4~5~6~7~8~9~10~
BarVisibility~f~1!{INCCLASSES=1,ALERTIC=1,ALERTOC=0.9,HIDEOOR="false"}
BarVisibility~d!2~3~4~5~6~7~8~9~10~
BarSort~f~1!{SUBORDER=1,OORLAST="false",RAIDORDER=3,SUBPF="true"}
BarSort~d!2~3~4~5~6~7~8~9~10~
BarAggro~f~1!{B=0,ALERTIND=2,G=0,TEXTFORMAT=3,SHOW="true",SHOWTEXTPCT="true",SHOWIND="true",SHOWTEXT="true",R=1,ALERT=2}
BarAggro~d!2~3~4~5~6~7~8~9~10~
AuxBarFrame~f~1!{OVERLAP=2}
AuxBarFrame~d!2~3~4~5~6~7~8~9~10~
AuxBar^1~f~1!{SIZE=1,USE=5,R=1,COLOUR=1,ANCHOR=2,OFFSET=0,DEPTH=2,G=1,B=1,OTYPE=1}
AuxBar^1~d!2~3~4~5~6~7~8~9~
AuxBar^1~f~10!{SIZE=1,USE=1,R=1,COLOUR=1,ANCHOR=2,OFFSET=0,DEPTH=2,G=1,B=1,OTYPE=1}
AuxBar^2~f~1!{SIZE=1,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=2,G=1,B=1,OTYPE=1}
AuxBar^2~d!2~3~4~5~6~7~8~9~10~
AuxBar^3~f~1!{SIZE=1,USE=1,R=1,COLOUR=2,ANCHOR=3,OFFSET=1,DEPTH=5,G=1,B=1,OTYPE=1}
AuxBar^3~d!2~3~4~5~6~7~8~9~10~
AuxBar^4~f~1!{SIZE=1,USE=6,R=1,COLOUR=2,ANCHOR=3,OFFSET=0,DEPTH=5,G=1,B=1,OTYPE=1}
AuxBar^4~d!2~3~4~5~6~
AuxBar^4~f~7!{SIZE=1,USE=1,R=1,COLOUR=2,ANCHOR=3,OFFSET=0,DEPTH=5,OTYPE=1,B=1,G=1}
AuxBar^4~f~8!{SIZE=1,USE=6,R=1,COLOUR=2,ANCHOR=3,OFFSET=0,DEPTH=5,OTYPE=1,B=1,G=1}
AuxBar^4~d!9~
AuxBar^4~f~10!{SIZE=1,USE=1,R=1,COLOUR=2,ANCHOR=3,OFFSET=0,DEPTH=5,OTYPE=1,B=1,G=1}
AuxBar^5~f~1!{SIZE=1,USE=4,R=1,COLOUR=1,ANCHOR=4,OFFSET=0,DEPTH=5,G=1,B=1,OTYPE=1}
AuxBar^5~d!2~3~4~5~6~
AuxBar^5~f~7!{SIZE=1,USE=1,R=1,COLOUR=1,ANCHOR=4,OFFSET=0,DEPTH=5,OTYPE=1,B=1,G=1}
AuxBar^5~f~8!{SIZE=1,USE=4,R=1,COLOUR=1,ANCHOR=4,OFFSET=0,DEPTH=5,OTYPE=1,B=1,G=1}
AuxBar^5~d!9~
AuxBar^5~f~10!{SIZE=1,USE=1,R=1,COLOUR=1,ANCHOR=4,OFFSET=0,DEPTH=5,G=1,B=1,OTYPE=1}
AuxBar^6~f~1!{SIZE=1,USE=1,R=1,COLOUR=2,ANCHOR=4,OFFSET=0,DEPTH=5,G=1,B=1,OTYPE=1}
AuxBar^6~d!2~3~4~5~6~7~8~9~10~
AuxBar^7~f~1!{SIZE=1,USE=5,R=1,COLOUR=1,ANCHOR=4,OFFSET=0,DEPTH=2,G=1,B=1,OTYPE=1}
AuxBar^7~d!2~3~4~5~6~7~8~9~
AuxBar^7~f~10!{SIZE=1,USE=1,R=1,COLOUR=1,ANCHOR=4,OFFSET=0,DEPTH=2,OTYPE=1,B=1,G=1}
AuxBar^8~f~1!{SIZE=1,USE=5,R=1,COLOUR=1,ANCHOR=1,OFFSET=0,DEPTH=2,G=1,B=1,OTYPE=1}
AuxBar^8~d!2~3~4~5~6~7~8~9~
AuxBar^8~f~10!{SIZE=1,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=0,DEPTH=2,OTYPE=1,B=1,G=1}
AuxBar^9~f~1!{SIZE=1,USE=5,R=1,COLOUR=1,ANCHOR=3,OFFSET=0,DEPTH=2,G=1,B=1,OTYPE=1}
AuxBar^9~d!2~3~4~5~6~7~8~9~
AuxBar^9~f~10!{SIZE=1,USE=1,R=1,COLOUR=1,ANCHOR=3,OFFSET=0,DEPTH=2,OTYPE=1,B=1,G=1}
Complete!]]
HealBot_ExtraSkinData[32]=[[Skin
Aux Party
Author~v!Monti of Terenas
DuplicateBars~v!false
Chat~t!{EOCOOM="false",EOCOOMV=5,MSG="Casting #s on #n",RESONLY="true",CHAN="",NOTIFY=1}
General~t!{OFREQ=0.07,OMIN=0.1,OMAX=0.95,FLUIDFREQ=10,HIDEPARTYF="false",HIDEPTF="false",HIDERAIDF="true",STICKYSENSITIVITY=20,STICKYFRAME="true",FLUIDBARS="false",HIDEBOSSF="true"}
Healing~t!{TINCSELF="false",GROUPPETS="true",TARGETINCOMBAT=1,TINCGROUP="true",FONLYFRIEND="true",TINCPET="false",TONLYFRIEND="false",FALWAYSSHOW="false",FOCUSINCOMBAT=2,TALWAYSSHOW="false",SELFPET=0,TINCRAID="true",TEXRAID="false",FEXRAID="false"}
Enemy~t!{ENEMYTARGET="true",INCTANKS="true",INCMYTAR="false",INCARENA="false",ENEMYTARGETSIZE=58,INCARENAPETS="false",INCSELF="false",NUMBOSS=1,EXISTSHOWPTAR=1,HIDE="true",EXISTSHOWBOSS="true",DOUBLEWIDTH="false",EXISTSHOWARENA=2}
FrameAlias~f~1!{SIZE=12,NAME="Party",R=1,ALIAS="Party",G=1,SHOW="true",OFFSET=1,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~2!{SIZE=12,NAME="Tank and Healer",R=1,ALIAS="Tank and Healer",G=1,SHOW="true",OFFSET=1,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~3!{SIZE=12,NAME="Pets",R=1,ALIAS="Not Used 1",G=1,SHOW="true",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~4!{SIZE=12,NAME="Focus and Target",R=1,ALIAS="Not Used 2",G=1,SHOW="true",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~5!{SIZE=12,NAME="Enemy",R=1,ALIAS="Not Used 3",G=1,SHOW="true",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~6!{SIZE=12,NAME="",R=1,ALIAS="Vehicle",G=1,SHOW="true",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~7!{SIZE=12,NAME="Pets",R=1,ALIAS="Pets",G=1,SHOW="true",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~8!{SIZE=12,NAME="Target",R=1,ALIAS="Target",G=1,SHOW="true",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~9!{SIZE=12,NAME="",R=1,ALIAS="Focus",G=1,SHOW="true",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~10!{SIZE=12,NAME="Enemy",R=0.9,ALIAS="Enemy",G=0.2,SHOW="true",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=0.2,OUTLINE=1}
FrameAliasBar~f~1!{A=0.23,WIDTH=0.94,B=0,HEIGHT=20,R=0.004,G=0,TEXTURE="Flat"}
FrameAliasBar~d!2~3~4~5~6~7~8~9~10~
Frame~f~1!{BORDERR=0.318,BACKR=0.506,SFOFFSETH=0,BORDERG=0.757,LOCKED="false",OPENSOUND="false",BORDERA=0,SFOFFSETV=0,AUTOCLOSE="false",BACKB=0.506,BACKA=0,SCALE=1,BORDERB=1,TIPLOC=2,BACKG=0.506}
Frame~f~2!{BORDERR=0.102,BACKR=0.102,SFOFFSETH=0,BORDERG=0.102,LOCKED="true",OPENSOUND="false",BORDERA=0,SFOFFSETV=0,AUTOCLOSE="false",BACKB=0.502,BACKA=0,SCALE=1,BORDERB=0.102,TIPLOC=1,BACKG=0.102}
Frame~f~3!{BORDERR=0.1,BACKR=0.1,SFOFFSETH=0,BORDERG=0.1,LOCKED="false",OPENSOUND="false",BORDERA=0.5,SFOFFSETV=0,AUTOCLOSE="false",BACKB=0.5,BACKA=0.2,SCALE=1,BORDERB=0.1,TIPLOC=2,BACKG=0.1}
Frame~d!4~
Frame~f~5!{BORDERR=0.1,BACKR=0.1,SFOFFSETH=0,BORDERG=0.1,LOCKED="false",OPENSOUND="false",BORDERA=0.5,SFOFFSETV=0,AUTOCLOSE="false",BACKB=0.5,BACKA=0.2,SCALE=1,BORDERB=0.1,TIPLOC=4,BACKG=0.1}
Frame~f~6!{BORDERR=0.1,BACKR=0.1,SFOFFSETH=0,BORDERG=0.1,LOCKED="false",OPENSOUND="false",BORDERA=0.5,SFOFFSETV=0,AUTOCLOSE="false",BACKB=0.5,BACKA=0.2,SCALE=1,BORDERB=0.1,TIPLOC=5,BACKG=0.1}
Frame~f~7!{BORDERR=0.102,BACKG=0.102,TIPLOC=5,BORDERB=0.102,LOCKED="true",SCALE=1,BORDERA=0.01,BORDERG=0.102,AUTOCLOSE="false",BACKB=0.502,BACKA=0.01,OPENSOUND="false",SFOFFSETV=8,SFOFFSETH=0,BACKR=0.102}
Frame~f~8!{BORDERR=0.102,BACKG=0.102,TIPLOC=5,BORDERB=0.102,LOCKED="false",SCALE=1,BORDERA=0,BORDERG=0.102,AUTOCLOSE="false",BACKB=0.502,BACKA=0,OPENSOUND="false",SFOFFSETV=4,SFOFFSETH=0,BACKR=0.102}
Frame~f~9!{BORDERR=0.1,BACKG=0.1,TIPLOC=5,BORDERB=0.1,LOCKED="false",SCALE=1,BORDERA=0.5,BORDERG=0.1,AUTOCLOSE="false",BACKB=0.5,BACKA=0.2,OPENSOUND="false",SFOFFSETV=0,SFOFFSETH=0,BACKR=0.1}
Frame~f~10!{BORDERR=0.706,BACKR=0.102,SFOFFSETH=5,BORDERG=0,LOCKED="true",OPENSOUND="false",BORDERA=0,SFOFFSETV=-4,AUTOCLOSE="false",BACKB=0.502,BACKA=0.05,SCALE=1,BORDERB=0.122,TIPLOC=4,BACKG=0.102}
StickyFrames~f~1!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~f~2!{STUCK="true",STUCKTOPOINT="TOPLEFT",STUCKTO=1,STUCKPOINT="TOPRIGHT"}
StickyFrames~f~3!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~d!4~5~6~
StickyFrames~f~7!{STUCK="true",STUCKTOPOINT="BOTTOMRIGHT",STUCKTO=1,STUCKPOINT="TOPRIGHT"}
StickyFrames~d!8~
StickyFrames~f~9!{STUCK="true",STUCKTOPOINT="BOTTOMRIGHT",STUCKTO=8,STUCKPOINT="TOPRIGHT"}
StickyFrames~f~10!{STUCK="true",STUCKTOPOINT="TOPLEFT",STUCKTO=1,STUCKPOINT="BOTTOMLEFT"}
HealGroups~f~1!{FRAME=1,STATE="true",NAME="Main tanks"}
HealGroups~f~2!{FRAME=1,STATE="false",NAME="Private List"}
HealGroups~f~3!{FRAME=1,STATE="false",NAME="Self"}
HealGroups~f~4!{FRAME=1,STATE="true",NAME="Healers"}
HealGroups~f~5!{FRAME=1,STATE="true",NAME="Group"}
HealGroups~f~6!{FRAME=1,STATE="true",NAME="Raid"}
HealGroups~f~7!{FRAME=6,STATE="false",NAME="Vehicle"}
HealGroups~f~8!{FRAME=1,STATE="true",NAME="Pets"}
HealGroups~f~9!{FRAME=8,STATE="true",NAME="Target"}
HealGroups~f~10!{FRAME=9,STATE="false",NAME="Focus"}
HealGroups~f~11!{FRAME=10,STATE="true",NAME="Enemy"}
Anchors~f~1!{Y=67.01,GROW=2,BARS=3,FRAME=3,X=92.46}
Anchors~f~2!{Y=73.09,GROW=2,BARS=1,FRAME=3,X=100}
Anchors~f~3!{Y=55,GROW=2,BARS=3,FRAME=3,X=96.42}
Anchors~f~4!{Y=64.17,GROW=2,BARS=1,FRAME=1,X=83.17}
Anchors~f~5!{Y=65.23,GROW=2,BARS=2,FRAME=2,X=89.04}
Anchors~f~6!{Y=55,GROW=2,BARS=1,FRAME=1,X=55}
Anchors~f~7!{Y=61.76,GROW=2,BARS=1,FRAME=3,X=94.41}
Anchors~f~8!{Y=61.34,GROW=2,BARS=1,FRAME=3,X=92.46}
Anchors~f~9!{Y=66.8,GROW=2,BARS=1,FRAME=3,X=85.69}
Anchors~f~10!{Y=68.34,GROW=2,BARS=4,FRAME=2,X=85.87}
HeadBar~f~1!{SHOW="false",WIDTH=0.9,B=0.506,R=0.506,HEIGHT=30,A=0.4,G=0.506,TEXTURE="Diagonal"}
HeadBar~f~2!{SHOW="false",WIDTH=0.9,B=0.1,R=0.1,HEIGHT=30,A=0.25,G=0.1,TEXTURE="Diagonal"}
HeadBar~d!3~4~5~6~7~8~9~10~
HeadText~f~1!{A=0.7,B=0.8,OFFSET=0,R=0.2,FONT="Friz Quadrata TT",HEIGHT=10,G=0.8,OUTLINE=1}
HeadText~f~2!{A=0.7,B=0.1,OFFSET=0,R=1,FONT="Friz Quadrata TT",HEIGHT=10,G=1,OUTLINE=1}
HeadText~d!3~4~5~6~7~8~9~10~
HealBar~f~1!{HEIGHT=34,GRPCOLS="false",CMARGIN=4,TEXTURE="Smooth v2",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=3,NUMCOLS=1,OFIX=1,RMARGIN=0,WIDTH=172}
HealBar~f~2!{HEIGHT=34,GRPCOLS="false",CMARGIN=4,TEXTURE="Smooth v2",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=172,RMARGIN=0,OFIX=1,NUMCOLS=1,LOWMANA=2}
HealBar~d!3~4~5~6~
HealBar~f~7!{HEIGHT=34,GRPCOLS="false",CMARGIN=4,TEXTURE="Smooth v2",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=1,NUMCOLS=1,OFIX=1,RMARGIN=0,WIDTH=172}
HealBar~f~8!{HEIGHT=34,GRPCOLS="false",CMARGIN=4,TEXTURE="Smooth v2",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=2,NUMCOLS=1,OFIX=1,RMARGIN=0,WIDTH=172}
HealBar~d!9~
HealBar~f~10!{HEIGHT=34,GRPCOLS="false",CMARGIN=4,TEXTURE="Smooth v2",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=2,NUMCOLS=1,OFIX=1,RMARGIN=0,WIDTH=177}
BarCol~f~1!{BACK=1,BA=0.1,BB=0.506,DISA=0.05,BR=0.506,HB=0.9,BG=0.506,BOUT=0,HA=1,HG=0.2,ORA=0.4,HR=0.2,HLTH=2}
BarCol~d!2~3~4~5~6~7~8~9~10~
BarIACol~f~1!{AC=4,AB=0.8,AA=0.5,AR=0.2,AG=0.8,IC=2,IB=0.953,IA=0.5,IR=1,IG=0.984}
BarIACol~d!2~3~4~5~6~7~8~9~10~
BarText~f~1!{HLTHONBAR="true",TAGOOR="OOR | ",OVERHEAL=1,MAXCHARS=0,CLASSONBAR="true",HOFFSET=0,OUTLINE=1,IGNOREONFULL="false",INCHEALS=2,HLTHTXTANCHOR=1,FONT="Friz Quadrata TT",HMAXCHARS=0,INCABSORBS=2,NUMFORMAT2=1,HOUTLINE=1,TAGDC="DC | ",HHEIGHT=14,TAGRIP="RIP | ",HEIGHT=12,NUMFORMAT1=11,SHOWROLE="true",HALIGN=2,NAMEONBAR="true",HLTHTYPE=1,OFFSET=2,CLASSTYPE=1,HOFFSET2=0,ALIGN=2,TAGR="R | ",HFONT="Friz Quadrata TT"}
BarText~d!2~3~4~5~6~7~8~9~
BarText~f~10!{HLTHONBAR="true",TAGOOR="OOR | ",OVERHEAL=1,MAXCHARS=0,CLASSONBAR="false",HFONT="Friz Quadrata TT",IGNOREONFULL="false",HOUTLINE=1,OFFSET=2,HLTHTXTANCHOR=1,HLTHTYPE=1,HOFFSET=0,CLASSTYPE=1,NUMFORMAT2=1,HMAXCHARS=0,NUMFORMAT1=11,HHEIGHT=14,TAGRIP="RIP | ",HEIGHT=12,FONT="Friz Quadrata TT",SHOWROLE="true",HALIGN=2,NAMEONBAR="true",TAGDC="DC | ",INCHEALS=2,INCABSORBS=2,HOFFSET2=0,ALIGN=2,TAGR="R | ",OUTLINE=1}
BarTextCol~f~1!{NAME=2,NDEBUFF="false",HCDA=0.58,NCDA=0.47,HCG=0,NCR=0.949,HCB=1,HCR=0.761,NCA=1,NCG=0.843,HCA=1,HDEBUFF="false",NCB=0.267,HLTH=1}
BarTextCol~d!2~3~4~5~6~7~8~9~10~
Icons~f~1!{SHOWBUFF="true",POSITION=2,FADESECS=15,I15EN="false",MAXDICONS=4,DOUBLE="true",SHOWDIR="false",FADE="false",DSCALE=1,ONBAR=1,SHOWRC="true",SCALE=1,SHOWDIRMOUSE="false",SHOWDEBUFF="true",MAXBICONS=8}
Icons~d!2~3~4~5~6~
Icons~f~7!{SHOWBUFF="true",POSITION=2,FADESECS=15,I15EN="false",MAXDICONS=4,DOUBLE="true",SHOWDIR="false",FADE="false",DSCALE=1,ONBAR=1,SHOWRC="true",SCALE=1,SHOWDIRMOUSE="false",SHOWDEBUFF="true",MAXBICONS=6}
Icons~f~8!{SHOWBUFF="true",POSITION=2,FADESECS=15,I15EN="false",MAXDICONS=4,DOUBLE="true",SHOWDIR="false",FADE="false",DSCALE=1,ONBAR=1,SHOWRC="true",SCALE=1,SHOWDIRMOUSE="false",SHOWDEBUFF="true",MAXBICONS=8}
Icons~d!9~10~
RaidIcon~f~1!{SQUARE="true",CIRCLE="true",DIAMOND="true",SHOW="true",SKULL="true",TRIANGLE="true",STAR="true",CROSS="true",MOON="true"}
RaidIcon~d!2~3~4~5~6~7~8~9~10~
IconText~f~1!{DURWARN=3,HEIGHT=10,SSCNT="false",SCNT="true",DURTHRH=9,FONT="Friz Quadrata TT",SDUR="true",SSDUR="true",OUTLINE=2}
IconText~d!2~3~4~5~6~7~8~9~10~
BarVisibility~f~1!{INCCLASSES=1,ALERTIC=0.95,ALERTOC=0.9,HIDEOOR="false"}
BarVisibility~d!2~3~4~5~6~7~8~9~10~
BarSort~f~1!{SUBORDER=4,OORLAST="false",RAIDORDER=2,SUBPF="true"}
BarSort~d!2~3~4~5~6~7~8~9~10~
BarAggro~f~1!{R=0.969,ALERTIND=2,G=0.173,TEXTFORMAT=3,SHOW="true",SHOWTEXTPCT="true",B=0.075,SHOWIND="true",SHOWTEXT="false",ALERT=2}
BarAggro~d!2~3~4~5~6~7~8~9~10~
AuxBarFrame~f~1!{OVERLAP=1}
AuxBarFrame~d!2~3~4~5~6~7~8~9~10~
AuxBar^1~f~1!{SIZE=0.98,USE=4,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=4,OTYPE=1,G=1,B=1}
AuxBar^1~d!2~3~4~5~6~7~8~9~
AuxBar^1~f~10!{SIZE=0.98,USE=1,B=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=4,R=1,G=1,OTYPE=1}
AuxBar^2~f~1!{SIZE=0.72,USE=9,R=0.761,COLOUR=1,ANCHOR=2,OFFSET=1,DEPTH=2,OTYPE=2,G=0,B=1}
AuxBar^2~d!2~3~4~5~6~7~8~9~
AuxBar^2~f~10!{SIZE=0.72,USE=1,R=0.761,COLOUR=1,ANCHOR=2,OFFSET=1,DEPTH=2,OTYPE=2,G=0,B=1}
AuxBar^3~f~1!{SIZE=0.98,USE=10,R=0.357,COLOUR=1,ANCHOR=2,OFFSET=-2,DEPTH=2,OTYPE=2,G=0.122,B=0.58}
AuxBar^3~d!2~3~4~5~6~7~8~9~
AuxBar^3~f~10!{SIZE=0.98,USE=1,R=0.357,COLOUR=1,ANCHOR=2,OFFSET=-2,DEPTH=2,OTYPE=2,G=0.122,B=0.58}
AuxBar^4~f~1!{SIZE=0.98,USE=6,R=1,COLOUR=1,ANCHOR=3,OFFSET=0,DEPTH=3,OTYPE=1,G=1,B=1}
AuxBar^4~d!2~3~4~5~6~7~8~9~
AuxBar^4~f~10!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=3,OFFSET=0,DEPTH=3,OTYPE=1,G=1,B=1}
AuxBar^5~f~1!{SIZE=0.98,USE=5,R=1,COLOUR=1,ANCHOR=3,OFFSET=1,DEPTH=2,OTYPE=2,G=1,B=1}
AuxBar^5~d!2~3~4~5~6~7~8~9~
AuxBar^5~f~10!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=3,OFFSET=1,DEPTH=2,OTYPE=2,G=1,B=1}
AuxBar^6~f~1!{SIZE=0.98,USE=7,R=1,COLOUR=3,ANCHOR=4,OFFSET=0,DEPTH=3,OTYPE=1,G=1,B=1}
AuxBar^6~d!2~3~4~5~6~7~8~9~
AuxBar^6~f~10!{SIZE=0.98,USE=1,R=1,COLOUR=3,ANCHOR=4,OFFSET=0,DEPTH=3,OTYPE=1,G=1,B=1}
AuxBar^7~f~1!{SIZE=0.98,USE=5,R=1,COLOUR=1,ANCHOR=4,OFFSET=1,DEPTH=2,OTYPE=2,G=1,B=1}
AuxBar^7~d!2~3~4~5~6~7~8~9~
AuxBar^7~f~10!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=4,OFFSET=1,DEPTH=2,OTYPE=2,G=1,B=1}
AuxBar^8~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=3,ANCHOR=3,OFFSET=1,DEPTH=2,OTYPE=2,G=0.557,B=0.251}
AuxBar^8~d!2~3~4~5~6~7~8~9~10~
AuxBar^9~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,OTYPE=1,G=1,B=1}
AuxBar^9~d!2~3~4~5~6~7~8~9~10~
Complete!]]
HealBot_ExtraSkinData[33]=[[Skin
Clarity Party
Author~v!Monti of Terenas
DuplicateBars~v!false
Chat~t!{EOCOOM="false",EOCOOMV=5,MSG="Casting #s on #n",RESONLY="true",CHAN="",NOTIFY=1}
General~t!{OFREQ=0.07,OMIN=0.1,OMAX=0.95,HIDEBOSSF="true",HIDEPTF="false",FLUIDFREQ=10,STICKYFRAME="true",HIDERAIDF="true",STICKYSENSITIVITY=20,FLUIDBARS="false",HIDEPARTYF="false"}
Healing~t!{TINCSELF="false",GROUPPETS="true",TARGETINCOMBAT=1,FEXRAID="false",FONLYFRIEND="true",SELFPET=0,TONLYFRIEND="false",TINCGROUP="true",FOCUSINCOMBAT=2,TALWAYSSHOW="false",TINCPET="false",TINCRAID="true",TEXRAID="false",FALWAYSSHOW="false"}
Enemy~t!{ENEMYTARGET="true",INCTANKS="true",INCMYTAR="false",INCARENA="false",INCARENAPETS="false",ENEMYTARGETSIZE=58,HIDE="true",NUMBOSS=1,EXISTSHOWPTAR=1,INCSELF="false",EXISTSHOWBOSS="true",DOUBLEWIDTH="false",EXISTSHOWARENA=2}
FrameAlias~f~1!{SIZE=12,NAME="Party",R=1,ALIAS="Party",G=1,SHOW="false",OFFSET=1,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~2!{SIZE=12,NAME="Tank and Healer",R=1,ALIAS="Tank and Healer",G=1,SHOW="false",OFFSET=1,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~3!{SIZE=12,NAME="Pets",R=1,ALIAS="Not Used 1",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~4!{SIZE=12,NAME="Focus and Target",R=1,ALIAS="Not Used 2",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~5!{SIZE=12,NAME="Enemy",R=1,ALIAS="Not Used 3",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~6!{SIZE=12,NAME="",R=1,ALIAS="Vehicle",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~7!{SIZE=12,NAME="Pets",R=1,ALIAS="Pets",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~8!{SIZE=12,NAME="Target",R=1,ALIAS="Target",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~9!{SIZE=12,NAME="",R=1,ALIAS="Focus",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~10!{SIZE=12,NAME="Enemy",R=1,ALIAS="Enemy",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAliasBar~f~1!{A=0.23,TEXTURE="Flat",B=0,HEIGHT=20,R=0.004,G=0,WIDTH=0.94}
FrameAliasBar~d!2~3~4~5~6~7~8~9~10~
Frame~f~1!{SFOFFSETH=0,AUTOCLOSE="false",BACKG=0.506,BACKB=0.506,LOCKED="false",SCALE=1,BORDERA=0,SFOFFSETV=0,TIPLOC=2,BORDERB=1,BACKA=0,OPENSOUND="false",BORDERG=0.757,BACKR=0.506,BORDERR=0.318}
Frame~f~2!{SFOFFSETH=0,AUTOCLOSE="false",BACKG=0.102,BACKB=0.502,LOCKED="true",SCALE=1,BORDERA=0,SFOFFSETV=0,TIPLOC=1,BORDERB=0.102,BACKA=0,OPENSOUND="false",BORDERG=0.102,BACKR=0.102,BORDERR=0.102}
Frame~f~3!{SFOFFSETH=0,AUTOCLOSE="false",BACKG=0.1,BACKB=0.5,LOCKED="false",SCALE=1,BORDERA=0.5,SFOFFSETV=0,TIPLOC=2,BORDERB=0.1,BACKA=0.2,OPENSOUND="false",BORDERG=0.1,BACKR=0.1,BORDERR=0.1}
Frame~d!4~
Frame~f~5!{SFOFFSETH=0,AUTOCLOSE="false",BACKG=0.1,BACKB=0.5,LOCKED="false",SCALE=1,BORDERA=0.5,SFOFFSETV=0,TIPLOC=4,BORDERB=0.1,BACKA=0.2,OPENSOUND="false",BORDERG=0.1,BACKR=0.1,BORDERR=0.1}
Frame~f~6!{SFOFFSETH=0,AUTOCLOSE="false",BACKG=0.1,BACKB=0.5,LOCKED="false",SCALE=1,BORDERA=0.5,SFOFFSETV=0,TIPLOC=5,BORDERB=0.1,BACKA=0.2,OPENSOUND="false",BORDERG=0.1,BACKR=0.1,BORDERR=0.1}
Frame~f~7!{BACKR=0.102,SFOFFSETH=0,BORDERR=0.102,BORDERG=0.102,LOCKED="true",OPENSOUND="false",BORDERA=0.01,SFOFFSETV=8,AUTOCLOSE="false",BACKB=0.502,BACKA=0.01,SCALE=1,BORDERB=0.102,TIPLOC=5,BACKG=0.102}
Frame~f~8!{BACKR=0.102,SFOFFSETH=0,BORDERR=0.102,BORDERG=0.102,LOCKED="false",OPENSOUND="false",BORDERA=0,SFOFFSETV=4,AUTOCLOSE="false",BACKB=0.502,BACKA=0,SCALE=1,BORDERB=0.102,TIPLOC=5,BACKG=0.102}
Frame~f~9!{BACKR=0.1,SFOFFSETH=0,BORDERR=0.1,BORDERG=0.1,LOCKED="false",OPENSOUND="false",BORDERA=0.5,SFOFFSETV=0,AUTOCLOSE="false",BACKB=0.5,BACKA=0.2,SCALE=1,BORDERB=0.1,TIPLOC=5,BACKG=0.1}
Frame~f~10!{SFOFFSETH=3,AUTOCLOSE="false",BACKG=0.102,BACKB=0.502,LOCKED="true",SCALE=1,BORDERA=0,SFOFFSETV=0,TIPLOC=4,BORDERB=0.122,BACKA=0.05,OPENSOUND="false",BORDERG=0,BACKR=0.102,BORDERR=0.706}
StickyFrames~f~1!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~f~2!{STUCK="true",STUCKTOPOINT="TOPLEFT",STUCKTO=1,STUCKPOINT="TOPRIGHT"}
StickyFrames~f~3!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~d!4~5~6~
StickyFrames~f~7!{STUCK="true",STUCKTOPOINT="BOTTOMRIGHT",STUCKTO=1,STUCKPOINT="TOPRIGHT"}
StickyFrames~d!8~
StickyFrames~f~9!{STUCK="true",STUCKTOPOINT="TOPLEFT",STUCKTO=1,STUCKPOINT="TOPRIGHT"}
StickyFrames~f~10!{STUCK="true",STUCKTOPOINT="TOPLEFT",STUCKTO=1,STUCKPOINT="BOTTOMLEFT"}
HealGroups~f~1!{FRAME=1,STATE="true",NAME="Main tanks"}
HealGroups~f~2!{FRAME=1,STATE="false",NAME="Private List"}
HealGroups~f~3!{FRAME=1,STATE="false",NAME="Self"}
HealGroups~f~4!{FRAME=1,STATE="true",NAME="Healers"}
HealGroups~f~5!{FRAME=1,STATE="true",NAME="Group"}
HealGroups~f~6!{FRAME=1,STATE="true",NAME="Raid"}
HealGroups~f~7!{FRAME=6,STATE="false",NAME="Vehicle"}
HealGroups~f~8!{FRAME=1,STATE="true",NAME="Pets"}
HealGroups~f~9!{FRAME=8,STATE="true",NAME="Target"}
HealGroups~f~10!{FRAME=9,STATE="true",NAME="Focus"}
HealGroups~f~11!{FRAME=10,STATE="true",NAME="Enemy"}
Anchors~f~1!{Y=59.64,GROW=2,BARS=3,FRAME=3,X=45.12}
Anchors~f~2!{Y=73.85,GROW=2,BARS=1,FRAME=3,X=100}
Anchors~f~3!{Y=55,GROW=2,BARS=3,FRAME=3,X=96.42}
Anchors~f~4!{Y=64.17,GROW=2,BARS=1,FRAME=1,X=83.17}
Anchors~f~5!{Y=65.23,GROW=2,BARS=2,FRAME=2,X=89.04}
Anchors~f~6!{Y=55,GROW=2,BARS=1,FRAME=1,X=55}
Anchors~f~7!{Y=2.83,GROW=2,BARS=1,FRAME=3,X=100}
Anchors~f~8!{Y=55.56,GROW=2,BARS=1,FRAME=3,X=45.12}
Anchors~f~9!{Y=59.64,GROW=2,BARS=1,FRAME=3,X=39.15}
Anchors~f~10!{Y=59.64,GROW=2,BARS=4,FRAME=2,X=39.26}
HeadBar~f~1!{SHOW="false",TEXTURE="Diagonal",R=0.506,B=0.506,HEIGHT=30,A=0.4,G=0.506,WIDTH=0.9}
HeadBar~f~2!{SHOW="false",TEXTURE="Diagonal",R=0.1,B=0.1,HEIGHT=30,A=0.25,G=0.1,WIDTH=0.9}
HeadBar~d!3~4~5~6~7~8~9~10~
HeadText~f~1!{A=0.7,R=0.2,OFFSET=0,B=0.8,FONT="Friz Quadrata TT",HEIGHT=10,G=0.8,OUTLINE=1}
HeadText~f~2!{A=0.7,R=1,OFFSET=0,B=0.1,FONT="Friz Quadrata TT",HEIGHT=10,G=1,OUTLINE=1}
HeadText~d!3~4~5~6~7~8~9~10~
HealBar~f~1!{HEIGHT=32,GRPCOLS="false",CMARGIN=2,TEXTURE="Smooth v2",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=152,RMARGIN=4,OFIX=1,NUMCOLS=1,LOWMANA=3}
HealBar~f~2!{HEIGHT=34,GRPCOLS="false",CMARGIN=4,TEXTURE="Smooth v2",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=2,NUMCOLS=1,OFIX=1,RMARGIN=0,WIDTH=172}
HealBar~d!3~4~5~6~
HealBar~f~7!{HEIGHT=34,GRPCOLS="false",CMARGIN=4,TEXTURE="Smooth v2",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=172,RMARGIN=0,OFIX=1,NUMCOLS=1,LOWMANA=1}
HealBar~f~8!{HEIGHT=34,GRPCOLS="false",CMARGIN=4,TEXTURE="Smooth v2",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=152,RMARGIN=0,OFIX=1,NUMCOLS=1,LOWMANA=2}
HealBar~d!9~
HealBar~f~10!{HEIGHT=34,GRPCOLS="false",CMARGIN=4,TEXTURE="Smooth v2",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=154,RMARGIN=0,OFIX=1,NUMCOLS=1,LOWMANA=2}
BarCol~f~1!{BACK=2,BA=0,BOUT=0,DISA=0,BR=0.506,HB=0.9,BG=0.506,HG=0.2,HA=1,HR=0.2,ORA=0.58,BB=0.506,HLTH=2}
BarCol~d!2~3~4~5~6~7~8~9~10~
BarIACol~f~1!{AC=4,AB=0.973,AA=0.25,AR=0.973,AG=0.973,IC=2,IB=0.953,IA=0.35,IR=1,IG=0.984}
BarIACol~d!2~3~4~5~6~7~8~9~10~
BarText~f~1!{HLTHONBAR="true",TAGOOR="OOR | ",IGNOREONFULL="false",MAXCHARS=0,CLASSONBAR="false",HFONT="Friz Quadrata TT",OVERHEAL=1,OUTLINE=1,OFFSET=2,HLTHTXTANCHOR=1,HLTHTYPE=1,INCHEALS=2,CLASSTYPE=1,NUMFORMAT2=1,HOUTLINE=1,NUMFORMAT1=11,FONT="Friz Quadrata TT",TAGRIP="RIP | ",HEIGHT=12,NAMEONBAR="true",SHOWROLE="true",HALIGN=2,HHEIGHT=14,TAGDC="DC | ",HMAXCHARS=0,INCABSORBS=2,HOFFSET2=0,ALIGN=2,TAGR="R | ",HOFFSET=0}
BarText~d!2~3~4~5~6~7~8~9~
BarText~f~10!{HLTHONBAR="true",TAGOOR="OOR | ",IGNOREONFULL="false",MAXCHARS=0,CLASSONBAR="false",HOFFSET=0,HOUTLINE=1,OUTLINE=1,INCHEALS=2,HLTHTXTANCHOR=1,HLTHTYPE=1,OFFSET=2,INCABSORBS=2,NUMFORMAT2=1,OVERHEAL=1,NUMFORMAT1=11,TAGDC="DC | ",TAGRIP="RIP | ",HEIGHT=10,HHEIGHT=12,SHOWROLE="true",HALIGN=2,NAMEONBAR="true",FONT="Friz Quadrata TT",HMAXCHARS=0,CLASSTYPE=1,HOFFSET2=0,ALIGN=2,TAGR="R | ",HFONT="Friz Quadrata TT"}
BarTextCol~f~1!{HCG=0,HCA=1,HLTH=1,NCDA=0.15,NCB=0.267,NCR=0.949,NCG=0.843,NCA=1,HCR=0.761,HCB=1,NDEBUFF="false",HDEBUFF="false",NAME=2,HCDA=0.1}
BarTextCol~d!2~3~4~5~6~7~
BarTextCol~f~8!{NAME=2,NDEBUFF="false",HCDA=0.74,NCDA=0.72,NCB=0.267,HCA=1,NCG=0.843,NCA=1,HCR=0.761,HCB=1,NCR=0.949,HDEBUFF="false",HCG=0,HLTH=1}
BarTextCol~f~9!{NAME=2,NDEBUFF="false",HCDA=0.72,NCDA=0.72,NCB=0.267,HCA=1,NCG=0.843,NCA=1,HCR=0.761,HCB=1,NCR=0.949,HDEBUFF="false",HCG=0,HLTH=1}
BarTextCol~f~10!{NAME=2,NDEBUFF="false",HCDA=0.1,NCDA=0.15,NCB=0.267,HCA=1,NCG=0.843,NCA=1,HCR=0.761,HCB=1,NCR=0.949,HDEBUFF="false",HCG=0,HLTH=1}
Icons~f~1!{SHOWBUFF="true",SHOWDEBUFF="true",FADESECS=15,I15EN="false",MAXDICONS=4,POSITION=2,ONBAR=1,FADE="false",DSCALE=1,SHOWDIR="false",SHOWRC="true",SCALE=1,DOUBLE="true",SHOWDIRMOUSE="false",MAXBICONS=8}
Icons~d!2~3~4~5~6~
Icons~f~7!{SHOWBUFF="true",SHOWDEBUFF="true",FADESECS=15,I15EN="false",MAXDICONS=4,POSITION=2,ONBAR=1,FADE="false",DSCALE=1,SHOWDIR="false",SHOWRC="true",SCALE=1,DOUBLE="true",SHOWDIRMOUSE="false",MAXBICONS=6}
Icons~f~8!{SHOWBUFF="true",SHOWDEBUFF="true",FADESECS=15,I15EN="false",MAXDICONS=4,POSITION=2,ONBAR=1,FADE="false",DSCALE=1,SHOWDIR="false",SHOWRC="true",SCALE=1,DOUBLE="true",SHOWDIRMOUSE="false",MAXBICONS=8}
Icons~d!9~10~
RaidIcon~f~1!{SQUARE="true",CIRCLE="true",DIAMOND="true",SHOW="true",MOON="true",TRIANGLE="true",STAR="true",SKULL="true",CROSS="true"}
RaidIcon~d!2~3~4~5~6~7~8~9~10~
IconText~f~1!{DURWARN=3,HEIGHT=10,SSCNT="false",SCNT="true",DURTHRH=9,FONT="Friz Quadrata TT",SDUR="true",SSDUR="true",OUTLINE=2}
IconText~d!2~3~4~5~6~7~8~9~10~
BarVisibility~f~1!{INCCLASSES=1,ALERTIC=0.95,ALERTOC=0.9,HIDEOOR="false"}
BarVisibility~f~2!{INCCLASSES=1,ALERTIC=0.92,ALERTOC=0.8,HIDEOOR="false"}
BarVisibility~d!3~4~5~6~7~
BarVisibility~f~8!{INCCLASSES=1,ALERTIC=1,ALERTOC=1,HIDEOOR="false"}
BarVisibility~d!9~
BarVisibility~f~10!{INCCLASSES=1,ALERTIC=0.92,ALERTOC=0.8,HIDEOOR="false"}
BarSort~f~1!{SUBORDER=4,OORLAST="false",RAIDORDER=2,SUBPF="true"}
BarSort~d!2~3~4~5~6~7~8~9~10~
BarAggro~f~1!{B=0.075,ALERTIND=2,G=0.173,TEXTFORMAT=3,SHOW="true",SHOWTEXTPCT="true",SHOWTEXT="false",SHOWIND="false",R=0.969,ALERT=2}
BarAggro~d!2~3~4~5~6~7~8~9~10~
AuxBarFrame~f~1!{OVERLAP=1}
AuxBarFrame~d!2~3~4~5~6~7~8~9~10~
AuxBar^1~f~1!{SIZE=1,USE=4,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,B=1,G=1,OTYPE=1}
AuxBar^1~d!2~3~4~5~6~7~8~9~10~
AuxBar^2~f~1!{SIZE=0.4,USE=9,R=0.761,COLOUR=1,ANCHOR=2,OFFSET=1,DEPTH=2,B=1,G=0,OTYPE=2}
AuxBar^2~d!2~3~4~5~6~7~8~9~
AuxBar^2~f~10!{SIZE=0.4,USE=1,R=0.761,COLOUR=1,ANCHOR=2,OFFSET=1,DEPTH=2,B=1,G=0,OTYPE=2}
AuxBar^3~f~1!{SIZE=0.4,USE=10,R=0.357,COLOUR=1,ANCHOR=2,OFFSET=-2,DEPTH=2,B=0.58,G=0.122,OTYPE=2}
AuxBar^3~d!2~3~4~5~6~7~8~9~
AuxBar^3~f~10!{SIZE=0.4,USE=1,R=0.357,COLOUR=1,ANCHOR=2,OFFSET=-2,DEPTH=2,B=0.58,G=0.122,OTYPE=2}
AuxBar^4~f~1!{SIZE=0.98,USE=6,R=1,COLOUR=1,ANCHOR=3,OFFSET=0,DEPTH=4,B=1,G=1,OTYPE=1}
AuxBar^4~d!2~3~4~5~6~7~8~9~
AuxBar^4~f~10!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=3,OFFSET=0,DEPTH=4,B=1,G=1,OTYPE=1}
AuxBar^5~f~1!{SIZE=0.98,USE=5,R=1,COLOUR=1,ANCHOR=2,OFFSET=1,DEPTH=1,B=1,G=1,OTYPE=1}
AuxBar^5~d!2~3~4~5~6~7~8~9~
AuxBar^5~f~10!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=2,OFFSET=1,DEPTH=1,B=1,G=1,OTYPE=1}
AuxBar^6~f~1!{SIZE=0.98,USE=7,R=1,COLOUR=3,ANCHOR=4,OFFSET=1,DEPTH=4,B=1,G=1,OTYPE=1}
AuxBar^6~d!2~3~4~5~6~7~8~9~
AuxBar^6~f~10!{SIZE=0.98,USE=1,R=1,COLOUR=3,ANCHOR=4,OFFSET=1,DEPTH=4,B=1,G=1,OTYPE=1}
AuxBar^7~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=4,OFFSET=1,DEPTH=3,B=1,G=1,OTYPE=2}
AuxBar^7~d!2~3~4~5~6~7~8~9~10~
AuxBar^8~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=3,ANCHOR=3,OFFSET=1,DEPTH=2,B=0.251,G=0.557,OTYPE=2}
AuxBar^8~d!2~3~4~5~6~7~8~9~10~
AuxBar^9~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,B=1,G=1,OTYPE=1}
AuxBar^9~d!2~3~4~5~6~7~8~9~10~
Complete!]]
HealBot_ExtraSkinData[34]=[[Skin
Clarity Raid 10
Author~v!Monti of Terenas
DuplicateBars~v!false
Chat~t!{EOCOOM="false",EOCOOMV=5,MSG="Casting #s on #n",RESONLY="true",CHAN="",NOTIFY=1}
General~t!{OFREQ=0.07,OMIN=0.1,OMAX=0.95,FLUIDFREQ=10,HIDEPTF="false",HIDEPARTYF="false",HIDERAIDF="true",STICKYSENSITIVITY=20,STICKYFRAME="true",FLUIDBARS="false",HIDEBOSSF="true"}
Healing~t!{TINCSELF="false",GROUPPETS="true",TARGETINCOMBAT=1,FALWAYSSHOW="false",FONLYFRIEND="true",TINCPET="false",TONLYFRIEND="false",TINCGROUP="true",FOCUSINCOMBAT=2,TALWAYSSHOW="false",SELFPET=0,TINCRAID="true",TEXRAID="false",FEXRAID="false"}
Enemy~t!{INCARENA="false",INCTANKS="true",INCMYTAR="false",ENEMYTARGET="true",INCARENAPETS="false",ENEMYTARGETSIZE=58,INCSELF="false",NUMBOSS=1,EXISTSHOWPTAR=1,HIDE="true",EXISTSHOWBOSS="true",DOUBLEWIDTH="false",EXISTSHOWARENA=2}
FrameAlias~f~1!{SIZE=12,NAME="Party",R=1,ALIAS="Raid",G=1,SHOW="false",OFFSET=1,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~2!{SIZE=12,NAME="Tank and Healer",R=1,ALIAS="Tank and Healer",G=1,SHOW="false",OFFSET=1,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~3!{SIZE=12,NAME="Pets",R=1,ALIAS="Not Used 1",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~4!{SIZE=12,NAME="Focus and Target",R=1,ALIAS="Not Used 2",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~5!{SIZE=12,NAME="Enemy",R=1,ALIAS="Not Used 3",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~6!{SIZE=12,NAME="",R=1,ALIAS="Vehicle",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~7!{SIZE=12,NAME="Pets",R=1,ALIAS="Pets",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~8!{SIZE=12,NAME="Target",R=1,ALIAS="Target",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~9!{SIZE=12,NAME="",R=1,ALIAS="Focus",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~10!{SIZE=12,NAME="Enemy",R=1,ALIAS="Enemy",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAliasBar~f~1!{A=0.23,WIDTH=0.94,B=0,HEIGHT=20,R=0.004,G=0,TEXTURE="Flat"}
FrameAliasBar~d!2~3~4~5~6~7~8~9~10~
Frame~f~1!{SFOFFSETH=0,BORDERR=0.318,BACKR=0.506,BORDERG=0.757,LOCKED="false",OPENSOUND="false",BORDERA=0,SFOFFSETV=0,AUTOCLOSE="false",BACKB=0.506,BACKA=0,SCALE=1,BORDERB=1,TIPLOC=2,BACKG=0.506}
Frame~f~2!{SFOFFSETH=0,BORDERR=0.102,BACKR=0.102,BORDERG=0.102,LOCKED="true",OPENSOUND="false",BORDERA=0,SFOFFSETV=0,AUTOCLOSE="false",BACKB=0.502,BACKA=0,SCALE=1,BORDERB=0.102,TIPLOC=1,BACKG=0.102}
Frame~f~3!{SFOFFSETH=0,BORDERR=0.1,BACKR=0.1,BORDERG=0.1,LOCKED="false",OPENSOUND="false",BORDERA=0.5,SFOFFSETV=0,AUTOCLOSE="false",BACKB=0.5,BACKA=0.2,SCALE=1,BORDERB=0.1,TIPLOC=2,BACKG=0.1}
Frame~d!4~
Frame~f~5!{SFOFFSETH=0,BORDERR=0.1,BACKR=0.1,BORDERG=0.1,LOCKED="false",OPENSOUND="false",BORDERA=0.5,SFOFFSETV=0,AUTOCLOSE="false",BACKB=0.5,BACKA=0.2,SCALE=1,BORDERB=0.1,TIPLOC=4,BACKG=0.1}
Frame~f~6!{SFOFFSETH=0,BORDERR=0.1,BACKR=0.1,BORDERG=0.1,LOCKED="false",OPENSOUND="false",BORDERA=0.5,SFOFFSETV=0,AUTOCLOSE="false",BACKB=0.5,BACKA=0.2,SCALE=1,BORDERB=0.1,TIPLOC=5,BACKG=0.1}
Frame~f~7!{SFOFFSETH=0,BACKG=0.102,TIPLOC=5,BORDERB=0.102,LOCKED="true",SCALE=1,BORDERA=0.01,BORDERG=0.102,AUTOCLOSE="false",BACKB=0.502,BACKA=0.01,OPENSOUND="false",BACKR=0.102,SFOFFSETV=8,BORDERR=0.102}
Frame~f~8!{SFOFFSETH=0,BACKG=0.102,TIPLOC=5,BORDERB=0.102,LOCKED="false",SCALE=1,BORDERA=0,BORDERG=0.102,AUTOCLOSE="false",BACKB=0.502,BACKA=0,OPENSOUND="false",BACKR=0.102,SFOFFSETV=4,BORDERR=0.102}
Frame~f~9!{SFOFFSETH=0,BACKG=0.1,TIPLOC=5,BORDERB=0.1,LOCKED="false",SCALE=1,BORDERA=0.5,BORDERG=0.1,AUTOCLOSE="false",BACKB=0.5,BACKA=0.2,OPENSOUND="false",BACKR=0.1,SFOFFSETV=0,BORDERR=0.1}
Frame~f~10!{SFOFFSETH=3,BORDERR=0.706,BACKR=0.102,BORDERG=0,LOCKED="true",OPENSOUND="false",BORDERA=0,SFOFFSETV=0,AUTOCLOSE="false",BACKB=0.502,BACKA=0.05,SCALE=1,BORDERB=0.122,TIPLOC=4,BACKG=0.102}
StickyFrames~f~1!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~f~2!{STUCK="true",STUCKTOPOINT="TOPLEFT",STUCKTO=1,STUCKPOINT="TOPRIGHT"}
StickyFrames~f~3!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~d!4~5~6~
StickyFrames~f~7!{STUCK="true",STUCKTOPOINT="BOTTOMRIGHT",STUCKTO=1,STUCKPOINT="TOPRIGHT"}
StickyFrames~f~8!{STUCK="true",STUCKTOPOINT="TOPLEFT",STUCKTO=1,STUCKPOINT="TOPRIGHT"}
StickyFrames~f~9!{STUCK="true",STUCKTOPOINT="BOTTOMLEFT",STUCKTO=1,STUCKPOINT="BOTTOMRIGHT"}
StickyFrames~f~10!{STUCK="true",STUCKTOPOINT="TOPLEFT",STUCKTO=1,STUCKPOINT="BOTTOMLEFT"}
HealGroups~f~1!{FRAME=1,STATE="true",NAME="Main tanks"}
HealGroups~f~2!{FRAME=1,STATE="false",NAME="Private List"}
HealGroups~f~3!{FRAME=1,STATE="false",NAME="Self"}
HealGroups~f~4!{FRAME=1,STATE="true",NAME="Healers"}
HealGroups~f~5!{FRAME=1,STATE="true",NAME="Raid"}
HealGroups~f~6!{FRAME=1,STATE="false",NAME="Group"}
HealGroups~f~7!{FRAME=6,STATE="false",NAME="Vehicle"}
HealGroups~f~8!{FRAME=7,STATE="true",NAME="Pets"}
HealGroups~f~9!{FRAME=8,STATE="true",NAME="Target"}
HealGroups~f~10!{FRAME=9,STATE="true",NAME="Focus"}
HealGroups~f~11!{FRAME=10,STATE="true",NAME="Enemy"}
Anchors~f~1!{Y=58.04,GROW=1,BARS=3,FRAME=3,X=45.73}
Anchors~f~2!{Y=73.85,GROW=2,BARS=1,FRAME=3,X=100}
Anchors~f~3!{Y=55,GROW=2,BARS=3,FRAME=3,X=96.42}
Anchors~f~4!{Y=64.17,GROW=2,BARS=1,FRAME=1,X=83.17}
Anchors~f~5!{Y=65.23,GROW=2,BARS=2,FRAME=2,X=89.04}
Anchors~f~6!{Y=55,GROW=2,BARS=1,FRAME=1,X=55}
Anchors~f~7!{Y=54.29,GROW=2,BARS=1,FRAME=3,X=45.73}
Anchors~f~8!{Y=58.37,GROW=2,BARS=1,FRAME=3,X=40.81}
Anchors~f~9!{Y=53.62,GROW=2,BARS=1,FRAME=4,X=40.81}
Anchors~f~10!{Y=58.04,GROW=2,BARS=4,FRAME=2,X=40.92}
HeadBar~f~1!{SHOW="false",WIDTH=0.9,B=0.506,R=0.506,HEIGHT=30,A=0.4,G=0.506,TEXTURE="Diagonal"}
HeadBar~f~2!{SHOW="false",WIDTH=0.9,B=0.1,R=0.1,HEIGHT=30,A=0.25,G=0.1,TEXTURE="Diagonal"}
HeadBar~d!3~4~5~6~7~8~9~10~
HeadText~f~1!{A=0.7,B=0.8,OFFSET=0,R=0.2,FONT="Friz Quadrata TT",HEIGHT=10,G=0.8,OUTLINE=1}
HeadText~f~2!{A=0.7,B=0.1,OFFSET=0,R=1,FONT="Friz Quadrata TT",HEIGHT=10,G=1,OUTLINE=1}
HeadText~d!3~4~5~6~7~8~9~10~
HealBar~f~1!{HEIGHT=32,GRPCOLS="false",CMARGIN=2,TEXTURE="Smooth v2",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=3,NUMCOLS=5,OFIX=1,RMARGIN=4,WIDTH=122}
HealBar~f~2!{HEIGHT=34,GRPCOLS="false",CMARGIN=4,TEXTURE="Smooth v2",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=172,RMARGIN=0,OFIX=1,NUMCOLS=1,LOWMANA=2}
HealBar~d!3~4~5~6~
HealBar~f~7!{HEIGHT=34,GRPCOLS="false",CMARGIN=4,TEXTURE="Smooth v2",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=1,NUMCOLS=2,OFIX=1,RMARGIN=0,WIDTH=122}
HealBar~f~8!{HEIGHT=34,GRPCOLS="false",CMARGIN=4,TEXTURE="Smooth v2",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=2,NUMCOLS=1,OFIX=1,RMARGIN=0,WIDTH=122}
HealBar~d!9~
HealBar~f~10!{HEIGHT=34,GRPCOLS="false",CMARGIN=4,TEXTURE="Smooth v2",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=2,NUMCOLS=2,OFIX=1,RMARGIN=0,WIDTH=128}
BarCol~f~1!{BACK=2,BA=0,BOUT=0,DISA=0,BR=0.506,HB=0.9,BG=0.506,BB=0.506,HA=1,HG=0.2,ORA=0.58,HR=0.2,HLTH=2}
BarCol~d!2~3~4~5~6~7~8~9~10~
BarIACol~f~1!{AC=4,AB=0.973,AA=0.25,AR=0.973,AG=0.973,IC=2,IB=0.953,IA=0.35,IR=1,IG=0.984}
BarIACol~d!2~3~4~5~6~7~8~9~10~
BarText~f~1!{HLTHONBAR="true",TAGOOR="OOR | ",IGNOREONFULL="false",MAXCHARS=0,CLASSONBAR="false",HOFFSET=0,OUTLINE=1,INCHEALS=2,OFFSET=2,HLTHTXTANCHOR=1,HLTHTYPE=1,HOUTLINE=1,INCABSORBS=2,NUMFORMAT2=1,HMAXCHARS=0,NUMFORMAT1=11,TAGDC="DC | ",TAGRIP="RIP | ",HEIGHT=12,HHEIGHT=14,SHOWROLE="true",HALIGN=2,NAMEONBAR="true",FONT="Friz Quadrata TT",OVERHEAL=1,CLASSTYPE=1,HOFFSET2=0,ALIGN=2,TAGR="R | ",HFONT="Friz Quadrata TT"}
BarText~d!2~3~4~5~6~7~8~9~
BarText~f~10!{HLTHONBAR="true",TAGOOR="OOR | ",IGNOREONFULL="false",MAXCHARS=0,CLASSONBAR="false",HFONT="Friz Quadrata TT",OUTLINE=1,OFFSET=2,INCHEALS=2,HLTHTXTANCHOR=1,HLTHTYPE=1,OVERHEAL=1,CLASSTYPE=1,NUMFORMAT2=1,HMAXCHARS=0,NUMFORMAT1=11,FONT="Friz Quadrata TT",TAGRIP="RIP | ",HEIGHT=12,NAMEONBAR="true",SHOWROLE="true",HALIGN=2,HHEIGHT=12,TAGDC="DC | ",HOUTLINE=1,INCABSORBS=2,HOFFSET2=0,ALIGN=2,TAGR="R | ",HOFFSET=0}
BarTextCol~f~1!{NCB=0.267,NCR=0.949,HCDA=0.1,NCDA=0.15,NAME=2,HCG=0,NCG=0.843,NCA=1,NDEBUFF="false",HCB=1,HCR=0.761,HDEBUFF="false",HCA=1,HLTH=1}
BarTextCol~d!2~3~4~5~6~7~
BarTextCol~f~8!{NCB=0.267,HCA=1,HLTH=1,NCDA=0.72,HCG=0,NAME=2,NCG=0.843,NCA=1,NCR=0.949,HCB=1,HCR=0.761,HDEBUFF="false",NDEBUFF="false",HCDA=0.74}
BarTextCol~f~9!{NCB=0.267,HCA=1,HLTH=1,NCDA=0.72,HCG=0,NAME=2,NCG=0.843,NCA=1,NCR=0.949,HCB=1,HCR=0.761,HDEBUFF="false",NDEBUFF="false",HCDA=0.72}
BarTextCol~f~10!{NCB=0.267,HCA=1,HLTH=1,NCDA=0.15,HCG=0,NAME=2,NCG=0.843,NCA=1,NCR=0.949,HCB=1,HCR=0.761,HDEBUFF="false",NDEBUFF="false",HCDA=0.1}
Icons~f~1!{SHOWBUFF="true",POSITION=2,I15EN="false",MAXDICONS=4,SHOWDIRMOUSE="false",DOUBLE="true",SHOWDIR="false",FADE="false",DSCALE=1,ONBAR=1,SHOWRC="true",SCALE=1,SHOWDEBUFF="true",FADESECS=15,MAXBICONS=8}
Icons~d!2~3~4~5~6~
Icons~f~7!{SHOWBUFF="true",POSITION=2,I15EN="false",MAXDICONS=4,SHOWDIRMOUSE="false",DOUBLE="true",SHOWDIR="false",FADE="false",DSCALE=1,ONBAR=1,SHOWRC="true",SCALE=1,SHOWDEBUFF="true",FADESECS=15,MAXBICONS=6}
Icons~f~8!{SHOWBUFF="true",POSITION=2,I15EN="false",MAXDICONS=4,SHOWDIRMOUSE="false",DOUBLE="true",SHOWDIR="false",FADE="false",DSCALE=1,ONBAR=1,SHOWRC="true",SCALE=1,SHOWDEBUFF="true",FADESECS=15,MAXBICONS=8}
Icons~d!9~10~
RaidIcon~f~1!{SQUARE="true",CIRCLE="true",DIAMOND="true",SHOW="true",SKULL="true",TRIANGLE="true",STAR="true",CROSS="true",MOON="true"}
RaidIcon~d!2~3~4~5~6~7~8~9~10~
IconText~f~1!{SDUR="true",HEIGHT=10,SSCNT="false",SCNT="true",DURTHRH=9,FONT="Friz Quadrata TT",DURWARN=3,SSDUR="true",OUTLINE=2}
IconText~d!2~3~4~5~6~7~8~9~10~
BarVisibility~f~1!{INCCLASSES=1,ALERTIC=0.95,ALERTOC=0.9,HIDEOOR="false"}
BarVisibility~d!2~3~4~5~6~7~
BarVisibility~f~8!{INCCLASSES=1,ALERTIC=1,ALERTOC=1,HIDEOOR="false"}
BarVisibility~d!9~
BarVisibility~f~10!{INCCLASSES=1,ALERTIC=0.95,ALERTOC=0.9,HIDEOOR="false"}
BarSort~f~1!{SUBORDER=4,OORLAST="false",RAIDORDER=2,SUBPF="true"}
BarSort~d!2~3~4~5~6~7~8~9~10~
BarAggro~f~1!{B=0.075,ALERTIND=2,G=0.173,TEXTFORMAT=3,SHOW="true",SHOWTEXTPCT="true",SHOWTEXT="false",R=0.969,SHOWIND="false",ALERT=2}
BarAggro~d!2~3~4~5~6~7~8~9~10~
AuxBarFrame~f~1!{OVERLAP=1}
AuxBarFrame~d!2~3~4~5~6~7~8~9~10~
AuxBar^1~f~1!{SIZE=1,USE=4,B=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,OTYPE=1,G=1,R=1}
AuxBar^1~d!2~3~4~5~6~7~8~9~10~
AuxBar^2~f~1!{SIZE=0.4,USE=9,B=1,COLOUR=1,ANCHOR=2,OFFSET=1,DEPTH=2,OTYPE=2,G=0,R=0.761}
AuxBar^2~d!2~3~4~5~6~7~8~9~
AuxBar^2~f~10!{SIZE=0.4,USE=1,B=1,COLOUR=1,ANCHOR=2,OFFSET=1,DEPTH=2,OTYPE=2,G=0,R=0.761}
AuxBar^3~f~1!{SIZE=0.4,USE=10,B=0.58,COLOUR=1,ANCHOR=2,OFFSET=-2,DEPTH=2,OTYPE=2,G=0.122,R=0.357}
AuxBar^3~d!2~3~4~5~6~7~8~9~
AuxBar^3~f~10!{SIZE=0.4,USE=1,B=0.58,COLOUR=1,ANCHOR=2,OFFSET=-2,DEPTH=2,OTYPE=2,G=0.122,R=0.357}
AuxBar^4~f~1!{SIZE=0.98,USE=6,B=1,COLOUR=1,ANCHOR=3,OFFSET=0,DEPTH=4,OTYPE=1,G=1,R=1}
AuxBar^4~d!2~3~4~5~6~7~8~9~
AuxBar^4~f~10!{SIZE=0.98,USE=1,B=1,COLOUR=1,ANCHOR=3,OFFSET=0,DEPTH=4,OTYPE=1,G=1,R=1}
AuxBar^5~f~1!{SIZE=0.98,USE=5,B=1,COLOUR=1,ANCHOR=2,OFFSET=1,DEPTH=1,OTYPE=1,G=1,R=1}
AuxBar^5~d!2~3~4~5~6~7~8~9~
AuxBar^5~f~10!{SIZE=0.98,USE=1,B=1,COLOUR=1,ANCHOR=2,OFFSET=1,DEPTH=1,OTYPE=1,G=1,R=1}
AuxBar^6~f~1!{SIZE=0.98,USE=7,B=1,COLOUR=3,ANCHOR=4,OFFSET=1,DEPTH=4,OTYPE=1,G=1,R=1}
AuxBar^6~d!2~3~4~5~6~7~8~9~
AuxBar^6~f~10!{SIZE=0.98,USE=1,B=1,COLOUR=3,ANCHOR=4,OFFSET=1,DEPTH=4,OTYPE=1,G=1,R=1}
AuxBar^7~f~1!{SIZE=0.98,USE=1,B=1,COLOUR=1,ANCHOR=4,OFFSET=1,DEPTH=3,OTYPE=2,G=1,R=1}
AuxBar^7~d!2~3~4~5~6~7~8~9~10~
AuxBar^8~f~1!{SIZE=0.98,USE=1,B=0.251,COLOUR=3,ANCHOR=3,OFFSET=1,DEPTH=2,OTYPE=2,G=0.557,R=1}
AuxBar^8~d!2~3~4~5~6~7~8~9~10~
AuxBar^9~f~1!{SIZE=0.98,USE=1,B=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,OTYPE=1,G=1,R=1}
AuxBar^9~d!2~3~4~5~6~7~8~9~10~
Complete!]]
HealBot_ExtraSkinData[35]=[[Skin
Clarity Raid 25
Author~v!Monti of Terenas
DuplicateBars~v!false
Chat~t!{EOCOOM="false",EOCOOMV=5,MSG="Casting #s on #n",RESONLY="true",CHAN="",NOTIFY=1}
General~t!{OFREQ=0.07,OMIN=0.1,OMAX=0.95,HIDEBOSSF="true",HIDEPARTYF="false",FLUIDFREQ=10,HIDERAIDF="true",STICKYSENSITIVITY=20,STICKYFRAME="true",FLUIDBARS="false",HIDEPTF="false"}
Healing~t!{TINCSELF="false",GROUPPETS="true",TARGETINCOMBAT=1,FEXRAID="false",FONLYFRIEND="true",SELFPET=0,TONLYFRIEND="false",FALWAYSSHOW="false",FOCUSINCOMBAT=2,TALWAYSSHOW="false",TINCPET="false",TINCRAID="true",TEXRAID="false",TINCGROUP="true"}
Enemy~t!{INCARENA="false",INCTANKS="true",INCMYTAR="false",ENEMYTARGET="true",ENEMYTARGETSIZE=58,INCARENAPETS="false",HIDE="true",NUMBOSS=1,EXISTSHOWPTAR=1,INCSELF="false",EXISTSHOWBOSS="true",DOUBLEWIDTH="false",EXISTSHOWARENA=2}
FrameAlias~f~1!{SIZE=12,NAME="Party",R=1,ALIAS="Raid",G=1,SHOW="false",OFFSET=1,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~2!{SIZE=12,NAME="Tank and Healer",R=1,ALIAS="Tank and Healer",G=1,SHOW="false",OFFSET=1,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~3!{SIZE=12,NAME="Pets",R=1,ALIAS="Not Used 1",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~4!{SIZE=12,NAME="Focus and Target",R=1,ALIAS="Not Used 2",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~5!{SIZE=12,NAME="Enemy",R=1,ALIAS="Not Used 3",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~6!{SIZE=12,NAME="",R=1,ALIAS="Vehicle",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~7!{SIZE=12,NAME="Pets",R=1,ALIAS="Pets",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~8!{SIZE=12,NAME="Target",R=1,ALIAS="Target",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~9!{SIZE=12,NAME="",R=1,ALIAS="Focus",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~10!{SIZE=12,NAME="Enemy",R=1,ALIAS="Enemy",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAliasBar~f~1!{A=0.23,TEXTURE="Flat",B=0,HEIGHT=20,R=0.004,G=0,WIDTH=0.94}
FrameAliasBar~d!2~3~4~5~6~7~8~9~10~
Frame~f~1!{BORDERR=0.318,TIPLOC=2,AUTOCLOSE="false",BACKB=0.506,LOCKED="false",SCALE=1,BORDERA=0,SFOFFSETV=0,BACKG=0.506,BORDERB=1,BACKA=0,OPENSOUND="false",SFOFFSETH=0,BORDERG=0.757,BACKR=0.506}
Frame~f~2!{BORDERR=0.102,TIPLOC=1,AUTOCLOSE="false",BACKB=0.502,LOCKED="true",SCALE=1,BORDERA=0,SFOFFSETV=0,BACKG=0.102,BORDERB=0.102,BACKA=0,OPENSOUND="false",SFOFFSETH=-8,BORDERG=0.102,BACKR=0.102}
Frame~f~3!{BORDERR=0.1,TIPLOC=2,AUTOCLOSE="false",BACKB=0.5,LOCKED="false",SCALE=1,BORDERA=0.5,SFOFFSETV=0,BACKG=0.1,BORDERB=0.1,BACKA=0.2,OPENSOUND="false",SFOFFSETH=0,BORDERG=0.1,BACKR=0.1}
Frame~d!4~
Frame~f~5!{BORDERR=0.1,TIPLOC=4,AUTOCLOSE="false",BACKB=0.5,LOCKED="false",SCALE=1,BORDERA=0.5,SFOFFSETV=0,BACKG=0.1,BORDERB=0.1,BACKA=0.2,OPENSOUND="false",SFOFFSETH=0,BORDERG=0.1,BACKR=0.1}
Frame~f~6!{BORDERR=0.1,TIPLOC=5,AUTOCLOSE="false",BACKB=0.5,LOCKED="false",SCALE=1,BORDERA=0.5,SFOFFSETV=0,BACKG=0.1,BORDERB=0.1,BACKA=0.2,OPENSOUND="false",SFOFFSETH=0,BORDERG=0.1,BACKR=0.1}
Frame~f~7!{BACKR=0.102,BORDERR=0.102,BORDERG=0.102,SFOFFSETH=0,LOCKED="true",OPENSOUND="false",BORDERA=0.01,SFOFFSETV=8,TIPLOC=5,BACKB=0.502,BACKA=0.01,SCALE=1,BORDERB=0.102,BACKG=0.102,AUTOCLOSE="false"}
Frame~f~8!{BACKR=0.102,BORDERR=0.102,BORDERG=0.102,SFOFFSETH=0,LOCKED="false",OPENSOUND="false",BORDERA=0,SFOFFSETV=4,TIPLOC=5,BACKB=0.502,BACKA=0,SCALE=1,BORDERB=0.102,BACKG=0.102,AUTOCLOSE="false"}
Frame~f~9!{BACKR=0.1,BORDERR=0.1,BORDERG=0.1,SFOFFSETH=0,LOCKED="false",OPENSOUND="false",BORDERA=0.5,SFOFFSETV=0,TIPLOC=5,BACKB=0.5,BACKA=0.2,SCALE=1,BORDERB=0.1,BACKG=0.1,AUTOCLOSE="false"}
Frame~f~10!{BORDERR=0.706,TIPLOC=4,AUTOCLOSE="false",BACKB=0.502,LOCKED="true",SCALE=1,BORDERA=0,SFOFFSETV=0,BACKG=0.102,BORDERB=0.122,BACKA=0.05,OPENSOUND="false",SFOFFSETH=3,BORDERG=0,BACKR=0.102}
StickyFrames~f~1!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~f~2!{STUCK="true",STUCKTOPOINT="TOPRIGHT",STUCKTO=1,STUCKPOINT="TOPLEFT"}
StickyFrames~f~3!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~d!4~5~6~
StickyFrames~f~7!{STUCK="true",STUCKTOPOINT="BOTTOMLEFT",STUCKTO=1,STUCKPOINT="TOPLEFT"}
StickyFrames~f~8!{STUCK="true",STUCKTOPOINT="TOPLEFT",STUCKTO=1,STUCKPOINT="TOPRIGHT"}
StickyFrames~f~9!{STUCK="true",STUCKTOPOINT="BOTTOMLEFT",STUCKTO=1,STUCKPOINT="BOTTOMRIGHT"}
StickyFrames~f~10!{STUCK="true",STUCKTOPOINT="TOPLEFT",STUCKTO=1,STUCKPOINT="BOTTOMLEFT"}
HealGroups~f~1!{FRAME=2,STATE="true",NAME="Main tanks"}
HealGroups~f~2!{FRAME=2,STATE="true",NAME="Healers"}
HealGroups~f~3!{FRAME=1,STATE="false",NAME="Private List"}
HealGroups~f~4!{FRAME=1,STATE="false",NAME="Self"}
HealGroups~f~5!{FRAME=1,STATE="true",NAME="Raid"}
HealGroups~f~6!{FRAME=1,STATE="false",NAME="Group"}
HealGroups~f~7!{FRAME=6,STATE="false",NAME="Vehicle"}
HealGroups~f~8!{FRAME=7,STATE="true",NAME="Pets"}
HealGroups~f~9!{FRAME=8,STATE="true",NAME="Target"}
HealGroups~f~10!{FRAME=9,STATE="true",NAME="Focus"}
HealGroups~f~11!{FRAME=10,STATE="true",NAME="Enemy"}
Anchors~f~1!{Y=58.11,GROW=2,BARS=3,FRAME=3,X=39.51}
Anchors~f~2!{Y=58.11,GROW=2,BARS=1,FRAME=1,X=39.23}
Anchors~f~3!{Y=55,GROW=2,BARS=3,FRAME=3,X=96.42}
Anchors~f~4!{Y=64.17,GROW=2,BARS=1,FRAME=1,X=83.17}
Anchors~f~5!{Y=65.23,GROW=2,BARS=2,FRAME=2,X=89.04}
Anchors~f~6!{Y=55,GROW=2,BARS=1,FRAME=1,X=55}
Anchors~f~7!{Y=31.86,GROW=2,BARS=1,FRAME=1,X=25.31}
Anchors~f~8!{Y=58.44,GROW=2,BARS=1,FRAME=3,X=25.31}
Anchors~f~9!{Y=31.19,GROW=2,BARS=1,FRAME=4,X=25.31}
Anchors~f~10!{Y=58.11,GROW=2,BARS=4,FRAME=2,X=25.42}
HeadBar~f~1!{SHOW="false",TEXTURE="Diagonal",R=0.506,B=0.506,HEIGHT=30,A=0.4,G=0.506,WIDTH=0.9}
HeadBar~f~2!{SHOW="false",TEXTURE="Diagonal",R=0.1,B=0.1,HEIGHT=30,A=0.25,G=0.1,WIDTH=0.9}
HeadBar~d!3~4~5~6~7~8~9~10~
HeadText~f~1!{A=0.7,R=0.2,OFFSET=0,B=0.8,FONT="Friz Quadrata TT",HEIGHT=10,G=0.8,OUTLINE=1}
HeadText~f~2!{A=0.7,R=1,OFFSET=0,B=0.1,FONT="Friz Quadrata TT",HEIGHT=10,G=1,OUTLINE=1}
HeadText~d!3~4~5~6~7~8~9~10~
HealBar~f~1!{HEIGHT=32,GRPCOLS="false",CMARGIN=2,TEXTURE="Smooth v2",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=122,RMARGIN=2,OFIX=1,NUMCOLS=3,LOWMANA=3}
HealBar~f~2!{HEIGHT=32,GRPCOLS="false",CMARGIN=4,TEXTURE="Smooth v2",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=2,NUMCOLS=1,OFIX=1,RMARGIN=2,WIDTH=132}
HealBar~f~3!{HEIGHT=34,GRPCOLS="false",CMARGIN=4,TEXTURE="Smooth v2",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=172,RMARGIN=0,OFIX=1,NUMCOLS=1,LOWMANA=2}
HealBar~d!4~5~6~
HealBar~f~7!{HEIGHT=34,GRPCOLS="false",CMARGIN=4,TEXTURE="Smooth v2",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=122,RMARGIN=0,OFIX=1,NUMCOLS=3,LOWMANA=1}
HealBar~f~8!{HEIGHT=34,GRPCOLS="false",CMARGIN=4,TEXTURE="Smooth v2",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=122,RMARGIN=0,OFIX=1,NUMCOLS=1,LOWMANA=2}
HealBar~d!9~
HealBar~f~10!{HEIGHT=34,GRPCOLS="false",CMARGIN=4,TEXTURE="Smooth v2",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=128,RMARGIN=0,OFIX=1,NUMCOLS=3,LOWMANA=2}
BarCol~f~1!{BACK=2,BA=0,BB=0.506,DISA=0,BR=0.506,HB=0.9,BG=0.506,HG=0.2,HA=1,HR=0.2,ORA=0.58,BOUT=0,HLTH=2}
BarCol~d!2~3~4~5~6~7~8~9~10~
BarIACol~f~1!{AC=4,AB=0.973,AA=0.25,AR=0.973,AG=0.973,IC=2,IB=0.953,IA=0.35,IR=1,IG=0.984}
BarIACol~d!2~3~4~5~6~7~8~9~10~
BarText~f~1!{HLTHONBAR="true",TAGOOR="OOR | ",OVERHEAL=1,MAXCHARS=0,HHEIGHT=14,CLASSONBAR="false",HFONT="Friz Quadrata TT",OUTLINE=1,OFFSET=2,INCHEALS=2,HLTHTXTANCHOR=1,HLTHTYPE=1,HMAXCHARS=0,CLASSTYPE=1,NUMFORMAT2=1,IGNOREONFULL="false",NUMFORMAT1=11,FONT="Friz Quadrata TT",TAGRIP="RIP | ",HEIGHT=12,NAMEONBAR="true",SHOWROLE="true",HALIGN=2,TAGDC="DC | ",HOUTLINE=1,INCABSORBS=2,HOFFSET2=0,ALIGN=2,TAGR="R | ",HOFFSET=0}
BarText~d!2~3~4~5~6~7~8~9~
BarText~f~10!{HLTHONBAR="true",TAGOOR="OOR | ",HOUTLINE=1,MAXCHARS=0,NAMEONBAR="true",CLASSONBAR="false",HOFFSET=0,OUTLINE=1,INCHEALS=2,OFFSET=2,HLTHTXTANCHOR=1,HLTHTYPE=1,HMAXCHARS=0,INCABSORBS=2,NUMFORMAT2=1,IGNOREONFULL="false",NUMFORMAT1=11,TAGDC="DC | ",TAGRIP="RIP | ",HEIGHT=12,HHEIGHT=12,SHOWROLE="true",HALIGN=2,FONT="Friz Quadrata TT",OVERHEAL=1,CLASSTYPE=1,HOFFSET2=0,ALIGN=2,TAGR="R | ",HFONT="Friz Quadrata TT"}
BarTextCol~f~1!{NCB=0.267,HCA=1,NAME=2,NCDA=0.15,HCG=0,NDEBUFF="false",HCB=1,HCR=0.761,NCR=0.949,NCG=0.843,NCA=1,HDEBUFF="false",HLTH=1,HCDA=0.1}
BarTextCol~d!2~3~4~5~6~7~
BarTextCol~f~8!{NCB=0.267,NDEBUFF="false",HCG=0,NCDA=0.72,NAME=2,NCR=0.949,HCB=1,HCR=0.761,HCA=1,NCG=0.843,NCA=1,HDEBUFF="false",HCDA=0.74,HLTH=1}
BarTextCol~f~9!{NCB=0.267,NDEBUFF="false",HCG=0,NCDA=0.72,NAME=2,NCR=0.949,HCB=1,HCR=0.761,HCA=1,NCG=0.843,NCA=1,HDEBUFF="false",HCDA=0.72,HLTH=1}
BarTextCol~f~10!{NCB=0.267,NDEBUFF="false",HCG=0,NCDA=0.15,NAME=2,NCR=0.949,HCB=1,HCR=0.761,HCA=1,NCG=0.843,NCA=1,HDEBUFF="false",HCDA=0.1,HLTH=1}
Icons~f~1!{SHOWBUFF="true",SHOWDEBUFF="true",FADESECS=15,FADE="false",I15EN="false",POSITION=2,ONBAR=1,DOUBLE="true",DSCALE=1,SHOWDIR="false",SHOWRC="true",SCALE=1,MAXDICONS=4,SHOWDIRMOUSE="false",MAXBICONS=8}
Icons~d!2~3~4~5~6~
Icons~f~7!{SHOWBUFF="true",SHOWDEBUFF="true",FADESECS=15,FADE="false",I15EN="false",POSITION=2,ONBAR=1,DOUBLE="true",DSCALE=1,SHOWDIR="false",SHOWRC="true",SCALE=1,MAXDICONS=4,SHOWDIRMOUSE="false",MAXBICONS=6}
Icons~f~8!{SHOWBUFF="true",SHOWDEBUFF="true",FADESECS=15,FADE="false",I15EN="false",POSITION=2,ONBAR=1,DOUBLE="true",DSCALE=1,SHOWDIR="false",SHOWRC="true",SCALE=1,MAXDICONS=4,SHOWDIRMOUSE="false",MAXBICONS=8}
Icons~d!9~10~
RaidIcon~f~1!{SQUARE="true",CIRCLE="true",DIAMOND="true",SHOW="true",MOON="true",TRIANGLE="true",STAR="true",SKULL="true",CROSS="true"}
RaidIcon~d!2~3~4~5~6~7~8~9~10~
IconText~f~1!{SDUR="true",HEIGHT=10,SSCNT="false",SCNT="true",DURTHRH=9,FONT="Friz Quadrata TT",DURWARN=3,SSDUR="true",OUTLINE=2}
IconText~d!2~3~4~5~6~7~8~9~10~
BarVisibility~f~1!{INCCLASSES=1,ALERTIC=0.95,ALERTOC=0.9,HIDEOOR="false"}
BarVisibility~d!2~3~4~5~6~7~
BarVisibility~f~8!{INCCLASSES=1,ALERTIC=1,ALERTOC=1,HIDEOOR="false"}
BarVisibility~d!9~
BarVisibility~f~10!{INCCLASSES=1,ALERTIC=0.95,ALERTOC=0.9,HIDEOOR="false"}
BarSort~f~1!{SUBORDER=4,OORLAST="false",RAIDORDER=2,SUBPF="true"}
BarSort~d!2~3~4~5~6~7~8~9~10~
BarAggro~f~1!{B=0.075,ALERTIND=2,G=0.173,TEXTFORMAT=3,SHOW="true",SHOWTEXTPCT="true",R=0.969,SHOWTEXT="false",SHOWIND="false",ALERT=2}
BarAggro~d!2~3~4~5~6~7~8~9~10~
AuxBarFrame~f~1!{OVERLAP=1}
AuxBarFrame~d!2~3~4~5~6~7~8~9~10~
AuxBar^1~f~1!{SIZE=1,USE=4,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,B=1,G=1,OTYPE=1}
AuxBar^1~d!2~3~4~5~6~7~8~9~10~
AuxBar^2~f~1!{SIZE=0.4,USE=9,R=0.761,COLOUR=1,ANCHOR=2,OFFSET=1,DEPTH=2,B=1,G=0,OTYPE=2}
AuxBar^2~d!2~3~4~5~6~7~8~9~
AuxBar^2~f~10!{SIZE=0.4,USE=1,R=0.761,COLOUR=1,ANCHOR=2,OFFSET=1,DEPTH=2,B=1,G=0,OTYPE=2}
AuxBar^3~f~1!{SIZE=0.4,USE=10,R=0.357,COLOUR=1,ANCHOR=2,OFFSET=-2,DEPTH=2,B=0.58,G=0.122,OTYPE=2}
AuxBar^3~d!2~3~4~5~6~7~8~9~
AuxBar^3~f~10!{SIZE=0.4,USE=1,R=0.357,COLOUR=1,ANCHOR=2,OFFSET=-2,DEPTH=2,B=0.58,G=0.122,OTYPE=2}
AuxBar^4~f~1!{SIZE=0.98,USE=6,R=1,COLOUR=1,ANCHOR=3,OFFSET=0,DEPTH=4,B=1,G=1,OTYPE=1}
AuxBar^4~d!2~3~4~5~6~7~8~9~
AuxBar^4~f~10!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=3,OFFSET=0,DEPTH=4,B=1,G=1,OTYPE=1}
AuxBar^5~f~1!{SIZE=0.98,USE=5,R=1,COLOUR=1,ANCHOR=2,OFFSET=1,DEPTH=1,B=1,G=1,OTYPE=1}
AuxBar^5~d!2~3~4~5~6~7~8~9~
AuxBar^5~f~10!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=2,OFFSET=1,DEPTH=1,B=1,G=1,OTYPE=1}
AuxBar^6~f~1!{SIZE=0.98,USE=7,R=1,COLOUR=3,ANCHOR=4,OFFSET=1,DEPTH=4,B=1,G=1,OTYPE=1}
AuxBar^6~d!2~3~4~5~6~7~8~9~
AuxBar^6~f~10!{SIZE=0.98,USE=1,R=1,COLOUR=3,ANCHOR=4,OFFSET=1,DEPTH=4,B=1,G=1,OTYPE=1}
AuxBar^7~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=4,OFFSET=1,DEPTH=3,B=1,G=1,OTYPE=2}
AuxBar^7~d!2~3~4~5~6~7~8~9~10~
AuxBar^8~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=3,ANCHOR=3,OFFSET=1,DEPTH=2,B=0.251,G=0.557,OTYPE=2}
AuxBar^8~d!2~3~4~5~6~7~8~9~10~
AuxBar^9~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,B=1,G=1,OTYPE=1}
AuxBar^9~d!2~3~4~5~6~7~8~9~10~
Complete!]]
HealBot_ExtraSkinData[36]=[[Skin
Clarity Raid 40
Author~v!Monti of Terenas
DuplicateBars~v!false
Chat~t!{EOCOOM="false",EOCOOMV=5,MSG="Casting #s on #n",RESONLY="true",CHAN="",NOTIFY=1}
General~t!{OFREQ=0.07,OMIN=0.1,OMAX=0.95,FLUIDFREQ=10,HIDEPARTYF="false",HIDEPTF="false",HIDERAIDF="true",STICKYSENSITIVITY=20,STICKYFRAME="true",FLUIDBARS="false",HIDEBOSSF="true"}
Healing~t!{TINCSELF="false",GROUPPETS="true",TARGETINCOMBAT=1,FALWAYSSHOW="false",FONLYFRIEND="true",TINCPET="false",TONLYFRIEND="false",TINCGROUP="true",FOCUSINCOMBAT=2,TALWAYSSHOW="false",FEXRAID="false",TINCRAID="true",TEXRAID="false",SELFPET=0}
Enemy~t!{ENEMYTARGET="true",INCTANKS="true",INCMYTAR="false",INCARENA="false",ENEMYTARGETSIZE=58,INCARENAPETS="false",INCSELF="false",NUMBOSS=1,EXISTSHOWPTAR=1,HIDE="true",EXISTSHOWBOSS="true",DOUBLEWIDTH="false",EXISTSHOWARENA=2}
FrameAlias~f~1!{SIZE=12,NAME="Party",R=1,ALIAS="Raid",G=1,SHOW="false",OFFSET=1,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~2!{SIZE=12,NAME="Tank and Healer",R=1,ALIAS="Tank and Healer",G=1,SHOW="false",OFFSET=1,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~3!{SIZE=12,NAME="Pets",R=1,ALIAS="Not Used 1",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~4!{SIZE=12,NAME="Focus and Target",R=1,ALIAS="Not Used 2",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~5!{SIZE=12,NAME="Enemy",R=1,ALIAS="Not Used 3",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~6!{SIZE=12,NAME="",R=1,ALIAS="Vehicle",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~7!{SIZE=12,NAME="Pets",R=1,ALIAS="Pets",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~8!{SIZE=12,NAME="Target",R=1,ALIAS="Target",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~9!{SIZE=12,NAME="",R=1,ALIAS="Focus",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~10!{SIZE=12,NAME="Enemy",R=1,ALIAS="Enemy",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAliasBar~f~1!{A=0.23,WIDTH=0.94,B=0,HEIGHT=20,R=0.004,G=0,TEXTURE="Flat"}
FrameAliasBar~d!2~3~4~5~6~7~8~9~10~
Frame~f~1!{BORDERR=0.318,BACKR=0.506,SFOFFSETV=0,SFOFFSETH=0,LOCKED="false",OPENSOUND="false",BORDERA=0,BORDERG=0.757,AUTOCLOSE="false",BORDERB=1,BACKA=0,SCALE=1,BACKB=0.506,TIPLOC=2,BACKG=0.506}
Frame~f~2!{BORDERR=0.102,BACKR=0.102,SFOFFSETV=0,SFOFFSETH=-8,LOCKED="true",OPENSOUND="false",BORDERA=0,BORDERG=0.102,AUTOCLOSE="false",BORDERB=0.102,BACKA=0,SCALE=1,BACKB=0.502,TIPLOC=1,BACKG=0.102}
Frame~f~3!{BORDERR=0.1,BACKR=0.1,SFOFFSETV=0,SFOFFSETH=0,LOCKED="false",OPENSOUND="false",BORDERA=0.5,BORDERG=0.1,AUTOCLOSE="false",BORDERB=0.1,BACKA=0.2,SCALE=1,BACKB=0.5,TIPLOC=2,BACKG=0.1}
Frame~d!4~
Frame~f~5!{BORDERR=0.1,BACKR=0.1,SFOFFSETV=0,SFOFFSETH=0,LOCKED="false",OPENSOUND="false",BORDERA=0.5,BORDERG=0.1,AUTOCLOSE="false",BORDERB=0.1,BACKA=0.2,SCALE=1,BACKB=0.5,TIPLOC=4,BACKG=0.1}
Frame~f~6!{BORDERR=0.1,BACKR=0.1,SFOFFSETV=0,SFOFFSETH=0,LOCKED="false",OPENSOUND="false",BORDERA=0.5,BORDERG=0.1,AUTOCLOSE="false",BORDERB=0.1,BACKA=0.2,SCALE=1,BACKB=0.5,TIPLOC=5,BACKG=0.1}
Frame~f~7!{BORDERR=0.102,BACKG=0.102,TIPLOC=5,BACKB=0.502,LOCKED="true",SCALE=1,BORDERA=0.01,SFOFFSETV=8,AUTOCLOSE="false",BORDERB=0.102,BACKA=0.01,OPENSOUND="false",BACKR=0.102,BORDERG=0.102,SFOFFSETH=0}
Frame~f~8!{BORDERR=0.102,BACKG=0.102,TIPLOC=5,BACKB=0.502,LOCKED="false",SCALE=1,BORDERA=0,SFOFFSETV=0,AUTOCLOSE="false",BORDERB=0.102,BACKA=0,OPENSOUND="false",BACKR=0.102,BORDERG=0.102,SFOFFSETH=5}
Frame~f~9!{BORDERR=0.1,BACKG=0.1,TIPLOC=5,BACKB=0.5,LOCKED="false",SCALE=1,BORDERA=0.5,SFOFFSETV=0,AUTOCLOSE="false",BORDERB=0.1,BACKA=0.2,OPENSOUND="false",BACKR=0.1,BORDERG=0.1,SFOFFSETH=5}
Frame~f~10!{BORDERR=0.706,BACKR=0.102,SFOFFSETV=0,SFOFFSETH=3,LOCKED="true",OPENSOUND="false",BORDERA=0,BORDERG=0,AUTOCLOSE="false",BORDERB=0.122,BACKA=0.05,SCALE=1,BACKB=0.502,TIPLOC=4,BACKG=0.102}
StickyFrames~f~1!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~f~2!{STUCK="true",STUCKTOPOINT="TOPRIGHT",STUCKTO=1,STUCKPOINT="TOPLEFT"}
StickyFrames~f~3!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~d!4~5~6~
StickyFrames~f~7!{STUCK="true",STUCKTOPOINT="BOTTOMLEFT",STUCKTO=1,STUCKPOINT="TOPLEFT"}
StickyFrames~f~8!{STUCK="true",STUCKTOPOINT="TOPLEFT",STUCKTO=1,STUCKPOINT="TOPRIGHT"}
StickyFrames~f~9!{STUCK="true",STUCKTOPOINT="BOTTOMLEFT",STUCKTO=1,STUCKPOINT="BOTTOMRIGHT"}
StickyFrames~f~10!{STUCK="true",STUCKTOPOINT="TOPLEFT",STUCKTO=1,STUCKPOINT="BOTTOMLEFT"}
HealGroups~f~1!{FRAME=2,STATE="true",NAME="Main tanks"}
HealGroups~f~2!{FRAME=2,STATE="true",NAME="Healers"}
HealGroups~f~3!{FRAME=1,STATE="false",NAME="Private List"}
HealGroups~f~4!{FRAME=1,STATE="false",NAME="Self"}
HealGroups~f~5!{FRAME=1,STATE="true",NAME="Raid"}
HealGroups~f~6!{FRAME=1,STATE="false",NAME="Group"}
HealGroups~f~7!{FRAME=6,STATE="false",NAME="Vehicle"}
HealGroups~f~8!{FRAME=7,STATE="true",NAME="Pets"}
HealGroups~f~9!{FRAME=8,STATE="true",NAME="Target"}
HealGroups~f~10!{FRAME=9,STATE="true",NAME="Focus"}
HealGroups~f~11!{FRAME=10,STATE="true",NAME="Enemy"}
Anchors~f~1!{Y=66.58,GROW=2,BARS=3,FRAME=3,X=41.6}
Anchors~f~2!{Y=66.58,GROW=2,BARS=1,FRAME=1,X=41.32}
Anchors~f~3!{Y=55,GROW=2,BARS=3,FRAME=3,X=96.42}
Anchors~f~4!{Y=64.17,GROW=2,BARS=1,FRAME=1,X=83.17}
Anchors~f~5!{Y=65.23,GROW=2,BARS=2,FRAME=2,X=89.04}
Anchors~f~6!{Y=55,GROW=2,BARS=1,FRAME=1,X=55}
Anchors~f~7!{Y=24.5,GROW=2,BARS=1,FRAME=1,X=29.5}
Anchors~f~8!{Y=66.58,GROW=2,BARS=1,FRAME=3,X=29.67}
Anchors~f~9!{Y=23.83,GROW=2,BARS=1,FRAME=4,X=29.67}
Anchors~f~10!{Y=66.58,GROW=2,BARS=4,FRAME=2,X=29.6}
HeadBar~f~1!{SHOW="false",WIDTH=0.9,B=0.506,R=0.506,HEIGHT=30,A=0.4,G=0.506,TEXTURE="Diagonal"}
HeadBar~f~2!{SHOW="false",WIDTH=0.9,B=0.1,R=0.1,HEIGHT=30,A=0.25,G=0.1,TEXTURE="Diagonal"}
HeadBar~d!3~4~5~6~7~8~9~10~
HeadText~f~1!{A=0.7,B=0.8,OFFSET=0,R=0.2,FONT="Friz Quadrata TT",HEIGHT=10,G=0.8,OUTLINE=1}
HeadText~f~2!{A=0.7,B=0.1,OFFSET=0,R=1,FONT="Friz Quadrata TT",HEIGHT=10,G=1,OUTLINE=1}
HeadText~d!3~4~5~6~7~8~9~10~
HealBar~f~1!{HEIGHT=30,GRPCOLS="false",CMARGIN=2,TEXTURE="Smooth v2",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=3,NUMCOLS=3,OFIX=1,RMARGIN=1,WIDTH=102}
HealBar~f~2!{HEIGHT=30,GRPCOLS="false",CMARGIN=4,TEXTURE="Smooth v2",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=112,RMARGIN=1,OFIX=1,NUMCOLS=1,LOWMANA=2}
HealBar~f~3!{HEIGHT=34,GRPCOLS="false",CMARGIN=4,TEXTURE="Smooth v2",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=2,NUMCOLS=1,OFIX=1,RMARGIN=0,WIDTH=172}
HealBar~d!4~5~6~
HealBar~f~7!{HEIGHT=25,GRPCOLS="false",CMARGIN=4,TEXTURE="Smooth v2",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=1,NUMCOLS=3,OFIX=1,RMARGIN=0,WIDTH=100}
HealBar~f~8!{HEIGHT=30,GRPCOLS="false",CMARGIN=4,TEXTURE="Smooth v2",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=2,NUMCOLS=1,OFIX=1,RMARGIN=0,WIDTH=102}
HealBar~d!9~
HealBar~f~10!{HEIGHT=30,GRPCOLS="false",CMARGIN=4,TEXTURE="Smooth v2",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=2,NUMCOLS=3,OFIX=1,RMARGIN=0,WIDTH=108}
BarCol~f~1!{BACK=2,BA=0,BB=0.506,DISA=0,BR=0.506,HB=0.9,BG=0.506,BOUT=0,HA=1,HR=0.2,ORA=0.58,HG=0.2,HLTH=2}
BarCol~d!2~3~4~5~6~7~8~9~10~
BarIACol~f~1!{AC=4,AB=0.973,AA=0.25,AR=0.973,AG=0.973,IC=2,IB=0.953,IA=0.35,IR=1,IG=0.984}
BarIACol~d!2~3~4~5~6~7~8~9~10~
BarText~f~1!{HLTHONBAR="true",TAGOOR="OOR | ",IGNOREONFULL="false",MAXCHARS=0,NAMEONBAR="true",HMAXCHARS=0,HOFFSET=0,OUTLINE=1,OFFSET=2,INCHEALS=2,HLTHTXTANCHOR=1,HLTHTYPE=1,CLASSONBAR="false",INCABSORBS=2,NUMFORMAT2=1,HOUTLINE=1,NUMFORMAT1=11,TAGDC="DC | ",TAGRIP="RIP | ",HEIGHT=12,HHEIGHT=14,SHOWROLE="true",HALIGN=2,FONT="Friz Quadrata TT",OVERHEAL=1,CLASSTYPE=1,HOFFSET2=0,ALIGN=2,TAGR="R | ",HFONT="Friz Quadrata TT"}
BarText~d!2~3~4~5~6~7~8~9~
BarText~f~10!{HLTHONBAR="true",TAGOOR="OOR | ",IGNOREONFULL="false",MAXCHARS=0,HHEIGHT=12,HMAXCHARS=0,HFONT="Friz Quadrata TT",OUTLINE=1,INCHEALS=2,OFFSET=2,HLTHTXTANCHOR=1,HLTHTYPE=1,CLASSONBAR="false",CLASSTYPE=1,NUMFORMAT2=1,OVERHEAL=1,NUMFORMAT1=11,FONT="Friz Quadrata TT",TAGRIP="RIP | ",HEIGHT=12,NAMEONBAR="true",SHOWROLE="true",HALIGN=2,TAGDC="DC | ",HOUTLINE=1,INCABSORBS=2,HOFFSET2=0,ALIGN=2,TAGR="R | ",HOFFSET=0}
BarTextCol~f~1!{HCG=0,NDEBUFF="false",NCB=0.267,NCDA=0.15,NAME=2,HCA=1,HCB=1,HCR=0.761,NCR=0.949,NCG=0.843,NCA=1,HDEBUFF="false",HCDA=0.1,HLTH=1}
BarTextCol~d!2~3~4~5~6~7~
BarTextCol~f~8!{NAME=2,NCR=0.949,NCB=0.267,NCDA=0.72,HCG=0,NDEBUFF="false",HCB=1,HCR=0.761,HCA=1,NCG=0.843,NCA=1,HDEBUFF="false",HLTH=1,HCDA=0.74}
BarTextCol~f~9!{NAME=2,NCR=0.949,NCB=0.267,NCDA=0.72,HCG=0,NDEBUFF="false",HCB=1,HCR=0.761,HCA=1,NCG=0.843,NCA=1,HDEBUFF="false",HLTH=1,HCDA=0.72}
BarTextCol~f~10!{NAME=2,NCR=0.949,NCB=0.267,NCDA=0.15,HCG=0,NDEBUFF="false",HCB=1,HCR=0.761,HCA=1,NCG=0.843,NCA=1,HDEBUFF="false",HLTH=1,HCDA=0.1}
Icons~f~1!{SHOWBUFF="true",POSITION=2,I15EN="false",FADESECS=15,DOUBLE="true",MAXDICONS=4,SHOWDIR="false",FADE="false",DSCALE=1,ONBAR=1,SHOWRC="true",SCALE=1,SHOWDIRMOUSE="false",SHOWDEBUFF="true",MAXBICONS=8}
Icons~d!2~3~4~5~6~
Icons~f~7!{SHOWBUFF="true",POSITION=2,I15EN="false",FADESECS=15,DOUBLE="true",MAXDICONS=4,SHOWDIR="false",FADE="false",DSCALE=1,ONBAR=1,SHOWRC="true",SCALE=1,SHOWDIRMOUSE="false",SHOWDEBUFF="true",MAXBICONS=6}
Icons~f~8!{SHOWBUFF="true",POSITION=2,I15EN="false",FADESECS=15,DOUBLE="true",MAXDICONS=4,SHOWDIR="false",FADE="false",DSCALE=1,ONBAR=1,SHOWRC="true",SCALE=1,SHOWDIRMOUSE="false",SHOWDEBUFF="true",MAXBICONS=8}
Icons~d!9~10~
RaidIcon~f~1!{SQUARE="true",CIRCLE="true",DIAMOND="true",SHOW="true",SKULL="true",TRIANGLE="true",STAR="true",CROSS="true",MOON="true"}
RaidIcon~d!2~3~4~5~6~7~8~9~10~
IconText~f~1!{DURWARN=3,HEIGHT=10,SSCNT="false",SCNT="true",DURTHRH=9,FONT="Friz Quadrata TT",SDUR="true",SSDUR="true",OUTLINE=2}
IconText~d!2~3~4~5~6~7~8~9~10~
BarVisibility~f~1!{INCCLASSES=1,ALERTIC=0.95,ALERTOC=0.9,HIDEOOR="false"}
BarVisibility~d!2~3~4~5~6~7~
BarVisibility~f~8!{INCCLASSES=1,ALERTIC=1,ALERTOC=1,HIDEOOR="false"}
BarVisibility~d!9~
BarVisibility~f~10!{INCCLASSES=1,ALERTIC=0.95,ALERTOC=0.9,HIDEOOR="false"}
BarSort~f~1!{SUBORDER=4,OORLAST="false",RAIDORDER=2,SUBPF="true"}
BarSort~d!2~3~4~5~6~7~8~9~10~
BarAggro~f~1!{B=0.075,ALERTIND=2,G=0.173,TEXTFORMAT=3,SHOW="true",SHOWTEXTPCT="true",SHOWIND="false",SHOWTEXT="false",R=0.969,ALERT=2}
BarAggro~d!2~3~4~5~6~7~8~9~10~
AuxBarFrame~f~1!{OVERLAP=1}
AuxBarFrame~d!2~3~4~5~6~7~8~9~10~
AuxBar^1~f~1!{SIZE=1,USE=4,B=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,OTYPE=1,G=1,R=1}
AuxBar^1~d!2~3~4~5~6~7~8~9~10~
AuxBar^2~f~1!{SIZE=0.4,USE=9,B=1,COLOUR=1,ANCHOR=2,OFFSET=1,DEPTH=2,OTYPE=2,G=0,R=0.761}
AuxBar^2~d!2~3~4~5~6~7~8~9~
AuxBar^2~f~10!{SIZE=0.4,USE=1,B=1,COLOUR=1,ANCHOR=2,OFFSET=1,DEPTH=2,OTYPE=2,G=0,R=0.761}
AuxBar^3~f~1!{SIZE=0.4,USE=10,B=0.58,COLOUR=1,ANCHOR=2,OFFSET=-2,DEPTH=2,OTYPE=2,G=0.122,R=0.357}
AuxBar^3~d!2~3~4~5~6~7~8~9~
AuxBar^3~f~10!{SIZE=0.4,USE=1,B=0.58,COLOUR=1,ANCHOR=2,OFFSET=-2,DEPTH=2,OTYPE=2,G=0.122,R=0.357}
AuxBar^4~f~1!{SIZE=0.98,USE=6,B=1,COLOUR=1,ANCHOR=3,OFFSET=0,DEPTH=4,OTYPE=1,G=1,R=1}
AuxBar^4~d!2~3~4~5~6~7~8~9~
AuxBar^4~f~10!{SIZE=0.98,USE=1,B=1,COLOUR=1,ANCHOR=3,OFFSET=0,DEPTH=4,OTYPE=1,G=1,R=1}
AuxBar^5~f~1!{SIZE=0.98,USE=5,B=1,COLOUR=1,ANCHOR=2,OFFSET=1,DEPTH=1,OTYPE=1,G=1,R=1}
AuxBar^5~d!2~3~4~5~6~7~8~9~
AuxBar^5~f~10!{SIZE=0.98,USE=1,B=1,COLOUR=1,ANCHOR=2,OFFSET=1,DEPTH=1,OTYPE=1,G=1,R=1}
AuxBar^6~f~1!{SIZE=0.98,USE=7,B=1,COLOUR=3,ANCHOR=4,OFFSET=1,DEPTH=4,OTYPE=1,G=1,R=1}
AuxBar^6~d!2~3~4~5~6~7~8~9~
AuxBar^6~f~10!{SIZE=0.98,USE=1,B=1,COLOUR=3,ANCHOR=4,OFFSET=1,DEPTH=4,OTYPE=1,G=1,R=1}
AuxBar^7~f~1!{SIZE=0.98,USE=1,B=1,COLOUR=1,ANCHOR=4,OFFSET=1,DEPTH=3,OTYPE=2,G=1,R=1}
AuxBar^7~d!2~3~4~5~6~7~8~9~10~
AuxBar^8~f~1!{SIZE=0.98,USE=1,B=0.251,COLOUR=3,ANCHOR=3,OFFSET=1,DEPTH=2,OTYPE=2,G=0.557,R=1}
AuxBar^8~d!2~3~4~5~6~7~8~9~10~
AuxBar^9~f~1!{SIZE=0.98,USE=1,B=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,OTYPE=1,G=1,R=1}
AuxBar^9~d!2~3~4~5~6~7~8~9~10~
Complete!]]
HealBot_ExtraSkinData[37]=[[Skin
Compact Raid 40
Author~v!Monti of Terenas
DuplicateBars~v!false
Chat~t!{EOCOOM="false",EOCOOMV=5,MSG="Casting #s on #n",RESONLY="true",CHAN="",NOTIFY=1}
General~t!{OFREQ=0.07,OMIN=0.1,OMAX=0.95,FLUIDFREQ=10,HIDEPTF="false",HIDEPARTYF="false",STICKYFRAME="true",HIDERAIDF="true",STICKYSENSITIVITY=20,FLUIDBARS="false",HIDEBOSSF="true"}
Healing~t!{TINCSELF="false",GROUPPETS="true",TARGETINCOMBAT=1,FALWAYSSHOW="false",FONLYFRIEND="true",TINCPET="false",TONLYFRIEND="false",TINCGROUP="true",FOCUSINCOMBAT=2,TALWAYSSHOW="false",SELFPET=0,TINCRAID="true",TEXRAID="false",FEXRAID="false"}
Enemy~t!{INCARENA="false",INCTANKS="true",INCMYTAR="false",ENEMYTARGET="true",INCARENAPETS="false",ENEMYTARGETSIZE=58,INCSELF="false",NUMBOSS=1,EXISTSHOWPTAR=1,HIDE="true",EXISTSHOWBOSS="true",DOUBLEWIDTH="false",EXISTSHOWARENA=2}
FrameAlias~f~1!{SIZE=12,NAME="Party",R=1,ALIAS="Raid",G=1,SHOW="false",OFFSET=1,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~2!{SIZE=12,NAME="Tank and Healer",R=1,ALIAS="Tank and Healer",G=1,SHOW="false",OFFSET=1,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~3!{SIZE=12,NAME="Pets",R=1,ALIAS="Not Used 1",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~4!{SIZE=12,NAME="Focus and Target",R=1,ALIAS="Not Used 2",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~5!{SIZE=12,NAME="Enemy",R=1,ALIAS="Not Used 3",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~6!{SIZE=12,NAME="",R=1,ALIAS="Vehicle",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~7!{SIZE=12,NAME="Pets",R=1,ALIAS="Pets",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~8!{SIZE=12,NAME="Target",R=1,ALIAS="Target",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~9!{SIZE=12,NAME="",R=1,ALIAS="Focus",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~10!{SIZE=12,NAME="Enemy",R=1,ALIAS="Enemy",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAliasBar~f~1!{A=0.23,WIDTH=0.94,B=0,HEIGHT=20,R=0.004,G=0,TEXTURE="Flat"}
FrameAliasBar~d!2~3~4~5~6~7~8~9~10~
Frame~f~1!{SFOFFSETH=0,BACKR=0.506,BORDERG=0.757,BORDERR=0.318,LOCKED="false",OPENSOUND="false",BORDERA=0,SFOFFSETV=0,BACKG=0.506,BACKB=0.506,BACKA=0,SCALE=1,BORDERB=1,AUTOCLOSE="false",TIPLOC=2}
Frame~f~2!{SFOFFSETH=-8,BACKR=0.102,BORDERG=0.102,BORDERR=0.102,LOCKED="true",OPENSOUND="false",BORDERA=0,SFOFFSETV=0,BACKG=0.102,BACKB=0.502,BACKA=0,SCALE=1,BORDERB=0.102,AUTOCLOSE="false",TIPLOC=1}
Frame~f~3!{SFOFFSETH=0,BACKR=0.1,BORDERG=0.1,BORDERR=0.1,LOCKED="false",OPENSOUND="false",BORDERA=0.5,SFOFFSETV=0,BACKG=0.1,BACKB=0.5,BACKA=0.2,SCALE=1,BORDERB=0.1,AUTOCLOSE="false",TIPLOC=2}
Frame~d!4~
Frame~f~5!{SFOFFSETH=0,BACKR=0.1,BORDERG=0.1,BORDERR=0.1,LOCKED="false",OPENSOUND="false",BORDERA=0.5,SFOFFSETV=0,BACKG=0.1,BACKB=0.5,BACKA=0.2,SCALE=1,BORDERB=0.1,AUTOCLOSE="false",TIPLOC=4}
Frame~f~6!{SFOFFSETH=0,BACKR=0.1,BORDERG=0.1,BORDERR=0.1,LOCKED="false",OPENSOUND="false",BORDERA=0.5,SFOFFSETV=0,BACKG=0.1,BACKB=0.5,BACKA=0.2,SCALE=1,BORDERB=0.1,AUTOCLOSE="false",TIPLOC=5}
Frame~f~7!{BORDERR=0.102,TIPLOC=5,AUTOCLOSE="false",BORDERB=0.102,LOCKED="true",SCALE=1,BORDERA=0.01,BORDERG=0.102,BACKG=0.102,BACKB=0.502,BACKA=0.01,OPENSOUND="false",BACKR=0.102,SFOFFSETV=8,SFOFFSETH=0}
Frame~f~8!{BORDERR=0.102,TIPLOC=5,AUTOCLOSE="false",BORDERB=0.102,LOCKED="false",SCALE=1,BORDERA=0,BORDERG=0.102,BACKG=0.102,BACKB=0.502,BACKA=0,OPENSOUND="false",BACKR=0.102,SFOFFSETV=0,SFOFFSETH=5}
Frame~f~9!{BORDERR=0.1,TIPLOC=5,AUTOCLOSE="false",BORDERB=0.1,LOCKED="false",SCALE=1,BORDERA=0.5,BORDERG=0.1,BACKG=0.1,BACKB=0.5,BACKA=0.2,OPENSOUND="false",BACKR=0.1,SFOFFSETV=0,SFOFFSETH=5}
Frame~f~10!{SFOFFSETH=3,BACKR=0.102,BORDERG=0,BORDERR=0.706,LOCKED="true",OPENSOUND="false",BORDERA=0,SFOFFSETV=-4,BACKG=0.102,BACKB=0.502,BACKA=0.05,SCALE=1,BORDERB=0.122,AUTOCLOSE="false",TIPLOC=4}
StickyFrames~f~1!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~f~2!{STUCK="true",STUCKTOPOINT="TOPRIGHT",STUCKTO=1,STUCKPOINT="TOPLEFT"}
StickyFrames~f~3!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~d!4~5~6~
StickyFrames~f~7!{STUCK="true",STUCKTOPOINT="BOTTOMLEFT",STUCKTO=1,STUCKPOINT="TOPLEFT"}
StickyFrames~f~8!{STUCK="true",STUCKTOPOINT="TOPLEFT",STUCKTO=1,STUCKPOINT="TOPRIGHT"}
StickyFrames~f~9!{STUCK="true",STUCKTOPOINT="BOTTOMLEFT",STUCKTO=1,STUCKPOINT="BOTTOMRIGHT"}
StickyFrames~f~10!{STUCK="true",STUCKTOPOINT="TOPLEFT",STUCKTO=1,STUCKPOINT="BOTTOMLEFT"}
HealGroups~f~1!{FRAME=1,STATE="true",NAME="Main tanks"}
HealGroups~f~2!{FRAME=1,STATE="true",NAME="Healers"}
HealGroups~f~3!{FRAME=1,STATE="false",NAME="Private List"}
HealGroups~f~4!{FRAME=1,STATE="false",NAME="Self"}
HealGroups~f~5!{FRAME=1,STATE="true",NAME="Raid"}
HealGroups~f~6!{FRAME=1,STATE="false",NAME="Group"}
HealGroups~f~7!{FRAME=6,STATE="false",NAME="Vehicle"}
HealGroups~f~8!{FRAME=7,STATE="true",NAME="Pets"}
HealGroups~f~9!{FRAME=8,STATE="true",NAME="Target"}
HealGroups~f~10!{FRAME=9,STATE="true",NAME="Focus"}
HealGroups~f~11!{FRAME=10,STATE="true",NAME="Enemy"}
Anchors~f~1!{Y=62.69,GROW=2,BARS=3,FRAME=3,X=44.62}
Anchors~f~2!{Y=62.69,GROW=2,BARS=1,FRAME=1,X=44.34}
Anchors~f~3!{Y=55,GROW=2,BARS=3,FRAME=3,X=96.42}
Anchors~f~4!{Y=64.17,GROW=2,BARS=1,FRAME=1,X=83.17}
Anchors~f~5!{Y=65.23,GROW=2,BARS=2,FRAME=2,X=89.04}
Anchors~f~6!{Y=55,GROW=2,BARS=1,FRAME=1,X=55}
Anchors~f~7!{Y=34.27,GROW=2,BARS=1,FRAME=1,X=34.02}
Anchors~f~8!{Y=62.69,GROW=2,BARS=1,FRAME=3,X=34.19}
Anchors~f~9!{Y=33.61,GROW=2,BARS=1,FRAME=4,X=34.19}
Anchors~f~10!{Y=62.36,GROW=2,BARS=4,FRAME=2,X=34.12}
HeadBar~f~1!{SHOW="false",WIDTH=0.9,B=0.506,R=0.506,HEIGHT=30,A=0.4,G=0.506,TEXTURE="Diagonal"}
HeadBar~f~2!{SHOW="false",WIDTH=0.9,B=0.1,R=0.1,HEIGHT=30,A=0.25,G=0.1,TEXTURE="Diagonal"}
HeadBar~d!3~4~5~6~7~8~9~10~
HeadText~f~1!{A=0.7,B=0.8,OFFSET=0,R=0.2,FONT="Friz Quadrata TT",HEIGHT=10,G=0.8,OUTLINE=1}
HeadText~f~2!{A=0.7,B=0.1,OFFSET=0,R=1,FONT="Friz Quadrata TT",HEIGHT=10,G=1,OUTLINE=1}
HeadText~d!3~4~5~6~7~8~9~10~
HealBar~f~1!{HEIGHT=25,GRPCOLS="false",CMARGIN=2,TEXTURE="Smooth v2",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=3,NUMCOLS=4,OFIX=1,RMARGIN=1,WIDTH=72}
HealBar~f~2!{HEIGHT=30,GRPCOLS="false",CMARGIN=2,TEXTURE="Smooth v2",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=112,RMARGIN=1,OFIX=1,NUMCOLS=1,LOWMANA=2}
HealBar~f~3!{HEIGHT=34,GRPCOLS="false",CMARGIN=4,TEXTURE="Smooth v2",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=2,NUMCOLS=1,OFIX=1,RMARGIN=0,WIDTH=172}
HealBar~d!4~5~6~
HealBar~f~7!{HEIGHT=20,GRPCOLS="false",CMARGIN=4,TEXTURE="Smooth v2",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=1,NUMCOLS=4,OFIX=1,RMARGIN=0,WIDTH=70}
HealBar~f~8!{HEIGHT=25,GRPCOLS="false",CMARGIN=4,TEXTURE="Smooth v2",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=2,NUMCOLS=1,OFIX=1,RMARGIN=0,WIDTH=72}
HealBar~d!9~
HealBar~f~10!{HEIGHT=25,GRPCOLS="false",CMARGIN=4,TEXTURE="Smooth v2",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=2,NUMCOLS=4,OFIX=1,RMARGIN=0,WIDTH=70}
BarCol~f~1!{BACK=2,BA=0,BOUT=0,DISA=0.1,BR=0.506,HB=0.9,BG=0.506,BB=0.506,HA=1,HG=0.2,ORA=0.58,HR=0.2,HLTH=2}
BarCol~d!2~3~4~5~6~7~8~9~10~
BarIACol~f~1!{AC=4,AB=0.973,AA=0.35,AR=0.973,AG=0.973,IC=2,IB=0.953,IA=0.4,IR=1,IG=0.984}
BarIACol~d!2~3~4~5~6~7~8~9~10~
BarText~f~1!{HLTHONBAR="false",TAGOOR="OOR | ",IGNOREONFULL="false",MAXCHARS=0,NAMEONBAR="true",CLASSONBAR="false",HOFFSET=0,OUTLINE=1,INCHEALS=2,OFFSET=0,HLTHTXTANCHOR=1,HLTHTYPE=1,HMAXCHARS=0,INCABSORBS=2,NUMFORMAT2=1,OVERHEAL=1,NUMFORMAT1=11,TAGDC="DC | ",TAGRIP="RIP | ",HEIGHT=12,HHEIGHT=12,SHOWROLE="true",HALIGN=2,FONT="Friz Quadrata TT",HOUTLINE=1,CLASSTYPE=1,HOFFSET2=0,ALIGN=2,TAGR="R | ",HFONT="Friz Quadrata TT"}
BarText~d!2~3~4~5~6~7~8~9~10~
BarTextCol~f~1!{NAME=2,NDEBUFF="false",HCG=0,NCDA=0.15,NCB=0.267,HCA=1,HCB=1,HCR=0.761,NCR=0.949,NCG=0.843,NCA=1,HDEBUFF="false",HCDA=0.1,HLTH=1}
BarTextCol~d!2~3~4~5~6~7~8~9~10~
Icons~f~1!{SHOWBUFF="true",POSITION=2,MAXDICONS=4,DOUBLE="true",SHOWDIRMOUSE="false",FADESECS=15,SHOWDIR="false",FADE="false",DSCALE=1,ONBAR=1,SHOWRC="true",SCALE=1,SHOWDEBUFF="true",I15EN="false",MAXBICONS=8}
Icons~d!2~3~4~5~6~
Icons~f~7!{SHOWBUFF="true",POSITION=2,MAXDICONS=4,DOUBLE="true",SHOWDIRMOUSE="false",FADESECS=15,SHOWDIR="false",FADE="false",DSCALE=1,ONBAR=1,SHOWRC="true",SCALE=1,SHOWDEBUFF="true",I15EN="false",MAXBICONS=6}
Icons~f~8!{SHOWBUFF="true",POSITION=2,MAXDICONS=4,DOUBLE="true",SHOWDIRMOUSE="false",FADESECS=15,SHOWDIR="false",FADE="false",DSCALE=1,ONBAR=1,SHOWRC="true",SCALE=1,SHOWDEBUFF="true",I15EN="false",MAXBICONS=8}
Icons~d!9~10~
RaidIcon~f~1!{SQUARE="true",CIRCLE="true",DIAMOND="true",SHOW="true",SKULL="true",TRIANGLE="true",STAR="true",CROSS="true",MOON="true"}
RaidIcon~d!2~3~4~5~6~7~8~9~10~
IconText~f~1!{SDUR="true",HEIGHT=10,SSCNT="false",SCNT="true",DURTHRH=9,FONT="Friz Quadrata TT",DURWARN=3,SSDUR="true",OUTLINE=2}
IconText~d!2~3~4~5~6~7~8~9~10~
BarVisibility~f~1!{INCCLASSES=1,ALERTIC=0.98,ALERTOC=0.95,HIDEOOR="false"}
BarVisibility~f~2!{INCCLASSES=1,ALERTIC=0.99,ALERTOC=0.97,HIDEOOR="false"}
BarVisibility~f~3!{INCCLASSES=1,ALERTIC=0.95,ALERTOC=0.9,HIDEOOR="false"}
BarVisibility~d!4~5~6~7~
BarVisibility~f~8!{INCCLASSES=1,ALERTIC=1,ALERTOC=1,HIDEOOR="false"}
BarVisibility~d!9~
BarVisibility~f~10!{INCCLASSES=1,ALERTIC=0.95,ALERTOC=0.9,HIDEOOR="false"}
BarSort~f~1!{SUBORDER=4,OORLAST="false",RAIDORDER=2,SUBPF="true"}
BarSort~d!2~3~4~5~6~7~8~9~10~
BarAggro~f~1!{B=0.075,ALERTIND=2,G=0.173,TEXTFORMAT=3,SHOW="true",SHOWTEXTPCT="true",SHOWIND="false",SHOWTEXT="false",R=0.969,ALERT=2}
BarAggro~d!2~3~4~5~6~7~8~9~10~
AuxBarFrame~f~1!{OVERLAP=1}
AuxBarFrame~d!2~3~4~5~6~7~8~9~10~
AuxBar^1~f~1!{SIZE=1,USE=4,B=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=3,OTYPE=1,G=1,R=1}
AuxBar^1~d!2~3~4~5~6~7~8~9~10~
AuxBar^2~f~1!{SIZE=0.4,USE=9,B=1,COLOUR=1,ANCHOR=2,OFFSET=1,DEPTH=2,OTYPE=2,G=0,R=0.761}
AuxBar^2~d!2~3~4~5~6~7~8~9~
AuxBar^2~f~10!{SIZE=0.4,USE=1,B=1,COLOUR=1,ANCHOR=2,OFFSET=1,DEPTH=2,OTYPE=2,G=0,R=0.761}
AuxBar^3~f~1!{SIZE=0.4,USE=10,B=0.58,COLOUR=1,ANCHOR=2,OFFSET=-2,DEPTH=2,OTYPE=2,G=0.122,R=0.357}
AuxBar^3~d!2~3~4~5~6~7~8~9~
AuxBar^3~f~10!{SIZE=0.4,USE=1,B=0.58,COLOUR=1,ANCHOR=2,OFFSET=-2,DEPTH=2,OTYPE=2,G=0.122,R=0.357}
AuxBar^4~f~1!{SIZE=0.98,USE=1,B=1,COLOUR=1,ANCHOR=3,OFFSET=0,DEPTH=4,OTYPE=1,G=1,R=1}
AuxBar^4~d!2~3~4~5~6~7~8~9~10~
AuxBar^5~f~1!{SIZE=0.98,USE=5,B=1,COLOUR=1,ANCHOR=2,OFFSET=0,DEPTH=1,OTYPE=1,G=1,R=1}
AuxBar^5~d!2~3~4~5~6~7~8~9~
AuxBar^5~f~10!{SIZE=0.98,USE=1,B=1,COLOUR=1,ANCHOR=2,OFFSET=0,DEPTH=1,OTYPE=1,G=1,R=1}
AuxBar^6~f~1!{SIZE=0.98,USE=1,B=1,COLOUR=3,ANCHOR=4,OFFSET=1,DEPTH=4,OTYPE=1,G=1,R=1}
AuxBar^6~d!2~3~4~5~6~7~8~9~10~
AuxBar^7~f~1!{SIZE=0.98,USE=1,B=1,COLOUR=1,ANCHOR=4,OFFSET=1,DEPTH=3,OTYPE=2,G=1,R=1}
AuxBar^7~d!2~3~4~5~6~7~8~9~10~
AuxBar^8~f~1!{SIZE=0.98,USE=1,B=0.251,COLOUR=3,ANCHOR=3,OFFSET=1,DEPTH=2,OTYPE=2,G=0.557,R=1}
AuxBar^8~d!2~3~4~5~6~7~8~9~10~
AuxBar^9~f~1!{SIZE=0.98,USE=1,B=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,OTYPE=1,G=1,R=1}
AuxBar^9~d!2~3~4~5~6~7~8~9~10~
Complete!]]
HealBot_ExtraSkinData[38]=[[Skin
Compact Raid 25
Author~v!Monti of Terenas
DuplicateBars~v!false
Chat~t!{EOCOOM="false",EOCOOMV=5,MSG="Casting #s on #n",RESONLY="true",CHAN="",NOTIFY=1}
General~t!{OFREQ=0.07,OMIN=0.1,OMAX=0.95,FLUIDFREQ=10,HIDEPARTYF="false",HIDEPTF="false",STICKYSENSITIVITY=20,STICKYFRAME="true",HIDERAIDF="true",FLUIDBARS="false",HIDEBOSSF="true"}
Healing~t!{TINCSELF="false",GROUPPETS="true",TARGETINCOMBAT=1,FALWAYSSHOW="false",FONLYFRIEND="true",TINCPET="false",TONLYFRIEND="false",TINCGROUP="true",FOCUSINCOMBAT=2,TALWAYSSHOW="false",FEXRAID="false",TINCRAID="true",TEXRAID="false",SELFPET=0}
Enemy~t!{ENEMYTARGET="true",INCTANKS="true",INCMYTAR="false",INCARENA="false",ENEMYTARGETSIZE=58,INCARENAPETS="false",INCSELF="false",NUMBOSS=1,EXISTSHOWPTAR=1,HIDE="true",EXISTSHOWBOSS="true",DOUBLEWIDTH="false",EXISTSHOWARENA=2}
FrameAlias~f~1!{SIZE=12,NAME="Party",R=1,ALIAS="Raid",G=1,SHOW="false",OFFSET=1,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~2!{SIZE=12,NAME="Tank and Healer",R=1,ALIAS="Tank and Healer",G=1,SHOW="false",OFFSET=1,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~3!{SIZE=12,NAME="Pets",R=1,ALIAS="Not Used 1",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~4!{SIZE=12,NAME="Focus and Target",R=1,ALIAS="Not Used 2",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~5!{SIZE=12,NAME="Enemy",R=1,ALIAS="Not Used 3",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~6!{SIZE=12,NAME="",R=1,ALIAS="Vehicle",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~7!{SIZE=12,NAME="Pets",R=1,ALIAS="Pets",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~8!{SIZE=12,NAME="Target",R=1,ALIAS="Target",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~9!{SIZE=12,NAME="",R=1,ALIAS="Focus",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~10!{SIZE=12,NAME="Enemy",R=1,ALIAS="Enemy",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAliasBar~f~1!{A=0.23,WIDTH=0.94,B=0,HEIGHT=20,R=0.004,G=0,TEXTURE="Flat"}
FrameAliasBar~d!2~3~4~5~6~7~8~9~10~
Frame~f~1!{BORDERR=0.318,BACKR=0.506,SFOFFSETV=0,SFOFFSETH=0,LOCKED="false",OPENSOUND="false",BORDERA=0,BORDERG=0.757,TIPLOC=2,BORDERB=1,BACKA=0,SCALE=1,BACKB=0.506,BACKG=0.506,AUTOCLOSE="false"}
Frame~f~2!{BORDERR=0.102,BACKR=0.102,SFOFFSETV=0,SFOFFSETH=-8,LOCKED="true",OPENSOUND="false",BORDERA=0,BORDERG=0.102,TIPLOC=1,BORDERB=0.102,BACKA=0,SCALE=1,BACKB=0.502,BACKG=0.102,AUTOCLOSE="false"}
Frame~f~3!{BORDERR=0.1,BACKR=0.1,SFOFFSETV=0,SFOFFSETH=0,LOCKED="false",OPENSOUND="false",BORDERA=0.5,BORDERG=0.1,TIPLOC=2,BORDERB=0.1,BACKA=0.2,SCALE=1,BACKB=0.5,BACKG=0.1,AUTOCLOSE="false"}
Frame~d!4~
Frame~f~5!{BORDERR=0.1,BACKR=0.1,SFOFFSETV=0,SFOFFSETH=0,LOCKED="false",OPENSOUND="false",BORDERA=0.5,BORDERG=0.1,TIPLOC=4,BORDERB=0.1,BACKA=0.2,SCALE=1,BACKB=0.5,BACKG=0.1,AUTOCLOSE="false"}
Frame~f~6!{BORDERR=0.1,BACKR=0.1,SFOFFSETV=0,SFOFFSETH=0,LOCKED="false",OPENSOUND="false",BORDERA=0.5,BORDERG=0.1,TIPLOC=5,BORDERB=0.1,BACKA=0.2,SCALE=1,BACKB=0.5,BACKG=0.1,AUTOCLOSE="false"}
Frame~f~7!{BORDERR=0.102,AUTOCLOSE="false",BACKG=0.102,BACKB=0.502,LOCKED="true",SCALE=1,BORDERA=0.01,SFOFFSETV=8,TIPLOC=5,BORDERB=0.102,BACKA=0.01,OPENSOUND="false",BACKR=0.102,BORDERG=0.102,SFOFFSETH=0}
Frame~f~8!{BORDERR=0.102,AUTOCLOSE="false",BACKG=0.102,BACKB=0.502,LOCKED="false",SCALE=1,BORDERA=0,SFOFFSETV=0,TIPLOC=5,BORDERB=0.102,BACKA=0,OPENSOUND="false",BACKR=0.102,BORDERG=0.102,SFOFFSETH=5}
Frame~f~9!{BORDERR=0.1,AUTOCLOSE="false",BACKG=0.1,BACKB=0.5,LOCKED="false",SCALE=1,BORDERA=0.5,SFOFFSETV=0,TIPLOC=5,BORDERB=0.1,BACKA=0.2,OPENSOUND="false",BACKR=0.1,BORDERG=0.1,SFOFFSETH=5}
Frame~f~10!{BORDERR=0.706,BACKR=0.102,SFOFFSETV=0,SFOFFSETH=3,LOCKED="true",OPENSOUND="false",BORDERA=0,BORDERG=0,TIPLOC=4,BORDERB=0.122,BACKA=0.05,SCALE=1,BACKB=0.502,BACKG=0.102,AUTOCLOSE="false"}
StickyFrames~f~1!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~f~2!{STUCK="true",STUCKTOPOINT="TOPRIGHT",STUCKTO=1,STUCKPOINT="TOPLEFT"}
StickyFrames~f~3!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~d!4~5~6~
StickyFrames~f~7!{STUCK="true",STUCKTOPOINT="BOTTOMLEFT",STUCKTO=1,STUCKPOINT="TOPLEFT"}
StickyFrames~f~8!{STUCK="true",STUCKTOPOINT="TOPLEFT",STUCKTO=1,STUCKPOINT="TOPRIGHT"}
StickyFrames~f~9!{STUCK="true",STUCKTOPOINT="BOTTOMLEFT",STUCKTO=1,STUCKPOINT="BOTTOMRIGHT"}
StickyFrames~f~10!{STUCK="true",STUCKTOPOINT="TOPLEFT",STUCKTO=1,STUCKPOINT="BOTTOMLEFT"}
HealGroups~f~1!{FRAME=1,STATE="true",NAME="Main tanks"}
HealGroups~f~2!{FRAME=1,STATE="true",NAME="Healers"}
HealGroups~f~3!{FRAME=1,STATE="false",NAME="Private List"}
HealGroups~f~4!{FRAME=1,STATE="false",NAME="Self"}
HealGroups~f~5!{FRAME=1,STATE="true",NAME="Raid"}
HealGroups~f~6!{FRAME=1,STATE="false",NAME="Group"}
HealGroups~f~7!{FRAME=6,STATE="false",NAME="Vehicle"}
HealGroups~f~8!{FRAME=7,STATE="true",NAME="Pets"}
HealGroups~f~9!{FRAME=8,STATE="true",NAME="Target"}
HealGroups~f~10!{FRAME=9,STATE="true",NAME="Focus"}
HealGroups~f~11!{FRAME=10,STATE="true",NAME="Enemy"}
Anchors~f~1!{Y=55.4,GROW=2,BARS=3,FRAME=3,X=45.49}
Anchors~f~2!{Y=62.69,GROW=2,BARS=1,FRAME=1,X=44.34}
Anchors~f~3!{Y=55,GROW=2,BARS=3,FRAME=3,X=96.42}
Anchors~f~4!{Y=64.17,GROW=2,BARS=1,FRAME=1,X=83.17}
Anchors~f~5!{Y=65.23,GROW=2,BARS=2,FRAME=2,X=89.04}
Anchors~f~6!{Y=55,GROW=2,BARS=1,FRAME=1,X=55}
Anchors~f~7!{Y=39.57,GROW=2,BARS=1,FRAME=1,X=30.56}
Anchors~f~8!{Y=55.4,GROW=2,BARS=1,FRAME=3,X=30.73}
Anchors~f~9!{Y=38.9,GROW=2,BARS=1,FRAME=4,X=30.73}
Anchors~f~10!{Y=55.4,GROW=2,BARS=4,FRAME=2,X=30.66}
HeadBar~f~1!{SHOW="false",WIDTH=0.9,B=0.506,R=0.506,HEIGHT=30,A=0.4,G=0.506,TEXTURE="Diagonal"}
HeadBar~f~2!{SHOW="false",WIDTH=0.9,B=0.1,R=0.1,HEIGHT=30,A=0.25,G=0.1,TEXTURE="Diagonal"}
HeadBar~d!3~4~5~6~7~8~9~10~
HeadText~f~1!{A=0.7,B=0.8,OFFSET=0,R=0.2,FONT="Friz Quadrata TT",HEIGHT=10,G=0.8,OUTLINE=1}
HeadText~f~2!{A=0.7,B=0.1,OFFSET=0,R=1,FONT="Friz Quadrata TT",HEIGHT=10,G=1,OUTLINE=1}
HeadText~d!3~4~5~6~7~8~9~10~
HealBar~f~1!{HEIGHT=28,GRPCOLS="false",CMARGIN=2,TEXTURE="Smooth v2",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=3,NUMCOLS=5,OFIX=1,RMARGIN=2,WIDTH=82}
HealBar~f~2!{HEIGHT=30,GRPCOLS="false",CMARGIN=4,TEXTURE="Smooth v2",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=112,RMARGIN=2,OFIX=1,NUMCOLS=1,LOWMANA=2}
HealBar~f~3!{HEIGHT=34,GRPCOLS="false",CMARGIN=4,TEXTURE="Smooth v2",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=2,NUMCOLS=1,OFIX=1,RMARGIN=0,WIDTH=172}
HealBar~d!4~5~6~
HealBar~f~7!{HEIGHT=20,GRPCOLS="false",CMARGIN=4,TEXTURE="Smooth v2",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=1,NUMCOLS=5,OFIX=1,RMARGIN=0,WIDTH=80}
HealBar~f~8!{HEIGHT=25,GRPCOLS="false",CMARGIN=4,TEXTURE="Smooth v2",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=2,NUMCOLS=1,OFIX=1,RMARGIN=0,WIDTH=72}
HealBar~d!9~
HealBar~f~10!{HEIGHT=25,GRPCOLS="false",CMARGIN=4,TEXTURE="Smooth v2",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=2,NUMCOLS=5,OFIX=1,RMARGIN=0,WIDTH=80}
BarCol~f~1!{BACK=2,BA=0,BB=0.506,DISA=0.1,BR=0.506,HB=0.9,BG=0.506,BOUT=0,HA=1,HR=0.2,ORA=0.58,HG=0.2,HLTH=2}
BarCol~d!2~3~4~5~6~7~8~9~10~
BarIACol~f~1!{AC=4,AB=0.973,AA=0.35,AR=0.973,AG=0.973,IC=2,IB=0.953,IA=0.4,IR=1,IG=0.984}
BarIACol~d!2~3~4~5~6~7~8~9~10~
BarText~f~1!{HLTHONBAR="false",TAGOOR="OOR | ",IGNOREONFULL="false",MAXCHARS=0,HHEIGHT=12,HMAXCHARS=0,HOFFSET=0,OUTLINE=1,INCHEALS=2,OFFSET=0,HLTHTXTANCHOR=1,HLTHTYPE=1,CLASSONBAR="false",INCABSORBS=2,NUMFORMAT2=1,OVERHEAL=1,NUMFORMAT1=11,TAGDC="DC | ",NAMEONBAR="true",HEIGHT=12,TAGRIP="RIP | ",SHOWROLE="true",HALIGN=2,FONT="Friz Quadrata TT",HOUTLINE=1,CLASSTYPE=1,HOFFSET2=0,ALIGN=2,TAGR="R | ",HFONT="Friz Quadrata TT"}
BarText~d!2~3~4~5~6~7~8~9~10~
BarTextCol~f~1!{NCB=0.267,NCR=0.949,NAME=2,NCDA=0.15,HCG=0,HCA=1,NCG=0.843,NCA=1,NDEBUFF="false",HCB=1,HCR=0.761,HDEBUFF="false",HCDA=0.1,HLTH=1}
BarTextCol~d!2~3~4~5~6~7~8~9~10~
Icons~f~1!{SHOWBUFF="true",POSITION=2,FADESECS=15,SHOWDIRMOUSE="false",FADE="false",I15EN="false",SHOWDIR="false",DOUBLE="true",DSCALE=1,ONBAR=1,SHOWRC="true",SCALE=1,SHOWDEBUFF="true",MAXDICONS=4,MAXBICONS=8}
Icons~d!2~3~4~5~6~
Icons~f~7!{SHOWBUFF="true",POSITION=2,FADESECS=15,SHOWDIRMOUSE="false",FADE="false",I15EN="false",SHOWDIR="false",DOUBLE="true",DSCALE=1,ONBAR=1,SHOWRC="true",SCALE=1,SHOWDEBUFF="true",MAXDICONS=4,MAXBICONS=6}
Icons~f~8!{SHOWBUFF="true",POSITION=2,FADESECS=15,SHOWDIRMOUSE="false",FADE="false",I15EN="false",SHOWDIR="false",DOUBLE="true",DSCALE=1,ONBAR=1,SHOWRC="true",SCALE=1,SHOWDEBUFF="true",MAXDICONS=4,MAXBICONS=8}
Icons~d!9~10~
RaidIcon~f~1!{SQUARE="true",CIRCLE="true",DIAMOND="true",SHOW="true",SKULL="true",TRIANGLE="true",STAR="true",CROSS="true",MOON="true"}
RaidIcon~d!2~3~4~5~6~7~8~9~10~
IconText~f~1!{DURWARN=3,HEIGHT=10,SSCNT="false",SCNT="true",DURTHRH=9,FONT="Friz Quadrata TT",SDUR="true",SSDUR="true",OUTLINE=2}
IconText~d!2~3~4~5~6~7~8~9~10~
BarVisibility~f~1!{INCCLASSES=1,ALERTIC=0.98,ALERTOC=0.95,HIDEOOR="false"}
BarVisibility~f~2!{INCCLASSES=1,ALERTIC=0.99,ALERTOC=0.97,HIDEOOR="false"}
BarVisibility~f~3!{INCCLASSES=1,ALERTIC=0.95,ALERTOC=0.9,HIDEOOR="false"}
BarVisibility~d!4~5~6~7~
BarVisibility~f~8!{INCCLASSES=1,ALERTIC=1,ALERTOC=1,HIDEOOR="false"}
BarVisibility~d!9~
BarVisibility~f~10!{INCCLASSES=1,ALERTIC=0.95,ALERTOC=0.9,HIDEOOR="false"}
BarSort~f~1!{SUBORDER=4,OORLAST="false",RAIDORDER=2,SUBPF="true"}
BarSort~d!2~3~4~5~6~7~8~9~10~
BarAggro~f~1!{B=0.075,ALERTIND=2,G=0.173,TEXTFORMAT=3,SHOW="true",SHOWTEXTPCT="true",R=0.969,SHOWIND="false",SHOWTEXT="false",ALERT=2}
BarAggro~d!2~3~4~5~6~7~8~9~10~
AuxBarFrame~f~1!{OVERLAP=1}
AuxBarFrame~d!2~3~4~5~6~7~8~9~10~
AuxBar^1~f~1!{SIZE=1,USE=4,B=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=3,OTYPE=1,G=1,R=1}
AuxBar^1~d!2~3~4~5~6~7~8~9~10~
AuxBar^2~f~1!{SIZE=0.4,USE=9,B=1,COLOUR=1,ANCHOR=2,OFFSET=1,DEPTH=2,OTYPE=2,G=0,R=0.761}
AuxBar^2~d!2~3~4~5~6~7~8~9~
AuxBar^2~f~10!{SIZE=0.4,USE=1,B=1,COLOUR=1,ANCHOR=2,OFFSET=1,DEPTH=2,OTYPE=2,G=0,R=0.761}
AuxBar^3~f~1!{SIZE=0.4,USE=10,B=0.58,COLOUR=1,ANCHOR=2,OFFSET=-2,DEPTH=2,OTYPE=2,G=0.122,R=0.357}
AuxBar^3~d!2~3~4~5~6~7~8~9~
AuxBar^3~f~10!{SIZE=0.4,USE=1,B=0.58,COLOUR=1,ANCHOR=2,OFFSET=-2,DEPTH=2,OTYPE=2,G=0.122,R=0.357}
AuxBar^4~f~1!{SIZE=0.98,USE=1,B=1,COLOUR=1,ANCHOR=3,OFFSET=0,DEPTH=4,OTYPE=1,G=1,R=1}
AuxBar^4~d!2~3~4~5~6~7~8~9~10~
AuxBar^5~f~1!{SIZE=0.98,USE=5,B=1,COLOUR=1,ANCHOR=2,OFFSET=0,DEPTH=1,OTYPE=1,G=1,R=1}
AuxBar^5~d!2~3~4~5~6~7~8~9~
AuxBar^5~f~10!{SIZE=0.98,USE=1,B=1,COLOUR=1,ANCHOR=2,OFFSET=0,DEPTH=1,OTYPE=1,G=1,R=1}
AuxBar^6~f~1!{SIZE=0.98,USE=1,B=1,COLOUR=3,ANCHOR=4,OFFSET=1,DEPTH=4,OTYPE=1,G=1,R=1}
AuxBar^6~d!2~3~4~5~6~7~8~9~10~
AuxBar^7~f~1!{SIZE=0.98,USE=1,B=1,COLOUR=1,ANCHOR=4,OFFSET=1,DEPTH=3,OTYPE=2,G=1,R=1}
AuxBar^7~d!2~3~4~5~6~7~8~9~10~
AuxBar^8~f~1!{SIZE=0.98,USE=1,B=0.251,COLOUR=3,ANCHOR=3,OFFSET=1,DEPTH=2,OTYPE=2,G=0.557,R=1}
AuxBar^8~d!2~3~4~5~6~7~8~9~10~
AuxBar^9~f~1!{SIZE=0.98,USE=1,B=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,OTYPE=1,G=1,R=1}
AuxBar^9~d!2~3~4~5~6~7~8~9~10~
Complete!]]
HealBot_ExtraSkinData[39]=[[Skin
Compact Raid 10
Author~v!Monti of Terenas
DuplicateBars~v!false
Chat~t!{EOCOOM="false",EOCOOMV=5,MSG="Casting #s on #n",RESONLY="true",CHAN="",NOTIFY=1}
General~t!{OFREQ=0.07,OMIN=0.1,OMAX=0.95,FLUIDFREQ=10,HIDEPTF="false",HIDEBOSSF="true",STICKYFRAME="true",HIDERAIDF="true",STICKYSENSITIVITY=20,FLUIDBARS="false",HIDEPARTYF="false"}
Healing~t!{TINCSELF="false",GROUPPETS="true",TARGETINCOMBAT=1,SELFPET=0,FONLYFRIEND="true",FEXRAID="false",TONLYFRIEND="false",TINCGROUP="true",FOCUSINCOMBAT=2,TALWAYSSHOW="false",TINCPET="false",TINCRAID="true",TEXRAID="false",FALWAYSSHOW="false"}
Enemy~t!{INCARENA="false",INCTANKS="true",INCMYTAR="false",ENEMYTARGET="true",ENEMYTARGETSIZE=58,INCARENAPETS="false",HIDE="true",NUMBOSS=1,EXISTSHOWPTAR=1,INCSELF="false",EXISTSHOWBOSS="true",DOUBLEWIDTH="false",EXISTSHOWARENA=2}
FrameAlias~f~1!{SIZE=12,NAME="Party",R=1,ALIAS="Raid",G=1,SHOW="false",OFFSET=1,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~2!{SIZE=12,NAME="Tank and Healer",R=1,ALIAS="Tank and Healer",G=1,SHOW="false",OFFSET=1,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~3!{SIZE=12,NAME="Pets",R=1,ALIAS="Not Used 1",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~4!{SIZE=12,NAME="Focus and Target",R=1,ALIAS="Not Used 2",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~5!{SIZE=12,NAME="Enemy",R=1,ALIAS="Not Used 3",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~6!{SIZE=12,NAME="",R=1,ALIAS="Vehicle",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~7!{SIZE=12,NAME="Pets",R=1,ALIAS="Pets",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~8!{SIZE=12,NAME="Target",R=1,ALIAS="Target",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~9!{SIZE=12,NAME="",R=1,ALIAS="Focus",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~10!{SIZE=12,NAME="Enemy",R=1,ALIAS="Enemy",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAliasBar~f~1!{A=0.23,TEXTURE="Flat",B=0,HEIGHT=20,R=0.004,G=0,WIDTH=0.94}
FrameAliasBar~d!2~3~4~5~6~7~8~9~10~
Frame~f~1!{SFOFFSETH=0,AUTOCLOSE="false",BACKG=0.506,BACKB=0.506,LOCKED="false",SCALE=1,BORDERA=0,SFOFFSETV=0,TIPLOC=2,BORDERB=1,BACKA=0,OPENSOUND="false",BORDERR=0.318,BORDERG=0.757,BACKR=0.506}
Frame~f~2!{SFOFFSETH=-8,AUTOCLOSE="false",BACKG=0.102,BACKB=0.502,LOCKED="true",SCALE=1,BORDERA=0,SFOFFSETV=0,TIPLOC=1,BORDERB=0.102,BACKA=0,OPENSOUND="false",BORDERR=0.102,BORDERG=0.102,BACKR=0.102}
Frame~f~3!{SFOFFSETH=0,AUTOCLOSE="false",BACKG=0.1,BACKB=0.5,LOCKED="false",SCALE=1,BORDERA=0.5,SFOFFSETV=0,TIPLOC=2,BORDERB=0.1,BACKA=0.2,OPENSOUND="false",BORDERR=0.1,BORDERG=0.1,BACKR=0.1}
Frame~d!4~
Frame~f~5!{SFOFFSETH=0,AUTOCLOSE="false",BACKG=0.1,BACKB=0.5,LOCKED="false",SCALE=1,BORDERA=0.5,SFOFFSETV=0,TIPLOC=4,BORDERB=0.1,BACKA=0.2,OPENSOUND="false",BORDERR=0.1,BORDERG=0.1,BACKR=0.1}
Frame~f~6!{SFOFFSETH=0,AUTOCLOSE="false",BACKG=0.1,BACKB=0.5,LOCKED="false",SCALE=1,BORDERA=0.5,SFOFFSETV=0,TIPLOC=5,BORDERB=0.1,BACKA=0.2,OPENSOUND="false",BORDERR=0.1,BORDERG=0.1,BACKR=0.1}
Frame~f~7!{BORDERR=0.102,SFOFFSETH=0,BORDERG=0.102,BACKR=0.102,LOCKED="true",OPENSOUND="false",BORDERA=0.01,SFOFFSETV=8,AUTOCLOSE="false",BACKB=0.502,BACKA=0.01,SCALE=1,BORDERB=0.102,TIPLOC=5,BACKG=0.102}
Frame~f~8!{BORDERR=0.102,SFOFFSETH=5,BORDERG=0.102,BACKR=0.102,LOCKED="false",OPENSOUND="false",BORDERA=0,SFOFFSETV=0,AUTOCLOSE="false",BACKB=0.502,BACKA=0,SCALE=1,BORDERB=0.102,TIPLOC=5,BACKG=0.102}
Frame~f~9!{BORDERR=0.1,SFOFFSETH=5,BORDERG=0.1,BACKR=0.1,LOCKED="false",OPENSOUND="false",BORDERA=0.5,SFOFFSETV=0,AUTOCLOSE="false",BACKB=0.5,BACKA=0.2,SCALE=1,BORDERB=0.1,TIPLOC=5,BACKG=0.1}
Frame~f~10!{SFOFFSETH=3,AUTOCLOSE="false",BACKG=0.102,BACKB=0.502,LOCKED="true",SCALE=1,BORDERA=0,SFOFFSETV=-4,TIPLOC=4,BORDERB=0.122,BACKA=0.05,OPENSOUND="false",BORDERR=0.706,BORDERG=0,BACKR=0.102}
StickyFrames~f~1!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~f~2!{STUCK="true",STUCKTOPOINT="TOPRIGHT",STUCKTO=1,STUCKPOINT="TOPLEFT"}
StickyFrames~f~3!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~d!4~5~6~
StickyFrames~f~7!{STUCK="true",STUCKTOPOINT="BOTTOMLEFT",STUCKTO=1,STUCKPOINT="TOPLEFT"}
StickyFrames~f~8!{STUCK="true",STUCKTOPOINT="TOPLEFT",STUCKTO=1,STUCKPOINT="TOPRIGHT"}
StickyFrames~f~9!{STUCK="true",STUCKTOPOINT="BOTTOMLEFT",STUCKTO=1,STUCKPOINT="BOTTOMRIGHT"}
StickyFrames~f~10!{STUCK="true",STUCKTOPOINT="TOPLEFT",STUCKTO=1,STUCKPOINT="BOTTOMLEFT"}
HealGroups~f~1!{FRAME=1,STATE="true",NAME="Main tanks"}
HealGroups~f~2!{FRAME=1,STATE="true",NAME="Healers"}
HealGroups~f~3!{FRAME=1,STATE="false",NAME="Private List"}
HealGroups~f~4!{FRAME=1,STATE="false",NAME="Self"}
HealGroups~f~5!{FRAME=1,STATE="true",NAME="Raid"}
HealGroups~f~6!{FRAME=1,STATE="false",NAME="Group"}
HealGroups~f~7!{FRAME=6,STATE="false",NAME="Vehicle"}
HealGroups~f~8!{FRAME=7,STATE="true",NAME="Pets"}
HealGroups~f~9!{FRAME=8,STATE="true",NAME="Target"}
HealGroups~f~10!{FRAME=9,STATE="true",NAME="Focus"}
HealGroups~f~11!{FRAME=10,STATE="true",NAME="Enemy"}
Anchors~f~1!{Y=55.4,GROW=2,BARS=3,FRAME=3,X=45.49}
Anchors~f~2!{Y=60.73,GROW=2,BARS=1,FRAME=1,X=38.95}
Anchors~f~3!{Y=55,GROW=2,BARS=3,FRAME=3,X=96.42}
Anchors~f~4!{Y=64.17,GROW=2,BARS=1,FRAME=1,X=83.17}
Anchors~f~5!{Y=65.23,GROW=2,BARS=2,FRAME=2,X=89.04}
Anchors~f~6!{Y=55,GROW=2,BARS=1,FRAME=1,X=55}
Anchors~f~7!{Y=52.07,GROW=2,BARS=1,FRAME=1,X=42.11}
Anchors~f~8!{Y=55.4,GROW=2,BARS=1,FRAME=3,X=42.28}
Anchors~f~9!{Y=51.4,GROW=2,BARS=1,FRAME=4,X=42.28}
Anchors~f~10!{Y=55.07,GROW=2,BARS=4,FRAME=2,X=42.21}
HeadBar~f~1!{SHOW="false",TEXTURE="Diagonal",R=0.506,B=0.506,HEIGHT=30,A=0.4,G=0.506,WIDTH=0.9}
HeadBar~f~2!{SHOW="false",TEXTURE="Diagonal",R=0.1,B=0.1,HEIGHT=30,A=0.25,G=0.1,WIDTH=0.9}
HeadBar~d!3~4~5~6~7~8~9~10~
HeadText~f~1!{A=0.7,R=0.2,OFFSET=0,B=0.8,FONT="Friz Quadrata TT",HEIGHT=10,G=0.8,OUTLINE=1}
HeadText~f~2!{A=0.7,R=1,OFFSET=0,B=0.1,FONT="Friz Quadrata TT",HEIGHT=10,G=1,OUTLINE=1}
HeadText~d!3~4~5~6~7~8~9~10~
HealBar~f~1!{HEIGHT=30,GRPCOLS="false",CMARGIN=2,TEXTURE="Smooth v2",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=87,RMARGIN=1,OFIX=1,NUMCOLS=2,LOWMANA=3}
HealBar~f~2!{HEIGHT=30,GRPCOLS="false",CMARGIN=2,TEXTURE="Smooth v2",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=2,NUMCOLS=1,OFIX=1,RMARGIN=1,WIDTH=112}
HealBar~f~3!{HEIGHT=34,GRPCOLS="false",CMARGIN=4,TEXTURE="Smooth v2",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=172,RMARGIN=0,OFIX=1,NUMCOLS=1,LOWMANA=2}
HealBar~d!4~5~6~
HealBar~f~7!{HEIGHT=25,GRPCOLS="false",CMARGIN=2,TEXTURE="Smooth v2",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=87,RMARGIN=1,OFIX=1,NUMCOLS=2,LOWMANA=1}
HealBar~f~8!{HEIGHT=28,GRPCOLS="false",CMARGIN=4,TEXTURE="Smooth v2",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=82,RMARGIN=0,OFIX=1,NUMCOLS=1,LOWMANA=2}
HealBar~d!9~
HealBar~f~10!{HEIGHT=27,GRPCOLS="false",CMARGIN=4,TEXTURE="Smooth v2",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=84,RMARGIN=1,OFIX=1,NUMCOLS=2,LOWMANA=2}
BarCol~f~1!{BACK=2,BA=0,BOUT=0,DISA=0.1,BR=0.506,HB=0.9,BG=0.506,HG=0.2,HA=1,HR=0.2,ORA=0.58,BB=0.506,HLTH=2}
BarCol~d!2~3~4~5~6~7~8~9~10~
BarIACol~f~1!{AC=4,AB=0.973,AA=0.35,AR=0.973,AG=0.973,IC=2,IB=0.953,IA=0.4,IR=1,IG=0.984}
BarIACol~d!2~3~4~5~6~7~8~9~10~
BarText~f~1!{HLTHONBAR="false",TAGOOR="OOR | ",OVERHEAL=1,MAXCHARS=0,TAGRIP="RIP | ",CLASSONBAR="false",HFONT="Friz Quadrata TT",OUTLINE=1,INCHEALS=2,OFFSET=0,HLTHTXTANCHOR=1,HLTHTYPE=1,HMAXCHARS=0,CLASSTYPE=1,NUMFORMAT2=1,HOUTLINE=1,NUMFORMAT1=11,FONT="Friz Quadrata TT",NAMEONBAR="true",HEIGHT=12,HHEIGHT=12,SHOWROLE="true",HALIGN=2,TAGDC="DC | ",IGNOREONFULL="false",INCABSORBS=2,HOFFSET2=0,ALIGN=2,TAGR="R | ",HOFFSET=0}
BarText~d!2~3~4~5~6~7~8~9~10~
BarTextCol~f~1!{HCG=0,HCA=1,NCB=0.267,NCDA=0.15,NAME=2,NCR=0.949,NCG=0.843,NCA=1,NDEBUFF="false",HCB=1,HCR=0.761,HDEBUFF="false",HLTH=1,HCDA=0.1}
BarTextCol~d!2~3~4~5~6~7~8~9~10~
Icons~f~1!{SHOWBUFF="true",POSITION=2,I15EN="false",DOUBLE="true",MAXDICONS=4,SHOWDEBUFF="true",ONBAR=1,FADE="false",DSCALE=1,SHOWDIR="false",SHOWRC="true",SCALE=1,SHOWDIRMOUSE="false",FADESECS=15,MAXBICONS=8}
Icons~d!2~3~4~5~6~
Icons~f~7!{SHOWBUFF="true",POSITION=2,I15EN="false",DOUBLE="true",MAXDICONS=4,SHOWDEBUFF="true",ONBAR=1,FADE="false",DSCALE=1,SHOWDIR="false",SHOWRC="true",SCALE=1,SHOWDIRMOUSE="false",FADESECS=15,MAXBICONS=6}
Icons~f~8!{SHOWBUFF="true",POSITION=2,I15EN="false",DOUBLE="true",MAXDICONS=4,SHOWDEBUFF="true",ONBAR=1,FADE="false",DSCALE=1,SHOWDIR="false",SHOWRC="true",SCALE=1,SHOWDIRMOUSE="false",FADESECS=15,MAXBICONS=8}
Icons~d!9~10~
RaidIcon~f~1!{SQUARE="true",CIRCLE="true",DIAMOND="true",SHOW="true",SKULL="true",TRIANGLE="true",STAR="true",MOON="true",CROSS="true"}
RaidIcon~d!2~3~4~5~6~7~8~9~10~
IconText~f~1!{SDUR="true",HEIGHT=10,SSCNT="false",SCNT="true",DURTHRH=9,FONT="Friz Quadrata TT",DURWARN=3,SSDUR="true",OUTLINE=2}
IconText~d!2~3~4~5~6~7~8~9~10~
BarVisibility~f~1!{INCCLASSES=1,ALERTIC=0.98,ALERTOC=0.95,HIDEOOR="false"}
BarVisibility~f~2!{INCCLASSES=1,ALERTIC=0.99,ALERTOC=0.97,HIDEOOR="false"}
BarVisibility~f~3!{INCCLASSES=1,ALERTIC=0.95,ALERTOC=0.9,HIDEOOR="false"}
BarVisibility~d!4~5~6~7~
BarVisibility~f~8!{INCCLASSES=1,ALERTIC=1,ALERTOC=1,HIDEOOR="false"}
BarVisibility~d!9~
BarVisibility~f~10!{INCCLASSES=1,ALERTIC=0.95,ALERTOC=0.9,HIDEOOR="false"}
BarSort~f~1!{SUBORDER=4,OORLAST="false",RAIDORDER=2,SUBPF="true"}
BarSort~d!2~3~4~5~6~7~8~9~10~
BarAggro~f~1!{B=0.075,ALERTIND=2,G=0.173,TEXTFORMAT=3,SHOW="true",SHOWTEXTPCT="true",SHOWTEXT="false",SHOWIND="false",R=0.969,ALERT=2}
BarAggro~d!2~3~4~5~6~7~8~9~10~
AuxBarFrame~f~1!{OVERLAP=1}
AuxBarFrame~d!2~3~4~5~6~7~8~9~10~
AuxBar^1~f~1!{SIZE=1,USE=4,B=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=3,R=1,G=1,OTYPE=1}
AuxBar^1~d!2~3~4~5~6~7~8~9~10~
AuxBar^2~f~1!{SIZE=0.4,USE=9,B=1,COLOUR=1,ANCHOR=2,OFFSET=1,DEPTH=2,R=0.761,G=0,OTYPE=2}
AuxBar^2~d!2~3~4~5~6~7~8~9~
AuxBar^2~f~10!{SIZE=0.4,USE=1,B=1,COLOUR=1,ANCHOR=2,OFFSET=1,DEPTH=2,R=0.761,G=0,OTYPE=2}
AuxBar^3~f~1!{SIZE=0.4,USE=10,B=0.58,COLOUR=1,ANCHOR=2,OFFSET=-2,DEPTH=2,R=0.357,G=0.122,OTYPE=2}
AuxBar^3~d!2~3~4~5~6~7~8~9~
AuxBar^3~f~10!{SIZE=0.4,USE=1,B=0.58,COLOUR=1,ANCHOR=2,OFFSET=-2,DEPTH=2,R=0.357,G=0.122,OTYPE=2}
AuxBar^4~f~1!{SIZE=0.98,USE=1,B=1,COLOUR=1,ANCHOR=3,OFFSET=0,DEPTH=4,R=1,G=1,OTYPE=1}
AuxBar^4~d!2~3~4~5~6~7~8~9~10~
AuxBar^5~f~1!{SIZE=0.98,USE=5,B=1,COLOUR=1,ANCHOR=2,OFFSET=0,DEPTH=1,R=1,G=1,OTYPE=1}
AuxBar^5~d!2~3~4~5~6~7~8~9~
AuxBar^5~f~10!{SIZE=0.98,USE=1,B=1,COLOUR=1,ANCHOR=2,OFFSET=0,DEPTH=1,R=1,G=1,OTYPE=1}
AuxBar^6~f~1!{SIZE=0.98,USE=1,B=1,COLOUR=3,ANCHOR=4,OFFSET=1,DEPTH=4,R=1,G=1,OTYPE=1}
AuxBar^6~d!2~3~4~5~6~7~8~9~10~
AuxBar^7~f~1!{SIZE=0.98,USE=1,B=1,COLOUR=1,ANCHOR=4,OFFSET=1,DEPTH=3,R=1,G=1,OTYPE=2}
AuxBar^7~d!2~3~4~5~6~7~8~9~10~
AuxBar^8~f~1!{SIZE=0.98,USE=1,B=0.251,COLOUR=3,ANCHOR=3,OFFSET=1,DEPTH=2,R=1,G=0.557,OTYPE=2}
AuxBar^8~d!2~3~4~5~6~7~8~9~10~
AuxBar^9~f~1!{SIZE=0.98,USE=1,B=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,R=1,G=1,OTYPE=1}
AuxBar^9~d!2~3~4~5~6~7~8~9~10~
Complete!]]
HealBot_ExtraSkinData[40]=[[Skin
Compact Party
Author~v!Monti of Terenas
DuplicateBars~v!false
Chat~t!{EOCOOM="false",EOCOOMV=5,MSG="Casting #s on #n",RESONLY="true",CHAN="",NOTIFY=1}
General~t!{OFREQ=0.07,OMIN=0.1,OMAX=0.95,FLUIDFREQ=10,HIDEPTF="false",HIDEBOSSF="true",STICKYFRAME="true",HIDERAIDF="true",STICKYSENSITIVITY=20,FLUIDBARS="false",HIDEPARTYF="false"}
Healing~t!{TINCSELF="false",GROUPPETS="true",TARGETINCOMBAT=1,SELFPET=0,FONLYFRIEND="true",FEXRAID="false",TONLYFRIEND="false",TINCGROUP="true",FOCUSINCOMBAT=2,TALWAYSSHOW="false",TINCPET="false",TINCRAID="true",TEXRAID="false",FALWAYSSHOW="false"}
Enemy~t!{INCARENA="false",INCTANKS="true",INCMYTAR="false",ENEMYTARGET="true",ENEMYTARGETSIZE=58,INCARENAPETS="false",HIDE="true",NUMBOSS=1,EXISTSHOWPTAR=1,INCSELF="false",EXISTSHOWBOSS="true",DOUBLEWIDTH="false",EXISTSHOWARENA=2}
FrameAlias~f~1!{SIZE=12,NAME="Party",R=1,ALIAS="Group",G=1,SHOW="false",OFFSET=1,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~2!{SIZE=12,NAME="Tank and Healer",R=1,ALIAS="Tank and Healer",G=1,SHOW="false",OFFSET=1,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~3!{SIZE=12,NAME="Pets",R=1,ALIAS="Not Used 1",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~4!{SIZE=12,NAME="Focus and Target",R=1,ALIAS="Not Used 2",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~5!{SIZE=12,NAME="Enemy",R=1,ALIAS="Not Used 3",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~6!{SIZE=12,NAME="",R=1,ALIAS="Vehicle",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~7!{SIZE=12,NAME="Pets",R=1,ALIAS="Pets",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~8!{SIZE=12,NAME="Target",R=1,ALIAS="Target",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~9!{SIZE=12,NAME="",R=1,ALIAS="Focus",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~10!{SIZE=12,NAME="Enemy",R=1,ALIAS="Enemy",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAliasBar~f~1!{A=0.23,TEXTURE="Flat",B=0,HEIGHT=20,R=0.004,G=0,WIDTH=0.94}
FrameAliasBar~d!2~3~4~5~6~7~8~9~10~
Frame~f~1!{SFOFFSETH=0,AUTOCLOSE="false",BACKG=0.506,BACKB=0.506,LOCKED="false",SCALE=1,BORDERA=0,SFOFFSETV=0,TIPLOC=2,BORDERB=1,BACKA=0,OPENSOUND="false",BORDERR=0.318,BORDERG=0.757,BACKR=0.506}
Frame~f~2!{SFOFFSETH=-8,AUTOCLOSE="false",BACKG=0.102,BACKB=0.502,LOCKED="true",SCALE=1,BORDERA=0,SFOFFSETV=0,TIPLOC=1,BORDERB=0.102,BACKA=0,OPENSOUND="false",BORDERR=0.102,BORDERG=0.102,BACKR=0.102}
Frame~f~3!{SFOFFSETH=0,AUTOCLOSE="false",BACKG=0.1,BACKB=0.5,LOCKED="false",SCALE=1,BORDERA=0.5,SFOFFSETV=0,TIPLOC=2,BORDERB=0.1,BACKA=0.2,OPENSOUND="false",BORDERR=0.1,BORDERG=0.1,BACKR=0.1}
Frame~d!4~
Frame~f~5!{SFOFFSETH=0,AUTOCLOSE="false",BACKG=0.1,BACKB=0.5,LOCKED="false",SCALE=1,BORDERA=0.5,SFOFFSETV=0,TIPLOC=4,BORDERB=0.1,BACKA=0.2,OPENSOUND="false",BORDERR=0.1,BORDERG=0.1,BACKR=0.1}
Frame~f~6!{SFOFFSETH=0,AUTOCLOSE="false",BACKG=0.1,BACKB=0.5,LOCKED="false",SCALE=1,BORDERA=0.5,SFOFFSETV=0,TIPLOC=5,BORDERB=0.1,BACKA=0.2,OPENSOUND="false",BORDERR=0.1,BORDERG=0.1,BACKR=0.1}
Frame~f~7!{BORDERR=0.102,SFOFFSETH=0,BORDERG=0.102,BACKR=0.102,LOCKED="true",OPENSOUND="false",BORDERA=0.01,SFOFFSETV=8,AUTOCLOSE="false",BACKB=0.502,BACKA=0.01,SCALE=1,BORDERB=0.102,TIPLOC=5,BACKG=0.102}
Frame~f~8!{BORDERR=0.102,SFOFFSETH=5,BORDERG=0.102,BACKR=0.102,LOCKED="false",OPENSOUND="false",BORDERA=0,SFOFFSETV=0,AUTOCLOSE="false",BACKB=0.502,BACKA=0,SCALE=1,BORDERB=0.102,TIPLOC=5,BACKG=0.102}
Frame~f~9!{BORDERR=0.1,SFOFFSETH=5,BORDERG=0.1,BACKR=0.1,LOCKED="false",OPENSOUND="false",BORDERA=0.5,SFOFFSETV=0,AUTOCLOSE="false",BACKB=0.5,BACKA=0.2,SCALE=1,BORDERB=0.1,TIPLOC=5,BACKG=0.1}
Frame~f~10!{SFOFFSETH=2,AUTOCLOSE="false",BACKG=0.102,BACKB=0.502,LOCKED="true",SCALE=1,BORDERA=0,SFOFFSETV=-7,TIPLOC=4,BORDERB=0.122,BACKA=0.05,OPENSOUND="false",BORDERR=0.706,BORDERG=0,BACKR=0.102}
StickyFrames~f~1!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~f~2!{STUCK="true",STUCKTOPOINT="TOPRIGHT",STUCKTO=1,STUCKPOINT="TOPLEFT"}
StickyFrames~f~3!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~d!4~5~6~
StickyFrames~f~7!{STUCK="true",STUCKTOPOINT="BOTTOMLEFT",STUCKTO=1,STUCKPOINT="TOPLEFT"}
StickyFrames~f~8!{STUCK="true",STUCKTOPOINT="TOPLEFT",STUCKTO=1,STUCKPOINT="TOPRIGHT"}
StickyFrames~f~9!{STUCK="true",STUCKTOPOINT="BOTTOMLEFT",STUCKTO=1,STUCKPOINT="BOTTOMRIGHT"}
StickyFrames~f~10!{STUCK="true",STUCKTOPOINT="TOPLEFT",STUCKTO=1,STUCKPOINT="BOTTOMLEFT"}
HealGroups~f~1!{FRAME=1,STATE="true",NAME="Main tanks"}
HealGroups~f~2!{FRAME=1,STATE="true",NAME="Healers"}
HealGroups~f~3!{FRAME=1,STATE="false",NAME="Private List"}
HealGroups~f~4!{FRAME=1,STATE="false",NAME="Self"}
HealGroups~f~5!{FRAME=1,STATE="true",NAME="Group"}
HealGroups~f~6!{FRAME=1,STATE="false",NAME="Raid"}
HealGroups~f~7!{FRAME=6,STATE="false",NAME="Vehicle"}
HealGroups~f~8!{FRAME=7,STATE="true",NAME="Pets"}
HealGroups~f~9!{FRAME=8,STATE="true",NAME="Target"}
HealGroups~f~10!{FRAME=9,STATE="true",NAME="Focus"}
HealGroups~f~11!{FRAME=10,STATE="true",NAME="Enemy"}
Anchors~f~1!{Y=55.4,GROW=2,BARS=3,FRAME=3,X=45.49}
Anchors~f~2!{Y=62.69,GROW=2,BARS=1,FRAME=1,X=44.34}
Anchors~f~3!{Y=55,GROW=2,BARS=3,FRAME=3,X=96.42}
Anchors~f~4!{Y=64.17,GROW=2,BARS=1,FRAME=1,X=83.17}
Anchors~f~5!{Y=65.23,GROW=2,BARS=2,FRAME=2,X=89.04}
Anchors~f~6!{Y=55,GROW=2,BARS=1,FRAME=1,X=55}
Anchors~f~7!{Y=52.07,GROW=2,BARS=1,FRAME=1,X=41.65}
Anchors~f~8!{Y=55.4,GROW=2,BARS=1,FRAME=3,X=41.83}
Anchors~f~9!{Y=51.4,GROW=2,BARS=1,FRAME=4,X=41.83}
Anchors~f~10!{Y=54.82,GROW=2,BARS=4,FRAME=2,X=41.72}
HeadBar~f~1!{SHOW="false",TEXTURE="Diagonal",R=0.506,B=0.506,HEIGHT=30,A=0.4,G=0.506,WIDTH=0.9}
HeadBar~f~2!{SHOW="false",TEXTURE="Diagonal",R=0.1,B=0.1,HEIGHT=30,A=0.25,G=0.1,WIDTH=0.9}
HeadBar~d!3~4~5~6~7~8~9~10~
HeadText~f~1!{A=0.7,R=0.2,OFFSET=0,B=0.8,FONT="Friz Quadrata TT",HEIGHT=10,G=0.8,OUTLINE=1}
HeadText~f~2!{A=0.7,R=1,OFFSET=0,B=0.1,FONT="Friz Quadrata TT",HEIGHT=10,G=1,OUTLINE=1}
HeadText~d!3~4~5~6~7~8~9~10~
HealBar~f~1!{HEIGHT=30,GRPCOLS="false",CMARGIN=2,TEXTURE="Smooth v2",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=100,RMARGIN=2,OFIX=1,NUMCOLS=1,LOWMANA=3}
HealBar~f~2!{HEIGHT=30,GRPCOLS="false",CMARGIN=4,TEXTURE="Smooth v2",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=2,NUMCOLS=1,OFIX=1,RMARGIN=4,WIDTH=112}
HealBar~f~3!{HEIGHT=34,GRPCOLS="false",CMARGIN=4,TEXTURE="Smooth v2",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=172,RMARGIN=0,OFIX=1,NUMCOLS=1,LOWMANA=2}
HealBar~d!4~5~6~
HealBar~f~7!{HEIGHT=25,GRPCOLS="false",CMARGIN=4,TEXTURE="Smooth v2",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=100,RMARGIN=1,OFIX=1,NUMCOLS=1,LOWMANA=1}
HealBar~f~8!{HEIGHT=30,GRPCOLS="false",CMARGIN=4,TEXTURE="Smooth v2",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=92,RMARGIN=0,OFIX=1,NUMCOLS=1,LOWMANA=2}
HealBar~d!9~
HealBar~f~10!{HEIGHT=28,GRPCOLS="false",CMARGIN=4,TEXTURE="Smooth v2",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=98,RMARGIN=1,OFIX=1,NUMCOLS=1,LOWMANA=2}
BarCol~f~1!{BACK=2,BA=0,BOUT=0,DISA=0.1,BR=0.506,HB=0.9,BG=0.506,HG=0.2,HA=1,HR=0.2,ORA=0.58,BB=0.506,HLTH=2}
BarCol~d!2~3~4~5~6~7~8~9~10~
BarIACol~f~1!{AC=4,AB=0.973,AA=0.35,AR=0.973,AG=0.973,IC=2,IB=0.953,IA=0.4,IR=1,IG=0.984}
BarIACol~d!2~3~4~5~6~7~8~9~10~
BarText~f~1!{HLTHONBAR="false",TAGOOR="OOR | ",OVERHEAL=1,MAXCHARS=0,CLASSONBAR="false",HFONT="Friz Quadrata TT",OUTLINE=1,INCHEALS=2,OFFSET=0,HLTHTXTANCHOR=1,HLTHTYPE=1,HMAXCHARS=0,CLASSTYPE=1,NUMFORMAT2=1,HOUTLINE=1,NUMFORMAT1=11,FONT="Friz Quadrata TT",NAMEONBAR="true",HEIGHT=12,HHEIGHT=12,SHOWROLE="true",HALIGN=2,TAGRIP="RIP | ",TAGDC="DC | ",IGNOREONFULL="false",INCABSORBS=2,HOFFSET2=0,ALIGN=2,TAGR="R | ",HOFFSET=0}
BarText~d!2~3~4~5~6~7~8~9~10~
BarTextCol~f~1!{HCG=0,NDEBUFF="false",HLTH=1,NCDA=0.15,NCB=0.267,NAME=2,HCB=1,HCR=0.761,NCA=1,NCG=0.843,HCA=1,HDEBUFF="false",NCR=0.949,HCDA=0.1}
BarTextCol~d!2~3~4~5~6~7~8~9~10~
Icons~f~1!{SHOWBUFF="true",POSITION=2,I15EN="false",DOUBLE="true",MAXDICONS=4,SHOWDEBUFF="true",ONBAR=1,FADE="false",DSCALE=1,SHOWDIR="false",SHOWRC="true",SCALE=1,SHOWDIRMOUSE="false",FADESECS=15,MAXBICONS=8}
Icons~d!2~3~4~5~6~
Icons~f~7!{SHOWBUFF="true",POSITION=2,I15EN="false",DOUBLE="true",MAXDICONS=4,SHOWDEBUFF="true",ONBAR=1,FADE="false",DSCALE=1,SHOWDIR="false",SHOWRC="true",SCALE=1,SHOWDIRMOUSE="false",FADESECS=15,MAXBICONS=6}
Icons~f~8!{SHOWBUFF="true",POSITION=2,I15EN="false",DOUBLE="true",MAXDICONS=4,SHOWDEBUFF="true",ONBAR=1,FADE="false",DSCALE=1,SHOWDIR="false",SHOWRC="true",SCALE=1,SHOWDIRMOUSE="false",FADESECS=15,MAXBICONS=8}
Icons~d!9~10~
RaidIcon~f~1!{SQUARE="true",CIRCLE="true",DIAMOND="true",SHOW="true",SKULL="true",TRIANGLE="true",STAR="true",MOON="true",CROSS="true"}
RaidIcon~d!2~3~4~5~6~7~8~9~10~
IconText~f~1!{SDUR="true",HEIGHT=10,SSCNT="false",SCNT="true",DURTHRH=9,FONT="Friz Quadrata TT",DURWARN=3,SSDUR="true",OUTLINE=2}
IconText~d!2~3~4~5~6~7~8~9~10~
BarVisibility~f~1!{INCCLASSES=1,ALERTIC=0.98,ALERTOC=0.95,HIDEOOR="false"}
BarVisibility~f~2!{INCCLASSES=1,ALERTIC=0.99,ALERTOC=0.97,HIDEOOR="false"}
BarVisibility~f~3!{INCCLASSES=1,ALERTIC=0.95,ALERTOC=0.9,HIDEOOR="false"}
BarVisibility~d!4~5~6~7~
BarVisibility~f~8!{INCCLASSES=1,ALERTIC=1,ALERTOC=1,HIDEOOR="false"}
BarVisibility~d!9~
BarVisibility~f~10!{INCCLASSES=1,ALERTIC=0.95,ALERTOC=0.9,HIDEOOR="false"}
BarSort~f~1!{SUBORDER=4,OORLAST="false",RAIDORDER=2,SUBPF="true"}
BarSort~d!2~3~4~5~6~7~8~9~10~
BarAggro~f~1!{B=0.075,ALERTIND=2,G=0.173,TEXTFORMAT=3,SHOW="true",SHOWTEXTPCT="true",SHOWIND="false",R=0.969,SHOWTEXT="false",ALERT=2}
BarAggro~d!2~3~4~5~6~7~8~9~10~
AuxBarFrame~f~1!{OVERLAP=1}
AuxBarFrame~d!2~3~4~5~6~7~8~9~10~
AuxBar^1~f~1!{SIZE=1,USE=4,B=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=3,R=1,G=1,OTYPE=1}
AuxBar^1~d!2~3~4~5~6~7~8~9~10~
AuxBar^2~f~1!{SIZE=0.4,USE=9,B=1,COLOUR=1,ANCHOR=2,OFFSET=1,DEPTH=2,R=0.761,G=0,OTYPE=2}
AuxBar^2~d!2~3~4~5~6~7~8~9~
AuxBar^2~f~10!{SIZE=0.4,USE=1,B=1,COLOUR=1,ANCHOR=2,OFFSET=1,DEPTH=2,R=0.761,G=0,OTYPE=2}
AuxBar^3~f~1!{SIZE=0.4,USE=10,B=0.58,COLOUR=1,ANCHOR=2,OFFSET=-2,DEPTH=2,R=0.357,G=0.122,OTYPE=2}
AuxBar^3~d!2~3~4~5~6~7~8~9~
AuxBar^3~f~10!{SIZE=0.4,USE=1,B=0.58,COLOUR=1,ANCHOR=2,OFFSET=-2,DEPTH=2,R=0.357,G=0.122,OTYPE=2}
AuxBar^4~f~1!{SIZE=0.98,USE=1,B=1,COLOUR=1,ANCHOR=3,OFFSET=0,DEPTH=4,R=1,G=1,OTYPE=1}
AuxBar^4~d!2~3~4~5~6~7~8~9~10~
AuxBar^5~f~1!{SIZE=0.98,USE=5,B=1,COLOUR=1,ANCHOR=2,OFFSET=0,DEPTH=1,R=1,G=1,OTYPE=1}
AuxBar^5~d!2~3~4~5~6~7~8~9~
AuxBar^5~f~10!{SIZE=0.98,USE=1,B=1,COLOUR=1,ANCHOR=2,OFFSET=0,DEPTH=1,R=1,G=1,OTYPE=1}
AuxBar^6~f~1!{SIZE=0.98,USE=1,B=1,COLOUR=3,ANCHOR=4,OFFSET=1,DEPTH=4,R=1,G=1,OTYPE=1}
AuxBar^6~d!2~3~4~5~6~7~8~9~10~
AuxBar^7~f~1!{SIZE=0.98,USE=1,B=1,COLOUR=1,ANCHOR=4,OFFSET=1,DEPTH=3,R=1,G=1,OTYPE=2}
AuxBar^7~d!2~3~4~5~6~7~8~9~10~
AuxBar^8~f~1!{SIZE=0.98,USE=1,B=0.251,COLOUR=3,ANCHOR=3,OFFSET=1,DEPTH=2,R=1,G=0.557,OTYPE=2}
AuxBar^8~d!2~3~4~5~6~7~8~9~10~
AuxBar^9~f~1!{SIZE=0.98,USE=1,B=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,R=1,G=1,OTYPE=1}
AuxBar^9~d!2~3~4~5~6~7~8~9~10~
Complete!]]
HealBot_ExtraSkinData[41]=[[Skin
RAID 40 RAVERA
Author~v!Ravera de Mandokir
DuplicateBars~v!false
Chat~t!{EOCOOM="false",EOCOOMV=20,MSG="Casting #s on #n",RESONLY="true",NOTIFY=5}
General~t!{OFREQ=0.07,OMIN=0.1,OMAX=0.95,FLUIDFREQ=10,STICKYSENSITIVITY=45,FLUIDBARS="true",LOWMANACOMBAT="false",HIDEBOSSF="false",HIDEPTF="false",STICKYFRAME="true",HIDERAIDF="true",HIDEPARTYF="false"}
Healing~t!{TONLYFRIEND="false",FEXRAID="false",FOCUSINCOMBAT=2,GROUPPETS="true",SELFPET="false",FONLYFRIEND="false",TEXRAID="false",TARGETINCOMBAT=2}
Enemy~t!{INCARENA="true",INCTANKS="true",INCMYTAR="false",INCARENAPETS="false",ENEMYTARGET="false",ENEMYTARGETSIZE=40,INCSELF="false",NUMBOSS=2,EXISTSHOWPTAR=1,HIDE="true",EXISTSHOWBOSS="true",DOUBLEWIDTH="false",EXISTSHOWARENA=3}
FrameAlias~f~1!{SIZE=12,NAME="",R=1,ALIAS="Frame 1",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~2!{SIZE=12,NAME="",R=1,ALIAS="Frame 2",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~d!3~4~5~
FrameAlias~f~6!{SIZE=12,NAME="Vehicle",R=1,ALIAS="Vehicle",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~7!{SIZE=12,NAME="Pets",R=1,ALIAS="Pets",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~8!{SIZE=12,NAME="Target",R=1,ALIAS="Target",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~9!{SIZE=12,NAME="Focus",R=1,ALIAS="Focus",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~10!{SIZE=12,NAME="Enemy",R=1,ALIAS="Enemy",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAliasBar~f~1!{A=0.2,TEXTURE="Skewed",B=0.1,HEIGHT=20,R=0.1,G=0.1,WIDTH=0.9}
FrameAliasBar~d!2~3~4~5~6~7~8~9~10~
Frame~f~1!{BACKR=0.1,BACKG=0.1,TIPLOC=5,BACKB=0.7,LOCKED="true",SCALE=1.05,BORDERA=0.04,SFOFFSETV=0,AUTOCLOSE="false",BORDERB=0.1,BACKA=0.1,OPENSOUND="false",BORDERG=0.1,BORDERR=0.1,SFOFFSETH=0}
Frame~f~2!{BACKR=0.1,BACKG=0.1,TIPLOC=5,BACKB=0.7,LOCKED="false",SCALE=1,BORDERA=0.04,SFOFFSETV=-8,AUTOCLOSE="false",BORDERB=0.1,BACKA=0.1,OPENSOUND="false",BORDERG=0.1,BORDERR=0.1,SFOFFSETH=0}
Frame~f~3!{BACKR=0.1,BACKG=0.1,TIPLOC=5,BACKB=0.7,LOCKED="false",SCALE=1,BORDERA=0.04,SFOFFSETV=0,AUTOCLOSE="false",BORDERB=0.1,BACKA=0.1,OPENSOUND="false",BORDERG=0.1,BORDERR=0.1,SFOFFSETH=0}
Frame~d!4~5~6~
Frame~f~7!{BACKR=0.1,BACKG=0.1,TIPLOC=5,BACKB=0.7,LOCKED="false",SCALE=1,BORDERA=0.04,SFOFFSETV=0,AUTOCLOSE="false",BORDERB=0.1,BACKA=0.1,OPENSOUND="false",BORDERG=0.1,BORDERR=0.1,SFOFFSETH=-8}
Frame~f~8!{BACKR=0.1,BACKG=0.1,TIPLOC=5,BACKB=0.7,LOCKED="false",SCALE=1,BORDERA=0.04,SFOFFSETV=1,AUTOCLOSE="false",BORDERB=0.1,BACKA=0.1,OPENSOUND="false",BORDERG=0.1,BORDERR=0.1,SFOFFSETH=9}
Frame~f~9!{BACKR=0.1,BACKG=0.1,TIPLOC=5,BACKB=0.7,LOCKED="false",SCALE=1,BORDERA=0.04,SFOFFSETV=0,AUTOCLOSE="false",BORDERB=0.1,BACKA=0.1,OPENSOUND="false",BORDERG=0.1,BORDERR=0.1,SFOFFSETH=9}
Frame~f~10!{BACKR=0.1,BACKG=0.1,TIPLOC=5,BACKB=0.7,LOCKED="false",SCALE=1,BORDERA=0.04,SFOFFSETV=0,AUTOCLOSE="false",BORDERB=0.1,BACKA=0.1,OPENSOUND="false",BORDERG=0.1,BORDERR=0.1,SFOFFSETH=0}
StickyFrames~f~1!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~f~2!{STUCK="true",STUCKTOPOINT="TOPLEFT",STUCKTO=1,STUCKPOINT="BOTTOMLEFT"}
StickyFrames~f~3!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~d!4~5~6~
StickyFrames~f~7!{STUCK="true",STUCKTOPOINT="TOPRIGHT",STUCKTO=1,STUCKPOINT="TOPLEFT"}
StickyFrames~f~8!{STUCK="true",STUCKTOPOINT="TOPLEFT",STUCKTO=1,STUCKPOINT="TOPRIGHT"}
StickyFrames~f~9!{STUCK="true",STUCKTOPOINT="LEFT",STUCKTO=1,STUCKPOINT="RIGHT"}
StickyFrames~f~10!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
HealGroups~f~1!{FRAME=1,STATE="true",NAME="Main tanks"}
HealGroups~f~2!{FRAME=1,STATE="true",NAME="Self"}
HealGroups~f~3!{FRAME=1,STATE="true",NAME="Healers"}
HealGroups~f~4!{FRAME=1,STATE="true",NAME="Group"}
HealGroups~f~5!{FRAME=1,STATE="true",NAME="Raid"}
HealGroups~f~6!{FRAME=1,STATE="false",NAME="Private List"}
HealGroups~f~7!{FRAME=6,STATE="false",NAME="Vehicle"}
HealGroups~f~8!{FRAME=7,STATE="false",NAME="Pets"}
HealGroups~f~9!{FRAME=8,STATE="false",NAME="Target"}
HealGroups~f~10!{FRAME=9,STATE="false",NAME="Focus"}
HealGroups~f~11!{FRAME=10,STATE="false",NAME="Enemy"}
Anchors~f~1!{Y=35.55,GROW=1,BARS=1,FRAME=1,X=41.87}
Anchors~f~2!{Y=33.29,GROW=2,BARS=3,FRAME=2,X=42}
Anchors~f~3!{Y=52,GROW=2,BARS=3,FRAME=3,X=52}
Anchors~f~4!{Y=53,GROW=2,BARS=3,FRAME=3,X=53}
Anchors~f~5!{Y=54,GROW=2,BARS=3,FRAME=3,X=54}
Anchors~f~6!{Y=55,GROW=2,BARS=3,FRAME=3,X=55}
Anchors~f~7!{Y=35.55,GROW=2,BARS=3,FRAME=3,X=60.28}
Anchors~f~8!{Y=64.1,GROW=2,BARS=3,FRAME=3,X=74.2}
Anchors~f~9!{Y=27.63,GROW=2,BARS=3,FRAME=3,X=96.72}
Anchors~f~10!{Y=59,GROW=2,BARS=3,FRAME=3,X=59}
HeadBar~f~1!{SHOW="false",TEXTURE="HealBot 10",R=0.1,B=0.1,HEIGHT=20,A=0.2,G=0.1,WIDTH=0.89}
HeadBar~f~2!{SHOW="false",TEXTURE="Skewed",R=0.1,B=0.1,HEIGHT=20,A=0.2,G=0.1,WIDTH=0.9}
HeadBar~d!3~4~5~6~7~8~9~10~
HeadText~f~1!{A=0.4,R=1,OFFSET=0,B=0.1,FONT="Friz Quadrata TT",HEIGHT=9,G=1,OUTLINE=1}
HeadText~d!2~3~4~5~6~7~8~9~10~
HealBar~f~1!{HEIGHT=27,GRPCOLS="false",CMARGIN=0,TEXTURE="HealBot 10",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=58,RMARGIN=0,OFIX=1,NUMCOLS=8,LOWMANA=2}
HealBar~f~2!{HEIGHT=32,GRPCOLS="false",CMARGIN=0,TEXTURE="Tukui2",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=154,RMARGIN=0,OFIX=1,NUMCOLS=2,LOWMANA=1}
HealBar~f~3!{HEIGHT=32,GRPCOLS="false",CMARGIN=2,TEXTURE="Tukui2",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=75,RMARGIN=2,OFIX=1,NUMCOLS=2,LOWMANA=1}
HealBar~d!4~5~6~
HealBar~f~7!{HEIGHT=27,GRPCOLS="false",CMARGIN=1,TEXTURE="Tukui2",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=49,RMARGIN=0,OFIX=1,NUMCOLS=1,LOWMANA=1}
HealBar~f~8!{HEIGHT=32,GRPCOLS="false",CMARGIN=2,TEXTURE="Tukui2",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=75,RMARGIN=0,OFIX=1,NUMCOLS=2,LOWMANA=1}
HealBar~d!9~
HealBar~f~10!{HEIGHT=32,GRPCOLS="false",CMARGIN=2,TEXTURE="Tukui2",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=75,RMARGIN=2,OFIX=1,NUMCOLS=2,LOWMANA=1}
BarCol~f~1!{BACK=3,BA=0.75,BOUT=0,DISA=0.75,BR=0.043,HB=0.4,BG=0.09,HG=0.4,HA=0.95,HR=0.2,ORA=0.4,BB=0.09,HLTH=2}
BarCol~f~2!{BACK=2,BA=0.05,BOUT=1,DISA=0.12,BR=0.2,HB=0.4,BG=0.4,HG=0.4,HA=0.95,HR=0.2,ORA=0.3,BB=0.4,HLTH=2}
BarCol~d!3~4~5~6~7~8~9~10~
BarIACol~f~1!{AC=3,AB=1,AA=0.5,AR=1,AG=1,IC=4,IB=0.2,IA=0.9,IR=0.2,IG=0.8}
BarIACol~f~2!{AC=3,AB=1,AA=0.5,AR=1,AG=1,IC=4,IB=0.2,IA=0.58,IR=0.2,IG=0.8}
BarIACol~d!3~4~5~6~7~8~9~10~
BarText~f~1!{HLTHONBAR="true",TAGOOR="",IGNOREONFULL="true",MAXCHARS=10,HMAXCHARS=0,OUTLINE=1,CLASSONBAR="false",HOUTLINE=1,INCHEALS=2,HLTHTXTANCHOR=1,FONT="Friz Quadrata TT",CLASSTYPE=1,HLTHTYPE=3,NUMFORMAT2=1,OVERHEAL=1,TAGDC="",TAGRIP="",NAMEONBAR="true",HEIGHT=8,OFFSET=-1,SHOWROLE="true",HALIGN=2,HFONT="Friz Quadrata TT",NUMFORMAT1=11,HHEIGHT=10,INCABSORBS=1,HOFFSET2=0,ALIGN=2,TAGR="",HOFFSET=0}
BarText~f~2!{HLTHONBAR="true",TAGOOR="",IGNOREONFULL="true",MAXCHARS=0,HMAXCHARS=0,OUTLINE=1,CLASSONBAR="false",HOUTLINE=1,INCHEALS=2,HLTHTXTANCHOR=1,FONT="Friz Quadrata TT",CLASSTYPE=1,HLTHTYPE=3,NUMFORMAT2=1,OVERHEAL=1,TAGDC="",TAGRIP="",NAMEONBAR="true",HEIGHT=10,OFFSET=0,SHOWROLE="true",HALIGN=2,HFONT="Friz Quadrata TT",NUMFORMAT1=11,HHEIGHT=10,INCABSORBS=1,HOFFSET2=0,ALIGN=2,TAGR="",HOFFSET=0}
BarText~f~3!{HLTHONBAR="true",TAGOOR="[ OOR ] ",IGNOREONFULL="true",MAXCHARS=0,HMAXCHARS=0,OUTLINE=1,CLASSONBAR="false",HOUTLINE=1,INCHEALS=2,HLTHTXTANCHOR=1,FONT="Friz Quadrata TT",CLASSTYPE=1,HLTHTYPE=3,NUMFORMAT2=1,OVERHEAL=1,TAGDC="[ DC ] ",TAGRIP="[ RIP ] ",NAMEONBAR="true",HEIGHT=10,OFFSET=0,SHOWROLE="true",HALIGN=2,HFONT="Friz Quadrata TT",NUMFORMAT1=11,HHEIGHT=10,INCABSORBS=1,HOFFSET2=0,ALIGN=2,TAGR="[ R ] ",HOFFSET=0}
BarText~d!4~5~6~
BarText~f~7!{HLTHONBAR="false",TAGOOR="",IGNOREONFULL="true",MAXCHARS=8,HMAXCHARS=0,OUTLINE=1,CLASSONBAR="false",HOUTLINE=1,INCHEALS=2,HLTHTXTANCHOR=1,FONT="Friz Quadrata TT",CLASSTYPE=1,HLTHTYPE=3,NUMFORMAT2=1,OVERHEAL=1,TAGDC="",TAGRIP="",NAMEONBAR="true",HEIGHT=10,OFFSET=0,SHOWROLE="true",HALIGN=2,HFONT="Friz Quadrata TT",NUMFORMAT1=11,HHEIGHT=10,INCABSORBS=1,HOFFSET2=0,ALIGN=2,TAGR="",HOFFSET=0}
BarText~f~8!{HLTHONBAR="true",TAGOOR="",IGNOREONFULL="true",MAXCHARS=0,HMAXCHARS=0,OUTLINE=1,CLASSONBAR="false",HOUTLINE=1,INCHEALS=2,HLTHTXTANCHOR=1,FONT="Friz Quadrata TT",CLASSTYPE=1,HLTHTYPE=3,NUMFORMAT2=1,OVERHEAL=1,TAGDC="",TAGRIP="",NAMEONBAR="true",HEIGHT=10,OFFSET=0,SHOWROLE="true",HALIGN=2,HFONT="Friz Quadrata TT",NUMFORMAT1=11,HHEIGHT=10,INCABSORBS=1,HOFFSET2=0,ALIGN=2,TAGR="",HOFFSET=0}
BarText~d!9~
BarText~f~10!{HLTHONBAR="true",TAGOOR="[ OOR ] ",IGNOREONFULL="true",MAXCHARS=0,HMAXCHARS=0,OUTLINE=1,CLASSONBAR="false",HOUTLINE=1,INCHEALS=2,HLTHTXTANCHOR=1,FONT="Friz Quadrata TT",CLASSTYPE=1,HLTHTYPE=3,NUMFORMAT2=1,OVERHEAL=1,TAGDC="[ DC ] ",TAGRIP="[ RIP ] ",NAMEONBAR="true",HEIGHT=10,OFFSET=0,SHOWROLE="true",HALIGN=2,HFONT="Friz Quadrata TT",NUMFORMAT1=11,HHEIGHT=10,INCABSORBS=1,HOFFSET2=0,ALIGN=2,TAGR="[ R ] ",HOFFSET=0}
BarTextCol~f~1!{NAME=3,NDEBUFF="false",HLTH=3,NCDA=1,HCG=1,NCA=1,NCG=1,HCR=0.973,HCB=0.992,HCA=1,NCR=0.973,HDEBUFF="false",NCB=0.992,HCDA=1}
BarTextCol~f~2!{NAME=2,NDEBUFF="false",HLTH=2,NCDA=0.7,HCG=1,NCA=1,NCG=1,HCR=1,HCB=0,HCA=1,NCR=1,HDEBUFF="false",NCB=0,HCDA=0.7}
BarTextCol~d!3~4~5~6~7~8~9~10~
Icons~f~1!{SHOWBUFF="true",POSITION=2,I15EN="true",MAXDICONS=2,DOUBLE="true",FADE="false",SHOWDIR="false",SHOWDIRMOUSE="false",DSCALE=1,ONBAR=1,SHOWRC="true",SCALE=1,SHOWDEBUFF="true",FADESECS=15,MAXBICONS=4}
Icons~f~2!{SHOWBUFF="true",POSITION=2,I15EN="true",MAXDICONS=2,DOUBLE="true",FADE="false",SHOWDIR="false",SHOWDIRMOUSE="false",DSCALE=1,ONBAR=1,SHOWRC="true",SCALE=1,SHOWDEBUFF="true",FADESECS=15,MAXBICONS=5}
Icons~f~3!{SHOWBUFF="true",POSITION=2,I15EN="true",MAXDICONS=2,DOUBLE="true",FADE="false",SHOWDIR="false",SHOWDIRMOUSE="false",DSCALE=1,ONBAR=1,SHOWRC="true",SCALE=1,SHOWDEBUFF="true",FADESECS=15,MAXBICONS=4}
Icons~d!4~5~
Icons~f~6!{SHOWBUFF="true",POSITION=2,I15EN="true",MAXDICONS=3,DOUBLE="true",FADE="false",SHOWDIR="false",SHOWDIRMOUSE="false",DSCALE=1,ONBAR=1,SHOWRC="true",SCALE=1,SHOWDEBUFF="true",FADESECS=15,MAXBICONS=8}
Icons~f~7!{SHOWBUFF="true",POSITION=2,I15EN="true",MAXDICONS=2,DOUBLE="true",FADE="false",SHOWDIR="false",SHOWDIRMOUSE="false",DSCALE=1,ONBAR=1,SHOWRC="true",SCALE=1,SHOWDEBUFF="true",FADESECS=15,MAXBICONS=4}
Icons~f~8!{SHOWBUFF="true",POSITION=2,I15EN="true",MAXDICONS=2,DOUBLE="true",FADE="false",SHOWDIR="false",SHOWDIRMOUSE="false",DSCALE=1,ONBAR=1,SHOWRC="true",SCALE=1,SHOWDEBUFF="true",FADESECS=15,MAXBICONS=6}
Icons~d!9~
Icons~f~10!{SHOWBUFF="true",POSITION=2,I15EN="true",MAXDICONS=3,DOUBLE="true",FADE="false",SHOWDIR="false",SHOWDIRMOUSE="false",DSCALE=1,ONBAR=1,SHOWRC="true",SCALE=1,SHOWDEBUFF="true",FADESECS=15,MAXBICONS=8}
RaidIcon~f~1!{SQUARE="true",CIRCLE="true",DIAMOND="true",SHOW="true",SKULL="true",TRIANGLE="true",STAR="true",CROSS="true",MOON="true"}
RaidIcon~d!2~3~4~5~6~7~8~9~10~
IconText~f~1!{DURWARN=3,HEIGHT=10,SSCNT="false",SCNT="true",DURTHRH=10,FONT="Friz Quadrata TT",SDUR="true",SSDUR="false",OUTLINE=2}
IconText~f~2!{DURWARN=3,HEIGHT=10,SSCNT="false",SCNT="true",DURTHRH=9,FONT="Friz Quadrata TT",SDUR="true",SSDUR="false",OUTLINE=2}
IconText~d!3~4~5~
IconText~f~6!{DURWARN=3,HEIGHT=10,SSCNT="false",SCNT="true",DURTHRH=9,FONT="Friz Quadrata TT",SDUR="false",SSDUR="true",OUTLINE=2}
IconText~d!7~8~9~10~
BarVisibility~f~1!{INCCLASSES=1,ALERTIC=0.95,ALERTOC=0.55,HIDEOOR="false"}
BarVisibility~f~2!{INCCLASSES=1,ALERTIC=0.95,ALERTOC=0.85,HIDEOOR="false"}
BarVisibility~d!3~4~5~
BarVisibility~f~6!{INCCLASSES=1,ALERTIC=0.85,ALERTOC=0.7,HIDEOOR="false"}
BarVisibility~d!7~
BarVisibility~f~8!{INCCLASSES=1,ALERTIC=0.95,ALERTOC=0.85,HIDEOOR="false"}
BarVisibility~d!9~10~
BarSort~f~1!{SUBORDER=4,OORLAST="true",RAIDORDER=2,SUBPF="true"}
BarSort~f~2!{SUBORDER=1,OORLAST="false",RAIDORDER=3,SUBPF="true"}
BarSort~d!3~4~5~6~7~8~9~10~
BarAggro~f~1!{R=1,SHOWTEXT="false",G=0,TEXTFORMAT=3,SHOW="true",SHOWTEXTPCT="false",ALERTIND=2,SHOWIND="true",B=0,ALERT=3}
BarAggro~d!2~3~4~5~6~7~8~9~10~
AuxBarFrame~f~1!{OVERLAP=1}
AuxBarFrame~d!2~3~4~5~6~7~8~9~10~
AuxBar^1~f~1!{SIZE=0.98,USE=4,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=3,G=1,B=1,OTYPE=1}
AuxBar^1~f~2!{SIZE=0.98,USE=4,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=2,G=1,B=1,OTYPE=1}
AuxBar^1~d!3~4~5~6~
AuxBar^1~f~7!{SIZE=0.98,USE=4,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=1,G=1,B=1,OTYPE=1}
AuxBar^1~d!8~9~
AuxBar^1~f~10!{SIZE=0.98,USE=4,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=2,G=1,B=1,OTYPE=1}
AuxBar^2~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,OTYPE=1}
AuxBar^2~d!2~3~4~5~6~7~8~9~10~
AuxBar^3~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,OTYPE=1}
AuxBar^3~d!2~3~4~5~6~7~8~9~10~
AuxBar^4~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,OTYPE=1}
AuxBar^4~d!2~3~4~5~6~7~8~9~10~
AuxBar^5~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,OTYPE=1}
AuxBar^5~f~2!{SIZE=0.98,USE=5,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=2,G=1,B=1,OTYPE=1}
AuxBar^5~d!3~4~5~6~
AuxBar^5~f~7!{SIZE=0.98,USE=5,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=1,G=1,B=1,OTYPE=1}
AuxBar^5~d!8~9~
AuxBar^5~f~10!{SIZE=0.98,USE=5,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=2,G=1,B=1,OTYPE=1}
AuxBar^6~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,OTYPE=1}
AuxBar^6~d!2~3~4~5~6~7~8~9~10~
AuxBar^7~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,OTYPE=1}
AuxBar^7~d!2~3~4~5~6~7~8~9~10~
AuxBar^8~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,OTYPE=1}
AuxBar^8~d!2~3~4~5~6~7~8~9~10~
AuxBar^9~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,OTYPE=1}
AuxBar^9~d!2~3~4~5~6~7~8~9~10~
Complete!]]
HealBot_ExtraSkinData[42]=[[Skin
Group 5
Author~v!Monti of Terenas
DuplicateBars~v!false
Chat~t!{EOCOOM="false",EOCOOMV=20,MSG="Casting #s on #n",RESONLY="true",CHAN="",NOTIFY=1}
General~t!{OFREQ=0.07,OMIN=0.1,OMAX=0.95,FLUIDFREQ=10,HIDEPARTYF="true",HIDEBOSSF="true",HIDERAIDF="true",STICKYSENSITIVITY=19,STICKYFRAME="true",FLUIDBARS="true",HIDEPTF="false"}
Healing~t!{TINCSELF="false",GROUPPETS="true",TARGETINCOMBAT=1,TINCGROUP="true",FONLYFRIEND="true",TINCPET="false",TONLYFRIEND="false",FALWAYSSHOW="false",FOCUSINCOMBAT=2,TALWAYSSHOW="false",FEXRAID="false",TINCRAID="true",TEXRAID="false",SELFPET=0}
Enemy~t!{ENEMYTARGET="false",INCTANKS="true",INCMYTAR="false",INCARENA="false",INCARENAPETS="false",ENEMYTARGETSIZE=40,INCSELF="false",NUMBOSS=4,EXISTSHOWPTAR=1,HIDE="true",EXISTSHOWBOSS="true",DOUBLEWIDTH="false",EXISTSHOWARENA=2}
FrameAlias~f~1!{SIZE=12,NAME="Party",R=1,ALIAS="Group",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~2!{SIZE=12,NAME="Tank and Healer",R=1,ALIAS="Tank and Healer",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~3!{SIZE=12,NAME="Pets",R=1,ALIAS="Not Used 1",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~4!{SIZE=12,NAME="Focus and Target",R=1,ALIAS="Not Used 2",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~5!{SIZE=12,NAME="Enemy",R=1,ALIAS="Not Used 3",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~6!{SIZE=12,NAME="",R=1,ALIAS="Vehicle",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~7!{SIZE=12,NAME="Pets",R=1,ALIAS="Pets",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~8!{SIZE=12,NAME="Target",R=1,ALIAS="Target",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~9!{SIZE=12,NAME="",R=1,ALIAS="Focus",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~10!{SIZE=12,NAME="",R=1,ALIAS="Enemy",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAliasBar~f~1!{A=0.25,WIDTH=0.9,B=0.1,HEIGHT=20,R=0.1,G=0.1,TEXTURE="Diagonal"}
FrameAliasBar~d!2~3~4~5~6~7~8~9~10~
Frame~f~1!{BACKR=0.506,SFOFFSETH=0,BORDERR=1,BORDERG=1,LOCKED="true",OPENSOUND="false",BORDERA=0.14,SFOFFSETV=0,BACKG=0.506,BACKB=0.506,BACKA=0,SCALE=1,BORDERB=1,AUTOCLOSE="false",TIPLOC=2}
Frame~f~2!{BACKR=0.1,SFOFFSETH=0,BORDERR=0.1,BORDERG=0.1,LOCKED="false",OPENSOUND="false",BORDERA=0.5,SFOFFSETV=0,BACKG=0.1,BACKB=0.5,BACKA=0.2,SCALE=1,BORDERB=0.1,AUTOCLOSE="false",TIPLOC=1}
Frame~f~3!{BACKR=0.1,SFOFFSETH=0,BORDERR=0.1,BORDERG=0.1,LOCKED="false",OPENSOUND="false",BORDERA=0.5,SFOFFSETV=0,BACKG=0.1,BACKB=0.5,BACKA=0.2,SCALE=1,BORDERB=0.1,AUTOCLOSE="false",TIPLOC=2}
Frame~d!4~
Frame~f~5!{BACKR=0.1,SFOFFSETH=0,BORDERR=0.1,BORDERG=0.1,LOCKED="false",OPENSOUND="false",BORDERA=0.5,SFOFFSETV=0,BACKG=0.1,BACKB=0.5,BACKA=0.2,SCALE=1,BORDERB=0.1,AUTOCLOSE="false",TIPLOC=4}
Frame~f~6!{BACKR=0.1,SFOFFSETH=0,BORDERR=0.1,BORDERG=0.1,LOCKED="false",OPENSOUND="false",BORDERA=0.5,SFOFFSETV=0,BACKG=0.1,BACKB=0.5,BACKA=0.2,SCALE=1,BORDERB=0.1,AUTOCLOSE="false",TIPLOC=5}
Frame~d!7~
Frame~f~8!{SFOFFSETH=5,TIPLOC=5,AUTOCLOSE="false",BORDERB=0.1,LOCKED="false",SCALE=1,BORDERA=0.5,BORDERG=0.1,BACKG=0.1,BACKB=0.5,BACKA=0.2,OPENSOUND="false",BACKR=0.1,SFOFFSETV=0,BORDERR=0.1}
Frame~f~9!{SFOFFSETH=0,TIPLOC=5,AUTOCLOSE="false",BORDERB=0.1,LOCKED="false",SCALE=1,BORDERA=0.5,BORDERG=0.1,BACKG=0.1,BACKB=0.5,BACKA=0.2,OPENSOUND="false",BACKR=0.1,SFOFFSETV=5,BORDERR=0.1}
Frame~f~10!{BACKR=0.102,SFOFFSETH=0,BORDERR=0.102,BORDERG=0.102,LOCKED="true",OPENSOUND="false",BORDERA=0.1,SFOFFSETV=0,BACKG=0.102,BACKB=0.502,BACKA=0.05,SCALE=1,BORDERB=0.102,AUTOCLOSE="false",TIPLOC=4}
StickyFrames~f~1!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~d!2~3~4~5~6~
StickyFrames~f~7!{STUCK="true",STUCKTOPOINT="TOPRIGHT",STUCKTO=1,STUCKPOINT="TOPLEFT"}
StickyFrames~f~8!{STUCK="true",STUCKTOPOINT="TOPLEFT",STUCKTO=1,STUCKPOINT="TOPRIGHT"}
StickyFrames~f~9!{STUCK="true",STUCKTOPOINT="BOTTOMRIGHT",STUCKTO=8,STUCKPOINT="TOPRIGHT"}
StickyFrames~f~10!{STUCK="true",STUCKTOPOINT="TOPRIGHT",STUCKTO=1,STUCKPOINT="BOTTOMRIGHT"}
HealGroups~f~1!{FRAME=1,STATE="true",NAME="Main tanks"}
HealGroups~f~2!{FRAME=1,STATE="true",NAME="Private List"}
HealGroups~f~3!{FRAME=1,STATE="false",NAME="Self"}
HealGroups~f~4!{FRAME=1,STATE="true",NAME="Healers"}
HealGroups~f~5!{FRAME=1,STATE="true",NAME="Group"}
HealGroups~f~6!{FRAME=1,STATE="false",NAME="Raid"}
HealGroups~f~7!{FRAME=6,STATE="false",NAME="Vehicle"}
HealGroups~f~8!{FRAME=1,STATE="true",NAME="Pets"}
HealGroups~f~9!{FRAME=8,STATE="true",NAME="Target"}
HealGroups~f~10!{FRAME=9,STATE="true",NAME="Focus"}
HealGroups~f~11!{FRAME=10,STATE="true",NAME="Enemy"}
Anchors~f~1!{Y=68.33,GROW=2,BARS=3,FRAME=3,X=95.11}
Anchors~f~2!{Y=64.2,GROW=2,BARS=1,FRAME=1,X=88.81}
Anchors~f~3!{Y=54.67,GROW=2,BARS=3,FRAME=3,X=88.79}
Anchors~f~4!{Y=64.17,GROW=2,BARS=1,FRAME=1,X=83.17}
Anchors~f~5!{Y=65.23,GROW=2,BARS=2,FRAME=2,X=89.04}
Anchors~f~6!{Y=55,GROW=2,BARS=1,FRAME=1,X=55}
Anchors~f~7!{Y=49.67,GROW=2,BARS=1,FRAME=1,X=88.64}
Anchors~f~8!{Y=68.33,GROW=2,BARS=1,FRAME=3,X=88.94}
Anchors~f~9!{Y=65.08,GROW=2,BARS=1,FRAME=3,X=88.94}
Anchors~f~10!{Y=68.33,GROW=2,BARS=4,FRAME=4,X=95.11}
HeadBar~f~1!{SHOW="false",WIDTH=0.9,B=0.506,R=0.506,HEIGHT=28,A=0.4,G=0.506,TEXTURE="Diagonal"}
HeadBar~f~2!{SHOW="false",WIDTH=0.9,B=0.1,R=0.1,HEIGHT=28,A=0.25,G=0.1,TEXTURE="Diagonal"}
HeadBar~d!3~4~5~6~7~8~9~10~
HeadText~f~1!{A=0.7,B=0.8,OFFSET=0,R=0.2,FONT="Friz Quadrata TT",HEIGHT=10,G=0.8,OUTLINE=1}
HeadText~f~2!{A=0.7,B=0.1,OFFSET=0,R=1,FONT="Friz Quadrata TT",HEIGHT=10,G=1,OUTLINE=1}
HeadText~d!3~4~5~6~7~8~9~10~
HealBar~f~1!{HEIGHT=34,GRPCOLS="false",CMARGIN=4,TEXTURE="Smooth v2",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=2,NUMCOLS=1,OFIX=1,RMARGIN=0,WIDTH=172}
HealBar~d!2~3~4~5~6~
HealBar~f~7!{HEIGHT=34,GRPCOLS="false",CMARGIN=4,TEXTURE="Smooth v2",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=2,NUMCOLS=3,OFIX=1,RMARGIN=0,WIDTH=172}
HealBar~f~8!{HEIGHT=34,GRPCOLS="false",CMARGIN=4,TEXTURE="Smooth v2",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=2,NUMCOLS=1,OFIX=1,RMARGIN=0,WIDTH=170}
HealBar~d!9~
HealBar~f~10!{HEIGHT=34,GRPCOLS="false",CMARGIN=4,TEXTURE="Smooth v2",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=2,NUMCOLS=2,OFIX=1,RMARGIN=0,WIDTH=172}
BarCol~f~1!{BACK=2,BA=0.2,BOUT=0,DISA=0,BR=0.506,HB=0.9,BB=0.506,BG=0.506,HA=1,HG=0.2,ORA=0.32,HR=0.2,HLTH=1}
BarCol~f~2!{BACK=2,BA=0.34,BOUT=0,DISA=0,BR=0.624,HB=1,BB=1,BG=0.914,HA=1,HG=1,ORA=0.55,HR=1,HLTH=1}
BarCol~f~3!{BACK=2,BA=0.24,BOUT=0,DISA=0,BR=1,HB=1,BB=1,BG=1,HA=1,HG=1,ORA=0.55,HR=1,HLTH=1}
BarCol~d!4~5~6~
BarCol~f~7!{BACK=2,BA=0.24,BOUT=0,DISA=0,BR=1,HB=1,BB=1,BG=1,HA=0.95,HG=1,ORA=0.55,HR=1,HLTH=1}
BarCol~f~8!{BACK=2,BA=0.24,BOUT=0,DISA=0,BR=1,HB=1,BB=1,BG=1,HA=1,HG=1,ORA=0.55,HR=1,HLTH=2}
BarCol~d!9~
BarCol~f~10!{BACK=2,BA=0.24,BOUT=0,DISA=0,BR=1,HB=0,BB=1,BG=1,HA=1,HG=0,ORA=0.55,HR=0.949,HLTH=3}
BarIACol~f~1!{AC=3,AB=0.8,AA=0.45,AR=0.2,AG=0.8,IC=3,IB=0.2,IA=0.5,IR=0.2,IG=0.9}
BarIACol~f~2!{AC=3,AB=0.816,AA=0.4,AR=0.184,AG=0.475,IC=3,IB=0.4,IA=0.5,IR=0.4,IG=1}
BarIACol~f~3!{AC=3,AB=0.816,AA=0.3,AR=0.184,AG=0.475,IC=3,IB=0.4,IA=0.3,IR=0.4,IG=1}
BarIACol~d!4~5~6~7~8~9~10~
BarText~f~1!{HHEIGHT=10,TAGOOR="OOR | ",IGNOREONFULL="true",MAXCHARS=0,NAMEONBAR="true",CLASSONBAR="false",HFONT="Friz Quadrata TT",OFFSET=0,HMAXCHARS=0,INCHEALS=3,HLTHTXTANCHOR=1,HLTHTYPE=1,OVERHEAL=1,INCABSORBS=1,NUMFORMAT2=1,OUTLINE=1,TAGDC="DC | ",FONT="Friz Quadrata TT",TAGRIP="RIP | ",HEIGHT=12,HOUTLINE=1,SHOWROLE="false",HALIGN=2,NUMFORMAT1=11,HLTHONBAR="true",CLASSTYPE=1,HOFFSET2=0,ALIGN=2,TAGR="R | ",HOFFSET=0}
BarText~f~2!{HHEIGHT=10,TAGOOR="OOR | ",IGNOREONFULL="true",MAXCHARS=0,NAMEONBAR="true",CLASSONBAR="false",HFONT="Friz Quadrata TT",OFFSET=0,HMAXCHARS=0,INCHEALS=3,HLTHTXTANCHOR=1,HLTHTYPE=3,OVERHEAL=1,INCABSORBS=1,NUMFORMAT2=1,OUTLINE=1,TAGDC="DC | ",FONT="Friz Quadrata TT",TAGRIP="RIP | ",HEIGHT=12,HOUTLINE=1,SHOWROLE="false",HALIGN=2,NUMFORMAT1=11,HLTHONBAR="true",CLASSTYPE=1,HOFFSET2=0,ALIGN=2,TAGR="R | ",HOFFSET=0}
BarText~f~3!{HHEIGHT=10,TAGOOR="[OOR] ",IGNOREONFULL="true",MAXCHARS=0,NAMEONBAR="true",CLASSONBAR="false",HFONT="Friz Quadrata TT",OFFSET=0,HMAXCHARS=0,INCHEALS=3,HLTHTXTANCHOR=1,HLTHTYPE=3,OVERHEAL=1,INCABSORBS=1,NUMFORMAT2=1,OUTLINE=1,TAGDC="[DC] ",FONT="Friz Quadrata TT",TAGRIP="[RIP] ",HEIGHT=12,HOUTLINE=1,SHOWROLE="false",HALIGN=2,NUMFORMAT1=11,HLTHONBAR="true",CLASSTYPE=1,HOFFSET2=0,ALIGN=2,TAGR="[R] ",HOFFSET=0}
BarText~d!4~5~
BarText~f~6!{HHEIGHT=10,TAGOOR="OOR | ",IGNOREONFULL="true",MAXCHARS=0,NAMEONBAR="true",CLASSONBAR="false",HFONT="Friz Quadrata TT",OFFSET=0,HMAXCHARS=0,INCHEALS=3,HLTHTXTANCHOR=1,HLTHTYPE=3,OVERHEAL=1,INCABSORBS=1,NUMFORMAT2=1,OUTLINE=1,TAGDC="DC | ",FONT="Friz Quadrata TT",TAGRIP="RIP | ",HEIGHT=12,HOUTLINE=1,SHOWROLE="false",HALIGN=2,NUMFORMAT1=11,HLTHONBAR="true",CLASSTYPE=1,HOFFSET2=0,ALIGN=2,TAGR="R | ",HOFFSET=0}
BarText~d!7~
BarText~f~8!{HHEIGHT=10,TAGOOR="",IGNOREONFULL="true",MAXCHARS=0,NAMEONBAR="true",CLASSONBAR="false",HFONT="Friz Quadrata TT",OFFSET=0,HMAXCHARS=0,INCHEALS=3,HLTHTXTANCHOR=1,HLTHTYPE=3,OVERHEAL=1,INCABSORBS=1,NUMFORMAT2=1,OUTLINE=1,TAGDC="",FONT="Friz Quadrata TT",TAGRIP="",HEIGHT=12,HOUTLINE=1,SHOWROLE="false",HALIGN=2,NUMFORMAT1=11,HLTHONBAR="true",CLASSTYPE=1,HOFFSET2=0,ALIGN=2,TAGR="",HOFFSET=0}
BarText~f~9!{HHEIGHT=10,TAGOOR="[OOR] ",IGNOREONFULL="true",MAXCHARS=0,NAMEONBAR="true",CLASSONBAR="false",HFONT="Friz Quadrata TT",OFFSET=0,HMAXCHARS=0,INCHEALS=3,HLTHTXTANCHOR=1,HLTHTYPE=3,OVERHEAL=1,INCABSORBS=1,NUMFORMAT2=1,OUTLINE=1,TAGDC="[DC] ",FONT="Friz Quadrata TT",TAGRIP="[RIP] ",HEIGHT=12,HOUTLINE=1,SHOWROLE="false",HALIGN=2,NUMFORMAT1=11,HLTHONBAR="true",CLASSTYPE=1,HOFFSET2=0,ALIGN=2,TAGR="[R] ",HOFFSET=0}
BarText~d!10~
BarTextCol~f~1!{NAME=2,NCR=0.949,NCB=0.267,NCDA=0.47,HCG=0.843,HCA=1,NCG=0.843,HCR=0.949,NDEBUFF="false",HCB=0.267,NCA=1,HDEBUFF="false",HCDA=0.47,HLTH=2}
BarTextCol~f~2!{NAME=2,NCR=0.8,NCB=0.149,NCDA=0.69,HCG=0.8,HCA=1,NCG=0.8,HCR=0.8,NDEBUFF="false",HCB=0.149,NCA=1,HDEBUFF="false",HCDA=0.69,HLTH=2}
BarTextCol~d!3~4~5~6~7~8~9~10~
Icons~f~1!{SHOWBUFF="true",SHOWDEBUFF="true",MAXDICONS=3,I15EN="true",POSITION=2,DOUBLE="false",ONBAR=1,FADE="false",DSCALE=0.45,SHOWDIR="true",SHOWRC="true",SCALE=0.45,FADESECS=15,SHOWDIRMOUSE="false",MAXBICONS=8}
Icons~d!2~3~4~5~6~7~8~9~10~
RaidIcon~f~1!{SQUARE="true",CIRCLE="true",DIAMOND="true",SHOW="true",MOON="true",TRIANGLE="true",STAR="true",SKULL="true",CROSS="true"}
RaidIcon~d!2~3~4~5~6~7~8~9~10~
IconText~f~1!{DURWARN=3,HEIGHT=10,SSCNT="false",FONT="Friz Quadrata TT",SCNT="true",DURTHRH=9,SCALE=0.75,SDUR="true",SSDUR="true",OUTLINE=2}
IconText~d!2~3~4~5~6~7~8~9~10~
BarVisibility~f~1!{INCCLASSES=1,ALERTIC=0.98,ALERTOC=0.9,HIDEOOR="false"}
BarVisibility~d!2~3~4~5~6~
BarVisibility~f~7!{INCCLASSES=1,ALERTIC=0.88,ALERTOC=0.75,HIDEOOR="true"}
BarVisibility~f~8!{INCCLASSES=1,ALERTIC=0.98,ALERTOC=0.9,HIDEOOR="false"}
BarVisibility~d!9~10~
BarSort~f~1!{SUBORDER=1,OORLAST="false",RAIDORDER=2,SUBPF="true"}
BarSort~f~2!{SUBORDER=1,OORLAST="false",RAIDORDER=3,SUBPF="true"}
BarSort~d!3~4~5~6~7~8~9~10~
BarAggro~f~1!{B=0.114,SHOWTEXT="false",G=0.553,TEXTFORMAT=3,SHOW="true",SHOWTEXTPCT="true",ALERTIND=2,R=0.988,SHOWIND="true",ALERT=2}
BarAggro~f~2!{B=0,SHOWTEXT="false",G=0,TEXTFORMAT=3,SHOW="true",SHOWTEXTPCT="true",ALERTIND=1,R=1,SHOWIND="true",ALERT=2}
BarAggro~f~3!{B=0,SHOWTEXT="false",G=0,TEXTFORMAT=3,SHOW="true",SHOWTEXTPCT="true",ALERTIND=2,R=1,SHOWIND="true",ALERT=2}
BarAggro~d!4~5~6~
BarAggro~f~7!{B=0,SHOWTEXT="false",G=1,TEXTFORMAT=3,SHOW="false",SHOWTEXTPCT="true",ALERTIND=2,R=0.957,SHOWIND="true",ALERT=2}
BarAggro~f~8!{B=0,SHOWTEXT="false",G=0,TEXTFORMAT=3,SHOW="true",SHOWTEXTPCT="true",ALERTIND=2,R=1,SHOWIND="true",ALERT=2}
BarAggro~d!9~10~
AuxBarFrame~f~1!{OVERLAP=1}
AuxBarFrame~d!2~3~4~5~6~7~8~9~10~
AuxBar^1~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=2,B=1,G=1,OTYPE=1}
AuxBar^1~d!2~3~4~5~6~7~8~9~10~
AuxBar^2~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,B=1,G=1,OTYPE=1}
AuxBar^2~d!2~3~4~5~6~7~8~9~10~
AuxBar^3~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,B=1,G=1,OTYPE=1}
AuxBar^3~d!2~3~4~5~6~7~8~9~10~
AuxBar^4~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,B=1,G=1,OTYPE=1}
AuxBar^4~d!2~3~4~5~6~7~8~9~10~
AuxBar^5~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=2,OFFSET=1,DEPTH=1,B=1,G=1,OTYPE=1}
AuxBar^5~d!2~3~4~5~6~7~8~9~10~
AuxBar^6~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,B=1,G=1,OTYPE=1}
AuxBar^6~d!2~3~4~5~6~7~8~9~10~
AuxBar^7~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,B=1,G=1,OTYPE=1}
AuxBar^7~d!2~3~4~5~6~7~8~9~10~
AuxBar^8~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,B=1,G=1,OTYPE=1}
AuxBar^8~d!2~3~4~5~6~7~8~9~10~
AuxBar^9~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,B=1,G=1,OTYPE=1}
AuxBar^9~d!2~3~4~5~6~7~8~9~10~
Complete!]]
HealBot_ExtraSkinData[43]=[[Skin
cRaid25
Author~v!Monti of Terenas
DuplicateBars~v!false
Chat~t!{EOCOOM="false",EOCOOMV=20,MSG="Casting #s on #n",RESONLY="true",CHAN="",NOTIFY=1}
General~t!{OFREQ=0.07,OMIN=0.1,OMAX=0.95,FLUIDFREQ=10,HIDEPTF="false",HIDEPARTYF="true",HIDERAIDF="true",HIDEBOSSF="true",STICKYSENSITIVITY=30,FLUIDBARS="true",STICKYFRAME="true"}
Healing~t!{TINCSELF="false",TINCPET="false",GROUPPETS="true",TARGETINCOMBAT=1,TINCRAID="true",FONLYFRIEND="false",TINCGROUP="true",TONLYFRIEND="false",FALWAYSSHOW="false",FOCUSINCOMBAT=2,TALWAYSSHOW="false",FEXRAID="false",SELFPET=0,TEXRAID="false",ALERT=0.95}
Enemy~t!{USE=0,INCARENA="true",INCTANKS="true",INCMYTAR="false",ENEMYTARGET="false",ENEMYTARGETSIZE=40,INCARENAPETS="false",INCSELF="false",NUMBOSS=4,EXISTSHOWPTAR=1,HIDE="true",EXISTSHOWBOSS="true",DOUBLEWIDTH="false",EXISTSHOWARENA=3}
FrameAlias~f~1!{SIZE=12,NAME="Tanks and Healers",R=1,ALIAS="Tanks and Healers",G=1,SHOW="true",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~2!{A=1,NAME="Damage Dealers",R=1,ALIAS="Raid",G=1,SHOW="true",OFFSET=0,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~3!{SIZE=12,NAME="Members Pets",R=1,ALIAS="Not Used",G=1,SHOW="true",OFFSET=8,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~4!{A=1,NAME="",R=1,ALIAS="Not Used 2",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~5!{SIZE=12,NAME="Hostile",R=1,ALIAS="Not Used 3",G=0.047058823529412,SHOW="true",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=0,OUTLINE=1}
FrameAlias~f~6!{SIZE=12,NAME="",R=1,ALIAS="Vehicle",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~7!{SIZE=12,NAME="",R=1,ALIAS="Pets",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~8!{SIZE=12,NAME="",R=1,ALIAS="Target",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~9!{SIZE=12,NAME="",R=1,ALIAS="Focus",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~10!{SIZE=12,NAME="",R=1,ALIAS="Enemy",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAliasBar~f~1!{A=0.5,TEXTURE="HealBot 10",B=0.25,HEIGHT=20,R=0.1,G=0.25,WIDTH=0.85}
FrameAliasBar~d!2~
FrameAliasBar~f~3!{A=0.5,TEXTURE="HealBot 10",B=0.25,HEIGHT=20,R=0.1,G=0.25,WIDTH=0.7}
FrameAliasBar~d!4~5~6~7~8~9~10~
Frame~f~1!{SFOFFSETH=0,BORDERB=0.027,BORDERR=0.027,BACKG=0.016,LOCKED="true",OPENSOUND="false",BORDERA=0,SFOFFSETV=0,TIPLOC=5,BACKB=0.016,BACKA=0.05,SCALE=1,AUTOCLOSE="false",BACKR=0.016,BORDERG=0.027}
Frame~f~2!{BORDERR=0.2,TIPLOC=2,OPENSOUND="false",BACKG=0.1,LOCKED="true",BACKB=0.1,BORDERA=0,SFOFFSETV=0,AUTOCLOSE="false",BORDERB=0.2,BACKA=0.05,SCALE=1,BACKR=0.1,BORDERG=0.2,SFOFFSETH=0}
Frame~f~3!{SFOFFSETH=0,BACKB=0.1,BORDERR=0.2,BACKG=0.1,LOCKED="true",SCALE=1,BORDERA=0,SFOFFSETV=0,AUTOCLOSE="false",BORDERB=0.2,BACKA=0.05,OPENSOUND="false",TIPLOC=5,BACKR=0.1,BORDERG=0.2}
Frame~f~4!{BORDERR=0.2,TIPLOC=4,OPENSOUND="false",BACKG=0.1,LOCKED="true",BACKB=0.1,BORDERA=0.2,SFOFFSETV=0,AUTOCLOSE="false",BORDERB=0.2,BACKA=0.05,SCALE=1,BACKR=0.1,BORDERG=0.2,SFOFFSETH=0}
Frame~f~5!{BORDERR=0.2,TIPLOC=4,OPENSOUND="false",BACKG=0.1,LOCKED="true",BACKB=0.1,BORDERA=0,SFOFFSETV=0,AUTOCLOSE="false",BORDERB=0.2,BACKA=0.05,SCALE=1,BACKR=0.1,BORDERG=0.2,SFOFFSETH=0}
Frame~f~6!{BORDERR=0.2,TIPLOC=5,OPENSOUND="false",BACKG=0.1,LOCKED="true",BACKB=0.1,BORDERA=0.2,SFOFFSETV=0,AUTOCLOSE="false",BORDERB=0.2,BACKA=0.05,SCALE=1,BACKR=0.1,BORDERG=0.2,SFOFFSETH=0}
Frame~d!7~8~9~
Frame~f~10!{SFOFFSETH=0,BACKB=0.1,BORDERR=0.2,BACKG=0.1,LOCKED="true",SCALE=1,BORDERA=0.2,SFOFFSETV=0,AUTOCLOSE="false",BORDERB=0.2,BACKA=0.05,OPENSOUND="false",TIPLOC=4,BACKR=0.1,BORDERG=0.2}
StickyFrames~f~1!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~f~2!{STUCK="true",STUCKTOPOINT="TOPLEFT",STUCKTO=1,STUCKPOINT="TOPRIGHT"}
StickyFrames~f~3!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~d!4~5~6~
StickyFrames~f~7!{STUCK="true",STUCKTOPOINT="BOTTOM",STUCKTO=2,STUCKPOINT="TOP"}
StickyFrames~f~8!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~d!9~
StickyFrames~f~10!{STUCK="true",STUCKTOPOINT="TOPRIGHT",STUCKTO=1,STUCKPOINT="BOTTOMRIGHT"}
HealGroups~f~1!{FRAME=1,STATE="true",NAME="Main tanks"}
HealGroups~f~2!{FRAME=1,STATE="false",NAME="Self"}
HealGroups~f~3!{FRAME=1,STATE="true",NAME="Healers"}
HealGroups~f~4!{FRAME=2,STATE="false",NAME="Group"}
HealGroups~f~5!{FRAME=2,STATE="true",NAME="Raid"}
HealGroups~f~6!{FRAME=3,STATE="false",NAME="Private List"}
HealGroups~f~7!{FRAME=6,STATE="false",NAME="Vehicle"}
HealGroups~f~8!{FRAME=7,STATE="true",NAME="Pets"}
HealGroups~f~9!{FRAME=8,STATE="false",NAME="Target"}
HealGroups~f~10!{FRAME=9,STATE="false",NAME="Focus"}
HealGroups~f~11!{FRAME=10,STATE="true",NAME="Enemy"}
Anchors~f~1!{Y=66.65,GROW=2,BARS=3,FRAME=3,X=95.47}
Anchors~f~2!{Y=66.65,GROW=2,BARS=3,FRAME=3,X=89.82}
Anchors~f~3!{Y=43.9,GROW=2,BARS=3,FRAME=3,X=95.03}
Anchors~f~4!{Y=79.82,GROW=2,BARS=3,FRAME=3,X=93.91}
Anchors~f~5!{Y=68.26,GROW=2,BARS=4,FRAME=4,X=93.58}
Anchors~f~6!{Y=34.7,GROW=2,BARS=3,FRAME=3,X=31.21}
Anchors~f~7!{Y=55.15,GROW=2,BARS=3,FRAME=5,X=83.09}
Anchors~f~8!{Y=66.65,GROW=2,BARS=3,FRAME=3,X=89.82}
Anchors~f~9!{Y=70.22,GROW=2,BARS=3,FRAME=3,X=90.04}
Anchors~f~10!{Y=68.32,GROW=2,BARS=3,FRAME=4,X=95.47}
HeadBar~f~1!{SHOW="false",TEXTURE="Tukui",R=0.298,B=0.231,HEIGHT=10,A=0.4,G=0.231,WIDTH=0.8}
HeadBar~f~2!{SHOW="false",WIDTH=0.8,B=0.231,R=0.298,HEIGHT=9,A=0.4,G=0.231,TEXTURE="Tukui"}
HeadBar~f~3!{SHOW="false",WIDTH=0.8,B=0.231,R=0.298,HEIGHT=7,A=0.4,G=0.231,TEXTURE="Tukui"}
HeadBar~f~4!{SHOW="false",WIDTH=0.8,B=0.231,R=0.298,HEIGHT=15,A=0.4,G=0.231,TEXTURE="Tukui"}
HeadBar~f~5!{SHOW="false",WIDTH=0.8,B=0.231,R=0.298,HEIGHT=9,A=0.4,G=0.231,TEXTURE="Tukui"}
HeadBar~f~6!{SHOW="false",WIDTH=0.8,B=0.231,R=0.298,HEIGHT=10,A=0.4,G=0.231,TEXTURE="Tukui"}
HeadBar~f~7!{SHOW="false",WIDTH=0.8,B=0.231,R=0.298,HEIGHT=9,A=0.4,G=0.231,TEXTURE="Tukui"}
HeadBar~f~8!{SHOW="false",WIDTH=0.8,B=0.231,R=0.298,HEIGHT=10,A=0.4,G=0.231,TEXTURE="Tukui"}
HeadBar~d!9~10~
HeadText~f~1!{A=1,R=1,OFFSET=0,B=1,FONT="Friz Quadrata TT",HEIGHT=12,G=1,OUTLINE=1}
HeadText~d!2~3~4~5~6~7~8~9~10~
HealBar~f~1!{HEIGHT=28,GRPCOLS="false",CMARGIN=2,TEXTURE="Minimalist",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=148,RMARGIN=0,OFIX=1,NUMCOLS=1,LOWMANA=2}
HealBar~f~2!{HEIGHT=25,GRPCOLS="false",CMARGIN=2,TEXTURE="Minimalist",POWERCNT="true",LOWMANACOMBAT="true",NUMCOLS=3,RMARGIN=0,OFIX=1,WIDTH=120,LOWMANA=2}
HealBar~f~3!{HEIGHT=20,GRPCOLS="false",CMARGIN=2,TEXTURE="Minimalist",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=50,RMARGIN=0,OFIX=1,NUMCOLS=2,LOWMANA=2}
HealBar~f~4!{HEIGHT=42,GRPCOLS="false",CMARGIN=2,TEXTURE="Minimalist",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=152,RMARGIN=0,OFIX=1,NUMCOLS=4,LOWMANA=2}
HealBar~f~5!{HEIGHT=25,GRPCOLS="false",CMARGIN=2,TEXTURE="Minimalist",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=95,RMARGIN=0,OFIX=1,NUMCOLS=3,LOWMANA=2}
HealBar~f~6!{HEIGHT=27,GRPCOLS="false",CMARGIN=2,TEXTURE="Minimalist",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=132,RMARGIN=0,OFIX=1,NUMCOLS=4,LOWMANA=2}
HealBar~f~7!{HEIGHT=25,GRPCOLS="false",CMARGIN=1,TEXTURE="Minimalist",POWERCNT="true",LOWMANACOMBAT="true",NUMCOLS=3,RMARGIN=0,OFIX=1,WIDTH=118,LOWMANA=2}
HealBar~f~8!{HEIGHT=27,GRPCOLS="false",CMARGIN=2,TEXTURE="Minimalist",POWERCNT="true",LOWMANACOMBAT="true",NUMCOLS=4,RMARGIN=0,OFIX=1,WIDTH=132,LOWMANA=2}
HealBar~d!9~
HealBar~f~10!{HEIGHT=27,GRPCOLS="false",CMARGIN=1,TEXTURE="Minimalist",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=130,RMARGIN=0,OFIX=1,NUMCOLS=4,LOWMANA=2}
BarCol~f~1!{BACK=2,BA=0.1,BOUT=2,DISA=0.04,BR=0.059,HB=0.404,BG=0.059,HR=0.38,HA=0.98,HG=0.424,ORA=0.5,BB=0.059,HLTH=2}
BarCol~f~2!{BACK=2,BA=0.1,BB=0.059,DISA=0.04,BR=0.059,HB=0.404,BG=0.059,BOUT=2,HA=0.98,HR=0.38,ORA=0.4,HG=0.424,HLTH=2}
BarCol~f~3!{BACK=2,BA=0.1,BB=0.059,DISA=0.04,BR=0.059,HB=0.404,BG=0.059,BOUT=2,HA=0.98,HR=0.38,ORA=0.5,HG=0.424,HLTH=2}
BarCol~d!4~5~6~
BarCol~f~7!{BACK=3,BA=0.1,BB=0.059,DISA=0.04,BR=0.059,HB=0.643,BG=0.059,BOUT=2,HA=0.98,HR=0.624,ORA=0.25,HG=0.659,HLTH=3}
BarCol~f~8!{BACK=2,BA=0.1,BB=0.059,DISA=0.04,BR=0.059,HB=0.404,BG=0.059,BOUT=2,HA=0.98,HR=0.38,ORA=0.5,HG=0.424,HLTH=2}
BarCol~d!9~
BarCol~f~10!{BACK=3,BA=0.2,BB=0,DISA=0.04,BR=0.6,HB=0.106,BG=0,HG=0.106,HA=0.98,HR=0.855,ORA=0.5,BOUT=2,HLTH=3}
BarIACol~f~1!{AC=3,AB=1,AA=0.7,AR=1,AG=1,IC=4,IB=0.459,IA=0.7,IR=1,IG=0.467}
BarIACol~d!2~3~4~5~6~7~8~9~10~
BarText~f~1!{HLTHONBAR="true",TAGOOR="OOR | ",IGNOREONFULL="false",MAXCHARS=0,NUMFORMAT1=2,HMAXCHARS=0,OUTLINE=1,OVERHEAL=1,FONT="Friz Quadrata TT",INCHEALS=3,HLTHTXTANCHOR=1,HLTHTYPE=1,CLASSONBAR="true",CLASSTYPE=1,NUMFORMAT2=1,TAGRIP="RIP | ",TAGDC=" DC | ",HHEIGHT=10,NAMEONBAR="true",HEIGHT=10,HFONT="Friz Quadrata TT",SHOWROLE="true",HALIGN=2,OFFSET=0,HOUTLINE=1,INCABSORBS=3,HOFFSET2=0,ALIGN=2,TAGR="R | ",HOFFSET=0}
BarText~d!2~
BarText~f~3!{HLTHONBAR="true",TAGOOR="OOR | ",IGNOREONFULL="false",MAXCHARS=0,NUMFORMAT1=2,HMAXCHARS=0,OUTLINE=1,OVERHEAL=1,CLASSONBAR="false",INCHEALS=3,HLTHTXTANCHOR=1,HLTHTYPE=1,CLASSTYPE=1,FONT="Friz Quadrata TT",NUMFORMAT2=1,NAMEONBAR="true",TAGDC=" DC | ",HHEIGHT=10,TAGRIP="RIP | ",HEIGHT=10,HFONT="Friz Quadrata TT",SHOWROLE="true",HALIGN=2,OFFSET=0,HOUTLINE=1,INCABSORBS=3,HOFFSET2=0,ALIGN=2,TAGR="R | ",HOFFSET=0}
BarText~d!4~5~6~7~8~9~10~
BarTextCol~f~1!{NAME=2,HCA=1,NCB=0,NCDA=0.8,HCG=1,NDEBUFF="false",HCB=0,HCR=1,NCR=1,NCG=1,NCA=1,HDEBUFF="false",HLTH=2,HCDA=0.8}
BarTextCol~d!2~3~4~5~6~7~8~9~10~
Icons~f~1!{SHOWBUFF="true",SHOWDEBUFF="true",FADESECS=15,FADE="false",MAXDICONS=3,ONBAR=1,POSITION=2,SHOWDIRMOUSE="false",DSCALE=0.5,SHOWDIR="true",SHOWRC="true",SCALE=0.5,DOUBLE="false",I15EN="true",MAXBICONS=8}
Icons~d!2~3~4~5~6~7~8~9~10~
RaidIcon~f~1!{SQUARE="true",CIRCLE="true",DIAMOND="true",SHOW="true",MOON="true",TRIANGLE="true",STAR="true",CROSS="true",SKULL="true"}
RaidIcon~d!2~3~4~5~6~7~8~9~10~
IconText~f~1!{SDUR="true",HEIGHT=8,SSCNT="false",SCNT="true",DURTHRH=9,FONT="Friz Quadrata TT",DURWARN=3,SSDUR="false",OUTLINE=2}
IconText~d!2~
IconText~f~3!{SDUR="true",HEIGHT=8,SSCNT="false",SCNT="true",DURTHRH=9,FONT="Friz Quadrata TT",DURWARN=3,SSDUR="true",OUTLINE=2}
IconText~f~4!{SDUR="true",HEIGHT=12,SSCNT="false",SCNT="true",DURTHRH=9,FONT="Friz Quadrata TT",DURWARN=3,SSDUR="true",OUTLINE=2}
IconText~f~5!{SDUR="true",HEIGHT=8,SSCNT="false",SCNT="true",DURTHRH=9,FONT="Friz Quadrata TT",DURWARN=3,SSDUR="true",OUTLINE=2}
IconText~f~6!{SDUR="true",HEIGHT=9,SSCNT="false",SCNT="true",DURTHRH=9,FONT="Friz Quadrata TT",DURWARN=3,SSDUR="true",OUTLINE=2}
IconText~f~7!{SDUR="true",HEIGHT=8,SSCNT="false",SCNT="true",DURTHRH=9,FONT="Friz Quadrata TT",DURWARN=3,SSDUR="true",OUTLINE=2}
IconText~f~8!{SDUR="true",HEIGHT=9,SSCNT="false",SCNT="true",DURTHRH=9,FONT="Friz Quadrata TT",DURWARN=3,SSDUR="true",OUTLINE=2}
IconText~d!9~10~
BarVisibility~f~1!{INCCLASSES=1,ALERTIC=0.95,ALERTOC=0.9,HIDEOOR="false"}
BarVisibility~f~2!{INCCLASSES=1,ALERTIC=0.9,ALERTOC=0.75,HIDEOOR="false"}
BarVisibility~f~3!{INCCLASSES=1,ALERTIC=0.98,ALERTOC=0.9,HIDEOOR="false"}
BarVisibility~d!4~5~6~
BarVisibility~f~7!{INCCLASSES=1,ALERTIC=0.75,ALERTOC=0.55,HIDEOOR="true"}
BarVisibility~f~8!{INCCLASSES=1,ALERTIC=0.98,ALERTOC=0.9,HIDEOOR="false"}
BarVisibility~d!9~10~
BarSort~f~1!{SUBORDER=1,OORLAST="false",RAIDORDER=2,SUBPF="true"}
BarSort~f~2!{SUBORDER=1,OORLAST="true",RAIDORDER=2,SUBPF="true"}
BarSort~d!3~4~5~6~7~8~9~10~
BarAggro~f~1!{B=0,ALERTIND=2,G=0,TEXTFORMAT=3,SHOW="true",SHOWTEXTPCT="true",SHOWIND="true",SHOWTEXT="false",R=1,ALERT=2}
BarAggro~f~2!{B=0.2,ALERTIND=2,G=0.569,TEXTFORMAT=3,SHOW="true",SHOWTEXTPCT="true",SHOWIND="true",SHOWTEXT="false",R=0.949,ALERT=2}
BarAggro~f~3!{B=0,ALERTIND=1,G=0,TEXTFORMAT=3,SHOW="true",SHOWTEXTPCT="true",SHOWIND="true",SHOWTEXT="true",R=1,ALERT=2}
BarAggro~f~4!{B=0,ALERTIND=2,G=0,TEXTFORMAT=3,SHOW="true",SHOWTEXTPCT="true",SHOWIND="true",SHOWTEXT="true",R=1,ALERT=2}
BarAggro~d!5~6~
BarAggro~f~7!{B=0,ALERTIND=2,G=0.792,TEXTFORMAT=3,SHOW="true",SHOWTEXTPCT="true",SHOWIND="true",SHOWTEXT="true",R=1,ALERT=2}
BarAggro~f~8!{B=0,ALERTIND=2,G=0,TEXTFORMAT=3,SHOW="true",SHOWTEXTPCT="true",SHOWIND="true",SHOWTEXT="true",R=1,ALERT=2}
BarAggro~d!9~10~
AuxBarFrame~f~1!{OVERLAP=1}
AuxBarFrame~d!2~3~4~5~6~7~8~9~10~
AuxBar^1~f~1!{SIZE=0.98,USE=4,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=2,G=1,B=1,OTYPE=1}
AuxBar^1~d!2~3~4~5~6~7~8~9~10~
AuxBar^2~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,OTYPE=1}
AuxBar^2~d!2~3~4~5~6~7~8~9~10~
AuxBar^3~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,OTYPE=1}
AuxBar^3~d!2~3~4~5~6~7~8~9~10~
AuxBar^4~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,OTYPE=1}
AuxBar^4~d!2~3~4~5~6~7~8~9~10~
AuxBar^5~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=2,OFFSET=1,DEPTH=1,G=1,B=1,OTYPE=1}
AuxBar^5~d!2~3~4~5~6~7~8~9~10~
AuxBar^6~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,OTYPE=1}
AuxBar^6~d!2~3~4~5~6~7~8~9~10~
AuxBar^7~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,OTYPE=1}
AuxBar^7~d!2~3~4~5~6~7~8~9~10~
AuxBar^8~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,OTYPE=1}
AuxBar^8~d!2~3~4~5~6~7~8~9~10~
AuxBar^9~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,OTYPE=1}
AuxBar^9~d!2~3~4~5~6~7~8~9~10~
Complete!]]
HealBot_ExtraSkinData[44]=[[Skin
cRaid40
Author~v!Monti of Terenas
DuplicateBars~v!false
Chat~t!{EOCOOM="false",EOCOOMV=20,MSG="Casting #s on #n",RESONLY="true",CHAN="",NOTIFY=1}
General~t!{OFREQ=0.07,OMIN=0.1,OMAX=0.95,FLUIDFREQ=10,HIDEPARTYF="true",HIDEBOSSF="true",HIDERAIDF="true",STICKYFRAME="true",STICKYSENSITIVITY=30,FLUIDBARS="true",HIDEPTF="false"}
Healing~t!{TINCRAID="true",TINCSELF="false",GROUPPETS="true",TARGETINCOMBAT=1,FALWAYSSHOW="false",FONLYFRIEND="false",TINCPET="false",TONLYFRIEND="false",TINCGROUP="true",FOCUSINCOMBAT=2,TALWAYSSHOW="false",FEXRAID="false",SELFPET=0,TEXRAID="false",ALERT=0.95}
Enemy~t!{USE=0,ENEMYTARGET="false",INCTANKS="true",INCMYTAR="false",INCARENA="true",ENEMYTARGETSIZE=40,INCARENAPETS="false",HIDE="true",NUMBOSS=4,EXISTSHOWPTAR=1,INCSELF="false",EXISTSHOWBOSS="true",DOUBLEWIDTH="false",EXISTSHOWARENA=3}
FrameAlias~f~1!{SIZE=12,NAME="Tanks",R=1,ALIAS="Tanks",G=1,SHOW="true",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~2!{A=1,NAME="Raid",R=1,ALIAS="Raid",G=1,SHOW="true",OFFSET=0,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~3!{SIZE=12,NAME="Members Pets",R=1,ALIAS="Not Used",G=1,SHOW="true",OFFSET=8,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~4!{A=1,NAME="",R=1,ALIAS="Not Used 2",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~5!{SIZE=12,NAME="Hostile",R=1,ALIAS="Not Used 3",G=0.047058823529412,SHOW="true",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=0,OUTLINE=1}
FrameAlias~f~6!{SIZE=12,NAME="",R=1,ALIAS="Vehicle",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~7!{SIZE=12,NAME="",R=1,ALIAS="Pets",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~8!{SIZE=12,NAME="",R=1,ALIAS="Target",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~9!{SIZE=12,NAME="",R=1,ALIAS="Focus",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~10!{SIZE=12,NAME="",R=1,ALIAS="Enemy",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAliasBar~f~1!{A=0.5,WIDTH=0.85,B=0.25,HEIGHT=20,R=0.1,G=0.25,TEXTURE="HealBot 10"}
FrameAliasBar~d!2~
FrameAliasBar~f~3!{A=0.5,WIDTH=0.7,B=0.25,HEIGHT=20,R=0.1,G=0.25,TEXTURE="HealBot 10"}
FrameAliasBar~d!4~5~6~7~8~9~10~
Frame~f~1!{SFOFFSETH=0,BACKR=0.016,SFOFFSETV=0,BACKG=0.016,LOCKED="true",SCALE=1,BORDERA=0,BORDERG=0.027,TIPLOC=5,BACKB=0.016,BACKA=0.05,OPENSOUND="false",BORDERB=0.027,AUTOCLOSE="false",BORDERR=0.027}
Frame~f~2!{BORDERR=0.2,SFOFFSETH=0,BACKR=0.1,SFOFFSETV=0,LOCKED="true",SCALE=1,BORDERA=0,BORDERG=0.2,BACKG=0.1,BORDERB=0.2,BACKA=0.05,OPENSOUND="false",BACKB=0.1,TIPLOC=2,AUTOCLOSE="false"}
Frame~f~3!{SFOFFSETH=0,BACKR=0.1,SFOFFSETV=0,BACKG=0.1,LOCKED="true",OPENSOUND="false",BORDERA=0,BORDERG=0.2,AUTOCLOSE="false",BORDERB=0.2,BACKA=0.05,SCALE=1,BACKB=0.1,TIPLOC=5,BORDERR=0.2}
Frame~f~4!{BORDERR=0.2,SFOFFSETH=0,BACKR=0.1,SFOFFSETV=0,LOCKED="true",SCALE=1,BORDERA=0.2,BORDERG=0.2,BACKG=0.1,BORDERB=0.2,BACKA=0.05,OPENSOUND="false",BACKB=0.1,TIPLOC=4,AUTOCLOSE="false"}
Frame~f~5!{BORDERR=0.2,SFOFFSETH=0,BACKR=0.1,SFOFFSETV=0,LOCKED="true",SCALE=1,BORDERA=0,BORDERG=0.2,BACKG=0.1,BORDERB=0.2,BACKA=0.05,OPENSOUND="false",BACKB=0.1,TIPLOC=4,AUTOCLOSE="false"}
Frame~f~6!{BORDERR=0.2,SFOFFSETH=0,BACKR=0.1,SFOFFSETV=0,LOCKED="true",SCALE=1,BORDERA=0.2,BORDERG=0.2,BACKG=0.1,BORDERB=0.2,BACKA=0.05,OPENSOUND="false",BACKB=0.1,TIPLOC=5,AUTOCLOSE="false"}
Frame~d!7~8~9~
Frame~f~10!{SFOFFSETH=0,BACKR=0.1,SFOFFSETV=0,BACKG=0.1,LOCKED="true",OPENSOUND="false",BORDERA=0.2,BORDERG=0.2,AUTOCLOSE="false",BORDERB=0.2,BACKA=0.05,SCALE=1,BACKB=0.1,TIPLOC=4,BORDERR=0.2}
StickyFrames~f~1!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~f~2!{STUCK="true",STUCKTOPOINT="TOPLEFT",STUCKTO=1,STUCKPOINT="TOPRIGHT"}
StickyFrames~f~3!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~d!4~5~6~
StickyFrames~f~7!{STUCK="true",STUCKTOPOINT="BOTTOM",STUCKTO=2,STUCKPOINT="TOP"}
StickyFrames~f~8!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~d!9~
StickyFrames~f~10!{STUCK="true",STUCKTOPOINT="TOPRIGHT",STUCKTO=1,STUCKPOINT="BOTTOMRIGHT"}
HealGroups~f~1!{FRAME=1,STATE="true",NAME="Main tanks"}
HealGroups~f~2!{FRAME=2,STATE="false",NAME="Self"}
HealGroups~f~3!{FRAME=2,STATE="true",NAME="Healers"}
HealGroups~f~4!{FRAME=2,STATE="false",NAME="Group"}
HealGroups~f~5!{FRAME=2,STATE="true",NAME="Raid"}
HealGroups~f~6!{FRAME=3,STATE="false",NAME="Private List"}
HealGroups~f~7!{FRAME=6,STATE="false",NAME="Vehicle"}
HealGroups~f~8!{FRAME=7,STATE="true",NAME="Pets"}
HealGroups~f~9!{FRAME=8,STATE="false",NAME="Target"}
HealGroups~f~10!{FRAME=9,STATE="false",NAME="Focus"}
HealGroups~f~11!{FRAME=10,STATE="true",NAME="Enemy"}
Anchors~f~1!{Y=66.65,GROW=2,BARS=3,FRAME=3,X=95.47}
Anchors~f~2!{Y=66.65,GROW=2,BARS=3,FRAME=3,X=89.82}
Anchors~f~3!{Y=43.9,GROW=2,BARS=3,FRAME=3,X=95.03}
Anchors~f~4!{Y=79.82,GROW=2,BARS=3,FRAME=3,X=93.91}
Anchors~f~5!{Y=68.26,GROW=2,BARS=4,FRAME=4,X=93.58}
Anchors~f~6!{Y=34.7,GROW=2,BARS=3,FRAME=3,X=31.21}
Anchors~f~7!{Y=43.32,GROW=2,BARS=3,FRAME=5,X=83.12}
Anchors~f~8!{Y=63.51,GROW=2,BARS=3,FRAME=3,X=62.1}
Anchors~f~9!{Y=62.51,GROW=2,BARS=3,FRAME=3,X=62.1}
Anchors~f~10!{Y=68.32,GROW=2,BARS=3,FRAME=4,X=95.47}
HeadBar~f~1!{SHOW="false",WIDTH=0.8,B=0.231,R=0.298,HEIGHT=10,A=0.4,G=0.231,TEXTURE="Tukui"}
HeadBar~f~2!{SHOW="false",TEXTURE="Tukui",R=0.298,B=0.231,HEIGHT=9,A=0.4,G=0.231,WIDTH=0.8}
HeadBar~f~3!{SHOW="false",TEXTURE="Tukui",R=0.298,B=0.231,HEIGHT=7,A=0.4,G=0.231,WIDTH=0.8}
HeadBar~f~4!{SHOW="false",TEXTURE="Tukui",R=0.298,B=0.231,HEIGHT=15,A=0.4,G=0.231,WIDTH=0.8}
HeadBar~f~5!{SHOW="false",TEXTURE="Tukui",R=0.298,B=0.231,HEIGHT=9,A=0.4,G=0.231,WIDTH=0.8}
HeadBar~f~6!{SHOW="false",TEXTURE="Tukui",R=0.298,B=0.231,HEIGHT=10,A=0.4,G=0.231,WIDTH=0.8}
HeadBar~f~7!{SHOW="false",TEXTURE="Tukui",R=0.298,B=0.231,HEIGHT=9,A=0.4,G=0.231,WIDTH=0.8}
HeadBar~f~8!{SHOW="false",TEXTURE="Tukui",R=0.298,B=0.231,HEIGHT=10,A=0.4,G=0.231,WIDTH=0.8}
HeadBar~d!9~10~
HeadText~f~1!{A=1,B=1,OFFSET=0,R=1,FONT="Friz Quadrata TT",HEIGHT=12,G=1,OUTLINE=1}
HeadText~d!2~3~4~5~6~7~8~9~10~
HealBar~f~1!{HEIGHT=28,GRPCOLS="false",CMARGIN=2,TEXTURE="Minimalist",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=2,NUMCOLS=1,OFIX=1,RMARGIN=0,WIDTH=148}
HealBar~f~2!{HEIGHT=25,GRPCOLS="false",CMARGIN=2,TEXTURE="Minimalist",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=2,WIDTH=90,OFIX=1,RMARGIN=0,NUMCOLS=4}
HealBar~f~3!{HEIGHT=20,GRPCOLS="false",CMARGIN=2,TEXTURE="Minimalist",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=2,NUMCOLS=2,OFIX=1,RMARGIN=0,WIDTH=50}
HealBar~f~4!{HEIGHT=42,GRPCOLS="false",CMARGIN=2,TEXTURE="Minimalist",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=2,NUMCOLS=4,OFIX=1,RMARGIN=0,WIDTH=152}
HealBar~f~5!{HEIGHT=25,GRPCOLS="false",CMARGIN=2,TEXTURE="Minimalist",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=2,NUMCOLS=3,OFIX=1,RMARGIN=0,WIDTH=95}
HealBar~f~6!{HEIGHT=27,GRPCOLS="false",CMARGIN=2,TEXTURE="Minimalist",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=2,NUMCOLS=4,OFIX=1,RMARGIN=0,WIDTH=132}
HealBar~f~7!{HEIGHT=25,GRPCOLS="false",CMARGIN=1,TEXTURE="Minimalist",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=2,WIDTH=118,OFIX=1,RMARGIN=0,NUMCOLS=3}
HealBar~f~8!{HEIGHT=27,GRPCOLS="false",CMARGIN=2,TEXTURE="Minimalist",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=2,WIDTH=132,OFIX=1,RMARGIN=0,NUMCOLS=4}
HealBar~d!9~
HealBar~f~10!{HEIGHT=27,GRPCOLS="false",CMARGIN=1,TEXTURE="Minimalist",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=2,NUMCOLS=4,OFIX=1,RMARGIN=0,WIDTH=130}
BarCol~f~1!{BACK=2,BA=0.1,BOUT=2,DISA=0.04,BR=0.059,HB=0.404,BG=0.059,BB=0.059,HA=0.98,HG=0.424,ORA=0.5,HR=0.38,HLTH=2}
BarCol~f~2!{BACK=2,BA=0.1,BOUT=1,DISA=0.04,BR=0.059,HB=0.404,BG=0.059,HR=0.38,HA=1,HG=0.424,ORA=0.4,BB=0.059,HLTH=2}
BarCol~f~3!{BACK=2,BA=0.1,BOUT=2,DISA=0.04,BR=0.059,HB=0.404,BG=0.059,HR=0.38,HA=0.98,HG=0.424,ORA=0.5,BB=0.059,HLTH=2}
BarCol~d!4~5~6~
BarCol~f~7!{BACK=3,BA=0.1,BOUT=2,DISA=0.04,BR=0.059,HB=0.643,BG=0.059,HR=0.624,HA=0.98,HG=0.659,ORA=0.25,BB=0.059,HLTH=3}
BarCol~f~8!{BACK=2,BA=0.1,BOUT=2,DISA=0.04,BR=0.059,HB=0.404,BG=0.059,HR=0.38,HA=0.98,HG=0.424,ORA=0.5,BB=0.059,HLTH=2}
BarCol~d!9~
BarCol~f~10!{BACK=3,BA=0.2,BB=0,DISA=0.04,BR=0.6,HB=0.106,BG=0,BOUT=2,HA=0.98,HR=0.855,ORA=0.5,HG=0.106,HLTH=3}
BarIACol~f~1!{AC=3,AB=1,AA=0.7,AR=1,AG=1,IC=4,IB=0.459,IA=0.7,IR=1,IG=0.467}
BarIACol~d!2~3~4~5~6~7~8~9~10~
BarText~f~1!{HLTHONBAR="true",TAGOOR="OOR | ",OVERHEAL=1,MAXCHARS=0,CLASSONBAR="true",HOFFSET=0,HMAXCHARS=0,HLTHTYPE=1,INCHEALS=3,HLTHTXTANCHOR=1,FONT="Friz Quadrata TT",IGNOREONFULL="false",INCABSORBS=3,NUMFORMAT2=1,HOUTLINE=1,TAGDC=" DC | ",OFFSET=0,TAGRIP="RIP | ",HEIGHT=10,HFONT="Friz Quadrata TT",SHOWROLE="true",HALIGN=2,NAMEONBAR="true",HHEIGHT=10,NUMFORMAT1=2,CLASSTYPE=1,HOFFSET2=0,ALIGN=2,TAGR="R | ",OUTLINE=1}
BarText~d!2~
BarText~f~3!{HLTHONBAR="true",TAGOOR="OOR | ",OVERHEAL=1,MAXCHARS=0,CLASSONBAR="false",HOFFSET=0,HMAXCHARS=0,FONT="Friz Quadrata TT",INCHEALS=3,HLTHTXTANCHOR=1,HLTHTYPE=1,IGNOREONFULL="false",INCABSORBS=3,NUMFORMAT2=1,HOUTLINE=1,TAGDC=" DC | ",OFFSET=0,NAMEONBAR="true",HEIGHT=10,HFONT="Friz Quadrata TT",SHOWROLE="true",HALIGN=2,TAGRIP="RIP | ",HHEIGHT=10,NUMFORMAT1=2,CLASSTYPE=1,HOFFSET2=0,ALIGN=2,TAGR="R | ",OUTLINE=1}
BarText~d!4~5~6~7~8~9~10~
BarTextCol~f~1!{NCB=0,NDEBUFF="false",HCDA=0.8,NCDA=0.8,HCG=1,NAME=2,HCB=0,HCR=1,NCA=1,NCG=1,NCR=1,HDEBUFF="false",HCA=1,HLTH=2}
BarTextCol~d!2~3~4~5~6~7~8~9~10~
Icons~f~1!{SHOWBUFF="true",POSITION=2,MAXDICONS=3,FADESECS=15,I15EN="true",SHOWDIRMOUSE="false",SHOWDIR="true",FADE="false",DSCALE=0.5,ONBAR=1,SHOWRC="true",SCALE=0.5,DOUBLE="false",SHOWDEBUFF="true",MAXBICONS=8}
Icons~d!2~3~4~5~6~7~8~9~10~
RaidIcon~f~1!{SQUARE="true",CIRCLE="true",DIAMOND="true",SHOW="true",MOON="true",TRIANGLE="true",STAR="true",SKULL="true",CROSS="true"}
RaidIcon~d!2~3~4~5~6~7~8~9~10~
IconText~f~1!{DURWARN=3,HEIGHT=8,SSCNT="false",SCNT="true",DURTHRH=9,FONT="Friz Quadrata TT",SDUR="true",SSDUR="false",OUTLINE=2}
IconText~d!2~
IconText~f~3!{DURWARN=3,HEIGHT=8,SSCNT="false",SCNT="true",DURTHRH=9,FONT="Friz Quadrata TT",SDUR="true",SSDUR="true",OUTLINE=2}
IconText~f~4!{DURWARN=3,HEIGHT=12,SSCNT="false",SCNT="true",DURTHRH=9,FONT="Friz Quadrata TT",SDUR="true",SSDUR="true",OUTLINE=2}
IconText~f~5!{DURWARN=3,HEIGHT=8,SSCNT="false",SCNT="true",DURTHRH=9,FONT="Friz Quadrata TT",SDUR="true",SSDUR="true",OUTLINE=2}
IconText~f~6!{DURWARN=3,HEIGHT=9,SSCNT="false",SCNT="true",DURTHRH=9,FONT="Friz Quadrata TT",SDUR="true",SSDUR="true",OUTLINE=2}
IconText~f~7!{DURWARN=3,HEIGHT=8,SSCNT="false",SCNT="true",DURTHRH=9,FONT="Friz Quadrata TT",SDUR="true",SSDUR="true",OUTLINE=2}
IconText~f~8!{DURWARN=3,HEIGHT=9,SSCNT="false",SCNT="true",DURTHRH=9,FONT="Friz Quadrata TT",SDUR="true",SSDUR="true",OUTLINE=2}
IconText~d!9~10~
BarVisibility~f~1!{INCCLASSES=1,ALERTIC=0.95,ALERTOC=0.9,HIDEOOR="false"}
BarVisibility~f~2!{INCCLASSES=1,ALERTIC=0.9,ALERTOC=0.75,HIDEOOR="false"}
BarVisibility~f~3!{INCCLASSES=1,ALERTIC=0.98,ALERTOC=0.9,HIDEOOR="false"}
BarVisibility~d!4~5~6~
BarVisibility~f~7!{INCCLASSES=1,ALERTIC=0.75,ALERTOC=0.55,HIDEOOR="true"}
BarVisibility~f~8!{INCCLASSES=1,ALERTIC=0.98,ALERTOC=0.9,HIDEOOR="false"}
BarVisibility~d!9~10~
BarSort~f~1!{SUBORDER=1,OORLAST="false",RAIDORDER=2,SUBPF="true"}
BarSort~f~2!{SUBORDER=1,OORLAST="true",RAIDORDER=2,SUBPF="true"}
BarSort~d!3~4~5~6~7~8~9~10~
BarAggro~f~1!{B=0,ALERTIND=2,G=0,TEXTFORMAT=3,SHOW="true",SHOWTEXTPCT="true",SHOWIND="true",R=1,SHOWTEXT="false",ALERT=2}
BarAggro~f~2!{B=0.2,ALERTIND=2,G=0.569,TEXTFORMAT=3,SHOW="true",SHOWTEXTPCT="true",SHOWIND="true",R=0.949,SHOWTEXT="false",ALERT=2}
BarAggro~f~3!{B=0,ALERTIND=1,G=0,TEXTFORMAT=3,SHOW="true",SHOWTEXTPCT="true",SHOWIND="true",R=1,SHOWTEXT="true",ALERT=2}
BarAggro~f~4!{B=0,ALERTIND=2,G=0,TEXTFORMAT=3,SHOW="true",SHOWTEXTPCT="true",SHOWIND="true",R=1,SHOWTEXT="true",ALERT=2}
BarAggro~d!5~6~
BarAggro~f~7!{B=0,ALERTIND=2,G=0.792,TEXTFORMAT=3,SHOW="true",SHOWTEXTPCT="true",SHOWIND="true",R=1,SHOWTEXT="true",ALERT=2}
BarAggro~f~8!{B=0,ALERTIND=2,G=0,TEXTFORMAT=3,SHOW="true",SHOWTEXTPCT="true",SHOWIND="true",R=1,SHOWTEXT="true",ALERT=2}
BarAggro~d!9~10~
AuxBarFrame~f~1!{OVERLAP=1}
AuxBarFrame~d!2~3~4~5~6~7~8~9~10~
AuxBar^1~f~1!{SIZE=0.98,USE=4,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=2,OTYPE=1,B=1,G=1}
AuxBar^1~d!2~3~4~5~6~7~8~9~10~
AuxBar^2~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,OTYPE=1,B=1,G=1}
AuxBar^2~d!2~3~4~5~6~7~8~9~10~
AuxBar^3~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,OTYPE=1,B=1,G=1}
AuxBar^3~d!2~3~4~5~6~7~8~9~10~
AuxBar^4~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,OTYPE=1,B=1,G=1}
AuxBar^4~d!2~3~4~5~6~7~8~9~10~
AuxBar^5~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=2,OFFSET=1,DEPTH=1,OTYPE=1,B=1,G=1}
AuxBar^5~d!2~3~4~5~6~7~8~9~10~
AuxBar^6~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,OTYPE=1,B=1,G=1}
AuxBar^6~d!2~3~4~5~6~7~8~9~10~
AuxBar^7~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,OTYPE=1,B=1,G=1}
AuxBar^7~d!2~3~4~5~6~7~8~9~10~
AuxBar^8~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,OTYPE=1,B=1,G=1}
AuxBar^8~d!2~3~4~5~6~7~8~9~10~
AuxBar^9~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,OTYPE=1,B=1,G=1}
AuxBar^9~d!2~3~4~5~6~7~8~9~10~
Complete!]]

HealBot_ExtraSkinData[45]=[[Skin
B&W-Group
Author~v!Monti of Terenas
DuplicateBars~v!false
Chat~t!{EOCOOM="false",EOCOOMV=20,MSG="Casting #s on #n",RESONLY="true",CHAN="",NOTIFY=1}
General~t!{OFREQ=0.07,OMIN=0.1,OMAX=0.95,FLUIDFREQ=10,HIDEPARTYF="true",HIDEPTF="false",HIDERAIDF="true",STICKYFRAME="true",STICKYSENSITIVITY=19,FLUIDBARS="true",HIDEBOSSF="true"}
Healing~t!{TINCRAID="true",TINCSELF="false",GROUPPETS="true",TARGETINCOMBAT=1,TINCGROUP="true",FONLYFRIEND="false",SELFPET=0,TONLYFRIEND="false",FALWAYSSHOW="false",FOCUSINCOMBAT=2,TALWAYSSHOW="false",FEXRAID="false",TINCPET="false",TEXRAID="false",ALERT=0.95}
Enemy~t!{ENEMYTARGET="false",INCTANKS="true",INCMYTAR="false",INCARENA="true",ENEMYTARGETSIZE=40,INCARENAPETS="false",HIDE="true",NUMBOSS=4,EXISTSHOWPTAR=1,INCSELF="false",EXISTSHOWBOSS="true",DOUBLEWIDTH="false",EXISTSHOWARENA=3}
FrameAlias~f~1!{SIZE=12,NAME="",R=0.714,ALIAS="Group",G=0.714,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=0.714,OUTLINE=1}
FrameAlias~f~2!{A=0.66,NAME="",R=1,ALIAS="Not Used",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~3!{A=1,NAME="",R=1,ALIAS="Not Used 1",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~4!{A=0.65,NAME="",R=1,ALIAS="Not Used 2",G=1,SHOW="true",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~5!{A=0.8,NAME="",R=1,ALIAS="Not Used 3",G=0.282,SHOW="true",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=0.188,OUTLINE=1}
FrameAlias~f~6!{SIZE=12,NAME="",R=1,ALIAS="Vehicle",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~7!{A=0.63,NAME="Pets",R=1,ALIAS="Pets",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~8!{A=1,NAME="",R=1,ALIAS="Target",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~9!{A=1,NAME="",R=1,ALIAS="Focus",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~10!{A=1,NAME="Enemy",R=0.757,ALIAS="Enemy",G=0.153,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=0.153,OUTLINE=1}
FrameAliasBar~f~1!{A=0.5,TEXTURE="HealBot 10",B=0.25,HEIGHT=20,R=0.1,G=0.25,WIDTH=0.7}
FrameAliasBar~d!2~3~4~5~6~7~8~9~10~
Frame~f~1!{BACKR=0.071,AUTOCLOSE="false",BACKG=0.071,BORDERB=0.2,LOCKED="false",SCALE=1,BORDERA=1,SFOFFSETV=0,TIPLOC=5,BACKB=0.071,BACKA=0.9,OPENSOUND="false",BORDERG=0.2,BORDERR=0.2,SFOFFSETH=0}
Frame~f~2!{BACKR=0.071,BORDERR=0.2,BACKG=0.071,BORDERB=0.2,LOCKED="true",SCALE=0.85,BORDERA=1,SFOFFSETV=0,TIPLOC=5,BACKB=0.071,BACKA=0.9,OPENSOUND="false",AUTOCLOSE="false",BORDERG=0.2,SFOFFSETH=0}
Frame~f~3!{BACKR=0.071,BORDERR=0.2,BACKG=0.071,BORDERB=0.2,LOCKED="false",SCALE=0.85,BORDERA=1,SFOFFSETV=0,TIPLOC=4,BACKB=0.071,BACKA=0.9,OPENSOUND="false",AUTOCLOSE="false",BORDERG=0.2,SFOFFSETH=0}
Frame~f~4!{BACKR=0.071,BORDERR=0.2,BACKG=0.071,BORDERB=0.2,LOCKED="false",SCALE=0.85,BORDERA=1,SFOFFSETV=0,TIPLOC=2,BACKB=0.071,BACKA=0.9,OPENSOUND="false",AUTOCLOSE="false",BORDERG=0.2,SFOFFSETH=0}
Frame~f~5!{BACKR=0.071,BORDERR=0.2,BACKG=0.071,BORDERB=0.2,LOCKED="false",SCALE=0.85,BORDERA=1,SFOFFSETV=0,TIPLOC=4,BACKB=0.071,BACKA=0.9,OPENSOUND="false",AUTOCLOSE="false",BORDERG=0.2,SFOFFSETH=0}
Frame~f~6!{BACKR=0.071,BORDERR=0.2,BACKG=0.071,BORDERB=0.2,LOCKED="true",SCALE=0.85,BORDERA=1,SFOFFSETV=0,TIPLOC=1,BACKB=0.071,BACKA=0.9,OPENSOUND="false",AUTOCLOSE="false",BORDERG=0.2,SFOFFSETH=0}
Frame~f~7!{BACKR=0.071,AUTOCLOSE="false",BACKG=0.071,BORDERB=0.2,LOCKED="true",SCALE=1,BORDERA=1,SFOFFSETV=0,TIPLOC=3,BACKB=0.071,BACKA=0.9,OPENSOUND="false",BORDERG=0.2,BORDERR=0.2,SFOFFSETH=0}
Frame~d!8~9~
Frame~f~10!{BACKR=0.071,AUTOCLOSE="false",BACKG=0.071,BORDERB=0.2,LOCKED="true",SCALE=1,BORDERA=1,SFOFFSETV=0,TIPLOC=4,BACKB=0.071,BACKA=0.9,OPENSOUND="false",BORDERG=0.2,BORDERR=0.2,SFOFFSETH=0}
StickyFrames~f~1!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~d!2~3~4~5~6~7~
StickyFrames~f~8!{STUCK="true",STUCKTOPOINT="TOPRIGHT",STUCKTO=1,STUCKPOINT="TOPLEFT"}
StickyFrames~d!9~
StickyFrames~f~10!{STUCK="true",STUCKTOPOINT="TOPLEFT",STUCKTO=1,STUCKPOINT="BOTTOMLEFT"}
HealGroups~f~1!{FRAME=2,STATE="false",NAME="Self"}
HealGroups~f~2!{FRAME=1,STATE="true",NAME="Main tanks"}
HealGroups~f~3!{FRAME=1,STATE="true",NAME="Healers"}
HealGroups~f~4!{FRAME=1,STATE="true",NAME="Group"}
HealGroups~f~5!{FRAME=2,STATE="false",NAME="Private List"}
HealGroups~f~6!{FRAME=1,STATE="true",NAME="Raid"}
HealGroups~f~7!{FRAME=6,STATE="false",NAME="Vehicle"}
HealGroups~f~8!{FRAME=1,STATE="true",NAME="Pets"}
HealGroups~f~9!{FRAME=8,STATE="true",NAME="Target"}
HealGroups~f~10!{FRAME=9,STATE="true",NAME="Focus"}
HealGroups~f~11!{FRAME=10,STATE="true",NAME="Enemy"}
Anchors~f~1!{Y=66.68,GROW=2,BARS=1,FRAME=1,X=17.1}
Anchors~f~2!{Y=60.6,GROW=2,BARS=3,FRAME=3,X=22.47}
Anchors~f~3!{Y=40.21,GROW=2,BARS=1,FRAME=4,X=7.14}
Anchors~f~4!{Y=39.37,GROW=2,BARS=1,FRAME=3,X=7.52}
Anchors~f~5!{Y=56.81,GROW=2,BARS=1,FRAME=4,X=21.87}
Anchors~f~6!{Y=34.62,GROW=2,BARS=1,FRAME=2,X=34.81}
Anchors~f~7!{Y=39.43,GROW=2,BARS=1,FRAME=1,X=8.48}
Anchors~f~8!{Y=66.68,GROW=2,BARS=1,FRAME=1,X=22.47}
Anchors~d!9~
Anchors~f~10!{Y=68.35,GROW=2,BARS=3,FRAME=2,X=17.1}
HeadBar~f~1!{A=1,TEXTURE="Minimalist",SHOW="false",B=0.184,HEIGHT=11,R=0.184,G=0.184,WIDTH=0.75}
HeadBar~f~2!{SHOW="false",WIDTH=0.75,A=1,B=0.184,HEIGHT=13,R=0.184,G=0.184,TEXTURE="Minimalist"}
HeadBar~f~3!{SHOW="true",WIDTH=0.75,A=1,B=0.184,HEIGHT=15,R=0.184,G=0.184,TEXTURE="Minimalist"}
HeadBar~f~4!{SHOW="false",WIDTH=0.75,A=1,B=0.184,HEIGHT=11,R=0.184,G=0.184,TEXTURE="Minimalist"}
HeadBar~f~5!{A=1,TEXTURE="Minimalist",SHOW="false",B=0.184,HEIGHT=12,R=0.184,G=0.184,WIDTH=0.75}
HeadBar~f~6!{A=1,TEXTURE="Minimalist",SHOW="false",B=0.184,HEIGHT=8,R=0.184,G=0.184,WIDTH=0.75}
HeadBar~d!7~
HeadBar~f~8!{A=1,TEXTURE="Minimalist",SHOW="false",B=0.184,HEIGHT=11,R=0.184,G=0.184,WIDTH=0.75}
HeadBar~d!9~
HeadBar~f~10!{A=1,TEXTURE="Minimalist",SHOW="false",B=0.184,HEIGHT=8,R=0.184,G=0.184,WIDTH=0.75}
HeadText~f~1!{A=0.7,B=1,OFFSET=0,R=1,FONT="Friz Quadrata TT",HEIGHT=10,G=1,OUTLINE=1}
HeadText~f~2!{A=0.68,R=0.424,OFFSET=0,B=0.424,FONT="Friz Quadrata TT",HEIGHT=10,G=0.424,OUTLINE=1}
HeadText~f~3!{A=0.26,B=0.984,OFFSET=0,R=0.984,FONT="Friz Quadrata TT",HEIGHT=10,G=0.984,OUTLINE=1}
HeadText~f~4!{A=0.68,B=0.424,OFFSET=0,R=0.424,FONT="Friz Quadrata TT",HEIGHT=10,G=0.424,OUTLINE=1}
HeadText~d!5~6~7~8~9~10~
HealBar~f~1!{HEIGHT=35,GRPCOLS="false",CMARGIN=2,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=140,RMARGIN=1,OFIX=1,NUMCOLS=1,LOWMANA=2}
HealBar~f~2!{HEIGHT=42,GRPCOLS="false",CMARGIN=2,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",NUMCOLS=4,RMARGIN=1,OFIX=1,WIDTH=95,LOWMANA=2}
HealBar~f~3!{HEIGHT=50,GRPCOLS="false",CMARGIN=2,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",NUMCOLS=12,RMARGIN=1,OFIX=1,WIDTH=120,LOWMANA=2}
HealBar~f~4!{HEIGHT=34,GRPCOLS="false",CMARGIN=2,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",NUMCOLS=2,RMARGIN=1,OFIX=1,WIDTH=70,LOWMANA=2}
HealBar~f~5!{HEIGHT=38,GRPCOLS="false",CMARGIN=2,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",NUMCOLS=3,RMARGIN=1,OFIX=1,WIDTH=95,LOWMANA=2}
HealBar~f~6!{HEIGHT=25,GRPCOLS="false",CMARGIN=2,TEXTURE="Smooth",POWERCNT="true",LOWMANACOMBAT="true",NUMCOLS=2,RMARGIN=1,OFIX=1,WIDTH=144,LOWMANA=2}
HealBar~f~7!{HEIGHT=25,GRPCOLS="false",CMARGIN=2,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=55,RMARGIN=1,OFIX=1,NUMCOLS=2,LOWMANA=2}
HealBar~f~8!{HEIGHT=34,GRPCOLS="false",CMARGIN=2,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=120,RMARGIN=1,OFIX=1,NUMCOLS=2,LOWMANA=2}
HealBar~d!9~
HealBar~f~10!{HEIGHT=25,GRPCOLS="false",CMARGIN=2,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=140,RMARGIN=1,OFIX=1,NUMCOLS=1,LOWMANA=2}
BarCol~f~1!{BACK=3,BA=0.75,BOUT=2,DISA=0.18,BR=0.043,HB=0.749,BG=0.047,HG=0.776,HA=1,HR=0.753,ORA=0.4,BB=0.051,HLTH=3}
BarCol~f~2!{BACK=3,BA=0.95,BOUT=2,DISA=0.18,BR=0.043,HB=0.749,BG=0.047,BB=0.051,HA=1,HG=0.776,ORA=0.4,HR=0.753,HLTH=3}
BarCol~d!3~4~
BarCol~f~5!{BACK=3,BA=0.95,BOUT=2,DISA=0.18,BR=0.043,HB=0.149,BG=0.047,BB=0.051,HA=1,HR=0.776,ORA=0.4,HG=0.243,HLTH=3}
BarCol~f~6!{BACK=3,BA=0.95,BOUT=2,DISA=0.18,BR=0.043,HB=0.749,BG=0.047,BB=0.051,HA=1,HR=0.753,ORA=0.4,HG=0.776,HLTH=3}
BarCol~d!7~8~9~
BarCol~f~10!{BACK=3,BA=0.95,BOUT=2,DISA=0.18,BR=0.043,HB=0.149,BG=0.047,HG=0.243,HA=1,HR=0.776,ORA=0.4,BB=0.051,HLTH=3}
BarIACol~f~1!{AC=4,AB=0.38,AA=0.9,AR=0.38,AG=0.38,IC=4,IB=0.592,IA=0.9,IR=0.533,IG=0.533}
BarIACol~f~2!{AC=4,AB=0.38,AA=0.9,AR=0.38,AG=0.38,IC=4,IB=0.592,IA=0.94,IR=0.533,IG=0.533}
BarIACol~d!3~4~5~6~7~8~9~10~
BarText~f~1!{HLTHONBAR="false",TAGOOR="OOR-",OVERHEAL=1,MAXCHARS=0,CLASSONBAR="false",OUTLINE=1,HMAXCHARS=0,FONT="Friz Quadrata TT",INCHEALS=2,HLTHTXTANCHOR=1,HLTHTYPE=1,IGNOREONFULL="true",CLASSTYPE=1,NUMFORMAT2=1,HHEIGHT=10,TAGDC="DC-",NUMFORMAT1=1,TAGRIP="RIP-",HEIGHT=10,HFONT="Friz Quadrata TT",SHOWROLE="true",HALIGN=2,NAMEONBAR="true",OFFSET=-5,HOUTLINE=1,INCABSORBS=1,HOFFSET2=0,ALIGN=2,TAGR="R-",HOFFSET=0}
BarText~d!2~3~4~5~6~7~8~9~10~
BarTextCol~f~1!{NAME=2,NDEBUFF="false",HLTH=2,NCDA=0.4,HCG=0.996,HCA=1,NCG=0.996,NCA=1,HCR=1,HCB=0.043,NCR=1,HDEBUFF="false",NCB=0.043,HCDA=0.4}
BarTextCol~d!2~3~4~5~6~7~8~9~10~
Icons~f~1!{SHOWBUFF="true",POSITION=1,FADESECS=15,I15EN="false",MAXDICONS=3,FADE="false",SHOWDIR="true",DOUBLE="false",DSCALE=0.45,ONBAR=1,SHOWRC="true",SCALE=0.45,SHOWDIRMOUSE="false",SHOWDEBUFF="true",MAXBICONS=8}
Icons~d!2~3~4~5~6~7~8~9~10~
RaidIcon~f~1!{SQUARE="true",CIRCLE="true",DIAMOND="true",SHOW="true",SKULL="true",TRIANGLE="true",STAR="true",MOON="true",CROSS="true"}
RaidIcon~d!2~3~4~5~6~7~8~9~10~
IconText~f~1!{SDUR="true",HEIGHT=8,SSCNT="false",SCNT="true",DURTHRH=9,FONT="Friz Quadrata TT",DURWARN=3,SSDUR="true",OUTLINE=2}
IconText~f~2!{SDUR="true",HEIGHT=12,SSCNT="false",SCNT="true",DURTHRH=9,FONT="Friz Quadrata TT",DURWARN=3,SSDUR="true",OUTLINE=2}
IconText~f~3!{SDUR="true",HEIGHT=10,SSCNT="false",SCNT="true",DURTHRH=9,FONT="Friz Quadrata TT",DURWARN=3,SSDUR="true",OUTLINE=2}
IconText~f~4!{SDUR="true",HEIGHT=8,SSCNT="false",SCNT="true",DURTHRH=9,FONT="Friz Quadrata TT",DURWARN=3,SSDUR="true",OUTLINE=2}
IconText~d!5~6~7~8~9~
IconText~f~10!{SDUR="true",HEIGHT=9,SSCNT="false",SCNT="true",DURTHRH=9,FONT="Friz Quadrata TT",DURWARN=3,SSDUR="true",OUTLINE=2}
BarVisibility~f~1!{INCCLASSES=1,ALERTIC=0.95,ALERTOC=0.9,HIDEOOR="false"}
BarVisibility~f~2!{INCCLASSES=1,ALERTIC=1,ALERTOC=0.95,HIDEOOR="false"}
BarVisibility~d!3~4~5~6~7~8~9~10~
BarSort~f~1!{SUBORDER=1,OORLAST="false",RAIDORDER=3,SUBPF="true"}
BarSort~f~2!{SUBORDER=1,OORLAST="false",RAIDORDER=2,SUBPF="true"}
BarSort~f~3!{SUBORDER=1,OORLAST="false",RAIDORDER=3,SUBPF="true"}
BarSort~d!4~5~6~7~8~9~10~
BarAggro~f~1!{R=1,ALERTIND=2,G=0,TEXTFORMAT=3,SHOW="true",SHOWTEXTPCT="true",SHOWTEXT="false",SHOWIND="true",B=0,ALERT=2}
BarAggro~d!2~3~4~5~6~7~8~9~10~
AuxBarFrame~f~1!{OVERLAP=1}
AuxBarFrame~d!2~3~4~5~6~7~8~9~10~
AuxBar^1~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,OTYPE=1}
AuxBar^1~d!2~3~4~5~6~7~8~9~10~
AuxBar^2~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,OTYPE=1}
AuxBar^2~d!2~3~4~5~6~7~8~9~10~
AuxBar^3~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,OTYPE=1}
AuxBar^3~d!2~3~4~5~6~7~8~9~10~
AuxBar^4~f~1!{SIZE=0.98,USE=5,R=1,COLOUR=1,ANCHOR=2,OFFSET=1,DEPTH=1,G=1,B=1,OTYPE=1}
AuxBar^4~d!2~3~4~5~6~7~8~9~
AuxBar^4~f~10!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=2,OFFSET=1,DEPTH=1,G=1,B=1,OTYPE=1}
AuxBar^5~f~1!{SIZE=0.98,USE=5,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=1,G=1,B=1,OTYPE=1}
AuxBar^5~d!2~3~4~5~6~7~8~9~
AuxBar^5~f~10!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=1,G=1,B=1,OTYPE=1}
AuxBar^6~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,OTYPE=1}
AuxBar^6~d!2~3~4~5~6~7~8~9~10~
AuxBar^7~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,OTYPE=1}
AuxBar^7~d!2~3~4~5~6~7~8~9~10~
AuxBar^8~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,OTYPE=1}
AuxBar^8~d!2~3~4~5~6~7~8~9~10~
AuxBar^9~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,OTYPE=1}
AuxBar^9~d!2~3~4~5~6~7~8~9~10~
Complete!]]

HealBot_ExtraSkinData[46]=[[Skin
B&W-Raid25
Author~v!Monti of Terenas
DuplicateBars~v!false
Chat~t!{EOCOOM="false",EOCOOMV=20,MSG="Casting #s on #n",RESONLY="true",CHAN="",NOTIFY=1}
General~t!{OFREQ=0.07,OMIN=0.1,OMAX=0.95,HIDEBOSSF="true",HIDEPARTYF="true",HIDEPTF="false",STICKYSENSITIVITY=30,HIDERAIDF="true",STICKYFRAME="true",FLUIDBARS="true",FLUIDFREQ=10}
Healing~t!{TINCRAID="true",TINCSELF="false",GROUPPETS="true",TARGETINCOMBAT=1,TINCGROUP="true",FONLYFRIEND="false",FEXRAID="false",TONLYFRIEND="false",FALWAYSSHOW="false",FOCUSINCOMBAT=2,TALWAYSSHOW="false",TINCPET="false",SELFPET=0,TEXRAID="false",ALERT=0.95}
Enemy~t!{INCARENA="true",INCTANKS="true",INCMYTAR="false",ENEMYTARGET="false",INCARENAPETS="false",ENEMYTARGETSIZE=40,HIDE="true",NUMBOSS=4,EXISTSHOWPTAR=1,INCSELF="false",EXISTSHOWBOSS="true",DOUBLEWIDTH="false",EXISTSHOWARENA=3}
FrameAlias~f~1!{SIZE=12,NAME="Tanks",R=0.714,ALIAS="Tanks",G=0.714,SHOW="true",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=0.714,OUTLINE=1}
FrameAlias~f~2!{A=0.66,NAME="Raid",R=1,ALIAS="Raid",G=1,SHOW="true",OFFSET=0,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~3!{A=1,NAME="",R=1,ALIAS="Not Used 1",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~4!{A=0.65,NAME="",R=1,ALIAS="Not Used 2",G=1,SHOW="true",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~5!{A=0.8,NAME="",R=1,ALIAS="Not Used 3",G=0.282,SHOW="true",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=0.188,OUTLINE=1}
FrameAlias~f~6!{SIZE=12,NAME="",R=1,ALIAS="Vehicle",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~7!{A=0.63,NAME="Pets",R=1,ALIAS="Pets",G=1,SHOW="true",OFFSET=0,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~8!{A=1,NAME="Target",R=0.714,ALIAS="Target",G=0.714,SHOW="true",OFFSET=0,FONT="Friz Quadrata TT",SIZE=12,B=0.714,OUTLINE=1}
FrameAlias~f~9!{A=1,NAME="Focus",R=0.714,ALIAS="Focus",G=0.714,SHOW="true",OFFSET=0,FONT="Friz Quadrata TT",SIZE=12,B=0.714,OUTLINE=1}
FrameAlias~f~10!{A=1,NAME="Enemy",R=0.757,ALIAS="Enemy",G=0.153,SHOW="true",OFFSET=0,FONT="Friz Quadrata TT",SIZE=12,B=0.153,OUTLINE=1}
FrameAliasBar~f~1!{A=0.5,TEXTURE="HealBot 10",B=0.25,HEIGHT=20,R=0.1,G=0.25,WIDTH=0.9}
FrameAliasBar~d!2~
FrameAliasBar~f~3!{A=0.5,TEXTURE="HealBot 10",B=0.25,HEIGHT=20,R=0.1,G=0.25,WIDTH=0.7}
FrameAliasBar~d!4~5~6~
FrameAliasBar~f~7!{A=0.5,TEXTURE="HealBot 10",B=0.25,HEIGHT=20,R=0.1,G=0.25,WIDTH=0.9}
FrameAliasBar~f~8!{A=0.5,TEXTURE="HealBot 10",B=0.25,HEIGHT=20,R=0.1,G=0.25,WIDTH=0.8}
FrameAliasBar~d!9~
FrameAliasBar~f~10!{A=0.5,WIDTH=0.9,B=0.25,HEIGHT=20,R=0.1,G=0.25,TEXTURE="HealBot 10"}
Frame~f~1!{SFOFFSETH=0,BACKG=0.071,AUTOCLOSE="false",BORDERB=0.2,LOCKED="false",OPENSOUND="false",BORDERA=1,BORDERG=0.2,TIPLOC=3,BACKB=0.071,BACKA=0.9,SCALE=1,BORDERR=0.2,SFOFFSETV=0,BACKR=0.071}
Frame~f~2!{SFOFFSETH=0,BORDERR=0.2,AUTOCLOSE="false",BORDERB=0.2,LOCKED="true",OPENSOUND="false",BORDERA=1,BORDERG=0.2,TIPLOC=5,BACKB=0.071,BACKA=0.9,SCALE=1,BACKG=0.071,BACKR=0.071,SFOFFSETV=0}
Frame~f~3!{SFOFFSETH=0,BORDERR=0.2,AUTOCLOSE="false",BORDERB=0.2,LOCKED="false",OPENSOUND="false",BORDERA=1,BORDERG=0.2,TIPLOC=4,BACKB=0.071,BACKA=0.9,SCALE=0.85,BACKG=0.071,BACKR=0.071,SFOFFSETV=0}
Frame~f~4!{SFOFFSETH=0,BORDERR=0.2,AUTOCLOSE="false",BORDERB=0.2,LOCKED="false",OPENSOUND="false",BORDERA=1,BORDERG=0.2,TIPLOC=2,BACKB=0.071,BACKA=0.9,SCALE=0.85,BACKG=0.071,BACKR=0.071,SFOFFSETV=0}
Frame~f~5!{SFOFFSETH=0,BORDERR=0.2,AUTOCLOSE="false",BORDERB=0.2,LOCKED="false",OPENSOUND="false",BORDERA=1,BORDERG=0.2,TIPLOC=4,BACKB=0.071,BACKA=0.9,SCALE=0.85,BACKG=0.071,BACKR=0.071,SFOFFSETV=0}
Frame~f~6!{SFOFFSETH=0,BORDERR=0.2,AUTOCLOSE="false",BORDERB=0.2,LOCKED="true",OPENSOUND="false",BORDERA=1,BORDERG=0.2,TIPLOC=1,BACKB=0.071,BACKA=0.9,SCALE=0.85,BACKG=0.071,BACKR=0.071,SFOFFSETV=0}
Frame~f~7!{SFOFFSETH=0,BACKG=0.071,AUTOCLOSE="false",BORDERB=0.2,LOCKED="false",OPENSOUND="false",BORDERA=1,BORDERG=0.2,TIPLOC=3,BACKB=0.071,BACKA=0.9,SCALE=1,BORDERR=0.2,SFOFFSETV=0,BACKR=0.071}
Frame~f~8!{SFOFFSETH=0,BACKR=0.071,TIPLOC=3,BACKB=0.071,LOCKED="true",SCALE=1,BORDERA=1,BORDERG=0.2,AUTOCLOSE="false",BORDERB=0.2,BACKA=0.9,OPENSOUND="false",BACKG=0.071,BORDERR=0.2,SFOFFSETV=0}
Frame~d!9~
Frame~f~10!{SFOFFSETH=0,BACKG=0.071,AUTOCLOSE="false",BORDERB=0.2,LOCKED="true",OPENSOUND="false",BORDERA=1,BORDERG=0.2,TIPLOC=4,BACKB=0.071,BACKA=0.9,SCALE=1,BORDERR=0.2,SFOFFSETV=0,BACKR=0.071}
StickyFrames~f~1!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~f~2!{STUCK="true",STUCKTOPOINT="BOTTOMRIGHT",STUCKTO=1,STUCKPOINT="TOPRIGHT"}
StickyFrames~f~3!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~d!4~5~6~
StickyFrames~f~7!{STUCK="true",STUCKTOPOINT="BOTTOMLEFT",STUCKTO=2,STUCKPOINT="TOPLEFT"}
StickyFrames~f~8!{STUCK="true",STUCKTOPOINT="TOPLEFT",STUCKTO=1,STUCKPOINT="TOPRIGHT"}
StickyFrames~f~9!{STUCK="true",STUCKTOPOINT="TOPRIGHT",STUCKTO=1,STUCKPOINT="TOPLEFT"}
StickyFrames~f~10!{STUCK="true",STUCKTOPOINT="TOPLEFT",STUCKTO=1,STUCKPOINT="BOTTOMLEFT"}
HealGroups~f~1!{FRAME=1,STATE="true",NAME="Main tanks"}
HealGroups~f~2!{FRAME=2,STATE="true",NAME="Self"}
HealGroups~f~3!{FRAME=2,STATE="true",NAME="Healers"}
HealGroups~f~4!{FRAME=2,STATE="false",NAME="Group"}
HealGroups~f~5!{FRAME=2,STATE="false",NAME="Private List"}
HealGroups~f~6!{FRAME=2,STATE="true",NAME="Raid"}
HealGroups~f~7!{FRAME=6,STATE="false",NAME="Vehicle"}
HealGroups~f~8!{FRAME=7,STATE="true",NAME="Pets"}
HealGroups~f~9!{FRAME=8,STATE="true",NAME="Target"}
HealGroups~f~10!{FRAME=9,STATE="true",NAME="Focus"}
HealGroups~f~11!{FRAME=10,STATE="true",NAME="Enemy"}
Anchors~f~1!{Y=70.02,GROW=2,BARS=1,FRAME=1,X=18.71}
Anchors~f~2!{Y=62.85,GROW=2,BARS=3,FRAME=3,X=32.77}
Anchors~f~3!{Y=40.21,GROW=2,BARS=1,FRAME=4,X=7.14}
Anchors~f~4!{Y=39.37,GROW=2,BARS=1,FRAME=3,X=7.52}
Anchors~f~5!{Y=56.81,GROW=2,BARS=1,FRAME=4,X=21.87}
Anchors~f~6!{Y=34.62,GROW=2,BARS=1,FRAME=2,X=34.81}
Anchors~f~7!{Y=56.68,GROW=2,BARS=1,FRAME=1,X=29.04}
Anchors~f~8!{Y=70.02,GROW=2,BARS=1,FRAME=3,X=18.71}
Anchors~f~9!{Y=70.02,GROW=2,BARS=1,FRAME=1,X=32.77}
Anchors~f~10!{Y=71.69,GROW=2,BARS=3,FRAME=2,X=18.71}
HeadBar~f~1!{SHOW="false",TEXTURE="Minimalist",A=1,B=0.184,HEIGHT=15,R=0.184,G=0.184,WIDTH=0.75}
HeadBar~f~2!{A=1,WIDTH=0.75,SHOW="false",B=0.184,HEIGHT=13,R=0.184,G=0.184,TEXTURE="Minimalist"}
HeadBar~f~3!{A=1,WIDTH=0.75,SHOW="true",B=0.184,HEIGHT=15,R=0.184,G=0.184,TEXTURE="Minimalist"}
HeadBar~f~4!{A=1,WIDTH=0.75,SHOW="false",B=0.184,HEIGHT=11,R=0.184,G=0.184,TEXTURE="Minimalist"}
HeadBar~f~5!{SHOW="false",TEXTURE="Minimalist",A=1,B=0.184,HEIGHT=12,R=0.184,G=0.184,WIDTH=0.75}
HeadBar~f~6!{SHOW="false",TEXTURE="Minimalist",A=1,B=0.184,HEIGHT=8,R=0.184,G=0.184,WIDTH=0.75}
HeadBar~d!7~
HeadBar~f~8!{SHOW="false",TEXTURE="Minimalist",A=1,B=0.184,HEIGHT=11,R=0.184,G=0.184,WIDTH=0.75}
HeadBar~d!9~
HeadBar~f~10!{SHOW="false",TEXTURE="Minimalist",A=1,B=0.184,HEIGHT=8,R=0.184,G=0.184,WIDTH=0.75}
HeadText~f~1!{A=0.7,B=1,OFFSET=0,R=1,FONT="Friz Quadrata TT",HEIGHT=10,G=1,OUTLINE=1}
HeadText~f~2!{A=0.68,R=0.424,OFFSET=0,B=0.424,FONT="Friz Quadrata TT",HEIGHT=10,G=0.424,OUTLINE=1}
HeadText~f~3!{A=0.26,B=0.984,OFFSET=0,R=0.984,FONT="Friz Quadrata TT",HEIGHT=10,G=0.984,OUTLINE=1}
HeadText~f~4!{A=0.68,B=0.424,OFFSET=0,R=0.424,FONT="Friz Quadrata TT",HEIGHT=10,G=0.424,OUTLINE=1}
HeadText~d!5~6~7~8~9~10~
HealBar~f~1!{HEIGHT=50,GRPCOLS="false",CMARGIN=1,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=192,RMARGIN=1,OFIX=1,NUMCOLS=2,LOWMANA=2}
HealBar~f~2!{HEIGHT=38,GRPCOLS="false",CMARGIN=1,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",NUMCOLS=4,RMARGIN=1,OFIX=1,WIDTH=93,LOWMANA=2}
HealBar~f~3!{HEIGHT=50,GRPCOLS="false",CMARGIN=1,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",NUMCOLS=2,RMARGIN=1,OFIX=1,WIDTH=192,LOWMANA=2}
HealBar~d!4~5~6~
HealBar~f~7!{HEIGHT=24,GRPCOLS="false",CMARGIN=1,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=73,RMARGIN=1,OFIX=1,NUMCOLS=5,LOWMANA=2}
HealBar~f~8!{HEIGHT=50,GRPCOLS="false",CMARGIN=1,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=112,RMARGIN=1,OFIX=1,NUMCOLS=2,LOWMANA=2}
HealBar~d!9~
HealBar~f~10!{HEIGHT=35,GRPCOLS="false",CMARGIN=1,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=125,RMARGIN=1,OFIX=1,NUMCOLS=3,LOWMANA=2}
BarCol~f~1!{BACK=3,BA=0.75,BB=0.051,DISA=0.18,BR=0.043,HB=0.749,BG=0.047,HG=0.776,HA=1,HR=0.753,ORA=0.4,BOUT=2,HLTH=3}
BarCol~f~2!{BACK=3,BA=0.95,BOUT=2,DISA=0.18,BR=0.043,HB=0.749,BG=0.047,BB=0.051,HA=1,HG=0.776,ORA=0.4,HR=0.753,HLTH=3}
BarCol~d!3~4~
BarCol~f~5!{BACK=3,BA=0.95,BOUT=2,DISA=0.18,BR=0.043,HB=0.149,BG=0.047,BB=0.051,HA=1,HR=0.776,ORA=0.4,HG=0.243,HLTH=3}
BarCol~f~6!{BACK=3,BA=0.95,BOUT=2,DISA=0.18,BR=0.043,HB=0.749,BG=0.047,BB=0.051,HA=1,HR=0.753,ORA=0.4,HG=0.776,HLTH=3}
BarCol~d!7~8~9~
BarCol~f~10!{BACK=3,BA=0.95,BB=0.051,DISA=0.18,BR=0.043,HB=0.149,BG=0.047,HG=0.243,HA=1,HR=0.776,ORA=0.4,BOUT=2,HLTH=3}
BarIACol~f~1!{AC=4,AB=0.38,AA=0.9,AR=0.38,AG=0.38,IC=4,IB=0.592,IA=0.9,IR=0.533,IG=0.533}
BarIACol~f~2!{AC=4,AB=0.38,AA=0.9,AR=0.38,AG=0.38,IC=4,IB=0.592,IA=0.94,IR=0.533,IG=0.533}
BarIACol~d!3~4~5~6~7~8~9~10~
BarText~f~1!{HLTHONBAR="false",TAGOOR="OOR-",IGNOREONFULL="true",MAXCHARS=0,HMAXCHARS=0,OUTLINE=1,HLTHTYPE=1,CLASSONBAR="false",INCHEALS=2,HLTHTXTANCHOR=1,FONT="Friz Quadrata TT",HOUTLINE=1,CLASSTYPE=1,NUMFORMAT2=1,HHEIGHT=10,TAGDC="DC-",NUMFORMAT1=1,TAGRIP="RIP-",HEIGHT=10,HFONT="Friz Quadrata TT",SHOWROLE="true",HALIGN=2,NAMEONBAR="true",OFFSET=-5,OVERHEAL=1,INCABSORBS=1,HOFFSET2=0,ALIGN=2,TAGR="R- ",HOFFSET=0}
BarText~d!2~3~4~5~6~7~8~9~10~
BarTextCol~f~1!{NCB=0.043,HCA=1,HLTH=2,NCDA=0.58,HCG=0.996,NAME=2,NCG=0.996,NCA=1,HCR=1,HCB=0.043,NCR=1,HDEBUFF="false",NDEBUFF="false",HCDA=0.58}
BarTextCol~d!2~3~4~5~6~7~8~9~10~
Icons~f~1!{SHOWBUFF="true",POSITION=1,MAXDICONS=3,DOUBLE="false",I15EN="false",SHOWDIRMOUSE="false",ONBAR=1,FADE="false",DSCALE=0.35,SHOWDIR="true",SHOWRC="true",SCALE=0.35,SHOWDEBUFF="true",FADESECS=15,MAXBICONS=8}
Icons~f~2!{SHOWBUFF="true",POSITION=1,MAXDICONS=3,SHOWDIRMOUSE="false",I15EN="false",DOUBLE="true",ONBAR=1,FADE="false",DSCALE=0.8,SHOWDIR="true",SHOWRC="true",SCALE=0.8,SHOWDEBUFF="true",FADESECS=15,MAXBICONS=8}
Icons~f~3!{SHOWBUFF="true",POSITION=1,MAXDICONS=3,SHOWDIRMOUSE="false",I15EN="true",DOUBLE="false",ONBAR=1,FADE="true",DSCALE=0.4,SHOWDIR="true",SHOWRC="true",SCALE=0.4,SHOWDEBUFF="true",FADESECS=15,MAXBICONS=8}
Icons~d!4~5~
Icons~f~6!{SHOWBUFF="true",POSITION=1,MAXDICONS=3,DOUBLE="false",I15EN="true",SHOWDIRMOUSE="false",ONBAR=1,FADE="true",DSCALE=0.5,SHOWDIR="true",SHOWRC="true",SCALE=0.5,SHOWDEBUFF="true",FADESECS=15,MAXBICONS=8}
Icons~f~7!{SHOWBUFF="true",SHOWDEBUFF="true",FADESECS=15,I15EN="false",POSITION=1,FADE="false",SHOWDIR="true",SHOWDIRMOUSE="false",DSCALE=0.5,ONBAR=1,SHOWRC="true",SCALE=0.5,MAXDICONS=3,DOUBLE="false",MAXBICONS=8}
Icons~f~8!{SHOWBUFF="true",SHOWDEBUFF="true",FADESECS=15,I15EN="false",POSITION=1,FADE="false",SHOWDIR="true",SHOWDIRMOUSE="false",DSCALE=0.45,ONBAR=1,SHOWRC="true",SCALE=0.45,MAXDICONS=3,DOUBLE="false",MAXBICONS=8}
Icons~d!9~10~
RaidIcon~f~1!{SQUARE="true",CIRCLE="true",DIAMOND="true",SHOW="true",SKULL="true",TRIANGLE="true",STAR="true",MOON="true",CROSS="true"}
RaidIcon~d!2~3~4~5~6~7~8~9~10~
IconText~f~1!{DURWARN=3,HEIGHT=10,SSCNT="false",SCNT="true",DURTHRH=9,FONT="Friz Quadrata TT",SDUR="true",SSDUR="true",OUTLINE=2}
IconText~f~2!{DURWARN=3,HEIGHT=12,SSCNT="false",SCNT="true",DURTHRH=9,FONT="Friz Quadrata TT",SDUR="true",SSDUR="true",OUTLINE=2}
IconText~f~3!{DURWARN=3,HEIGHT=10,SSCNT="false",SCNT="true",DURTHRH=9,FONT="Friz Quadrata TT",SDUR="true",SSDUR="true",OUTLINE=2}
IconText~f~4!{DURWARN=3,HEIGHT=8,SSCNT="false",SCNT="true",DURTHRH=9,FONT="Friz Quadrata TT",SDUR="true",SSDUR="true",OUTLINE=2}
IconText~d!5~6~7~8~9~
IconText~f~10!{DURWARN=3,HEIGHT=9,SSCNT="false",SCNT="true",DURTHRH=9,FONT="Friz Quadrata TT",SDUR="true",SSDUR="true",OUTLINE=2}
BarVisibility~f~1!{INCCLASSES=1,ALERTIC=1,ALERTOC=0.95,HIDEOOR="false"}
BarVisibility~f~2!{INCCLASSES=1,ALERTIC=0.95,ALERTOC=0.85,HIDEOOR="false"}
BarVisibility~f~3!{INCCLASSES=1,ALERTIC=1,ALERTOC=0.95,HIDEOOR="false"}
BarVisibility~d!4~5~6~
BarVisibility~f~7!{INCCLASSES=1,ALERTIC=0.9,ALERTOC=0.75,HIDEOOR="true"}
BarVisibility~f~8!{INCCLASSES=1,ALERTIC=1,ALERTOC=0.95,HIDEOOR="false"}
BarVisibility~d!9~10~
BarSort~f~1!{SUBORDER=1,OORLAST="false",RAIDORDER=3,SUBPF="true"}
BarSort~f~2!{SUBORDER=1,OORLAST="false",RAIDORDER=2,SUBPF="true"}
BarSort~f~3!{SUBORDER=1,OORLAST="false",RAIDORDER=3,SUBPF="true"}
BarSort~d!4~5~6~7~8~9~10~
BarAggro~f~1!{R=1,ALERTIND=2,G=0,TEXTFORMAT=3,SHOW="true",SHOWTEXTPCT="true",SHOWTEXT="false",SHOWIND="true",B=0,ALERT=2}
BarAggro~d!2~3~4~5~6~7~8~9~10~
AuxBarFrame~f~1!{OVERLAP=1}
AuxBarFrame~d!2~3~4~5~6~7~8~9~10~
AuxBar^1~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,OTYPE=1}
AuxBar^1~d!2~3~4~5~6~7~8~9~10~
AuxBar^2~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,OTYPE=1}
AuxBar^2~d!2~3~4~5~6~7~8~9~10~
AuxBar^3~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,OTYPE=1}
AuxBar^3~d!2~3~4~5~6~7~8~9~10~
AuxBar^4~f~1!{SIZE=0.98,USE=5,R=1,COLOUR=1,ANCHOR=2,OFFSET=0,DEPTH=1,G=1,B=1,OTYPE=1}
AuxBar^4~d!2~3~4~5~6~7~8~9~
AuxBar^4~f~10!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=2,OFFSET=0,DEPTH=1,G=1,B=1,OTYPE=1}
AuxBar^5~f~1!{SIZE=0.98,USE=5,R=1,COLOUR=1,ANCHOR=1,OFFSET=0,DEPTH=1,G=1,B=1,OTYPE=1}
AuxBar^5~d!2~3~4~5~6~7~8~9~
AuxBar^5~f~10!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=0,DEPTH=1,G=1,B=1,OTYPE=1}
AuxBar^6~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,OTYPE=1}
AuxBar^6~d!2~3~4~5~6~7~8~9~10~
AuxBar^7~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,OTYPE=1}
AuxBar^7~d!2~3~4~5~6~7~8~9~10~
AuxBar^8~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,OTYPE=1}
AuxBar^8~d!2~3~4~5~6~7~8~9~10~
AuxBar^9~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,OTYPE=1}
AuxBar^9~d!2~3~4~5~6~7~8~9~10~
Complete!]]
HealBot_ExtraSkinData[47]=[[Skin
B&W Raid40
Author~v!Monti of Terenas
DuplicateBars~v!true
Chat~t!{EOCOOM="false",EOCOOMV=20,MSG="Casting #s on #n",RESONLY="true",CHAN="",NOTIFY=1}
General~t!{OFREQ=0.07,OMIN=0.1,OMAX=0.95,FLUIDFREQ=10,HIDEPTF="false",HIDEBOSSF="true",STICKYSENSITIVITY=30,HIDERAIDF="true",STICKYFRAME="true",FLUIDBARS="true",HIDEPARTYF="true"}
Healing~t!{TINCRAID="true",TINCSELF="false",GROUPPETS="true",TARGETINCOMBAT=1,FALWAYSSHOW="false",FONLYFRIEND="false",FEXRAID="false",TONLYFRIEND="false",TINCGROUP="true",FOCUSINCOMBAT=2,TALWAYSSHOW="false",TINCPET="false",SELFPET=0,TEXRAID="false",ALERT=0.95}
Enemy~t!{INCARENA="true",INCTANKS="true",INCMYTAR="false",ENEMYTARGET="false",ENEMYTARGETSIZE=40,INCARENAPETS="false",INCSELF="false",NUMBOSS=4,EXISTSHOWPTAR=1,HIDE="true",EXISTSHOWBOSS="true",DOUBLEWIDTH="false",EXISTSHOWARENA=3}
FrameAlias~f~1!{SIZE=12,NAME="Tanks",R=1,ALIAS="Tanks",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=0.66,B=1,OUTLINE=1}
FrameAlias~f~2!{A=0.66,NAME="Raid",R=1,ALIAS="Raid",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~3!{A=0.66,NAME="",R=1,ALIAS="Not Used 1",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~4!{A=0.66,NAME="",R=1,ALIAS="Not Used 2",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~5!{A=0.66,NAME="",R=1,ALIAS="Not Used 3",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~6!{SIZE=12,NAME="",R=1,ALIAS="Vehicle",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=0.66,B=1,OUTLINE=1}
FrameAlias~f~7!{A=0.66,NAME="Pets",R=1,ALIAS="Pets",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~8!{A=0.66,NAME="Target",R=1,ALIAS="Target",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~9!{A=0.66,NAME="Focus",R=1,ALIAS="Focus",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~10!{A=0.66,NAME="Enemy",R=1,ALIAS="Enemy",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAliasBar~f~1!{A=0.5,WIDTH=0.9,B=0.25,HEIGHT=20,R=0.1,G=0.25,TEXTURE="Empty"}
FrameAliasBar~f~2!{A=0.5,TEXTURE="HealBot 10",B=0.25,HEIGHT=20,R=0.1,G=0.25,WIDTH=0.9}
FrameAliasBar~f~3!{A=0.5,WIDTH=0.9,B=0.25,HEIGHT=20,R=0.1,G=0.25,TEXTURE="Empty"}
FrameAliasBar~d!4~5~6~7~8~9~10~
Frame~f~1!{BACKR=0.071,BORDERR=0.2,SFOFFSETH=0,SFOFFSETV=0,LOCKED="false",SCALE=1,BORDERA=1,BORDERG=0.2,AUTOCLOSE="false",BORDERB=0.2,BACKA=0.9,OPENSOUND="false",BACKB=0.071,BACKG=0.071,TIPLOC=3}
Frame~f~2!{BACKR=0.071,BORDERR=0.2,SFOFFSETV=0,AUTOCLOSE="false",LOCKED="true",SCALE=1,BORDERA=1,BORDERG=0.2,TIPLOC=5,BORDERB=0.2,BACKA=0.9,OPENSOUND="false",BACKB=0.071,BACKG=0.071,SFOFFSETH=0}
Frame~f~3!{BACKR=0.071,BORDERR=0.2,SFOFFSETV=0,AUTOCLOSE="false",LOCKED="false",SCALE=0.85,BORDERA=1,BORDERG=0.2,TIPLOC=4,BORDERB=0.2,BACKA=0.9,OPENSOUND="false",BACKB=0.071,BACKG=0.071,SFOFFSETH=0}
Frame~f~4!{BACKR=0.071,BORDERR=0.2,SFOFFSETV=0,AUTOCLOSE="false",LOCKED="false",SCALE=0.85,BORDERA=1,BORDERG=0.2,TIPLOC=2,BORDERB=0.2,BACKA=0.9,OPENSOUND="false",BACKB=0.071,BACKG=0.071,SFOFFSETH=0}
Frame~f~5!{BACKR=0.071,BORDERR=0.2,SFOFFSETV=0,AUTOCLOSE="false",LOCKED="false",SCALE=0.85,BORDERA=1,BORDERG=0.2,TIPLOC=4,BORDERB=0.2,BACKA=0.9,OPENSOUND="false",BACKB=0.071,BACKG=0.071,SFOFFSETH=0}
Frame~f~6!{BACKR=0.071,BORDERR=0.2,SFOFFSETV=0,AUTOCLOSE="false",LOCKED="true",SCALE=0.85,BORDERA=1,BORDERG=0.2,TIPLOC=1,BORDERB=0.2,BACKA=0.9,OPENSOUND="false",BACKB=0.071,BACKG=0.071,SFOFFSETH=0}
Frame~f~7!{BACKR=0.071,BORDERR=0.2,SFOFFSETH=0,SFOFFSETV=0,LOCKED="true",SCALE=1,BORDERA=1,BORDERG=0.2,AUTOCLOSE="false",BORDERB=0.2,BACKA=0.9,OPENSOUND="false",BACKB=0.071,BACKG=0.071,TIPLOC=3}
Frame~d!8~9~
Frame~f~10!{BACKR=0.071,BORDERR=0.2,SFOFFSETH=0,SFOFFSETV=0,LOCKED="true",SCALE=1,BORDERA=1,BORDERG=0.2,AUTOCLOSE="false",BORDERB=0.2,BACKA=0.9,OPENSOUND="false",BACKB=0.071,BACKG=0.071,TIPLOC=4}
StickyFrames~f~1!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~f~2!{STUCK="true",STUCKTOPOINT="BOTTOMRIGHT",STUCKTO=1,STUCKPOINT="TOPRIGHT"}
StickyFrames~f~3!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~d!4~5~6~
StickyFrames~f~7!{STUCK="true",STUCKTOPOINT="BOTTOMLEFT",STUCKTO=2,STUCKPOINT="TOPLEFT"}
StickyFrames~f~8!{STUCK="true",STUCKTOPOINT="TOPLEFT",STUCKTO=1,STUCKPOINT="TOPRIGHT"}
StickyFrames~f~9!{STUCK="true",STUCKTOPOINT="TOPRIGHT",STUCKTO=1,STUCKPOINT="TOPLEFT"}
StickyFrames~f~10!{STUCK="true",STUCKTOPOINT="TOPLEFT",STUCKTO=1,STUCKPOINT="BOTTOMLEFT"}
HealGroups~f~1!{FRAME=1,STATE="true",NAME="Main tanks"}
HealGroups~f~2!{FRAME=2,STATE="false",NAME="Self"}
HealGroups~f~3!{FRAME=2,STATE="false",NAME="Healers"}
HealGroups~f~4!{FRAME=2,STATE="false",NAME="Group"}
HealGroups~f~5!{FRAME=2,STATE="false",NAME="Private List"}
HealGroups~f~6!{FRAME=2,STATE="true",NAME="Raid"}
HealGroups~f~7!{FRAME=6,STATE="false",NAME="Vehicle"}
HealGroups~f~8!{FRAME=7,STATE="true",NAME="Pets"}
HealGroups~f~9!{FRAME=8,STATE="true",NAME="Target"}
HealGroups~f~10!{FRAME=9,STATE="false",NAME="Focus"}
HealGroups~f~11!{FRAME=10,STATE="true",NAME="Enemy"}
Anchors~f~1!{Y=69.25,GROW=1,BARS=1,FRAME=1,X=14.23}
Anchors~f~2!{Y=64.93,GROW=1,BARS=1,FRAME=3,X=32.05}
Anchors~f~3!{Y=40.21,GROW=2,BARS=1,FRAME=4,X=7.14}
Anchors~f~4!{Y=39.37,GROW=2,BARS=1,FRAME=3,X=7.52}
Anchors~f~5!{Y=56.81,GROW=2,BARS=1,FRAME=4,X=21.87}
Anchors~f~6!{Y=34.62,GROW=2,BARS=1,FRAME=2,X=34.81}
Anchors~f~7!{Y=60.87,GROW=1,BARS=1,FRAME=1,X=26.03}
Anchors~f~8!{Y=69.25,GROW=2,BARS=1,FRAME=3,X=14.23}
Anchors~f~9!{Y=66.55,GROW=2,BARS=1,FRAME=1,X=33.99}
Anchors~f~10!{Y=69.25,GROW=1,BARS=1,FRAME=2,X=14.23}
HeadBar~f~1!{SHOW="true",WIDTH=0.75,A=1,B=0.184,HEIGHT=30,R=0.184,G=0.184,TEXTURE="Empty"}
HeadBar~f~2!{A=1,TEXTURE="Empty",SHOW="true",B=0.184,HEIGHT=30,R=0.184,G=0.184,WIDTH=0.95}
HeadBar~f~3!{A=1,TEXTURE="Empty",SHOW="true",B=0.184,HEIGHT=30,R=0.184,G=0.184,WIDTH=0.75}
HeadBar~d!4~5~6~
HeadBar~f~7!{A=1,TEXTURE="Empty",SHOW="true",B=0.184,HEIGHT=30,R=0.184,G=0.184,WIDTH=0.95}
HeadBar~f~8!{SHOW="true",WIDTH=0.75,A=1,B=0.184,HEIGHT=30,R=0.184,G=0.184,TEXTURE="Empty"}
HeadBar~d!9~
HeadBar~f~10!{SHOW="true",WIDTH=0.95,A=1,B=0.184,HEIGHT=30,R=0.184,G=0.184,TEXTURE="Empty"}
HeadText~f~1!{A=0.68,R=0.62,OFFSET=0,B=0.62,FONT="Friz Quadrata TT",HEIGHT=10,G=0.62,OUTLINE=1}
HeadText~d!2~3~4~5~6~7~8~9~10~
HealBar~f~1!{HEIGHT=35,GRPCOLS="false",CMARGIN=1,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=2,NUMCOLS=4,OFIX=1,RMARGIN=1,WIDTH=99}
HealBar~f~2!{HEIGHT=32,GRPCOLS="false",CMARGIN=1,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=2,WIDTH=78,OFIX=1,RMARGIN=1,NUMCOLS=1}
HealBar~f~3!{HEIGHT=50,GRPCOLS="false",CMARGIN=1,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=2,WIDTH=192,OFIX=1,RMARGIN=1,NUMCOLS=2}
HealBar~d!4~5~6~
HealBar~f~7!{HEIGHT=24,GRPCOLS="false",CMARGIN=1,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=2,NUMCOLS=1,OFIX=1,RMARGIN=1,WIDTH=78}
HealBar~f~8!{HEIGHT=35,GRPCOLS="false",CMARGIN=1,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=2,NUMCOLS=2,OFIX=1,RMARGIN=1,WIDTH=92}
HealBar~d!9~
HealBar~f~10!{HEIGHT=30,GRPCOLS="false",CMARGIN=1,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=2,NUMCOLS=1,OFIX=1,RMARGIN=1,WIDTH=78}
BarCol~f~1!{BACK=3,BA=0.75,BOUT=2,DISA=0.18,BR=0.043,HB=0.749,BG=0.047,BB=0.051,HA=1,HG=0.776,ORA=0.4,HR=0.753,HLTH=3}
BarCol~f~2!{BACK=3,BA=0.95,BB=0.051,DISA=0.18,BR=0.043,HB=0.749,BG=0.047,HR=0.753,HA=1,HG=0.776,ORA=0.4,BOUT=2,HLTH=3}
BarCol~d!3~4~
BarCol~f~5!{BACK=3,BA=0.95,BB=0.051,DISA=0.18,BR=0.043,HB=0.149,BG=0.047,HG=0.243,HA=1,HR=0.776,ORA=0.4,BOUT=2,HLTH=3}
BarCol~f~6!{BACK=3,BA=0.95,BB=0.051,DISA=0.18,BR=0.043,HB=0.749,BG=0.047,HG=0.776,HA=1,HR=0.753,ORA=0.4,BOUT=2,HLTH=3}
BarCol~d!7~8~9~
BarCol~f~10!{BACK=3,BA=0.95,BOUT=2,DISA=0.18,BR=0.043,HB=0.149,BG=0.047,BB=0.051,HA=1,HG=0.243,ORA=0.4,HR=0.776,HLTH=3}
BarIACol~f~1!{AC=4,AB=0.38,AA=0.9,AR=0.38,AG=0.38,IC=4,IB=0.592,IA=0.9,IR=0.533,IG=0.533}
BarIACol~f~2!{AC=4,AB=0.38,AA=0.9,AR=0.38,AG=0.38,IC=4,IB=0.592,IA=0.94,IR=0.533,IG=0.533}
BarIACol~d!3~4~5~6~7~8~9~10~
BarText~f~1!{HHEIGHT=10,TAGOOR="OOR-",IGNOREONFULL="true",MAXCHARS=0,HMAXCHARS=0,HOFFSET=0,CLASSONBAR="false",FONT="Friz Quadrata TT",INCHEALS=2,HLTHTXTANCHOR=1,HLTHTYPE=1,OVERHEAL=1,INCABSORBS=1,NUMFORMAT2=1,HOUTLINE=1,TAGDC="DC-",OFFSET=-5,NAMEONBAR="true",HEIGHT=10,HFONT="Friz Quadrata TT",SHOWROLE="true",HALIGN=2,TAGRIP="RIP-",NUMFORMAT1=1,HLTHONBAR="false",CLASSTYPE=1,HOFFSET2=0,ALIGN=2,TAGR="R- ",OUTLINE=1}
BarText~d!2~3~4~5~6~7~8~9~10~
BarTextCol~f~1!{NCB=0.043,NCR=1,HCDA=0.58,NCDA=0.58,NAME=2,HCA=1,HCB=0.043,HCR=1,NCA=1,NCG=0.996,NDEBUFF="false",HDEBUFF="false",HCG=0.996,HLTH=2}
BarTextCol~d!2~3~4~5~6~7~8~9~10~
Icons~f~1!{SHOWBUFF="true",SHOWDEBUFF="true",FADESECS=15,MAXDICONS=3,I15EN="false",POSITION=1,SHOWDIR="false",FADE="false",DSCALE=0.4,ONBAR=1,SHOWRC="true",SCALE=0.4,DOUBLE="false",SHOWDIRMOUSE="false",MAXBICONS=8}
Icons~f~2!{SHOWBUFF="true",SHOWDEBUFF="true",FADESECS=15,MAXDICONS=3,I15EN="false",POSITION=1,SHOWDIR="false",FADE="false",DSCALE=0.9,ONBAR=1,SHOWRC="true",SCALE=0.9,SHOWDIRMOUSE="false",DOUBLE="true",MAXBICONS=8}
Icons~f~3!{SHOWBUFF="true",SHOWDEBUFF="true",FADESECS=15,MAXDICONS=3,I15EN="false",POSITION=1,SHOWDIR="false",FADE="false",DSCALE=0.4,ONBAR=1,SHOWRC="true",SCALE=0.4,SHOWDIRMOUSE="false",DOUBLE="false",MAXBICONS=8}
Icons~d!4~5~6~7~8~9~10~
RaidIcon~f~1!{SQUARE="true",CIRCLE="true",DIAMOND="true",SHOW="true",MOON="true",TRIANGLE="true",STAR="true",CROSS="true",SKULL="true"}
RaidIcon~d!2~3~4~5~6~7~8~9~10~
IconText~f~1!{DURWARN=3,HEIGHT=10,SSCNT="false",SCNT="true",DURTHRH=9,FONT="Friz Quadrata TT",SDUR="true",SSDUR="true",OUTLINE=2}
IconText~f~2!{DURWARN=3,HEIGHT=12,SSCNT="false",SCNT="true",DURTHRH=9,FONT="Friz Quadrata TT",SDUR="true",SSDUR="true",OUTLINE=2}
IconText~f~3!{DURWARN=3,HEIGHT=10,SSCNT="false",SCNT="true",DURTHRH=9,FONT="Friz Quadrata TT",SDUR="true",SSDUR="true",OUTLINE=2}
IconText~f~4!{DURWARN=3,HEIGHT=8,SSCNT="false",SCNT="true",DURTHRH=9,FONT="Friz Quadrata TT",SDUR="true",SSDUR="true",OUTLINE=2}
IconText~d!5~6~7~8~9~
IconText~f~10!{DURWARN=3,HEIGHT=9,SSCNT="false",SCNT="true",DURTHRH=9,FONT="Friz Quadrata TT",SDUR="true",SSDUR="true",OUTLINE=2}
BarVisibility~f~1!{INCCLASSES=1,ALERTIC=0.98,ALERTOC=0.9,HIDEOOR="false"}
BarVisibility~f~2!{INCCLASSES=1,ALERTIC=0.95,ALERTOC=0.85,HIDEOOR="false"}
BarVisibility~f~3!{INCCLASSES=1,ALERTIC=1,ALERTOC=0.95,HIDEOOR="false"}
BarVisibility~d!4~5~6~
BarVisibility~f~7!{INCCLASSES=1,ALERTIC=0.9,ALERTOC=0.75,HIDEOOR="true"}
BarVisibility~f~8!{INCCLASSES=1,ALERTIC=1,ALERTOC=0.95,HIDEOOR="false"}
BarVisibility~d!9~10~
BarSort~f~1!{SUBORDER=1,OORLAST="false",RAIDORDER=3,SUBPF="true"}
BarSort~d!2~3~4~5~6~7~8~9~10~
BarAggro~f~1!{R=1,ALERTIND=2,G=0,TEXTFORMAT=3,SHOW="true",SHOWTEXTPCT="true",SHOWIND="false",SHOWTEXT="false",B=0,ALERT=2}
BarAggro~d!2~3~4~5~6~7~8~9~10~
AuxBarFrame~f~1!{OVERLAP=1}
AuxBarFrame~d!2~3~4~5~6~7~8~9~10~
AuxBar^1~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,OTYPE=1,B=1,G=1}
AuxBar^1~d!2~3~4~5~6~7~8~9~10~
AuxBar^2~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,OTYPE=1,B=1,G=1}
AuxBar^2~d!2~3~4~5~6~7~8~9~10~
AuxBar^3~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,OTYPE=1,B=1,G=1}
AuxBar^3~d!2~3~4~5~6~7~8~9~10~
AuxBar^4~f~1!{SIZE=0.98,USE=5,R=1,COLOUR=1,ANCHOR=2,OFFSET=0,DEPTH=1,OTYPE=1,B=1,G=1}
AuxBar^4~d!2~3~4~5~6~7~8~9~
AuxBar^4~f~10!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=2,OFFSET=0,DEPTH=1,OTYPE=1,B=1,G=1}
AuxBar^5~f~1!{SIZE=0.98,USE=5,R=1,COLOUR=1,ANCHOR=1,OFFSET=0,DEPTH=1,OTYPE=1,B=1,G=1}
AuxBar^5~d!2~3~4~5~6~7~8~9~
AuxBar^5~f~10!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=0,DEPTH=1,OTYPE=1,B=1,G=1}
AuxBar^6~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,OTYPE=1,B=1,G=1}
AuxBar^6~d!2~3~4~5~6~7~8~9~10~
AuxBar^7~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,OTYPE=1,B=1,G=1}
AuxBar^7~d!2~3~4~5~6~7~8~9~10~
AuxBar^8~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,OTYPE=1,B=1,G=1}
AuxBar^8~d!2~3~4~5~6~7~8~9~10~
AuxBar^9~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,OTYPE=1,B=1,G=1}
AuxBar^9~d!2~3~4~5~6~7~8~9~10~
Complete!]]
HealBot_ExtraSkinData[48]=[[Skin
High-Vis
Author~v!Monti of Terenas
DuplicateBars~v!false
Chat~t!{EOCOOM="false",EOCOOMV=20,MSG="",RESONLY="true",CHAN="",NOTIFY=1}
General~t!{OFREQ=0.07,OMIN=0.1,OMAX=0.95,FLUIDFREQ=10,HIDEPARTYF="true",HIDEBOSSF="true",HIDERAIDF="true",STICKYFRAME="true",STICKYSENSITIVITY=30,FLUIDBARS="false",HIDEPTF="false"}
Healing~t!{TINCSELF="false",GROUPPETS="false",TARGETINCOMBAT=2,FEXRAID="false",FONLYFRIEND="false",TINCPET="false",TONLYFRIEND="false",TINCGROUP="true",FOCUSINCOMBAT=2,TALWAYSSHOW="false",SELFPET=0,TINCRAID="true",TEXRAID="false",FALWAYSSHOW="false"}
Enemy~t!{ENEMYTARGET="false",INCTANKS="false",INCMYTAR="false",INCARENA="true",INCARENAPETS="false",ENEMYTARGETSIZE=40,HIDE="true",NUMBOSS=2,EXISTSHOWPTAR=1,INCSELF="false",EXISTSHOWBOSS="true",DOUBLEWIDTH="false",EXISTSHOWARENA=3}
FrameAlias~f~1!{SIZE=12,NAME="",R=1,ALIAS="Group",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~2!{SIZE=12,NAME="",R=1,ALIAS="Frame 1",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~d!3~4~5~
FrameAlias~f~6!{SIZE=12,NAME="",R=1,ALIAS="Vehicle",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~7!{SIZE=12,NAME="",R=1,ALIAS="Pets",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~8!{SIZE=12,NAME="",R=1,ALIAS="Target",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~9!{SIZE=12,NAME="",R=1,ALIAS="Focus",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~10!{SIZE=12,NAME="",R=1,ALIAS="Enemy",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAliasBar~f~1!{A=0.5,WIDTH=0.7,B=0.25,HEIGHT=20,R=0.1,G=0.25,TEXTURE="HealBot 10"}
FrameAliasBar~d!2~3~4~5~6~7~8~9~10~
Frame~f~1!{BACKR=0.1,SFOFFSETH=0,SFOFFSETV=0,BACKG=0.1,LOCKED="false",OPENSOUND="false",BORDERA=0.2,BORDERG=0.2,TIPLOC=5,BACKB=0.1,BACKA=0.05,SCALE=1,BORDERB=0.2,AUTOCLOSE="false",BORDERR=0.2}
Frame~d!2~3~4~5~6~7~8~9~10~
StickyFrames~f~1!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~d!2~3~4~5~6~7~
StickyFrames~f~8!{STUCK="true",STUCKTOPOINT="TOPLEFT",STUCKTO=1,STUCKPOINT="TOPRIGHT"}
StickyFrames~f~9!{STUCK="true",STUCKTOPOINT="BOTTOMRIGHT",STUCKTO=1,STUCKPOINT="TOPRIGHT"}
StickyFrames~f~10!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
HealGroups~f~1!{FRAME=1,STATE="false",NAME="Self"}
HealGroups~f~2!{FRAME=1,STATE="true",NAME="Main tanks"}
HealGroups~f~3!{FRAME=1,STATE="false",NAME="Healers"}
HealGroups~f~4!{FRAME=1,STATE="true",NAME="Raid"}
HealGroups~f~5!{FRAME=1,STATE="true",NAME="Group"}
HealGroups~f~6!{FRAME=1,STATE="false",NAME="Private List"}
HealGroups~f~7!{FRAME=1,STATE="false",NAME="Vehicle"}
HealGroups~f~8!{FRAME=1,STATE="true",NAME="Pets"}
HealGroups~f~9!{FRAME=8,STATE="true",NAME="Target"}
HealGroups~f~10!{FRAME=9,STATE="false",NAME="Focus"}
HealGroups~f~11!{FRAME=10,STATE="false",NAME="Enemy"}
Anchors~f~1!{Y=68.08,GROW=2,BARS=3,FRAME=3,X=89.41}
Anchors~f~2!{Y=75.7,GROW=2,BARS=3,FRAME=3,X=84.17}
Anchors~f~3!{Y=52,GROW=2,BARS=3,FRAME=3,X=52}
Anchors~f~4!{Y=53,GROW=2,BARS=3,FRAME=3,X=53}
Anchors~f~5!{Y=54,GROW=2,BARS=3,FRAME=3,X=54}
Anchors~f~6!{Y=55,GROW=2,BARS=3,FRAME=3,X=55}
Anchors~f~7!{Y=57.61,GROW=2,BARS=3,FRAME=3,X=93.82}
Anchors~f~8!{Y=68.08,GROW=2,BARS=3,FRAME=3,X=77.93}
Anchors~f~9!{Y=57.89,GROW=2,BARS=3,FRAME=3,X=25.43}
Anchors~f~10!{Y=71.8,GROW=2,BARS=3,FRAME=3,X=89.41}
HeadBar~f~1!{SHOW="false",TEXTURE="HealBot 10",R=0.1,B=0.1,HEIGHT=17,A=0.4,G=0.7,WIDTH=0.7}
HeadBar~f~2!{SHOW="false",WIDTH=0.7,B=0.1,R=0.1,HEIGHT=15,A=0.4,G=0.7,TEXTURE="HealBot 10"}
HeadBar~d!3~4~5~6~7~8~9~10~
HeadText~f~1!{A=0.74,R=1,OFFSET=0,B=1,FONT="Friz Quadrata TT",HEIGHT=9,G=1,OUTLINE=1}
HeadText~d!2~3~4~5~6~7~8~9~10~
HealBar~f~1!{HEIGHT=33,GRPCOLS="false",CMARGIN=0,TEXTURE="Smooth",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=2,WIDTH=155,OFIX=1,RMARGIN=0,NUMCOLS=2}
HealBar~f~2!{HEIGHT=30,GRPCOLS="false",CMARGIN=2,TEXTURE="Smooth",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=2,WIDTH=161,OFIX=1,RMARGIN=1,NUMCOLS=2}
HealBar~d!3~4~5~6~7~8~9~10~
BarCol~f~1!{BACK=1,BA=0.05,BOUT=1,DISA=0.7,BR=0.4,HB=0.702,BG=0.4,HR=0.4,HA=1,HG=0.4,ORA=0.05,BB=0.7,HLTH=1}
BarCol~f~2!{BACK=1,BA=0,BOUT=2,DISA=0.04,BR=0.4,HB=0.7,BG=0.4,HR=0.4,HA=1,HG=0.4,ORA=0.13,BB=0.7,HLTH=1}
BarCol~d!3~4~5~6~7~8~9~10~
BarIACol~f~1!{AC=3,AB=1,AA=0.72,AR=1,AG=1,IC=3,IB=0.2,IA=0.58,IR=0.2,IG=1}
BarIACol~f~2!{AC=3,AB=1,AA=0.78,AR=1,AG=1,IC=3,IB=0.2,IA=0.64,IR=0.2,IG=1}
BarIACol~d!3~4~5~6~7~8~9~10~
BarText~f~1!{HLTHONBAR="false",TAGOOR="OOR|",IGNOREONFULL="true",MAXCHARS=15,FONT="Friz Quadrata TT",CLASSONBAR="false",HOFFSET=0,OUTLINE=2,OFFSET=0,INCHEALS=2,HLTHTXTANCHOR=1,HLTHTYPE=1,HMAXCHARS=0,INCABSORBS=1,NUMFORMAT2=1,HOUTLINE=1,NUMFORMAT1=11,HHEIGHT=10,TAGRIP="RIP|",HEIGHT=15,NAMEONBAR="true",SHOWROLE="true",HALIGN=2,TAGDC="DC|",OVERHEAL=1,CLASSTYPE=1,HOFFSET2=0,ALIGN=1,TAGR="R|",HFONT="Friz Quadrata TT"}
BarText~f~2!{HLTHONBAR="false",TAGOOR="OOR|",HOUTLINE=1,MAXCHARS=15,TAGRIP="RIP|",HMAXCHARS=0,HFONT="Friz Quadrata TT",OUTLINE=2,OFFSET=0,INCHEALS=2,HLTHTXTANCHOR=1,FONT="Friz Quadrata TT",HLTHTYPE=1,CLASSTYPE=2,NUMFORMAT2=1,CLASSONBAR="false",NUMFORMAT1=11,OVERHEAL=1,NAMEONBAR="true",HEIGHT=15,TAGDC="DC|",SHOWROLE="false",HALIGN=2,HHEIGHT=10,IGNOREONFULL="true",INCABSORBS=1,HOFFSET2=0,ALIGN=1,TAGR="R|",HOFFSET=0}
BarText~d!3~4~5~6~7~8~9~10~
BarTextCol~f~1!{HCG=1,NDEBUFF="false",NAME=2,NCDA=0.7,NCB=0,NCR=1,HCB=0,HCR=1,HCA=1,NCG=1,NCA=1,HDEBUFF="false",HCDA=0.4,HLTH=2}
BarTextCol~f~2!{HCG=1,NCR=1,NCB=0,NCDA=0.4,NAME=2,HCA=1,HCB=0,HCR=1,NDEBUFF="false",NCG=1,NCA=1,HDEBUFF="false",HLTH=2,HCDA=0.4}
BarTextCol~d!3~4~5~6~7~8~9~10~
Icons~f~1!{SHOWBUFF="true",SHOWDEBUFF="true",FADESECS=15,MAXDICONS=3,POSITION=2,FADE="false",ONBAR=1,SHOWDIRMOUSE="false",DSCALE=0.85,SHOWDIR="false",SHOWRC="true",SCALE=0.85,DOUBLE="true",I15EN="false",MAXBICONS=8}
Icons~f~2!{SHOWBUFF="true",SHOWDEBUFF="true",FADESECS=15,I15EN="true",POSITION=2,FADE="true",ONBAR=1,SHOWDIRMOUSE="false",DSCALE=0.7,SHOWDIR="true",SHOWRC="true",SCALE=0.7,DOUBLE="false",MAXDICONS=3,MAXBICONS=8}
Icons~d!3~4~5~6~7~8~9~10~
RaidIcon~f~1!{SQUARE="true",CIRCLE="true",DIAMOND="true",SHOW="true",SKULL="true",TRIANGLE="true",STAR="true",CROSS="true",MOON="true"}
RaidIcon~d!2~3~4~5~6~7~8~9~10~
IconText~f~1!{SDUR="true",HEIGHT=9,SSCNT="false",SCNT="true",DURTHRH=9,FONT="Friz Quadrata TT",DURWARN=3,SSDUR="true",OUTLINE=2}
IconText~f~2!{SDUR="true",HEIGHT=11,SSCNT="false",SCNT="true",DURTHRH=9,FONT="Friz Quadrata TT",DURWARN=3,SSDUR="true",OUTLINE=2}
IconText~d!3~4~5~6~7~8~9~10~
BarVisibility~f~1!{INCCLASSES=1,ALERTIC=0.98,ALERTOC=0.95,HIDEOOR="false"}
BarVisibility~f~2!{INCCLASSES=1,ALERTIC=1,ALERTOC=1,HIDEOOR="false"}
BarVisibility~d!3~4~5~6~7~8~9~10~
BarSort~f~1!{SUBORDER=1,OORLAST="false",RAIDORDER=1,SUBPF="true"}
BarSort~f~2!{SUBORDER=1,OORLAST="false",RAIDORDER=3,SUBPF="true"}
BarSort~d!3~4~5~6~7~8~9~10~
BarAggro~f~1!{B=0,SHOWIND="false",G=0,TEXTFORMAT=3,SHOW="true",SHOWTEXTPCT="true",R=1,ALERTIND=1,SHOWTEXT="true",ALERT=1}
BarAggro~f~2!{B=0,SHOWIND="true",G=0,TEXTFORMAT=3,SHOW="true",SHOWTEXTPCT="true",ALERTIND=2,R=1,SHOWTEXT="true",ALERT=2}
BarAggro~d!3~4~5~6~7~8~9~10~
AuxBarFrame~f~1!{OVERLAP=1}
AuxBarFrame~d!2~3~4~5~6~7~8~9~10~
AuxBar^1~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,OTYPE=1,B=1,G=1}
AuxBar^1~d!2~3~4~5~6~7~8~9~10~
AuxBar^2~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,OTYPE=1,B=1,G=1}
AuxBar^2~d!2~3~4~5~6~7~8~9~10~
AuxBar^3~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,OTYPE=1,B=1,G=1}
AuxBar^3~d!2~3~4~5~6~7~8~9~10~
AuxBar^4~f~1!{SIZE=0.98,USE=5,R=1,COLOUR=1,ANCHOR=2,OFFSET=0,DEPTH=2,OTYPE=1,B=1,G=1}
AuxBar^4~f~2!{SIZE=0.98,USE=5,R=1,COLOUR=1,ANCHOR=2,OFFSET=1,DEPTH=2,G=1,B=1,OTYPE=1}
AuxBar^4~d!3~4~5~6~7~8~9~
AuxBar^4~f~10!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=2,OFFSET=1,DEPTH=2,OTYPE=1,B=1,G=1}
AuxBar^5~f~1!{SIZE=0.98,USE=5,R=1,COLOUR=1,ANCHOR=1,OFFSET=0,DEPTH=2,OTYPE=1,B=1,G=1}
AuxBar^5~f~2!{SIZE=0.98,USE=5,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=2,G=1,B=1,OTYPE=1}
AuxBar^5~d!3~4~5~6~7~8~9~
AuxBar^5~f~10!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=2,OTYPE=1,B=1,G=1}
AuxBar^6~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,OTYPE=1,B=1,G=1}
AuxBar^6~d!2~3~4~5~6~7~8~9~10~
AuxBar^7~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,OTYPE=1,B=1,G=1}
AuxBar^7~d!2~3~4~5~6~7~8~9~10~
AuxBar^8~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,OTYPE=1,B=1,G=1}
AuxBar^8~d!2~3~4~5~6~7~8~9~10~
AuxBar^9~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,OTYPE=1,B=1,G=1}
AuxBar^9~d!2~3~4~5~6~7~8~9~10~
Complete!]]
HealBot_ExtraSkinData[49]=[[Skin
Retro-Raid
Author~v!Ivanhoof of Terenas
DuplicateBars~v!true
Chat~t!{EOCOOM="false",EOCOOMV=20,MSG="Casting #s on #n",RESONLY="true",CHAN="",NOTIFY=1}
General~t!{OFREQ=0.07,OMIN=0.1,OMAX=0.95,FLUIDFREQ=10,HIDEPARTYF="true",HIDEPTF="false",STICKYFRAME="false",STICKYSENSITIVITY=30,HIDERAIDF="true",FLUIDBARS="true",HIDEBOSSF="true"}
Healing~t!{TINCSELF="false",GROUPPETS="true",TARGETINCOMBAT=2,TINCRAID="true",FONLYFRIEND="false",SELFPET=0,TONLYFRIEND="false",TINCGROUP="true",FOCUSINCOMBAT=2,TALWAYSSHOW="false",FEXRAID="false",FALWAYSSHOW="false",TEXRAID="false",TINCPET="false"}
Enemy~t!{ENEMYTARGET="false",INCTANKS="true",INCMYTAR="false",INCARENA="true",ENEMYTARGETSIZE=40,INCARENAPETS="false",INCSELF="false",NUMBOSS=2,EXISTSHOWPTAR=1,HIDE="true",EXISTSHOWBOSS="true",DOUBLEWIDTH="false",EXISTSHOWARENA=3}
FrameAlias~f~1!{SIZE=12,NAME="",R=1,ALIAS="Raid",G=1,SHOW="false",OFFSET=10,FONT="Oregon LDO Black",A=1,B=1,OUTLINE=1}
FrameAlias~f~2!{SIZE=12,NAME="",R=1,ALIAS="Frame 2",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~d!3~4~5~
FrameAlias~f~6!{SIZE=12,NAME="",R=1,ALIAS="Vehicle",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~7!{SIZE=12,NAME="",R=1,ALIAS="Pets",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~8!{SIZE=12,NAME="",R=1,ALIAS="Target",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~9!{SIZE=12,NAME="",R=1,ALIAS="Focus",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~10!{SIZE=12,NAME="",R=1,ALIAS="Enemy",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAliasBar~f~1!{A=0.5,WIDTH=0.8,B=0.25,HEIGHT=20,R=0.1,G=0.25,TEXTURE="HealBot 10"}
FrameAliasBar~f~2!{A=0.5,WIDTH=0.7,B=0.25,HEIGHT=20,R=0.1,G=0.25,TEXTURE="HealBot 10"}
FrameAliasBar~d!3~4~5~6~7~8~9~10~
Frame~f~1!{BORDERR=0.2,TIPLOC=5,AUTOCLOSE="false",BACKB=0.1,LOCKED="false",OPENSOUND="false",BORDERA=0.2,SFOFFSETV=0,BACKG=0.1,BORDERB=0.2,BACKA=0.05,SCALE=1,BORDERG=0.2,BACKR=0.1,SFOFFSETH=0}
Frame~d!2~3~4~5~6~7~8~9~10~
StickyFrames~f~1!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~d!2~3~4~5~6~7~8~9~10~
HealGroups~f~1!{FRAME=1,STATE="false",NAME="Self"}
HealGroups~f~2!{FRAME=1,STATE="true",NAME="Main tanks"}
HealGroups~f~3!{FRAME=1,STATE="true",NAME="Healers"}
HealGroups~f~4!{FRAME=1,STATE="true",NAME="Raid"}
HealGroups~f~5!{FRAME=1,STATE="false",NAME="Group"}
HealGroups~f~6!{FRAME=1,STATE="false",NAME="Private List"}
HealGroups~f~7!{FRAME=1,STATE="false",NAME="Vehicle"}
HealGroups~f~8!{FRAME=1,STATE="true",NAME="Pets"}
HealGroups~f~9!{FRAME=8,STATE="false",NAME="Target"}
HealGroups~f~10!{FRAME=9,STATE="false",NAME="Focus"}
HealGroups~f~11!{FRAME=10,STATE="false",NAME="Enemy"}
Anchors~f~1!{Y=83.06,GROW=2,BARS=3,FRAME=3,X=29.67}
Anchors~f~2!{Y=51,GROW=2,BARS=3,FRAME=3,X=51}
Anchors~f~3!{Y=52,GROW=2,BARS=3,FRAME=3,X=52}
Anchors~f~4!{Y=53,GROW=2,BARS=3,FRAME=3,X=53}
Anchors~f~5!{Y=54,GROW=2,BARS=3,FRAME=3,X=54}
Anchors~f~6!{Y=55,GROW=2,BARS=3,FRAME=3,X=55}
Anchors~f~7!{Y=56,GROW=2,BARS=3,FRAME=3,X=56}
Anchors~f~8!{Y=87.7,GROW=2,BARS=3,FRAME=3,X=23.77}
Anchors~f~9!{Y=87.66,GROW=2,BARS=3,FRAME=3,X=29.7}
Anchors~f~10!{Y=83.29,GROW=2,BARS=3,FRAME=3,X=35.14}
HeadBar~f~1!{SHOW="true",TEXTURE="HealBot 10",R=0.1,B=0.1,HEIGHT=14,A=0.4,G=0.7,WIDTH=0.9}
HeadBar~f~2!{SHOW="true",TEXTURE="HealBot 10",R=0.1,B=0.1,HEIGHT=13,A=0.4,G=0.7,WIDTH=0.7}
HeadBar~d!3~4~5~6~7~8~9~10~
HeadText~f~1!{A=0.74,R=1,OFFSET=0,B=1,FONT="Friz Quadrata TT",HEIGHT=9,G=1,OUTLINE=1}
HeadText~d!2~3~4~5~6~7~8~9~10~
HealBar~f~1!{HEIGHT=25,GRPCOLS="false",CMARGIN=1,TEXTURE="Smooth",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=79,RMARGIN=0,OFIX=1,NUMCOLS=2,LOWMANA=2}
HealBar~f~2!{HEIGHT=25,GRPCOLS="false",CMARGIN=2,TEXTURE="Smooth",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=144,RMARGIN=1,OFIX=1,NUMCOLS=2,LOWMANA=2}
HealBar~d!3~4~5~6~7~8~9~
HealBar~f~10!{HEIGHT=25,GRPCOLS="false",CMARGIN=2,TEXTURE="Smooth",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=2,NUMCOLS=2,OFIX=1,RMARGIN=0,WIDTH=144}
BarCol~f~1!{BACK=1,BA=0,BOUT=0,DISA=0.1,BR=0.4,HB=0.7,BG=0.4,HR=0.4,HA=1,HG=0.4,ORA=0.4,BB=0.7,HLTH=1}
BarCol~f~2!{BACK=1,BA=0,BOUT=2,DISA=0.1,BR=0.4,HB=0.7,BG=0.4,BB=0.7,HA=1,HR=0.4,ORA=0.4,HG=0.4,HLTH=1}
BarCol~d!3~4~5~6~7~8~9~
BarCol~f~10!{BACK=1,BA=0.3,BOUT=1,DISA=0.1,BR=0.4,HB=0.7,BG=0.4,HG=0.4,HA=1,HR=0.4,ORA=0.4,BB=0.7,HLTH=1}
BarIACol~f~1!{AC=3,AB=1,AA=0.78,AR=1,AG=1,IC=3,IB=0.2,IA=0.82,IR=0.2,IG=1}
BarIACol~d!2~3~4~5~6~7~8~9~10~
BarText~f~1!{HLTHONBAR="true",TAGOOR="",OVERHEAL=1,MAXCHARS=0,CLASSONBAR="false",HFONT="Friz Quadrata TT",OUTLINE=1,OFFSET=0,INCHEALS=2,HLTHTXTANCHOR=1,HLTHTYPE=3,HMAXCHARS=0,CLASSTYPE=1,NUMFORMAT2=1,IGNOREONFULL="true",TAGDC="",NUMFORMAT1=11,NAMEONBAR="true",HEIGHT=10,FONT="Friz Quadrata TT",SHOWROLE="true",HALIGN=2,TAGRIP="",HHEIGHT=10,HOUTLINE=1,INCABSORBS=1,HOFFSET2=0,ALIGN=2,TAGR="",HOFFSET=0}
BarText~f~2!{HLTHONBAR="true",TAGOOR="[ OOR ] ",OVERHEAL=1,MAXCHARS=0,CLASSONBAR="false",HFONT="Friz Quadrata TT",OUTLINE=1,OFFSET=0,INCHEALS=2,HLTHTXTANCHOR=1,HLTHTYPE=1,HMAXCHARS=0,CLASSTYPE=1,NUMFORMAT2=1,IGNOREONFULL="true",TAGDC="[ DC ] ",NUMFORMAT1=11,NAMEONBAR="true",HEIGHT=10,FONT="Friz Quadrata TT",SHOWROLE="true",HALIGN=2,TAGRIP="[ RIP ] ",HHEIGHT=10,HOUTLINE=1,INCABSORBS=1,HOFFSET2=0,ALIGN=2,TAGR="[ R ] ",HOFFSET=0}
BarText~d!3~4~5~6~7~8~9~10~
BarTextCol~f~1!{NAME=2,NDEBUFF="false",HLTH=2,NCDA=0.4,HCG=1,HCA=1,NCG=1,NCA=1,HCR=1,HCB=0,NCR=1,HDEBUFF="false",NCB=0,HCDA=0.4}
BarTextCol~d!2~3~4~5~6~7~8~9~10~
Icons~f~1!{SHOWBUFF="true",SHOWDEBUFF="true",FADESECS=15,MAXDICONS=3,I15EN="true",DOUBLE="false",SHOWDIR="true",FADE="true",DSCALE=0.6,ONBAR=1,SHOWRC="true",SCALE=0.6,SHOWDIRMOUSE="false",POSITION=2,MAXBICONS=8}
Icons~f~2!{SHOWBUFF="true",SHOWDEBUFF="true",FADESECS=15,MAXDICONS=3,I15EN="true",DOUBLE="false",SHOWDIR="true",FADE="true",DSCALE=0.7,ONBAR=1,SHOWRC="true",SCALE=0.7,SHOWDIRMOUSE="false",POSITION=2,MAXBICONS=8}
Icons~d!3~4~5~6~7~8~9~10~
RaidIcon~f~1!{SQUARE="true",CIRCLE="true",DIAMOND="true",SHOW="true",SKULL="true",TRIANGLE="true",STAR="true",CROSS="true",MOON="true"}
RaidIcon~d!2~3~4~5~6~7~8~9~10~
IconText~f~1!{SDUR="true",HEIGHT=8,SSCNT="false",SCNT="true",DURTHRH=9,FONT="Friz Quadrata TT",DURWARN=3,SSDUR="true",OUTLINE=2}
IconText~f~2!{SDUR="true",HEIGHT=9,SSCNT="false",SCNT="true",DURTHRH=9,FONT="Friz Quadrata TT",DURWARN=3,SSDUR="true",OUTLINE=2}
IconText~d!3~4~5~6~7~8~9~10~
BarVisibility~f~1!{INCCLASSES=1,ALERTIC=0.98,ALERTOC=0.9,HIDEOOR="false"}
BarVisibility~f~2!{INCCLASSES=1,ALERTIC=1,ALERTOC=0.95,HIDEOOR="false"}
BarVisibility~d!3~4~5~6~7~8~9~10~
BarSort~f~1!{SUBORDER=1,OORLAST="false",RAIDORDER=3,SUBPF="true"}
BarSort~d!2~3~4~5~6~7~8~9~10~
BarAggro~f~1!{B=0,SHOWIND="true",G=0,TEXTFORMAT=3,SHOW="true",SHOWTEXTPCT="true",ALERTIND=2,R=1,SHOWTEXT="false",ALERT=2}
BarAggro~f~2!{B=0,SHOWIND="true",G=0,TEXTFORMAT=3,SHOW="true",SHOWTEXTPCT="true",R=1,ALERTIND=2,SHOWTEXT="true",ALERT=2}
BarAggro~d!3~4~5~6~7~8~9~10~
AuxBarFrame~f~1!{OVERLAP=1}
AuxBarFrame~d!2~3~4~5~6~7~8~9~10~
AuxBar^1~f~1!{SIZE=0.98,USE=4,R=1,COLOUR=1,ANCHOR=1,OFFSET=0,DEPTH=2,G=1,B=1,OTYPE=1}
AuxBar^1~d!2~3~4~5~6~7~8~9~
AuxBar^1~f~10!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=0,DEPTH=2,OTYPE=1,B=1,G=1}
AuxBar^2~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,OTYPE=1}
AuxBar^2~d!2~3~4~5~6~7~8~9~10~
AuxBar^3~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,OTYPE=1}
AuxBar^3~d!2~3~4~5~6~7~8~9~10~
AuxBar^4~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,OTYPE=1}
AuxBar^4~d!2~3~4~5~6~7~8~9~10~
AuxBar^5~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=2,OFFSET=0,DEPTH=1,G=1,B=1,OTYPE=1}
AuxBar^5~d!2~3~4~5~6~7~8~9~10~
AuxBar^6~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,OTYPE=1}
AuxBar^6~d!2~3~4~5~6~7~8~9~10~
AuxBar^7~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,OTYPE=1}
AuxBar^7~d!2~3~4~5~6~7~8~9~10~
AuxBar^8~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,OTYPE=1}
AuxBar^8~d!2~3~4~5~6~7~8~9~10~
AuxBar^9~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,OTYPE=1}
AuxBar^9~d!2~3~4~5~6~7~8~9~10~
Complete!]]
HealBot_ExtraSkinData[50]=[[Skin
Blended-Group
Author~v!Ivanhoof of Terenas
DuplicateBars~v!false
Chat~t!{EOCOOM="false",EOCOOMV=20,MSG="",RESONLY="true",CHAN="",NOTIFY=1}
General~t!{OFREQ=0.07,OMIN=0.1,OMAX=0.95,FLUIDFREQ=10,HIDEPTF="false",HIDEPARTYF="true",STICKYSENSITIVITY=30,HIDERAIDF="true",STICKYFRAME="true",FLUIDBARS="true",HIDEBOSSF="true"}
Healing~t!{TINCSELF="false",TINCRAID="false",GROUPPETS="true",TARGETINCOMBAT=2,TINCGROUP="false",FONLYFRIEND="false",FEXRAID="false",TONLYFRIEND="false",FALWAYSSHOW="false",FOCUSINCOMBAT=2,TALWAYSSHOW="false",TINCPET="false",SELFPET="true",TEXRAID="false",ALERT=0.95}
Enemy~t!{USE=0,INCARENA="true",INCTANKS="true",INCMYTAR="false",ENEMYTARGET="false",INCARENAPETS="false",ENEMYTARGETSIZE=40,INCSELF="false",NUMBOSS=2,EXISTSHOWPTAR=1,HIDE="true",EXISTSHOWBOSS="true",DOUBLEWIDTH="false",EXISTSHOWARENA=2}
FrameAlias~f~1!{SIZE=12,NAME="",R=0.243,ALIAS="Tank and Heals",G=0.478,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=0.882,OUTLINE=1}
FrameAlias~f~2!{SIZE=12,NAME="Damage Dealers",R=0.275,ALIAS="Group",G=0.882,SHOW="true",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=0.243,OUTLINE=1}
FrameAlias~f~3!{SIZE=12,NAME="",R=1,ALIAS="Not Used",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~d!4~5~
FrameAlias~f~6!{SIZE=12,NAME="",R=1,ALIAS="Vehicle",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~7!{SIZE=12,NAME="Pets",R=0.275,ALIAS="Pets",G=0.882,SHOW="true",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=0.243,OUTLINE=1}
FrameAlias~f~8!{SIZE=12,NAME="",R=1,ALIAS="Target",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~9!{SIZE=12,NAME="",R=1,ALIAS="Focus",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~10!{SIZE=12,NAME="Enemy",R=0.902,ALIAS="Enemy",G=0.2,SHOW="true",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=0.2,OUTLINE=1}
FrameAliasBar~f~1!{A=0.5,TEXTURE="HealBot 10",B=0.25,HEIGHT=20,R=0.1,G=0.25,WIDTH=0.95}
FrameAliasBar~f~2!{A=0.25,TEXTURE="Smooth v2",B=0,HEIGHT=14,R=0,G=0,WIDTH=0.95}
FrameAliasBar~f~3!{A=0.5,TEXTURE="HealBot 10",B=0.25,HEIGHT=20,R=0.1,G=0.25,WIDTH=0.7}
FrameAliasBar~d!4~5~6~
FrameAliasBar~f~7!{A=0.25,TEXTURE="Smooth v2",B=0,HEIGHT=12,R=0,G=0,WIDTH=0.95}
FrameAliasBar~f~8!{A=0.5,TEXTURE="HealBot 10",B=0.25,HEIGHT=20,R=0.1,G=0.25,WIDTH=0.7}
FrameAliasBar~d!9~
FrameAliasBar~f~10!{A=0.25,TEXTURE="HealBot 10",B=0,HEIGHT=14,R=0,G=0,WIDTH=0.9}
Frame~f~1!{BACKR=0.2,BACKG=0.196,AUTOCLOSE="false",BORDERB=0.2,LOCKED="true",SCALE=1,BORDERA=0,SFOFFSETV=0,TIPLOC=4,BACKB=0.188,BACKA=0,OPENSOUND="false",BORDERG=0.2,BORDERR=0.2,SFOFFSETH=0}
Frame~f~2!{BACKR=0.173,BACKG=0.184,AUTOCLOSE="false",BORDERB=0.808,LOCKED="true",SCALE=1,BORDERA=0,SFOFFSETV=0,TIPLOC=5,BACKB=0.2,BACKA=0,OPENSOUND="false",BORDERG=0.796,BORDERR=0.765,SFOFFSETH=0}
Frame~f~3!{BORDERR=0.765,BACKR=0.173,AUTOCLOSE="false",BORDERB=0.808,LOCKED="true",OPENSOUND="false",BORDERA=0.5,SFOFFSETV=0,TIPLOC=5,BACKB=0.2,BACKA=0.1,SCALE=1,BACKG=0.184,BORDERG=0.796,SFOFFSETH=0}
Frame~d!4~5~6~
Frame~f~7!{BORDERR=0.765,BACKG=0.184,AUTOCLOSE="false",BORDERB=0.808,LOCKED="true",OPENSOUND="false",BORDERA=0,SFOFFSETV=0,TIPLOC=5,BACKB=0.2,BACKA=0,SCALE=1,BORDERG=0.796,BACKR=0.173,SFOFFSETH=0}
Frame~f~8!{BACKR=0.173,BACKG=0.184,AUTOCLOSE="false",BORDERB=0.808,LOCKED="false",OPENSOUND="false",BORDERA=0.5,SFOFFSETV=0,TIPLOC=5,BACKB=0.2,BACKA=0.1,SCALE=1,BORDERG=0.796,BORDERR=0.765,SFOFFSETH=0}
Frame~d!9~
Frame~f~10!{BACKR=0.2,BACKG=0.2,AUTOCLOSE="false",BORDERB=0.2,LOCKED="true",SCALE=1,BORDERA=0,SFOFFSETV=-14,TIPLOC=2,BACKB=0.2,BACKA=0,OPENSOUND="false",BORDERG=0.2,BORDERR=0.2,SFOFFSETH=0}
StickyFrames~f~1!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~f~2!{STUCK="true",STUCKTOPOINT="BOTTOMRIGHT",STUCKTO=1,STUCKPOINT="TOPRIGHT"}
StickyFrames~f~3!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~d!4~5~6~
StickyFrames~f~7!{STUCK="true",STUCKTOPOINT="BOTTOMRIGHT",STUCKTO=2,STUCKPOINT="TOPRIGHT"}
StickyFrames~f~8!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~d!9~
StickyFrames~f~10!{STUCK="true",STUCKTOPOINT="TOPLEFT",STUCKTO=1,STUCKPOINT="TOPRIGHT"}
HealGroups~f~1!{FRAME=1,STATE="true",NAME="Main tanks"}
HealGroups~f~2!{FRAME=1,STATE="true",NAME="Healers"}
HealGroups~f~3!{FRAME=1,STATE="false",NAME="Self"}
HealGroups~f~4!{FRAME=2,STATE="true",NAME="Group"}
HealGroups~f~5!{FRAME=2,STATE="false",NAME="Private List"}
HealGroups~f~6!{FRAME=2,STATE="false",NAME="Raid"}
HealGroups~f~7!{FRAME=1,STATE="false",NAME="Vehicle"}
HealGroups~f~8!{FRAME=7,STATE="true",NAME="Pets"}
HealGroups~f~9!{FRAME=8,STATE="false",NAME="Target"}
HealGroups~f~10!{FRAME=9,STATE="false",NAME="Focus"}
HealGroups~f~11!{FRAME=10,STATE="true",NAME="Enemy"}
Anchors~f~1!{Y=69.09,X=79.66,BARS=1,FRAME=1,GROW=2}
Anchors~f~2!{Y=62.92,X=84.89,BARS=1,FRAME=3,GROW=1}
Anchors~f~3!{Y=41.05,X=35.18,BARS=1,FRAME=1,GROW=2}
Anchors~f~4!{Y=38.93,X=33.85,BARS=1,FRAME=1,GROW=2}
Anchors~f~5!{Y=36.82,X=32.53,BARS=1,FRAME=1,GROW=2}
Anchors~f~6!{Y=34.7,X=31.21,BARS=1,FRAME=1,GROW=2}
Anchors~f~7!{Y=58.17,X=84.89,BARS=1,FRAME=3,GROW=2}
Anchors~f~8!{Y=63.18,X=83.33,BARS=1,FRAME=1,GROW=2}
Anchors~f~9!{Y=58.28,X=83.32,BARS=1,FRAME=1,GROW=2}
Anchors~f~10!{Y=67.92,X=79.66,BARS=3,FRAME=3,GROW=2}
HeadBar~f~1!{SHOW="true",WIDTH=0.95,B=0,R=0,HEIGHT=14,A=0.25,G=0,TEXTURE="Smooth v2"}
HeadBar~f~2!{SHOW="false",TEXTURE="Skewed",R=0.09,B=0.118,HEIGHT=13,A=0,G=0.11,WIDTH=0.9}
HeadBar~f~3!{SHOW="true",TEXTURE="Skewed",R=0.09,B=0.118,HEIGHT=10,A=0,G=0.11,WIDTH=0.9}
HeadBar~d!4~5~6~
HeadBar~f~7!{SHOW="false",WIDTH=0.9,B=0.118,R=0.09,HEIGHT=12,A=0,G=0.11,TEXTURE="Skewed"}
HeadBar~f~8!{SHOW="true",WIDTH=0.9,B=0.118,R=0.09,HEIGHT=10,A=0,G=0.11,TEXTURE="Skewed"}
HeadBar~d!9~
HeadBar~f~10!{SHOW="false",WIDTH=0.9,B=0.118,R=0.09,HEIGHT=5,A=0,G=0.11,TEXTURE="Skewed"}
HeadText~f~1!{A=1,R=0.2,OFFSET=0,B=0.2,FONT="Friz Quadrata TT",HEIGHT=12,G=0.902,OUTLINE=1}
HeadText~f~2!{A=1,B=0.835,OFFSET=-1,R=0.541,FONT="Friz Quadrata TT",HEIGHT=12,G=0.757,OUTLINE=1}
HeadText~f~3!{A=0.85,B=0.973,OFFSET=0,R=0.651,FONT="Friz Quadrata TT",HEIGHT=12,G=0.82,OUTLINE=1}
HeadText~d!4~5~6~
HeadText~f~7!{A=0.85,B=0.973,OFFSET=-1,R=0.651,FONT="Friz Quadrata TT",HEIGHT=12,G=0.82,OUTLINE=1}
HeadText~f~8!{A=0.85,B=0.973,OFFSET=0,R=0.651,FONT="Friz Quadrata TT",HEIGHT=12,G=0.82,OUTLINE=1}
HeadText~d!9~10~
HealBar~f~1!{HEIGHT=32,GRPCOLS="true",CMARGIN=1,TEXTURE="Charcoal",POWERCNT="true",LOWMANACOMBAT="true",NUMCOLS=1,RMARGIN=1,OFIX=1,WIDTH=140,LOWMANA=1}
HealBar~f~2!{HEIGHT=31,GRPCOLS="false",CMARGIN=1,TEXTURE="Charcoal",POWERCNT="true",LOWMANACOMBAT="true",NUMCOLS=1,RMARGIN=1,OFIX=1,WIDTH=93,LOWMANA=1}
HealBar~f~3!{HEIGHT=25,GRPCOLS="false",CMARGIN=1,TEXTURE="Smooth",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=75,RMARGIN=1,OFIX=1,NUMCOLS=5,LOWMANA=1}
HealBar~d!4~5~6~
HealBar~f~7!{HEIGHT=24,GRPCOLS="false",CMARGIN=1,TEXTURE="Charcoal",POWERCNT="true",LOWMANACOMBAT="true",NUMCOLS=4,RMARGIN=0,OFIX=1,WIDTH=69,LOWMANA=1}
HealBar~f~8!{HEIGHT=25,GRPCOLS="false",CMARGIN=1,TEXTURE="Smooth",POWERCNT="true",LOWMANACOMBAT="true",NUMCOLS=5,RMARGIN=1,OFIX=1,WIDTH=75,LOWMANA=1}
HealBar~d!9~
HealBar~f~10!{HEIGHT=28,GRPCOLS="false",CMARGIN=1,TEXTURE="Charcoal",POWERCNT="true",LOWMANACOMBAT="true",NUMCOLS=1,RMARGIN=0,OFIX=1,WIDTH=102,LOWMANA=1}
BarCol~f~1!{BACK=1,BA=0,BB=0.2,DISA=0.02,BR=0,HB=0.2,BG=0.2,BOUT=0,HA=1,HG=0.2,ORA=0.3,HR=0,HLTH=1}
BarCol~d!2~3~4~5~6~7~8~9~
BarCol~f~10!{BACK=1,BA=0,BOUT=0,DISA=0.02,BR=0,HB=0.11,BG=0.2,HR=0.824,HA=1,HG=0.11,ORA=0.3,BB=0.2,HLTH=3}
BarIACol~f~1!{AC=4,AB=1,AA=0.5,AR=1,AG=1,IC=3,IB=0,IA=0.7,IR=0,IG=0.502}
BarIACol~d!2~3~4~5~6~7~8~9~
BarIACol~f~10!{AC=4,AB=1,AA=0.5,AR=1,AG=1,IC=4,IB=0.173,IA=0.7,IR=0.996,IG=0.886}
BarText~f~1!{HLTHONBAR="true",TAGOOR="",OVERHEAL=1,MAXCHARS=0,HMAXCHARS=0,HFONT="Friz Quadrata TT",OUTLINE=1,OFFSET=0,INCHEALS=2,HLTHTXTANCHOR=1,HLTHTYPE=1,FONT="Friz Quadrata TT",CLASSTYPE=1,NUMFORMAT2=1,IGNOREONFULL="true",TAGDC="",NUMFORMAT1=2,TAGRIP="",HEIGHT=10,NAMEONBAR="true",SHOWROLE="false",HALIGN=2,HHEIGHT=10,HOUTLINE=1,CLASSONBAR="false",INCABSORBS=1,HOFFSET2=0,ALIGN=2,TAGR="",HOFFSET=0}
BarText~f~2!{HLTHONBAR="true",TAGOOR="",HOUTLINE=1,MAXCHARS=0,HMAXCHARS=0,HFONT="Friz Quadrata TT",OUTLINE=1,CLASSONBAR="false",OFFSET=1,HLTHTXTANCHOR=1,HLTHTYPE=1,INCHEALS=2,CLASSTYPE=1,NUMFORMAT2=1,OVERHEAL=1,TAGDC="",FONT="Friz Quadrata TT",NAMEONBAR="true",HEIGHT=10,TAGRIP="",SHOWROLE="false",HALIGN=2,NUMFORMAT1=2,HHEIGHT=10,IGNOREONFULL="true",INCABSORBS=1,HOFFSET2=0,ALIGN=2,TAGR="",HOFFSET=0}
BarText~f~3!{HLTHONBAR="true",TAGOOR="",HOUTLINE=1,MAXCHARS=0,HMAXCHARS=0,HFONT="Friz Quadrata TT",OUTLINE=1,CLASSONBAR="false",OFFSET=0,HLTHTXTANCHOR=1,HLTHTYPE=1,INCHEALS=2,CLASSTYPE=1,NUMFORMAT2=1,OVERHEAL=1,TAGDC="",FONT="Friz Quadrata TT",NAMEONBAR="true",HEIGHT=10,TAGRIP="",SHOWROLE="false",HALIGN=2,NUMFORMAT1=2,HHEIGHT=10,IGNOREONFULL="true",INCABSORBS=1,HOFFSET2=0,ALIGN=2,TAGR="",HOFFSET=0}
BarText~d!4~5~6~
BarText~f~7!{HLTHONBAR="false",TAGOOR="",HOUTLINE=1,MAXCHARS=12,HMAXCHARS=0,HFONT="Friz Quadrata TT",OUTLINE=1,CLASSONBAR="false",OFFSET=0,HLTHTXTANCHOR=1,HLTHTYPE=1,INCHEALS=2,CLASSTYPE=1,NUMFORMAT2=1,OVERHEAL=1,TAGDC="",FONT="Friz Quadrata TT",NAMEONBAR="true",HEIGHT=10,TAGRIP="",SHOWROLE="false",HALIGN=2,NUMFORMAT1=2,HHEIGHT=10,IGNOREONFULL="true",INCABSORBS=1,HOFFSET2=0,ALIGN=2,TAGR="",HOFFSET=0}
BarText~f~8!{HLTHONBAR="true",TAGOOR="",HOUTLINE=1,MAXCHARS=0,HMAXCHARS=0,HFONT="Friz Quadrata TT",OUTLINE=1,CLASSONBAR="false",OFFSET=0,HLTHTXTANCHOR=1,HLTHTYPE=1,INCHEALS=2,CLASSTYPE=1,NUMFORMAT2=1,OVERHEAL=1,TAGDC="",FONT="Friz Quadrata TT",NAMEONBAR="true",HEIGHT=10,TAGRIP="",SHOWROLE="false",HALIGN=2,NUMFORMAT1=2,HHEIGHT=10,IGNOREONFULL="true",INCABSORBS=1,HOFFSET2=0,ALIGN=2,TAGR="",HOFFSET=0}
BarText~d!9~10~
BarTextCol~f~1!{HCG=1,NCR=1,HLTH=2,NCDA=0.4,NCB=0,NDEBUFF="false",HCB=0,HCR=1,NCA=1,NCG=1,HCA=1,HDEBUFF="false",NAME=2,HCDA=0.4}
BarTextCol~d!2~3~4~5~6~7~8~9~10~
Icons~f~1!{SHOWBUFF="true",SHOWDEBUFF="true",I15EN="true",MAXDICONS=3,FADESECS=8,DOUBLE="false",ONBAR=1,FADE="true",DSCALE=0.5,SHOWDIR="true",SHOWRC="false",SCALE=0.5,SHOWDIRMOUSE="false",POSITION=2,MAXBICONS=8}
Icons~f~2!{SHOWBUFF="true",SHOWDEBUFF="true",I15EN="true",MAXDICONS=2,FADESECS=8,POSITION=2,ONBAR=1,DOUBLE="false",DSCALE=0.5,SHOWDIR="true",SHOWRC="false",SCALE=0.5,SHOWDIRMOUSE="false",FADE="true",MAXBICONS=5}
Icons~f~3!{SHOWBUFF="true",SHOWDEBUFF="true",I15EN="true",MAXDICONS=3,FADESECS=15,POSITION=2,ONBAR=1,DOUBLE="false",DSCALE=0.5,SHOWDIR="true",SHOWRC="false",SCALE=0.5,SHOWDIRMOUSE="false",FADE="true",MAXBICONS=8}
Icons~d!4~5~6~
Icons~f~7!{SHOWBUFF="true",SHOWDEBUFF="true",I15EN="true",MAXDICONS=2,FADESECS=8,POSITION=2,ONBAR=1,DOUBLE="false",DSCALE=0.5,SHOWDIR="true",SHOWRC="false",SCALE=0.5,SHOWDIRMOUSE="false",FADE="true",MAXBICONS=5}
Icons~f~8!{SHOWBUFF="true",SHOWDEBUFF="true",I15EN="true",MAXDICONS=3,FADESECS=15,POSITION=2,ONBAR=1,DOUBLE="false",DSCALE=0.5,SHOWDIR="true",SHOWRC="false",SCALE=0.5,SHOWDIRMOUSE="false",FADE="true",MAXBICONS=8}
Icons~d!9~
Icons~f~10!{SHOWBUFF="true",SHOWDEBUFF="true",I15EN="true",MAXDICONS=2,FADESECS=8,POSITION=2,ONBAR=1,DOUBLE="false",DSCALE=0.5,SHOWDIR="true",SHOWRC="false",SCALE=0.5,SHOWDIRMOUSE="false",FADE="true",MAXBICONS=5}
RaidIcon~f~1!{SQUARE="true",CIRCLE="true",DIAMOND="true",SHOW="true",SKULL="true",TRIANGLE="true",STAR="true",MOON="true",CROSS="true"}
RaidIcon~d!2~3~4~5~6~7~8~9~10~
IconText~f~1!{DURWARN=3,HEIGHT=8,SSCNT="false",SCNT="true",DURTHRH=9,FONT="Friz Quadrata TT",SDUR="true",SSDUR="true",OUTLINE=2}
IconText~d!2~
IconText~f~3!{SDUR="false",HEIGHT=8,SSCNT="false",SCNT="true",DURTHRH=9,FONT="Friz Quadrata TT",DURWARN=3,SSDUR="true",OUTLINE=2}
IconText~d!4~5~6~7~8~9~
IconText~f~10!{SDUR="false",HEIGHT=8,SSCNT="false",SCNT="true",DURTHRH=9,FONT="Friz Quadrata TT",DURWARN=3,SSDUR="false",OUTLINE=2}
BarVisibility~f~1!{INCCLASSES=1,ALERTIC=0.98,ALERTOC=0.95,HIDEOOR="false"}
BarVisibility~f~2!{INCCLASSES=1,ALERTIC=0.95,ALERTOC=0.9,HIDEOOR="false"}
BarVisibility~f~3!{INCCLASSES=1,ALERTIC=0.99,ALERTOC=0.95,HIDEOOR="false"}
BarVisibility~d!4~5~6~
BarVisibility~f~7!{INCCLASSES=1,ALERTIC=0.9,ALERTOC=0.8,HIDEOOR="false"}
BarVisibility~f~8!{INCCLASSES=1,ALERTIC=0.99,ALERTOC=0.95,HIDEOOR="false"}
BarVisibility~d!9~10~
BarSort~f~1!{SUBORDER=1,OORLAST="false",RAIDORDER=3,SUBPF="true"}
BarSort~d!2~3~4~5~6~7~8~9~10~
BarAggro~f~1!{B=0,ALERTIND=2,G=0,TEXTFORMAT=3,SHOW="true",SHOWTEXTPCT="true",R=1,SHOWIND="true",SHOWTEXT="false",ALERT=2}
BarAggro~d!2~3~4~5~6~7~8~9~10~
AuxBarFrame~f~1!{OVERLAP=1}
AuxBarFrame~d!2~3~4~5~6~7~8~9~10~
AuxBar^1~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,OTYPE=1}
AuxBar^1~d!2~3~4~5~6~7~8~9~10~
AuxBar^2~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,OTYPE=1}
AuxBar^2~d!2~3~4~5~6~7~8~9~10~
AuxBar^3~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,OTYPE=1}
AuxBar^3~d!2~3~4~5~6~7~8~9~10~
AuxBar^4~f~1!{SIZE=0.98,USE=5,R=1,COLOUR=1,ANCHOR=2,OFFSET=1,DEPTH=1,G=1,B=1,OTYPE=1}
AuxBar^4~d!2~3~4~5~6~7~8~9~
AuxBar^4~f~10!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=2,OFFSET=1,DEPTH=1,G=1,B=1,OTYPE=1}
AuxBar^5~f~1!{SIZE=0.98,USE=5,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=1,G=1,B=1,OTYPE=1}
AuxBar^5~d!2~3~4~5~6~7~8~9~
AuxBar^5~f~10!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=1,G=1,B=1,OTYPE=1}
AuxBar^6~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,OTYPE=1}
AuxBar^6~d!2~3~4~5~6~7~8~9~10~
AuxBar^7~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,OTYPE=1}
AuxBar^7~d!2~3~4~5~6~7~8~9~10~
AuxBar^8~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,OTYPE=1}
AuxBar^8~d!2~3~4~5~6~7~8~9~10~
AuxBar^9~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,OTYPE=1}
AuxBar^9~d!2~3~4~5~6~7~8~9~10~
Complete!]]
HealBot_ExtraSkinData[51]=[[Skin
Blended-Raid
Author~v!Monti of Terenas
DuplicateBars~v!false
Chat~t!{EOCOOM="false",EOCOOMV=20,MSG="",RESONLY="true",CHAN="",NOTIFY=1}
General~t!{OFREQ=0.07,OMIN=0.1,OMAX=0.95,HIDEBOSSF="true",HIDEPARTYF="true",HIDEPTF="false",STICKYSENSITIVITY=30,HIDERAIDF="true",STICKYFRAME="true",FLUIDBARS="true",FLUIDFREQ=10}
Healing~t!{TINCRAID="false",TINCSELF="false",GROUPPETS="true",TARGETINCOMBAT=2,FALWAYSSHOW="false",FONLYFRIEND="false",FEXRAID="false",TONLYFRIEND="false",TINCGROUP="false",FOCUSINCOMBAT=2,TALWAYSSHOW="false",SELFPET="true",TINCPET="false",TEXRAID="false",ALERT=0.95}
Enemy~t!{USE=0,ENEMYTARGET="false",INCTANKS="true",INCMYTAR="false",INCARENA="true",ENEMYTARGETSIZE=40,INCARENAPETS="false",INCSELF="false",NUMBOSS=2,EXISTSHOWPTAR=1,HIDE="true",EXISTSHOWBOSS="true",DOUBLEWIDTH="false",EXISTSHOWARENA=2}
FrameAlias~f~1!{SIZE=12,NAME="Tanks and Healers",R=0.2,ALIAS="Tank and Heals",G=0.9,SHOW="true",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=0.2,OUTLINE=1}
FrameAlias~f~2!{SIZE=12,NAME="Raid",R=0.275,ALIAS="Raid",G=0.882,SHOW="true",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=0.243,OUTLINE=1}
FrameAlias~f~3!{SIZE=12,NAME="",R=1,ALIAS="Not Used",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~d!4~5~
FrameAlias~f~6!{SIZE=12,NAME="",R=1,ALIAS="Vehicle",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~7!{SIZE=12,NAME="Pets",R=0.275,ALIAS="Pets",G=0.882,SHOW="true",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=0.243,OUTLINE=1}
FrameAlias~f~8!{SIZE=12,NAME="",R=1,ALIAS="Target",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~9!{SIZE=12,NAME="",R=1,ALIAS="Focus",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~10!{SIZE=12,NAME="Enemy",R=0.902,ALIAS="Enemy",G=0.2,SHOW="true",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=0.2,OUTLINE=1}
FrameAliasBar~f~1!{A=0.25,WIDTH=0.95,B=0.004,HEIGHT=14,R=0.004,G=0.004,TEXTURE="Smooth v2"}
FrameAliasBar~f~2!{A=0.25,WIDTH=0.95,B=0,HEIGHT=14,R=0,G=0,TEXTURE="Smooth v2"}
FrameAliasBar~f~3!{A=0.5,WIDTH=0.7,B=0.25,HEIGHT=20,R=0.1,G=0.25,TEXTURE="HealBot 10"}
FrameAliasBar~d!4~5~6~
FrameAliasBar~f~7!{A=0.25,WIDTH=0.95,B=0,HEIGHT=12,R=0,G=0,TEXTURE="Smooth v2"}
FrameAliasBar~f~8!{A=0.5,WIDTH=0.7,B=0.25,HEIGHT=20,R=0.1,G=0.25,TEXTURE="HealBot 10"}
FrameAliasBar~d!9~
FrameAliasBar~f~10!{A=0.25,WIDTH=0.9,B=0,HEIGHT=14,R=0,G=0,TEXTURE="HealBot 10"}
Frame~f~1!{BACKR=0.2,BORDERR=0.2,AUTOCLOSE="false",BACKB=0.188,LOCKED="false",OPENSOUND="false",BORDERA=0,BORDERG=0.2,TIPLOC=2,BORDERB=0.2,BACKA=0,SCALE=1,BACKG=0.196,SFOFFSETV=0,SFOFFSETH=0}
Frame~f~2!{BACKR=0.173,BORDERR=0.765,AUTOCLOSE="false",BACKB=0.2,LOCKED="true",OPENSOUND="false",BORDERA=0,BORDERG=0.796,TIPLOC=3,BORDERB=0.808,BACKA=0,SCALE=1,BACKG=0.184,SFOFFSETV=0,SFOFFSETH=0}
Frame~f~3!{BORDERR=0.765,BACKG=0.184,AUTOCLOSE="false",BACKB=0.2,LOCKED="true",OPENSOUND="false",BORDERA=0.5,BORDERG=0.796,TIPLOC=5,BORDERB=0.808,BACKA=0.1,SCALE=1,SFOFFSETV=0,BACKR=0.173,SFOFFSETH=0}
Frame~d!4~5~6~
Frame~f~7!{BORDERR=0.765,BACKR=0.173,AUTOCLOSE="false",BACKB=0.2,LOCKED="true",SCALE=1,BORDERA=0,BORDERG=0.796,TIPLOC=5,BORDERB=0.808,BACKA=0,OPENSOUND="false",BACKG=0.184,SFOFFSETV=0,SFOFFSETH=0}
Frame~f~8!{BACKR=0.173,BORDERR=0.765,AUTOCLOSE="false",BACKB=0.2,LOCKED="false",SCALE=1,BORDERA=0.5,BORDERG=0.796,TIPLOC=5,BORDERB=0.808,BACKA=0.1,OPENSOUND="false",BACKG=0.184,SFOFFSETV=0,SFOFFSETH=0}
Frame~d!9~
Frame~f~10!{BACKR=0.2,BORDERR=0.2,AUTOCLOSE="false",BACKB=0.2,LOCKED="true",OPENSOUND="false",BORDERA=0,BORDERG=0.2,TIPLOC=4,BORDERB=0.2,BACKA=0,SCALE=1,BACKG=0.2,SFOFFSETV=0,SFOFFSETH=0}
StickyFrames~f~1!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~f~2!{STUCK="true",STUCKTOPOINT="BOTTOMRIGHT",STUCKTO=1,STUCKPOINT="TOPRIGHT"}
StickyFrames~f~3!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~d!4~5~6~
StickyFrames~f~7!{STUCK="true",STUCKTOPOINT="BOTTOMRIGHT",STUCKTO=2,STUCKPOINT="TOPRIGHT"}
StickyFrames~f~8!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~d!9~
StickyFrames~f~10!{STUCK="true",STUCKTOPOINT="TOPRIGHT",STUCKTO=1,STUCKPOINT="BOTTOMRIGHT"}
HealGroups~f~1!{FRAME=1,STATE="true",NAME="Main tanks"}
HealGroups~f~2!{FRAME=1,STATE="true",NAME="Healers"}
HealGroups~f~3!{FRAME=1,STATE="false",NAME="Self"}
HealGroups~f~4!{FRAME=2,STATE="true",NAME="Group"}
HealGroups~f~5!{FRAME=2,STATE="false",NAME="Private List"}
HealGroups~f~6!{FRAME=2,STATE="true",NAME="Raid"}
HealGroups~f~7!{FRAME=1,STATE="false",NAME="Vehicle"}
HealGroups~f~8!{FRAME=7,STATE="true",NAME="Pets"}
HealGroups~f~9!{FRAME=8,STATE="false",NAME="Target"}
HealGroups~f~10!{FRAME=9,STATE="false",NAME="Focus"}
HealGroups~f~11!{FRAME=10,STATE="true",NAME="Enemy"}
Anchors~f~1!{Y=68.67,X=75.85,BARS=1,FRAME=1,GROW=2}
Anchors~f~2!{Y=63.42,X=80.38,BARS=1,FRAME=3,GROW=2}
Anchors~f~3!{Y=41.05,X=35.18,BARS=1,FRAME=1,GROW=2}
Anchors~f~4!{Y=38.93,X=33.85,BARS=1,FRAME=1,GROW=2}
Anchors~f~5!{Y=36.82,X=32.53,BARS=1,FRAME=1,GROW=2}
Anchors~f~6!{Y=34.7,X=31.21,BARS=1,FRAME=1,GROW=2}
Anchors~f~7!{Y=45.17,X=80.38,BARS=1,FRAME=3,GROW=2}
Anchors~f~8!{Y=63.18,X=83.33,BARS=1,FRAME=1,GROW=2}
Anchors~f~9!{Y=58.28,X=83.32,BARS=1,FRAME=1,GROW=2}
Anchors~f~10!{Y=69.84,X=80.38,BARS=1,FRAME=4,GROW=1}
HeadBar~f~1!{SHOW="false",TEXTURE="Smooth v2",R=0,B=0,HEIGHT=14,A=0.25,G=0,WIDTH=0.95}
HeadBar~f~2!{SHOW="false",WIDTH=0.9,B=0.118,R=0.09,HEIGHT=13,A=0,G=0.11,TEXTURE="Skewed"}
HeadBar~f~3!{SHOW="true",WIDTH=0.9,B=0.118,R=0.09,HEIGHT=10,A=0,G=0.11,TEXTURE="Skewed"}
HeadBar~d!4~5~6~
HeadBar~f~7!{SHOW="false",TEXTURE="Skewed",R=0.09,B=0.118,HEIGHT=12,A=0,G=0.11,WIDTH=0.9}
HeadBar~f~8!{SHOW="true",TEXTURE="Skewed",R=0.09,B=0.118,HEIGHT=10,A=0,G=0.11,WIDTH=0.9}
HeadBar~d!9~
HeadBar~f~10!{SHOW="false",TEXTURE="Skewed",R=0.09,B=0.118,HEIGHT=5,A=0,G=0.11,WIDTH=0.9}
HeadText~f~1!{A=1,B=0.2,OFFSET=0,R=0.2,FONT="Friz Quadrata TT",HEIGHT=12,G=0.9,OUTLINE=1}
HeadText~f~2!{A=1,R=0.541,OFFSET=-1,B=0.835,FONT="Friz Quadrata TT",HEIGHT=12,G=0.757,OUTLINE=1}
HeadText~f~3!{A=0.85,R=0.651,OFFSET=0,B=0.973,FONT="Friz Quadrata TT",HEIGHT=12,G=0.82,OUTLINE=1}
HeadText~d!4~5~6~
HeadText~f~7!{A=0.85,R=0.651,OFFSET=-1,B=0.973,FONT="Friz Quadrata TT",HEIGHT=12,G=0.82,OUTLINE=1}
HeadText~f~8!{A=0.85,R=0.651,OFFSET=0,B=0.973,FONT="Friz Quadrata TT",HEIGHT=12,G=0.82,OUTLINE=1}
HeadText~d!9~10~
HealBar~f~1!{HEIGHT=35,GRPCOLS="false",CMARGIN=2,TEXTURE="Charcoal",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=120,RMARGIN=1,OFIX=1,NUMCOLS=2,LOWMANA=1}
HealBar~f~2!{HEIGHT=28,GRPCOLS="false",CMARGIN=1,TEXTURE="Charcoal",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=80,RMARGIN=1,OFIX=1,NUMCOLS=3,LOWMANA=1}
HealBar~f~3!{HEIGHT=25,GRPCOLS="false",CMARGIN=1,TEXTURE="Smooth",POWERCNT="true",LOWMANACOMBAT="true",NUMCOLS=5,RMARGIN=1,OFIX=1,WIDTH=75,LOWMANA=1}
HealBar~d!4~5~6~
HealBar~f~7!{HEIGHT=24,GRPCOLS="false",CMARGIN=1,TEXTURE="Charcoal",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=59,RMARGIN=0,OFIX=1,NUMCOLS=4,LOWMANA=1}
HealBar~f~8!{HEIGHT=25,GRPCOLS="false",CMARGIN=1,TEXTURE="Smooth",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=75,RMARGIN=1,OFIX=1,NUMCOLS=5,LOWMANA=1}
HealBar~d!9~
HealBar~f~10!{HEIGHT=28,GRPCOLS="false",CMARGIN=1,TEXTURE="Charcoal",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=80,RMARGIN=0,OFIX=1,NUMCOLS=1,LOWMANA=1}
BarCol~f~1!{BACK=1,BA=0,BOUT=0,DISA=0.02,BR=0,HB=0.2,BG=0.2,HG=0.2,HA=1,HR=0,ORA=0.25,BB=0.2,HLTH=1}
BarCol~d!2~
BarCol~f~3!{BACK=1,BA=0,BB=0.2,DISA=0.02,BR=0,HB=0.2,BG=0.2,BOUT=0,HA=1,HG=0.2,ORA=0.3,HR=0,HLTH=1}
BarCol~d!4~5~6~
BarCol~f~7!{BACK=1,BA=0,BB=0.2,DISA=0.02,BR=0,HB=0.2,BG=0.2,BOUT=0,HA=1,HG=0.2,ORA=0.2,HR=0,HLTH=1}
BarCol~f~8!{BACK=1,BA=0,BB=0.2,DISA=0.02,BR=0,HB=0.2,BG=0.2,BOUT=0,HA=1,HG=0.2,ORA=0.3,HR=0,HLTH=1}
BarCol~d!9~
BarCol~f~10!{BACK=1,BA=0,BB=0.2,DISA=0.02,BR=0,HB=0.11,BG=0.2,BOUT=0,HA=1,HG=0.11,ORA=0.25,HR=0.824,HLTH=3}
BarIACol~f~1!{AC=4,AB=1,AA=0.5,AR=1,AG=1,IC=3,IB=0,IA=0.7,IR=0,IG=0.502}
BarIACol~d!2~3~4~5~6~7~8~9~
BarIACol~f~10!{AC=4,AB=1,AA=0.5,AR=1,AG=1,IC=4,IB=0.173,IA=0.7,IR=0.996,IG=0.886}
BarText~f~1!{HLTHONBAR="true",TAGOOR="",OVERHEAL=1,MAXCHARS=0,CLASSONBAR="false",HFONT="Friz Quadrata TT",OUTLINE=1,HOUTLINE=1,INCHEALS=2,HLTHTXTANCHOR=1,HLTHTYPE=1,HMAXCHARS=0,CLASSTYPE=1,NUMFORMAT2=1,IGNOREONFULL="true",TAGDC="",FONT="Friz Quadrata TT",NAMEONBAR="true",HEIGHT=10,OFFSET=0,SHOWROLE="false",HALIGN=2,TAGRIP="",NUMFORMAT1=2,HHEIGHT=10,INCABSORBS=1,HOFFSET2=0,ALIGN=2,TAGR="",HOFFSET=0}
BarText~f~2!{HLTHONBAR="true",TAGOOR="",IGNOREONFULL="true",MAXCHARS=0,CLASSONBAR="false",HFONT="Friz Quadrata TT",OUTLINE=1,HLTHTYPE=1,OFFSET=1,HLTHTXTANCHOR=1,FONT="Friz Quadrata TT",HMAXCHARS=0,CLASSTYPE=1,NUMFORMAT2=1,OVERHEAL=1,NUMFORMAT1=2,TAGDC="",TAGRIP="",HEIGHT=10,INCHEALS=2,SHOWROLE="false",HALIGN=2,NAMEONBAR="true",HHEIGHT=10,HOUTLINE=1,INCABSORBS=1,HOFFSET2=0,ALIGN=2,TAGR="",HOFFSET=2}
BarText~f~3!{HLTHONBAR="true",TAGOOR="",IGNOREONFULL="true",MAXCHARS=0,CLASSONBAR="false",HFONT="Friz Quadrata TT",OUTLINE=1,HLTHTYPE=1,OFFSET=0,HLTHTXTANCHOR=1,FONT="Friz Quadrata TT",HMAXCHARS=0,CLASSTYPE=1,NUMFORMAT2=1,OVERHEAL=1,NUMFORMAT1=2,TAGDC="",TAGRIP="",HEIGHT=10,INCHEALS=2,SHOWROLE="false",HALIGN=2,NAMEONBAR="true",HHEIGHT=10,HOUTLINE=1,INCABSORBS=1,HOFFSET2=0,ALIGN=2,TAGR="",HOFFSET=0}
BarText~d!4~5~6~
BarText~f~7!{HLTHONBAR="false",TAGOOR="",IGNOREONFULL="true",MAXCHARS=12,CLASSONBAR="false",HFONT="Friz Quadrata TT",OUTLINE=1,HLTHTYPE=1,OFFSET=-5,HLTHTXTANCHOR=1,FONT="Friz Quadrata TT",HMAXCHARS=0,CLASSTYPE=1,NUMFORMAT2=1,OVERHEAL=1,NUMFORMAT1=2,TAGDC="",TAGRIP="",HEIGHT=10,INCHEALS=2,SHOWROLE="false",HALIGN=2,NAMEONBAR="true",HHEIGHT=10,HOUTLINE=1,INCABSORBS=1,HOFFSET2=0,ALIGN=2,TAGR="",HOFFSET=0}
BarText~f~8!{HLTHONBAR="true",TAGOOR="",IGNOREONFULL="true",MAXCHARS=0,CLASSONBAR="false",HFONT="Friz Quadrata TT",OUTLINE=1,HLTHTYPE=1,OFFSET=0,HLTHTXTANCHOR=1,FONT="Friz Quadrata TT",HMAXCHARS=0,CLASSTYPE=1,NUMFORMAT2=1,OVERHEAL=1,NUMFORMAT1=2,TAGDC="",TAGRIP="",HEIGHT=10,INCHEALS=2,SHOWROLE="false",HALIGN=2,NAMEONBAR="true",HHEIGHT=10,HOUTLINE=1,INCABSORBS=1,HOFFSET2=0,ALIGN=2,TAGR="",HOFFSET=0}
BarText~d!9~
BarText~f~10!{HLTHONBAR="false",TAGOOR="",IGNOREONFULL="true",MAXCHARS=0,CLASSONBAR="false",HFONT="Friz Quadrata TT",OUTLINE=1,HLTHTYPE=1,OFFSET=-5,HLTHTXTANCHOR=1,FONT="Friz Quadrata TT",HMAXCHARS=0,CLASSTYPE=1,NUMFORMAT2=1,OVERHEAL=1,NUMFORMAT1=2,TAGDC="",TAGRIP="",HEIGHT=10,INCHEALS=2,SHOWROLE="false",HALIGN=2,NAMEONBAR="true",HHEIGHT=10,HOUTLINE=1,INCABSORBS=1,HOFFSET2=0,ALIGN=2,TAGR="",HOFFSET=0}
BarTextCol~f~1!{NAME=2,NDEBUFF="false",HLTH=2,NCDA=0.75,HCG=1,HCA=1,NCG=1,NCA=1,HCR=1,HCB=0,NCR=1,HDEBUFF="false",NCB=0,HCDA=0.75}
BarTextCol~f~2!{NCB=0,NCR=1,HCDA=0.5,NCDA=0.5,HCG=1,NDEBUFF="false",NCG=1,NCA=1,HCR=1,HCB=0,HCA=1,HDEBUFF="false",NAME=2,HLTH=2}
BarTextCol~f~3!{NCB=0,NCR=1,HCDA=0.4,NCDA=0.4,HCG=1,NDEBUFF="false",NCG=1,NCA=1,HCR=1,HCB=0,HCA=1,HDEBUFF="false",NAME=2,HLTH=2}
BarTextCol~d!4~5~6~7~8~9~10~
Icons~f~1!{SHOWBUFF="true",POSITION=2,FADESECS=15,MAXDICONS=3,I15EN="true",SHOWDEBUFF="true",ONBAR=1,FADE="true",DSCALE=0.5,SHOWDIR="true",SHOWRC="true",SCALE=0.5,SHOWDIRMOUSE="false",DOUBLE="false",MAXBICONS=8}
Icons~f~2!{SHOWBUFF="true",SHOWDEBUFF="true",FADESECS=15,MAXDICONS=2,I15EN="true",POSITION=2,ONBAR=1,SHOWDIRMOUSE="false",DSCALE=0.5,SHOWDIR="true",SHOWRC="true",SCALE=0.5,DOUBLE="false",FADE="true",MAXBICONS=5}
Icons~f~3!{SHOWBUFF="true",SHOWDEBUFF="true",FADESECS=15,MAXDICONS=3,I15EN="true",POSITION=2,ONBAR=1,SHOWDIRMOUSE="false",DSCALE=0.5,SHOWDIR="true",SHOWRC="false",SCALE=0.5,DOUBLE="false",FADE="true",MAXBICONS=8}
Icons~d!4~5~6~
Icons~f~7!{SHOWBUFF="true",SHOWDEBUFF="true",FADESECS=15,MAXDICONS=2,I15EN="true",POSITION=2,ONBAR=1,SHOWDIRMOUSE="false",DSCALE=0.5,SHOWDIR="true",SHOWRC="false",SCALE=0.5,DOUBLE="false",FADE="true",MAXBICONS=5}
Icons~f~8!{SHOWBUFF="true",SHOWDEBUFF="true",FADESECS=15,MAXDICONS=3,I15EN="true",POSITION=2,ONBAR=1,SHOWDIRMOUSE="false",DSCALE=0.5,SHOWDIR="true",SHOWRC="false",SCALE=0.5,DOUBLE="false",FADE="true",MAXBICONS=8}
Icons~d!9~
Icons~f~10!{SHOWBUFF="true",SHOWDEBUFF="true",FADESECS=15,MAXDICONS=2,I15EN="true",POSITION=2,ONBAR=1,SHOWDIRMOUSE="false",DSCALE=0.5,SHOWDIR="true",SHOWRC="false",SCALE=0.5,DOUBLE="false",FADE="true",MAXBICONS=5}
RaidIcon~f~1!{SQUARE="true",CIRCLE="true",DIAMOND="true",SHOW="true",MOON="true",TRIANGLE="true",STAR="true",CROSS="true",SKULL="true"}
RaidIcon~d!2~3~4~5~6~7~8~9~10~
IconText~f~1!{SDUR="false",HEIGHT=8,SSCNT="false",SCNT="true",DURTHRH=9,FONT="Friz Quadrata TT",DURWARN=3,SSDUR="true",OUTLINE=2}
IconText~d!2~3~4~5~6~7~8~9~10~
BarVisibility~f~1!{INCCLASSES=1,ALERTIC=0.98,ALERTOC=0.95,HIDEOOR="false"}
BarVisibility~f~2!{INCCLASSES=1,ALERTIC=0.95,ALERTOC=0.9,HIDEOOR="false"}
BarVisibility~f~3!{INCCLASSES=1,ALERTIC=0.99,ALERTOC=0.95,HIDEOOR="false"}
BarVisibility~d!4~5~6~
BarVisibility~f~7!{INCCLASSES=1,ALERTIC=0.85,ALERTOC=0.7,HIDEOOR="false"}
BarVisibility~f~8!{INCCLASSES=1,ALERTIC=0.99,ALERTOC=0.95,HIDEOOR="false"}
BarVisibility~d!9~10~
BarSort~f~1!{SUBORDER=2,OORLAST="false",RAIDORDER=6,SUBPF="true"}
BarSort~f~2!{SUBORDER=1,OORLAST="false",RAIDORDER=3,SUBPF="true"}
BarSort~d!3~4~5~6~7~8~9~10~
BarAggro~f~1!{B=0,SHOWIND="true",G=0,TEXTFORMAT=3,SHOW="true",SHOWTEXTPCT="true",ALERTIND=2,R=1,SHOWTEXT="false",ALERT=2}
BarAggro~d!2~3~4~5~6~7~8~9~10~
AuxBarFrame~f~1!{OVERLAP=1}
AuxBarFrame~d!2~3~4~5~6~7~8~9~10~
AuxBar^1~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,OTYPE=1}
AuxBar^1~d!2~3~4~5~6~7~8~9~10~
AuxBar^2~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,OTYPE=1}
AuxBar^2~d!2~3~4~5~6~7~8~9~10~
AuxBar^3~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,OTYPE=1}
AuxBar^3~d!2~3~4~5~6~7~8~9~10~
AuxBar^4~f~1!{SIZE=0.98,USE=5,R=1,COLOUR=1,ANCHOR=2,OFFSET=0,DEPTH=2,G=1,B=1,OTYPE=1}
AuxBar^4~d!2~3~4~5~6~7~8~9~
AuxBar^4~f~10!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=2,OFFSET=0,DEPTH=2,G=1,B=1,OTYPE=1}
AuxBar^5~f~1!{SIZE=0.98,USE=5,R=1,COLOUR=1,ANCHOR=1,OFFSET=0,DEPTH=2,G=1,B=1,OTYPE=1}
AuxBar^5~d!2~3~4~5~6~7~8~9~
AuxBar^5~f~10!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=0,DEPTH=2,G=1,B=1,OTYPE=1}
AuxBar^6~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,OTYPE=1}
AuxBar^6~d!2~3~4~5~6~7~8~9~10~
AuxBar^7~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,OTYPE=1}
AuxBar^7~d!2~3~4~5~6~7~8~9~10~
AuxBar^8~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,OTYPE=1}
AuxBar^8~d!2~3~4~5~6~7~8~9~10~
AuxBar^9~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,OTYPE=1}
AuxBar^9~d!2~3~4~5~6~7~8~9~10~
Complete!]]
HealBot_ExtraSkinData[52]=[[Skin
Kalimdor-5
Author~v!Monti of Terenas
DuplicateBars~v!false
Chat~t!{EOCOOM="false",EOCOOMV=20,MSG="Casting #s on #n",RESONLY="true",CHAN="",NOTIFY=0}
General~t!{OFREQ=0.07,OMIN=0.1,OMAX=0.95,FLUIDFREQ=10,HIDEPTF="false",HIDEPARTYF="true",STICKYSENSITIVITY=35,HIDERAIDF="true",STICKYFRAME="true",FLUIDBARS="true",HIDEBOSSF="true"}
Healing~t!{TINCSELF="false",GROUPPETS="true",TARGETINCOMBAT=2,TINCRAID=1,FONLYFRIEND="false",SELFPET=0,TONLYFRIEND="false",FALWAYSSHOW="false",FOCUSINCOMBAT=2,TALWAYSSHOW="false",TINCPET="false",TINCGROUP=1,TEXRAID="false",FEXRAID="false"}
Enemy~t!{ENEMYTARGET="false",INCTANKS="true",INCMYTAR="false",INCARENA="true",ENEMYTARGETSIZE=40,INCARENAPETS="false",HIDE="true",NUMBOSS=2,EXISTSHOWPTAR=1,INCSELF="false",EXISTSHOWBOSS="true",DOUBLEWIDTH="false",EXISTSHOWARENA=3}
FrameAlias~f~1!{SIZE=12,NAME="",R=1,ALIAS="Group",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~2!{A=1,NAME="Tanks",R=1,ALIAS="Tank",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~3!{A=1,NAME="",R=1,ALIAS="Not Used",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~4!{A=1,NAME="",R=1,ALIAS="NotUsed",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~5!{A=1,NAME="",R=1,ALIAS="Not Used",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~6!{A=1,NAME="",R=1,ALIAS="Vehicle",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~7!{A=1,NAME="",R=1,ALIAS="Pets",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~8!{A=1,NAME="",R=1,ALIAS="Target",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~9!{A=1,NAME="",R=1,ALIAS="Focus",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~10!{A=1,NAME="",R=1,ALIAS="Enemy",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAliasBar~f~1!{A=0.8,TEXTURE="HealBot 10",B=0.106,HEIGHT=30,R=0.106,G=0.106,WIDTH=0.95}
FrameAliasBar~f~2!{A=0.4,TEXTURE="HealBot 10",B=0.102,HEIGHT=30,R=0.102,G=0.102,WIDTH=0.95}
FrameAliasBar~f~3!{A=0.5,TEXTURE="HealBot 10",B=0.25,HEIGHT=20,R=0.1,G=0.25,WIDTH=0.7}
FrameAliasBar~d!4~5~6~7~8~9~10~
Frame~f~1!{BACKR=0.102,BACKG=0.102,AUTOCLOSE="false",BACKB=0.702,LOCKED="false",SCALE=1,BORDERA=0.04,BORDERG=0.1,TIPLOC=2,BORDERB=0.1,BACKA=0,OPENSOUND="false",SFOFFSETV=0,SFOFFSETH=0,BORDERR=0.1}
Frame~f~2!{SFOFFSETH=0,BORDERR=0.1,AUTOCLOSE="false",BACKB=0.702,LOCKED="true",OPENSOUND="false",BORDERA=0.04,BORDERG=0.1,TIPLOC=2,BORDERB=0.1,BACKA=0,SCALE=1,BACKG=0.102,SFOFFSETV=-5,BACKR=0.102}
Frame~f~3!{BACKR=0.1,BACKG=0.1,AUTOCLOSE="false",BACKB=0.7,LOCKED="false",SCALE=1,BORDERA=0.04,BORDERG=0.1,TIPLOC=5,BORDERB=0.1,BACKA=0.1,OPENSOUND="false",SFOFFSETV=0,SFOFFSETH=0,BORDERR=0.1}
Frame~d!4~
Frame~f~5!{SFOFFSETH=0,BORDERR=0.1,AUTOCLOSE="false",BACKB=0.7,LOCKED="true",OPENSOUND="false",BORDERA=0.04,BORDERG=0.1,TIPLOC=2,BORDERB=0.1,BACKA=0.1,SCALE=1,BACKG=0.1,SFOFFSETV=0,BACKR=0.1}
Frame~f~6!{SFOFFSETH=0,BORDERR=0.1,AUTOCLOSE="false",BACKB=0.7,LOCKED="false",OPENSOUND="false",BORDERA=0.04,BORDERG=0.1,TIPLOC=5,BORDERB=0.1,BACKA=0.1,SCALE=1,BACKG=0.1,SFOFFSETV=0,BACKR=0.1}
Frame~f~7!{SFOFFSETH=0,BORDERR=0.1,AUTOCLOSE="false",BACKB=0.7,LOCKED="true",OPENSOUND="false",BORDERA=0.04,BORDERG=0.1,TIPLOC=5,BORDERB=0.1,BACKA=0.1,SCALE=1,BACKG=0.1,SFOFFSETV=5,BACKR=0.1}
Frame~f~8!{BACKR=0.1,SFOFFSETH=0,SFOFFSETV=0,BACKG=0.1,LOCKED="false",SCALE=1,BORDERA=0.04,BORDERG=0.1,AUTOCLOSE="false",BACKB=0.7,BACKA=0.1,OPENSOUND="false",BORDERB=0.1,TIPLOC=5,BORDERR=0.1}
Frame~d!9~
Frame~f~10!{BACKR=0.1,SFOFFSETH=-2,SFOFFSETV=0,BACKG=0.1,LOCKED="true",SCALE=1,BORDERA=1,BORDERG=0,AUTOCLOSE="false",BACKB=0.7,BACKA=0.1,OPENSOUND="false",BORDERB=0,TIPLOC=4,BORDERR=1}
StickyFrames~f~1!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~f~2!{STUCK="true",STUCKTOPOINT="TOPLEFT",STUCKTO=1,STUCKPOINT="BOTTOMLEFT"}
StickyFrames~f~3!{STUCK="false",STUCKTOPOINT="RIGHT",STUCKTO=2,STUCKPOINT="LEFT"}
StickyFrames~f~4!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~d!5~6~
StickyFrames~f~7!{STUCK="true",STUCKTOPOINT="BOTTOMLEFT",STUCKTO=1,STUCKPOINT="TOPLEFT"}
StickyFrames~f~8!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~f~9!{STUCK="true",STUCKTOPOINT="TOPLEFT",STUCKTO=2,STUCKPOINT="TOPRIGHT"}
StickyFrames~f~10!{STUCK="true",STUCKTOPOINT="TOPRIGHT",STUCKTO=1,STUCKPOINT="TOPLEFT"}
HealGroups~f~1!{FRAME=1,STATE="false",NAME="Self"}
HealGroups~f~2!{FRAME=2,STATE="true",NAME="Main tanks"}
HealGroups~f~3!{FRAME=1,STATE="false",NAME="Healers"}
HealGroups~f~4!{FRAME=1,STATE="true",NAME="Group"}
HealGroups~f~5!{FRAME=1,STATE="false",NAME="Private List"}
HealGroups~f~6!{FRAME=1,STATE="false",NAME="Raid"}
HealGroups~f~7!{FRAME=1,STATE="false",NAME="Vehicle"}
HealGroups~f~8!{FRAME=7,STATE="true",NAME="Pets"}
HealGroups~f~9!{FRAME=8,STATE="false",NAME="Target"}
HealGroups~f~10!{FRAME=9,STATE="true",NAME="Focus"}
HealGroups~f~11!{FRAME=10,STATE="true",NAME="Enemy"}
Anchors~f~1!{Y=64.99,GROW=2,BARS=1,FRAME=1,X=72.07}
Anchors~f~2!{Y=64.57,GROW=1,BARS=1,FRAME=2,X=72.07}
Anchors~f~3!{Y=22.89,GROW=1,BARS=1,FRAME=6,X=31.19}
Anchors~f~4!{Y=53,GROW=2,BARS=1,FRAME=1,X=53}
Anchors~f~5!{Y=50.59,GROW=2,BARS=1,FRAME=1,X=58.13}
Anchors~f~6!{Y=55,GROW=2,BARS=1,FRAME=1,X=55}
Anchors~f~7!{Y=59.07,GROW=2,BARS=1,FRAME=1,X=72.07}
Anchors~f~8!{Y=69.57,GROW=2,BARS=1,FRAME=1,X=72.07}
Anchors~f~9!{Y=70.91,GROW=2,BARS=1,FRAME=3,X=72.07}
Anchors~f~10!{Y=64.99,GROW=2,BARS=1,FRAME=1,X=75.28}
HeadBar~f~1!{SHOW="false",TEXTURE="Tukui",R=0.102,B=0.102,HEIGHT=66,A=0.4,G=0.102,WIDTH=0.95}
HeadBar~f~2!{SHOW="false",WIDTH=0.95,B=0.102,R=0.102,HEIGHT=62,A=0.4,G=0.102,TEXTURE="Tukui"}
HeadBar~f~3!{SHOW="true",WIDTH=0.95,B=0.102,R=0.102,HEIGHT=60,A=0.4,G=0.102,TEXTURE="Tukui2"}
HeadBar~d!4~5~6~
HeadBar~f~7!{SHOW="false",WIDTH=0.95,B=0.102,R=0.102,HEIGHT=38,A=0.4,G=0.102,TEXTURE="Tukui"}
HeadBar~f~8!{SHOW="true",WIDTH=0.95,B=0.102,R=0.102,HEIGHT=60,A=0.4,G=0.102,TEXTURE="Tukui2"}
HeadBar~d!9~
HeadBar~f~10!{SHOW="true",TEXTURE="Tukui2",R=0.102,B=0.102,HEIGHT=12,A=0.4,G=0.102,WIDTH=0.95}
HeadText~f~1!{A=1,R=1,OFFSET=0,B=0.961,FONT="Friz Quadrata TT",HEIGHT=11,G=0.996,OUTLINE=1}
HeadText~d!2~3~4~5~6~7~8~9~10~
HealBar~f~1!{HEIGHT=60,GRPCOLS="false",CMARGIN=2,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=80,RMARGIN=2,OFIX=1,NUMCOLS=2,LOWMANA=1}
HealBar~f~2!{HEIGHT=60,GRPCOLS="false",CMARGIN=2,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=166,RMARGIN=2,OFIX=1,NUMCOLS=1,LOWMANA=1}
HealBar~f~3!{HEIGHT=60,GRPCOLS="false",CMARGIN=2,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=80,RMARGIN=2,OFIX=1,NUMCOLS=2,LOWMANA=1}
HealBar~f~4!{HEIGHT=60,GRPCOLS="false",CMARGIN=2,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=1,NUMCOLS=3,OFIX=1,RMARGIN=2,WIDTH=80}
HealBar~d!5~6~
HealBar~f~7!{HEIGHT=30,GRPCOLS="false",CMARGIN=2,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=1,WIDTH=80,OFIX=1,RMARGIN=2,NUMCOLS=2}
HealBar~f~8!{HEIGHT=60,GRPCOLS="false",CMARGIN=2,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=1,WIDTH=80,OFIX=1,RMARGIN=2,NUMCOLS=3}
HealBar~d!9~
HealBar~f~10!{HEIGHT=50,GRPCOLS="false",CMARGIN=2,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",NUMCOLS=3,RMARGIN=2,OFIX=1,WIDTH=80,LOWMANA=1}
BarCol~f~1!{BACK=3,BA=0.75,BOUT=2,DISA=0.15,BR=0,HB=0.4,BG=0,HR=0.2,HA=1,HG=0.4,ORA=0.45,BB=0,HLTH=2}
BarCol~d!2~3~4~5~6~7~8~9~10~
BarIACol~f~1!{AC=3,AB=1,AA=0.6,AR=1,AG=1,IC=4,IB=0.2,IA=0.6,IR=0.2,IG=0.8}
BarIACol~d!2~3~4~5~6~7~8~9~10~
BarText~f~1!{HLTHONBAR="false",TAGOOR="",HOUTLINE=1,MAXCHARS=12,CLASSONBAR="false",OUTLINE=2,INCHEALS=2,FONT="Friz Quadrata TT",OFFSET=10,HLTHTXTANCHOR=1,HLTHTYPE=3,HMAXCHARS=0,CLASSTYPE=1,NUMFORMAT2=1,OVERHEAL=1,TAGDC="",NUMFORMAT1=11,TAGRIP="",HEIGHT=10,HFONT="Friz Quadrata TT",SHOWROLE="true",HALIGN=2,NAMEONBAR="true",HHEIGHT=10,IGNOREONFULL="true",INCABSORBS=1,HOFFSET2=0,ALIGN=2,TAGR="",HOFFSET=0}
BarText~f~2!{HLTHONBAR="false",TAGOOR="",HOUTLINE=1,MAXCHARS=0,CLASSONBAR="false",OUTLINE=2,INCHEALS=2,FONT="Friz Quadrata TT",OFFSET=10,HLTHTXTANCHOR=1,HLTHTYPE=3,HMAXCHARS=0,CLASSTYPE=1,NUMFORMAT2=1,OVERHEAL=1,TAGDC="",NUMFORMAT1=11,TAGRIP="",HEIGHT=10,HFONT="Friz Quadrata TT",SHOWROLE="true",HALIGN=2,NAMEONBAR="true",HHEIGHT=10,IGNOREONFULL="true",INCABSORBS=1,HOFFSET2=0,ALIGN=2,TAGR="",HOFFSET=0}
BarText~f~3!{HLTHONBAR="false",TAGOOR="",HOUTLINE=1,MAXCHARS=12,CLASSONBAR="false",OUTLINE=2,INCHEALS=2,FONT="Friz Quadrata TT",OFFSET=10,HLTHTXTANCHOR=1,HLTHTYPE=3,HMAXCHARS=0,CLASSTYPE=1,NUMFORMAT2=1,OVERHEAL=1,TAGDC="",NUMFORMAT1=11,TAGRIP="",HEIGHT=10,HFONT="Friz Quadrata TT",SHOWROLE="true",HALIGN=2,NAMEONBAR="true",HHEIGHT=10,IGNOREONFULL="true",INCABSORBS=1,HOFFSET2=0,ALIGN=2,TAGR="",HOFFSET=0}
BarText~d!4~5~6~
BarText~f~7!{HLTHONBAR="false",TAGOOR="",HOUTLINE=1,MAXCHARS=12,CLASSONBAR="false",HFONT="Friz Quadrata TT",OUTLINE=2,HMAXCHARS=0,INCHEALS=2,HLTHTXTANCHOR=1,FONT="Friz Quadrata TT",HLTHTYPE=3,CLASSTYPE=1,NUMFORMAT2=1,OVERHEAL=1,TAGDC="",IGNOREONFULL="true",TAGRIP="",HEIGHT=10,NAMEONBAR="true",SHOWROLE="true",HALIGN=2,OFFSET=1,NUMFORMAT1=11,HHEIGHT=10,INCABSORBS=1,HOFFSET2=0,ALIGN=2,TAGR="",HOFFSET=0}
BarText~f~8!{HLTHONBAR="false",TAGOOR="",HOUTLINE=1,MAXCHARS=12,CLASSONBAR="false",HFONT="Friz Quadrata TT",OUTLINE=2,HMAXCHARS=0,INCHEALS=2,HLTHTXTANCHOR=1,FONT="Friz Quadrata TT",HLTHTYPE=3,CLASSTYPE=1,NUMFORMAT2=1,OVERHEAL=1,TAGDC="",IGNOREONFULL="true",TAGRIP="",HEIGHT=10,NAMEONBAR="true",SHOWROLE="true",HALIGN=2,OFFSET=10,NUMFORMAT1=11,HHEIGHT=10,INCABSORBS=1,HOFFSET2=0,ALIGN=2,TAGR="",HOFFSET=0}
BarText~d!9~
BarText~f~10!{HLTHONBAR="false",TAGOOR="",OVERHEAL=1,MAXCHARS=12,CLASSONBAR="false",HFONT="Friz Quadrata TT",OUTLINE=2,HMAXCHARS=0,OFFSET=5,HLTHTXTANCHOR=1,HLTHTYPE=3,FONT="Friz Quadrata TT",CLASSTYPE=1,NUMFORMAT2=1,IGNOREONFULL="true",NUMFORMAT1=11,TAGDC="",NAMEONBAR="true",HEIGHT=10,TAGRIP="",SHOWROLE="true",HALIGN=2,INCHEALS=2,HHEIGHT=10,HOUTLINE=1,INCABSORBS=1,HOFFSET2=0,ALIGN=2,TAGR="",HOFFSET=0}
BarTextCol~f~1!{NAME=3,HCA=1,HLTH=3,NCDA=0.7,HCG=1,NCR=0.929,HCB=0,NCA=1,NDEBUFF="false",NCG=1,HCR=0.929,HDEBUFF="false",NCB=0,HCDA=0.7}
BarTextCol~d!2~3~4~5~6~7~8~9~10~
Icons~f~1!{SHOWBUFF="true",POSITION=2,FADESECS=15,I15EN="true",SHOWDEBUFF="true",FADE="true",ONBAR=1,DOUBLE="true",DSCALE=0.55,SHOWDIR="false",SHOWRC="true",SCALE=0.55,SHOWDIRMOUSE="false",MAXDICONS=4,MAXBICONS=6}
Icons~f~2!{SHOWBUFF="true",POSITION=2,FADESECS=15,I15EN="true",SHOWDEBUFF="true",FADE="true",ONBAR=1,DOUBLE="true",DSCALE=0.55,SHOWDIR="false",SHOWRC="true",SCALE=0.55,SHOWDIRMOUSE="false",MAXDICONS=5,MAXBICONS=10}
Icons~f~3!{SHOWBUFF="true",POSITION=2,FADESECS=15,I15EN="true",SHOWDEBUFF="true",FADE="true",ONBAR=1,DOUBLE="true",DSCALE=0.55,SHOWDIR="false",SHOWRC="true",SCALE=0.55,SHOWDIRMOUSE="false",MAXDICONS=3,MAXBICONS=8}
Icons~d!4~5~6~
Icons~f~7!{SHOWBUFF="true",POSITION=2,I15EN="true",MAXDICONS=2,FADESECS=15,SHOWDIRMOUSE="false",ONBAR=1,FADE="true",DSCALE=0.45,SHOWDIR="false",SHOWRC="true",SCALE=0.45,DOUBLE="false",SHOWDEBUFF="true",MAXBICONS=3}
Icons~f~8!{SHOWBUFF="true",POSITION=2,I15EN="true",MAXDICONS=3,FADESECS=15,SHOWDIRMOUSE="false",ONBAR=1,FADE="true",DSCALE=0.55,SHOWDIR="false",SHOWRC="true",SCALE=0.55,DOUBLE="true",SHOWDEBUFF="true",MAXBICONS=8}
Icons~d!9~
Icons~f~10!{SHOWBUFF="true",POSITION=2,I15EN="true",MAXDICONS=4,FADESECS=15,SHOWDIRMOUSE="false",ONBAR=1,FADE="true",DSCALE=0.55,SHOWDIR="false",SHOWRC="true",SCALE=0.55,DOUBLE="true",SHOWDEBUFF="true",MAXBICONS=6}
RaidIcon~f~1!{SQUARE="true",CIRCLE="true",DIAMOND="true",SHOW="true",SKULL="true",TRIANGLE="true",STAR="true",CROSS="true",MOON="true"}
RaidIcon~d!2~3~4~5~6~7~8~9~10~
IconText~f~1!{DURWARN=3,HEIGHT=10,SSCNT="false",SCALE=0.8,SCNT="true",DURTHRH=9,FONT="Swansea",SDUR="true",SSDUR="false",OUTLINE=2}
IconText~f~2!{DURWARN=3,HEIGHT=10,SSCNT="false",SCALE=0.7,SCNT="true",DURTHRH=9,FONT="Swansea",SDUR="true",SSDUR="false",OUTLINE=2}
IconText~d!3~4~5~6~7~8~9~10~
BarVisibility~f~1!{INCCLASSES=1,ALERTIC=1,ALERTOC=0.9,HIDEOOR="false"}
BarVisibility~d!2~3~4~5~6~7~8~9~10~
BarSort~f~1!{SUBORDER=1,OORLAST="false",RAIDORDER=3,SUBPF="true"}
BarSort~d!2~3~4~5~6~7~8~9~10~
BarAggro~f~1!{B=0,ALERTIND=2,G=0,TEXTFORMAT=3,SHOW="true",SHOWTEXTPCT="true",SHOWIND="true",SHOWTEXT="true",R=1,ALERT=2}
BarAggro~d!2~3~4~5~6~7~8~9~10~
AuxBarFrame~f~1!{OVERLAP=1}
AuxBarFrame~d!2~3~4~5~6~7~8~9~10~
AuxBar^1~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,OTYPE=1}
AuxBar^1~d!2~3~4~5~6~7~8~9~10~
AuxBar^2~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,OTYPE=1}
AuxBar^2~d!2~3~4~5~6~7~8~9~10~
AuxBar^3~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,OTYPE=1}
AuxBar^3~d!2~3~4~5~6~7~8~9~10~
AuxBar^4~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,OTYPE=1}
AuxBar^4~d!2~3~4~5~6~7~8~9~10~
AuxBar^5~f~1!{SIZE=0.98,USE=5,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=1,G=1,B=1,OTYPE=1}
AuxBar^5~d!2~3~4~5~6~7~8~9~10~
AuxBar^6~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,OTYPE=1}
AuxBar^6~d!2~3~4~5~6~7~8~9~10~
AuxBar^7~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,OTYPE=1}
AuxBar^7~d!2~3~4~5~6~7~8~9~10~
AuxBar^8~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,OTYPE=1}
AuxBar^8~d!2~3~4~5~6~7~8~9~10~
AuxBar^9~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,OTYPE=1}
AuxBar^9~d!2~3~4~5~6~7~8~9~10~
Complete!]]
HealBot_ExtraSkinData[53]=[[Skin
Kalimdor-25
Author~v!Monti of Terenas
DuplicateBars~v!true
Chat~t!{EOCOOM="false",EOCOOMV=20,MSG="Casting #s on #n",RESONLY="true",CHAN="",NOTIFY=0}
General~t!{OFREQ=0.07,OMIN=0.1,OMAX=0.95,FLUIDFREQ=10,HIDEPTF="false",HIDEPARTYF="true",STICKYFRAME="true",STICKYSENSITIVITY=35,HIDERAIDF="true",FLUIDBARS="true",HIDEBOSSF="true"}
Healing~t!{TINCSELF="false",GROUPPETS="true",TARGETINCOMBAT=2,TINCRAID=1,FONLYFRIEND="false",SELFPET=0,TONLYFRIEND="false",FALWAYSSHOW="false",FOCUSINCOMBAT=2,TALWAYSSHOW="false",TINCPET="false",TINCGROUP=1,TEXRAID="false",FEXRAID="false"}
Enemy~t!{ENEMYTARGET="false",INCTANKS="true",INCMYTAR="false",INCARENA="true",ENEMYTARGETSIZE=40,INCARENAPETS="false",HIDE="true",NUMBOSS=2,EXISTSHOWPTAR=1,INCSELF="false",EXISTSHOWBOSS="true",DOUBLEWIDTH="false",EXISTSHOWARENA=3}
FrameAlias~f~1!{SIZE=12,NAME="",R=1,ALIAS="Raid",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~2!{A=1,NAME="Tanks",R=1,ALIAS="Tanks",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~3!{A=1,NAME="",R=1,ALIAS="Not Used",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~4!{A=1,NAME="",R=1,ALIAS="NotUsed",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~5!{A=1,NAME="",R=1,ALIAS="Not Used",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~6!{A=1,NAME="",R=1,ALIAS="Vehicle",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~7!{A=1,NAME="",R=1,ALIAS="Pets",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~8!{A=1,NAME="",R=1,ALIAS="Target",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~9!{A=1,NAME="",R=1,ALIAS="Focus",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~10!{A=1,NAME="",R=1,ALIAS="Enemy",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAliasBar~f~1!{A=0.8,TEXTURE="HealBot 10",B=0.106,HEIGHT=30,R=0.106,G=0.106,WIDTH=0.95}
FrameAliasBar~f~2!{A=0.4,TEXTURE="HealBot 10",B=0.102,HEIGHT=30,R=0.102,G=0.102,WIDTH=0.95}
FrameAliasBar~f~3!{A=0.5,TEXTURE="HealBot 10",B=0.25,HEIGHT=20,R=0.1,G=0.25,WIDTH=0.7}
FrameAliasBar~d!4~5~6~7~8~9~10~
Frame~f~1!{BACKR=0.102,AUTOCLOSE="false",TIPLOC=2,BACKB=0.702,LOCKED="false",SCALE=1,BORDERA=0.04,BORDERG=0.1,BACKG=0.102,BORDERB=0.1,BACKA=0,OPENSOUND="false",SFOFFSETV=0,BORDERR=0.1,SFOFFSETH=0}
Frame~f~2!{BORDERR=0.1,BACKR=0.102,TIPLOC=2,BACKB=0.702,LOCKED="true",OPENSOUND="false",BORDERA=0.04,BORDERG=0.1,BACKG=0.102,BORDERB=0.1,BACKA=0,SCALE=1,AUTOCLOSE="false",SFOFFSETV=-5,SFOFFSETH=0}
Frame~f~3!{BACKR=0.1,AUTOCLOSE="false",TIPLOC=5,BACKB=0.7,LOCKED="false",SCALE=1,BORDERA=0.04,BORDERG=0.1,BACKG=0.1,BORDERB=0.1,BACKA=0.1,OPENSOUND="false",SFOFFSETV=0,BORDERR=0.1,SFOFFSETH=0}
Frame~d!4~
Frame~f~5!{BORDERR=0.1,BACKR=0.1,TIPLOC=2,BACKB=0.7,LOCKED="true",OPENSOUND="false",BORDERA=0.04,BORDERG=0.1,BACKG=0.1,BORDERB=0.1,BACKA=0.1,SCALE=1,AUTOCLOSE="false",SFOFFSETV=0,SFOFFSETH=0}
Frame~f~6!{BORDERR=0.1,BACKR=0.1,TIPLOC=5,BACKB=0.7,LOCKED="false",OPENSOUND="false",BORDERA=0.04,BORDERG=0.1,BACKG=0.1,BORDERB=0.1,BACKA=0.1,SCALE=1,AUTOCLOSE="false",SFOFFSETV=0,SFOFFSETH=0}
Frame~f~7!{BORDERR=0.1,BACKR=0.1,TIPLOC=5,BACKB=0.7,LOCKED="true",OPENSOUND="false",BORDERA=0.04,BORDERG=0.1,BACKG=0.1,BORDERB=0.1,BACKA=0.1,SCALE=1,AUTOCLOSE="false",SFOFFSETV=5,SFOFFSETH=0}
Frame~f~8!{SFOFFSETH=0,BORDERR=0.1,SFOFFSETV=0,AUTOCLOSE="false",LOCKED="false",SCALE=1,BORDERA=0.04,BORDERG=0.1,TIPLOC=5,BACKB=0.7,BACKA=0.1,OPENSOUND="false",BORDERB=0.1,BACKG=0.1,BACKR=0.1}
Frame~d!9~
Frame~f~10!{SFOFFSETH=-2,BORDERR=1,SFOFFSETV=0,AUTOCLOSE="false",LOCKED="true",SCALE=1,BORDERA=1,BORDERG=0,TIPLOC=4,BACKB=0.7,BACKA=0.1,OPENSOUND="false",BORDERB=0,BACKG=0.1,BACKR=0.1}
StickyFrames~f~1!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~f~2!{STUCK="true",STUCKTOPOINT="TOPLEFT",STUCKTO=1,STUCKPOINT="BOTTOMLEFT"}
StickyFrames~f~3!{STUCK="false",STUCKTOPOINT="RIGHT",STUCKTO=2,STUCKPOINT="LEFT"}
StickyFrames~f~4!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~d!5~6~
StickyFrames~f~7!{STUCK="true",STUCKTOPOINT="BOTTOMLEFT",STUCKTO=1,STUCKPOINT="TOPLEFT"}
StickyFrames~f~8!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~d!9~
StickyFrames~f~10!{STUCK="true",STUCKTOPOINT="TOPRIGHT",STUCKTO=1,STUCKPOINT="TOPLEFT"}
HealGroups~f~1!{FRAME=1,STATE="false",NAME="Self"}
HealGroups~f~2!{FRAME=2,STATE="true",NAME="Main tanks"}
HealGroups~f~3!{FRAME=1,STATE="false",NAME="Healers"}
HealGroups~f~4!{FRAME=1,STATE="false",NAME="Group"}
HealGroups~f~5!{FRAME=1,STATE="false",NAME="Private List"}
HealGroups~f~6!{FRAME=1,STATE="true",NAME="Raid"}
HealGroups~f~7!{FRAME=1,STATE="false",NAME="Vehicle"}
HealGroups~f~8!{FRAME=7,STATE="true",NAME="Pets"}
HealGroups~f~9!{FRAME=8,STATE="false",NAME="Target"}
HealGroups~f~10!{FRAME=9,STATE="false",NAME="Focus"}
HealGroups~f~11!{FRAME=10,STATE="true",NAME="Enemy"}
Anchors~f~1!{Y=69.09,GROW=1,BARS=1,FRAME=1,X=66.93}
Anchors~f~2!{Y=68.67,GROW=1,BARS=1,FRAME=2,X=66.93}
Anchors~f~3!{Y=22.89,GROW=1,BARS=1,FRAME=6,X=31.19}
Anchors~f~4!{Y=53,GROW=2,BARS=1,FRAME=1,X=53}
Anchors~f~5!{Y=50.59,GROW=2,BARS=1,FRAME=1,X=58.13}
Anchors~f~6!{Y=55,GROW=2,BARS=1,FRAME=1,X=55}
Anchors~f~7!{Y=63.17,GROW=1,BARS=1,FRAME=1,X=66.93}
Anchors~f~8!{Y=73.74,GROW=2,BARS=1,FRAME=1,X=66.78}
Anchors~f~9!{Y=75.01,GROW=2,BARS=1,FRAME=1,X=63.65}
Anchors~f~10!{Y=69.09,GROW=2,BARS=1,FRAME=1,X=72.93}
HeadBar~f~1!{SHOW="true",TEXTURE="Tukui",R=0.102,B=0.102,HEIGHT=66,A=0.4,G=0.102,WIDTH=0.95}
HeadBar~f~2!{SHOW="true",WIDTH=0.95,B=0.102,R=0.102,HEIGHT=62,A=0.4,G=0.102,TEXTURE="Tukui"}
HeadBar~f~3!{SHOW="true",WIDTH=0.95,B=0.102,R=0.102,HEIGHT=60,A=0.4,G=0.102,TEXTURE="Tukui2"}
HeadBar~d!4~5~6~
HeadBar~f~7!{SHOW="true",WIDTH=0.95,B=0.102,R=0.102,HEIGHT=38,A=0.4,G=0.102,TEXTURE="Tukui"}
HeadBar~f~8!{SHOW="true",WIDTH=0.95,B=0.102,R=0.102,HEIGHT=60,A=0.4,G=0.102,TEXTURE="Tukui2"}
HeadBar~d!9~10~
HeadText~f~1!{A=1,R=1,OFFSET=0,B=0.961,FONT="Friz Quadrata TT",HEIGHT=11,G=0.996,OUTLINE=1}
HeadText~d!2~3~4~5~6~7~8~9~10~
HealBar~f~1!{HEIGHT=60,GRPCOLS="false",CMARGIN=2,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=80,RMARGIN=2,OFIX=1,NUMCOLS=1,LOWMANA=1}
HealBar~f~2!{HEIGHT=60,GRPCOLS="false",CMARGIN=2,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=147,RMARGIN=2,OFIX=1,NUMCOLS=1,LOWMANA=1}
HealBar~f~3!{HEIGHT=60,GRPCOLS="false",CMARGIN=2,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=80,RMARGIN=2,OFIX=1,NUMCOLS=2,LOWMANA=1}
HealBar~f~4!{HEIGHT=60,GRPCOLS="false",CMARGIN=2,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=1,NUMCOLS=3,OFIX=1,RMARGIN=2,WIDTH=80}
HealBar~d!5~6~
HealBar~f~7!{HEIGHT=30,GRPCOLS="false",CMARGIN=2,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=1,WIDTH=80,OFIX=1,RMARGIN=2,NUMCOLS=1}
HealBar~f~8!{HEIGHT=60,GRPCOLS="false",CMARGIN=2,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=1,WIDTH=80,OFIX=1,RMARGIN=2,NUMCOLS=3}
HealBar~d!9~10~
BarCol~f~1!{BACK=3,BA=0.75,BOUT=2,DISA=0.15,BR=0,HB=0.4,BG=0,HR=0.2,HA=1,HG=0.4,ORA=0.45,BB=0,HLTH=2}
BarCol~d!2~3~4~5~6~7~8~9~10~
BarIACol~f~1!{AC=3,AB=1,AA=0.6,AR=1,AG=1,IC=4,IB=0.2,IA=0.6,IR=0.2,IG=0.8}
BarIACol~d!2~3~4~5~6~7~8~9~10~
BarText~f~1!{HLTHONBAR="false",TAGOOR="",OVERHEAL=1,MAXCHARS=12,CLASSONBAR="false",OUTLINE=2,HMAXCHARS=0,FONT="Friz Quadrata TT",INCHEALS=2,HLTHTXTANCHOR=1,HLTHTYPE=3,OFFSET=10,CLASSTYPE=1,NUMFORMAT2=1,IGNOREONFULL="true",NUMFORMAT1=11,HFONT="Friz Quadrata TT",TAGRIP="",HEIGHT=10,NAMEONBAR="true",SHOWROLE="true",HALIGN=2,TAGDC="",HHEIGHT=10,HOUTLINE=1,INCABSORBS=1,HOFFSET2=0,ALIGN=2,TAGR="",HOFFSET=0}
BarText~f~2!{HLTHONBAR="false",TAGOOR="",OVERHEAL=1,MAXCHARS=0,CLASSONBAR="false",OUTLINE=2,HMAXCHARS=0,FONT="Friz Quadrata TT",INCHEALS=2,HLTHTXTANCHOR=1,HLTHTYPE=3,OFFSET=10,CLASSTYPE=1,NUMFORMAT2=1,IGNOREONFULL="true",NUMFORMAT1=11,HFONT="Friz Quadrata TT",TAGRIP="",HEIGHT=10,NAMEONBAR="true",SHOWROLE="true",HALIGN=2,TAGDC="",HHEIGHT=10,HOUTLINE=1,INCABSORBS=1,HOFFSET2=0,ALIGN=2,TAGR="",HOFFSET=0}
BarText~f~3!{HLTHONBAR="false",TAGOOR="",OVERHEAL=1,MAXCHARS=12,CLASSONBAR="false",OUTLINE=2,HMAXCHARS=0,FONT="Friz Quadrata TT",INCHEALS=2,HLTHTXTANCHOR=1,HLTHTYPE=3,OFFSET=10,CLASSTYPE=1,NUMFORMAT2=1,IGNOREONFULL="true",NUMFORMAT1=11,HFONT="Friz Quadrata TT",TAGRIP="",HEIGHT=10,NAMEONBAR="true",SHOWROLE="true",HALIGN=2,TAGDC="",HHEIGHT=10,HOUTLINE=1,INCABSORBS=1,HOFFSET2=0,ALIGN=2,TAGR="",HOFFSET=0}
BarText~d!4~5~6~
BarText~f~7!{HLTHONBAR="false",TAGOOR="",HOUTLINE=1,MAXCHARS=12,CLASSONBAR="false",OUTLINE=2,HMAXCHARS=0,FONT="Friz Quadrata TT",INCHEALS=2,HLTHTXTANCHOR=1,HLTHTYPE=3,OVERHEAL=1,CLASSTYPE=1,NUMFORMAT2=1,IGNOREONFULL="true",TAGDC="",TAGRIP="",NAMEONBAR="true",HEIGHT=10,OFFSET=1,SHOWROLE="true",HALIGN=2,HFONT="Friz Quadrata TT",NUMFORMAT1=11,HHEIGHT=10,INCABSORBS=1,HOFFSET2=0,ALIGN=2,TAGR="",HOFFSET=0}
BarText~f~8!{HLTHONBAR="false",TAGOOR="",HOUTLINE=1,MAXCHARS=12,CLASSONBAR="false",OUTLINE=2,HMAXCHARS=0,FONT="Friz Quadrata TT",INCHEALS=2,HLTHTXTANCHOR=1,HLTHTYPE=3,OVERHEAL=1,CLASSTYPE=1,NUMFORMAT2=1,IGNOREONFULL="true",TAGDC="",TAGRIP="",NAMEONBAR="true",HEIGHT=10,OFFSET=10,SHOWROLE="true",HALIGN=2,HFONT="Friz Quadrata TT",NUMFORMAT1=11,HHEIGHT=10,INCABSORBS=1,HOFFSET2=0,ALIGN=2,TAGR="",HOFFSET=0}
BarText~d!9~10~
BarTextCol~f~1!{HCG=1,NDEBUFF="false",HLTH=3,NCDA=0.7,NAME=3,HCR=0.929,NCG=1,NCA=1,HCB=0,HCA=1,NCR=0.929,HDEBUFF="false",NCB=0,HCDA=0.7}
BarTextCol~d!2~3~4~5~6~7~8~9~10~
Icons~f~1!{SHOWBUFF="true",POSITION=2,FADESECS=15,I15EN="true",MAXDICONS=4,SHOWDEBUFF="true",ONBAR=1,SHOWDIRMOUSE="false",DSCALE=0.55,SHOWDIR="false",SHOWRC="true",SCALE=0.55,FADE="true",DOUBLE="true",MAXBICONS=6}
Icons~f~2!{SHOWBUFF="true",POSITION=2,FADESECS=15,I15EN="true",MAXDICONS=5,SHOWDEBUFF="true",ONBAR=1,SHOWDIRMOUSE="false",DSCALE=0.55,SHOWDIR="false",SHOWRC="true",SCALE=0.55,FADE="true",DOUBLE="true",MAXBICONS=10}
Icons~f~3!{SHOWBUFF="true",POSITION=2,FADESECS=15,I15EN="true",MAXDICONS=3,SHOWDEBUFF="true",ONBAR=1,SHOWDIRMOUSE="false",DSCALE=0.55,SHOWDIR="false",SHOWRC="true",SCALE=0.55,FADE="true",DOUBLE="true",MAXBICONS=8}
Icons~d!4~5~6~
Icons~f~7!{SHOWBUFF="true",POSITION=2,FADESECS=15,MAXDICONS=2,I15EN="true",SHOWDIRMOUSE="false",ONBAR=1,FADE="true",DSCALE=0.45,SHOWDIR="false",SHOWRC="true",SCALE=0.45,DOUBLE="false",SHOWDEBUFF="true",MAXBICONS=3}
Icons~f~8!{SHOWBUFF="true",POSITION=2,FADESECS=15,MAXDICONS=3,I15EN="true",SHOWDIRMOUSE="false",ONBAR=1,FADE="true",DSCALE=0.55,SHOWDIR="false",SHOWRC="true",SCALE=0.55,DOUBLE="true",SHOWDEBUFF="true",MAXBICONS=8}
Icons~d!9~
Icons~f~10!{SHOWBUFF="true",POSITION=2,FADESECS=15,MAXDICONS=4,I15EN="true",SHOWDIRMOUSE="false",ONBAR=1,FADE="true",DSCALE=0.55,SHOWDIR="false",SHOWRC="true",SCALE=0.55,DOUBLE="true",SHOWDEBUFF="true",MAXBICONS=6}
RaidIcon~f~1!{SQUARE="true",CIRCLE="true",DIAMOND="true",SHOW="true",SKULL="true",TRIANGLE="true",STAR="true",CROSS="true",MOON="true"}
RaidIcon~d!2~3~4~5~6~7~8~9~10~
IconText~f~1!{DURWARN=3,HEIGHT=10,SSCNT="false",SCALE=0.8,SCNT="true",DURTHRH=9,FONT="Swansea",SDUR="true",SSDUR="false",OUTLINE=2}
IconText~f~2!{DURWARN=3,HEIGHT=10,SSCNT="false",SCALE=0.7,SCNT="true",DURTHRH=9,FONT="Swansea",SDUR="true",SSDUR="false",OUTLINE=2}
IconText~d!3~4~5~6~7~8~9~10~
BarVisibility~f~1!{INCCLASSES=1,ALERTIC=0.95,ALERTOC=0.9,HIDEOOR="false"}
BarVisibility~f~2!{INCCLASSES=1,ALERTIC=0.98,ALERTOC=0.95,HIDEOOR="false"}
BarVisibility~f~3!{INCCLASSES=1,ALERTIC=1,ALERTOC=0.9,HIDEOOR="false"}
BarVisibility~d!4~5~6~
BarVisibility~f~7!{INCCLASSES=1,ALERTIC=0.95,ALERTOC=0.9,HIDEOOR="false"}
BarVisibility~f~8!{INCCLASSES=1,ALERTIC=1,ALERTOC=0.9,HIDEOOR="false"}
BarVisibility~d!9~10~
BarSort~f~1!{SUBORDER=1,OORLAST="false",RAIDORDER=3,SUBPF="true"}
BarSort~d!2~3~4~5~6~7~8~9~10~
BarAggro~f~1!{B=0,ALERTIND=2,G=0,TEXTFORMAT=3,SHOW="true",SHOWTEXTPCT="true",SHOWTEXT="true",R=1,SHOWIND="true",ALERT=2}
BarAggro~d!2~3~4~5~6~7~8~9~10~
AuxBarFrame~f~1!{OVERLAP=1}
AuxBarFrame~d!2~3~4~5~6~7~8~9~10~
AuxBar^1~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,OTYPE=1}
AuxBar^1~d!2~3~4~5~6~7~8~9~10~
AuxBar^2~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,OTYPE=1}
AuxBar^2~d!2~3~4~5~6~7~8~9~10~
AuxBar^3~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,OTYPE=1}
AuxBar^3~d!2~3~4~5~6~7~8~9~10~
AuxBar^4~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,OTYPE=1}
AuxBar^4~d!2~3~4~5~6~7~8~9~10~
AuxBar^5~f~1!{SIZE=0.98,USE=5,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=1,G=1,B=1,OTYPE=1}
AuxBar^5~d!2~3~4~5~6~7~8~9~10~
AuxBar^6~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,OTYPE=1}
AuxBar^6~d!2~3~4~5~6~7~8~9~10~
AuxBar^7~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,OTYPE=1}
AuxBar^7~d!2~3~4~5~6~7~8~9~10~
AuxBar^8~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,OTYPE=1}
AuxBar^8~d!2~3~4~5~6~7~8~9~10~
AuxBar^9~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,OTYPE=1}
AuxBar^9~d!2~3~4~5~6~7~8~9~10~
Complete!]]
HealBot_ExtraSkinData[54]=[[Skin
Kalimdor-40
Author~v!Monti of Terenas
DuplicateBars~v!true
Chat~t!{EOCOOM="false",EOCOOMV=20,MSG="Casting #s on #n",RESONLY="true",CHAN="",NOTIFY=0}
General~t!{OFREQ=0.07,OMIN=0.1,OMAX=0.95,HIDEBOSSF="true",HIDEPTF="false",FLUIDFREQ=10,STICKYFRAME="true",STICKYSENSITIVITY=35,HIDERAIDF="true",FLUIDBARS="true",HIDEPARTYF="true"}
Healing~t!{TINCSELF="false",GROUPPETS="true",TARGETINCOMBAT=2,FEXRAID="false",FONLYFRIEND="false",TINCPET="false",TONLYFRIEND="false",FALWAYSSHOW="false",FOCUSINCOMBAT=2,TALWAYSSHOW="false",SELFPET=0,TINCGROUP=1,TEXRAID="false",TINCRAID=1}
Enemy~t!{INCARENA="true",INCTANKS="true",INCMYTAR="false",ENEMYTARGET="false",ENEMYTARGETSIZE=40,INCARENAPETS="false",INCSELF="false",NUMBOSS=2,EXISTSHOWPTAR=1,HIDE="true",EXISTSHOWBOSS="true",DOUBLEWIDTH="false",EXISTSHOWARENA=3}
FrameAlias~f~1!{SIZE=12,NAME="",R=1,ALIAS="Raid",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~2!{A=1,NAME="Tanks",R=1,ALIAS="Tanks",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~3!{A=1,NAME="",R=1,ALIAS="Not Used",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~4!{A=1,NAME="",R=1,ALIAS="NotUsed",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~5!{A=1,NAME="",R=1,ALIAS="Not Used",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~6!{A=1,NAME="",R=1,ALIAS="Vehicle",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~7!{A=1,NAME="",R=1,ALIAS="Pets",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~8!{A=1,NAME="",R=1,ALIAS="Target",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~9!{A=1,NAME="",R=1,ALIAS="Focus",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~10!{A=1,NAME="",R=1,ALIAS="Enemy",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAliasBar~f~1!{A=0.8,WIDTH=0.95,B=0.106,HEIGHT=30,R=0.106,G=0.106,TEXTURE="HealBot 10"}
FrameAliasBar~f~2!{A=0.4,WIDTH=0.95,B=0.102,HEIGHT=30,R=0.102,G=0.102,TEXTURE="HealBot 10"}
FrameAliasBar~f~3!{A=0.5,WIDTH=0.7,B=0.25,HEIGHT=20,R=0.1,G=0.25,TEXTURE="HealBot 10"}
FrameAliasBar~d!4~5~6~7~8~9~10~
Frame~f~1!{SFOFFSETH=0,BORDERR=0.1,BACKR=0.102,BORDERG=0.1,LOCKED="false",OPENSOUND="false",BORDERA=0.04,SFOFFSETV=0,TIPLOC=2,BORDERB=0.1,BACKA=0,SCALE=1,BACKB=0.702,AUTOCLOSE="false",BACKG=0.102}
Frame~f~2!{SFOFFSETH=0,BORDERR=0.1,BORDERG=0.1,TIPLOC=2,LOCKED="false",SCALE=1,BORDERA=0.04,SFOFFSETV=-5,BACKG=0.102,BORDERB=0.1,BACKA=0,OPENSOUND="false",BACKB=0.702,AUTOCLOSE="false",BACKR=0.102}
Frame~f~3!{SFOFFSETH=0,BORDERR=0.1,BACKR=0.1,BORDERG=0.1,LOCKED="false",OPENSOUND="false",BORDERA=0.04,SFOFFSETV=0,TIPLOC=5,BORDERB=0.1,BACKA=0.1,SCALE=1,BACKB=0.7,AUTOCLOSE="false",BACKG=0.1}
Frame~d!4~
Frame~f~5!{SFOFFSETH=0,BORDERR=0.1,BORDERG=0.1,TIPLOC=2,LOCKED="true",SCALE=1,BORDERA=0.04,SFOFFSETV=0,BACKG=0.1,BORDERB=0.1,BACKA=0.1,OPENSOUND="false",BACKB=0.7,AUTOCLOSE="false",BACKR=0.1}
Frame~f~6!{SFOFFSETH=0,BORDERR=0.1,BORDERG=0.1,TIPLOC=5,LOCKED="false",SCALE=1,BORDERA=0.04,SFOFFSETV=0,BACKG=0.1,BORDERB=0.1,BACKA=0.1,OPENSOUND="false",BACKB=0.7,AUTOCLOSE="false",BACKR=0.1}
Frame~f~7!{SFOFFSETH=0,BORDERR=0.1,BORDERG=0.1,TIPLOC=5,LOCKED="true",SCALE=1,BORDERA=0.04,SFOFFSETV=5,BACKG=0.1,BORDERB=0.1,BACKA=0.1,OPENSOUND="false",BACKB=0.7,AUTOCLOSE="false",BACKR=0.1}
Frame~f~8!{BACKR=0.1,SFOFFSETH=0,AUTOCLOSE="false",BACKB=0.7,LOCKED="false",OPENSOUND="false",BORDERA=0.04,BORDERG=0.1,TIPLOC=5,BORDERB=0.1,BACKA=0.1,SCALE=1,BACKG=0.1,BORDERR=0.1,SFOFFSETV=0}
Frame~d!9~
Frame~f~10!{BACKR=0.1,SFOFFSETH=-2,AUTOCLOSE="false",BACKB=0.7,LOCKED="true",OPENSOUND="false",BORDERA=1,BORDERG=0,TIPLOC=4,BORDERB=0,BACKA=0.1,SCALE=1,BACKG=0.1,BORDERR=1,SFOFFSETV=0}
StickyFrames~f~1!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~f~2!{STUCK="true",STUCKTOPOINT="TOPLEFT",STUCKTO=1,STUCKPOINT="BOTTOMLEFT"}
StickyFrames~f~3!{STUCK="false",STUCKTOPOINT="RIGHT",STUCKTO=2,STUCKPOINT="LEFT"}
StickyFrames~f~4!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~d!5~6~
StickyFrames~f~7!{STUCK="true",STUCKTOPOINT="BOTTOMLEFT",STUCKTO=1,STUCKPOINT="TOPLEFT"}
StickyFrames~f~8!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~d!9~
StickyFrames~f~10!{STUCK="true",STUCKTOPOINT="TOPRIGHT",STUCKTO=1,STUCKPOINT="TOPLEFT"}
HealGroups~f~1!{FRAME=1,STATE="false",NAME="Self"}
HealGroups~f~2!{FRAME=2,STATE="true",NAME="Main tanks"}
HealGroups~f~3!{FRAME=1,STATE="false",NAME="Healers"}
HealGroups~f~4!{FRAME=1,STATE="false",NAME="Group"}
HealGroups~f~5!{FRAME=1,STATE="false",NAME="Private List"}
HealGroups~f~6!{FRAME=1,STATE="true",NAME="Raid"}
HealGroups~f~7!{FRAME=1,STATE="false",NAME="Vehicle"}
HealGroups~f~8!{FRAME=7,STATE="true",NAME="Pets"}
HealGroups~f~9!{FRAME=8,STATE="false",NAME="Target"}
HealGroups~f~10!{FRAME=9,STATE="false",NAME="Focus"}
HealGroups~f~11!{FRAME=10,STATE="true",NAME="Enemy"}
Anchors~f~1!{Y=66.17,GROW=1,BARS=1,FRAME=1,X=71.69}
Anchors~f~2!{Y=65.75,GROW=1,BARS=1,FRAME=2,X=71.69}
Anchors~f~3!{Y=22.89,GROW=1,BARS=1,FRAME=6,X=31.19}
Anchors~f~4!{Y=53,GROW=2,BARS=1,FRAME=1,X=53}
Anchors~f~5!{Y=50.59,GROW=2,BARS=1,FRAME=1,X=58.13}
Anchors~f~6!{Y=55,GROW=2,BARS=1,FRAME=1,X=55}
Anchors~f~7!{Y=34.01,GROW=1,BARS=1,FRAME=1,X=71.69}
Anchors~f~8!{Y=73.74,GROW=2,BARS=1,FRAME=1,X=66.78}
Anchors~f~9!{Y=75.08,GROW=2,BARS=1,FRAME=1,X=63.5}
Anchors~f~10!{Y=66.17,GROW=2,BARS=1,FRAME=1,X=85.19}
HeadBar~f~1!{SHOW="true",WIDTH=0.95,B=0.102,R=0.102,HEIGHT=47,A=0.4,G=0.102,TEXTURE="Tukui"}
HeadBar~f~2!{SHOW="true",TEXTURE="Tukui",R=0.102,B=0.102,HEIGHT=55,A=0.4,G=0.102,WIDTH=0.75}
HeadBar~f~3!{SHOW="true",TEXTURE="Tukui2",R=0.102,B=0.102,HEIGHT=60,A=0.4,G=0.102,WIDTH=0.95}
HeadBar~d!4~5~6~
HeadBar~f~7!{SHOW="true",TEXTURE="Tukui",R=0.102,B=0.102,HEIGHT=39,A=0.4,G=0.102,WIDTH=0.95}
HeadBar~f~8!{SHOW="true",TEXTURE="Tukui2",R=0.102,B=0.102,HEIGHT=60,A=0.4,G=0.102,WIDTH=0.95}
HeadBar~d!9~10~
HeadText~f~1!{A=1,B=0.961,OFFSET=0,R=1,FONT="Friz Quadrata TT",HEIGHT=11,G=0.996,OUTLINE=1}
HeadText~d!2~3~4~5~6~7~8~9~10~
HealBar~f~1!{HEIGHT=40,GRPCOLS="false",CMARGIN=1,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=1,NUMCOLS=1,OFIX=1,RMARGIN=1,WIDTH=58}
HealBar~f~2!{HEIGHT=40,GRPCOLS="false",CMARGIN=1,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=1,NUMCOLS=2,OFIX=1,RMARGIN=1,WIDTH=74}
HealBar~f~3!{HEIGHT=60,GRPCOLS="false",CMARGIN=2,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=1,NUMCOLS=2,OFIX=1,RMARGIN=2,WIDTH=80}
HealBar~f~4!{HEIGHT=60,GRPCOLS="false",CMARGIN=2,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=80,RMARGIN=2,OFIX=1,NUMCOLS=3,LOWMANA=1}
HealBar~d!5~6~
HealBar~f~7!{HEIGHT=25,GRPCOLS="false",CMARGIN=1,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",NUMCOLS=1,RMARGIN=1,OFIX=1,WIDTH=58,LOWMANA=1}
HealBar~f~8!{HEIGHT=60,GRPCOLS="false",CMARGIN=2,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",NUMCOLS=3,RMARGIN=2,OFIX=1,WIDTH=80,LOWMANA=1}
HealBar~d!9~
HealBar~f~10!{HEIGHT=60,GRPCOLS="false",CMARGIN=1,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=1,WIDTH=80,OFIX=1,RMARGIN=1,NUMCOLS=3}
BarCol~f~1!{BACK=3,BA=0.75,BB=0,DISA=0.15,BR=0,HB=0.4,BG=0,BOUT=2,HA=1,HG=0.4,ORA=0.45,HR=0.2,HLTH=2}
BarCol~d!2~3~4~5~6~7~8~9~10~
BarIACol~f~1!{AC=3,AB=1,AA=0.6,AR=1,AG=1,IC=4,IB=0.2,IA=0.6,IR=0.2,IG=0.8}
BarIACol~d!2~3~4~5~6~7~8~9~10~
BarText~f~1!{HLTHONBAR="false",TAGOOR="",HOUTLINE=1,MAXCHARS=12,NAMEONBAR="true",HMAXCHARS=0,HOFFSET=0,FONT="Friz Quadrata TT",INCHEALS=2,OFFSET=5,HLTHTXTANCHOR=1,HLTHTYPE=3,CLASSONBAR="false",INCABSORBS=1,NUMFORMAT2=1,OVERHEAL=1,NUMFORMAT1=11,HHEIGHT=10,TAGRIP="",HEIGHT=10,TAGDC="",SHOWROLE="true",HALIGN=2,HFONT="Friz Quadrata TT",IGNOREONFULL="true",CLASSTYPE=1,HOFFSET2=0,ALIGN=2,TAGR="",OUTLINE=2}
BarText~f~2!{HLTHONBAR="false",TAGOOR="",HOUTLINE=1,MAXCHARS=0,NAMEONBAR="true",HMAXCHARS=0,HOFFSET=0,FONT="Friz Quadrata TT",INCHEALS=2,OFFSET=5,HLTHTXTANCHOR=1,HLTHTYPE=3,CLASSONBAR="false",INCABSORBS=1,NUMFORMAT2=1,OVERHEAL=1,NUMFORMAT1=11,HHEIGHT=10,TAGRIP="",HEIGHT=10,TAGDC="",SHOWROLE="true",HALIGN=2,HFONT="Friz Quadrata TT",IGNOREONFULL="true",CLASSTYPE=1,HOFFSET2=0,ALIGN=2,TAGR="",OUTLINE=2}
BarText~f~3!{HLTHONBAR="false",TAGOOR="",HOUTLINE=1,MAXCHARS=12,NAMEONBAR="true",HMAXCHARS=0,HOFFSET=0,FONT="Friz Quadrata TT",INCHEALS=2,OFFSET=10,HLTHTXTANCHOR=1,HLTHTYPE=3,CLASSONBAR="false",INCABSORBS=1,NUMFORMAT2=1,OVERHEAL=1,NUMFORMAT1=11,HHEIGHT=10,TAGRIP="",HEIGHT=10,TAGDC="",SHOWROLE="true",HALIGN=2,HFONT="Friz Quadrata TT",IGNOREONFULL="true",CLASSTYPE=1,HOFFSET2=0,ALIGN=2,TAGR="",OUTLINE=2}
BarText~d!4~5~6~
BarText~f~7!{HHEIGHT=10,TAGOOR="",IGNOREONFULL="true",MAXCHARS=12,OFFSET=1,HMAXCHARS=0,HOFFSET=0,FONT="Friz Quadrata TT",CLASSONBAR="false",INCHEALS=2,HLTHTXTANCHOR=1,HLTHTYPE=3,OVERHEAL=1,INCABSORBS=1,NUMFORMAT2=1,HLTHONBAR="false",TAGDC="",NUMFORMAT1=11,NAMEONBAR="true",HEIGHT=10,HFONT="Friz Quadrata TT",SHOWROLE="true",HALIGN=2,TAGRIP="",HOUTLINE=1,CLASSTYPE=1,HOFFSET2=0,ALIGN=2,TAGR="",OUTLINE=2}
BarText~f~8!{HHEIGHT=10,TAGOOR="",IGNOREONFULL="true",MAXCHARS=12,OFFSET=10,HMAXCHARS=0,HOFFSET=0,FONT="Friz Quadrata TT",CLASSONBAR="false",INCHEALS=2,HLTHTXTANCHOR=1,HLTHTYPE=3,OVERHEAL=1,INCABSORBS=1,NUMFORMAT2=1,HLTHONBAR="false",TAGDC="",NUMFORMAT1=11,NAMEONBAR="true",HEIGHT=10,HFONT="Friz Quadrata TT",SHOWROLE="true",HALIGN=2,TAGRIP="",HOUTLINE=1,CLASSTYPE=1,HOFFSET2=0,ALIGN=2,TAGR="",OUTLINE=2}
BarText~d!9~10~
BarTextCol~f~1!{NAME=3,NCR=0.929,NCB=0,NCDA=0.7,HCG=1,HCA=1,HCB=0,NCA=1,NDEBUFF="false",NCG=1,HCR=0.929,HDEBUFF="false",HCDA=0.7,HLTH=3}
BarTextCol~d!2~3~4~5~6~7~8~9~10~
Icons~f~1!{SHOWBUFF="true",POSITION=2,I15EN="true",FADE="true",FADESECS=15,SHOWDIRMOUSE="false",SHOWDIR="false",DOUBLE="true",DSCALE=0.55,ONBAR=1,SHOWRC="true",SCALE=0.55,SHOWDEBUFF="true",MAXDICONS=4,MAXBICONS=6}
Icons~f~2!{SHOWBUFF="true",POSITION=2,I15EN="true",FADE="true",FADESECS=15,SHOWDIRMOUSE="false",SHOWDIR="false",DOUBLE="true",DSCALE=0.55,ONBAR=1,SHOWRC="true",SCALE=0.55,SHOWDEBUFF="true",MAXDICONS=5,MAXBICONS=10}
Icons~f~3!{SHOWBUFF="true",POSITION=2,I15EN="true",FADE="true",FADESECS=15,SHOWDIRMOUSE="false",SHOWDIR="false",DOUBLE="true",DSCALE=0.55,ONBAR=1,SHOWRC="true",SCALE=0.55,SHOWDEBUFF="true",MAXDICONS=3,MAXBICONS=8}
Icons~d!4~5~6~
Icons~f~7!{SHOWBUFF="true",SHOWDEBUFF="true",FADESECS=15,MAXDICONS=2,POSITION=2,DOUBLE="false",SHOWDIR="false",FADE="true",DSCALE=0.45,ONBAR=1,SHOWRC="true",SCALE=0.45,I15EN="true",SHOWDIRMOUSE="false",MAXBICONS=3}
Icons~f~8!{SHOWBUFF="true",SHOWDEBUFF="true",FADESECS=15,MAXDICONS=3,POSITION=2,DOUBLE="true",SHOWDIR="false",FADE="true",DSCALE=0.55,ONBAR=1,SHOWRC="true",SCALE=0.55,I15EN="true",SHOWDIRMOUSE="false",MAXBICONS=8}
Icons~d!9~
Icons~f~10!{SHOWBUFF="true",SHOWDEBUFF="true",FADESECS=15,MAXDICONS=4,POSITION=2,DOUBLE="true",SHOWDIR="false",FADE="true",DSCALE=0.55,ONBAR=1,SHOWRC="true",SCALE=0.55,I15EN="true",SHOWDIRMOUSE="false",MAXBICONS=6}
RaidIcon~f~1!{SQUARE="true",CIRCLE="true",DIAMOND="true",SHOW="true",MOON="true",TRIANGLE="true",STAR="true",SKULL="true",CROSS="true"}
RaidIcon~d!2~3~4~5~6~7~8~9~10~
IconText~f~1!{SDUR="true",HEIGHT=10,SSCNT="false",SCALE=0.8,SCNT="true",DURTHRH=9,FONT="Swansea",DURWARN=3,SSDUR="false",OUTLINE=2}
IconText~f~2!{SDUR="true",HEIGHT=10,SSCNT="false",SCALE=0.7,SCNT="true",DURTHRH=9,FONT="Swansea",DURWARN=3,SSDUR="false",OUTLINE=2}
IconText~d!3~4~5~6~7~8~9~10~
BarVisibility~f~1!{INCCLASSES=1,ALERTIC=1,ALERTOC=0.9,HIDEOOR="false"}
BarVisibility~d!2~3~4~5~6~7~8~9~10~
BarSort~f~1!{SUBORDER=1,OORLAST="false",RAIDORDER=3,SUBPF="true"}
BarSort~d!2~3~4~5~6~7~8~9~10~
BarAggro~f~1!{B=0,ALERTIND=2,G=0,TEXTFORMAT=3,SHOW="true",SHOWTEXTPCT="true",R=1,SHOWTEXT="true",SHOWIND="true",ALERT=2}
BarAggro~d!2~3~4~5~6~7~8~9~10~
AuxBarFrame~f~1!{OVERLAP=1}
AuxBarFrame~d!2~3~4~5~6~7~8~9~10~
AuxBar^1~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,OTYPE=1,B=1,G=1}
AuxBar^1~d!2~3~4~5~6~7~8~9~10~
AuxBar^2~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,OTYPE=1,B=1,G=1}
AuxBar^2~d!2~3~4~5~6~7~8~9~10~
AuxBar^3~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,OTYPE=1,B=1,G=1}
AuxBar^3~d!2~3~4~5~6~7~8~9~10~
AuxBar^4~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,OTYPE=1,B=1,G=1}
AuxBar^4~d!2~3~4~5~6~7~8~9~10~
AuxBar^5~f~1!{SIZE=0.98,USE=5,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=1,OTYPE=1,B=1,G=1}
AuxBar^5~d!2~3~4~5~6~7~8~9~10~
AuxBar^6~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,OTYPE=1,B=1,G=1}
AuxBar^6~d!2~3~4~5~6~7~8~9~10~
AuxBar^7~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,OTYPE=1,B=1,G=1}
AuxBar^7~d!2~3~4~5~6~7~8~9~10~
AuxBar^8~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,OTYPE=1,B=1,G=1}
AuxBar^8~d!2~3~4~5~6~7~8~9~10~
AuxBar^9~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,OTYPE=1,B=1,G=1}
AuxBar^9~d!2~3~4~5~6~7~8~9~10~
Complete!]]
HealBot_ExtraSkinData[55]=[[Skin
Kalimdor-10
Author~v!Monti of Terenas
DuplicateBars~v!true
Chat~t!{EOCOOM="false",EOCOOMV=20,MSG="Casting #s on #n",RESONLY="true",CHAN="",NOTIFY=0}
General~t!{OFREQ=0.07,OMIN=0.1,OMAX=0.95,HIDEBOSSF="true",HIDEPTF="false",FLUIDFREQ=10,STICKYSENSITIVITY=35,HIDERAIDF="true",STICKYFRAME="true",FLUIDBARS="true",HIDEPARTYF="true"}
Healing~t!{TINCSELF="false",GROUPPETS="true",TARGETINCOMBAT=2,TINCPET="false",FONLYFRIEND="false",FEXRAID="false",TONLYFRIEND="false",FALWAYSSHOW="false",FOCUSINCOMBAT=2,TALWAYSSHOW="false",SELFPET=0,TINCGROUP=1,TEXRAID="false",TINCRAID=1}
Enemy~t!{INCARENA="true",INCTANKS="true",INCMYTAR="false",ENEMYTARGET="false",ENEMYTARGETSIZE=40,INCARENAPETS="false",INCSELF="false",NUMBOSS=2,EXISTSHOWPTAR=1,HIDE="true",EXISTSHOWBOSS="true",DOUBLEWIDTH="false",EXISTSHOWARENA=3}
FrameAlias~f~1!{SIZE=12,NAME="",R=1,ALIAS="Raid",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~2!{A=1,NAME="Tanks",R=1,ALIAS="Tanks",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~3!{A=1,NAME="",R=1,ALIAS="Not Used",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~4!{A=1,NAME="",R=1,ALIAS="NotUsed",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~5!{A=1,NAME="",R=1,ALIAS="Not Used",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~6!{A=1,NAME="",R=1,ALIAS="Vehicle",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~7!{A=1,NAME="",R=1,ALIAS="Pets",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~8!{A=1,NAME="",R=1,ALIAS="Target",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~9!{A=1,NAME="",R=1,ALIAS="Focus",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAlias~f~10!{A=1,NAME="",R=1,ALIAS="Enemy",G=1,SHOW="false",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=1,OUTLINE=1}
FrameAliasBar~f~1!{A=0.8,WIDTH=0.95,B=0.106,HEIGHT=30,R=0.106,G=0.106,TEXTURE="HealBot 10"}
FrameAliasBar~f~2!{A=0.4,WIDTH=0.95,B=0.102,HEIGHT=30,R=0.102,G=0.102,TEXTURE="HealBot 10"}
FrameAliasBar~f~3!{A=0.5,WIDTH=0.7,B=0.25,HEIGHT=20,R=0.1,G=0.25,TEXTURE="HealBot 10"}
FrameAliasBar~d!4~5~6~7~8~9~10~
Frame~f~1!{SFOFFSETH=0,BORDERR=0.1,BACKR=0.102,SFOFFSETV=0,LOCKED="false",OPENSOUND="false",BORDERA=0.04,BORDERG=0.1,AUTOCLOSE="false",BACKB=0.702,BACKA=0,SCALE=1,BORDERB=0.1,BACKG=0.102,TIPLOC=2}
Frame~f~2!{SFOFFSETH=0,BORDERR=0.1,SFOFFSETV=-5,AUTOCLOSE="false",LOCKED="true",SCALE=1,BORDERA=0.04,BORDERG=0.1,TIPLOC=2,BACKB=0.702,BACKA=0,OPENSOUND="false",BORDERB=0.1,BACKG=0.102,BACKR=0.102}
Frame~f~3!{SFOFFSETH=0,BORDERR=0.1,BACKR=0.1,SFOFFSETV=0,LOCKED="false",OPENSOUND="false",BORDERA=0.04,BORDERG=0.1,AUTOCLOSE="false",BACKB=0.7,BACKA=0.1,SCALE=1,BORDERB=0.1,BACKG=0.1,TIPLOC=5}
Frame~d!4~
Frame~f~5!{SFOFFSETH=0,BORDERR=0.1,SFOFFSETV=0,AUTOCLOSE="false",LOCKED="true",SCALE=1,BORDERA=0.04,BORDERG=0.1,TIPLOC=2,BACKB=0.7,BACKA=0.1,OPENSOUND="false",BORDERB=0.1,BACKG=0.1,BACKR=0.1}
Frame~f~6!{SFOFFSETH=0,BORDERR=0.1,SFOFFSETV=0,AUTOCLOSE="false",LOCKED="false",SCALE=1,BORDERA=0.04,BORDERG=0.1,TIPLOC=5,BACKB=0.7,BACKA=0.1,OPENSOUND="false",BORDERB=0.1,BACKG=0.1,BACKR=0.1}
Frame~f~7!{SFOFFSETH=0,BORDERR=0.1,SFOFFSETV=5,AUTOCLOSE="false",LOCKED="true",SCALE=1,BORDERA=0.04,BORDERG=0.1,TIPLOC=5,BACKB=0.7,BACKA=0.1,OPENSOUND="false",BORDERB=0.1,BACKG=0.1,BACKR=0.1}
Frame~f~8!{BACKR=0.1,SFOFFSETH=0,BACKG=0.1,BORDERB=0.1,LOCKED="false",OPENSOUND="false",BORDERA=0.04,SFOFFSETV=0,AUTOCLOSE="false",BACKB=0.7,BACKA=0.1,SCALE=1,TIPLOC=5,BORDERG=0.1,BORDERR=0.1}
Frame~d!9~
Frame~f~10!{BACKR=0.1,SFOFFSETH=-2,BACKG=0.1,BORDERB=0,LOCKED="true",OPENSOUND="false",BORDERA=1,SFOFFSETV=0,AUTOCLOSE="false",BACKB=0.7,BACKA=0.1,SCALE=1,TIPLOC=4,BORDERG=0,BORDERR=1}
StickyFrames~f~1!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~f~2!{STUCK="true",STUCKTOPOINT="TOPLEFT",STUCKTO=1,STUCKPOINT="BOTTOMLEFT"}
StickyFrames~f~3!{STUCK="false",STUCKTOPOINT="RIGHT",STUCKTO=2,STUCKPOINT="LEFT"}
StickyFrames~f~4!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~d!5~6~
StickyFrames~f~7!{STUCK="true",STUCKTOPOINT="BOTTOMLEFT",STUCKTO=1,STUCKPOINT="TOPLEFT"}
StickyFrames~f~8!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~d!9~
StickyFrames~f~10!{STUCK="true",STUCKTOPOINT="TOPRIGHT",STUCKTO=1,STUCKPOINT="TOPLEFT"}
HealGroups~f~1!{FRAME=1,STATE="false",NAME="Self"}
HealGroups~f~2!{FRAME=2,STATE="true",NAME="Main tanks"}
HealGroups~f~3!{FRAME=1,STATE="false",NAME="Healers"}
HealGroups~f~4!{FRAME=1,STATE="false",NAME="Group"}
HealGroups~f~5!{FRAME=1,STATE="false",NAME="Private List"}
HealGroups~f~6!{FRAME=1,STATE="true",NAME="Raid"}
HealGroups~f~7!{FRAME=1,STATE="false",NAME="Vehicle"}
HealGroups~f~8!{FRAME=7,STATE="true",NAME="Pets"}
HealGroups~f~9!{FRAME=8,STATE="false",NAME="Target"}
HealGroups~f~10!{FRAME=9,STATE="false",NAME="Focus"}
HealGroups~f~11!{FRAME=10,STATE="true",NAME="Enemy"}
Anchors~f~1!{Y=69.16,GROW=1,BARS=1,FRAME=1,X=66.78}
Anchors~f~2!{Y=68.74,GROW=1,BARS=1,FRAME=2,X=66.78}
Anchors~f~3!{Y=22.89,GROW=1,BARS=1,FRAME=6,X=31.19}
Anchors~f~4!{Y=53,GROW=2,BARS=1,FRAME=1,X=53}
Anchors~f~5!{Y=50.59,GROW=2,BARS=1,FRAME=1,X=58.13}
Anchors~f~6!{Y=55,GROW=2,BARS=1,FRAME=1,X=55}
Anchors~f~7!{Y=63.24,GROW=1,BARS=1,FRAME=1,X=66.78}
Anchors~f~8!{Y=73.74,GROW=2,BARS=1,FRAME=1,X=66.78}
Anchors~f~9!{Y=75.08,GROW=2,BARS=1,FRAME=1,X=63.5}
Anchors~f~10!{Y=69.16,GROW=2,BARS=1,FRAME=1,X=72.78}
HeadBar~f~1!{SHOW="true",WIDTH=0.95,B=0.102,R=0.102,HEIGHT=66,A=0.4,G=0.102,TEXTURE="Tukui"}
HeadBar~f~2!{SHOW="true",TEXTURE="Tukui",R=0.102,B=0.102,HEIGHT=62,A=0.4,G=0.102,WIDTH=0.95}
HeadBar~f~3!{SHOW="true",TEXTURE="Tukui2",R=0.102,B=0.102,HEIGHT=60,A=0.4,G=0.102,WIDTH=0.95}
HeadBar~d!4~5~6~
HeadBar~f~7!{SHOW="true",TEXTURE="Tukui",R=0.102,B=0.102,HEIGHT=38,A=0.4,G=0.102,WIDTH=0.95}
HeadBar~f~8!{SHOW="true",TEXTURE="Tukui2",R=0.102,B=0.102,HEIGHT=60,A=0.4,G=0.102,WIDTH=0.95}
HeadBar~d!9~
HeadBar~f~10!{SHOW="true",WIDTH=0.95,B=0.102,R=0.102,HEIGHT=12,A=0.4,G=0.102,TEXTURE="Tukui2"}
HeadText~f~1!{A=1,B=0.961,OFFSET=0,R=1,FONT="Friz Quadrata TT",HEIGHT=11,G=0.996,OUTLINE=1}
HeadText~d!2~3~4~5~6~7~8~9~10~
HealBar~f~1!{HEIGHT=60,GRPCOLS="false",CMARGIN=2,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=1,NUMCOLS=1,OFIX=1,RMARGIN=2,WIDTH=80}
HealBar~f~2!{HEIGHT=60,GRPCOLS="false",CMARGIN=2,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=1,NUMCOLS=1,OFIX=1,RMARGIN=2,WIDTH=147}
HealBar~f~3!{HEIGHT=60,GRPCOLS="false",CMARGIN=2,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=1,NUMCOLS=2,OFIX=1,RMARGIN=2,WIDTH=80}
HealBar~f~4!{HEIGHT=60,GRPCOLS="false",CMARGIN=2,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=80,RMARGIN=2,OFIX=1,NUMCOLS=3,LOWMANA=1}
HealBar~d!5~6~
HealBar~f~7!{HEIGHT=30,GRPCOLS="false",CMARGIN=2,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",NUMCOLS=1,RMARGIN=2,OFIX=1,WIDTH=80,LOWMANA=1}
HealBar~f~8!{HEIGHT=60,GRPCOLS="false",CMARGIN=2,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",NUMCOLS=3,RMARGIN=2,OFIX=1,WIDTH=80,LOWMANA=1}
HealBar~d!9~
HealBar~f~10!{HEIGHT=47,GRPCOLS="false",CMARGIN=2,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=1,WIDTH=80,OFIX=1,RMARGIN=2,NUMCOLS=3}
BarCol~f~1!{BACK=3,BA=0.75,BB=0,DISA=0.15,BR=0,HB=0.4,BG=0,BOUT=2,HA=1,HR=0.2,ORA=0.45,HG=0.4,HLTH=2}
BarCol~d!2~3~4~5~6~7~8~9~10~
BarIACol~f~1!{AC=3,AB=1,AA=0.6,AR=1,AG=1,IC=4,IB=0.2,IA=0.6,IR=0.2,IG=0.8}
BarIACol~d!2~3~4~5~6~7~8~9~10~
BarText~f~1!{HLTHONBAR="false",TAGOOR="",HOUTLINE=1,MAXCHARS=12,HMAXCHARS=0,HOFFSET=0,INCHEALS=2,FONT="Friz Quadrata TT",OFFSET=10,HLTHTXTANCHOR=1,HLTHTYPE=3,CLASSONBAR="false",INCABSORBS=1,NUMFORMAT2=1,OVERHEAL=1,NUMFORMAT1=11,HHEIGHT=10,TAGRIP="",HEIGHT=10,TAGDC="",SHOWROLE="true",HALIGN=2,NAMEONBAR="true",HFONT="Friz Quadrata TT",IGNOREONFULL="true",CLASSTYPE=1,HOFFSET2=0,ALIGN=2,TAGR="",OUTLINE=2}
BarText~f~2!{HLTHONBAR="false",TAGOOR="",HOUTLINE=1,MAXCHARS=0,HMAXCHARS=0,HOFFSET=0,INCHEALS=2,FONT="Friz Quadrata TT",OFFSET=10,HLTHTXTANCHOR=1,HLTHTYPE=3,CLASSONBAR="false",INCABSORBS=1,NUMFORMAT2=1,OVERHEAL=1,NUMFORMAT1=11,HHEIGHT=10,TAGRIP="",HEIGHT=10,TAGDC="",SHOWROLE="true",HALIGN=2,NAMEONBAR="true",HFONT="Friz Quadrata TT",IGNOREONFULL="true",CLASSTYPE=1,HOFFSET2=0,ALIGN=2,TAGR="",OUTLINE=2}
BarText~f~3!{HLTHONBAR="false",TAGOOR="",HOUTLINE=1,MAXCHARS=12,HMAXCHARS=0,HOFFSET=0,INCHEALS=2,FONT="Friz Quadrata TT",OFFSET=10,HLTHTXTANCHOR=1,HLTHTYPE=3,CLASSONBAR="false",INCABSORBS=1,NUMFORMAT2=1,OVERHEAL=1,NUMFORMAT1=11,HHEIGHT=10,TAGRIP="",HEIGHT=10,TAGDC="",SHOWROLE="true",HALIGN=2,NAMEONBAR="true",HFONT="Friz Quadrata TT",IGNOREONFULL="true",CLASSTYPE=1,HOFFSET2=0,ALIGN=2,TAGR="",OUTLINE=2}
BarText~d!4~5~6~
BarText~f~7!{HHEIGHT=10,TAGOOR="",OVERHEAL=1,MAXCHARS=12,HMAXCHARS=0,HOFFSET=0,CLASSONBAR="false",FONT="Friz Quadrata TT",INCHEALS=2,HLTHTXTANCHOR=1,HLTHTYPE=3,HOUTLINE=1,INCABSORBS=1,NUMFORMAT2=1,HLTHONBAR="false",TAGDC="",NUMFORMAT1=11,TAGRIP="",HEIGHT=10,HFONT="Friz Quadrata TT",SHOWROLE="true",HALIGN=2,OFFSET=1,NAMEONBAR="true",IGNOREONFULL="true",CLASSTYPE=1,HOFFSET2=0,ALIGN=2,TAGR="",OUTLINE=2}
BarText~f~8!{HHEIGHT=10,TAGOOR="",OVERHEAL=1,MAXCHARS=12,HMAXCHARS=0,HOFFSET=0,CLASSONBAR="false",FONT="Friz Quadrata TT",INCHEALS=2,HLTHTXTANCHOR=1,HLTHTYPE=3,HOUTLINE=1,INCABSORBS=1,NUMFORMAT2=1,HLTHONBAR="false",TAGDC="",NUMFORMAT1=11,TAGRIP="",HEIGHT=10,HFONT="Friz Quadrata TT",SHOWROLE="true",HALIGN=2,OFFSET=10,NAMEONBAR="true",IGNOREONFULL="true",CLASSTYPE=1,HOFFSET2=0,ALIGN=2,TAGR="",OUTLINE=2}
BarText~d!9~
BarText~f~10!{HLTHONBAR="false",TAGOOR="",IGNOREONFULL="true",MAXCHARS=12,HMAXCHARS=0,HOFFSET=0,CLASSONBAR="false",HLTHTYPE=3,OFFSET=5,HLTHTXTANCHOR=1,FONT="Friz Quadrata TT",HOUTLINE=1,INCABSORBS=1,NUMFORMAT2=1,OVERHEAL=1,NUMFORMAT1=11,HHEIGHT=10,NAMEONBAR="true",HEIGHT=10,HFONT="Friz Quadrata TT",SHOWROLE="true",HALIGN=2,INCHEALS=2,TAGRIP="",TAGDC="",CLASSTYPE=1,HOFFSET2=0,ALIGN=2,TAGR="",OUTLINE=2}
BarTextCol~f~1!{NCB=0,NDEBUFF="false",HCDA=0.7,NCDA=0.7,HCG=1,HCR=0.929,NCG=1,NCA=1,NCR=0.929,HCA=1,HCB=0,HDEBUFF="false",NAME=3,HLTH=3}
BarTextCol~d!2~3~4~5~6~7~8~9~10~
Icons~f~1!{SHOWBUFF="true",POSITION=2,I15EN="true",MAXDICONS=4,FADESECS=15,DOUBLE="true",SHOWDIR="false",SHOWDIRMOUSE="false",DSCALE=0.55,ONBAR=1,SHOWRC="true",SCALE=0.55,FADE="true",SHOWDEBUFF="true",MAXBICONS=6}
Icons~f~2!{SHOWBUFF="true",POSITION=2,I15EN="true",MAXDICONS=5,FADESECS=15,DOUBLE="true",SHOWDIR="false",SHOWDIRMOUSE="false",DSCALE=0.55,ONBAR=1,SHOWRC="true",SCALE=0.55,FADE="true",SHOWDEBUFF="true",MAXBICONS=10}
Icons~f~3!{SHOWBUFF="true",POSITION=2,I15EN="true",MAXDICONS=3,FADESECS=15,DOUBLE="true",SHOWDIR="false",SHOWDIRMOUSE="false",DSCALE=0.55,ONBAR=1,SHOWRC="true",SCALE=0.55,FADE="true",SHOWDEBUFF="true",MAXBICONS=8}
Icons~d!4~5~6~
Icons~f~7!{SHOWBUFF="true",SHOWDEBUFF="true",MAXDICONS=2,FADESECS=15,POSITION=2,DOUBLE="false",SHOWDIR="false",FADE="true",DSCALE=0.45,ONBAR=1,SHOWRC="true",SCALE=0.45,SHOWDIRMOUSE="false",I15EN="true",MAXBICONS=3}
Icons~f~8!{SHOWBUFF="true",SHOWDEBUFF="true",MAXDICONS=3,FADESECS=15,POSITION=2,DOUBLE="true",SHOWDIR="false",FADE="true",DSCALE=0.55,ONBAR=1,SHOWRC="true",SCALE=0.55,SHOWDIRMOUSE="false",I15EN="true",MAXBICONS=8}
Icons~d!9~
Icons~f~10!{SHOWBUFF="true",SHOWDEBUFF="true",MAXDICONS=4,FADESECS=15,POSITION=2,DOUBLE="true",SHOWDIR="false",FADE="true",DSCALE=0.55,ONBAR=1,SHOWRC="true",SCALE=0.55,SHOWDIRMOUSE="false",I15EN="true",MAXBICONS=6}
RaidIcon~f~1!{SQUARE="true",CIRCLE="true",DIAMOND="true",SHOW="true",MOON="true",TRIANGLE="true",STAR="true",SKULL="true",CROSS="true"}
RaidIcon~d!2~3~4~5~6~7~8~9~10~
IconText~f~1!{SDUR="true",HEIGHT=10,SSCNT="false",SCALE=0.8,SCNT="true",DURTHRH=9,FONT="Swansea",DURWARN=3,SSDUR="false",OUTLINE=2}
IconText~f~2!{SDUR="true",HEIGHT=10,SSCNT="false",SCALE=0.7,SCNT="true",DURTHRH=9,FONT="Swansea",DURWARN=3,SSDUR="false",OUTLINE=2}
IconText~d!3~4~5~6~7~8~9~10~
BarVisibility~f~1!{INCCLASSES=1,ALERTIC=1,ALERTOC=0.9,HIDEOOR="false"}
BarVisibility~d!2~3~4~5~6~7~8~9~10~
BarSort~f~1!{SUBORDER=1,OORLAST="false",RAIDORDER=3,SUBPF="true"}
BarSort~d!2~3~4~5~6~7~8~9~10~
BarAggro~f~1!{B=0,ALERTIND=2,G=0,TEXTFORMAT=3,SHOW="true",SHOWTEXTPCT="true",SHOWTEXT="true",SHOWIND="true",R=1,ALERT=2}
BarAggro~d!2~3~4~5~6~7~8~9~10~
AuxBarFrame~f~1!{OVERLAP=1}
AuxBarFrame~d!2~3~4~5~6~7~8~9~10~
AuxBar^1~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,OTYPE=1,B=1,G=1}
AuxBar^1~d!2~3~4~5~6~7~8~9~10~
AuxBar^2~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,OTYPE=1,B=1,G=1}
AuxBar^2~d!2~3~4~5~6~7~8~9~10~
AuxBar^3~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,OTYPE=1,B=1,G=1}
AuxBar^3~d!2~3~4~5~6~7~8~9~10~
AuxBar^4~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,OTYPE=1,B=1,G=1}
AuxBar^4~d!2~3~4~5~6~7~8~9~10~
AuxBar^5~f~1!{SIZE=0.98,USE=5,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=1,OTYPE=1,B=1,G=1}
AuxBar^5~d!2~3~4~5~6~7~8~9~10~
AuxBar^6~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,OTYPE=1,B=1,G=1}
AuxBar^6~d!2~3~4~5~6~7~8~9~10~
AuxBar^7~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,OTYPE=1,B=1,G=1}
AuxBar^7~d!2~3~4~5~6~7~8~9~10~
AuxBar^8~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,OTYPE=1,B=1,G=1}
AuxBar^8~d!2~3~4~5~6~7~8~9~10~
AuxBar^9~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,OTYPE=1,B=1,G=1}
AuxBar^9~d!2~3~4~5~6~7~8~9~10~
Complete!]]
HealBot_ExtraSkinData[56]=[[Skin
Dark Efficient 5
Author~v!Monti of Terenas
DuplicateBars~v!false
Chat~t!{EOCOOM="false",EOCOOMV=20,MSG="Casting #s on #n",RESONLY="true",CHAN="",NOTIFY=1}
General~t!{HIDEBOSSF="true",STICKYSENSITIVITY=19,FLUIDBARS="false",HIDEPARTYF="false",HIDEPTF="false",OMAX=0.95,HIDERAIDF="true",FLUIDFREQ=10,STICKYFRAME="true",OMIN=0.1,OFREQ=0.07}
Healing~t!{TINCSELF="false",GROUPPETS="true",TARGETINCOMBAT=1,TINCGROUP="true",FONLYFRIEND="true",TINCPET="false",TONLYFRIEND="false",FALWAYSSHOW="false",FOCUSINCOMBAT=2,TALWAYSSHOW="false",FEXRAID="false",TINCRAID="true",TEXRAID="false",SELFPET=0}
Enemy~t!{ENEMYTARGET="false",INCTANKS="true",INCMYTAR="false",INCARENA="false",INCARENAPETS="false",ENEMYTARGETSIZE=40,INCSELF="false",NUMBOSS=4,EXISTSHOWPTAR=1,HIDE="true",EXISTSHOWBOSS="true",DOUBLEWIDTH="false",EXISTSHOWARENA=2}
FrameAlias~f~1!{SIZE=12,NAME="Party",R=1,ALIAS="Group",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~2!{SIZE=12,NAME="Tank and Healer",R=1,ALIAS="Tank and Healer",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~3!{SIZE=12,NAME="Pets",R=1,ALIAS="Not Used 1",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~4!{SIZE=12,NAME="Focus and Target",R=1,ALIAS="Not Used 2",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~5!{SIZE=12,NAME="Enemy",R=1,ALIAS="Not Used 3",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~6!{SIZE=12,NAME="",R=1,ALIAS="Vehicle",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~7!{SIZE=12,NAME="Pets",R=1,ALIAS="Pets",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~8!{SIZE=12,NAME="Target",R=1,ALIAS="Target",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~9!{SIZE=12,NAME="",R=1,ALIAS="Focus",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~10!{SIZE=12,NAME="",R=1,ALIAS="Enemy",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAliasBar~f~1!{A=0.91,WIDTH=0.9,B=0.192,HEIGHT=20,R=0.576,G=0.192,TEXTURE="Diagonal"}
FrameAliasBar~f~2!{A=0.25,TEXTURE="Diagonal",B=0.1,HEIGHT=20,R=0.1,G=0.1,WIDTH=0.9}
FrameAliasBar~d!3~4~5~6~7~8~9~10~
Frame~f~1!{BORDERR=0.498,BACKR=0.227,SFOFFSETH=0,BORDERG=0.498,LOCKED="false",OPENSOUND="false",BORDERA=0.32,SFOFFSETV=0,AUTOCLOSE="false",BACKB=0.227,BACKA=0.58,SCALE=1,BORDERB=0.498,TIPLOC=2,BACKG=0.227}
Frame~d!2~3~4~5~6~7~
Frame~f~8!{SFOFFSETH=-4,BACKG=0.227,TIPLOC=2,BORDERB=0.498,LOCKED="false",SCALE=1,BORDERA=0.32,BORDERG=0.498,AUTOCLOSE="false",BACKB=0.227,BACKA=0.58,OPENSOUND="false",SFOFFSETV=-2,BACKR=0.227,BORDERR=0.498}
Frame~f~9!{SFOFFSETH=4,BACKG=0.227,TIPLOC=2,BORDERB=0.498,LOCKED="false",SCALE=1,BORDERA=0.32,BORDERG=0.498,AUTOCLOSE="false",BACKB=0.227,BACKA=0.58,OPENSOUND="false",SFOFFSETV=-2,BACKR=0.227,BORDERR=0.498}
Frame~f~10!{BORDERR=0.498,BACKR=0.227,SFOFFSETH=0,BORDERG=0.498,LOCKED="false",OPENSOUND="false",BORDERA=0.32,SFOFFSETV=-4,AUTOCLOSE="false",BACKB=0.227,BACKA=0.58,SCALE=1,BORDERB=0.498,TIPLOC=2,BACKG=0.227}
StickyFrames~f~1!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~d!2~3~4~5~6~
StickyFrames~f~7!{STUCK="true",STUCKTOPOINT="BOTTOMRIGHT",STUCKTO=1,STUCKPOINT="TOPRIGHT"}
StickyFrames~f~8!{STUCK="true",STUCKTOPOINT="TOPRIGHT",STUCKTO=1,STUCKPOINT="TOPLEFT"}
StickyFrames~f~9!{STUCK="true",STUCKTOPOINT="TOPLEFT",STUCKTO=1,STUCKPOINT="TOPRIGHT"}
StickyFrames~f~10!{STUCK="true",STUCKTOPOINT="TOPLEFT",STUCKTO=1,STUCKPOINT="BOTTOMLEFT"}
HealGroups~f~1!{FRAME=1,STATE="true",NAME="Main tanks"}
HealGroups~f~2!{FRAME=1,STATE="false",NAME="Private List"}
HealGroups~f~3!{FRAME=1,STATE="false",NAME="Self"}
HealGroups~f~4!{FRAME=1,STATE="true",NAME="Healers"}
HealGroups~f~5!{FRAME=1,STATE="true",NAME="Group"}
HealGroups~f~6!{FRAME=1,STATE="false",NAME="Raid"}
HealGroups~f~7!{FRAME=6,STATE="false",NAME="Vehicle"}
HealGroups~f~8!{FRAME=1,STATE="true",NAME="Pets"}
HealGroups~f~9!{FRAME=8,STATE="false",NAME="Target"}
HealGroups~f~10!{FRAME=9,STATE="false",NAME="Focus"}
HealGroups~f~11!{FRAME=10,STATE="true",NAME="Enemy"}
Anchors~f~1!{Y=69.45,GROW=2,BARS=3,FRAME=3,X=92.75}
Anchors~f~2!{Y=80.57,GROW=2,BARS=3,FRAME=3,X=80.94}
Anchors~f~3!{Y=70.01,GROW=2,BARS=3,FRAME=3,X=88.59}
Anchors~f~4!{Y=64.17,GROW=2,BARS=3,FRAME=3,X=83.17}
Anchors~f~5!{Y=65.23,GROW=2,BARS=3,FRAME=3,X=89.04}
Anchors~f~6!{Y=55,GROW=2,BARS=3,FRAME=3,X=55}
Anchors~f~7!{Y=53.06,GROW=2,BARS=3,FRAME=3,X=77.98}
Anchors~f~8!{Y=70.07,GROW=2,BARS=3,FRAME=3,X=77.98}
Anchors~f~9!{Y=70.11,GROW=2,BARS=3,FRAME=3,X=78.26}
Anchors~f~10!{Y=69.12,GROW=2,BARS=3,FRAME=2,X=86.33}
HeadBar~f~1!{SHOW="false",WIDTH=0.9,B=0.506,R=0.506,HEIGHT=28,A=0.4,G=0.506,TEXTURE="BantoBar"}
HeadBar~f~2!{SHOW="false",WIDTH=0.9,B=0.1,R=0.1,HEIGHT=28,A=0.25,G=0.1,TEXTURE="Diagonal"}
HeadBar~d!3~4~5~6~7~8~9~10~
HeadText~f~1!{A=0.7,B=0.8,OFFSET=0,R=0.2,FONT="Friz Quadrata TT",HEIGHT=10,G=0.8,OUTLINE=1}
HeadText~f~2!{A=0.7,B=0.1,OFFSET=0,R=1,FONT="Friz Quadrata TT",HEIGHT=10,G=1,OUTLINE=1}
HeadText~d!3~4~5~6~7~8~9~10~
HealBar~f~1!{HEIGHT=38,GRPCOLS="false",CMARGIN=4,TEXTURE="Smooth v2",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=2,NUMCOLS=1,OFIX=1,RMARGIN=0,WIDTH=172}
HealBar~f~2!{HEIGHT=34,GRPCOLS="false",CMARGIN=4,TEXTURE="Smooth v2",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=172,RMARGIN=0,OFIX=1,NUMCOLS=1,LOWMANA=2}
HealBar~d!3~4~5~6~7~
HealBar~f~8!{HEIGHT=34,GRPCOLS="false",CMARGIN=4,TEXTURE="Smooth v2",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=2,NUMCOLS=1,OFIX=1,RMARGIN=0,WIDTH=170}
HealBar~d!9~
HealBar~f~10!{HEIGHT=34,GRPCOLS="false",CMARGIN=4,TEXTURE="Smooth v2",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=2,NUMCOLS=1,OFIX=1,RMARGIN=0,WIDTH=172}
BarCol~f~1!{BACK=2,BA=0.2,BOUT=0,DISA=0,BR=0.506,HB=0.086,BG=0.506,BB=0.506,HA=1,HG=0.086,ORA=0.4,HR=0.086,HLTH=3}
BarCol~d!2~3~4~5~6~7~8~9~
BarCol~f~10!{BACK=2,BA=0.2,BOUT=0,DISA=0,BR=0.506,HB=0,BG=0.506,BB=0.506,HA=1,HG=0,ORA=0.4,HR=0.361,HLTH=3}
BarIACol~f~1!{AC=4,AB=0.173,AA=0.45,AR=0.173,AG=0.173,IC=4,IB=0.129,IA=0.7,IR=0.129,IG=0.129}
BarIACol~d!2~3~4~5~6~7~8~9~
BarIACol~f~10!{AC=4,AB=0,AA=0.45,AR=0.675,AG=0,IC=4,IB=0,IA=0.7,IR=0.518,IG=0}
BarText~f~1!{HLTHONBAR="true",TAGOOR="OOR | ",HOUTLINE=1,MAXCHARS=15,HMAXCHARS=0,HOFFSET=-2,HLTHTYPE=1,INCHEALS=2,HLTHTXTANCHOR=1,FONT="2002",CLASSONBAR="false",IGNOREONFULL="true",NUMFORMAT2=1,OVERHEAL=1,NUMFORMAT1=11,HHEIGHT=13,NAMEONBAR="true",HEIGHT=13,TAGRIP="RIP | ",SHOWROLE="false",HALIGN=2,TAGDC="DC | ",HFONT="Friz Quadrata TT",OFFSET=2,INCABSORBS=1,HOFFSET2=0,ALIGN=2,TAGR="R | ",OUTLINE=1}
BarText~f~2!{HLTHONBAR="true",TAGOOR="OOR | ",HOUTLINE=1,MAXCHARS=0,HMAXCHARS=0,HOFFSET=-2,HLTHTYPE=1,INCHEALS=2,HLTHTXTANCHOR=1,FONT="Friz Quadrata TT",CLASSONBAR="false",IGNOREONFULL="true",NUMFORMAT2=1,OVERHEAL=1,NUMFORMAT1=11,HHEIGHT=13,NAMEONBAR="true",HEIGHT=12,TAGRIP="RIP | ",SHOWROLE="false",HALIGN=2,TAGDC="DC | ",HFONT="Friz Quadrata TT",OFFSET=0,INCABSORBS=1,HOFFSET2=0,ALIGN=2,TAGR="R | ",OUTLINE=1}
BarText~f~3!{HLTHONBAR="true",TAGOOR="[OOR] ",HOUTLINE=1,MAXCHARS=0,HMAXCHARS=0,HOFFSET=-2,HLTHTYPE=1,INCHEALS=2,HLTHTXTANCHOR=1,FONT="Friz Quadrata TT",CLASSONBAR="false",IGNOREONFULL="true",NUMFORMAT2=1,OVERHEAL=1,NUMFORMAT1=11,HHEIGHT=13,NAMEONBAR="true",HEIGHT=12,TAGRIP="[RIP] ",SHOWROLE="false",HALIGN=2,TAGDC="[DC] ",HFONT="Friz Quadrata TT",OFFSET=0,INCABSORBS=1,HOFFSET2=0,ALIGN=2,TAGR="[R] ",OUTLINE=1}
BarText~d!4~5~
BarText~f~6!{HLTHONBAR="true",TAGOOR="OOR | ",HOUTLINE=1,MAXCHARS=0,HMAXCHARS=0,HOFFSET=-2,HLTHTYPE=1,INCHEALS=2,HLTHTXTANCHOR=1,FONT="Friz Quadrata TT",CLASSONBAR="false",IGNOREONFULL="true",NUMFORMAT2=1,OVERHEAL=1,NUMFORMAT1=11,HHEIGHT=13,NAMEONBAR="true",HEIGHT=12,TAGRIP="RIP | ",SHOWROLE="false",HALIGN=2,TAGDC="DC | ",HFONT="Friz Quadrata TT",OFFSET=0,INCABSORBS=1,HOFFSET2=0,ALIGN=2,TAGR="R | ",OUTLINE=1}
BarText~d!7~
BarText~f~8!{HLTHONBAR="true",TAGOOR="",HOUTLINE=1,MAXCHARS=0,HMAXCHARS=0,HOFFSET=-2,HLTHTYPE=1,INCHEALS=2,HLTHTXTANCHOR=1,FONT="Friz Quadrata TT",CLASSONBAR="false",IGNOREONFULL="true",NUMFORMAT2=1,OVERHEAL=1,NUMFORMAT1=11,HHEIGHT=13,NAMEONBAR="true",HEIGHT=12,TAGRIP="",SHOWROLE="false",HALIGN=2,TAGDC="",HFONT="Friz Quadrata TT",OFFSET=0,INCABSORBS=1,HOFFSET2=0,ALIGN=2,TAGR="",OUTLINE=1}
BarText~f~9!{HLTHONBAR="true",TAGOOR="[OOR] ",HOUTLINE=1,MAXCHARS=0,HMAXCHARS=0,HOFFSET=-2,HLTHTYPE=1,INCHEALS=2,HLTHTXTANCHOR=1,FONT="Friz Quadrata TT",CLASSONBAR="false",IGNOREONFULL="true",NUMFORMAT2=1,OVERHEAL=1,NUMFORMAT1=11,HHEIGHT=13,NAMEONBAR="true",HEIGHT=12,TAGRIP="[RIP] ",SHOWROLE="false",HALIGN=2,TAGDC="[DC] ",HFONT="Friz Quadrata TT",OFFSET=0,INCABSORBS=1,HOFFSET2=0,ALIGN=2,TAGR="[R] ",OUTLINE=1}
BarText~d!10~
BarTextCol~f~1!{HCG=0.843,HCA=1,HCDA=0.25,NCDA=0.25,NCB=0.878,NCR=0.078,HCB=0.267,NCA=1,NDEBUFF="false",NCG=0.2,HCR=0.949,HDEBUFF="false",NAME=2,HLTH=2}
BarTextCol~f~2!{HCG=0.843,HCA=1,HCDA=0.25,NCDA=0.69,NCB=0.149,NCR=0.8,HCB=0.267,NCA=1,NDEBUFF="false",NCG=0.8,HCR=0.949,HDEBUFF="false",NAME=2,HLTH=2}
BarTextCol~d!3~4~5~6~7~8~9~
BarTextCol~f~10!{HCG=0.843,NCR=0.8,HLTH=2,NCDA=0.55,NAME=2,NDEBUFF="false",HCB=0.267,NCA=1,HCA=1,NCG=0.8,HCR=0.949,HDEBUFF="false",NCB=0.149,HCDA=0.25}
Icons~f~1!{RCEN="true",I15EN="true",CLASSEN="true",TARGETEN="true",BUFFFADE="false",DEBUFFANCHOR=1,RCVOFFSET=0,OORVOFFSET=-5,DEBUFFDOUBLE="false",TARGETVOFFSET=2,BUFFONBAR=1,SHOWDIR="true",SHOWRC="true",TARGETANCHOR=3,RCSCALE=0.7,MAXBICONS=8,TARGETHOFFSET=30,FADESECS=15,RCHOFFSET=0,OORHOFFSET=-20,CLASSONBAR=3,CLASSVOFFSET=2,TARGETSCALE=0.5,DSCALE=0.4,SCALE=0.4,TARGETONBAR=3,BUFFDOUBLE="false",OORONBAR=3,BUFFANCHOR=2,RCANCHOR=3,SHOWROLE="true",DEBUFFONBAR=1,RCONBAR=3,MAXDICONS=4,CLASSSCALE=0.5,CLASSHOFFSET=-50,SHOWCLASS="false",CLASSANCHOR=3,DOUBLE="false",OORANCHOR=2,BUFFI15EN="true",BUFFFADESECS=15,OORSCALE=0.55,SHOWDIRMOUSE="false",OOREN="true",FADE="false"}
Icons~f~2!{RCEN="true",I15EN="true",CLASSEN="true",TARGETEN="true",BUFFFADE="false",DEBUFFANCHOR=1,RCVOFFSET=0,OORVOFFSET=-5,DEBUFFDOUBLE="false",TARGETVOFFSET=2,BUFFONBAR=1,SHOWDIR="true",SHOWRC="true",TARGETANCHOR=3,RCSCALE=0.7,MAXBICONS=8,TARGETHOFFSET=30,FADESECS=15,RCHOFFSET=0,OORHOFFSET=-20,CLASSONBAR=3,CLASSVOFFSET=2,TARGETSCALE=0.5,DSCALE=0.4,SCALE=0.4,OORONBAR=3,BUFFDOUBLE="false",TARGETONBAR=3,BUFFANCHOR=2,RCANCHOR=3,CLASSSCALE=0.5,DOUBLE="false",RCONBAR=3,MAXDICONS=3,OORANCHOR=2,CLASSHOFFSET=-50,FADE="false",CLASSANCHOR=3,DEBUFFONBAR=1,SHOWCLASS="false",BUFFI15EN="true",BUFFFADESECS=15,OORSCALE=0.55,SHOWROLE="true",OOREN="true",SHOWDIRMOUSE="false"}
Icons~d!3~4~5~6~7~8~9~
Icons~f~10!{RCEN="true",I15EN="true",CLASSEN="true",TARGETEN="true",BUFFFADE="false",DEBUFFANCHOR=1,RCVOFFSET=0,OORVOFFSET=-5,DEBUFFDOUBLE="false",TARGETVOFFSET=2,BUFFONBAR=1,SHOWDIR="false",SHOWRC="true",TARGETANCHOR=3,RCSCALE=0.7,MAXBICONS=8,TARGETHOFFSET=30,FADESECS=15,RCHOFFSET=0,OORHOFFSET=-20,CLASSONBAR=3,CLASSVOFFSET=2,TARGETSCALE=0.5,DSCALE=0.4,SCALE=0.4,OORONBAR=3,BUFFDOUBLE="false",TARGETONBAR=3,BUFFANCHOR=2,RCANCHOR=3,CLASSSCALE=0.5,DOUBLE="false",RCONBAR=3,MAXDICONS=3,OORANCHOR=2,CLASSHOFFSET=-50,FADE="false",CLASSANCHOR=3,DEBUFFONBAR=1,SHOWCLASS="false",BUFFI15EN="true",BUFFFADESECS=15,OORSCALE=0.55,SHOWROLE="true",OOREN="true",SHOWDIRMOUSE="false"}
RaidIcon~f~1!{SQUARE="true",CIRCLE="true",DIAMOND="true",SHOW="true",MOON="true",TRIANGLE="true",STAR="true",SKULL="true",CROSS="true"}
RaidIcon~d!2~3~4~5~6~7~8~9~10~
IconText~f~1!{SDUR="true",BUFFHEIGHT=10,BUFFOUTLINE=2,BUFFDURTHRH=5,SCNT="true",DURTHRH=5,FONT="Friz Quadrata TT",BUFFFONT="Friz Quadrata TT",BUFFSCNT="true",SSCNT="false",BUFFSDUR="true",BUFFSSCNT="false",BUFFDURWARN=2,HEIGHT=10,BUFFSSDUR="true",DURWARN=2,SCALE=0.75,SSDUR="true",OUTLINE=2}
IconText~d!2~3~4~5~6~7~8~9~10~
BarVisibility~f~1!{INCCLASSES=1,ALERTIC=0.95,ALERTOC=0.9,HIDEOOR="false"}
BarVisibility~f~2!{INCCLASSES=1,ALERTIC=0.98,ALERTOC=0.95,HIDEOOR="false"}
BarVisibility~d!3~4~5~6~7~8~9~10~
BarSort~f~1!{SUBORDER=1,OORLAST="false",RAIDORDER=2,SUBPF="true"}
BarSort~f~2!{SUBORDER=1,OORLAST="false",RAIDORDER=3,SUBPF="true"}
BarSort~d!3~4~5~6~7~8~9~10~
BarAggro~f~1!{R=0.988,SHOWTEXT="false",G=0.553,TEXTFORMAT=3,SHOW="true",SHOWTEXTPCT="false",ALERTIND=2,B=0.114,SHOWIND="false",ALERT=2}
BarAggro~f~2!{R=1,SHOWTEXT="false",G=0,TEXTFORMAT=3,SHOW="true",SHOWTEXTPCT="true",ALERTIND=1,B=0,SHOWIND="true",ALERT=2}
BarAggro~f~3!{R=1,SHOWTEXT="false",G=0,TEXTFORMAT=3,SHOW="true",SHOWTEXTPCT="true",ALERTIND=2,B=0,SHOWIND="true",ALERT=2}
BarAggro~d!4~5~6~
BarAggro~f~7!{R=0.957,SHOWTEXT="false",G=1,TEXTFORMAT=3,SHOW="false",SHOWTEXTPCT="true",ALERTIND=2,B=0,SHOWIND="true",ALERT=2}
BarAggro~f~8!{R=1,SHOWTEXT="false",G=0,TEXTFORMAT=3,SHOW="true",SHOWTEXTPCT="true",ALERTIND=2,B=0,SHOWIND="true",ALERT=2}
BarAggro~d!9~10~
AuxBarFrame~f~1!{OVERLAP=1}
AuxBarFrame~d!2~3~4~5~6~7~8~9~10~
AuxBar^1~f~1!{SIZE=1,USE=5,R=0.675,COLOUR=3,ANCHOR=1,OFFSET=0,DEPTH=1,B=0,G=0,OTYPE=1}
AuxBar^1~d!2~3~4~5~6~7~8~9~
AuxBar^1~f~10!{SIZE=1,USE=1,B=0,COLOUR=3,ANCHOR=1,OFFSET=0,DEPTH=1,OTYPE=1,G=0,R=0.675}
AuxBar^2~f~1!{SIZE=1,USE=5,R=0.518,COLOUR=3,ANCHOR=2,OFFSET=0,DEPTH=1,B=0,G=0,OTYPE=1}
AuxBar^2~d!2~3~4~5~6~7~8~9~
AuxBar^2~f~10!{SIZE=1,USE=1,B=0,COLOUR=3,ANCHOR=2,OFFSET=0,DEPTH=1,OTYPE=1,G=0,R=0.518}
AuxBar^3~f~1!{SIZE=1,USE=5,R=0.518,COLOUR=3,ANCHOR=3,OFFSET=0,DEPTH=1,B=0,G=0,OTYPE=1}
AuxBar^3~d!2~3~4~5~6~7~8~9~
AuxBar^3~f~10!{SIZE=1,USE=1,B=0,COLOUR=3,ANCHOR=3,OFFSET=0,DEPTH=1,OTYPE=1,G=0,R=0.518}
AuxBar^4~f~1!{SIZE=1,USE=5,R=0.518,COLOUR=3,ANCHOR=4,OFFSET=0,DEPTH=1,B=0,G=0,OTYPE=1}
AuxBar^4~d!2~3~4~5~6~7~8~9~
AuxBar^4~f~10!{SIZE=1,USE=1,B=0,COLOUR=3,ANCHOR=4,OFFSET=0,DEPTH=1,OTYPE=1,G=0,R=0.518}
AuxBar^5~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=2,OFFSET=1,DEPTH=1,B=1,G=1,OTYPE=1}
AuxBar^5~d!2~3~4~5~6~7~8~9~10~
AuxBar^6~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,B=1,G=1,OTYPE=1}
AuxBar^6~d!2~3~4~5~6~7~8~9~10~
AuxBar^7~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,B=1,G=1,OTYPE=1}
AuxBar^7~d!2~3~4~5~6~7~8~9~10~
AuxBar^8~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,B=1,G=1,OTYPE=1}
AuxBar^8~d!2~3~4~5~6~7~8~9~10~
AuxBar^9~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,B=1,G=1,OTYPE=1}
AuxBar^9~d!2~3~4~5~6~7~8~9~10~
Complete!]]
HealBot_ExtraSkinData[57]=[[Skin
Dark Efficient 25
Author~v!Monti of Terenas
DuplicateBars~v!false
Chat~t!{EOCOOM="false",EOCOOMV=20,MSG="Casting #s on #n",RESONLY="true",CHAN="",NOTIFY=1}
General~t!{HIDEBOSSF="true",STICKYSENSITIVITY=30,FLUIDBARS="false",HIDEPARTYF="false",HIDEPTF="false",OMAX=0.95,STICKYFRAME="true",FLUIDFREQ=10,HIDERAIDF="true",OMIN=0.1,OFREQ=0.07}
Healing~t!{TINCRAID="true",TINCSELF="false",GROUPPETS="true",TARGETINCOMBAT=1,TINCGROUP="true",FONLYFRIEND="false",TINCPET="false",TONLYFRIEND="false",FALWAYSSHOW="false",FOCUSINCOMBAT=2,TALWAYSSHOW="false",SELFPET=0,FEXRAID="false",TEXRAID="false",ALERT=0.95}
Enemy~t!{ENEMYTARGET="false",INCTANKS="true",INCMYTAR="false",INCARENA="true",ENEMYTARGETSIZE=40,INCARENAPETS="false",HIDE="true",NUMBOSS=4,EXISTSHOWPTAR=1,INCSELF="false",EXISTSHOWBOSS="true",DOUBLEWIDTH="false",EXISTSHOWARENA=3}
FrameAlias~f~1!{SIZE=11,NAME="Tanks",R=0.714,ALIAS="Tanks",G=0.714,SHOW="true",OFFSET=-1,FONT="Friz Quadrata TT",A=1,B=0.714,OUTLINE=1}
FrameAlias~f~2!{A=1,NAME="Raid",R=0.714,ALIAS="Raid",G=0.714,SHOW="true",OFFSET=-1,FONT="Friz Quadrata TT",SIZE=12,B=0.714,OUTLINE=1}
FrameAlias~f~3!{A=1,NAME="",R=0.714,ALIAS="Not Used 1",G=0.714,SHOW="true",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=0.714,OUTLINE=1}
FrameAlias~f~4!{A=1,NAME="",R=0.714,ALIAS="Not Used 2",G=0.714,SHOW="true",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=0.714,OUTLINE=1}
FrameAlias~f~5!{A=1,NAME="",R=0.714,ALIAS="Not Used 3",G=0.714,SHOW="true",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=0.714,OUTLINE=1}
FrameAlias~f~6!{SIZE=12,NAME="",R=0.714,ALIAS="Vehicle",G=0.714,SHOW="true",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=0.714,OUTLINE=1}
FrameAlias~f~7!{A=1,NAME="Pets",R=0.714,ALIAS="Pets",G=0.714,SHOW="true",OFFSET=-1,FONT="Friz Quadrata TT",SIZE=12,B=0.714,OUTLINE=1}
FrameAlias~f~8!{A=1,NAME="Target",R=0.714,ALIAS="Target",G=0.714,SHOW="true",OFFSET=0,FONT="Friz Quadrata TT",SIZE=12,B=0.714,OUTLINE=1}
FrameAlias~f~9!{A=1,NAME="Focus",R=0.714,ALIAS="Focus",G=0.714,SHOW="true",OFFSET=0,FONT="Friz Quadrata TT",SIZE=12,B=0.714,OUTLINE=1}
FrameAlias~f~10!{A=1,NAME="Enemy",R=0.714,ALIAS="Enemy",G=0.714,SHOW="true",OFFSET=-1,FONT="Friz Quadrata TT",SIZE=12,B=0.714,OUTLINE=1}
FrameAliasBar~f~1!{A=0.75,TEXTURE="HealBot 10",B=0,HEIGHT=15,R=0,G=0,WIDTH=0.99}
FrameAliasBar~d!2~3~4~5~6~7~8~9~10~
Frame~f~1!{SFOFFSETH=0,AUTOCLOSE="false",TIPLOC=2,BACKB=0.071,LOCKED="false",OPENSOUND="false",BORDERA=1,SFOFFSETV=0,BACKG=0.071,BORDERB=0.2,BACKA=0.9,SCALE=1,BORDERG=0.2,BORDERR=0.2,BACKR=0.071}
Frame~f~2!{BORDERR=0.2,SFOFFSETH=0,TIPLOC=2,BACKB=0.071,LOCKED="true",OPENSOUND="false",BORDERA=1,SFOFFSETV=3,BACKG=0.071,BORDERB=0.2,BACKA=0.9,SCALE=1,AUTOCLOSE="false",BORDERG=0.2,BACKR=0.071}
Frame~f~3!{BORDERR=0.2,SFOFFSETH=0,TIPLOC=4,BACKB=0.071,LOCKED="false",OPENSOUND="false",BORDERA=1,SFOFFSETV=0,BACKG=0.071,BORDERB=0.2,BACKA=0.9,SCALE=0.85,AUTOCLOSE="false",BORDERG=0.2,BACKR=0.071}
Frame~f~4!{BORDERR=0.2,SFOFFSETH=0,TIPLOC=2,BACKB=0.071,LOCKED="false",OPENSOUND="false",BORDERA=1,SFOFFSETV=0,BACKG=0.071,BORDERB=0.2,BACKA=0.9,SCALE=0.85,AUTOCLOSE="false",BORDERG=0.2,BACKR=0.071}
Frame~f~5!{BORDERR=0.2,SFOFFSETH=0,TIPLOC=4,BACKB=0.071,LOCKED="false",OPENSOUND="false",BORDERA=1,SFOFFSETV=0,BACKG=0.071,BORDERB=0.2,BACKA=0.9,SCALE=0.85,AUTOCLOSE="false",BORDERG=0.2,BACKR=0.071}
Frame~f~6!{BORDERR=0.2,SFOFFSETH=0,TIPLOC=1,BACKB=0.071,LOCKED="true",OPENSOUND="false",BORDERA=1,SFOFFSETV=0,BACKG=0.071,BORDERB=0.2,BACKA=0.9,SCALE=0.85,AUTOCLOSE="false",BORDERG=0.2,BACKR=0.071}
Frame~f~7!{SFOFFSETH=0,AUTOCLOSE="false",TIPLOC=5,BACKB=0.071,LOCKED="false",OPENSOUND="false",BORDERA=1,SFOFFSETV=3,BACKG=0.071,BORDERB=0.2,BACKA=0.9,SCALE=1,BORDERG=0.2,BORDERR=0.2,BACKR=0.071}
Frame~f~8!{BACKR=0.071,SFOFFSETH=0,AUTOCLOSE="false",BORDERB=0.2,LOCKED="true",SCALE=1,BORDERA=1,SFOFFSETV=0,BACKG=0.071,BACKB=0.071,BACKA=0.9,OPENSOUND="false",TIPLOC=3,BORDERG=0.2,BORDERR=0.2}
Frame~d!9~
Frame~f~10!{SFOFFSETH=0,AUTOCLOSE="false",TIPLOC=4,BACKB=0.071,LOCKED="true",OPENSOUND="false",BORDERA=1,SFOFFSETV=-3,BACKG=0.071,BORDERB=0.2,BACKA=0.9,SCALE=1,BORDERG=0.2,BORDERR=0.2,BACKR=0.071}
StickyFrames~f~1!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~f~2!{STUCK="true",STUCKTOPOINT="BOTTOMLEFT",STUCKTO=1,STUCKPOINT="TOPLEFT"}
StickyFrames~f~3!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~d!4~5~6~
StickyFrames~f~7!{STUCK="true",STUCKTOPOINT="BOTTOMLEFT",STUCKTO=2,STUCKPOINT="TOPLEFT"}
StickyFrames~f~8!{STUCK="true",STUCKTOPOINT="TOPLEFT",STUCKTO=1,STUCKPOINT="TOPRIGHT"}
StickyFrames~f~9!{STUCK="true",STUCKTOPOINT="TOPRIGHT",STUCKTO=1,STUCKPOINT="TOPLEFT"}
StickyFrames~f~10!{STUCK="true",STUCKTOPOINT="TOPLEFT",STUCKTO=1,STUCKPOINT="BOTTOMLEFT"}
HealGroups~f~1!{FRAME=1,STATE="true",NAME="Main tanks"}
HealGroups~f~2!{FRAME=2,STATE="true",NAME="Self"}
HealGroups~f~3!{FRAME=2,STATE="true",NAME="Healers"}
HealGroups~f~4!{FRAME=2,STATE="false",NAME="Group"}
HealGroups~f~5!{FRAME=2,STATE="false",NAME="Private List"}
HealGroups~f~6!{FRAME=2,STATE="true",NAME="Raid"}
HealGroups~f~7!{FRAME=6,STATE="false",NAME="Vehicle"}
HealGroups~f~8!{FRAME=7,STATE="true",NAME="Pets"}
HealGroups~f~9!{FRAME=8,STATE="false",NAME="Target"}
HealGroups~f~10!{FRAME=9,STATE="false",NAME="Focus"}
HealGroups~f~11!{FRAME=10,STATE="true",NAME="Enemy"}
Anchors~f~1!{Y=64.4,GROW=2,BARS=1,FRAME=1,X=72.26}
Anchors~f~2!{Y=58.23,GROW=2,BARS=3,FRAME=1,X=72.26}
Anchors~f~3!{Y=60.68,GROW=2,BARS=1,FRAME=4,X=88.59}
Anchors~f~4!{Y=39.37,GROW=2,BARS=1,FRAME=3,X=7.52}
Anchors~f~5!{Y=56.81,GROW=2,BARS=1,FRAME=4,X=21.87}
Anchors~f~6!{Y=34.62,GROW=2,BARS=1,FRAME=2,X=34.81}
Anchors~f~7!{Y=53.06,GROW=2,BARS=1,FRAME=1,X=72.26}
Anchors~f~8!{Y=71.66,GROW=2,BARS=1,FRAME=3,X=79.06}
Anchors~f~9!{Y=72.36,GROW=2,BARS=1,FRAME=1,X=73.06}
Anchors~f~10!{Y=65.4,GROW=2,BARS=3,FRAME=2,X=72.26}
HeadBar~f~1!{A=1,TEXTURE="Minimalist",SHOW="false",B=0.184,HEIGHT=15,R=0.184,G=0.184,WIDTH=0.75}
HeadBar~f~2!{SHOW="false",WIDTH=0.75,A=1,B=0.184,HEIGHT=13,R=0.184,G=0.184,TEXTURE="Minimalist"}
HeadBar~f~3!{SHOW="true",WIDTH=0.75,A=1,B=0.184,HEIGHT=15,R=0.184,G=0.184,TEXTURE="Minimalist"}
HeadBar~f~4!{SHOW="false",WIDTH=0.75,A=1,B=0.184,HEIGHT=11,R=0.184,G=0.184,TEXTURE="Minimalist"}
HeadBar~f~5!{A=1,TEXTURE="Minimalist",SHOW="false",B=0.184,HEIGHT=12,R=0.184,G=0.184,WIDTH=0.75}
HeadBar~f~6!{A=1,TEXTURE="Minimalist",SHOW="false",B=0.184,HEIGHT=8,R=0.184,G=0.184,WIDTH=0.75}
HeadBar~d!7~
HeadBar~f~8!{A=1,TEXTURE="Minimalist",SHOW="false",B=0.184,HEIGHT=11,R=0.184,G=0.184,WIDTH=0.75}
HeadBar~d!9~
HeadBar~f~10!{A=1,TEXTURE="Minimalist",SHOW="false",B=0.184,HEIGHT=8,R=0.184,G=0.184,WIDTH=0.75}
HeadText~f~1!{A=0.7,B=1,OFFSET=0,R=1,FONT="Friz Quadrata TT",HEIGHT=10,G=1,OUTLINE=1}
HeadText~f~2!{A=0.68,R=0.424,OFFSET=0,B=0.424,FONT="Friz Quadrata TT",HEIGHT=10,G=0.424,OUTLINE=1}
HeadText~f~3!{A=0.26,B=0.984,OFFSET=0,R=0.984,FONT="Friz Quadrata TT",HEIGHT=10,G=0.984,OUTLINE=1}
HeadText~f~4!{A=0.68,B=0.424,OFFSET=0,R=0.424,FONT="Friz Quadrata TT",HEIGHT=10,G=0.424,OUTLINE=1}
HeadText~d!5~6~7~8~9~10~
HealBar~f~1!{HEIGHT=50,GRPCOLS="false",CMARGIN=0,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=192,RMARGIN=0,OFIX=1,NUMCOLS=2,LOWMANA=2}
HealBar~f~2!{HEIGHT=38,GRPCOLS="false",CMARGIN=0,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",NUMCOLS=4,RMARGIN=0,OFIX=1,WIDTH=95,LOWMANA=2}
HealBar~f~3!{HEIGHT=50,GRPCOLS="false",CMARGIN=0,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",NUMCOLS=2,RMARGIN=0,OFIX=1,WIDTH=192,LOWMANA=2}
HealBar~d!4~5~6~
HealBar~f~7!{HEIGHT=24,GRPCOLS="false",CMARGIN=0,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=75,RMARGIN=0,OFIX=1,NUMCOLS=5,LOWMANA=2}
HealBar~f~8!{HEIGHT=50,GRPCOLS="false",CMARGIN=0,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=192,RMARGIN=0,OFIX=1,NUMCOLS=2,LOWMANA=2}
HealBar~d!9~
HealBar~f~10!{HEIGHT=35,GRPCOLS="false",CMARGIN=0,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=129,RMARGIN=0,OFIX=1,NUMCOLS=3,LOWMANA=2}
BarCol~f~1!{BACK=2,BA=0.2,BB=0.051,DISA=0,BR=0.043,HB=0.086,BG=0.047,HR=0.086,HA=1,HG=0.086,ORA=0.32,BOUT=0,HLTH=3}
BarCol~d!2~3~4~5~6~7~8~9~
BarCol~f~10!{BACK=2,BA=0.2,BB=0.051,DISA=0,BR=0.043,HB=0,BG=0.047,HR=0.361,HA=1,HG=0,ORA=0.32,BOUT=0,HLTH=3}
BarIACol~f~1!{AC=4,AB=0.173,AA=0.45,AR=0.173,AG=0.173,IC=4,IB=0.129,IA=0.7,IR=0.129,IG=0.129}
BarIACol~d!2~3~4~5~6~7~8~9~
BarIACol~f~10!{AC=4,AB=0,AA=0.45,AR=0.675,AG=0,IC=4,IB=0,IA=0.7,IR=0.518,IG=0}
BarText~f~1!{HLTHONBAR="false",TAGOOR="OOR-",IGNOREONFULL="true",MAXCHARS=0,HMAXCHARS=0,HFONT="Friz Quadrata TT",HOFFSET=0,OFFSET=-5,HLTHTXTANCHOR=1,HLTHTYPE=1,HOUTLINE=1,INCHEALS=2,NUMFORMAT2=1,OVERHEAL=1,NUMFORMAT1=1,FONT="Friz Quadrata TT",TAGRIP="RIP-",HEIGHT=10,NAMEONBAR="true",SHOWROLE="true",HALIGN=2,CLASSONBAR="false",HHEIGHT=10,TAGDC="DC-",INCABSORBS=1,HOFFSET2=0,ALIGN=2,TAGR="R- ",OUTLINE=1}
BarText~d!2~3~4~5~6~7~8~9~10~
BarTextCol~f~1!{NCB=0.043,NDEBUFF="false",HLTH=2,NCDA=0.7,NCR=1,HCG=0.996,HCB=0.043,HCR=1,NCA=1,NCG=0.996,HCA=1,HDEBUFF="false",NAME=2,HCDA=0.7}
BarTextCol~f~2!{NAME=2,NCR=1,HCDA=0.7,NCDA=0.58,HCA=1,HCG=0.996,HCB=0.043,HCR=1,NCA=1,NCG=0.996,NDEBUFF="false",HDEBUFF="false",NCB=0.043,HLTH=2}
BarTextCol~d!3~4~5~6~7~8~9~10~
Icons~f~1!{RCEN="true",I15EN="true",CLASSEN="false",TARGETEN="true",BUFFFADE="false",DEBUFFANCHOR=1,RCVOFFSET=-10,OORVOFFSET=0,DEBUFFDOUBLE="false",TARGETVOFFSET=1,BUFFONBAR=1,SHOWDIR="false",SHOWRC="true",TARGETANCHOR=6,RCSCALE=0.55,MAXBICONS=8,TARGETHOFFSET=-10,FADESECS=15,RCHOFFSET=0,OORHOFFSET=0,CLASSONBAR=3,CLASSVOFFSET=2,TARGETSCALE=0.35,DSCALE=0.35,SCALE=0.35,TARGETONBAR=3,BUFFDOUBLE="false",OORONBAR=3,BUFFANCHOR=2,RCANCHOR=3,SHOWROLE="true",DEBUFFONBAR=1,RCONBAR=3,MAXDICONS=3,CLASSSCALE=0.35,CLASSHOFFSET=30,SHOWCLASS="false",CLASSANCHOR=5,DOUBLE="false",OORANCHOR=2,BUFFI15EN="true",BUFFFADESECS=15,OORSCALE=0.5,SHOWDIRMOUSE="false",OOREN="false",FADE="false"}
Icons~d!2~3~4~5~6~7~8~9~10~
RaidIcon~f~1!{SQUARE="true",CIRCLE="true",DIAMOND="true",SHOW="true",MOON="true",TRIANGLE="true",STAR="true",SKULL="true",CROSS="true"}
RaidIcon~d!2~3~4~5~6~7~8~9~10~
IconText~f~1!{DURWARN=2,BUFFHEIGHT=10,BUFFOUTLINE=2,BUFFDURTHRH=5,SCNT="true",DURTHRH=5,FONT="Friz Quadrata TT",BUFFFONT="Friz Quadrata TT",BUFFSCNT="true",SSCNT="false",BUFFSDUR="true",BUFFDURWARN=2,HEIGHT=10,BUFFSSCNT="false",BUFFSSDUR="true",SDUR="true",SSDUR="true",OUTLINE=2}
IconText~d!2~3~4~5~6~7~8~9~10~
BarVisibility~f~1!{INCCLASSES=1,ALERTIC=1,ALERTOC=0.95,HIDEOOR="false"}
BarVisibility~f~2!{INCCLASSES=1,ALERTIC=0.95,ALERTOC=0.85,HIDEOOR="false"}
BarVisibility~f~3!{INCCLASSES=1,ALERTIC=1,ALERTOC=0.95,HIDEOOR="false"}
BarVisibility~d!4~5~6~
BarVisibility~f~7!{INCCLASSES=1,ALERTIC=0.9,ALERTOC=0.75,HIDEOOR="true"}
BarVisibility~f~8!{INCCLASSES=1,ALERTIC=1,ALERTOC=0.95,HIDEOOR="false"}
BarVisibility~d!9~10~
BarSort~f~1!{SUBORDER=1,OORLAST="false",RAIDORDER=3,SUBPF="true"}
BarSort~f~2!{SUBORDER=1,OORLAST="false",RAIDORDER=2,SUBPF="true"}
BarSort~f~3!{SUBORDER=1,OORLAST="false",RAIDORDER=3,SUBPF="true"}
BarSort~d!4~5~6~7~8~9~10~
BarAggro~f~1!{B=0,ALERTIND=2,G=0,TEXTFORMAT=3,SHOW="true",SHOWTEXTPCT="false",R=1,SHOWTEXT="false",SHOWIND="false",ALERT=2}
BarAggro~d!2~3~4~5~6~7~8~9~10~
AuxBarFrame~f~1!{OVERLAP=1}
AuxBarFrame~d!2~3~4~5~6~7~8~9~10~
AuxBar^1~f~1!{SIZE=1,USE=5,R=0.518,COLOUR=3,ANCHOR=1,OFFSET=0,DEPTH=1,G=0,B=0,OTYPE=1}
AuxBar^1~d!2~3~4~5~6~7~8~9~
AuxBar^1~f~10!{SIZE=1,USE=1,R=0.518,COLOUR=3,ANCHOR=1,OFFSET=0,DEPTH=1,OTYPE=1,B=0,G=0}
AuxBar^2~f~1!{SIZE=1,USE=5,R=0.518,COLOUR=3,ANCHOR=2,OFFSET=0,DEPTH=1,G=0,B=0,OTYPE=1}
AuxBar^2~d!2~3~4~5~6~7~8~9~
AuxBar^2~f~10!{SIZE=1,USE=1,R=0.518,COLOUR=3,ANCHOR=2,OFFSET=0,DEPTH=1,OTYPE=1,B=0,G=0}
AuxBar^3~f~1!{SIZE=1,USE=5,R=0.518,COLOUR=3,ANCHOR=3,OFFSET=0,DEPTH=1,G=0,B=0,OTYPE=1}
AuxBar^3~d!2~3~4~5~6~7~8~9~
AuxBar^3~f~10!{SIZE=1,USE=1,R=0.518,COLOUR=3,ANCHOR=3,OFFSET=0,DEPTH=1,OTYPE=1,B=0,G=0}
AuxBar^4~f~1!{SIZE=1,USE=5,R=0.518,COLOUR=3,ANCHOR=4,OFFSET=0,DEPTH=1,G=0,B=0,OTYPE=1}
AuxBar^4~d!2~3~4~5~6~7~8~9~
AuxBar^4~f~10!{SIZE=1,USE=1,R=0.518,COLOUR=3,ANCHOR=4,OFFSET=0,DEPTH=1,G=0,B=0,OTYPE=1}
AuxBar^5~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=0,DEPTH=1,G=1,B=1,OTYPE=1}
AuxBar^5~d!2~3~4~5~6~7~8~9~10~
AuxBar^6~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,OTYPE=1}
AuxBar^6~d!2~3~4~5~6~7~8~9~10~
AuxBar^7~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,OTYPE=1}
AuxBar^7~d!2~3~4~5~6~7~8~9~10~
AuxBar^8~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,OTYPE=1}
AuxBar^8~d!2~3~4~5~6~7~8~9~10~
AuxBar^9~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,G=1,B=1,OTYPE=1}
AuxBar^9~d!2~3~4~5~6~7~8~9~10~
Complete!]]
HealBot_ExtraSkinData[58]=[[Skin
Dark Efficient 40
Author~v!Burbon of Mirage Raceway
DuplicateBars~v!true
Chat~t!{EOCOOM="false",EOCOOMV=20,MSG="Casting #s on #n",RESONLY="true",CHAN="",NOTIFY=1}
General~t!{OFREQ=0.07,STICKYSENSITIVITY=30,FLUIDBARS="false",FLUIDFREQ=10,HIDEPARTYF="false",OMIN=0.1,HIDERAIDF="true",HIDEBOSSF="true",STICKYFRAME="true",OMAX=0.95,HIDEPTF="false"}
Healing~t!{TINCRAID="true",TINCSELF="false",GROUPPETS="true",TARGETINCOMBAT=1,FALWAYSSHOW="false",FONLYFRIEND="false",FEXRAID="false",TONLYFRIEND="false",TINCGROUP="true",FOCUSINCOMBAT=2,TALWAYSSHOW="false",TINCPET="false",SELFPET=0,TEXRAID="false",ALERT=0.95}
Enemy~t!{ENEMYTARGET="false",INCTANKS="true",INCMYTAR="false",INCARENA="true",INCARENAPETS="false",ENEMYTARGETSIZE=40,INCSELF="false",NUMBOSS=4,EXISTSHOWPTAR=1,HIDE="true",EXISTSHOWBOSS="true",DOUBLEWIDTH="false",EXISTSHOWARENA=3}
FrameAlias~f~1!{SIZE=11,NAME="Tanks",R=0.714,ALIAS="Tanks",G=0.714,SHOW="true",OFFSET=-1,FONT="Friz Quadrata TT",A=1,B=0.714,OUTLINE=1}
FrameAlias~f~2!{A=1,NAME="Raid",R=0.714,ALIAS="Raid",G=0.714,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",SIZE=12,B=0.714,OUTLINE=1}
FrameAlias~f~3!{A=1,NAME="",R=0.714,ALIAS="Not Used 1",G=0.714,SHOW="true",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=0.714,OUTLINE=1}
FrameAlias~f~4!{A=1,NAME="",R=0.714,ALIAS="Not Used 2",G=0.714,SHOW="true",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=0.714,OUTLINE=1}
FrameAlias~f~5!{A=1,NAME="",R=0.714,ALIAS="Not Used 3",G=0.714,SHOW="true",OFFSET=10,FONT="Friz Quadrata TT",SIZE=12,B=0.714,OUTLINE=1}
FrameAlias~f~6!{SIZE=12,NAME="",R=0.714,ALIAS="Vehicle",G=0.714,SHOW="true",OFFSET=10,FONT="Friz Quadrata TT",A=1,B=0.714,OUTLINE=1}
FrameAlias~f~7!{A=1,NAME="Pets",R=0.714,ALIAS="Pets",G=0.714,SHOW="true",OFFSET=-1,FONT="Friz Quadrata TT",SIZE=11,B=0.714,OUTLINE=1}
FrameAlias~f~8!{A=1,NAME="Target",R=0.714,ALIAS="Target",G=0.714,SHOW="true",OFFSET=0,FONT="Friz Quadrata TT",SIZE=12,B=0.714,OUTLINE=1}
FrameAlias~f~9!{A=1,NAME="Focus",R=0.714,ALIAS="Focus",G=0.714,SHOW="true",OFFSET=0,FONT="Friz Quadrata TT",SIZE=12,B=0.714,OUTLINE=1}
FrameAlias~f~10!{A=1,NAME="Enemy",R=0.714,ALIAS="Enemy",G=0.714,SHOW="true",OFFSET=-1,FONT="Friz Quadrata TT",SIZE=11,B=0.714,OUTLINE=1}
FrameAliasBar~f~1!{A=0.75,WIDTH=0.99,B=0,HEIGHT=17,R=0,G=0,TEXTURE="HealBot 10"}
FrameAliasBar~f~2!{A=0.75,TEXTURE="HealBot 10",B=0,HEIGHT=15,R=0,G=0,WIDTH=0.99}
FrameAliasBar~d!3~4~5~6~
FrameAliasBar~f~7!{A=0.82,TEXTURE="HealBot 10",B=0,HEIGHT=17,R=0,G=0,WIDTH=0.99}
FrameAliasBar~f~8!{A=0.75,TEXTURE="HealBot 10",B=0,HEIGHT=15,R=0,G=0,WIDTH=0.99}
FrameAliasBar~d!9~
FrameAliasBar~f~10!{A=0.75,TEXTURE="HealBot 10",B=0,HEIGHT=17,R=0,G=0,WIDTH=0.99}
Frame~f~1!{BACKR=0.071,BORDERR=0.2,SFOFFSETH=0,SFOFFSETV=0,LOCKED="false",SCALE=1,BORDERA=1,BORDERG=0.2,AUTOCLOSE="false",BORDERB=0.2,BACKA=0.9,OPENSOUND="false",BACKB=0.071,BACKG=0.071,TIPLOC=2}
Frame~f~2!{SFOFFSETH=0,BORDERR=0.2,SFOFFSETV=3,AUTOCLOSE="false",LOCKED="true",SCALE=1,BORDERA=1,BORDERG=0.2,TIPLOC=2,BORDERB=0.2,BACKA=0.9,OPENSOUND="false",BACKB=0.071,BACKG=0.071,BACKR=0.071}
Frame~f~3!{SFOFFSETH=0,BORDERR=0.2,SFOFFSETV=0,AUTOCLOSE="false",LOCKED="false",SCALE=0.85,BORDERA=1,BORDERG=0.2,TIPLOC=4,BORDERB=0.2,BACKA=0.9,OPENSOUND="false",BACKB=0.071,BACKG=0.071,BACKR=0.071}
Frame~f~4!{SFOFFSETH=0,BORDERR=0.2,SFOFFSETV=0,AUTOCLOSE="false",LOCKED="false",SCALE=0.85,BORDERA=1,BORDERG=0.2,TIPLOC=2,BORDERB=0.2,BACKA=0.9,OPENSOUND="false",BACKB=0.071,BACKG=0.071,BACKR=0.071}
Frame~f~5!{SFOFFSETH=0,BORDERR=0.2,SFOFFSETV=0,AUTOCLOSE="false",LOCKED="false",SCALE=0.85,BORDERA=1,BORDERG=0.2,TIPLOC=4,BORDERB=0.2,BACKA=0.9,OPENSOUND="false",BACKB=0.071,BACKG=0.071,BACKR=0.071}
Frame~f~6!{SFOFFSETH=0,BORDERR=0.2,SFOFFSETV=0,AUTOCLOSE="false",LOCKED="true",SCALE=0.85,BORDERA=1,BORDERG=0.2,TIPLOC=1,BORDERB=0.2,BACKA=0.9,OPENSOUND="false",BACKB=0.071,BACKG=0.071,BACKR=0.071}
Frame~f~7!{BACKR=0.071,BORDERR=0.2,SFOFFSETH=0,SFOFFSETV=3,LOCKED="false",SCALE=1,BORDERA=1,BORDERG=0.2,AUTOCLOSE="false",BORDERB=0.2,BACKA=0.9,OPENSOUND="false",BACKB=0.071,BACKG=0.071,TIPLOC=5}
Frame~f~8!{SFOFFSETH=0,BACKR=0.071,SFOFFSETV=0,TIPLOC=3,LOCKED="true",OPENSOUND="false",BORDERA=1,BORDERG=0.2,AUTOCLOSE="false",BACKB=0.071,BACKA=0.9,SCALE=1,BORDERB=0.2,BACKG=0.071,BORDERR=0.2}
Frame~d!9~
Frame~f~10!{BACKR=0.071,BORDERR=0.2,SFOFFSETH=0,SFOFFSETV=-3,LOCKED="true",SCALE=1,BORDERA=1,BORDERG=0.2,AUTOCLOSE="false",BORDERB=0.2,BACKA=0.9,OPENSOUND="false",BACKB=0.071,BACKG=0.071,TIPLOC=4}
StickyFrames~f~1!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~f~2!{STUCK="true",STUCKTOPOINT="BOTTOMRIGHT",STUCKTO=1,STUCKPOINT="TOPRIGHT"}
StickyFrames~f~3!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~d!4~5~6~
StickyFrames~f~7!{STUCK="true",STUCKTOPOINT="BOTTOMLEFT",STUCKTO=2,STUCKPOINT="TOPLEFT"}
StickyFrames~f~8!{STUCK="true",STUCKTOPOINT="TOPLEFT",STUCKTO=1,STUCKPOINT="TOPRIGHT"}
StickyFrames~f~9!{STUCK="true",STUCKTOPOINT="TOPRIGHT",STUCKTO=1,STUCKPOINT="TOPLEFT"}
StickyFrames~f~10!{STUCK="true",STUCKTOPOINT="TOPLEFT",STUCKTO=1,STUCKPOINT="BOTTOMLEFT"}
HealGroups~f~1!{FRAME=1,STATE="true",NAME="Main tanks"}
HealGroups~f~2!{FRAME=2,STATE="false",NAME="Self"}
HealGroups~f~3!{FRAME=2,STATE="false",NAME="Healers"}
HealGroups~f~4!{FRAME=2,STATE="false",NAME="Group"}
HealGroups~f~5!{FRAME=2,STATE="false",NAME="Private List"}
HealGroups~f~6!{FRAME=2,STATE="true",NAME="Raid"}
HealGroups~f~7!{FRAME=6,STATE="false",NAME="Vehicle"}
HealGroups~f~8!{FRAME=7,STATE="true",NAME="Pets"}
HealGroups~f~9!{FRAME=8,STATE="false",NAME="Target"}
HealGroups~f~10!{FRAME=9,STATE="false",NAME="Focus"}
HealGroups~f~11!{FRAME=10,STATE="true",NAME="Enemy"}
Anchors~f~1!{Y=70.3,GROW=2,BARS=1,FRAME=1,X=78.33}
Anchors~f~2!{Y=62.6,GROW=2,BARS=3,FRAME=3,X=92.43}
Anchors~f~3!{Y=60.68,GROW=2,BARS=1,FRAME=4,X=88.59}
Anchors~f~4!{Y=39.37,GROW=2,BARS=1,FRAME=3,X=7.52}
Anchors~f~5!{Y=56.81,GROW=2,BARS=1,FRAME=4,X=21.87}
Anchors~f~6!{Y=34.62,GROW=2,BARS=1,FRAME=2,X=34.81}
Anchors~f~7!{Y=55.74,GROW=2,BARS=1,FRAME=1,X=88.64}
Anchors~f~8!{Y=60.99,GROW=2,BARS=1,FRAME=3,X=92.43}
Anchors~f~9!{Y=72.36,GROW=2,BARS=1,FRAME=1,X=73.06}
Anchors~f~10!{Y=71.48,GROW=2,BARS=3,FRAME=2,X=78.33}
HeadBar~f~1!{A=1,WIDTH=0.75,SHOW="false",B=0.184,HEIGHT=17,R=0.184,G=0.184,TEXTURE="Minimalist"}
HeadBar~f~2!{SHOW="true",TEXTURE="HealBot 10",A=0.77,B=0,HEIGHT=17,R=0,G=0,WIDTH=0.99}
HeadBar~f~3!{SHOW="true",TEXTURE="Minimalist",A=1,B=0.184,HEIGHT=15,R=0.184,G=0.184,WIDTH=0.75}
HeadBar~f~4!{SHOW="false",TEXTURE="Minimalist",A=1,B=0.184,HEIGHT=11,R=0.184,G=0.184,WIDTH=0.75}
HeadBar~f~5!{A=1,WIDTH=0.75,SHOW="false",B=0.184,HEIGHT=12,R=0.184,G=0.184,TEXTURE="Minimalist"}
HeadBar~f~6!{A=1,WIDTH=0.75,SHOW="false",B=0.184,HEIGHT=8,R=0.184,G=0.184,TEXTURE="Minimalist"}
HeadBar~d!7~
HeadBar~f~8!{A=1,WIDTH=0.75,SHOW="false",B=0.184,HEIGHT=11,R=0.184,G=0.184,TEXTURE="Minimalist"}
HeadBar~d!9~
HeadBar~f~10!{A=1,WIDTH=0.75,SHOW="false",B=0.184,HEIGHT=8,R=0.184,G=0.184,TEXTURE="Minimalist"}
HeadText~f~1!{A=0.7,R=1,OFFSET=0,B=1,FONT="Friz Quadrata TT",HEIGHT=10,G=1,OUTLINE=1}
HeadText~f~2!{A=0.82,B=0.71,OFFSET=0,R=0.71,FONT="Friz Quadrata TT",HEIGHT=11,G=0.71,OUTLINE=1}
HeadText~f~3!{A=0.26,R=0.984,OFFSET=0,B=0.984,FONT="Friz Quadrata TT",HEIGHT=10,G=0.984,OUTLINE=1}
HeadText~f~4!{A=0.68,R=0.424,OFFSET=0,B=0.424,FONT="Friz Quadrata TT",HEIGHT=10,G=0.424,OUTLINE=1}
HeadText~d!5~6~7~8~9~10~
HealBar~f~1!{HEIGHT=40,GRPCOLS="false",CMARGIN=0,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=2,NUMCOLS=2,OFIX=1,RMARGIN=0,WIDTH=192}
HealBar~f~2!{HEIGHT=38,GRPCOLS="false",CMARGIN=0,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=2,WIDTH=95,OFIX=1,RMARGIN=0,NUMCOLS=2}
HealBar~f~3!{HEIGHT=50,GRPCOLS="false",CMARGIN=0,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=2,WIDTH=192,OFIX=1,RMARGIN=0,NUMCOLS=2}
HealBar~d!4~5~6~
HealBar~f~7!{HEIGHT=24,GRPCOLS="false",CMARGIN=0,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=2,NUMCOLS=5,OFIX=1,RMARGIN=0,WIDTH=75}
HealBar~f~8!{HEIGHT=50,GRPCOLS="false",CMARGIN=0,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=2,NUMCOLS=2,OFIX=1,RMARGIN=0,WIDTH=192}
HealBar~d!9~
HealBar~f~10!{HEIGHT=32,GRPCOLS="false",CMARGIN=0,TEXTURE="Tukui",POWERCNT="true",LOWMANACOMBAT="true",LOWMANA=2,NUMCOLS=3,OFIX=1,RMARGIN=0,WIDTH=129}
BarCol~f~1!{BACK=2,BA=0.2,BOUT=0,DISA=0,BR=0.043,HB=0.086,BG=0.047,BB=0.051,HA=1,HG=0.086,ORA=0.32,HR=0.086,HLTH=3}
BarCol~d!2~3~4~5~6~7~8~9~
BarCol~f~10!{BACK=2,BA=0.2,BOUT=0,DISA=0,BR=1,HB=0,BG=1,BB=1,HA=1,HG=0,ORA=0.32,HR=0.361,HLTH=3}
BarIACol~f~1!{AC=4,AB=0.173,AA=0.55,AR=0.173,AG=0.173,IC=4,IB=0.129,IA=0.75,IR=0.129,IG=0.129}
BarIACol~d!2~3~4~5~6~7~8~9~
BarIACol~f~10!{AC=4,AB=0,AA=0.55,AR=0.675,AG=0,IC=4,IB=0,IA=0.75,IR=0.518,IG=0}
BarText~f~1!{HLTHONBAR="false",TAGOOR="OOR-",OVERHEAL=1,MAXCHARS=0,CLASSONBAR="false",OUTLINE=1,HOFFSET=0,OFFSET=-5,HLTHTXTANCHOR=1,HLTHTYPE=1,INCHEALS=2,HMAXCHARS=0,NUMFORMAT2=1,IGNOREONFULL="true",NUMFORMAT1=1,TAGDC="DC-",NAMEONBAR="true",HEIGHT=10,TAGRIP="RIP-",SHOWROLE="true",HALIGN=2,HHEIGHT=10,FONT="Friz Quadrata TT",HOUTLINE=1,INCABSORBS=1,HOFFSET2=0,ALIGN=2,TAGR="R- ",HFONT="Friz Quadrata TT"}
BarText~d!2~3~4~5~6~7~8~9~10~
BarTextCol~f~1!{NAME=2,NCR=1,HCDA=0.7,NCDA=0.7,HCG=0.996,NDEBUFF="false",HCB=0.043,HCR=1,HCA=1,NCG=0.996,NCA=1,HDEBUFF="false",NCB=0.043,HLTH=2}
BarTextCol~f~2!{NCB=0.043,HCA=1,HLTH=2,NCDA=0.58,HCG=0.996,NCR=1,HCB=0.043,HCR=1,NDEBUFF="false",NCG=0.996,NCA=1,HDEBUFF="false",NAME=2,HCDA=0.7}
BarTextCol~d!3~4~5~6~7~8~9~10~
Icons~f~1!{RCEN="true",I15EN="true",CLASSEN="false",SHOWDIRMOUSE="false",BUFFFADE="false",DEBUFFANCHOR=1,RCVOFFSET=-10,OORVOFFSET=0,DEBUFFDOUBLE="false",TARGETVOFFSET=1,BUFFONBAR=1,SHOWDIR="false",SHOWRC="true",TARGETANCHOR=6,RCSCALE=0.55,MAXBICONS=8,TARGETSCALE=0.35,FADESECS=15,RCHOFFSET=0,TARGETHOFFSET=-10,CLASSONBAR=3,CLASSVOFFSET=2,OORHOFFSET=0,DSCALE=0.3,BUFFDOUBLE="false",OORONBAR=3,SCALE=0.3,TARGETONBAR=3,FADE="false",RCANCHOR=3,CLASSSCALE=0.35,DOUBLE="false",RCONBAR=3,MAXDICONS=3,OORANCHOR=2,CLASSANCHOR=5,SHOWCLASS="false",CLASSHOFFSET=30,DEBUFFONBAR=1,SHOWROLE="true",BUFFI15EN="true",BUFFFADESECS=15,OORSCALE=0.5,TARGETEN="true",OOREN="false",BUFFANCHOR=2}
Icons~d!2~
Icons~f~3!{RCEN="true",I15EN="true",CLASSEN="false",FADE="false",BUFFFADE="false",DEBUFFANCHOR=1,RCVOFFSET=-10,OORVOFFSET=0,SHOWCLASS="false",TARGETVOFFSET=1,BUFFONBAR=1,SHOWDIR="false",SHOWRC="true",TARGETANCHOR=6,RCSCALE=0.55,MAXBICONS=8,SHOWROLE="true",FADESECS=15,RCHOFFSET=0,TARGETHOFFSET=-10,CLASSONBAR=3,CLASSVOFFSET=2,OORHOFFSET=0,DSCALE=0.35,RCANCHOR=3,SCALE=0.35,BUFFDOUBLE="false",TARGETONBAR=3,SHOWDIRMOUSE="false",TARGETEN="true",OORONBAR=3,DEBUFFONBAR=1,RCONBAR=3,MAXDICONS=3,CLASSSCALE=0.35,CLASSANCHOR=5,BUFFANCHOR=2,CLASSHOFFSET=30,DOUBLE="false",OORANCHOR=2,BUFFI15EN="true",BUFFFADESECS=15,OORSCALE=0.5,TARGETSCALE=0.35,OOREN="false",DEBUFFDOUBLE="false"}
Icons~d!4~5~6~7~8~9~10~
RaidIcon~f~1!{SQUARE="true",CIRCLE="true",DIAMOND="true",SHOW="true",SKULL="true",TRIANGLE="true",STAR="true",CROSS="true",MOON="true"}
RaidIcon~d!2~3~4~5~6~7~8~9~10~
IconText~f~1!{DURWARN=2,BUFFHEIGHT=10,BUFFOUTLINE=2,BUFFDURTHRH=5,SCNT="true",DURTHRH=5,FONT="Friz Quadrata TT",BUFFFONT="Friz Quadrata TT",BUFFSCNT="true",SSCNT="false",OUTLINE=2,BUFFDURWARN=2,HEIGHT=10,SDUR="true",BUFFSSDUR="true",BUFFSSCNT="false",SSDUR="true",BUFFSDUR="true"}
IconText~d!2~3~4~5~6~7~8~9~10~
BarVisibility~f~1!{INCCLASSES=1,ALERTIC=0.98,ALERTOC=0.95,HIDEOOR="false"}
BarVisibility~f~2!{INCCLASSES=1,ALERTIC=0.95,ALERTOC=0.85,HIDEOOR="false"}
BarVisibility~f~3!{INCCLASSES=1,ALERTIC=1,ALERTOC=0.95,HIDEOOR="false"}
BarVisibility~d!4~5~6~
BarVisibility~f~7!{INCCLASSES=1,ALERTIC=0.9,ALERTOC=0.75,HIDEOOR="true"}
BarVisibility~f~8!{INCCLASSES=1,ALERTIC=1,ALERTOC=0.95,HIDEOOR="false"}
BarVisibility~d!9~10~
BarSort~f~1!{SUBORDER=1,OORLAST="false",RAIDORDER=3,SUBPF="true"}
BarSort~d!2~3~4~5~6~7~8~9~10~
BarAggro~f~1!{R=1,ALERTIND=2,G=0,TEXTFORMAT=3,SHOW="true",SHOWTEXTPCT="false",B=0,SHOWIND="false",SHOWTEXT="false",ALERT=2}
BarAggro~d!2~3~4~5~6~7~8~9~10~
AuxBarFrame~f~1!{OVERLAP=1}
AuxBarFrame~d!2~3~4~5~6~7~8~9~10~
AuxBar^1~f~1!{SIZE=1,USE=5,R=0.518,COLOUR=3,ANCHOR=1,OFFSET=0,DEPTH=1,OTYPE=1,B=0,G=0}
AuxBar^1~d!2~3~4~5~6~7~8~9~
AuxBar^1~f~10!{SIZE=1,USE=1,R=0.518,COLOUR=3,ANCHOR=1,OFFSET=0,DEPTH=1,G=0,B=0,OTYPE=1}
AuxBar^2~f~1!{SIZE=1,USE=5,R=0.518,COLOUR=3,ANCHOR=2,OFFSET=0,DEPTH=1,OTYPE=1,B=0,G=0}
AuxBar^2~d!2~3~4~5~6~7~8~9~
AuxBar^2~f~10!{SIZE=1,USE=1,R=0.518,COLOUR=3,ANCHOR=2,OFFSET=0,DEPTH=1,G=0,B=0,OTYPE=1}
AuxBar^3~f~1!{SIZE=1,USE=5,R=0.518,COLOUR=3,ANCHOR=3,OFFSET=0,DEPTH=1,OTYPE=1,B=0,G=0}
AuxBar^3~d!2~3~4~5~6~7~8~9~
AuxBar^3~f~10!{SIZE=1,USE=1,R=0.518,COLOUR=3,ANCHOR=3,OFFSET=0,DEPTH=1,G=0,B=0,OTYPE=1}
AuxBar^4~f~1!{SIZE=1,USE=5,R=0.518,COLOUR=3,ANCHOR=4,OFFSET=0,DEPTH=1,OTYPE=1,B=0,G=0}
AuxBar^4~d!2~3~4~5~6~7~8~9~
AuxBar^4~f~10!{SIZE=1,USE=1,R=0.518,COLOUR=3,ANCHOR=4,OFFSET=0,DEPTH=1,OTYPE=1,B=0,G=0}
AuxBar^5~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=0,DEPTH=1,OTYPE=1,B=1,G=1}
AuxBar^5~d!2~3~4~5~6~7~8~9~10~
AuxBar^6~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,OTYPE=1,B=1,G=1}
AuxBar^6~d!2~3~4~5~6~7~8~9~10~
AuxBar^7~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,OTYPE=1,B=1,G=1}
AuxBar^7~d!2~3~4~5~6~7~8~9~10~
AuxBar^8~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,OTYPE=1,B=1,G=1}
AuxBar^8~d!2~3~4~5~6~7~8~9~10~
AuxBar^9~f~1!{SIZE=0.98,USE=1,R=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,OTYPE=1,B=1,G=1}
AuxBar^9~d!2~3~4~5~6~7~8~9~10~
Complete!]]
HealBot_ExtraSkinData[59]=[[Skin
Mirandinn Party
Author~v!Mirandinn of Proudmoore
DuplicateBars~v!false
Chat~t!{EOCOOM="false",EOCOOMV=20,MSG="Casting #s on #n",RESONLY="true",NOTIFY=1}
General~t!{HIDEBOSSF="false",STICKYSENSITIVITY=20,FLUIDBARS="true",HIDEPTF="false",HIDEPARTYF="true",OMAX=0.95,HIDERAIDF="true",FLUIDFREQ=10,STICKYFRAME="true",OMIN=0.1,OFREQ=0.07}
Healing~t!{TONLYFRIEND="false",TARGETINCOMBAT=2,FOCUSINCOMBAT=2,GROUPPETS="true",FEXRAID="false",FONLYFRIEND="false",TEXRAID="false",SELFPET="false"}
Enemy~t!{ENEMYTARGET="false",INCTANKS="true",INCMYTAR="false",INCARENA="true",INCARENAPETS="false",ENEMYTARGETSIZE=40,HIDE="true",NUMBOSS=2,EXISTSHOWPTAR=1,INCSELF="false",EXISTSHOWBOSS="true",DOUBLEWIDTH="false",EXISTSHOWARENA=3}
FrameAlias~f~1!{SIZE=12,NAME="",R=1,ALIAS="Frame 1",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~d!2~3~4~5~
FrameAlias~f~6!{SIZE=12,NAME="Vehicle",R=1,ALIAS="Vehicle",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~7!{SIZE=12,NAME="Pets",R=1,ALIAS="Pets",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~8!{SIZE=12,NAME="Target",R=1,ALIAS="Target",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~9!{SIZE=12,NAME="Focus",R=1,ALIAS="Focus",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~10!{SIZE=12,NAME="Enemy",R=1,ALIAS="Enemy",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAliasBar~f~1!{A=0.25,TEXTURE="Diagonal",B=0.1,HEIGHT=20,R=0.1,G=0.1,WIDTH=0.9}
FrameAliasBar~d!2~3~4~5~6~7~8~9~10~
Frame~f~1!{BACKR=0.1,AUTOCLOSE="false",BACKG=0.1,BACKB=0.5,LOCKED="true",SCALE=1,BORDERA=0,SFOFFSETV=0,TIPLOC=4,BORDERB=0.1,BACKA=0.2,OPENSOUND="false",BORDERG=0.1,BORDERR=0.1,SFOFFSETH=0}
Frame~f~2!{BACKR=0.1,AUTOCLOSE="false",BACKG=0.1,BACKB=0.5,LOCKED="false",SCALE=1,BORDERA=0,SFOFFSETV=0,TIPLOC=5,BORDERB=0.1,BACKA=0.2,OPENSOUND="false",BORDERG=0.1,BORDERR=0.1,SFOFFSETH=0}
Frame~d!3~4~5~6~
Frame~f~7!{BACKR=0.1,AUTOCLOSE="false",BACKG=0.1,BACKB=0.5,LOCKED="true",SCALE=1,BORDERA=0,SFOFFSETV=0,TIPLOC=4,BORDERB=0.1,BACKA=0.2,OPENSOUND="false",BORDERG=0.1,BORDERR=0.1,SFOFFSETH=-8}
Frame~f~8!{BACKR=0.1,AUTOCLOSE="false",BACKG=0.1,BACKB=0.5,LOCKED="true",SCALE=1,BORDERA=0,SFOFFSETV=0,TIPLOC=2,BORDERB=0.1,BACKA=0.2,OPENSOUND="false",BORDERG=0.1,BORDERR=0.1,SFOFFSETH=9}
Frame~f~9!{BACKR=0.1,AUTOCLOSE="false",BACKG=0.1,BACKB=0.5,LOCKED="true",SCALE=1,BORDERA=0,SFOFFSETV=9,TIPLOC=2,BORDERB=0.1,BACKA=0.2,OPENSOUND="false",BORDERG=0.1,BORDERR=0.1,SFOFFSETH=0}
Frame~f~10!{BACKR=0.1,AUTOCLOSE="false",BACKG=0.1,BACKB=0.5,LOCKED="false",SCALE=1,BORDERA=0,SFOFFSETV=0,TIPLOC=5,BORDERB=0.1,BACKA=0.2,OPENSOUND="false",BORDERG=0.1,BORDERR=0.1,SFOFFSETH=0}
StickyFrames~f~1!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~d!2~3~4~5~6~
StickyFrames~f~7!{STUCK="true",STUCKTOPOINT="TOPRIGHT",STUCKTO=1,STUCKPOINT="TOPLEFT"}
StickyFrames~f~8!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~f~9!{STUCK="true",STUCKTOPOINT="BOTTOMRIGHT",STUCKTO=8,STUCKPOINT="TOPRIGHT"}
StickyFrames~f~10!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
HealGroups~f~1!{FRAME=1,STATE="false",NAME="Self"}
HealGroups~f~2!{FRAME=1,STATE="true",NAME="Main tanks"}
HealGroups~f~3!{FRAME=1,STATE="false",NAME="Healers"}
HealGroups~f~4!{FRAME=1,STATE="true",NAME="Group"}
HealGroups~f~5!{FRAME=1,STATE="false",NAME="Raid"}
HealGroups~f~6!{FRAME=1,STATE="false",NAME="Private List"}
HealGroups~f~7!{FRAME=6,STATE="false",NAME="Vehicle"}
HealGroups~f~8!{FRAME=7,STATE="false",NAME="Pets"}
HealGroups~f~9!{FRAME=8,STATE="false",NAME="Target"}
HealGroups~f~10!{FRAME=9,STATE="false",NAME="Focus"}
HealGroups~f~11!{FRAME=10,STATE="false",NAME="Enemy"}
Anchors~f~1!{Y=51.77,GROW=2,BARS=1,FRAME=1,X=25.59}
Anchors~f~2!{Y=55.66,GROW=2,BARS=1,FRAME=1,X=25.59}
Anchors~f~3!{Y=52,GROW=2,BARS=1,FRAME=1,X=52}
Anchors~f~4!{Y=53,GROW=2,BARS=1,FRAME=1,X=53}
Anchors~f~5!{Y=54,GROW=2,BARS=1,FRAME=1,X=54}
Anchors~f~6!{Y=55,GROW=2,BARS=1,FRAME=1,X=55}
Anchors~f~7!{Y=69,GROW=2,BARS=1,FRAME=1,X=87.6}
Anchors~f~8!{Y=31,GROW=2,BARS=1,FRAME=1,X=88}
Anchors~f~9!{Y=28,GROW=2,BARS=1,FRAME=1,X=88}
Anchors~f~10!{Y=59,GROW=2,BARS=1,FRAME=1,X=59}
HeadBar~f~1!{SHOW="false",TEXTURE="Diagonal",R=0.1,B=0.1,HEIGHT=20,A=0.25,G=0.1,WIDTH=0.9}
HeadBar~d!2~3~4~5~6~7~8~9~10~
HeadText~f~1!{A=0.7,R=1,OFFSET=0,B=0.1,FONT="Friz Quadrata TT",HEIGHT=10,G=1,OUTLINE=1}
HeadText~d!2~3~4~5~6~7~8~9~10~
HealBar~f~1!{HEIGHT=45,GRPCOLS="false",CMARGIN=4,TEXTURE="Smooth",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=180,RMARGIN=0,OFIX=1,NUMCOLS=1,LOWMANA=2}
HealBar~f~2!{HEIGHT=34,GRPCOLS="false",CMARGIN=4,TEXTURE="HealBot 10",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=158,RMARGIN=0,OFIX=1,NUMCOLS=1,LOWMANA=2}
HealBar~d!3~4~5~6~
HealBar~f~7!{HEIGHT=34,GRPCOLS="false",CMARGIN=4,TEXTURE="HealBot 10",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=78,RMARGIN=0,OFIX=1,NUMCOLS=2,LOWMANA=2}
HealBar~f~8!{HEIGHT=34,GRPCOLS="false",CMARGIN=4,TEXTURE="HealBot 10",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=158,RMARGIN=0,OFIX=1,NUMCOLS=1,LOWMANA=2}
HealBar~d!9~10~
BarCol~f~1!{BACK=3,BA=0.75,BOUT=0,DISA=0.1,BR=0,HB=1,BB=0,HG=1,HA=1,HR=1,ORA=0.4,BG=0,HLTH=2}
BarCol~f~2!{BACK=1,BA=0.1,BOUT=0,DISA=0.05,BR=1,HB=1,BB=1,HG=1,HA=0.98,HR=1,ORA=0.35,BG=1,HLTH=2}
BarCol~f~3!{BACK=1,BA=0.1,BOUT=0,DISA=0.05,BR=1,HB=1,BB=1,HG=1,HA=0.98,HR=1,ORA=0.35,BG=1,HLTH=1}
BarCol~d!4~5~6~
BarCol~f~7!{BACK=1,BA=0.1,BOUT=0,DISA=0.05,BR=1,HB=0.8,BB=1,HG=0.8,HA=0.98,HR=0.7,ORA=0.35,BG=1,HLTH=3}
BarCol~f~8!{BACK=1,BA=0.1,BOUT=0,DISA=0.05,BR=1,HB=1,BB=1,HG=1,HA=0.98,HR=1,ORA=0.35,BG=1,HLTH=2}
BarCol~d!9~10~
BarIACol~f~1!{AC=3,AB=0.9,AA=0.78,AR=0.6,AG=0.7,IC=1,IB=0.4,IA=0.82,IR=0.4,IG=1}
BarIACol~f~2!{AC=4,AB=0.9,AA=0.7,AR=0.6,AG=0.7,IC=2,IB=0.4,IA=0.7,IR=0.4,IG=1}
BarIACol~d!3~4~5~6~7~8~9~10~
BarText~f~1!{HHEIGHT=10,TAGOOR="[ OOR ] ",IGNOREONFULL="true",MAXCHARS=0,CLASSONBAR="false",HFONT="Friz Quadrata TT",HLTHTYPE=3,INCHEALS=1,HLTHTXTANCHOR=1,FONT="Friz Quadrata TT",OUTLINE=1,OVERHEAL=1,NUMFORMAT2=1,HMAXCHARS=0,TAGDC="[ DC ] ",HLTHONBAR="true",TAGRIP="[ RIP ] ",HEIGHT=13,NAMEONBAR="true",SHOWROLE="true",HALIGN=2,HOUTLINE=1,NUMFORMAT1=11,OFFSET=0,INCABSORBS=1,HOFFSET2=0,ALIGN=1,TAGR="[ R ] ",HOFFSET=0}
BarText~f~2!{HHEIGHT=10,TAGOOR="[ OOR ] ",IGNOREONFULL="true",MAXCHARS=0,CLASSONBAR="false",HFONT="Friz Quadrata TT",HLTHTYPE=3,INCHEALS=2,HLTHTXTANCHOR=1,FONT="Friz Quadrata TT",OUTLINE=1,OVERHEAL=1,NUMFORMAT2=1,HMAXCHARS=0,TAGDC="[ DC ] ",HLTHONBAR="true",TAGRIP="[ RIP ] ",HEIGHT=13,NAMEONBAR="true",SHOWROLE="true",HALIGN=2,HOUTLINE=1,NUMFORMAT1=11,OFFSET=0,INCABSORBS=1,HOFFSET2=0,ALIGN=1,TAGR="[ R ] ",HOFFSET=0}
BarText~d!3~4~5~6~7~8~9~10~
BarTextCol~f~1!{NCB=0.937,NDEBUFF="false",HLTH=3,NCDA=0.8,NCR=0.898,HCG=1,NCG=1,HCR=0.898,NCA=1,HCB=0.937,HCA=1,HDEBUFF="false",NAME=3,HCDA=0.8}
BarTextCol~d!2~3~4~5~6~7~8~9~10~
Icons~f~1!{RCEN="false",I15EN="true",CLASSEN="false",FADE="true",BUFFFADE="true",DEBUFFANCHOR=1,RCVOFFSET=0,OORVOFFSET=0,DEBUFFDOUBLE="true",TARGETVOFFSET=0,BUFFONBAR=1,SHOWDIR="false",SHOWRC="true",TARGETANCHOR=1,RCSCALE=0.5,MAXBICONS=8,FADESECS=15,RCHOFFSET=0,TARGETHOFFSET=0,RCANCHOR=1,CLASSVOFFSET=0,OORHOFFSET=0,DSCALE=1,SHOWCLASS="true",TARGETEN="false",BUFFDOUBLE="true",TARGETONBAR=1,TARGETSCALE=0.5,BUFFANCHOR=2,CLASSONBAR=1,CLASSSCALE=0.5,RCONBAR=1,MAXDICONS=4,OORANCHOR=1,SHOWDIRMOUSE="false",CLASSANCHOR=1,CLASSHOFFSET=0,DEBUFFONBAR=1,OORONBAR=3,BUFFI15EN="true",BUFFFADESECS=15,OORSCALE=0.5,SCALE=1,OOREN="false",SHOWROLE="true"}
Icons~f~2!{RCEN="false",I15EN="true",CLASSEN="false",FADE="true",BUFFFADE="true",DEBUFFANCHOR=1,RCVOFFSET=0,OORVOFFSET=0,DEBUFFDOUBLE="true",TARGETVOFFSET=0,BUFFONBAR=1,SHOWDIR="false",SHOWRC="true",TARGETANCHOR=1,RCSCALE=0.5,MAXBICONS=8,FADESECS=15,RCHOFFSET=0,TARGETHOFFSET=0,RCANCHOR=1,CLASSVOFFSET=0,OORHOFFSET=0,DSCALE=1,TARGETEN="false",SCALE=1,BUFFDOUBLE="true",OORONBAR=3,TARGETSCALE=0.5,SHOWCLASS="false",BUFFANCHOR=2,CLASSSCALE=0.5,RCONBAR=1,MAXDICONS=4,OORANCHOR=1,SHOWROLE="false",CLASSANCHOR=1,CLASSHOFFSET=0,DEBUFFONBAR=1,CLASSONBAR=1,BUFFI15EN="true",BUFFFADESECS=15,OORSCALE=0.5,TARGETONBAR=1,OOREN="false",SHOWDIRMOUSE="false"}
Icons~d!3~4~5~6~
Icons~f~7!{RCEN="false",I15EN="true",CLASSEN="false",FADE="true",BUFFFADE="true",DEBUFFANCHOR=1,RCVOFFSET=0,OORVOFFSET=0,DEBUFFDOUBLE="true",TARGETVOFFSET=0,BUFFONBAR=1,SHOWDIR="false",SHOWRC="true",TARGETANCHOR=1,RCSCALE=0.5,MAXBICONS=4,FADESECS=15,RCHOFFSET=0,TARGETHOFFSET=0,RCANCHOR=1,CLASSVOFFSET=0,OORHOFFSET=0,DSCALE=1,TARGETEN="false",SCALE=1,BUFFDOUBLE="true",OORONBAR=3,TARGETSCALE=0.5,SHOWCLASS="false",BUFFANCHOR=2,CLASSSCALE=0.5,RCONBAR=1,MAXDICONS=2,OORANCHOR=1,SHOWROLE="false",CLASSANCHOR=1,CLASSHOFFSET=0,DEBUFFONBAR=1,CLASSONBAR=1,BUFFI15EN="true",BUFFFADESECS=15,OORSCALE=0.5,TARGETONBAR=1,OOREN="false",SHOWDIRMOUSE="false"}
Icons~f~8!{RCEN="false",I15EN="true",CLASSEN="false",FADE="true",BUFFFADE="true",DEBUFFANCHOR=1,RCVOFFSET=0,OORVOFFSET=0,DEBUFFDOUBLE="true",TARGETVOFFSET=0,BUFFONBAR=1,SHOWDIR="false",SHOWRC="true",TARGETANCHOR=1,RCSCALE=0.5,MAXBICONS=8,FADESECS=15,RCHOFFSET=0,TARGETHOFFSET=0,RCANCHOR=1,CLASSVOFFSET=0,OORHOFFSET=0,DSCALE=1,TARGETEN="false",SCALE=1,BUFFDOUBLE="true",OORONBAR=3,TARGETSCALE=0.5,SHOWCLASS="false",BUFFANCHOR=2,CLASSSCALE=0.5,RCONBAR=1,MAXDICONS=4,OORANCHOR=1,SHOWROLE="false",CLASSANCHOR=1,CLASSHOFFSET=0,DEBUFFONBAR=1,CLASSONBAR=1,BUFFI15EN="true",BUFFFADESECS=15,OORSCALE=0.5,TARGETONBAR=1,OOREN="false",SHOWDIRMOUSE="false"}
Icons~d!9~10~
RaidIcon~f~1!{SQUARE="true",CIRCLE="true",DIAMOND="true",SHOW="true",MOON="true",TRIANGLE="true",STAR="true",CROSS="true",SKULL="true"}
RaidIcon~d!2~3~4~5~6~7~8~9~10~
IconText~f~1!{SDUR="true",BUFFHEIGHT=10,BUFFOUTLINE=2,BUFFDURTHRH=9,SCNT="true",DURTHRH=9,FONT="Friz Quadrata TT",BUFFFONT="Friz Quadrata TT",BUFFSCNT="true",SSCNT="false",OUTLINE=2,BUFFDURWARN=3,BUFFSSCNT="false",HEIGHT=10,BUFFSSDUR="true",DURWARN=3,SSDUR="true",BUFFSDUR="true"}
IconText~d!2~3~4~5~6~7~8~9~10~
BarVisibility~f~1!{INCCLASSES=1,ALERTIC=1,ALERTOC=1,HIDEOOR="false"}
BarVisibility~f~2!{INCCLASSES=1,ALERTIC=1,ALERTOC=0.95,HIDEOOR="false"}
BarVisibility~d!3~4~5~6~7~8~9~10~
BarSort~f~1!{SUBORDER=1,OORLAST="false",RAIDORDER=3,SUBPF="true"}
BarSort~d!2~3~4~5~6~7~8~9~10~
BarAggro~f~1!{B=0,ALERTIND=2,G=0,TEXTFORMAT=3,SHOW="true",SHOWTEXTPCT="false",R=1,SHOWTEXT="false",SHOWIND="true",ALERT=3}
BarAggro~d!2~3~4~5~6~7~8~9~10~
AuxBarFrame~f~1!{OVERLAP=1}
AuxBarFrame~d!2~3~4~5~6~7~8~9~10~
AuxBar^1~f~1!{SIZE=0.98,USE=4,B=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=1,R=1,G=1,OTYPE=1}
AuxBar^1~d!2~3~4~5~6~7~8~9~10~
AuxBar^2~f~1!{SIZE=0.98,USE=1,B=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,R=1,G=1,OTYPE=1}
AuxBar^2~d!2~3~4~5~6~7~8~9~10~
AuxBar^3~f~1!{SIZE=0.98,USE=1,B=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,R=1,G=1,OTYPE=1}
AuxBar^3~d!2~3~4~5~6~7~8~9~10~
AuxBar^4~f~1!{SIZE=0.98,USE=1,B=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,R=1,G=1,OTYPE=1}
AuxBar^4~d!2~3~4~5~6~7~8~9~10~
AuxBar^5~f~1!{SIZE=0.98,USE=5,B=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=1,R=1,G=1,OTYPE=1}
AuxBar^5~d!2~3~4~5~6~7~8~9~10~
AuxBar^6~f~1!{SIZE=0.98,USE=1,B=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,R=1,G=1,OTYPE=1}
AuxBar^6~d!2~3~4~5~6~7~8~9~10~
AuxBar^7~f~1!{SIZE=0.98,USE=1,B=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,R=1,G=1,OTYPE=1}
AuxBar^7~d!2~3~4~5~6~7~8~9~10~
AuxBar^8~f~1!{SIZE=0.98,USE=1,B=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,R=1,G=1,OTYPE=1}
AuxBar^8~d!2~3~4~5~6~7~8~9~10~
AuxBar^9~f~1!{SIZE=0.98,USE=1,B=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,R=1,G=1,OTYPE=1}
AuxBar^9~d!2~3~4~5~6~7~8~9~10~
Complete!]]
HealBot_ExtraSkinData[60]=[[Skin
Mirandinn Raid
Author~v!Mirandinn of Proudmoore
DuplicateBars~v!false
Chat~t!{EOCOOM="false",EOCOOMV=20,MSG="Casting #s on #n",RESONLY="true",CHAN="",NOTIFY=1}
General~t!{HIDEBOSSF="false",STICKYSENSITIVITY=30,FLUIDBARS="false",HIDEPTF="false",HIDEPARTYF="false",OMAX=0.95,HIDERAIDF="true",FLUIDFREQ=10,STICKYFRAME="false",OMIN=0.1,OFREQ=0.07}
Healing~t!{TINCSELF="false",GROUPPETS="true",TARGETINCOMBAT=2,TINCGROUP="true",FONLYFRIEND="false",TINCPET="false",TONLYFRIEND="false",FALWAYSSHOW="false",FOCUSINCOMBAT=2,TALWAYSSHOW="false",SELFPET=0,TINCRAID="true",TEXRAID="false",FEXRAID="false"}
Enemy~t!{ENEMYTARGET="false",INCTANKS="true",INCMYTAR="false",INCARENA="true",INCARENAPETS="false",ENEMYTARGETSIZE=40,HIDE="true",NUMBOSS=2,EXISTSHOWPTAR=1,INCSELF="false",EXISTSHOWBOSS="true",DOUBLEWIDTH="false",EXISTSHOWARENA=3}
FrameAlias~f~1!{SIZE=12,NAME="",R=1,ALIAS="Frame 1",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~d!2~3~4~5~
FrameAlias~f~6!{SIZE=12,NAME="Vehicle",R=1,ALIAS="Vehicle",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~7!{SIZE=12,NAME="Pets",R=1,ALIAS="Pets",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~8!{SIZE=12,NAME="Targets",R=1,ALIAS="Target",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~9!{SIZE=12,NAME="Focus",R=1,ALIAS="Focus",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAlias~f~10!{SIZE=12,NAME="Enemy",R=1,ALIAS="Enemy",G=1,SHOW="false",OFFSET=0,FONT="Friz Quadrata TT",A=1,B=1,OUTLINE=1}
FrameAliasBar~f~1!{A=0.4,TEXTURE="HealBot 10",B=0.1,HEIGHT=20,R=0.1,G=0.7,WIDTH=0.7}
FrameAliasBar~d!2~3~4~5~6~7~8~9~10~
Frame~f~1!{BACKR=0.1,TIPLOC=5,AUTOCLOSE="false",BACKB=0.1,LOCKED="true",SCALE=1,BORDERA=0.2,SFOFFSETV=0,BACKG=0.1,BORDERB=0.2,BACKA=0.05,OPENSOUND="false",BORDERG=0.2,BORDERR=0.2,SFOFFSETH=0}
Frame~d!2~3~4~5~6~7~8~9~10~
StickyFrames~f~1!{STUCK="false",STUCKTOPOINT="NONE",STUCKTO=0,STUCKPOINT="NONE"}
StickyFrames~d!2~3~4~5~6~7~8~9~10~
HealGroups~f~1!{FRAME=1,STATE="false",NAME="Self"}
HealGroups~f~2!{FRAME=1,STATE="true",NAME="Main tanks"}
HealGroups~f~3!{FRAME=1,STATE="true",NAME="Healers"}
HealGroups~f~4!{FRAME=1,STATE="true",NAME="Group"}
HealGroups~f~5!{FRAME=1,STATE="true",NAME="Raid"}
HealGroups~f~6!{FRAME=1,STATE="false",NAME="Private List"}
HealGroups~f~7!{FRAME=6,STATE="false",NAME="Vehicle"}
HealGroups~f~8!{FRAME=7,STATE="false",NAME="Pets"}
HealGroups~f~9!{FRAME=8,STATE="false",NAME="Target"}
HealGroups~f~10!{FRAME=9,STATE="false",NAME="Focus"}
HealGroups~f~11!{FRAME=10,STATE="false",NAME="Enemy"}
Anchors~f~1!{Y=68.25,GROW=2,BARS=3,FRAME=3,X=37.37}
Anchors~f~2!{Y=72.14,GROW=2,BARS=3,FRAME=3,X=29.97}
Anchors~f~3!{Y=52,GROW=2,BARS=3,FRAME=3,X=52}
Anchors~f~4!{Y=53,GROW=2,BARS=3,FRAME=3,X=53}
Anchors~f~5!{Y=54,GROW=2,BARS=3,FRAME=3,X=54}
Anchors~f~6!{Y=55,GROW=2,BARS=3,FRAME=3,X=55}
Anchors~f~7!{Y=56,GROW=2,BARS=3,FRAME=3,X=56}
Anchors~f~8!{Y=42.93,GROW=2,BARS=3,FRAME=3,X=29.4}
Anchors~f~9!{Y=58,GROW=2,BARS=3,FRAME=3,X=58}
Anchors~f~10!{Y=59,GROW=2,BARS=3,FRAME=3,X=59}
HeadBar~f~1!{SHOW="true",TEXTURE="HealBot 10",R=0.1,B=0.1,HEIGHT=18,A=0.4,G=0.7,WIDTH=0.7}
HeadBar~f~2!{SHOW="true",TEXTURE="HealBot 10",R=0.1,B=0.1,HEIGHT=13,A=0.4,G=0.7,WIDTH=0.7}
HeadBar~d!3~4~5~6~7~8~9~10~
HeadText~f~1!{A=0.74,R=1,OFFSET=0,B=1,FONT="Friz Quadrata TT",HEIGHT=9,G=1,OUTLINE=1}
HeadText~d!2~3~4~5~6~7~8~9~10~
HealBar~f~1!{HEIGHT=35,GRPCOLS="false",CMARGIN=2,TEXTURE="Smooth",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=150,RMARGIN=1,OFIX=1,NUMCOLS=2,LOWMANA=2}
HealBar~f~2!{HEIGHT=25,GRPCOLS="false",CMARGIN=2,TEXTURE="Smooth",POWERCNT="true",LOWMANACOMBAT="true",WIDTH=144,RMARGIN=1,OFIX=1,NUMCOLS=2,LOWMANA=2}
HealBar~d!3~4~5~6~7~8~9~10~
BarCol~f~1!{BACK=3,BA=0.75,BOUT=0,DISA=0.1,BR=0,HB=0.7,BB=0,HG=0.4,HA=1,HR=0.4,ORA=0.4,BG=0,HLTH=2}
BarCol~d!2~3~4~5~6~7~8~9~10~
BarIACol~f~1!{AC=3,AB=1,AA=0.78,AR=1,AG=1,IC=1,IB=0.2,IA=0.82,IR=0.2,IG=1}
BarIACol~d!2~3~4~5~6~7~8~9~10~
BarText~f~1!{HHEIGHT=10,TAGOOR="[ OOR ] ",IGNOREONFULL="true",MAXCHARS=0,CLASSONBAR="false",HFONT="Friz Quadrata TT",OUTLINE=1,INCHEALS=1,HLTHTXTANCHOR=1,HLTHTYPE=3,OFFSET=0,OVERHEAL=1,NUMFORMAT2=1,HMAXCHARS=0,TAGDC="[ DC ] ",HLTHONBAR="true",TAGRIP="[ RIP ] ",HEIGHT=13,NAMEONBAR="true",SHOWROLE="true",HALIGN=2,FONT="Friz Quadrata TT",HOUTLINE=1,NUMFORMAT1=11,INCABSORBS=1,HOFFSET2=0,ALIGN=1,TAGR="[ R ] ",HOFFSET=0}
BarText~f~2!{HHEIGHT=10,TAGOOR="[ OOR ] ",IGNOREONFULL="true",MAXCHARS=0,CLASSONBAR="false",HFONT="Friz Quadrata TT",OUTLINE=1,INCHEALS=2,HLTHTXTANCHOR=1,HLTHTYPE=1,OFFSET=0,OVERHEAL=1,NUMFORMAT2=1,HMAXCHARS=0,TAGDC="[ DC ] ",HLTHONBAR="true",TAGRIP="[ RIP ] ",HEIGHT=10,NAMEONBAR="true",SHOWROLE="true",HALIGN=2,FONT="Friz Quadrata TT",HOUTLINE=1,NUMFORMAT1=11,INCABSORBS=1,HOFFSET2=0,ALIGN=2,TAGR="[ R ] ",HOFFSET=0}
BarText~d!3~4~5~6~7~8~9~10~
BarTextCol~f~1!{HCG=0.969,HCA=1,HLTH=3,NCDA=0.8,NCR=0.957,NCB=1,HCB=1,NCA=1,HCR=0.957,NCG=0.969,NDEBUFF="false",HDEBUFF="false",NAME=3,HCDA=0.8}
BarTextCol~f~2!{HCG=1,HCA=1,HLTH=2,NCDA=0.8,NCR=1,NCB=0,HCB=0,NCA=1,HCR=1,NCG=1,NDEBUFF="false",HDEBUFF="false",NAME=2,HCDA=0.8}
BarTextCol~d!3~4~5~6~7~8~9~10~
Icons~f~1!{RCEN="false",I15EN="true",CLASSEN="false",FADE="true",BUFFFADE="true",DEBUFFANCHOR=1,RCVOFFSET=0,OORVOFFSET=0,DEBUFFDOUBLE="true",TARGETVOFFSET=0,BUFFONBAR=1,SHOWDIR="true",SHOWRC="true",TARGETANCHOR=1,RCSCALE=0.5,MAXBICONS=8,FADESECS=15,RCHOFFSET=0,TARGETHOFFSET=0,RCANCHOR=1,CLASSVOFFSET=0,OORHOFFSET=0,DSCALE=1,SHOWCLASS="true",TARGETEN="false",BUFFDOUBLE="true",TARGETONBAR=1,TARGETSCALE=0.5,BUFFANCHOR=2,CLASSONBAR=1,CLASSSCALE=0.5,RCONBAR=1,MAXDICONS=3,OORANCHOR=1,SHOWDIRMOUSE="false",CLASSANCHOR=1,CLASSHOFFSET=0,DEBUFFONBAR=1,OORONBAR=3,BUFFI15EN="true",BUFFFADESECS=15,OORSCALE=0.5,SCALE=1,OOREN="false",SHOWROLE="true"}
Icons~f~2!{RCEN="false",I15EN="true",CLASSEN="false",FADE="true",BUFFFADE="true",DEBUFFANCHOR=1,RCVOFFSET=0,OORVOFFSET=0,DEBUFFDOUBLE="false",TARGETVOFFSET=0,BUFFONBAR=1,SHOWDIR="true",SHOWRC="true",TARGETANCHOR=1,RCSCALE=0.5,MAXBICONS=8,TARGETEN="false",FADESECS=15,RCHOFFSET=0,OORHOFFSET=0,CLASSONBAR=1,CLASSVOFFSET=0,TARGETSCALE=0.5,DSCALE=0.7,TARGETONBAR=1,BUFFDOUBLE="false",SCALE=0.7,OORONBAR=3,BUFFANCHOR=2,RCANCHOR=1,CLASSSCALE=0.5,DOUBLE="false",RCONBAR=1,MAXDICONS=3,OORANCHOR=1,CLASSANCHOR=1,SHOWCLASS="false",CLASSHOFFSET=0,DEBUFFONBAR=1,SHOWROLE="false",BUFFI15EN="true",BUFFFADESECS=15,OORSCALE=0.5,SHOWDIRMOUSE="false",OOREN="false",TARGETHOFFSET=0}
Icons~d!3~4~5~6~7~8~9~10~
RaidIcon~f~1!{SQUARE="true",CIRCLE="true",DIAMOND="true",SHOW="true",MOON="true",TRIANGLE="true",STAR="true",CROSS="true",SKULL="true"}
RaidIcon~d!2~3~4~5~6~7~8~9~10~
IconText~f~1!{SDUR="true",BUFFHEIGHT=12,BUFFOUTLINE=2,BUFFDURTHRH=9,SCNT="true",DURTHRH=9,FONT="Friz Quadrata TT",BUFFFONT="Friz Quadrata TT",BUFFSCNT="true",SSCNT="false",OUTLINE=2,BUFFDURWARN=3,BUFFSSCNT="false",HEIGHT=12,BUFFSSDUR="true",DURWARN=3,SSDUR="true",BUFFSDUR="true"}
IconText~f~2!{SDUR="true",BUFFHEIGHT=9,BUFFOUTLINE=2,BUFFDURTHRH=9,SCNT="true",DURTHRH=9,FONT="Friz Quadrata TT",BUFFFONT="Friz Quadrata TT",BUFFSCNT="true",SSCNT="false",OUTLINE=2,BUFFDURWARN=3,BUFFSSCNT="false",HEIGHT=9,BUFFSSDUR="true",DURWARN=3,SSDUR="true",BUFFSDUR="true"}
IconText~d!3~4~5~6~7~8~9~10~
BarVisibility~f~1!{INCCLASSES=1,ALERTIC=1,ALERTOC=1,HIDEOOR="false"}
BarVisibility~f~2!{INCCLASSES=1,ALERTIC=0.98,ALERTOC=0.95,HIDEOOR="false"}
BarVisibility~d!3~4~5~6~7~8~9~10~
BarSort~f~1!{SUBORDER=1,OORLAST="false",RAIDORDER=3,SUBPF="true"}
BarSort~d!2~3~4~5~6~7~8~9~10~
BarAggro~f~1!{R=1,ALERTIND=2,G=0,TEXTFORMAT=3,SHOW="true",SHOWTEXTPCT="true",SHOWIND="true",B=0,SHOWTEXT="false",ALERT=3}
BarAggro~d!2~3~4~5~6~7~8~9~10~
AuxBarFrame~f~1!{OVERLAP=1}
AuxBarFrame~d!2~3~4~5~6~7~8~9~10~
AuxBar^1~f~1!{SIZE=0.98,USE=1,B=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,R=1,G=1,OTYPE=1}
AuxBar^1~d!2~3~4~5~6~7~8~9~10~
AuxBar^2~f~1!{SIZE=0.98,USE=1,B=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,R=1,G=1,OTYPE=1}
AuxBar^2~d!2~3~4~5~6~7~8~9~10~
AuxBar^3~f~1!{SIZE=0.98,USE=1,B=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,R=1,G=1,OTYPE=1}
AuxBar^3~d!2~3~4~5~6~7~8~9~10~
AuxBar^4~f~1!{SIZE=0.98,USE=1,B=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,R=1,G=1,OTYPE=1}
AuxBar^4~d!2~3~4~5~6~7~8~9~10~
AuxBar^5~f~1!{SIZE=0.98,USE=5,B=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=2,R=1,G=1,OTYPE=1}
AuxBar^5~d!2~3~4~5~6~7~8~9~10~
AuxBar^6~f~1!{SIZE=0.98,USE=8,B=1,COLOUR=1,ANCHOR=2,OFFSET=1,DEPTH=1,R=1,G=1,OTYPE=1}
AuxBar^6~f~2!{SIZE=0.98,USE=1,B=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,R=1,G=1,OTYPE=1}
AuxBar^6~d!3~4~5~6~7~8~9~10~
AuxBar^7~f~1!{SIZE=0.98,USE=1,B=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,R=1,G=1,OTYPE=1}
AuxBar^7~d!2~3~4~5~6~7~8~9~10~
AuxBar^8~f~1!{SIZE=0.98,USE=1,B=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,R=1,G=1,OTYPE=1}
AuxBar^8~d!2~3~4~5~6~7~8~9~10~
AuxBar^9~f~1!{SIZE=0.98,USE=1,B=1,COLOUR=1,ANCHOR=1,OFFSET=1,DEPTH=5,R=1,G=1,OTYPE=1}
AuxBar^9~d!2~3~4~5~6~7~8~9~10~
Complete!]]