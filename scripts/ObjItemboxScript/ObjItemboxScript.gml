function ObjItemboxScript()
{
	// Check if monitor is not destoryed
	if !Destroyed
	{
		// Play normal animation
		animation_play(spr_obj_itembox, 4, 1);
		
		if (Player.Animation == AnimRoll or Player.GlidingState == 1) and Player.Ysp >= 0
		{
			if object_player_overlap(CollisionHitbox)
			{
				// Inverse player's yspeed if not grounded
				if (!Player.Grounded) Player.Ysp = -Player.Ysp;
					
				// Spawn explosion and play its sound
				instance_create(floor(x), floor(y), DustExplosion);
				audio_sfx_play(sfxDestroy, false);
					
				// Update 'destroyed' flag
				Destroyed = true;
			}
		}		
		else
		{
			// Do solid collision
			object_act_solid(true, true, false, false);
			
			// Bounce monitor up if player is moving upwards
			if !Airborne
			{
				if floor(Player.PosY - 16) >= floor(y) and object_player_overlap(CollisionHitbox)
				{
					Airborne   = true;
					Ysp        = -1.5;
					Player.Ysp = -Player.Ysp;
				}
			}
		}

		// Check if monitor is airborne
		if Airborne
		{
			// Update position
			Ysp  += 0.21875;
			PosY += Ysp;
		
			// Do collision with tiles & check if we collided
			var foundFloor = object_collide_tiles_v(SideLeft, SideBottom, 0, LayerA)
			if  foundFloor
			{
				Airborne = false;
			}
		}	
	}
	
	// Check if monitor is destroyed
	else
	{
		// Play destroyed animation
		animation_play(spr_obj_itembox_destroyed, 1, 1);
	}
	
	y = floor(PosY);
}