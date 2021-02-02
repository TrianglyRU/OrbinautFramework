/// @description Scripts
// You can call your scripts in this editor
	
	// Update player's state
	PlayerStateUpdate();
	
	// Check for movement lock
	PlayerMovementLock();
	
	// Run main code basing on current state
	switch State 
	{
		case PlayerStateNormal:
		{	
			// Perform jump and exit the code
			PlayerJumpPerform();
			if Jumping exit;
			
			// Set slope gravity
			PlayerSlopeResist();
			
			// Update player's speeds
			PlayerMovementNormal();
			
			// Collide with walls
			PlayerHitWalls();
			
			// Update player's position and keep them inside the stage
			PlayerPositionUpdate();
			
			// Perform spindash
			PlayerSpindashPerform();
			
			// Perform roll
			PlayerRollPerform();
			
			// Collide with floor and update player's angle
			PlayerCollideFloor();
			
			// Fall off the ceiling and walls
			PlayerSlopeDetach();
			
			// Collide with the objects
			PlayerCollideSolidObjects();
		}
		break;
		case PlayerStateRoll:
		{
			// Perform jump and exit the code
			PlayerJumpPerform();
			if Jumping exit;
			
			// Set slope gravity
			PlayerSlopeResistRolling();	
			
			// Update player's speeds
			PlayerMovementRolling();
			
			// Collide with walls
			PlayerHitWalls();
			
			// Update player's position and keep them inside the stage
			PlayerPositionUpdate();
			
			// Collide with floor and update player's angle
			PlayerCollideFloor();
			
			// Fall off the ceiling and walls
			PlayerSlopeDetach();
			
			// Collide with the objects
			PlayerCollideSolidObjects();
		}
		break;
		case PlayerStateAirborne:
		{
			// Limit jump height
			PlayerJumpResist();
			
			// Update player's speeds
			PlayerMovementAirborne();
			
			// Update player's position and keep them inside the stage
			PlayerPositionUpdate();
			
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
	show_debug_message("TO CEILING: " + string(tile_get_distance_v(floor(PosX - xRadius), floor(PosY - yRadius), LayerA, false, false)));
	//show_debug_message(string(tile_get_distance_v(floor(PosX - xRadius), floor(PosY - yRadius), LayerA, false, false)) + ":" + string(colmask_get_distance_v(floor(PosX - xRadius), floor(PosY - yRadius), false, false)));
	//show_debug_message(tile_get_distance_v(floor(PosX - xRadius), floor(PosY - yRadius), LayerA, false, false));