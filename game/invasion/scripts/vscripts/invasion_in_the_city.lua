
if InvasionMode == nil then
	InvasionMode = class({})
end

BOSS_LEVEL = 0

SOUND_TABLE = {
"Invasion.ZombieMan",	
"Invasion.ZombieGirl",
"Invasion.ZombieGirl",
"Invasion.ZombieFat",
"Invasion.ZombieFast",
"Invasion.ZombieDog"
}


function InvasionMode:CityMap()

	
	GameRules:SetCustomGameTeamMaxPlayers( DOTA_TEAM_GOODGUYS, 4 )
	GameRules:SetCustomGameTeamMaxPlayers( DOTA_TEAM_BADGUYS, 0 )

	GameRules:SetSameHeroSelectionEnabled(false)
	
	GameRules:SetTimeOfDay( 0.5 )
	GameRules:SetHeroRespawnEnabled( true )
	GameRules:SetUseUniversalShopMode( true )
	GameRules:SetHeroSelectionTime( 30.0 )
	GameRules:SetStrategyTime( 0.0 )
	GameRules:SetShowcaseTime( 0.0 )		
	GameRules:SetPreGameTime( 30.0 )
	GameRules:SetPostGameTime( 60.0 )
	GameRules:SetTreeRegrowTime( 60.0 )
	GameRules:SetHeroMinimapIconScale( 0.7 )
	GameRules:SetCreepMinimapIconScale( 0.7 )
	GameRules:SetRuneMinimapIconScale( 0.7 )
	GameRules:SetGoldTickTime( 1 )
	GameRules:SetGoldPerTick( 8 )
	GameRules:GetGameModeEntity():SetRemoveIllusionsOnDeath( true )
	GameRules:GetGameModeEntity():SetTopBarTeamValuesOverride( true )
	GameRules:GetGameModeEntity():SetTopBarTeamValuesVisible( false )
	GameRules:GetGameModeEntity():SetFixedRespawnTime(30)
	--GameRules:GetGameModeEntity():SetRecommendedItemsDisabled( true )
	GameRules:SetSameHeroSelectionEnabled( false )

	ListenToGameEvent('game_rules_state_change', Dynamic_Wrap(InvasionMode, 'CityMapGameRulesStateChange'), self)
	ListenToGameEvent('entity_killed', Dynamic_Wrap(InvasionMode, 'CityMapEntityKilled'), self)	
	ListenToGameEvent("dota_player_killed", Dynamic_Wrap(InvasionMode, "CityMapOnHeroKilled"), self)	
	ListenToGameEvent("npc_spawned", Dynamic_Wrap(InvasionMode, 'CityMapOnNPCSpawn'), self)	
	AddFOWViewer( DOTA_TEAM_NEUTRALS, Vector(0,0,0), 10000, -1, false)

	GameRules:GetGameModeEntity():SetDamageFilter(Dynamic_Wrap(InvasionMode, "CityMapDamageFilter"), self)	

end

function InvasionMode:CityMapDamageFilter(data)
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


function InvasionMode:CityMapGameRulesStateChange(keys)
	local newState = GameRules:State_Get()

	if newState == DOTA_GAMERULES_STATE_PRE_GAME then
		EmitGlobalSound("Invasion.Horror")
		GameRules:SendCustomMessage("<font color='#58ACFA'>Найдите себе место, где можно переждать ночь и забаррикадируйтесь там!</font>", 0, 0)
		GameRules:SendCustomMessage("<font color='#58ACFA'>Find a place to wait out the night and build barricade!</font>", 0, 0)

		local messageinfo = { message = "#popup_body_city_start", duration = 5}
		FireGameEvent("show_center_message",messageinfo)   
	end

	if newState == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
		InvasionMode:CityMapGameStart()
	end

	if newState == DOTA_GAMERULES_STATE_POST_GAME then
		local presentTime = GameRules:GetDOTATime(false,false)
		if presentTime < 1201 then
			GameRules:SetGameWinner(DOTA_TEAM_BADGUYS)
		end
	end
end


function InvasionMode:CityMapOnNPCSpawn(data)
	local player = EntIndexToHScript(data.entindex)

	if player:IsHero() then
		if not player.next_spawn then
			player.next_spawn = true;

			if player:GetName() == "npc_dota_hero_tidehunter" then
				player:AddNewModifier(player, nil, "modifier_item_ultimate_scepter", {})
			end

			if player:GetName() == "npc_dota_hero_ember_spirit" then
				player:FindAbilityByName("ogre_magi_multicast"):SetLevel(1)	
			end	

			if player:GetName() == "npc_dota_hero_invoker" then
				player:FindAbilityByName("black_dragon_splash_attack"):SetLevel(1)	
			end
			
		end
	end

	if player:IsHero() then
		--[[
		if not player.next_spawn then
			player.next_spawn = true;
			local newItem = CreateItem("item_wood_wall", nil, nil)
	   		newItem:SetPurchaseTime(0)
	   		newItem:SetCurrentCharges(3)
	   		player:AddItem(newItem)				
		end]]
		player:AddNewModifier(player, nil, "modifier_attack_immune", {duration = 15})
	end

end


