/// @description Main 2
// You can write your code in this editor

	/* This is called after object
	scripts are processed */
	
	// Check if we should execute the code below
	if !PlayerProcess()
	{
		return;
	}
	PlayerGeneralUpdate();
	PlayerSuperFormsProcess();
	PlayerWaterEvents();
	PlayerPhysicsHandle();
	PlayerAnimate();
	PlayerRotation();