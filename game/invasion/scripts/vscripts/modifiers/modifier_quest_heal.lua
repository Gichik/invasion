modifier_quest_heal = class({})
require( 'modifiers_links' )

function modifier_quest_heal:GetTexture()
    return "custom_folder/quests_icons/quest_icon"
end

function modifier_quest_heal:DeclareFunctions()
	local funcs = { MODIFIER_EVENT_ON_HEAL_RECEIVED }
	return funcs
end

function modifier_quest_heal:OnCreated(data)
	if IsServer() then
		self:SetStackCount(70)
	end
end

function modifier_quest_heal:OnHealReceived(data)
	print("health")
for k,v in pairs(data) do
		print(k)
	end
--[[	if IsServer() then

		local attacker = data.attacker
		local target = data.unit

		if attacker:HasModifier("modifier_quest_heal") then
			local modifier = attacker:FindModifierByName("modifier_quest_heal")
			modifier:DecrementStackCount()

			if modifier:GetStackCount() <= 0 then
				attacker:AddNewModifier(attacker, nil, "modifier_critic", {duration = 120})
				ParticleManager:CreateParticle("particles/units/heroes/hero_legion_commander/legion_commander_duel_victory.vpcf", PATTACH_ABSORIGIN, attacker)
				EmitSoundOn("Tutorial.Quest.complete_01", attacker)
				
				modifier:Destroy()
			end
		end
	end]]
end


function modifier_quest_heal:OnDestroy()
	if IsServer() then
		local caster = self:GetCaster()
		if self:GetStackCount() > 0 then
			EmitSoundOn("ui.contract_complete", caster)
		end 
		caster:AddNewModifier(caster, nil, GetQuestModifierName(), {duration = 120})
	end
end


function modifier_quest_heal:RemoveOnDeath()
	return false
end

function modifier_quest_heal:IsHidden()
	return false
end
