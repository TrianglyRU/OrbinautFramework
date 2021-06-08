/// @description Scripts
// You can write your code in this editor

	// Exit the code if stage is loading or unloading
	if Stage.State == ActStateLoading or Stage.State == ActStateUnload
	{
		exit;
	}

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
			
			// Check for crossing stage boundaries
			PlayerLevelBound();
			
			// Update player's position
			PlayerSpeedToPos();
						
			// Check for dropdash as Sonic
			PlayerCheckDropdash();
			
			// Check for flying as Tails
			PlayerCheckFly();
			
			// Apply gravity and rotation
			PlayerApplyGravity();
			
			// Collide with walls
			PlayerHitWalls();
			
			// Collide with roof
			PlayerHitRoof();
			
			// Check for gliding as Knuckles
			PlayerCheckGlide();
			
			// Check for climbing walls as Knuckles
			PlayerCheckClimb();
			
			// Collide with floor
			PlayerHitFloor();

			// Use barriers abilities
			PlayerBarriersUsage();
			
			// Reset flags on landing
			PlayerResetOnFloor();
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
			PlayerAnglePos();
			
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
			PlayerAnglePos();
	
			// Fall off the ceiling and walls
			PlayerSlopeRepel();
		}
	}
	else
	{
		// Run debug mode
		PlayerDebugModeControl();
	}