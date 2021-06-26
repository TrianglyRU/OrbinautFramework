/// @description Scripts Event
// You can call your scripts in this editor
	
	if object_player_touch(SideTop)
	{
		if image_xscale == 1  and floor(Player.PosX + 4) >= floor(x)
		or image_xscale == -1 and floor(Player.PosX - 4) <= floor(x)
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
		
			// Launch upwards or downwards
			Player.Ysp = -LaunchForce * image_yscale;
			Player.Xsp =  LaunchForce * image_xscale;
		
			// Use normal collision radiuses
			Player.xRadius = Player.xRadiusDefault;
			Player.yRadius = Player.yRadiusDefault;

			// Play sound
			audio_sfx_play(sfxSpring, false);	
		
			// Start animation
			animation_set_frame(sprite_index, 2);
		}
	}
	
	// Play spring animation
	if animation_get_frame(id) > 1
	{
		animation_play(sprite_index, 3, 1);
	}
	
	// Act solid
	object_act_solid(true, true, true, CollisionMap);