function GameFrameworkSetup()
{
	// Dev mode. Enables some debug shortcuts and features, disable it on your game release
	Game.DevMode = true;
	
	/* If devmode is disabed, settings marked with '**' will be overwritten by the
	gameconfig file */
	
	// Default game state (this only applies when we load right into stage/room avoiding main menu)
	Game.Character    =  CharSonic;
	Game.Score	      =  0;
	Game.Lives	      =  1;
	Game.Continues    =  2;
	Game.Emeralds     =  0;
	Game.ActiveSave   = -1;
	Game.CurrentStage = [0, DevMenu];
	
	// Window settings
	Game.WindowFullscreen = false;	/**/
	Game.ResolutionWidth  = 400;	/**/
	Game.ResolutionHeight = 224;	/**/
	Game.WindowSize		  = 4;		/**/
	
	// Audio settings
	Game.MusicVolume = 0;			/**/
	Game.SoundVolume = 0.5;			/**/
	
	// Control settings (keyboard)
	Game.KeyboardControl = [vk_up, vk_down, vk_left, vk_right, ord("Z"), ord("X"), ord("C"), vk_space, vk_enter];	/**/
	
	// Originals differences
	Game.SpindashEnabled        = true;  // Enables S2 Spindash			/**/
	Game.DropdashEnabled        = false; // Enables Mania Dropdash		/**/
	Game.PeeloutEnabled         = true;  // Enables SCD Super Peel Out	/**/
	Game.GroundSpeedcap	        = false; // Enables ground speedcap	    /**/
	Game.AirSpeedcap	        = false; // Enables air speedcap        /**/
	Game.RolljumpControl        = false; // Unlocks directional contorls if you jump after rolling
	Game.ExtendedCamera			= false; // Enables camera to shift to the side of your direction movement
	Game.StrongerSlopeGravity   = true;  // In S3 slope gravity and slope detach method were re-written to work better. True - Sonic 3+ method.
	Game.LooseCrouch		    = false; // In S&K, you can start crouching when you are moving slowly. True - SK method.
	Game.ConstantRollPhysics    = true;  // In SK, rolling physics are the same for everyone. True - SK method
	Game.SpeedFloorClip	        = true;  // In S2 and later, the max distance you're allowed to clip to a floor is based on your speed. True = S2+ method
	Game.ExtensiveWallCollision	= true;  // In SK, you can collide with the walls on cardinal angles as well (90, 180, 270) instead of just in angle range of 270->360->90
	Game.BalancingCrouch		= false; // In S3 and later you're allowed to crouch when balancing. True = S3+ method
	Game.BuffedWaterBarrier     = false; // In Sonic Mania, water barrier halves your xsp instead of setting it to 0
	Game.PreciseRings			= false; // In Sonic Mania, shattered rings behaviour was updated
	
	// Orbinaut improvements
	Game.PostProcessing        = false; // Enable post-processing shader
	Game.SmoothRotation	       = true;  // Use smooth rotation
	Game.RichPresenceSupport   = false; // Enable Rich Presence
	Game.NoRollSpeedLimit	   = false; // Disables xsp limit when rolling. May cause collision glitches on higher speeds
	Game.FlyingCancel	       = true;  // Allows you to cancel flying as Tails
	Game.SuperCancel		   = false; // Allows you to cancel super form
}