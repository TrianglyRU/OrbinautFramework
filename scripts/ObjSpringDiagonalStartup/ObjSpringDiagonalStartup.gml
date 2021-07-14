function ObjSpringDiagonalStartup()
{
	// Initialize variables
	LaunchSide  isVar;
	LaunchForce isVar;
	
	// Set object solidbox
	object_set_solidbox(16, 16);
	CollisionMap = [16,16,16,16,16,16,16,16,16,16,15,14,13,12,11,10,9,8,7,6,5,4,3,2,1,0,-1,-2,-3,-4,-5,-6];
	
	// Set object depth
	object_set_depth(Player, false);
	
	// Define launch side
	LaunchSide = image_yscale ? SideTop : SideBottom;
	
	// Define spring force
	if object_index == SpringYellowDiagonal
	{
		LaunchForce = 10;
	}
	else if object_index == SpringRedDiagonal
	{
		LaunchForce = 16;
	}
}