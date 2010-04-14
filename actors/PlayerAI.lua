require('actors/AI')

PlayerAI = class('PlayerAI', AI)
PlayerAI:includes(Beholder)

local twoPi = 2.0*math.pi

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

function _sign(x)
  return x>0 and 1 or x<0 and -1 or 0
end

local _normalizeAngle = function(angle)
  angle = angle % twoPi
  return (angle < 0 and (angle + twoPi) or angle)
end

function PlayerAI:getRotationDirection()

  local ox, oy = love.mouse.getPosition()

  local vehicle = self:getVehicle()
  local x, y = vehicle:getPosition()
  local angle = vehicle:getAngle()
  local maxTorque = vehicle:getRotation()
  local inertia = vehicle:getInertia()
  local w = vehicle:getAngularVelocity()

  local targetAngle = math.atan2(oy-y,ox-x)
  -- difference between my angle and my target angle
  local differenceAngle = _normalizeAngle(targetAngle - angle)
  -- the distance i would move before stopping, if I started stopping just now, with my current w
  local brakingAngle = _normalizeAngle(_sign(w)*2.0*w*w*inertia/maxTorque)

  local torque = maxTorque
  local a,b,c = differenceAngle > math.pi, brakingAngle > differenceAngle, w > 0
  -- two of these 3 conditions must be true
  if( (a and b) or (a and c) or (b and c) ) then
    torque = -torque
  end

  return torque > 0 and 'clockwise' or 'counterclockwise'
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
