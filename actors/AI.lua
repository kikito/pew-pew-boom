AI = class('AI', passion.Actor)

function AI:initialize()
  super.initialize(self)
end

function AI:setVehicle(vehicle)
  self.vehicle = vehicle
end

function AI:getVehicle(vehicle)
  return self.vehicle
end
