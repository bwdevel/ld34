require 'TEsound'
require 'player'
require 'rocks'

function love.load()
  debug = true
  love.physics.setMeter(32)
  --world = love.physics.newWorld(0, 9.81*32, true) 
  world = love.physics.newWorld(0, 0, true) 
  objects = {}
  playerInit()
  rocksInit()

end


function love.update(dt)
  TEsound.cleanup()
  world:update(dt)

  playerUpdate(dt)
  rocksUpdate(dt)
end


function love.draw()
  playerDraw()
  rocksDraw()
end


function love.keypressed(key)
  if key == 'f' then 
    player.fire = false
    player.rotate = true
  end
  if key == 'j' then
    player.shield = true
  end

end


function love.keyreleased(key)
  if key == 'q' then love.event.quit() end
  
  if key == 'f' then 
    player.fire = true
    player.rotate = false
  end
  if key == 'j' then
    player.shield = false
  end
end

function getDistance(x1, y1, x2, y2)
  a = math.abs(x1 - x2)
  b = math.abs(y1 - y2)
  c = (a * a) + (b * b)
  return math.sqrt(c)
end
