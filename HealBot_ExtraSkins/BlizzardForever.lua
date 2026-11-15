-- Native Skin-v3 payloads: importing uses the normal HealBot skin loader.
-- These presets approximate Blizzard compact frames using bundled media.
local function build(name, raid, width, height, columns)
    local rows={"Skin-v3", name, "Author~0~s~v!Cappe93", "DuplicateBars~0~s~v!false"}
    local function row(command, data) rows[#rows+1]=command.."!{"..data.."}" end
    row("General~0~s~t", 'HIDEPARTYF="false",HIDERAIDF="false",FLUIDBARS="false",STICKYFRAME="false"')
    row("Healing~0~s~t", 'GROUPPETS="false",SELFPET="false"')
    row("Anchors~0~s~f~1", 'X=15,Y=65,FRAME=1,BARS=1,GROW=2')
    row("HealBar~0~s~f~1", 'TEXTURE="Blizzard Raid Bar",WIDTH='..width..',HEIGHT='..height..',NUMCOLS='..columns..',GRPCOLS="'..tostring(raid)..'",RMARGIN=3,CMARGIN=3,POWERCNT="false"')
    row("BarCol~0~s~f~1", 'HLTH=2,BACK=4,BR=0.08,BG=0.08,BB=0.08,BIR=0.08,BIG=0.08,BIB=0.08,BCR=0.08,BCG=0.08,BCB=0.08,BA=1,BORDER=5,BORR=0.08,BORG=0.08,BORB=0.08,BORIR=0.08,BORIG=0.08,BORIB=0.08,BORCR=0.08,BORCG=0.08,BORCB=0.08,BORSIZE=1,HA=1,DISA=1,ORA=0.45')
    row("BarText~0~s~f~1", 'FONT="Friz Quadrata TT",HEIGHT=11,OUTLINE=2,NAMEONBAR="true",HLTHONBAR="false",SHOWROLE="false",CLASSONBAR="false",ALIGN=2,MAXCHARS=14')
    row("BarTextCol~0~s~f~1", 'NAME=2,NCR=1,NCG=1,NCB=1,NICR=1,NICG=1,NICB=1,NCCR=1,NCCG=1,NCCB=1,NCA=1,NCDA=1')
    row("BarSort~0~s~f~1", 'RAIDORDER=3,SUBORDER=1,OORLAST="false",SUBPF="false"')
    row("BarIACol~0~s~f~1", 'IC=6,IR=0.2,IG=1,IB=0.3,IIR=0.2,IIG=1,IIB=0.3,ICR=0.2,ICG=1,ICB=0.3,IA=0.65,AC=6,AA=0.7')
    row("Frame~0~s~f~1", 'SCALE=1,PADDING=2,BACKA=0,BORDERA=0')
    row("FrameAlias~0~s~f~1", 'SHOW="false"')
    row("HeadBar~0~s~f~1", 'SHOW="false"')
    row("Icons~0~s~f~1", 'SHOWCLASS="true",SHOWROLE="true",SHOWMTONLY="false",CLASSEN="true",CLASSSCALE=0.3,CLASSANCHOR=3,RCEN="true",RCSCALE=0.35,RCANCHOR=4')
    row("Emerg~0~s~f~1", 'USE="false"')
    local names={"Main tanks","Self","Group","Private List","Healers","Raid","Private Focus","Private Focus ToT","Vehicle","Pets","Target","Target of Target","Focus","Target of Focus","Enemy"}
    for id,label in ipairs(names) do
        local enabled=(raid and id==6) or (not raid and (id==2 or id==3))
        row("HealGroups~0~s~f~"..id, 'FRAME='..(id==15 and 10 or 1)..',STATE="'..tostring(enabled)..'",NAME="'..label..'"')
    end
    row("Bar~1~a~f~1", 'USE="Power",ANCHOR=1,DEPTH=4,OFFSET=0,COLOUR=1,SIZE=1,MANAONLY="false",TEXT="false"')
    row("IconSets~1~i~f~1", 'BUFFANCHOR=2,DEBUFFANCHOR=1,BSCALE=0.3,DSCALE=0.3,MAXBICONS=3,MAXDICONS=3,BICONSPACER=1,DICONSPACER=1,BUFFDOUBLE="false",DEBUFFDOUBLE="false"')
    for set=2,3 do row("IconSets~"..set.."~i~f~1", 'MAXBICONS=0,MAXDICONS=0') end
    row("IconSetsText~1~i~f~1", 'BUFFSDUR="true",DBSDUR="true",BUFFDURTHRH=60,DBDURTHRH=60')
    rows[#rows+1]="Complete!0"
    return table.concat(rows,"\n")
end

for _,preset in ipairs({
    {"Blizzard Forever - Party", "GROUP", false, 120, 44, 1},
    {"Blizzard Forever - Raid 10", "SMALL-RAID", true, 100, 40, 2},
    {"Blizzard Forever - Raid 40", "LARGE-RAID", true, 90, 36, 8},
}) do
    HealBot_ExtraSkins_AddSkin(preset[1], preset[2],
        "Blizzard compact-frame inspired preset by Cappe93.\nClass colours, dark borders, power bar and corner auras.\nUses HealBot click-casting. No screenshot preview available.\nBlizzard's own frames remain visible; hide them separately if desired.",
        build(preset[1],preset[3],preset[4],preset[5],preset[6]))
end
