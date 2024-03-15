local jailTime, ped, tablet = false, false, 0, nil, false


function hasAccess()
    local player = GetPlayerPed(-1)
    local acePermission = "CXJail.Allow"
    local job = Config.UseND and NDCore.getPlayer().job or IsAllowedAce(player, acePermission)

    for _, department in pairs(Jailer.accessDepartments) do
        if department == job then
            return true
        end
    end

    return false
end


AddEventHandler("playerSpawned", function()
    TriggerServerEvent("Jailer:getJailTime")
end)

function jail(time)
    local player = PlayerPedId()
    local pedCoords = GetEntityCoords(player)
    jailTime = time
    SetEntityCoords(player, Jailer.jailCoords.x, Jailer.jailCoords.y, Jailer.jailCoords.z, false, false, false, false)
    SetEntityHeading(player, Jailer.jailCoords.h)
    TriggerEvent("Jailer:timeLeft")
    TriggerServerEvent("Jailer:updateJailing", jailTime)

    while jailTime > 0 do
        jailTime = jailTime -1
        player = PlayerPedId()
        if #(GetEntityCoords(player) - vector3(Jailer.jailCoords.x, Jailer.jailCoords.y, Jailer.jailCoords.z)) > Jailer.jailDistance then
            SetEntityCoords(player, Jailer.jailCoords.x, Jailer.jailCoords.y, Jailer.jailCoords.z, false, false, false, false)
        end
        Citizen.Wait(1000)
    end
    SetEntityCoords(player, Jailer.releaseCoords.x, Jailer.releaseCoords.y, Jailer.releaseCoords.z, false, false, false, false)
    SetEntityHeading(player, Jailer.releaseCoords.h)
    TriggerServerEvent("Jailer:updateJailing", jailTime)
end

RegisterNetEvent("Jailer:timeLeft", function()
    while jailTime > 0 do
        Citizen.Wait(0)
        text("Time until release: " .. tostring(jailTime), 0.5, 0.9, 0.5)
    end
end)

-- Jail a player and loop to keep them in jail every second.
RegisterNetEvent("Jailer:jailPlayer", function(time)
    jail(time)
end)

RegisterNetEvent("Jailer:unjailPlayer", function(time)
    jailTime = 0
end)

-- Chat suggestion for command.
TriggerEvent("chat:addSuggestion", "/jail", "Jail a player", {
    {name="Id", help="Player Id"},
    {name="Time", help="Time to jail (seconds)"},
    {name="Fine", help="How much will the player be fined?"},
    {name="Reason", help="Short description of the charge."}
})

-- Same jail function but with a command.
RegisterCommand("jail", function(source, args, rawCommand)
    local id = tonumber(args[1])
    local time = tonumber(args[2])
    local fine = args[3]
    local reason = args[4]
    
    if id and time and fine and reason then
        if hasAccess() then
            if not GetPlayerFromServerId(id) then
                TriggerEvent("chat:addMessage", {
                    color = { 255, 0, 0 },
                    multiline = true,
                    args = { "[Error]", "Couldn't find a player with id " .. id .. "." }
                })
            elseif time > Jailer.maxJailTime then
                TriggerEvent("chat:addMessage", {
                    color = { 255, 0, 0 },
                    multiline = true,
                    args = { "[Error]", "Max time to jail is: " .. Jailer.maxJailTime .. " seconds." }
                })
            elseif time <= Jailer.maxJailTime then
                TriggerServerEvent("Jailer:jailPlayer", id, time, fine, reason)
                SetDisplay(false)
            end
        else
            TriggerEvent("chat:addMessage", {
                color = { 255, 0, 0 },
                multiline = true,
                args = { "[Error]", "You don't have permission to use this command." }
            })
        end
    else
        TriggerEvent("chat:addMessage", {
            color = { 255, 0, 0 },
            multiline = true,
            args = { "[Error]", "Please complete all the arguments: /jail <id> <time> <fine> <reason>" }
        })
    end
end, false)




RegisterNetEvent("Jailer:TriggerModernHUDNotify")
AddEventHandler("Jailer:TriggerModernHUDNotify", function(jailingOfficer, jailedPerson, time, reason)
    exports["ModernHUD"]:AndyyyNotify({
        title = '<font color="#34eb52">Jail Logs:</font>',
        message = jailingOfficer .. " jailed " .. jailedPerson .. " for " .. time .. " seconds with the reason: " .. reason,
        icon = "bank",
        colorHex = "#34eb52",
        timeout = 8000
    })
end)
