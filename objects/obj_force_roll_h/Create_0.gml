// Inherit the parent event
event_inherited();

// Don't cull if there's more than one player
if PLAYER_COUNT < 2
{
	event_culler(CULL_ACTION.PAUSE);
}

depth = RENDER_DEPTH_PRIORITY;