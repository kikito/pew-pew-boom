require('actors/Slot.lua')
require('mixins/BodyBuilder.lua')
require('mixins/SlotBuilder.lua')
require('mixins/DebugDraw.lua')
require('mixins/HasGroupIndex.lua')

Vehicle = class('Vehicle', passion.physics.Actor)

Vehicle:includes(BodyBuilder)
Vehicle:includes(SlotBuilder)
Vehicle:includes(DebugDraw)
Vehicle:includes(HasGroupIndex)

function Vehicle:initialize(x, y, cx, cy, shapes, slots, quad)
  super.initialize(self)
  self:buildBody(shapes)
  self:getNewGroupIndex()
  self:buildSlots(slots)
  self:setPosition(x,y)
  self:setCenter(cx,cy)
  self.quad = quad
end

function Vehicle:getSlot(slotName)
  local slot = self.slots[slotName]
  assert(slot~=nil, "Slot " .. slotName .. " not found on ship. Available slots: " .. tostring(self.slots))
  return slot
end

function Vehicle:attach(slotName, module)
  self:getSlot(slotName):attach(module)
end



