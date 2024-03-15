RegisterCommand("ufind", function(source, args, rawCommand)
    if not args[1] then
        TriggerEvent("chatMessage", "Error", {255, 0, 0}, "Usage: /ufind [args]")
        return
    end

    TriggerEvent("chatMessage", "Search Result", {0, 255, 0}, "Results for: " .. table.concat(args, " "))
end, false)
