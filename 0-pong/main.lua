push = require 'push'
Class = require 'class'
require 'Ball'
require 'Paddle'

-- actual window size
WINDOW_WIDTH, WINDOW_HEIGHT = 1280, 720
-- emulated window size by push
VIRTUAL_WIDTH, VIRTUAL_HEIGHT = 432, 243

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    love.window.setTitle("Pong")
    math.randomseed(os.time())

    smallFont = love.graphics.newFont('font.ttf', 8)
    largeFont = love.graphics.newFont('font.ttf', 16)
    scoreFont = love.graphics.newFont('font.ttf', 32)
    love.graphics.setFont(smallFont)

    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        resizable = false,
        fullscreen = false
    })
    push.setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, { upscale = 'normal' })

    player1 = Paddle(10, 30, 5, 20)
    player2 = Paddle(VIRTUAL_WIDTH - 15, VIRTUAL_HEIGHT - 50, 5, 20)
    ball = Ball(VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 - 2, 4, 4)
end

function love.resize(w, h)
    push.resize(w, h)
end

function love.update(dt)

end

function love.draw()
    push.start()
    love.graphics.clear(40 / 255, 45 / 255, 52 / 255, 1)
    player1:render()
    player2:render()
    ball:render()
    displayFPS()
    push.finish()
end

function displayFPS()
    love.graphics.setFont(smallFont)
    love.graphics.setColor(0, 1, 0, 1)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 10, 10)
    love.graphics.setColor(1, 1, 1, 1)
end
