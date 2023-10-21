function DoFile(path)
    local modpath = minetest.get_modpath("eqex")
    return dofile(modpath .. path)
end

eqex = {}

DoFile("/src/init.lua")
