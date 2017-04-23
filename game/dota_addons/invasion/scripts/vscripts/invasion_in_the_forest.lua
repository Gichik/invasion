if InvasionMode == nil then
	InvasionMode = class({})
end

GAME_ROUND = 0
MAX_ROUNDS = 30



function InvasionMode:InvasionITForestMap()

	GameRules:SetCustomGameTeamMaxPlayers( DOTA_TEAM_GOODGUYS, 5 )
	GameRules:SetCustomGameTeamMaxPlayers( DOTA_TEAM_BADGUYS, 0 )

	GameRules:SetSameHeroSelectionEnabled(false)
	
	GameRules:SetTimeOfDay( 0.11 )
	GameRules:SetHeroRespawnEnabled( false )
	GameRules:SetUseUniversalShopMode( false )
	GameRules:SetHeroSelectionTime( 20.0 )
	GameRules:SetPreGameTime( 10.0 )
	GameRules:SetPostGameTime( 60.0 )
	GameRules:SetTreeRegrowTime( 60.0 )
	GameRules:SetHeroMinimapIconScale( 0.7 )
	GameRules:SetCreepMinimapIconScale( 0.7 )
	GameRules:SetRuneMinimapIconScale( 0.7 )
	GameRules:SetGoldTickTime( 60.0 )
	GameRules:SetGoldPerTick( 0 )
	GameRules:GetGameModeEntity():SetBuybackEnabled( false )	
	GameRules:GetGameModeEntity():SetRemoveIllusionsOnDeath( true )
	GameRules:GetGameModeEntity():SetTopBarTeamValuesOverride( true )
	GameRules:GetGameModeEntity():SetTopBarTeamValuesVisible( false )	
	GameRules:SetSameHeroSelectionEnabled( false )

	ListenToGameEvent('game_rules_state_change', Dynamic_Wrap(InvasionMode, 'ForestMapGameRulesStateChange'), self)	
	--ListenToGameEvent('entity_killed', Dynamic_Wrap(InvasionMode, 'ForestMapOnEntityKilled'), self)	
	ListenToGameEvent("dota_player_killed", Dynamic_Wrap(InvasionMode, "ForestMapOnHeroKilled"), self)
	ListenToGameEvent("npc_spawned", Dynamic_Wrap(InvasionMode, 'ForestMapNPCSpawn'), self)

	GameRules:GetGameModeEntity():SetDamageFilter(Dynamic_Wrap(InvasionMode, "ForestMapDamageFilter"), self)	

end

function InvasionMode:ForestMapDamageFilter(data)
	local damage 				= data.damage
	local entindex_inflictor_const 	= data.entindex_inflictor_const
	local entindex_victim_const		= data.entindex_victim_const
	local entindex_attacker_const 	= data.entindex_attacker_const
	local damagetype_const 		= data.damagetype_const
	local ability = nil
	local victim = nil
	local attacker = nil


	if (entindex_inflictor_const) then 
		ability	= EntIndexToHScript(entindex_inflictor_const) 
	end
	if (entindex_victim_const) then 
		victim 	= EntIndexToHScript(entindex_victim_const)
	end
	if (entindex_attacker_const) then 
		attacker 	= EntIndexToHScript(entindex_attacker_const) 
		if attacker:HasItemInInventory("item_octarinity") and ability and victim then

			local multiplier = 1
			local item = nil
			local itemAbility = nil

			for i = 0, 5 do  
				item = attacker:GetItemInSlot(i)
				if item ~= nil and item:GetName() == "item_octarinity" then
					itemAbility = item
				end	
			end		

			if victim:IsRealHero() then
				multiplier = itemAbility:GetSpecialValueFor("hero_lifesteal")/100
			else
				multiplier = itemAbility:GetSpecialValueFor("creep_lifesteal")/100
			end	

			local partID1 = ParticleManager:CreateParticle("particles/items3_fx/octarine_core_lifesteal.vpcf", PATTACH_ABSORIGIN_FOLLOW, attacker)
			ParticleManager:SetParticleControl(partID1, 0, attacker:GetAbsOrigin())

			attacker:Heal(damage*multiplier, attacker)
		end
	end
	return true;
end


