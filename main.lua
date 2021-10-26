require("src/Dependencies");

function love.load()
    -- set filter to make 2d nicer
    love.graphics.setDefaultFilter('nearest', 'nearest');

    -- set name for game
    love.window.setTitle('Breakout');

    -- set virtual resoulution
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        resizable = true,
        vsync = true,
        fullscreen = false
    });

    -- init fonts for game
    gFonts = {
        ['small'] = love.graphics.newFont('fonts/font.ttf', 8),
        ['medium'] = love.graphics.newFont('fonts/font.ttf', 16),
        ['large'] = love.graphics.newFont('fonts/font.ttf', 32)
    }

    -- load all arts
    gTextures = {
        ['background'] = love.graphics.newImage('arts/background.png'),
        ['arrows'] = love.graphics.newImage('arts/arrows.png'),
        ['blocks'] = love.graphics.newImage('arts/breakout.png'),
        ['hearts'] = love.graphics.newImage('arts/hearts.png'),
        ['particle'] = love.graphics.newImage('arts/particle.png')
    }

    -- load all sprites in sprite sheet up there
    gSprites = {
        ['paddles'] = GenerateQuadsPaddles(gTextures['blocks']),
        ['blocks'] = GenerateQuadsBlock(gTextures['blocks']),
        ['balls'] = GenerateQuadsBall(gTextures['blocks'])
    }

    -- load all sounds
    gSounds = {
        ['brick-hit-1'] = love.audio.newSource('sounds/brick-hit-1.wav', 'static'),
        ['brick-hit-2'] = love.audio.newSource('sounds/brick-hit-2.wav', 'static'),
        ['confirm'] = love.audio.newSource('sounds/confirm.wav', 'static'),
        ['high_score'] = love.audio.newSource('sounds/high_score.wav', 'static'),
        ['hurt'] = love.audio.newSource('sounds/hurt.wav', 'static'),
        ['music'] = love.audio.newSource('sounds/music.wav', 'static'),
        ['no-select'] = love.audio.newSource('sounds/no-select.wav', 'static'),
        ['paddle_hit'] = love.audio.newSource('sounds/paddle_hit.wav', 'static'),
        ['pause'] = love.audio.newSource('sounds/pause.wav', 'static'),
        ['recover'] = love.audio.newSource('sounds/recover.wav', 'static'),
        ['score'] = love.audio.newSource('sounds/score.wav', 'static'),
        ['select'] = love.audio.newSource('sounds/select.wav', 'static'),
        ['victory'] = love.audio.newSource('sounds/victory.wav', 'static'),
        ['wall_hit'] = love.audio.newSource('sounds/wall_hit.wav', 'static'),
    }

    -- init state machine
    gStateMachine = StateMachine({
        ['Welcome'] = function () return WelcomeState(); end,
        ['Play'] = function() return PlayState(); end,
    })

    gStateMachine:change('Welcome');
    love.keyboard.keysPressed = {}
end

-- when a key is pressed, change state of key in array
function love.keypressed(key) 
    love.keyboard.keysPressed[key] = true;
end

-- If a key is pressed at this tick return true
function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key];
end

-- Update every tick(frame)
function love.update(dt)
    gStateMachine:update(dt);
    love.keyboard.keysPressed = {}
end

function love.draw()
    push:apply('start');

    local bgWidth = gTextures['background']:getWidth();
    local bgHeight = gTextures['background']:getHeight();
    love.graphics.draw(gTextures['background'], 
        -- position
        0, 0, 
        -- rotation
        0,
        -- scale ( minus one for mistake of float number)
        VIRTUAL_WIDTH / (bgWidth - 1), VIRTUAL_HEIGHT / (bgHeight - 1)
    );
    gStateMachine:render();

    push:apply('end');
end