local hidden, cash, bank, job = false, "", "", ""

-- Add your job list configuration
local jobList = {
    'SASP',
    'DOA',
    'LSCSO',
    -- Add more jobs as needed
}

function notify(title, description, duration, position, type, style, icon, iconColor, iconAnimation, alignIcon)
    lib.notify({
        title = title,
        description = description,
        duration = duration,
        position = position,
        type = type,
        style = style,
        icon = icon,
        iconColor = iconColor,
        iconAnimation = iconAnimation,
        alignIcon = alignIcon
    })
end

function init()
    local player = NDCore.getPlayer()
    if player then
        cash, bank, job = player.cash, player.bank, player.job
    end
end

function update(c, b)
    cash, bank = c, b
end

function displayNotifications()
    if Config.enableMoneyHud then
        notify("Cash", " " .. cash, 5000, 'top-right', 'inform', nil, 'money-bill', '#278100' )
        notify("Bank", " " .. bank, 5000, 'top-right', 'inform', nil, 'credit-card', '#0092ff' )
        notify("Job", " " .. job, 5000, 'top-right', 'inform', nil, 'briefcase', '865200' )
    end
end

if Config.enableCommand then
    RegisterCommand("pinfo", function()
        displayNotifications()
    end, false)
end


if Config.enableMoneyHud then
    local function delayedInit()
        Wait(10000)
        init()
    end

    AddEventHandler("playerSpawned", init)
    AddEventHandler("onResourceStart", delayedInit)
    RegisterNetEvent("ND:setCharacter", init)
    RegisterNetEvent("ND:updateCharacter", delayedInit)
    RegisterNetEvent("ND:updateMoney", delayedInit)
    AddEventHandler("ND:updateMoney", update)
end

if Config.AutoDisplay then
    Citizen.CreateThread(function()
        while true do
            Wait(60000)  -- Display notifications every 60 seconds
            displayNotifications()
        end
    end)
end


-- Helper function to display players in a new context menu
function DisplayPlayersInMenu(job, players)
    local options = {}

    for _, playerData in ipairs(players) do
        table.insert(options, {
            title = playerData.playerName,
            onSelect = function()
                print(playerData.playerId, "Name:", playerData.playerName)
                print(playerData.playerId, "Job:", playerData.job)
            end
        })
    end

    -- Add a "Back" button to navigate back to the previous menu
    table.insert(options, {
        title = "Back",
        onSelect = function()
            lib.showContext("getCops") -- Navigate back to DisplayPlayersMenu
        end
    })

    -- Register the new context menu
    lib.registerContext({
        id = "DisplayPlayersMenu",
        title = "Players in " .. job,
        canClose = true,
        options = options
    })

    -- Show the new context menu
    lib.showContext("DisplayPlayersMenu")
end

-- Helper function to get players with a specific job
function GetPlayersWithJob(job)
    local players = GetActivePlayers()
    local jobPlayers = {}

    for _, playerId in ipairs(players) do
        local player = NDCore.getPlayer(playerId)
        if player and player.job == job then
            table.insert(jobPlayers, {
                playerId = playerId,
                playerName = player.fullname,
                job = player.job
            })
        end
    end

    return jobPlayers
end

-- Register a context menu to display players within a specific job
lib.registerContext({
    id = "DisplayPlayersWithinJob",
    title = "Select Job",
    canClose = true,
    options = {
        {
            title = "SASP",
            onSelect = function()
                local jobPlayers = GetPlayersWithJob("SASP")
                DisplayPlayersInMenu("SASP", jobPlayers)
            end
        },
        {
            title = "LSCSO",
            onSelect = function()
                local jobPlayers = GetPlayersWithJob("LSCSO")
                DisplayPlayersInMenu("LSCSO", jobPlayers)
            end
        },
        {
            title = "DOA",
            onSelect = function()
                local jobPlayers = GetPlayersWithJob("DOA")
                DisplayPlayersInMenu("DOA", jobPlayers)
            end
        },
        {
            title = "SAFR",
            onSelect = function()
                local jobPlayers = GetPlayersWithJob("SAFR")
                DisplayPlayersInMenu("SAFR", jobPlayers)
            end
        },
        {
            title = "Back",
            onSelect = function()
                lib.showContext("getCops") -- Navigate back to getCops menu
            end
        }
    }
})

-- Register the getCops command to display the job selection menu
lib.registerContext({
    id = "getCops",
    title = "Get Cops",
    canClose = true,
    options = {
        {
            title = "SASP",
            onSelect = function()
                local jobPlayers = GetPlayersWithJob("SASP")
                DisplayPlayersInMenu("SASP", jobPlayers)
            end
        },
        {
            title = "LSCSO",
            onSelect = function()
                local jobPlayers = GetPlayersWithJob("LSCSO")
                DisplayPlayersInMenu("LSCSO", jobPlayers)
            end
        },
        {
            title = "DOA",
            onSelect = function()
                local jobPlayers = GetPlayersWithJob("DOA")
                DisplayPlayersInMenu("DOA", jobPlayers)
            end
        },
        {
            title = "Back",
            onSelect = function()
                lib.showContext("getCops") -- Navigate back to listjobs menu
            end
        }
    }
})

-- Register the getFire command to display the job selection menu
lib.registerContext({
    id = "getFire",
    title = "Get Firefighters",
    canClose = true,
    options = {
        {
            title = "SAFR",
            onSelect = function()
                local jobPlayers = GetPlayersWithJob("SAFR")
                DisplayPlayersInMenu("SAFR", jobPlayers)
            end
        },
        {
            title = "Back",
            onSelect = function()
                lib.showContext("getFire") -- Navigate back to listjobs menu
            end
        }
    }
})

-- Register commands to open the respective context menus
RegisterCommand("listjobs", function()
    lib.showContext("listjobs")
end, false)

RegisterCommand("getCops", function()
    lib.showContext("getCops")
end, false)

RegisterCommand("getFire", function()
    lib.showContext("getFire")
end, false)
