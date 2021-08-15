function GameFrameworkSetup()
{
	// Dev mode. Enables some debug shortcuts and features, disable it on your game release
	Game.DevMode = true;
	
	/* If devmode is disabed, settings marked with '**' will be overwritten by the
	gameconfig file */
	
	// Default game state (this only applies when we load right into stage/room avoiding main menu)
	Game.Character    =  CharSonic;
	Game.Score	      =  0;
	Game.Lives	      =  3;
	Game.Continues    =  2;
	Game.Emeralds     =  4;
	Game.ActiveSave   = -1;
	Game.CurrentStage = [0, MQZ0];
	
	// Window settings
	Game.WindowFullscreen = false;	/**/
	Game.ResolutionWidth  = 400;	/**/
	Game.ResolutionHeight = 224;	/**/
	Game.WindowSize		  = 4;		/**/
	
	// Audio settings
	Game.MusicVolume = 0.5;			/**/
	Game.SoundVolume = 0.5;			/**/
	
	// Control settings (keyboard)
	Game.KeyboardControl = [vk_up, vk_down, vk_left, vk_right, ord("Z"), ord("X"), ord("C"), vk_space, vk_enter];	/**/
	
	// Originals differences
	Game.SpindashEnabled        = true;  /**/
	Game.DropdashEnabled        = false; /**/
	Game.PeeloutEnabled         = true;  /**/
	Game.GroundSpeedcap	        = false; /**/
	Game.AirSpeedcap	        = false; /**/
	Game.RolljumpControl        = true;
	Game.ExtendedCamera			= false;
	Game.StrongerSlopeGravity   = true;
	Game.LooseCrouch		    = false;
	Game.ConstantRollPhysics    = true;
	Game.SpeedFloorClip	        = true;
	Game.ExtensiveWallCollision	= true;
	Game.BalancingCrouch		= false;
	Game.BuffedWaterBarrier     = false;
	Game.PreciseRings			= false;
	
	// Orbinaut improvements
	Game.PostProcessing        = false;
	Game.SmoothRotation	       = true;
	Game.RichPresenceSupport   = true;
	Game.NoRollSpeedLimit	   = false;
	Game.FlyingCancel	       = true;
	Game.SuperCancel		   = false;
}