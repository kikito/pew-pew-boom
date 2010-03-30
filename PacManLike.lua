
PacManLike = {}

function PacManLike:pacManCheck()
  local x,y = self:getPosition()
  
  if(x < -16) then x = 800 end
  if(x > 816) then x = 0 end
  if(y < -16) then y = 600 end
  if(y > 610) then y = 0 end
  
  self:setPosition(x,y)

end



