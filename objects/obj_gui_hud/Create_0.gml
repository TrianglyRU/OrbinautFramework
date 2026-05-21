// Inherit the parent event
event_inherited();

update_string = function()
{
	var _min = 9;
	var _sec = 59;
	var _msc = 59;

	if local_timer < 35999
	{
		_min = floor(local_timer / 3600);
		_sec = floor((local_timer - _min * 3600) / 60);
		_msc = floor(local_timer % 60 / 3 * 5);
	}

	if !global.cd_timer
	{
		timer_string = string(_min) + ":" + ((_sec > 9) ? "" : "0") + string(_sec);
	}
	else
	{
		timer_string = string(_min) + "'" + ((_sec > 9) ? "" : "0") + string(_sec) + ";" + ((_msc > 9) ? "" : "0") + string(_msc);
	}
}

depth = RENDER_DEPTH_HUD;
max_allowed_game_state = GAME_STATE.STOP_OBJECTS;
timer_string = "";
dynamic_frame = 0;
score_offset = 0;
time_offset  = 0;
rings_offset = 0;
lives_offset = 0;
local_timer = 0;
update_timer = true;

// Update timer string
update_string();