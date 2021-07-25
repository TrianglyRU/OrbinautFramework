function ObjSpringDiagonalMain()
{
	// Is current frame different from 1?
	if animation_get_frame(id) > 1
	{
		// Play animation
		animation_play(sprite_index, 3, 1);
	}
	else
	{
		if (floor(Player.PosX + 4 * image_xscale) - x) * image_xscale >= 0 and object_player_touch(LaunchSide)
		{
			// Reset flags
			Player.Grounded      = false;
			Player.OnObject      = false;
			Player.Jumping       = false;
			Player.FlyingState   = false;
			Player.GlidingState  = false;
			Player.ClimbingState = false;
			Player.DropdashRev   = -1;
		
			// Set 'spring up' or 'walk' animation
			Player.Animation = LaunchSide == SideTop ? AnimSpring : AnimWalk;
			
			// Reset visual angle
			Player.VisualAngle = 360;
		
			// Launch upwards or downwards
			Player.Ysp = -LaunchForce * image_yscale;
			Player.Xsp =  LaunchForce * image_xscale;
		
			// Use normal collision radiuses
			Player.xRadius = Player.xRadiusDefault;
			Player.yRadius = Player.yRadiusDefault;

			// Stop player sounds
			audio_sfx_stop(sfxFlying);
			audio_sfx_stop(sfxTired);
			
			// Play spring sound
			audio_sfx_play(sfxSpring, false)	
		
			// Start animation
			animation_set_frame(sprite_index, 2);
		}
		else
		{
			// Act solid
			object_act_solid(true, true, true, CollisionMap);
		}
	}
}