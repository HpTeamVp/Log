local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "LogGui"

-- Giao diện khung log
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 400, 0, 300)
frame.Position = UDim2.new(0.5, -200, 0.5, -150)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.BackgroundTransparency = 0.2
frame.BorderSizePixel = 0

-- Tiêu đề
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = "📄 Ghi Log Object Bonds"
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundTransparency = 1
title.Font = Enum.Font.SourceSansBold
title.TextScaled = true

-- Hộp chứa log
local scrolling = Instance.new("ScrollingFrame", frame)
scrolling.Size = UDim2.new(1, -20, 1, -80)
scrolling.Position = UDim2.new(0, 10, 0, 35)
scrolling.CanvasSize = UDim2.new(0, 0, 10, 0)
scrolling.ScrollBarThickness = 6
scrolling.BackgroundColor3 = Color3.fromRGB(30, 30, 30)

-- Nút sao chép
local copyBtn = Instance.new("TextButton", frame)
copyBtn.Size = UDim2.new(0.9, 0, 0, 35)
copyBtn.Position = UDim2.new(0.05, 0, 1, -40)
copyBtn.Text = "📋 Sao chép tất cả log"
copyBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
copyBtn.TextColor3 = Color3.new(1, 1, 1)
copyBtn.Font = Enum.Font.SourceSansBold
copyBtn.TextScaled = true

-- Biến log
local logs = ""

-- Danh sách từ khóa cần tìm
local keywords = {
    "bond", "bonds", "phiếu", "trái", "traiphieu", "money", "cash", "currency", "tien", "note", "bill", "coin"
}

-- Hàm kiểm tra tên object có chứa từ khóa
local function matchKeyword(name)
    name = string.lower(name)
    for _, word in pairs(keywords) do
        if name:find(word) then return true end
    end
    return false
end

-- Ghi log và hiện trong GUI
local count = 0
for _, v in pairs(workspace:GetDescendants()) do
    if v:IsA("BasePart") and matchKeyword(v.Name) then
        count += 1
        local line = "["..count.."] "..v:GetFullName().." @ "..tostring(v.Position)
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

-- Nút sao chép log vào clipboard
copyBtn.MouseButton1Click:Connect(function()
    setclipboard(logs)
    copyBtn.Text = "✅ Đã sao chép!"
    wait(2)
    copyBtn.Text = "📋 Sao chép tất cả log"
end)