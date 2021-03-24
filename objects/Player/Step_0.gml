/// @description Scripts
// You can call your scripts in this editor
	
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
			PlayerHitWalls();
			
			// Check for crossing stage boundaries
			PlayerLevelBound();
			
			// Update player's position
			PlayerSpeedToPos();
			
			// Perform spindash
			PlayerCheckSpindash();
			
			// Perform super peel out
			PlayerCheckPeelout();
			
			// Perform roll
			PlayerCheckRoll();
					
			// Collide with floor
			PlayerCollideFloor();
			
			// Get floor angle
			PlayerUpdateAngle();
			
			// Check for gliding on the ground as Knuckles
			PlayerCheckGlide();
			
			// Fall off the ceiling and walls
			PlayerSlopeRepel();
			
			// Collide or check for overlap with the objects
			PlayerObjectsInteraction();
			
			// Check for being hurt
			PlayerCheckHurt();
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
			
			// Get floor angle
			PlayerUpdateAngle();
			
			// Fall off the ceiling and walls
			PlayerSlopeRepel();
			
			// Collide or check for overlap with the objects
			PlayerObjectsInteraction();
			
			// Check for being hurt
			PlayerCheckHurt();
		}
		break;
		case PlayerStateAirborne:
		{
			// Limit jump height
			PlayerJumpResist();
			
			// Update player's speeds
			PlayerMoveAirborne();
			
			// Check for crossing stage boundaries
			PlayerLevelBound();
			
			// Check for dropdash as Sonic
			PlayerCheckDropdash();
			
			// Check for flying as Tails
			PlayerCheckFlying();
			
			// Check for gliding as Knuckles
			PlayerCheckGlide();
			
			// Check for climbing walls as Knuckles
			PlayerCheckClimb();
			
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
			
			// Collide or check for overlap with the objects
			PlayerObjectsInteraction();
			
			// Check for being hurt
			PlayerCheckHurt();
			
			// Reset flags on landing
			PlayerResetOnFloor();
		}
		break;
	}
	
	// Use character animation list
	PlayerCharacterAnimationList();
	
	// Display character
	PlayerCharacterDisplay();