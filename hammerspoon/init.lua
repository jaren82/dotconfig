-- key mapping for vim
-- Convert input soruce as English and sends 'escape' if inputSource is not English.
-- Sends 'escape' if inputSource is English.
-- key bindding reference --> https://www.hammerspoon.org/docs/hs.hotkey.html
local inputEnglish = "com.apple.keylayout.ABC"
local esc_bind

function convert_to_eng_with_esc()
	local inputSource = hs.keycodes.currentSourceID()
	if not (inputSource == inputEnglish) then
		hs.eventtap.keyStroke({}, 'right')
		hs.keycodes.currentSourceID(inputEnglish)
	end
	esc_bind:disable()
	hs.eventtap.keyStroke({}, 'escape')
	esc_bind:enable()
end

esc_bind = hs.hotkey.new({}, 'escape', convert_to_eng_with_esc):enable()

function IM_alert()
    -- end the alert function if the alert is the same as the previous one
    if hs.keycodes.currentSourceID() == last_alerted_IM_ID then return end
     -- close the previous alert about IM changing
    hs.alert.closeSpecific(last_IM_alert_uuid)
    if last_alerted_IM_ID == inputEnglish then
      last_IM_alert_uuid = hs.alert.show("한글")
    else
      last_IM_alert_uuid = hs.alert.show("Eng")
    end
    last_alerted_IM_ID = hs.keycodes.currentSourceID()
end

hs.keycodes.inputSourceChanged(IM_alert)

local FRemap = require('foundation_remapping')
local remapper = FRemap.new()

remapper:remap('rcmd', 'F18')
remapper:register()

function reloadConfig(files)
    doReload = false
    for _,file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
    end
end
myWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.alert.show("Config loaded")

------------------------------------------------------------------------------------
-- 2022.03.19 - sng_hn.lee - Arrow keys
-- hs.hotkey.bind(mods, key, [message,] pressedfn, releasedfn, repeatfn)
-- 누르고 있는 경우를 고려하기 위해서는 repeatfn 이 정의되어야 함.
function stroke_arrow(arrow_key)
  -- hs.eventtap.keyStroke()의 경우 중간에 timer.usleep()이
  -- 포함되어 있어, 연속 입력이 어려우므로, 다음처럼 처리하였다.
  local event = require("hs.eventtap").event
  event.newKeyEvent({}, arrow_key, true):post()
  event.newKeyEvent({}, arrow_key, false):post()
end

hs.hotkey.bind({"ctrl"}, "H",
  function () stroke_arrow('left') end,
  function () end,
  function () stroke_arrow('left') end
)
hs.hotkey.bind({"ctrl"}, "J",
  function () stroke_arrow('down') end,
  function () end,
  function () stroke_arrow('down') end
)
hs.hotkey.bind({"ctrl"}, "K",
  function () stroke_arrow('up') end,
  function () end,
  function () stroke_arrow('up') end
)
hs.hotkey.bind({"ctrl"}, "L",
  function () stroke_arrow('right') end,
  function () end,
  function () stroke_arrow('right') end
)

------------------------------------------------------------------------------------
-- 2022.03.20 - sng_hn.lee - ctrl + shift + hjkl => block
-- function을 만들어서, 아래 간소화할 것.
-- https://www.hammerspoon.org/docs/hs.eventtap.event.html#newKeyEvent
function stroke_shift_arrow(arrow_key)
  return function ()
    local event = require("hs.eventtap").event
    event.newKeyEvent({'shift'}, arrow_key, true):post()
    event.newKeyEvent({'shift'}, arrow_key, false):post()
  end
end
hs.hotkey.bind({"ctrl", "shift"}, "H",
  stroke_shift_arrow('left'),
  function () end,
  stroke_shift_arrow('left')
)
hs.hotkey.bind({"ctrl", "shift"}, "J",
  stroke_shift_arrow('down'),
  function () end,
  stroke_shift_arrow('down')
)
hs.hotkey.bind({"ctrl", "shift"}, "K",
  stroke_shift_arrow('up'),
  function () end,
  stroke_shift_arrow('up')
)
hs.hotkey.bind({"ctrl", "shift"}, "L",
  stroke_shift_arrow('right'),
  function () end,
  stroke_shift_arrow('right')
)

hs.hotkey.bind({'ctrl', 'cmd'}, '1', function()
    hs.application.launchOrFocus('Google Chrome')
end)

hs.hotkey.bind({'ctrl', 'cmd'}, '2', function()
    hs.application.launchOrFocus('iTerm')
    -- hs.application.launchOrFocus('WebStorm')
end)

hs.hotkey.bind({'ctrl', 'cmd'}, '3', function()
    hs.application.launchOrFocus('Slack')
end)

hs.hotkey.bind({'ctrl', 'cmd'}, '4', function()
    hs.application.launchOrFocus('DataGrip')
end)
