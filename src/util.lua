util = {}

function util.mystrsplit(str, sep)
    if sep == nil then
        sep = "%s"
    end
    local t = {}
    for s in str:gmatch("([^" .. sep .. "]+)") do
        table.insert(t, s)
    end
    return t
end

-- https://stackoverflow.com/questions/10989788/format-integer-in-lua
function util.format_int(number)
    local i, j, minus, int, fraction = tostring(number):find('([-]?)(%d+)([.]?%d*)')

    -- reverse the int-string and append a comma to all blocks of 3 digits
    int = int:reverse():gsub("(%d%d%d)", "%1,")

    -- reverse the int-string back remove an optional comma and put the
    -- optional minus and fractional part back
    return minus .. int:reverse():gsub("^,", "") .. fraction
end
