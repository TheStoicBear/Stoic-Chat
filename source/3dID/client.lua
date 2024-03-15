local disPlayerNames = 1.0
local playerDistances = {}

local function DrawText3D(position, text, r, g, b)
    local onScreen, _x, _y = World3dToScreen2d(position.x, position.y, position.z + 1)
    local dist = #(GetGameplayCamCoords() - position)

    local scale = (1 / dist) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov

    if onScreen then
        if not useCustomScale then
            SetTextScale(0.0 * scale, 0.55 * scale)
        else
            SetTextScale(0.0 * scale, customScale)
        end
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(r, g, b, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end

Citizen.CreateThread(function()
    while true do
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)

        for _, id in ipairs(GetActivePlayers()) do
            local targetPed = GetPlayerPed(id)
            if targetPed ~= playerPed then
                local distance = #(playerCoords - GetEntityCoords(targetPed))
                playerDistances[id] = distance
            end
        end

        Citizen.Wait(4500)  -- Adjust the wait time as needed
    end
end)

Citizen.CreateThread(function()
    while true do
        for _, id in ipairs(GetActivePlayers()) do
            local targetPed = GetPlayerPed(id)
            if targetPed ~= PlayerPedId() then
                if playerDistances[id] and playerDistances[id] < disPlayerNames then
                    local targetPedCords = GetEntityCoords(targetPed)

                    -- Get job information for the target player
                    local targetPlayer = NDCore.getPlayer(id)
                    if targetPlayer then
                        -- Check if the source player has the required job to see IDs
                        local sourcePlayer = NDCore.getPlayer()
                        local allowedJobs = Config.AllowedJobs or {}  -- Assuming Config.AllowedJobs is a table with job names
                        if sourcePlayer and allowedJobs[sourcePlayer.job] then
                            if NetworkIsPlayerTalking(id) then
                                DrawText3D(targetPedCords, GetPlayerServerId(id), 247, 124, 24)
                                DrawMarker(27, targetPedCords.x, targetPedCords.y, targetPedCords.z - 0.97, 0, 0, 0, 0, 0, 0, 1.001, 1.0001, 0.5001, 173, 216, 230, 100, 0, 0, 0, 0)
                            else
                                DrawText3D(targetPedCords, GetPlayerServerId(id), 255, 255, 255)
                            end
                        end
                    end
                end
            end
        end
        Citizen.Wait(4500)  -- Adjust the wait time as needed
    end
end)
