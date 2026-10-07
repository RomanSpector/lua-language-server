-- A field declared with `---@field` on a parent class keeps its declared type
-- when a child class assigns it, just as it does for the declaring class itself.

TEST 'List<Item>' [[
---@class List<T> : { [integer]: T }
---@field Count integer
---@operator call(table): List
List = {}

---@class Item
Item = {}

---@class Parent
---@field items List<Item>
Parent = {}

---@class Child : Parent
Child = setmetatable({}, { __index = Parent })

function Child:init()
    self.items = List {}
    print(self.<?items?>)
end
]]

TEST 'Item' [[
---@class List<T> : { [integer]: T }
---@field Count integer
---@operator call(table): List
List = {}

---@class Item
Item = {}

---@class Parent
---@field items List<Item>
Parent = {}

---@class Child : Parent
Child = setmetatable({}, { __index = Parent })

function Child:init()
    self.items = List {}
    local <?item?> = self.items[1]
end
]]

-- The declaration is found through every level of inheritance
TEST 'Item' [[
---@class Item

---@class Parent
---@field item Item
Parent = {}

---@class Middle : Parent
Middle = {}

---@class Child : Middle
Child = {}

function Child:init()
    self.item = {}
    print(self.<?item?>)
end
]]

-- A declaration on the child itself still wins over its assignment
TEST 'Item' [[
---@class Item

---@class Parent
Parent = {}

---@class Child : Parent
---@field item Item
Child = {}

function Child:init()
    self.item = {}
    print(self.<?item?>)
end
]]

-- A field no class declares is still typed by its assignment
TEST 'integer' [[
---@class Parent
---@field item string
Parent = {}

---@class Child : Parent
Child = {}

function Child:init()
    self.count = 1
    print(self.<?count?>)
end
]]

-- A method defined on the child still overrides the parent's declaration
TEST 'integer' [[
---@class Parent
---@field get fun(self: Parent): number
Parent = {}

---@class Child : Parent
Child = {}

function Child:get()
    return 1
end

local <?x?> = Child:get()
]]

-- The same holds for a value given in the class table constructor
TEST 'Item' [[
---@class Item

---@class Parent
---@field item Item
Parent = {}

---@class Child : Parent
Child = { item = {} }

print(Child.<?item?>)
]]
