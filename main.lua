-- main.lua
local Map = require("map")

print("Program dimulai...")

-- player
local player = {nama = "Ram", x = 0, y = 0, lokasi = "Spawn Point"}

-- fungsi untuk pindah lokasi
local function pindahLokasi(namaLokasi)
  local tujuan = Map.cariLokasi(namaLokasi)
  if tujuan then
    player.x = tujuan.x
    player.y = tujuan.y
    player.lokasi = tujuan.nama
    print("🚶 " .. player.nama .. " pindah ke " .. tujuan.nama)
  else
    print("❌ Lokasi '" .. namaLokasi .. "' tidak ditemukan.")
  end
end

-- tampilkan posisi player
local function tampilkanPosisi()
  print("📍 Lokasi saat ini: " .. player.lokasi .. " (x: " .. player.x .. ", y: " .. player.y .. ")")
end

-- main loop sederhana
while true do
  tampilkanPosisi()
  print("Ketik nama lokasi (Spawn Point, Market, Forest, Mountain) atau 'exit':")
  local input = io.read()
  if input == "exit" then
    print("👋 Keluar dari game.")
    break
  end
  pindahLokasi(input)
end
