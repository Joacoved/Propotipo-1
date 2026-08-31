require("jugador")
require("enemigo")

local enemigo1

function love.load()

    love.window.setMode(
        800,
        600
    )

    love.window.setTitle(
        "Prototipo1"
    )

    Jugador.Load()

        enemigo1 =
        Enemigo:Load(
            100,
            100,
            "assets/enemigos/orc1_walk_without_shadow.png",
            80,
            1.85
        )



end


function love.update(dt)

    Jugador.UpdateMovimiento(dt)

    Jugador.UpdateAnimacion(dt)

     enemigo1:Update(
        Jugador.x,
        Jugador.y,
        dt
    )

end


function love.draw()

    Jugador.Draw()

    enemigo1:Draw()

    Jugador.Debug()

end