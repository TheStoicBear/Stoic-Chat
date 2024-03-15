local iconUrl = "https://i.imgur.com/yqSDWuL.png"

RegisterCommand("hr", function(source, args, rawCommand)
    local targetId = tonumber(args[1])
    if not targetId then TriggerError(source, "Usage: /hr [id]") return end

    local targetPlayer, heartRate = GetPlayerFromServerId(targetId), CalculateHeartRate(targetId)
    DisplayHeartRate(source, targetId, heartRate)
end, false)

function CalculateHeartRate(targetId)
    local targetHealth = GetEntityHealth(GetPlayerPed(GetPlayerFromServerId(targetId)))
    return (targetHealth >= 70) and math.floor(60 + (targetHealth - 70) * 0.4) or math.random(40, 70)
end

function DisplayHeartRate(source, targetId, heartRate)
    local textColor = (heartRate >= 70) and {0, 255, 0} or {255, 165, 0}
    local chatMessage = string.format("Player ID: %d - Heart Rate: %d", targetId, heartRate)

    TriggerEvent("chat:addMessage", {
        color = textColor,
        args = {chatMessage},
        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(0, 0, 0, 0.8); border-radius: 15px; max-width: 80vw; overflow-wrap: break-word; word-wrap: break-word; word-break: break-all;">' ..
                   '<img src="' .. iconUrl .. '" style="max-width: 30px; height: auto; margin-right: 10px;">' ..
                   '{0}' ..
                   '</div>',
        bubble = true
    })
end

function TriggerError(source, errorMessage)
    TriggerClientEvent("chatMessage", source, "Error", {255, 0, 0}, errorMessage)
end
