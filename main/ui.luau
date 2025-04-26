local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local InjectButton = Instance.new("TextButton")
local ExecuteButton = Instance.new("TextButton")
local DecompileButton = Instance.new("TextButton")
local SourceBox = Instance.new("TextBox")

ScreenGui.Name = "DavuksxUI"
ScreenGui.Parent = game.CoreGui

Frame.Name = "MainFrame"
Frame.Size = UDim2.new(0, 400, 0, 300)
Frame.Position = UDim2.new(0.5, -200, 0.5, -150)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.Parent = ScreenGui

InjectButton.Name = "InjectButton"
InjectButton.Size = UDim2.new(0, 120, 0, 40)
InjectButton.Position = UDim2.new(0, 20, 0, 20)
InjectButton.Text = "Inject"
InjectButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
InjectButton.Parent = Frame

ExecuteButton.Name = "ExecuteButton"
ExecuteButton.Size = UDim2.new(0, 120, 0, 40)
ExecuteButton.Position = UDim2.new(0, 20, 0, 80)
ExecuteButton.Text = "Execute"
ExecuteButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
ExecuteButton.Parent = Frame

DecompileButton.Name = "DecompileButton"
DecompileButton.Size = UDim2.new(0, 120, 0, 40)
DecompileButton.Position = UDim2.new(0, 20, 0, 140)
DecompileButton.Text = "Decompile"
DecompileButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
DecompileButton.Parent = Frame

SourceBox.Name = "SourceBox"
SourceBox.Size = UDim2.new(0, 220, 0, 260)
SourceBox.Position = UDim2.new(0, 160, 0, 20)
SourceBox.Text = ""
SourceBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
SourceBox.TextColor3 = Color3.fromRGB(255, 255, 255)
SourceBox.ClearTextOnFocus = false
SourceBox.MultiLine = true
SourceBox.TextWrapped = true
SourceBox.TextScaled = false
SourceBox.Parent = Frame

local disassemble

InjectButton.MouseButton1Click:Connect(function()
    if not disassemble then
        local success, result = pcall(function()
            return loadstring(game:HttpGet("https://github.com/DMenuForever/davuksx/raw/refs/heads/main/main/decompile.luau"))()
        end)
        if success then
            disassemble = result
            warn("[DAVUKSX] Successfully injected.")
        else
            warn("[DAVUKSX] Failed to inject.")
        end
    end
end)

ExecuteButton.MouseButton1Click:Connect(function()
    if SourceBox.Text and SourceBox.Text ~= "" then
        local success, func = pcall(loadstring, SourceBox.Text)
        if success and type(func) == "function" then
            pcall(func)
            warn("[DAVUKSX] Code executed.")
        else
            warn("[DAVUKSX] Failed to execute code.")
        end
    end
end)

DecompileButton.MouseButton1Click:Connect(function()
    if disassemble then
        local target = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("LocalScript")
        if target then
            local source = disassemble(target)
            SourceBox.Text = source
            warn("[DAVUKSX] Decompiled script loaded into SourceBox.")
        else
            warn("[DAVUKSX] No LocalScript found.")
        end
    else
        warn("[DAVUKSX] Not injected.")
    end
end)
