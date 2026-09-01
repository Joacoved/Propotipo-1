img_particula = nil

particulas = nil


-- CARGAR PARTICULAS

function CargarParticulas()

    img_particula =
        love.graphics.newImage(
            "assets/particula.png"
        )


    particulas =
        love.graphics.newParticleSystem(
            img_particula,
            100
        )


    particulas:setParticleLifetime(
        0.2,
        0.5
    )


    particulas:setSizeVariation(
        1
    )


    particulas:setSizes(
        0.08,
        0.03
    )


    particulas:setLinearAcceleration(
        -120,
        -120,
        120,
        120
    )


    particulas:setColors(
        1,
        1,
        1,
        1,

        1,
        1,
        1,
        0
    )

end


-- UPDATE

function UpdateParticulas(dt)

    particulas:update(dt)

end


-- GOLPE

function ParticulasGolpe(enemigo)

    particulas:setPosition(
        enemigo.x +
        enemigo.hitbox_offset_x,

        enemigo.y +
        enemigo.hitbox_offset_y
    )


    particulas:emit(
        5
    )

end


-- DERROTA ENEMIGO

function ParticulasDerrota(enemigo)

    particulas:setPosition(
        enemigo.x +
        enemigo.hitbox_offset_x,

        enemigo.y +
        enemigo.hitbox_offset_y
    )


    particulas:emit(
        15
    )

end


-- DRAW

function DrawParticulas()

    love.graphics.setColor(
        1,
        1,
        1
    )


    love.graphics.draw(
        particulas
    )

end