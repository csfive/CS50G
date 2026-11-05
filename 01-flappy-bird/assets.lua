local assets = {
    textures = {},
    fonts = {},
    sounds = {},
}

function assets.load()
    assets.textures.background = love.graphics.newImage('assets/textures/background.png')
    assets.textures.ground = love.graphics.newImage('assets/textures/ground.png')
    assets.textures.bird = love.graphics.newImage('assets/textures/bird.png')
    assets.textures.pipe = love.graphics.newImage('assets/textures/pipe.png')
    assets.textures.medalBronze = love.graphics.newImage('assets/textures/medal_bronze.png')
    assets.textures.medalSilver = love.graphics.newImage('assets/textures/medal_silver.png')
    assets.textures.medalGold = love.graphics.newImage('assets/textures/medal_gold.png')

    assets.fonts.small = love.graphics.newFont('assets/fonts/font.ttf', 8)
    assets.fonts.medium = love.graphics.newFont('assets/fonts/flappy.ttf', 14)
    assets.fonts.flappy = love.graphics.newFont('assets/fonts/flappy.ttf', 28)
    assets.fonts.huge = love.graphics.newFont('assets/fonts/flappy.ttf', 56)

    assets.sounds.jump = love.audio.newSource('assets/sounds/jump.wav', 'static')
    assets.sounds.explosion = love.audio.newSource('assets/sounds/explosion.wav', 'static')
    assets.sounds.hurt = love.audio.newSource('assets/sounds/hurt.wav', 'static')
    assets.sounds.score = love.audio.newSource('assets/sounds/score.wav', 'static')
    assets.sounds.pause = love.audio.newSource('assets/sounds/pause.wav', 'static')
    assets.sounds.music = love.audio.newSource('assets/sounds/marios_way.mp3', 'static')
end

return assets
