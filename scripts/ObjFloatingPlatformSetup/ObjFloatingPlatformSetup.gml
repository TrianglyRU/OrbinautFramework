function ObjFloatingPlatformSetup()
{
	// Set solidbox
	object_set_solidbox(PlatformXRadius, PlatformYRadius);
	
	// Render behind the player
	object_set_depth(Player, false);
	
	// Set sprite
	id.sprite_index = PlatformSprite;
	
	// Set positions
	OriginX = x;
	OriginY = y;
	
	// Set fall state
	FallTimer = 0;
	FallState = false;
}