IMG_DIR = "assets/PlanetCute PNG/"
basic_entities = {
    {"brown", IMG_DIR .. "Brown Block.png"},
    {"dirt", IMG_DIR .. "Dirt Block.png"},
    {"grass", IMG_DIR .. "Grass Block.png"},
    {"plain", IMG_DIR .. "Plain Block.png"},
    {"stone", IMG_DIR .. "Stone Block.png"},
    {"stone_tall", IMG_DIR .. "Stone Block Tall.png"},
    {"wall", IMG_DIR .. "Wall Block.png"},
    {"wall_tall", IMG_DIR .. "Wall Block Tall.png"},
    {"water", IMG_DIR .. "Water Block.png"},
    {"wood", IMG_DIR .. "Wood Block.png"},
    {"boy", IMG_DIR .. "Character Boy.png"}
}

function create_basic_entities()
    for entry in list_iter(basic_entities) do
        local key = entry[1]
        local path = entry[2]
        local bmp = game.Bitmap(path)
        game.world:getEntityFactory():registerPrototype(key, function()
            return game.SpriteEntity(bmp)
        end)
    end
end

