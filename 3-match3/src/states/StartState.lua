StartState = Class { __includes = BaseState }

local positions = {}

function StartState:init()
    for i = 1, 64 do
        table.insert(positions, gFrames['tiles'][math.random(18)][math.random(6)])
    end
end

function StartState:update(dt)
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
end

function StartState:render()
    for y = 1, 8 do
        for x = 1, 8 do
            -- render shadow first
            love.graphics.setColor(0, 0, 0, 1)
            love.graphics.draw(
                gTextures['main'],
                positions[(y - 1) * x + x],
                (x - 1) * 32 + 128 + 3,
                (y - 1) * 32 + 16 + 3
            )

            love.graphics.setColor(1, 1, 1, 1)
            love.graphics.draw(
                gTextures['main'],
                positions[(y - 1) * x + x],
                (x - 1) * 32 + 128,
                (y - 1) * 32 + 16
            )
        end
    end

    love.graphics.setColor(0, 0, 0, 128 / 255)
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
end
