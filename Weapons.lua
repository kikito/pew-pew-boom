require('ShipModule')

Weapon = ShipModule:subclass('Weapon')

function Weapon:initialize(quad, centerX, centerY, ammo)
  super.initialize(self, quad, centerX, centerY)
  self.ammo = ammo
end

function Weapon:fire()
  local ship, slot = self.ship, self.slot
  if(ship==nil or slot==nil) then return end

  local velX, velY = ship:getLinearVelocity()
end


Cannon = ShipModule:subclass('Cannon')

Cannon.image = passion:getImage('images/image.png')
Cannon.quad1 = passion.graphics.newQuad( Cannon.image,  0,48, 16,16 )
Cannon.quad2 = passion.graphics.newQuad( Cannon.image, 17,48, 16,16 )
Cannon.quad3 = passion.graphics.newQuad( Cannon.image, 33,48, 16,16 )

function Cannon:initialize(level)
  super.initialize(self, Cannon['quad' .. level], 8,8)
  self.level = level
end
