/// @description Draw Debug Screen
// You can write your code in this editor
	
	// Draw debug screen
	if DebugFPS
	{
		draw_set_halign(fa_left);
		draw_set_font(Font.FontDefault);
		
		draw_text_transformed(8, global.Height - 4, "FPS: " + string(floor(fps_real)), 0.5, 0.5, 0);
	}
	if DebugVariables
	{
		// Set information to display
		#region Display Info
		{
			if Audio.PrimaryTrack[1]
			{
				var LowPlaying = string_upper(audio_get_name(Audio.PrimaryTrack[1]));
			}
			else
			{
				var LowPlaying = "NOT PLAYING";
			}
			if Audio.SecondaryTrack[1]
			{
				var HighPlaying = string_upper(audio_get_name(Audio.SecondaryTrack[1]));
			}
			else
			{
				var HighPlaying = "NOT PLAYING";
			}		
			switch Audio.PrimaryTrack[0]
			{
				case EventIdle:
					var LowEvent = "IDLE";
				break;
				case EventMute:
					var LowEvent = "MUTE";
				break;
				case EventStop:
					var LowEvent = "STOP";
				break;
				case EventUnmute:
					var LowEvent = "UNMUTE";
				break;
			}
			switch Audio.SecondaryTrack[0]
			{
				case EventIdle:
					var HighEvent = "IDLE";
				break;
				case EventMute:
					var HighEvent = "MUTE";
				break;
				case EventStop:
					var HighEvent = "STOP";
				break;
				case EventUnmute:
					var HighEvent = "UNMUTE";
				break;
			}
		}
		#endregion		
		
		// Draw rectangle
		draw_set_alpha(0.65);
		draw_rectangle_colour(global.Width - 90, 4, global.Width - 4, global.Height - 4, c_black, c_black, c_black, c_black, false)
	
		// Set font
		draw_set_alpha(1);
		draw_set_halign(fa_left);
		draw_set_font(Font.FontDefault);
	
		// Draw debug text
		draw_text_ext_transformed(global.Width - 86, 8,
		
					"         ORBINAUT  FRAMEWORK"
				+ "\n            DEBUG SCREEN"
				+ "\n"
				+ "\n"
				+ "\n          * PLAYER MOTION *"
				+ "\n"
				+ "\n   POS X: "	      + string(floor(Player.PosX)) + " REAL: " + string(Player.PosX)
				+ "\n   POS Y: "		  + string(floor(Player.PosY)) + " REAL: " + string(Player.PosY)
				+ "\n   X SPEED : "		  + string(Player.Xsp) 
				+ "\n   Y SPEED: "		  + string(Player.Ysp) 		
				+ "\n   GROUND SPEED: "	  + string(Player.Gsp) 
				+ "\n   GRAVITY: "	      + string(Player.Grv) 
				+ "\n   GROUND LOCK: "    + string(Player.GroundLock)
				+ "\n   AIR LOCK: "       + string(Player.AirLock)
				+ "\n   SLOPE GRAVITY: "  + string(Player.SlopeGravity)
				+ "\n   ANGLE: "		  + string(Player.Angle)
				+ "\n   COLLISION MODE: " + string(Player.CollisionMode[0]) + " : " + string(Player.CollisionMode[1])
				+ "\n"
				+ "\n         * PLAYER FLAGS *"
				+ "\n"
				+ "\n   X RADIUS: "			 + string(Player.RadiusX)
				+ "\n   Y RADIUS: "		     + string(Player.RadiusY)
				+ "\n   WIDE X RADIUS: "     + string(Player.DefaultRadiusX + 1)
				+ "\n   ON OBJECT: "		 + string(Player.OnObject)
				+ "\n   GROUNDED: "			 + string(Player.Grounded)
				+ "\n   FACING: "			 + string(Player.Facing)
				+ "\n   SPINNING: "			 + string(Player.Spinning)
				+ "\n   JUMPING: "			 + string(Player.Jumping)
				+ "\n   ROLLING: "			 + string(Player.Grounded and Player.Spinning)
				+ "\n   PUSHING: "			 + string(Player.Pushing)
				+ "\n   GLIDE STATE: "		 + string(Player.GlideState)
				+ "\n   GLIDE VALUE: "		 + string(Player.GlideValue)
				+ "\n   CLIMB STATE: "       + string(Player.ClimbState)
				+ "\n   CLIMB VALUE: "	     + string(Player.ClimbValue)
				+ "\n   FLIGHT STATE: "		 + string(Player.FlightState)
				+ "\n   FLIGHT VALUE: "		 + string(Player.FlightValue)
				+ "\n   SPINDASH: "			 + string(round(Player.SpindashRev))
				+ "\n   PEELOUT: "			 + string(Player.PeeloutRev)
				+ "\n   DBL SPIN ATTACK: "	 + string(Player.DoubleSpinAttack)
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
				+ "\n   ANIMATION ID: "  + string(Player.Animation)
				+ "\n   SPRITE: "		 + string_upper(sprite_get_name(Player.sprite_index))
				+ "\n   CURRENT FRAME: " + string(Player.image_index + 1)
				+ "\n   FRAMES TOTAL: "  + string(Player.image_number)
				+ "\n   VISUAL ANGLE: "  + string(Player.VisualAngle)
				+ "\n"
				+ "\n              * CAMERA *"
				+ "\n"
				+ "\n   X: "			  + string(Camera.PosX) + " VIEW X: " + string(Camera.ViewX)
				+ "\n   Y: "			  + string(Camera.PosY) + " VIEW Y: " + string(Camera.ViewY)
				+ "\n   SHIFT X: "		  + string(Camera.ShiftX)
				+ "\n   SHIFT Y: "		  + string(Camera.ShiftY)
				+ "\n   SCROLL DELAY: "   + string(Camera.ScrollDelay)
				+ "\n   OVERVIEW DELAY: " + string(Camera.OverviewDelay)
				+ "\n   OVERVIEW SHIFT: " + string(Camera.OverviewOffset)
				+ "\n   CD SHIFT: "       + string(Camera.ExtendedOffset)
				+ "\n"
				+ "\n              * AUDIO *"
				+ "\n"
				+ "\n   PRIMARY TRACK: "        + LowPlaying
				+ "\n   PRIMARY EVENT: "        + LowEvent
				+ "\n   PRIMARY EVENT TIME: "   + string(Audio.PrimaryTrack[2])
				+ "\n   PRIMARY VOLUME: "       + string(audio_sound_get_gain(Audio.PrimaryTrack[1]))
				+ "\n   PRIMARY POSITION: "     + string(audio_sound_get_track_position(Audio.PrimaryTrack[1]))
				+ "\n   SECONDARY TRACK: "      + HighPlaying
				+ "\n   SECONDARY EVENT: "      + HighEvent
				+ "\n   SECONDARY EVENT TIME: " + string(Audio.SecondaryTrack[2])
				+ "\n   SECONDARY VOLUME: "     + string(audio_sound_get_gain(Audio.SecondaryTrack[1]))
				+ "\n   SECONDARY POSITION: "   + string(audio_sound_get_track_position(Audio.SecondaryTrack[1]))
				+ "\n"
				+ "\n              * STAGE *"
				+ "\n"
				+ "\n   T BOUND: "		   + string(Stage.TopBoundary)    + " TARGET: " + string(Stage.TargetTopBoundary)
				+ "\n   B BOUND: "		   + string(Stage.BottomBoundary) + " TARGET: " + string(Stage.TargetBottomBoundary)
				+ "\n   L BOUND: "		   + string(Stage.LeftBoundary)   + " TARGET: " + string(Stage.TargetLeftBoundary)
				+ "\n   R BOUND: "		   + string(Stage.RightBoundary)  + " TARGET: " + string(Stage.TargetRightBoundary)
				+ "\n   OBJECTS LOADED: "  + string(instance_count),
				
		8, 256, 0.28, 0.28, 0);
	}