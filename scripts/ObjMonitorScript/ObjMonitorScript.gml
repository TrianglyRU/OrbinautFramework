function ObjMonitorScript()
{
	// Check if monitor is not destoryed
	if !Destroyed
	{
		// Play normal animation
		animation_play(spr_obj_itembox, 4, 1);
		
		// Check if player is rolling or jumping, and does not standing on the monitor
		if (Player.Rolling or Player.Jumping) and Player.OnObject != id
		{		
			// Do not act as solid
			object_act_solid(false, false, false, false);
			
			// Check for hitbox overlap
			if object_player_overlap(CollisionHitbox)
			{
				// Check if player is moving downwards
				if Player.Ysp >= 0
				{
					// Inverse player's yspeed if not grounded
					if (!Player.Grounded) Player.Ysp = -Player.Ysp;
					
					// Spawn explosion and play its sound
					object_spawn(floor(x), floor(y), ExplosionFX);
					audio_sfx_play(sfxDestroy, false, false);
					
					// Update 'destroyed' flag
					Destroyed = true;
					
					// Shake the camera
					Screen.ShakeTime     = 6;
					Screen.ShakeStrength = 3;
					
					// Exit further code
					exit;
				}
					
				// Bounce monitor up if player is moving upwards
				else if floor(Player.PosY - 16) >= floor(y)
				{
					Airborne   = true;
					Ysp        = -1.5;
					Player.Ysp = -Player.Ysp;
				}
			}
		}
		
		// Do solid collision
		else
		{
			object_act_solid(true, true, false, false);
		}
		
		// Check if monitor is airborne
		if Airborne
		{
			// Update position
			Ysp  += 0.21875;
			PosY += Ysp;
			y	  = floor(PosY);
		
			// Do collision with tiles & check if we collided
			var foundFloor = object_collide_tiles_v(SideLeft, SideBottom, 0, LayerA)
			if  foundFloor
			{
				Airborne = false;
			}
		}	
		
		// Keep card on the same y as itembox
		ItemCardPosY = y - 3;
	}
	
	// Check if monitor is destroyed
	else
	{
		// Play destroyed animation
		animation_play(spr_obj_itembox_destroyed, 1, 1);
	}
}