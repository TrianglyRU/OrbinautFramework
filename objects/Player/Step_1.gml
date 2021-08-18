/// @description Pre-Objects Code
// You can write your code in this editor

	// Check if we're in Debug Mode
	if PlayerDebugMode() exit;
	
	// Check if we should execute the code below
	if !PlayerProcess() exit;

	// Pre-Objects Scripts
	if !Grounded
	{
		// Airborne
		PlayerJump();
		PlayerMovementAir();
		PlayerLevelBound();
		PlayerPosition();
		PlayerSonicDropdash();
		PlayerTailsFlight();
		PlayerKnuxClimb();
		PlayerKnuxGlide();
		PlayerAirLevelCollision();
		PlayerResetOnFloor();
	}
	else if Grounded and !Spinning
	{
		// Grounded, not rolling
		if PlayerCrouch()    exit;
		if PlayerLookup()    exit;
		if PlayerJumpStart() exit;
		PlayerSlopeResist();
		PlayerMovementGround();
		PlayerBalance();
		PlayerSkid();
		PlayerPush();
		PlayerGroundWallCollision();	
		PlayerRollStart();
		PlayerLevelBound();
		PlayerPosition();
		PlayerGroundFloorCollision();
		PlayerSlopeRepel();
	}
	else if Grounded and Spinning
	{
		// Grounded, rolling
		if PlayerJumpStart() exit;
		PlayerSlopeResistRoll();	
		PlayerRoll();
		PlayerGroundWallCollision();
		PlayerLevelBound();
		PlayerPosition();
		PlayerGroundFloorCollision();
		PlayerSlopeRepel();
	}