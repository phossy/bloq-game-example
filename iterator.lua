-- define a simple iterator to be used on array-like tables

function list_iter(t)
    local i = 0
    local n = table.getn(t)
    return function()
        i = i + 1
        if i <= n then return t[i] end
    end
end

