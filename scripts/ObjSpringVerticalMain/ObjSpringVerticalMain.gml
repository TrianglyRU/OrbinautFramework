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
			// Stop player's actions
			Player.GlideState  = false;
			Player.ClimbState  = false;
			Player.FlightState = false;
			Player.Jumping     = false;
			Player.Rolling     = false;
			Player.DropdashRev = -1;
			
			// Go airborne
			Player.Grounded = false;
			Player.OnObject = false;
		
			// Set 'spring up' or 'walk' animation
			Player.Animation = LaunchSide == SideTop ? AnimSpring : AnimWalk;
			
			// Reset visual angle
			Player.VisualAngle = 360;

			// Launch upwards or downwards
			Player.Ysp = -LaunchForce * image_yscale;
		
			// Use normal collision radiuses
			Player.RadiusX = Player.DefaultRadiusX;
			Player.RadiusY = Player.DefaultRadiusY;
		
			// Stop player sounds
			audio_sfx_stop(sfxFlying);
			audio_sfx_stop(sfxTired);
			
			// Play spring sound
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