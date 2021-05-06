function ObjLayerChangeScript()
{
	// Check if player is overlapping hitbox
	if object_player_overlap(CollisionHitbox)
	{
		// Check for GroundOnly flag
		if !GroundOnly or (GroundOnly and Player.Grounded)
		{
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
	
	// Check if AI is overlapping hitbox
	if object_player_overlap_ai(CollisionHitbox)
	{
		// Check for GroundOnly flag
		if !GroundOnly or (GroundOnly and AI.Grounded)
		{
			// Check player's movement direction and perform layer change
			var    AIDirection = AI.Xsp <= 0 ? LeftDirection : RightDirection;
			switch AIDirection
			{
				case "To LayerA":
					AI.Layer = LayerA;
				break;
				case "To LayerB":
					AI.Layer = LayerB;
				break;
			}
		}
	}
}