function InvasionMode:CityMapGameStart()

	GameRules:GetGameModeEntity():SetContextThink("WinGameThink", 
		function()
			local messageinfo = { message = "#popup_body_win", duration = 5}
			FireGameEvent("show_center_message",messageinfo)
			GameRules:SetGameWinner( DOTA_TEAM_GOODGUYS )
		end,
		1202)

	GameRules:GetGameModeEntity():SetContextThink("NightTimeThink", 
	function()
		StopSoundEvent("Invasion.Horror",nil)
		EmitGlobalSound("Invasion.Horror")
		GameRules:SendCustomMessage("<font color='#58ACFA'>OST Путевой обходчик – Колыбельная</font>", 0, 0)
		GameRules:SendCustomMessage("<font color='#58ACFA'>OST Trackman - Lullaby</font>", 0, 0)
		GameRules:SetTimeOfDay( 0.75 )
		return 235
	end,
	0.1)	

	GameRules:GetGameModeEntity():SetContextThink("ZombieSoundThink", 
	function()
		EmitGlobalSound(SOUND_TABLE[RandomInt(1,#SOUND_TABLE)])
		return 10
	end,
	1)

	GameRules:GetGameModeEntity():SetContextThink("BossThink", 
	function()
		EmitGlobalSound("Hero_Undying.FleshGolem.Cast")
		local point = nil
		local unit = nil
		point = Entities:FindByName( nil, "zombie_spawn_" .. RandomInt(1,8)):GetAbsOrigin()
		unit = CreateUnitByName("city_boss_undying", point, true, nil, nil, DOTA_TEAM_BADGUYS )
		unit:CreatureLevelUp(BOSS_LEVEL)
		BOSS_LEVEL = BOSS_LEVEL + 1
		return 360
	end,
	360)

	--local point = Entities:FindByName( nil, "night_spawn"):GetAbsOrigin()
	--local unit = CreateUnitByName("npc_night_city", point, true, nil, nil, DOTA_TEAM_BADGUYS )
	InvasionMode:CityMapSpawnMoobs()	
end

function InvasionMode:CityMapSpawnMoobs()
	local point = nil
	local unit = nil
	--local way = Entities:FindByName( nil, "way_1") 
	for i = 1, 8 do
		point = Entities:FindByName( nil, "zombie_spawn_" .. i ):GetAbsOrigin()
		for l = 1, 5 do 
			unit = CreateUnitByName("city_zombie", point, true, nil, nil, DOTA_TEAM_BADGUYS )
			unit.vSpawnLoc = unit:GetOrigin()
			unit.vSpawnVector = Vector(-1,-1,0)
			unit:SetForwardVector(Vector(-1,-1,0))
			--unit:SetInitialGoalEntity( way )
		end
	end
end
 
function InvasionMode:CityMapEntityKilled (event)
	local killedEntity = EntIndexToHScript(event.entindex_killed)

    if killedEntity:GetUnitName() == "city_zombie" then
		local SpawnLoc = killedEntity.vSpawnLoc
		local SpawnVector = killedEntity.vSpawnVector
		local level = killedEntity:GetLevel()
		local newEntity = CreateUnitByName("city_zombie", SpawnLoc, true, nil, nil, DOTA_TEAM_BADGUYS )
		--local way = Entities:FindByName( nil, "way_1")

		if not SpawnLoc then
			SpawnLoc = Entities:FindByName( nil, "zombie_spawn_" .. RandomInt(1,8) ):GetAbsOrigin()
		end

		if not SpawnVector then
			SpawnVector = Vector(-1,-1,0)
		end

		newEntity:CreatureLevelUp(level)
		newEntity.vSpawnLoc = SpawnLoc
		newEntity.vSpawnVector = SpawnVector
		newEntity:SetForwardVector(Vector(-1,-1,0))

		if level > 25 then
			local ability = newEntity:AddAbility("zombie_corrosive_skin")
			ability:SetLevel(1)
		end

		--newEntity:SetInitialGoalEntity( way )
	end

   if killedEntity:GetUnitName() == "npc_cage" then
		InvasionMode:CityMapCreateDrop("item_wood_wall", killedEntity:GetAbsOrigin())	
   end

end


function InvasionMode:CityMapOnHeroKilled(data)
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
	local playerCount = PlayerResource:GetTeamPlayerCount()

	for i=0, playerCount  do
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
 
function InvasionMode:CityMapCreateDrop (itemName, pos)
   local newItem = CreateItem(itemName, nil, nil)
   newItem:SetPurchaseTime(0)
   local drop = CreateItemOnPositionSync(pos, newItem)
   newItem:LaunchLoot(false, 300, 0.75, pos + RandomVector(50))

	GameRules:GetGameModeEntity():SetContextThink(string.format("ItemDropThink_%d",RandomInt(1,9999)), 
	function()
		if newItem and IsValidEntity(newItem) then
	    	if not newItem:GetOwnerEntity() then 
		        if drop and IsValidEntity(drop) then 
		        	UTIL_Remove(drop) 
		        end
	           	UTIL_Remove(newItem)
	        end
	    end
	end,
	30) 
end
 

 function InvasionMode:CityMapOnItemPickedUp(data)
	local item = EntIndexToHScript( data.ItemEntityIndex )
	local hero = EntIndexToHScript( data.HeroEntityIndex )
	local team = hero:GetTeamNumber() 
	local gold = 500

	if data.itemname == "item_bag_of_gold" then
		for i=0,5 do
			if PlayerResource:IsValidPlayer(i) then
				local player = PlayerResource:GetPlayer(i)
				local teamNumb = player:GetTeamNumber()

				if teamNumb == team then
					PlayerResource:ModifyGold( player:GetPlayerID(), gold, true, 0 )
					SendOverheadEventMessage( hero, OVERHEAD_ALERT_GOLD, player, gold, nil )
				end
			
			end
		end
		UTIL_Remove( item )
	end
end