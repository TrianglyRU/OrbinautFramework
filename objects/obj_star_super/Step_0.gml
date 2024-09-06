var _last_frame = 5;

if !instance_exists(TargetPlayer) || TargetPlayer.super_timer <= 0
{
	if ani_get_frame() == _last_frame 
	{
		instance_destroy();
	}
	
	exit;
}

// Check if the player is not in a dash action and is at or above top speed
if TargetPlayer.action != ACTION_DASH && abs(TargetPlayer.spd_ground) >= TargetPlayer.acc_top
{
	if !do_update
	{
		ani_update(0, true, undefined, undefined, 0);
		ani_resume();
		attach_to_player = true;
		do_update = true;
	}
	
	var _frame = ani_get_frame();
	
	if attach_to_player || _frame == 0 && ani_get_frame_change() 
	{
		x = TargetPlayer.x;
		y = TargetPlayer.y;
		
		if attach_to_player && _frame == _last_frame
		{
			attach_to_player = false;
		}
	}
} 
else if do_update
{
	do_update = false;
	ani_update_loopframe(_last_frame);
}