require('passion.init')

Bullet = passion.Actor:subclass('Bullet', {hasBody = true})

Bullet.image = passion.graphics.getImage('images/image.png')
Bullet.quad1 = passion.graphics.newQuad(  0,32, 16,16 )
Bullet.quad2 = passion.graphics.newQuad( 16,32, 16,16 )
Bullet.quad3 = passion.graphics.newQuad( 32,32, 16,16 )

function Bullet:initialize(x,y,angle,level,velX,velY)
  super.initialize(self)

  self:newBody()

  self:newRectangleShape(4,7,10,4)
  
  self:setMassFromShapes()

  self:setPosition(x,y)

  self.setAngle(angle)
  local c = math.cos(angle)
  local s = math.sin(angle)

  self:setLinearVelocity(velX, velY)
  self:applyImpulse(c*strength+velX, s*strength+velY)

  self.quad = Bullet['quad'..level]
end

function Bullet:draw()
  local x, y = self:getPosition()
  passion.graphics.drawq(self.quad, x, y, self:getAngle(), 1, 1, 8, 8)
end

function Bullet:update()
  
end
