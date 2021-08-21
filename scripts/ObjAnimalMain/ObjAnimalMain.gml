function ObjAnimalMain()
{
	// If animal is coming from a capsule, wait until moving on
	if CapsuleDelay
	{	
		if !(--CapsuleDelay)
		{
			State = 0;
			object_set_depth(EggPrison, true);
		}
	}
	else
	{	
		// Move vertically		
		PosY += Ysp;
		Ysp  += 0.21875; 
	
		// Update position
		object_update_position(PosX, PosY);
	
		// Appear
		if State == 0
		{
			if Ysp > 0 
			{
				// Collide with floor
				var FindFloor = object_collide_tiles_v(SideCentre, SideBottom, 0, LayerA)
				if  FindFloor
				{
					// Set direction
				    image_xscale = FromCapsule ? choose(-1, 1) : -1;
				
					// Set speeds
					Xsp	*= image_xscale;
					Ysp  = -4;
				
					// Change gravity for Flicky
					if AnimalType == spr_obj_animal_flicky
					{
						Grv = 0.09375;
					}
				
					// Switch to second frame
					image_index = 1;
				
					// Increment state
			        State++;
			    }
			}
		}
		
		// Leave the screen
		else if State == 1
		{
			// Move horizontally
			PosX += Xsp;
		
			// Animate animal
			switch AnimalType
			{
				// Flicky
				case spr_obj_animal_flicky:
				{
					animation_play(sprite_index, 4, 1);
				}
				break;
			
				// Cucky
				case spr_obj_animal_cucky:
				{
					animation_play(sprite_index, 2, 1);
				}
				break;
			
				// Pocky, Ricky, Rocky, Picky, Pecky
				case spr_obj_animal_pocky:
				case spr_obj_animal_ricky:
				case spr_obj_animal_rocky:
				case spr_obj_animal_picky:
				case spr_obj_animal_pecky:
				{
					image_index = Ysp < 0 ? 1 : 2;
				}
				break;
			}
		 
			// Reverse speed if in collision with floor
			if Ysp > 0
			{
				var FindFloor = object_collide_tiles_v(SideCentre, SideBottom, 0, LayerA)
				if  FindFloor
				{
					Ysp = DefaultYsp;
				}
			}
		}
	}
}