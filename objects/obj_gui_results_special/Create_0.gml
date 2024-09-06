#macro SS_RESULTS_STATE_LOAD -1
#macro SS_RESULTS_STATE_MOVE 0
#macro SS_RESULTS_STATE_TALLY 1
#macro SS_RESULTS_STATE_WAIT_EXIT 2
#macro SS_RESULTS_STATE_EXIT 3
#macro SS_RESULTS_STATE_SUPERMSG 4

// Allow only one instance of this object at a time
if instance_number(object_index) > 1
{
	instance_destroy();
	exit;
}

audio_play_bgm(bgm_actclear);

offset_line1 = -288;
offset_line2 = 288;
offset_score = 528;	
offset_rings = 544;
speed_x = 16;
state = SS_RESULTS_STATE_LOAD;
state_timer = 20;
message_super = false;
ring_bonus = 50;
total_score = 0;