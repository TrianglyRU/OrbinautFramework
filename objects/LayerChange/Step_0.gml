/// @description Script
// You can write your code in this editor
	
	// Check for overlap
	if hitbox_collision(Player, self)
	{
		// Check for GroundOnly flag
		if GroundOnly and !Player.Grounded exit;
		
		// Check player's movement direction and perform layer change
		var    PlayerDirection = Player.Xsp < 0 ? LeftDirection : RightDirection;
		switch PlayerDirection
		{
			case "None": 
			break;
			case "To LayerA":
				Player.Layer = LayerA;
			break;
			case "To LayerB":
				Player.Layer = LayerB;
			break;
		}
	}
				