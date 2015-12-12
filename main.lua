require 'player'

function love.load()
  playerInit()

end


function love.update(dt)
  playerUpdate(dt)

end


function love.draw()
  playerDraw()

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

