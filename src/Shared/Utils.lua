--[[
    Utility functions for Territorial.io
]]

local Utils = {}

-- TABLE UTILITIES
function Utils.DeepCopy(original)
    local copy = {}
    for k, v in pairs(original) do
        if type(v) == "table" then
            copy[k] = Utils.DeepCopy(v)
        else
            copy[k] = v
        end
    end
    return copy
end

function Utils.TableLength(t)
    local count = 0
    for _ in pairs(t) do count = count + 1 end
    return count
end

function Utils.TableFind(t, value)
    for k, v in pairs(t) do
        if v == value then return k end
    end
    return nil
end

-- STRING UTILITIES
function Utils.ToTitleCase(str)
    return str:gsub("^%l", string.upper):gsub("_%l", function(match)
        return " " .. string.upper(match:sub(2))
    end)
end

function Utils.Format(template, ...)
    local args = {...}
    return template:gsub("$(%d)", function(i)
        return tostring(args[tonumber(i)])
    end)
end

-- MATH UTILITIES
function Utils.Clamp(value, min, max)
    if value < min then return min end
    if value > max then return max end
    return value
end

function Utils.Lerp(a, b, t)
    return a + (b - a) * t
end

function Utils.Distance(x1, y1, x2, y2)
    return math.sqrt((x2 - x1)^2 + (y2 - y1)^2)
end

function Utils.IsNeighbor(x1, y1, x2, y2)
    local dx = math.abs(x2 - x1)
    local dy = math.abs(y2 - y1)
    return (dx + dy) == 1 -- Manhattan distance
end

-- ARRAY UTILITIES
function Utils.ArrayContains(arr, value)
    for _, v in ipairs(arr) do
        if v == value then return true end
    end
    return false
end

function Utils.ArrayRemove(arr, value)
    for i, v in ipairs(arr) do
        if v == value then
            table.remove(arr, i)
            return true
        end
    end
    return false
end

function Utils.ArrayFilter(arr, predicate)
    local result = {}
    for _, v in ipairs(arr) do
        if predicate(v) then table.insert(result, v) end
    end
    return result
end

-- COLOR UTILITIES
function Utils.ColorLerp(color1, color2, t)
    t = Utils.Clamp(t, 0, 1)
    local r = Utils.Lerp(color1.R, color2.R, t)
    local g = Utils.Lerp(color1.G, color2.G, t)
    local b = Utils.Lerp(color1.B, color2.B, t)
    return Color3.fromRGB(r * 255, g * 255, b * 255)
end

function Utils.ColorBrighter(color, amount)
    return Color3.fromRGB(
        math.min(255, color.R * 255 + amount),
        math.min(255, color.G * 255 + amount),
        math.min(255, color.B * 255 + amount)
    )
end

-- VALIDATION UTILITIES
function Utils.IsValidTerritory(territory)
    return territory and
        territory.id and
        territory.name and
        territory.x and
        territory.y and
        territory.type
end

function Utils.HasSufficientResources(playerResources, cost)
    for resource, amount in pairs(cost) do
        if (playerResources[resource] or 0) < amount then
            return false
        end
    end
    return true
end

-- TIME UTILITIES
function Utils.GetTimestamp()
    return os.time()
end

function Utils.FormatTime(seconds)
    local hours = math.floor(seconds / 3600)
    local minutes = math.floor((seconds % 3600) / 60)
    local secs = seconds % 60
    return string.format("%02d:%02d:%02d", hours, minutes, secs)
end

-- LOGGING
function Utils.Log(level, message)
    local timestamp = os.date("%Y-%m-%d %H:%M:%S")
    print(string.format("[%s] [%s] %s", timestamp, level, message))
end

function Utils.LogInfo(message)
    Utils.Log("INFO", message)
end

function Utils.LogError(message)
    Utils.Log("ERROR", message)
end

function Utils.LogWarn(message)
    Utils.Log("WARN", message)
end

return Utils
