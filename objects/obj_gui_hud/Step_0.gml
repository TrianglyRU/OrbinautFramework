// Update local timer
if update_timer
{
	local_timer = c_framework.frame_counter;
}

// Calculate dynamic frame
dynamic_frame = floor((c_framework.frame_counter - 1) / 8) % 2;

// Initialise time variables
var _min = 9;
var _sec = 59;
var _msc = 59;

// Calculate timer values
if local_timer < 35999
{
	_min = floor(local_timer / 3600);
	_sec = floor((local_timer - _min * 3600) / 60);
	_msc = floor(local_timer % 60 / 3 * 5);
}

// Format timer string
if !global.cd_timer
{
	timer_string = string(_min) + ":" + ((_sec > 9) ? "" : "0") + string(_sec);
}
else
{
	timer_string = string(_min) + "'" + ((_sec > 9) ? "" : "0") + string(_sec) + ";" + ((_msc > 9) ? "" : "0") + string(_msc);
}