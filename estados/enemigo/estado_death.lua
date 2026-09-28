local Estado = require("estados.estado")

local EstadoDeath = {}

function EstadoDeath:Load(enemigo)

    local estado = Estado:Load()

    estado.enemigo = enemigo

    function estado:Ingresar()

        self.enemigo.indice_death = 1
        self.enemigo.tocando_jugador = false

    end

    function estado:Update(dt)

        self.enemigo.indice_death =
            self.enemigo.indice_death +
            self.enemigo.velocidad_death *
            dt

        if self.enemigo.indice_death >=
           self.enemigo.cantidad_death + 1 then

            self.enemigo.indice_death =
                self.enemigo.cantidad_death

            self.enemigo.activo = false

        end

    end

    function estado:Draw()
    end

    return estado

end

return EstadoDeath