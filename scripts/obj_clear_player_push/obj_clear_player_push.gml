/// @self c_object
/// @description Clears the flag that forces a push animation on the specified player object, reverting to the default move animation.
/// @param {Id.Instance} player The player object instance.
function obj_clear_player_push(_player)
{
	if _player.set_push_anim_by == id
	{
		if _player.animation != ANI_SPIN && _player.animation != ANI_SPINDASH
		{
			_player.animation = ANI_MOVE;
		}
	
		_player.set_push_anim_by = noone;
	}
}