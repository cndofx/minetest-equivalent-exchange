util = {}

function util.mystrsplit(str, sep)
    print("splitting str: " .. str)
    if sep == nil then
        sep = "%s"
    end
    local t = {}
    for s in str:gmatch("([^" .. sep .. "]+)") do
        print("split part: " .. s)
        table.insert(t, s)
    end
    return t
end
