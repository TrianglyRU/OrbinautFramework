function PlayerCharacterAnimationList()
{	
	switch CharacterID
	{	
		case CharSonic:
		
			// Static animations
			if Inertia = 0
			{
				if !Input.Down and !Input.Up and SpindashRev < 0
				{
					animation_set(spr_sonic_idle, 12, false);
				}
				if Input.Down and SpindashRev < 0 
				{
					animation_set(spr_sonic_crouch, 4, false);
				}
				if Input.Down and SpindashRev >= 0
				{
					animation_set(spr_sonic_spindash, 1, true);
				}	
				if Input.Up
				{
					animation_set(spr_sonic_lookup, 4, false);
				}
			}
			
			// Movement animations
			if Inertia != 0 and !Rolling and !Jumping
			{
				if abs(Inertia) < TopAcc 
				{
					animation_set(spr_sonic_walk, round(max(1, 8 - abs(Inertia))), true);			
				}
				else
				{
					animation_set(spr_sonic_run, round(max(1, 8 - abs(Inertia))), true);
				}		
			}
			
			// Spin animations
			if Rolling or Jumping
			{
				animation_set(spr_sonic_roll, round(max(1, 5 - abs(Inertia))), true);
			}

		break;
		case CharTails: 
		/*
			// Idle
			if Inertia = 0 and (Grounded or OnObject) 
			{	
				animation_set(spr_tails_idle, 128);
			}
		
			// Walking
			if Inertia != 0 
			{	
				animation_set(spr_tails_walk, round(max(1, 8 - abs(Inertia))));
			}
		
			// Running
			if abs(Inertia) >= TopAcc 
			{			
				animation_set(spr_tails_run, round(max(1, 8 - abs(Inertia))));
			} 
		
			// Rolling and Jumping
			if Rolling or Jumping 
			{	
				animation_set(spr_tails_roll, 2);
			}
			*/
		break;
	}
}