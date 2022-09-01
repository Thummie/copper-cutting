local QBCore = exports['moon-core']:GetCoreObject()

CreateThread(function()
    while true do
        Wait(600000) -- Every 10 minutes check if copper is cut and reset at 20 min.
        for k, v in pairs(Config.CutCopper) do
            if Config.CutCopper[k].cut and Config.CutCopper[k].timeout ~= false then
                if Config.CutCopper[k].timeout < os.time() then
                    Config.CutCopper[k].cut = false
                    Config.CutCopper[k].timeout = false
                end
            end
        end
        TriggerClientEvent('copper:updateCopper', -1, Config)
    end
end)

-- Events
RegisterNetEvent('copper:giveCopper', function(location)
    -- Going to build in automatic ban if distance above 120
    --[[if k ~= nil and Config.CutCopper[k].coords ~= nil then
        local playerPos = GetEntityCoords(GetPlayerPed(source), false)
        local dist = GetDistanceBetweenCoords(playerPos, Config.CutCopper[k].coords, true)
    end--]]

    local Player = QBCore.Functions.GetPlayer(source)
    if Player.Functions.AddItem('copper', math.random(3, 8)) then
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['copper'], "add")
    else
        TriggerClientEvent('QBCore:Notify', source, 'Je hebt teveel spullen op zak..', 'error')
    end
end)

RegisterNetEvent('copper:setState', function(location)
    Config.CutCopper[location].cut = true
    Config.CutCopper[location].timeout = (os.time() + 1200)
    TriggerClientEvent('copper:cutState', -1, Config)
end)