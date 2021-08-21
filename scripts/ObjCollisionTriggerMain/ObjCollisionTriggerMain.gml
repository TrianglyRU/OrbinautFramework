function ObjCollisionTriggerMain()
{
	// Exit if no overlap occured
	if object_player_overlap(Triggerbox)
	{
		exit;
	}
	
	// Check for GroundOnly flag
	if !GroundOnly or (GroundOnly and Player.Grounded)
	{
		// Check player's movement direction and perform layer change
		var    Direction = Player.Xsp <= 0 ? LeftDirection : RightDirection;
		switch Direction
		{
			case "To LayerA":
				Player.Layer = LayerA;
			break;
			case "To LayerB":
				Player.Layer = LayerB;
			break;
		}
	}
}