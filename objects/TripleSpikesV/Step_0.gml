/// @description Insert description here
// You can write your code in this editor
	
	// Check if player is standing on the spikes
	if object_check_touch(SideTop)
	{
		// Damage them
		object_do_damage(false);
	}
	
	// Do solid collision
	object_do_collision(SolidAll, false);