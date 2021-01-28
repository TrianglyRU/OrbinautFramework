/// @description Player Scripts
// You can call your scripts in this editor
	
	// Update player's state
	PlayerStateUpdate();
	
	// Run main code basing on current state
	switch State 
	{
		case PlayerStateNormal:
			PlayerMovementLock();
			PlayerSlopeResist();
			PlayerMovementNormal();
			PlayerUpdateAnglePosition();
			PlayerHitWalls();
			PlayerPositionUpdate();
			PlayerPushPerform();
			PlayerSpindashPerform();
			PlayerRollPerform();
			PlayerJumpPerform();
			PlayerUpdateAnglePosition();
			PlayerCollideFloor();	
			PlayerSlopeDetach();
			PlayerCollideSolidObjects();
		break;
		case PlayerStateRoll:
			PlayerMovementLock();
			PlayerSlopeResistRolling();	
			PlayerMovementRolling();
			PlayerUpdateAnglePosition();
			PlayerHitWalls();
			PlayerPositionUpdate();
			PlayerJumpPerform();
			PlayerUpdateAnglePosition();
			PlayerCollideFloor();	
			PlayerSlopeDetach();
			PlayerCollideSolidObjects();
		break;
		case PlayerStateAirborne:
			PlayerJumpResist();
			PlayerMovementAirborne();
			PlayerPositionUpdate();
			PlayerApplyGravity();
			PlayerHitWalls();
			PlayerHitRoof();
			PlayerHitFloor();
			PlayerCollideSolidObjects();
			PlayerResetOnFloor();
		break;
	}