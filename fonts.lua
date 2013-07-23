fonts = {
    {"oxygen", "assets/Oxygen/Oxygen-Regular.ttf", 16},
    {"oxygen_mono", "assets/Oxygen_Mono/OxygenMono-Regular.ttf", 16},
    {"oxygen72", "assets/Oxygen/Oxygen-Regular.ttf", 72},
}

function create_fonts()
    for entry in list_iter(fonts) do
        local key = entry[1]
        local path = entry[2]
        local pt = entry[3]
        fonts[key] = game.Typeface(path, pt)
        game.world.entityFactory:registerPrototype(key, function()
            return game.TextEntity(fonts[key])
        end)
    end
end
