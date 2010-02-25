require('passion.init')

ShipSlot = class('ShipSlot')

function ShipSlot:initialize(ship, name, specs)
  self.ship = ship
  self.name = name
  self.x = specs.x or 0
  self.y = specs.y or 0
  self.angle = specs.angle or 0
end

function ShipSlot:attach(module)

  if(self.module~=nil) then
    self.module:destroy()
  end

  self.module = module

  local x,y = self.ship:getWorldPoint(self.x, self.y)
  module:setPosition(x,y)
  self.joint = love.physics.newRevoluteJoint(self.ship:getBody(), module:getBody(), x, y)

  module:attach(self)
end



