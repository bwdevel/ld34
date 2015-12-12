print 'Loading rocks.lua'

function rocksInit()
  rocks = {}
  for i = 1, 20 do
    local speed = math.random(20,50)
    local rot = math.rad(math.random(0,360))
    local rock = {
      col = false,
      x = math.random(0, love.window.getWidth()), 
      y = math.random(0, love.window.getHeight()),
      r = math.random(20,40),
      vx = speed * math.cos(rot),
      vy = speed * math.sin(rot),
      d = 0
    }
    table.insert(rocks, rock)
  end
end


function rocksUpdate(dt)
  for i, v in ipairs(rocks) do
    v.x = v.x + (v.vx * dt)
    v.y = v.y + (v.vy * dt)
    v.d = getDistance(v.x, v.y, player.x, player.y)

    if v.x < 0 then v.x = love.window.getWidth() end
    if v.x > love.window.getWidth() then v.x = 0 end
    if v.y < 0 then v.y = love.window.getHeight() end
    if v.y > love.window.getHeight() then v.y = 0 end
    if v.d < v.r + 32 then 
      v.vx = v.vx * -1
      v.vy = v.vy * -1
    end
  end

end


function rocksDraw()
  for i, v in ipairs(rocks) do
    love.graphics.circle('line', v.x, v.y, v.r)
    if debug then
      love.graphics.point(v.x, v.y)
      --love.graphics.print(tostring(v.d), v.x + 5, v.y + 5 )
    end
  end

end
