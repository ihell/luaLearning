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
end-- world.lua
local world = {
    zones = {
        { name = "Spawn",   x = 0,   y = 0,   w = 400, h = 300, color = {0.2, 0.4, 0.8} },
        { name = "Market",  x = 400, y = 0,   w = 400, h = 300, color = {0.3, 0.6, 0.3} },
        { name = "Forest",  x = 0,   y = 300, w = 400, h = 300, color = {0.1, 0.5, 0.1} },
        { name = "Beach",   x = 400, y = 300, w = 400, h = 300, color = {0.9, 0.8, 0.3} },
    },
    seats = {
        {x=200, y=250, used=false},
        {x=450, y=200, used=false},
        {x=350, y=500, used=false},
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

    -- gambar kursi/meja (seats)
    for _, s in ipairs(self.seats) do
        if s.used then
            love.graphics.setColor(0.6, 0.6, 0.6)
        else
            love.graphics.setColor(0.4, 0.2, 0.1)
        end
        love.graphics.rectangle("fill", s.x - 12, s.y - 8, 24, 16)
        love.graphics.setColor(1,1,1)
    end

    local current = self:getCurrentZone(px, py)
    if current then
        love.graphics.print("Lokasi: " .. current.name, 10, 10)
    end
end

function world:findNearbySeat(px, py, maxdist)
    maxdist = maxdist or 24
    for i, s in ipairs(self.seats) do
        local dx = px - s.x
        local dy = py - s.y
        if (dx*dx + dy*dy) <= (maxdist * maxdist) and (not s.used) then
            return i, s
        end
    end
    return nil
end

return world
-- world.lua
local world = {
    zones = {
        { name = "Spawn",   x = 0,   y = 0,   w = 400, h = 300, color = {0.2, 0.4, 0.8} },
        { name = "Market",  x = 400, y = 0,   w = 400, h = 300, color = {0.3, 0.6, 0.3} },
        { name = "Forest",  x = 0,   y = 300, w = 400, h = 300, color = {0.1, 0.5, 0.1} },
        { name = "Beach",   x = 400, y = 300, w = 400, h = 300, color = {0.9, 0.8, 0.3} },
    },
    seats = {
        {x=200, y=250, used=false},
        {x=450, y=200, used=false},
        {x=350, y=500, used=false},
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

    -- gambar kursi/meja (seats)
    for _, s in ipairs(self.seats) do
        if s.used then
            love.graphics.setColor(0.6, 0.6, 0.6)
        else
            love.graphics.setColor(0.4, 0.2, 0.1)
        end
        love.graphics.rectangle("fill", s.x - 12, s.y - 8, 24, 16)
        love.graphics.setColor(1,1,1)
    end

    local current = self:getCurrentZone(px, py)
    if current then
        love.graphics.print("Lokasi: " .. current.name, 10, 10)
    end
end

function world:findNearbySeat(px, py, maxdist)
    maxdist = maxdist or 24
    for i, s in ipairs(self.seats) do
        local dx = px - s.x
        local dy = py - s.y
        if (dx*dx + dy*dy) <= (maxdist * maxdist) and (not s.used) then
            return i, s
        end
    end
    return nil
end

return world


return world
