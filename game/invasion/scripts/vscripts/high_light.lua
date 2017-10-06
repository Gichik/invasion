if InvasionMode == nil then
	InvasionMode = class({})
end

XP_PER_LEVEL_TABLE = {
	0 -- 1	 
 }

deadTowerCounter = 0

function InvasionMode:InvasionHighLight()
	print( "InitGameMode" )
	GameRules:SetCustomGameTeamMaxPlayers( DOTA_TEAM_GOODGUYS, 4 )
	GameRules:SetCustomGameTeamMaxPlayers( DOTA_TEAM_BADGUYS, 1 )
	
	--GameRules:SetTimeOfDay( 0.75 )
	GameRules:SetHeroRespawnEnabled( false )
	GameRules:SetUseUniversalShopMode( false )
	GameRules:SetHeroSelectionTime( 10.0 )
	GameRules:SetPreGameTime( 5.0 )
	GameRules:SetPostGameTime( 60.0 )
	GameRules:SetTreeRegrowTime( 60.0 )
	GameRules:SetHeroMinimapIconScale( 0.7 )
	GameRules:SetCreepMinimapIconScale( 0.7 )
	GameRules:SetRuneMinimapIconScale( 0.7 )
	GameRules:SetGoldTickTime( 60.0 )
	GameRules:SetGoldPerTick( 0 )
	GameRules:SetStartingGold(0)
	GameRules:GetGameModeEntity():SetRemoveIllusionsOnDeath( true )
	GameRules:GetGameModeEntity():SetTopBarTeamValuesOverride( true )
	GameRules:GetGameModeEntity():SetTopBarTeamValuesVisible( false )
	GameRules:GetGameModeEntity():SetBuybackEnabled( false )
	GameRules:GetGameModeEntity():SetRecommendedItemsDisabled( true )	
	GameRules:SetSameHeroSelectionEnabled( false )

	GameRules:GetGameModeEntity():SetUnseenFogOfWarEnabled( false )
	
	GameRules:GetGameModeEntity():SetUseCustomHeroLevels(true)
	GameRules:GetGameModeEntity():SetCustomHeroMaxLevel(1)		
	GameRules:GetGameModeEntity():SetCustomXPRequiredToReachNextLevel( XP_PER_LEVEL_TABLE )
	GameRules:GetGameModeEntity():SetStashPurchasingDisabled( true )

	GameRules:GetGameModeEntity():SetLoseGoldOnDeath(false)	
	GameRules:SetUseBaseGoldBountyOnHeroes(false)
	
	--GameRules:GetGameModeEntity():SetUnseenFogOfWarEnabled( true )

    ListenToGameEvent('entity_killed', Dynamic_Wrap(InvasionMode, 'HighLighOnEntityKilled'), self)
	ListenToGameEvent('game_rules_state_change', Dynamic_Wrap(InvasionMode, 'HighLighGameRulesStateChange'), self)
	ListenToGameEvent("npc_spawned", Dynamic_Wrap(InvasionMode, 'HighLighOnNPCSpawn'), self)
--	ListenToGameEvent("dota_player_gained_level", Dynamic_Wrap(InvasionMode, 'OnPlayerGainedLevel'), self)
--	ListenToGameEvent('dota_item_picked_up', Dynamic_Wrap(InvasionMode, 'OnItemPickedUp'), self)	
	ListenToGameEvent("dota_player_killed", Dynamic_Wrap(InvasionMode, "HighLighOnHeroKilled"), self)

	AddFOWViewer(DOTA_TEAM_BADGUYS, Vector(-838,1944,256), 300, -1, false)
	AddFOWViewer(DOTA_TEAM_BADGUYS, Vector(3526,-1266,256), 300, -1, false)
	AddFOWViewer(DOTA_TEAM_BADGUYS, Vector(-640,-4480,256), 300, -1, false)	
	
	AddFOWViewer(DOTA_TEAM_GOODGUYS, Vector(-838,1944,256), 300, -1, false)
	AddFOWViewer(DOTA_TEAM_GOODGUYS, Vector(3526,-1266,256), 300, -1, false)
	AddFOWViewer(DOTA_TEAM_GOODGUYS, Vector(-640,-4480,256), 300, -1, false)	

	local unit = CreateUnitByName("blood_tower", Vector(-2496,-256,128), true, nil, nil, DOTA_TEAM_BADGUYS )	
	unit:SetForwardVector(Vector(0,1,0))
	unit = CreateUnitByName("blood_tower", Vector(-3904,3776,128), true, nil, nil, DOTA_TEAM_BADGUYS )	
	unit:SetForwardVector(Vector(0,1,0))	
	unit = CreateUnitByName("blood_tower", Vector(0,3264,128), true, nil, nil, DOTA_TEAM_BADGUYS )	
	unit:SetForwardVector(Vector(0,1,0))
	unit = CreateUnitByName("blood_tower", Vector(4736,4288,128), true, nil, nil, DOTA_TEAM_BADGUYS )	
	unit:SetForwardVector(Vector(0,1,0))
	unit = CreateUnitByName("blood_tower", Vector(3968,320,128), true, nil, nil, DOTA_TEAM_BADGUYS )	
	unit:SetForwardVector(Vector(0,1,0))
	unit = CreateUnitByName("blood_tower", Vector(2944,-4224,128), true, nil, nil, DOTA_TEAM_BADGUYS )	
	unit:SetForwardVector(Vector(0,1,0))
	unit = CreateUnitByName("blood_tower", Vector(384,-2368,128), true, nil, nil, DOTA_TEAM_BADGUYS )	
	unit:SetForwardVector(Vector(0,1,0))	
	unit = CreateUnitByName("blood_tower", Vector(-3968,-4160,128), true, nil, nil, DOTA_TEAM_BADGUYS )	
	unit:SetForwardVector(Vector(0,1,0))

	unit = CreateUnitByName("wisp_tower", Vector(889,-1090,128), true, nil, nil, DOTA_TEAM_GOODGUYS )	
	unit:SetForwardVector(Vector(0,-1,0))
	unit = CreateUnitByName("wisp_tower", Vector(1024,5248,128), true, nil, nil, DOTA_TEAM_GOODGUYS )	
	unit:SetForwardVector(Vector(0,-1,0))	



