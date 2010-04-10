-- Example: Stateful game

require('passion.init')
require('Game')

function passion.load()
  math.randomseed( os.time() )
  love.graphics.setLineWidth(2)
  game = Game:new()
end

function love.run()
  return passion.run()
end
