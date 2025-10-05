local player = require("player")
local world = require("world")

function love.load()
    love.window.setTitle("Indo Hangout Prototype - ASDW Movement")
    love.window.setMode(800, 600)
end

function love.update(dt)
    player:update(dt)
end

function love.draw()
    world:draw(player.x, player.y)
    player:draw()
end
