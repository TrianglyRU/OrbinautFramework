/// @self
/// @description Resets the background music (BGM) based on the state of the specified player or plays the default BGM if no player is provided.
/// @param {Asset.GMSound} default_bgm The default BGM sound asset to be played if no special conditions are met.
/// @param {Id.Instance} [player] The player instance whose state determines which BGM to play (optional, defaults to noone).
function audio_reset_bgm(_default_bgm, _player = noone)
{
	if _player == noone
	{
		audio_play_bgm(_default_bgm);
	}
	else if _player.super_timer > 0
	{
		audio_play_bgm(bgm_super);
	}
	else if _player.item_inv_timer > 0
	{
		audio_play_bgm(bgm_invincibility);
	}
	else if _player.item_speed_timer > 0
	{
		audio_play_bgm(bgm_highspeed);
	}
	else
	{
		audio_play_bgm(_default_bgm);
	}
}
