function ObjBuzzbomberStartup()
{
	// Create variables
	Way		      = 0;
	InitX         = 0;
	Delay	      = 0;
	Action		  = 0;
	InitDirection = 0;
	Direction     = 0;
	BulletObject  = 0;
	
	// Set flags
	InitX		  = x;
	InitDirection = image_xscale;
	Direction	  = image_xscale; 
	BulletObject  = noone;
	Way			  = 500;
	
	// Set object hitbox
	object_set_hitbox(24, 12);
	
	// Set object depth
	object_set_depth(Player, false);
	
	// Set object active range
	object_set_range(TypeReset);
}