/// @description Startup
// You can write your code in this editor
	
	// Set object properties
	object_set_depth(Player, 1);
	animation_play(sprite_index, 4, 7);
	
	// Play sound
	if object_is_onscreen(self)
	{
		audio_sfx_play(sfxWaterSplash, false);
	}