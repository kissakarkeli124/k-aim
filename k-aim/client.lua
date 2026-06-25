local aimMode = false
local isAiming = false
local defaultCam = 1
local AIM_KVP = "Myresource_aimMode"

function ShowNotification(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, false)
end

CreateThread(function()
    Wait(250)

    local saved = GetResourceKvpString(AIM_KVP)
    aimMode = (saved == "true")
end)

RegisterCommand("aim", function()
    aimMode = not aimMode
    SetResourceKvp(AIM_KVP, tostring(aimMode))

    ShowNotification(aimMode and "First person shooting päällä" or "Third person shooting päällä")
end, false)
RegisterCommand("+aimCam", function()
    if isAiming then return end
    isAiming = true
    defaultCam = GetFollowPedCamViewMode()
    SetFollowPedCamViewMode(aimMode and 4 or 1)
end, false)
RegisterCommand("-aimCam", function()
    if not isAiming then return end
    isAiming = false
    SetFollowPedCamViewMode(defaultCam)
end, false)
RegisterKeyMapping("+aimCam", "Aim camera toggle", "mouse_button", "MOUSE_RIGHT")