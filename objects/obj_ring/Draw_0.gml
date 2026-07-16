if state != RING_STATE.DROPPED
{
	instance_animate(FRAME_COUNTER, 6);
}

// Inherit the parent event
event_inherited();