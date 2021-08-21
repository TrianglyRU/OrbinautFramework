/// @description Insert description here
// You can write your code in this editor
	
	// Move Chopper
	PosY += Ysp;
	Ysp  += 0.09375;
	
	// Update its position
	y = floor(PosY);

	// If near peak amplitude, speedup animation
	if Ysp < 0
	{ 
		if y < OriginY - 192
		{
			AnimationSpeed = 4;
		}
		
		// Play animation
		animation_play(sprite_index, AnimationSpeed, 0);
	}
	else if Ysp >= 0
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