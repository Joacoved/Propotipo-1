Enemigo = {}

Enemigo.__index = Enemigo


-- LOAD 

function Enemigo:Load(
    x,
    y,
    imagen,
    velocidad,
    escala
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


-- PERSEGUIR 

function Enemigo:Perseguir(
    jugador_x,
    jugador_y,
    dt
)

    local dx =
        jugador_x - self.x

    local dy =
        jugador_y - self.y

    local distancia =
        math.sqrt(
            dx * dx +
            dy * dy
        )


    if distancia > 0 then

        dx = dx / distancia
        dy = dy / distancia

        self.x =
            self.x +
            dx *
            self.velocidad *
            dt

        self.y =
            self.y +
            dy *
            self.velocidad *
            dt


        if math.abs(dx) >
           math.abs(dy) then

            if dx > 0 then

                self.direccion =
                    "derecha"

            else

                self.direccion =
                    "izquierda"

            end

        else

            if dy > 0 then

                self.direccion =
                    "abajo"

            else

                self.direccion =
                    "arriba"

            end

        end

    end

end


-- UPDATE 

function Enemigo:Update(
    jugador_x,
    jugador_y,
    dt
)

    self:Perseguir(
        jugador_x,
        jugador_y,
        dt
    )


    self.indice =
        self.indice +
        self.velocidad_animacion *
        dt

    if self.indice >=
       self.cantidad_frames + 1 then

        self.indice = 1

    end

end


-- DRAW 

function Enemigo:Draw()

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