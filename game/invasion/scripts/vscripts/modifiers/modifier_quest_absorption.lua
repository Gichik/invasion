modifier_quest_absorption = class({})
--LinkLuaModifier("modifier_iron_head", "modifiers/modifier_iron_head.lua", LUA_MODIFIER_MOTION_NONE )
require( 'modifiers_links' )

function modifier_quest_absorption:GetTexture()
    return "custom_folder/quests_icons/quest_icon"
end

function modifier_quest_absorption:DeclareFunctions()
	local funcs = { MODIFIER_EVENT_ON_TAKEDAMAGE }
	return funcs
end

function modifier_quest_absorption:OnCreated(data)
	if IsServer() then
		self:SetStackCount(2000)
	end
end

function modifier_quest_absorption:OnTakeDamage(data)
	if IsServer() then
		local target = data.unit

		if target:HasModifier("modifier_quest_absorption")  then
			local modifier = target:FindModifierByName("modifier_quest_absorption")
			modifier:SetStackCount(modifier:GetStackCount() - data.damage)


			if modifier:GetStackCount() <= 0 then
				target:AddNewModifier(target, nil, "modifier_iron_head", {duration = 120})
				ParticleManager:CreateParticle("particles/units/heroes/hero_legion_commander/legion_commander_duel_victory.vpcf", PATTACH_ABSORIGIN, target)
				EmitSoundOn("Tutorial.Quest.complete_01", target)
				
				modifier:Destroy()
			end
		end
	end
	--[[for k,v in pairs(data) do
		print(k)
	end]]
end


function modifier_quest_absorption:OnDestroy()
	if IsServer() then
		local caster = self:GetCaster()
		if self:GetStackCount() > 0 then
			EmitSoundOn("ui.contract_complete", self:GetCaster())
		end
		caster:AddNewModifier(caster, nil, GetQuestModifierName(), {duration = 120})
	end
end


function modifier_quest_absorption:RemoveOnDeath()
	return false
end

function modifier_quest_absorption:IsHidden()
	return false
end
