GAME_ROUND = 0
MAX_ROUNDS = 30
roomBG = 1


if InvasionMode == nil then
	InvasionMode = class({})
end

function InvasionMode:InvasionForestPvZMap()


	GameRules:SetCustomGameTeamMaxPlayers( DOTA_TEAM_GOODGUYS, 5 )
	GameRules:SetCustomGameTeamMaxPlayers( DOTA_TEAM_BADGUYS, 3 )


	GameRules:SetTimeOfDay( 0.8 )
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

	ListenToGameEvent('game_rules_state_change', Dynamic_Wrap(InvasionMode, 'OnGameRulesStateChange'), self)	
	
end

function InvasionMode:ForestPVZGameStart()

	
	  local return_time = 30


	  local pointBosses = Entities:FindByName( nil, "spawnBosses"):GetAbsOrigin()
	  
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
		  			
	
	      Timers:CreateTimer(1, function()		  
		  GAME_ROUND = GAME_ROUND + 1 --Значение GAME_ROUND увеличивается на 1.
		  
		  if GAME_ROUND == 1 then 
		  local messageinfo = { message = "Oh, where am I? This is a dream?", duration = 5}
		  FireGameEvent("show_center_message", messageinfo)
		  end

		  
		  if GAME_ROUND == MAX_ROUNDS then -- Если GAME_ROUND равно MAX_ROUNDS, переменная return_time получит нулевое значение.          
			Timers:CreateTimer(60, function()
				GameRules:SetGameWinner( DOTA_TEAM_GOODGUYS )
				return nil
				end)
			return_time = nil 
          end
		  
		  if GAME_ROUND == 11 then
		  	local messageinfo = { message = "Oh, God, no, what's he doing here?", duration = 5}
		    FireGameEvent("show_center_message", messageinfo)
		    local unit_0_1 = CreateUnitByName("Big_Skeleton", pointBosses, true, nil, nil, DOTA_TEAM_BADGUYS ) 		  
		  end
		  
		  if GAME_ROUND == 20 then
		  	local messageinfo = { message = "She comes to me at night...", duration = 5}
		    FireGameEvent("show_center_message", messageinfo)	  
			local unit_0_2 = CreateUnitByName("Big_Ghost", pointBosses, true, nil, nil, DOTA_TEAM_BADGUYS ) 			
		  end

		  if GAME_ROUND == 28 then
		  	local messageinfo = { message = "My grandfather sometimes indulged me", duration = 5}
		    FireGameEvent("show_center_message", messageinfo)	  
			local unit_0_3 = CreateUnitByName("Big_Troll", pointBosses, true, nil, nil, DOTA_TEAM_BADGUYS ) 
		  end
		  

		  
		  
		  
		  
		  if GAME_ROUND <= 13 then	  		

		   for i=1, 2 do
				local unit1 = CreateUnitByName("fast_zombies", point1, true, nil, nil, DOTA_TEAM_BADGUYS ) 
				unit1:SetInitialGoalEntity( way1 )
				local unit5 = CreateUnitByName("fast_zombies", point5, true, nil, nil, DOTA_TEAM_BADGUYS ) 
				unit5:SetInitialGoalEntity( way5 )
				local unit9 = CreateUnitByName("fast_zombies", point9, true, nil, nil, DOTA_TEAM_BADGUYS ) 
				unit9:SetInitialGoalEntity( way9 )
				local unit13 = CreateUnitByName("fast_zombies", point13, true, nil, nil, DOTA_TEAM_BADGUYS ) 
				unit13:SetInitialGoalEntity( way13 )
				local unit17 = CreateUnitByName("fast_zombies", point17, true, nil, nil, DOTA_TEAM_BADGUYS ) 
				unit17:SetInitialGoalEntity( way17 )
				
				local unit4 = CreateUnitByName("fat_zombies", point4, true, nil, nil, DOTA_TEAM_BADGUYS ) 
				unit4:SetInitialGoalEntity( way4 )
				local unit8 = CreateUnitByName("fat_zombies", point8, true, nil, nil, DOTA_TEAM_BADGUYS ) 
				unit8:SetInitialGoalEntity( way8 )
				local unit12 = CreateUnitByName("fat_zombies", point12, true, nil, nil, DOTA_TEAM_BADGUYS ) 
				unit12:SetInitialGoalEntity( way12 )
				local unit16 = CreateUnitByName("fat_zombies", point16, true, nil, nil, DOTA_TEAM_BADGUYS ) 
				unit16:SetInitialGoalEntity( way16 )				
			end
			local unit3 = CreateUnitByName("fast_zombies", point3, true, nil, nil, DOTA_TEAM_BADGUYS ) 
		    unit3:SetInitialGoalEntity( way3 )
			local unit7 = CreateUnitByName("fast_zombies", point7, true, nil, nil, DOTA_TEAM_BADGUYS ) 
		    unit7:SetInitialGoalEntity( way7 )
			local unit11 = CreateUnitByName("fast_zombies", point11, true, nil, nil, DOTA_TEAM_BADGUYS ) 
		    unit11:SetInitialGoalEntity( way11 )
			local unit15 = CreateUnitByName("fast_zombies", point15, true, nil, nil, DOTA_TEAM_BADGUYS ) 
		    unit15:SetInitialGoalEntity( way15 )
			local unit19 = CreateUnitByName("fast_zombies", point19, true, nil, nil, DOTA_TEAM_BADGUYS ) 
		    unit19:SetInitialGoalEntity( way19 )
			
			local unit2 = CreateUnitByName("fat_zombies", point2, true, nil, nil, DOTA_TEAM_BADGUYS ) 
		    unit2:SetInitialGoalEntity( way2 )
			local unit6 = CreateUnitByName("fat_zombies", point6, true, nil, nil, DOTA_TEAM_BADGUYS ) 
		    unit6:SetInitialGoalEntity( way6 )	
			local unit10 = CreateUnitByName("fat_zombies", point10, true, nil, nil, DOTA_TEAM_BADGUYS ) 
		    unit10:SetInitialGoalEntity( way10 )	
			local unit14 = CreateUnitByName("fat_zombies", point14, true, nil, nil, DOTA_TEAM_BADGUYS ) 
		    unit14:SetInitialGoalEntity( way14 )	
			local unit18 = CreateUnitByName("fat_zombies", point18, true, nil, nil, DOTA_TEAM_BADGUYS ) 
		    unit18:SetInitialGoalEntity( way18 )

			
		  end 
		  		  
		  if GAME_ROUND > 13 and GAME_ROUND <= 22 then	  		
			

				local unit1 = CreateUnitByName("kid_zombies", point1 + RandomVector( RandomFloat( 0, 50 )), true, nil, nil, DOTA_TEAM_BADGUYS ) 
				unit1:SetInitialGoalEntity( way1 )
				local unit5 = CreateUnitByName("kid_zombies", point5 + RandomVector( RandomFloat( 0, 50 )), true, nil, nil, DOTA_TEAM_BADGUYS ) 
				unit5:SetInitialGoalEntity( way5 )
				local unit9 = CreateUnitByName("kid_zombies", point9 + RandomVector( RandomFloat( 0, 50 )), true, nil, nil, DOTA_TEAM_BADGUYS ) 
				unit9:SetInitialGoalEntity( way9 )
				local unit13 = CreateUnitByName("kid_zombies", point13 + RandomVector( RandomFloat( 0, 50 )), true, nil, nil, DOTA_TEAM_BADGUYS ) 
				unit13:SetInitialGoalEntity( way13 )
				local unit17 = CreateUnitByName("kid_zombies", point17 + RandomVector( RandomFloat( 0, 50 )), true, nil, nil, DOTA_TEAM_BADGUYS ) 
				unit17:SetInitialGoalEntity( way17 )
				
				local unit4 = CreateUnitByName("hugo_zombies", point4 + RandomVector( RandomFloat( 0, 50 )), true, nil, nil, DOTA_TEAM_BADGUYS ) 
				unit4:SetInitialGoalEntity( way4 )	
				local unit8 = CreateUnitByName("hugo_zombies", point8 + RandomVector( RandomFloat( 0, 50 )), true, nil, nil, DOTA_TEAM_BADGUYS ) 
				unit8:SetInitialGoalEntity( way8 )
				local unit12 = CreateUnitByName("hugo_zombies", point12 + RandomVector( RandomFloat( 0, 50 )), true, nil, nil, DOTA_TEAM_BADGUYS ) 
				unit12:SetInitialGoalEntity( way12 )
				local unit16 = CreateUnitByName("hugo_zombies", point16 + RandomVector( RandomFloat( 0, 50 )), true, nil, nil, DOTA_TEAM_BADGUYS ) 
				unit16:SetInitialGoalEntity( way16 )				

			local unit3 = CreateUnitByName("kid_zombies", point3, true, nil, nil, DOTA_TEAM_BADGUYS ) 
		    unit3:SetInitialGoalEntity( way3 )
			local unit7 = CreateUnitByName("kid_zombies", point7, true, nil, nil, DOTA_TEAM_BADGUYS ) 
		    unit7:SetInitialGoalEntity( way7 )
			local unit11 = CreateUnitByName("kid_zombies", point11, true, nil, nil, DOTA_TEAM_BADGUYS ) 
		    unit11:SetInitialGoalEntity( way11 )
			local unit15 = CreateUnitByName("kid_zombies", point15, true, nil, nil, DOTA_TEAM_BADGUYS ) 
		    unit15:SetInitialGoalEntity( way15 )
			local unit19 = CreateUnitByName("kid_zombies", point19, true, nil, nil, DOTA_TEAM_BADGUYS ) 
		    unit19:SetInitialGoalEntity( way19 )	
			
			local unit2 = CreateUnitByName("hugo_zombies", point2, true, nil, nil, DOTA_TEAM_BADGUYS ) 
		    unit2:SetInitialGoalEntity( way2 )
			local unit6 = CreateUnitByName("hugo_zombies", point6, true, nil, nil, DOTA_TEAM_BADGUYS ) 
		    unit6:SetInitialGoalEntity( way6 )	
			local unit10 = CreateUnitByName("hugo_zombies", point10, true, nil, nil, DOTA_TEAM_BADGUYS ) 
		    unit10:SetInitialGoalEntity( way10 )	
			local unit14 = CreateUnitByName("hugo_zombies", point14, true, nil, nil, DOTA_TEAM_BADGUYS ) 
		    unit14:SetInitialGoalEntity( way14 )	
			local unit18 = CreateUnitByName("hugo_zombies", point18, true, nil, nil, DOTA_TEAM_BADGUYS ) 
		    unit18:SetInitialGoalEntity( way18 )								

			
			return_time = 40
			end

		  if GAME_ROUND > 22 then	  		
			

				local unit1 = CreateUnitByName("baby_zombies", point1 + RandomVector( RandomFloat( 0, 50 )), true, nil, nil, DOTA_TEAM_BADGUYS ) 
				unit1:SetInitialGoalEntity( way1 )
				local unit5 = CreateUnitByName("baby_zombies", point5 + RandomVector( RandomFloat( 0, 50 )), true, nil, nil, DOTA_TEAM_BADGUYS ) 
				unit5:SetInitialGoalEntity( way5 )
				local unit9 = CreateUnitByName("baby_zombies", point9 + RandomVector( RandomFloat( 0, 50 )), true, nil, nil, DOTA_TEAM_BADGUYS ) 
				unit9:SetInitialGoalEntity( way9 )
				local unit13 = CreateUnitByName("baby_zombies", point13 + RandomVector( RandomFloat( 0, 50 )), true, nil, nil, DOTA_TEAM_BADGUYS ) 
				unit13:SetInitialGoalEntity( way13 )
				local unit17 = CreateUnitByName("baby_zombies", point17 + RandomVector( RandomFloat( 0, 50 )), true, nil, nil, DOTA_TEAM_BADGUYS ) 
				unit17:SetInitialGoalEntity( way17 )
				
				local unit4 = CreateUnitByName("parent_zombies", point4 + RandomVector( RandomFloat( 0, 50 )), true, nil, nil, DOTA_TEAM_BADGUYS ) 
				unit4:SetInitialGoalEntity( way4 )	
				local unit8 = CreateUnitByName("parent_zombies", point8 + RandomVector( RandomFloat( 0, 50 )), true, nil, nil, DOTA_TEAM_BADGUYS ) 
				unit8:SetInitialGoalEntity( way8 )
				local unit12 = CreateUnitByName("parent_zombies", point12 + RandomVector( RandomFloat( 0, 50 )), true, nil, nil, DOTA_TEAM_BADGUYS ) 
				unit12:SetInitialGoalEntity( way12 )
				local unit16 = CreateUnitByName("parent_zombies", point16 + RandomVector( RandomFloat( 0, 50 )), true, nil, nil, DOTA_TEAM_BADGUYS ) 
				unit16:SetInitialGoalEntity( way16 )				

				
			local unit3 = CreateUnitByName("baby_zombies", point3, true, nil, nil, DOTA_TEAM_BADGUYS ) 
		    unit3:SetInitialGoalEntity( way3 )
			local unit7 = CreateUnitByName("baby_zombies", point7, true, nil, nil, DOTA_TEAM_BADGUYS ) 
		    unit7:SetInitialGoalEntity( way7 )
			local unit11 = CreateUnitByName("baby_zombies", point11, true, nil, nil, DOTA_TEAM_BADGUYS ) 
		    unit11:SetInitialGoalEntity( way11 )
			local unit15 = CreateUnitByName("baby_zombies", point15, true, nil, nil, DOTA_TEAM_BADGUYS ) 
		    unit15:SetInitialGoalEntity( way15 )
			local unit19 = CreateUnitByName("baby_zombies", point19, true, nil, nil, DOTA_TEAM_BADGUYS ) 
		    unit19:SetInitialGoalEntity( way19 )	
			
			local unit2 = CreateUnitByName("parent_zombies", point2, true, nil, nil, DOTA_TEAM_BADGUYS ) 
		    unit2:SetInitialGoalEntity( way2 )
			local unit6 = CreateUnitByName("parent_zombies", point6, true, nil, nil, DOTA_TEAM_BADGUYS ) 
		    unit6:SetInitialGoalEntity( way6 )	
			local unit10 = CreateUnitByName("parent_zombies", point10, true, nil, nil, DOTA_TEAM_BADGUYS ) 
		    unit10:SetInitialGoalEntity( way10 )	
			local unit14 = CreateUnitByName("parent_zombies", point14, true, nil, nil, DOTA_TEAM_BADGUYS ) 
		    unit14:SetInitialGoalEntity( way14 )	
			local unit18 = CreateUnitByName("parent_zombies", point18, true, nil, nil, DOTA_TEAM_BADGUYS ) 
		    unit18:SetInitialGoalEntity( way18 )				

			
			return_time = 40
			end	
			
		 return return_time		  
		  end)
	

