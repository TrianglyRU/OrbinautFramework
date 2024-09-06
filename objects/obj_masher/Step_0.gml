// Act as an enemy and exit if destroyed
if !obj_act_enemy()
{
	exit;
}

y += vel_y;
vel_y += 0.09375;

// Reset velocity and position
if y >= ystart
{
	y = ystart; 
	vel_y = vel_y_default;
}

var _duration = 8;

if y < ystart - 192
{
	// A leftover from S1, it's never triggered in S2 due to a different jump velocity
	_duration = 4;
}
else if vel_y >= 0
{
	_duration = 0;
}

// Update animation frame duration
if ani_get_duration() != _duration
{
	ani_update(0, true, undefined, _duration, undefined);
}
