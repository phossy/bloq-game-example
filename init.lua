require "assets/utils"
require "assets/entities"
require "assets/fonts"
require "assets/settings"
require "assets/tiles"

-- basic setup
create_basic_entities()
create_fonts()
layout_tiles(tiles)

-- create the player object
player = game.world:spawnEntityAt("boy", (TILE_WIDTH * 3), (TILE_HEIGHT * 2.75), 1)
player.leftBound = 17
player.rightBound = 17
player.topBound = 62
player.bottomBound = 30
player.onCollision = nil
player.onCollision = function(colliding)
    print('We ran into a ' .. colliding.type .. '!')
    game.world:removeEntity(colliding)
end
player.collidable = true

-- create a test gem object
gem = game.world:spawnEntityAt("gem_blue", (TILE_WIDTH * 3) * 3, (TILE_HEIGHT * 2.75) * 2, 2)
gem.leftBound = 3
gem.rightBound = 4
gem.topBound = 58
gem.bottomBound = 10
gem.collidable = true

-- basic keyboard input
game.event:addKeyListener(function(keyname, pressed)
    if pressed then
        if keyname == 'Left' then
            player.x = player.x - TILE_WIDTH
            game.window.viewX = game.window.viewX - TILE_WIDTH
        elseif keyname == 'Right' then
            player.x = player.x + TILE_WIDTH
            game.window.viewX = game.window.viewX + TILE_WIDTH
        elseif keyname == 'Up' then
            player.y = player.y - TILE_HEIGHT
            game.window.viewY = game.window.viewY - TILE_HEIGHT
        elseif keyname == 'Down' then
            player.y = player.y + TILE_HEIGHT
            game.window.viewY = game.window.viewY + TILE_HEIGHT
        elseif keyname == 'Escape' then
            game.quit()
        elseif keyname == '`' then
            game.console.visible = true
        end
    end
end)

-- draw some hello world text
e = cast(game.TextEntity, game.world:spawnEntityAt("oxygen72", 50, 50, 1000))
e.text = "Hello World"
e.color = {255, 255, 0, 255}
