-- Pickaxe

minetest.register_tool("eqex:pick_dark_matter", {
    description = "Dark Matter Pickaxe",
    inventory_image = "eqex_pick_dark_matter.png",
    tool_capabilities = {
        full_punch_interval = 0.9,
        max_drop_level = 3,
        groupcaps = {
            cracky = {
                times = {
                    [1] = 1.5,
                    [2] = 0.8,
                    [3] = 0.4,
                },
                uses = 0,
                maxlevel = 3,
            }
        },
        damage_groups = { fleshy = 6 },
        groups = { pickaxe = 1 }
    }
})

minetest.register_craft({
    output = "eqex:pick_dark_matter",
    type = "shaped",
    recipe = {
        { "eqex:dark_matter", "eqex:dark_matter", "eqex:dark_matter" },
        { "",                 "default:diamond",  "" },
        { "",                 "default:diamond",  "" },
    }
})

minetest.register_tool("eqex:pick_red_matter", {
    description = "Red Matter Pickaxe",
    inventory_image = "eqex_pick_red_matter.png",
    tool_capabilities = {
        full_punch_interval = 0.9,
        max_drop_level = 3,
        groupcaps = {
            cracky = {
                times = {
                    [1] = 1.3,
                    [2] = 0.6,
                    [3] = 0.3,
                },
                uses = 0,
                maxlevel = 3,
            }
        },
        damage_groups = { fleshy = 8 },
        groups = { pickaxe = 1 }
    }
})

minetest.register_craft({
    output = "eqex:pick_red_matter",
    type = "shaped",
    recipe = {
        { "eqex:red_matter", "eqex:red_matter",       "eqex:red_matter" },
        { "",                "eqex:pick_dark_matter", "" },
        { "",                "eqex:dark_matter",      "" },
    }
})

-- Shovel

minetest.register_tool("eqex:shovel_dark_matter", {
    description = "Dark Matter Shovel",
    inventory_image = "eqex_shovel_dark_matter.png",
    wield_image = "eqex_shovel_dark_matter.png^[transformR90",
    tool_capabilities = {
        full_punch_interval = 1.0,
        max_drop_level = 3,
        groupcaps = {
            crumbly = {
                times = {
                    [1] = 0.8,
                    [2] = 0.3,
                    [3] = 0.2,
                },
                uses = 0,
                maxlevel = 3,
            }
        },
        damage_groups = { fleshy = 7 },
        groups = { shovel = 1 }
    }
})

minetest.register_craft({
    output = "eqex:shovel_dark_matter",
    type = "shaped",
    recipe = {
        { "eqex:dark_matter" },
        { "default:diamond" },
        { "default:diamond" },
    }
})

minetest.register_tool("eqex:shovel_red_matter", {
    description = "Red Matter Shovel",
    inventory_image = "eqex_shovel_red_matter.png",
    wield_image = "eqex_shovel_red_matter.png^[transformR90",
    tool_capabilities = {
        full_punch_interval = 1.0,
        max_drop_level = 3,
        groupcaps = {
            crumbly = {
                times = {
                    [1] = 0.6,
                    [2] = 0.2,
                    [3] = 0.1,
                },
                uses = 0,
                maxlevel = 3,
            }
        },
        damage_groups = { fleshy = 9 },
        groups = { shovel = 1 }
    }
})

minetest.register_craft({
    output = "eqex:shovel_red_matter",
    type = "shaped",
    recipe = {
        { "eqex:red_matter" },
        { "eqex:shovel_dark_matter" },
        { "eqex:dark_matter" },
    }
})

-- Axe

minetest.register_tool("eqex:axe_dark_matter", {
    description = "Dark Matter Axe",
    inventory_image = "eqex_axe_dark_matter.png",
    wield_image = "eqex_axe_dark_matter.png",
    tool_capabilities = {
        full_punch_interval = 0.9,
        max_drop_level = 1,
        groupcaps = {
            choppy = {
                times = {
                    [1] = 1.7,
                    [2] = 0.7,
                    [3] = 0.4,
                },
                uses = 0,
                maxlevel = 3,
            }
        },
        damage_groups = { fleshy = 9 },
        groups = { axe = 1 }
    }
})

minetest.register_craft({
    output = "eqex:axe_dark_matter",
    type = "shaped",
    recipe = {
        { "eqex:dark_matter", "eqex:dark_matter" },
        { "eqex:dark_matter", "default:diamond" },
        { "",                 "default:diamond" },
    }
})

minetest.register_tool("eqex:axe_red_matter", {
    description = "Red Matter Axe",
    inventory_image = "eqex_axe_red_matter.png",
    wield_image = "eqex_axe_red_matter.png",
    tool_capabilities = {
        full_punch_interval = 0.9,
        max_drop_level = 1,
        groupcaps = {
            choppy = {
                times = {
                    [1] = 1.4,
                    [2] = 0.5,
                    [3] = 0.3,
                },
                uses = 0,
                maxlevel = 3,
            }
        },
        damage_groups = { fleshy = 11 },
        groups = { axe = 1 }
    }
})

minetest.register_craft({
    output = "eqex:axe_red_matter",
    type = "shaped",
    recipe = {
        { "eqex:red_matter", "eqex:red_matter" },
        { "eqex:red_matter", "eqex:axe_dark_matter" },
        { "",                "eqex:dark_matter" },
    }
})
