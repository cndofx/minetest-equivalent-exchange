-- Dark Matter

minetest.register_craftitem("eqex:dark_matter", {
    description = "Dark Matter",
    inventory_image = "eqex_dark_matter.png",
})

minetest.register_craft({
    output = "eqex:dark_matter",
    type = "shaped",
    recipe = {
        { "eqex:aeternalis_fuel", "eqex:aeternalis_fuel", "eqex:aeternalis_fuel" },
        { "eqex:aeternalis_fuel", "default:diamondblock", "eqex:aeternalis_fuel" },
        { "eqex:aeternalis_fuel", "eqex:aeternalis_fuel", "eqex:aeternalis_fuel" },
    }
})

-- Red Matter

minetest.register_craftitem("eqex:red_matter", {
    description = "Red Matter",
    inventory_image = "eqex_red_matter.png",
})

minetest.register_craft({
    output = "eqex:red_matter",
    type = "shaped",
    recipe = {
        { "eqex:aeternalis_fuel", "eqex:dark_matter", "eqex:aeternalis_fuel" },
        { "eqex:aeternalis_fuel", "eqex:dark_matter", "eqex:aeternalis_fuel" },
        { "eqex:aeternalis_fuel", "eqex:dark_matter", "eqex:aeternalis_fuel" },
    }
})

minetest.register_craft({
    output = "eqex:red_matter",
    type = "shaped",
    recipe = {
        { "eqex:aeternalis_fuel", "eqex:aeternalis_fuel", "eqex:aeternalis_fuel" },
        { "eqex:dark_matter",     "eqex:dark_matter",     "eqex:dark_matter" },
        { "eqex:aeternalis_fuel", "eqex:aeternalis_fuel", "eqex:aeternalis_fuel" },
    }
})
