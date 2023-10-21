eqex.philosophers_stone = {
    swaps = {
        {
            "default:sand",
            "default:dirt",
        },
        {
            "default:stone",
            "default:cobble",
        },
        {
            "default:gravel",
            "default:clay",
        },
        {
            "default:tree",
            "default:acacia_tree",
            "default:aspen_tree",
            "default:jungletree",
            "default:pine_tree",
        },
    }
}

function eqex.philosophers_stone.get_swapped_block(block_name)
    for _, swap_group in ipairs(eqex.philosophers_stone.swaps) do
        for idx, block in ipairs(swap_group) do
            if block == block_name then
                -- swap this block with the next one
                local i = idx + 1
                if swap_group[i] ~= nil then
                    return swap_group[i]
                else
                    return swap_group[1]
                end
            end
        end
    end

    -- no swap exists for this block
    return block_name
end

local function do_philosopher_swap(itemstack, user, pointed_thing)
    if pointed_thing.type == "node" then
        local node_pos = pointed_thing.under
        local node = minetest.get_node(node_pos)
        local new_name = eqex.philosophers_stone.get_swapped_block(node.name)
        if node.name ~= new_name then
            minetest.set_node(node_pos, { name = new_name })
        end
    end
end

minetest.register_tool("eqex:philosophers_stone", {
    description = "Philosopher's Stone",
    inventory_image = "eqex_philosophers_stone.png",
    on_place = do_philosopher_swap,
})

minetest.register_craft({
    output = "eqex:philosophers_stone",
    type = "shaped",
    recipe = {
        { "default:mese_crystal", "default:gold_ingot", "default:mese_crystal" },
        { "default:gold_ingot",   "default:diamond",    "default:gold_ingot" },
        { "default:mese_crystal", "default:gold_ingot", "default:mese_crystal" },
    }
})

minetest.register_craft({
    output = "eqex:philosophers_stone",
    type = "shaped",
    recipe = {
        { "default:gold_ingot",   "default:mese_crystal", "default:gold_ingot" },
        { "default:mese_crystal", "default:diamond",      "default:mese_crystal" },
        { "default:gold_ingot",   "default:mese_crystal", "default:gold_ingot" },
    }
})
