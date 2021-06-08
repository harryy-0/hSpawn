include("shared.lua")


function ENT:Draw()

dis = LocalPlayer():GetPos():Distance( self:GetPos() ) 

   self:DrawModel()
   
   if ( dis < 300 ) then 
      
      local offset = Vector( 0, .02, 18)
      local ang = LocalPlayer():EyeAngles()
      local pos = self:GetPos() + offset + ang:Up()
    
      ang:RotateAroundAxis( ang:Forward(), 90 )
      ang:RotateAroundAxis( ang:Right(), 90 )
    

      cam.Start3D2D( pos, Angle( 0, ang.y, 90 ), 0.05)
         surface.SetDrawColor(Color(0, 0, 0))
         surface.DrawRect(-55, 15, 180, 50)
         surface.SetFont("DermaLarge")
         surface.SetTextPos(-39, 27)
         surface.SetTextColor(Color(255, 255, 255))
         surface.DrawText("Spawn Point")
      cam.End3D2D()
   end

end

