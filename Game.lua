require('passion.init')
require('PlayerShip')
require('ShipModels')
require('Weapons')
require('Thrusters')
require('Asteroids')
require('Gyroscopes')

debug = false

Game = class('Game', StatefulObject)
Game:includes(Beholder)

-- load some functions using passion's built-in resource manager
Game.fonts = {
  title = passion.fonts.getFont('fonts/SVBasicManual.ttf', 70),
  button = passion.fonts.getFont('fonts/SVBasicManual.ttf', 40)
}

function Game:initialize()
  super.initialize(self)

  self:gotoState('MainMenu')
  self:observe('keypressed_tab', 'toggleDebug')
end

function Game:toggleDebug()
  debug = not debug
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
    onClick = function(b) passion.exit() end
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

  passion.newWorld(3000, 3000)

  self.ship = PlayerShip(ShipModel.lens_culinaris, 100,100)

  self.ship:attach('frontLeft', Cannon:new(1))
  self.ship:attach('frontRight', Cannon:new(2))
  self.ship:attach('utility', Gyroscope:new(2))
  self.ship:attach('back', Thruster:new(1))

  local asteroidModels = {
    Asteroid.big_asteroid_1,
    Asteroid.big_asteroid_2,
    Asteroid.medium_asteroid_1,
    Asteroid.medium_asteroid_2,
    Asteroid.medium_asteroid_3,
    Asteroid.small_asteroid_1,
    Asteroid.small_asteroid_2,
    Asteroid.small_asteroid_3,
    Asteroid.small_asteroid_4
  }
  
  self.asteroids = {}
  
  for i=1,30 do
    table.insert(self.asteroids,
      Asteroid:new(asteroidModels[math.random(1,#asteroidModels)],
        math.random(150, 650),
        math.random(150, 450)
      )
    )
  end
end

function Play:exitState()
  self.ship:destroy()
  self.ship = nil
  for _,asteroid in ipairs(self.asteroids) do
    asteroid:destroy()
  end
  self.asteroids = nil
  passion.destroyWorld()
end
