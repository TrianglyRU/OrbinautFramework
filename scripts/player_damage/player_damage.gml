/// @function player_damage(flame_type,thunder_type,instant_kill)
function player_damage(flame_type,thunder_type,instant_kill)
{	
	// Exit if player can't be damaged
	if !instant_kill and (Player.InvincibilityFrames or Player.InvincibleBonus or Player.SuperState)
	{
		exit;
	}
	if flame_type and Player.BarrierType == BarrierFlame
	{
		exit;
	}
	if thunder_type and Player.BarrierType == BarrierThunder
	{
		exit;
	}
	
	// Set flags
	Player.NoControls  = true;
	Player.Grounded	   = false;
	Player.OnObject	   = false;
	Player.Jumping	   = false;
	Player.FlightState = false;
	Player.GlideState  = false;
	Player.ClimbState  = false;
	Player.PeeloutRev  = -1;
	Player.SpindashRev = -1;
	Player.DropdashRev = -1;
	
	// Stop sounds
	audio_sfx_stop(sfxFlying);
	audio_sfx_stop(sfxTired);
	
	// Kill player
	if !Player.Rings and !Player.BarrierType or instant_kill
	{	
		// Set flags
		Stage.AllowPause	  = false;
		Camera.Enabled		  = false;
		Player.AllowCollision = false;
		Player.DrawOrder	  = 0;
		Player.Death          = true;
		Player.Animation	  = AnimDeath;
				
		// Perform movement
		Player.Grv     = 0.21875;
		Player.Ysp	   = -7;
		Player.Xsp	   = 0;
		Player.Inertia = 0;
		
		// Play hurt sound
		if object_index == SpikesVertical or object_index == SpikesHorizontal
		{
			audio_sfx_play(sfxHurtSpike, false);
		}
		else
		{
			audio_sfx_play(sfxHurt, false);
		}
	}
		
	// Check if player has rings or barrier
	else
	{	
		// Set flags
		Player.Animation		   = AnimHurt;
		Player.Hurt				   = true;
		Player.InvincibilityFrames = 121;
		
		// Reset collision radiuses
		Player.RadiusX = Player.DefaultRadiusX;
		Player.RadiusY = Player.DefaultRadiusY;
						
		// Lose rings
		if !Player.BarrierType
		{
			Player.Rings		= 0;
			Player.LivesRewards = 0;
			
			// Play sound
			if Player.Rings > 0
			{
				audio_sfx_play(sfxRingLoss, false)
			}
			else
			{
				if object_index == SpikesVertical or object_index == SpikesHorizontal
				{
					audio_sfx_play(sfxHurtSpike, false)
				}
				else
				{
					audio_sfx_play(sfxHurt, false);
				}
			}
			
			// Set default values we will use to spread rings
			var Dir = -1;
			var Ang = 168.75;
			var Spd = 4;
			
			// Do for each ring (maximum of 32)
			for (var i = 0; i < min(Player.Rings, 32); i++) 
			{
				// Spawn ring
				var Created = instance_create(floor(Player.PosX), floor(Player.PosY), RingShattered);
				if  i == 16 
				{ 
					Ang = 168.75; 
					Spd = 2;
				}
				Created.Xsp = Spd * dsin(Ang) * Dir;
				Created.Ysp	= Spd * dcos(Ang);
				
				// Update direction and movement angle
				if Dir 
				{ 
					Ang -= 22.5;
				}
				Dir *= -1
			}
		}
			
		// Lose barrier
		else
		{
			// Remove barrier
			instance_destroy(Barrier);
			Player.BarrierType = false;
			
			// Play sound
			if object_index == SpikesVertical or object_index == SpikesHorizontal
			{
				audio_sfx_play(sfxHurtSpike, false)
			}
			else
			{
				audio_sfx_play(sfxHurt, false);
			}
		}
		
		// Set speeds
		if !Player.IsUnderwater
		{
			Player.Grv = 0.1875;
			
			Player.Xsp = floor(Player.PosX) > floor(x) ? 1 : -1;
			Player.Ysp = -2;
		}
		else
		{
			// Reduce gravity by 0x20 if underwater
			Player.Grv = 0.0625;
			
			Player.Xsp = floor(Player.PosX) > floor(x) ? 2 : -2;
			Player.Ysp = -4;
		}
	}
}