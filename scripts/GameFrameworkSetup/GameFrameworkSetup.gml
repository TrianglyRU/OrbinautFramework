function GameFrameworkSetup()
{
	// Game state
	Game.GlobalCharacter = CharSonic;
	Game.GlobalScore	 = 0;
	Game.GlobalLives	 = 3;
	Game.GlobalConts	 = 0;
	Game.GlobalEmeralds  = 0;
	Game.GamePaused		 = false;
	Game.SavedCheckpoint = false;
	Game.SavedPosition   = false;
	
	// Window settings
	Game.WindowFullscreen = false;
	Game.ResolutionWidth  = 398;
	Game.ResolutionHeight = 224;
	Game.WindowSize		  = 2;
	
	// Audio settings
	Game.MusicVolume = 0;
	Game.SoundVolume = 0.3;
	
	// Gameplay
	Game.SpindashEnabled		 = true;	// Enables S2 Spindash
	Game.PeeloutEnabled          = true;	// Enables SCD Super Peel Out
	Game.DropdashEnabled		 = false;	// Enables Mania Dropdash
	Game.GroundSpeedcap			 = false;	// Enables ground speedcap
	Game.AirSpeedcap			 = false;	// Enables air speedcap
	Game.RolljumpControl		 = false;	// Unlocks directional contorls if you jump after rolling
	Game.AllowUnroll			 = true;    // Allows you to unroll with UP button when rolling
	Game.ExtendedCamera			 = false;	// Enables camera to shift to the side of your direction movement
	Game.OriginalRollLimit		 = true;	// Limits inertia instead of x speed when rolling
	Game.FlyingCancel			 = true;    // Allows you to cancel flying as Tails
	
	// Engine
	Game.StrongerSlopeGravity	 = false;	// In Sonic 3+, you always affected by slope gravity on non-shallow floors. True - Sonic 3+ method.
	Game.ConsiderAngleDifference = true;    // In Sonic 2+, your angle will be resetted to your cardinal angle if the angle difference is higher than 45. True - Sonic 2+ method
	Game.LooseCrouch			 = false;	// In SK, you can start crouching even when you are moving slowly. True - SK method.
	Game.ConstantRollFrc		 = true;	// In SK, rolling friction is hard-coded to always be half of regular acceleration, even when Super. True - SK method
	Game.StrongerSlopeDetach     = false;   // Before S3 you were able to slide down on 45-degree floors. True - Sonic 3 method
	Game.SpeedFloorClip			 = false;   // In S2+, the max distance you're allowed to clip to a floor is based on your speed. True = S2+ method
	Game.ExtensiveWallCollision	 = true;	// In SK, you can collide with the walls on cardinal angles as well (90, 180, 270) instead of just in angle range of 270->360->90
	Game.ImprovedObjCollision	 = true;    // In originals, objects are pretty wacky in terms of collision. True - apply Orbinaut's fixes
	Game.SmoothPaletteCycle		 = false;	// Apply interpolation to palette cycles
	Game.SmoothRotation			 = true;	// Use smooth rotation
	Game.RichPresenceSupport	 = true;	// Enable Rich Presence
		
	// Default palette status
	Game.FadeEnabled = true;
	Game.PaletteSet	 = 0;
	Game.PalIndex[0] = 0;
	
	// Default keyboard control mappings
	Game.KeyboardControl = [vk_up, vk_down, vk_left, vk_right, ord("A"), ord("S"), ord("D"), vk_space, vk_enter];
	
	// Save slots data
	Game.ActiveSave	= 0;
	Game.Saveslot   = 0;
}