require("jugador")
require("enemigo")

local enemigo1
local enemigo2
local enemigo3

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
    
    enemigo2 =
    Enemigo:Load(
        700,
        100,
        "assets/enemigos/orc2_walk_without_shadow.png",
        100,
        2.0
    )


    enemigo3 =
    Enemigo:Load(
        400,
        500,
        "assets/enemigos/orc3_walk_without_shadow.png",
        120,
        2.15
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

    enemigo2:Update(
    Jugador.x,
    Jugador.y,
    dt
)

    enemigo3:Update(
    Jugador.x,
    Jugador.y,
    dt
)

end


function love.draw()

    Jugador.Draw()

    enemigo1:Draw()
    enemigo2:Draw()
    enemigo3:Draw()

    Jugador.Debug()

    enemigo1:Debug()
    enemigo2:Debug()
    enemigo3:Debug()

end