/// @self
/// @description Performs a dull fade effect.
/// @param {Enum.FADEROUTINE} routine The type of fade action to perform (e.g., fade-in or fade-out).
/// @param {Real} step_duration The duration of the effect update in game steps, affecting both speed and smoothness.
/// @param {Bool} [game_control] Whether to pause game updates during the fade effect (optional, defaults to true).
function fade_perform_dull(_routine, _step_duration, _game_control = true)
{
	var _speed = _step_duration > 0 ? 1 / _step_duration : 0;
	
	fade_perform
	(
		_routine, _routine == FADEROUTINE.IN ? FADETYPE.DULLSYNC : FADETYPE.DULLORDER, _speed, _step_duration, _game_control
	);
}