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