function ObjDoubleSpinShieldMain()
{
	// Destroy on animation end
	if image_index == 6
	{
		instance_destroy();
	}
	
	// Follow player
	else
	{
		x = floor(Player.PosX);
		y = floor(Player.PosY);
		
		// Check for player's direction
		image_xscale = Player.Facing;
	}
}