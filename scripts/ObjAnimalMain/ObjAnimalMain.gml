function ObjAnimalMain()
{
	switch State
	{
		case 0:
		{
			PosY += Ysp;
			Ysp  += Grv;
			
			if Ysp > 0 
			{
				// Check for floor
				var FindFloor = tile_find_v(PosX, PosY + 12, true, false, LayerA)[0];
				if  FindFloor < 0
				{
					PosY += FindFloor;
					
					if AnimalType == spr_obj_animal_flicky
					{
						Grv = 0.09375;
					}
					Xsp	*= image_xscale;
					Ysp	 = -4;
					
					// Update animation
					switch AnimalType
					{
						case spr_obj_animal_flicky:
							animation_play(sprite_index, 4, 1);
						break;
						case spr_obj_animal_cucky:
							animation_play(sprite_index, 2, 1);
						break;
					}
					image_index = 1; 
				
					// Increment state
			        State++;
			    }
			}
		}
		break;
		case 1:
		{
			PosX += Xsp;
			PosY += Ysp;
			Ysp  += Grv;
		
			// Update animation
			switch AnimalType
			{
				case spr_obj_animal_pocky: case spr_obj_animal_ricky:
				case spr_obj_animal_rocky: case spr_obj_animal_picky:
				case spr_obj_animal_pecky:
				{
					image_index = Ysp < 0 ? 1 : 2;
				}
				break;
			}
			
			// Check for floor
			if Ysp > 0
			{
				var FindFloor = tile_find_v(PosX, PosY + 12, true, false, LayerA)[0]
				if  FindFloor < 0
				{
					PosY += FindFloor;
					Ysp   = DefaultYsp;
				}
			}
		}
		break;
		
		// Spawn from the Egg Prison
		case 2:
		{
			if !(--Delay)
			{
				object_set_depth(EggPrison, 1);
				image_xscale = choose(-1, 1);
				
				// Decrement state
				State -= 2;
			}
		}
		break;
	}
	
	// Update position
	x = floor(PosX);
	y = floor(PosY);
}