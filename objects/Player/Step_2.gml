/// @description Post-Objects Code
// You can write your code in this editor

	// Check if we should execute the code below
	if !PlayerProcess() exit;
	
	// Post-Objects Scripts
	PlayerGeneralUpdate();
	PlayerSuperFormsProcess();
	PlayerWaterEvents();
	PlayerPhysicsHandle();
	PlayerPositionRecord();
	PlayerAnimate();
	PlayerRotation();