Jugador = {}


Jugador.x = 400
Jugador.y = 330

Jugador.velocidad = 200

Jugador.vida = 10

Jugador.escala = 1.7

Jugador.origen_x = 32
Jugador.origen_y = 32


-- HITBOX

Jugador.hitbox_ancho = 34
Jugador.hitbox_alto = 44

Jugador.hitbox_x = 0
Jugador.hitbox_y = 0


-- ESTADO

Jugador.direccion = "derecha"

Jugador.moviendose = false

Jugador.atacando = false
Jugador.nuevo_ataque = false

Jugador.ataque_en_movimiento = false

Jugador.hurt = false
Jugador.muerto = false


-- SPRITES

Jugador.sprite_idle = nil
Jugador.sprite_walk = nil
Jugador.sprite_ataque = nil
Jugador.sprite_walk_ataque = nil
Jugador.sprite_hurt = nil
Jugador.sprite_death = nil


-- ANIMACIONES

Jugador.anim_idle = {}
Jugador.anim_walk = {}
Jugador.anim_ataque = {}
Jugador.anim_walk_ataque = {}
Jugador.anim_hurt = {}
Jugador.anim_death = {}


Jugador.indice_idle = 1
Jugador.indice_walk = 1
Jugador.indice_ataque = 1
Jugador.indice_walk_ataque = 1
Jugador.indice_hurt = 1
Jugador.indice_death = 1


Jugador.velocidad_idle = 8
Jugador.velocidad_walk = 10
Jugador.velocidad_ataque = 14
Jugador.velocidad_walk_ataque = 10
Jugador.velocidad_hurt = 10
Jugador.velocidad_death = 8


Jugador.cantidad_idle = {
    abajo = 12,
    izquierda = 12,
    derecha = 12,
    arriba = 4
}

Jugador.cantidad_walk = 6
Jugador.cantidad_ataque = 8
Jugador.cantidad_walk_ataque = 6
Jugador.cantidad_hurt = 5
Jugador.cantidad_death = 7

-- COMBATE

-- COMBATE

Jugador.ataque_x = 0
Jugador.ataque_y = 0

Jugador.ataque_ancho = 0
Jugador.ataque_alto = 0


Jugador.ataque_ancho_horizontal = 30
Jugador.ataque_alto_horizontal = 35

Jugador.ataque_ancho_vertical = 35
Jugador.ataque_alto_vertical = 30


Jugador.cooldown_ataque = 0
Jugador.tiempo_cooldown = 0.6

Jugador.tiempo_ataque = 0
Jugador.duracion_ataque = 0.55


-- INVULNERABILIDAD

Jugador.invulnerable = false

Jugador.tiempo_invulnerable = 0
Jugador.duracion_invulnerable = 1

Jugador.tiempo_golpe = 0
Jugador.duracion_golpe = 0.6


-- LOAD

