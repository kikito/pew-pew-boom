-- Example: Stateful game

require('passion.init')
require('Game')

function love.load()
  math.randomseed( os.time() )
  game = Game:new()
end
