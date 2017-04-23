-- Quest entity that will contain the quest data so it can be referenced later
--local EntQuestEnch = nil
--local FlagQuestEnch = 0

-- Call this function from Hammer to start the quest.  Checks to see if the entity has been created, if not, create the entity
-- See "adventure_example.vmap" for syntax on accessing functions
function QuestEnchStart()
	print("QuestEnchStart")
	print(FlagQuestEnch)
	if FlagQuestEnch == 0 then
		EntQuestEnch = SpawnEntityFromTableSynchronous( "quest", { name = "QuestEnch", title = "#QuestEnch_title" } )
		print("Quest")
		InvasionMode:ToogleQuestEnch()
	end
end


-- Call this function to end the quest.  References the previously created quest if it has been created, if not, should do nothing
function QuestEnchComplete()
	print("QuestEnchComplete")
	print(FlagQuestEnch)
	if FlagQuestEnch ~= 0 then
		EntQuestEnch:CompleteQuest()
	end
end


LinkLuaModifier("modifier_quest_rye", "modifiers/quests/modifier_quest_rye.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_quest_fish", "modifiers/quests/modifier_quest_fish.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_quest_weapon", "modifiers/quests/modifier_quest_weapon.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_quest_jewelry", "modifiers/quests/modifier_quest_jewelry.lua", LUA_MODIFIER_MOTION_NONE )

QuestPrizeTable = {}
QuestPrizeTable["modifier_quest_weapon"] = 500
QuestPrizeTable["modifier_quest_rye"] = 500
QuestPrizeTable["modifier_quest_jewelry"] = 200
QuestPrizeTable["modifier_quest_fish"] = 1200




function SaveKiller(data)
	data.caster.killer = data.attacker
end


function ApplyQuestModifier(data)
	local caster = data.caster
	local killer = caster.killer
	local modifName = data.ModifName
	local maxStacks = tonumber(data.MaxStacks)
	local chance = tonumber(data.Chance)

	if killer and modifName and maxStacks and chance then

		if not killer:IsIllusion() then
			if not killer:IsRealHero() then
				killer = killer:GetOwner()
			end

			if RollPercentage(chance) then
				local modifier = killer:FindModifierByName(modifName)
				if modifier then
					if modifier:GetStackCount() < maxStacks then
						modifier:IncrementStackCount()
					end
				else
					killer:AddNewModifier(killer, nil, modifName, {}):IncrementStackCount()
				end
			end
		end
	end
end


function CheckQuest(data)
	local caster = data.caster

	local heroes = FindUnitsInRadius( caster:GetTeamNumber(), caster:GetAbsOrigin(), caster, caster:GetBaseDayTimeVisionRange(),
	DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, 0, false )
	
	for i = 1, #heroes do		
		if heroes[i] then 
			local modifTable = heroes[i]:FindAllModifiers()
			for l = 1, #modifTable do
				local prize = QuestPrizeTable[modifTable[l]:GetName()]
				if prize then
					if modifTable[l]:GetStackCount() >= modifTable[l]:GiveMaxStack() then
						heroes[i]:ModifyGold(prize, false, 0)
						heroes[i]:RemoveModifierByName(modifTable[l]:GetName())
						ParticleManager:CreateParticle("particles/econ/courier/courier_flopjaw_gold/flopjaw_death_coins_gold.vpcf", PATTACH_ABSORIGIN, heroes[i])
						SendOverheadEventMessage( nil, OVERHEAD_ALERT_GOLD, heroes[i], prize, nil )
						--caster:DestroyAllSpeechBubbles()
						--heroes[i]:AddSpeechBubble(1, "Quest_complete", 2, 0, 0)
						EmitSoundOnLocationForAllies(heroes[i]:GetAbsOrigin(),"Tutorial.Quest.complete_01",heroes[i])
					end
				end
			end			
		end
	end	
end


function CheckQuestRye(data)
	local caster = data.caster

	local heroes = FindUnitsInRadius( caster:GetTeamNumber(), caster:GetAbsOrigin(), caster, caster:GetBaseDayTimeVisionRange(),
	DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, 0, false )
	
	for i = 1, #heroes do		
		if heroes[i] then 
			local modifier = heroes[i]:FindModifierByName("modifier_quest_rye")
			if modifier and modifier:GetStackCount() >= modifier:GiveMaxStack() then
				local prize = QuestPrizeTable["modifier_quest_rye"] 
				heroes[i]:ModifyGold(prize, false, 0)
				heroes[i]:RemoveModifierByName("modifier_quest_rye")
				ParticleManager:CreateParticle("particles/econ/courier/courier_flopjaw_gold/flopjaw_death_coins_gold.vpcf", PATTACH_ABSORIGIN, heroes[i])
				SendOverheadEventMessage( nil, OVERHEAD_ALERT_GOLD, heroes[i], prize, nil )
				--caster:DestroyAllSpeechBubbles()
				--heroes[i]:AddSpeechBubble(1, "Quest_complete", 2, 0, 0)
				EmitSoundOnLocationForAllies(heroes[i]:GetAbsOrigin(),"Tutorial.Quest.complete_01",heroes[i])
			end
		end
	end	
