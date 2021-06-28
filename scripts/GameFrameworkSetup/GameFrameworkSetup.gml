function GameFrameworkSetup()
{
	// Dev mode. Enables some debug shortcuts and features, disable it on your game release
	Game.DevMode = true;
	
	// Game state
	Game.Character = CharSonic;
	Game.Score	 = 0;
	Game.Lives	 = 3;
	Game.Continues	 = 0;
	Game.Emeralds  = 0;
	
	/* From here and until 'engine' section values and flags are overwritten by default on game load
	   if devmode is disabled, so you want to temporary enable it if you want to edit values here!   */
	
	// Window settings
	Game.WindowFullscreen = false;
	Game.ResolutionWidth  = 400;
	Game.ResolutionHeight = 224;
	Game.WindowSize		  = 3;
	
	// Audio settings
	Game.MusicVolume = 0.3;
	Game.SoundVolume = 0.3;
	
	// Control settings (keyboard)
	Game.KeyboardControl = [vk_up, vk_down, vk_left, vk_right, ord("Z"), ord("X"), ord("C"), vk_space, vk_enter];
	
	// Originals differences
	Game.SpindashEnabled        = true;  // Enables S2 Spindash
	Game.DropdashEnabled        = false; // Enables Mania Dropdash
	Game.PeeloutEnabled         = false; // Enables SCD Super Peel Out
	Game.GroundSpeedcap	        = true;  // Enables ground speedcap
	Game.AirSpeedcap	        = false; // Enables air speedcap
	Game.RolljumpControl        = false; // Unlocks directional contorls if you jump after rolling
	Game.ExtendedCamera			= false; // Enables camera to shift to the side of your direction movement
	Game.StrongerSlopeGravity   = false; // In S3 and later, you always affected by slope gravity on non-shallow floors. True - Sonic 3+ method.
	Game.LooseCrouch		    = false; // In S&K, you can start crouching when you are moving slowly. True - SK method.
	Game.ConstantRollFrc        = false; // In SK, rolling friction is hard-coded to always be half of regular acceleration when Super. True - SK method
	Game.StrongerSlopeRepel     = false; // Before S3, you were able to slide down on 45-degree floors. True - Sonic 3+ method
	Game.SpeedFloorClip	        = true;  // In S2 and later, the max distance you're allowed to clip to a floor is based on your speed. True = S2+ method
	Game.ExtensiveWallCollision	= true;  // In SK, you can collide with the walls on cardinal angles as well (90, 180, 270) instead of just in angle range of 270->360->90
	Game.StageTransitions		= false; // In S3 stage transitions were introduced. True = S3+-like transitions (not a direct copy).
	Game.BalancingCrouch		= false; // In S3 and later you're allowed to crouch when balancing. True = S3+ method
	Game.BuffedWaterBarrier     = false; // In Sonic Mania, water barrier halves your xsp instead of setting it to 0
	
	// Orbinaut improvements
	Game.ImprovedTileCollision = true;  // Uses custom advanced method to update collision mode, fixes several collision flaws and resets floor angle better
	Game.ImprovedObjCollision  = true;  // In originals, objects are pretty wacky in terms of collision and hitboxes. True - apply Orbinaut's fixes
	Game.SmoothRotation	       = true;  // Use smooth rotation
	Game.RichPresenceSupport   = true;  // Enable Rich Presence
	Game.RingsPreciseCollision = true;  // Make rings check for collision every frame instead of every 4
	Game.RingsNoBoundDespawn   = true;  // Make rings despawn as soon as they leave the screen
	Game.RingsAllSideCollision = false; // Make rings collide with walls and ceiling instead of just floor
	Game.NoRollSpeedLimit	   = false; // Disables xsp limitation when rolling. May cause collision glitches on higher speeds
	Game.FlyingCancel	       = true;  // Allows you to cancel flying as Tails
}