// Run a unique animation routine
if State != RING_STATE_DROP
{
	ani_run_by_timer(c_framework.frame_counter, 6);
}
	
// Inherit the parent event
event_inherited();