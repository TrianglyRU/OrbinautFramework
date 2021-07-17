/// @description Insert description here
// You can write your code in this editor

	// Check if timer is higher than 0
	if StopTimer 
	{
		// Count it down
		StopTimer--;
		
		// If it counted to 0, flip badnik and restore speed
		if !StopTimer
		{
			sprite_index = spr_badnik_crabmeat_move;
			Xsp  =  0.5;
			Dir *= -1;
			
			// Set xscale to Crabmeat direction
			image_xscale = Dir;
			
			Reset = false;
		}
	}
	
	x += Xsp * Dir;
	
	if Xsp != 0
	{
		// Collide tiles & check for if Crabmeat is 2 pixels away from the surface
		var collideFloor = object_collide_tiles_v(Dir ? SideRight : SideLeft, SideBottom, 2, LayerA);
		if !collideFloor
		{
			// Stop Motobug
			StopTimer = 120;
			Xsp       = 0;
			sprite_index = spr_badnik_crabmeat_idle;
		}
	}
	
	if StopTimer == 60 and !Reset 
	{
		sprite_index = spr_badnik_crabmeat_fire;
		var i = 1;
		repeat(2)
		{
			var Bullet = instance_create_depth(x + 16 * i, y, depth, BadnikBullet)
			with Bullet 
			{
				Xsp = i;      
				Ysp = -4; 
				Grv = 0.21875;
				sprite_index = spr_badnik_bullet2;
			}
			i = -1;
		}
	}

	// Check for hitbox overlap
	object_act_enemy(EnemyBadnik)