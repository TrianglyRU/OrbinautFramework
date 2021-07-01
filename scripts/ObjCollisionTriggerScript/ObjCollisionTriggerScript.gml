function ObjCollisionChangeScript()
{
	// Check if player is overlapping triggerbox
	if object_player_overlap(CollisionTriggerbox)
	{
		// Check for GroundOnly flag
		if !GroundOnly or (GroundOnly and Player.Grounded)
		{
			// Check player's movement direction and perform layer change
			var    playerDirection = Player.Xsp <= 0 ? LeftDirection : RightDirection;
			switch playerDirection
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
}