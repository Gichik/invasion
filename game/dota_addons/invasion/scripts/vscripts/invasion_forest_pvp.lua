GAME_ROUND = 0

if InvasionMode == nil then
	InvasionMode = class({})
end

function InvasionMode:InvasionForestPvPMap()

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

	ListenToGameEvent('game_rules_state_change', Dynamic_Wrap(InvasionMode, 'ForestPVPMapGameRulesStateChange'), self)	
end

function InvasionMode:ForestPVPGameStart()
	
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
   	  
		  	
	
	
	      Timers:CreateTimer(1, function()		  
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


 function InvasionMode:ForestPVPMapGameRulesStateChange(keys)
  local newState = GameRules:State_Get()
  if newState == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
    InvasionMode:ForestPVPGameStart()
  end
end
