local supportedGames = {
    [7856269159] = "AO.lua",
    [9739620371] = "Hyaku%20Asura.lua" -- Notice the %20 here!
}

local currentPlace = game.GameId

if supportedGames[currentPlace] then
    local fileName = supportedGames[currentPlace]
    local url = "https://raw.githubusercontent.com/SupFr/Sup-Hub/main/" .. fileName
    
    print("Hub Loading: " .. string.gsub(fileName, "%%20", " ")) -- Cleans it up for the print statement
    
    -- Added a pcall just in case the link is ever dead, so it tells you instead of freezing
    local success, scriptContent = pcall(function()
        return game:HttpGet(url)
    end)
    
    if success and scriptContent then
        loadstring(scriptContent)()
    else
        warn("Failed to download the script. The GitHub link might be broken or updating!")
    end
else
    warn("Game ID: " .. tostring(currentPlace) .. " is not supported!")
end
