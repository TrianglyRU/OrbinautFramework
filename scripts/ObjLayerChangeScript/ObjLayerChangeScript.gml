function ObjLayerChangeScript()
{
	if object_check_overlap(CollisionHitbox)
	{
		// Check for GroundOnly flag
		if GroundOnly and !Player.Grounded exit;
		
		// Check player's movement direction and perform layer change
		var    PlayerDirection = Player.Xsp < 0 ? LeftDirection : RightDirection;
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