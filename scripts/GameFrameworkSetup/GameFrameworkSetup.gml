function GameFrameworkSetup()
{
	// Game settins
	Game.DevMode    = true;
	Game.ShowSplash = false;
	
	// Default game state (this only applies when we load right into stage/room avoiding main menu)
	Game.Character  = CharSonic;
	Game.Score	    = 0;
	Game.Lives	    = 3;
	Game.Continues  = 2;
	Game.Emeralds   = 0;
	Game.ActiveSave = -1;
	
	// Originals differences
	Game.SpindashEnabled    = true;
	Game.DropdashEnabled    = false;
	Game.PeeloutEnabled		= false;
	Game.GroundSpeedcap	    = false;
	Game.AirSpeedcap	    = false;
	Game.CDCamera			= false;
	Game.RolljumpControl    = false;
	Game.S3SlopePhysics		= false;
	Game.SKCrouch			= false;
	Game.SKRollDeceleration	= false;
	Game.S2FloorCollision	= true;
	Game.SKWallCollision	= true;
	
	Game.SKItemBoxBehaviour = true;
	Game.CDStageTimer	    = true;
	
	// Orbinaut improvements
	Game.CustomSlopeCollision = true;
	Game.SmoothRotation	      = true;
	Game.RichPresenceSupport  = true;
	Game.PreciseRingBehaviour = false;
	Game.NoRollSpeedLimit	  = false;
	Game.FlightCancel	      = false;
	
	/* Everything below is overwritten by game settings if
	Developer Mode is disabled! */
	
	// Video settings
	Game.WindowFullscreen = false;
	Game.Width            = 400;
	Game.Height			  = 224;
	Game.WindowSize	      = 4;
	
	// Audio settings
	Game.MusicVolume = 0.5;
	Game.SoundVolume = 0.5;
	
	// Control settings (keyboard)
	Game.KeyboardControl = [vk_up, vk_down, vk_left, vk_right, ord("Z"), ord("X"), ord("C"), vk_space, vk_enter];
}