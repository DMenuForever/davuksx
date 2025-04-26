task.spawn(function()

    local HttpService = game:GetService("HttpService")
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer

    local function safeLoadString(source)
        local func, err = loadstring(source)
        if not func then
            warn("Loadstring error:", err)
            return nil
        end
        return func
    end

    local disassemble = safeLoadString(game:HttpGet("https://github.com/DMenuForever/davuksx/raw/refs/heads/main/main/decompile.luau"))()

    if not disassemble then
        warn("[DAVUKSX]: Failed to load decompile.luau")
        return
    end

    print("[DAVUKSX]: decompile.luau loaded successfully.")

    while true do
        print("\n--- DAVUKSX EXECUTOR ---")
        print("1. Execute code")
        print("2. Decompile script")
        print("3. Exit")
        io.write("> ")

        local choice = tonumber(read())

        if choice == 1 then
            io.write("Enter code: ")
            local source = read()
            local func = safeLoadString(source)
            if func then
                task.spawn(func)
                print("Code executed.")
            else
                warn("Code execution failed.")
            end

        elseif choice == 2 then
            print("Searching for LocalScript...")
            local scriptTarget = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildWhichIsA("LocalScript")
            if scriptTarget then
                local result = disassemble(scriptTarget)
                print("=== Decompiled Script ===")
                print(result)
            else
                warn("No LocalScript found.")
            end

        elseif choice == 3 then
            print("Exiting...")
            break
        else
            print("Invalid input.")
        end

        task.wait(0.5)
    end
end)
