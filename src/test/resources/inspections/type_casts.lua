---@param returnString boolean
---@return string|number
local function stringOrNumber(returnString)
    return returnString and "someString" or 1
end

---@param n number
function wantsNumber(n)
end

wantsNumber(<error descr="Type mismatch for argument: n. Required: 'number' Found: 'string|number'">stringOrNumber(false)</error>)
wantsNumber(--[[---@type number]] stringOrNumber(false))

wantsNumber(
        ---@type number @Single line doc comments also work as type casts
        stringOrNumber(false)
)

wantsNumber(<error descr="Type mismatch for argument: n. Required: 'number' Found: 'fun(): any'">--[[---@type fun(): any]] 1</error>)

---@param arr any[]
function wantsArray(arr)
end

local aString = "aString"

wantsArray(<error descr="Type mismatch for argument: arr. Required: 'any[]' Found: 'string'">aString</error>)
wantsArray(--[[--- @type any[] ]] aString) -- Trailing space used to separate array ']' from the block comment ']]'.
