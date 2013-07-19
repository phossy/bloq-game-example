-- define a simple iterator to be used on array-like tables
function list_iter(t)
    local i = 0
    local n = table.getn(t)
    return function()
        i = i + 1
        if i <= n then return t[i] end
    end
end

-- using the above, is v a member of t?
function table.contains(t, v)
    for i in list_iter(t) do
        if v == i then
            return true
        end
    end
    return false
end

-- vardump that understands userdata and metatables
__vardump_printed = {}
function vardump(e, depth, maxrec)
	if depth == nil then
		depth = 0
	end
	if maxrec == nil then
		maxrec = 10
	end
    -- bail if we are getting into an infinitely recursive loop
    if depth >= maxrec then
        io.write('** recursion **')
        return
    end

    -- we've already seen this
    if (type(e) == 'function' or type(e) == 'table' or type(e) == 'userdata') and table.contains(__vardump_printed, e) then
        io.write('[' .. tostring(e) .. ']')
        return
    end

    -- nil
    if e == nil then
        io.write('nil')
        return
    end
    table.insert(__vardump_printed, e)

    -- table
    if type(e) == 'table' then
        io.write(tostring(e) .. ' {\n')
        for k, v in pairs(e) do
            io.write(string.rep('  ', depth))
            dumpvar(k, depth+1, maxrec)
            -- special case where key is a table/userdata and has a metatable
            if type(k) == 'table' or type(k) == 'userdata' then
                local mt = getmetatable(k)
                if mt ~= nil then
                    io.write('<KEY HAS METATABLE> ')
                    dumpvar(mt, depth+1, maxrec)
                end
            end
            io.write(' = ')
            dumpvar(v, depth+1, maxrec)
            io.write('\n')
        end
    elseif type(e) == 'string' then
        io.write('"' .. tostring(e) .. '"')
    else
        io.write(tostring(e))
    end

    if depth == 0 then
        io.write('\n')
    end

    if type(e) == 'table' or type(e) == 'userdata' then
        -- write the metatable
        local mt = getmetatable(e)
        if mt ~= nil then
            if depth > 0 then
                io.write(string.rep('  ', depth))
            end
            io.write('<METATABLE> ')
            dumpvar(mt, depth+1, maxrec)
            io.write('\n')
        end
    end

    if type(e) == 'table' then
        io.write(string.rep('  ', depth-1))
        io.write('}')
    end
end

-- a way to upcast a class instance by changing its metatable
-- I'm not sure what effect this may have on reference counting, gc, etc.
-- and ideally we would just make the lua wrapper more type-aware
function cast(class, obj)
    local mt = getmetatable(class)
    debug.setmetatable(obj, mt.__class)
    return obj
end
