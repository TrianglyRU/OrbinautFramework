/// @description Insert description here
// You can write your code in this editor
	
	if MovOfst 
	{
		MovOfst--;
	} 
	else 
	{ 
		if y >= InitY 
		{ 
			y = InitY; 
			Ysp = -7; 
			image_speed = 1; 
		}
		
		Ysp += 0.09375;
		PosY += Ysp;
		y = floor(PosY);
		
		if Ysp <= 0 and y < InitY - 192 
		{ 
			image_speed = 2;
		}
		if Ysp > 0  and y > InitY - 192 
		{ 
			image_speed = 0; 
			image_index = 0;
		}
	}
	
	// Check for hitbox overlap
	if object_player_overlap(CollisionHitbox)
	{
		// Damage player or be destroyed
		object_act_badnik(true, false);
	}