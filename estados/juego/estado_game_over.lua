local Estado = require("estados.estado")

local EstadoGameOver = {}


function EstadoGameOver:Load(juego)

    local estado =
        Estado:Load()

    estado.juego =
        juego

    estado.resultado =
        nil


    function estado:Ingresar(
        parametros
    )

        self.resultado =
            parametros

    end


    function estado:Update(dt)

    end


function estado:KeyPressed(
    key
)

    if key == "r" then

        self.juego.Reiniciar()

        self.juego.CambiarEstado(
            "jugando"
        )


    elseif key == "escape" then

        self.juego.Reiniciar()

        self.juego.CambiarEstado(
            "inicio"
        )

    end

end


    function estado:Draw()

        love.graphics.setColor(
            1,
            1,
            1
        )


        if self.resultado ==
           "victoria" then

            love.graphics.printf(
                "VICTORIA",
                0,
                240,
                800,
                "center"
            )


            love.graphics.printf(
                "Has derrotado a todos los enemigos",
                0,
                280,
                800,
                "center"
            )

        else

            love.graphics.printf(
                "DERROTA",
                0,
                240,
                800,
                "center"
            )


            love.graphics.printf(
                "Has sido derrotado",
                0,
                280,
                800,
                "center"
            )

        end


        love.graphics.printf(
            "Presiona R para reiniciar",
            0,
            330,
            800,
            "center"
        )

        love.graphics.printf(
    "Presiona ESC para volver al menu",
    0,
    360,
    800,
    "center"
)

    end


    return estado

end


return EstadoGameOver