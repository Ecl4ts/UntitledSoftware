-- Script Path: game:GetService("Workspace").Macie_bean.AntiJump
-- Took 0.49s to decompile.
-- Executor: Madium (1.3.8.0) (madium my love ❤️)

-- https://lua.expert/
game:GetService("RunService")
local Humanoid = script.Parent:WaitForChild("Humanoid")
local v1 = 2
local v2 = 0
Humanoid:GetPropertyChangedSignal("Jump"):Connect(function() --[[ Line: 12 | Upvalues: Humanoid (copy), v2 (ref), v1 (ref) ]]
    if not Humanoid.Jump then
        return
    end
    local v12 = Humanoid:GetState()
    if v12 == Enum.HumanoidStateType.Freefall or (v12 == Enum.HumanoidStateType.Jumping or v12 == Enum.HumanoidStateType.Landed) then
        return
    end
    local v22 = os.clock()
    local v3 = v22 - v2
    if v3 > 0 then
        v1 = math.min(2, v1 + v3 * 1.15)
    end
    v2 = v22
    if v1 >= 1 then
        v1 = v1 - 1
    else
        Humanoid.Jump = false
    end
end)
