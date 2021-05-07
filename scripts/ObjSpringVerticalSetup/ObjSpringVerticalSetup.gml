function ObjSpringVerticalSetup()
{
	// Set object solidbox
	object_set_solidbox(14, 8);
	
	// Set object visibility
	object_set_visibility(true);
		
	// Render behind the player
	object_set_depth(Player, false);
	
	// Define launch side
	LaunchSide = image_yscale ? SideTop : SideBottom;
	
	// Define spring force and sprite
	if SpringType == "Yellow"
	{
		LaunchForce  = 10;
		sprite_index = spr_obj_spring_yellow_v;
	}
	else if SpringType == "Red"
	{
		LaunchForce  = 16;
		sprite_index = spr_obj_spring_red_v;
	}
}