require('passion.init')
require('Ship')

local twoPi = 2.0*math.pi

local normalizeAngle = function(angle)
  angle = angle % twoPi
  return (angle < 0 and (angle + twoPi) or angle)
end

PlayerShip = Ship:subclass('PlayerShip', {hasBody = true})

function PlayerShip:initialize(model,x,y)
  super.initialize(self, model, x, y)
  self:observe('mousepressed_l', 'fire')
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
  local ox, oy = self:getObjective()
  local x, y = self:getPosition()
  local thrust = self:getThrust()
  local strafeThrust = self:getStrafeThrust()
  local rotation = self:getRotation()
  local angle = self:getAngle()
  local angularVelocity = self:getAngularVelocity()

  local objectiveAngle = math.atan2(oy-y,ox-x)
  
  local differenceAngle = normalizeAngle(objectiveAngle - angle)

  -- if the ship can snap to the objective's direction, then snap
  if( differenceAngle <= self.model.snapAngleThreshold or 
      differenceAngle >= twoPi - self.model.snapAngleThreshold
    ) then
    self:setAngle(objectiveAngle)
    self:setAngularVelocity(0)
  else -- could not snap - rotate using torques
    if(differenceAngle <= math.pi) then -- counter-clockwise
      if(angularVelocity < self.model.maxAngularVelocity) then 
        self:applyTorque(rotation)
      end
    elseif(angularVelocity > -self.model.maxAngularVelocity) then
      self:applyTorque(-rotation)
    end
  end

  local c = math.cos(angle)
  local s = math.sin(angle)

  if(love.keyboard.isDown('w')) then
    self:applyImpulse( c*thrust, s*thrust )
  end

  if(love.keyboard.isDown('d')) then
    self:applyImpulse( -s*strafeThrust, c*strafeThrust )
  end

  if(love.keyboard.isDown('a')) then
    self:applyImpulse( s*strafeThrust, -c*strafeThrust )
  end
  
--  if(love.mouse.isDown('l')) then
--    self:fire()
--  end
end
