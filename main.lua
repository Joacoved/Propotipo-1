require("colisiones")
require("arena")
require("jugador")
require("enemigo")
require("sonido")
require("particulas")
require("evento")

local HUD = require("hud")

local Eventos = require("evento")

local MaquinaEstado =
    require("estados.maquina_estado")


local EstadoInicio =
    require("estados.juego.estado_inicio")

local EstadoJugando =
    require("estados.juego.estado_jugando")

local EstadoGameOver =
    require("estados.juego.estado_game_over")

local Orc1 = require("enemigos.orc1")
local Orc2 = require("enemigos.orc2")
local Orc3 = require("enemigos.orc3")

local Juego = {}

local maquina_estado_juego

local enemigos = {}

local oleada_actual = 0
local oleadas_totales = 3

local debug_activo =
    false


-- JUGADOR COLISIONA

local function JugadorColisiona()

    for _, enemigo in ipairs(enemigos) do

        if enemigo.activo
           and not enemigo.muerto
           and Colisiones.AABB(
                Jugador.hitbox_x,
                Jugador.hitbox_y,
                Jugador.hitbox_ancho,
                Jugador.hitbox_alto,

                enemigo.hitbox_x,
                enemigo.hitbox_y,
                enemigo.hitbox_ancho,
                enemigo.hitbox_alto
           ) then

            return true

        end

    end

    return false

end


-- CONTAR ENEMIGOS


local function ContarEnemigosRestantes()

    local cantidad = 0

    for _, enemigo in ipairs(enemigos) do

        if enemigo.activo then

            cantidad =
                cantidad + 1

        end

    end

    return cantidad

end

-- CREAR ENEMIGO ALEATORIO

local function CrearEnemigoAleatorio(
    x,
    y
)

    local tipo =
        math.random(
            1,
            3
        )


    if tipo == 1 then

        return Orc1:Load(
            x,
            y
        )

    elseif tipo == 2 then

        return Orc2:Load(
            x,
            y
        )

    else

        return Orc3:Load(
            x,
            y
        )

    end

end

-- GENERAR OLEADA

local function GenerarOleada(nivel)

    local cantidad =
        2 + nivel

    local patron =
        nivel % 3


    -- PATRON 1


    if patron == 1 then

        local centro_x = 400
        local centro_y = 300

        local radio =
            220


        for i = 1, cantidad do

            local angulo =
                (i / cantidad) *
                (math.pi * 2)


            local x =
                centro_x +
                math.cos(angulo) *
                radio


            local y =
                centro_y +
                math.sin(angulo) *
                radio


local enemigo =
    CrearEnemigoAleatorio(
        x,
        y
    )


            table.insert(
                enemigos,
                enemigo
            )

        end


    -- PATRON 2


    elseif patron == 2 then

        for i = 1, cantidad do

            local x =
                (800 / (cantidad + 1)) *
                i


            local y

            if i % 2 == 0 then

                y = 100

            else

                y = 500

            end


            local enemigo =
    CrearEnemigoAleatorio(
        x,
        y
    )


            table.insert(
                enemigos,
                enemigo
            )

        end


    -- PATRON 3


    else

        for i = 1, cantidad do

            local progreso =
                i /
                (cantidad + 1)


            local x =
                progreso * 800


            local y

            if i % 2 == 0 then

                y =
                    progreso * 600

            else

                y =
                    600 -
                    (progreso * 600)

            end


            local enemigo =
    CrearEnemigoAleatorio(
        x,
        y
    )


            table.insert(
                enemigos,
                enemigo
            )

        end

    end

end


-- REINICIAR

local function ReiniciarJuego()

    Jugador.Load()


enemigos = {}

oleada_actual = 1

GenerarOleada(
    oleada_actual
)


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

    math.randomseed(
    os.time()
)

    ReiniciarJuego()

    maquina_estado_juego =
    MaquinaEstado:Load({

        inicio =
            function()

                return EstadoInicio:Load(
                    Juego
                )

            end,

        jugando =
            function()

                return EstadoJugando:Load(
                    Juego
                )

            end,

        game_over =
            function()

                return EstadoGameOver:Load(
                    Juego
                )

            end

    })

    maquina_estado_juego:Cambiar(
    "inicio"
)

end

function Juego.CambiarEstado(
    nombre,
    parametros
)

    maquina_estado_juego:Cambiar(
        nombre,
        parametros
    )

end

function Juego.Reiniciar()

    ReiniciarJuego()

end

-- UPDATE

