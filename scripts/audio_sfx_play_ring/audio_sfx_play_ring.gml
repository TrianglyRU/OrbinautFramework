/// @self
/// @description Plays alternating ring sound effect.
function audio_sfx_play_ring()
{
	if global.ring_sound_counter++ % 2 == 0
	{
		audio_sfx_play(snd_ring_right);
	}
	else
	{
		audio_sfx_play(snd_ring_left);
	}
}