-- Low Covalence Dust

minetest.register_craftitem("eqex:low_covalence_dust", {
    description = "Low Covalence Dust",
    inventory_image = "eqex_low_covalence_dust.png",
})

minetest.register_craft({
    output = "eqex:low_covalence_dust 40",
    type = "shapeless",
    recipe = {
        "default:coal_lump",
        "default:cobble",
        "default:cobble",
        "default:cobble",
        "default:cobble",
        "default:cobble",
        "default:cobble",
        "default:cobble",
        "default:cobble",
    }
})

-- Medium Covalence Dust

minetest.register_craftitem("eqex:medium_covalence_dust", {
    description = "Medium Covalence Dust",
    inventory_image = "eqex_medium_covalence_dust.png",
})

minetest.register_craft({
    output = "eqex:medium_covalence_dust 40",
    type = "shapeless",
    recipe = {
        "default:steel_ingot",
        "default:mese_crystal",
    }
})

-- High Covalence Dust

minetest.register_craftitem("eqex:high_covalence_dust", {
    description = "High Covalence Dust",
    inventory_image = "eqex_high_covalence_dust.png",
})

minetest.register_craft({
    output = "eqex:high_covalence_dust 40",
    type = "shapeless",
    recipe = {
        "default:coal_lump",
        "default:diamond",
    }
})
