hspawn = hspawn or {}

function hAddSpawn(data)
    
	data.boxcolor = data.boxcolor or Color(77, 77, 77, 255)
	data.namecolor = data.namecolor or Color(255,255,255)
	data.desccolor = data.desccolor or Color(255,255,255, 150)
	data.timecolor = data.timecolor or Color(255,255,255)
    

	option = optionpnl:Add("DButton")

	option:Dock(LEFT)
	option:SetWide(320)
	option:SetText("")


	function option:Paint(w, h)
	timeleft = string.FormattedTime(timer.TimeLeft( "SitCooldown" ), "%02i:%02i")

		draw.RoundedBox(0, 0, 0, w, h, data.boxcolor, 100)
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

	chat.AddText(color_green, "hSpawn | ", color_white, "Your pos is: "..pos)
	chat.AddText(color_red, "hSpawn | ", color_white, "Remember to add commas when adding to config")

end)


net.Receive("hspawn_errormessage", function()
    
    local msg = net.ReadString()

    chat.AddText( color_green,"Spawn | ", color_white, msg)

end)


net.Receive("RemovePanel", function(len, ply)

	if not IsValid(hspawnmain) then return end
	hspawnmain:Remove()

	
end)


concommand.Add("hspawn_close", function(ply)
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


XeninUI:CreateFont("hspawntitle", 45, 100)
XeninUI:CreateFont("hspawntext", 18, 75)