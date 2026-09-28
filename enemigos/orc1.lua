require("enemigo")

local Orc1 = {}
Orc1.__index = Orc1

setmetatable(Orc1, {
    __index = Enemigo
})


function Orc1:Load(x, y)

    local nuevo = Enemigo:Load(
        x,
        y,

        "assets/enemigos/orc1_walk_without_shadow.png",
        "assets/enemigos/orc1_attack_without_shadow.png",
        "assets/enemigos/orc1_hurt_without_shadow.png",
        "assets/enemigos/orc1_death_without_shadow.png",

        120,
        1.85,

        42,
        52,

        0,
        -6
    )

    nuevo.vida = 2
    nuevo.vida_maxima = 2

    return nuevo

end


return Orc1