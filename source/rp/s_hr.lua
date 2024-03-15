local iconUrl = "YOUR_ICON_URL" -- Replace with your icon URL

RegisterCommand("hr", function(source, args, rawCommand)
    local targetId = tonumber(args[1])

    if not targetId then
       -- TriggerClientEvent("chatMessage", source, "Error", {255, 0, 0}, "Usage: /hr [id]")
        sendErrorMessage(source, "Usage: /hr [id]")
        return
    end

    local targetPlayer = tonumber(args[1])
    local sourcePlayer = source
    local targetHealth = GetEntityHealth(GetPlayerPed(targetPlayer))
    local heartRate = targetHealth >= 70 and math.floor(60 + (targetHealth - 70) * 0.4) or math.random(40, 70)
    local textColor = heartRate >= 70 and {0, 255, 0} or {255, 165, 0}
    local message = string.format("Player ID: %d - BPM: %d", targetId, heartRate)

    TriggerClientEvent("chatMessage", -1, "System", textColor, message)
    TriggerClientEvent("chat:addMessage", -1, {
        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(0, 0, 0, 0.8); border-radius: 15px; max-width: 80vw; overflow-wrap: break-word; word-wrap: break-word; word-break: break-all;">' ..
                   '<img src="' .. iconUrl .. '" style="max-width: 30px; height: auto; margin-right: 10px;">' ..
                   '{0}' ..
                   '</div>',
        args = {message}
    })

    TriggerClientEvent("startCPRAnimation", sourcePlayer)

    if targetHealth < 10 then
        TriggerClientEvent("startNotepadAnimation", sourcePlayer)
    end
end, false)

RegisterCommand("removeallweapons", function(source, args, rawCommand)
    local targetId = tonumber(args[1])

    if not targetId then
        TriggerEvent("chatMessage", "SYSTEM", {255, 0, 0}, "Usage: /removeallweapons [playerId]")
        sendErrorMessage(source, "Usage: /removeallweapons [playerId]")
        return
    end

    local targetPlayer = tonumber(args[1])
    local targetPed = GetPlayerPed(targetPlayer)

    if DoesEntityExist(targetPed) then
        RemoveAllPedWeapons(targetPed, true)
        local playerName = GetPlayerName(targetPlayer)
        local identifier = GetPlayerIdentifier(targetPlayer, 0)
        sendSuccessMessage(source, "All weapons have been removed from the Target Player")
        TriggerEvent("chatMessage", "SYSTEM", {0, 255, 0}, "Player " .. playerName .. " has identifier: " .. identifier)
    else
        sendErrorMessage(source, "That player ID was not found.")
    end
end, false)