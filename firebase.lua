-- firebase.lua
local http = require("socket.http")
local ltn12 = require("ltn12")
local json = require("dkjson")
local Env = require("env")

-- Load variabel dari .env
local env = Env.load()
local Firebase = {}

Firebase.DB_URL = env.FIREBASE_DB_URL or "https://your-default.firebaseio.com"

function Firebase:sendMessage(author, text)
    local payload = { author = author, text = text, ts = os.time() }
    local body = json.encode(payload)
    local response_body = {}
    local res, code, headers, status = http.request{
        url = self.DB_URL .. "/messages.json",
        method = "POST",
        headers = {
            ["Content-Type"] = "application/json",
            ["Content-Length"] = tostring(#body)
        },
        source = ltn12.source.string(body),
        sink = ltn12.sink.table(response_body),
        timeout = 5
    }
    return res, code, table.concat(response_body)
end

function Firebase:getMessages()
    local response_body = {}
    local res, code, headers, status = http.request{
        url = self.DB_URL .. "/messages.json",
        method = "GET",
        sink = ltn12.sink.table(response_body),
        timeout = 5
    }
    if not res or code ~= 200 then
        return nil, code
    end
    local body = table.concat(response_body)
    local data, pos, err = json.decode(body, 1, nil)
    if err then
        return nil, err
    end

    local list = {}
    if data then
        for k, v in pairs(data) do
            table.insert(list, {id = k, author = v.author, text = v.text, ts = v.ts})
        end
        table.sort(list, function(a,b) return (a.ts or 0) < (b.ts or 0) end)
    end
    return list
end

return Firebase
