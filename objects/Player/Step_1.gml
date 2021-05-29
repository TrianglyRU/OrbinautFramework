/// @description Scripts
// You can write your code in this editor

	// Exit the code if stage is loading, unloading or restarting
	if (Stage.State == ActStateLoading or Stage.State == ActStateUnload or Stage.State == ActStateRestart) exit;

	// Update general player stuff
	PlayerGeneralUpdate();

	if !DebugMode
	{
		// Airborne script
		if !Grounded
		{
			// Limit jump height
			PlayerJumpResist();
			
			// Update player's speeds
			PlayerMoveAirborne();
			
			// Check for flying as Tails
			PlayerCheckFly();
			
			// Check for gliding as Knuckles
			PlayerCheckGlide();
			
			// Check for climbing walls as Knuckles
			PlayerCheckClimb();
			
			// Check for crossing stage boundaries
			PlayerLevelBound();
			
			// Update player's position
			PlayerSpeedToPos();
			
			// Apply gravity and rotation
			PlayerApplyGravity();
			
			// Collide with walls
			PlayerHitWalls();
			
			// Collide with floor
			PlayerHitFloor();
			
			// Collide with roof
			PlayerHitRoof();
			
			// Reset flags on landing
			PlayerResetOnFloor();

			// Check for dropdash as Sonic
			PlayerCheckDropdash();
		}
	
		// Grounded script
		else if !Rolling
		{
			// Perform jump and exit the code
			if PlayerCheckJump() exit;

			// Set slope gravity
			PlayerSlopeResist();

			// Update player's speeds
			PlayerMove();
			
			// Collide with walls
			PlayerHitWalls();
			
			// Check for crossing stage boundaries
			PlayerLevelBound();
			
			// Update player's position
			PlayerSpeedToPos();
			
			// Perform crouch actions, such as Spindash
			PlayerCheckCrouch();
			
			// Perform look up actions, such as Super Peel Out
			PlayerCheckLookup();
			
			// Perform roll
			PlayerCheckRoll();
			
			// Collide with floor
			PlayerCollideFloor();
			
			// Fall off the ceiling and walls
			PlayerSlopeRepel();
		}
	
		// Rolling script
		else
		{
			// Perform jump and exit the code
			if PlayerCheckJump() exit;
			
			// Set slope gravity
			PlayerSlopeResist();	
			
			// Update player's speeds
			PlayerMoveRoll();

			// Collide with walls
			PlayerHitWalls();
			
			// Check for crossing stage boundaries
			PlayerLevelBound();
			
			// Update player's position
			PlayerSpeedToPos();
			
			// Collide with floor
			PlayerCollideFloor();
	
			// Fall off the ceiling and walls
			PlayerSlopeRepel();
		}
	}
	else
	{
		// Run debug mode
		PlayerDebugModeControl();
	}