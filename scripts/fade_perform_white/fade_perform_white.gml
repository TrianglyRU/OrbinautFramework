/// @self
/// @description								Triggers a white fade effect.
/// @param {Enum.FADE_DIRECTION} _direction		The "direction" of the fade (e.g., fade-in or fade-out).
/// @param {Real} _step_duration				The time in game steps between updates of the fade effect, affecting both speed and smoothness.
/// @param {Function|Undefined} [_fade_action]	A callback function executed once per game step after the fade completes until it returns true or is forcibly cleared (default is undefined).
/// @param {Enum.GAME_STATE} [_target_state]	Game state to set during the fade (default is GAME_STATE.STOP_ALL).
function fade_perform_white(_direction, _step_duration, _fade_action = undefined, _target_state = GAME_STATE.STOP_ALL)
{
	var _speed = _step_duration > 0 ? (1 / _step_duration) : 0;
	var _type = _direction == FADE_DIRECTION.IN ? FADE_TYPE.WHITE_ORDER : FADE_TYPE.WHITE_SYNC;
	
	fade_perform(_direction, _type, _speed, _step_duration, _fade_action, _target_state);
}