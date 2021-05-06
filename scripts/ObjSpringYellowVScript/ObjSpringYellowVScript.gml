function ObjSpringYellowVScript()
{
	// Do collision
	object_act_solid(true, true, true, false);
	
	// Define launch side
	var launchSide = image_yscale ? SideTop : SideBottom;
	
	// Check if we're touching launch side
	if object_player_touch(launchSide)
	{
		// Reset flags
		Player.Grounded      = false;
		Player.OnObject      = false;
		Player.Jumping       = false;
		Player.FlyingState   = false;
		Player.GlidingState  = false;
		Player.ClimbingState = false;
		
		// Set 'spring up' or 'walk' animation
		Player.Animation = launchSide == SideTop ? AnimSpringUp : AnimWalk;

		// Launch upwards or downwards
		Player.Ysp = -10 * image_yscale;
		
		// Use normal collision radiuses
		Player.xRadius = Player.xRadiusDefault;
		Player.yRadius = Player.yRadiusDefault;
		
		// Play sound
		audio_sfx_play(sfxSpring, false, true);	
		
		// Start animation
		animation_set_frame(id, 2);
	}	
	
	// Check AI is touching launch side
	if object_player_touch_ai(launchSide)
	{
		// Reset flags
		AI.Grounded      = false;
		AI.OnObject      = false;
		AI.Jumping       = false;
		AI.FlyingState   = false;
		AI.GlidingState  = false;
		AI.ClimbingState = false;
		
		// Set 'spring up' or 'walk' animation
		AI.Animation = launchSide == SideTop ? AnimSpringUp : AnimWalk;

		// Launch upwards or downwards
		AI.Ysp = -10 * image_yscale;
		
		// Use normal collision radiuses
		AI.xRadius = AI.xRadiusDefault;
		AI.yRadius = AI.yRadiusDefault;
		
		// Play sound
		audio_sfx_play(sfxSpring, false, true);	
		
		// Start animation
		animation_set_frame(id, 2);
	}	
	
	// Play spring animation
	if animation_get_frame(id) > 1
	{
		animation_play(sprite_index, 3, 1);
	}
}