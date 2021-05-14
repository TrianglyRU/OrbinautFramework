/// @description Render
// You can write your code in this editor
	
	// Exit the code if stage is loading, unloading or restarting
	if (Stage.State == ActStateLoading or Stage.State == ActStateUnload or Stage.State == ActStateRestart) exit;
	
	// Execute code based on current state
	switch State
	{
		case PlayerStateDebug:
		{
			// Display objects when in debug mode
			PlayerDebugModeDisplay();
		}
		break;
		default:
		{
			// Animate character
			PlayerAnimate();
	
			// Display character
			PlayerDisplay();
		}
		break;
	}
	
	
	