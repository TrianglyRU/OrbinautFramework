/// @function scr_giganorbi_rotate_orbs
function scr_giganorbi_rotate_orbs()
{
	gml_pragma("forceinline");
	
	if boss_state == BOSS_GIGAN_STATE_WAIT
	{
		exit;
	}

	// Update orb oscillation parameters
	orb_siner += 0.025;
	angle = (angle + ANGLE_INCREMENT * orb_spin_speed) % 360;

	var _max_speed = orb_count > 4 ? 0.85 : 1;
	
	if boss_state == BOSS_GIGAN_STATE_PREPARE || boss_state == BOSS_GIGAN_STATE_BOUNCE
	{
		_max_speed *= 2;
	}
	
	orb_spin_speed = clamp(orb_spin_speed + 0.05 * orb_direction, -_max_speed, _max_speed);
	orb_sin_multiplier = lerp(orb_sin_multiplier, boss_state == BOSS_GIGAN_STATE_BOUNCE ? 0 : 12, 0.1);
	
	// Update each orb's position based on oscillation
	for (var i = 0; i < orb_count; i++)
	{
		var _orb = orbs[i];
		
		if _orb == noone
		{
			continue;
		}

		var _new_angle = angle + angle_step * i;
		_orb.x = obj_oscillate_x(x, _new_angle, 64 + (cos(orb_siner) * orb_sin_multiplier));
		_orb.y = obj_oscillate_y(y, _new_angle, 48 - (cos(orb_siner) * orb_sin_multiplier));
	}
}