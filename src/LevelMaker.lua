LevelMaker = Class{};

--[[
    Return a list of blocks which are spawned in this level
]]
function LevelMaker:spawnBlocks(level)
    -- list store all blocks
    local blocks = {};

    -- spawn block in rengtagle with size (numRow, numCol)
    -- will have numRow * numCol blocks
    local numRow = level;
    local numCol = math.min(level * 2, 10);

    -- init start position
    local startX = VIRTUAL_WIDTH / 2 - numCol * 16;
    local startY = 32;

    -- create blocks
    for i = 1, numRow do
        for j = 1, numCol do
            local randomLevel = math.random(1, level);
            local newBlock = Block((j - 1) * 32 + startX, (i - 1) * 16 + startY, randomLevel);
            table.insert(blocks, newBlock);
        end
    end

    return blocks;
end
