RegisterCommand("ufind", function(source, args, rawCommand)
    if not args[1] then
        TriggerServerEvent("ufind:sendToAll", "Usage: /ufind [args]")
        return
    end

    local searchTerm = table.concat(args, " ")
    TriggerServerEvent("ufind:sendToAll", "You Find: " .. searchTerm)
end, false)
