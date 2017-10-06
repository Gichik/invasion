modifier_quest_kill_tightZ = class({})
require( 'modifiers_links' )

function modifier_quest_kill_tightZ:GetTexture()
    return "custom_folder/quests_icons/quest_icon"
end

function modifier_quest_kill_tightZ:DeclareFunctions()
	local funcs = { MODIFIER_EVENT_ON_DEATH }
	return funcs
end

function modifier_quest_kill_tightZ:OnCreated(data)
	if IsServer() then
		self:SetStackCount(40)
	end
end

function modifier_quest_kill_tightZ:OnDeath(data)

	if IsServer() then

		local attacker = data.attacker
		local target = data.unit

		if attacker:HasModifier("modifier_quest_kill_tightZ")  and target:GetUnitName() == "tight_zombies" then
			local modifier = attacker:FindModifierByName("modifier_quest_kill_tightZ")
			modifier:DecrementStackCount()

			if modifier:GetStackCount() <= 0 then
				attacker:AddNewModifier(attacker, nil, "modifier_strange_man", {duration = 120})
				ParticleManager:CreateParticle("particles/units/heroes/hero_legion_commander/legion_commander_duel_victory.vpcf", PATTACH_ABSORIGIN, attacker)
				EmitSoundOn("Tutorial.Quest.complete_01", attacker)
				
				modifier:Destroy()
			end
		end
	end
end


function modifier_quest_kill_tightZ:OnDestroy()
	if IsServer() then
		local caster = self:GetCaster()
		if self:GetStackCount() > 0 then
			EmitSoundOn("ui.contract_complete", caster)
		end 
		caster:AddNewModifier(caster, nil, GetQuestModifierName(), {duration = 120})
	end
end


function modifier_quest_kill_tightZ:RemoveOnDeath()
	return false
end

function modifier_quest_kill_tightZ:IsHidden()
	return false
end
