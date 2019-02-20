
require( 'modifiers_links' )
require( 'timers' )

if InvasionMode == nil then
	InvasionMode = class({})
end

MONSTERS_RESPAWN_TIME = 10
WAVE_RESPAWN_TIME = 1
CHEESE_DROP_PERC = 30
MILK_DROP_PERC = 30

function InvasionMode:InvasionMap()

	
	GameRules:SetCustomGameTeamMaxPlayers( DOTA_TEAM_GOODGUYS, 4 )
	GameRules:SetCustomGameTeamMaxPlayers( DOTA_TEAM_BADGUYS, 0 )

	GameRules:SetSameHeroSelectionEnabled(false)
	
	GameRules:SetHeroRespawnEnabled( true )
	GameRules:SetUseUniversalShopMode( true )
	GameRules:SetHeroSelectionTime( 30.0 )
	GameRules:SetStrategyTime( 0.0 )
	GameRules:SetShowcaseTime( 0.0 )	
	GameRules:SetPreGameTime( 10.0 )
	GameRules:SetPostGameTime( 60.0 )
	GameRules:SetTreeRegrowTime( 60.0 )
	GameRules:SetHeroMinimapIconScale( 0.7 )
	GameRules:SetCreepMinimapIconScale( 0.7 )
	GameRules:SetRuneMinimapIconScale( 0.7 )
	GameRules:SetGoldTickTime( 1 )
	GameRules:SetGoldPerTick( 0 )

	GameRules:GetGameModeEntity():SetRemoveIllusionsOnDeath( true )
	GameRules:GetGameModeEntity():SetTopBarTeamValuesOverride( true )
	GameRules:GetGameModeEntity():SetTopBarTeamValuesVisible( false )
	--GameRules:GetGameModeEntity():SetRecommendedItemsDisabled( true )

	ListenToGameEvent('game_rules_state_change', Dynamic_Wrap(InvasionMode, 'InvasionMapGameRulesStateChange'), self)
	ListenToGameEvent('entity_killed', Dynamic_Wrap(InvasionMode, 'InvasionEntityKilled'), self)		
	ListenToGameEvent('npc_spawned', Dynamic_Wrap(InvasionMode, 'InvasionOnNPCSpawn'), self)	

	AddFOWViewer(DOTA_TEAM_BADGUYS, Entities:FindByName( nil, "dota_shop"):GetAbsOrigin(), 1000, -1, false)

end


 function InvasionMode:InvasionMapGameRulesStateChange(data)
	local newState = GameRules:State_Get()
	if newState == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
		InvasionMode:InvasionGameStart()
	end
	if newState == DOTA_GAMERULES_STATE_POST_GAME then
		local presentTime = GameRules:GetDOTATime(false,false)
		if presentTime < 1479 then
			GameRules:SetGameWinner(DOTA_TEAM_BADGUYS)
		end
	end

end


function InvasionMode:InvasionOnNPCSpawn(data)

	local npc = EntIndexToHScript(data.entindex)
end


function InvasionMode:InvasionGameStart()

	InvasionMode:InvasionSpawnMoobs()

	Timers:CreateTimer(2,function()
		EmitGlobalSound("Invasion.Intro")	
		GameRules:SendCustomMessage("<font color='#58ACFA'>Akira Yamaoka – Never Forgive Me</font>", 0, 0)
		return nil
	end)

	Timers:CreateTimer(595,function()
		EmitGlobalSound("Invasion.Summertime")	
		GameRules:SendCustomMessage("<font color='#58ACFA'>Lana Del Rey - Summertime Sadness (smoke remix)</font>", 0, 0)
		return nil
	end)

--5 минута, 1я ночь
	Timers:CreateTimer(300,function()
		EmitGlobalSound("Invasion.Night")
		EmitGlobalSound("Invasion.HalloweenJC")
		GameRules:SendCustomMessage("<font color='#58ACFA'>Halloween - John Carpenter</font>", 0, 0)
		self:SpawnNightZombie(1)
	return nil
	end)


--15 минута, 2я ночь
	Timers:CreateTimer(900,function()
		EmitGlobalSound("invasion.Night")
		EmitGlobalSound("Invasion.HalloweenJC")
		GameRules:SendCustomMessage("<font color='#58ACFA'>Halloween - John Carpenter</font>", 0, 0)
 		self:SpawnNightZombie(2)
		return nil
	end)

--25 минута, 3я ночь
	Timers:CreateTimer(1500,function()
		EmitGlobalSound("invasion.Night")
		EmitGlobalSound("Invasion.HalloweenJC")
		GameRules:SendCustomMessage("<font color='#58ACFA'>Halloween - John Carpenter</font>", 0, 0)
		self:SpawnNightZombie(3)
		return nil
	end)

 --30 минута, конец 3ей ночи, день
	Timers:CreateTimer(1800,function()
	 	EmitGlobalSound("Invasion.Castaways")
		GameRules:SendCustomMessage("<font color='#58ACFA'>The Castaways – Liar Liar</font>", 0, 0) 
		return nil
	end) 
 
	Timers:CreateTimer(1860,function()
		GameRules:SetGameWinner( DOTA_TEAM_GOODGUYS )
		return nil
	end)

