function ObjAnimalStartup()
{
	// Initialize variables
	AnimalType   isAsset;
	State		 isReal;
	PosX		 isReal;
	PosY		 isReal;
	DefaultXsp   isReal;
	DefaultYsp   isReal;
	Xsp          isReal;
	Ysp			 isReal;
	Grv			 isReal;
	CapsuleDelay isReal;
	FromCapsule  isBool;
	
	// Set object solidbox
	object_set_solidbox(8, 12);
	
	// Set object depth
	object_set_depth(Player, false);
	
	// Set active range
	object_set_range(RangeClose, 2);
	
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
	
	// Set speeds
	Xsp = DefaultXsp;
	Ysp = -4;
	
	// Set default position
	PosX = x;
	PosY = y;
	
	// Set gravity
	Grv = 0.21875;
}