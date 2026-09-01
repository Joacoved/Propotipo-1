require("colisiones")
require("jugador")
require("enemigo")


local enemigo1
local enemigo2
local enemigo3


-- JUGADOR COLISIONA

local function JugadorColisiona()

if enemigo1.activo
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

        enemigo1.vida = 2

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

        enemigo2.vida = 3

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

        enemigo3.vida = 5

end


function love.update(dt)

    -- MOVIMIENTO JUGADOR
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

    -- GOLPE A ENEMIGO 1

if Jugador.atacando
   and enemigo1.activo
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

    enemigo1.golpeado_ataque = true

end


-- GOLPE A ENEMIGO 2

if Jugador.atacando
   and enemigo2.activo
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

    enemigo2.golpeado_ataque = true

end


-- GOLPE A ENEMIGO 3

if Jugador.atacando
   and enemigo3.activo
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

    enemigo3.golpeado_ataque = true

end


    -- COLISION ENTRE ENEMIGOS

if enemigo1.activo
   and enemigo2.activo then

    enemigo1:ResolverColision(
        enemigo2,

        Jugador.hitbox_x,
        Jugador.hitbox_y,
        Jugador.hitbox_ancho,
        Jugador.hitbox_alto
    )

end


if enemigo1.activo
   and enemigo3.activo then

    enemigo1:ResolverColision(
        enemigo3,

        Jugador.hitbox_x,
        Jugador.hitbox_y,
        Jugador.hitbox_ancho,
        Jugador.hitbox_alto
    )

end


if enemigo2.activo
   and enemigo3.activo then

    enemigo2:ResolverColision(
        enemigo3,

        Jugador.hitbox_x,
        Jugador.hitbox_y,
        Jugador.hitbox_ancho,
        Jugador.hitbox_alto
    )

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

    love.graphics.print(
    "Vida E1: " .. enemigo1.vida,
    10,
    10
)

love.graphics.print(
    "Vida E2: " .. enemigo2.vida,
    10,
    30
)

love.graphics.print(
    "Vida E3: " .. enemigo3.vida,
    10,
    50
)




end