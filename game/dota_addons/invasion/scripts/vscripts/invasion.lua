



if InvasionMode == nil then
	InvasionMode = class({})
end


function InvasionMode:InvasionMap()

	
	GameRules:SetCustomGameTeamMaxPlayers( DOTA_TEAM_GOODGUYS, 5 )
	GameRules:SetCustomGameTeamMaxPlayers( DOTA_TEAM_BADGUYS, 0 )

	GameRules:SetSameHeroSelectionEnabled(false)
	
	GameRules:SetTimeOfDay( 0.5 )
	GameRules:SetHeroRespawnEnabled( true )
	GameRules:SetUseUniversalShopMode( true )
	GameRules:SetHeroSelectionTime( 20.0 )
	GameRules:SetPreGameTime( 10.0 )
	GameRules:SetPostGameTime( 60.0 )
	GameRules:SetTreeRegrowTime( 60.0 )
	GameRules:SetHeroMinimapIconScale( 0.7 )
	GameRules:SetCreepMinimapIconScale( 0.7 )
	GameRules:SetRuneMinimapIconScale( 0.7 )
	GameRules:SetGoldTickTime( 60.0 )
	GameRules:SetGoldPerTick( 0 )
	GameRules:GetGameModeEntity():SetRemoveIllusionsOnDeath( true )
	GameRules:GetGameModeEntity():SetTopBarTeamValuesOverride( true )
	GameRules:GetGameModeEntity():SetTopBarTeamValuesVisible( false )

	ListenToGameEvent('game_rules_state_change', Dynamic_Wrap(InvasionMode, 'InvasionMapGameRulesStateChange'), self)
	ListenToGameEvent('entity_killed', Dynamic_Wrap(InvasionMode, 'OnEntityKilled'), self)	
	--ListenToGameEvent('dota_glyph_used', Dynamic_Wrap(InvasionMode, 'OnGlyphUsed'), self)	
	ListenToGameEvent('dota_item_picked_up', Dynamic_Wrap(InvasionMode, 'OnItemPickedUp'), self)
	
	
	local point = Entities:FindByName( nil, "spawn_base"):GetAbsOrigin()
	local unit = CreateUnitByName("npc_base", point, true, nil, nil, DOTA_TEAM_GOODGUYS )	
	unit:SetForwardVector(Vector(0,-1,0))
end


 function InvasionMode:InvasionMapGameRulesStateChange(keys)
  local newState = GameRules:State_Get()
  if newState == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
    InvasionMode:InvasionGameStart()
  end
end


function InvasionMode:InvasionGameStart()

InvasionMode:SpawnMoobs()


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
	GameRules:SendCustomMessage("<font color='#58ACFA'>Lana Del Rey – Summertime Sadness</font>", 0, 0)
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
	EmitGlobalSound("invasion.Night")
	local messageinfo = { message = "#popup_body_third_night", duration = 5}
	FireGameEvent("show_center_message",messageinfo)
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

 
Timers:CreateTimer(30,function()
local point = nil
local unit = nil
local presentTime = GameRules:GetDOTATime(false,false)
local return_time = 10

if GameRules:IsDaytime() == false then
EmitGlobalSound("Invasion.Zombie")
------------------------------------second--------------------------------
	--[[
	if presentTime > 240 and presentTime < 480 then
		for n = 0, 7 do
			for i = 11, 23 do
				point = Entities:FindByName( nil, "spawn_" .. i):GetAbsOrigin()
				unit = CreateUnitByName("dead_ghost", point + RandomVector( RandomFloat( 0, 100 )), true, nil, nil, DOTA_TEAM_BADGUYS )
				way = Entities:FindByName( nil, "way_1") 
				unit:SetInitialGoalEntity( way )				
			end
		end
	end]]
------------------------------------second--------------------------------
	if presentTime > 720 and presentTime < 960 then
		for n = 0, 4 do
			for i = 53, 56 do
				point = Entities:FindByName( nil, "spawn_" .. i):GetAbsOrigin()
				unit = CreateUnitByName("mad_tight_zombies", point + RandomVector( RandomFloat( 0, 100 )), true, nil, nil, DOTA_TEAM_BADGUYS )
				way = Entities:FindByName( nil, "way_1") 
				unit:SetInitialGoalEntity( way )				
			end
		end
		for i = 10, 24 do
			point = Entities:FindByName( nil, "spawn_" .. i):GetAbsOrigin()
			unit = CreateUnitByName("dead_ghost", point, true, nil, nil, DOTA_TEAM_BADGUYS )
			way = Entities:FindByName( nil, "way_1") 
			unit:SetInitialGoalEntity( way )	
		end	
		return_time = 15
	end
------------------------------------third--------------------------------
	if presentTime > 1200 and presentTime < 1440 then
		for n = 0, 6 do
			for i = 57, 58 do
				point = Entities:FindByName( nil, "spawn_" .. i):GetAbsOrigin()
				unit = CreateUnitByName("mad_toothy_zombies", point + RandomVector( RandomFloat( 0, 100 )), true, nil, nil, DOTA_TEAM_BADGUYS )
				way = Entities:FindByName( nil, "way_1") 
				unit:SetInitialGoalEntity( way )
				unit:AddNewModifier(unit, nil, "modifier_item_monkey_king_bar", {}) 				
			end
		end
		for i = 14, 24 do
			point = Entities:FindByName( nil, "spawn_" .. i):GetAbsOrigin()
			unit = CreateUnitByName("dead_ghost", point, true, nil, nil, DOTA_TEAM_BADGUYS )
			way = Entities:FindByName( nil, "way_1") 
			unit:SetInitialGoalEntity( way )	
		end	
		return_time = 20	
	end
	
end
	
	
return return_time
end)


