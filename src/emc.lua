eqex.emc = {}
eqex.emc.defaults = {
    ["default:dirt"] = 1,
    ["default:stone"] = 1,
    ["default:cobble"] = 1,
    ["default:gravel"] = 4,

    ["default:diamond"] = 8192,
}
eqex.emc.cache = {}

function eqex.emc.get_emc_for(itemstring)
    local path = {}
    return eqex.emc._get_emc_for(itemstring, path)
end

function eqex.emc._get_emc_for(itemstring, path)
    print("getting emc for '" .. itemstring .. "'")

    -- check if this is a group
    local group_prefix = "group:"
    if itemstring:sub(1, #group_prefix) == group_prefix then
        print("'" .. itemstring .. "' is a group")
        local emc = eqex.emc._get_emc_for_group(itemstring, path)
        print("got " .. emc .. " emc for group " .. itemstring)
        print("get_emc_for returning: " .. emc)
        return emc
    end

    -- make sure this item exists
    if minetest.registered_items[itemstring] == nil then
        print("item '" .. itemstring .. "' does not exist")
        print("get_emc_for returning: -1")
        return -1
    end

    -- check if this item has a cached emc value
    if eqex.emc.cache[itemstring] ~= nil then
        print("emc value found in cache")
        local emc = eqex.emc.cache[itemstring]
        print("get_emc_for returning: " .. emc)
        return emc
    end

    -- check if this item has a custom emc value
    -- not yet implemented

    -- check if this item has a default emc value
    if eqex.emc.defaults[itemstring] ~= nil then
        print("emc value found in defaults")
        local emc = eqex.emc.defaults[itemstring]
        print("get_emc_for returning: " .. emc)
        eqex.emc.cache[itemstring] = emc
        return emc
    end

    -- no emc found, calculate from crafting components

    print("current path:")
    for _, pathitem in ipairs(path) do
        print(pathitem)
    end
    print("end current path")

    -- make sure the current item wasnt visited earlier in the path
    for _, pathitem in ipairs(path) do
        if pathitem == itemstring then
            print("loop detected, returning -1")
            return -1
        end
    end

    -- add the current item to the path
    print("adding to path: " .. itemstring)
    path[#path + 1] = itemstring

    local lowest_total_emc = -1
    local recipes = minetest.get_all_craft_recipes(itemstring)
    if recipes ~= nil then
        for _, recipe in ipairs(recipes) do
            print("recipe:\n" .. dump(recipe))
            local total_emc = 0
            local all_ingredients_have_emc = true
            for _, ingredient in pairs(recipe.items) do
                print("ingredient: " .. ingredient)
                local emc = eqex.emc._get_emc_for(ingredient, path)
                if emc > 0 then
                    total_emc = total_emc + emc
                elseif emc < 0 then
                    all_ingredients_have_emc = false
                end
                -- if emc is zero then it just wont be considered
            end

            -- todo: subtract repacements value from the total emc
            -- todo: divide emc by the output count of this recipe

            print("all_ingredients_have_emc: " .. dump(all_ingredients_have_emc))
            print("total_emc: " .. total_emc)
            if all_ingredients_have_emc and total_emc > 0 and (total_emc < lowest_total_emc or lowest_total_emc == -1) then
                print("condition passed")
                lowest_total_emc = total_emc
            end
        end
    end

    -- remove the current item from the path
    print("removing from path: " .. path[#path])
    path[#path] = nil


    print("get_emc_for returning: " .. lowest_total_emc)
    eqex.emc.cache[itemstring] = lowest_total_emc
    return lowest_total_emc
end

function eqex.emc._get_emc_for_group(group, path)
    group = group:gsub("group:", "")
    print("getting emc for group " .. group)
    -- get all items in this group
    local items = {}
    for itemstring, def in pairs(minetest.registered_items) do
        if def.groups[group] ~= nil then
            items[#items + 1] = itemstring
        end
    end

    print("group contains items:")
    for _, item in ipairs(items) do
        print(item)
    end

    -- get the lowest emc value that is not -1
    local lowest_emc = -1
    for _, itemstring in ipairs(items) do
        local emc = eqex.emc._get_emc_for(itemstring, path)
        if emc > 0 and (emc < lowest_emc or lowest_emc == -1) then
            lowest_emc = emc
        end
    end

    return lowest_emc
end

local function init_emc()
    print("unimplemented")
end

minetest.register_on_mods_loaded(init_emc)
