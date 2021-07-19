/// @description Post-Objects Code
// You can write your code in this editor
	
	// Check if we should run the code below
	if !PlayerCheckProcess() exit;
	
	// Update invincibility and highspeed bonuses
	PlayerPowerupHandle();
	
	// Handle superstate events
	PlayerSuperStateHandle();
	
	// Handle underwater events
	PlayerWaterHandle();
	
	// Handle player physics values
	PlayerPhysicsHandle();
	
	// Record player position
	PlayerRecordPosition();