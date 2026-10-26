local Estado = require("estados.estado")

local EstadoInicio = {}


function EstadoInicio:Load(juego)

    local estado =
        Estado:Load()

    estado.juego =
        juego



    function estado:KeyPressed(
    key
)

    if key == "return" then

        self.juego.CambiarEstado(
            "jugando"
        )

    end

end


    function estado:Draw()

        love.graphics.setColor(
            1,
            1,
            1
        )


        love.graphics.printf(
            "PROTOTIPO 4",
            0,
            220,
            800,
            "center"
        )


        love.graphics.printf(
            "Presiona ENTER para comenzar",
            0,
            280,
            800,
            "center"
        )

    end


    return estado

end


return EstadoInicio