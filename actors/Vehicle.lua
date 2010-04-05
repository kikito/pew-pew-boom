require('actors/Slot.lua')
require('mixins/BodyBuilder.lua')
require('mixins/SlotBuilder.lua')
require('mixins/DebugDraw.lua')

Vehicle = class('Vehicle', passion.ActorWithBody)

Vehicle:includes(BodyBuilder)
Vehicle:includes(SlotBuilder)
Vehicle:includes(DebugDraw)

function Vehicle:initialize(x, y, cx, cy, shapes, slots, quad)
  super.initialize(self)
  self:buildBody(shapes)
  self:buildSlots(slots)
  self:setPosition(x,y)
  self:setCenter(cx,cy)
  self.quad = quad
end

function Vehicle:attach(slotName, module)
  self.slots[slotName]:attach(module)
end



