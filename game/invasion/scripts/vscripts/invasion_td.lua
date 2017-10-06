

if InvasionMode == nil then
	InvasionMode = class({})
end


function InvasionMode:TDMap()

	
	GameRules:SetCustomGameTeamMaxPlayers( DOTA_TEAM_GOODGUYS, 4 )
	GameRules:SetCustomGameTeamMaxPlayers( DOTA_TEAM_BADGUYS, 0 )

	GameRules:SetSameHeroSelectionEnabled(true)
	
	GameRules:SetHeroRespawnEnabled( false )
	GameRules:SetUseUniversalShopMode( true )
	GameRules:SetHeroSelectionTime( 0.0 )
	GameRules:SetShowcaseTime( 0.0 )	
	GameRules:SetStrategyTime( 0.0 )	
	GameRules:SetPreGameTime( 3.0 )
	GameRules:SetPostGameTime( 60.0 )
	GameRules:SetTreeRegrowTime( 60.0 )
	GameRules:SetHeroMinimapIconScale( 0.7 )
	GameRules:SetCreepMinimapIconScale( 0.7 )
	GameRules:SetRuneMinimapIconScale( 0.7 )
	GameRules:SetGoldTickTime( 0 )
	GameRules:SetGoldPerTick( 0 )

	GameRules:GetGameModeEntity():SetRemoveIllusionsOnDeath( true )
	GameRules:GetGameModeEntity():SetTopBarTeamValuesOverride( true )
	GameRules:GetGameModeEntity():SetTopBarTeamValuesVisible( false )
	--GameRules:GetGameModeEntity():SetRecommendedItemsDisabled( true )

	GameRules:GetGameModeEntity():SetDamageFilter(Dynamic_Wrap(InvasionMode, "DamageFilter"), self)	

	ListenToGameEvent('game_rules_state_change', Dynamic_Wrap(InvasionMode, 'TDMapGameRulesStateChange'), self)
	ListenToGameEvent('entity_killed', Dynamic_Wrap(InvasionMode, 'TDMapEntityKilled'), self)		
	ListenToGameEvent('dota_item_picked_up', Dynamic_Wrap(InvasionMode, 'TDMapOnItemPickedUp'), self)
	ListenToGameEvent('npc_spawned', Dynamic_Wrap(InvasionMode, 'TDMapOnNPCSpawn'), self)	

	--local point = Entities:FindByName( nil, "wood_spawn_1"):GetAbsOrigin()
	--local unit = CreateUnitByName("wood_wall", point, true, nil, nil, DOTA_TEAM_NEUTRALS )	
	--unit:SetForwardVector(Vector(-1,0,0))
	--unit:SetHullRadius(100.0)
	--point = Entities:FindByName( nil, "wood_spawn_2"):GetAbsOrigin()
	--unit = CreateUnitByName("wood_wall", point, true, nil, nil, DOTA_TEAM_NEUTRALS )
	--unit:SetForwardVector(Vector(0,-1,0))
	--unit:SetHullRadius(100.0)

end



 function InvasionMode:TDMapGameRulesStateChange(data)
	local newState = GameRules:State_Get()
	if newState == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
		InvasionMode:TDMapGameStart()
	end
	if newState == DOTA_GAMERULES_STATE_POST_GAME then
		local presentTime = GameRules:GetDOTATime(false,false)
		if presentTime < 1479 then
			GameRules:SetGameWinner(DOTA_TEAM_BADGUYS)
		end
	end

end


function InvasionMode:TDMapOnNPCSpawn(data)

	local npc = EntIndexToHScript(data.entindex)

	if npc:IsHero() then
		if not npc.next_spawn then
			npc.next_spawn = true;
			npc:AddNewModifier(npc, nil, "modifier_item_phase_boots_active", {})
			if npc:HasAnyAvailableInventorySpace() then
				npc:AddItemByName("item_blink")
			end
			if npc:HasAnyAvailableInventorySpace() then
				npc:AddItemByName("item_ignition_key")
			end
			if npc:HasAnyAvailableInventorySpace() then
				npc:AddItemByName("item_basis_of_turret")
			end
			if npc:HasAnyAvailableInventorySpace() then
				npc:AddItemByName("item_purple_stone_of_poison")
			end
			if npc:HasAnyAvailableInventorySpace() then
				npc:AddItemByName("item_maroon_stone_of_fire")
			end
			if npc:HasAnyAvailableInventorySpace() then
				npc:AddItemByName("item_feldgrau_stone_of_poison")
			end			
			if npc:HasAnyAvailableInventorySpace() then
				npc:AddItemByName("item_feldgrau_stone_of_relations")
			end	
			if npc:HasAnyAvailableInventorySpace() then
				npc:AddItemByName("item_amber_stone_of_fire")
			end							
		end	
	end

end


function InvasionMode:TDMapGameStart()

	
end
 
function InvasionMode:TDMapEntityKilled (data)
   local killedEntity = EntIndexToHScript(data.entindex_killed)

 end
 
function InvasionMode:TDMapCreateDrop (itemName, pos)
   local newItem = CreateItem(itemName, nil, nil)
   newItem:SetPurchaseTime(0)
   CreateItemOnPositionSync(pos, newItem)
   newItem:LaunchLoot(false, 300, 0.75, pos + RandomVector(RandomFloat(50, 350)))
end


function InvasionMode:TDMapOnItemPickedUp(data)
	local item = EntIndexToHScript( data.ItemEntityIndex )
	local gold = 500	
	local hero = nil
	local team = nil

	if data.HeroEntityIndex then
		hero = EntIndexToHScript( data.HeroEntityIndex )
		team = hero:GetTeamNumber()

		if data.itemname == "item_bag_of_gold" then
			for i=0,5 do
				if PlayerResource:IsValidPlayer(i) then
					local player = PlayerResource:GetPlayer(i)
					if player then 
						local teamNumb = player:GetTeamNumber()

						if teamNumb == team then
							PlayerResource:ModifyGold( player:GetPlayerID(), gold, true, 0 )
							SendOverheadEventMessage( hero, OVERHEAD_ALERT_GOLD, player, gold, nil )
						end
					end
				end
			end
			UTIL_Remove( item )
		end
	end
end

