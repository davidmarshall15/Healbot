local libLSM=LibStub and LibStub:GetLibrary("LibSharedMedia-3.0", true)
local libLDB11=LibStub and LibStub("LibDataBroker-1.1", true)
local libLDBIcon=LibStub and LibStub("LibDBIcon-1.0", true)
local LibDeflate=LibStub and LibStub:GetLibrary("LibDeflate")
local LibCustomGlow=LibStub and LibStub:GetLibrary("LibCustomGlow-1.0")

local libCHC=nil
if HEALBOT_GAME_VERSION<4 then
    libCHC=libCHC or (LibStub and LibStub("LibHealComm-4.0", true))
end

function HealBot_Libs_LSM()
    return libLSM
end

function HealBot_Libs_LDB11()
    return libLDB11
end

function HealBot_Libs_LDBIcon()
    return libLDBIcon
end

function HealBot_Libs_CHC()
    return libCHC
end

function HealBot_Libs_LibC()
    return LibDeflate
end

function HealBot_Libs_LibGlow()
    return LibCustomGlow
end
