-- ====== AUTO FARM LEVEL (FIX CHUẨN) ======
-- Tìm quái KHẮP MAP (King Legacy không cố định Enemies)

task.spawn(function()
    while true do
        if AutoLevel then
            local targetName = pickMob()
            for _,mob in ipairs(workspace:GetDescendants()) do
                if mob.Name == targetName
                and mob:FindFirstChild("Humanoid")
                and mob:FindFirstChild("HumanoidRootPart")
                and mob.Humanoid.Health > 0 then

                    -- Tele sát quái
                    hrp.CFrame = mob.HumanoidRootPart.CFrame * CFrame.new(0,0,3)

                    -- Đánh
                    VU:Button1Down(Vector2.new(0,0))
                    task.wait(0.15)
                end
            end
        end
        task.wait(0.1)
    end
end)