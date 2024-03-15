local imageUrl = "https://cdn.discordapp.com/attachments/916084229937438812/1187506512420147241/police-icon-29952.png?ex=6597229f&is=6584ad9f&hm=2da08b19914bde867f13e759e04b22e218a3cc062a8b06219df12fa448162551&L"

local function sendSearchMessage(resultItems, targetId)
    local officerText = targetId and "Law Enforcement Searches" or "Officer Searches"
    local chatMessages = {}

    for _, itemData in pairs(resultItems) do
        local itemType = itemData.isLegal and "[Legal]" or "[Illegal]"
        table.insert(chatMessages, string.format("%s %s", itemType, itemData.item))
    end

    TriggerClientEvent("chat:addMessage", -1, {
        args = {table.concat(chatMessages, "\n")},
        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(0, 0, 0, 0.8); border-radius: 15px; max-width: 80vw; overflow-wrap: break-word; word-wrap: break-word; word-break: break-all;">' ..
                   '<img src="' .. imageUrl .. '" style="max-width: 30px; height: auto; margin-right: 10px;">' ..
                   officerText .. ': {0}' ..
                   '</div>',
        bubble = true
    })
end

RegisterCommand("wdif", function(source, args, rawCommand)
    local targetId = tonumber(args[1])
    local playerPed = GetPlayerPed(-1)

    if targetId then
        local legalItems, illegalItems = Config.LegalItems, Config.IllegalItems
        local numLegalItems, numIllegalItems = math.random(1, 5), math.random(0, 3)
        local resultItems = {}

        for i = 1, numLegalItems do table.insert(resultItems, {item = legalItems[math.random(#legalItems)], isLegal = true}) end
        for i = 1, numIllegalItems do table.insert(resultItems, {item = illegalItems[math.random(#illegalItems)], isLegal = false}) end

        sendSearchMessage(resultItems, targetId)
    else
        local presetMessage = "Officer Searches. What do they find?"
        TriggerClientEvent("chat:addMessage", source, {
            args = {presetMessage},
            template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(0, 0, 0, 0.8); border-radius: 15px; max-width: 80vw; overflow-wrap: break-word; word-wrap: break-word; word-break: break-all;">' ..
                       '<img src="' .. imageUrl .. '" style="max-width: 30px; height: auto; margin-right: 10px;">' ..
                       'Officer Searches: {0}' ..
                       '</div>',
            bubble = true
        })
    end
end, false)
