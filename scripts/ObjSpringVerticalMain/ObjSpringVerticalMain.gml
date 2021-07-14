function ObjSpringVerticalMain()
{
	// Is current frame different from 1?
	if animation_get_frame(id) > 1
	{
		// Play animation
		animation_play(sprite_index, 3, 1);
	}
	else 
	{
		// Is player touching launch side?
		if object_player_touch(LaunchSide)
		{
			// Reset flags
			Player.Grounded      = false;
			Player.OnObject      = false;
			Player.Jumping       = false;
			Player.Rolling		 = false;
			Player.FlyingState   = false;
			Player.GlidingState  = false;
			Player.ClimbingState = false;
			Player.DropdashRev   = -1;
			Player.Inertia		 = 0;
		
			// Set 'spring up' or 'walk' animation
			Player.Animation = LaunchSide == SideTop ? AnimSpring : AnimWalk;

			// Launch upwards or downwards
			Player.Ysp = -LaunchForce * image_yscale;
		
			// Use normal collision radiuses
			Player.xRadius = Player.xRadiusDefault;
			Player.yRadius = Player.yRadiusDefault;
		
			// Play sound
			audio_sfx_play(sfxSpring, false);	
		
			// Start animation
			animation_set_frame(sprite_index, 2);
		}
		else
		{
			// Do collision
			object_act_solid(true, true, true, false);
		}
	}	
}