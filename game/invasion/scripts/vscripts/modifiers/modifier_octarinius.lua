
modifier_octarinius = class({})


function modifier_octarinius:GetTexture()
    return "arc_warden_magnetic_field"
end

function modifier_octarinius:DeclareFunctions()
	local funcs = {}
	return funcs
end


function modifier_octarinius:OnCreated( data )
	if IsServer() then		
		self:OnIntervalThink()
		self:StartIntervalThink( 0.1 )
	end	
end
--self:GetParent():HasItemInInventory("item_octarinius")
function modifier_octarinius:OnIntervalThink()
	local caster = self:GetParent()
	local hasOctarinius = false
	local item = nil
	for i = 0, 11 do
		item = caster:GetItemInSlot(i)
		if item ~= nil and item:GetAbilityName() == "item_octarinity" then
			hasOctarinius = true
		end		
	end

	if caster:HasItemInInventory("item_octarinity") then
		caster:RemoveModifierByName("modifier_item_ultimate_scepter_consumed")
		caster:AddNewModifier(caster, nil, "modifier_item_ultimate_scepter_consumed", {duration = -1})
	else
		caster:RemoveModifierByName("modifier_item_ultimate_scepter_consumed")
	end

	if not hasOctarinius then
		caster:RemoveModifierByName("modifier_octarinius")
	end

end

function modifier_octarinius:OnDestroy( data )
	if IsServer() then
		caster = self:GetParent()
		caster:RemoveModifierByName("modifier_item_ultimate_scepter_consumed")
	end
end


function modifier_octarinius:RemoveOnDeath()
	return false
end

function modifier_octarinius:IsHidden()
	return false
end
