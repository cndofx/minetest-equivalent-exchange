eqex.chest = {}

function eqex.chest.get_formspec(pos)
    local pos = pos.x .. "," .. pos.y .. "," .. pos.z
    local formspec = {
        "size[13,12.6]",
        "list[nodemeta:", pos, ";main;0,0;13,8;]",
        "list[current_player;main;0,8.55;9,1;]",
        "list[current_player;main;0,9.78;9,3;9]",
        "listring[nodemeta:", pos, ";main]",
        "listring[current_player;main]",
    }
    return table.concat(formspec, "")
end

minetest.register_node("eqex:alchemical_chest", {
    description = "Alchemical Chest",
    groups = { cracky = 1 },
    tiles = {
        "eqex_alchemical_chest_top.png",
        "eqex_alchemical_chest_bottom.png",
        "eqex_alchemical_chest_side.png",
        "eqex_alchemical_chest_side.png",
        "eqex_alchemical_chest_side.png",
        "eqex_alchemical_chest_front.png",
    },
    paramtype2 = "facedir",
    on_construct = function(pos)
        local meta = minetest.get_meta(pos)
        local inv = meta:get_inventory()
        inv:set_size("main", 13 * 8)
    end,
    can_dig = function(pos, player)
        local meta = minetest.get_meta(pos)
        local inv = meta:get_inventory()
        return inv == nil or inv:is_empty("main")
    end,
    on_rightclick = function(pos, node, clicker)
        local clicker_name = clicker:get_player_name()
        minetest.show_formspec(clicker_name, "eqex:alchemical_chest", eqex.chest.get_formspec(pos))
    end
})

minetest.register_craft({
    output = "eqex:alchemical_chest",
    type = "shaped",
    recipe = {
        { "eqex:low_covalence_dust", "eqex:medium_covalence_dust", "eqex:high_covalence_dust" },
        { "group:stone",             "default:diamond",            "group:stone" },
        { "default:steel_ingot",     "default:chest",              "default:steel_ingot" }
    }
})
