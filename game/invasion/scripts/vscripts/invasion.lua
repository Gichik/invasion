
require( 'modifiers_links' )

if InvasionMode == nil then
	InvasionMode = class({})
end

BossesArtifacts = 0
NecrolyteIsDead = 0

-- -item item_undying_heart
-- -item item_witch_eye

function InvasionMode:InvasionMap()

	
	GameRules:SetCustomGameTeamMaxPlayers( DOTA_TEAM_GOODGUYS, 5 )
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

	GameRules:GetGameModeEntity():SetDamageFilter(Dynamic_Wrap(InvasionMode, "DamageFilter"), self)	

	ListenToGameEvent('game_rules_state_change', Dynamic_Wrap(InvasionMode, 'InvasionMapGameRulesStateChange'), self)
	ListenToGameEvent('entity_killed', Dynamic_Wrap(InvasionMode, 'InvasionEntityKilled'), self)		
	ListenToGameEvent('dota_item_picked_up', Dynamic_Wrap(InvasionMode, 'InvasionOnItemPickedUp'), self)
	ListenToGameEvent('npc_spawned', Dynamic_Wrap(InvasionMode, 'InvasionOnNPCSpawn'), self)	

	--local point = Entities:FindByName( nil, "wood_spawn_1"):GetAbsOrigin()
	--local unit = CreateUnitByName("wood_wall", point, true, nil, nil, DOTA_TEAM_NEUTRALS )	
	--unit:SetForwardVector(Vector(-1,0,0))
	--unit:SetHullRadius(100.0)
	--point = Entities:FindByName( nil, "wood_spawn_2"):GetAbsOrigin()
	--unit = CreateUnitByName("wood_wall", point, true, nil, nil, DOTA_TEAM_NEUTRALS )
	--unit:SetForwardVector(Vector(0,-1,0))
	--unit:SetHullRadius(100.0)

end


function InvasionMode:DamageFilter(data)
	local damage 				= data.damage
	local entindex_inflictor_const 	= data.entindex_inflictor_const
	local entindex_victim_const		= data.entindex_victim_const
	local entindex_attacker_const 	= data.entindex_attacker_const
	local damagetype_const 		= data.damagetype_const
	local ability = nil
	local victim = nil
	local attacker = nil
print(damage)

	if damage > 0 then

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
		
	end
	return true;
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

	if npc:IsHero() then

		if not ChekQuestModifier(npc) then
			npc:AddNewModifier(npc, nil, GetQuestModifierName(), {duration = 120})
		end

		if not npc.next_spawn then
			npc.next_spawn = true;

			if npc:GetName() == "npc_dota_hero_tidehunter" then
				npc:AddNewModifier(npc, nil, "modifier_item_ultimate_scepter", {})	
			end
			
			if npc:GetName() == "npc_dota_hero_ember_spirit" then
				npc:FindAbilityByName("ogre_magi_multicast"):SetLevel(1)	
			end	

			if npc:GetName() == "npc_dota_hero_invoker" then
				npc:FindAbilityByName("black_dragon_splash_attack"):SetLevel(1)	
			end
		end		
	end
end


function InvasionMode:InvasionGameStart()

InvasionMode:InvasionSpawnMoobs()



Timers:CreateTimer(2,function()
	
	local presentTime = GameRules:GetDOTATime(false,false)
	if presentTime < 1400 then
		EmitGlobalSound("Invasion.Intro")	
		GameRules:SendCustomMessage("<font color='#58ACFA'>Akira Yamaoka – Never Forgive Me</font>", 0, 0)
	end

return nil
--return 480
end)

Timers:CreateTimer(475,function()
	local presentTime = GameRules:GetDOTATime(false,false)
	EmitGlobalSound("Invasion.Summertime")	
	GameRules:SendCustomMessage("<font color='#58ACFA'>Lana Del Rey - Summertime Sadness (smoke remix)</font>", 0, 0)
return nil
end)

