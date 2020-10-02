local crosshair = false
local toggled = false
local aiming = true
Citizen.CreateThread(function()
    while true do
        Wait(100)
        if crosshair then
            if aiming then
                if not toggled then
                    toggled = true
                    SendNUIMessage({
                        display = "crosshairShow",
                    })
                end
            else
                SendNUIMessage({
                    display = "crosshairHide",
                })
            end
        else
            SendNUIMessage({
                display = "crosshairHide",
            })
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Wait(0)
        if IsPedArmed(PlayerPedId(), 6) then
            local carcam = GetFollowVehicleCamViewMode()
            local cam = GetFollowPedCamViewMode()
            if cam ~= 4 or carcam ~= 4 then
                if (IsPlayerFreeAiming(PlayerId()))  then
                    aiming = true
                    if IsControlJustPressed(0, 73) then
                        if crosshair then
                            crosshair = false
                            toggled = false
                        else
                            crosshair = true
                            toggled = false
                        end
                    end
                else
                    aiming = false
                    toggled = false
                    Wait(100)
                end
            else
                aiming = false
                toggled = false
                SendNUIMessage({
                    display = "crosshairHide",
                })
                Wait(100)
            end
        else
            Wait(100)
        end
    end
end)
