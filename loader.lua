local REPO      = "https://raw.githubusercontent.com/SupFr/Sup-dev/main/"
local TOKEN_FILE = "gh_token.txt"

local games = {
    [7856269159] = "AO.lua",
    [9739620371] = "Hyaku%20Asura.lua",
    [10004244222] = "KickALuckyBlock.lua",
    [8220767002] = "BeeGarden.lua",
    [7488190691] = "UTD_MacroHub.lua",
    [4509896324] = "ALS_MacroHub.lua",
    [6409513651] = "AnimeWarriorsIII.lua",
}

local fileName = games[game.GameId]
if not fileName then
    warn("Game ID: " .. tostring(game.GameId) .. " is not supported!")
    return
end

print("Hub Loading: " .. fileName:gsub("%%20", " "))

local ok, token = pcall(readfile, TOKEN_FILE)
if not ok or not token or token == "" then
    warn("gh_token.txt missing. Run once: writefile('gh_token.txt', 'your_pat')")
    return
end

local res = request({
    Url     = REPO .. fileName,
    Method  = "GET",
    Headers = { ["Authorization"] = "token " .. token:gsub("%s+", "") },
})

if res.StatusCode ~= 200 then
    warn("Failed to load script (HTTP " .. res.StatusCode .. "). Check token or repo.")
    return
end

loadstring(res.Body)()