end

function CheckQuestFish(data)
	local caster = data.caster

	local heroes = FindUnitsInRadius( caster:GetTeamNumber(), caster:GetAbsOrigin(), caster, caster:GetBaseDayTimeVisionRange(),
	DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, 0, false )
	
	for i = 1, #heroes do		
		if heroes[i] then 
			local modifier = heroes[i]:FindModifierByName("modifier_quest_fish")
			if modifier and modifier:GetStackCount() >= modifier:GiveMaxStack() then
				local prize = QuestPrizeTable["modifier_quest_fish"] 
				heroes[i]:ModifyGold(prize, false, 0)
				heroes[i]:RemoveModifierByName("modifier_quest_fish")
				ParticleManager:CreateParticle("particles/econ/courier/courier_flopjaw_gold/flopjaw_death_coins_gold.vpcf", PATTACH_ABSORIGIN, heroes[i])
				SendOverheadEventMessage( nil, OVERHEAD_ALERT_GOLD, heroes[i], prize, nil )
				--caster:DestroyAllSpeechBubbles()
				--heroes[i]:AddSpeechBubble(1, "Quest_complete", 2, 0, 0)
				EmitSoundOnLocationForAllies(heroes[i]:GetAbsOrigin(),"Tutorial.Quest.complete_01",heroes[i])
			end
		end
	end	
end

function CheckQuestWeapon(data)
	local caster = data.caster

	local heroes = FindUnitsInRadius( caster:GetTeamNumber(), caster:GetAbsOrigin(), caster, caster:GetBaseDayTimeVisionRange(),
	DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, 0, false )
	
	for i = 1, #heroes do		
		if heroes[i] then 
			local modifier = heroes[i]:FindModifierByName("modifier_quest_weapon")
			if modifier and modifier:GetStackCount() >= modifier:GiveMaxStack() then
				local prize = QuestPrizeTable["modifier_quest_weapon"] 
				if heroes[i]:GetTeamNumber() == DOTA_TEAM_GOODGUYS then
					prize = prize + 500
				end
				heroes[i]:ModifyGold(prize, false, 0)
				heroes[i]:RemoveModifierByName("modifier_quest_weapon")
				ParticleManager:CreateParticle("particles/econ/courier/courier_flopjaw_gold/flopjaw_death_coins_gold.vpcf", PATTACH_ABSORIGIN, heroes[i])
				SendOverheadEventMessage( nil, OVERHEAD_ALERT_GOLD, heroes[i], prize, nil )
				--caster:DestroyAllSpeechBubbles()
				--heroes[i]:AddSpeechBubble(1, "Quest_complete", 2, 0, 0)
				EmitSoundOnLocationForAllies(heroes[i]:GetAbsOrigin(),"Tutorial.Quest.complete_01",heroes[i])
			end
		end
	end	
end


function CheckQuestJewelry(data)
	local caster = data.caster

	local heroes = FindUnitsInRadius( caster:GetTeamNumber(), caster:GetAbsOrigin(), caster, caster:GetBaseDayTimeVisionRange(),
	DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, 0, false )
	
	for i = 1, #heroes do		
		if heroes[i] then 
			local modifier = heroes[i]:FindModifierByName("modifier_quest_jewelry")
			if modifier then
				local stacks = modifier:GetStackCount()
				local prize = stacks*QuestPrizeTable["modifier_quest_jewelry"] 
				heroes[i]:ModifyGold(prize, false, 0)
				heroes[i]:RemoveModifierByName("modifier_quest_jewelry")
				ParticleManager:CreateParticle("particles/econ/courier/courier_flopjaw_gold/flopjaw_death_coins_gold.vpcf", PATTACH_ABSORIGIN, heroes[i])
				SendOverheadEventMessage( nil, OVERHEAD_ALERT_GOLD, heroes[i], prize, nil )
				--caster:DestroyAllSpeechBubbles()
				caster:AddSpeechBubble(1, "Quest_complete", 2, 0, 0)
				EmitSoundOnLocationForAllies(heroes[i]:GetAbsOrigin(),"Tutorial.Quest.complete_01",heroes[i])
			end
		end
	end	
end