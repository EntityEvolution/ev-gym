local PlayerPedId = PlayerPedId
local status

function showNoti(message, action, coords)
    if isCardActive and insidePoly then
        print('loaded thread')
        CreateThread(function()
            local ped = PlayerPedId()
            while insidePoly do
                local actualCoords = action == "yoga" and GetEntityCoords(ped) or coords
                showFloatingHelpNotification(message, actualCoords)
                if IsControlJustReleased(0, 38) then
                    status = action
                    TriggerServerEvent('ev:status', action)
                    if action == "pullups" then 
                        beginPlayingScenario("prop_human_muscle_chin_ups", 221.0, 8, -1200.00, -1571.17, 4.6095)
                    elseif action == "yoga" then
                        beginPlayingScenario("world_human_yoga", math.random(1.0, 359.0), 8, actualCoords.x, actualCoords.y, actualCoords.z)
                    elseif action == "weights" then 
                        beginPlayingScenario("world_human_muscle_free_weights", 33.85, 8, -1203.03, -1564.84, 4.6119)
                    elseif action == "situps" then
                        beginPlayingAnim("amb@world_human_sit_ups@male@idle_a", 'idle_a', 1, 123.68, 5,-1198.76, -1564.75, 5.0202)
                    elseif action == "pushups" then
                        beginPlayingAnim("amb@world_human_push_ups@male@idle_a", 'idle_d', 1, 220.44, 5, -1204.71, -1560.12, 4.6147)
                    end
                end
                Wait(5)
            end
        end)
    else
        return print('Does not have gym card')
    end
end

function beginPlayingAnim(dict, anim, flag, heading, seconds, x, y, z)
    local ped = PlayerPedId()
    SetEntityHeading(ped, heading)
    Wait(100)
    FreezeEntityPosition(ped, true)
    SetEntityCoords(ped, x, y, z - 1, false, false, false, true)
    Wait(1500)
    LoadAnim(dict)
    TaskPlayAnim(ped, dict, anim, 8.0, 8.0, -1, flag, 0, false, false, false)
    Wait(seconds * 1000)
    ClearPedTasks(ped)
    FreezeEntityPosition(ped, false)
    TriggerServerEvent('ev:status', status)
end

function beginPlayingScenario(scenario, heading, seconds, x, y, z)
    local ped = PlayerPedId()
    SetEntityHeading(ped, heading - 0.01)
    Wait(100)
    FreezeEntityPosition(ped, true)
    SetEntityCoords(ped, x, y, z - 1, false, false, false, true)
    Wait(1500)
    TaskStartScenarioInPlace(ped, scenario, 0, true) 
    Wait(seconds * 1000)
    ClearPedTasks(ped)
    FreezeEntityPosition(ped, false)
    TriggerServerEvent('ev:status', status)
end

function showNotification(message)
    SetNotificationTextEntry('STRING')
    AddTextComponentString(message)
    DrawNotification(0, 1)
end

function LoadAnim(dict)
    while not HasAnimDictLoaded(dict) do
      RequestAnimDict(dict)
      Wait(10)
    end
end

function showFloatingHelpNotification(message, coords)
    AddTextEntry('float', message)
    SetFloatingHelpTextWorldPosition(1, coords)
    SetFloatingHelpTextStyle(1, 1, 2, -1, 3, 0)
    BeginTextCommandDisplayHelp('float')
    EndTextCommandDisplayHelp(2, false, false, -1)
end