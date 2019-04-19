
if ArmageddonMode == nil then
	ArmageddonMode = class({})
end


function ArmageddonMode:Settings()

	
	GameRules:SetCustomGameTeamMaxPlayers( DOTA_TEAM_GOODGUYS, 4 )
	GameRules:SetCustomGameTeamMaxPlayers( DOTA_TEAM_BADGUYS, 4 )

	GameRules:SetSameHeroSelectionEnabled(false)
	
	GameRules:SetHeroRespawnEnabled( false )
	GameRules:SetUseUniversalShopMode( false )
	GameRules:SetHeroSelectionTime( 30.0 )
	GameRules:SetStrategyTime( 30.0 )
	GameRules:SetShowcaseTime( 0.0 )	
	GameRules:SetPreGameTime( 10.0 )
	GameRules:SetPostGameTime( 60.0 )
	GameRules:SetTreeRegrowTime( 60.0 )
	GameRules:SetHeroMinimapIconScale( 0.7 )
	GameRules:SetCreepMinimapIconScale( 0.7 )
	GameRules:SetRuneMinimapIconScale( 0.7 )
	GameRules:SetGoldTickTime( 1 )
	GameRules:SetGoldPerTick( 0 )
	GameRules:SetStartingGold( 500 )

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
		unit:AddNewModifier(unit, nil, "modifier_tower_truesight_aura", {})
		unit = CreateUnitByName("npc_tower", point, true, nil, nil, DOTA_TEAM_BADGUYS)
		unit:SetAbsOrigin(point)
		unit:AddNewModifier(unit, nil, "modifier_tower_truesight_aura", {})
	end


end


function ArmageddonMode:ArmageddonGameRulesStateChange(data)
	local newState = GameRules:State_Get()
	if newState == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
		Timers:CreateTimer(0, function()
			self:RespawnMoobs()
	        return 30
	    end
	    )

		Timers:CreateTimer(600, function()
			--print("--------FOW-------")
			for i = 0, 8 do
				local hPlayer = PlayerResource:GetPlayer(i)
				if  hPlayer then
					local hHero = hPlayer:GetAssignedHero()
					if hHero and hHero:IsAlive() then
						hHero:AddNewModifier(hHero, nil, "modifier_item_dustofappearance", {duration = 5})
						AddFOWViewer(DOTA_TEAM_GOODGUYS, hHero:GetAbsOrigin(), 300, 10, true)
	        			AddFOWViewer(DOTA_TEAM_BADGUYS, hHero:GetAbsOrigin(), 300, 10, true)
	        		end
	        	end
	        end

	        return 600
	    end
	    )

		Timers:CreateTimer(2100, function()
			if DIRE_COUNT == RADIANT_COUNT then
				GameRules:SetGameWinner(DOTA_TEAM_NEUTRALS)
			end

	    	if DIRE_COUNT > RADIANT_COUNT then
	    		GameRules:SetGameWinner(DOTA_TEAM_GOODGUYS)
	    	end

	    	if DIRE_COUNT < RADIANT_COUNT then
	    		GameRules:SetGameWinner(DOTA_TEAM_BADGUYS)
	    	end

	    	return nil
	    end
	    )


	end
end

function ArmageddonMode:ArmageddonOnNPCSpawn(data)

	local unit = EntIndexToHScript(data.entindex)

    if unit:IsRealHero() then
    	if not unit.nextSpawn then
    		unit.nextSpawn = true
	    	if unit:GetTeamNumber() == DOTA_TEAM_BADGUYS then
	    		DIRE_COUNT = DIRE_COUNT + 1
	    	end
	    	if unit:GetTeamNumber() == DOTA_TEAM_GOODGUYS then
	    		RADIANT_COUNT = RADIANT_COUNT + 1
	    	end

	    end
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


    if killedEntity:IsRealHero() then
    	if not killedEntity:IsReincarnating() then

	        for i = 0, 11 do
	        	if  killedEntity:GetItemInSlot(i) then
	        		 self:CreateDrop(killedEntity:GetItemInSlot(i):GetAbilityName(), killedEntity:GetAbsOrigin())
	        		 killedEntity:RemoveItem(killedEntity:GetItemInSlot(i))
	        	end
	        end

	     	if killedEntity:GetTeamNumber() == DOTA_TEAM_BADGUYS then
	    		DIRE_COUNT = DIRE_COUNT - 1
	    	end
	    	if killedEntity:GetTeamNumber() == DOTA_TEAM_GOODGUYS then
	    		RADIANT_COUNT = RADIANT_COUNT - 1
	    	end

	    	if DIRE_COUNT < 1 and RADIANT_COUNT < 1 then
	    		GameRules:SetGameWinner(DOTA_TEAM_NEUTRALS)
	    	elseif DIRE_COUNT < 1 then
	    		GameRules:SetGameWinner(DOTA_TEAM_GOODGUYS)
			elseif RADIANT_COUNT < 1 then
	    		GameRules:SetGameWinner(DOTA_TEAM_BADGUYS)
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
    local delta = 1

    MONSTERS_LEVEL = MONSTERS_LEVEL + 0.5
    if MONSTERS_LEVEL < 1 then
    	delta = 0.5
    end


    for i = 1, 3 do
    	for j = 1, 4 do
    		point = Entities:FindByName( nil, "spawn_moobs_" .. biomTable[ i ] .. "_" .. j ):GetAbsOrigin()

    		if self:IsCampNotBlocked(point) then
			    unit = CreateUnitByName("npc_armageddon_zombie", point, true, nil, nil, team )
			    unit:CreatureLevelUp(math.floor(MONSTERS_LEVEL) - delta)
			    unit:SetForwardVector(Vector(0,-1,0))
			    unit.itemDropType = biomTable[ i ]

	   			modifier = unit:AddNewModifier(unit, nil, GetRandomModifierName(), {})
			    for n = 1, MINIONS_COUNT do 
			        unit = CreateUnitByName("npc_armageddon_zombie", point + RandomVector(300), true, nil, nil, team )
			        if modifier:CanBeAddToMinions() then
			            unit:AddNewModifier(unit, nil, modifier:GetName(), {})
			            unit:CreatureLevelUp(math.floor(MONSTERS_LEVEL) - delta)
			            unit:SetForwardVector(Vector(0,-1,0))
			            unit.itemDropType = biomTable[ i ]
			        end
			    end
			end

    	end
    end

    for i = 1, 5 do
		point = Entities:FindByName( nil, "spawn_moobs_secrets_" .. i ):GetAbsOrigin()

		if self:IsCampNotBlocked(point) then
		    unit = CreateUnitByName("npc_armageddon_boss", point, true, nil, nil, team )
		    unit:CreatureLevelUp(math.floor(MONSTERS_LEVEL) - delta)
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
