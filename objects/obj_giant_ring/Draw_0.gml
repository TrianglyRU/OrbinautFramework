// Run a unique animation routine
if state == GIANTRING_STATE_IDLE
{
	ani_run_by_timer(c_framework.frame_counter, 6);
}
	
// Inherit the parent event
event_inherited();