Enemigo = {}

Enemigo.__index = Enemigo


-- LOAD

function Enemigo:Load(
    x,
    y,
    imagen,
    velocidad,
    escala,
    hitbox_ancho,
    hitbox_alto,
    hitbox_offset_x,
    hitbox_offset_y
)

    local enemigo =
        setmetatable(
            {},
            Enemigo
        )


    enemigo.x = x
    enemigo.y = y

    enemigo.velocidad =
        velocidad

    enemigo.escala =
        escala or 1


    enemigo.origen_x = 32
    enemigo.origen_y = 32


    enemigo.direccion =
        "derecha"

        -- COMBATE
    -- COMBATE

    enemigo.vida = 3
    enemigo.activo = true

     enemigo.golpeado_ataque = false 

    -- HITBOX

    enemigo.hitbox_ancho =
        hitbox_ancho or 42

    enemigo.hitbox_alto =
        hitbox_alto or 52

    enemigo.hitbox_offset_x =
        hitbox_offset_x or 0

    enemigo.hitbox_offset_y =
        hitbox_offset_y or -6

    enemigo.hitbox_x = 0
    enemigo.hitbox_y = 0





    -- COLISION

    enemigo.tocando_jugador =
        false


    -- SPRITE

    enemigo.sprite =
        love.graphics.newImage(
            imagen
        )


    enemigo.cantidad_frames = 6

    enemigo.indice = 1

    enemigo.velocidad_animacion = 10


    enemigo.animaciones = {
        abajo = {},
        arriba = {},
        izquierda = {},
        derecha = {}
    }


    enemigo:CrearAnimaciones()

    enemigo:UpdateHitbox()


    return enemigo

end


-- CREAR ANIMACIONES

function Enemigo:CrearAnimaciones()

    local direcciones = {
        "abajo",
        "arriba",
        "izquierda",
        "derecha"
    }


    for fila = 0, 3 do

        local direccion =
            direcciones[fila + 1]


        for columna = 0,
            self.cantidad_frames - 1 do

            table.insert(
                self.animaciones[direccion],

                love.graphics.newQuad(
                    columna * 64,
                    fila * 64,
                    64,
                    64,
                    self.sprite
                )
            )

        end

    end

end


-- HITBOX

function Enemigo:UpdateHitbox()

    self.hitbox_x =
        self.x -
        self.hitbox_ancho / 2 +
        self.hitbox_offset_x

    self.hitbox_y =
        self.y -
        self.hitbox_alto / 2 +
        self.hitbox_offset_y

end


-- PERSEGUIR

function Enemigo:Perseguir(
    jugador_x,
    jugador_y,
    dt
)

    local dx =
        jugador_x -
        self.x

    local dy =
        jugador_y -
        self.y


    if math.abs(dx) >
       math.abs(dy) then

        if dx < 0 then

            self.x =
                self.x -
                self.velocidad *
                dt

            self.direccion =
                "izquierda"

        elseif dx > 0 then

            self.x =
                self.x +
                self.velocidad *
                dt

            self.direccion =
                "derecha"

        end

    else

        if dy < 0 then

            self.y =
                self.y -
                self.velocidad *
                dt

            self.direccion =
                "arriba"

        elseif dy > 0 then

            self.y =
                self.y +
                self.velocidad *
                dt

            self.direccion =
                "abajo"

        end

    end

end


-- UPDATE



function Enemigo:Update(

    
    jugador_x,
    jugador_y,

    jugador_hitbox_x,
    jugador_hitbox_y,
    jugador_hitbox_ancho,
    jugador_hitbox_alto,

    dt
)

if not self.activo then

    return

end

  local x_anterior =
    self.x

local y_anterior =
    self.y


    self:Perseguir(
        jugador_x,
        jugador_y,
        dt
    )


    self:UpdateHitbox()


local tocando_jugador =
    Colisiones.AABB(
        self.hitbox_x,
        self.hitbox_y,
        self.hitbox_ancho,
        self.hitbox_alto,

        jugador_hitbox_x,
        jugador_hitbox_y,
        jugador_hitbox_ancho,
        jugador_hitbox_alto
    )


if tocando_jugador then

 self.x =
    x_anterior

self.y =
    y_anterior

        self:UpdateHitbox()

    end


    self.indice =
        self.indice +
        self.velocidad_animacion *
        dt


    if self.indice >=
       self.cantidad_frames + 1 then

        self.indice = 1

    end

