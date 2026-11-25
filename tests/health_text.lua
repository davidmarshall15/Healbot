-- Exercise the actual modern health formatter. Native concatenation/format
-- propagate opaque values; addon arithmetic, inspection and tostring fail.
local passed=0
local hidden=setmetatable({}, {__mode="k"})
local function raw(v) if hidden[v]~=nil then return hidden[v] end return v end
local function forbidden() error("addon inspected protected health text") end
local secret
secret=function(value)
    local v=setmetatable({}, {__add=forbidden,__sub=forbidden,__mul=forbidden,
        __div=forbidden,__lt=forbidden,__le=forbidden,__tostring=forbidden,
        __concat=function(a,b) return secret(raw(a)..raw(b)) end})
    hidden[v]=value
    return v
end
local function eq(actual,expected,label)
    assert(raw(actual)==expected,label..": unexpected result")
    passed=passed+1
end
local f=assert(io.open("HealBot/HealBot_Text.lua","rb"))
local source=f:read("*a"):gsub("\r\n","\n"); f:close()
local formatter=assert(source:match("(function HealBot_Text_DoSetHealthText%([^\n]+.-)\nfunction "))
local nativeFormatter=assert(source:match("(local hbNativeHealthFormats={}.-)\nfunction HealBot_Text_DoSetHealthText"))
local function run(health,percent,include,places,healthType,missing,options)
    options=options or {}
    local updates=0
    local button={unit="party1",frame=1,framecol=2,health={current=health,cpct=percent},text={}}
    local env=setmetatable({
        HealBot_Util_isMidnight=function() return true end,
        HealBot_Globals={UseLowerNumSuffix=options.lower},
        hbBarHealthTextLen={[2]=options.width or 50},
        -- Model only the native sink: addon code must pass opaque values intact.
        AbbreviateNumbers=not options.noAbbreviation and function(value,config)
            local number=raw(value)
            local text=tostring(number)
            local previous=math.huge
            for _,data in ipairs(config.breakpointData) do
                assert(data.breakpoint<previous,"breakpoints must descend")
                assert(data.abbreviationIsGlobal==false,"literal suffix")
                previous=data.breakpoint
                if number>=data.breakpoint then
                    text=tostring(math.floor(number/data.significandDivisor)/data.fractionDivisor)..data.abbreviation
                    break
                end
            end
            if options.german then text=text:gsub("%.",",") end
            return hidden[value]~=nil and secret(text) or text
        end,
        UnitHealthMissing=missing and function(unit,predicted)
            assert(unit=="party1" and predicted==false)
            return missing
        end,
        hbNumFormats={SurroundLeft={[2]="("},SurroundRight={[2]=")"},Places={[1]=0,[2]=places}},
        hbv_Skins_GetFrameVar=function(section,key,frame)
            assert(section=="BarText" and key=="HLTHTYPE" and frame==2)
            return healthType
        end,
        hbv_Skins_GetFrameBoolean=function(section,key,frame)
            assert(section=="BarText" and key=="HLTHINCPTC" and frame==2)
            return include
        end,
        format=function(fmt,value)
            local result=string.format(fmt,raw(value))
            return hidden[value]~=nil and secret(result) or result
        end,
        HealBot_Text_UpdateText=function(b) assert(b==button); updates=updates+1 end,
    },{__index=_G})
    setfenv(assert(loadstring(nativeFormatter.."\n"..formatter)),env)()
    env.HealBot_Text_DoSetHealthText(button,false,false)
    eq(updates,1,"text refresh dispatched")
    eq(button.text.healthupdate,true,"health text marked for update")
    return button.text.healthcomplete
