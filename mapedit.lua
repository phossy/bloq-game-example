require "assets/utils"
require "assets/entities"
require "assets/fonts"
require "assets/settings"
require "assets/tiles"

-- basic setup
create_basic_entities()
create_fonts()
--layout_tiles(tiles)

modes = {
    D = "dirt",
    G = "grass",
    W = "water",
    S = "stone",
    T = "stone_tall",
    P = "plain",
    B = "brown",
    O = "wood",
    A = "wall"
}

TILE_OFFSET = 50

shape = game.ShapeEntity(game.color.WHITE)
shape.w = TILE_WIDTH
shape.h = TILE_HEIGHT
shape.y = TILE_OFFSET
game.world:addOverlay(shape)

-- basic keyboard input
game.event:addKeyListener(function(keyname, pressed)
    if pressed then
        if keyname == 'Left' then
            shape.x = shape.x - TILE_WIDTH
        elseif keyname == 'Right' then
            shape.x = shape.x + TILE_WIDTH
        elseif keyname == 'Up' then
            shape.y = shape.y - TILE_HEIGHT
        elseif keyname == 'Down' then
            shape.y = shape.y + TILE_HEIGHT
        elseif keyname == 'Escape' then
            game.quit()
        elseif keyname == '`' then
            game.console.visible = true
        elseif modes[keyname] ~= nil then
            game.world:spawnEntityAt(modes[keyname], shape.x, shape.y - TILE_OFFSET, shape.y)
        end
    end
end)
