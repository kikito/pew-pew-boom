require('ShipModule')
require('Projectile')

Weapon = ShipModule:subclass('Weapon')

function Weapon:initialize(quad, centerX, centerY, coolDown)
  super.initialize(self, quad, centerX, centerY)
  self.coolDown = coolDown
end

function Weapon:fire()
  local ship, slot = self.ship, self.slot
  if(ship==nil or slot==nil) then return end

  local velX, velY = ship:getLinearVelocity()
  local x,y=self:getPosition()
  local angle = self:getAngle()

  Projectile:new(x,y,angle,self.level,velX,velY, 0.25*self.level)

  self:pushState('CoolingDown')
end

-- The weapon enters this state after firing
CoolingDown = Weapon:addState('CoolingDown')

function CoolingDown:enterState()
  self:after(self.coolDown, 'popState')
end

function CoolingDown:fire() end -- do nothing


Cannon = Weapon:subclass('Cannon')

Cannon.image = passion.graphics.getImage('images/image.png')
Cannon.quad1 = passion.graphics.newQuad( Cannon.image,  0,48, 16,16 )
Cannon.quad2 = passion.graphics.newQuad( Cannon.image, 17,48, 16,16 )
Cannon.quad3 = passion.graphics.newQuad( Cannon.image, 33,48, 16,16 )

function Cannon:initialize(level)
  super.initialize(self, Cannon['quad' .. level], 8,8, 0.5)
  self.level = level
end
