RegisterNetEvent("show911Message")
AddEventHandler("show911Message", function(location, description, callerInfo)
    local chatMessage = string.format(Config.ChatTemplates.EmergencyMessage, location, description, callerInfo)
    local template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(0, 0, 0, 0.85); border-radius: 10px; max-width: 80vw; overflow-wrap: break-word; word-wrap: break-word; word-break: break-all;">{0}</div>'

    ShowChatMessage(-1, chatMessage, {255, 0, 0}, template, true)
end)

if Config.Command911 then
    RegisterCommand("c911", function(source, args, rawCommand)
        local player = source
        local location = GetEntityCoords(GetPlayerPed(player))
        local description = table.concat(args, " ")

        -- Notify emergency services
        TriggerClientEvent("ND_Chat:911", -1, location, description)

        -- Get image URL from configuration (assuming Config.URLs.Dispatch is a table with the necessary fields)
        local dispatchText = "^7[^1Dispatch^7] Emergency Services are on their way."
        local imageUrl = Config.URLs.Dispatch

        -- Send a chat bubble message to the user who initiated the command with a small image to the left of "[Dispatch]" in red
        local bubbleTemplate = '<div style="display: flex; align-items: center; padding: 0.5vw; margin: 0.5vw; background-color: rgba(0, 0, 0, 0.85); border-radius: 10px; max-width: 80vw; overflow-wrap: break-word; word-wrap: break-word; word-break: break-all;">' ..
                                '<img src="' .. imageUrl .. '" style="max-width: 30px; height: auto; margin-right: 10px;">' ..
                                '{0}' ..
                                '</div>'

        ShowChatMessage(player, dispatchText, {255, 0, 0}, bubbleTemplate, true)
    end, false)
end

function ShowChatMessage(target, text, color, template, bubble)
    TriggerClientEvent("chat:addMessage", target, {
        color = color,
        args = {text},
        template = template,
        bubble = bubble
    })
end
