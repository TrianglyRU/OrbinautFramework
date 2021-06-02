function GameFrameworkSetup()
{
	// Dev mode. Enables some debug shortcuts and features, disable it on your game release
	Game.DevMode = true;
	
	// Game state
	Game.GlobalCharacter = CharSonic;
	Game.GlobalScore	 = 0;
	Game.GlobalLives	 = 3;
	Game.GlobalConts	 = 0;
	Game.GlobalEmeralds  = 0;
	Game.GamePaused		 = false;
	Game.SavedCheckpoint = false;
	Game.SavedPosition   = false;
	
	/* From here and until 'engine' section values and flags are overwritten by default on game load
	   if devmode is disabled, so you want to temporary enable it if you want to edit values here!   */
	
	// Window settings
	Game.WindowFullscreen = false;
	Game.ResolutionWidth  = 400;
	Game.ResolutionHeight = 224;
	Game.WindowSize		  = 4;
	
	// Audio settings
	Game.MusicVolume = 0;
	Game.SoundVolume = 0.3;
	
	// Control settings (keyboard)
	Game.KeyboardControl = [vk_up, vk_down, vk_left, vk_right, ord("A"), ord("S"), ord("D"), vk_space, vk_enter];
	
	// Gameplay	
	Game.SpindashEnabled   = true;  // Enables S2 Spindash
	Game.DropdashEnabled   = false; // Enables Mania Dropdash
	Game.PeeloutEnabled    = true;  // Enables SCD Super Peel Out
	Game.GroundSpeedcap	   = false; // Enables ground speedcap
	Game.AirSpeedcap	   = false; // Enables air speedcap
	Game.RolljumpControl   = false; // Unlocks directional contorls if you jump after rolling
	Game.ExtendedCamera	   = false; // Enables camera to shift to the side of your direction movement
	Game.OriginalRollLimit = true;  // Limits xsp instead of inertia speed when rolling
	Game.FlyingCancel	   = true;  // Allows you to cancel flying as Tails
	
	// Engine
	/* These flags are not affected by game settings and set only here */
	
	// Originals differences
	Game.StrongerSlopeGravity   = false; // In S3 and later, you always affected by slope gravity on non-shallow floors. True - Sonic 3+ method.
	Game.LooseCrouch		    = false; // In S&K, you can start crouching even when you are moving slowly. True - SK method.
	Game.ConstantRollFrc        = false; // In SK, rolling friction is hard-coded to always be half of regular acceleration, even when Super. True - SK method
	Game.StrongerSlopeDetach    = false; // Before S3, you were able to slide down on 45-degree floors. True - Sonic 3+ method
	Game.SpeedFloorClip	        = true;  // In S2 and later, the max distance you're allowed to clip to a floor is based on your speed. True = S2+ method
	Game.ExtensiveWallCollision	= true;  // In SK, you can collide with the walls on cardinal angles as well (90, 180, 270) instead of just in angle range of 270->360->90
	Game.StageTransitions		= true;	 // In S3 and later stage transitions are used. True = S3+.
	Game.BalancingCrouch		= true;  // In S3 and later you're allowed to crouch when balancing. True = S3+ method
	
	// Orbinaut improvements
	Game.ImprovedTileCollision = true;  // Uses custom advanced method to update collision mode, fixes several collision flaws and resets floor angle better
	Game.ImprovedObjCollision  = true;  // In originals, objects are pretty wacky in terms of collision and hitboxes. True - apply Orbinaut's fixes
	Game.SmoothPaletteCycle	   = true;  // Apply interpolation to palette cycles
	Game.SmoothRotation	       = true;  // Use smooth rotation
	Game.RichPresenceSupport   = true;  // Enable Rich Presence
	Game.RingsPreciseCollision = true;  // Make rings check for collision every frame instead of every 4
	Game.RingsNoBoundDespawn   = true;  // Make rings despawn as soon as they leave the screen
	Game.RingsAllSideCollision = false; // Make rings collide with walls and ceiling instead of just floor
}