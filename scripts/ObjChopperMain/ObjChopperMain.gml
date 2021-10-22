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
			animation_play(sprite_index, 4, 0, 0);
		}	
	}
	else
	{ 
		// If fallen below its initial position, jump
		if y >= OriginY 
		{ 
			y	= OriginY; 
			Ysp	= -7; 
			 
			// Reset animation speed
			animation_play(sprite_index, 8, 0, 0);
		}
		
		// Stop animation
		else
		{
			animation_set(sprite_index, 0);
		}	
	}
	
	// Act as badnik
	object_act_enemy(EnemyBadnik);
}