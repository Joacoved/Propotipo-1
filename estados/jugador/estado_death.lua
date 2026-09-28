local Estado = require("estados.estado")

local EstadoDeath = {}

function EstadoDeath:Load(jugador)

    local estado = Estado:Load()

    estado.jugador = jugador

    function estado:Ingresar()

        self.jugador.indice_death = 1

    end

    function estado:Update(dt)

        self.jugador.indice_death =
            self.jugador.indice_death +
            self.jugador.velocidad_death *
            dt

        if self.jugador.indice_death >
           self.jugador.cantidad_death then

            self.jugador.indice_death =
                self.jugador.cantidad_death

        end

    end

    function estado:Draw()
    end

    return estado

end

return EstadoDeath