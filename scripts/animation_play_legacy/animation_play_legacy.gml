/// @function animation_play_legacy(sprite_id, duration, loop)
function animation_play_legacy(sprite_id, duration, loop)
{
	// Ignore the animation method built into the IDE
	sprite_set_speed(sprite_id, 0, spritespeed_framespergameframe);
	
	// Update sprite
	if !variable_instance_exists(id, "sprite_frame") or sprite_index != sprite_id
	{
		//Obj_AnimTimer = duration;
		sprite_index = sprite_id;
		sprite_frame = 0;
	}
	
	image_index = sprite_frame;
	
	var AnimationSpeed = 1 / duration;
	
	if floor(sprite_frame) <= image_number
	{
		sprite_frame += AnimationSpeed;
	}
	else
	{
		sprite_frame = loop;
	}
}