// @function animation_play_sync(sprite_id,speed)
function animation_play_sync(sprite_id, speed)
{
	sprite_index = sprite_id;
	image_index  = Stage.AnimationTime div speed mod image_number;
}