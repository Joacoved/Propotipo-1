local MaquinaEstado = {}

function MaquinaEstado:Load(estados)

    local maquina = {}

    maquina.estados =
        estados or {}

    maquina.actual = {
    Ingresar = function(self, parametros) end,
    Salir = function(self) end,
    Update = function(self, dt) end,
    Draw = function(self) end
}

    function maquina:Cambiar(
        nombre_estado,
        parametros
    )

        assert(
            self.estados[nombre_estado],
            "Estado inexistente: " ..
            tostring(nombre_estado)
        )

        self.actual:Salir()

        self.actual =
            self.estados[nombre_estado]()

        self.actual:Ingresar(
            parametros
        )

    end

    function maquina:Update(dt)

        self.actual:Update(
            dt
        )

    end

    function maquina:Draw()

        self.actual:Draw()

    end

    return maquina
end

return MaquinaEstado