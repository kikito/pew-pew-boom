require('actors/Module.lua')
require('actors/Slot.lua')
require('actors/Vehicle.lua')
require('mixins/PacManLike.lua')

local twoPi = 2.0*math.pi

local _normalizeAngle = function(angle)
  angle = angle % twoPi
  return (angle < 0 and (angle + twoPi) or angle)
end

local _getTotalAttribute = function(self, baseValue, moduleMethod)
  local result = baseValue
  for _,slot in pairs(self.slots) do
    module = slot.module
    if(module~=nil and type(module[moduleMethod]) == "function") then
      result = result + module[moduleMethod](module)
    end
  end
  return result
end

Ship = class('Ship', Vehicle)
Ship:includes(PacManLike)

function Ship:initialize(model,x,y)
  super.initialize(self, x,y, model.centerX, model.centerY, model.shapes, model.slots, model.quad)
  self.model = model
  self:setAngle(math.pi/2.0)
end

function Ship:getThrust()
  return _getTotalAttribute(self, self.model.baseThrust, 'getThrust')
end

function Ship:getStrafeThrust()
  return _getTotalAttribute(self, self.model.baseStrafeThrust, 'getThrust')
end

function Ship:getRotation()
  return _getTotalAttribute(self, self.model.baseRotation, 'getRotation')
end

function Ship:getObjective()
  return 0,0
end

function Ship:thrust()
  local angle = self:getAngle()
  local c = math.cos(angle)
  local s = math.sin(angle)
  local thrust = self:getThrust()
  self:applyImpulse( c*thrust, s*thrust )
end

function Ship:strafeLeft()
  local angle = self:getAngle()
  local c = math.cos(angle)
  local s = math.sin(angle)
  local strafeThrust = self:getStrafeThrust()
  self:applyImpulse( s*strafeThrust, -c*strafeThrust )
end

function Ship:strafeRight()
  local angle = self:getAngle()
  local c = math.cos(angle)
  local s = math.sin(angle)
  local strafeThrust = self:getStrafeThrust()
  self:applyImpulse( -s*strafeThrust, c*strafeThrust )
end

function Ship:orientate()

  local ox, oy = self:getObjective()
  local x, y = self:getPosition()
  local rotation = self:getRotation()

  local angle = self:getAngle()
  
  local objectiveAngle = math.atan2(oy-y,ox-x)
  
  local differenceAngle = _normalizeAngle(objectiveAngle - angle)

  -- if the ship can snap to the objective's direction, then snap
  if( differenceAngle <= self.model.snapAngleThreshold or 
      differenceAngle >= twoPi - self.model.snapAngleThreshold
    ) then
    self:setAngle(objectiveAngle)
    self:setAngularVelocity(0)
  else -- could not snap - rotate using torques
    if(differenceAngle <= math.pi) then -- counter-clockwise
      self:setAngularVelocity(rotation)
    else
      self:setAngularVelocity(-rotation)
    end
  end
end

function Ship:fire()
  local module

  for _,slot in pairs(self.slots) do
    module = slot.module
    if(module~=nil and type(module.fire)=='function') then
      module:fire()
    end
  end
end

function Ship:draw()
  love.graphics.setColor(unpack(passion.white))
  super.draw(self)
end

function Ship:update()
  self:pacManCheck()
end