end

function InvasionMode:InvasionSpawnMoobs()
	local point = nil
	local unit = nil
	--boss_spawner_2
	--wave_spawner_1


	---sheeps and pigs
	for i = 1, 5 do
		point = Entities:FindByName( nil, "start_spawner_1"):GetAbsOrigin()
		unit = CreateUnitByName("npc_classic_pig", point + RandomVector(200), true, nil, nil, DOTA_TEAM_NEUTRALS)
		unit.respawn = true		
		unit.vSpawnLoc = unit:GetOrigin()
		unit.team = DOTA_TEAM_NEUTRALS		
		--unit.vSpawnVector = Vector(-1,-1,0)
		unit:SetForwardVector(RandomVector(1))
	end	

	for i = 1, 5 do
		point = Entities:FindByName( nil, "start_spawner_2"):GetAbsOrigin()
		unit = CreateUnitByName("npc_classic_sheep", point + RandomVector(200), true, nil, nil, DOTA_TEAM_NEUTRALS)
		unit.respawn = true			
		unit.vSpawnLoc = unit:GetOrigin()
		unit.team = DOTA_TEAM_NEUTRALS			
		--unit.vSpawnVector = Vector(-1,-1,0)
		unit:SetForwardVector(RandomVector(1))
	end	


	---forest zombie
	for i = 1, 5 do
		point = Entities:FindByName( nil, "forest_spawner_" .. i):GetAbsOrigin()
		for j = 1, 5 do
			unit = CreateUnitByName("npc_classic_half_zombie", point + RandomVector(200), true, nil, nil, DOTA_TEAM_BADGUYS )
			unit.respawn = true					
			unit.vSpawnLoc = unit:GetOrigin()
			unit.team = DOTA_TEAM_BADGUYS			
			--unit.vSpawnVector = Vector(-1,-1,0)
			unit:SetForwardVector(RandomVector(1))
		end
	end	

	
	---city zombie
	local zombieName = { 
        "npc_classic_zombie","npc_classic_zombie",
        "npc_classic_big_zombie","npc_classic_big_zombie","npc_classic_big_zombie",
        "npc_classic_ghoul","npc_classic_ghoul"
        } 

	for i = 1, 7 do
		point = Entities:FindByName( nil, "city_spawner_" .. i):GetAbsOrigin()
		for j = 1, 5 do
			unit = CreateUnitByName(zombieName[i], point + RandomVector(200), true, nil, nil, DOTA_TEAM_BADGUYS )
			unit.respawn = true		
			unit.vSpawnLoc = unit:GetOrigin()
			unit.team = DOTA_TEAM_BADGUYS			
			--unit.vSpawnVector = Vector(-1,-1,0)
			unit:SetForwardVector(RandomVector(1))
		end
	end	


	--bosses
	point = Entities:FindByName( nil, "boss_spawner_1"):GetAbsOrigin()
	unit = CreateUnitByName("npc_classic_witch", point, true, nil, nil, DOTA_TEAM_BADGUYS)
	unit.respawn = false	
	unit:SetForwardVector(RandomVector(1))

	point = Entities:FindByName( nil, "boss_spawner_2"):GetAbsOrigin()
	unit = CreateUnitByName("npc_boss_mutant", point, true, nil, nil, DOTA_TEAM_BADGUYS)
	unit.respawn = false	
	unit:SetForwardVector(RandomVector(1))


end

 

