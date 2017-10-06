function ModifierOctarinityOnCreated(data)
	local caster = data.caster
	local ability = data.ability

	caster:RemoveModifierByName("modifier_item_ultimate_scepter_consumed")
	caster:RemoveModifierByName("modifier_item_octarine_core")

	caster:AddNewModifier(caster, ability, "modifier_item_ultimate_scepter_consumed", {duration = -1})
	caster:AddNewModifier(caster, ability, "modifier_item_octarine_core", {duration = -1})
end

function ModifierOctarinityOnDestroy(data)
	--print("OnDestroy")	
	local caster = data.caster
	local num_octarinity = -1

	for i = 0, 5 do  
		local current_item = caster:GetItemInSlot(i)
		if current_item ~= nil then
			local item_name = current_item:GetName()
			
			if item_name == "item_octarinity" then
				num_octarinity = num_octarinity + 1
			end
		end
	end

	if num_octarinity <= 0 then
		caster:RemoveModifierByName("modifier_item_ultimate_scepter_consumed")
		caster:RemoveModifierByName("modifier_item_octarine_core")
	end
end