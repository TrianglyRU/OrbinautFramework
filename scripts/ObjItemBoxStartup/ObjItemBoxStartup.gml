function ObjItemBoxStartup()
{
	// Set variables
	PosX	  = x;
	PosY	  = y;
	CardX	  = x;
	CardY	  = y - 4;
	Timer     = 5;
	CardSpeed = 3;
	State	  = 0;
	IsFalling = 0;
	Ysp		  = 0;
	
	/* Variable Definitions	
	1. BoxType, default = "Empty"
	*/
	
	// Define item card to display
	switch BoxType
	{
		case "10 Rings":
			CardSprite = 0;
		break;
		case "Barrier":
			CardSprite = 1;
		break;
		case "Thunder Barrier":
			CardSprite = 2;
		break;
		case "Flame Barrier":
			CardSprite = 3;
		break;
		case "Water Barrier":
			CardSprite = 4;
		break;
		case "High Speed":
			CardSprite = 5;
		break;
		case "Invincibility":
			CardSprite = 6;
		break;
		case "Extra Life":
			CardSprite = 7 + Game.Character;
		break;
		case "Eggman":
			CardSprite = 10;
		break;
		case "Empty":
			CardSprite = 11;
		break;
	}
	
	// Set object solidbox
	object_set_solidbox(14, 16, false);

	// Set object hitbox
	object_set_hitbox(15, 17);
	
	// Set object depth
	object_set_depth(Player, false);
	
	// Set active range
	object_set_range(TypeReset);
}