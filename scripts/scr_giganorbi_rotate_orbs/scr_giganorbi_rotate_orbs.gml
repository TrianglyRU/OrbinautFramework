/// @function scr_giganorbi_rotate_orbs
function scr_giganorbi_rotate_orbs()
{
	gml_pragma("forceinline");
	
	if boss_state == GIGANORBI_STATE.WAIT
	{
		exit;
	}

	orb_siner += 0.025;
	angle = (angle + ANGLE_INCREMENT * orb_spin_speed) % 360;

	var _max_speed = orb_count > 4 ? 0.85 : 1;
	
	if boss_state == GIGANORBI_STATE.PREPARE || boss_state == GIGANORBI_STATE.BOUNCE
	{
		_max_speed *= 2;
	}
	
	orb_spin_speed = clamp(orb_spin_speed + 0.05 * orb_direction, -_max_speed, _max_speed);
	orb_sin_multiplier = lerp(orb_sin_multiplier, boss_state == GIGANORBI_STATE.BOUNCE ? 0 : 12, 0.1);
	
	for (var _i = 0; _i < orb_count; _i++)
	{
		var _orb = orbs[_i];
		
		if _orb != noone
		{
			var _new_angle = angle + angle_step * _i;
			
			_orb.x = math_oscillate_x(x, _new_angle, 64 + (cos(orb_siner) * orb_sin_multiplier));
			_orb.y = math_oscillate_y(y, _new_angle, 48 - (cos(orb_siner) * orb_sin_multiplier));
		}
	}
}