require("enemigo")

local Orc3 = {}
Orc3.__index = Orc3

setmetatable(Orc3, {
    __index = Enemigo
})


function Orc3:Load(x, y)

    local nuevo = Enemigo:Load(
        x,
        y,

        "assets/enemigos/orc3_walk_without_shadow.png",
        "assets/enemigos/orc3_attack_without_shadow.png",
        "assets/enemigos/orc3_hurt_without_shadow.png",
        "assets/enemigos/orc3_death_without_shadow.png",

        80,
        2.15,

        58,
        68,

        0,
        -12
    )

    nuevo.vida = 5
    nuevo.vida_maxima = 5

    return nuevo

end


return Orc3