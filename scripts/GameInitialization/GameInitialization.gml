function GameInitialization()
{
	// Ggame state
	Game.GlobalCharacter		= 0;
	Game.SavedCheckpoint        = 0;
	Game.SavedScore				= 0;
	Game.SavedLives				= 3;
	Game.GamePaused				= false;
	
	// Window settings
	Game.WindowFullscreen		= false;
	Game.ResolutionWidth		= 398;
	Game.ResolutionHeight		= 224;
	Game.WindowSize				= 2;
	
	// Audio settings
	Game.MusicVolume			= 5;
	Game.SoundVolume			= 5;
	
	// Engine customization
	Game.TileCollisionMethod    = false;
	Game.SpindashEnabled		= true;		// S2 Spindash
	Game.PeeloutEnabled         = false;	// SCD Super Peel Out
	Game.GroundSpeedcap			= false;	// S1-like ground speedcap
	Game.AirSpeedcap			= false;	// Pre S3-like air speedcap
	Game.StrongerSlopeGravity	= false;	// In Sonic 3+, you always affected by slope gravity on non-shallow floors. True - Sonic 3+ method.
	Game.CardinalSlopeAngle		= true;	    // In Sonic 2+, your angle will be resetted to your cardinal angle if the angle difference is higher than 45. True - Sonic 2+ method
	Game.LooseCrouch			= false;	// In SK, you can start crouching when you are moving slowly. True - SK method.
	Game.RolljumpControl		= false;	// In every game but CD your controls are locked if you jump after rolling
	Game.StrongerSlopeDetach    = false;    // Before S3 you were able to slide down on 45-degree floors. True - Sonic 3 method
	Game.SpeedFloorClip		    = false;    // In S2+, the max distance you're allowed to clip to a floor is based on your speed (instead of static 14 in S1). True = S2+ method
	
	Game.ExtendedCamera			= false;
	Game.SmoothPaletteCycle		= false;
	Game.SmoothRotation			= true;
	Game.RichPresenceSupport    = true;
	
	// Default palette status
	Game.FadeEnabled			= true;
	Game.PaletteSet				= 0;
	Game.PalIndex[0]			= 0;
	
	// Temporary value array. Can be used for various things
	Game.TempValue[0]			= 0;
}