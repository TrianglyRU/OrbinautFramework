function ObjRingCollect()
{
	if hitbox_collision(Player, self)
	{	
		// Add 1 to ring counter
		Player.Rings++;
		
		// Create shine object (depth will be set on RingSparkle creation)
		instance_create_depth(x, y, depth, RingSparkle);	
		
		// Play sound
		sound_sfx_play(sfxRing, false);
		
		// Destroy ring
		instance_destroy(self);		
	}
}