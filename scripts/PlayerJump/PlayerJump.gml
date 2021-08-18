function PlayerJump()
{
	// Exit if we're not jumping
	if !Player.Jumping
	{
		exit;
	}
	
	// Shorten our jump if button is released
	if !Input.ABC
	{
		if Player.Ysp < Player.JumpMin
		{
			Player.Ysp = Player.JumpMin;
		}
	}	
	
	// Exit the further code if button wasn't pressed mid-air
	if !Input.ABCPress
	{
		exit;
	}
	
	// Clear the rolljump flag
	Player.RollJumping = false;
	
	// Transform into super form
	if Input.CPress and Player.Rings >= 50 and !Player.SuperState and Game.Emeralds == 7 and !Stage.IsFinished
	{
		Player.InvincibilityFrames = 0;
		Player.NoControls		   = true;
		Player.SuperState          = true;
		Player.SuperStateValue     = false;
		Player.InvincibilityBonus  = false;
		Player.Jumping			   = false;
		Player.Spinning			   = false;
		Player.RadiusX			   = Player.DefaultRadiusX;
		Player.RadiusY			   = Player.DefaultRadiusY;
		Player.Animation	       = AnimTransform;
		
		// Play transform sound and super theme
		audio_sfx_play(sfxTransform, false);		
		audio_bgm_play(PriorityLow, SuperMusic, other);	
	}
	
	// Else perform double jump action
	else switch Game.Character
	{
		// Use barriers as Sonic
		case CharSonic:
		{
			// Exit if not allowed to use barrier
			if Player.SuperState	  or Player.InvincibilityBonus
			or Player.BarrierIsActive or Player.BarrierType <= BarrierNormal
			{
				exit;
			}
			
			// Set flag
			Player.BarrierIsActive = true;
			
			// Get current barrier
			switch Player.BarrierType
			{
				// Flame barrier
				case BarrierFlame:
				{
					if Camera.ExtendedOffset == 0 
					{
						Camera.ScrollDelay = 16;
					}
					Player.Xsp = 8 * Player.Facing;
					Player.Ysp = 0;
					
					audio_sfx_play(sfxFlameBarrierDash, false);
				}
				break;
			
				// Thunder barrier
				case BarrierThunder:
				{
					for (var i = 0; i < 4; i++)
					{
						var  Sparkle = instance_create(floor(Player.PosX), floor(Player.PosY), ThunderSparkle);
						with Sparkle
						{
							SparkleID = i;
						}
					}
					Player.Ysp = -5.5;
				
					audio_sfx_play(sfxThunderBarrierSpark, false);
				}
				break;
			
				// Water barrier
				case BarrierWater:
				{
					with Barrier
					{
						animation_set_frame(spr_barrier_water_drop, 1);
					}
					Player.Xsp = Game.BuffedWaterBarrier ? Player.Xsp / 2 : 0;
					Player.Ysp = 8;	
				}
				break;
			}
		}
		break;
		
		// Start Tails flight
		case CharTails:
		{
			Input.ABC	       = false;
			Input.ABCPress     = false;
			Player.Jumping	   = false;
			Player.Spinning    = false;	
			Player.Grv		   = 0.03125;
			Player.FlightValue = 480;
			Player.FlightState = FlightActive;	
			Player.RadiusX     = Player.DefaultRadiusX;
			Player.RadiusY     = Player.DefaultRadiusY;
		}
		break;
			
		// Start Knuckles glide
		case CharKnuckles:
		{
			Player.Ysp			  = max(Ysp, 0);
			Player.Xsp			  = 4 * Facing;	
			Player.Inertia		  = 0;
			Player.RadiusX		  = 10;
			Player.RadiusY		  = 10;						
			Player.Jumping		  = false;
			Player.Spinning		  = false;
			Player.GlideGrounded  = false;
			Player.GlideState     = GlideActive;
			Player.GlideDirection = Player.Facing;
			Player.GlideValue     = Player.Facing == FlipRight ? 180 : 0;	
		}
		break;
	}
}