modifier_quest_kill_some_units = class({})
require( 'modifiers_links' )

function modifier_quest_kill_some_units:GetTexture()
    return "custom_folder/quests_icons/quest_icon"
end

function modifier_quest_kill_some_units:DeclareFunctions()
	local funcs = { MODIFIER_EVENT_ON_DEATH }
	return funcs
end

function modifier_quest_kill_some_units:OnCreated(data)
	if IsServer() then
		self:SetStackCount(70)
	end
end

function modifier_quest_kill_some_units:OnDeath(data)

	if IsServer() then

		local attacker = data.attacker
		local target = data.unit

		if attacker:HasModifier("modifier_quest_kill_some_units") then
			local modifier = attacker:FindModifierByName("modifier_quest_kill_some_units")
			modifier:DecrementStackCount()

			if modifier:GetStackCount() <= 0 then
				attacker:AddNewModifier(attacker, nil, "modifier_critic", {duration = 120})
				ParticleManager:CreateParticle("particles/units/heroes/hero_legion_commander/legion_commander_duel_victory.vpcf", PATTACH_ABSORIGIN, attacker)
				EmitSoundOn("Tutorial.Quest.complete_01", attacker)
				
				modifier:Destroy()
			end
		end
	end
end


function modifier_quest_kill_some_units:OnDestroy()
	if IsServer() then
		local caster = self:GetCaster()
		if self:GetStackCount() > 0 then
			EmitSoundOn("ui.contract_complete", caster)
		end 
		caster:AddNewModifier(caster, nil, GetQuestModifierName(), {duration = 120})
	end
end


function modifier_quest_kill_some_units:RemoveOnDeath()
	return false
end

function modifier_quest_kill_some_units:IsHidden()
	return false
end
