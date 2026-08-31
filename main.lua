require("jugador")


function love.load()

    love.window.setMode(
        800,
        600
    )

    love.window.setTitle(
        "Prototipo1"
    )

    Jugador.Load()

end


function love.update(dt)

    Jugador.UpdateMovimiento(dt)

    Jugador.UpdateAnimacion(dt)

end


function love.draw()

    Jugador.Draw()

    Jugador.Debug()

end