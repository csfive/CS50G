local push = require('push')

WINDOW_WIDTH, WINDOW_HEIGHT = 1280, 720
VIRTUAL_WIDTH, VIRTUAL_HEIGHT = 432, 243

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    love.math.setRandomSeed(os.time())
    love.window.setTitle('Pong')

    smallFont = love.graphics.newFont('font.ttf', 8)
    largeFont = love.graphics.newFont('font.ttf', 16)
    scoreFont = love.graphics.newFont('font.ttf', 32)
    love.graphics.setFont(smallFont)

    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
        resizable = true,
        fullscreen = false,
        vsync = true,
    })
    push.setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, { upscale = 'normal' })
end

function love.resize(w, h)
    push.resize(w, h)
end

function love.update(dt) end

function love.draw()
    push.start()
    love.graphics.clear(40 / 255, 45 / 255, 52 / 255, 255 / 255)
    displayFPS()
    push.finish()
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end

function displayFPS()
    love.graphics.setFont(smallFont)
    love.graphics.setColor(0, 255 / 255, 0, 255 / 255)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 10, 10)
    love.graphics.setColor(255, 255, 255, 255)
end
