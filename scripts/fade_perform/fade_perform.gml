/// @self
/// @description Configures and triggers a screen fade effect. If unsure, use the pre-сonfigured functions.
/// @param {Enum.FADEROUTINE} routine The type of fade action to perform (e.g., fade-in or fade-out).
/// @param {Enum.FADETYPE} type The colour blending type used during the fade effect.
/// @param {Real} speed The speed at which the fade effect occurs.
/// @param {Real} [freq] The number of game steps between each update of the effect, affecting the smoothness of the transition (optional, defaults to 1).
/// @param {Bool} [game_control] Whether to pause game updates during the fade effect or not (optional, defaults to true).
function fade_perform(_routine, _type, _speed, _freq = 1, _game_control = true)
{
	if _speed != 0
	{
		_speed = clamp(_speed * _freq * ENGINE_FADE_TIMER_STEP, 0, ENGINE_FADE_TIMER_MAX);
	}

	var _fade = c_framework.fade;

	// Modify speed for specific fade types
	if _type == FADETYPE.DULLORDER || _type == FADETYPE.DULLSYNC || _type == FADETYPE.FLASHORDER || _type == FADETYPE.FLASHSYNC
	{
		_speed *= 3;
	}
	
	// Initialise fade parameters
	_fade.frequency_timer = 0;
	_fade.frequency_target = _freq;
	_fade.blend_type = _type;
	_fade.timer_step = _speed;
	_fade.routine = _routine;
	_fade.game_control = _game_control;

	// Determine fade state and timer based on routine and speed
	if _fade.timer_step != 0
	{
		_fade.timer = _routine == FADEROUTINE.IN ? 0 : ENGINE_FADE_TIMER_MAX;
		_fade.state = _routine == FADEROUTINE.IN ? FADESTATE.PLAINCOLOUR : FADESTATE.NONE;
		_fade.process_flag = ENGINE_FADE_FLAG_UPDATE;
	}
	else
	{
		_fade.timer = _routine == FADEROUTINE.IN ? ENGINE_FADE_TIMER_MAX : 0;
		_fade.state = _routine == FADEROUTINE.IN ? FADESTATE.NONE : FADESTATE.PLAINCOLOUR;
		_fade.process_flag = ENGINE_FADE_FLAG_IDLE;

		// Control game state based on fade routine
		if _game_control
		{
			c_framework.state = _routine == FADEROUTINE.IN ? STATE_NORMAL : STATE_PAUSED;
		}
	}
}