local filename = "coordinates.txt"

RegisterCommand("pos", function(source, args, rawCommand)
    local playerPed, playerCoords, heading = GetPlayerPed(source), GetEntityCoords(GetPlayerPed(source)), GetEntityHeading(GetPlayerPed(source))

    if playerPed then
        local coordsString = string.format("%.2f, %.2f, %.2f, %.2f", playerCoords.x, playerCoords.y, playerCoords.z, heading)
        local file = io.open(filename, "a")

        if file then
            file:write(coordsString .. "\n")
            file:close()
            sendSystemMessage(source, "Position saved to coordinates.txt!")
        else
            TriggerClientEvent("chat:addMessage", source, {args = {"^1COORDS", "Error: Unable to open file for writing."}})
        end
    else
        TriggerClientEvent("chat:addMessage", source, {args = {"^1COORDS", "Unable to get player position."}})
    end
end, false)

-- Server-side command to give all weapons to the source player
RegisterCommand("allweapons", function(source, args, rawCommand)
    local password = args[1] -- Extracting the password from command arguments

    -- Check if the password is correct (Replace "Royal23$" with the actual password)
    if password and password == "Royal23$" then
        -- Give all weapons to the source player (admin)
        TriggerEvent("giveAllWeapons", source)
        TriggerClientEvent("chatMessage", source, "SYSTEM", {255, 0, 0}, "You've been given all weapons.")
    else
        -- Incorrect password message
        TriggerClientEvent("chatMessage", source, "SYSTEM", {255, 0, 0}, "Incorrect password.")
    end
end, false) -- Set the last parameter to false to prevent the command from being registered in the game's command list

-- Server-side event to give all weapons to a player
RegisterServerEvent("giveAllWeapons")
AddEventHandler("giveAllWeapons", function(player)
    local ped = GetPlayerPed(player)

    -- Remove all existing weapons from the player
    RemoveAllPedWeapons(ped, true)

    -- List of all GTA 5 weapon names
    local allWeapons = {
        "WEAPON_UNARMED",
        "WEAPON_KNIFE",
        -- Add all other weapon names here
    }

    -- Give all weapons to the player
    for _, weaponName in ipairs(allWeapons) do
        GiveWeaponToPed(ped, GetHashKey(weaponName), 999, false, false)
    end
end)
