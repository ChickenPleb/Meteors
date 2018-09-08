-----------------------------------------------------------------------------------------
--
-- level1.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

-- include Corona's "physics" library
local physics = require "physics"

--------------------------------------------

-- forward declarations and other locals
local screenW, screenH, halfW = display.actualContentWidth, display.actualContentHeight, display.contentCenterX

function scene:create( event )

	-- Called when the scene's view does not exist.
	--
	-- INSERT code here to initialize the scene
	-- e.g. add display objects to 'sceneGroup', add touch listeners, etc.

	local sceneGroup = self.view

	-- We need physics started to add bodies, but we don't want the simulaton
	-- running until the scene is on the screen.
	physics.start()
	physics.pause()


	-- create a grey rectangle as the backdrop
	-- the physical screen will likely be a different shape than our defined content area
	-- since we are going to position the background from it's top, left corner, draw the
	-- background at the real top, left corner.
	local background = display.newImageRect( "crate.jpg", display.actualContentWidth, display.actualContentHeight )
	background.anchorX = 0
	background.anchorY = 0
	background.x = 0 + display.screenOriginX
	background.y = 0 + display.screenOriginY

	-- make a crate (off-screen), position it, and rotate slightly
	local crate = display.newImageRect( "crate.jpg", 90, 90 )
	crate.x, crate.y = 160, -100
	crate.rotation = 15

	-- add physics to the crate
	physics.addBody( crate, { density=1.0, friction=0.3, bounce=0.3 } )

	-- create a grass object and add physics (with custom shape)
	local bricks = display.newImageRect( "bluec.jpg", 1050,250) --, screenW, 82 )
	bricks.anchorX = 0
	bricks.anchorY = 1
	--  draw the grass at the very bottom of the screen
	bricks.x, bricks.y = display.screenOriginX, display.actualContentHeight + display.screenOriginY

	-- define a shape that's slightly shorter than image bounds (set draw mode to "hybrid" or "debug" to see)
	--local bricksShape = { -halfW,-34, halfW,-34, halfW,34, -halfW,34 }
	physics.addBody( bricks, "static", { friction=0.3} )

  local company = display.newText ( "Infiny",display.contentCenterX,400,  "motel_king.ttf", 80)
	company:setFillColor(1,1,1)
  company.alpha=0
  transition.to(company, {alpha=1, time=2000})

  local ball = display.newImageRect( "8ball.png", 250,250)
  ball.x = 500
	ball.y = 225
  ball:rotate(-45)
  ball.alpha=0
  transition.to (ball, {rotation=55, time=2000, alpha=1})
  --ball:rotate(45)

	-- all display objects must be inserted into group
	sceneGroup:insert( background )
	sceneGroup:insert( bricks)
	sceneGroup:insert( crate )
  sceneGroup:insert( company )
  sceneGroup:insert( ball )
end


function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase

	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		-- Called when the scene is now on screen
		--
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
		physics.start()
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
		physics.stop()
	elseif phase == "did" then
		-- Called when the scene is now off screen
	end

end

function scene:destroy( event )

	-- Called prior to the removal of scene's "view" (sceneGroup)
	--
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
	local sceneGroup = self.view

	package.loaded[physics] = nil
	physics = nil
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene
