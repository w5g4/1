-- tesetsetststset
local Players = game:GetService("Players")
local lp = Players.LocalPlayer

local function kick()
    pcall(function() lp:Kick("Dumper detected") end)
    task.wait(1)
    while true do end
end

local function depth(f)
    local d = 0
    xpcall(f, function()
        local _, n = debug.traceback():gsub("\n", "\n")
        d = n
    end, nil)
    return d
end

local function hooked()
    local ref = depth(setmetatable)
    if depth(loadstring) ~= ref then
        return true
    end

    local env = getgenv()
    local triggered = false
    local rw = env.writefile
    env.writefile = function() triggered = true end
    pcall(loadstring, "return 1")
    env.writefile = rw

    return triggered
end

if hooked() then
    kick()
end

task.spawn(function()
    while task.wait(0.5) do
        if hooked() then
            kick()
        end
    end
end)
