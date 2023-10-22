minetest.register_chatcommand("debug_dump_items", {
    description = "Dump all itemstrings to stdout",
    func = function(name)
        for itemstring, def in pairs(minetest.registered_items) do
            print(itemstring)
        end
    end
})

minetest.register_chatcommand("debug_dump_recipes", {
    description = "Dump all recipes to stdout in JSON format",
    func = function(name)
        for itemstring, def in pairs(minetest.registered_items) do
            local recipes = minetest.get_all_craft_recipes(itemstring)
            if recipes ~= nil then
                for i, recipe in ipairs(recipes) do
                    print(minetest.write_json(recipe))
                end
            end
        end
    end
})

minetest.register_chatcommand("debug_calculate_emc", {
    description = "Calculate the EMC value of the given item",
    params = "<item>",
    func = function(name, params)
        if minetest.registered_items[params] ~= nil then
            local emc = eqex.emc.get_emc_for(params)
            local message
            if emc ~= nil then
                message = "get_emc_for(" .. params .. ") returned: " .. emc
            else
                message = "get_emc_for(" .. params .. ") returned: nil"
            end
            print(message)
            minetest.chat_send_player(name, message)
        else
            minetest.chat_send_player(name, "Item '" .. params .. "' does not exist!")
        end
    end
})

minetest.register_chatcommand("debug_get_items_in_group", {
    description = "Lists all items in the given group",
    params = "<group>",
    func = function(name, params)
        local group = params:gsub("group:", "")
        minetest.chat_send_player(name, "Items in group '" .. group .. "':")
        for itemstring, def in pairs(minetest.registered_items) do
            if def.groups[group] ~= nil then
                minetest.chat_send_player(name, itemstring)
            end
        end
    end
})
