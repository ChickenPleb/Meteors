local composer = require( "composer" )
 
local scene = composer.newScene()
 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local textbox1, textbox2
 
local function onAxisEvent( event )
    local device_name
    if (event.device==nil) then
      device_name = "virtual keyboard (?)"
    else
      device_name = event.device.displayName
    end
    if (event.normalizedValue>0.5 or event.normalizedValue<-0.5) then
      local message = "controller: " .. device_name .. " axis=" .. event.normalizedValue .. " " .. event.axis.type
      
      
      textbox2.text = message
    end
end
local function onKeyEvent( event )
  local device_name
    if (event.device==nil) then
      device_name = "virtual keyboard (?)"
    else
      device_name = event.device.displayName
    end
    local message = "controller: " .. device_name .. " Key '" .. event.keyName .. "' was pressed " .. event.phase 
    textbox1.text = message
    return false
end
 
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
 
-- create()
function scene:create( event )
 
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
    textbox1 = display.newText(sceneGroup, "connect a controller", display.contentCenterX, display.contentCenterY, native.systemFont, 30)
    textbox1:setFillColor(1,1,1)
    textbox2 = display.newText(sceneGroup, "connect a controller", display.contentCenterX, display.contentCenterY+100, native.systemFont, 30)
    textbox2:setFillColor(1,1,1)

end
 
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
        Runtime:addEventListener( "axis", onAxisEvent )
        Runtime:addEventListener( "key", onKeyEvent )
    end
end
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
 
    end
end
 
 
-- destroy()
function scene:destroy( event )
 
    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view
 
end
 
 
-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------
 
return scene