require('passion.init')
require('Ship')

PlayerShip = Ship:subclass('PlayerShip', {hasBody = true})

function PlayerShip:initialize(model,x,y)
  super.initialize(self, model, x, y)
end

function PlayerShip:getObjective()
  return love.mouse.getPosition()
end

function PlayerShip:draw()
  local x, y = self:getPosition()
  local model = self.model
  self:drawShapes()
  passion.graphics.drawq(model.quad, x, y, self:getAngle(), 1, 1, model.centerX, model.centerY)
end

function PlayerShip:update()
  self:orientate()

  if(love.keyboard.isDown('w')) then
    self:thrust()
  end

  if(love.keyboard.isDown('d')) then
    self:strafeLeft()
  end

  if(love.keyboard.isDown('a')) then
    self:strafeRight()
  end
  
  if(love.mouse.isDown('l')) then
    self:fire()
  end
end
