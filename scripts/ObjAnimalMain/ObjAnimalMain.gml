function ObjAnimalMain()
{
	switch State
	{
		case 0:
		{
			// Move vertically
			PosY += Ysp;
			Ysp  += Grv;
			
			if Ysp > 0 
			{
				// Collide with floor
				var FindFloor = tile_check_collision_v(PosX, PosY + 12, true, false, LayerA)[0];
				if  FindFloor < 0
				{
					// Clip out
					PosY += FindFloor;
				
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
		break;
		case 1:
		{
			// Move
			PosX += Xsp;
			PosY += Ysp;
			Ysp  += Grv;
		
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
			
			// Check for floor
			if Ysp > 0
			{
				var FindFloor = tile_check_collision_v(PosX, PosY + 12, true, false, LayerA)[0]
				if  FindFloor < 0
				{
					// Clip out
					PosY += FindFloor;
					
					// Reverse speed
					Ysp = DefaultYsp;
				}
			}
		}
		break;
		case 2:
		{
			if !(--Delay)
			{
				State -= 2;
				object_set_depth(EggPrison, true);
				
				// Set direction
				image_xscale = choose(-1, 1);
			}
		}
		break;
	}
	
	// Update position
	x = floor(PosX);
	y = floor(PosY);
}