-- Hello World
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "W", function()
  hs.alert.show("Hello World!")
end)

-- ctrl hjkl

local function keyCode(key, modifiers)
   modifiers = modifiers or {}
   return function()
      hs.eventtap.event.newKeyEvent(modifiers, string.lower(key), true):post()
      hs.timer.usleep(1000)
      hs.eventtap.event.newKeyEvent(modifiers, string.lower(key), false):post()
   end
end

local function remapKey(modifiers, key, keyCode)
   hs.hotkey.bind(modifiers, key, keyCode, nil, keyCode)
end

remapKey({'ctrl'}, 'h', keyCode('left'))
remapKey({'ctrl'}, 'j', keyCode('down'))
remapKey({'ctrl'}, 'k', keyCode('up'))
remapKey({'ctrl'}, 'l', keyCode('right'))

-- Press Cmd+Q twice to quit

local quitModal = hs.hotkey.modal.new('cmd','q')

function quitModal:entered()
   hs.alert.show("Press Cmd+Q again to quit", 1)
   hs.timer.doAfter(1, function() quitModal:exit() end)
end

local function doQuit()
   local res = hs.application.frontmostApplication():selectMenuItem("^Quit.*$")
   quitModal:exit()
end

quitModal:bind('cmd', 'q', doQuit)

-- Move application between displays

function moveWindowToDisplay(d)
   return function()
      local displays = hs.screen.allScreens()
      local win = hs.window.focusedWindow()
      local wasFullScreen = win:isFullScreen()
      if wasFullScreen then
         win:toggleFullScreen()
      end
      win:moveToScreen(displays[d], false, true)
      if wasFullScreen then
         win:toggleFullScreen()
      end
   end
end

hs.hotkey.bind({"option", "shift"}, "1", moveWindowToDisplay(1))
hs.hotkey.bind({"option", "shift"}, "2", moveWindowToDisplay(2))

--

quitModal:bind('', 'escape', function() quitModal:exit() end)
