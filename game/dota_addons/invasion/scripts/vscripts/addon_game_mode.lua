--[[
	Basic Barebones
]]

-- Required files to be visible from anywhere
require( 'timers' )
require( 'barebones' )

GAME_ROUND = 0
MAX_ROUNDS = 6
MAX_ROUNDS_2 = 30
ROUND_DURATION = 30 
ROUND_UNITS = 30 
nextTimer = 240

if GameMode == nil then
	GameMode = class({})
end

function Precache( context )
	-- NOTE: IT IS RECOMMENDED TO USE A MINIMAL AMOUNT OF LUA PRECACHING, AND A MAXIMAL AMOUNT OF DATADRIVEN PRECACHING.
	-- Precaching guide: https://moddota.com/forums/discussion/119/precache-fixing-and-avoiding-issues

	--[[
	This function is used to precache resources/units/items/abilities that will be needed
	for sure in your game and that cannot or should not be precached asynchronously or 
	after the game loads.
	See GameMode:PostLoadPrecache() in barebones.lua for more information
	]]

	print("[BAREBONES] Performing pre-load precache")

	-- Particles can be precached individually or by folder
	-- It it likely that precaching a single particle system will precache all of its children, but this may not be guaranteed
	PrecacheResource("particle", "particles/units/heroes/hero_leshrac/leshrac_lightning_bolt.vpcf" , context)
 	PrecacheResource("particle", "particles/econ/courier/courier_golden_roshan/golden_roshan_ambient.vpcf" , context)
 	PrecacheResource("particle", "particles/part_exp_two.vpcf" , context)
	PrecacheResource("particle", "particles/econ/generic/generic_aoe_explosion_sphere_1/generic_aoe_explosion_sphere_1.vpcf", context)
	PrecacheResource("particle_folder", "particles/test_particle", context)

	-- Models can also be precached by folder or individually
	-- PrecacheModel should generally used over PrecacheResource for individual models
	PrecacheResource("model_folder", "particles/heroes/antimage", context)
	PrecacheResource("model", "particles/heroes/viper/viper.vmdl", context)
	PrecacheModel("models/heroes/viper/viper.vmdl", context)

	-- Sounds can precached here like anything else
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_gyrocopter.vsndevts", context)

	-- Entire items can be precached by name
	-- Abilities can also be precached in this way despite the name
	PrecacheItemByNameSync("example_ability", context)
	PrecacheItemByNameSync("item_example_item", context)

	-- Entire heroes (sound effects/voice/models/particles) can be precached with PrecacheUnitByNameSync
	-- Custom units from npc_units_custom.txt can also have all of their abilities and precache{} blocks precached in this way
	PrecacheUnitByNameSync("npc_dota_hero_ancient_apparition", context)
	PrecacheUnitByNameSync("npc_dota_hero_enigma", context)
	PrecacheUnitByNameSync("sickly_zombies", context)
end

-- Create the game mode when we activate


 function CreateDrop (itemName, pos)
   local newItem = CreateItem(itemName, nil, nil)
   newItem:SetPurchaseTime(0)
   CreateItemOnPositionSync(pos, newItem)
   newItem:LaunchLoot(false, 300, 0.75, pos + RandomVector(RandomFloat(50, 350)))
 end
 
 function OnEntityKilled (event)
   local killedEntity = EntIndexToHScript(event.entindex_killed)
   if killedEntity:GetUnitName() == "cow" then
    if RandomInt(1, 10) > 8  then
     CreateDrop("item_flask", killedEntity:GetAbsOrigin())
	 end
   end
   if killedEntity:GetUnitName() == "sheep" then
	 if RandomInt(1, 10) > 8  then
     CreateDrop("item_clarity", killedEntity:GetAbsOrigin())
	 end
   end
 end

function Activate()
	GameRules.GameMode = GameMode()
	GameRules.GameMode:InitGameMode()
	ListenToGameEvent("entity_killed", OnEntityKilled, nil)
