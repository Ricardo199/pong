push= require 'libraries/push'
WINDOW_WIDTH= 1280
WINDOW_HEIGHT= 720

VIRTUAL_WIDTH= 432
VIRTUAL_HEIGHT= 243

PADDLE_SPEED= 200

function love.load()
  love.graphics.setDefaultFilter('nearest', 'nearest')
  math.randomseed(os.time())
  smallFont= love.graphics.newFont('fonts/font.ttf', 8)
  scoreFont= love.graphics.newFont('fonts/font.ttf', 32)
  love.graphics.setFont(smallFont)
  push: setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT,{
      fullscreen= false,
      resizable= false,
      vsync= true
    })
  
  player1Score= 0
  player2Score= 0
  
  player1y= 30
  player2y= VIRTUAL_HEIGHT - 50
  
  ballX= VIRTUAL_WIDTH/2 - 2
  ballY= VIRTUAL_HEIGHT/2 - 2
  
  ballDX= math.random(2)== 1 and 100 or -100
  ballDY= math.random(-50, 50)
  
  gameState= 'start'
end

function love.update(dt)
  --player1 movement
  if love.keyboard.isDown('w') then
    player1y= math.max(0, player1y + -PADDLE_SPEED * dt)
  elseif love.keyboard.isDown('s') then
    player1y= math.min(VIRTUAL_HEIGHT - 20, player1y  + PADDLE_SPEED * dt)
  end
  if love.keyboard.isDown('up') then
    player2y= math.max(0, player2y+ -PADDLE_SPEED *dt)
  elseif love.keyboard.isDown('down') then
    player2y= math.min(VIRTUAL_HEIGHT - 20, player2y + PADDLE_SPEED * dt)
  end
  
  if gameState== 'play' then
    ballX= ballX + ballDX * dt
    ballY= ballY + ballDY * dt
  end
end

function love.keypressed(key)
  if key== 'escape' then
    love.event.quit()
  elseif key== 'enter' or key== 'return' then
    if gameState== 'start' then
       gameState= 'play'
    else
      gameState= 'start'
      ballX= VIRTUAL_WIDTH/2 - 2
      ballY= VIRTUAL_HEIGHT/2 -2
      
      ballDX= math.random(2)== 1 and 100 or -100
      ballDY= math.random(-50, 50)* 1.5
    end
  end
end

function love.draw()
  push:apply('start')
  
  love.graphics.clear(40/255, 45/255, 52/255, 255/255)
  love.graphics.setFont(smallFont)
  if gameState== 'start' then
    love.graphics.printf('Hello Start State!', 0, 20, VIRTUAL_WIDTH, 'center')
  elseif gameState== 'play' then
    love.graphics.printf('Hello Play State!', 0, 20, VIRTUAL_WIDTH, 'center')
  end
  
  love.graphics.setFont(scoreFont)
  love.graphics.print(tostring(player1Score), VIRTUAL_WIDTH/2 - 50, VIRTUAL_HEIGHT/3)
  love.graphics.print(tostring(player2Score), VIRTUAL_WIDTH/2 + 30, VIRTUAL_HEIGHT/3)
    --player1 paddle
    love.graphics.rectangle('fill', 10, player1y, 5, 20)
    --player2 paddle
    love.graphics.rectangle('fill', VIRTUAL_WIDTH - 15, player2y, 5, 20)
    --ball
    love.graphics.rectangle('fill', ballX, ballY, 4, 4)
    
    push:apply('end')
end