Timers:CreateTimer(240,function()
	--EmitGlobalSound("Invasion.Zombie")
	EmitGlobalSound("Invasion.Night")
	local messageinfo = { message = "#popup_body_first_night", duration = 5}
    FireGameEvent("show_center_message",messageinfo)
return nil
end)
--[[
Timers:CreateTimer(720,function()
	EmitGlobalSound("invasion.zombie")
	EmitGlobalSound("invasion.Night")
	local messageinfo = { message = "Night came, and with it the death", duration = 5}
	FireGameEvent("show_center_message",messageinfo)
return nil
end)
]]
--12 минута, 2я ночь
Timers:CreateTimer(720,function()
	--EmitGlobalSound("invasion.zombie")
	EmitGlobalSound("invasion.Night")
	local messageinfo = { message = "#popup_body_second_night", duration = 5}
	FireGameEvent("show_center_message",messageinfo)
return nil
end)
--20 минута, 3я ночь
Timers:CreateTimer(1200,function()
	--EmitGlobalSound("invasion.zombie")
	if BossesArtifacts < 2 then
		EmitGlobalSound("invasion.Night")
	end
	local messageinfo = { message = "#popup_body_third_night", duration = 5}
	FireGameEvent("show_center_message",messageinfo)


--EmitGlobalSound("Invasion.EpicFight1")
--GameRules:SendCustomMessage("<font color='#58ACFA'>Daniel Pemberton - (ost)King Arthur: Legend of the Sword</font>", 0, 0) 
return nil
end)
 --24 минута, конец 3ей ночи, день
Timers:CreateTimer(1400,function()
 	EmitGlobalSound("Invasion.Castaways")
	GameRules:SendCustomMessage("<font color='#58ACFA'>The Castaways – Liar Liar</font>", 0, 0) 
return nil
end) 
 
 Timers:CreateTimer(1480,function()
	local messageinfo = { message = "#popup_body_win", duration = 5}
	FireGameEvent("show_center_message",messageinfo)
	GameRules:SetGameWinner( DOTA_TEAM_GOODGUYS )
return nil
end)

 --[[
	Timers:CreateTimer(30,function()
		local presentTime = GameRules:GetDOTATime(false,false)
		local return_time = 10
		local zombieName = nil

		if GameRules:IsDaytime() == false then
			EmitGlobalSound("Invasion.Zombie")

			if presentTime > 1200 then
				return_time = 20
				zombieName = "mad_toothy_zombies"		
				--print(">1200")
			elseif presentTime > 720 then
				return_time = 15
				zombieName = "mad_tight_zombies"
				--print(">720")
			elseif presentTime > 240 then
				return_time = 15
				--print(">240")	
			end

			for i = 53, 56 do
				InvasionMode:InvasionSpawnWaveUnits(zombieName, "spawn_" .. i, "way_1", 4, DOTA_TEAM_BADGUYS)
			end
				
		end
			
		return return_time
	end)]]

end

function InvasionMode:InvasionSpawnMoobs()
local point = nil
local unit = nil
local ability = nil
local way = nil
local i = 0

	point = Entities:FindByName( nil, "spawn_boss"):GetAbsOrigin()
	unit = CreateUnitByName("Forest_ghost", point, true, nil, nil, DOTA_TEAM_BADGUYS )
	--ability = unit:FindAbilityByName("respawn")

	point = Entities:FindByName( nil, "spawn_59"):GetAbsOrigin()
	unit = CreateUnitByName("boss_undying", point, true, nil, nil, DOTA_TEAM_BADGUYS )	

for i = 0, 4 do
	point = Entities:FindByName( nil, "spawn_" .. i):GetAbsOrigin()
	unit = CreateUnitByName("cadaveric_bunch", point, true, nil, nil, DOTA_TEAM_BADGUYS )
	--ability = unit:FindAbilityByName("respawn")
	--ability:SetOverrideCastPoint(i) 
	unit.vSpawnLoc = unit:GetOrigin()
	unit.vSpawnVector = Vector(-1,-1,0)
	unit:SetForwardVector(Vector(-1,-1,0))	
end	

for i = 10, 29 do
	point = Entities:FindByName( nil, "spawn_" .. i):GetAbsOrigin()
	unit = CreateUnitByName("new_half_zombies", point, true, nil, nil, DOTA_TEAM_BADGUYS )
	--ability = unit:FindAbilityByName("respawn")
	--ability:SetOverrideCastPoint(i) 
	unit.vSpawnLoc = unit:GetOrigin()
	unit.vSpawnVector = Vector(-1,-1,0)
	unit:SetForwardVector(Vector(-1,-1,0))	
end	



for i = 0, 4 do
	point = Entities:FindByName( nil, "spawn_30"):GetAbsOrigin()
	unit = CreateUnitByName("pig", point + RandomVector( RandomFloat( 0, 100 )), true, nil, nil, DOTA_TEAM_BADGUYS )
	--ability = unit:FindAbilityByName("respawn")
	--ability:SetOverrideCastPoint(30)
	unit.vSpawnLoc = unit:GetOrigin()
	unit.vSpawnVector = Vector(1,0,0)
	unit:SetForwardVector(Vector(1,0,0))	 	
end

