/// @description Insert description here
// You can write your code in this editor

	var Pos = floor(Player.PosX - x) * sign(image_xscale);
	if JumpTimer
	{
		JumpTimer--;
		if !JumpTimer and object_player_stand(id)
		{
			var Modifier = 0;
			if Pos >= 27
			{
				Modifier = 4;
			}
			else if Pos >= 21
			{
				Modifier = 3;
			}
			else if Pos >= 13
			{
				Modifier = 2;
			}
			else if Pos >= -3  
			{
				Modifier = 1;
			}
			
			with Player
			{
				// Stop player's actions
				GlideState  = false;
				ClimbState  = false;
				FlightState = false;
				Jumping     = false;
				Rolling     = false;
				DropdashRev = -1;
			
				// Go airborne
				Grounded = false;
				OnObject = false;
				
				// Use 'spring' animation
				Animation = AnimSpring;
				
				if abs(Xsp) >= 4
				{
					Xsp += Modifier * sign(Xsp);
				}
				Ysp = -4 - Modifier;
			}
			
			// Play sound
			audio_sfx_play(sfxSpring, false);
		}
	}
	else 
	{
		if object_player_stand(id) and Pos >= -14 and Pos <= 28
		{
			JumpTimer = 4;
		}
	}
	
	image_index = JumpTimer > 0;
	object_act_solid(true, true, true, JumpTimer ? ColMap2 : ColMap1);