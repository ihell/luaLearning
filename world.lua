local world = {
    zones = {
        { name = "Spawn",   x = 0,   y = 0,   w = 400, h = 300, color = {0.2, 0.4, 0.8} },
        { name = "Market",  x = 400, y = 0,   w = 400, h = 300, color = {0.3, 0.6, 0.3} },
        { name = "Forest",  x = 0,   y = 300, w = 400, h = 300, color = {0.1, 0.5, 0.1} },
        { name = "Beach",   x = 400, y = 300, w = 400, h = 300, color = {0.9, 0.8, 0.3} },
    }
}

function world:getCurrentZone(px, py)
    for _, zone in ipairs(self.zones) do
        if px > zone.x and px < zone.x + zone.w and py > zone.y and py < zone.y + zone.h then
            return zone
        end
    end
    return nil
end

function world:draw(px, py)
    for _, zone in ipairs(self.zones) do
        love.graphics.setColor(zone.color)
        love.graphics.rectangle("fill", zone.x, zone.y, zone.w, zone.h)
        love.graphics.setColor(1, 1, 1)
        love.graphics.print(zone.name, zone.x + 10, zone.y + 10)
    end

    local current = self:getCurrentZone(px, py)
    if current then
        love.graphics.print("Lokasi: " .. current.name, 10, 10)
    end
end

return world
