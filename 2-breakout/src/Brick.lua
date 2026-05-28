Brick = Class {}

function Brick:init(x, y)
    self.x = x
    self.y = y
    self.width = 32
    self.height = 16
    self.tier = 0
    self.color = 1
    self.inPlay = true
end

function Brick:render()
    if self.inPlay then
        love.graphics.draw(
            gTextures['main'],
            gFrames['bricks'][1 + ((self.color - 1) * 4) + self.tier],
            self.x, self.y
        )
    end
end

function Brick:hit()
    gSounds['brick-hit-2']:stop()
    gSounds['brick-hit-2']:play()

    if self.color > 1 then
        self.color = self.color - 1
    elseif self.tier > 0 then
        self.tier = self.tier - 1
        self.color = 5
    else
        self.inPlay = false
    end

    if not self.inPlay then
        gSounds['brick-hit-1']:stop()
        gSounds['brick-hit-1']:play()
    end
end
