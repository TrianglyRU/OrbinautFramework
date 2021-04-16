function ScreenDebugScreenDisplay()
{	
	// Hotkeys:
	if Stage.State != ActStateLoading
	{
		string_set_font(Game.Font[FontDebug], "centre");
		string_display(Width / 2, Height - 4, "TOGGLE: Q  SOLIDS: W  HITBOXES:E  SENSORS: R  VARIABLES: T", 0.5);
	}
		
	// FPS:
	string_set_font(Game.Font[FontDebug], "left");
	string_display(Width - 45, Height - 8, "FPS: " + string(floor(fps)), 0.5);
	if !DebugVariables
	{
		string_display(Width - 65, Height - 4, "TRUE FPS: " + string(floor(fps_real)), 0.5);
	}
	else
	{
		string_display(Width - 85, Height - 4, "APRX TRUE FPS: " + string(floor(fps_real) + 800), 0.5);
	}
	
	// Show variables information
	if DebugToggle and DebugVariables
	{
		// Draw rectangle
		draw_set_alpha(0.65);
		draw_rectangle_colour(Width - 90, 4, Width - 4, Height - 12, c_black, c_black, c_black, c_black, false)
	
		// Set font
		draw_set_alpha(1);
	
		// Display debug screen
		string_display_list(Width - 86, 8,
					"          ORBINAUT  FRAMEWORK"
				+ "\n            STANDALONE VER."
				+ "\n"
				+ "\n         BY TRIANGLY AND MICG"
				+ "\n"
				+ "\n"
				+ "\n            * COLLISION *"
				+ "\n"
				+ "\n   PLAYER X RADIUS: " + string(Player.yRadius)
				+ "\n   PLAYER Y RADIUS: " + string(Player.xRadius)
				+ "\n   WALL OFFSET: " + string((Player.Grounded and Player.Angle == 360) * 8)
				+ "\n"
				+ "\n   LFLOOR DIST: " + string(Screen.DebugValue[0])
				+ "\n   RFLOOR DIST: " + string(Screen.DebugValue[1])
				+ "\n   LFLOOR ANG: " + string(Screen.DebugValue[2])
				+ "\n   RFLOOR ANG: " + string(Screen.DebugValue[3])
				+ "\n   FLOOR COL USED: " + Screen.DebugValue[4]
				+ "\n"
				+ "\n   LWALL DIST: " + string(Screen.DebugValue[5])
				+ "\n   RWALL DIST: " + string(Screen.DebugValue[6])
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
				+ "\n   MOVEMENT ANGLE: " + string(Player.Angle)
				+ "\n   SLOPE GRAVITY: " + string(Player.SlopeGravity)
				+ "\n"
				+ "\n         * STATES AND FLAGS *"
				+ "\n"
				+ "\n   ON OBJECT: " + string(Player.OnObject)
				+ "\n   GROUNDED: " + string(Player.Grounded)
				+ "\n   ROLLING: " + string(Player.Rolling)
				+ "\n   JUMPING: " + string(Player.Jumping)
				+ "\n   PUSHING: " + string(Player.Pushing)
				+ "\n   BALANCING: " + string(Player.Balancing)
				+ "\n   GLIDING: " + string(Player.GlidingState)
				+ "\n   CLIMBING: " + string(Player.ClimbingState)
				+ "\n   FLYING: " + string(Player.FlyingState)
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
				+ "\n   SPIN OFFSET: " + string(SpinOffset),	
		10, 0.28);
	}
}