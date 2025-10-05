-- map.lua
local Map = {}

Map.lokasi = {
  {nama = "Spawn Point", x = 0, y = 0},
  {nama = "Market", x = 10, y = 5},
  {nama = "Forest", x = -5, y = 12},
  {nama = "Mountain", x = 20, y = 20}
}

function Map.cariLokasi(nama)
  for _, lokasi in ipairs(Map.lokasi) do
    if lokasi.nama == nama then
      return lokasi
    end
  end
  return nil
end

return Map
