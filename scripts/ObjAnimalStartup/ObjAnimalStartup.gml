function ObjAnimalStartup()
{
	// Variables list
	AnimalType   = 0;
	State		 = 0;
	PosX		 = 0;
	PosY		 = 0;
	DefaultXsp   = 0;
	DefaultYsp   = 0;
	Xsp          = 0;
	Ysp			 = 0;
	Grv			 = 0;
	CapsuleDelay = 0;
	FromCapsule  = 0;
	
	// Destroy object if stage animal set is empty
	if Stage.AnimalSet == noone
	{
		instance_destroy(id);
	}
	else
	{
		// Choose random animal
		AnimalType = Stage.AnimalSet[irandom(array_length(Stage.AnimalSet) - 1)];
	
		// Set default speeds based on animal type
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
	
		// Set speeds
		Xsp = DefaultXsp;
		Ysp = -4;
	
		// Set default position
		PosX = x;
		PosY = y;
	
		// Set gravity
		Grv = 0.21875;
	
		// Apply sprite
		animation_set_frame(AnimalType, 1);
	
		// Set object solidbox
		object_set_solidbox(8, 12, false);
	
		// Set object depth
		object_set_depth(Player, false);
	
		// Set active range
		object_set_range(RangeClose, ResetDelete);
	}
}