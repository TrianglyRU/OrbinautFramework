/// @description Scripts
// You can call your scripts in this editor
	
	// Update player's states
	PlayerStatesUpdate();
	
	// Simulate how player behaviours when double input registered
	PlayerInputSimulation();
	
	// Run main code based on current state
	switch State 
	{
		case PlayerStateNormal:
		{	
			// Perform jump and exit the code
			PlayerCheckJump();
			if Jumping exit;
			
			// Set slope gravity
			PlayerSlopeResist();
			
			// Update player's speeds
			PlayerMove();
			
			// Collide with walls
			PlayerHitWalls();
			
			// Update player's position
			PlayerSpeedToPos();
			
			// Check for crossing stage boundaries
			PlayerLevelBound();
			
			// Perform spindash
			PlayerCheckSpindash();
			
			// Perform roll
			PlayerCheckRoll();
			
			// Collide with floor and update player's angle
			PlayerCollideFloor();
			
			// Fall off the ceiling and walls
			PlayerSlopeRepel();
			
			// Collide with the objects
			PlayerCollideSolidObjects();
		}
		break;
		case PlayerStateRoll:
		{
			// Perform jump and exit the code
			PlayerCheckJump();
			if Jumping exit;
			
			// Set slope gravity
			PlayerSlopeResist();	
			
			// Update player's speeds
			PlayerMoveRoll();
			
			// Collide with walls
			PlayerHitWalls();
			
			// Update player's position
			PlayerSpeedToPos();
			
			// Check for crossing stage boundaries
			PlayerLevelBound();
			
			// Collide with floor and update player's angle
			PlayerCollideFloor();
			
			// Fall off the ceiling and walls
			PlayerSlopeRepel();
			
			// Collide with the objects
			PlayerCollideSolidObjects();
		}
		break;
		case PlayerStateAirborne:
		{
			// Limit jump height
			PlayerJumpResist();
			
			// Update player's speeds
			PlayerMoveAirborne();
			
			// Update player's position
			PlayerSpeedToPos();
			
			// Check for crossing stage boundaries
			PlayerLevelBound();
			
			// Apply gravity and rotation
			PlayerApplyGravity();
			
			// Collide with walls
			PlayerHitWalls();
			
			// Collide with roof
			PlayerHitRoof();
			
			// Collide with floor
			PlayerHitFloor();
			
			// Collide with solid objects
			PlayerCollideSolidObjects();
			
			// Landing events
			PlayerResetOnFloor();
		}
		break;
	}