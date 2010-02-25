require('passion.init')
require('PlayerShip')
require('ShipModels')
require('Weapons')
require('Thrusters')

Game = class('Game', StatefulObject)

-- load some functions using passion's built-in resource manager
Game.fonts = {
  title = passion:getFont('fonts/SVBasicManual.ttf', 70),
  button = passion:getFont('fonts/SVBasicManual.ttf', 40)
}

Game.image = passion:getImage('images/image.png')

function Game:initialize()
  super.initialize(self)

  self:gotoState('MainMenu')
end

local MainMenu = Game:addState('MainMenu')

function MainMenu:enterState()
  self.title = passion.gui.Label:new({
    text='pew pew BOOM!', 
    x=200, y=20, width=400, align='center',
    font=Game.fonts.title
  })

  self.startButton = passion.gui.Button:new({
    text='pew pew',
    x=150, y=200, width=500, valign='center',
    cornerRadius=10,
    font=Game.fonts.button,
    onClick = function(b) game:gotoState('Play') end
  })

  self.exitButton = passion.gui.Button:new({
    text='BOOM!',
    x=150, y=400, width=500,
    cornerRadius=10,
    font=Game.fonts.button,
    onClick = function(b) passion:exit() end
  })
end

function MainMenu:exitState()
  self.title:destroy()
  self.title = nil
  self.startButton:destroy()
  self.startButton = nil
  self.exitButton:destroy()
  self.exitButton = nil
end

local Play = Game:addState('Play')

function Play:enterState()

  passion:newWorld(3000, 3000)

  self.ship = PlayerShip(ShipModel.lens_culinaris, 100,100)

  self.ship.slots.frontLeft:attach(Cannon:new(3))
  self.ship.slots.frontRight:attach(Cannon:new(3))
  self.ship.slots.back:attach(Thruster:new(3))
end

function Play:exitState()
  passion:destroyWorld()
  self.ship:destroy()
  self.ship = nil
end
