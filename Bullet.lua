require('passion.init')

Bullet = passion.ActorWithBody:subclass('Bullet')

Bullet.image = passion.graphics.getImage('images/image.png')
Bullet.quad1 = passion.graphics.newQuad(Bullet.image,  0,32, 16,16 )
Bullet.quad2 = passion.graphics.newQuad(Bullet.image, 16,32, 16,16 )
Bullet.quad3 = passion.graphics.newQuad(Bullet.image, 32,32, 16,16 )

Bullet.fireSound = passion.audio.getSource( 'sfx/pew.wav', 'static' )

function Bullet:initialize(x,y,angle,level,velX,velY, duration)
  super.initialize(self)

  self:newBody()

  self:newRectangleShape(4,7,10,4)
  
  self:setMassFromShapes()

  self:setPosition(x,y)

  self:setAngle(angle)
  local c = math.cos(angle)
  local s = math.sin(angle)

  local strength = 2

  self:setLinearVelocity(velX, velY)
  self:applyImpulse(c*strength, s*strength)

  self.quad = Bullet['quad'..level]

  self.duration = duration

  passion.timer.after(duration, Bullet.destroy, self)

  love.audio.play(Bullet.fireSound)

end

function Bullet:draw()
  local x, y = self:getPosition()
  passion.graphics.drawq(self.quad, x, y, self:getAngle(), 1, 1, 8, 8)
end
