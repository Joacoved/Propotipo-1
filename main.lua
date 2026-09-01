require("colisiones")
require("arena")
require("jugador")
require("enemigo")
require("sonido")
require("particulas")


local enemigo1
local enemigo2
local enemigo3


local estado_juego =
    "jugando"


local debug_activo =
    false


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


-- CONTAR ENEMIGOS

local function ContarEnemigosRestantes()

    local cantidad =
        0


    if enemigo1.activo then

        cantidad =
            cantidad + 1

    end


    if enemigo2.activo then

        cantidad =
            cantidad + 1

    end


    if enemigo3.activo then

        cantidad =
            cantidad + 1

    end


    return cantidad

end


-- REINICIAR

local function ReiniciarJuego()

    estado_juego =
        "jugando"


    Jugador.Load()


    -- ENEMIGO 1

    enemigo1 =
        Enemigo:Load(
            100,
            180,

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


    enemigo1.vida =
        2

    enemigo1.vida_maxima =
        2


    -- ENEMIGO 2

    enemigo2 =
        Enemigo:Load(
            700,
            180,

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


    enemigo2.vida =
        3

    enemigo2.vida_maxima =
        3


    -- ENEMIGO 3

    enemigo3 =
        Enemigo:Load(
            400,
            480,

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


    enemigo3.vida =
        5

    enemigo3.vida_maxima =
        5


    if particulas ~= nil then

        particulas:reset()

    end

end


-- LOAD

function love.load()

    love.window.setMode(
        800,
        600
    )


    love.window.setTitle(
        "Prototipo1"
    )


    love.graphics.setDefaultFilter(
        "nearest",
        "nearest"
    )


    Arena.Load()

    CargarSonidos()

    CargarParticulas()


    ReiniciarJuego()

end


-- UPDATE

function love.update(dt)

    UpdateParticulas(
        dt
    )


    if estado_juego ~=
       "jugando" then

        return

    end


    Jugador.UpdateInvulnerabilidad(
        dt
    )


    -- MOVIMIENTO JUGADOR

    local jugador_x_anterior =
        Jugador.x


    local jugador_y_anterior =
        Jugador.y


    Jugador.UpdateMovimiento(
        dt
    )


    if JugadorColisiona() then

        Jugador.x =
            jugador_x_anterior

        Jugador.y =
            jugador_y_anterior

        Jugador.UpdateHitbox()

    end


    -- ATAQUE JUGADOR

    Jugador.Atacar(
        dt
    )


    Jugador.UpdateAnimacion(
        dt
    )


    if Jugador.nuevo_ataque then

        enemigo1.golpeado_ataque =
            false

        enemigo2.golpeado_ataque =
            false

        enemigo3.golpeado_ataque =
            false


        ReproducirSonido(
            sonidos.ataque
        )

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


    -- COLISION ENEMIGO 1 Y 2

    enemigo1:ResolverColision(
        enemigo2,

        Jugador.hitbox_x,
        Jugador.hitbox_y,
        Jugador.hitbox_ancho,
        Jugador.hitbox_alto
    )


    -- COLISION ENEMIGO 1 Y 3

    enemigo1:ResolverColision(
        enemigo3,

        Jugador.hitbox_x,
        Jugador.hitbox_y,
        Jugador.hitbox_ancho,
        Jugador.hitbox_alto
    )


    -- COLISION ENEMIGO 2 Y 3

    enemigo2:ResolverColision(
        enemigo3,

        Jugador.hitbox_x,
        Jugador.hitbox_y,
        Jugador.hitbox_ancho,
        Jugador.hitbox_alto
    )


    -- GOLPE ENEMIGO 1

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

        enemigo1:RecibirGolpe(
            1
        )


        enemigo1.golpeado_ataque =
            true


        ReproducirSonido(
            sonidos.golpe_enemigo
        )


        if enemigo1.muerto then

            ParticulasDerrota(
                enemigo1
            )

        else

            ParticulasGolpe(
                enemigo1
            )

        end

    end


    -- GOLPE ENEMIGO 2

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

        enemigo2:RecibirGolpe(
            1
        )


        enemigo2.golpeado_ataque =
            true


        ReproducirSonido(
            sonidos.golpe_enemigo
        )


        if enemigo2.muerto then

            ParticulasDerrota(
                enemigo2
            )

        else

            ParticulasGolpe(
                enemigo2
            )

        end

    end


    -- GOLPE ENEMIGO 3

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

        enemigo3:RecibirGolpe(
            1
        )


        enemigo3.golpeado_ataque =
            true


        ReproducirSonido(
            sonidos.golpe_enemigo
        )


        if enemigo3.muerto then

            ParticulasDerrota(
                enemigo3
            )

        else

            ParticulasGolpe(
                enemigo3
            )

        end

    end


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

        Jugador.RecibirGolpe(
            1
        )


        ReproducirSonido(
            sonidos.golpe_jugador
        )


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


    -- DERROTA

    if Jugador.muerto
       and Jugador.indice_death >=
       Jugador.cantidad_death then

        estado_juego =
            "derrota"


    -- VICTORIA

    elseif not enemigo1.activo
       and not enemigo2.activo
       and not enemigo3.activo then

        estado_juego =
            "victoria"

    end

end


-- TECLADO

function love.keypressed(
    key
)

    if key == "f1" then

        debug_activo =
            not debug_activo

    end


    if key == "r"
       and estado_juego ~=
       "jugando" then

        ReiniciarJuego()

    end

end


-- INTERFAZ

local function DibujarInterfaz()

    local vida_maxima =
        10


    local barra_x =
        20


    local barra_y =
        20


    local barra_ancho =
        200


    local barra_alto =
        20


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
        Jugador.vida /
        vida_maxima


    love.graphics.setColor(
        0.8,
        0.1,
        0.1
    )


    love.graphics.rectangle(
        "fill",
        barra_x,
        barra_y,
        barra_ancho *
        porcentaje,
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
        "Vida: " ..
        Jugador.vida ..
        " / " ..
        vida_maxima,
        85,
        22
    )


    love.graphics.print(
        "Enemigos restantes: " ..
        ContarEnemigosRestantes(),
        610,
        20
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


-- PANTALLA FINAL

local function DibujarPantallaFinal()

    if estado_juego ==
       "jugando" then

        return

    end


    love.graphics.setColor(
        0,
        0,
        0,
        0.7
    )


    love.graphics.rectangle(
        "fill",
        0,
        0,
        800,
        600
    )


    love.graphics.setColor(
        1,
        1,
        1
    )


    if estado_juego ==
       "victoria" then

        love.graphics.printf(
            "VICTORIA",
            0,
            240,
            800,
            "center"
        )


        love.graphics.printf(
            "Has derrotado a todos los enemigos",
            0,
            280,
            800,
            "center"
        )


    elseif estado_juego ==
           "derrota" then

        love.graphics.printf(
            "DERROTA",
            0,
            240,
            800,
            "center"
        )


        love.graphics.printf(
            "Has sido derrotado",
            0,
            280,
            800,
            "center"
        )

    end


    love.graphics.printf(
        "Presiona R para reiniciar",
        0,
        330,
        800,
        "center"
    )


    love.graphics.setColor(
        1,
        1,
        1
    )

end


-- DRAW

function love.draw()

    Arena.Draw()


    Jugador.Draw()


    enemigo1:Draw()
    enemigo2:Draw()
    enemigo3:Draw()


    DrawParticulas()


    enemigo1:DibujarBarraVida()
    enemigo2:DibujarBarraVida()
    enemigo3:DibujarBarraVida()


    -- DEBUG APAGADO POR DEFECTO

    if debug_activo then

        love.graphics.setColor(
            1,
            1,
            1
        )


        Jugador.Debug()

        enemigo1:Debug()
        enemigo2:Debug()
        enemigo3:Debug()

        Arena.Debug()


        love.graphics.setColor(
            1,
            1,
            1
        )

    end


    DibujarInterfaz()


    DibujarPantallaFinal()

end