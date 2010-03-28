require('passion.init')


ShipModel = class('ShipModel')

function ShipModel:initialize(name, centerX, centerY, quad, shapes, slotSpecs, options)
  self.name = name
  self.centerX = centerX
  self.centerY = centerY
  self.quad = quad
  self.shapes = shapes
  self.slotSpecs = slotSpecs
  
  options = options or {}
  
  -- The ship impulse, without thrusters
  self.baseThrust = options.baseThrust or 0.05

  -- The ship lateral impulse, without lateral thrusters
  self.baseStrafeThrust = options.baseStrafeThrust or 0.02

  -- The ship rotation torque, without rotational thrusters / gyroscopes
  self.baseRotation = options.baseRotation or 0.1

  -- The max angular speed that the ship can get, even with rotational thrusters / gyroscopes
  self.maxAngularVelocity = options.maxAngularVelocity or 0.6

  -- The angle on which the ship "snaps" to the target direction
  -- Defaults to ~20 degrees
  self.snapAngleThreshold = options.directionSnapAngleThreshold or 0.05
end

ShipModel.image = passion.graphics.getImage('images/image.png')

ShipModel.lens_culinaris = 
  ShipModel:new("Lens culinaris", 16,16, passion.graphics.newQuad(ShipModel.image, 0,0, 32,32),
    -- Shapes
    { circle={0,0,16} },
    -- Slots
    { frontLeft= { x=6,y=-10, angle=0 },
      frontRight={ x=6,y=10, angle=0 },
      back={ x=-13, y=0, angle=0 }
    },
    -- Other stuff
    { baseThrust=0.01, baseStrafeThrust=0.01, baseRotation=0.5 }
  )




