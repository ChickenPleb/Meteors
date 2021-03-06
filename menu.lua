-----------------------------------------------------------------------------------------
--
-- menu.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

-- include Corona's "widget" library
local widget = require "widget"

--------------------------------------------

-- forward declarations and other locals
local playBtn
local player1
local button2

local function onKeyEvent( event )
  if (event.keyName == "button10") then
    composer.gotoScene( "game", "fade", 500 )
  end
  if (event.keyName == "button2") then
    player1.alpha=1
    button2.alpha=0

  end

end


-- 'onRelease' event listener for playBtn
local function onPlayBtnRelease()

	-- go to level1.lua scene
<<<<<<< HEAD
	composer.gotoScene( "game", "fade", 500 )

=======
	composer.gotoScene( "level1", "fade", 500 )

>>>>>>> a59f7109457787e6b18edf8f8431da2f77bc0b71
	return true	-- indicates successful touch
end

local function onMouseEvent(event)
  playBtn.fill.effect.contrast = 10
end

function scene:create( event )
	local sceneGroup = self.view

	-- Called when the scene's view does not exist.
	--
	-- INSERT code here to initialize the scene
	-- e.g. add display objects to 'sceneGroup', add touch listeners, etc.

	-- display a background image
	local background = display.newImageRect( "crate.jpg", display.actualContentWidth, display.actualContentHeight )
	background.anchorX = 0
	background.anchorY = 0
	background.x = 0 + display.screenOriginX
	background.y = 0 + display.screenOriginY

	-- create/position logo/title image on upper-half of the screen

  local gameTitle = display.newText ( "Cratez",display.contentCenterX,400,  "bangers.ttf", 100)
	gameTitle:setFillColor(1,1,1)


	button2 = display.newImageRect("bfa.png",50,50)
  button2.x = 200
  button2.y = 175
  button2.alpha=1


	-- create a widget button (which will loads level1.lua on release)



  playBtn = display.newImageRect ("ops.png", 70,85)
  playBtn.x = display.contentCenterX + 100
	playBtn.y = display.contentHeight - 160
	playBtn.fill.effect = "filter.contrast"

  playBtn.fill.effect.contrast = 2
<<<<<<< HEAD

  player1 = display.newImageRect ("player1.png", 140,200)
  player1.x=250
  player1.y=225
  player1.alpha=0
=======


>>>>>>> a59f7109457787e6b18edf8f8431da2f77bc0b71
  -- all display objects must be inserted into group
	sceneGroup:insert( background )
  sceneGroup:insert(gameTitle)
	sceneGroup:insert( playBtn )

end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase

	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
    playBtn:addEventListener("tap", onPlayBtnRelease)
    playBtn:addEventListener("mouse", onMouseEvent)
    Runtime:addEventListener( "key", onKeyEvent )
	-- Called when the scene is now on screen
		--
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
	end
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase

	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
    playBtn:removeEventListener("tap",onPlayBtnRelease)
	elseif phase == "did" then
		-- Called when the scene is now off screen
	end
end

function scene:destroy( event )
	local sceneGroup = self.view

	-- Called prior to the removal of scene's "view" (sceneGroup)
	--
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.


end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene
