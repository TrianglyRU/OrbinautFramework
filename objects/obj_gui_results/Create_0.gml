#macro RESULTS_STATE_LOAD -1
#macro RESULTS_STATE_MOVE 0
#macro RESULTS_STATE_TALLY 1
#macro RESULTS_STATE_WAIT_EXIT 2
#macro RESULTS_STATE_EXIT 3

// Allow only one instance of this object at time
if instance_number(object_index) > 1
{
	instance_destroy();
	exit;
}

audio_play_bgm(bgm_actclear);

offset_line1 = -256;
offset_line2 = 256;
offset_time = 512;
offset_rings = 528;
offset_perfect = 544;
offset_total = 560;
speed_x = 16;
player_object = player_get(0);
player_object_type = player_object.PlayerType;
state = RESULTS_STATE_LOAD;
state_timer = 40;
total_bonus = 0;
ring_bonus = global.player_rings * 100;
c_framework.allow_pause = false;

var _stage_time = obj_gui_hud.local_timer;

if _stage_time < 1800	
{
	time_bonus = 50000;		// < 0:30
}
else if _stage_time < 2700
{
	time_bonus = 10000;		// < 0:45
}
else if _stage_time < 3600
{
	time_bonus = 5000;		// < 1:00
}
else if _stage_time < 5400
{
	time_bonus = 4000;		// < 1:30
}
else if _stage_time < 7200
{
	time_bonus = 3000;		// < 2:00
}
else if _stage_time < 10800
{
	time_bonus = 2000;		// < 3:00
}
else if _stage_time < 14400
{
	time_bonus = 1000;		// < 4:00
}
else if _stage_time < 18000
{
	time_bonus = 500;		// < 5:00
}
else
{
	time_bonus = 0;
}