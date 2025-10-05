-- npc.lua
local NPC = {}

NPC.list = {
    {name = "Budi", x = 220, y = 160, radius = 14, dialog = {"Halo!", "Mau ngopi?"}, idx = 1},
    {name = "Siti", x = 520, y = 120, radius = 14, dialog = {"Ada promo hari ini!", "Yuk nongkrong!"}, idx = 1},
    {name = "Iwan", x = 300, y = 420, radius = 14, dialog = {"Cuaca enak nih", "Main yuk!"}, idx = 1},
}

function NPC:update(dt)
    -- contoh: animasi kecil atau patrol bisa ditambahkan
    -- sekarang NPC statis
end

function NPC:draw()
    for _, n in ipairs(self.list) do
        love.graphics.setColor(0.8, 0.2, 0.2)
        love.graphics.circle("fill", n.x, n.y, n.radius)
        love.graphics.setColor(1,1,1)
        love.graphics.print(n.name, n.x - 18, n.y + 18)
    end
end

function NPC:getNearby(px, py, maxdist)
    maxdist = maxdist or 32
    for _, n in ipairs(self.list) do
        local dx = px - n.x
        local dy = py - n.y
        if (dx*dx + dy*dy) <= (maxdist * maxdist) then
            return n
        end
    end
    return nil
end

function NPC:getDialog(n)
    if not n then return nil end
    local s = n.dialog[n.idx]
    n.idx = n.idx + 1
    if n.idx > #n.dialog then n.idx = 1 end
    return s
end

return NPC
