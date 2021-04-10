function ObjRingScript()
{
	// Play animation
	animation_play(sprite_index, 4, 1);
	
	// Check for collision
	if object_check_overlap(Player, self)
	{	
		// Add 1 to ring counter
		Player.Rings++;
		
		// Create shine object (depth will be set on RingSparkle creation)
		instance_create_depth(x, y, depth, RingSparkle);	
		
		// Play sound
		audio_sfx_play(sfxRing, false);
		
		// Destroy ring
		instance_destroy(self);		
	}
}