end

function InvasionMode:SpawnMoobs()
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
	ability = unit:FindAbilityByName("respawn")
	ability:SetOverrideCastPoint(i) 	
end	

for i = 10, 24 do
	point = Entities:FindByName( nil, "spawn_" .. i):GetAbsOrigin()
	unit = CreateUnitByName("new_half_zombies", point, true, nil, nil, DOTA_TEAM_BADGUYS )
	ability = unit:FindAbilityByName("respawn")
	ability:SetOverrideCastPoint(i) 	
end	

for i = 0, 4 do
	point = Entities:FindByName( nil, "spawn_30"):GetAbsOrigin()
	unit = CreateUnitByName("pig", point + RandomVector( RandomFloat( 0, 100 )), true, nil, nil, DOTA_TEAM_BADGUYS )
	ability = unit:FindAbilityByName("respawn")
	ability:SetOverrideCastPoint(30) 	
end

for i = 0, 4 do
	point = Entities:FindByName( nil, "spawn_31"):GetAbsOrigin()
	unit = CreateUnitByName("sheep", point + RandomVector( RandomFloat( 0, 100 )), true, nil, nil, DOTA_TEAM_BADGUYS )
	ability = unit:FindAbilityByName("respawn")
	ability:SetOverrideCastPoint(31) 	
end


for i = 0, 7 do
	point = Entities:FindByName( nil, "spawn_50"):GetAbsOrigin()
	unit = CreateUnitByName("sickly_zombies", point + RandomVector( RandomFloat( 0, 100 )), true, nil, nil, DOTA_TEAM_BADGUYS )
	ability = unit:FindAbilityByName("respawn")
	ability:SetOverrideCastPoint(50) 	
end

for i = 0, 3 do
	point = Entities:FindByName( nil, "spawn_51"):GetAbsOrigin()
	unit = CreateUnitByName("sickly_zombies", point + RandomVector( RandomFloat( 0, 100 )), true, nil, nil, DOTA_TEAM_BADGUYS )
	ability = unit:FindAbilityByName("respawn")
	ability:SetOverrideCastPoint(51) 	
end

for i = 0, 3 do
	point = Entities:FindByName( nil, "spawn_52"):GetAbsOrigin()
	unit = CreateUnitByName("sickly_zombies", point + RandomVector( RandomFloat( 0, 100 )), true, nil, nil, DOTA_TEAM_BADGUYS )
	ability = unit:FindAbilityByName("respawn")
	ability:SetOverrideCastPoint(52) 	
end

for i = 0, 7 do
	point = Entities:FindByName( nil, "spawn_53"):GetAbsOrigin()
	unit = CreateUnitByName("tight_zombies", point + RandomVector( RandomFloat( 0, 100 )), true, nil, nil, DOTA_TEAM_BADGUYS )
	ability = unit:FindAbilityByName("respawn")
	ability:SetOverrideCastPoint(53) 	
end


for i = 0, 3 do
	point = Entities:FindByName( nil, "spawn_54"):GetAbsOrigin()
	unit = CreateUnitByName("tight_zombies", point + RandomVector( RandomFloat( 0, 100 )), true, nil, nil, DOTA_TEAM_BADGUYS )
	ability = unit:FindAbilityByName("respawn")
	ability:SetOverrideCastPoint(54) 	
end

for i = 0, 3 do
	point = Entities:FindByName( nil, "spawn_55"):GetAbsOrigin()
	unit = CreateUnitByName("tight_zombies", point + RandomVector( RandomFloat( 0, 100 )), true, nil, nil, DOTA_TEAM_BADGUYS )
	ability = unit:FindAbilityByName("respawn")
	ability:SetOverrideCastPoint(55) 	
end
	
for i = 0, 7 do
	point = Entities:FindByName( nil, "spawn_56"):GetAbsOrigin()
	unit = CreateUnitByName("tight_zombies", point + RandomVector( RandomFloat( 0, 100 )), true, nil, nil, DOTA_TEAM_BADGUYS )
	ability = unit:FindAbilityByName("respawn")
	ability:SetOverrideCastPoint(56) 	
end

for n = 0, 7 do
	for i = 57, 58 do
		point = Entities:FindByName( nil, "spawn_" .. i):GetAbsOrigin()
		unit = CreateUnitByName("toothy_zombies", point + RandomVector( RandomFloat( 0, 100 )), true, nil, nil, DOTA_TEAM_BADGUYS )
		ability = unit:FindAbilityByName("respawn")
		ability:SetOverrideCastPoint(i) 	
	end
end


	
end
 
function InvasionMode:OnEntityKilled (event)
   local killedEntity = EntIndexToHScript(event.entindex_killed)
    if killedEntity:GetUnitName() == "npc_base" then
		GameRules:SetGameWinner(DOTA_TEAM_BADGUYS)
		EmitGlobalSound("Invasion.HommerWin")
	end	
   
   
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
   end 
   if killedEntity:GetUnitName() == "boss_undying" then
	      InvasionMode:CreateDrop("item_rapier", killedEntity:GetAbsOrigin())
   end 

 end
 
function InvasionMode:CreateDrop (itemName, pos)
   local newItem = CreateItem(itemName, nil, nil)
   newItem:SetPurchaseTime(0)
   CreateItemOnPositionSync(pos, newItem)
   newItem:LaunchLoot(false, 300, 0.75, pos + RandomVector(RandomFloat(50, 350)))
 end
 

 function InvasionMode:OnItemPickedUp(data)
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