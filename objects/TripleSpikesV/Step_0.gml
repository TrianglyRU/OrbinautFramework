/// @description Insert description here
// You can write your code in this editor
	
	// Get hurt sidt
	var hurtSide = image_yscale == 1 ? SideTop : SideBottom
	
	// Check if player is touching the hurt side
	if object_check_touch(hurtSide)
	{
		// Damage them
		object_do_damage(false, false, false);
	}
	
	// Do solid collision
	object_do_collision(SolidAll, false);