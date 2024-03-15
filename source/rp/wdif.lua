RegisterCommand("wdif", function(source, args, rawCommand)
    local targetId, legalItems, illegalItems = tonumber(args[1]), Config.LegalItems, Config.IllegalItems

    if not targetId then
        TriggerEvent("chat:addMessage", {color = {255, 0, 0}, multiline = true, args = {"Usage: /wdif [id]"}})
        return
    end

    local numLegalItems, numIllegalItems = math.random(1, 5), math.random(0, 3)
    local resultItems = {}

    for i = 1, numLegalItems do table.insert(resultItems, {item = legalItems[math.random(#legalItems)], isLegal = true}) end
    for i = 1, numIllegalItems do table.insert(resultItems, {item = illegalItems[math.random(#illegalItems)], isLegal = false}) end

    if #resultItems > 0 then
        local imageUrl, playerName = Config.URLs.Dispatch, GetPlayerName(source)
        local chatMessages, fullMessage = {}, ""

        for _, itemData in pairs(resultItems) do
            local itemType, itemText = itemData.isLegal and "[Legal]" or "[Illegal]", string.format("%s %s", itemType, itemData.item)
            table.insert(chatMessages, itemText)
        end

        fullMessage = table.concat(chatMessages, "\n")

        TriggerEvent("chat:addMessage", {
            args = {fullMessage},
            template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(0, 0, 0, 0.8); border-radius: 15px; max-width: 80vw; overflow-wrap: break-word; word-wrap: break-word; word-break: break-all;">' ..
                       '<img src="' .. imageUrl .. '" style="max-width: 30px; height: auto; margin-right: 10px;">' ..
                       '{0}' ..
                       '</div>',
            bubble = true
        })
    else
        TriggerEvent("chat:addMessage", {color = {255, 0, 0}, args = {"No items found for Player ID " .. targetId}})
    end
end, false)
