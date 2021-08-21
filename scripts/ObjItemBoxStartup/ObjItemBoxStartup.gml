function ObjItemBoxStartup()
{
	// Variables list
	Airborne    = 0;
	Destroyed   = 0;
	PosX        = 0;
	PosY	    = 0;
	Ysp		    = 0;	
	CardPosX    = 0;
	CardPosY    = 0;
	CardSpeed   = 0;
	CardSprite  = 0;
	CardTimer   = 0;
	
	/* Variable Definitions	
	1. BoxType, default = "Empty"
	*/

	// Set object solidbox
	object_set_solidbox(14, 16, false);

	// Set object hitbox
	object_set_hitbox(15, 17);
	
	// Set object pdeth
	object_set_depth(Player, false);
	
	// Set active range
	object_set_range(RangeFar, TypeReset);
	
	// Set default propertiess
	PosX	  = x;
	PosY	  = y;
	CardPosX  = x;
	CardPosY  = y - 4;
	CardSpeed = -3;
	CardTimer =  5;
	
	// Define item card to display
	switch BoxType
	{
		case "10 Rings":
			CardSprite = 0;
		break;
		case "High Speed":
			CardSprite = 1;
		break;
		case "Regular Barrier":
			CardSprite = 2;
		break;
		case "Thunder Barrier":
			CardSprite = 3;
		break;
		case "Flame Barrier":
			CardSprite = 4;
		break;
		case "Water Barrier":
			CardSprite = 5;
		break;
		case "Invincibility":
			CardSprite = 6;
		break;
		case "Extra Life":
			CardSprite = 7 + Player.CharacterID;
		break;
		case "Eggman":
			CardSprite = 10;
		break;
		case "Empty":
			CardSprite = 11;
		break;
	}
}