end




function InvasionMode:OnGameRulesStateChange(keys)
  local newState = GameRules:State_Get()
  if newState == DOTA_GAMERULES_STATE_HERO_SELECTION then
    InvasionMode:ForcedToPlay()
  end
  if newState == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
    InvasionMode:ForestPVZGameStart()
  end
end


function InvasionMode:ForcedToPlay()
print("----------------------------------------all connect----------------------------------------")
	for i=0,5 do
		if PlayerResource:IsValidPlayer(i) then
			local player = PlayerResource:GetPlayer(i)
			--local player = hero:GetPlayerOwner()
			local teamNumb = player:GetTeamNumber()
			local name =  GetTeamName(teamNumb)
			if name == "#DOTA_BadGuys" then
				if roomBG == 1 then 
					InvasionMode:OnNewHeroCreated("npc_dota_hero_undying",player)				
				end
				if roomBG == 2 then
					player = InvasionMode:OnNewHeroCreated("npc_dota_hero_life_stealer",player)
					player:AddItemByName("item_ultimate_scepter")					
				end
				if roomBG == 3 then 
					InvasionMode:OnNewHeroCreated("npc_dota_hero_death_prophet",player)				
				end
				roomBG = roomBG+1		
	end
		end
	end
end


function InvasionMode:OnNewHeroCreated(name,player)
					player=CreateHeroForPlayer(name,player)
					player:SetGold(0, false)
					player:SetAbilityPoints(0)
					--player:GetAbilityCount()				
					for i=0, 6 do
						local ability = player:GetAbilityByIndex(i)
						if ability ~= nil then
							if ability:GetLevel() == 0 then							
								  ability:SetLevel(2)
							end
						end
					end
return player					

end