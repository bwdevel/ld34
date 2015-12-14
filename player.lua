print 'Loading player.lua'

function playerInit()
  player = {
    x = love.window.getWidth()/2,
    y = love.window.getHeight()/2,
    r = 0,
    rmax = 0.125,
    rrate = 0,
    thrust = 0.25,
    thrustDecay = 0.125,
    rotate = false,
    fire = false,
    vx = 0,
    vy = 0,
    shield = false,
    energy = 100,
    sprite = love.graphics.newImage('images/ship.png'),
    ssprite = love.graphics.newImage('images/shield.png')
  }
  player.w = player.sprite:getWidth()
  player.h = player.sprite:getHeight()
  player.sw = player.ssprite:getWidth()
  player.sh = player.ssprite:getHeight()

  player.body = love.physics.newBody(world, player.x, player.y, "dynamic")
  player.shape = love.physics.newCircleShape(player.w/2) 
  player.fixture = love.physics.newFixture(player.body, player.shape, 1)
  player.fixture:setRestitution(0.9)

  bullets = {}
  bulletSpeed = 500
  delBullets = {}


end

function playerUpdate(dt)
  if player.rotate then 
    player.rrate = player.rrate + (player.thrust * dt) 
  else
    player.rrate = player.rrate - (player.thrustDecay * dt)
  end
  if player.rrate > player.rmax then player.rrate = player.rmax end
  if player.rrate < 0 then player.rrate = 0 end  
  player.r = player.r + player.rrate
  if player.fire then playerFire() end
  if #bullets > 0 then  bulletsUpdate(dt) end

end

function playerDraw()
  love.graphics.draw(player.sprite, player.x, player.y, player.r, 1, 1, player.w / 2, player.h / 2) 
  bulletsDraw()
  love.graphics.print("bullets: " .. #bullets, 10, 10)
  love.graphics.print("rrate:   " .. player.rrate, 10, 20)
  love.graphics.print("rot:     " .. player.r, 10, 30)

  if player.shield then love.graphics.draw(player.ssprite, player.x, player.y, 0, 1, 1, player.sw / 2, player.sh / 2) end
end

function playerFire()
  player.fire = false
  bulletCreate()
end

function bulletCreate()
  local bulletDx = bulletSpeed * math.cos(player.r)
  local bulletDy = bulletSpeed * math.sin(player.r)

  bullet = {}
  bullet.x = player.x
  bullet.y = player.y
  bullet.dx = bulletDx
  bullet.dy = bulletDy
  bullet.body = love.physics.newBody(world, bullet.x, bullet.y, "dynamic")
  bullet.shape = love.physics.newCircleShape(3)
  bullet.fixture = love.physics.newFixture(bullet.body, bullet.shape, 5)
  bullet.body:applyForce(bullet.dx, bullet.dy)
  table.insert(bullets, bullet) 
end

function bulletsDraw()
  for i, v in ipairs(bullets) do
--    love.graphics.circle("fill", v["x"], v["y"], 3)
 
    love.graphics.circle("fill", v.body:getX(), v.body:getY(), v.shape:getRadius())
  end
end

function bulletsUpdate(dt)
  for i, v in ipairs(bullets) do
    v.x = v.x + (v.dx * dt)
    v.y = v.y + (v.dy * dt)
  end

  local delBullets = {}
  for i, v in ipairs(bullets) do
    if v.x < 0 or v.x > love.window.getWidth() or
      v.y < 0 or v.y > love.window.getHeight() then
      table.insert(delBullets, i)
    end
  end
  if #delBullets > 0 then
    for i, v in ipairs(delBullets) do
      table.remove(bullets, v)
    end
  end
end