for i = 0, 4 do
	point = Entities:FindByName( nil, "spawn_31"):GetAbsOrigin()
	unit = CreateUnitByName("sheep", point + RandomVector( RandomFloat( 0, 100 )), true, nil, nil, DOTA_TEAM_BADGUYS )
	--ability = unit:FindAbilityByName("respawn")
	--ability:SetOverrideCastPoint(31) 	
	unit.vSpawnLoc = unit:GetOrigin()
	unit.vSpawnVector = Vector(-1,0,0)
	unit:SetForwardVector(Vector(-1,0,0))	
end


for i = 0, 7 do
	point = Entities:FindByName( nil, "spawn_50"):GetAbsOrigin()
	unit = CreateUnitByName("sickly_zombies", point + RandomVector( RandomFloat( 0, 100 )), true, nil, nil, DOTA_TEAM_BADGUYS )
	--ability = unit:FindAbilityByName("respawn")
	--ability:SetOverrideCastPoint(50) 
	unit.vSpawnLoc = unit:GetOrigin()
	unit.vSpawnVector = Vector(1,0,0)
	unit:SetForwardVector(Vector(1,0,0))		
end

for i = 0, 3 do
	point = Entities:FindByName( nil, "spawn_51"):GetAbsOrigin()
	unit = CreateUnitByName("sickly_zombies", point + RandomVector( RandomFloat( 0, 100 )), true, nil, nil, DOTA_TEAM_BADGUYS )
	--ability = unit:FindAbilityByName("respawn")
	--ability:SetOverrideCastPoint(51) 	
	unit.vSpawnLoc = unit:GetOrigin()
	unit.vSpawnVector = Vector(-1,0,0)
	unit:SetForwardVector(Vector(-1,0,0))	
end

for i = 0, 3 do
	point = Entities:FindByName( nil, "spawn_52"):GetAbsOrigin()
	unit = CreateUnitByName("sickly_zombies", point + RandomVector( RandomFloat( 0, 100 )), true, nil, nil, DOTA_TEAM_BADGUYS )
	--ability = unit:FindAbilityByName("respawn")
	--ability:SetOverrideCastPoint(52)
	unit.vSpawnLoc = unit:GetOrigin()
	unit.vSpawnVector = Vector(-1,0,0)
	unit:SetForwardVector(Vector(-1,0,0))	 	
end

for i = 0, 7 do
	point = Entities:FindByName( nil, "spawn_53"):GetAbsOrigin()
	unit = CreateUnitByName("tight_zombies", point + RandomVector( RandomFloat( 0, 100 )), true, nil, nil, DOTA_TEAM_BADGUYS )
	--ability = unit:FindAbilityByName("respawn")
	--ability:SetOverrideCastPoint(53) 	
	unit.vSpawnLoc = unit:GetOrigin()
	unit.vSpawnVector = Vector(-1,0,0)
	unit:SetForwardVector(Vector(-1,0,0))	
end


for i = 0, 3 do
	point = Entities:FindByName( nil, "spawn_54"):GetAbsOrigin()
	unit = CreateUnitByName("tight_zombies", point + RandomVector( RandomFloat( 0, 100 )), true, nil, nil, DOTA_TEAM_BADGUYS )
	--ability = unit:FindAbilityByName("respawn")
	--ability:SetOverrideCastPoint(54)
	unit.vSpawnLoc = unit:GetOrigin()
	unit.vSpawnVector = Vector(1,0,0)
	unit:SetForwardVector(Vector(1,0,0))	 	
end

for i = 0, 3 do
	point = Entities:FindByName( nil, "spawn_55"):GetAbsOrigin()
	unit = CreateUnitByName("tight_zombies", point + RandomVector( RandomFloat( 0, 100 )), true, nil, nil, DOTA_TEAM_BADGUYS )
	--ability = unit:FindAbilityByName("respawn")
	--ability:SetOverrideCastPoint(55) 
	unit.vSpawnLoc = unit:GetOrigin()
	unit.vSpawnVector = Vector(-1,0,0)
	unit:SetForwardVector(Vector(-1,0,0))
end
	
for i = 0, 7 do
	point = Entities:FindByName( nil, "spawn_56"):GetAbsOrigin()
	unit = CreateUnitByName("tight_zombies", point + RandomVector( RandomFloat( 0, 100 )), true, nil, nil, DOTA_TEAM_BADGUYS )
	--ability = unit:FindAbilityByName("respawn")
	--ability:SetOverrideCastPoint(56)
	unit.vSpawnLoc = unit:GetOrigin()
	unit.vSpawnVector = Vector(1,0,0)
	unit:SetForwardVector(Vector(1,0,0))	 	
end

