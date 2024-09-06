// Inherit the parent event
event_inherited();
	
obj_set_priority(0);
ani_start(sprite_index, [6, 8, 8, 8, 8, 8, 8, 0], 0, 6);
audio_play_sfx(sfx_explosion);