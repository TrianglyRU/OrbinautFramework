/// @description Player Scripts
// You can call your scripts in this editor
	
	// Update player's state
	PlayerStateUpdate();
	
	// Run main code basing on current state
	switch State {
		case StateNormal:
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
		case StateAirborne:
			PlayerJumpResist();
			PlayerMovementAirborne();
			PlayerPositionUpdate();
			PlayerApplyGravity();
			PlayerHitWalls();
			PlayerHitCeiling();
			PlayerHitFloor();
			PlayerCollideSolidObjects();
			PlayerResetOnFloor();
		break;
		case StateRolling:
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
	}