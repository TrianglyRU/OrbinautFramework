/// @description Main
// You can write your code in this editor
	
	// Act as badnik and exit if it was destroyed
	if object_act_enemy(EnemyBadnik)
	{
		return;
	}
	
	PosY += Ysp;
	Ysp  += 0.09375;
	y	  = floor(PosY);
	
	switch State
	{
		case 0:
		{
			// If near peak amplitude, speedup animation
			if y <= OriginY - 192
			{
				animation_play(sprite_index, 4, 0);
				
				// Increment state
				State++;
			}
		}
		break;
		case 1:
		{
			// If falling down, stop animation
			if y >= OriginY - 192
			{
				animation_set(sprite_index, 0);
				
				// Increment state
				State++;
			}
		}
		break;
		case 2:
		{
			// If fallen below initial position, restart
			if y >= OriginY 
			{ 
				y   = OriginY; 
				Ysp = -7;
				
				animation_play(sprite_index, 8, 0);
				
				// Go back to state 0
				State -= 2;
			}
		}
		break;
	}