local Estado = require("estados.estado")

local EstadoIdle = {}

function EstadoIdle:Load(jugador)

    local estado = Estado:Load()

    estado.jugador = jugador

    function estado:Ingresar()

        self.jugador.indice_idle = 1

    end

    function estado:Update(dt)

        local cantidad =
            self.jugador.cantidad_idle[
                self.jugador.direccion
            ]

        self.jugador.indice_idle =
            self.jugador.indice_idle +
            self.jugador.velocidad_idle *
            dt

        if self.jugador.indice_idle >=
           cantidad + 1 then

            self.jugador.indice_idle = 1

        end

    end

    function estado:Draw()
    end

    return estado

end

return EstadoIdle