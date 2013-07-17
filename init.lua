require "assets/iterator"
require "assets/entities"

--[[
function reg_types()
    -- 1
    local b = game.Bitmap("assets/PlanetCute PNG/Plain Block.png")
	local b2 = game.Bitmap("assets/PlanetCute PNG/Stone Block.png")
    game.world:getEntityFactory():registerPrototype("1", function()
        local e = game.SpriteEntity(b, b2)
        game.timer:schedule(5, function(t)
            e:onTimer(t)
        end)
        return e
    end)

    local b3 = game.Bitmap("assets/PlanetCute PNG/Wood Block.png")
    local b4 = game.Bitmap("assets/PlanetCute PNG/Stone Block.png")
    game.world:getEntityFactory():registerPrototype("2", function()
        local e = game.SpriteEntity(b3, b4)
        game.timer:schedule(5, function(t)
            e:onTimer(t)
        end)
        return e
    end)
end
--]]

W = 101
H = 81

tiles = {
    {"dirt", "dirt", "stone_tall"},
    {"dirt", "grass", "stone"},
    {"water", "water", "water"}
}

function layout_tiles(t)
    y = 0
    for row in list_iter(t) do
        x = 0
        for cell in list_iter(row) do
            local e = game.world:spawnEntityAt(cell, x * W, y * H)
            x = x + 1
        end
        y = y + 1
    end
end

create_basic_entities()
layout_tiles(tiles)

player = game.world:spawnEntityAt("boy", 200, 200)

game.event:addKeyListener(function(keyname, pressed)
    if pressed then
        if keyname == 'Left' then
            player:setPos(player.x - 1, player.y)
        elseif keyname == 'Right' then
            player:setPos(player.x + 1, player.y)
        elseif keyname == 'Up' then
            player:setPos(player.x, player.y - 1)
        elseif keyname == 'Down' then
            player:setPos(player.x, player.y + 1)
        end
    end
end)

game.event:addKeyListener(function(keycode, pressed)
    if pressed then
        print("key " .. keycode .. " pressed")
    else
        print("key " .. keycode .. " released")
    end
end)

-- game.world:spawnEntityAt("test2", 100, 100)

