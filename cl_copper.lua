local QBCore = exports['moon-core']:GetCoreObject()

local isLoggedIn = false
local copperZones = {}
local insideZone = false

-- Loops
Citizen.CreateThread(function()
    Wait(4)
    for k, v in pairs(Config.CutCopper) do
        if not Config.CutCopper[k].cut then
            copperZones[k] = "cutcopper"..tostring(k)
            exports['moon-target']:AddBoxZone("cutcopper"..tostring(k), Config.CutCopper[k].coords, 1.0, 1.0, {
                name = "cutcopper"..tostring(k),
                heading = 0.0,
                debugPoly = false,
                minZ = Config.CutCopper[k].coords.z - 1.0,
                maxZ = Config.CutCopper[k].coords.z + 1.0,
            }, {
                options = {
                    {
                        action = function()
                            QBCore.Functions.TriggerCallback('QBCore:HasItem', function(hasItem)
                                if hasItem then
                                    TriggerServerEvent('copper:setState', k)
                                    Config.CutCopper[k].cut = true
                                    QBCore.Functions.Progressbar('cut_copper', 'Koper knippen..', 5000, false, false, { -- Name | Label | Time | useWhileDead | canCancel
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
                                        TriggerServerEvent('copper:giveCopper', k)
                                        --if math.random(1, 12) <= 4 then
                                        --    exports['ps-dispatch']:copperCut
                                        --end
                                        exports['moon-target']:RemoveZone("cutcopper"..tostring(k))
                                    end)
                                else
                                    QBCore.Functions.Notify('Je hebt geen betonschaar..', 'error')
                                end
                            end, 'cutter')
                        end,
                        icon = "fas fa-scissors",
                        label = "Koper knippen",
                        data = k,
                    },
                },
                distance = 1.5
            })
        else
            exports['moon-target']:RemoveZone("cutcopper"..tostring(k))
        end
    end
end)

CreateThread(function()
    while true do
        Wait(4)
        for k, v in pairs(Config.CutCopper) do
            if #(GetEntityCoords(PlayerPedId()) - Config.CutCopper[k].coords) < 8.0 then
                if not Config.CutCopper[k].cut then
                    DrawMarker(2, Config.CutCopper[k].coords, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.4, 0.4, 0.2, 255, 255, 255, 255, 0, 1, 0, 0, 0, 0, 0)
                end
            end
        end
    end
end)

-- Events
RegisterNetEvent('copper:cutState', function(k)
    for k, v in pairs(Config.CutCopper) do
        if not Config.CutCopper[k].cut then
            exports['moon-target']:AddBoxZone("cutcopper"..tostring(k), Config.CutCopper[k].coords, 1.0, 1.0, {
                name = "cutcopper"..tostring(k),
                heading = 0.0,
                debugPoly = false,
                minZ = Config.CutCopper[k].coords.z - 1.0,
                maxZ = Config.CutCopper[k].coords.z + 1.0,
            }, {
                options = {
                    {
                        action = function()
                            QBCore.Functions.TriggerCallback('QBCore:HasItem', function(hasItem)
                                if hasItem then
                                    TriggerServerEvent('copper:setState', k)
                                    Config.CutCopper[k].cut = true
                                    QBCore.Functions.Progressbar('cut_copper', 'Koper knippen..', 5000, false, false, { -- Name | Label | Time | useWhileDead | canCancel
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
                                        TriggerServerEvent('copper:giveCopper', k)
                                        --if math.random(1, 12) <= 4 then
                                        --    exports['ps-dispatch']:copperCut
                                        --end
                                        exports['moon-target']:RemoveZone("cutcopper"..tostring(k))
                                    end)
                                else
                                    QBCore.Functions.Notify('Je hebt geen betonschaar..', 'error')
                                end
                            end, 'cutter')
                        end,
                        icon = "fas fa-scissors",
                        label = "Koper knippen",
                        data = k,
                    },
                },
                distance = 1.5
            })
        else
            exports['moon-target']:RemoveZone("cutcopper"..tostring(k))
        end
    end
end)