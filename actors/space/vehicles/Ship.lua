require('actors/Module.lua')
require('actors/Slot.lua')
require('actors/Vehicle.lua')
require('mixins/PacManLike.lua')
require('mixins/Orientable.lua')

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

local _getSinCosAngle = function(self)
  local angle = self:getAngle()
  return math.sin(angle), math.cos(angle)
end

Ship = class('Ship', Vehicle)
Ship:includes(PacManLike)
Ship:includes(Orientable)

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
  local s,c = _getSinCosAngle(self)
  local thrust = self:getThrust()
  self:applyImpulse( c*thrust, s*thrust )
end

function Ship:strafeLeft()
  local s,c = _getSinCosAngle(self)
  local strafeThrust = self:getStrafeThrust()
  self:applyImpulse( s*strafeThrust, -c*strafeThrust )
end

function Ship:strafeRight()
  local s,c = _getSinCosAngle(self)
  local strafeThrust = self:getStrafeThrust()
  self:applyImpulse( -s*strafeThrust, c*strafeThrust )
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
