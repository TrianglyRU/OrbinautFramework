function ObjAnimalMain()
{
	if CapsuleDelay
	{
		if !(--CapsuleDelay)
		{
			State = 0;
		}
	}
	else
	{	
		// Move vertically
		Ysp  += Grv; 
		PosY += Ysp;
	
		// Update position
		object_update_position(PosX, PosY);
	
		// 'Appear from Badink' state
		if State == 0
		{
			if Ysp > 0 
			{
				var FindFloor = object_collide_tiles_v(SideCentre, SideBottom, 0, LayerA)
				if  FindFloor
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
			        State++;
			    }
			}
		}
	
		// Leaving state
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
					animation_play(sprite_index, 4, 2);
				}
				break;
			
				// Cucky
				case spr_obj_animal_cucky:
				{
					animation_play(sprite_index, 2, 2);
				}
				break;
			
				// Pocky, Ricky, Rocky, Picky, Pecky
				case spr_obj_animal_pocky:
				case spr_obj_animal_ricky:
				case spr_obj_animal_rocky:
				case spr_obj_animal_picky:
				case spr_obj_animal_pecky:
				{
					animation_set_frame(sprite_index, Ysp < 0 ? 2 : 3);
				}
				break;
			}
		 
			// Reverse speed when colliding ground
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