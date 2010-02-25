-- Example: Stateful game

require('passion.init')
require('Game')

function passion:load()
  love.graphics.setLineWidth(2)
  game = Game:new()
end

function love.run()
  return passion:run()
end
