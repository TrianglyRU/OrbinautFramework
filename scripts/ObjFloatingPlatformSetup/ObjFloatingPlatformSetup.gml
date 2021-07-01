function ObjFloatingPlatformSetup()
{
	// Initialize variables
	OriginX   isVar;
	OriginY   isVar;
	Weight    isVar;
	Angle	  isVar;
	FallState isVar;
	FallTimer isVar;
	
	/* Variable Definitions	
	1. PlatformXRadius,  default = 30;
	2. PlatformYRadius,  default = 11;
	3. PlatformSpeed,    default = 0;
	4. PlatformDistance, default = 0;
	5. PlatformSprite,   default = spr_obj_platform_template;
	6. PlatformMovement, default = "Horizontal";
	7. PlatformDoFall,   default = false;
	*/
	
	// Set object solidbox
	object_set_solidbox(PlatformXRadius, PlatformYRadius);
	
	// Set object depth
	object_set_depth(Player, false);
	
	// Set sprite
	id.sprite_index = PlatformSprite;
	
	// Set default position
	OriginX = x;
	OriginY = y;
}