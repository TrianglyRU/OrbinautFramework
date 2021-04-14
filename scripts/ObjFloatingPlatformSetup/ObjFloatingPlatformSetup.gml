function ObjFloatingPlatformSetup()
{
	// Set depth
	object_set_depth(Player, false);
	
	// Set visibility
	object_set_visibility(true);
	
	// Set solidbox
	object_set_solidbox(PlatformXRadius, PlatformYRadius);
	
	// Set sprite
	id.sprite_index = PlatformSprite;
}