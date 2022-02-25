/// @function player_damage(isFlame,isThunder,instantKill)
function player_damage(isFlame,isThunder,instantKill)
{	
	// Exit if player can't be damaged
	if Player.Death or Player.DebugMode
	{
		return;
	}	
	if !instantKill and (Player.InvincibilityFrames or Player.InvincibleBonus or Player.SuperState)
	{
		return;
	}
	if isFlame and Player.BarrierType == BarrierFlame
	{
		return;
	}
	if isThunder and Player.BarrierType == BarrierThunder
	{
		return;
	}
	
	var ThisObject = id;
	
	audio_sfx_stop(sfxFlying);
	audio_sfx_stop(sfxTired);
	
	with Player
	{
		// Kill player
		if !Rings and !BarrierType or instantKill
		{	
			if global.Character == CharTails
			{
				TailsObject.visible = false;
			}
			Camera.Enabled = false;
			
			AllowCollision      = false;
			BarrierType		    = false;
			Death               = true;
			InvincibilityFrames = 0;		
			Animation	        = AnimDeath;

			Grv   =  0.21875;
			Ysp	  = -7;
			Xsp	  =  0;
			Gsp   =  0;
			
			// Draw player above everything
			depth = 50;
		}
		
		// Make player lose their rings or barrier
		else
		{	
			Animation		    = AnimHurt;
			Hurt				= true;
			InvincibilityFrames = 120;
					
			// Lose rings
			if !BarrierType
			{		
				if Rings > 0
				{
					audio_sfx_play(sfxRingLoss, false)
				}
			
				// Set default values we will use to spread rings
				var Direction = -1;
				var Angle     = 168.75;
				var Speed     = 4;
			
				for (var i = 0; i < min(Rings, 32); i++) 
				{
					// Spawn ring
					var NewObject = instance_create(PosX, PosY, ShatteredRing);
					if  i == 16 
					{ 
						Angle = 168.75; 
						Speed = 2;
					}
					with NewObject
					{
						Xsp = Speed * dsin(Angle) * Direction;
						Ysp = Speed * dcos(Angle);
					}
				
					if Direction
					{ 
						Angle -= 22.5;
					}
					Direction *= -1
				}
			
				Rings		    = 0;
				LivesRewards[0] = 100;
			}
			
			// Lose barrier
			else
			{
				BarrierType = false;
			}
		
			// Set speeds
			if !IsUnderwater
			{
				Xsp =  floor(PosX) > floor(ThisObject.x) ? 2 : -2;
				Ysp = -4;
				Grv =  0.1875;
			}
			else
			{
				Xsp =  floor(PosX) > floor(ThisObject.x) ? 1 : -1;
				Ysp = -2;
			
				// Reduce gravity by 0x28 (0.15625) if underwater
				Grv = 0.0625;
			}
		}
	
		RadiusX      = DefaultRadiusX;
		RadiusY      = DefaultRadiusY;
		AirLock      = true;
		Grounded	 = false;
		OnObject	 = false;
		Jumping	     = false;
		Spinning     = false;
		FlightState  = false;
		GlideState   = false;
		ClimbState   = false;
		PeeloutRev   = -1;
		SpindashRev  = -1;
		DropdashRev  = -1;
		DropdashFlag = DashLocked;
	}
	
	// Play hurt sound
	if !audio_sfx_is_playing(sfxRingLoss)
	{
		switch object_index
		{
			case SpikesVertical: 
			case SpikesHorizontal:
				audio_sfx_play(sfxHurtSpike, false);
			break;
			default:
				audio_sfx_play(sfxHurt, false);
		}
	}
}