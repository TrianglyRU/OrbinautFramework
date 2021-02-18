function GameFrameworkSetup()
{
	// Game state
	Game.GlobalCharacter = CharSonic;
	Game.SavedCheckpoint = 0;
	Game.SavedScore		 = 0;
	Game.SavedLives		 = 3;
	Game.GamePaused		 = false;
	
	// Window settings
	Game.WindowFullscreen = false;
	Game.ResolutionWidth  = 398;
	Game.ResolutionHeight = 224;
	Game.WindowSize		  = 2;
	
	// Audio settings
	Game.MusicVolume = 0.5;
	Game.SoundVolume = 0.5;
	
	// Engine customization
	Game.SpindashEnabled		 = true;	// S2 Spindash
	Game.PeeloutEnabled          = true;	// SCD Super Peel Out
	Game.DropdashEnabled		 = false;	// Dropdash
	Game.GroundSpeedcap			 = false;	// S1-like ground speedcap
	Game.AirSpeedcap			 = false;	// Pre S3-like air speedcap
	Game.StrongerSlopeGravity	 = false;	// In Sonic 3+, you always affected by slope gravity on non-shallow floors. True - Sonic 3+ method.
	Game.ConsiderAngleDifference = true;    // In Sonic 2+, your angle will be resetted to your cardinal angle if the angle difference is higher than 45. True - Sonic 2+ method
	Game.LooseCrouch			 = false;	// In SK, you can start crouching when you are moving slowly. True - SK method.
	Game.RolljumpControl		 = false;	// In every game but CD your controls are locked if you jump after rolling
	Game.StrongerSlopeDetach     = false;   // Before S3 you were able to slide down on 45-degree floors. True - Sonic 3 method
	Game.SpeedFloorClip			 = true;    // In S2+, the max distance you're allowed to clip to a floor is based on your speed (instead of static 14 in S1). True = S2+ method
	Game.ExtensiveWallCollision	 = true;	// In SK, you can collide with the walls on cardinal angles as well (90, 180, 270) instead of just in angle range of 270->360->90
	Game.ImprovedObjCollision	 = true;    // In original games collision with objects is pretty wacky. If set to true, Orbinaut will apply its fixes to collision
	Game.ExtendedCamera			 = false;	// In SCD, the camera will shift forward to the direction you're running
	Game.SmoothPaletteCycle		 = false;	// Apply interpolation to palette cycles
	Game.SmoothRotation			 = false;	// Use Mania-like smooth rotation
	Game.OriginalRollLimit		 = true;
	Game.RichPresenceSupport	 = true;	// Enable Rich Presence
	Game.AllowUnroll			 = true;    // Allows you to unroll with UP button when rolling. Good for more complex momentum gaining!
		
	// Default palette status
	Game.FadeEnabled = true;
	Game.PaletteSet	 = 0;
	Game.PalIndex[0] = 0;
	
	// Keyboard control mappings
	Game.Control = [vk_up, vk_down, vk_left, vk_right, ord("A"), ord("S"), ord("D"), vk_space, vk_enter];
}