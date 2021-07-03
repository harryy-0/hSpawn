hspawn = hspawn or {}
function OPENUI()

	if IsValid(hspawnmain) then
		hspawnmain:Remove()
	end
	hspawnmain = vgui.Create("HSpawnPanel")
	hspawnmain:SetSize(ScrW(), ScrH())


-- ADD OPTIONS HERE


	HaddOption({
		name = "Fountain",

		desc = "The big water thing.",

		vector = Vector(-1889.687500, -1370.375000, -195.968750),

		boxcolor = Color(77, 77, 77, 255),

		namecolor = Color(255,255,255),

		desccolor = Color(255,255,255),

		timecolor = Color(255,255,255)
	})

	HaddOption({
		name = "Industrial",

		desc = "The warehouses.",

		vector = Vector(-3670.906250, 1292.718750, -203.968750),

		boxcolor = Color(77, 77, 77, 255),

		namecolor = Color(255,255,255),

		desccolor = Color(255,255,255),

		timecolor = Color(255,255,255)
	})

	HaddOption({
		name = "Main Spawn",

		desc = "Main spawn area, go check out the NPCs",

		vector = Vector(1016.843750, -517.031250, -195.968750),

		boxcolor = Color(77, 77, 77, 255),

		namecolor = Color(255,255,255),

		desccolor = Color(255,255,255),

		timecolor = Color(255,255,255)
	})

	HaddOption({
		name = "Petrol Station",

		desc = "The petrol station.",

		vector = Vector(-1244.406250, -7088.625000, -203.968750),

		boxcolor = Color(77, 77, 77, 255),

		namecolor = Color(255,255,255),

		desccolor = Color(255,255,255),

		timecolor = Color(255,255,255)
	})

	HaddOption({
		name = "Basketball Court",

		desc = "The place with the orange ball.",

		vector = Vector(1281.343750, 6083.625000, -203.968750),

		boxcolor = Color(77, 77, 77, 255),

		namecolor = Color(255,255,255),

		desccolor = Color(255,255,255),

		timecolor = Color(255,255,255)
	})
	
		HaddOption({
		name = "Mining Area",

		desc = "The place where you mine for minerals.",

		vector = Vector(5887.531250, 1199.218750, -192.750000),

		boxcolor = Color(77, 77, 77, 255),

		namecolor = Color(255,255,255),

		desccolor = Color(255,255,255),

		timecolor = Color(255,255,255)
	})


-- END OF OPTIONS HERE
end

function HaddOption(data)

	option = optionpnl:Add("DButton")

	option:Dock(LEFT)
	option:SetWide(320)
	option:SetText("")


	function option:Paint(w, h)
	timeleft = string.FormattedTime(timer.TimeLeft( "SitCooldown" ), "%02i:%02i")

	if self:IsHovered() then 
		draw.RoundedBox(0, 0, 0, w, h, ColorAlpha(data.boxcolor, 240))
		draw.SimpleText(data.name, "hspawntitle", w*.5, h*.5, data.namecolor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		draw.SimpleText(data.desc, "hspawntext", w*.5, h*.55, data.desccolor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

		if timeleft == nil then return end
		draw.SimpleText(timeleft, "hspawntitle", w*.5, h - 50, data.timecolor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

	else
		draw.RoundedBox(0, 0, 0, w, h, data.boxcolor)
		draw.SimpleText(data.name, "hspawntitle", w*.5, h*.5, data.namecolor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		draw.SimpleText(data.desc, "hspawntext", w*.5, h*.55, data.desccolor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
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