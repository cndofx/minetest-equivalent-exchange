eqex.emc = {}
eqex.emc.defaults = {
    ["default:dirt"] = 1,
    ["default:dirt_with_coniferous_litter"] = 1,
    ["default:dirt_with_rainforest_litter"] = 1,
    ["default:dirt_with_dry_grass"] = 1,
    ["default:dirt_with_grass"] = 1,
    ["default:dirt_with_snow"] = 1,
    ["default:dry_dirt"] = 1,
    ["default:dry_dirt_with_dry_grass"] = 1,
    ["default:permafrost"] = 1,
    ["default:permafrost_with_moss"] = 1,
    ["default:permafrost_with_stones"] = 1,
    ["default:stone"] = 1,
    ["default:cobble"] = 1,
    ["default:mossycobble"] = 9,
    ["default:desert_cobble"] = 1,
    ["default:sand"] = 1,
    ["default:silver_sand"] = 1,
    ["default:desert_sand"] = 1,
    ["default:sand_with_kelp"] = 1,
    ["default:snow"] = 1,
    ["default:ice"] = 1,
    ["default:gravel"] = 4,
    ["default:flint"] = 4,
    ["default:clay"] = 64,
    ["default:obsidian"] = 64,

    ["default:fern_1"] = 1,
    ["default:grass_1"] = 1,
    ["default:dry_grass_1"] = 1,
    ["default:dry_shrub"] = 1,
    ["default:junglegrass"] = 1,
    ["default:marram_grass_1"] = 1,

    ["default:tree"] = 32,
    ["default:acacia_tree"] = 32,
    ["default:aspen_tree"] = 32,
    ["default:pine_tree"] = 32,
    ["default:jungletree"] = 32,
    ["default:sapling"] = 32,
    ["default:acacia_sapling"] = 32,
    ["default:aspen_sapling"] = 32,
    ["default:pine_sapling"] = 32,
    ["default:junglesapling"] = 32,
    ["default:emergent_jungle_sapling"] = 32,

    ["default:cactus"] = 8,
    ["default:papyrus"] = 32,
    ["default:apple"] = 128,
    ["default:coral_brown"] = 16,
    ["default:coral_cyan"] = 16,
    ["default:coral_green"] = 16,
    ["default:coral_orange"] = 16,
    ["default:coral_pink"] = 16,
    ["default:coral_skeleton"] = 8,

    ["default:copper_ingot"] = 128,
    ["default:tin_ingot"] = 128,
    ["default:steel_ingot"] = 256,
    ["default:mese_crystal"] = 512,
    ["default:gold_ingot"] = 2048,
    ["default:diamond"] = 8192,

    -- hopefully temporary values
    -- need to find a way to subtract replacement value from item emc
    ["default:coal_lump"] = 128,
    ["eqex:alchemical_coal"] = 512,
    ["eqex:mobius_fuel"] = 2048,
    ["eqex:aeternalis_fuel"] = 8192,
}
eqex.emc.cache = {}

function eqex.emc.get_emc_for(itemstring)
    local path = {}
    return eqex.emc._get_emc_for(itemstring, path)
end

