require('passion.init')
require('PacManLike')


Projectile = passion.ActorWithBody:subclass('Projectile')
Projectile:includes(PacManLike)

Projectile.image = passion.graphics.getImage('images/image.png')
Projectile.quad1 = passion.graphics.newQuad(Projectile.image,  0,32, 16,16 )
Projectile.quad2 = passion.graphics.newQuad(Projectile.image, 16,32, 16,16 )
Projectile.quad3 = passion.graphics.newQuad(Projectile.image, 32,32, 16,16 )

Projectile.fireSound = passion.audio.getSource( 'sfx/pew.mp3', 'static', 4 )

function Projectile:initialize(x,y,angle,level,velX,velY, duration)
  super.initialize(self)

  self:newBody()
  self:setBullet(true)

  self:newRectangleShape(4,7,10,4)

  self:setMassFromShapes()

  self:setPosition(x,y)

  self:setAngle(angle)
  local c = math.cos(angle)
  local s = math.sin(angle)

  local strength = 1

  self:setLinearVelocity(velX, velY)
  self:applyImpulse(c*strength, s*strength)

  self.quad = Projectile['quad'..level]

  self.duration = duration

  self:after(duration, 'destroy')

  passion.audio.play(Projectile.fireSound)

end

function Projectile:draw()
  love.graphics.setColor(unpack(passion.white))
  local x, y = self:getPosition()
  passion.graphics.drawq(self.quad, x, y, self:getAngle(), 1, 1, 8, 8)
end

function Projectile:update()
  self:pacManCheck()
end
