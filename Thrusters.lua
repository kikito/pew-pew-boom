require('ShipModule')

Thruster = ShipModule:subclass('Thruster')

Thruster.image = passion.graphics.getImage('images/image.png')
Thruster.quad1 = passion.graphics.newQuad( Thruster.image,  0,64, 16,16 )
Thruster.quad2 = passion.graphics.newQuad( Thruster.image, 17,64, 16,16 )
Thruster.quad3 = passion.graphics.newQuad( Thruster.image, 33,64, 16,16 )

function Thruster:initialize(level)
  super.initialize(self, Thruster['quad' .. level], 8,8)
  self.level = level
end

function Thruster:getThrust()
  return self.level * 0.01
end

function Thruster:getStrafeThrust()
  return self.level * 0.003
end
