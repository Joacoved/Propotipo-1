local CorrutinaOleadas = {}

local corrutina = nil
local tiempo_espera = 0
local mensaje = nil

function CorrutinaOleadas.Iniciar(siguiente_oleada, generar_oleada)

    if corrutina ~= nil then
        return
    end

    corrutina = coroutine.create(function()

        mensaje = "Oleada completada"
        coroutine.yield(2)

        mensaje = "Preparate para la siguiente oleada"
        coroutine.yield(2)

        mensaje = nil
        generar_oleada(siguiente_oleada)

    end)

    local correcto, espera = coroutine.resume(corrutina)

    if not correcto then
        error(espera)
    end

    tiempo_espera = espera or 0

end

function CorrutinaOleadas.Update(dt)

    if corrutina == nil then
        return
    end

    tiempo_espera = tiempo_espera - dt

    if tiempo_espera > 0 then
        return
    end

    if coroutine.status(corrutina) == "dead" then
        corrutina = nil
        return
    end

    local correcto, espera = coroutine.resume(corrutina)

    if not correcto then
        error(espera)
    end

    tiempo_espera = espera or 0

    if coroutine.status(corrutina) == "dead" then
        corrutina = nil
    end

end

function CorrutinaOleadas.Draw()

    if mensaje == nil then
        return
    end

    love.graphics.setColor(1, 1, 1)

    love.graphics.printf(
        mensaje,
        0,
        280,
        800,
        "center"
    )

end

function CorrutinaOleadas.Activa()
    return corrutina ~= nil
end

function CorrutinaOleadas.Reset()
    corrutina = nil
    tiempo_espera = 0
    mensaje = nil
end

return CorrutinaOleadas
