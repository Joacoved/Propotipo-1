local Estado = require("estados.estado")

local EstadoWalk = {}

function EstadoWalk:Load(jugador)

    local estado = Estado:Load()

    estado.jugador = jugador

    function estado:Ingresar()

        self.jugador.indice_walk = 1

    end

    function estado:Update(dt)

        self.jugador.indice_walk =
            self.jugador.indice_walk +
            self.jugador.velocidad_walk *
            dt

        if self.jugador.indice_walk >=
           self.jugador.cantidad_walk + 1 then

            self.jugador.indice_walk = 1

        end

    end

    function estado:Draw()
    end

    return estado

end

return EstadoWalk