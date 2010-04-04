require('ShipModule')
require('PacManLike')

AstroObjectModel = class('AstroObjectModel')

function AstroObjectModel:initialize(name, centerX, centerY, quad, shapes)
  self.name = name
  self.centerX = centerX
  self.centerY = centerY
  self.quad = quad
  self.shapes = shapes
end

AstroObject = class('AstroObject', passion.ActorWithBody)
AstroObject:includes(PacManLike)

function AstroObject:initialize(model)
  super.initialize(self)

  self.model = model

  -- create body according to the spec
  self:newBody()
  for shapeType,shapeData in pairs(model.shapes) do
    if(shapeType=='circle') then
      self:newCircleShape(unpack(shapeData))
    elseif(shapeType=='polygon') then
      self:newPolygonShape(unpack(shapeData))
    elseif(shapeType=='rectangle') then
      self:newRectangleShape(unpack(shapeData))
    else
      error('Unknown shape type: ' .. shapeType)
    end
  end
  self:setMassFromShapes()
end

function AstroObject:draw()
  local x, y = self:getPosition()
  local model = self.model
  passion.graphics.drawq(model.quad, x, y, self:getAngle(), 1, 1, model.centerX, model.centerY)
  if(debug==true) then
    love.graphics.setColor(unpack(passion.lightGreen))
    self:drawShapes()
    love.graphics.rectangle('line', self:getBoundingBox())
  end
end

function AstroObject:update()
  self:pacManCheck()
end


