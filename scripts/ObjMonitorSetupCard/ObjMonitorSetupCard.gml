function ObjMonitorSetupCard()
{
	// Exit the code if monitor type is "empty"
	if (BoxType == "Empty") exit;
	
	// Create item card
	ItemCard	 = object_spawn(x, y - 3, PowerupCard);
	ItemCardPosY = ItemCard.y;
	
	// Render object behind player
	with ItemCard object_set_depth(Player, false);
	
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