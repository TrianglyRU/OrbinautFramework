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
			{
				TargetLayer = LayerA;
				image_index = 1;
			}
			break;
			case "To LayerB":
			{
				TargetLayer = LayerB;
				image_index = 2;
			}
			break;
		}
	}
	
	// Exit if no overlap occured
	if !object_check_overlap(Triggerbox)
	{
		exit;
	}
	
	// Change layer
	Player.Layer = TargetLayer;
}