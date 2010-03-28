require('passion.init')
require('ShipModule')
require('ShipSlot')
require('Weapons')

Ship = passion.ActorWithBody:subclass('Ship')

function Ship:initialize(model,x,y)
  super.initialize(self)

  self.model = model

  -- create body according to the spec
  self:newBody()
  for shapeType,shapeData in pairs(model.shapes) do
    if(shapeType=='circle') then
      self:newCircleShape(unpack(shapeData))
    elseif(shapeType=='polygon') then
      self:newPolygonShape(unpack(shapeData))
    elseif(shapeType=='rectangle') then
      self:newRectangleShape(unpack(shapeData))
    else
      error('Unknown shape type: ' .. shapeType)
    end
  end

  self:setMassFromShapes()

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
end

function Ship:getStrafeThrust()
  local thrust = self.model.baseStrafeThrust
  for _,slot in pairs(self.slots) do
    module = slot.module
    if(instanceOf(Thruster,module)) then
      thrust = thrust + module:getStrafeThrust()
    end
  end
end

function Ship:getRotation()
  local rotation = self.model.baseRotation
  for _,slot in pairs(self.slots) do
    module = slot.module
    if(instanceOf(Gyroscope,module)) then
      rotation = rotation + module:getRotation()
    end
  end
end

function Ship:getObjective()
  return 0,0
end

function Ship:draw()
  local x, y = self:getPosition()
  local model = self.model
  self:drawShapes()
  passion.graphics.drawq(model.quad, x, y, self:getAngle(), 1, 1, model.centerX, model.centerY)
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
