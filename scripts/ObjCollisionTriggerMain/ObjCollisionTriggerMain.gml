function ObjCollisionTriggerMain()
{
	// Check for GroundOnly flag
	if !GroundOnly or (GroundOnly and Player.Grounded)
	{
		// Check player's movement direction
		var    Direction = Player.Xsp <= 0 ? LeftDirection : RightDirection;
		switch Direction
		{
			case "To LayerA":
				TargetLayer = LayerA;
			break;
			case "To LayerB":
				TargetLayer = LayerB;
			break;
		}
	}
	
	// Exit if no overlap occured
	if !object_check_overlap(TypeTrigger) or Player.DebugMode
	{
		exit;
	}
	
	// Change layer
	Player.Layer = TargetLayer;
}