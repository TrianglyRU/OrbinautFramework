/// @description Insert description here
// You can write your code in this editor
	
	// Check if itembox is not destoryed
	if !Destroyed
	{
		// Play normal animation
		animation_play(spr_obj_itembox, 3, 1);
		
		// Do not solid collision if player is rolling or jumping 
		if (Player.Rolling or Player.Jumping) and Player.OnObject != id
		{		
			// Do not do collision
			object_do_collision(SolidNone, false);
			
			// Check for hitbox overlap
			if object_check_overlap(CollisionHitbox)
			{
				if Player.Ysp >= 0
				{
					// Inverse player's yspeed if not grounded
					if (!Player.Grounded) Player.Ysp = -Player.Ysp;
					
					// Spawn explosion and enter destoryed state
					instance_create_depth(floor(x), floor(y), depth, ExplosionFX);
					Destroyed = true;
					
					// Play sound
					audio_sfx_play(sfxDestroy, false, false);
					
					// Exit further code
					exit;
				}
					
				// Bounce monitor up if player collided from bottom
				else if floor(Player.PosY - 16) >= floor(y)
				{
					Airborne   = true;
					Ysp        = -1.5;
					Player.Ysp = -Player.Ysp;
				}
			}
		}
		
		// Do solid collision
		else if floor(Player.PosY) < y
		{
			object_do_collision(SolidAll, false);
		}
		
		// Fall if airborne
		if Airborne
		{
			// Update code position
			Ysp  += 0.21875;
			PosY += Ysp;
			
			// Update object position
			y = floor(PosY);
		
			// Check for landing
			if object_check_tiles_v(SideLeft, SideBottom, 0, LayerA)
			{
				object_collide_tiles_v(SideLeft, SideBottom, LayerA);
				Airborne = false;
			}
		}	
	}
	
	// Check if itembox is destroyed
	else
	{
		// Play destroyed animation
		animation_play(spr_obj_itembox_destroyed, 1, 1);
	}
	