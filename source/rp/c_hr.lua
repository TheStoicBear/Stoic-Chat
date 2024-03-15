local cprInProgress = false

RegisterNetEvent("startCPRAnimation")
AddEventHandler("startCPRAnimation", function()
    if cprInProgress then return end

    local playerPed = GetPlayerPed(-1)
    cprInProgress = true

    PerformAnimation(playerPed, "CODE_HUMAN_MEDIC_TEND_TO_DEAD", 10000)
end)

RegisterNetEvent("startNotepadAnimation")
AddEventHandler("startNotepadAnimation", function()
    local playerPed = GetPlayerPed(-1)
    
    PerformAnimation(playerPed, "CODE_HUMAN_MEDIC_TIME_OF_DEATH", 10000)
end)

function PerformAnimation(playerPed, animation, duration)
    TaskStartScenarioInPlace(playerPed, animation, 0, true)
    Citizen.Wait(duration)
    ClearPedTasks(playerPed)
    cprInProgress = false
end
