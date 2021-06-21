function ObjSpringHorizontalSetup()
{
	// Initialize variables
	LaunchSide  isVar;
	LaunchForce isVar;
	
	/* Variable Definitions	
	1. SpringType, default = "Yellow"
	*/
	
	// Set object solidbox
	object_set_solidbox(8, 16);
	
	// Set object depth
	object_set_depth(Player, false);
	
	// Define launch side
	LaunchSide = image_xscale ? SideRight : SideLeft;
	
	// Define spring force and sprite
	if SpringType == "Yellow"
	{
		LaunchForce  = 10;
		sprite_index = spr_obj_spring_yellow_h;
	}
	else if SpringType == "Red"
	{
		LaunchForce  = 16;
		sprite_index = spr_obj_spring_red_h;
	}
}