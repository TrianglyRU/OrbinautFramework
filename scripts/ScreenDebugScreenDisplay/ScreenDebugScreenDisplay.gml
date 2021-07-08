function ScreenDebugScreenDisplay()
{	
	// Hotkeys:
	if Stage.State != ActStateLoading and DebugToggle
	{
		string_set_font(Game.Font[FontDebug], "centre");
		string_display(Width / 2, Height - 4, "TOGGLE: Q  SOLIDS: W  HITBOXES:E  SENSORS: R  VARIABLES: T", 0.5);
		
		string_set_font(Game.Font[FontDebug], "left");
		string_display(Width - 45, Height - 8, "FPS: " + string(floor(fps)), 0.5);
		string_display(Width - 65, Height - 4, "TRUE FPS: " + string(floor(fps_real)), 0.5);
	}
	
	// Toggle debug help
	if keyboard_check_pressed(ord("T"))
	{
		DebugVariables = !DebugVariables;
	}
	
	// Show variables information
	if DebugToggle and DebugVariables
	{
		// Draw rectangle
		draw_set_alpha(0.65);
		draw_rectangle_colour(Width - 90, 4, Width - 4, Height - 12, c_black, c_black, c_black, c_black, false)
	
		// Set font
		draw_set_alpha(1);
		string_set_font(Game.Font[FontDebug], "left");
	
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
				+ "\n   SLOPE GRAVITY: " + string(Player.SlopeGravity)
				+ "\n   MOVEMENT ANGLE: " + string(Player.Angle)
				+ "\n   FLOOR RANGE: " + string(Player.AngleQuadFloor)
				+ "\n   WALL RANGE: " + string(Player.AngleQuadWall)
				+ "\n"
				+ "\n         * STATES AND FLAGS *"
				+ "\n"
				+ "\n   ON OBJECT: " + string(Player.OnObject)
				+ "\n   GROUNDED: " + string(Player.Grounded)
				+ "\n   FACING: " + string(Player.Facing)
				+ "\n   ROLLING: " + string(Player.Rolling)
				+ "\n   JUMPING: " + string(Player.Jumping)
				+ "\n   PUSHING: " + string(Player.Pushing)
				+ "\n   BALANCING: " + string(Player.Balancing)
				+ "\n   GLIDING: " + string(Player.GlidingState)
				+ "\n   CLIMBING: " + string(Player.ClimbingState)
				+ "\n   FLYING: " + string(Player.FlyingState)
				+ "\n   FLYING TIMER: " + string(Player.FlyingTimer)
				+ "\n   SPINDASH: " + string(round(Player.SpindashRev))
				+ "\n   PEELOUT: " + string(Player.PeeloutRev)
				+ "\n   DROPDASH: " + string(Player.DropdashRev)
				+ "\n   BARRIER: " + string(Player.BarrierType)
				+ "\n   BARRIER ACTIVE: " + string(Player.BarrierIsActive)
				+ "\n   LAYER: " + string(Player.Layer)
				+ "\n   HIGHSPEED BONUS: " + string(Player.HighSpeedBonus)
				+ "\n   INVINCIBILITY BONUS: " + string(Player.InvincibilityBonus)
				+ "\n   HURT: " + string(Player.Hurt)
				+ "\n   INVINCIBLE: " + string(Player.IsInvincible)
				+ "\n   UNDERWATER: " + string(Player.isUnderwater)
				+ "\n   AIR TIMER: " + string(Player.AirTimer)
				+ "\n   SUPER STATE: " + string(Player.SuperState)
				+ "\n   SUPER STATE VALUE: " + string(Player.SuperStateValue)
				+ "\n"
				+ "\n         * CHARACTER VISUALS *"
				+ "\n"
				+ "\n   ANIMATION: " + string(sprite_get_name(Player.sprite_index))
				+ "\n   NEXT FRAME IN: " + string(Player.AnimationTimer)
				+ "\n   CURRENT FRAME: " + string(Player.image_index + 1)
				+ "\n   FRAMES TOTAL: " + string(Player.image_number)
				+ "\n   VISUAL ANGLE: " + string(Player.VisualAngle)
				+ "\n"
				+ "\n              * CAMERA *"
				+ "\n"
				+ "\n   X: " + string(CameraX)
				+ "\n   Y: " + string(CameraY)
				+ "\n   SHIFT X: " + string(SpeedX)
				+ "\n   SHIFT Y: " + string(SpeedY)
				+ "\n   SCROLL DELAY TIMER: " + string(ScrollDelay)
				+ "\n   OVERVIEW DELAY TIMER: " + string(OverviewDelay)
				+ "\n   OVERVIEW SHIFT: " + string(OverviewOffset)
				+ "\n   EXTENDED VIEW SHIFT: " + string(ExtendedOffset)
				+ "\n   SPIN OFFSET: " + string(SpinOffset)
				+ "\n"
				+ "\n              * AUDIO *"
				+ "\n"
				+ "\n   NORMAL ACTIVE: " + string(Game.NormalTrack[TrackID])
				+ "\n   NORMAL EVENT: " + string(Game.NormalTrack[TrackEvent])
				+ "\n   PRIORITY ACTIVE: " + string(Game.PriorityTrack[TrackID])
				+ "\n   PRIORITY EVENT: " + string(Game.PriorityTrack[TrackEvent])
				+ "\n   JINGLE ACTIVE: " + string(Game.JingleTrack[TrackID])
				+ "\n   JINGLE EVENT: " + string(Game.JingleTrack[TrackEvent]),
		8, 0.28);
	}
}