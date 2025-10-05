-- env.lua
local Env = {}

function Env.load(path)
    path = path or ".env"
    local file = io.open(path, "r")
    if not file then return {} end

    local vars = {}
    for line in file:lines() do
        local key, value = line:match("^(%w+)%s*=%s*(.+)$")
        if key and value then
            vars[key] = value
        end
    end
    file:close()
    return vars
end

return Env
