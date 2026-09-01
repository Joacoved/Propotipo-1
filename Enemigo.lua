Enemigo = {}

Enemigo.__index = Enemigo


-- LOAD

function Enemigo:Load(
    x,
    y,
    imagen_walk,
    imagen_attack,
    imagen_hurt,
    imagen_death,
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

    enemigo.vida = 3

    enemigo.activo = true

    enemigo.atacando = false
    enemigo.hurt = false
    enemigo.muerto = false

    enemigo.tocando_jugador = false

    enemigo.golpe_jugador_registrado = false
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


    -- SPRITES

    enemigo.sprite_walk =
        love.graphics.newImage(
            imagen_walk
        )


    enemigo.sprite_attack =
        love.graphics.newImage(
            imagen_attack
        )


    enemigo.sprite_hurt =
        love.graphics.newImage(
            imagen_hurt
        )


    enemigo.sprite_death =
        love.graphics.newImage(
            imagen_death
        )


    -- ANIMACIONES

    enemigo.anim_walk = {}
    enemigo.anim_attack = {}
    enemigo.anim_hurt = {}
    enemigo.anim_death = {}


    enemigo.indice_walk = 1
    enemigo.indice_attack = 1
    enemigo.indice_hurt = 1
    enemigo.indice_death = 1


    enemigo.cantidad_walk = 6
    enemigo.cantidad_attack = 8
    enemigo.cantidad_hurt = 6
    enemigo.cantidad_death = 8


    enemigo.velocidad_walk = 10
    enemigo.velocidad_attack = 12
    enemigo.velocidad_hurt = 10
    enemigo.velocidad_death = 8


    enemigo:CrearAnimaciones()

    enemigo:UpdateHitbox()


    return enemigo

end


-- CREAR ANIMACIONES

function Enemigo:CrearAnimaciones()

    self.anim_walk = {
        abajo = {},
        arriba = {},
        izquierda = {},
        derecha = {}
    }


    self.anim_attack = {
        abajo = {},
        arriba = {},
        izquierda = {},
        derecha = {}
    }


    self.anim_hurt = {
        abajo = {},
        arriba = {},
        izquierda = {},
        derecha = {}
    }


    self.anim_death = {
        abajo = {},
        arriba = {},
        izquierda = {},
        derecha = {}
    }


    local direcciones = {
        "abajo",
        "arriba",
        "izquierda",
        "derecha"
    }


    -- WALK

    for fila = 0, 3 do

        local direccion =
            direcciones[fila + 1]


        for columna = 0,
            self.cantidad_walk - 1 do

            table.insert(
                self.anim_walk[direccion],

                love.graphics.newQuad(
                    columna * 64,
                    fila * 64,
                    64,
                    64,
                    self.sprite_walk
                )
            )

        end

    end


    -- ATTACK

    for fila = 0, 3 do

        local direccion =
            direcciones[fila + 1]


        for columna = 0,
            self.cantidad_attack - 1 do

            table.insert(
                self.anim_attack[direccion],

                love.graphics.newQuad(
                    columna * 64,
                    fila * 64,
                    64,
                    64,
                    self.sprite_attack
                )
            )

        end

    end


    -- HURT

    for fila = 0, 3 do

        local direccion =
            direcciones[fila + 1]


        for columna = 0,
            self.cantidad_hurt - 1 do

            table.insert(
                self.anim_hurt[direccion],

                love.graphics.newQuad(
                    columna * 64,
                    fila * 64,
                    64,
                    64,
                    self.sprite_hurt
                )
            )

        end

    end


    -- DEATH

    for fila = 0, 3 do

        local direccion =
            direcciones[fila + 1]


        for columna = 0,
            self.cantidad_death - 1 do

            table.insert(
                self.anim_death[direccion],

                love.graphics.newQuad(
                    columna * 64,
                    fila * 64,
                    64,
                    64,
                    self.sprite_death
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


-- INICIAR ATAQUE

function Enemigo:IniciarAtaque()

    if not self.activo
       or self.muerto
       or self.hurt
       or self.atacando then

        return

    end


    self.atacando = true

    self.indice_attack = 1

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


    -- DEATH

    if self.muerto then

        self.indice_death =
            self.indice_death +
            self.velocidad_death *
            dt


        if self.indice_death >=
           self.cantidad_death + 1 then

            self.indice_death =
                self.cantidad_death

            self.activo = false

        end


        return

    end


    -- HURT

    if self.hurt then

        self.indice_hurt =
            self.indice_hurt +
            self.velocidad_hurt *
            dt


        if self.indice_hurt >=
           self.cantidad_hurt + 1 then

            self.indice_hurt = 1

            self.hurt = false

        end


        return

    end


    -- ATTACK

    if self.atacando then

        self.indice_attack =
            self.indice_attack +
            self.velocidad_attack *
            dt


        if self.indice_attack >=
           self.cantidad_attack + 1 then

            self.indice_attack = 1

            self.atacando = false

        end


        return

    end


    -- MOVIMIENTO

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


    self.tocando_jugador =
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


    if self.tocando_jugador then

        self.x =
            x_anterior

        self.y =
            y_anterior

        self:UpdateHitbox()


    else

        self.golpe_jugador_registrado =
            false

    end


    -- WALK

    self.indice_walk =
        self.indice_walk +
        self.velocidad_walk *
        dt


    if self.indice_walk >=
       self.cantidad_walk + 1 then

        self.indice_walk = 1

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

    if not self.activo
       or not otro.activo
       or self.muerto
       or otro.muerto then

        return

    end


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


    -- COMPROBAR SELF CONTRA JUGADOR

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


    -- COMPROBAR OTRO CONTRA JUGADOR

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

    if not self.activo
       or self.muerto then

        return

    end


    self.vida =
        self.vida -
        cantidad


    if self.vida <= 0 then

        self.vida = 0

        self.muerto = true

        self.atacando = false
        self.hurt = false

        self.indice_death = 1


    else

        self.atacando = false

        self.hurt = true

        self.indice_hurt = 1

    end

end


-- DRAW

function Enemigo:Draw()

    if not self.activo then

        return

    end


    local sprite
    local quad


    -- DEATH

    if self.muerto then

        sprite =
            self.sprite_death


        local frame =
            math.floor(
                self.indice_death
            )


        if frame >
           self.cantidad_death then

            frame =
                self.cantidad_death

        end


        quad =
            self.anim_death
                [self.direccion]
                [frame]


    -- HURT

    elseif self.hurt then

        sprite =
            self.sprite_hurt


        local frame =
            math.floor(
                self.indice_hurt
            )


        if frame >
           self.cantidad_hurt then

            frame =
                self.cantidad_hurt

        end


        quad =
            self.anim_hurt
                [self.direccion]
                [frame]


    -- ATTACK

    elseif self.atacando then

        sprite =
            self.sprite_attack


        local frame =
            math.floor(
                self.indice_attack
            )


        if frame >
           self.cantidad_attack then

            frame =
                self.cantidad_attack

        end


        quad =
            self.anim_attack
                [self.direccion]
                [frame]


    -- WALK

    else

        sprite =
            self.sprite_walk


        local frame =
            math.floor(
                self.indice_walk
            )


        if frame >
           self.cantidad_walk then

            frame = 1

            self.indice_walk = 1

        end


        quad =
            self.anim_walk
                [self.direccion]
                [frame]

    end


    love.graphics.draw(
        sprite,
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