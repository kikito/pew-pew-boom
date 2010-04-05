require('actors/space/vehicles/Ship.lua')

PlayerShip = class('PlayerShip', Ship)

function PlayerShip:initialize(model,x,y)
  super.initialize(self, model, x, y)
end

function PlayerShip:getObjective()
  return love.mouse.getPosition()
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

  self:pacManCheck()
end
