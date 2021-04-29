function ObjFloatingPlatformSetup()
{
	// Set object solidbox
	object_set_solidbox(PlatformXRadius, PlatformYRadius);
	
	// Render object behind player
	object_set_depth(Player, false);
	
	// Set sprite
	id.sprite_index = PlatformSprite;
	
	// Set positions
	OriginX = x;
	OriginY = y;
}