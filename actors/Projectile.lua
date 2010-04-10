require('mixins/PacManLike.lua')
require('mixins/DebugDraw.lua')
require('mixins/HasGroupIndex.lua')

Projectile = class('Projectile', passion.ActorWithBody)
Projectile:includes(PacManLike)
Projectile:includes(DebugDraw)
Projectile:includes(HasGroupIndex)

function Projectile:initialize(x,y,velX,velY,angle,groupIndex,duration,impulse,quad)
  super.initialize(self)

  self:newBody()
  self:setBullet(true)

  self:newRectangleShape(-5,-2,10,4)
  self:setCenter(8,8)
  self:setMassFromShapes()
  self:setGroupIndex(groupIndex)

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
