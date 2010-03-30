require('ShipModule')
require('AstroObject')

local twoPi = math.pi * 2.0


local colors = {
  passion.white,
  passion.yellow,
  passion.green,
  passion.blue,
  passion.red
}

Asteroid = class('Asteroid', AstroObject)

Asteroid.image = passion.graphics.getImage('images/image.png')

function Asteroid:initialize(model,x,y)
  local rnd = math.random
  super.initialize(self, model)
  self:setPosition(x,y)
  self:setAngle(rnd() * twoPi)
  self:applyTorque(rnd(-1,1) * rnd())
  self:setLinearVelocity(rnd(-20,20) * rnd(), rnd(-20,20) * rnd())
  self.color = colors[rnd(1,#colors)]
end

function Asteroid:draw()
  love.graphics.setColor(unpack(self.color))
  super.draw(self)
end


Asteroid.big_asteroid_1 =
  AstroObjectModel:new('Big Asteroid 1', 32,32, passion.graphics.newQuad(Asteroid.image, 320,0, 64,64),
    { polygon={-28,-7 , -8,-27 , 8,-28 , 18,-19 , 25,-8 , 27,10 , 5,28 , -24,18} }
  )

Asteroid.big_asteroid_2 =
  AstroObjectModel:new('Big Asteroid 2', 32,32, passion.graphics.newQuad(Asteroid.image, 384,0, 64,64),
    { polygon={-21,-16 , -6,-26, 8,-27 , 23,-14 , 25,11 , 12,25 , -11,25, -25,10} }
  )

Asteroid.medium_asteroid_1 =
  AstroObjectModel:new('Medium Asteroid 1', 16,16 , passion.graphics.newQuad(Asteroid.image, 448,0, 32,32),
    { polygon={-6,-8 , 3,-8 , 8,-3 , 10,7 , 6,10 , -2,11 , -7,1} }
  )

Asteroid.medium_asteroid_2 =
  AstroObjectModel:new('Medium Asteroid 2', 16,16 , passion.graphics.newQuad(Asteroid.image, 480,0, 32,32),
    { polygon={-3,-11 , 2,-13 , 5,-8 , 7,12 , 2,13 , -8,6 , -4,1} }
  )

Asteroid.medium_asteroid_3 =
  AstroObjectModel:new('Medium Asteroid 3', 16,16 , passion.graphics.newQuad(Asteroid.image, 448,32, 32,32),
    { circle={-1.5, -1, 9} }
  )

Asteroid.small_asteroid_1 =
  AstroObjectModel:new('Small Asteroid 1', 8,8 , passion.graphics.newQuad(Asteroid.image, 480,32, 16,16),
    { polygon={-4,-3 , 1,-4 , 5,-2 , 6,4 , -3,3} }
  )

Asteroid.small_asteroid_2 =
  AstroObjectModel:new('Small Asteroid 2', 8,8 , passion.graphics.newQuad(Asteroid.image, 496,32, 16,16),
    { polygon={1,-3 , 4,-3 , 4,1 , 1,4 , -3,4 , -3,1} }
  )

Asteroid.small_asteroid_3 =
  AstroObjectModel:new('Small Asteroid 3', 8,8 , passion.graphics.newQuad(Asteroid.image, 480,48, 16,16),
    { polygon={4,-3 , 1,-5 , 3,-5 , 6,-2 , 6,2 , 2,6 , -2,6 , -4,4} }
  )

Asteroid.small_asteroid_4 =
  AstroObjectModel:new('Small Asteroid 4', 8,8 , passion.graphics.newQuad(Asteroid.image, 496,48, 16,16),
    { polygon={-4,-2 , -1,-5 , 3,-5 , 5,-3 , 5,4 , 2,6 , -3,5 , -4,2 } }
  )