end

function InvasionMode:HighLighGameRulesStateChange(keys)
	local newState = GameRules:State_Get()
	if newState == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
		
		GameRules:GetGameModeEntity():SetContextThink("NightTimeThink", 
		function()
			EmitGlobalSound("Hero_Nightstalker.Darkness")
			GameRules:SetTimeOfDay( 0.75 )
			return 235
		end,
		0.1)

	end
end


function InvasionMode:HighLighOnNPCSpawn(data)
	--print("spawn")
	local unit = EntIndexToHScript(data.entindex)

	if unit:IsHero() then	

		unit:SetAbilityPoints(0)

		if unit:GetTeamNumber() == DOTA_TEAM_BADGUYS then

			GameRules:GetGameModeEntity():SetContextThink(string.format("ReplaceBadHeroThink_%d", unit:GetPlayerID()), 
			function()

				unit:AddNoDraw()
				unit = PlayerResource:ReplaceHeroWith(unit:GetPlayerID(), "npc_dota_hero_life_stealer", 0, 0)
				UTIL_Remove(EntIndexToHScript(data.entindex))

				local table = {}
				table[1] = Vector(-3200,-4352,128)
				table[2] = Vector(-1563,-512,128)
				table[3] = Vector(-3584,3840,128)
				table[4] = Vector(4864,3840,128)				
				table[5] = Vector(3456,-4352,128)

				unit:SetAbsOrigin(table[RandomInt(1,5)])
				for i = 0, 6 do
					local ability = unit:GetAbilityByIndex(i)
					if ability then
						ability:SetLevel(1)
					end 
				end				
			end,
			1)
		else
			GameRules:GetGameModeEntity():SetContextThink(string.format("ReplaceGodHeroThink_%d", unit:GetPlayerID()), 
			function()
				unit:AddNoDraw()
				unit = PlayerResource:ReplaceHeroWith(unit:GetPlayerID(), "npc_dota_hero_wisp", 0, 0)
				UTIL_Remove(EntIndexToHScript(data.entindex))
				for i = 0, 6 do
					local ability = unit:GetAbilityByIndex(i)
					if ability then
						ability:SetLevel(1)
					end 
				end					
			end,
			1)
		end

	end
end


function InvasionMode:HighLighOnHeroKilled(data)
--	print("hero killed")

	local killedUnit = PlayerResource:GetSelectedHeroEntity(data.PlayerID)
	local point = {}
	point[1] = Vector(-838,1944,256)
	point[2] = Vector(3526,-1266,256)
	point[3] = Vector(-640,-4480,256)

	killedUnit:SetAbsOrigin(point[RandomInt(1,3)])

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
			local player = PlayerResource:GetSelectedHeroEntity(i)
			if player:IsAlive() and (player:GetTeamNumber() == DOTA_TEAM_GOODGUYS) then
				AllDead = false
			end
		end
	end

	if AllDead then
		GameRules:SetGameWinner(DOTA_TEAM_BADGUYS)
	end

end


function InvasionMode:HighLighOnEntityKilled (event)
   local killedEntity = EntIndexToHScript(event.entindex_killed)

    if killedEntity:GetUnitName() == "blood_tower" then
		print(killedEntity:GetAbsOrigin())
    	AddFOWViewer(DOTA_TEAM_BADGUYS, killedEntity:GetAbsOrigin(), 300, -1, false)	
		AddFOWViewer(DOTA_TEAM_GOODGUYS, killedEntity:GetAbsOrigin(), 300, -1, false)
    	deadTowerCounter = deadTowerCounter + 1
		--EmitGlobalSound("Invasion.HommerWin")
	end	

	if deadTowerCounter >= 5 then
		GameRules:SetGameWinner(DOTA_TEAM_GOODGUYS)
	end

end