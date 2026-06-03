Powerup = Class{}

-- powerup types
POWERUP_BALLS = 9
POWERUP_KEY = 10

POWERUP_SPEED = 60

function Powerup:init(x, y, powerupType)
    self.x = x
    self.y = y
    self.width = 16
    self.height = 16
    self.powerupType = powerupType
    self.dy = POWERUP_SPEED
    self.inPlay = true
end

function Powerup:update(dt)
    self.y = self.y + self.dy * dt
    if self.y >= VIRTUAL_HEIGHT then
        self.inPlay = false
    end
end

function Powerup:render()
    if self.inPlay then
        love.graphics.draw(
            gTextures['main'],
            gFrames['powerups'][self.powerupType],
            self.x, self.y
        )
    end
end

function Powerup:collides(target)
    if self.x > target.x + target.width or target.x > self.x + self.width then
        return false
    end
    if self.y > target.y + target.height or target.y > self.y + self.height then
        return false
    end
    return true
end
