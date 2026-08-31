require("colisiones")
require("jugador")
require("enemigo")


local enemigo1
local enemigo2
local enemigo3

local colision_detectada = false


-- RESOLVER COLISION JUGADOR / ENEMIGO

local function ResolverColisionJugadorEnemigo(
    enemigo,
    x_anterior,
    y_anterior
)

    if Colisiones.AABB(
        Jugador.hitbox_x,
        Jugador.hitbox_y,
        Jugador.hitbox_ancho,
        Jugador.hitbox_alto,

        enemigo.hitbox_x,
        enemigo.hitbox_y,
        enemigo.hitbox_ancho,
        enemigo.hitbox_alto
    ) then

        enemigo.x =
            x_anterior

        enemigo.y =
            y_anterior

        enemigo:UpdateHitbox()

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


    colision_detectada = false


    -- ENEMIGO 1

    local enemigo1_x_anterior =
        enemigo1.x

    local enemigo1_y_anterior =
        enemigo1.y


    enemigo1:Update(
        Jugador.x,
        Jugador.y,
        dt
    )


    if ResolverColisionJugadorEnemigo(
        enemigo1,
        enemigo1_x_anterior,
        enemigo1_y_anterior
    ) then

        colision_detectada = true

    end


    -- ENEMIGO 2

    local enemigo2_x_anterior =
        enemigo2.x

    local enemigo2_y_anterior =
        enemigo2.y


    enemigo2:Update(
        Jugador.x,
        Jugador.y,
        dt
    )


    if ResolverColisionJugadorEnemigo(
        enemigo2,
        enemigo2_x_anterior,
        enemigo2_y_anterior
    ) then

        colision_detectada = true

    end


    -- ENEMIGO 3

    local enemigo3_x_anterior =
        enemigo3.x

    local enemigo3_y_anterior =
        enemigo3.y


    enemigo3:Update(
        Jugador.x,
        Jugador.y,
        dt
    )


    if ResolverColisionJugadorEnemigo(
        enemigo3,
        enemigo3_x_anterior,
        enemigo3_y_anterior
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