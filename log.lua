local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "LogGui"
gui.ResetOnSpawn = false

-- Frame chính
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 400, 0, 320)
frame.Position = UDim2.new(0.5, -200, 0.5, -160)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.BackgroundTransparency = 0.2
frame.BorderSizePixel = 0
frame.Visible = true

-- Tiêu đề
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = "📄 GHI LOG OBJECT BONDS"
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundTransparency = 1
title.Font = Enum.Font.SourceSansBold
title.TextScaled = true

-- Hộp log
local scrolling = Instance.new("ScrollingFrame", frame)
scrolling.Size = UDim2.new(1, -20, 1, -90)
scrolling.Position = UDim2.new(0, 10, 0, 35)
scrolling.CanvasSize = UDim2.new(0, 0, 0, 0)
scrolling.ScrollBarThickness = 6
scrolling.BackgroundColor3 = Color3.fromRGB(30, 30, 30)

-- Nút sao chép
local copyBtn = Instance.new("TextButton", frame)
copyBtn.Size = UDim2.new(0.45, 0, 0, 35)
copyBtn.Position = UDim2.new(0.05, 0, 1, -45)
copyBtn.Text = "📋 Sao chép log"
copyBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
copyBtn.TextColor3 = Color3.new(1, 1, 1)
copyBtn.Font = Enum.Font.SourceSansBold
copyBtn.TextScaled = true

-- Nút thu nhỏ
local toggleBtn = Instance.new("TextButton", gui)
toggleBtn.Size = UDim2.new(0, 100, 0, 35)
toggleBtn.Position = UDim2.new(0, 20, 0, 20)
toggleBtn.Text = "📦 Ẩn log"
toggleBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
toggleBtn.TextColor3 = Color3.new(1, 1, 1)
toggleBtn.Font = Enum.Font.SourceSansBold
toggleBtn.TextScaled = true

-- Tạo log
local keywords = {
    "bond", "bonds", "money", "phiếu", "traiphieu", "trái", "tien",
    "cash", "currency", "note", "bill", "coin"
}

local function matchKeyword(str)
    local name = string.lower(str)
    for _, kw in pairs(keywords) do
        if name:find(kw) then return true end
    end
    return false
end

local logs = ""
local count = 0

for _, obj in pairs(workspace:GetDescendants()) do
    if obj:IsA("BasePart") and matchKeyword(obj.Name) then
        count += 1
        local line = "["..count.."] "..obj:GetFullName().." @ "..tostring(obj.Position)
        logs = logs .. line .. "\n"

        local label = Instance.new("TextLabel", scrolling)
        label.Size = UDim2.new(1, -10, 0, 20)
        label.Position = UDim2.new(0, 5, 0, (count - 1) * 22)
        label.BackgroundTransparency = 1
        label.TextColor3 = Color3.new(1, 1, 1)
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Font = Enum.Font.SourceSans
        label.TextSize = 14
        label.Text = line
    end
end

scrolling.CanvasSize = UDim2.new(0, 0, 0, count * 22)

-- Sao chép clipboard
copyBtn.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard(logs)
        copyBtn.Text = "✅ Đã sao chép!"
        wait(2)
        copyBtn.Text = "📋 Sao chép log"
    else
        copyBtn.Text = "❌ Không hỗ trợ setclipboard"
        wait(2)
        copyBtn.Text = "📋 Sao chép log"
    end
end)

-- Thu nhỏ / Hiện lại
local visible = true
toggleBtn.MouseButton1Click:Connect(function()
    visible = not visible
    frame.Visible = visible
    toggleBtn.Text = visible and "📦 Ẩn log" or "📂 Mở log"
end)