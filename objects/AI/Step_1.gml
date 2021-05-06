/// @description Scripts
// You can write your code in this editor

	// Do not run this code if stage is loading, unloading or restarting
	if (Stage.State == ActStateLoading or Stage.State == ActStateUnload or Stage.State == ActStateRestart) exit;
	
	// Update player
	AIGeneralUpdate();

	// Run main code based on current state
	switch State 
	{
		case PlayerStateNormal:
		{	
			// Perform jump and exit the code
			if AICheckJump() break;

			// Set slope gravity
			AISlopeResist();

			// Update player's speeds
			AIMove();
			
			// Collide with walls
			AICollideWalls();
			
			// Check for crossing stage boundaries
			AILevelBound();
			
			// Update player's position
			AISpeedToPos();
			
			// Perform crouch actions, such as Spindash
			AICheckCrouch();
			
			// Perform look up actions, such as Super Peel Out
			AICheckLookup();
			
			// Perform roll
			AICheckRoll();
			
			// Collide with floor
			AICollideFloor();
			
			// Fall off the ceiling and walls
			AISlopeRepel();
		}
		break;
		case PlayerStateRoll:
		{		
			// Perform jump and exit the code
			if AICheckJump() break;
			
			// Set slope gravity
			AISlopeResist();	
			
			// Update player's speeds
			AIMoveRoll();

			// Collide with walls
			AICollideWalls();
			
			// Check for crossing stage boundaries
			AILevelBound();
			
			// Update player's position
			AISpeedToPos();
			
			// Collide with floor
			AICollideFloor();
	
			// Fall off the ceiling and walls
			AISlopeRepel();
		}
		break;
		case PlayerStateAirborne:
		{
			// Limit jump height
			AIJumpResist();
			
			// Update player's speeds
			AIMoveAirborne();
			
			// Check for flying
			AICheckFly();
			
			// Check for crossing stage boundaries
			AILevelBound();
			
			// Update player's position
			AISpeedToPos();
			
			// Apply gravity and rotation
			AIApplyGravity();
			
			// Collide with walls
			AICollideWalls();
			
			// Collide with floor
			AICollideFloor();
			
			// Collide with roof
			AICollideRoof();		
			
			// Reset flags on landing
			AIResetOnFloor();
		}
		break;
	}