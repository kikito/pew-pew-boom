require('mixins/PacManLike.lua')
require('mixins/DebugDraw.lua')

Projectile = class('Projectile', passion.ActorWithBody)
Projectile:includes(PacManLike)
Projectile:includes(DebugDraw)

function Projectile:initialize(x,y,velX,velY,angle,duration,impulse,quad)
  super.initialize(self)

  self:newBody()
  self:setBullet(true)

  self:newRectangleShape(4,7,10,4)
  self:setMassFromShapes()

  self:setPosition(x,y)
  self:setAngle(angle)
  self:setLinearVelocity(velX, velY)
  self:applyImpulse(math.cos(angle)*impulse, math.sin(angle)*impulse)

  self.quad = quad
  self:after(duration, 'destroy')
end

function Projectile:update()
  self:pacManCheck()
end
