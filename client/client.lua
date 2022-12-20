local activePresent = nil
local sleep = 1000

RegisterNetEvent('xechristmas:createPresent', function(data)
    activePresent = data
end)

RegisterNetEvent('xechristmas:removePresent', function(data)
    activePresent = nil
end)

CreateThread(function()
    while true do Wait(sleep)
        if activePresent ~= nil then
            sleep = 0
            local x, y, z = table.unpack(activePresent.coords)
            local playerCoords = GetEntityCoords(PlayerPedId())
            local distance = #(playerCoords - vector3(x, y, z))

            if distance < Config.visibleDistance then
                DrawMarker(2, x, y, z, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 0.5, 255, 0, 0, 100, 1, 0, 0, 1)
                if distance < 1.5 then
                    drawNativeInfo('Press ~INPUT_CONTEXT~ to open the present')
                    if IsControlJustPressed(0, 38) then
                        TriggerServerEvent('xechristmas:openPresent')
                        activePresent = nil
                    end
                end
            else
                sleep = 1000
            end
        else
            sleep = 1000
        end
    end
end)

function drawNativeInfo(text)
    SetTextComponentFormat('STRING')
    AddTextComponentString(text)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end