function DoFile(path)
    local modpath = minetest.get_modpath("eqex")
    return dofile(modpath .. path)
end

eqex = {}
eqex.storage = minetest.get_mod_storage()
eqex.storage_custom_emc_prefix = "custom_emc_"

DoFile("/src/init.lua")
