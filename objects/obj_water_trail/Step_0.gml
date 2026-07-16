if !instance_exists(player) || !player.run_on_water
{
	audio_stop_sound(snd_water_trail);
	instance_destroy();
}
else if (FRAME_COUNTER + 3) % 16 == 0
{
	audio_sfx_play(snd_water_trail);
}