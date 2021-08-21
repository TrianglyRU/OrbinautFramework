function ObjBuzzbomberBulletMain()
{
	if !(--Timer)
	{
		// Move object
		x += Xsp;
		y += Ysp;
		
		// Animate it
		animation_play(sprite_index, 1, 2);
	}
	
	// Advance to the next frame
	else if Timer == 8
	{
		sprite_index = 1;
	}
	
	// Damage player
	if object_player_overlap(Hitbox)
	{
		player_damage(false, false, false);
	}
}