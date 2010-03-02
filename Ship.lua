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
  for slotName,slotData in pairs(model.slotSpecs) do
    self.slots[slotName] = ShipSlot:new(self, slotName, slotData)
  end

  self:setPosition(x,y)
  self:setAngle(math.pi/2.0)
end

function Ship:getThrust()
  return self.model.baseThrust
end

function Ship:getStrafeThrust()
  return self.model.baseStrafeThrust
end

function Ship:getRotation()
  return self.model.baseRotation
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
