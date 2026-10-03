local Players = game:GetService("Players")
local lp = Players.LocalPlayer

local function kick(reason)
    pcall(function() lp:Kick(reason or "Tamper detected") end)
    task.wait(1)
    while true do end
end

local function isLoadstringHooked()
    local env = getgenv()

    if islclosure and islclosure(loadstring) then
        return true
    end

    local realWrite = env.writefile
    local triggered = false
    env.writefile = function() triggered = true end
    pcall(loadstring, "return 1")
    env.writefile = realWrite

    return triggered
end

if isLoadstringHooked() then
    kick("Dumper detected")
end

task.spawn(function()
    while task.wait(5) do
        if isLoadstringHooked() then
            kick("Dumper detected")
        end
    end
end)
