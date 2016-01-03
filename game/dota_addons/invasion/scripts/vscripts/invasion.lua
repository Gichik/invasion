GAME_ROUND = 1
ROUND_UNITS = 10 
nextTimer = 240
flagOfDay = 1



if InvasionMode == nil then
	InvasionMode = class({})
end


function InvasionMode:InvasionMap()

	
	GameRules:SetCustomGameTeamMaxPlayers( DOTA_TEAM_GOODGUYS, 5 )
	GameRules:SetCustomGameTeamMaxPlayers( DOTA_TEAM_BADGUYS, 0 )


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
	EmitGlobalSound("Invasion.Intro")
return 480
end)


Timers:CreateTimer(240,function()
	EmitGlobalSound("Invasion.Zombie")
	EmitGlobalSound("Invasion.Night")
	local messageinfo = { message = "You hear that?", duration = 5}
    FireGameEvent("show_center_message",messageinfo)
return nil
end)

Timers:CreateTimer(720,function()
	EmitGlobalSound("invasion.zombie")
	EmitGlobalSound("invasion.Night")
	local messageinfo = { message = "Night came, and with it the death", duration = 5}
	FireGameEvent("show_center_message",messageinfo)
return nil
end)

Timers:CreateTimer(1200,function()
	EmitGlobalSound("invasion.zombie")
	EmitGlobalSound("invasion.Night")
	local messageinfo = { message = "Do not lose hope, dawn soon", duration = 5}
	FireGameEvent("show_center_message",messageinfo)
return nil
end)

