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

tiles = {
    {W,W,G,D,D,B,B,S,T,T},
    {W,W,G,G,G,D,D,S,T,T},
    {D,W,G,G,O,D,D,S,S,T},
    {D,W,G,G,O,D,D,S,S,S},
    {D,W,W,G,G,G,D,D,S,S},
    {D,W,W,G,G,G,D,D,D,S},
    {D,D,W,W,W,G,G,D,D,D},
    {S,S,D,D,W,G,G,D,P,D}
}

function layout_tiles(t)
    y = 0
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

player = game.world:spawnEntityAt("boy", 200, 200, 1)
MOVE_AMT = 3
ACCEL = 1.0

accel = ACCEL
game.event:addKeyListener(function(keyname, pressed)
    if pressed then
        accel = accel + 0.5
	print("amount = " .. (MOVE_AMT * accel))
        if keyname == 'Left' then
            player:setPos(player.x - (MOVE_AMT * accel), player.y)
        elseif keyname == 'Right' then
            player:setPos(player.x + (MOVE_AMT * accel), player.y)
        elseif keyname == 'Up' then
            player:setPos(player.x, player.y - (MOVE_AMT * accel))
        elseif keyname == 'Down' then
            player:setPos(player.x, player.y + (MOVE_AMT * accel))
        elseif keyname == 'Escape' then
            game.quit()
        end
    else
        accel = ACCEL
    end
end)

game.event:addKeyListener(function(keycode, pressed)
    if pressed then
        print("key " .. keycode .. " pressed")
    else
        print("key " .. keycode .. " released")
    end
end)