for n = 0, 7 do
	for i = 57, 58 do
		point = Entities:FindByName( nil, "spawn_" .. i):GetAbsOrigin()
		unit = CreateUnitByName("toothy_zombies", point + RandomVector( RandomFloat( 0, 100 )), true, nil, nil, DOTA_TEAM_BADGUYS )
		--ability = unit:FindAbilityByName("respawn")
		--ability:SetOverrideCastPoint(i)
		unit.vSpawnLoc = unit:GetOrigin()
		unit.vSpawnVector = Vector(0,-1,0)
		unit:SetForwardVector(Vector(0,-1,0))		 	
	end
end


	
end
 
function InvasionMode:InvasionEntityKilled (data)
   local killedEntity = EntIndexToHScript(data.entindex_killed)

--    if killedEntity:IsRealHero() then
--		local unit = EntIndexToHScript(data.entindex_attacker)
--		unit:AddSpeechBubble(1, "#PlayerDead", 2, 0, 0)
--	end	

    if killedEntity:GetUnitName() == "NPC_base" then
		GameRules:SetGameWinner(DOTA_TEAM_BADGUYS)
		EmitGlobalSound("Invasion.HommerWin")
	end	

--	if killedEntity:GetUnitName() == "npc_enchantress_base" then
--		GameRules:SetGoldPerTick( 0 )
--		local unit = Entities:FindByName(nil, "NPC_base")
--		unit:AddSpeechBubble(1, "#EnchDead_Bubble", 2, 0, 0)
		--EmitGlobalSound("Invasion.HommerWin")
--	end	


   if killedEntity:GetUnitName() == "pig" then
    if RandomInt(1, 10) > 5  then
     InvasionMode:CreateDrop("item_food_cheese", killedEntity:GetAbsOrigin())
	 end
   end
   if killedEntity:GetUnitName() == "sheep" then
	 if RandomInt(1, 10) > 5  then
     InvasionMode:CreateDrop("item_milk", killedEntity:GetAbsOrigin())
	 end
   end
	if killedEntity:GetUnitName() == "Forest_ghost" then
		for i = 1, 4  do
			InvasionMode:CreateDrop("item_bag_of_gold", killedEntity:GetAbsOrigin())
		end
		if GameRules:IsDaytime() == false then
			Say(nil,"Necromancer: Excellent! Bring it to me!", true)
			InvasionMode:CreateDrop("item_witch_eye", killedEntity:GetAbsOrigin())
		end
		InvasionMode:InvasionActivateGhosts()	 
	end 
	if killedEntity:GetUnitName() == "boss_undying" then
		--InvasionMode:CreateDrop("item_rapier", killedEntity:GetAbsOrigin())
		for i = 1, 4  do
			InvasionMode:CreateDrop("item_bag_of_gold", killedEntity:GetAbsOrigin())
		end
		if GameRules:IsDaytime() == false then
			Say(nil,"Necromancer: Excellent! Bring it to me!", true)
			InvasionMode:CreateDrop("item_undying_heart", killedEntity:GetAbsOrigin())
		end
		InvasionMode:InvasionActivateMadZombies()
	end 

	if killedEntity:GetUnitName() == "npc_necrolyte_quest" then
		if BossesArtifacts > 1 then
			Say(nil,"Necromancer: Hahah, you fool, you can not stop your death! He's coming on third night!", true)
		else
			Say(nil,"Necromancer: I could make you a god ... But you get nothing... Good day sir!", true)
		end
		InvasionMode:InvasionActivateGhoul()
		NecrolyteIsDead = 1	 
	end 	

	if killedEntity:GetUnitName() == "npc_crate_of_provisions" then
		InvasionMode:CreateDrop("item_crate_of_provisions", killedEntity:GetAbsOrigin())
	end

 end
 
function InvasionMode:CreateDrop (itemName, pos)
   local newItem = CreateItem(itemName, nil, nil)
   newItem:SetPurchaseTime(0)
   CreateItemOnPositionSync(pos, newItem)
   newItem:LaunchLoot(false, 300, 0.75, pos + RandomVector(RandomFloat(50, 350)))
end


function InvasionMode:InvasionOnItemPickedUp(data)
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

function InvasionMode:InvasionSpawnWaveUnits(unitName, pointName, wayName, unitCount, team)
	local point = Entities:FindByName( nil, pointName):GetAbsOrigin()
	local way = Entities:FindByName( nil, wayName)
	local unit = nil

	if point and way and team and unitName and unitCount then 
		for i = 1, unitCount do	
			unit = CreateUnitByName(unitName, point + RandomVector( RandomFloat( 0, 100 )), true, nil, nil, team )
			if unit then
				unit:SetInitialGoalEntity( way )
				if unit:GetUnitName() == "mad_toothy_zombies" then
					unit:AddNewModifier(unit, nil, "modifier_item_monkey_king_bar", {}) 
				end
				if unit:GetUnitName() == "dead_ghost" then
					unit:AddNewModifier(unit, nil, "modifier_ghost_evasion", {}) 
				end
			end	
		end
	end
