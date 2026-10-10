TEST [[
X.<!y!> = 1

local t = X

print(t.<?y?>)
]]

TEST [[
X.x.<!y!> = 1

local t = X.x

print(t.<?y?>)
]]

TEST [[
X.x.<!y!> = 1

local t = X

print(t.x.<?y?>)
]]

-- A table constructor a child assigns to a field its parent declares keeps its
-- own keys as definitions, also when the child is reached through its type
TEST [[
---@class Parent
---@field spells table<string, integer>

---@generic T : Parent
---@param name `T`
---@return T
local function add(name) end

---@class Child : Parent
local declared = add 'Child'

declared.spells = {
    <!fireball!> = 1,
}

local child = add 'Child'
local spells = child.spells
print(spells.<?fireball?>)
]]
