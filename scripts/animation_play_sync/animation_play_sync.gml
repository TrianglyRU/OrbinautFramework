// @function animation_play_sync(ind,speed)
function animation_play_sync(ind,speed)
{	
	// Exit if object is off-screen
	if !object_is_onscreen(id)
	{
		exit;
	}
	
	// Update sprite
	if sprite_index != ind
	{
		sprite_index = ind;
		image_index  = 0;
	}
	
	// Play animation
	image_index = Game.GlobalTime div speed mod image_number;
}