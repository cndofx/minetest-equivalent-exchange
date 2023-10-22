-- Alchemical Coal

minetest.register_craftitem("eqex:alchemical_coal", {
    description = "Alchemical Coal",
    inventory_image = "eqex_alchemical_coal.png"
})

minetest.register_craft({
    output = "eqex:alchemical_coal",
    type = "shapeless",
    recipe = {
        "eqex:philosophers_stone",
        "default:coal_lump",
        "default:coal_lump",
        "default:coal_lump",
        "default:coal_lump",
    },
    replacements = {
        { "eqex:philosophers_stone", "eqex:philosophers_stone" }
    }
})

minetest.register_craft({
    type = "fuel",
    recipe = "eqex:alchemical_coal",
    burntime = 160, -- 4x normal coal, same efficiency but compressed
})

-- Mobius Fuel

minetest.register_craftitem("eqex:mobius_fuel", {
    description = "Mobius Fuel",
    inventory_image = "eqex_mobius_fuel.png"
})

minetest.register_craft({
    output = "eqex:mobius_fuel",
    type = "shapeless",
    recipe = {
        "eqex:philosophers_stone",
        "eqex:alchemical_coal",
        "eqex:alchemical_coal",
        "eqex:alchemical_coal",
        "eqex:alchemical_coal",
    },
    replacements = {
        { "eqex:philosophers_stone", "eqex:philosophers_stone" }
    }
})

minetest.register_craft({
    type = "fuel",
    recipe = "eqex:mobius_fuel",
    burntime = 640, -- 16x normal coal, same efficiency but compressed
})

-- Aeternalis Fuel

minetest.register_craftitem("eqex:aeternalis_fuel", {
    description = "Aeternalis Fuel",
    inventory_image = "eqex_aeternalis_fuel.png"
})

minetest.register_craft({
    output = "eqex:aeternalis_fuel",
    type = "shapeless",
    recipe = {
        "eqex:philosophers_stone",
        "eqex:mobius_fuel",
        "eqex:mobius_fuel",
        "eqex:mobius_fuel",
        "eqex:mobius_fuel",
    },
    replacements = {
        { "eqex:philosophers_stone", "eqex:philosophers_stone" }
    }
})

minetest.register_craft({
    type = "fuel",
    recipe = "eqex:aeternalis_fuel",
    burntime = 2560, -- 64x normal coal, same efficiency but compressed
})
