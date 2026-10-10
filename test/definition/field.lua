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

-- A method declared with `---@field ... fun(...)` jumps to its implementation
TEST [[
---@class A
---@field run fun(self: A)

---@generic T
---@param name `T`
---@return T
local function add(name) end

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
]]