Timers:CreateTimer(1680,function()
	EmitGlobalSound("invasion.zombie")
	EmitGlobalSound("invasion.Night")
	local messageinfo = { message = "My hands in the blood, it is time to end", duration = 5}
	FireGameEvent("show_center_message",messageinfo)
return nil
end)
 
 
 Timers:CreateTimer(1960,function()
	local messageinfo = { message = "Yeah, i do it!", duration = 5}
	FireGameEvent("show_center_message",messageinfo)
	GameRules:SetGameWinner( DOTA_TEAM_GOODGUYS )
return nil
end)

 
Timers:CreateTimer(30,function()
local point = nil
local unit = nil
local presentTime = GameRules:GetDOTATime(false,false)

if GameRules:IsDaytime() == false then
------------------------------------second--------------------------------
	if presentTime > 720 and presentTime < 960 then
		for n = 0, 7 do
			for i = 50, 52 do
				point = Entities:FindByName( nil, "spawn_" .. i):GetAbsOrigin()
				unit = CreateUnitByName("mad_sickly_zombies", point + RandomVector( RandomFloat( 0, 100 )), true, nil, nil, DOTA_TEAM_BADGUYS )
				way = Entities:FindByName( nil, "way_1") 
				unit:SetInitialGoalEntity( way )				
			end
		end
	end
------------------------------------third--------------------------------
	if presentTime > 1200 and presentTime < 1440 then
		for n = 0, 5 do
			for i = 53, 56 do
				point = Entities:FindByName( nil, "spawn_" .. i):GetAbsOrigin()
				unit = CreateUnitByName("mad_tight_zombies", point + RandomVector( RandomFloat( 0, 100 )), true, nil, nil, DOTA_TEAM_BADGUYS )
				way = Entities:FindByName( nil, "way_1") 
				unit:SetInitialGoalEntity( way )				
			end
		end
	end
------------------------------------fourth--------------------------------
	if presentTime > 1680 and presentTime < 1920 then
		for n = 0, 7 do
			for i = 57, 59 do
				point = Entities:FindByName( nil, "spawn_" .. i):GetAbsOrigin()
				unit = CreateUnitByName("mad_toothy_zombies", point + RandomVector( RandomFloat( 0, 100 )), true, nil, nil, DOTA_TEAM_BADGUYS )
				way = Entities:FindByName( nil, "way_1") 
				unit:SetInitialGoalEntity( way )				
			end
		end
	end
	
end
	
	
return 10
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


for i = 0, 9 do
	point = Entities:FindByName( nil, "spawn_50"):GetAbsOrigin()
	unit = CreateUnitByName("sickly_zombies", point + RandomVector( RandomFloat( 0, 100 )), true, nil, nil, DOTA_TEAM_BADGUYS )
	ability = unit:FindAbilityByName("respawn")
	ability:SetOverrideCastPoint(50) 	
end

for i = 0, 4 do
	point = Entities:FindByName( nil, "spawn_51"):GetAbsOrigin()
	unit = CreateUnitByName("sickly_zombies", point + RandomVector( RandomFloat( 0, 100 )), true, nil, nil, DOTA_TEAM_BADGUYS )
	ability = unit:FindAbilityByName("respawn")
	ability:SetOverrideCastPoint(51) 	
end

for i = 0, 4 do
	point = Entities:FindByName( nil, "spawn_52"):GetAbsOrigin()
	unit = CreateUnitByName("sickly_zombies", point + RandomVector( RandomFloat( 0, 100 )), true, nil, nil, DOTA_TEAM_BADGUYS )
	ability = unit:FindAbilityByName("respawn")
	ability:SetOverrideCastPoint(52) 	
end

for i = 0, 9 do
	point = Entities:FindByName( nil, "spawn_53"):GetAbsOrigin()
	unit = CreateUnitByName("tight_zombies", point + RandomVector( RandomFloat( 0, 100 )), true, nil, nil, DOTA_TEAM_BADGUYS )
	ability = unit:FindAbilityByName("respawn")
	ability:SetOverrideCastPoint(53) 	
end


for i = 0, 4 do
	point = Entities:FindByName( nil, "spawn_54"):GetAbsOrigin()
	unit = CreateUnitByName("tight_zombies", point + RandomVector( RandomFloat( 0, 100 )), true, nil, nil, DOTA_TEAM_BADGUYS )
	ability = unit:FindAbilityByName("respawn")
	ability:SetOverrideCastPoint(54) 	
end

for i = 0, 4 do
	point = Entities:FindByName( nil, "spawn_55"):GetAbsOrigin()
	unit = CreateUnitByName("tight_zombies", point + RandomVector( RandomFloat( 0, 100 )), true, nil, nil, DOTA_TEAM_BADGUYS )
	ability = unit:FindAbilityByName("respawn")
	ability:SetOverrideCastPoint(55) 	
end
	
for i = 0, 9 do
	point = Entities:FindByName( nil, "spawn_56"):GetAbsOrigin()
	unit = CreateUnitByName("tight_zombies", point + RandomVector( RandomFloat( 0, 100 )), true, nil, nil, DOTA_TEAM_BADGUYS )
	ability = unit:FindAbilityByName("respawn")
	ability:SetOverrideCastPoint(56) 	
end

for n = 0, 9 do
	for i = 57, 59 do
		point = Entities:FindByName( nil, "spawn_" .. i):GetAbsOrigin()
		unit = CreateUnitByName("toothy_zombies", point + RandomVector( RandomFloat( 0, 100 )), true, nil, nil, DOTA_TEAM_BADGUYS )
		ability = unit:FindAbilityByName("respawn")
		ability:SetOverrideCastPoint(i) 	
	end
end


	
end
 
function InvasionMode:OnEntityKilled (event)
   local killedEntity = EntIndexToHScript(event.entindex_killed)
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
	 if RandomInt(1, 10) > 5  then
	      InvasionMode:CreateDrop("item_bfury", killedEntity:GetAbsOrigin())
	 else
		  InvasionMode:CreateDrop("item_assault", killedEntity:GetAbsOrigin())
	 end
   end   
 end
 
function InvasionMode:CreateDrop (itemName, pos)
   local newItem = CreateItem(itemName, nil, nil)
   newItem:SetPurchaseTime(0)
   CreateItemOnPositionSync(pos, newItem)
   newItem:LaunchLoot(false, 300, 0.75, pos + RandomVector(RandomFloat(50, 350)))
 end


 