function InvasionMode:SpawnNightZombie(nightNumber)
	local point = nil
	local unit = nil
	local time = 1
	--boss_spawner_2
	--wave_spawner_1

	if nightNumber == 1 then
		Timers:CreateTimer(1,function()
			time = time + 1

			for i = 1, 4 do 
				point = Entities:FindByName( nil, "wave_spawner_" .. i):GetAbsOrigin()
				unit = CreateUnitByName("npc_classic_wave_zombie", point, true, nil, nil, DOTA_TEAM_BADGUYS )
				unit.respawn = true
				unit.nightZombie = true		
				unit.vSpawnLoc = unit:GetOrigin()
				unit.team = DOTA_TEAM_BADGUYS			
				unit:SetForwardVector(RandomVector(1))
			end

			if time <= 20 then
				return 0.5
			else
				return nil
			end
		end)
	end


	if nightNumber == 2 then
		Timers:CreateTimer(1,function()
			time = time + 1

			for i = 5, 6 do 
				point = Entities:FindByName( nil, "wave_spawner_" .. i):GetAbsOrigin()
				unit = CreateUnitByName("npc_classic_wave_ghost", point + RandomVector(200), true, nil, nil, DOTA_TEAM_BADGUYS )
				unit.respawn = true
				unit.nightZombie = true		
				unit.vSpawnLoc = unit:GetOrigin()
				unit.team = DOTA_TEAM_BADGUYS			
				unit:SetForwardVector(RandomVector(1))
			end

			for i = 1, 4 do 
				point = Entities:FindByName( nil, "wave_spawner_" .. i):GetAbsOrigin()
				unit = CreateUnitByName("npc_classic_wave_big_zombie", point, true, nil, nil, DOTA_TEAM_BADGUYS )
				unit.respawn = true
				unit.nightZombie = true		
				unit.vSpawnLoc = unit:GetOrigin()
				unit.team = DOTA_TEAM_BADGUYS			
				unit:SetForwardVector(RandomVector(1))
			end

			if time <= 13 then
				return 1
			else
				return nil
			end
		end)
	end

	if nightNumber == 3 then
		Timers:CreateTimer(1,function()
			time = time + 1

			for i = 5, 6 do 
				point = Entities:FindByName( nil, "wave_spawner_" .. i):GetAbsOrigin()
				unit = CreateUnitByName("npc_classic_wave_ghost", point + RandomVector(200), true, nil, nil, DOTA_TEAM_BADGUYS )
				unit.respawn = true
				unit.nightZombie = true		
				unit.vSpawnLoc = unit:GetOrigin()
				unit.team = DOTA_TEAM_BADGUYS			
				unit:SetForwardVector(RandomVector(1))
			end

			for i = 1, 4 do 
				point = Entities:FindByName( nil, "wave_spawner_" .. i):GetAbsOrigin()
				unit = CreateUnitByName("npc_classic_wave_ghoul", point, true, nil, nil, DOTA_TEAM_BADGUYS )
				unit.respawn = true
				unit.nightZombie = true		
				unit.vSpawnLoc = unit:GetOrigin()
				unit.team = DOTA_TEAM_BADGUYS			
				unit:SetForwardVector(RandomVector(1))
			end

			if time <= 13 then
				return 0.5
			else
				return nil
			end
		end)
	end


end


function InvasionMode:InvasionEntityKilled (data)
	local killedEntity = EntIndexToHScript(data.entindex_killed)

	if killedEntity:GetUnitName() == "NPC_base" then
		GameRules:SetGameWinner(DOTA_TEAM_BADGUYS)
		EmitGlobalSound("Invasion.HommerWin")
	end	


	if killedEntity:IsCreature() then
		if killedEntity.respawn  then
			if killedEntity.nightZombie then
				self:RespawnCreature(killedEntity,WAVE_RESPAWN_TIME)
			else
				self:RespawnCreature(killedEntity,MONSTERS_RESPAWN_TIME)
			end
		end

		if killedEntity:GetUnitName() == "npc_classic_pig" then
            if RollPercentage(CHEESE_DROP_PERC) then
                self:CreateDrop("item_custom_cheese", killedEntity:GetAbsOrigin())
            end
		end	

		if killedEntity:GetUnitName() == "npc_classic_sheep" then
            if RollPercentage(MILK_DROP_PERC) then
                self:CreateDrop("item_milk", killedEntity:GetAbsOrigin())
            end
		end

		if killedEntity:GetUnitName() == "npc_classic_witch" then
			for i = 1, 3 do
            	self:CreateDrop("item_bag_of_gold", killedEntity:GetAbsOrigin() + RandomVector(RandomFloat(50, 300)) )
        	end
		end

		if killedEntity:GetUnitName() == "npc_boss_mutant" then
			for i = 1, 5 do
            	self:CreateDrop("item_bag_of_gold", killedEntity:GetAbsOrigin() + RandomVector(RandomFloat(50, 300)) )
        	end
		end

	end


end
 
function InvasionMode:CreateDrop (itemName, pos)
   local newItem = CreateItem(itemName, nil, nil)
   newItem:SetPurchaseTime(0)
   CreateItemOnPositionSync(pos, newItem)
   newItem:LaunchLoot(false, 300, 0.75, pos + RandomVector(RandomFloat(50, 350)))
end

function InvasionMode:RespawnCreature(entity,time)
    local team = entity.team
    local name = entity:GetUnitName()
    local SpawnLoc = entity.vSpawnLoc

    if entity.nightZombie then
    	if not GameRules:IsDaytime() then
		    Timers:CreateTimer(time, function()
		   		local unit = CreateUnitByName(name, SpawnLoc, true, nil, nil, team )
		   		unit.nightZombie = true
		   		unit.respawn = true
		        unit.vSpawnLoc = SpawnLoc	   
		        unit.team = team
				unit:SetForwardVector(RandomVector(1))
		      	return nil
		    end)
		end
	else
	    Timers:CreateTimer(time, function()
	   		local unit = CreateUnitByName(name, SpawnLoc, true, nil, nil, team )
	   		unit.respawn = true
	        unit.vSpawnLoc = SpawnLoc 
	        unit.team = team
			unit:SetForwardVector(RandomVector(1))
	      	return nil
	    end)
	end
end
