local Assets = {
    textures = {},
    fonts = {},
    sounds = {},
}

function Assets.load()
    Assets.textures.background = love.graphics.newImage('assets/textures/background.png')
    Assets.textures.ground = love.graphics.newImage('assets/textures/ground.png')
    Assets.textures.bird = love.graphics.newImage('assets/textures/bird.png')
    Assets.textures.pipe = love.graphics.newImage('assets/textures/pipe.png')
    Assets.textures.medalBronze = love.graphics.newImage('assets/textures/medal_bronze.png')
    Assets.textures.medalSilver = love.graphics.newImage('assets/textures/medal_silver.png')
    Assets.textures.medalGold = love.graphics.newImage('assets/textures/medal_gold.png')

    Assets.fonts.small = love.graphics.newFont('assets/fonts/font.ttf', 8)
    Assets.fonts.medium = love.graphics.newFont('assets/fonts/flappy.ttf', 14)
    Assets.fonts.flappy = love.graphics.newFont('assets/fonts/flappy.ttf', 28)
    Assets.fonts.huge = love.graphics.newFont('assets/fonts/flappy.ttf', 56)

    Assets.sounds.jump = love.audio.newSource('assets/sounds/jump.wav', 'static')
    Assets.sounds.explosion = love.audio.newSource('assets/sounds/explosion.wav', 'static')
    Assets.sounds.hurt = love.audio.newSource('assets/sounds/hurt.wav', 'static')
    Assets.sounds.score = love.audio.newSource('assets/sounds/score.wav', 'static')
    Assets.sounds.pause = love.audio.newSource('assets/sounds/pause.wav', 'static')
    Assets.sounds.music = love.audio.newSource('assets/sounds/marios_way.mp3', 'static')
end

return Assets
