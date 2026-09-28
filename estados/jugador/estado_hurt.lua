local Estado = require("estados.estado")

local EstadoHurt = {}

function EstadoHurt:Load(jugador)

    local estado = Estado:Load()

    estado.jugador = jugador

    function estado:Ingresar()

        self.jugador.indice_hurt = 1

    end

    function estado:Update(dt)

        self.jugador.indice_hurt =
            self.jugador.indice_hurt +
            self.jugador.velocidad_hurt *
            dt

        if self.jugador.indice_hurt >
           self.jugador.cantidad_hurt then

            self.jugador.indice_hurt = 1

            self.jugador.hurt = false

            if self.jugador.moviendose then

                self.jugador.CambiarEstado(
                    "walk"
                )

            else

                self.jugador.CambiarEstado(
                    "idle"
                )

            end

        end

    end

    function estado:Draw()
    end

    return estado

end

return EstadoHurt