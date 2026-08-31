require("colisiones")
require("jugador")
require("enemigo")

local enemigo1
local enemigo2
local enemigo3

local colision_detectada = false

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
            1.85,
            42,
            52,
            0,
            -6
        )
    
    enemigo2 =
    Enemigo:Load(
        700,
        100,
        "assets/enemigos/orc2_walk_without_shadow.png",
        100,
        2.0,
        50,
        60,
        0,
        -9
    )


    enemigo3 =
    Enemigo:Load(
        400,
        500,
        "assets/enemigos/orc3_walk_without_shadow.png",
        120,
        2.15,
        58,
        68,
        0,
        -12
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

colision_detectada = false


if Colisiones.AABB(
    Jugador.hitbox_x,
    Jugador.hitbox_y,
    Jugador.hitbox_ancho,
    Jugador.hitbox_alto,

    enemigo1.hitbox_x,
    enemigo1.hitbox_y,
    enemigo1.hitbox_ancho,
    enemigo1.hitbox_alto
) then

    colision_detectada = true

end


if Colisiones.AABB(
    Jugador.hitbox_x,
    Jugador.hitbox_y,
    Jugador.hitbox_ancho,
    Jugador.hitbox_alto,

    enemigo2.hitbox_x,
    enemigo2.hitbox_y,
    enemigo2.hitbox_ancho,
    enemigo2.hitbox_alto
) then

    colision_detectada = true

end


if Colisiones.AABB(
    Jugador.hitbox_x,
    Jugador.hitbox_y,
    Jugador.hitbox_ancho,
    Jugador.hitbox_alto,

    enemigo3.hitbox_x,
    enemigo3.hitbox_y,
    enemigo3.hitbox_ancho,
    enemigo3.hitbox_alto
) then

    colision_detectada = true

end

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

    if colision_detectada then

    love.graphics.print(
        "COLISION",
        10,
        10
    )

end
end