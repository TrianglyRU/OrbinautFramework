if state != STARPOST_STATE_IDLE
{
	exit;
}

var _checkpoint_data = global.checkpoint_data;

// Activate the starpost if a more recent activated checkpoint exists
if array_length(_checkpoint_data) > 0 && _checkpoint_data[7] >= ID
{
	state = STARPOST_STATE_ACTIVE;
	lamp_obj.m_starpost_lamp_activate();
	exit;
}

var _player = player_get(0);

if _player.state >= PLAYER_STATE_NO_CONTROL
{
	exit;
}

// Check if the player is within Star Post bounds
var _dist_x = _player.x - x + 8;
var _dist_y = _player.y - y + 64;

if _dist_x < 0 || _dist_x >= 16 || _dist_y < 0 || _dist_y >= 104
{
	exit;
}

global.checkpoint_data =
[
	x, y + 24, c_framework.frame_counter, c_stage.bound_top[0], c_stage.bound_bottom[0], c_stage.bound_left[0], c_stage.bound_right[0], ID
];

state = STARPOST_STATE_ACTIVE;
lamp_obj.state = LAMP_STATE_ROTATE;

audio_play_sfx(sfx_starpost);

// Spawn Bonus Stage stars if the player has 20 or more rings
if global.player_rings >= 20
{
	for (var i = 0; i < 4; i++)
	{
		instance_create(x, y - 50, obj_starpost_star, { StarID: i, ParentStarPost: id });
	}
}