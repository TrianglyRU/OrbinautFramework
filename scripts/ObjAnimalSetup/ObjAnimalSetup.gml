function ObjAnimalSetup()
{
	object_set_solidbox(8, 8);
	object_set_depth(Player, false);

	AnimalType = choose(spr_obj_animal_flicky);
	
	switch AnimalType
	{
        case spr_obj_animal_flicky: Xsp = 3; Ysp = -4; break;
    }
	
	FromCapsule = false;
	Grv			= 0.21875;
	PosX		= x;
	PosY		= y;
}