/// @description Pre-Object Code
// You can write your code in this editor

	// Debug mode state
	PlayerDebugMode();
	
	// Check if we should run the code below
	if !PlayerProcess() exit;

	// Airborne
	if !Grounded
	{
		// Limit jump height and perform jump actions
		PlayerJump();
			
		// Update player's speeds
		PlayerMovementAir();
			
		// Check for crossing stage boundaries
		PlayerLevelBound();
			
		// Update player's position
		PlayerPosition();
		
		// Check for dropdash as Sonic
		PlayerSonicDropdash();
		
		// Check for flying as Tails
		PlayerTailsFlight();
		
		// Check for climbing walls as Knuckles
		PlayerKnuxClimb();
		
		// Check for gliding as Knuckles
		PlayerKnuxGlide();
		
		// Air collision
		PlayerAirLevelCollision();
			
		// Reset flags on landing
		PlayerResetOnFloor();
	}
	
	// Grounded, not rolling
	else if Grounded and !Rolling
	{
		// Perform crouch actions, such as Spindash
		if PlayerCrouch() exit;
		
		// Perform look up actions, such as Super Peel Out
		if PlayerLookup() exit;
		
		// Perform jump
		if PlayerJumpStart() exit;

		// Set slope gravity
		PlayerSlopeResist();

		// Update player's speeds
		PlayerMovementGround();
		
		// Check balancing
		PlayerBalance();
		
		// Check for skidding
		PlayerSkid();
		
		// Check push
		PlayerPush();
		
		// Collide with walls
		PlayerGroundWallCollision();
		
		// Perform roll
		PlayerRollStart();
			
		// Check for crossing stage boundaries
		PlayerLevelBound();
			
		// Update player's position
		PlayerPosition();
					
		// Collide with floor
		PlayerGroundFloorCollision();
			
		// Fall off the ceiling and walls
		PlayerSlopeRepel();
	}
	
	// Grounded and rolling
	else if Grounded and Rolling
	{
		// Perform jump
		if PlayerJumpStart() exit;
			
		// Set slope gravity
		PlayerSlopeResistRoll();	
			
		// Update player's speeds
		PlayerRoll();

		// Collide with walls
		PlayerGroundWallCollision();
			
		// Check for crossing stage boundaries
		PlayerLevelBound();
			
		// Update player's position
		PlayerPosition();
			
		// Collide with floor
		PlayerGroundFloorCollision();
	
		// Fall off the ceiling and walls
		PlayerSlopeRepel();
	}