function ObjSpindashDustMain()
{
	// Play animation
	animation_play(sprite_index, 2, 1);
	
	// Follow player
	x = floor(Player.PosX);
	y = floor(Player.PosY + Player.RadiusY);	
	
	// Destroy if player is airborne or not spindashing anymore
	if !Player.Grounded or Player.Spinning or Player.SpindashRev == -1
	{
		instance_destroy();
	}
}