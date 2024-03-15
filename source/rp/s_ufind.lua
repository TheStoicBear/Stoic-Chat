RegisterServerEvent("ufind:sendToAll")
AddEventHandler("ufind:sendToAll", function(message)
    local imageUrl = "https://cdn.discordapp.com/attachments/916084229937438812/1187506512420147241/police-icon-29952.png?ex=6597229f&is=6584ad9f&hm=2da08b19914bde867f13e759e04b22e218a3cc062a8b06219df12fa448162551&"
    local officerText = "Officer Searches"

    TriggerClientEvent("chat:addMessage", -1, {
        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(0, 0, 0, 0.8); border-radius: 15px; max-width: 80vw; overflow-wrap: break-word; word-wrap: break-word; word-break: break-all;">' ..
                   '<img src="' .. imageUrl .. '" style="max-width: 30px; height: auto; margin-right: 10px;">' ..
                   officerText .. ': {0}' ..
                   '</div>',
        args = {message},
        color = {255, 255, 255}
    })
end)