function Jugador.Load()

    Jugador.x = 400
    Jugador.y = 330

    Jugador.vida = 10


    Jugador.direccion = "derecha"

    Jugador.moviendose = false

    Jugador.atacando = false
    Jugador.nuevo_ataque = false

    Jugador.ataque_en_movimiento = false

    Jugador.hurt = false
    Jugador.muerto = false


    Jugador.invulnerable = false

    Jugador.tiempo_invulnerable = 0
    Jugador.tiempo_golpe = 0


    Jugador.cooldown_ataque = 0
    Jugador.tiempo_ataque = 0


    Jugador.indice_idle = 1
    Jugador.indice_walk = 1
    Jugador.indice_ataque = 1
    Jugador.indice_walk_ataque = 1
    Jugador.indice_hurt = 1
    Jugador.indice_death = 1


    -- SPRITES

    Jugador.sprite_idle =
        love.graphics.newImage(
            "assets/jugador/Swordsman_lvl1_Idle_without_shadow.png"
        )


    Jugador.sprite_walk =
        love.graphics.newImage(
            "assets/jugador/Swordsman_lvl1_Walk_without_shadow.png"
        )


    Jugador.sprite_ataque =
        love.graphics.newImage(
            "assets/jugador/Swordsman_lvl1_attack_without_shadow.png"
        )


    Jugador.sprite_walk_ataque =
        love.graphics.newImage(
            "assets/jugador/Swordsman_lvl1_Walk_Attack_without_shadow.png"
        )


    Jugador.sprite_hurt =
        love.graphics.newImage(
            "assets/jugador/Swordsman_lvl1_Hurt_without_shadow.png"
        )


    Jugador.sprite_death =
        love.graphics.newImage(
            "assets/jugador/Swordsman_lvl1_Death_without_shadow.png"
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


    Jugador.anim_ataque = {
        abajo = {},
        izquierda = {},
        derecha = {},
        arriba = {}
    }


    Jugador.anim_walk_ataque = {
        abajo = {},
        izquierda = {},
        derecha = {},
        arriba = {}
    }


    Jugador.anim_hurt = {
        abajo = {},
        izquierda = {},
        derecha = {},
        arriba = {}
    }


    Jugador.anim_death = {
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


    -- ATTACK

    for fila = 0, 3 do

        local direccion =
            direcciones[fila + 1]


        for columna = 0,
            Jugador.cantidad_ataque - 1 do

            table.insert(
                Jugador.anim_ataque[direccion],

                love.graphics.newQuad(
                    columna * 64,
                    fila * 64,
                    64,
                    64,
                    Jugador.sprite_ataque
                )
            )

        end

    end


    -- WALK ATTACK

    for fila = 0, 3 do

        local direccion =
            direcciones[fila + 1]


        for columna = 0,
            Jugador.cantidad_walk_ataque - 1 do

            table.insert(
                Jugador.anim_walk_ataque[direccion],

                love.graphics.newQuad(
                    columna * 64,
                    fila * 64,
                    64,
                    64,
                    Jugador.sprite_walk_ataque
                )
            )

        end

    end


    -- HURT

    for fila = 0, 3 do

        local direccion =
            direcciones[fila + 1]


        for columna = 0,
            Jugador.cantidad_hurt - 1 do

            table.insert(
                Jugador.anim_hurt[direccion],

                love.graphics.newQuad(
                    columna * 64,
                    fila * 64,
                    64,
                    64,
                    Jugador.sprite_hurt
                )
            )

        end

    end


    -- DEATH

    for fila = 0, 3 do

        local direccion =
            direcciones[fila + 1]


        for columna = 0,
            Jugador.cantidad_death - 1 do

            table.insert(
                Jugador.anim_death[direccion],

                love.graphics.newQuad(
                    columna * 64,
                    fila * 64,
                    64,
                    64,
                    Jugador.sprite_death
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


-- INVULNERABILIDAD

function Jugador.UpdateInvulnerabilidad(dt)

    if Jugador.invulnerable then

        Jugador.tiempo_invulnerable =
            Jugador.tiempo_invulnerable -
            dt


        if Jugador.tiempo_invulnerable <= 0 then

            Jugador.tiempo_invulnerable = 0

            Jugador.invulnerable = false

        end

    end


    if Jugador.tiempo_golpe > 0 then

        Jugador.tiempo_golpe =
            Jugador.tiempo_golpe -
            dt


        if Jugador.tiempo_golpe < 0 then

            Jugador.tiempo_golpe = 0

        end

    end

end


-- MOVIMIENTO

function Jugador.UpdateMovimiento(dt)

    Jugador.moviendose = false


    if Jugador.muerto then

        return

    end


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


-- ATAQUE

function Jugador.Atacar(dt)

    
    Jugador.nuevo_ataque = false


    if Jugador.hurt
       or Jugador.muerto then

        Jugador.atacando = false

        return

    end


    -- COOLDOWN

    if Jugador.cooldown_ataque > 0 then

        Jugador.cooldown_ataque =
            Jugador.cooldown_ataque -
            dt

    end


    -- DURACION DEL ATAQUE
    -- DURACION

    if Jugador.tiempo_ataque > 0 then

        Jugador.tiempo_ataque =
            Jugador.tiempo_ataque -
            dt

        Jugador.atacando = true

    else

        Jugador.tiempo_ataque = 0

        Jugador.atacando = false

    end


    -- INICIAR ATAQUE
    -- INICIAR

    if love.keyboard.isDown("space")
       and Jugador.cooldown_ataque <= 0
       and not Jugador.atacando then

        Jugador.atacando = true
        Jugador.nuevo_ataque = true


        Jugador.ataque_en_movimiento =
            Jugador.moviendose


        Jugador.cooldown_ataque =
            Jugador.tiempo_cooldown


        Jugador.tiempo_ataque =
            Jugador.duracion_ataque


        Jugador.indice_ataque = 1
        Jugador.indice_walk_ataque = 1

    end


    -- HITBOX DEL ATAQUE
    -- HITBOX ATAQUE

    if Jugador.atacando then


        
        -- DERECHA

        if Jugador.direccion == "derecha" then

            Jugador.ataque_ancho =
                Jugador.ataque_ancho_horizontal

            Jugador.ataque_alto =
                Jugador.ataque_alto_horizontal


            Jugador.ataque_x =
                Jugador.x +
                Jugador.hitbox_ancho / 2

            Jugador.ataque_y =
                Jugador.y -
                Jugador.ataque_alto / 2


        
        -- IZQUIERDA

        elseif Jugador.direccion == "izquierda" then

            Jugador.ataque_ancho =
                Jugador.ataque_ancho_horizontal

            Jugador.ataque_alto =
                Jugador.ataque_alto_horizontal


            Jugador.ataque_x =
                Jugador.x -
                Jugador.hitbox_ancho / 2 -
                Jugador.ataque_ancho

            Jugador.ataque_y =
                Jugador.y -
                Jugador.ataque_alto / 2


        
        -- ARRIBA

        elseif Jugador.direccion == "arriba" then

            Jugador.ataque_ancho =
                Jugador.ataque_ancho_vertical

            Jugador.ataque_alto =
                Jugador.ataque_alto_vertical


            Jugador.ataque_x =
                Jugador.x -
                Jugador.ataque_ancho / 2

            Jugador.ataque_y =
                Jugador.y -
                Jugador.hitbox_alto / 2 -
                Jugador.ataque_alto


        
        -- ABAJO

        elseif Jugador.direccion == "abajo" then

            Jugador.ataque_ancho =
                Jugador.ataque_ancho_vertical

            Jugador.ataque_alto =
                Jugador.ataque_alto_vertical


            Jugador.ataque_x =
                Jugador.x -
                Jugador.ataque_ancho / 2

            Jugador.ataque_y =
                Jugador.y +
                Jugador.hitbox_alto / 2

        end

    end

end


-- UPDATE ANIMACION

function Jugador.UpdateAnimacion(dt)

    -- DEATH

    if Jugador.muerto then

        Jugador.indice_death =
            Jugador.indice_death +
            Jugador.velocidad_death *
            dt


        if Jugador.indice_death >
           Jugador.cantidad_death then

            Jugador.indice_death =
                Jugador.cantidad_death

        end


        return

    end


    -- HURT

    if Jugador.hurt then

        Jugador.indice_hurt =
            Jugador.indice_hurt +
            Jugador.velocidad_hurt *
            dt


        if Jugador.indice_hurt >
           Jugador.cantidad_hurt then

            Jugador.indice_hurt = 1

            Jugador.hurt = false

        end


        return

    end


    -- WALK ATTACK

    if Jugador.atacando
       and Jugador.ataque_en_movimiento then

        Jugador.indice_walk_ataque =
            Jugador.indice_walk_ataque +
            Jugador.velocidad_walk_ataque *
            dt


        if Jugador.indice_walk_ataque >
           Jugador.cantidad_walk_ataque then

            Jugador.indice_walk_ataque =
                Jugador.cantidad_walk_ataque

        end


        return

    end


    -- ATTACK

    if Jugador.atacando then

        Jugador.indice_ataque =
            Jugador.indice_ataque +
            Jugador.velocidad_ataque *
            dt


        if Jugador.indice_ataque >
           Jugador.cantidad_ataque then

            Jugador.indice_ataque =
                Jugador.cantidad_ataque

        end


        return

    end


    -- WALK

    if Jugador.moviendose then

        Jugador.indice_walk =
            Jugador.indice_walk +
            Jugador.velocidad_walk *
            dt


        if Jugador.indice_walk >=
           Jugador.cantidad_walk + 1 then

            Jugador.indice_walk = 1

        end


        return

    end


    -- IDLE

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


-- RECIBIR GOLPE

function Jugador.RecibirGolpe(cantidad)

    if Jugador.invulnerable
       or Jugador.muerto then

        return

    end


    Jugador.vida =
        Jugador.vida -
        cantidad


    if Jugador.vida < 0 then

        Jugador.vida = 0

    end


    Jugador.invulnerable = true


    Jugador.tiempo_invulnerable =
        Jugador.duracion_invulnerable


    Jugador.tiempo_golpe =
        Jugador.duracion_golpe


    -- CANCELAR ATAQUE

    Jugador.atacando = false
    Jugador.tiempo_ataque = 0


    -- MUERTE

    if Jugador.vida <= 0 then

        Jugador.muerto = true
        Jugador.hurt = false

        Jugador.indice_death = 1


    -- HURT

    else

        Jugador.hurt = true

        Jugador.indice_hurt = 1

    end

end


-- DRAW

function Jugador.Draw()

    local sprite
    local quad


    -- DEATH

    if Jugador.muerto then

        sprite =
            Jugador.sprite_death


        local frame =
            math.floor(
                Jugador.indice_death
            )


        if frame >
           Jugador.cantidad_death then

            frame =
                Jugador.cantidad_death

        end


        quad =
            Jugador.anim_death
                [Jugador.direccion]
                [frame]


    -- HURT

    elseif Jugador.hurt then

        sprite =
            Jugador.sprite_hurt


        local frame =
            math.floor(
                Jugador.indice_hurt
            )


        if frame >
           Jugador.cantidad_hurt then

            frame =
                Jugador.cantidad_hurt

        end


        quad =
            Jugador.anim_hurt
                [Jugador.direccion]
                [frame]


    -- WALK ATTACK

    elseif Jugador.atacando
       and Jugador.ataque_en_movimiento then

        sprite =
            Jugador.sprite_walk_ataque


        local frame =
            math.floor(
                Jugador.indice_walk_ataque
            )


        if frame >
           Jugador.cantidad_walk_ataque then

            frame =
                Jugador.cantidad_walk_ataque

        end


        quad =
            Jugador.anim_walk_ataque
                [Jugador.direccion]
                [frame]


    -- ATTACK

    elseif Jugador.atacando then

        sprite =
            Jugador.sprite_ataque


        local frame =
            math.floor(
                Jugador.indice_ataque
            )


        if frame >
           Jugador.cantidad_ataque then

            frame =
                Jugador.cantidad_ataque

        end


        quad =
            Jugador.anim_ataque
                [Jugador.direccion]
                [frame]


    -- WALK

    elseif Jugador.moviendose then

        sprite =
            Jugador.sprite_walk


        local frame =
            math.floor(
                Jugador.indice_walk
            )


        if frame >
           Jugador.cantidad_walk then

            frame = 1
            Jugador.indice_walk = 1

        end


        quad =
            Jugador.anim_walk
                [Jugador.direccion]
                [frame]


    -- IDLE

    else

        sprite =
            Jugador.sprite_idle


        local cantidad =
            Jugador.cantidad_idle[
                Jugador.direccion
            ]


        local frame =
            math.floor(
                Jugador.indice_idle
            )


        if frame > cantidad then

            frame = 1

            Jugador.indice_idle = 1

        end


        quad =
            Jugador.anim_idle
                [Jugador.direccion]
                [frame]

    end


    -- PARPADEO AL RECIBIR GOLPE

    local mostrar = true


    if not Jugador.muerto
       and Jugador.tiempo_golpe > 0 then

        mostrar =
            math.floor(
                Jugador.tiempo_golpe * 8
            ) % 2 == 0

    end


    if mostrar then

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


    if Jugador.atacando then

        love.graphics.rectangle(
            "line",
            Jugador.ataque_x,
            Jugador.ataque_y,
            Jugador.ataque_ancho,
            Jugador.ataque_alto
        )

    end

end