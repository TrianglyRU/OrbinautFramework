function ObjAnimalStartup()
{
	if Stage.AnimalSet == noone
	{
		instance_destroy();
	}
	else
	{
		// Choose random animal
		AnimalType = Stage.AnimalSet[irandom(array_length(Stage.AnimalSet) - 1)];
	
		// Set default speed
		switch AnimalType
		{
		    case spr_obj_animal_flicky: 
			{
				DefaultXsp =  3;
				DefaultYsp = -4;
			}
			break;
			case spr_obj_animal_pocky:
			{
				DefaultXsp =  2;
				DefaultYsp = -4;
			}
			break;
			case spr_obj_animal_cucky:
			{
				DefaultXsp =  2;
				DefaultYsp = -3;
			}
			break;
			case spr_obj_animal_pecky:
			{
				DefaultXsp =  1.5;
				DefaultYsp = -3;
			}
			break;
			case spr_obj_animal_picky:
			{
				DefaultXsp =  1.75;
				DefaultYsp = -3;
			}
			break;
			case spr_obj_animal_ricky:
			{
				DefaultXsp =  2.5;
				DefaultYsp = -3.5;
			}
			break;
			case spr_obj_animal_rocky:
			{
				DefaultXsp =  1.25;
				DefaultYsp = -1.5;
			}
			break;
		}
	
		// Initialise variables
		PosX  = x;
		PosY  = y;
		Xsp   = DefaultXsp;
		Ysp   = -4;
		Grv   = 0.21875;
		State = 0;
		Delay = 0;
	
		// Set object properties
		object_set_unload(FlagDelete);
		object_set_depth(Player, 0);
		object_set_solidbox(8, 12, false);
		
		animation_set(AnimalType, 0); image_xscale = -1;
	}
}