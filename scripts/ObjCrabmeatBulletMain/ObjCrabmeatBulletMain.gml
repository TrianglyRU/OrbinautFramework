function ObjCrabmeatBulletMain()
{
	// Move bullet
	PosX += Xsp;
	PosY += Ysp;
	Ysp  += 0.21875;
	
	// Update position
	x = floor(PosX);
	y = floor(PosY);
	
	// Damage player on overlap
	if object_check_overlap(Hitbox)
	{
		player_damage(false, false, false);
	}
	
	// Play animation
	animation_play(sprite_index, 4, 0);
}