function ObjItemBoxStartup()
{
	/* Variable Definitions	
	1. BoxType, default = "Empty"
	*/
	
	PosX	  = x;
	PosY	  = y;
	CardX	  = x;
	CardY	  = y - 3;
	Timer     = 5;
	CardSpeed = 3;
	IsFalling = 0;
	State	  = 0;
	Ysp		  = 0;

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
	
	// Set object properties
	object_set_unload(FlagReset);
	object_set_depth(Player, 0);
	object_set_hitbox(16, 16);
	object_set_solidbox(15, 15, false);
	
	animation_play(sprite_index, 4, 0);
}