local QBCore = exports['qb-core']:GetCoreObject()

-- Events
RegisterNetEvent('copper:sync', function(entity, state)
    Config.CutProps[entity] = state
    TriggerClientEvent('copper:sync', -1, Config.CutProps)
    if Config.Debug then
        print('synced')
    end

    SetTimeout((Config.Copper.time * (60 * 1000)), function()
        Config.CutProps[entity] = not state
        TriggerClientEvent('copper:sync', -1, Config.CutProps)
        if Config.Debug then
            print('can use again')
        end
    end)
end)

RegisterNetEvent('copper:giveItem', function(item, amount)
    local Player = QBCore.Functions.GetPlayer(source)
    Player.Functions.AddItem(item, amount)
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[item], 'add', amount)
end)
