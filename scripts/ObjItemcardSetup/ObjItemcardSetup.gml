function ObjItemcardSetup()
{
	// Initialize variables
	ItemCard	  isVar;
	ItemCardRel   isVar;
	ItemCardTimer isVar;
	ItemCardYsp	  isVar;
	ItemCardPosY  isVar;
	
	// Exit the code if monitor type is "empty"
	if BoxType == "Empty"
	{
		exit;
	}
	
	// Create item card
	ItemCard	 = instance_create(x, y - 3, ItemboxCard);
	ItemCardPosY = ItemCard.y;
	
	// Load sprite
	ItemCard.sprite_index = spr_obj_itembox_powerup;
	
	// Render object above itembox
	var  ThisItembox = id;
	with ItemCard object_set_depth(ThisItembox, true);
	
	// Define card to display
	switch BoxType
	{
		case "10 Rings":
			ItemCard.image_index = 0;
		break;
		case "High Speed":
			ItemCard.image_index = 1;
		break;
		case "Regular Barrier":
			ItemCard.image_index = 2;
		break;
		case "Thunder Barrier":
			ItemCard.image_index = 3;
		break;
		case "Flame Barrier":
			ItemCard.image_index = 4;
		break;
		case "Water Barrier":
			ItemCard.image_index = 5;
		break;
		case "Invincibility":
			ItemCard.image_index = 6;
		break;
		case "Extra Life":
			ItemCard.image_index = 7 + Player.CharacterID;
		break;
		case "Eggman":
			ItemCard.image_index = 10;
		break;
	}
}