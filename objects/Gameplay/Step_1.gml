/// @description
// You can write your code in this editor
	
	// Player Scripts
	#region Player
	{
		// Handle debug mode
		if !PlayerDebugMode()
		{
			// Check if we should run the code below
			if PlayerProcess()
			{
				switch Player.State
				{
					case StateAirborne:
					{
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
					break;
					case StateGrounded:
					{
						if PlayerCrouch()	 break;
						if PlayerLookup()	 break;
						if PlayerJumpStart() break;
						
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
					break;
					case StateRolling:
					{
						if PlayerJumpStart() break;
			
						PlayerSlopeResistRoll();	
						PlayerRoll();
						PlayerGroundWallCollision();
						PlayerLevelBound();
						PlayerPosition();
						PlayerGroundFloorCollision();
						PlayerSlopeRepel();
					}
					break;
				}
			}
		}
	}
	#endregion