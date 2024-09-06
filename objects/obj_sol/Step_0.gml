// Act as an enemy and exit if destroyed
if !obj_act_enemy()
{
	exit;
}

var _player = player_get(0);

if state == SOL_STATE_ROAM
{
	var _dist_x = floor(_player.x) - floor(x);
	var _dist_y = floor(_player.y) - floor(y);
	
	// Check if the player is within range and not controlled
	if abs(_dist_x) < 160 && abs(_dist_y) < 80 && _player.state < PLAYER_STATE_NO_CONTROL
	{
		state = SOL_STATE_SHOOT;
	}
}

x -= 0.25 * image_xscale;
angle = (angle - ANGLE_INCREMENT * image_xscale) % 360;

for (var i = 0; i < fireball_count; i++)
{
	var _fireball = fireballs[i];
	if _fireball == noone
	{
		continue;
	}
	
	// If the fireball is attached to us, run its hurt routine from here to make sure it
	// happens after Sol checks for collision with the player
	_fireball.m_sol_fireball_hurt();
	
	var _new_angle = angle + angle_step * i;
	
	// Calculate new position for the fireball
	_fireball.x = obj_oscillate_x(x, _new_angle, 16, 1, 0);
	_fireball.y = obj_oscillate_y(y, _new_angle, 16, 1, 0);
	
	if state != SOL_STATE_SHOOT || _new_angle != 0
	{
		continue;
	}
	
	// Throw the fireball
	_fireball.data_culling.parent_object = noone;
	_fireball.vel_x = -2 * image_xscale; 
	
	with _fireball
	{
		obj_set_culling(CULLING.REMOVE);
	}
	
	fireballs[i] = noone;
}
