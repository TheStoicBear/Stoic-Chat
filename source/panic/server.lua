RegisterNetEvent("showPanicButtonMessage")
AddEventHandler("showPanicButtonMessage", function(location, description, callerInfo)
    local chatMessage = string.format(Config.ChatTemplates.EmergencyMessage, location, description, callerInfo)
    ShowChatBubbleMessage(-1, chatMessage, {255, 0, 0})
end)

if Config.CommandPanic then
    RegisterCommand("cpanic", function(source, args, rawCommand)
        local player = source
        local location = GetEntityCoords(GetPlayerPed(player))
        local description = table.concat(args, " ")

        -- Notify emergency services
        TriggerClientEvent("ND_Chat:PanicButton", -1, location, description)

        -- Get image URL from configuration
        local dispatchText = "^7[^1Dispatch^7] Emergency Services are on their way."
        local imageUrl = Config.URLs.Dispatch

        -- Send a chat bubble message
        ShowChatBubbleMessage(player, dispatchText, {255, 0, 0}, imageUrl)
    end, false)
end

function ShowChatBubbleMessage(target, text, color, imageUrl)
    local template = '<div style="display: flex; align-items: center; padding: 0.5vw; margin: 0.5vw; background-color: rgba(0, 0, 0, 0.85); border-radius: 10px; max-width: 80vw; overflow-wrap: break-word; word-wrap: break-word; word-break: break-all;">' ..
                    '<img src="%s" style="max-width: 30px; height: auto; margin-right: 10px;">' ..
                    '{0}' ..
                    '</div>'

    TriggerClientEvent("chat:addMessage", target, {
        color = color,
        args = {text},
        template = string.format(template, imageUrl),
        bubble = true
    })
end
