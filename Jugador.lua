Jugador = {}

Jugador.x = 400
Jugador.y = 330

Jugador.velocidad = 200

Jugador.escala = 1.7

Jugador.origen_x = 32
Jugador.origen_y = 32

Jugador.direccion = "derecha"
Jugador.moviendose = false

Jugador.sprite_idle = nil
Jugador.sprite_walk = nil

Jugador.anim_idle = {}
Jugador.anim_walk = {}

Jugador.indice_idle = 1
Jugador.indice_walk = 1

Jugador.velocidad_idle = 8
Jugador.velocidad_walk = 10

Jugador.cantidad_idle = {
    abajo = 12,
    izquierda = 12,
    derecha = 12,
    arriba = 4
}

Jugador.cantidad_walk = 6


-- =================== LOAD ===================

function Jugador.Load()

    Jugador.x = 400
    Jugador.y = 330

    Jugador.direccion = "derecha"
    Jugador.moviendose = false

    Jugador.indice_idle = 1
    Jugador.indice_walk = 1


    Jugador.sprite_idle =
        love.graphics.newImage(
            "assets/jugador/Swordsman_lvl1_Idle_without_shadow.png"
        )

    Jugador.sprite_walk =
        love.graphics.newImage(
            "assets/jugador/Swordsman_lvl1_Walk_without_shadow.png"
        )


    Jugador.CrearAnimaciones()

end


-- =================== CREAR ANIMACIONES ===================

function Jugador.CrearAnimaciones()

    Jugador.anim_idle = {
        abajo = {},
        izquierda = {},
        derecha = {},
        arriba = {}
    }

    Jugador.anim_walk = {
        abajo = {},
        izquierda = {},
        derecha = {},
        arriba = {}
    }


    local direcciones = {
        "abajo",
        "izquierda",
        "derecha",
        "arriba"
    }


    -- =================== IDLE ===================

    for fila = 0, 3 do

        local direccion =
            direcciones[fila + 1]

        local cantidad =
            Jugador.cantidad_idle[direccion]

        for columna = 0, cantidad - 1 do

            table.insert(
                Jugador.anim_idle[direccion],

                love.graphics.newQuad(
                    columna * 64,
                    fila * 64,
                    64,
                    64,
                    Jugador.sprite_idle
                )
            )

        end

    end


    -- =================== WALK ===================

    for fila = 0, 3 do

        local direccion =
            direcciones[fila + 1]

        for columna = 0,
            Jugador.cantidad_walk - 1 do

            table.insert(
                Jugador.anim_walk[direccion],

                love.graphics.newQuad(
                    columna * 64,
                    fila * 64,
                    64,
                    64,
                    Jugador.sprite_walk
                )
            )

        end

    end

end


-- =================== MOVIMIENTO ===================

function Jugador.UpdateMovimiento(dt)

    local movimiento_x = 0
    local movimiento_y = 0


    if love.keyboard.isDown("a") then

        movimiento_x = -1
        Jugador.direccion = "izquierda"

    elseif love.keyboard.isDown("d") then

        movimiento_x = 1
        Jugador.direccion = "derecha"

    end


    if love.keyboard.isDown("w") then

        movimiento_y = -1
        Jugador.direccion = "arriba"

    elseif love.keyboard.isDown("s") then

        movimiento_y = 1
        Jugador.direccion = "abajo"

    end


    Jugador.moviendose =
        movimiento_x ~= 0
        or movimiento_y ~= 0


    if movimiento_x ~= 0
       and movimiento_y ~= 0 then

        local diagonal =
            math.sqrt(2)

        movimiento_x =
            movimiento_x / diagonal

        movimiento_y =
            movimiento_y / diagonal

    end


    Jugador.x =
        Jugador.x +
        movimiento_x *
        Jugador.velocidad *
        dt

    Jugador.y =
        Jugador.y +
        movimiento_y *
        Jugador.velocidad *
        dt

end


-- =================== UPDATE ANIMACION ===================

function Jugador.UpdateAnimacion(dt)

    if Jugador.moviendose then

        Jugador.indice_walk =
            Jugador.indice_walk +
            Jugador.velocidad_walk *
            dt

        if Jugador.indice_walk >=
           Jugador.cantidad_walk + 1 then

            Jugador.indice_walk = 1

        end

    else

        local cantidad =
            Jugador.cantidad_idle[
                Jugador.direccion
            ]

        Jugador.indice_idle =
            Jugador.indice_idle +
            Jugador.velocidad_idle *
            dt

        if Jugador.indice_idle >=
           cantidad + 1 then

            Jugador.indice_idle = 1

        end

    end

end


-- =================== DRAW ===================

function Jugador.Draw()

    local sprite
    local quad


    if Jugador.moviendose then

        sprite =
            Jugador.sprite_walk

        local frame =
            math.floor(
                Jugador.indice_walk
            )

        quad =
            Jugador.anim_walk
                [Jugador.direccion]
                [frame]

    else

        sprite =
            Jugador.sprite_idle

        local frame =
            math.floor(
                Jugador.indice_idle
            )

        quad =
            Jugador.anim_idle
                [Jugador.direccion]
                [frame]

    end


    love.graphics.draw(
        sprite,
        quad,
        Jugador.x,
        Jugador.y,
        0,
        Jugador.escala,
        Jugador.escala,
        Jugador.origen_x,
        Jugador.origen_y
    )

end