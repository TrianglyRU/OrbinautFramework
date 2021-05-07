function ObjSpringHorizontalSetup()
{
	// Set object solidbox
	object_set_solidbox(8, 14);
	
	// Set object visibility
	object_set_visibility(true);
		
	// Render behind the player
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