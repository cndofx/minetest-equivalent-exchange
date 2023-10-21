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
