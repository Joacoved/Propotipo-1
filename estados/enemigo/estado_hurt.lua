local Estado = require("estados.estado")

local EstadoHurt = {}

function EstadoHurt:Load(enemigo)

    local estado = Estado:Load()

    estado.enemigo = enemigo

    function estado:Ingresar()

        self.enemigo.indice_hurt = 1
        self.enemigo.tocando_jugador = false

    end

    function estado:Update(dt)

        self.enemigo.indice_hurt =
            self.enemigo.indice_hurt +
            self.enemigo.velocidad_hurt *
            dt

        if self.enemigo.indice_hurt >=
           self.enemigo.cantidad_hurt + 1 then

            self.enemigo.indice_hurt = 1
            self.enemigo.hurt = false

            self.enemigo.CambiarEstado(
                self.enemigo,
                "walk"
            )

        end

    end

    function estado:Draw()
    end

    return estado

end

return EstadoHurt