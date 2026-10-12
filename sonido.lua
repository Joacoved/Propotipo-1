local Eventos = require("evento")

sonidos = {}


-- CARGAR SONIDOS

function CargarSonidos()

    sonidos = {

        ataque =
            love.audio.newSource(
                "assets/jugador/ataque.wav",
                "static"
            ),

        golpe_enemigo =
            love.audio.newSource(
                "assets/enemigos/golpe_enemigo.wav",
                "static"
            ),

        golpe_jugador =
            love.audio.newSource(
                "assets/jugador/golpe_jugador.wav",
                "static"
            )

    }

end


-- REPRODUCIR SONIDO

function ReproducirSonido(sonido)

    sonido:stop()

    sonido:play()

end

-- EVENTO DE ATAQUE DEL JUGADOR

Eventos.on("jugador_ataca", function()

    ReproducirSonido(
        sonidos.ataque
    )

end)

-- EVENTO DE GOLPE AL ENEMIGO

Eventos.on("enemigo_golpeado", function()

    ReproducirSonido(
        sonidos.golpe_enemigo
    )

end)

-- EVENTO DE GOLPE AL JUGADOR

Eventos.on("jugador_golpeado", function()

    ReproducirSonido(
        sonidos.golpe_jugador
    )

end)