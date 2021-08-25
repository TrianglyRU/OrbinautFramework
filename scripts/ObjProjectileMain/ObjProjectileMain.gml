function ObjProjectileMain()
{
	// Move object
	PosX += Xsp;
	PosY += Ysp;
	Ysp  += 0.21875;
	
	// Update object position
	x = floor(PosX);
	y = floor(PosY);
	
	// Check if object should bounce off player (TODO)
	if object_check_overlap(Hitbox)
	{
		player_damage(false, false, false);
	}
	
	// Play animation
	animation_play(sprite_index, 4, 0);
}