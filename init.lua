require "assets/iterator"
require "assets/entities"

TILE_WIDTH = 101
TILE_HEIGHT = 81

D = "dirt"
G = "grass"
W = "water"
S = "stone"
T = "stone_tall"
P = "plain"
B = "brown"
O = "wood"
A = "wall"

tiles = {
    {W,D,G,G,D,B,S,S,S,S,T},
    {W,W,G,D,D,B,B,S,T,T,T},
    {W,W,G,G,G,D,D,S,T,T,S},
    {D,W,G,G,O,D,D,S,S,T,S},
    {D,W,G,G,O,D,D,S,S,S,S},
    {D,W,W,G,G,G,D,D,S,S,D},
    {D,W,W,G,G,G,D,D,D,S,D},
    {D,D,W,W,W,G,G,D,D,D,A},
    {S,S,D,D,W,G,G,D,P,D,A},
    {S,D,D,W,W,G,G,D,D,D,A}
}

function layout_tiles(t)
    y = -1 -- to fill the top layer
    for row in list_iter(t) do
        x = 0
        for cell in list_iter(row) do
            local e = game.world:spawnEntityAt(cell, x * TILE_WIDTH, y * TILE_HEIGHT, y - 1000) -- place the top row at min z-order
            x = x + 1
        end
        y = y + 1
    end
end

create_basic_entities()
layout_tiles(tiles)

player = game.world:spawnEntityAt("boy", (TILE_WIDTH * 3), (TILE_HEIGHT * 2.75), 1)

game.event:addKeyListener(function(keyname, pressed)
    if pressed then
        if keyname == 'Left' then
            player:setPos(player.x - TILE_WIDTH, player.y)
        elseif keyname == 'Right' then
            player:setPos(player.x + TILE_WIDTH, player.y)
        elseif keyname == 'Up' then
            player:setPos(player.x, player.y - TILE_HEIGHT)
        elseif keyname == 'Down' then
            player:setPos(player.x, player.y + TILE_HEIGHT)
        elseif keyname == 'Escape' then
            game.quit()
        end
    end
end)

