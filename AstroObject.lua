require('modules/PacManLike')
require('modules/BodyBuilder')

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
AstroObject:includes(BodyBuilder)

function AstroObject:initialize(model)
  super.initialize(self)
  self:buildBody(model.shapes)
  self.model = model
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


