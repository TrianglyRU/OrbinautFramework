/// @function scr_player_hammerdash
function scr_player_hammerdash()
{
	gml_pragma("forceinline");
	
	if action != ACTION_HAMMERDASH
	{
		exit;
	}

	// Check conditions to exit action
	if spd_ground == 0 && hammerdash_timer > 0 || ++hammerdash_timer == 60 || !input_down.action_any || dcos(angle) <= 0 || set_push_anim_by != noone
	{
		action = ACTION_NONE;
		exit;
	}

	// Flip facing direction based on input
	if input_press.left && facing == DIRECTION.POSITIVE || input_press.right && facing == DIRECTION.NEGATIVE
	{
		facing *= -1;
	}

	// Update velocity if grounded
	if is_grounded
	{
		spd_ground = 6 * facing;
		m_player_set_velocity_from_speed();
	}
}