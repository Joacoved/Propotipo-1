
local HUD = {}


function HUD.Draw(
    vida,
    enemigos_restantes,
    oleada_actual,
    oleadas_totales
)

    local vida_maxima = 10

    local barra_x = 20
    local barra_y = 20
    local barra_ancho = 200
    local barra_alto = 20


    -- FONDO

    love.graphics.setColor(
        0.2,
        0.2,
        0.2
    )

    love.graphics.rectangle(
        "fill",
        barra_x,
        barra_y,
        barra_ancho,
        barra_alto
    )


    -- VIDA

    local porcentaje =
        vida / vida_maxima

    love.graphics.setColor(
        0.8,
        0.1,
        0.1
    )

    love.graphics.rectangle(
        "fill",
        barra_x,
        barra_y,
        barra_ancho * porcentaje,
        barra_alto
    )


    -- BORDE

    love.graphics.setColor(
        1,
        1,
        1
    )

    love.graphics.rectangle(
        "line",
        barra_x,
        barra_y,
        barra_ancho,
        barra_alto
    )


    -- TEXTO

    love.graphics.setColor(
        1,
        1,
        1
    )

    love.graphics.print(
        "Vida: " .. vida .. " / " .. vida_maxima,
        85,
        22
    )

    love.graphics.print(
        "Enemigos restantes: " .. enemigos_restantes,
        610,
        20
    )

    love.graphics.print(
        "Oleada: " .. oleada_actual .. " / " .. oleadas_totales,
        610,
        40
    )

    love.graphics.print(
        "WASD = Mover",
        20,
        50
    )

    love.graphics.print(
        "ESPACIO = Atacar",
        20,
        70
    )

    love.graphics.print(
        "F1 = Debug",
        20,
        90
    )

    love.graphics.setColor(
        1,
        1,
        1
    )

end


return HUD
