
if modifier_lump == nil then
    modifier_lump = class({})
end

function modifier_lump:IsHidden()
	return false
end

function modifier_lump:GetTexture()
    return "tiny_grow"
end

function modifier_lump:RemoveOnDeath()
	return true
end

function modifier_lump:CanBeAddToMinions()
    return true
end

function modifier_lump:IsPurgable()
    return false
end

function modifier_lump:IsPurgeException()
    return false
end


function modifier_lump:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
        MODIFIER_PROPERTY_INCOMING_PHYSICAL_DAMAGE_PERCENTAGE,
    }
    return funcs
end

function modifier_lump:GetModifierMagicalResistanceBonus()	
	return self.magicResBonus or 0
end


--new_pos, process_procs, order_type, issuer_player_index, target, damage_category, reincarnate
--damage, ignore_invis, attacker, ranged_attack, record, activity, do_not_consume, damage_type
--heart_regen_applied, diffusal_applied, mkb_tested, distance, no_attack_cooldown, damage_flags
--original_damage, cost, gain, basher_tested, fail_type
function modifier_lump:GetModifierIncomingPhysicalDamage_Percentage()	
	return self.physArmorBonus or 0
end

function modifier_lump:OnCreated()
	self.magicResBonus = 80
	self.physArmorBonus = -80

	if IsServer() then
		self:GetParent():SetRenderColor(105, 105, 105)
	end
end


