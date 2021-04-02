function ScreenDebugScreenDisplay()
{	
	// Show FPS
	string_set_font(Game.Font[FontDebug], "left");
	string_display(Width - 40, Height - 4, "FPS: " + string(floor(fps_real)), 0.5);
	
	// Display only if allowed to
	if DebugViewEnabled = false exit;
	
	// Draw rectangle
	draw_set_alpha(0.65);
	draw_rectangle_colour(Width - 90, 4, Width - 4, Height - 8, c_black, c_black, c_black, c_black, false)
	
	// Set font
	draw_set_alpha(1);
	
	// Display debug screen
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
			+ "\n"
			+ "\n          * PLAYER MOTION *"
			+ "\n"
			+ "\n   POS X: " + string(floor(Player.PosX)) + " REAL: " + string(Player.PosX)
			+ "\n   POS Y: " + string(floor(Player.PosY)) + " REAL: " + string(Player.PosY)
			+ "\n   SPEED X: " + string(Player.Xsp) 
			+ "\n   SPEED Y: " + string(Player.Ysp) 
			+ "\n   INERTIA: " + string(Player.Inertia) 
			+ "\n   MOVEMENT LOCK: " + string(Player.MovementLock) 
			+ "\n"
			+ "\n          * SLOPE PHYSICS *"
			+ "\n"
			+ "\n   ANGLE: " + string(Player.Angle)
			+ "\n   ANGLE RANGE: " + string(Player.AngleRange)
			+ "\n   SLOPE GRAVITY: " + string(Player.SlopeGravity)
			+ "\n"
			+ "\n         * STATES AND FLAGS *"
			+ "\n"
			+ "\n   ON OBJECT: " + string(Player.OnObject)
			+ "\n   GROUNDED: " + string(Player.Grounded)
			+ "\n   IS ROLLING: " + string(Player.Rolling)
			+ "\n   IS JUMPING: " + string(Player.Jumping)
			+ "\n   IS PUSHING: " + string(Player.Pushing)
			+ "\n   ON LAYER: " + string(Player.Layer)
			+ "\n   SPINDASH REV: " + string(Player.SpindashRev)
			+ "\n   PEELOUT REV: " + string(Player.PeeloutRev)
			+ "\n   DROPDASH REV: " + string(Player.DropdashRev)
			+ "\n   INVINCIBILITY: " + string(Player.isInvincible)
			+ "\n   HIGHSPEED BONUS: " + string(Player.HighSpeedBonus)
			+ "\n   INVINCIBILITY BONUS: " + string(Player.InvincibilityBonus)
			+ "\n   SUPER STATE: " + string(Player.isSuper)
			+ "\n"
			+ "\n         * CHARACTER VISUALS *"
			+ "\n"
			+ "\n   ANIMATION: " + string(sprite_get_name(Player.sprite_index))
			+ "\n   NEXT FRAME IN: " + string(Player.aniTimer)
			+ "\n   CURRENT FRAME: " + string(Player.image_index + 1)
			+ "\n   FRAMES TOTAL: " + string(Player.image_number)
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
			+ "\n   F1: DEBUG OVERVIEW"
			+ "\n   F2: STAGE RESTART"
			+ "\n   F3: GAME RESTART"
			+ "\n   F4: FRAME BY FRAME MODE"
			+ "\n   F5: SHOW HITBOXES"
			+ "\n   F6: SHOW COLLISION",		
	10, 0.3);
}