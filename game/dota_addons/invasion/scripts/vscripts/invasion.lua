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


	  local return_neutral_time = 40
			  
	  local cow_point = Entities:FindByName( nil, "spawner_cow"):GetAbsOrigin()
      local cow_way = Entities:FindByName( nil, "cow_point")   
 	  local sheep_point = Entities:FindByName( nil, "spawner_sheep"):GetAbsOrigin()
      local sheep_way = Entities:FindByName( nil, "sheep_point")  
 
 
		 Timers:CreateTimer(10, function()
			  for i=1, 4 do 		  
				local neutral_cow = CreateUnitByName( "cow", cow_point + RandomVector( RandomFloat( 0, 200 ) ), true, nil, nil, DOTA_TEAM_NEUTRALS )
				neutral_cow:SetInitialGoalEntity( cow_way )
				local neutral_sheep = CreateUnitByName( "sheep", sheep_point + RandomVector( RandomFloat( 0, 200 ) ), true, nil, nil, DOTA_TEAM_NEUTRALS )
				neutral_sheep:SetInitialGoalEntity( sheep_way )			  
			  end
			  return return_neutral_time
			end)


	

end


 function InvasionMode:InvasionMapGameRulesStateChange(keys)
  local newState = GameRules:State_Get()
  if newState == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
    InvasionMode:InvasionGameStart()
  end
end


