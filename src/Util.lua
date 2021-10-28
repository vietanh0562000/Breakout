-- this file has all funtion can use global for this project
-- aka global function

--[[
    This function get a file (image) and return list of quads (list of element in that image)
    breakout.png. See image for well understand
]]
function GenerateQuadsPaddles(atlas)
    local x = 0;
    local y = 64;

    local counter = 1;
    local quads = {};

    for i = 0, 3 do
        -- small
        quads[counter] = love.graphics.newQuad(x, y, 32, 16, atlas:getDimensions());
        counter = counter + 1;

        -- medium
        quads[counter] = love.graphics.newQuad(x + 32, y, 64, 16, atlas:getDimensions());
        counter = counter + 1;

        -- large
        quads[counter] = love.graphics.newQuad(x + 96, y, 96, 16, atlas:getDimensions());
        counter = counter + 1;

        -- huge
        quads[counter] = love.graphics.newQuad(x, y + 16, 128, 16, atlas:getDimensions());
        counter = counter + 1;

        -- move position x, y to next paddle
        x = 0;
        y = y + 32;
    end

    return quads;
end

--[[
    Get list of quads of all image block in file breakout.png. See image for well understand
]]
function GenerateQuadsBlock(atlas)
    local x = 0;
    local y = 0;
    
    local counter = 1;
    local quads = {};

    for i = 0, 3 do
        for j = 0, 6 do
            quads[counter] = love.graphics.newQuad(x + 32 * j, y + 16 * i, 32, 16, atlas:getDimensions());
            counter = counter + 1;
        end
    end

    return quads;
end

--[[
    Get list quads of all ball in file breakout.png. See image for well understand
]]
function GenerateQuadsBall(atlas)
    local x = 96;
    local y = 48;
    local counter = 1;
    local quads = {};

    for i = 0, 2 do
        for j = 0, 3 do
            quads[counter] = love.graphics.newQuad(x + 8 * j, y + 8 * i, 8, 8, atlas:getDimensions());
            counter = counter + 1;
        end
    end

    return quads;
end

--[[
    Get image heart from heart.png. See image for well understand
]]
function GenerateQuadsHeart(atlas)
    local quads = {};

    quads[1] = love.graphics.newQuad(0, 0, 9, 9, atlas:getDimensions());
    quads[2] = love.graphics.newQuad(0, 9, 9, 9, atlas:getDimensions());

    return quads;
end

--[[
    Load high scores from file local (or get file from server)
]]
function GetHighScores()
    love.filesystem.setIdentity("Breakout");

    -- if file not exist. Create it
    if not love.filesystem.getInfo('HighScores.lst') then
        local scores = '';
        for i = 10, 1, -1 do
            scores = scores .. 'CTO\n';
            scores = scores .. tostring(i) .. '\n';
        end

        love.filesystem.write('HighScores.lst', scores);
    end

    -- Reading high scores
    local isName = true;
    local currentName = nil;
    local counter = 1;

    local scores = {};

    -- create blank table scores
    for i = 1, 10 do
        scores[i] = {
            name = nil,
            score = nil
        }
    end

    -- fill from file to talble
    for line in love.filesystem.lines('HighScores.lst') do
        if isName then
            scores[counter].name = string.sub(line, 1, 3);
        else
            scores[counter].score = tonumber(line);    
            counter = counter + 1;
        end

        isName = not isName;
    end

    return scores;
end

function WriteHighScores(highScores)
    local scoresText = '';
    for i = 1, 10 do
        scoresText = scoresText .. tostring(highScores[i].name) .. '\n';
        scoresText = scoresText .. tostring(highScores[i].score) .. '\n'; 
    end

    love.filesystem.write('HighScores.lst', scoresText);
end
