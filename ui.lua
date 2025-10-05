-- ui.lua
local UI = {}
UI.messages = {}      -- chat messages lokal
UI.input = ""         -- input sementara
UI.focus = false
UI.lastFetch = 0
UI.fetchInterval = 1.0 -- detik polling
UI.npcMessage = nil
UI.npcTimer = 0

function UI:draw()
    -- area chat di kanan bawah
    local sw, sh = love.graphics.getDimensions()
    local chatW, chatH = 300, 200
    local x = sw - chatW - 10
    local y = sh - chatH - 10

    love.graphics.setColor(0, 0, 0, 0.6)
    love.graphics.rectangle("fill", x, y, chatW, chatH)
    love.graphics.setColor(1,1,1)
    -- tampilkan beberapa pesan terakhir
    local start = math.max(1, #self.messages - 8)
    local yy = y + 10
    for i = start, #self.messages do
        local m = self.messages[i]
        love.graphics.print(m.author .. ": " .. m.text, x + 8, yy)
        yy = yy + 18
    end

    -- input box
    love.graphics.setColor(1,1,1)
    love.graphics.rectangle("line", x, y + chatH - 34, chatW-20, 24)
    love.graphics.print(self.input, x + 6, y + chatH - 32)

    -- tombol customisasi kecil (topi + warna)
    love.graphics.print("T: Toggle Hat  |  1/2/3: Color", 10, love.graphics.getHeight() - 20)

    -- npc dialog popup
    if self.npcMessage then
        love.graphics.setColor(0,0,0,0.7)
        love.graphics.rectangle("fill", 10, 40, 300, 28)
        love.graphics.setColor(1,1,1)
        love.graphics.print(self.npcMessage, 16, 44)
    end
end

function UI:update(dt)
    if self.npcMessage then
        self.npcTimer = self.npcTimer - dt
        if self.npcTimer <= 0 then
            self.npcMessage = nil
        end
    end
end

function UI:pushMessage(m)
    table.insert(self.messages, m)
    -- jaga panjang array
    if #self.messages > 200 then
        table.remove(self.messages, 1)
    end
end

function UI:showNPCMessage(text, t)
    self.npcMessage = text
    self.npcTimer = t or 3
end

return UI
