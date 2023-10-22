minetest.register_chatcommand("eqex_set_emc", {
    description = "Set the EMC value of the currently held item",
    params = "<emc>",
    func = function(name, params)
        local emc = tonumber(params)
        if emc ~= nil then
            local player = minetest.get_player_by_name(name)
            local itemstring = player:get_wielded_item():get_name()
            local notification = "EMC of '" .. itemstring .. "' set to " .. emc .. "! Reload the world to see changes."
            if itemstring ~= "" then
                local storage_key = eqex.storage_custom_emc_prefix .. itemstring
                eqex.storage:set_int(storage_key, emc)
                minetest.chat_send_player(name, notification)
            else
                minetest.chat_send_player(name, "You cannot set the EMC of nothing!")
            end
        else
            minetest.chat_send_player(name, "'" .. params .. "' is not a valid number.")
        end
    end
})

minetest.register_chatcommand("eqex_reset_emc", {
    description = "Reset the value of the currently held item to its default",
    func = function(name)
        local player = minetest.get_player_by_name(name)
        local itemstring = player:get_wielded_item():get_name()
        local storage_key = eqex.storage_custom_emc_prefix .. itemstring
        local notification = "Custom EMC removed from '" .. itemstring .. "'."
        eqex.storage:set_string(storage_key, "")
        minetest.chat_send_player(name, notification)
    end
})

minetest.register_chatcommand("eqex_reset_all", {
    description = "Reset ALL values in storage!",
    func = function(name)
        for _, key in ipairs(eqex.storage:get_keys()) do
            local notification = "Removing key '" .. key .. "' from storage."
            minetest.chat_send_player(name, notification)
            eqex.storage:set_string(key, "")
        end
    end
})

-- debug commands

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

minetest.register_chatcommand("debug_dump_emc_cache", {
    description = "Dump all cached EMC values to stdout",
    func = function(name)
        print(dump(eqex.emc.cache))
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
