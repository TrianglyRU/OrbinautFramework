function ObjAnimalMain()
{
	// Update vertical speed
	Ysp  += Grv;
	PosY += Ysp;
	
	// 'Appear from Badink' state
	if State == 0
	{
		// Check if animal colliding with the ground
		if Ysp > 0 
		{
			var findFloor = object_collide_tiles_v(false, SideBottom, 0, LayerA)
			if  findFloor
			{
				// Reverse speed
		        Ysp = -4;
				
				// Set direction
			    image_xscale = FromCapsule ? choose(-1, 1) : -1;
				
				// Set horizontal speed
				Xsp	*= image_xscale;
				
				// Change gravity for Flicky
				if AnimalType == spr_obj_animal_flicky
				{
					Grv = 0.09375;
				}
				
				// Set second frame
				animation_set_frame(false, 2);
				
				// Go to the next state
		        State = 1;
		    }
		}
	}
	
	// Leaving state
	else if State == 1
	{
		// Move
		PosX += Xsp;
		
		// Animate animal
		switch AnimalType
		{
			// Flicky
			case spr_obj_animal_flicky:
			{
				if animation_get_frame(id) == 1
				{
					animation_set_frame(sprite_index, 2);
				}
				animation_play(sprite_index, 3, 2);
			}
			break;
			
			// Pocky
			case spr_obj_animal_pocky:
			{
				animation_set_frame(sprite_index, Ysp < 0 ? 2 : 3);
			}
			break;
		}
		 
		// Reverse speed when colliding ground
		if Ysp > 0
		{
			var findFloor = object_collide_tiles_v(false, SideBottom, 0, LayerA)
			if  findFloor
			{
				Ysp = DefaultYsp;
			}
		}
	}
}