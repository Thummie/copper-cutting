local QBCore = exports['qb-core']:GetCoreObject()
local CurrentCops = 0

local function setupCopperTargets()
    exports['qb-target']:AddTargetModel(Config.Copper.props, {
        options = {
            {
                icon = 'fas fa-cut',
                label = 'Cut copper',
                action = function(entity)
                    if QBCore.Functions.HasItem('cutter') then
                        if CurrentCops >= Config.Copper.police then
                            TriggerEvent('copper:cutCopper', entity)
                        else
                            QBCore.Functions.Notify('There are not enough officers on duty..', 'error')
                        end
                    else
                        QBCore.Functions.Notify('You are missing something..', 'error')
                        if Config.Debug then
                            print('no cutter')
                        end
                    end
                end,
            },
        },
        distance = 1.5
    })
end
setupCopperTargets()

RegisterNetEvent('copper:cutCopper', function(entity)
    if Config.Debug then
        print('Current entity '..entity)
    end

    if not Config.CutProps[entity] then
        TriggerServerEvent('copper:sync', entity, true)
        TaskTurnPedToFaceEntity(PlayerPedId(), entity, 1.0)
        Wait(1000)
        if Config.Debug then
            print('started cutting')
        end
        ClearPedTasks(PlayerPedId())

        QBCore.Functions.Progressbar('cut_copper', 'Cutting Copper..', 5000, false, false, { -- Name | Label | Time | useWhileDead | canCancel
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@',
            anim = 'machinic_loop_mechandplayer',
            flags = 16,
        }, {}, {}, function() -- Done
            ClearPedTasks(PlayerPedId())
            TriggerServerEvent('copper:giveItem', 'copper', math.random(2, 8))
            if math.random(1, 12) <= 4 then
                exports["ps-dispatch"]:CustomAlert({
                    coords = GetEntityCoords(PlayerPedId()),
                    message = "Theft of public property",
                    dispatchCode = "211",
                    description = "Theft of public property",
                    gender = true,
                    radius = 0,
                    sprite = 761,
                    color = 1,
                    scale = 0.5,
                    length = 2,
                })
            end
        end)
    else
        QBCore.Functions.Notify('The copper has already been cut..', 'error')
    end
end)

RegisterNetEvent('copper:sync', function(cutProp)
    Config.CutProps = cutProp
end)

RegisterNetEvent('police:SetCopCount', function(amount)
    CurrentCops = amount
end)
