require('ShipModule')
require('AstroObject')

Asteroid = class('Asteroid', AstroObject)

Asteroid.image = passion.graphics.getImage('images/image.png')

function Asteroid:initialize(model,x,y)
  super.initialize(self, model)
  self:setPosition(x,y)
end


Asteroid.big_asteroid_1 =
  AstroObjectModel:new('Big Asteroid 1', 32,32, passion.graphics.newQuad(Asteroid.image, 320,0, 64,64),
    -- Shapes
    { polygon={-28,7 , -8,27 , 8,28 , 18,19 , 25,8 , 27,-10 , 5,-28 , -26,-12} }
  )

Asteroid.big_asteroid_2 =
  AstroObjectModel:new('Big Asteroid 2', 32,32, passion.graphics.newQuad(Asteroid.image, 384,0, 64,64),
    -- Shapes
    { polygon={-21,16 , -6,26, 8,28 , 23,14 , 25,-11 , 12,-25 , -11,-25, -25, -10} }
  )


