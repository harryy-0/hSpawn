AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")


function ENT:Initialize()
    self:SetModel("models/hunter/misc/platehole1x1a.mdl")
    self:PhysicsInit(SOLID_NONE)
    self:SetMaterial("models/debug/debugwhite")
    self:SetSolid(SOLID_VPHYSICS)
    self:SetColor(Color(255, 0, 0, 0))


    

    
    phys = self:GetPhysicsObject()

    if phys:IsValid() then
        phys:Wake()
        phys:SetMass(50)
    end
end

