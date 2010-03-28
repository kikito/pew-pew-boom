require('passion.init')
require('ShipModule')
require('ShipSlot')
require('Weapons')
require('AstroObject')


local twoPi = 2.0*math.pi

local _normalizeAngle = function(angle)
  angle = angle % twoPi
  return (angle < 0 and (angle + twoPi) or angle)
end

Ship = class('Ship', AstroObject)

function Ship:initialize(model,x,y)
  super.initialize(self, model)

  self.model = model

  -- Initialize ship slots
  self.slots = {}
  for slotName,slotSpec in pairs(model.slotSpecs) do
    self.slots[slotName] = ShipSlot:new(self, slotName, slotSpec)
  end

  self:setPosition(x,y)
  self:setAngle(math.pi/2.0)
end

function Ship:getThrust()
  local thrust = self.model.baseThrust
  for _,slot in pairs(self.slots) do
    module = slot.module
    if(instanceOf(Thruster,module)) then
      thrust = thrust + module:getThrust()
    end
  end
  return thrust
end

function Ship:getStrafeThrust()
  local thrust = self.model.baseStrafeThrust
  for _,slot in pairs(self.slots) do
    module = slot.module
    if(instanceOf(Thruster,module)) then
      thrust = thrust + module:getStrafeThrust()
    end
  end
  return thrust
end

function Ship:getRotation()
  local rotation = self.model.baseRotation
  for _,slot in pairs(self.slots) do
    module = slot.module
    if(instanceOf(Gyroscope,module)) then
      rotation = rotation + module:getRotation()
    end
  end
  return rotation
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
    if(instanceOf(Weapon,module)) then
      module:fire()
    end
  end
end
