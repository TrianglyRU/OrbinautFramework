/// @description Room Script
// You can write your code in this editor

	// Disable fade in the room
	Game.FadeEnabled = false;
			
	// Set loading Sonic object position
	objLoadingIcon.x = Game.ResolutionWidth - 24;
	objLoadingIcon.y = Game.ResolutionHeight - 24;	
			
	// Start initialization timer and proceed to dev menu
	Timer   += 1;
	if (Timer = 30) room_goto(MBZ);