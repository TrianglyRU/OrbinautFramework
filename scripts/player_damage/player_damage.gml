/// @function object_damage(flame_type,thunder_type,instant_kill)
function object_damage(flame_type, thunder_type, instant_kill)
{	
	// Exit the code if player can't be damaged
	if !instant_kill and (Player.InvincibilityFrames or Player.InvincibilityBonus or Player.SuperState)
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
	
	// Reset player flags
	Player.NoControls   = true;
	Player.Jumping		= false;
	Player.FlightState	= false;
	Player.GlideState	= false;
	Player.ClimbState   = false;
	Player.PeeloutRev	= -1;
	Player.SpindashRev  = -1;
	Player.DropdashRev  = -1;
	
	// Go airborne
	Player.Grounded	= false;
	Player.OnObject	= false;
	
	// Stop Tails sfx
	audio_sfx_stop(sfxFlying);
	audio_sfx_stop(sfxTired);
	
	// Set graivty
	Player.Grv = 0.1875;
	
	// Check if player has no rings and barrier or should die instantly
	if !Player.Rings and !Player.BarrierType or instant_kill
	{	
		// Disable collisions and camera
		Screen.CameraEnabled  = false;
		Player.AllowCollision = false;
		
		// Ignore all input
		Input.IgnoreInput = true;
		
		// Draw player above everything
		Player.DrawOrder = 0;
			
		// Perform movement
		Player.Inertia = 0;
		Player.Xsp	   = 0;
		Player.Ysp	   = -7;
			
		// Enter death state
		Player.Death     = true;
		Player.Animation = AnimDeath;
		
		// Play hurt sound
		if object_index == SpikesVertical or object_index == SpikesHorizontal
		{
			audio_sfx_play(sfxHurtSpike, false)
		}
		else
		{
			audio_sfx_play(sfxHurt, false);
		}
	}
		
	// Check if player has rings or barrier
	else
	{	
		// Set 'hurt' animation
		Player.Animation = AnimHurt;
		
		// Reset radiuses
		Player.RadiusX = Player.DefaultRadiusX;
		Player.RadiusY = Player.DefaultRadiusY;
						
		// Lose rings if we do not have active barrier
		if !Player.BarrierType
		{
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

				// Set ring flags and speed
				Created.Xsp = Spd * dsin(Ang) * Dir;
				Created.Ysp	= Spd * dcos(Ang);
				
				// Update direction and movement angle
				if Dir 
				{ 
					Ang -= 22.5;
				}
				Dir *= -1
			}
			
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
			
			// Update player's ring counter
			Player.Rings		= 0;
			Player.LivesRewards = 0;
	
		}
			
		// Else just lose barrier if player has rings
		else
		{
			// Remove barrier
			instance_destroy(Barrier);
			Player.BarrierType = false;
			
			if object_index == SpikesVertical or object_index == SpikesHorizontal
			{
				audio_sfx_play(sfxHurtSpike, false)
			}
			else
			{
				audio_sfx_play(sfxHurt, false);
			}
		}
		
		// Reduce gravity if underwater by 0x20
		if Player.IsUnderwater
		{
			Player.Grv -= 0.125;
			
			Player.Xsp = floor(Player.PosX) > floor(x) ? 1 : -1;
			Player.Ysp = -2;
		}
		else
		{
			Player.Xsp = floor(Player.PosX) > floor(x) ? 2 : -2;
			Player.Ysp = -4;
		}
		
		// Enter hurt state
		Player.Hurt				   = true;
		Player.InvincibilityFrames = 121;
	}
}