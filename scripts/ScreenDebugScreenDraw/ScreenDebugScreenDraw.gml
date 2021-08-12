function ScreenDebugScreenDraw()
{	
	string_set_font(Game.Font[FontDebug], fa_left);
	string_display(Width - 45, Height - 8, "FPS: " + string(floor(fps)), 0.5);
	string_display(Width - 65, Height - 4, "GAME FPS: " + string(floor(fps_real)), 0.5);
	
	if !Game.DevMode
	{
		exit;
	}
	
	// Hotkeys:
	if Stage.DoUpdate and DebugToggle
	{
		string_set_font(Game.Font[FontDebug], fa_center);
		string_display(Width / 2, Height - 4, "TOGGLE: Q  SOLIDS: W  HITBOXES:E  SENSORS: R  VARIABLES: T", 0.5);
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
		string_set_font(Game.Font[FontDebug], fa_left);
	
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
				+ "\n   PLAYER X RADIUS: " + string(Player.RadiusY)
				+ "\n   PLAYER Y RADIUS: " + string(Player.RadiusX)
				+ "\n   WALL OFFSET: " + string((Player.Grounded and Player.Angle == 360) * 8)
				+ "\n"
				+ "\n          * PLAYER MOTION *"
				+ "\n"
				+ "\n   POS X: " + string(floor(Player.PosX)) + " REAL: " + string(Player.PosX)
				+ "\n   POS Y: " + string(floor(Player.PosY)) + " REAL: " + string(Player.PosY)
				+ "\n   SPEED X: " + string(Player.Xsp) 
				+ "\n   SPEED Y: " + string(Player.Ysp) 		
				+ "\n   INERTIA: " + string(Player.Inertia) 
				+ "\n   GRAVITY: " + string(Player.Grv) 
				+ "\n   MOVEMENT LOCK: " + string(Player.MovementLock)
				+ "\n   SLOPE GRAVITY: " + string(Player.SlopeGravity)
				+ "\n   ANGLE: " + string(Player.Angle)
				+ "\n"
				+ "\n         * STATES AND FLAGS *"
				+ "\n"
				+ "\n   ON OBJECT: " + string(Player.OnObject)
				+ "\n   GROUNDED: " + string(Player.Grounded)
				+ "\n   FACING: " + string(Player.Facing)
				+ "\n   SPINNING: " + string(Player.Spinning)
				+ "\n   JUMPING: " + string(Player.Jumping)
				+ "\n   ROLLING: " + string(Player.Grounded and Player.Spinning)
				+ "\n   ROLL JUMPING: " + string(Player.RollJumping)
				+ "\n   PUSHING: " + string(Player.Pushing)
				+ "\n   BALANCING: " + string(Player.Balancing)
				+ "\n   SKIDDING: " + string(Player.Skidding)
				+ "\n   GLIDE STATE: " + string(Player.GlideState)
				+ "\n   GLIDE VALUE: " + string(Player.GlideValue)
				+ "\n   GLIDE SLIDE: " + string(Player.GlideGrounded)
				+ "\n   CLIMB STATE: " + string(Player.ClimbState)
				+ "\n   CLIMB VALUE: " + string(Player.ClimbValue)
				+ "\n   FLIGHT STATE: " + string(Player.FlightState)
				+ "\n   FLIGHT VALUE: " + string(Player.FlightValue)
				+ "\n   SPINDASH: " + string(round(Player.SpindashRev))
				+ "\n   PEELOUT: " + string(Player.PeeloutRev)
				+ "\n   DROPDASH: " + string(Player.DropdashRev)
				+ "\n   BARRIER: " + string(Player.BarrierType)
				+ "\n   BARRIER ACTIVE: " + string(Player.BarrierIsActive)
				+ "\n   LAYER: " + string(Player.Layer)
				+ "\n   HIGHSPEED BONUS: " + string(Player.HighSpeedBonus)
				+ "\n   INVINCIBLE BONUS: " + string(Player.InvincibilityBonus)
				+ "\n   INVINCIBILITY FRAMES: " + string(Player.InvincibilityFrames)
				+ "\n   HURT: " + string(Player.Hurt)
				+ "\n   UNDERWATER: " + string(Player.IsUnderwater)
				+ "\n   AIR TIMER: " + string(Player.AirTimer)
				+ "\n   SUPER STATE: " + string(Player.SuperState)
				+ "\n   SUPER STATE VALUE: " + string(Player.SuperStateValue)
				+ "\n"
				+ "\n         * CHARACTER VISUALS *"
				+ "\n"
				+ "\n   ANIMATION: " + string(sprite_get_name(Player.sprite_index))
				+ "\n   NEXT FRAME IN: " + string(Player.image_duration)
				+ "\n   CURRENT FRAME: " + string(Player.image_index + 1)
				+ "\n   LAST FRAME: " + string(Player.image_lastindex + 1)
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
				+ "\n   LOW TRACK: " + string(Game.LowTrack[0])
				+ "\n   LOW EVENT: " + string(Game.LowTrack[2])
				+ "\n   LOW EVENT TIME: " + string(Game.LowTrack[3])
				+ "\n   LOW VOLUME: " + string(audio_sound_get_gain(Game.LowTrack[0]))
				+ "\n   LOW POSITION: " + string(audio_sound_get_track_position(Game.LowTrack[0]))
				+ "\n   HIGH TRACK: " + string(Game.HighTrack[0])
				+ "\n   HIGH EVENT: " + string(Game.HighTrack[2])
				+ "\n   HIGH EVENT TIME: " + string(Game.HighTrack[3])
				+ "\n   HIGH VOLUME: " + string(audio_sound_get_gain(Game.HighTrack[0]))
				+ "\n   HIGH POSITION: " + string(audio_sound_get_track_position(Game.HighTrack[0])),
		8, 0.28);
	}
}