end
eq(run(500,50,true,0,1),"(500)  (50%)","current HP plus percentage")
eq(run(500,50,false,0,1),"(500)","disabled option retains HP only")
eq(run(500,50.24,true,1,1),"(500)  (50.2%)","one decimal from selected text frame")
eq(run(500,50.25,true,2,1),"(500)  (50.25%)","two decimals from selected text frame")
eq(run(500,50,true,3,1),"(500)  (50%)","unsupported precision uses integer")
eq(run(500,50,true,0,3),"(50%)","percentage mode does not duplicate text")
eq(run(500,50,false,0,2),"(50%)","existing modern deficit fallback preserved")
eq(run(500,50,false,0,2,secret(500)),"(-500)","protected missing health uses native deficit")
eq(run(500,50,true,0,2,secret(500)),"(-500)  (50%)","deficit can include percentage")
eq(run(1000,100,false,0,2,secret(0)),"(-0)","zero deficit remains protected")
for _,values in ipairs({{secret(500),50},{500,secret(50)},{secret(500),secret(50)}}) do
    local text=run(values[1],values[2],true,0,1)
    eq(text,"(500)  (50%)","both fields survive protected values")
    eq(hidden[text]~=nil,true,"combined text remains protected")
end
eq(run(secret(500),secret(50),false,0,1),"(500)","protected HP-only output retained")
eq(run(secret(500),secret(50.25),false,2,3),"(50.25%)","protected percentage precision retained")
for _,protect in ipairs({function(v) return v end,secret}) do
    for _,case in ipairs({{-1,"1234"},{0,"1K"},{1,"1.2K"},{2,"1.23K"},{3,"1.234K"},{9,"1.23K"}}) do
        eq(run(protect(1234),50,false,case[1],1),"("..case[2]..")","current format selection")
        eq(run(protect(2000),50,false,case[1],2,protect(1234)),"(-"..case[2]..")","deficit format selection")
    end
    eq(run(protect(1234567),50,false,2,1),"(1.23M)","million abbreviation")
    eq(run(protect(12345),50,false,9,1),"(12.3K)","automatic medium precision")
    eq(run(protect(123456),50,false,9,1),"(123K)","automatic large precision")
    eq(run(protect(999),50,false,3,1),"(999)","small values stay whole")
    eq(run(protect(1234),50,false,1,1,nil,{lower=true}),"(1.2k)","lowercase suffix")
    eq(run(protect(1234),50,false,1,1,nil,{german=true}),"(1,2K)","localized native text is preserved")
    eq(run(protect(1234),50,false,2,1,nil,{width=4}),"(1K)","narrow bars use short precision")
    eq(run(protect(1234),50,false,2,1,nil,{noAbbreviation=true}),"(1234)","missing native formatter falls back safely")
    eq(run(protect(1234),secret(50.25),true,2,2,protect(1234)),"(-1.23K)  (50.25%)","abbreviated deficit with percentage")
end
local uf=assert(io.open("HealBot/HealBot_Util.lua","rb"))
local util=uf:read("*a"):gsub("\r\n","\n"); uf:close()
local shortHealTxt=assert(source:match("(local vShortHealTxtIsK.-\n)end\n"))
local numberFormatter=assert(util:match("(local mult=0\nfunction HealBot_Util_Round.-\nend\n)"))
    ..assert(util:match("(local nConcat={}.-function HealBot_Util_NumConcat.-\nend\n)"))
    ..assert(util:match("(local nSuffix={}.-)\nfunction HealBot_Util_SetNumSuffix"))
    ..assert(util:match("(\nfunction HealBot_Util_ReadNumber.-\n    return HealBot_Util_NumConcat%(%)\nend\n)"))
local numEnv=setmetatable({floor=math.floor,HealBot_Globals={},hbNumFormats={Places={[1]=-1,[2]=2,[3]=0}}},{__index=_G})
setfenv(assert(loadstring(numberFormatter.."\n"..shortHealTxt.."end\n")),numEnv)()
local function short(amount,frame,maxChars) return numEnv.HealBot_Text_shortHealTxt(amount,frame,maxChars or 50) end
eq(short(45000,2),"45K","positive thousands")
eq(short(-45000,2),"-45K","negative thousands match positive")
eq(short(1234567,2),"1.23M","positive millions")
eq(short(-1234567,2),"-1.23M","negative millions match positive")
eq(short(-1234,3),"-1K","negative honours selected precision")
eq(short(-1234,2,4),"-1K","negative on narrow bars")
eq(short(-999,2),-999,"small negatives stay whole")
eq(short(-45000,1),-45000,"negative with abbreviation disabled")
print("PASS: "..passed.." health text assertions (mock secret propagation)")
