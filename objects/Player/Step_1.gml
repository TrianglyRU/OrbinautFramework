/// @description Pre-Object Code
// You can write your code in this editor

	// Debug mode state
	PlayerDebugMode();
	
	// Check if we should run the code below
	if !PlayerCheckProcess() exit;

	// Airborne
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

		// Air collision
		PlayerAirLevelCollision();
		
		// Check for gliding as Knuckles
		//PlayerCheckGlide();
			
		// Check for climbing walls as Knuckles
		//PlayerCheckClimb();

		// Use barriers abilities
		PlayerBarriersUsage();
			
		// Reset flags on landing
		PlayerResetOnFloor();
	}
	
	// Grounded, not rolling
	else if Grounded and !Rolling
	{
		// Perform crouch actions, such as Spindash
		if PlayerCheckCrouch() exit;
		
		// Perform look up actions, such as Super Peel Out
		if PlayerCheckLookup() exit;
		
		// Perform jump
		if PlayerCheckJump() exit;

		// Set slope gravity
		PlayerSlopeResist();

		// Update player's speeds
		PlayerMove();
		
		// Check balancing
		PlayerCheckBalance();
		
		// Check for skidding
		PlayerCheckSkid();
		
		// Check push
		PlayerCheckPush();
		
		// Collide with walls
		PlayerGroundWallCollision();
		
		// Perform roll
		PlayerCheckRoll();
			
		// Check for crossing stage boundaries
		PlayerLevelBound();
			
		// Update player's position
		PlayerSpeedToPos();
					
		// Collide with floor
		PlayerAnglePos();
			
		// Fall off the ceiling and walls
		PlayerSlopeRepel();
	}
	
	// Grounded and rolling
	else if Grounded and Rolling
	{
		// Perform jump
		if PlayerCheckJump() exit;
			
		// Set slope gravity
		PlayerSlopeResistRoll();	
			
		// Update player's speeds
		PlayerMoveRoll();

		// Collide with walls
		PlayerGroundWallCollision();
			
		// Check for crossing stage boundaries
		PlayerLevelBound();
			
		// Update player's position
		PlayerSpeedToPos();
			
		// Collide with floor
		PlayerAnglePos();
	
		// Fall off the ceiling and walls
		PlayerSlopeRepel();
	}