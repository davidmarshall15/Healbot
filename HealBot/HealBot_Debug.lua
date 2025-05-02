local debugText={}
local dedupText={}
local debugCatText={}
local debugCat=1

local dFrame=CreateFrame("Frame", "HealBot_Debug_Frame", UIParent, BackdropTemplateMixin and "BackdropTemplate")

local function HealBot_Debug_OnMouseDown(self, button)
    if button == "LeftButton" and not dFrame.isMoving then
        dFrame:StartMoving();
        dFrame.isMoving=true;
    end
end

local function HealBot_Debug_OnMouseUp(self, button)
    if button == "LeftButton" and dFrame.isMoving then
		dFrame:StopMovingOrSizing();
		dFrame.isMoving=false;
    end
end

dFrame:SetBackdrop({
    bgFile="Interface\\Addons\\HealBot\\Images\\frame\\WhiteLine.tga",
    edgeFile="Interface\\Addons\\HealBot\\Images\\frame\\border.tga",
    tile=true,
    tileSize=8,
    edgeSize=8,
    insets={ left=3, right=3, top=3, bottom=3, },
})
dFrame:SetMovable(true)
dFrame:EnableMouse(true)
dFrame:SetScript("OnMouseDown", function(self, button) HealBot_Debug_OnMouseDown(self, button) end)
dFrame:SetScript("OnMouseUp", function(self, button) HealBot_Debug_OnMouseUp(self, button) end)
dFrame:SetHeight(840)
dFrame:SetWidth(500)
dFrame:SetPoint("TOPLEFT",20,-120)
dFrame:SetBackdropColor(0.1,0.1,0.1,0.88)
dFrame:Hide()
local dFrameTitleText=dFrame:CreateFontString("HealBot_Debug_FrameTitleText", "ARTWORK", "GameFontNormal")
dFrameTitleText:SetPoint("TOP", dFrame, "TOP", 0, -4)
dFrameTitleText:SetText("HealBot Debug")

local dFrameCatText=dFrame:CreateFontString("HealBot_Debug_FrameCatText", "ARTWORK", "GameFontNormal")
dFrameCatText:SetPoint("BOTTOM", 0, 18)
dFrameCatText:SetText("Cat Text")

local dFrameText={}
dFrameText[1]=dFrame:CreateFontString("HealBot_Debug_FrameText1", "ARTWORK", "GameFontNormal")
dFrameText[1]:SetPoint("TOPLEFT", dFrame, "TOPLEFT", 20, -35)
for x=2,50 do
    dFrameText[x]=dFrame:CreateFontString("HealBot_Debug_FrameText"..x, "ARTWORK", "GameFontNormal")
    dFrameText[x]:SetPoint("TOPLEFT", dFrameText[x-1], "TOPLEFT", 0, -15)
end

