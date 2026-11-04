local Assets = {
    textures = {},
    fonts = {},
    sounds = {},
}

function Assets.load()
    Assets.textures.background = love.graphics.newImage('background.png')
    Assets.textures.ground = love.graphics.newImage('ground.png')
    Assets.textures.bird = love.graphics.newImage('bird.png')
    Assets.textures.pipe = love.graphics.newImage('pipe.png')
    Assets.textures.medalBronze = love.graphics.newImage('medal_bronze.png')
    Assets.textures.medalSilver = love.graphics.newImage('medal_silver.png')
    Assets.textures.medalGold = love.graphics.newImage('medal_gold.png')

    Assets.fonts.small = love.graphics.newFont('font.ttf', 8)
    Assets.fonts.medium = love.graphics.newFont('flappy.ttf', 14)
    Assets.fonts.flappy = love.graphics.newFont('flappy.ttf', 28)
    Assets.fonts.huge = love.graphics.newFont('flappy.ttf', 56)

    Assets.sounds.jump = love.audio.newSource('jump.wav', 'static')
    Assets.sounds.explosion = love.audio.newSource('explosion.wav', 'static')
    Assets.sounds.hurt = love.audio.newSource('hurt.wav', 'static')
    Assets.sounds.score = love.audio.newSource('score.wav', 'static')
    Assets.sounds.pause = love.audio.newSource('pause.wav', 'static')
    Assets.sounds.music = love.audio.newSource('marios_way.mp3', 'static')
end

return Assets
