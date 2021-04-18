/// @description Scripts
// You can write your code in this editor
	
	if keyboard_check(vk_space) exit;
	
	// Do not run this code until stage loaded
	if (Stage.State = ActStateLoading) exit;
	
	// Update player
	PlayerGeneralUpdate();

	// Run main code based on current state
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
			//PlayerHitWalls();
			
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
			PlayerHitWalls();
		
			// Collide with roof
			PlayerHitRoof();
			
			// Collide with floor
			PlayerHitFloor();
			
			// Check for dropdash as Sonic
			PlayerCheckDropdash();
			
			// Reset flags on landing
			PlayerResetOnFloor();
		}
		break;
	}