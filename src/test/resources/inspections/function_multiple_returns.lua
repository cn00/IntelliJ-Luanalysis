---@class ClassWithAField
local ClassWithAField = { field = "name" }

---@return number, ClassWithAField
local function multipleReturns()
    ---@type ClassWithAField
    local res
    return 1, res
end

---@type string
local aString

---@type number, ClassWithAField
local aNumber, classWithAField = multipleReturns()
<error descr="Type mismatch. Required: 'ClassWithAField' Found: 'number'">classWithAField</error>, <error descr="Type mismatch. Required: 'number' Found: 'ClassWithAField'">aNumber</error> = <error descr="Result 1, type mismatch. Required: 'ClassWithAField' Found: 'number'"><error descr="Result 2, type mismatch. Required: 'number' Found: 'ClassWithAField'">multipleReturns()</error></error>
aNumber, classWithAField, <error descr="Too many assignees, will be assigned nil.">aString</error> = multipleReturns()
aNumber = <weak_warning descr="Insufficient assignees, values will be discarded.">multipleReturns()</weak_warning>
aNumber, aString = multipleReturns(), "some string"
aString, aNumber = "some string", <weak_warning descr="Insufficient assignees, values will be discarded.">multipleReturns()</weak_warning>

local implicitNumber, implicitClassWithAField = multipleReturns()


aNumber = implicitNumber
classWithAField = implicitClassWithAField

local a, b, <error descr="Too many assignees, will be assigned nil.">c</error> = multipleReturns()
local d = <weak_warning descr="Insufficient assignees, values will be discarded.">multipleReturns()</weak_warning>

---@param arg1 number
---@param arg2 string
---@vararg boolean
local function acceptsNumberStringVariadicBoolean(arg1, arg2, ...) end

---@param arg1 number
---@param arg2 string
local function acceptsNumberString(arg1, arg2) end

---@return number, string, boolean...
local function returnsNumberStringVariadicBoolean()
    return 1, "a string", true
end

---@return string, boolean...
local function returnStringVariadicBoolean()
    return "a string", true
end

---@return number, string, boolean
local function returnsNumberStringBoolean()
    if aNumber == 1 then
        return 1, "a string", true
    elseif aNumber == 2 then
        ---@type <error descr="Incorrect number of values. Expected 3 but found 1."><error descr="Type mismatch. Required: 'number' Found: 'string'">string</error></error>
        return <error descr="Result 1, type mismatch. Required: 'string' Found: '1'">1</error>, <error descr="Result 2, type mismatch. Required: 'void' Found: '\"a string\"'">"a string"</error>, <error descr="Result 3, type mismatch. Required: 'void' Found: 'true'">true</error>
    else
        return <error descr="Incorrect number of values. Expected 3 but found 2.">returnsNumberStringVariadicBoolean()</error>
    end
end

acceptsNumberStringVariadicBoolean(1, "a string", true)
acceptsNumberStringVariadicBoolean(returnsNumberStringVariadicBoolean())
acceptsNumberStringVariadicBoolean(returnsNumberStringVariadicBoolean(), <error descr="Type mismatch. Required: 'string' Found: 'true'">true</error>)
acceptsNumberStringVariadicBoolean(1, returnStringVariadicBoolean())
acceptsNumberString(returnsNumberStringVariadicBoolean())
acceptsNumberString(<weak_warning descr="1 result is an excess argument.">returnsNumberStringBoolean()</weak_warning>)


---@return number, number
local function returnsNumberNumber()
return 0, 0
end

---@return string, string
local function returnsStringString()
return "a", "a"
end

local returnsNumberNumberOrStringString = {returnsNumberNumber, returnsStringString}

---@type number | string
local numberOrString

for _, fun in ipairs(returnsNumberNumberOrStringString) do
    local numberOrString1, numberOrString2 = fun()

    numberOrString = numberOrString1
    numberOrString = numberOrString2

    aNumber = <error descr="Type mismatch. Required: 'number' Found: 'number|string'">numberOrString1</error>
    aNumber = <error descr="Type mismatch. Required: 'number' Found: 'number|string'">numberOrString2</error>
end


---@return 1, 2, 3
local function returns123()
return 1, 2, 3
end

---@type number[]
local numberArray = {returns123()}

---@overload fun(f: (fun: void), ...: any): nil|string
---@generic T
---@param f fun: T
---@return string | T
local function returnStringOrGeneric(f, ...)
    return aString
end

local inferredNumberOrString = <weak_warning descr="Insufficient assignees, values will be discarded.">returnStringOrGeneric(returns123)</weak_warning>

numberOrString = inferredNumberOrString
aNumber = <error descr="Type mismatch. Required: 'number' Found: '1|string'">inferredNumberOrString</error> -- Expect error