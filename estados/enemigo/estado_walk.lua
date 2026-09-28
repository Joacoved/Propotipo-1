local Estado = require("estados.estado")

local EstadoWalk = {}

function EstadoWalk:Load(enemigo)

    local estado = Estado:Load()

    estado.enemigo = enemigo

    function estado:Ingresar()

        self.enemigo.indice_walk = 1

    end

    function estado:Update(dt)

        self.enemigo.indice_walk =
            self.enemigo.indice_walk +
            self.enemigo.velocidad_walk *
            dt

        if self.enemigo.indice_walk >=
           self.enemigo.cantidad_walk + 1 then

            self.enemigo.indice_walk = 1

        end

    end

    function estado:Draw()
    end

    return estado

end

return EstadoWalk