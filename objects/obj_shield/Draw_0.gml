if player.super_timer <= 0 && player.item_inv_timer == 0 && player.state != PLAYER_STATE.DEATH
{
	// Inherit the parent event
	event_inherited();
}