Arena = {}


Arena.fondo = nil


-- LIMITES INTERIORES

Arena.limite_izquierdo = 45
Arena.limite_derecho = 755

Arena.limite_superior = 145
Arena.limite_inferior = 525


-- LOAD

function Arena.Load()

    Arena.fondo =
        love.graphics.newImage(
            "assets/fondo.png"
        )

end


-- DRAW

function Arena.Draw()

    love.graphics.setColor(
        1,
        1,
        1
    )


    love.graphics.draw(
        Arena.fondo,
        0,
        0
    )

end


-- DEBUG

function Arena.Debug()

    love.graphics.rectangle(
        "line",
        Arena.limite_izquierdo,
        Arena.limite_superior,

        Arena.limite_derecho -
        Arena.limite_izquierdo,

        Arena.limite_inferior -
        Arena.limite_superior
    )

end