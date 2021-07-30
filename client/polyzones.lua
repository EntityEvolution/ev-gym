local pullUp <const> = CircleZone:Create(vector3(-1200.22, -1570.86, 4.61), 1.0, {
    name = "pullUp",
    useZ = false,
    lazygrid = true,
    debugPoly = false
})

local yoga <const> = PolyZone:Create({
    vector2(-1233.2965087891, -1558.0021972656),
    vector2(-1212.138671875, -1543.8118896484),
    vector2(-1215.8872070313, -1538.3508300781),
    vector2(-1238.90234375, -1550.2661132813)
}, {
    name="yoga",
    minZ = 2.2938261032104,
    maxZ = 5.6719541549683, 
    lazygrid = true,
    debugPoly=false
})

local liftWeights <const> = CircleZone:Create(vector3(-1202.97, -1565.07, 4.61), 1.0, {
    name="lifteigts",
    useZ=false,
    lazygrid = true,
    debugPoly=false
})

local pushUps <const> = CircleZone:Create(vector3(-1204.91, -1560.2, 4.61), 1.0, {
    name="pushups",
    useZ=false,
    lazygrid = true,
    debugPoly=false
})

local sitUps <const> =  CircleZone:Create(vector3(-1199.11, -1565.07, 4.62), 1.0, {
    name="Situps",
    useZ=false,
    lazygrid = true,
    debugPoly=false
})

local inTime = GetClockHours() > Config.minHours and GetClockHours() < Config.maxHours

sitUps:onPointInOut(PolyZone.getPlayerPosition, function(isPointInside, point)
    if isPointInside then
        if not insidePoly and inTime then
            insidePoly = true
            showNoti("E - Situps", "situps", vector3(-1199.11, -1565.07, 4.62))
        end
	else
        if insidePoly then
            insidePoly = false
        end
    end
end)

pushUps:onPointInOut(PolyZone.getPlayerPosition, function(isPointInside, point)
    if isPointInside then
        if not insidePoly and inTime then
            insidePoly = true
            showNoti("E - Pushups", "pushups", vector3(-1204.91, -1560.2, 4.61))
        end
	else
        if insidePoly then
            insidePoly = false
        end
    end
end)

liftWeights:onPointInOut(PolyZone.getPlayerPosition, function(isPointInside, point)
    if isPointInside then
        if not insidePoly and inTime then
            insidePoly = true
            showNoti("E - weights", "weights", vector3(-1202.97, -1565.07, 4.61))
        end
	else
        if insidePoly then
            insidePoly = false
        end
    end
end)

yoga:onPointInOut(PolyZone.getPlayerPosition, function(isPointInside, point)
    if isPointInside then
        if not insidePoly and inTime then
            insidePoly = true
            showNoti("E - Yoga", "yoga", nil)
        end
	else
        if insidePoly then
            insidePoly = false
        end
    end
end)

pullUp:onPointInOut(PolyZone.getPlayerPosition, function(isPointInside, point)
    if isPointInside then
        if not insidePoly and inTime then
            insidePoly = true
            showNoti("E - PullUps", "pullups", vector3(-1200.22, -1570.86, 4.61))
        end
	else
        if insidePoly then
            insidePoly = false
        end
    end
end)



  