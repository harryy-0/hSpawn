util.AddNetworkString("SpawnOpenUI")
util.AddNetworkString("GetPos")
util.AddNetworkString("TPVect")
util.AddNetworkString("hspawn_errormessage")
util.AddNetworkString("RemovePanel")
util.AddNetworkString("SetTime")


hook.Add("PlayerSay", "GetPosCMD", function(ply, txt)
	if not (string.lower(txt) == "!getpos") then return end

	net.Start("GetPos")
	net.WriteVector(ply:GetPos())
	net.Send(ply)
	
	return ""
end)


hook.Add("PlayerSpawn", "SpawnOpenUI", function(ply)
	local time = string.FormattedTime(timer.TimeLeft( "SitCooldown" ), "%02i:%02i")

	net.Start("SpawnOpenUI")
	net.WriteString(time)
	net.Send(ply)

end)

hook.Add("PlayerSelectSpawn", "RandomSpawn", function(pl)
	if not hspawn.EnableInitialSpawnPoints then return end

	local spawnpoints = ents.FindByClass("spawnpoint")
	local random = math.random(#spawnpoints)

	return spawnpoints[random]
end)


hook.Add("InitPostEntity", "SpawnSpawnPoints", function(pl)
if not hspawn.EnableInitialSpawnPoints then return end
	for k,v in pairs(hspawn.InitialSpawnPoints) do
		local spawnpoint = ents.Create( "spawnpoint" )
		spawnpoint:SetPos(v)
		spawnpoint:Spawn()
			if spawnpoint:IsValid() then
			print("[HSPAWN] Spawned "..k, v)
		else
			print("[HSPAWN][FAILED] Spawned "..k, v)
		end
	end
end)

shouldOccurSH = true



net.Receive("TPVect", function(len, ply)
	timeleft = string.FormattedTime(timer.TimeLeft( "SitCooldown" ), "%02i:%02i")

	if not shouldOccurSH then
		print("rejected")
		net.Start("SetTime")
		net.WriteString(timeleft)
		net.Send(ply)
	return end
		shouldOccurSH = false
		timer.Create( "SitCooldown", hspawn.SpawnDelay, 1 , function() shouldOccurSH = true end )

	local phys = ply:GetPhysicsObject()
	local vec = net.ReadVector()

	net.Start("RemovePanel")
	net.Send(ply)
	ply:SetPos(vec)


end)


function hspawn_message(msg, ply)

	net.Start("hspawn_errormessage")
	net.WriteString(msg)
	net.Send(ply)
	
end