function InvasionMode:ForestMapNPCSpawn(data)

	local player = EntIndexToHScript(data.entindex)

	if player:IsHero() and player:GetName() == "npc_dota_hero_tidehunter" then
		if not player:HasModifier("modifier_item_ultimate_scepter")	then
			player:AddNewModifier(player, nil, "modifier_item_ultimate_scepter", {})
		end		
	end
	
	if player:IsHero() and player:GetName() == "npc_dota_hero_ember_spirit" then
		player:FindAbilityByName("ogre_magi_multicast"):SetLevel(1)	
	end	
end

function InvasionMode:ForestGameStart()


	GameRules:GetGameModeEntity():SetContextThink("NightTimeThink", 
		function()
			EmitGlobalSound("Hero_Nightstalker.Darkness")
			GameRules:SetTimeOfDay( 0.75 )
		return 235
		end,
	0.1)

	local point = Entities:FindByName( nil, "night_spawn"):GetAbsOrigin()
	local unit = CreateUnitByName("npc_night", point, true, nil, nil, DOTA_TEAM_BADGUYS )

	for i = 3, 11 do
		point = Entities:FindByName( nil, "zombie_spawn_" .. i):GetAbsOrigin()
		unit = CreateUnitByName("forest_zombie", point, true, nil, nil, DOTA_TEAM_BADGUYS )
		unit.vSpawnLoc = unit:GetOrigin()
		unit.vSpawnVector = Vector(-1,-1,0)
		unit:SetForwardVector(Vector(-1,-1,0))
	end

	GameRules:GetGameModeEntity():SetContextThink("ZombieSpawnThink", 
		function()
			local zombieName = "forest_zombie"
			local a = 255
			local b = 255
			local c = 255

			local presentTime = GameRules:GetDOTATime(false,false)

			--------------------4 minuts------------------------
			if presentTime >= 230 and presentTime < 350 then
				zombieName = "forest_ice_zombie"
				a = 0
				b = 204
				c = 204

				point = Entities:FindByName( nil, "zombie_spawn_1"):GetAbsOrigin()
				InvasionMode:ForestMapSpawnUnit(zombieName,point,a,b,c)

				point = Entities:FindByName( nil, "zombie_spawn_2"):GetAbsOrigin()
				InvasionMode:ForestMapSpawnUnit(zombieName,point,a,b,c)				
			end
			-------------------6 minuts------------------------
			if presentTime >= 350 and presentTime < 470 then
				zombieName = "forest_big_zombie"

				point = Entities:FindByName( nil, "zombie_spawn_1"):GetAbsOrigin()
				InvasionMode:ForestMapSpawnUnit(zombieName,point,a,b,c)

				point = Entities:FindByName( nil, "zombie_spawn_2"):GetAbsOrigin()
				InvasionMode:ForestMapSpawnUnit(zombieName,point,a,b,c)				
			end
			-------------------8 minuts------------------------
			if presentTime >= 470 and presentTime < 590 then
				zombieName = "forest_dead_ghost"

				point = Entities:FindByName( nil, "zombie_spawn_1"):GetAbsOrigin()
				InvasionMode:ForestMapSpawnUnit(zombieName,point,a,b,c)

				point = Entities:FindByName( nil, "zombie_spawn_2"):GetAbsOrigin()
				InvasionMode:ForestMapSpawnUnit(zombieName,point,a,b,c)				
			end
			-------------------10 minuts------------------------
			if presentTime >= 590 and presentTime < 710 then
				zombieName = "forest_fat_zombie"

				point = Entities:FindByName( nil, "zombie_spawn_1"):GetAbsOrigin()
				InvasionMode:ForestMapSpawnUnit(zombieName,point,a,b,c)

				point = Entities:FindByName( nil, "zombie_spawn_2"):GetAbsOrigin()
				InvasionMode:ForestMapSpawnUnit(zombieName,point,a,b,c)				
			end
			-------------------12 minuts-----------------------
			if presentTime >= 710 and presentTime < 830 then
				zombieName = "forest_poison_zombie"
				a = 0
				b = 255
				c = 128

				point = Entities:FindByName( nil, "zombie_spawn_1"):GetAbsOrigin()
				InvasionMode:ForestMapSpawnUnit(zombieName,point,a,b,c)

				point = Entities:FindByName( nil, "zombie_spawn_2"):GetAbsOrigin()
				InvasionMode:ForestMapSpawnUnit(zombieName,point,a,b,c)				
			end
			-------------------14 minuts-----------------------
			if presentTime >= 830 and presentTime < 950 then
				zombieName = "forest_hecate_ghost"

				point = Entities:FindByName( nil, "zombie_spawn_1"):GetAbsOrigin()
				InvasionMode:ForestMapSpawnUnit(zombieName,point,a,b,c)

				point = Entities:FindByName( nil, "zombie_spawn_2"):GetAbsOrigin()
				InvasionMode:ForestMapSpawnUnit(zombieName,point,a,b,c)				
			end
			-------------------16 minuts-----------------------
			if presentTime >= 950 then
				zombieName = "forest_leech"

				point = Entities:FindByName( nil, "zombie_spawn_1"):GetAbsOrigin()
				InvasionMode:ForestMapSpawnUnit(zombieName,point,a,b,c)

				point = Entities:FindByName( nil, "zombie_spawn_2"):GetAbsOrigin()
				InvasionMode:ForestMapSpawnUnit(zombieName,point,a,b,c)				
			end
			---------------------------------------------------

			point = Entities:FindByName( nil, "zombie_spawn_" .. RandomInt(3,6)):GetAbsOrigin()
			InvasionMode:ForestMapSpawnUnit(zombieName,point,a,b,c)

			point = Entities:FindByName( nil, "zombie_spawn_" .. RandomInt(7,11)):GetAbsOrigin()
			InvasionMode:ForestMapSpawnUnit(zombieName,point,a,b,c)
		return 60
		end,
	30)	

	GameRules:GetGameModeEntity():SetContextThink("WinGameThink", 
		function()
			local messageinfo = { message = "#popup_body_win", duration = 5}
			FireGameEvent("show_center_message",messageinfo)
			GameRules:SetGameWinner( DOTA_TEAM_GOODGUYS )
		end,
	1202)	
