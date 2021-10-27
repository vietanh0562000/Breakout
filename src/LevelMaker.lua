LevelMaker = Class{};

--[[
    Return a list of blocks which are spawned in this level
]]
function LevelMaker:spawnBlocks(level)
    -- list store all blocks
    local blocks = {};

    -- spawn block in rengtagle with size (numRow, numCol)
    -- will have numRow * numCol blocks
    local numRow = 4;
    local numCol = 10;

    -- init start position
    local startX = 64;
    local startY = 32;

    -- create blocks
    for i = 1, numRow do
        for j = 1, numCol do
            newBlock = Block((j - 1) * 32 + startX, (i - 1) * 16 + startY, 1);
            table.insert(blocks, newBlock);
        end
    end

    return blocks;
end
