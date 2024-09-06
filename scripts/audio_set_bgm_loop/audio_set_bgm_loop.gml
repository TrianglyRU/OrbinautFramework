/// @self
/// @description Sets the loop points for the specified BGM sound asset.
/// @param {Asset.GMSound} soundid The sound asset for which the loop points are being set.
/// @param {Real} loopstart The start point of the loop, in seconds.
/// @param {Real} loopend The end point of the loop, in seconds.
function audio_set_bgm_loop(_soundid, _loopstart, _loopend)
{
	audio_sound_loop_start(_soundid, _loopstart);
	audio_sound_loop_end(_soundid, _loopend);
	array_push(c_framework.audio.loop_array, _soundid);
}