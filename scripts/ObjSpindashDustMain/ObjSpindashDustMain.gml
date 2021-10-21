function ObjSpindashDustMain()
{
	// Follow player
	x = floor(Player.PosX);
	y = floor(Player.PosY + Player.RadiusY);	
	
	// Destroy if player is airborne or not spindashing anymore
	if !Player.Grounded or Player.SpindashRev == -1
	{
		instance_destroy();
	}
}