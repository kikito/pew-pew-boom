require('mixins/DebugDraw')

Module = class('Module', passion.ActorWithBody)
Module:includes(DebugDraw)

function Module:initialize(centerX, centerY, quad)
  super.initialize(self)
  self:newBody()
  self:setMass(centerX, centerY, 0.1, 0.1)
  self:setCenter(centerX, centerY)
  self.quad = quad
end

function Module:attach(slot)
  self.slot = slot
  self.vehicle = slot.vehicle
end

function Module:getDrawOrder()
  if(self.drawOrder~=nil) then return self.drawOrder end

  local vehicle = self.vehicle
  if(vehicle==nil) then return end

  local so = vehicle:getDrawOrder()
  if(so~=nil) then return so-1 end
end

function Module:update(dt)
  local vehicle, slot = self.vehicle, self.slot
  if(vehicle==nil or slot==nil) then return end
  
  local x,y = self.vehicle:getWorldPoint(slot.x, slot.y)
  self:setPosition(x,y)
  self:setAngle(vehicle:getAngle() + slot.angle ) -- FIXME: the slot.angle isn't ok
end



