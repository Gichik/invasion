modifier_quest_apply_mag_dmg = class({})
require( 'modifiers_links' )

function modifier_quest_apply_mag_dmg:GetTexture()
    return "custom_folder/quests_icons/quest_icon"
end

function modifier_quest_apply_mag_dmg:DeclareFunctions()
	local funcs = { MODIFIER_EVENT_ON_TAKEDAMAGE }
	return funcs
end

function modifier_quest_apply_mag_dmg:OnCreated(data)
	if IsServer() then
		self:SetStackCount(3000)
	end
end

function modifier_quest_apply_mag_dmg:OnTakeDamage(data)
	if IsServer() then

		local attacker = data.attacker

		if attacker:HasModifier("modifier_quest_apply_mag_dmg")  and data.damage_type == DAMAGE_TYPE_MAGICAL then
			local modifier = attacker:FindModifierByName("modifier_quest_apply_mag_dmg")
			modifier:SetStackCount(modifier:GetStackCount() - math.floor(data.damage))

			if modifier:GetStackCount() <= 0 then
				attacker:AddNewModifier(attacker, nil, "modifier_love", {duration = 120})
				ParticleManager:CreateParticle("particles/units/heroes/hero_legion_commander/legion_commander_duel_victory.vpcf", PATTACH_ABSORIGIN, attacker)
				EmitSoundOn("Tutorial.Quest.complete_01", attacker)
				
				modifier:Destroy()
			end
		end
	end
end


function modifier_quest_apply_mag_dmg:OnDestroy()
	if IsServer() then
		local caster = self:GetCaster()
		if self:GetStackCount() > 0 then
			EmitSoundOn("ui.contract_complete", caster)
		end 
		caster:AddNewModifier(caster, nil, GetQuestModifierName(), {duration = 120})
	end
end


function modifier_quest_apply_mag_dmg:RemoveOnDeath()
	return false
end

function modifier_quest_apply_mag_dmg:IsHidden()
	return false
end