end
 
 
function GameMode:InitGameMode()



	local MapName = GetMapName()
	if MapName == "invasion" then
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

	
	--потоки
	local return_time = 30 
	  --поток 1го пути
      local point = Entities:FindByName( nil, "spawnerino"):GetAbsOrigin() --Записываем в переменную 'point' координаты нашего спавнера 'spawnerino'
	  local waypoint = Entities:FindByName( nil, "way1") -- Записываем в переменную 'waypoint' координаты первого бокса way1.

	  --поток 2го пути
	  local point_2 = Entities:FindByName( nil, "spawnerino_2"):GetAbsOrigin() --Записываем в переменную 'point' координаты нашего спавнера 'spawnerino'
	  local waypoint_2 = Entities:FindByName( nil, "way2") -- Записываем в переменную 'waypoint' координаты первого бокса way1.

	  --поток 3го пути
	  local point_3 = Entities:FindByName( nil, "spawnerino_3"):GetAbsOrigin() --Записываем в переменную 'point' координаты нашего спавнера 'spawnerino'
	  local waypoint_3 = Entities:FindByName( nil, "way3") -- Записываем в переменную 'waypoint' координаты первого бокса way1.

	  --поток 4го пути
	  local point_4 = Entities:FindByName( nil, "spawnerino_4"):GetAbsOrigin() --Записываем в переменную 'point' координаты нашего спавнера 'spawnerino'
	  local waypoint_4 = Entities:FindByName( nil, "way4") -- Записываем в переменную 'waypoint' координаты первого бокса way1.
  
	--переменные имен зомбаков		
	  local name_of_neutral_zombies = "sickly_zombies"
	  local name_of_wave_zombies = "mad_sickly_zombies"	
	
	--нейтралы	
	  local return_neutral_time = 40

	  
	  local cow_point = Entities:FindByName( nil, "spawner_cow"):GetAbsOrigin()
      local cow_way = Entities:FindByName( nil, "cow_point")   
 	  local sheep_point = Entities:FindByName( nil, "spawner_sheep"):GetAbsOrigin()
      local sheep_way = Entities:FindByName( nil, "sheep_point")  
 
	  local neutral_point_1 = Entities:FindByName( nil, "spawner_neutral_1"):GetAbsOrigin()
      local neutral_waypoint_1 = Entities:FindByName( nil, "way_neutral_1_1")

      
	  local neutral_point_2 = Entities:FindByName( nil, "spawner_neutral_2"):GetAbsOrigin()
      local neutral_waypoint_2 = Entities:FindByName( nil, "way_neutral_2_1")
    
	  local neutral_point_2 = Entities:FindByName( nil, "spawner_neutral_2"):GetAbsOrigin()
      local neutral_waypoint_2 = Entities:FindByName( nil, "way_neutral_2_1")

	  local neutral_point_3 = Entities:FindByName( nil, "spawner_neutral_3"):GetAbsOrigin()
      local neutral_waypoint_3 = Entities:FindByName( nil, "way_neutral_3_1")

	  local neutral_point_4 = Entities:FindByName( nil, "spawner_neutral_4"):GetAbsOrigin()
      local neutral_waypoint_4 = Entities:FindByName( nil, "way_neutral_4_1")

	  local neutral_point_5 = Entities:FindByName( nil, "spawner_neutral_5"):GetAbsOrigin()
      local neutral_waypoint_5 = Entities:FindByName( nil, "way_neutral_5_1")

	  local neutral_point_6 = Entities:FindByName( nil, "spawner_neutral_6"):GetAbsOrigin()
      local neutral_waypoint_6 = Entities:FindByName( nil, "way_neutral_6_1")

	  local neutral_point_7 = Entities:FindByName( nil, "spawner_neutral_7"):GetAbsOrigin()
      local neutral_waypoint_7 = Entities:FindByName( nil, "way_neutral_7_1")

	  local neutral_point_8 = Entities:FindByName( nil, "spawner_neutral_8"):GetAbsOrigin()
      local neutral_waypoint_8 = Entities:FindByName( nil, "way_neutral_8_1")
	  
	 

		 Timers:CreateTimer(10, function()
			  for i=1, 4 do 		  
				local neutral_cow = CreateUnitByName( "cow", cow_point + RandomVector( RandomFloat( 0, 200 ) ), true, nil, nil, DOTA_TEAM_NEUTRALS )
				neutral_cow:SetInitialGoalEntity( cow_way )
				local neutral_sheep = CreateUnitByName( "sheep", sheep_point + RandomVector( RandomFloat( 0, 200 ) ), true, nil, nil, DOTA_TEAM_NEUTRALS )
				neutral_sheep:SetInitialGoalEntity( sheep_way )			  
			  end
			  return return_neutral_time
			end)

								
		 Timers:CreateTimer(10, function()
		  	  
		  	if GAME_ROUND == 2 then
				name_of_neutral_zombies = "tight_zombies"
			end
			
			if GAME_ROUND == 4 then
				name_of_neutral_zombies = "toothy_zombies"
			end	
		  
		  for i=1, 3 do 		
		    local neutral_unit_1 = CreateUnitByName( name_of_neutral_zombies, neutral_point_1 + RandomVector( RandomFloat( 0, 50 ) ), true, nil, nil, DOTA_TEAM_NEUTRALS )
			neutral_unit_1:SetInitialGoalEntity( neutral_waypoint_1 )		   
		    local neutral_unit_2 = CreateUnitByName( name_of_neutral_zombies, neutral_point_2 + RandomVector( RandomFloat( 0, 50 ) ), true, nil, nil, DOTA_TEAM_NEUTRALS )
			neutral_unit_2:SetInitialGoalEntity( neutral_waypoint_2 )			 					
		    local neutral_unit_3 = CreateUnitByName( name_of_neutral_zombies, neutral_point_3 + RandomVector( RandomFloat( 0, 50 ) ), true, nil, nil, DOTA_TEAM_NEUTRALS )
			neutral_unit_3:SetInitialGoalEntity( neutral_waypoint_3 )
			local neutral_unit_4 = CreateUnitByName( name_of_neutral_zombies, neutral_point_4 + RandomVector( RandomFloat( 0, 50 ) ), true, nil, nil, DOTA_TEAM_NEUTRALS )
			neutral_unit_4:SetInitialGoalEntity( neutral_waypoint_4 )				  
		    local neutral_unit_5 = CreateUnitByName( name_of_neutral_zombies, neutral_point_5 + RandomVector( RandomFloat( 0, 50 ) ), true, nil, nil, DOTA_TEAM_NEUTRALS )
			neutral_unit_5:SetInitialGoalEntity( neutral_waypoint_5 )
			local neutral_unit_6 = CreateUnitByName( name_of_neutral_zombies, neutral_point_6 + RandomVector( RandomFloat( 0, 50 ) ), true, nil, nil, DOTA_TEAM_NEUTRALS )
			neutral_unit_6:SetInitialGoalEntity( neutral_waypoint_6 )		  
		    local neutral_unit_7 = CreateUnitByName( name_of_neutral_zombies, neutral_point_7 + RandomVector( RandomFloat( 0, 50 ) ), true, nil, nil, DOTA_TEAM_NEUTRALS )
			neutral_unit_7:SetInitialGoalEntity( neutral_waypoint_7 )		    
			local neutral_unit_8 = CreateUnitByName( name_of_neutral_zombies, neutral_point_8 + RandomVector( RandomFloat( 0, 50 ) ), true, nil, nil, DOTA_TEAM_NEUTRALS )
			neutral_unit_8:SetInitialGoalEntity( neutral_waypoint_8 )
						
		  end
		  return return_neutral_time
			end)
								  	  



									  
		 Timers:CreateTimer(30, function()		  
		  
		  local minuts = GameRules:GetDOTATime(false, false)
			 if  minuts < nextTimer then
				 local wait = nextTimer - minuts
				 return wait
			 end
			 

		  
		  GAME_ROUND = GAME_ROUND + 1 --Значение GAME_ROUND увеличивается на 1.
		  
		  if GAME_ROUND == MAX_ROUNDS then -- Если GAME_ROUND равно MAX_ROUNDS, переменная return_time получит нулевое значение.
            
			Timers:CreateTimer(40, function()
				GameRules:SetGameWinner( DOTA_TEAM_GOODGUYS )
				return nil
				end)
			return_neutral_time = nil
			return_time = nil 
			
          end

		  
		 if GAME_ROUND == 1 then
		  local messageinfo = { message = "Night came, and with it the death", duration = 5}
		  FireGameEvent("show_center_message",messageinfo)
		  name_of_wave_zombies = "mad_sickly_zombies"		  
		  nextTimer = nextTimer+220
		 end 		  
		  
		 if GAME_ROUND == 2 then
		  local messageinfo = { message = "Do not lose hope, dawn soon", duration = 5}
		  FireGameEvent("show_center_message",messageinfo)		 
		  name_of_wave_zombies = "mad_tight_zombies"
		  nextTimer = nextTimer+260
		 end 

		 if GAME_ROUND == 3 then
		  local messageinfo = { message = "They come and come, there is no end", duration = 5}
		  FireGameEvent("show_center_message",messageinfo)			 
		  name_of_wave_zombies = "mad_toothy_zombies"	  
		  nextTimer = nextTimer+220
		  end 

		 if GAME_ROUND == 4 then
		  local messageinfo = { message = "It was the cry of a rooster or roar aught? ", duration = 5}
		  FireGameEvent("show_center_message",messageinfo)		  
		  name_of_wave_zombies = "mad_fat_zombies"		  
		  nextTimer = nextTimer+260
		  end 

		 if GAME_ROUND == 5 then
		  local messageinfo = { message = "This is the last night, but not the last battle", duration = 5}
		  FireGameEvent("show_center_message", messageinfo)
		  name_of_wave_zombies = "mad_huge_zombies"		  
		  nextTimer = nextTimer+220
		  end 

		 if GAME_ROUND == 6 then
		  local messageinfo = { message = "My hands in the blood, it is time to end", duration = 5}
		  FireGameEvent("show_center_message", messageinfo)		  
		  name_of_wave_zombies = "mad_omg_zombies"
		  nextTimer = nextTimer+260		  
		  end 
		  
		 for i=1, ROUND_UNITS do --Произведет нижние действия столько раз, сколько указано в ROUND_UNITS. То есть в нашем случае создаст 2 юнита.
		    
			--юниты 1го пути
			local unit_1 = CreateUnitByName( name_of_wave_zombies, point + RandomVector( RandomFloat( 0, 50 ) ), true, nil, nil, DOTA_TEAM_NEUTRALS ) --// Создаем юнита 'example_unit_', в конце к названию добавится 1,2,3,4 или 5, в зависимости от раунда, и в итоге получатся наши example_unit_1, example_unit_2 и т.д.. Юнит появится в векторе point + RandomVector( RandomFloat( 0, 200 ) ) - point - наша переменная, а рандомный вектор добавляется для того, чтобы мобы не появлялись в одной точке и не застревали. Мобы будут за силы тьмы.
		    unit_1:SetInitialGoalEntity( waypoint ) --Посылаем мобов на наш way1, координаты которого мы записали в переменную 'waypoint'
		    --юниты 2го пути
			local unit_2 = CreateUnitByName( name_of_wave_zombies, point_2 + RandomVector( RandomFloat( 0, 50 ) ), true, nil, nil, DOTA_TEAM_NEUTRALS ) 
		    unit_2:SetInitialGoalEntity( waypoint_2 ) 
 		    --юниты 3го пути
			local unit_3 = CreateUnitByName( name_of_wave_zombies, point_3 + RandomVector( RandomFloat( 0, 50 ) ), true, nil, nil, DOTA_TEAM_NEUTRALS )
		    unit_3:SetInitialGoalEntity( waypoint_3 ) 
		    --юниты 4го пути
			local unit_4 = CreateUnitByName( name_of_wave_zombies, point_4 + RandomVector( RandomFloat( 0, 50 ) ), true, nil, nil, DOTA_TEAM_NEUTRALS ) 
		    unit_4:SetInitialGoalEntity( waypoint_4 ) 
			
		 end
		  
          return return_time --Возвращаем таймеру время, через которое он должен снова сработать. Когда пройдет последний раунд таймер получит значение 'nil' и выключится.
      end)
	
