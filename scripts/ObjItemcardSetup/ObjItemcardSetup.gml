function ObjItemcardSetup()
{
	// Exit the code if monitor type is "empty"
	if (BoxType == "Empty") exit;
	
	// Create item card
	ItemCard	 = object_spawn(x, y - 3, ItemboxCard);
	ItemCardPosY = ItemCard.y;
	
	// Load sprite
	ItemCard.sprite_index = spr_obj_itembox_powerup;
	
	// Render object above itembox
	var thisItembox = id;
	with ItemCard object_set_depth(thisItembox, true);
	
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
		case "Invincibility":
			ItemCard.image_index = 3;
		break;
		case "Extra Life":
			ItemCard.image_index = 4;
		break;
	}
}