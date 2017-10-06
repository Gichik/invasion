modifier_quest_kill_halfZ = class({})
require( 'modifiers_links' )

function modifier_quest_kill_halfZ:GetTexture()
    return "custom_folder/quests_icons/quest_icon"
end

function modifier_quest_kill_halfZ:DeclareFunctions()
	local funcs = { MODIFIER_EVENT_ON_DEATH }
	return funcs
end

function modifier_quest_kill_halfZ:OnCreated(data)
	if IsServer() then
		self:SetStackCount(30)
	end
end

function modifier_quest_kill_halfZ:OnDeath(data)

	if IsServer() then

		local attacker = data.attacker
		local target = data.unit

		if attacker:HasModifier("modifier_quest_kill_halfZ")  and target:GetUnitName() == "new_half_zombies" then
			local modifier = attacker:FindModifierByName("modifier_quest_kill_halfZ")
			modifier:DecrementStackCount()

			if modifier:GetStackCount() <= 0 then
				attacker:AddNewModifier(attacker, nil, "modifier_nudity", {duration = 120})
				ParticleManager:CreateParticle("particles/units/heroes/hero_legion_commander/legion_commander_duel_victory.vpcf", PATTACH_ABSORIGIN, attacker)
				EmitSoundOn("Tutorial.Quest.complete_01", attacker)
				
				modifier:Destroy()
			end
		end
	end
end


function modifier_quest_kill_halfZ:OnDestroy()
	if IsServer() then
		local caster = self:GetCaster()
		if self:GetStackCount() > 0 then
			EmitSoundOn("ui.contract_complete", caster)
		end 
		caster:AddNewModifier(caster, nil, GetQuestModifierName(), {duration = 120})
	end
end


function modifier_quest_kill_halfZ:RemoveOnDeath()
	return false
end

function modifier_quest_kill_halfZ:IsHidden()
	return false
end
