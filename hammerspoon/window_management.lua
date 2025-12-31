-- Window Management for Fullscreen Windows
-- Move fullscreen window to another monitor

local function moveToNextScreen(direction)
    local win = hs.window.focusedWindow()
    if not win then
        hs.alert.show("No focused window")
        return
    end

    local currentScreen = win:screen()
    local targetScreen

    if direction == "next" then
        targetScreen = currentScreen:next()
    else
        targetScreen = currentScreen:previous()
    end

    if currentScreen:id() == targetScreen:id() then
        hs.alert.show("Only one monitor")
        return
    end

    local isFullScreen = win:isFullScreen()
    hs.alert.show("Moving to " .. direction .. " (fullscreen: " .. tostring(isFullScreen) .. ")")

    if isFullScreen then
        win:setFullScreen(false)
        hs.timer.doAfter(0.5, function()
            win:moveToScreen(targetScreen)
            hs.timer.doAfter(0.3, function()
                win:setFullScreen(true)
            end)
        end)
    else
        win:moveToScreen(targetScreen)
    end
end

-- Ctrl + Option + Cmd + [ / ]
hs.hotkey.bind({"ctrl", "alt", "cmd"}, "[", function()
    moveToNextScreen("prev")
end)

hs.hotkey.bind({"ctrl", "alt", "cmd"}, "]", function()
    moveToNextScreen("next")
end)

-- Cmd + Shift + /
hs.hotkey.bind({"cmd", "shift"}, "/", function()
    moveToNextScreen("next")
end)

hs.alert.show("Window management loaded")
