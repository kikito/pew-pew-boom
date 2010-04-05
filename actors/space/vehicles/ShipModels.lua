ShipModel = class('ShipModel')

function ShipModel:initialize(centerX, centerY, quad, shapes, slots, options) 
  super.initialize(self)
  
  self.centerX = centerX
  self.centerY = centerY
  self.quad = quad
  self.shapes = shapes
  self.slots = slots

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
  -- Defaults to ~10 degrees
  self.snapAngleThreshold = options.directionSnapAngleThreshold or 0.02
end

local image = passion.graphics.getImage('images/image.png')

ShipModel.lens_culinaris = 
  ShipModel:new(16,16, passion.graphics.newQuad(image, 0,0, 32,32),
    -- Shapes
    { circle={0,0,16} },
    -- Slots
    { frontLeft= { x=6, y=-10 },
      frontRight={ x=6, y=10 },
      utility = { x=-9, y=0 },
      back={ x=-13, y=0 }
    },
    -- Other stuff
    { baseThrust=0.01, baseStrafeThrust=0.01, baseRotation=0.7 }
  )

ShipModel.razor = 
  ShipModel:new(16,16, passion.graphics.newQuad(image, 32,0, 32,32),
    -- Shapes
    { circle={0,0,16} },
    -- Slots
    { frontLeft= { x=6,y=-10 },
      frontRight={ x=6,y=10 },
      back={ x=-13, y=0 }
    },
    -- Other stuff
    { baseThrust=0.05, baseStrafeThrust=0.03, baseRotation=1.2 }
  )





