
Orientable = {}

local twoPi = 2.0*math.pi

local _normalizeAngle = function(angle)
  angle = angle % twoPi
  return (angle < 0 and (angle + twoPi) or angle)
end

function Orientable:orientate()

  local ox, oy = self:getObjective()
  local x, y = self:getPosition()
  local rotation = self:getRotation()
  local angle = self:getAngle()
  local objectiveAngle = math.atan2(oy-y,ox-x)
  local differenceAngle = _normalizeAngle(objectiveAngle - angle)

  -- if the ship can snap to the objective's direction, then snap
  if( differenceAngle <= self.model.snapAngleThreshold or 
      differenceAngle >= twoPi - self.model.snapAngleThreshold
    ) then
    self:setAngle(objectiveAngle)
    self:setAngularVelocity(0)
  else -- could not snap - rotate using fixed rotation velocity
    if(differenceAngle <= math.pi) then -- counter-clockwise
      self:setAngularVelocity(rotation)
    else
      self:setAngularVelocity(-rotation)
    end
  end
end
