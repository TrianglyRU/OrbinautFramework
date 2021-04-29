function ObjLayerChangeScript()
{
	// Adjust triggerbox based on player's speed
	object_set_triggerbox(-8 - abs(Player.Xsp / 2), 8 + abs(Player.Xsp / 2), -32, 32)

	// Check if player is inside the triggerbox
	if object_player_overlap(CollisionTriggerbox)
	{
		// Check for GroundOnly flag
		if GroundOnly and !Player.Grounded exit;
		
		// Check player's movement direction and perform layer change
		var    PlayerDirection = Player.Xsp <= 0 ? LeftDirection : RightDirection;
		switch PlayerDirection
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