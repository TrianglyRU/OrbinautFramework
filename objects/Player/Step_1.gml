/// @description Scripts
// You can write your code in this editor

	// Exit the code if stage is loading, unloading or restarting
	if (Stage.State == ActStateLoading or Stage.State == ActStateUnload or Stage.State == ActStateRestart) exit;
	
	// Update player's state
	PlayerStateUpdate();
	
	// Update general player stuff
	PlayerGeneralUpdate();

	// Execute code based on current state
	switch State 
	{
		case PlayerStateNormal:
		{	
			// Perform jump and exit the code
			if PlayerCheckJump() break;

			// Set slope gravity
			PlayerSlopeResist();

			// Update player's speeds
			PlayerMove();
			
			// Collide with walls
			PlayerCollideWalls();
			
			// Check for crossing stage boundaries
			PlayerLevelBound();
			
			// Update player's position
			PlayerSpeedToPos();
			
			// Perform crouch actions, such as Spindash
			PlayerCheckCrouch();
			
			// Perform look up actions, such as Super Peel Out
			PlayerCheckLookup();
			
			// Check for gliding on the ground as Knuckles
			PlayerCheckGlide();
			
			// Perform roll
			PlayerCheckRoll();
			
			// Collide with floor
			PlayerCollideFloor();
			
			// Fall off the ceiling and walls
			PlayerSlopeRepel();
		}
		break;
		case PlayerStateRoll:
		{	
			// Perform jump and exit the code
			if PlayerCheckJump() break;
			
			// Set slope gravity
			PlayerSlopeResist();	
			
			// Update player's speeds
			PlayerMoveRoll();

			// Collide with walls
			PlayerCollideWalls();
			
			// Check for crossing stage boundaries
			PlayerLevelBound();
			
			// Update player's position
			PlayerSpeedToPos();
			
			// Collide with floor
			PlayerCollideFloor();
	
			// Fall off the ceiling and walls
			PlayerSlopeRepel();
		}
		break;
		case PlayerStateAirborne:
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
			PlayerCollideWalls();
			
			// Collide with floor
			PlayerCollideFloor();
			
			// Collide with roof
			PlayerCollideRoof();
			
			// Check for dropdash as Sonic
			PlayerCheckDropdash();
			
			// Reset flags on landing
			PlayerResetOnFloor();
		}
		break;
		case PlayerStateDebug:
		{
			// Run debug mode
			PlayerDebugModeControl();
		}
	}
	
	