end

function InvasionMode:InvasionActivateGhosts()
	Timers:CreateTimer(1,function()
		local return_time = 15
		local ghostName = "dead_ghost"

		--if NecrolyteIsDead >= 1 then
		--	ghostName = "forest_hecate_ghost"
		--end

		if GameRules:IsDaytime() == false then
			for i = 10, 24 do
				InvasionMode:InvasionSpawnWaveUnits(ghostName, "spawn_" .. i, "way_1", 1, DOTA_TEAM_BADGUYS)	
			end		
		end
		
		return return_time
	end)
end

function InvasionMode:InvasionActivateMadZombies()
	Timers:CreateTimer(1,function()
		local return_time = 15

		if GameRules:IsDaytime() == false then
			for i = 53, 56 do
				InvasionMode:InvasionSpawnWaveUnits("mad_tight_zombies", "spawn_" .. i, "way_1", 5, DOTA_TEAM_BADGUYS)
			end		
		end
		
		return return_time
	end)
end

function InvasionMode:InvasionActivateGhoul()
	Timers:CreateTimer(1,function()
		local return_time = 15

		if GameRules:IsDaytime() == false then
			for i = 53, 56 do
				InvasionMode:InvasionSpawnWaveUnits("mad_toothy_zombies", "spawn_" .. i, "way_1", 5, DOTA_TEAM_BADGUYS)
			end		
		end
		
		return return_time
	end)
end


function InvasionMode:InvasionActivateDemonOfHell()
	Timers:CreateTimer(1,function()
		local return_time = 15
		local present_time = GameRules:GetDOTATime(false,false)

		if GameRules:IsDaytime() == false and present_time >= 1200 then
		   --print(BossesArtifacts)
	    	local way = Entities:FindByName( nil, "way_1")
	    	local unit = CreateUnitByName("npc_demon_of_hell", Vector(2314,350,64), true, nil, nil, DOTA_TEAM_BADGUYS )
			if unit then
					unit:SetInitialGoalEntity( way )
			end
			EmitGlobalSound("Invasion.EpicFight1")
			GameRules:SendCustomMessage("<font color='#58ACFA'>Daniel Pemberton - (ost)King Arthur: Legend of the Sword</font>", 0, 0) 
		return_time = nil
		end
		
		return return_time
	end)
end

function CheckBossesArtifacts(data)
	--for k,v in pairs(data) do
	--	print(k)
	--end
	local target = data.target
	--print(target:GetUnitName())

	if BossesArtifacts == 0 or BossesArtifacts == 1 then
		--ShowGenericPopupToPlayer(target, "#popup_title_necrolyte_first", "#popup_body_necrolyte_first", "", "", DOTA_SHOWGENERICPOPUP_TINT_SCREEN )
		Say(nil,"Necromancer: Do you want the power of the gods? Bring me the witch's eye and the heart of the immortal and I will make you a god. Only kill them at night, otherwise their bodies will melt in the sun...", true)
	elseif BossesArtifacts < 0 then 
		Say(nil,"Necromancer: Muhahahah, prepare to die!", true)
		--ShowGenericPopupToPlayer(target, "#popup_title_necrolyte_second", "#popup_body_necrolyte_second", "", "", DOTA_SHOWGENERICPOPUP_TINT_SCREEN )
	end

	
	if target then
		if target:HasItemInInventory("item_witch_eye") or target:HasItemInInventory("item_undying_heart") then
			for i = 0, 8 do 
				local item = target:GetItemInSlot(i)
				if item ~= nil then
					if item:GetAbilityName() == "item_witch_eye" or item:GetAbilityName() == "item_undying_heart" then
						target:RemoveItem(item)
						BossesArtifacts = BossesArtifacts + 1
					end				
				end
			end			
		end
	end

	if BossesArtifacts > 1 then
		--ShowGenericPopupToPlayer(target, "#popup_title_necrolyte_second", "#popup_body_necrolyte_second", "", "", DOTA_SHOWGENERICPOPUP_TINT_SCREEN )
		Say(nil,"Necromancer: Excellent! Now wait for the third night and accept your death!", true)
		InvasionMode:InvasionActivateDemonOfHell()
		BossesArtifacts = -1
	end

end