end


-- COLISION ENTRE ENEMIGOS

function Enemigo:ResolverColision(
    otro,

    jugador_hitbox_x,
    jugador_hitbox_y,
    jugador_hitbox_ancho,
    jugador_hitbox_alto
)

    if not Colisiones.AABB(
        self.hitbox_x,
        self.hitbox_y,
        self.hitbox_ancho,
        self.hitbox_alto,

        otro.hitbox_x,
        otro.hitbox_y,
        otro.hitbox_ancho,
        otro.hitbox_alto
    ) then

        return

    end


    local self_x_anterior =
        self.x

    local self_y_anterior =
        self.y


    local otro_x_anterior =
        otro.x

    local otro_y_anterior =
        otro.y


    local centro_self_x =
        self.hitbox_x +
        self.hitbox_ancho / 2

    local centro_self_y =
        self.hitbox_y +
        self.hitbox_alto / 2


    local centro_otro_x =
        otro.hitbox_x +
        otro.hitbox_ancho / 2

    local centro_otro_y =
        otro.hitbox_y +
        otro.hitbox_alto / 2


    local distancia_x =
        centro_otro_x -
        centro_self_x

    local distancia_y =
        centro_otro_y -
        centro_self_y


    local penetracion_x =
        (
            self.hitbox_ancho / 2 +
            otro.hitbox_ancho / 2
        )
        - math.abs(distancia_x)


    local penetracion_y =
        (
            self.hitbox_alto / 2 +
            otro.hitbox_alto / 2
        )
        - math.abs(distancia_y)


    -- SEPARAR POR EL EJE DE MENOR PENETRACION
  

    if penetracion_x <
       penetracion_y then

        local separacion =
            penetracion_x / 2


        if distancia_x < 0 then

            self.x =
                self.x +
                separacion

            otro.x =
                otro.x -
                separacion

        else

            self.x =
                self.x -
                separacion

            otro.x =
                otro.x +
                separacion

        end

    else

        local separacion =
            penetracion_y / 2


        if distancia_y < 0 then

            self.y =
                self.y +
                separacion

            otro.y =
                otro.y -
                separacion

        else

            self.y =
                self.y -
                separacion

            otro.y =
                otro.y +
                separacion

        end

    end


    self:UpdateHitbox()
    otro:UpdateHitbox()


    -- COMPROBAR SELF CONTRA EL JUGADOR
   

    if Colisiones.AABB(
        self.hitbox_x,
        self.hitbox_y,
        self.hitbox_ancho,
        self.hitbox_alto,

        jugador_hitbox_x,
        jugador_hitbox_y,
        jugador_hitbox_ancho,
        jugador_hitbox_alto
    ) then

        self.x =
            self_x_anterior

        self.y =
            self_y_anterior

        self:UpdateHitbox()

    end


    -- COMPROBAR OTRO CONTRA EL JUGADOR
   

    if Colisiones.AABB(
        otro.hitbox_x,
        otro.hitbox_y,
        otro.hitbox_ancho,
        otro.hitbox_alto,

        jugador_hitbox_x,
        jugador_hitbox_y,
        jugador_hitbox_ancho,
        jugador_hitbox_alto
    ) then

        otro.x =
            otro_x_anterior

        otro.y =
            otro_y_anterior

        otro:UpdateHitbox()

    end

end

-- RECIBIR GOLPE

function Enemigo:RecibirGolpe(cantidad)

    if not self.activo then

        return

    end


    self.vida =
        self.vida -
        cantidad


    if self.vida <= 0 then

        self.vida = 0
        self.activo = false

    end

end

-- DRAW

function Enemigo:Draw()

    if not self.activo then

    return

end

    local frame =
        math.floor(
            self.indice
        )


    local quad =
        self.animaciones
            [self.direccion]
            [frame]


    love.graphics.draw(
        self.sprite,
        quad,
        self.x,
        self.y,
        0,
        self.escala,
        self.escala,
        self.origen_x,
        self.origen_y
    )

end


-- DEBUG

function Enemigo:Debug()

    if not self.activo then

    return

end

    love.graphics.rectangle(
        "line",
        self.hitbox_x,
        self.hitbox_y,
        self.hitbox_ancho,
        self.hitbox_alto
    )


    love.graphics.circle(
        "fill",
        self.x,
        self.y,
        2
    )

end