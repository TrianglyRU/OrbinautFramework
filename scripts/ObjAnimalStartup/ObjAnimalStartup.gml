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
	
	// Set object solidbox
	object_set_solidbox(8, 12, false);
	
	// Set object depth
	object_set_depth(Player, false);
	
	// Set active range
	object_set_range(RangeClose, ResetDelete);
	
	// Animals list
	AnimalType = choose
	(
		spr_obj_animal_flicky,
		spr_obj_animal_pocky,
		spr_obj_animal_flicky,
		spr_obj_animal_pocky,
	);
	
	// Set default speeds based on animal type
	switch AnimalType
	{
        case spr_obj_animal_flicky: 
		{
			DefaultXsp = 3;
			DefaultYsp = -4;
		}
		break;
		case spr_obj_animal_pocky:
		{
			DefaultXsp = 2;
			DefaultYsp = -4;
		}
		break;
    }
	
	// Apply sprite
	animation_set_frame(AnimalType, 1);
	
	// Set speeds
	Xsp = DefaultXsp;
	Ysp = -4;
	
	// Set default position
	PosX = x;
	PosY = y;
	
	// Set gravity
	Grv = 0.21875;
}