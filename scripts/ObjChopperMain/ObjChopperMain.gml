function ObjChopperMain()
{
	// Move Chopper
	PosY += Ysp;
	Ysp  += 0.09375;
	
	// Update its position
	y = floor(PosY);
	
	switch State
	{
		case 0:
		{
			// If near peak amplitude, speedup animation
			if y < OriginY - 192
			{
				animation_play(sprite_index, 4, 0, 0);
				
				// Increment state
				State++;
			}
		}
		break;
		case 1:
		{
			if Ysp >= 0
			{
				animation_set(sprite_index, 0);
				
				// Increment state
				State++;
			}
		}
		break;
		case 2:
		{
			if y >= OriginY 
			{ 
				y = OriginY; Ysp = -7; 
				animation_play(sprite_index, 8, 0, 0);
				
				// Go back to state 0
				State -= 2;
			}
		}
		break;
	}

	// Act as badnik
	object_act_enemy(TypeBadnik);
}