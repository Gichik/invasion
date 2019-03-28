
if modifier_reflector == nil then
    modifier_reflector = class({})
end

function modifier_reflector:IsHidden()
	return false
end

function modifier_reflector:GetTexture()
    return "nevermore_shadowraze1"
end

function modifier_reflector:RemoveOnDeath()
	return true
end

function modifier_reflector:CanBeAddToMinions()
    return true
end

function modifier_reflector:IsPurgable()
	return false
end

function modifier_reflector:IsPurgeException()
	return false
end

function modifier_reflector:DeclareFunctions()
    local funcs = {
        MODIFIER_EVENT_ON_TAKEDAMAGE
    }
    return funcs
end

--[[new_pos, process_procs,order_type,issuer_player_index,fail_type,damage_category,reincarnate,damage,ignore_invis
attacker,ranged_attack,record,unit,do_not_consume,damage_type,activity,heart_regen_applied,diffusal_applied
mkb_tested,no_attack_cooldown,damage_flags,original_damage,gain,cost,basher_tested,distance]]
function modifier_reflector:OnTakeDamage(data)
	if IsServer() then
		if data.unit == self:GetParent() then
	        ApplyDamage({
	            victim = data.attacker,
	            attacker = self:GetParent(),
	            damage = data.damage*self.refPercent/100,
	            damage_type = data.damage_type,
	            ability = self
	           })
	        local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_spectre/spectre_dispersion_fallback_mid.vpcf", PATTACH_POINT_FOLLOW, data.attacker) 
			ParticleManager:SetParticleControlEnt(particle, 0, data.unit, PATTACH_POINT_FOLLOW, "attach_hitloc", data.unit:GetAbsOrigin(), true) 
			ParticleManager:SetParticleControlEnt(particle, 1, data.attacker, PATTACH_POINT_FOLLOW, "attach_hitloc", data.attacker:GetAbsOrigin(), true)
			ParticleManager:ReleaseParticleIndex(particle)
		end
	end
end

function modifier_reflector:OnCreated()
	if IsServer() then
		self.refPercent = 80
		self:GetParent():SetRenderColor(220, 20, 60) 
	end
end