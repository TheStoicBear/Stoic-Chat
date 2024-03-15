-- Fine Command Suggestion
TriggerEvent('chat:addSuggestion', '/fine', 'Fine a player', {
    { name = "ID", help = "the ID of the player you wish to fine." },
    { name = "amount", help = "what is the amount you would like to fine for?" },
    { name = "reason", help = "what is the reason for the fine?" }
})

-- Ticket Command Suggestion
TriggerEvent('chat:addSuggestion', '/ticket', 'Ticket a player', {
    { name = "ID", help = "the ID of the player you wish to ticket." },
    { name = "amount", help = "what is the amount you would like to ticket for?" },
    { name = "reason", help = "what is the reason for the ticket?" }
})

-- Parking Command Suggestion
TriggerEvent('chat:addSuggestion', '/parking', 'Issue a parking ticket to a player', {
    { name = "ID", help = "the ID of the player you wish to issue a parking ticket to." },
    { name = "amount", help = "what is the amount you would like to charge for the parking ticket?" },
    { name = "reason", help = "what is the reason for issuing the parking ticket?" }
})

-- Impound Command Suggestion
TriggerEvent('chat:addSuggestion', '/impound', 'Impound the closest vehicle in front of you', {
    { name = "none", help = "No arguments needed." }
})

-- Impound Vehicle Event
RegisterNetEvent('impoundVehicle')
AddEventHandler('impoundVehicle', function()
    local playerPed = PlayerPedId()
    local x, y, z = table.unpack(GetEntityCoords(playerPed, true))
    local radius = 5.0
    local modelHash = 0
    
    local closestVehicle = GetClosestVehicle(x, y, z, radius, modelHash, 127)
    
    if DoesEntityExist(closestVehicle) then
        ImpoundClosestVehicle(closestVehicle)
    else
        NotifyImpoundError("No vehicle found nearby.")
    end
end)

-- Function to impound the closest vehicle
function ImpoundClosestVehicle(vehicle)
    local impoundLocations = Settings.Impound.ImpoundLocations
    local randomLocationIndex = math.random(1, #impoundLocations)
    local impoundLocation = impoundLocations[randomLocationIndex]
    local impoundX, impoundY, impoundZ, impoundHeading = impoundLocation.X, impoundLocation.Y, impoundLocation.Z, impoundLocation.H

    local offset = 5.0
    local angle = math.rad(impoundHeading)

    local spawnX = impoundX + (offset * math.cos(angle))
    local spawnY = impoundY + (offset * math.sin(angle))
    local spawnZ = impoundZ
    
    SetEntityCoords(vehicle, spawnX, spawnY, spawnZ, true, true, true)
    SetEntityHeading(vehicle, impoundHeading)
    
    local title = "[Police] Impound"
    local message = "SUCCESS: The vehicle has been impounded."
    NotifyImpoundResult(title, message)
end

-- Function to notify impound result
function NotifyImpoundResult(title, message)
    if GetResourceState("ModernHUD") == "started" then
        NotifyWithModernHUD(title, message, "fa-solid fa-car-crash", "#FF0000")
    else
        TriggerEvent('chatMessage', title, { 255, 255, 255 }, message)
    end
end

-- Function to notify impound error
function NotifyImpoundError(message)
    local title = "[Police] Impound"
    NotifyImpoundResult(title, message)
end

-- Function to send Fine notifications using ModernHUD if available
RegisterNetEvent('SendModernHUDNotification')
AddEventHandler('SendModernHUDNotification', function(title, message, amount)
    if exports["ModernHUD"] then
        NotifyWithModernHUD("[Police] ", message, "fa-solid fa-dollar-sign", "#e74c3c")
    else
        TriggerEvent('chatMessage', '^3Fine System', { 255, 255, 255 }, message)
    end
end)

-- Function to notify with ModernHUD
function NotifyWithModernHUD(title, message, icon, colorHex)
    exports["ModernHUD"]:AndyyyNotify({
        title = title,
        message = message,
        icon = icon,
        colorHex = colorHex,
        timeout = 8000
    })
end
