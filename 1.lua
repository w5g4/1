local Players = game:GetService("Players")
local lp = Players.LocalPlayer
local env = getgenv()
local original = loadstring

local function kick()
    pcall(function() lp:Kick("Dumper detected") end)
    task.wait(1)
    while true do end
end

local function hooked()
    if env.loadstring ~= original or loadstring ~= original then
        return true
    end

    if islclosure and islclosure(original) then
        return true
    end

    local triggered = false
    local rw, rt, rts = env.writefile, env.typeof, env.tostring
    env.writefile = function() triggered = true end
    env.typeof = function() triggered = true return "string" end
    env.tostring = function() triggered = true return "" end
    pcall(original, "return 1")
    env.writefile, env.typeof, env.tostring = rw, rt, rts

    return triggered
end

if hooked() then
    kick()
end

task.spawn(function()
    while true do
        if hooked() then
            kick()
        end
        task.wait(0.5)
    end
end)
