local function DrawText3D(x, y, z, text, scale)
    local camCoords = GetGameplayCamCoords()
    local dist = #(vector3(x, y, z) - camCoords)


    local scaleMod = (scale / dist) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    scaleMod = scaleMod * fov


    SetTextScale(scaleMod, scaleMod)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(table.unpack(Config.TextColor))
    SetTextCentre(true)
    

    SetTextDropshadow(1, 0, 0, 0, 255)
    SetTextOutline()
    
    SetDrawOrigin(x, y, z, 0)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end


Citizen.CreateThread(function()
    while true do
        Wait(0)
        local playerCoords = GetEntityCoords(PlayerPedId())

        for _, info in pairs(Config.Texts) do
            local dist = #(playerCoords - info.pos)

            if dist <= info.distance then
                DrawText3D(info.pos.x, info.pos.y, info.pos.z, info.text, info.scale)
            end
        end
    end
end)
