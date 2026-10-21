function love.conf(t)
    t.identity = 'pong'
    t.version = '11.5'

    t.window.title = 'Pong'
    t.window.width = 1280
    t.window.height = 720
    t.window.resizable = true
    t.window.vsync = 1
    t.window.msaa = 0
    t.window.highdpi = false
end