local lineNum=1
local function HealBot_Debug_RefreshCat()
    lineNum=1
    dFrameCatText:SetText(debugCatText[debugCat].." ("..debugCat.." of "..#debugCatText..")")
    table.foreach(debugText[debugCatText[debugCat]], function (index,msg)
        dFrameText[lineNum]:SetText(msg)
        lineNum=lineNum+1
    end)
    for x=lineNum,50 do
        dFrameText[x]:SetText("")
    end
end

local function HealBot_Debug_NextCat()
    debugCat=debugCat+1
    if debugCat>#debugCatText then debugCat=1 end
    HealBot_Debug_RefreshCat()
end

local function HealBot_Debug_PrevCat()
    debugCat=debugCat-1
    if debugCat<1 then debugCat=#debugCatText end
    HealBot_Debug_RefreshCat()
end

local function HealBot_Debug_SetupStatusBarButton(bar, x, text)
	bar:SetSize(22, 22)
	bar:SetPoint("BOTTOM", x, 12)
	bar:SetStatusBarTexture("Interface\\Addons\\HealBot\\Images\\textures\\tukuibar.tga")
	bar.Text=bar:CreateFontString()
	bar.Text:SetFontObject(GameFontNormal)
	bar.Text:SetPoint("CENTER")
    bar.Text:SetText(text)
end

local dFramePrevCatButton=CreateFrame("StatusBar", "HealBot_Debug_Frame_PrevCatButton", dFrame)
HealBot_Debug_SetupStatusBarButton(dFramePrevCatButton, -100, "<")
dFramePrevCatButton:SetScript("OnMouseDown", function() HealBot_Debug_PrevCat() end)
local dFrameNextCatButton=CreateFrame("StatusBar", "HealBot_Debug_Frame_NextCatButton", dFrame)
HealBot_Debug_SetupStatusBarButton(dFrameNextCatButton, 100, ">")
dFrameNextCatButton:SetScript("OnMouseDown", function() HealBot_Debug_NextCat() end)

local dLeft,dTop=20,850
function HealBot_Debug_HideShow(show)
    if HealBot_Globals.DebugOut and not dFrame:IsVisible() then
        dFrame:Show()
        dLeft=dFrame:GetLeft()
        dTop=dFrame:GetTop()
        if dLeft<-400 then dLeft=20 end
        if dLeft>(GetScreenWidth()-100) then dLeft=GetScreenWidth()-520 end
        if dTop<100 then
            dTop=GetScreenHeight()-850
        elseif dTop>(GetScreenHeight()+400) then
            dTop=50
        elseif dLeft~=dFrame:GetLeft() then
           dTop=GetScreenHeight()-dTop
        end
        if dLeft~=dFrame:GetLeft() or dTop~=dFrame:GetTop() then
            dFrame:ClearAllPoints()
            dFrame:SetPoint("TOPLEFT",UIParent,"TOPLEFT",dLeft,-dTop)
        end
        HealBot_Debug_RefreshCat()
    else
        dFrame:Hide()
    end
end

function HealBot_Debug_Clear(cat)
    debugText[cat]={};
    if debugCatText[debugCat] == cat then
        for x=1,50 do
            dFrameText[x]:SetText("")
        end
    end
end

function HealBot_Debug_Add(cat, text, incTime)
    if not debugText[cat] then
        debugText[cat]={}
        table.insert(debugCatText,cat)
    end
    if not incTime then
        if not dedupText[cat] then dedupText[cat]={} end
        if not dedupText[cat][text] then
            table.insert(debugText[cat],text)
            dedupText[cat][text]=true
        end
    else
        table.insert(debugText[cat],"["..date("%H:%M:%S", time()).."] "..text)
    end
    if #debugText[cat]>50 then
        table.remove(debugText[cat],1)
    end
    HealBot_Debug_RefreshCat()
end


local msgs={}
local order={}
function HealBot_Debug_UpdateCalls()
    if not debugText["Calls"] then
        debugText["Calls"]={}
        table.insert(debugCatText,"Calls")
        HealBot_Debug_Add("Calls", "Calls Active", true)
        debugText["Calls-Freq"]={}
        table.insert(debugCatText,"Calls-Freq")
        HealBot_Debug_Add("Calls-Freq", "Calls Active", true)
    elseif debugCatText[debugCat] == "Calls" then
        debugText["Calls"]={}
        msgs=HealBot_retCalls()
        local linenum=0
        local maxcount=0
        for x,_ in pairs(order) do
            order[x]=nil;
        end

        for name,count in pairs(msgs) do
            table.insert(order,name)
        end
        table.sort(order,function (a,b)
            if msgs[a]>msgs[b] then return true end
            if msgs[a]<msgs[b] then return false end
            return a>b
        end)
        --
        for j=1,#order do
            if linenum<50 then
                linenum=linenum+1
                table.insert(debugText["Calls"],order[j].."="..msgs[order[j]])
            end
        end

        HealBot_Debug_RefreshCat()
    elseif debugCatText[debugCat] == "Calls-Freq" then
        debugText["Calls-Freq"]={}
        msgs=HealBot_retCalls(nil, true)
        local linenum=0
        local maxcount=0
        for x,_ in pairs(order) do
            order[x]=nil;
        end

        for name,count in pairs(msgs) do
            table.insert(order,name)
        end
        table.sort(order,function (a,b)
            if msgs[a]>msgs[b] then return true end
            if msgs[a]<msgs[b] then return false end
            return a>b
        end)
        --
        for j=1,#order do
            if linenum<50 then
                linenum=linenum+1
                table.insert(debugText["Calls-Freq"],order[j].."="..msgs[order[j]])
            end
        end
    end
end

local debugRefresh=0
function HealBot_Debug_UpdateButtonCalls(button, caller, mCount)
    if not debugText["Calls "..button.name] then
        debugText["Calls "..button.name]={}
        table.insert(debugCatText,"Calls "..button.name)
        HealBot_Debug_Add("Calls "..button.name, "Calls Active for "..button.name, true)
    elseif debugRefresh<HealBot_TimeNow then
        debugRefresh=HealBot_TimeNow+0.1
        debugText["Calls "..button.name]={}
        msgs=HealBot_retCalls(button)
        local linenum=0
        local maxcount=0
        for x,_ in pairs(order) do
            order[x]=nil;
        end

        for name,count in pairs(msgs) do
            table.insert(order,name)
        end
        table.sort(order,function (a,b)
            if msgs[a]>msgs[b] then return true end
            if msgs[a]<msgs[b] then return false end
            return a>b
        end)
        --
        for j=1,#order do
            if linenum<50 then
                linenum=linenum+1
                table.insert(debugText["Calls "..button.name],order[j].."="..msgs[order[j]])
            end
        end
        HealBot_Debug_RefreshCat()
    end
    if caller then
        HealBot_Debug_Add("Calls "..button.name.." Ordered", caller.." x"..mCount, true)
    end
end


HealBot_Debug_Add("Load", "Debug Loaded", true)

local pFrame=CreateFrame("Frame", "HealBot_Debug_Perf", UIParent, BackdropTemplateMixin and "BackdropTemplate")

local function HealBot_Debug_pFrameOnMouseDown(self, button)
    if button == "LeftButton" and not pFrame.isMoving then
        pFrame:StartMoving();
        pFrame.isMoving=true;
    end
end

local function HealBot_Debug_pFrameOnMouseUp(self, button)
    if button == "LeftButton" and pFrame.isMoving then
		pFrame:StopMovingOrSizing();
		pFrame.isMoving=false;
    end
end

pFrame:SetBackdrop({
    bgFile="Interface\\Addons\\HealBot\\Images\\frame\\WhiteLine.tga",
    edgeFile="Interface\\Addons\\HealBot\\Images\\frame\\border.tga",
    tile=true,
    tileSize=8,
    edgeSize=8,
    insets={ left=3, right=3, top=3, bottom=3, },
})
pFrame:SetMovable(true)
pFrame:EnableMouse(true)
pFrame:SetScript("OnMouseDown", function(self, button) HealBot_Debug_pFrameOnMouseDown(self, button) end)
pFrame:SetScript("OnMouseUp", function(self, button) HealBot_Debug_pFrameOnMouseUp(self, button) end)
pFrame:SetHeight(330)
pFrame:SetWidth(220)
pFrame:SetPoint("TOPLEFT",20,-120)
pFrame:SetBackdropColor(0.1,0.1,0.1,0.88)
pFrame:Hide()
local pFrameTitleText=pFrame:CreateFontString("HealBot_pFrameDebug_FrameTitleText", "ARTWORK", "GameFontNormal")
pFrameTitleText:SetPoint("TOP", pFrame, "TOP", 0, -4)
pFrameTitleText:SetText("HealBot Performance")

local pIndex={["PerfLevel"]=1,
              ["AuraUpdate"]=2,
              ["TimersOn"]=3,
              ["TimersOff"]=4,
              ["UpdateNumUnits"]=5,
              ["updUnitsAdj"]=6,
              ["aggroInt"]=7,
              ["statusInt"]=8,
              ["healthInt"]=9,
              ["deadInt"]=10,
              ["auxOutlines"]=11,
              ["fps"]=12,
              ["lag"]=13,
              ["CDdelay"]=14,
              ["FluidFreq"]=15,
              ["FlashFreq"]=16,
              ["AuxFluidFreq"]=17,
             }
local pFrameText={}
local pFrameTextVal={}
for x=1,17 do
    pFrameText[x]=pFrame:CreateFontString("HealBot_Debug_pFrameFrameText"..x, "ARTWORK", "GameFontNormal")
    pFrameTextVal[x]=pFrame:CreateFontString("HealBot_pFrameDebug_FrameTextVal"..x, "ARTWORK", "GameFontNormal")
    pFrameTextVal[x]:SetTextColor(1,1,1,1)
end

pFrameText[1]:SetPoint("TOPLEFT", pFrame, "TOPLEFT", 10, -35)
pFrameText[1]:SetText("Performance Level: ")

pFrameText[2]:SetPoint("TOPLEFT", pFrameText[1], "TOPLEFT", 0, -20)
pFrameText[2]:SetText("Aura Update:")

pFrameText[3]:SetPoint("TOPLEFT", pFrameText[2], "TOPLEFT", 0, -20)
pFrameText[3]:SetText("Timers Turbo ON:")
pFrameText[4]:SetPoint("TOPLEFT", pFrameText[3], "TOPLEFT", 0, -15)
pFrameText[4]:SetText("Timers Turbo OFF:")

pFrameText[5]:SetPoint("TOPLEFT", pFrameText[4], "TOPLEFT", 0, -20)
pFrameText[5]:SetText("Update Units Max:")
pFrameText[6]:SetPoint("TOPLEFT", pFrameText[5], "TOPLEFT", 0, -15)
pFrameText[6]:SetText("Update Units Adj:")

pFrameText[7]:SetPoint("TOPLEFT", pFrameText[6], "TOPLEFT", 0, -20)
pFrameText[7]:SetText("Threat check interval:")
pFrameText[8]:SetPoint("TOPLEFT", pFrameText[7], "TOPLEFT", 0, -15)
pFrameText[8]:SetText("DC check Interval:")
pFrameText[9]:SetPoint("TOPLEFT", pFrameText[8], "TOPLEFT", 0, -15)
pFrameText[9]:SetText("Health check Interval:")
pFrameText[10]:SetPoint("TOPLEFT", pFrameText[9], "TOPLEFT", 0, -15)
pFrameText[10]:SetText("Dead check Interval:")

pFrameText[11]:SetPoint("TOPLEFT", pFrameText[10], "TOPLEFT", 0, -20)
pFrameText[11]:SetText("Num Aux Outlines:")

pFrameText[12]:SetPoint("TOPLEFT", pFrameText[11], "TOPLEFT", 0, -20)
pFrameText[12]:SetText("Frames per Second:")
pFrameText[13]:SetPoint("TOPLEFT", pFrameText[12], "TOPLEFT", 0, -15)
pFrameText[13]:SetText("World Latency:")
pFrameText[14]:SetPoint("TOPLEFT", pFrameText[13], "TOPLEFT", 0, -15)
pFrameText[14]:SetText("Cooldown Delay:")

pFrameText[15]:SetPoint("TOPLEFT", pFrameText[14], "TOPLEFT", 0, -20)
pFrameText[15]:SetText("Fluid Freq:")
pFrameText[16]:SetPoint("TOPLEFT", pFrameText[15], "TOPLEFT", 0, -15)
pFrameText[16]:SetText("Flash Freq:")
pFrameText[17]:SetPoint("TOPLEFT", pFrameText[16], "TOPLEFT", 0, -15)
pFrameText[17]:SetText("Aux Fluid Freq:")

pFrameTextVal[1]:SetPoint("TOPRIGHT", pFrame, "TOPRIGHT", -10, -35)
pFrameTextVal[2]:SetPoint("TOPRIGHT", pFrameTextVal[1], "TOPRIGHT", 0, -20)
pFrameTextVal[3]:SetPoint("TOPRIGHT", pFrameTextVal[2], "TOPRIGHT", 0, -20)
pFrameTextVal[4]:SetPoint("TOPRIGHT", pFrameTextVal[3], "TOPRIGHT", 0, -15)
pFrameTextVal[5]:SetPoint("TOPRIGHT", pFrameTextVal[4], "TOPRIGHT", 0, -20)
pFrameTextVal[6]:SetPoint("TOPRIGHT", pFrameTextVal[5], "TOPRIGHT", 0, -15)
pFrameTextVal[7]:SetPoint("TOPRIGHT", pFrameTextVal[6], "TOPRIGHT", 0, -20)
pFrameTextVal[8]:SetPoint("TOPRIGHT", pFrameTextVal[7], "TOPRIGHT", 0, -15)
pFrameTextVal[9]:SetPoint("TOPRIGHT", pFrameTextVal[8], "TOPRIGHT", 0, -15)
pFrameTextVal[10]:SetPoint("TOPRIGHT", pFrameTextVal[9], "TOPRIGHT", 0, -15)
pFrameTextVal[11]:SetPoint("TOPRIGHT", pFrameTextVal[10], "TOPRIGHT", 0, -20)
pFrameTextVal[12]:SetPoint("TOPRIGHT", pFrameTextVal[11], "TOPRIGHT", 0, -20)
pFrameTextVal[13]:SetPoint("TOPRIGHT", pFrameTextVal[12], "TOPRIGHT", 0, -15)
pFrameTextVal[14]:SetPoint("TOPRIGHT", pFrameTextVal[13], "TOPRIGHT", 0, -15)
pFrameTextVal[15]:SetPoint("TOPRIGHT", pFrameTextVal[14], "TOPRIGHT", 0, -20)
pFrameTextVal[16]:SetPoint("TOPRIGHT", pFrameTextVal[15], "TOPRIGHT", 0, -15)
pFrameTextVal[17]:SetPoint("TOPRIGHT", pFrameTextVal[16], "TOPRIGHT", 0, -15)

local pLeft,pTop=20,120
function HealBot_Debug_PerfHideShow(show)
    if not pFrame:IsVisible() then
        pFrame:Show()
        pLeft=pFrame:GetLeft()
        pTop=pFrame:GetTop()
        if pLeft<-100 then pLeft=20 end
        if pLeft>(GetScreenWidth()-100) then pLeft=GetScreenWidth()-240 end
        if pTop<100 then
            pTop=GetScreenHeight()-220
        elseif pTop>(GetScreenHeight()+100) then
            pTop=50
        elseif pLeft~=pFrame:GetLeft() then
            pTop=GetScreenHeight()-pTop
        end
        if pLeft~=pFrame:GetLeft() or pTop~=pFrame:GetTop() then
            pFrame:ClearAllPoints()
            pFrame:SetPoint("TOPLEFT",UIParent,pLeft,-pTop)
        end
        HealBot_Debug_RefreshCat()
    else
        pFrame:Hide()
    end
end

function HealBot_Debug_PerfUpdate(cat, value)
    if type(value) == "boolean" then
        if value then
            value="True"
        else
            value="False"
        end
    end
    pFrameTextVal[pIndex[cat]]:SetText(value)
end