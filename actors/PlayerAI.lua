require('actors/AI')

PlayerAI = class('PlayerAI', AI)
PlayerAI:includes(Beholder)

local twoPi = 2.0*math.pi

local _normalizeAngle = function(angle)
  angle = angle % twoPi
  return (angle < 0 and (angle + twoPi) or angle)
end

function PlayerAI:initialize()
  super.initialize(self)
  self._thrust = false
  self._strafeLeft = false
  self._strafeRight = false
  self._fire = false
  
  self:observe('keypressed_w', function(self) self._thrust = true end)
  self:observe('keypressed_a', function(self) self._strafeLeft = true end)
  self:observe('keypressed_d', function(self) self._strafeRight = true end)
  self:observe('mousepressed_l', function(self) self._fire = true end)
  self:observe('keyreleased_w', function(self) self._thrust = false end)
  self:observe('keyreleased_a', function(self) self._strafeLeft = false end)
  self:observe('keyreleased_d', function(self) self._strafeRight = false end)
  self:observe('mousereleased_l', function(self) self._fire = false end)
end

function PlayerAI:wantsThrust()
  return self._thrust
end

function PlayerAI:getStrafeDirection()
  if(self._strafeLeft) then return 'left' end
  if(self._strafeRight) then return 'right' end
  return nil
end

function PlayerAI:getRotationDirection()

  local ox, oy = love.mouse.getPosition()

  local vehicle = self:getVehicle()
  local x, y = vehicle:getPosition()
  local angle = vehicle:getAngle()
  local rotation = vehicle:getRotation()
  local inertia = vehicle:getInertia()
  local w = vehicle:getAngularVelocity()

  local targetAngle = math.atan2(oy-y,ox-x)
  local differenceAngle = _normalizeAngle(targetAngle - angle)

  --rotation = (differenceAngle * inertia) / (2*w*w)

  if(differenceAngle <= math.pi) then -- counter-clockwise
    return 'counterclockwise'
  else
    return 'clockwise'
  end

end

function PlayerAI:getWeaponsFired()
  local slotNames = {}

  if(self._fire) then
    for slotName,slot in pairs(self.vehicle.slots) do
      module = slot.module
      if(module~=nil and type(module.fire)=='function') then
        table.insert(slotNames, slotName)
      end
    end
  end

  return slotNames
end
