require('ShipModule')

Gyroscope = ShipModule:subclass('Gyroscope')

Gyroscope.image = passion.graphics.getImage('images/image.png')
Gyroscope.quad1 = passion.graphics.newQuad( Gyroscope.image, 48,32, 16,16 )
Gyroscope.quad2 = passion.graphics.newQuad( Gyroscope.image, 64,32, 16,16 )
Gyroscope.quad3 = passion.graphics.newQuad( Gyroscope.image, 80,32, 16,16 )

function Gyroscope:initialize(level)
  super.initialize(self, Gyroscope['quad' .. level], 8,8)
  self.level = level
end

function Gyroscope:getRotation()
  return self.level * 0.6
end
