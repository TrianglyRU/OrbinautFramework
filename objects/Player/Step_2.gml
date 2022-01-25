/// @description Main 2
// You can call your scripts in this editor

	/* This is called after stage object
	scripts are processed */
	
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