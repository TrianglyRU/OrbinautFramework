if !instance_exists(TargetPlayer) || !TargetPlayer.is_underwater
{
    instance_destroy();
    exit;
}

if TargetPlayer.state == PLAYER_STATE_HURT || TargetPlayer.state == PLAYER_STATE_DEBUG_MODE || TargetPlayer.shield == SHIELD_BUBBLE
{
	exit;
}

var _x = TargetPlayer.x + 6 * TargetPlayer.facing;
var _y = TargetPlayer.y;

var _spawn_direction = TargetPlayer.forced_roll ? DIRECTION.POSITIVE : TargetPlayer.facing;
var _air_timer = TargetPlayer.air_timer;

// Handle bubble spawning based on the player's air timer
if _air_timer > 0
{
    if _air_timer <= 720 && _air_timer % 120 == 0
    {	
		if _air_timer == 720
		{
			// Reset the frame index if starting to drown
			countdown_bubble_frame = 0;
		}
		
        spawn_countdown_bubble = true;
    }

    if next_bubble_timer >= 0
    {
        next_bubble_timer--;
    }

    // Generate bubbles at specific intervals or when the timer reaches zero
    if _air_timer % 60 == 0 || next_bubble_timer == 0
    {
        // Schedule a follow-up bubble with a 50% chance
        if next_bubble_timer < 0 && irandom(1) > 0
        {
            next_bubble_timer = irandom_range(1, 16);
        }

        var _type = BUBBLE_TYPE_SMALL;

        // Assign the countdown bubble a 25% chance to replace the main bubble
        if spawn_countdown_bubble && (next_bubble_timer <= 0 || irandom(3) == 0)
        {
            _type = BUBBLE_TYPE_COUNTDOWN;
        }
		
        instance_create(_x, _y, obj_bubble, 
        {
            BubbleType: _type, WobbleDirection: _spawn_direction, CountdownFrame: countdown_bubble_frame
        });

        if _type == BUBBLE_TYPE_COUNTDOWN
        {
            countdown_bubble_frame++;
            spawn_countdown_bubble = false;
        }
    }
}

// Handle bubble spawning when the player is out of air
else if bubbles_spawned_no_air < 12
{
    if next_bubble_timer_no_air > 0
    {
        next_bubble_timer_no_air--;
        exit;
    }

    var _type = irandom(3) > 0 ? BUBBLE_TYPE_SMALL : BUBBLE_TYPE_MEDIUM;
	
    instance_create(_x, _y - 12, obj_bubble,
    {
        BubbleType: _type, WobbleDirection: _spawn_direction, depth: RENDERER_DEPTH_HIGHEST - 1
    });
	
    bubbles_spawned_no_air++;
    next_bubble_timer_no_air = irandom_range(0, 7);
}