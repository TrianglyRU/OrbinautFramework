// @function animation_play_sync(ind,speed)
function animation_play_sync(ind,speed)
{	
	// Update sprite
	if sprite_index != ind
	{
		sprite_index = ind;
		image_index  = 0;
	}
	
	// Play animation
	image_index = Stage.AnimationTime div speed mod image_number;
}