
if InvasionMode == nil then
	InvasionMode = class({})
end

KilledRadiantUnit = 0
KilledDireUnit = 0
GameWinner = DOTA_TEAM_BADGUYS

function InvasionMode:ScorchedEarthMap()

	
	GameRules:SetCustomGameTeamMaxPlayers( DOTA_TEAM_GOODGUYS, 4 )
	GameRules:SetCustomGameTeamMaxPlayers( DOTA_TEAM_BADGUYS, 4 )

	GameRules:SetSameHeroSelectionEnabled(false)
	
	GameRules:SetTimeOfDay( 0.5 )
	GameRules:SetHeroRespawnEnabled( true )
	GameRules:SetUseUniversalShopMode( true )
	GameRules:SetHeroSelectionTime( 20.0 )
	GameRules:SetPreGameTime( 10.0 )
	GameRules:SetPostGameTime( 60.0 )
	GameRules:SetTreeRegrowTime( 60.0 )
	GameRules:SetGoldTickTime( 10 )
	GameRules:SetGoldPerTick( 0 )

	GameRules:GetGameModeEntity():SetRemoveIllusionsOnDeath( true )
	GameRules:GetGameModeEntity():SetTopBarTeamValuesOverride( true )
	GameRules:GetGameModeEntity():SetTopBarTeamValuesVisible( false )

	GameRules:GetGameModeEntity():SetUnseenFogOfWarEnabled( false )
	--AddFOWViewer( DOTA_TEAM_NEUTRALS, Vector(0,0,0), 10000, -1, false)

	ListenToGameEvent('game_rules_state_change', Dynamic_Wrap(InvasionMode, 'ScorchedEarthGameRulesStateChange'), self)
	ListenToGameEvent("npc_spawned", Dynamic_Wrap(InvasionMode, 'ScorchedEarthOnNPCSpawn'), self)	

	ListenToGameEvent('entity_killed', Dynamic_Wrap(InvasionMode, 'ScorchedEarthEntityKilled'), self)

	GameRules:GetGameModeEntity():SetDamageFilter(Dynamic_Wrap(InvasionMode, "ScorchedEarthDamageFilter"), self)		
end


function InvasionMode:ScorchedEarthDamageFilter(data)
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

 function InvasionMode:ScorchedEarthGameRulesStateChange(data)
	local newState = GameRules:State_Get()
	if newState == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then

		Timers:CreateTimer(5,function()
			EmitGlobalSound("Invasion.SadMelody")
			GameRules:SendCustomMessage("<font color='#58ACFA'>Max Richter – Departure (Reflection)</font>", 0, 0)			
		return 480
		end)		

		Timers:CreateTimer(30,function()
			if GameRules:IsDaytime() == false then
				EmitGlobalSound("Invasion.Zombie")
			end
		return 35
		end)

		for i = 1, 6 do
			local point = Entities:FindByName( nil, "spawn_jewelry_point_" .. RandomInt(1,12) ):GetAbsOrigin()
			local unit = CreateUnitByName("npc_burial_of_jewelry", point, true, nil, nil, DOTA_TEAM_NEUTRALS )
			--unit:AddNewModifier( unit, nil, "modifier_invisible", {} )
		end
	end

	if newState == DOTA_GAMERULES_STATE_POST_GAME then
		GameRules:SetGameWinner(GameWinner)
	end
end

function InvasionMode:ScorchedEarthOnNPCSpawn(data)
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

function InvasionMode:ScorchedEarthEntityKilled (data)
    local killedUnit = EntIndexToHScript( data.entindex_killed )
	local killer = EntIndexToHScript( data.entindex_attacker )
    local name = killedUnit:GetUnitName()

	if name == "npc_dead_witch" then
		GameWinner = killer:GetTeamNumber()
		GameRules:SetGameWinner( killer:GetTeamNumber() )
	end

	if name == "npc_mad_zombie" then
		if RollPercentage(60) then
	    	InvasionMode:ScorchedEarthCreateDrop("item_gold_map", killedUnit:GetAbsOrigin())
	    end
	end 

	if name == "npc_burial_gold_chest" then
	    InvasionMode:ScorchedEarthCreateDrop("item_gold_chest", killedUnit:GetAbsOrigin())
	end  

    if killedUnit:GetUnitName() == "npc_bartleby" then
		KilledRadiantUnit = KilledRadiantUnit + 1
	end	
    if killedUnit:GetUnitName() == "npc_cair" then
		KilledRadiantUnit = KilledRadiantUnit + 1
	end	
    if killedUnit:GetUnitName() == "npc_guts" then
		KilledRadiantUnit = KilledRadiantUnit + 1
	end	
    if killedUnit:GetUnitName() == "npc_louis" then
		KilledRadiantUnit = KilledRadiantUnit + 1
	end	
    if killedUnit:GetUnitName() == "npc_loki" then
		KilledDireUnit = KilledDireUnit + 1
	end	
    if killedUnit:GetUnitName() == "npc_merle" then
		KilledDireUnit = KilledDireUnit + 1
	end	
    if killedUnit:GetUnitName() == "npc_bender" then
		KilledDireUnit = KilledDireUnit + 1
	end	
    if killedUnit:GetUnitName() == "npc_redfield" then
		KilledDireUnit = KilledDireUnit + 1
	end	
--[[
	if KilledRadiantUnit >=4 then
		GameRules:SetGameWinner(DOTA_TEAM_BADGUYS)
	end

	if KilledDireUnit >=4 then
		GameRules:SetGameWinner(DOTA_TEAM_GOODGUYS)
	end]]

end

function InvasionMode:ScorchedEarthCreateDrop(itemName, pos)
   local newItem = CreateItem(itemName, nil, nil)
   newItem:SetPurchaseTime(0)
   CreateItemOnPositionSync(pos, newItem)
   newItem:LaunchLoot(false, 200, 0.75, pos + RandomVector(RandomFloat(50, 100)))
end
