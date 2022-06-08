/// @description Main 1
// You can call your scripts in this editor

	/* This is called before stage objects are processed */
	
	if PlayerDebugMode()
	{
		return;
	}
	else if PlayerProcess()
	{
		// Airborne
		if !Grounded
		{
			if !GlideState and !ClimbState
			{
				// Not gliding or climbing
				PlayerJump();
				PlayerMovementAir();
				PlayerLevelBound();
				PlayerPosition();
				PlayerSonicDropdash();
				PlayerTailsFlight();
				PlayerAirLevelCollision();
			}
			else
			{
				// Gliding or climbing
				PlayerMovementAir();
				PlayerKnuxGlideControl();
				PlayerLevelBound();
				PlayerPosition();
				PlayerKnuxGlide();
				PlayerKnuxClimb();
			}
			PlayerResetOnFloor();
			PlayerHitboxUpdate();
		}
		
		// Grounded
		else
		{
			if !Spinning
			{
				// Not rolling
				if PlayerSpindash()  return;
				if PlayerPeelout()   return;
				if PlayerJumpStart() return;
				PlayerSlopeResist();
				PlayerMovementGround();
				PlayerBalance();
				PlayerGroundWallCollision();	
				PlayerRollStart();	
			}
			else
			{
				// Rolling
				if PlayerJumpStart() return;
				PlayerSlopeResistRoll();	
				PlayerMovementRoll();
				PlayerGroundWallCollision();
			}
			PlayerLevelBound();
			PlayerPosition();
			PlayerGroundFloorCollision();
			PlayerSlopeRepel();
			PlayerHitboxUpdate();
		}
	}	