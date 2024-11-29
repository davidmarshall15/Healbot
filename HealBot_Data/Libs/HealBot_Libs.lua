local libLSM=nil
local libLDB11=nil
local libLDBIcon=nil
local LibDeflate=nil
local LibCustomGlow=nil
local LibSerial=nil
local libCHC=nil

function HealBot_Libs_LSM()
    libLSM=libLSM or (LibStub and LibStub:GetLibrary("LibSharedMedia-3.0", true))
    return libLSM
end

function HealBot_Libs_LDB11()
    libLDB11=libLDB11 or (LibStub and LibStub("LibDataBroker-1.1", true))
    return libLDB11
end

function HealBot_Libs_LDBIcon()
    libLDBIcon=libLDBIcon or (LibStub and LibStub("LibDBIcon-1.0", true))
    return libLDBIcon
end

function HealBot_Libs_CHC()
    if HEALBOT_GAME_VERSION<4 then
        libCHC=libCHC or (LibStub and LibStub("LibHealComm-4.0", true))
    end
    return libCHC
end

function HealBot_Libs_LibC()
    LibDeflate=LibDeflate or (LibStub and LibStub:GetLibrary("LibDeflate"))
    return LibDeflate
end

function HealBot_Libs_LibGlow()
    LibCustomGlow=LibCustomGlow or (LibStub and LibStub:GetLibrary("LibCustomGlow-1.0"))
    return LibCustomGlow
end

function HealBot_Libs_LibSerial()
    LibSerial=LibSerial or (LibStub and LibStub:GetLibrary("AceSerializer-3.0"))
    return LibSerial
end
