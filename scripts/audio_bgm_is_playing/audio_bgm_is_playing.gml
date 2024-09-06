/// @self
/// @description Checks if BGM is playing on the specified channel.
/// @param {Real} [channel_id] The index of the channel (optional, defaults to 0).
/// @returns {Bool}
function audio_bgm_is_playing(_channel_index = 0)
{
	return c_framework.audio.current_bgm[_channel_index] != -1
}
