require("colisiones")
require("jugador")
require("enemigo")


local enemigo1
local enemigo2
local enemigo3


-- JUGADOR COLISIONA

local function JugadorColisiona()

    if enemigo1.activo
       and not enemigo1.muerto
       and Colisiones.AABB(
            Jugador.hitbox_x,
            Jugador.hitbox_y,
            Jugador.hitbox_ancho,
            Jugador.hitbox_alto,

            enemigo1.hitbox_x,
            enemigo1.hitbox_y,
            enemigo1.hitbox_ancho,
            enemigo1.hitbox_alto
       ) then

        return true

    end


    if enemigo2.activo
       and not enemigo2.muerto
       and Colisiones.AABB(
            Jugador.hitbox_x,
            Jugador.hitbox_y,
            Jugador.hitbox_ancho,
            Jugador.hitbox_alto,

            enemigo2.hitbox_x,
            enemigo2.hitbox_y,
            enemigo2.hitbox_ancho,
            enemigo2.hitbox_alto
       ) then

        return true

    end


    if enemigo3.activo
       and not enemigo3.muerto
       and Colisiones.AABB(
            Jugador.hitbox_x,
            Jugador.hitbox_y,
            Jugador.hitbox_ancho,
            Jugador.hitbox_alto,

            enemigo3.hitbox_x,
            enemigo3.hitbox_y,
            enemigo3.hitbox_ancho,
            enemigo3.hitbox_alto
       ) then

        return true

    end


    return false

end


function love.load()

    love.window.setMode(
        800,
        600
    )


    love.window.setTitle(
        "Prototipo1"
    )


    Jugador.Load()


    -- ENEMIGO 1

    enemigo1 =
        Enemigo:Load(
            100,
            100,

            "assets/enemigos/orc1_walk_without_shadow.png",
            "assets/enemigos/orc1_attack_without_shadow.png",
            "assets/enemigos/orc1_hurt_without_shadow.png",
            "assets/enemigos/orc1_death_without_shadow.png",

            80,
            1.85,
            42,
            52,
            0,
            -6
        )


    enemigo1.vida = 2


    -- ENEMIGO 2

    enemigo2 =
        Enemigo:Load(
            700,
            100,

            "assets/enemigos/orc2_walk_without_shadow.png",
            "assets/enemigos/orc2_attack_without_shadow.png",
            "assets/enemigos/orc2_hurt_without_shadow.png",
            "assets/enemigos/orc2_death_without_shadow.png",

            100,
            2.0,
            50,
            60,
            0,
            -9
        )


    enemigo2.vida = 3


    -- ENEMIGO 3

    enemigo3 =
        Enemigo:Load(
            400,
            500,

            "assets/enemigos/orc3_walk_without_shadow.png",
            "assets/enemigos/orc3_attack_without_shadow.png",
            "assets/enemigos/orc3_hurt_without_shadow.png",
            "assets/enemigos/orc3_death_without_shadow.png",

            120,
            2.15,
            58,
            68,
            0,
            -12
        )


    enemigo3.vida = 5

end


function love.update(dt)

    -- INVULNERABILIDAD JUGADOR

    Jugador.UpdateInvulnerabilidad(dt)


    -- MOVIMIENTO JUGADOR

    local jugador_x_anterior =
        Jugador.x

    local jugador_y_anterior =
        Jugador.y


    Jugador.UpdateMovimiento(dt)


    if JugadorColisiona() then

        Jugador.x =
            jugador_x_anterior

        Jugador.y =
            jugador_y_anterior

        Jugador.UpdateHitbox()

    end

        -- ATAQUE JUGADOR
