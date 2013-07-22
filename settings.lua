-- set up some basic settings like the max FPS and the console
game.window.targetFps = 60

game.console:init(game.Typeface("assets/Oxygen_Mono/OxygenMono-Regular.ttf", 14))
print = function(s)
    game.console:print(s)
end

-- enable to show the white bounding boxes around entities
--game.world.drawBoundingBoxes = true