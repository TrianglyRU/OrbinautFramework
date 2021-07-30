// @function animation_play_sync(sprite_id,speed)
function animation_play_sync(sprite_id, speed)
{
	if sprite_index != sprite_id
	{
		sprite_index = sprite_id;
		image_index  = 0;
	}
	image_index = Stage.AnimationTime div speed mod image_number;
}