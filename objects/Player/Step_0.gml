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
			PlayerHitWalls();
			PlayerPositionUpdate();
			PlayerPushPerform();
			PlayerSpindashPerform();
			PlayerRollPerform();
			PlayerJumpPerform();
			PlayerCollideFloor();	
			PlayerSlopeDetach();
			PlayerCollideSolidObjects();
		break;
		case PlayerStateRoll:
			PlayerMovementLock();
			PlayerSlopeResistRolling();	
			PlayerMovementRolling();
			PlayerHitWalls();
			PlayerPositionUpdate();
			PlayerJumpPerform();
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