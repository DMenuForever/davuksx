return function(scr)
    if typeof(scr) ~= "Instance" or not scr:IsA("LuaSourceContainer") then
        return "-- invalid script given"
    end

    local success, source = pcall(function()
        return scr.Source
    end)

    if success and source then
        return source
    else
        return "-- failed to decompile script"
    end
end