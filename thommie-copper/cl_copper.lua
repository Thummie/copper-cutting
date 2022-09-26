local QBCore = exports['qb-core']:GetCoreObject()

-- Loops
CreateThread(function()
    for k, v in pairs(Config.CutCopper) do
        if not Config.CutCopper[k].cut then
            exports['qb-target']:AddBoxZone("cutcopper"..tostring(k), Config.CutCopper[k].coords, 1.0, 1.0, {
                name = "cutcopper"..tostring(k),
                heading = 0.0,
                debugPoly = false,
                minZ = Config.CutCopper[k].coords.z - 1.0,
                maxZ = Config.CutCopper[k].coords.z + 1.0,
            }, {
                options = {
                    {
                        action = function()
                            if QBCore.Functions.HasItem("cutter") then
                                TriggerServerEvent('copper:setState', k)
                                Config.CutCopper[k].cut = true
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
                                    exports['qb-inventory']:toggleItem(1, 'copper', math.random(2, 8))
                                    if math.random(1, 12) <= 4 then
                                        exports["ps-dispatch"]:CustomAlert({
                                            coords = GetEntityCoords(PlayerPedId()),
                                            message = "Copper Cutting",
                                            dispatchCode = "211",
                                            description = "Copper Cutting",
                                            gender = true,
                                            radius = 0,
                                            sprite = 761,
                                            color = 1,
                                            scale = 0.5,
                                            length = 2,
                                        })
                                    end
                                    exports['qb-target']:RemoveZone("cutcopper"..tostring(k))
                                end)
                            else
                                QBCore.Functions.Notify('You do not have heavy cutters on you..', 'error')
                            end
                        end,
                        icon = "fas fa-scissors",
                        label = "Cut Copper",
                        data = k,
                    },
                },
                distance = 1.5
            })
        else
            exports['qb-target']:RemoveZone("cutcopper"..tostring(k))
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
            exports['qb-target']:AddBoxZone("cutcopper"..tostring(k), Config.CutCopper[k].coords, 1.0, 1.0, {
                name = "cutcopper"..tostring(k),
                heading = 0.0,
                debugPoly = false,
                minZ = Config.CutCopper[k].coords.z - 1.0,
                maxZ = Config.CutCopper[k].coords.z + 1.0,
            }, {
                options = {
                    {
                        action = function()
                            if QBCore.Functions.HasItem("cutter") then
                                TriggerServerEvent('copper:setState', k)
                                Config.CutCopper[k].cut = true
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
                                    exports['qb-inventory']:toggleItem(1, 'copper', math.random(2, 8))
                                    if math.random(1, 12) <= 4 then
                                        exports["ps-dispatch"]:CustomAlert({
                                            coords = GetEntityCoords(PlayerPedId()),
                                            message = "Copper Cutting",
                                            dispatchCode = "211",
                                            description = "Copper Cutting",
                                            gender = true,
                                            radius = 0,
                                            sprite = 761,
                                            color = 1,
                                            scale = 0.5,
                                            length = 2,
                                        })
                                    end
                                    exports['qb-target']:RemoveZone("cutcopper"..tostring(k))
                                end)
                            else
                                QBCore.Functions.Notify('You do not have heavy cutters on you..', 'error')
                            end
                        end,
                        icon = "fas fa-scissors",
                        label = "Cut Copper",
                        data = k,
                    },
                },
                distance = 1.5
            })
        else
            exports['qb-target']:RemoveZone("cutcopper"..tostring(k))
        end
    end
end)