function Juego.UpdateJugando(dt)

    UpdateParticulas(
        dt
    )

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

    for _, enemigo in ipairs(enemigos) do

        enemigo.golpeado_ataque =
            false

    end


    ReproducirSonido(
        sonidos.ataque
    )

end


    -- UPDATE ENEMIGOS

    for _, enemigo in ipairs(enemigos) do

    enemigo:Update(
        Jugador.x,
        Jugador.y,

        Jugador.hitbox_x,
        Jugador.hitbox_y,
        Jugador.hitbox_ancho,
        Jugador.hitbox_alto,

        dt
    )

end


   -- COLISION ENTRE ENEMIGOS

for i = 1, #enemigos - 1 do

    for j = i + 1, #enemigos do

        enemigos[i]:ResolverColision(
            enemigos[j],

            Jugador.hitbox_x,
            Jugador.hitbox_y,
            Jugador.hitbox_ancho,
            Jugador.hitbox_alto
        )

    end

end

   -- GOLPE A ENEMIGOS

for _, enemigo in ipairs(enemigos) do

    if Jugador.atacando
       and enemigo.activo
       and not enemigo.muerto
       and not enemigo.golpeado_ataque
       and Colisiones.AABB(
            Jugador.ataque_x,
            Jugador.ataque_y,
            Jugador.ataque_ancho,
            Jugador.ataque_alto,

            enemigo.hitbox_x,
            enemigo.hitbox_y,
            enemigo.hitbox_ancho,
            enemigo.hitbox_alto
       ) then

        enemigo:RecibirGolpe(
            1
        )


        enemigo.golpeado_ataque =
            true


        ReproducirSonido(
            sonidos.golpe_enemigo
        )


        if enemigo.muerto then

            ParticulasDerrota(
                enemigo
            )

        else

            ParticulasGolpe(
                enemigo
            )

        end

    end

end


 -- GOLPE AL JUGADOR

local enemigos_que_golpean = {}


for _, enemigo in ipairs(enemigos) do

    local puede_golpear =
        enemigo.activo
        and enemigo.tocando_jugador
        and not enemigo.golpe_jugador_registrado
        and not enemigo.muerto


    if puede_golpear then

        table.insert(
            enemigos_que_golpean,
            enemigo
        )

    end

end


if #enemigos_que_golpean > 0
   and not Jugador.invulnerable
   and not Jugador.muerto then

    Jugador.RecibirGolpe(
        1
    )


    ReproducirSonido(
        sonidos.golpe_jugador
    )


    for _, enemigo in ipairs(
        enemigos_que_golpean
    ) do

        enemigo:IniciarAtaque()

    end


    for _, enemigo in ipairs(enemigos) do

        if enemigo.tocando_jugador then

            enemigo.golpe_jugador_registrado =
                true

        end

    end

end


    -- DERROTA

    if Jugador.muerto
       and Jugador.indice_death >=
       Jugador.cantidad_death then


        Juego.CambiarEstado(
            "game_over",
            "derrota"
        )


-- VICTORIA

else

    local todos_derrotados = true

    for _, enemigo in ipairs(enemigos) do

        if enemigo.activo then

            todos_derrotados = false
            break

        end

    end


if todos_derrotados then

    if oleada_actual <
       oleadas_totales then

        oleada_actual =
            oleada_actual + 1

        enemigos = {}

        GenerarOleada(
            oleada_actual
        )

    else

        Juego.CambiarEstado(
            "game_over",
            "victoria"
        )

    end

end

end

end

function love.update(dt)

    maquina_estado_juego:Update(
        dt
    )

end

-- TECLADO

function love.keypressed(
    key
)

    local estado_actual =
        maquina_estado_juego.actual


    if estado_actual.KeyPressed then

        estado_actual:KeyPressed(
            key
        )

    end

    if key == "f1" then

        debug_activo =
            not debug_activo

    end


end

-- DRAW

function Juego.DrawJugando()

    Arena.Draw()


    Jugador.Draw()


for _, enemigo in ipairs(enemigos) do

    enemigo:Draw()

end


    DrawParticulas()


for _, enemigo in ipairs(enemigos) do

    enemigo:DibujarBarraVida()

end


    -- DEBUG APAGADO POR DEFECTO

    if debug_activo then

        love.graphics.setColor(
            1,
            1,
            1
        )


        Jugador.Debug()

 for _, enemigo in ipairs(enemigos) do

    enemigo:Debug()

end

        Arena.Debug()


        love.graphics.setColor(
            1,
            1,
            1
        )

    end


HUD.Draw(
    Jugador.vida,
    ContarEnemigosRestantes(),
    oleada_actual,
    oleadas_totales
)


end

function love.draw()

    maquina_estado_juego:Draw()

end