function eqex.emc._get_emc_for(itemstring, path)
    -- print("getting emc for '" .. itemstring .. "'")

    -- check if this is a group
    local group_prefix = "group:"
    if itemstring:sub(1, #group_prefix) == group_prefix then
        -- print("'" .. itemstring .. "' is a group")
        local emc = eqex.emc._get_emc_for_group(itemstring, path)
        -- print("got " .. emc .. " emc for group " .. itemstring)
        -- print("get_emc_for returning: " .. emc)
        return emc
    end

    -- make sure this item exists
    if minetest.registered_items[itemstring] == nil then
        -- print("item '" .. itemstring .. "' does not exist")
        -- print("get_emc_for returning: -1")
        return -1
    end

    -- check if this item has a cached emc value
    if eqex.emc.cache[itemstring] ~= nil then
        -- print("emc value found in cache")
        local emc = eqex.emc.cache[itemstring]
        -- print("get_emc_for returning: " .. emc)
        return emc
    end

    -- check if this item has a custom emc value
    -- not yet implemented
    for _, key in ipairs(eqex.storage:get_keys()) do
        if key == eqex.storage_custom_emc_prefix .. itemstring then
            -- print("custom emc found in storage")
            local emc = eqex.storage:get_int(key)
            -- print("get_emc_for returning: " .. emc)
            eqex.emc.cache[itemstring] = emc
            return emc
        end
    end

    -- check if this item has a default emc value
    if eqex.emc.defaults[itemstring] ~= nil then
        -- print("emc value found in defaults")
        local emc = eqex.emc.defaults[itemstring]
        -- print("get_emc_for returning: " .. emc)
        eqex.emc.cache[itemstring] = emc
        return emc
    end

    -- no emc found, calculate from crafting components

    -- print("current path:")
    -- for _, pathitem in ipairs(path) do
    --     print(pathitem)
    -- end
    -- print("end current path")

    -- make sure the current item wasnt visited earlier in the path
    for _, pathitem in ipairs(path) do
        if pathitem == itemstring then
            -- print("loop detected, returning -1")
            return -1
        end
    end

    -- add the current item to the path
    -- print("adding to path: " .. itemstring)
    path[#path + 1] = itemstring

    -- for every recipe that creates this item,
    -- sum up the value of the ingredients and choose the lowest one (that isnt -1)
    local lowest_total_emc = -1
    local recipes = minetest.get_all_craft_recipes(itemstring)
    if recipes ~= nil then
        for _, recipe in ipairs(recipes) do
            -- print("recipe:\n" .. dump(recipe))
            local total_emc = 0
            local all_ingredients_have_emc = true
            for _, ingredient in pairs(recipe.items) do
                -- print("ingredient: " .. ingredient)
                local emc = eqex.emc._get_emc_for(ingredient, path)
                if emc > 0 then
                    total_emc = total_emc + emc
                elseif emc < 0 then
                    all_ingredients_have_emc = false
                end
                -- if emc is zero then it just wont be considered
            end


            -- ======================

            -- print("recipe:")
            -- print(dump(recipe))

            -- subtract repacements value from the total emc
            -- local craft_result = minetest.get_craft_result({
            --     method = "normal",
            --     width = recipe.width,
            --     items = recipe.items
            -- })
            -- print("craft result:")
            -- print(dump(craft_result))

            -- ======================

            -- print(dump(recipe.replacements))
            -- if recipe.replacements ~= nil then
            --     print(itemstring .. " has replacements!")
            --     for _, replacement in ipairs(recipe.replacements) do
            --         print("replacement: " .. replacement)
            --         local item = replacement[2]
            --         local emc = eqex.emc.get_emc_for(item)
            --         total_emc = total_emc - emc
            --     end
            -- end

            -- divide emc by the output count of this recipe
            -- count will be the number after a space
            local split_output = util.mystrsplit(recipe.output, "%s")
            if split_output[2] ~= nil then
                local count = tonumber(split_output[2])
                -- no floor division operator in this version it seems :(
                -- total_emc = total_emc // count
                total_emc = math.floor(total_emc / count)
            end

            -- print("all_ingredients_have_emc: " .. dump(all_ingredients_have_emc))
            -- print("total_emc: " .. total_emc)
            if all_ingredients_have_emc and total_emc > 0 and (total_emc < lowest_total_emc or lowest_total_emc == -1) then
                -- print("condition passed")
                lowest_total_emc = total_emc
            end
        end
    end

    -- remove the current item from the path
    -- print("removing from path: " .. path[#path])
    path[#path] = nil


    -- print("get_emc_for returning: " .. lowest_total_emc)
    eqex.emc.cache[itemstring] = lowest_total_emc
    return lowest_total_emc
end

function eqex.emc._get_emc_for_group(group, path)
    group = group:gsub("group:", "")
    -- print("getting emc for group " .. group)
    -- get all items in this group
    local items = {}
    for itemstring, def in pairs(minetest.registered_items) do
        if def.groups[group] ~= nil then
            items[#items + 1] = itemstring
        end
    end

    -- print("group contains items:")
    -- for _, item in ipairs(items) do
    --     print(item)
    -- end

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
    -- set emc values and tooltips on all items
    for itemstring, def in pairs(minetest.registered_items) do
        local emc = eqex.emc.get_emc_for(itemstring)
        if emc ~= -1 then
            local emc = util.format_int(emc)
            local desc = "\nEMC: " .. emc
            desc = minetest.colorize("#FFFF00", desc)
            desc = def.description .. desc
            minetest.override_item(itemstring, {
                _eqex_emc = emc,
                description = desc,
            })
        end
    end
end

minetest.register_on_mods_loaded(init_emc)