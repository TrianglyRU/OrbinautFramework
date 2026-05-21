if !instance_exists(player) || !player.is_underwater
{
    instance_destroy();
    return;
}

if global.player_shields[player.player_index] == SHIELD.BUBBLE
{
	return;
}

var _player_state = player.state;

if _player_state == PLAYER_STATE.HURT || _player_state == PLAYER_STATE.DEBUG_MODE
{
	return;
}

var _player_facing = player.facing;
var _spawn_direction = player.is_forced_roll ? 1 : _player_facing;
var _x = player.x + 6 * _player_facing;
var _y = player.y;
var _air_timer = player.air_timer;

if _air_timer > 0
{
    if _air_timer <= 720 && _air_timer % 120 == 0
    {
		if _air_timer == 720
		{
			countdown_bubble_frame = 0;
		}
		
        spawn_countdown_bubble = true;
    }

    if next_bubble_timer >= 0
    {
        next_bubble_timer--;
    }
	
    if _air_timer % 60 == 0 || next_bubble_timer == 0
    {
        // Schedule a follow-up bubble with a 50% chance
        if next_bubble_timer < 0 && irandom(1) > 0
        {
            next_bubble_timer = irandom_range(1, 16);
        }

        var _type = BUBBLE.SMALL;
		
        // Assign the countdown bubble a 25% chance to replace the main bubble
        if spawn_countdown_bubble && (next_bubble_timer <= 0 || irandom(3) == 0)
        {
            _type = BUBBLE.COUNTDOWN;
        }
		
        with instance_create(_x, _y, obj_bubble, { bubble_type: _type })
		{
			wobble_direction = _spawn_direction;
			countdown_frame = other.countdown_bubble_frame;
		}
		
        if _type == BUBBLE.COUNTDOWN
        {
            countdown_bubble_frame++;
            spawn_countdown_bubble = false;
        }
    }
}

// Drowning
else if bubbles_spawned_no_air < 12
{
    if next_bubble_timer_no_air > 0
    {
        next_bubble_timer_no_air--;
    }
	else
	{
		var _type = irandom(3) > 0 ? BUBBLE.SMALL : BUBBLE.MEDIUM;
		
	    with instance_create(_x, _y - 12, obj_bubble, { bubble_type: _type })
		{
			depth = RENDER_DEPTH_PRIORITY - 1;
			wobble_direction = _spawn_direction;
		}
		
	    bubbles_spawned_no_air++;
	    next_bubble_timer_no_air = irandom_range(0, 7);
	}
}