end


    if MapName == "invasion_in_the_forest" then
	GameRules:SetCustomGameTeamMaxPlayers( DOTA_TEAM_GOODGUYS, 5 )
	GameRules:SetCustomGameTeamMaxPlayers( DOTA_TEAM_BADGUYS, 0 )


	GameRules:SetTimeOfDay( 0.11 )
	GameRules:SetHeroRespawnEnabled( true )
	GameRules:SetUseUniversalShopMode( false )
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
	
	  local return_time = 30


	  
	  local point1 = Entities:FindByName( nil, "spawn1"):GetAbsOrigin()
	  local point3 = Entities:FindByName( nil, "spawn3"):GetAbsOrigin()
	  local point5 = Entities:FindByName( nil, "spawn5"):GetAbsOrigin()
	  local point7 = Entities:FindByName( nil, "spawn7"):GetAbsOrigin()
	  local point9 = Entities:FindByName( nil, "spawn9"):GetAbsOrigin()
	  local point11 = Entities:FindByName( nil, "spawn11"):GetAbsOrigin()
	  local point13 = Entities:FindByName( nil, "spawn13"):GetAbsOrigin()
	  local point15 = Entities:FindByName( nil, "spawn15"):GetAbsOrigin()
	  local point17 = Entities:FindByName( nil, "spawn17"):GetAbsOrigin()
	  local point19 = Entities:FindByName( nil, "spawn19"):GetAbsOrigin()
	  
	  
	  local point2 = Entities:FindByName( nil, "spawn2"):GetAbsOrigin()
	  local point4 = Entities:FindByName( nil, "spawn4"):GetAbsOrigin()	  
	  local point6 = Entities:FindByName( nil, "spawn6"):GetAbsOrigin()
	  local point8 = Entities:FindByName( nil, "spawn8"):GetAbsOrigin()
	  local point10 = Entities:FindByName( nil, "spawn10"):GetAbsOrigin()
	  local point12 = Entities:FindByName( nil, "spawn12"):GetAbsOrigin()
	  local point14 = Entities:FindByName( nil, "spawn14"):GetAbsOrigin()
	  local point16 = Entities:FindByName( nil, "spawn16"):GetAbsOrigin()
	  local point18 = Entities:FindByName( nil, "spawn18"):GetAbsOrigin()	  
	  
      local way1 = Entities:FindByName( nil, "way1")
      local way2 = Entities:FindByName( nil, "way2")  
      local way3 = Entities:FindByName( nil, "way3")  
      local way4 = Entities:FindByName( nil, "way4")  
      local way5 = Entities:FindByName( nil, "way5")  
      local way6 = Entities:FindByName( nil, "way6")  
      local way7 = Entities:FindByName( nil, "way7")  
      local way8 = Entities:FindByName( nil, "way8")  
      local way9 = Entities:FindByName( nil, "way9")  
      local way10 = Entities:FindByName( nil, "way10")  
      local way11 = Entities:FindByName( nil, "way11")  
      local way12 = Entities:FindByName( nil, "way12")  
      local way13 = Entities:FindByName( nil, "way13")  
      local way14 = Entities:FindByName( nil, "way14")  
      local way15 = Entities:FindByName( nil, "way15")  
      local way16 = Entities:FindByName( nil, "way16")  
      local way17 = Entities:FindByName( nil, "way17")  
      local way18 = Entities:FindByName( nil, "way18")  
      local way19 = Entities:FindByName( nil, "way19")  	  
		  
	  local startPoint1 = Entities:FindByName( nil, "spawn_start1"):GetAbsOrigin()
	  local startPoint2 = Entities:FindByName( nil, "spawn_start2"):GetAbsOrigin()
	  local startPoint3 = Entities:FindByName( nil, "spawn_start3"):GetAbsOrigin()
	  local startPoint4 = Entities:FindByName( nil, "spawn_start4"):GetAbsOrigin()
	  local startPoint5 = Entities:FindByName( nil, "spawn_start5"):GetAbsOrigin()
	  local startPoint6 = Entities:FindByName( nil, "spawn_start6"):GetAbsOrigin()
	  local startPoint7 = Entities:FindByName( nil, "spawn_start7"):GetAbsOrigin()
	  local startPoint8 = Entities:FindByName( nil, "spawn_start8"):GetAbsOrigin()
	  
			local Start_unit1 = CreateUnitByName("fat_start_zombies", startPoint1, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
			local Start_unit2 = CreateUnitByName("fat_start_zombies", startPoint2, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
			local Start_unit3 = CreateUnitByName("fat_start_zombies", startPoint3, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
			local Start_unit4 = CreateUnitByName("fat_start_zombies", startPoint4, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
			local Start_unit5 = CreateUnitByName("fat_start_zombies", startPoint5, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
			local Start_unit6 = CreateUnitByName("fat_start_zombies", startPoint6, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
			local Start_unit7 = CreateUnitByName("fat_start_zombies", startPoint7, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
			local Start_unit8 = CreateUnitByName("fat_start_zombies", startPoint8, true, nil, nil, DOTA_TEAM_NEUTRALS ) 			
	
	      Timers:CreateTimer(80, function()		  
		  GAME_ROUND = GAME_ROUND + 1 --Значение GAME_ROUND увеличивается на 1.
		  
		  if GAME_ROUND == 1 then 
		  local messageinfo = { message = "Oh, where am I? This is a dream?", duration = 5}
		  FireGameEvent("show_center_message", messageinfo)
		  end

		  
		  if GAME_ROUND == MAX_ROUNDS_2 then -- Если GAME_ROUND равно MAX_ROUNDS, переменная return_time получит нулевое значение.          
			Timers:CreateTimer(60, function()
				GameRules:SetGameWinner( DOTA_TEAM_GOODGUYS )
				return nil
				end)
			return_time = nil 
          end
		  
		  if GAME_ROUND == 11 then
		  	local messageinfo = { message = "Oh, God, no, what's he doing here?", duration = 5}
		    FireGameEvent("show_center_message", messageinfo)
		    local unit_0_1 = CreateUnitByName("Big_Skeleton", point1, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
		    unit_0_1:SetInitialGoalEntity( way1 )
		  end
		  
		  if GAME_ROUND == 20 then
		  	local messageinfo = { message = "She comes to me at night...", duration = 5}
		    FireGameEvent("show_center_message", messageinfo)	  
			local unit_0_2 = CreateUnitByName("Big_Ghost", point10, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
		    unit_0_2:SetInitialGoalEntity( way10 )			
		  end

		  if GAME_ROUND == 28 then
		  	local messageinfo = { message = "My grandfather sometimes indulged me", duration = 5}
		    FireGameEvent("show_center_message", messageinfo)	  
			local unit_0_3 = CreateUnitByName("Big_Troll", point5, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
		    unit_0_3:SetInitialGoalEntity( way5 )
		  end
		  

		  
		  
		  
		  
		  if GAME_ROUND <= 13 then	  		

		   for i=1, 2 do
				local unit1 = CreateUnitByName("fast_zombies", point1, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
				unit1:SetInitialGoalEntity( way1 )
				local unit5 = CreateUnitByName("fast_zombies", point5, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
				unit5:SetInitialGoalEntity( way5 )
				local unit9 = CreateUnitByName("fast_zombies", point9, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
				unit9:SetInitialGoalEntity( way9 )
				local unit13 = CreateUnitByName("fast_zombies", point13, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
				unit13:SetInitialGoalEntity( way13 )
				local unit17 = CreateUnitByName("fast_zombies", point17, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
				unit17:SetInitialGoalEntity( way17 )
				
				local unit4 = CreateUnitByName("fat_zombies", point4, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
				unit4:SetInitialGoalEntity( way4 )
				local unit8 = CreateUnitByName("fat_zombies", point8, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
				unit8:SetInitialGoalEntity( way8 )
				local unit12 = CreateUnitByName("fat_zombies", point12, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
				unit12:SetInitialGoalEntity( way12 )
				local unit16 = CreateUnitByName("fat_zombies", point16, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
				unit16:SetInitialGoalEntity( way16 )				

			local unit3 = CreateUnitByName("fast_zombies", point3, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
		    unit3:SetInitialGoalEntity( way3 )
			local unit7 = CreateUnitByName("fast_zombies", point7, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
		    unit7:SetInitialGoalEntity( way7 )
			local unit11 = CreateUnitByName("fast_zombies", point11, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
		    unit11:SetInitialGoalEntity( way11 )
			local unit15 = CreateUnitByName("fast_zombies", point15, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
		    unit15:SetInitialGoalEntity( way15 )
			local unit19 = CreateUnitByName("fast_zombies", point19, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
		    unit19:SetInitialGoalEntity( way19 )
			
			local unit2 = CreateUnitByName("fat_zombies", point2, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
		    unit2:SetInitialGoalEntity( way2 )
			local unit6 = CreateUnitByName("fat_zombies", point6, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
		    unit6:SetInitialGoalEntity( way6 )	
			local unit10 = CreateUnitByName("fat_zombies", point10, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
		    unit10:SetInitialGoalEntity( way10 )	
			local unit14 = CreateUnitByName("fat_zombies", point14, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
		    unit14:SetInitialGoalEntity( way14 )	
			local unit18 = CreateUnitByName("fat_zombies", point18, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
		    unit18:SetInitialGoalEntity( way18 )

			end			
		  end 
		  		  
		  if GAME_ROUND > 13 and GAME_ROUND <= 22 then	  		
			
		   for i=1, 2 do
				local unit1 = CreateUnitByName("kid_zombies", point1 + RandomVector( RandomFloat( 0, 50 )), true, nil, nil, DOTA_TEAM_NEUTRALS ) 
				unit1:SetInitialGoalEntity( way1 )
				local unit5 = CreateUnitByName("kid_zombies", point5 + RandomVector( RandomFloat( 0, 50 )), true, nil, nil, DOTA_TEAM_NEUTRALS ) 
				unit5:SetInitialGoalEntity( way5 )
				local unit9 = CreateUnitByName("kid_zombies", point9 + RandomVector( RandomFloat( 0, 50 )), true, nil, nil, DOTA_TEAM_NEUTRALS ) 
				unit9:SetInitialGoalEntity( way9 )
				local unit13 = CreateUnitByName("kid_zombies", point13 + RandomVector( RandomFloat( 0, 50 )), true, nil, nil, DOTA_TEAM_NEUTRALS ) 
				unit13:SetInitialGoalEntity( way13 )
				local unit17 = CreateUnitByName("kid_zombies", point17 + RandomVector( RandomFloat( 0, 50 )), true, nil, nil, DOTA_TEAM_NEUTRALS ) 
				unit17:SetInitialGoalEntity( way17 )
				
				local unit4 = CreateUnitByName("hugo_zombies", point4 + RandomVector( RandomFloat( 0, 50 )), true, nil, nil, DOTA_TEAM_NEUTRALS ) 
				unit4:SetInitialGoalEntity( way4 )	
				local unit8 = CreateUnitByName("hugo_zombies", point8 + RandomVector( RandomFloat( 0, 50 )), true, nil, nil, DOTA_TEAM_NEUTRALS ) 
				unit8:SetInitialGoalEntity( way8 )
				local unit12 = CreateUnitByName("hugo_zombies", point12 + RandomVector( RandomFloat( 0, 50 )), true, nil, nil, DOTA_TEAM_NEUTRALS ) 
				unit12:SetInitialGoalEntity( way12 )
				local unit16 = CreateUnitByName("hugo_zombies", point16 + RandomVector( RandomFloat( 0, 50 )), true, nil, nil, DOTA_TEAM_NEUTRALS ) 
				unit16:SetInitialGoalEntity( way16 )				
			end
			local unit3 = CreateUnitByName("kid_zombies", point3, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
		    unit3:SetInitialGoalEntity( way3 )
			local unit7 = CreateUnitByName("kid_zombies", point7, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
		    unit7:SetInitialGoalEntity( way7 )
			local unit11 = CreateUnitByName("kid_zombies", point11, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
		    unit11:SetInitialGoalEntity( way11 )
			local unit15 = CreateUnitByName("kid_zombies", point15, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
		    unit15:SetInitialGoalEntity( way15 )
			local unit19 = CreateUnitByName("kid_zombies", point19, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
		    unit19:SetInitialGoalEntity( way19 )	
			
			local unit2 = CreateUnitByName("hugo_zombies", point2, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
		    unit2:SetInitialGoalEntity( way2 )
			local unit6 = CreateUnitByName("hugo_zombies", point6, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
		    unit6:SetInitialGoalEntity( way6 )	
			local unit10 = CreateUnitByName("hugo_zombies", point10, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
		    unit10:SetInitialGoalEntity( way10 )	
			local unit14 = CreateUnitByName("hugo_zombies", point14, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
		    unit14:SetInitialGoalEntity( way14 )	
			local unit18 = CreateUnitByName("hugo_zombies", point18, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
		    unit18:SetInitialGoalEntity( way18 )								

			
			return_time = 30
			end

		  if GAME_ROUND > 22 then	  		
			
		   for i=1, 2 do
				local unit1 = CreateUnitByName("baby_zombies", point1 + RandomVector( RandomFloat( 0, 50 )), true, nil, nil, DOTA_TEAM_NEUTRALS ) 
				unit1:SetInitialGoalEntity( way1 )
				local unit5 = CreateUnitByName("baby_zombies", point5 + RandomVector( RandomFloat( 0, 50 )), true, nil, nil, DOTA_TEAM_NEUTRALS ) 
				unit5:SetInitialGoalEntity( way5 )
				local unit9 = CreateUnitByName("baby_zombies", point9 + RandomVector( RandomFloat( 0, 50 )), true, nil, nil, DOTA_TEAM_NEUTRALS ) 
				unit9:SetInitialGoalEntity( way9 )
				local unit13 = CreateUnitByName("baby_zombies", point13 + RandomVector( RandomFloat( 0, 50 )), true, nil, nil, DOTA_TEAM_NEUTRALS ) 
				unit13:SetInitialGoalEntity( way13 )
				local unit17 = CreateUnitByName("baby_zombies", point17 + RandomVector( RandomFloat( 0, 50 )), true, nil, nil, DOTA_TEAM_NEUTRALS ) 
				unit17:SetInitialGoalEntity( way17 )
				
				local unit4 = CreateUnitByName("parent_zombies", point4 + RandomVector( RandomFloat( 0, 50 )), true, nil, nil, DOTA_TEAM_NEUTRALS ) 
				unit4:SetInitialGoalEntity( way4 )	
				local unit8 = CreateUnitByName("parent_zombies", point8 + RandomVector( RandomFloat( 0, 50 )), true, nil, nil, DOTA_TEAM_NEUTRALS ) 
				unit8:SetInitialGoalEntity( way8 )
				local unit12 = CreateUnitByName("parent_zombies", point12 + RandomVector( RandomFloat( 0, 50 )), true, nil, nil, DOTA_TEAM_NEUTRALS ) 
				unit12:SetInitialGoalEntity( way12 )
				local unit16 = CreateUnitByName("parent_zombies", point16 + RandomVector( RandomFloat( 0, 50 )), true, nil, nil, DOTA_TEAM_NEUTRALS ) 
				unit16:SetInitialGoalEntity( way16 )				
			end
				
			local unit3 = CreateUnitByName("baby_zombies", point3, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
		    unit3:SetInitialGoalEntity( way3 )
			local unit7 = CreateUnitByName("baby_zombies", point7, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
		    unit7:SetInitialGoalEntity( way7 )
			local unit11 = CreateUnitByName("baby_zombies", point11, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
		    unit11:SetInitialGoalEntity( way11 )
			local unit15 = CreateUnitByName("baby_zombies", point15, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
		    unit15:SetInitialGoalEntity( way15 )
			local unit19 = CreateUnitByName("baby_zombies", point19, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
		    unit19:SetInitialGoalEntity( way19 )	
			
			local unit2 = CreateUnitByName("parent_zombies", point2, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
		    unit2:SetInitialGoalEntity( way2 )
			local unit6 = CreateUnitByName("parent_zombies", point6, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
		    unit6:SetInitialGoalEntity( way6 )	
			local unit10 = CreateUnitByName("parent_zombies", point10, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
		    unit10:SetInitialGoalEntity( way10 )	
			local unit14 = CreateUnitByName("parent_zombies", point14, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
		    unit14:SetInitialGoalEntity( way14 )	
			local unit18 = CreateUnitByName("parent_zombies", point18, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
		    unit18:SetInitialGoalEntity( way18 )				

			
			return_time = 30
			end	
			
		 return return_time		  
		  end)
	
	
	
	
end

    if MapName == "pvp_invasion_forest" then


	GameRules:SetTimeOfDay( 0.11 )
	GameRules:SetHeroRespawnEnabled( true )
	GameRules:SetUseUniversalShopMode( false )
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
	
	  local return_time = 40


	  
	  local point1 = Entities:FindByName( nil, "spawn1"):GetAbsOrigin()
	  local point3 = Entities:FindByName( nil, "spawn3"):GetAbsOrigin()
	  local point5 = Entities:FindByName( nil, "spawn5"):GetAbsOrigin()
	  local point7 = Entities:FindByName( nil, "spawn7"):GetAbsOrigin()
	  local point9 = Entities:FindByName( nil, "spawn9"):GetAbsOrigin()
	  local point11 = Entities:FindByName( nil, "spawn11"):GetAbsOrigin()
	  local point13 = Entities:FindByName( nil, "spawn13"):GetAbsOrigin()
	  local point15 = Entities:FindByName( nil, "spawn15"):GetAbsOrigin()	  
	  
	  local point2 = Entities:FindByName( nil, "spawn2"):GetAbsOrigin()
	  local point4 = Entities:FindByName( nil, "spawn4"):GetAbsOrigin()	  
	  local point6 = Entities:FindByName( nil, "spawn6"):GetAbsOrigin()
	  local point8 = Entities:FindByName( nil, "spawn8"):GetAbsOrigin()
	  local point10 = Entities:FindByName( nil, "spawn10"):GetAbsOrigin()
	  local point12 = Entities:FindByName( nil, "spawn12"):GetAbsOrigin()
	  local point14 = Entities:FindByName( nil, "spawn14"):GetAbsOrigin()

	  
	  local point17 = Entities:FindByName( nil, "spawn17"):GetAbsOrigin()
	  local point19 = Entities:FindByName( nil, "spawn19"):GetAbsOrigin()
	  local point21 = Entities:FindByName( nil, "spawn21"):GetAbsOrigin()
	  local point23 = Entities:FindByName( nil, "spawn23"):GetAbsOrigin()
	  local point25 = Entities:FindByName( nil, "spawn25"):GetAbsOrigin()
	  local point27 = Entities:FindByName( nil, "spawn27"):GetAbsOrigin()
	  local point29 = Entities:FindByName( nil, "spawn29"):GetAbsOrigin()
  
	  local point16 = Entities:FindByName( nil, "spawn16"):GetAbsOrigin()
	  local point18 = Entities:FindByName( nil, "spawn18"):GetAbsOrigin()	  
	  local point20 = Entities:FindByName( nil, "spawn20"):GetAbsOrigin()
	  local point22 = Entities:FindByName( nil, "spawn22"):GetAbsOrigin()
	  local point24 = Entities:FindByName( nil, "spawn24"):GetAbsOrigin()
	  local point26 = Entities:FindByName( nil, "spawn26"):GetAbsOrigin()
	  local point28 = Entities:FindByName( nil, "spawn28"):GetAbsOrigin()	  
	  local point30 = Entities:FindByName( nil, "spawn30"):GetAbsOrigin()
	  
      local way1 = Entities:FindByName( nil, "way1")
      local way2 = Entities:FindByName( nil, "way2")  
      local way3 = Entities:FindByName( nil, "way3")  
      local way4 = Entities:FindByName( nil, "way4")  
      local way5 = Entities:FindByName( nil, "way5")  
      local way6 = Entities:FindByName( nil, "way6")  
      local way7 = Entities:FindByName( nil, "way7")  
      local way8 = Entities:FindByName( nil, "way8")  
      local way9 = Entities:FindByName( nil, "way9")  
      local way10 = Entities:FindByName( nil, "way10")  
      local way11 = Entities:FindByName( nil, "way11")  
      local way12 = Entities:FindByName( nil, "way12")  
      local way13 = Entities:FindByName( nil, "way13")  
      local way14 = Entities:FindByName( nil, "way14")  
      local way15 = Entities:FindByName( nil, "way15")  
      local way16 = Entities:FindByName( nil, "way16")  
      local way17 = Entities:FindByName( nil, "way17")  
      local way18 = Entities:FindByName( nil, "way18")  
      local way19 = Entities:FindByName( nil, "way19")
      local way20 = Entities:FindByName( nil, "way20")
      local way21 = Entities:FindByName( nil, "way21")  
      local way22 = Entities:FindByName( nil, "way22")  
      local way23 = Entities:FindByName( nil, "way23")  
      local way24 = Entities:FindByName( nil, "way24")  
      local way25 = Entities:FindByName( nil, "way25")  
      local way26 = Entities:FindByName( nil, "way26")  
      local way27 = Entities:FindByName( nil, "way27")  
      local way28 = Entities:FindByName( nil, "way28") 
      local way29 = Entities:FindByName( nil, "way29") 	  
      local way30 = Entities:FindByName( nil, "way30")  
   	  
		  
	  local startPoint1 = Entities:FindByName( nil, "spawn_start1"):GetAbsOrigin()
	  local startPoint2 = Entities:FindByName( nil, "spawn_start2"):GetAbsOrigin()
	  local startPoint3 = Entities:FindByName( nil, "spawn_start3"):GetAbsOrigin()
	  local startPoint4 = Entities:FindByName( nil, "spawn_start4"):GetAbsOrigin()
	  local startPoint5 = Entities:FindByName( nil, "spawn_start5"):GetAbsOrigin()
	  local startPoint6 = Entities:FindByName( nil, "spawn_start6"):GetAbsOrigin()
	  local startPoint7 = Entities:FindByName( nil, "spawn_start7"):GetAbsOrigin()
	  local startPoint8 = Entities:FindByName( nil, "spawn_start8"):GetAbsOrigin()

	  local startPoint9 = Entities:FindByName( nil, "spawn_start9"):GetAbsOrigin()
	  local startPoint10 = Entities:FindByName( nil, "spawn_start10"):GetAbsOrigin()
	  local startPoint11 = Entities:FindByName( nil, "spawn_start11"):GetAbsOrigin()
	  local startPoint12 = Entities:FindByName( nil, "spawn_start12"):GetAbsOrigin()
	  local startPoint13 = Entities:FindByName( nil, "spawn_start13"):GetAbsOrigin()
	  local startPoint14 = Entities:FindByName( nil, "spawn_start14"):GetAbsOrigin()
	  local startPoint15 = Entities:FindByName( nil, "spawn_start15"):GetAbsOrigin()
	  local startPoint16 = Entities:FindByName( nil, "spawn_start16"):GetAbsOrigin()


	  
	local Start_unit1 = CreateUnitByName("fat_start_zombies", startPoint1, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
	local Start_unit2 = CreateUnitByName("fat_start_zombies", startPoint2, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
	local Start_unit3 = CreateUnitByName("fat_start_zombies", startPoint3, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
	local Start_unit4 = CreateUnitByName("fat_start_zombies", startPoint4, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
	local Start_unit5 = CreateUnitByName("fat_start_zombies", startPoint5, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
	local Start_unit6 = CreateUnitByName("fat_start_zombies", startPoint6, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
	local Start_unit7 = CreateUnitByName("fat_start_zombies", startPoint7, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
	local Start_unit8 = CreateUnitByName("fat_start_zombies", startPoint8, true, nil, nil, DOTA_TEAM_NEUTRALS ) 

	local Start_unit9 = CreateUnitByName("fat_start_zombies", startPoint9, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
	local Start_unit10 = CreateUnitByName("fat_start_zombies", startPoint10, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
	local Start_unit11 = CreateUnitByName("fat_start_zombies", startPoint11, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
	local Start_unit12 = CreateUnitByName("fat_start_zombies", startPoint12, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
	local Start_unit13 = CreateUnitByName("fat_start_zombies", startPoint13, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
	local Start_unit14 = CreateUnitByName("fat_start_zombies", startPoint14, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
	local Start_unit15 = CreateUnitByName("fat_start_zombies", startPoint15, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
	local Start_unit16 = CreateUnitByName("fat_start_zombies", startPoint16, true, nil, nil, DOTA_TEAM_NEUTRALS ) 	

	Timers:CreateTimer(50, function()
		  	local messageinfo = { message = "Zombies wake up through 50 seconds", duration = 5}
		    FireGameEvent("show_center_message", messageinfo)							
			return nil
		end)
	
	
	      Timers:CreateTimer(100, function()		  
		  GAME_ROUND = GAME_ROUND + 1 --Значение GAME_ROUND увеличивается на 1.
		  
		  if GAME_ROUND == 1 then 
		  	local messageinfo = { message = "Oh, where am I? This is a dream?", duration = 5}
		    FireGameEvent("show_center_message", messageinfo)
		  end

		 		  
		  		  
		  
		  if GAME_ROUND <= 9 then	  		

		for i=1, 2 do
				local unit1 = CreateUnitByName("fast_zombies_", point1 + RandomVector( RandomFloat( 0, 50 )), true, nil, nil, DOTA_TEAM_NEUTRALS ) 
				unit1:SetInitialGoalEntity( way1 )
				local unit5 = CreateUnitByName("fast_zombies_", point5 + RandomVector( RandomFloat( 0, 50 )), true, nil, nil, DOTA_TEAM_NEUTRALS ) 
				unit5:SetInitialGoalEntity( way5 )
				local unit9 = CreateUnitByName("fast_zombies_", point9 + RandomVector( RandomFloat( 0, 50 )), true, nil, nil, DOTA_TEAM_NEUTRALS ) 
				unit9:SetInitialGoalEntity( way9 )
				local unit13 = CreateUnitByName("fast_zombies_", point13 + RandomVector( RandomFloat( 0, 50 )), true, nil, nil, DOTA_TEAM_NEUTRALS ) 
				unit13:SetInitialGoalEntity( way13 )
				local unit17 = CreateUnitByName("fast_zombies_", point17 + RandomVector( RandomFloat( 0, 50 )), true, nil, nil, DOTA_TEAM_NEUTRALS ) 
				unit17:SetInitialGoalEntity( way17 )
				local unit21 = CreateUnitByName("fast_zombies_", point21 + RandomVector( RandomFloat( 0, 50 )), true, nil, nil, DOTA_TEAM_NEUTRALS ) 
				unit21:SetInitialGoalEntity( way21 )				
				local unit25 = CreateUnitByName("fast_zombies_", point25 + RandomVector( RandomFloat( 0, 50 )), true, nil, nil, DOTA_TEAM_NEUTRALS ) 
				unit25:SetInitialGoalEntity( way25 )
				local unit29 = CreateUnitByName("fast_zombies_", point29 + RandomVector( RandomFloat( 0, 50 )), true, nil, nil, DOTA_TEAM_NEUTRALS ) 
				unit29:SetInitialGoalEntity( way29 )
				
				local unit4 = CreateUnitByName("fat_zombies_", point4 + RandomVector( RandomFloat( 0, 50 )), true, nil, nil, DOTA_TEAM_NEUTRALS ) 
				unit4:SetInitialGoalEntity( way4 )
				local unit8 = CreateUnitByName("fat_zombies_", point8 + RandomVector( RandomFloat( 0, 50 )), true, nil, nil, DOTA_TEAM_NEUTRALS ) 
				unit8:SetInitialGoalEntity( way8 )
				local unit12 = CreateUnitByName("fat_zombies_", point12 + RandomVector( RandomFloat( 0, 50 )), true, nil, nil, DOTA_TEAM_NEUTRALS ) 
				unit12:SetInitialGoalEntity( way12 )
				local unit16 = CreateUnitByName("fat_zombies_", point16 + RandomVector( RandomFloat( 0, 50 )), true, nil, nil, DOTA_TEAM_NEUTRALS ) 
				unit16:SetInitialGoalEntity( way16 )
				local unit20 = CreateUnitByName("fat_zombies_", point20 + RandomVector( RandomFloat( 0, 50 )), true, nil, nil, DOTA_TEAM_NEUTRALS ) 
				unit20:SetInitialGoalEntity( way20 )
				local unit24 = CreateUnitByName("fat_zombies_", point24 + RandomVector( RandomFloat( 0, 50 )), true, nil, nil, DOTA_TEAM_NEUTRALS ) 
				unit24:SetInitialGoalEntity( way24)
				local unit28 = CreateUnitByName("fat_zombies_", point28 + RandomVector( RandomFloat( 0, 50 )), true, nil, nil, DOTA_TEAM_NEUTRALS ) 
				unit28:SetInitialGoalEntity( way28 )				
			end	

			local unit3 = CreateUnitByName("fast_zombies_", point3, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
		    unit3:SetInitialGoalEntity( way3 )
			local unit7 = CreateUnitByName("fast_zombies_", point7, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
		    unit7:SetInitialGoalEntity( way7 )
			local unit11 = CreateUnitByName("fast_zombies_", point11, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
		    unit11:SetInitialGoalEntity( way11 )
--			local unit15 = CreateUnitByName("fast_zombies_", point15, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
--		    unit15:SetInitialGoalEntity( way15 )
			local unit19 = CreateUnitByName("fast_zombies_", point19, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
		    unit19:SetInitialGoalEntity( way19 )
			local unit23 = CreateUnitByName("fast_zombies_", point23, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
		    unit23:SetInitialGoalEntity( way23 )
			local unit27 = CreateUnitByName("fast_zombies_", point27, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
		    unit27:SetInitialGoalEntity( way27 )			
			
			local unit2 = CreateUnitByName("fat_zombies_", point2, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
		    unit2:SetInitialGoalEntity( way2 )
			local unit6 = CreateUnitByName("fat_zombies_", point6, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
		    unit6:SetInitialGoalEntity( way6 )
			local unit10 = CreateUnitByName("fat_zombies_", point10, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
		    unit10:SetInitialGoalEntity( way10 )	
			local unit14 = CreateUnitByName("fat_zombies_", point14, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
		    unit14:SetInitialGoalEntity( way14 )
			local unit18 = CreateUnitByName("fat_zombies_", point18, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
		    unit18:SetInitialGoalEntity( way18 )
			local unit22 = CreateUnitByName("fat_zombies_", point22, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
		    unit22:SetInitialGoalEntity( way22 )
			local unit26 = CreateUnitByName("fat_zombies_", point26, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
		    unit26:SetInitialGoalEntity( way26 )
--			local unit30 = CreateUnitByName("fat_zombies_", point30, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
--		    unit30:SetInitialGoalEntity( way30 )			
			
			return_time = 40			
		  end 
		  		  
		  if GAME_ROUND > 9 and GAME_ROUND <= 18 then	  		
			
			for i=1, 2 do
				local unit1 = CreateUnitByName("kid_zombies_", point1 + RandomVector( RandomFloat( 0, 50 )), true, nil, nil, DOTA_TEAM_NEUTRALS ) 
				unit1:SetInitialGoalEntity( way1 )
				local unit5 = CreateUnitByName("kid_zombies_", point5 + RandomVector( RandomFloat( 0, 50 )), true, nil, nil, DOTA_TEAM_NEUTRALS ) 
				unit5:SetInitialGoalEntity( way5 )
				local unit9 = CreateUnitByName("kid_zombies_", point9 + RandomVector( RandomFloat( 0, 50 )), true, nil, nil, DOTA_TEAM_NEUTRALS ) 
				unit9:SetInitialGoalEntity( way9 )
				local unit13 = CreateUnitByName("kid_zombies_", point13 + RandomVector( RandomFloat( 0, 50 )), true, nil, nil, DOTA_TEAM_NEUTRALS ) 
				unit13:SetInitialGoalEntity( way13 )
				local unit17 = CreateUnitByName("kid_zombies_", point17 + RandomVector( RandomFloat( 0, 50 )), true, nil, nil, DOTA_TEAM_NEUTRALS ) 
				unit17:SetInitialGoalEntity( way17 )
				local unit21 = CreateUnitByName("kid_zombies_", point21 + RandomVector( RandomFloat( 0, 50 )), true, nil, nil, DOTA_TEAM_NEUTRALS ) 
				unit21:SetInitialGoalEntity( way21 )				
				local unit25 = CreateUnitByName("kid_zombies_", point25 + RandomVector( RandomFloat( 0, 50 )), true, nil, nil, DOTA_TEAM_NEUTRALS ) 
				unit25:SetInitialGoalEntity( way25 )
				local unit29 = CreateUnitByName("kid_zombies_", point29 + RandomVector( RandomFloat( 0, 50 )), true, nil, nil, DOTA_TEAM_NEUTRALS ) 
				unit29:SetInitialGoalEntity( way29 )
				
				local unit4 = CreateUnitByName("hugo_zombies_", point4 + RandomVector( RandomFloat( 0, 50 )), true, nil, nil, DOTA_TEAM_NEUTRALS ) 
				unit4:SetInitialGoalEntity( way4 )
				local unit8 = CreateUnitByName("hugo_zombies_", point8 + RandomVector( RandomFloat( 0, 50 )), true, nil, nil, DOTA_TEAM_NEUTRALS ) 
				unit8:SetInitialGoalEntity( way8 )
				local unit12 = CreateUnitByName("hugo_zombies_", point12 + RandomVector( RandomFloat( 0, 50 )), true, nil, nil, DOTA_TEAM_NEUTRALS ) 
				unit12:SetInitialGoalEntity( way12 )
				local unit16 = CreateUnitByName("hugo_zombies_", point16 + RandomVector( RandomFloat( 0, 50 )), true, nil, nil, DOTA_TEAM_NEUTRALS ) 
				unit16:SetInitialGoalEntity( way16 )
				local unit20 = CreateUnitByName("hugo_zombies_", point20 + RandomVector( RandomFloat( 0, 50 )), true, nil, nil, DOTA_TEAM_NEUTRALS ) 
				unit20:SetInitialGoalEntity( way20 )
				local unit24 = CreateUnitByName("hugo_zombies_", point24 + RandomVector( RandomFloat( 0, 50 )), true, nil, nil, DOTA_TEAM_NEUTRALS ) 
				unit24:SetInitialGoalEntity( way24)
				local unit28 = CreateUnitByName("hugo_zombies_", point28 + RandomVector( RandomFloat( 0, 50 )), true, nil, nil, DOTA_TEAM_NEUTRALS ) 
				unit28:SetInitialGoalEntity( way28 )				
			end	
			
			local unit3 = CreateUnitByName("kid_zombies_", point3, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
		    unit3:SetInitialGoalEntity( way3 )
			local unit7 = CreateUnitByName("kid_zombies_", point7, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
		    unit7:SetInitialGoalEntity( way7 )
			local unit11 = CreateUnitByName("kid_zombies_", point11, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
		    unit11:SetInitialGoalEntity( way11 )
--			local unit15 = CreateUnitByName("kid_zombies_", point15, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
--		    unit15:SetInitialGoalEntity( way15 )
			local unit19 = CreateUnitByName("kid_zombies_", point19, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
		    unit19:SetInitialGoalEntity( way19 )
			local unit23 = CreateUnitByName("kid_zombies_", point23, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
		    unit23:SetInitialGoalEntity( way23 )
			local unit27 = CreateUnitByName("kid_zombies_", point27, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
		    unit27:SetInitialGoalEntity( way27 )			

			local unit2 = CreateUnitByName("hugo_zombies_", point2, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
		    unit2:SetInitialGoalEntity( way2 )
			local unit6 = CreateUnitByName("hugo_zombies_", point6, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
		    unit6:SetInitialGoalEntity( way6 )
			local unit10 = CreateUnitByName("hugo_zombies_", point10, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
		    unit10:SetInitialGoalEntity( way10 )	
			local unit14 = CreateUnitByName("hugo_zombies_", point14, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
		    unit14:SetInitialGoalEntity( way14 )
			local unit18 = CreateUnitByName("hugo_zombies_", point18, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
		    unit18:SetInitialGoalEntity( way18 )
			local unit22 = CreateUnitByName("hugo_zombies_", point22, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
		    unit22:SetInitialGoalEntity( way22 )
			local unit26 = CreateUnitByName("hugo_zombies_", point26, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
		    unit26:SetInitialGoalEntity( way26 )
--			local unit30 = CreateUnitByName("hugo_zombies_", point30, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
--		    unit30:SetInitialGoalEntity( way30 )			
			
			return_time = 60
			end

		  if GAME_ROUND > 18 then	  		
			
		   for i=1, 2 do
				local unit1 = CreateUnitByName("baby_zombies_", point1 + RandomVector( RandomFloat( 0, 50 )), true, nil, nil, DOTA_TEAM_NEUTRALS ) 
				unit1:SetInitialGoalEntity( way1 )
				local unit5 = CreateUnitByName("baby_zombies_", point5 + RandomVector( RandomFloat( 0, 50 )), true, nil, nil, DOTA_TEAM_NEUTRALS ) 
				unit5:SetInitialGoalEntity( way5 )
				local unit9 = CreateUnitByName("baby_zombies_", point9 + RandomVector( RandomFloat( 0, 50 )), true, nil, nil, DOTA_TEAM_NEUTRALS ) 
				unit9:SetInitialGoalEntity( way9 )
				local unit13 = CreateUnitByName("baby_zombies_", point13 + RandomVector( RandomFloat( 0, 50 )), true, nil, nil, DOTA_TEAM_NEUTRALS ) 
				unit13:SetInitialGoalEntity( way13 )
				local unit17 = CreateUnitByName("baby_zombies_", point17 + RandomVector( RandomFloat( 0, 50 )), true, nil, nil, DOTA_TEAM_NEUTRALS ) 
				unit17:SetInitialGoalEntity( way17 )
				local unit21 = CreateUnitByName("baby_zombies_", point21 + RandomVector( RandomFloat( 0, 50 )), true, nil, nil, DOTA_TEAM_NEUTRALS ) 
				unit21:SetInitialGoalEntity( way21 )				
				local unit25 = CreateUnitByName("baby_zombies_", point25 + RandomVector( RandomFloat( 0, 50 )), true, nil, nil, DOTA_TEAM_NEUTRALS ) 
				unit25:SetInitialGoalEntity( way25 )
				local unit29 = CreateUnitByName("baby_zombies_", point29 + RandomVector( RandomFloat( 0, 50 )), true, nil, nil, DOTA_TEAM_NEUTRALS ) 
				unit29:SetInitialGoalEntity( way29 )
				
				local unit4 = CreateUnitByName("parent_zombies_", point4 + RandomVector( RandomFloat( 0, 50 )), true, nil, nil, DOTA_TEAM_NEUTRALS ) 
				unit4:SetInitialGoalEntity( way4 )
				local unit8 = CreateUnitByName("parent_zombies_", point8 + RandomVector( RandomFloat( 0, 50 )), true, nil, nil, DOTA_TEAM_NEUTRALS ) 
				unit8:SetInitialGoalEntity( way8 )
				local unit12 = CreateUnitByName("parent_zombies_", point12 + RandomVector( RandomFloat( 0, 50 )), true, nil, nil, DOTA_TEAM_NEUTRALS ) 
				unit12:SetInitialGoalEntity( way12 )
				local unit16 = CreateUnitByName("parent_zombies_", point16 + RandomVector( RandomFloat( 0, 50 )), true, nil, nil, DOTA_TEAM_NEUTRALS ) 
				unit16:SetInitialGoalEntity( way16 )
				local unit20 = CreateUnitByName("parent_zombies_", point20 + RandomVector( RandomFloat( 0, 50 )), true, nil, nil, DOTA_TEAM_NEUTRALS ) 
				unit20:SetInitialGoalEntity( way20 )
				local unit24 = CreateUnitByName("parent_zombies_", point24 + RandomVector( RandomFloat( 0, 50 )), true, nil, nil, DOTA_TEAM_NEUTRALS ) 
				unit24:SetInitialGoalEntity( way24)
				local unit28 = CreateUnitByName("parent_zombies_", point28 + RandomVector( RandomFloat( 0, 50 )), true, nil, nil, DOTA_TEAM_NEUTRALS ) 
				unit28:SetInitialGoalEntity( way28 )				
			end	
			
			local unit3 = CreateUnitByName("baby_zombies_", point3, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
		    unit3:SetInitialGoalEntity( way3 )
			local unit7 = CreateUnitByName("baby_zombies_", point7, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
		    unit7:SetInitialGoalEntity( way7 )
			local unit11 = CreateUnitByName("baby_zombies_", point11, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
		    unit11:SetInitialGoalEntity( way11 )
--			local unit15 = CreateUnitByName("baby_zombies_", point15, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
--		    unit15:SetInitialGoalEntity( way15 )
			local unit19 = CreateUnitByName("baby_zombies_", point19, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
		    unit19:SetInitialGoalEntity( way19 )
			local unit23 = CreateUnitByName("baby_zombies_", point23, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
		    unit23:SetInitialGoalEntity( way23 )			
			local unit27 = CreateUnitByName("baby_zombies_", point27, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
		    unit27:SetInitialGoalEntity( way27 )
			
			local unit2 = CreateUnitByName("parent_zombies_", point2, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
		    unit2:SetInitialGoalEntity( way2 )
			local unit6 = CreateUnitByName("parent_zombies_", point6, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
		    unit6:SetInitialGoalEntity( way6 )
			local unit10 = CreateUnitByName("parent_zombies_", point10, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
		    unit10:SetInitialGoalEntity( way10 )	
			local unit14 = CreateUnitByName("parent_zombies_", point14, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
		    unit14:SetInitialGoalEntity( way14 )
			local unit18 = CreateUnitByName("parent_zombies_", point18, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
		    unit18:SetInitialGoalEntity( way18 )
			local unit22 = CreateUnitByName("parent_zombies_", point22, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
		    unit22:SetInitialGoalEntity( way22 )			
			local unit26 = CreateUnitByName("parent_zombies_", point26, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
		    unit26:SetInitialGoalEntity( way26 )
--			local unit30 = CreateUnitByName("parent_zombies_", point30, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
--		    unit30:SetInitialGoalEntity( way30 )			
			
			return_time = 60
			end	
			
		 return return_time		  
		  end)
	
	
	
	
end


end