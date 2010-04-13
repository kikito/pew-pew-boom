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

local _drawAngle = function(x,y,angle, color)
  love.graphics.setColor(unpack(color))
  
  -- love.graphics.line(x,y,x+math.cos(angle)*20, y + math.sin(angle)*20)
  
  love.graphics.rectangle('line', x,y, 10, angle*30)
end

function _sign(x)
  return x>0 and 1 or x<0 and -1 or 0
end

function PlayerAI:draw()
  if(debug) then

    love.graphics.print('braking: ' .. tostring(self.braking), 100, 240)
    love.graphics.print('w: ' .. tostring(self.w), 100, 300)
    love.graphics.print('direction: ' .. tostring(self.direction), 100, 260)
    love.graphics.print('quadrant: ' .. tostring(self.quadrant), 100, 280)
    --love.graphics.reset()
    _drawAngle(50,220,0, passion.white)
    _drawAngle(50,220,math.pi/2.0, passion.white)
    _drawAngle(60,220,self.differenceAngle, passion.green)
    _drawAngle(70,220,self.brakingAngle, passion.red)
  end
end


function PlayerAI:getRotationDirection()

  local ox, oy = love.mouse.getPosition()

  local vehicle = self:getVehicle()
  local x, y = vehicle:getPosition()
  local angle = vehicle:getAngle()
  local maxTorque = vehicle:getRotation()
  local inertia = vehicle:getInertia()
  local w = vehicle:getAngularVelocity()

  self.targetAngle = math.atan2(oy-y,ox-x)
  self.differenceAngle = _normalizeAngle(self.targetAngle - angle)
  self.braking = false


  self.w = w

  if(self.differenceAngle < math.pi) then -- clockwise is the shortest path
    self.quadrant = 1
    self.direction = 'clockwise'
    self.brakingAngle = 2.0*w*w*inertia/maxTorque
    if(self.brakingAngle > self.differenceAngle) then
      if(w>0) then
        self.braking = true
        self.direction = 'counterclockwise'
      end
    end
  else -- second half
    self.quadrant = 2
    self.direction = 'counterclockwise'
    self.brakingAngle = _normalizeAngle(twoPi-2.0*w*w*inertia/maxTorque)
    if(self.brakingAngle < self.differenceAngle) then
      if(w<0) then
        self.braking = true
        self.direction = 'clockwise'
      end
    end
  end
  
  

  return self.direction
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
