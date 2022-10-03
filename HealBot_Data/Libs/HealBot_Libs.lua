local libLSM = LibStub and LibStub:GetLibrary("LibSharedMedia-3.0", true)
local libLDB11 = LibStub and LibStub("LibDataBroker-1.1", true)
local libLDBIcon = LibStub and LibStub("LibDBIcon-1.0", true)
local LibDeflate = LibStub and LibStub:GetLibrary("LibDeflate")
local libCHC = nil
local libCD = nil

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

function HealBot_Libs_CD()
    return libCD
end

function HealBot_Libs_LibC()
    return LibDeflate
end

if HEALBOT_GAME_VERSION<4 then
    if HEALBOT_GAME_VERSION==1 then 
        libCD = libCD or (LibStub and LibStub("LibClassicDurations"))
    end
    libCHC = libCHC or (LibStub and LibStub("LibHealComm-4.0", true))
end