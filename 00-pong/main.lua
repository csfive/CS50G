WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

function love.load()
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true, -- 垂直同步，避免画面撕裂
    })
end

function love.draw()
    love.graphics.printf(
        'Hello World!',
        0, -- x，坐标系从左上角开始，向右向下
        WINDOW_HEIGHT / 2, -- y
        WINDOW_WIDTH, -- 居中用的宽度
        'center'
    )
end
