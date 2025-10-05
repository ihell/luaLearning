-- main.lua
local player = require("player")
local world = require("world")
local NPC = require("npc")
local UI = require("ui")
local Firebase = require("firebase")

local lastFetch = 0
local fetchInterval = 1.0 -- detik

function love.load()
    love.window.setTitle("Indo Hangout - Net Prototype")
    love.window.setMode(900, 600)
    math.randomseed(os.time())
    -- optional: set player name from prompt
    player.name = "Rama" -- ubah sesuai
end

function love.update(dt)
    player:update(dt)
    NPC:update(dt)
    UI:update(dt)

    -- cek apakah ada NPC di dekat player
    local near = NPC:getNearby(player.x, player.y, 32)
    if near then
        -- tampilkan prompt
        UI:showNPCMessage("Tekan E untuk ngobrol dengan " .. near.name, 0.5)
    end

    -- polling Firebase messages
    lastFetch = lastFetch + dt
    if lastFetch >= fetchInterval then
        lastFetch = 0
        -- panggil async-ish: kita jalankan blocking HTTP (sederhana)
        local msgs, err = Firebase:getMessages()
        if msgs and type(msgs) == "table" then
            -- replace UI messages (simple)
            UI.messages = {}
            for _, m in ipairs(msgs) do
                UI:pushMessage({author = m.author or "?", text = m.text or ""})
            end
        else
            -- ignore error untuk prototipe
        end
    end
end

function love.draw()
    world:draw(player.x, player.y)
    NPC:draw()
    player:draw()
    UI:draw()
end

function love.textinput(t)
    -- jika fokus di input chat (sederhana selalu aktif)
    UI.input = UI.input .. t
end

function love.keypressed(key)
    if key == "backspace" then
        local byteoffset = utf8.offset(UI.input, -1)
        if byteoffset then
            UI.input = string.sub(UI.input, 1, byteoffset - 1)
        end
    elseif key == "return" or key == "kpenter" then
        local text = UI.input:gsub("^%s*(.-)%s*$", "%1")
        if text ~= "" then
            -- kirim ke firebase
            local ok, code = Firebase:sendMessage(player.name, text)
            -- tambahkan lokal juga biar cepat muncul
            UI:pushMessage({author = player.name, text = text})
            UI.input = ""
        end
    elseif key == "e" then
        -- interaksi NPC / duduk
        local near = NPC:getNearby(player.x, player.y, 32)
        if near then
            local dialog = NPC:getDialog(near)
            if dialog then UI:showNPCMessage(near.name .. ": " .. dialog, 3) end
        else
            local idx, seat = world:findNearbySeat(player.x, player.y, 24)
            if idx then
                seat.used = true
                player.x = seat.x
                player.y = seat.y - 10
                UI:showNPCMessage("Kamu duduk.", 2)
            end
        end
    elseif key == "t" then
        player:toggleHat()
    elseif key == "1" then
        player:setColor(1, 0.6, 0) -- orange
    elseif key == "2" then
        player:setColor(0.2, 0.8, 0.2) -- green
    elseif key == "3" then
        player:setColor(0.4, 0.6, 1) -- blue
    end
end
