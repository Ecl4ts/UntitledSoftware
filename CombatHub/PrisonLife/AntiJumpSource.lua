-- Script Path: game:GetService("Workspace").Macie_bean.AntiJump
-- Took 0.49s to decompile.
-- Executor: Madium (1.3.8.0) (madium my love ❤️)

-- https://lua.expert/
local RunService = game:GetService("RunService")
local Humanoid = script.Parent:WaitForChild("Humanoid")
local v1 = 2
local v2 = 0

Humanoid:GetPropertyChangedSignal("Jump"):Connect(function()
    if not Humanoid.Jump then
        return
    end

    local state = Humanoid:GetState()
    if state == Enum.HumanoidStateType.Freefall
    or state == Enum.HumanoidStateType.Jumping
    or state == Enum.HumanoidStateType.Landed then
        return
    end

    local now = os.clock()
    local delta = now - v2
    if delta > 0 then
        v1 = math.min(2, v1 + delta * 1.15)
    end
    v2 = now

    if v1 >= 1 then
        v1 = v1 - 1
    else
        Humanoid.Jump = false
    end
end)
