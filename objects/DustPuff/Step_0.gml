/// @description Scripts Event
// You can call your scripts in this editor

	animation_play(sprite_index, 4, 5);
	if animation_get_frame(id) == 5
	{
		instance_destroy();
	}