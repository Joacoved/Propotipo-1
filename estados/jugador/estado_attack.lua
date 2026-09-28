local Estado = require("estados.estado")

local EstadoAttack = {}

function EstadoAttack:Load(jugador)

    local estado = Estado:Load()

    estado.jugador = jugador

    function estado:Ingresar()

        self.jugador.indice_ataque = 1
        self.jugador.indice_walk_ataque = 1

    end

    function estado:Update(dt)

        -- ATAQUE EN MOVIMIENTO
        if self.jugador.ataque_en_movimiento then

            self.jugador.indice_walk_ataque =
                self.jugador.indice_walk_ataque +
                self.jugador.velocidad_walk_ataque *
                dt

            if self.jugador.indice_walk_ataque >
               self.jugador.cantidad_walk_ataque then

                self.jugador.indice_walk_ataque = 1
                self.jugador.atacando = false
                self.jugador.ataque_en_movimiento = false

                if self.jugador.moviendose then
                    self.jugador.CambiarEstado("walk")
                else
                    self.jugador.CambiarEstado("idle")
                end

            end

            return

        end

        -- ATAQUE QUIETO
        self.jugador.indice_ataque =
            self.jugador.indice_ataque +
            self.jugador.velocidad_ataque *
            dt

        if self.jugador.indice_ataque >
           self.jugador.cantidad_ataque then

            self.jugador.indice_ataque = 1
            self.jugador.atacando = false
            self.jugador.ataque_en_movimiento = false

            if self.jugador.moviendose then
                self.jugador.CambiarEstado("walk")
            else
                self.jugador.CambiarEstado("idle")
            end

        end

    end

    function estado:Draw()
    end

    return estado

end

return EstadoAttack