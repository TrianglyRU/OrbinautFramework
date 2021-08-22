function InterfaceDebugScreenDraw()
{	
	// Exit if not allowed to display
	if !Game.DevMode or !Stage.DoUpdate or !DebugToggle
	{
		exit;
	}
	
	// Set font
	draw_set_font(Game.Font[font_default]);
	
	// Toggle hotkeys on-screen guide
	if keyboard_check_pressed(ord("Y"))
	{
		DebugHelp = !DebugHelp;
	}
	
	// Display available hotkeys
	if DebugHelp
	{
		draw_set_halign(fa_center);
		draw_text_transformed(Game.Width / 2, Game.Height - 4, "TOGGLE: Q  SOLIDS: W  HITBOXES:E  TRIGGERS: R  VARIABLES: T  SHORTCUTS: Y", 0.5, 0.5, 0);
	}
	
	// Toggle variables debug
	if keyboard_check_pressed(ord("T"))
	{
		DebugVariables = !DebugVariables;
	}
	
	// Display variables
	if DebugVariables
	{
		// Draw rectangle
		draw_set_alpha(0.65);
		draw_rectangle_colour(Game.Width - 90, 4, Game.Width - 4, Game.Height - 12, c_black, c_black, c_black, c_black, false)
	
		// Set font
		draw_set_alpha(1);
		draw_set_halign(fa_left);
	
		// Display debug screen
		draw_text_ext_transformed(Game.Width - 86, 8,
					"          ORBINAUT  FRAMEWORK"
				+ "\n            STANDALONE VER."
				+ "\n"
				+ "\n         BY TRIANGLY AND MICG"
				+ "\n"
				+ "\n"
				+ "\n          * PLAYER MOTION *"
				+ "\n"
				+ "\n   POS X: "	     + string(floor(Player.PosX)) + " REAL: " + string(Player.PosX)
				+ "\n   POS Y: "		 + string(floor(Player.PosY)) + " REAL: " + string(Player.PosY)
				+ "\n   SPEED X: "		 + string(Player.Xsp) 
				+ "\n   SPEED Y: "		 + string(Player.Ysp) 		
				+ "\n   INERTIA: "		 + string(Player.Inertia) 
				+ "\n   GRAVITY: "	     + string(Player.Grv) 
				+ "\n   GROUND LOCK: "   + string(Player.GroundLock)
				+ "\n   AIR LOCK: "      + string(Player.AirLock)
				+ "\n   SLOPE GRAVITY: " + string(Player.SlopeGravity)
				+ "\n   ANGLE: "		 + string(Player.Angle)
				+ "\n"
				+ "\n         * PLAYER INFORMATION *"
				+ "\n"
				+ "\n   X RADIUS: "			 + string(Player.RadiusY)
				+ "\n   Y RADIUS: "		     + string(Player.RadiusX)
				+ "\n   WALL OFFSET: "       + string((Player.Grounded and Player.Angle == 360) * 8)
				+ "\n   ON OBJECT: "		 + string(Player.OnObject)
				+ "\n   GROUNDED: "			 + string(Player.Grounded)
				+ "\n   FACING: "			 + string(Player.Facing)
				+ "\n   SPINNING: "			 + string(Player.Spinning)
				+ "\n   JUMPING: "			 + string(Player.Jumping)
				+ "\n   ROLLING: "			 + string(Player.Grounded and Player.Spinning)
				+ "\n   PUSHING: "			 + string(Player.Pushing)
				+ "\n   GLIDE STATE: "		 + string(Player.GlideState)
				+ "\n   GLIDE VALUE: "		 + string(Player.GlideValue)
				+ "\n   GLIDE SLIDE: "	     + string(Player.GlideGrounded)
				+ "\n   CLIMB STATE: "       + string(Player.ClimbState)
				+ "\n   CLIMB VALUE: "	     + string(Player.ClimbValue)
				+ "\n   FLIGHT STATE: "		 + string(Player.FlightState)
				+ "\n   FLIGHT VALUE: "		 + string(Player.FlightValue)
				+ "\n   SPINDASH: "			 + string(round(Player.SpindashRev))
				+ "\n   PEELOUT: "			 + string(Player.PeeloutRev)
				+ "\n   DROPDASH: "			 + string(Player.DropdashRev)
				+ "\n   DROPDASH FLAG: "	 + string(Player.DropdashFlag)
				+ "\n   BARRIER: "		     + string(Player.BarrierType)
				+ "\n   BARRIER ACTIVE: "    + string(Player.BarrierIsActive)
				+ "\n   LAYER: "			 + string(Player.Layer)
				+ "\n   HIGHSPEED BONUS: "   + string(Player.HighspeedBonus)
				+ "\n   INVIN BONUS: "		 + string(Player.InvincibleBonus)
				+ "\n   INVIN FRAMES: "		 + string(Player.InvincibilityFrames)
				+ "\n   HURT: "				 + string(Player.Hurt)
				+ "\n   UNDERWATER: "		 + string(Player.IsUnderwater)
				+ "\n   AIR TIMER: "		 + string(Player.AirTimer)
				+ "\n   SUPER STATE: "		 + string(Player.SuperState)
				+ "\n   SUPER STATE VALUE: " + string(Player.SuperStateValue)
				+ "\n"
				+ "\n         * PLAYER VISUALS *"
				+ "\n"
				+ "\n   ANIMATION: "     + string(sprite_get_name(Player.sprite_index))
				+ "\n   NEXT FRAME IN: " + string(Player.image_duration)
				+ "\n   CURRENT FRAME: " + string(Player.image_index + 1)
				+ "\n   LAST FRAME: "    + string(Player.image_lastindex + 1)
				+ "\n   FRAMES TOTAL: "  + string(Player.image_number)
				+ "\n   VISUAL ANGLE: "  + string(Player.VisualAngle)
				+ "\n"
				+ "\n              * CAMERA *"
				+ "\n"
				+ "\n   X: "			  + string(Camera.ViewX)
				+ "\n   Y: "			  + string(Camera.ViewY)
				+ "\n   SHIFT X: "		  + string(Camera.ShiftX)
				+ "\n   SHIFT Y: "		  + string(Camera.ShiftY)
				+ "\n   SCROLL DELAY: "   + string(Camera.ScrollDelay)
				+ "\n   OVERVIEW DELAY: " + string(Camera.OverviewDelay)
				+ "\n   OVERVIEW SHIFT: " + string(Camera.OverviewOffset)
				+ "\n   CD SHIFT: "       + string(Camera.ExtendedOffset)
				+ "\n   SPIN OFFSET: "    + string(Camera.SpinOffset)
				+ "\n"
				+ "\n              * INPUT *"
				+ "\n"
				+ "\n   LEFT: "	 + string(Input.Left)  + " LEFT PRESS: " + string(Input.LeftPress)
				+ "\n   RIGHT: " + string(Input.Right) + " RIGHT PRESS: " + string(Input.RightPress)
				+ "\n"
				+ "\n              * AUDIO *"
				+ "\n"
				+ "\n   LOW TRACK: "       + string(Audio.LowTrack[0])
				+ "\n   LOW EVENT: "       + string(Audio.LowTrack[2])
				+ "\n   LOW EVENT TIME: "  + string(Audio.LowTrack[3])
				+ "\n   LOW VOLUME: "      + string(audio_sound_get_gain(Audio.LowTrack[0]))
				+ "\n   LOW POSITION: "    + string(audio_sound_get_track_position(Audio.LowTrack[0]))
				+ "\n   HIGH TRACK: "      + string(Audio.HighTrack[0])
				+ "\n   HIGH EVENT: "      + string(Audio.HighTrack[2])
				+ "\n   HIGH EVENT TIME: " + string(Audio.HighTrack[3])
				+ "\n   HIGH VOLUME: "     + string(audio_sound_get_gain(Audio.HighTrack[0]))
				+ "\n   HIGH POSITION: "   + string(audio_sound_get_track_position(Audio.HighTrack[0])),
		8, 256, 0.28, 0.28, 0);
	}
}