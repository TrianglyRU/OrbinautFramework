/// @description Scripts Event
// You can call your scripts in this editor
	
	animation_play(spr_obj_watersplash, 4, 8);
	if animation_get_frame == 8
	{
		instance_destroy();
	}