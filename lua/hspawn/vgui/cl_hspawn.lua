
function hAddSpawn(data)

	option = optionpnl:Add("DButton")

	option:Dock(LEFT)
	option:SetWide(320)
	option:SetText("")


	function option:Paint(w, h)
	timeleft = string.FormattedTime(timer.TimeLeft( "SitCooldown" ), "%02i:%02i")

		draw.RoundedBox(0, 0, 0, w, h, data.boxcolor)
		draw.SimpleText(data.name, "hspawntitle", w*.5, h*.5, data.namecolor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		draw.SimpleText(data.desc, "hspawntext", w*.5, h*.55, data.desccolor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

		if self:IsHovered() then 
			draw.RoundedBox(0, 0, 0, w, h, XeninUI.Theme.Navbar)
			draw.SimpleText(data.name, "hspawntitle", w*.5, h*.5, data.namecolor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			draw.SimpleText(data.desc, "hspawntext", w*.5, h*.55, data.desccolor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	
			if timeleft == nil then return end
			draw.SimpleText(timeleft, "hspawntitle", w*.5, h - 50, data.timecolor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end

end

shouldOccur = true
	function option:DoClick()
	if not shouldOccur then
	return end
		shouldOccur = false
		if timer.Exists("SitCooldown") then return end
		timer.Create( "SitCooldown", hspawn.SpawnDelay, 1 , function() shouldOccur = true end )
		net.Start("TPVect")
		net.WriteVector(data.vector)
		net.SendToServer()
	end	
end



net.Receive("SpawnOpenUI", function()
	
	OPENUI()

end)

net.Receive("GetPos", function()
	
	pos = tostring(net.ReadVector())

	chat.AddText(color_green, "Dev Tool | ", color_white, "Your pos is: "..pos)

end)


net.Receive("hspawn_errormessage", function()
    
    local msg = net.ReadString()

    chat.AddText( color_green,"Spawn | ", color_white, msg)

end)


net.Receive("RemovePanel", function(len, ply)

	if not IsValid(hspawnmain) then return end
	hspawnmain:Remove()

	
end)


concommand.Add("hspawn_removepanel", function(ply)
if not ply:IsSuperAdmin() then return end
if not IsValid(hspawnmain) then return end
	hspawnmain:Remove()
end)

concommand.Add("hspawn_addpanel", function(ply)
if not ply:IsSuperAdmin() then return end
if IsValid(hspawnmain) then return end
	OPENUI()
end)


hook.Add("InitPostEntity", "SpawnOpenUICL", OPENUI)

surface.CreateFont( "hspawntitle", {
	font = "Bebas Neue", 
	extended = false,
	size = 50,
	weight = 100,
} )

surface.CreateFont( "hspawntext", {
	font = "Abel", 
	size = 20,
	weight = 10,
} )