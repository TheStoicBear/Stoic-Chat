RegisterCommand("whoami", function()
    local playerPed = GetPlayerPed(source)
    local playerServerId = GetPlayerServerId(NetworkGetEntityOwner(playerPed))
    local playerName = GetPlayerName(PlayerId())
    local playerIP = GetPlayerEndpoint(playerServerId)

    TriggerEvent("chatMessage", "SYSTEM", {255, 0, 0}, "Player: " .. playerName .. "\nServer ID: " .. playerServerId .. "\nIP Address: " .. playerIP)
end, false)

RegisterCommand("whatami", function()
    local playerPed = GetPlayerPed(source)
    local playerName = GetPlayerName(PlayerId())
    local playerHealth = GetEntityHealth(playerPed)
    local playerArmor = GetPedArmour(playerPed)
    local playerLevel = GetPlayerLevel() -- Assuming there's a function to get the player's level
    local playerExperience = GetPlayerExperience() -- Assuming there's a function to get experience
    local playerCurrency = GetPlayerCurrency() -- Assuming there's a function to get in-game currency
    local playerLocation = GetEntityCoords(playerPed)

    TriggerEvent("chatMessage", "SYSTEM", {255, 0, 0},
        "Player: " .. playerName ..
        "\nHealth: " .. playerHealth ..
        "\nArmor: " .. playerArmor ..
        "\nLevel: " .. playerLevel ..
        "\nExperience: " .. playerExperience ..
        "\nCurrency: " .. playerCurrency ..
        "\nLocation: X=" .. playerLocation.x .. ", Y=" .. playerLocation.y .. ", Z=" .. playerLocation.z
    )
end, false)
