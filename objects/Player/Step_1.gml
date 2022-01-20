/// @description Main 1
// You can call your scripts in this editor

	/* This is called before object
	scripts are processed */
	
	if PlayerDebugMode()
	{
		return;
	}
	else if PlayerProcess()
	{
		// Airborne
		if !Grounded
		{
			PlayerJump();
			PlayerMovementAir();
			PlayerLevelBound();
			PlayerPosition();
			PlayerSonicDropdash();
			PlayerTailsFlight();
			PlayerAirLevelCollision();
			PlayerKnuxClimb();
			PlayerKnuxGlide();
			PlayerResetOnFloor();
			PlayerHitboxUpdate();
		}
		
		// Grounded, not rolling	
		else if Grounded and !Spinning
		{
			if PlayerSpindash()  return;
			if PlayerPeelout()   return;
			if PlayerJumpStart() return;
			PlayerSlopeResist();
			PlayerMovementGround();
			PlayerBalance();
			PlayerGroundWallCollision();	
			PlayerRollStart();
			PlayerLevelBound();
			PlayerPosition();
			PlayerGroundFloorCollision();
			PlayerSlopeRepel();
			PlayerHitboxUpdate();
		}
		
		// Grounded, rolling
		else if Grounded and Spinning
		{
			if PlayerJumpStart() return;
			PlayerSlopeResistRoll();	
			PlayerMovementRoll();
			PlayerGroundWallCollision();
			PlayerLevelBound();
			PlayerPosition();
			PlayerGroundFloorCollision();
			PlayerSlopeRepel();
			PlayerHitboxUpdate();
		}
	}
	