/// @description
// You can write your code in this editor
	
	// Render above player
	object_set_depth(Player, true);
	
	// Play animation
	animation_play(sprite_index, 2, 8);
	
	// Destroy if player is airborne
	if image_index == 10
	{
		instance_destroy();
	}