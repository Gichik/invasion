modifier_quest_kill_sicklyZ = class({})
require( 'modifiers_links' )

function modifier_quest_kill_sicklyZ:GetTexture()
    return "custom_folder/quests_icons/quest_icon"
end

function modifier_quest_kill_sicklyZ:DeclareFunctions()
	local funcs = { MODIFIER_EVENT_ON_DEATH }
	return funcs
end

function modifier_quest_kill_sicklyZ:OnCreated(data)
	if IsServer() then
		self:SetStackCount(40)
	end
end

function modifier_quest_kill_sicklyZ:OnDeath(data)

	if IsServer() then

		local attacker = data.attacker
		local target = data.unit

		if attacker:HasModifier("modifier_quest_kill_sicklyZ")  and target:GetUnitName() == "sickly_zombies" then
			local modifier = attacker:FindModifierByName("modifier_quest_kill_sicklyZ")
			modifier:DecrementStackCount()

			if modifier:GetStackCount() <= 0 then
				attacker:AddNewModifier(attacker, nil, "modifier_bodybuilder", {duration = 120})
				ParticleManager:CreateParticle("particles/units/heroes/hero_legion_commander/legion_commander_duel_victory.vpcf", PATTACH_ABSORIGIN, attacker)
				EmitSoundOn("Tutorial.Quest.complete_01", attacker)
				
				modifier:Destroy()
			end
		end
	end
end


function modifier_quest_kill_sicklyZ:OnDestroy()
	if IsServer() then
		local caster = self:GetCaster()
		if self:GetStackCount() > 0 then
			EmitSoundOn("ui.contract_complete", caster)
		end 
		caster:AddNewModifier(caster, nil, GetQuestModifierName(), {duration = 120})
	end
end


function modifier_quest_kill_sicklyZ:RemoveOnDeath()
	return false
end

function modifier_quest_kill_sicklyZ:IsHidden()
	return false
end
