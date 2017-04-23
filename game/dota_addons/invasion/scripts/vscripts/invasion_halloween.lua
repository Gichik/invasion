if InvasionMode == nil then
	InvasionMode = class({})
end

XP_PER_LEVEL_TABLE = {
	0 -- 1	 
 }

CandyCount = 0

function InvasionMode:HalloweenMap()
	print( "InitGameMode" )
	GameRules:SetCustomGameTeamMaxPlayers( DOTA_TEAM_GOODGUYS, 1 )
	GameRules:SetCustomGameTeamMaxPlayers( DOTA_TEAM_BADGUYS, 3 )
	
	--GameRules:SetTimeOfDay( 0.75 )
	GameRules:SetHeroRespawnEnabled( true )
	GameRules:SetUseUniversalShopMode( false )
	GameRules:SetHeroSelectionTime( 0.0 )
	GameRules:SetPreGameTime( 0.0 )
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

	GameRules:SetFirstBloodActive( false )	
	GameRules:SetHideKillMessageHeaders( true )
	GameRules:GetGameModeEntity():SetAnnouncerDisabled( true )

	GameRules:GetGameModeEntity():SetFixedRespawnTime(15)
	
	GameRules:GetGameModeEntity():SetUseCustomHeroLevels(true)
	GameRules:GetGameModeEntity():SetCustomHeroMaxLevel(1)		
	GameRules:GetGameModeEntity():SetCustomXPRequiredToReachNextLevel( XP_PER_LEVEL_TABLE )
	GameRules:GetGameModeEntity():SetStashPurchasingDisabled( true )

	GameRules:GetGameModeEntity():SetLoseGoldOnDeath(false)	
	GameRules:SetUseBaseGoldBountyOnHeroes(false)
	
	--GameRules:GetGameModeEntity():SetUnseenFogOfWarEnabled( true )

    --ListenToGameEvent('entity_killed', Dynamic_Wrap(InvasionMode, 'HighLighOnEntityKilled'), self)
	ListenToGameEvent('game_rules_state_change', Dynamic_Wrap(InvasionMode, 'HalloweenGameRulesStateChange'), self)
	ListenToGameEvent("npc_spawned", Dynamic_Wrap(InvasionMode, 'HalloweenOnNPCSpawn'), self)
--	ListenToGameEvent("dota_player_gained_level", Dynamic_Wrap(InvasionMode, 'OnPlayerGainedLevel'), self)
--	ListenToGameEvent('dota_item_picked_up', Dynamic_Wrap(InvasionMode, 'OnItemPickedUp'), self)	
	ListenToGameEvent("dota_player_killed", Dynamic_Wrap(InvasionMode, "HalloweenOnHeroKilled"), self)


end

function InvasionMode:HalloweenGameRulesStateChange(keys)
	local newState = GameRules:State_Get()
	if newState == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then

		ShowGenericPopup( "#popup_title_halloween", "#popup_body_halloween", "", "", DOTA_SHOWGENERICPOPUP_TINT_SCREEN )

		GameRules:GetGameModeEntity():SetContextThink("NightTimeThink", 
		function()
			EmitGlobalSound("Invasion.Halloween")
			GameRules:SendCustomMessage("<font color='#58ACFA'>Music: This is Halloween</font>", 0, 0)
			GameRules:SetTimeOfDay( 0.75 )
			return 185
		end,
		0.1)

		GameRules:GetGameModeEntity():SetContextThink("WinsTimeThink", 
		function()
			GameRules:SetGameWinner(DOTA_TEAM_GOODGUYS)
			return nil
		end,
		600)		
	end
	if newState == DOTA_GAMERULES_STATE_POST_GAME then
		local presentTime = GameRules:GetDOTATime(false,false)
		if presentTime < 599 then
			GameRules:SetGameWinner(DOTA_TEAM_BADGUYS)
		end
	end
end


function InvasionMode:HalloweenOnNPCSpawn(data)
	--print("spawn")
	local unit = EntIndexToHScript(data.entindex)

	if unit:IsHero() and not unit.next_spawn then
		unit.next_spawn = true;	
		unit:SetAbilityPoints(0)
		for i = 0, 4 do
			local ability = unit:GetAbilityByIndex(i)
			if ability then
				ability:SetLevel(1)
			end
		end

		if unit:GetTeamNumber() == DOTA_TEAM_GOODGUYS then
			GameRules:GetGameModeEntity():SetContextThink(string.format("ReplaceGoodHeroThink_%d", unit:GetPlayerID()), 
			function()
				unit:AddNoDraw()
				unit = PlayerResource:ReplaceHeroWith(unit:GetPlayerID(), "npc_dota_hero_beastmaster", 0, 0)
				UTIL_Remove(EntIndexToHScript(data.entindex))
			end,
			1)
		end

		if unit:GetTeamNumber() == DOTA_TEAM_BADGUYS then
			unit:AddNewModifier(unit, nil, "modifier_stunned", {duration = 15})		
		end

	end
end


function InvasionMode:HalloweenOnHeroKilled(data)
--	print("hero killed")
	local killedUnit = PlayerResource:GetSelectedHeroEntity(data.PlayerID)
end