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
        local face = game.Typeface(path, pt)
        game.world:getEntityFactory():registerPrototype(key, function()
            return game.TextEntity(face)
        end)
    end
end
