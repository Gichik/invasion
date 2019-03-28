
if ArmageddonMode == nil then
	ArmageddonMode = class({})
end

MINIONS_COUNT = 5
MONSTERS_LEVEL = 0

function ArmageddonMode:Settings()

	
	GameRules:SetCustomGameTeamMaxPlayers( DOTA_TEAM_GOODGUYS, 4 )
	GameRules:SetCustomGameTeamMaxPlayers( DOTA_TEAM_BADGUYS, 4 )

	GameRules:SetSameHeroSelectionEnabled(false)
	
	GameRules:SetHeroRespawnEnabled( false )
	GameRules:SetUseUniversalShopMode( false )
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
	GameRules:SetStartingGold( 5 )

	GameRules:GetGameModeEntity():SetRemoveIllusionsOnDeath( true )
	GameRules:GetGameModeEntity():SetTopBarTeamValuesOverride( true )
	GameRules:GetGameModeEntity():SetTopBarTeamValuesVisible( false )
	GameRules:GetGameModeEntity():SetBuybackEnabled(false)
	--GameRules:GetGameModeEntity():SetStashPurchasingDisabled(true)

	--GameRules:GetGameModeEntity():SetRecommendedItemsDisabled( true )

	ListenToGameEvent('game_rules_state_change', Dynamic_Wrap(ArmageddonMode, 'ArmageddonGameRulesStateChange'), self)
	ListenToGameEvent('npc_spawned', Dynamic_Wrap(ArmageddonMode, 'ArmageddonOnNPCSpawn'), self)
	ListenToGameEvent("entity_killed", Dynamic_Wrap(ArmageddonMode, "ArmageddonOnEntityKilled"), self)


	local point = nil
	local unit = nil
	for i = 1, 4 do
		point = Entities:FindByName( nil, "spawn_tower_" .. i ):GetAbsOrigin()
		unit = CreateUnitByName("npc_tower", point, true, nil, nil, DOTA_TEAM_GOODGUYS)
		unit:SetAbsOrigin(point)
		unit = CreateUnitByName("npc_tower", point, true, nil, nil, DOTA_TEAM_BADGUYS)
		unit:SetAbsOrigin(point)
	end


end


function ArmageddonMode:ArmageddonGameRulesStateChange(data)
	local newState = GameRules:State_Get()
	if newState == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
		Timers:CreateTimer(0, function()
			self:RespawnMoobs()
	        return 60
	    end
	    )
	end
end

function ArmageddonMode:ArmageddonOnNPCSpawn(data)

	local unit = EntIndexToHScript(data.entindex)

    if unit:IsRealHero() then

    end

end


function ArmageddonMode:ArmageddonOnEntityKilled(data)

	local killedEntity = EntIndexToHScript(data.entindex_killed)
	local attackerEntity = EntIndexToHScript(data.entindex_attacker)

    if killedEntity:IsCreature()  then
    	if killedEntity:GetTeamNumber() == DOTA_TEAM_NEUTRALS then

    		 if killedEntity:GetUnitName() == "npc_armageddon_zombie" then
                if RollPercentage(REWARD_DROP_PERCENT) then
                	if RollPercentage(ITEM_DROP_PERCENT) then
                    	self:CreateDrop(GetRandomItemNameFrom(killedEntity.itemDropType), killedEntity:GetAbsOrigin())
                    else
                    	self:CreateDrop("item_armageddon_bag_of_gold", killedEntity:GetAbsOrigin())           
                	end
                end
    		 end

			if killedEntity:GetUnitName() == "npc_armageddon_boss" then
				self:CreateDrop(GetRandomItemNameFrom(killedEntity.itemDropType), killedEntity:GetAbsOrigin())
			end

		end
	end
	
end


function ArmageddonMode:RespawnMoobs()
	--print("--------RespawnMoobs---------")
    local team = DOTA_TEAM_NEUTRALS
    local unit = nil
    local point = nil
    local biomTable = {"misc","attributes","weapons"}
    local modifier = nil
    local modifCount = nil
    local modifName = nil

    MONSTERS_LEVEL = MONSTERS_LEVEL + 1

    for i = 1, 3 do
    	for j = 1, 4 do
    		point = Entities:FindByName( nil, "spawn_moobs_" .. biomTable[ i ] .. "_" .. j ):GetAbsOrigin()

    		if self:IsCampNotBlocked(point) then
			    unit = CreateUnitByName("npc_armageddon_zombie", point, true, nil, nil, team )
			    unit:CreatureLevelUp(MONSTERS_LEVEL - 1)
			    unit:SetForwardVector(Vector(0,-1,0))
			    unit.itemDropType = biomTable[ i ]

	   			modifier = unit:AddNewModifier(unit, nil, GetRandomModifierName(), {})
			    for n = 1, MINIONS_COUNT do 
			        unit = CreateUnitByName("npc_armageddon_zombie", point + RandomVector(300), true, nil, nil, team )
			        if modifier:CanBeAddToMinions() then
			            unit:AddNewModifier(unit, nil, modifier:GetName(), {})
			            unit:CreatureLevelUp(MONSTERS_LEVEL - 1)
			            unit:SetForwardVector(Vector(0,-1,0))
			            unit.itemDropType = biomTable[ i ]
			        end
			    end
			end

    	end
    end

    for i = 1, 4 do
		point = Entities:FindByName( nil, "spawn_moobs_secrets_" .. i ):GetAbsOrigin()

		if self:IsCampNotBlocked(point) then
		    unit = CreateUnitByName("npc_armageddon_boss", point, true, nil, nil, team )
		    unit:CreatureLevelUp(MONSTERS_LEVEL - 1)
		    unit:SetForwardVector(Vector(0,-1,0))
		    unit.itemDropType = "secret"

	        modifCount = 0

	        for j = 0, 10 do
	            modifName = GetRandomModifierName()
	            if not unit:HasModifier(modifName) then
	                unit:AddNewModifier(unit, nil, modifName, {})
	                modifCount = modifCount + 1
	            end
	            if modifCount >= 3 then
	                break
	            end
	        end
	    end

    end

end

function ArmageddonMode:IsCampNotBlocked(point)
	--print("----------IsCampNotBlocked----------")
    local units = nil

    units = FindUnitsInRadius( DOTA_TEAM_NEUTRALS, point, nil, 500,
    DOTA_UNIT_TARGET_TEAM_BOTH, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE + DOTA_UNIT_TARGET_FLAG_INVULNERABLE, 0, false )

    if #units > 0 then
    	return false
    end

    return true

end


function ArmageddonMode:CreateDrop(itemName, pos)
   local newItem = CreateItem(itemName, nil, nil)
   newItem:SetPurchaseTime(0)
   local drop = CreateItemOnPositionSync(pos, newItem)
   newItem:LaunchLoot(false, 300, 0.75, pos + RandomVector(RandomFloat(50, 50)))

    Timers:CreateTimer(TIME_BEFORE_REMOVE_DROP, function()
        if newItem and IsValidEntity(newItem) then
            if not newItem:GetOwnerEntity() then 

                if drop and IsValidEntity(drop) then 
                    UTIL_Remove(drop) 
                end

                UTIL_Remove(newItem)
            end
        end
      return nil
    end
    )
end
