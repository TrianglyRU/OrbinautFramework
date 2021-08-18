/// @description Post-Objects Code
// You can write your code in this editor

	// Check if we should run the code below
	if !PlayerProcess() exit;
	
	// Update invincibility and highspeed bonuses
	PlayerPowerup();
	
	// Handle superstate events
	PlayerSuperFormsProcess();
	
	// Handle underwater events
	PlayerWaterEvents();
	
	// Handle player physics values
	PlayerSwapPhysics();
	
	// Record player position
	PlayerPositionRecord();
	
	// Animate character
	PlayerAnimate();
	
	// Rotate character
	PlayerRotation();