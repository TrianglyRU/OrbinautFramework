if state != RING_STATE.DROPPED
{
	instance_animate(obj_game.frame_counter, 6);
}

// Inherit the parent event
event_inherited();