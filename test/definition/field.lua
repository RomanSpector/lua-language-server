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

<<<<<<< HEAD
-- A table constructor a child assigns to a field its parent declares keeps its
-- own keys as definitions, also when the child is reached through its type
TEST [[
---@class Parent
---@field spells table<string, integer>

---@generic T : Parent
=======
-- A method declared with `---@field ... fun(...)` jumps to its implementation
TEST [[
---@class A
---@field run fun(self: A)

---@generic T
>>>>>>> 1eb18985d (Go to the implementation of a method declared as a field)
---@param name `T`
---@return T
local function add(name) end

<<<<<<< HEAD
---@class Child : Parent
local declared = add 'Child'

declared.spells = {
    <!fireball!> = 1,
}

local child = add 'Child'
local spells = child.spells
print(spells.<?fireball?>)
=======
local A = add 'A'

function A:<!run!>()
end

function A:update()
    self:<?run?>()
end
]]

-- With no implementation it still jumps to the declaration
TEST [[
---@class A
---@field <!run!> fun(self: A)

---@type A
local a

a:<?run?>()
>>>>>>> 1eb18985d (Go to the implementation of a method declared as a field)
]]