end

function InvasionMode:ForestMapGameRulesStateChange(keys)
	local newState = GameRules:State_Get()
	if newState == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
		InvasionMode:ForestGameStart()
	end
	if newState == DOTA_GAMERULES_STATE_POST_GAME then
		local presentTime = GameRules:GetDOTATime(false,false)
		if presentTime < 1201 then
			GameRules:SetGameWinner(DOTA_TEAM_BADGUYS)
		end
	end
end

function InvasionMode:ForestMapOnEntityKilled( event )
	local killedEntity = EntIndexToHScript( event.entindex_killed )
end

function InvasionMode:ForestMapOnHeroKilled(data)
	--	print("hero killed")

	local killedUnit = PlayerResource:GetSelectedHeroEntity(data.PlayerID)


	local newItem = CreateItem( "item_tombstone", killedUnit, killedUnit )
	newItem:SetPurchaseTime( 0 )
	newItem:SetPurchaser( killedUnit )
	local tombstone = SpawnEntityFromTableSynchronous( "dota_item_tombstone_drop", {} )
	tombstone:SetContainedItem( newItem )
	tombstone:SetAngles( 0, RandomFloat( 0, 360 ), 0 )
	FindClearSpaceForUnit( tombstone, killedUnit:GetAbsOrigin(), true )	



	local AllDead = true

	for i=0,5 do
		if PlayerResource:IsValidPlayer(i) then
			if PlayerResource:GetSelectedHeroEntity(i):IsAlive() then
				AllDead = false
			end
		end
	end

	if AllDead then
		GameRules:SetGameWinner(DOTA_TEAM_BADGUYS)
	end
end

function InvasionMode:ForestMapSpawnUnit(name,point,a,b,c)
	local unit = CreateUnitByName(name, point, true, nil, nil, DOTA_TEAM_BADGUYS )
	unit.vSpawnLoc = unit:GetOrigin()
	unit.vSpawnVector = Vector(-1,-1,0)
	unit:SetForwardVector(Vector(-1,-1,0))
	unit:SetRenderColor(a, b, c)
end