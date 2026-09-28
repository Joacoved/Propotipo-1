require("enemigo")

local Orc2 = {}
Orc2.__index = Orc2

setmetatable(Orc2, {
    __index = Enemigo
})


function Orc2:Load(x, y)

    local nuevo = Enemigo:Load(
        x,
        y,

        "assets/enemigos/orc2_walk_without_shadow.png",
        "assets/enemigos/orc2_attack_without_shadow.png",
        "assets/enemigos/orc2_hurt_without_shadow.png",
        "assets/enemigos/orc2_death_without_shadow.png",

        100,
        2.0,

        50,
        60,

        0,
        -9
    )

    nuevo.vida = 3
    nuevo.vida_maxima = 3

    return nuevo

end


return Orc2