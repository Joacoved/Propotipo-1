local Estado = require("estados.estado")

local EstadoAttack = {}

function EstadoAttack:Load(enemigo)

    local estado = Estado:Load()

    estado.enemigo = enemigo

    function estado:Ingresar()

        self.enemigo.indice_attack = 1

    end

    function estado:Update(dt)

        self.enemigo.indice_attack =
            self.enemigo.indice_attack +
            self.enemigo.velocidad_attack *
            dt

        if self.enemigo.indice_attack >=
           self.enemigo.cantidad_attack + 1 then

            self.enemigo.indice_attack = 1

            self.enemigo.atacando = false

            self.enemigo.golpe_jugador_registrado =
                false

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

return EstadoAttack