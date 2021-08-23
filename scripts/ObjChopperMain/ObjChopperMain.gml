function ObjChopperMain()
{
	// Move Chopper
	PosY += Ysp;
	Ysp  += 0.09375;
	
	// Update its position
	y = floor(PosY);

	if Ysp < 0
	{ 
		// If near peak amplitude, speedup animation
		if y < OriginY - 192
		{
			AnimationSpeed = 4;
		}
		
		// Play animation
		animation_play(sprite_index, AnimationSpeed, 0);
	}
	else
	{ 
		// If fallen below its initial position, jump
		if y >= OriginY 
		{ 
			y	= OriginY; 
			Ysp	= -7; 
			
			// Set animation speed
			AnimationSpeed = 8; 
		}
		
		// Stop animation
		image_index = 0;
	}
	
	// Act as badnik
	object_act_enemy(EnemyBadnik);
}