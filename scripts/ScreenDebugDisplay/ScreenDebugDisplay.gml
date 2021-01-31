function ScreenDebugDisplay()
{	
	// Display only if allowed to
	if EnableDebug = false exit;
	
	// Draw rectangle
	draw_set_alpha(0.65);
	draw_rectangle_colour(Width - 90, 4, Width - 4, Height - 8, c_black, c_black, c_black, c_black, false)
	
	// Set font
	draw_set_alpha(1);
	string_set_font(Game.Font[0], "left");
	
	// Display
	string_display_list(Width - 93, 8,
			    "          ORBINAUT  FRAMEWORK"
			+ "\n            STANDALONE VER."
			+ "\n"
			+ "\n         BY TRIANGLY AND MICG"
			+ "\n"
			+ "\n"
			+ "\n            * COLLISION *"
			+ "\n"
			+ "\n   X RADIUS: " + string(Player.yRadius)
			+ "\n   Y RADIUS: " + string(Player.xRadius)
			+ "\n   WALL OFFSET: " + string((Player.Grounded and !Player.Angle) * 8)
			+ "\n   MAX DISTANCE: " + string(Player.CollisionDistance)
			+ "\n   MASK ID: " + string(Game.TempValue[98])
			+ "\n   MASK LAYER: " + string(Game.TempValue[99])
			+ "\n   MASK SOLIDITY: " + string(Game.TempValue[100])
			+ "\n"
			+ "\n          * PLAYER MOTION *"
			+ "\n"
			+ "\n   POS X: " + string(Player.PosX)
			+ "\n   POS Y: " + string(Player.PosY)
			+ "\n   SPEED X: " + string(Player.Xsp) 
			+ "\n   SPEED Y: " + string(Player.Ysp) 
			+ "\n   INERTIA: " + string(Player.Inertia) 
			+ "\n   MOVEMENT LOCK: " + string(Player.MovementLock) 
			+ "\n"
			+ "\n          * SLOPE PHYSICS *"
			+ "\n"
			+ "\n   ANGLE: " + string(Player.Angle)
			+ "\n   ANGLE MODE: " + string(round(Player.Angle/90) % 4)
			+ "\n   SLOPE GRAVITY: " + string(Player.SlopeGravity)
			+ "\n"
			+ "\n         * STATES AND FLAGS *"
			+ "\n"
			+ "\n   STATE SCRIPT: " + string(Player.State)
			+ "\n   ON OBJECT: " + string(Player.OnObject)
			+ "\n   GROUNDED: " + string(Player.Grounded)
			+ "\n   IS ROLLING: " + string(Player.Rolling)
			+ "\n   IS JUMPING: " + string(Player.Jumping)
			+ "\n   IS PUSHING: " + string(Player.Pushing)
			+ "\n   ON LAYER: " + string(Player.Layer)
			+ "\n   SPINDASH REV: " + string(Player.SpindashRev)
			+ "\n   HIGHSPEED TIMER: " + string(Player.HighSpeedBonus)
			+ "\n   INVINCIBILITY TIMER: " + string(Player.InvincibilityBonus)
			+ "\n"
			+ "\n         * CHARACTER VISUALS *"
			+ "\n"
			+ "\n   ANIMATION ID: " + string(Player.sprite_index)
			+ "\n   FRAME INDEX: " + string(floor(Player.image_index))
			+ "\n   VISUAL ANGLE: " + string(Player.VisualAngle)
			+ "\n"
			+ "\n              * CAMERA *"
			+ "\n"
			+ "\n   ACTUAL X: " + string(ViewX) + " RENDER: " + string(RenderX)
			+ "\n   ACTUAL Y: " + string(ViewY) + " RENDER: " + string(RenderY)
			+ "\n   SHIFT X: " + string(ShiftX)
			+ "\n   SHIFT Y: " + string(ShiftY)
			+ "\n   SCROLL DELAY TIMER: " + string(ScrollDelay)
			+ "\n   OVERVIEW DELAY TIMER: " + string(OverviewDelay)
			+ "\n   OVERVIEW SHIFT: " + string(OverviewOffset)
			+ "\n   EXTENDED VIEW SHIFT: " + string(ExtendedOffset)
			+ "\n   SPIN OFFSET: " + string(SpinOffset)
			+ "\n"
			+ "\n"
			+ "\n   F1: STAGE RESTART"
			+ "\n   F2: GAME RESTART"
			+ "\n   F3: FRAME BY FRAME MODE"
			+ "\n   F4: SHOW DEBUG VIEW"
			+ "\n   F5: SHOW COLLISION MASKS"
 			+ "\n",			
	10, 0.3);
}