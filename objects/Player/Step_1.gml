/// @description Main 1
// You can call your scripts in this editor

	/* This is called before stage object
	scripts are processed */
	
	if PlayerDebugMode()
	{
		return;
	}
	else if PlayerProcess()
	{
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
	