function InvasionMode:InvasionGameStart()

	  local return_time = 30 
	  	--переменные имен зомбаков		
	  local name_of_neutral_zombies = "sickly_zombies"
	  local name_of_wave_zombies = "mad_sickly_zombies"	
	  
	  local point1 = Entities:FindByName( nil, "spawner_neutral_1"):GetAbsOrigin()
      local neutral_waypoint_1 = Entities:FindByName( nil, "way_neutral_1_1")
	  local waypoint1 = Entities:FindByName( nil, "way1") 
    
	  local point2 = Entities:FindByName( nil, "spawner_neutral_2"):GetAbsOrigin()
      local neutral_waypoint_2 = Entities:FindByName( nil, "way_neutral_2_1")
	  local waypoint2 = Entities:FindByName( nil, "way2") 
	  
	  local point3 = Entities:FindByName( nil, "spawner_neutral_3"):GetAbsOrigin()
      local neutral_waypoint_3 = Entities:FindByName( nil, "way_neutral_3_1")
	  local waypoint3 = Entities:FindByName( nil, "way3") 
	  
	  local point4 = Entities:FindByName( nil, "spawner_neutral_4"):GetAbsOrigin()
      local neutral_waypoint_4 = Entities:FindByName( nil, "way_neutral_4_1")
	  local waypoint4 = Entities:FindByName( nil, "way4") 
	  	  
	  local point5 = Entities:FindByName( nil, "spawner_neutral_5"):GetAbsOrigin()
      local neutral_waypoint_5 = Entities:FindByName( nil, "way_neutral_5_1")
	  local waypoint5 = Entities:FindByName( nil, "way5") 
	  
	  local point6 = Entities:FindByName( nil, "spawner_neutral_6"):GetAbsOrigin()
      local neutral_waypoint_6 = Entities:FindByName( nil, "way_neutral_6_1")
	  local waypoint6 = Entities:FindByName( nil, "way6") 
	  
	  local point7 = Entities:FindByName( nil, "spawner_neutral_7"):GetAbsOrigin()
      local neutral_waypoint_7 = Entities:FindByName( nil, "way_neutral_7_1")
	  local waypoint7 = Entities:FindByName( nil, "way7") 
	  
	  local point8 = Entities:FindByName( nil, "spawner_neutral_8"):GetAbsOrigin()
      local neutral_waypoint_8 = Entities:FindByName( nil, "way_neutral_8_1")
	  local waypoint8 = Entities:FindByName( nil, "way8") 	




	Timers:CreateTimer(1, function()		  
		  local minuts = GameRules:GetDOTATime(false, false)
		  if  minuts < nextTimer then		 
				local wait = nextTimer - minuts
				return wait
	      end
		  	  
		 if GAME_ROUND == 1 then
		  local messageinfo = { message = "Night came, and with it the death", duration = 5}
		  FireGameEvent("show_center_message",messageinfo)
		  name_of_wave_zombies = "mad_sickly_zombies"
		  flagOfDay = 0
		  nextTimer = nextTimer+240
		 end 		  

		if GAME_ROUND == 2 then		
			local messageinfo = { message = "The sun, I am glad it!", duration = 5}
			FireGameEvent("show_center_message", messageinfo)
			name_of_neutral_zombies = "tight_zombies"
			flagOfDay = 1
			nextTimer = nextTimer+240
		end

		 
		 if GAME_ROUND == 3 then		  
		  local messageinfo = { message = "They come and come, there is no end", duration = 5}
		  FireGameEvent("show_center_message",messageinfo)
		  name_of_wave_zombies = "mad_fat_zombies"	
		  flagOfDay = 0		  
		  nextTimer = nextTimer+240
		  end 

		if GAME_ROUND == 4 then		
			local messageinfo = { message = "The sun, I am glad it!", duration = 5}
			FireGameEvent("show_center_message", messageinfo)
			name_of_neutral_zombies = "toothy_zombies"
			flagOfDay = 1
			nextTimer = nextTimer+240			
		end		  
		  		  
		  
		 if GAME_ROUND == 5 then
		  local messageinfo = { message = "My hands in the blood, it is time to end", duration = 5}
		  FireGameEvent("show_center_message", messageinfo)		  
		  name_of_wave_zombies = "mad_omg_zombies"
		  flagOfDay = 0	
		  nextTimer = nextTimer+240		  
		  end 

		  
		if GAME_ROUND == 6 then		
			local messageinfo = { message = "The sun, I am glad it!", duration = 5}
			FireGameEvent("show_center_message", messageinfo)
			GameRules:SetGameWinner( DOTA_TEAM_GOODGUYS )
			return_time = nil 
			flagOfDay = 1
			return nil
		end		  
		 		  
		  
--[[		  
		  local messageinfo = { message = "Do not lose hope, dawn soon", duration = 5}
		  FireGameEvent("show_center_message",messageinfo)		 
		  name_of_wave_zombies = "mad_tight_zombies"

		  local messageinfo = { message = "It was the cry of a rooster or roar aught? ", duration = 5}
		  FireGameEvent("show_center_message",messageinfo)		  			 
		  name_of_wave_zombies = "mad_toothy_zombies"	

		  local messageinfo = { message = "This is the last night, but not the last battle", duration = 5}
		  FireGameEvent("show_center_message", messageinfo)
		  name_of_wave_zombies = "mad_huge_zombies"			  

]]		  

	GAME_ROUND = GAME_ROUND + 1 
				
	return 1
		   	  	  
	
	end)
			
									  
	Timers:CreateTimer(1, function()		  	    
		  
		if  flagOfDay == 1  then		  
			for i=1, 3 do 
				InvasionMode:SpawnMoobByNameForWay(name_of_neutral_zombies,point1,neutral_waypoint_1)
				InvasionMode:SpawnMoobByNameForWay(name_of_neutral_zombies,point2,neutral_waypoint_2)						   
				InvasionMode:SpawnMoobByNameForWay(name_of_neutral_zombies,point3,neutral_waypoint_3)
				InvasionMode:SpawnMoobByNameForWay(name_of_neutral_zombies,point4,neutral_waypoint_4)						   
				InvasionMode:SpawnMoobByNameForWay(name_of_neutral_zombies,point5,neutral_waypoint_5)						   
				InvasionMode:SpawnMoobByNameForWay(name_of_neutral_zombies,point6,neutral_waypoint_6)						   
				InvasionMode:SpawnMoobByNameForWay(name_of_neutral_zombies,point7,neutral_waypoint_7)						   
				InvasionMode:SpawnMoobByNameForWay(name_of_neutral_zombies,point8,neutral_waypoint_8)						   							
			end				
		else		 		  	  					  
			for i=1, ROUND_UNITS do 				
				--юниты 1го пути
				InvasionMode:SpawnMoobByNameForWay(name_of_wave_zombies,point1,waypoint1)
				--юниты 2го пути
				InvasionMode:SpawnMoobByNameForWay(name_of_wave_zombies,point2,waypoint2)
				--юниты 3го пути
				InvasionMode:SpawnMoobByNameForWay(name_of_wave_zombies,point3,waypoint3) 
				--юниты 4го пути
				InvasionMode:SpawnMoobByNameForWay(name_of_wave_zombies,point4,waypoint4)
				--юниты 5го пути
				InvasionMode:SpawnMoobByNameForWay(name_of_wave_zombies,point5,waypoint5)
				--юниты 6го пути
				InvasionMode:SpawnMoobByNameForWay(name_of_wave_zombies,point6,waypoint6)
				--юниты 7го пути
				InvasionMode:SpawnMoobByNameForWay(name_of_wave_zombies,point7,waypoint7)
				--юниты 8го пути
				InvasionMode:SpawnMoobByNameForWay(name_of_wave_zombies,point8,waypoint8)								
			end								
		end
					
		
		return return_time 
	end)

end

function InvasionMode:SpawnMoobByNameForWay(name,point,waypoint)
	local unit1 = CreateUnitByName(name,  point + RandomVector( RandomFloat( 0, 50 ) ), true, nil, nil, DOTA_TEAM_NEUTRALS )
	unit1:SetInitialGoalEntity( waypoint ) 
 end
 
function InvasionMode:OnEntityKilled (event)
   local killedEntity = EntIndexToHScript(event.entindex_killed)
   if killedEntity:GetUnitName() == "cow" then
    if RandomInt(1, 10) > 8  then
     InvasionMode:CreateDrop("item_flask", killedEntity:GetAbsOrigin())
	 end
   end
   if killedEntity:GetUnitName() == "sheep" then
	 if RandomInt(1, 10) > 8  then
     InvasionMode:CreateDrop("item_clarity", killedEntity:GetAbsOrigin())
	 end
   end
 end
 
function InvasionMode:CreateDrop (itemName, pos)
   local newItem = CreateItem(itemName, nil, nil)
   newItem:SetPurchaseTime(0)
   CreateItemOnPositionSync(pos, newItem)
   newItem:LaunchLoot(false, 300, 0.75, pos + RandomVector(RandomFloat(50, 350)))
 end


 