/// @description Insert description here
// You can write your code in this editor
	if JumpTimer
	{
		JumpTimer--;
		if !JumpTimer and object_player_stand(id)
		{
			var Modifier = 0;
			var Pos = Player.PosX - x;
			if Pos >= 28
			{
				Modifier = 4;
			}
			else if Pos >= 22
			{
				Modifier = 3;
			}
			else if Pos >= 14
			{
				Modifier = 2;
			}
			else if Pos >= -2  
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
				
				if abs(Xsp) >= 4
				{
					Xsp += Modifier * sign(Xsp);
				}
				Ysp = -4 - Modifier;
			}
		}
	}
	else if object_player_stand(id) and Player.PosX >= x - 15 and Player.PosX <= x + 29
	{
		JumpTimer = 4;
	}
	
	image_index = JumpTimer > 0;
	object_act_solid(false, true, false, JumpTimer ? ColMap2: ColMap1);