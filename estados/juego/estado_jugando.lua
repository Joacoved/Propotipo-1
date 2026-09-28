local Estado = require("estados.estado")

local EstadoJugando = {}


function EstadoJugando:Load(juego)

    local estado =
        Estado:Load()

    estado.juego =
        juego


    function estado:Ingresar()

    end


    function estado:Update(dt)
 self.juego.UpdateJugando(
        dt
    )

    end


    function estado:Draw()

        self.juego.DrawJugando()

    end


    return estado

end


return EstadoJugando