local insidePoly = false

local function floatNotify(text, coords)
  AddTextEntry('float_notify', 'Press [~g~E~s~] to do ' .. text)
  SetFloatingHelpTextWorldPosition(1, coords)
  SetFloatingHelpTextStyle(1, 1, 2, -1, 3, 0)
  BeginTextCommandDisplayHelp('float_notify')
  EndTextCommandDisplayHelp(2, false, false, -1)
end

local function loadDict(dict)
  while not HasAnimDictLoaded(dict) do
    RequestAnimDict(dict)
    Wait(10)
  end
end

local function playAnimation(ped, data)
  if data.scenario then
    -- Prepare the animation
    SetEntityHeading(ped, data.coords.w - 0.01)
    Wait(150)
    FreezeEntityPosition(ped, true)
    SetEntityCoords(ped, data.coords.x, data.coords.y, data.coords.z - 1, false, false, false, true)
    Wait(1500)
    TaskStartScenarioInPlace(ped, data.scenario, 0, true)
    Wait(data.duration)

    -- Cleanup
    ClearPedTasks(ped)
    FreezeEntityPosition(ped, false)
  else
    if not data.dict or not data.anim then
      print('Error: Missing animation data')
      return
    end
    -- Preparation
    SetEntityHeading(ped, data.coords.w)
    Wait(150)
    FreezeEntityPosition(ped, true)
    SetEntityCoords(ped, data.coords.x, data.coords.y, data.coords.z - 1, false, false, false, true)
    Wait(1500)
    loadDict(data.dict)
    TaskPlayAnim(ped, data.dict, data.anim, 4.0, 4.0, -1, data.flag, 0.5, false, false, false)
    Wait(data.duration)

    -- Cleanup
    ClearPedTasks(ped)
    FreezeEntityPosition(ped, false)
  end
  print('done')
end

local function startThread(data)
  insidePoly = true
  CreateThread(function()
    while insidePoly do
      floatNotify(data.name, data.coords)
      if IsControlJustReleased(0, 38) then
        playAnimation(PlayerPedId(), data)
        insidePoly = false
      end
      Wait(0)
    end
  end)
end

for k, v in pairs(Config.Gym) do
  local poly = CircleZone:Create(v.coords, 1.0, {
    name = "gym_" .. k,
    useZ=false,
    lazyGrid = true,
    debugPoly = Config.debugMode,
  })

  poly:onPointInOut(PolyZone.getPlayerPosition, function(isPointInside, point)
    if isPointInside then
      local currentTime = GetClockHours()
      local inTime = currentTime > Config.minHours and currentTime < Config.maxHours
      if not insidePoly and inTime or Config.debugMode then
        startThread(v)
      end
    else
      if insidePoly then
        insidePoly = false
      end
    end
  end)
end