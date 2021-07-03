hspawn = hspawn or {}

--[Do not touch!]--

function OPENUI()
	if IsValid(hspawnmain) then
		hspawnmain:Remove()
	end
	hspawnmain = vgui.Create("HSpawnPanel")
	hspawnmain:SetSize(ScrW(), ScrH())

--[ Config Begins ]--

	hAddSpawn({
		name = "Fountain",
		desc = "The big water thing.",
		
		vector = Vector(-1889.687500, -1370.375000, -195.968750),
	})

	hAddSpawn({
		name = "Industrial",
		desc = "The warehouses.",

		vector = Vector(-3670.906250, 1292.718750, -203.968750),
	})

	hAddSpawn({
		name = "Main Spawn",
		desc = "Main spawn area, go check out the NPCs",

		vector = Vector(1016.843750, -517.031250, -195.968750),
	})

	hAddSpawn({
		name = "Petrol Station",
		desc = "The petrol station.",

		vector = Vector(-1244.406250, -7088.625000, -203.968750),
	})

	hAddSpawn({
		name = "Basketball Court",
		desc = "The place with the orange ball.",

		vector = Vector(1281.343750, 6083.625000, -203.968750),
	})
	
		hAddSpawn({
		name = "Mining Area",
		desc = "The place where you mine for minerals.",

		vector = Vector(5887.531250, 1199.218750, -192.750000),
	})
end

hspawn = {

	SpawnDelay = 1,

    EnableInitialSpawnPoints = false, -- If disabled they are automatically in the maps spawn
    
	InitialSpawnPoints = {  -- Spawn points when the players first join the server. (Only needed if using Initial spawn points)

		Vector(-888.625000, -287.562500, 12224.031250),
		Vector(-746.906250, -282.375000, 12224.031250),
		Vector(-636.500000, -284.187500, 12224.031250),
		Vector( -515.312500, -281.843750, 12224.031250),
		Vector(-510.718750, -76.281250, 12224.031250),
		Vector(-669.687500, -70.250000, 12224.031250),
		Vector(-842.687500, -66.812500, 12224.031250),
		Vector(-841.875000, 134.531250, 12224.031250),
		Vector(-694.531250, 133.968750, 12224.031250),
		Vector(-510.009857, 98.622513, 12224.031250)

	}

}