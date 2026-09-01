Jugador = {}

Jugador.x = 400
Jugador.y = 330

Jugador.velocidad = 200

Jugador.escala = 1.7

Jugador.origen_x = 32
Jugador.origen_y = 32


Jugador.hitbox_ancho = 34
Jugador.hitbox_alto = 44

Jugador.hitbox_x = 0
Jugador.hitbox_y = 0


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


-- LOAD

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

    Jugador.UpdateHitbox()

end


-- CREAR ANIMACIONES

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


    -- IDLE

    for fila = 0, 3 do

        local direccion =
            direcciones[fila + 1]

        local cantidad =
            Jugador.cantidad_idle[direccion]


        for columna = 0,
            cantidad - 1 do

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


    -- WALK

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


-- HITBOX

function Jugador.UpdateHitbox()

    Jugador.hitbox_x =
        Jugador.x -
        Jugador.hitbox_ancho / 2

    Jugador.hitbox_y =
        Jugador.y -
        Jugador.hitbox_alto / 2

end


-- MOVIMIENTO

function Jugador.UpdateMovimiento(dt)

    Jugador.moviendose = false


    if love.keyboard.isDown("w") then

        Jugador.y =
            Jugador.y -
            Jugador.velocidad *
            dt

        Jugador.direccion = "arriba"

        Jugador.moviendose = true


    elseif love.keyboard.isDown("s") then

        Jugador.y =
            Jugador.y +
            Jugador.velocidad *
            dt

        Jugador.direccion = "abajo"

        Jugador.moviendose = true


    elseif love.keyboard.isDown("a") then

        Jugador.x =
            Jugador.x -
            Jugador.velocidad *
            dt

        Jugador.direccion = "izquierda"

        Jugador.moviendose = true


    elseif love.keyboard.isDown("d") then

        Jugador.x =
            Jugador.x +
            Jugador.velocidad *
            dt

        Jugador.direccion = "derecha"

        Jugador.moviendose = true

    end


    Jugador.UpdateHitbox()

end


-- UPDATE ANIMACION

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


-- DRAW

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


-- DEBUG

function Jugador.Debug()

    love.graphics.rectangle(
        "line",
        Jugador.hitbox_x,
        Jugador.hitbox_y,
        Jugador.hitbox_ancho,
        Jugador.hitbox_alto
    )


    love.graphics.circle(
        "fill",
        Jugador.x,
        Jugador.y,
        2
    )

end