-- ATAQUE JUGADOR

    -- ATAQUE JUGADOR

    Jugador.Atacar(dt)

    Jugador.UpdateAnimacion(dt)


    -- NUEVO ATAQUE

    if Jugador.nuevo_ataque then

        enemigo1.golpeado_ataque = false
        enemigo2.golpeado_ataque = false
        enemigo3.golpeado_ataque = false

    end


    -- UPDATE ENEMIGOS

    enemigo1:Update(
        Jugador.x,
        Jugador.y,

        Jugador.hitbox_x,
        Jugador.hitbox_y,
        Jugador.hitbox_ancho,
        Jugador.hitbox_alto,

        dt
    )


    enemigo2:Update(
        Jugador.x,
        Jugador.y,

        Jugador.hitbox_x,
        Jugador.hitbox_y,
        Jugador.hitbox_ancho,
        Jugador.hitbox_alto,

        dt
    )


    enemigo3:Update(
        Jugador.x,
        Jugador.y,

        Jugador.hitbox_x,
        Jugador.hitbox_y,
        Jugador.hitbox_ancho,
        Jugador.hitbox_alto,

        dt
    )


    -- COLISION ENTRE ENEMIGOS

    if enemigo1.activo
       and not enemigo1.muerto
       and enemigo2.activo
       and not enemigo2.muerto then

        enemigo1:ResolverColision(
            enemigo2,

            Jugador.hitbox_x,
            Jugador.hitbox_y,
            Jugador.hitbox_ancho,
            Jugador.hitbox_alto
        )

    end


    if enemigo1.activo
       and not enemigo1.muerto
       and enemigo3.activo
       and not enemigo3.muerto then

        enemigo1:ResolverColision(
            enemigo3,

            Jugador.hitbox_x,
            Jugador.hitbox_y,
            Jugador.hitbox_ancho,
            Jugador.hitbox_alto
        )

    end


    if enemigo2.activo
       and not enemigo2.muerto
       and enemigo3.activo
       and not enemigo3.muerto then

        enemigo2:ResolverColision(
            enemigo3,

            Jugador.hitbox_x,
            Jugador.hitbox_y,
            Jugador.hitbox_ancho,
            Jugador.hitbox_alto
        )

    end


    -- GOLPE A ENEMIGO 1

    if Jugador.atacando
       and enemigo1.activo
       and not enemigo1.muerto
       and not enemigo1.golpeado_ataque
       and Colisiones.AABB(
            Jugador.ataque_x,
            Jugador.ataque_y,
            Jugador.ataque_ancho,
            Jugador.ataque_alto,

            enemigo1.hitbox_x,
            enemigo1.hitbox_y,
            enemigo1.hitbox_ancho,
            enemigo1.hitbox_alto
       ) then

        enemigo1:RecibirGolpe(1)

        enemigo1.golpeado_ataque =
            true

    end


-- GOLPE A ENEMIGO 2
    -- GOLPE A ENEMIGO 2

    if Jugador.atacando
       and enemigo2.activo
       and not enemigo2.muerto
       and not enemigo2.golpeado_ataque
       and Colisiones.AABB(
            Jugador.ataque_x,
            Jugador.ataque_y,
            Jugador.ataque_ancho,
            Jugador.ataque_alto,

            enemigo2.hitbox_x,
            enemigo2.hitbox_y,
            enemigo2.hitbox_ancho,
            enemigo2.hitbox_alto
       ) then

        enemigo2:RecibirGolpe(1)

        enemigo2.golpeado_ataque =
            true

    end


    -- GOLPE A ENEMIGO 3

    if Jugador.atacando
       and enemigo3.activo
       and not enemigo3.muerto
       and not enemigo3.golpeado_ataque
       and Colisiones.AABB(
            Jugador.ataque_x,
            Jugador.ataque_y,
            Jugador.ataque_ancho,
            Jugador.ataque_alto,

            enemigo3.hitbox_x,
            enemigo3.hitbox_y,
            enemigo3.hitbox_ancho,
            enemigo3.hitbox_alto
       ) then

        enemigo3:RecibirGolpe(1)

        enemigo3.golpeado_ataque =
            true

    end


    -- COLISION ENTRE ENEMIGOS
    -- GOLPE AL JUGADOR

    local golpe_enemigo1 =
        enemigo1.activo
        and enemigo1.tocando_jugador
        and not enemigo1.golpe_jugador_registrado
        and not enemigo1.muerto


    local golpe_enemigo2 =
        enemigo2.activo
        and enemigo2.tocando_jugador
        and not enemigo2.golpe_jugador_registrado
        and not enemigo2.muerto


    local golpe_enemigo3 =
        enemigo3.activo
        and enemigo3.tocando_jugador
        and not enemigo3.golpe_jugador_registrado
        and not enemigo3.muerto


    local enemigo_puede_golpear =
        golpe_enemigo1
        or golpe_enemigo2
        or golpe_enemigo3


    if enemigo_puede_golpear
       and not Jugador.invulnerable
       and not Jugador.muerto then

        Jugador.RecibirGolpe(1)


        if golpe_enemigo1 then

            enemigo1:IniciarAtaque()

        end


        if golpe_enemigo2 then

            enemigo2:IniciarAtaque()

        end


        if golpe_enemigo3 then

            enemigo3:IniciarAtaque()

        end


        if enemigo1.tocando_jugador then

            enemigo1.golpe_jugador_registrado =
                true

        end


        if enemigo2.tocando_jugador then

            enemigo2.golpe_jugador_registrado =
                true

        end


        if enemigo3.tocando_jugador then

            enemigo3.golpe_jugador_registrado =
                true

        end

    end

end


function love.draw()

    Jugador.Draw()


    enemigo1:Draw()
    enemigo2:Draw()
    enemigo3:Draw()


    -- DEBUG

    Jugador.Debug()

    enemigo1:Debug()
    enemigo2:Debug()
    enemigo3:Debug()


    -- INFORMACION TEMPORAL

    love.graphics.print(
        "Vida jugador: " ..
        Jugador.vida,
        10,
        10
    )


    love.graphics.print(
        "Vida E1: " ..
        enemigo1.vida,
        10,
        30
    )


    love.graphics.print(
        "Vida E2: " ..
        enemigo2.vida,
        10,
        50
    )


    love.graphics.print(
        "Vida E3: " ..
        enemigo3.vida,
        10,
        70
    )

end