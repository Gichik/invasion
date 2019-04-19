
-------------------------------------------------------------------
------------------------------Settings-----------------------------
-------------------------------------------------------------------
REWARD_DROP_PERCENT = 80
ITEM_DROP_PERCENT = 60
TIME_BEFORE_REMOVE_DROP = 60
MINIONS_COUNT = 5
MONSTERS_LEVEL = 0
RADIANT_COUNT = 0
DIRE_COUNT = 0

ATTRIBUTES_ITEMS = { 
    "item_gauntlets",
    "item_slippers",
    "item_mantle",   
    "item_circlet",
    "item_belt_of_strength",
    "item_boots_of_elves",
    "item_robe",
    "item_crown",
    "item_ogre_axe",
    "item_blade_of_alacrity",
    "item_staff_of_wizardry"             
    }

WEAPONS_ITEMS = { 
    "item_ring_of_protection",
    "item_stout_shield",
    "item_quelling_blade", 
    "item_orb_of_venom",
    "item_blight_stone",
    "item_blades_of_attack",
    "item_chainmail",
    "item_quarterstaff",
    "item_helm_of_iron_will",
    "item_javelin",
    "item_broadsword",
    "item_claymore",             
    "item_mithril_hammer"             
    } 

MISC_ITEMS = { 
    "item_ring_of_regen",
    "item_sobi_mask",
    "item_boots",
    "item_gloves",
    "item_cloak",
    "item_ring_of_tarrasque",
    "item_ring_of_health",
    "item_void_stone",           
    "item_gem",
    "item_lifesteal",
    "item_shadow_amulet",    
    "item_ghost",
    "item_blink"              
    } 


SECRET_ITEMS = { 
    "item_energy_booster",
    "item_vitality_booster",
    "item_point_booster",
    "item_platemail",
    "item_talisman_of_evasion",
    "item_hyperstone",
    "item_ultimate_orb",
    "item_demon_edge",
    "item_mystic_staff",
    "item_reaver",
    "item_eagle",
    "item_relic"
    }   


function GetRandomItemNameFrom(itemType)
    if itemType == "attributes" then
        return ATTRIBUTES_ITEMS[RandomInt(1,#ATTRIBUTES_ITEMS)]        
    end

    if itemType == "weapons" then
        return WEAPONS_ITEMS[RandomInt(1,#WEAPONS_ITEMS)]        
    end

    if itemType == "misc" then
        return MISC_ITEMS[RandomInt(1,#MISC_ITEMS)]        
    end    

    if itemType == "secret" then
        return SECRET_ITEMS[RandomInt(1,#SECRET_ITEMS)]        
    end

end
