for _, path in ipairs(arg) do
    local handle=assert(io.open(path,"rb"))
    local source=handle:read("*a")
    handle:close()
    source=source:gsub("^\239\187\191", "")
    assert(loadstring(source,"@"..path))
end
