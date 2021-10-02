local debugText={}
local dedupText={}
local debugCatText={}
local debugCat=1

local dFrame=CreateFrame("Frame", "HealBot_Debug_Frame", UIParent, BackdropTemplateMixin and "BackdropTemplate")

local function HealBot_Debug_OnMouseDown(self, button)
    if button=="LeftButton" and not dFrame.isMoving then
        dFrame:StartMoving();
        dFrame.isMoving = true;
    end
end

local function HealBot_Debug_OnMouseUp(self, button)
    if button=="LeftButton" and dFrame.isMoving then
		dFrame:StopMovingOrSizing();
		dFrame.isMoving = false;
    end
end

dFrame:SetBackdrop({
    bgFile = "Interface\\Addons\\HealBot\\Images\\WhiteLine",
    edgeFile = "Interface\\Addons\\HealBot\\Images\\border",
    tile = true,
    tileSize = 8,
    edgeSize = 8,
    insets = { left = 3, right = 3, top = 3, bottom = 3, },
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
dFrameText[1]:SetText("Test 1")
for x=2,50 do
    dFrameText[x]=dFrame:CreateFontString("HealBot_Debug_FrameText"..x, "ARTWORK", "GameFontNormal")
    dFrameText[x]:SetPoint("TOPLEFT", dFrameText[x-1], "TOPLEFT", 0, -15)
    dFrameText[x]:SetText("Test "..x)
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
	bar:SetStatusBarTexture("Interface\\Addons\\HealBot\\Images\\tukuibar.tga")
	bar.Text = bar:CreateFontString()
	bar.Text:SetFontObject(GameFontNormal)
	bar.Text:SetPoint("CENTER")
	bar.Text:SetJustifyH("CENTER")
	bar.Text:SetJustifyV("CENTER")
    bar.Text:SetText(text)
end

local dFramePrevCatButton=CreateFrame("StatusBar", "HealBot_Debug_Frame_PrevCatButton", dFrame)
HealBot_Debug_SetupStatusBarButton(dFramePrevCatButton, -100, "<")
dFramePrevCatButton:SetScript("OnMouseDown", function() HealBot_Debug_PrevCat() end)
local dFrameNextCatButton=CreateFrame("StatusBar", "HealBot_Debug_Frame_NextCatButton", dFrame)
HealBot_Debug_SetupStatusBarButton(dFrameNextCatButton, 100, ">")
dFrameNextCatButton:SetScript("OnMouseDown", function() HealBot_Debug_NextCat() end)

function HealBot_Debug_HideShow(show)
    if HealBot_Globals.DebugOut and not dFrame:IsVisible() then
        dFrame:Show()
        HealBot_Debug_RefreshCat()
    else
        dFrame:Hide()
    end
end
    
function HealBot_Debug_Clear(cat)
    debugText[cat]={};
    if debugCatText[debugCat]==cat then
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
    elseif debugCatText[debugCat]=="Calls" then    
        debugText["Calls"]={}
        msgs=HealBot_retCalls()
        linenum = 0
        local maxcount=0
        for x,_ in pairs(order) do
            order[x]=nil;
        end
        
        for name,count in pairs(msgs) do
            table.insert(order,name)
            if count>maxcount then maxcount=count end
        end
        local filtercount=floor(maxcount/100)
        table.sort(order,function (a,b)
            if msgs[a]>msgs[b] then return true end
            if msgs[a]<msgs[b] then return false end
            return a>b
        end)
        --
        for j=1,#order do
            if linenum<50 then --and msgs[order[j]]>filtercount then
                linenum=linenum+1
                table.insert(debugText["Calls"],order[j].." = "..msgs[order[j]])
            end
        end
        HealBot_Debug_RefreshCat()
    end
end


HealBot_Debug_Add("Load", "Debug Loaded", true)