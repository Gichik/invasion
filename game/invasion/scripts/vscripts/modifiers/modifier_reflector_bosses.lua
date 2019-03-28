
if modifier_reflector_bosses == nil then
    modifier_reflector_bosses = class({})
end

function modifier_reflector_bosses:IsHidden()
	return true
end

function modifier_reflector_bosses:GetTexture()
    return "nevermore_shadowraze1"
end

function modifier_reflector_bosses:RemoveOnDeath()
	return true
end

function modifier_reflector_bosses:CanBeAddToMinions()
    return true
end

function modifier_reflector_bosses:IsPurgable()
	return false
end

function modifier_reflector_bosses:IsPurgeException()
	return false
end

function modifier_reflector_bosses:DeclareFunctions()
    local funcs = {
        MODIFIER_EVENT_ON_TAKEDAMAGE
    }
    return funcs
end

--[[new_pos, process_procs,order_type,issuer_player_index,fail_type,damage_category,reincarnate,damage,ignore_invis
attacker,ranged_attack,record,unit,do_not_consume,damage_type,activity,heart_regen_applied,diffusal_applied
mkb_tested,no_attack_cooldown,damage_flags,original_damage,gain,cost,basher_tested,distance]]
function modifier_reflector_bosses:OnTakeDamage(data)
	if IsServer() then
		if data.unit == self:GetParent() and self:AttackDistance(data) > 300 then
	        ApplyDamage({
	            victim = data.attacker,
	            attacker = self:GetParent(),
	            damage = data.damage*3,
	            damage_type = DAMAGE_TYPE_PURE,
	            ability = self
	           })
	        local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_spectre/spectre_dispersion_fallback_mid.vpcf", PATTACH_POINT_FOLLOW, data.attacker) 
			ParticleManager:SetParticleControlEnt(particle, 0, data.unit, PATTACH_POINT_FOLLOW, "attach_hitloc", data.unit:GetAbsOrigin(), true) 
			ParticleManager:SetParticleControlEnt(particle, 1, data.attacker, PATTACH_POINT_FOLLOW, "attach_hitloc", data.attacker:GetAbsOrigin(), true)
			ParticleManager:ReleaseParticleIndex(particle)
		end
	end
end

function modifier_reflector_bosses:AttackDistance(data)
	local vAttacker = data.attacker:GetAbsOrigin()
	local vUnit = data.unit:GetAbsOrigin()

	return math.sqrt( math.pow(vAttacker.x-vUnit.x,2) + math.pow(vAttacker.y-vUnit.y,2) )
end