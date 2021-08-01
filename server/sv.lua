GlobalState.pushUps = false
GlobalState.pullUps = false
GlobalState.weights = false
GlobalState.sitUps = false
RegisterNetEvent('ev:status', function(type)
    if type == "pushups" then
        if not GlobalState.pushUps then
            GlobalState.pushUps = true
        else
            GlobalState.pushUps = false
        end
    elseif type == "weights" then
        if not GlobalState.weights then
            GlobalState.weights = true
        else
            GlobalState.weights = false
        end
    elseif type == "situps" then
        if not GlobalState.sitUps then
            GlobalState.sitUps = true
        else
            GlobalState.sitUps = false
        end
    elseif type == "pullups" then
        if not GlobalState.pullUps then
            GlobalState.pullUps = true
        else
            GlobalState.pullUps = false
        end
    end
end)