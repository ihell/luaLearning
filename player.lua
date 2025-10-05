-- player.lua
local player = {
    x = 400,
    y = 300,
    speed = 180,
    radius = 16,
    color = {1, 1, 0}, -- default kuning
    hat = false, -- topi off
    name = "Player"
}

function player:update(dt)
    if love.keyboard.isDown("w") then
        self.y = self.y - self.speed * dt
    end
    if love.keyboard.isDown("s") then
        self.y = self.y + self.speed * dt
    end
    if love.keyboard.isDown("a") then
        self.x = self.x - self.speed * dt
    end
    if love.keyboard.isDown("d") then
        self.x = self.x + self.speed * dt
    end
end

function player:draw()
    love.graphics.setColor(self.color)
    love.graphics.circle("fill", self.x, self.y, self.radius)
    -- topi: gambar lingkaran kecil di atas kepala
    if self.hat then
        love.graphics.setColor(0.1, 0.1, 0.1)
        love.graphics.rectangle("fill", self.x - 12, self.y - self.radius - 8, 24, 6)
    end
    -- nama
    love.graphics.setColor(1,1,1)
    love.graphics.print(self.name, self.x - 20, self.y + 22)
end

function player:toggleHat()
    self.hat = not self.hat
end

function player:setColor(r,g,b)
    self.color = {r,g,b}
end

return player
