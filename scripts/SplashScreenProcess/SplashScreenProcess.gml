function SplashScreenProcess()
{
	switch RoomTimer
	{
		// Fade in
		case 10:
			fade_perform(FadeFrom, ColourBlack, 1);
		break;
		
		// Fade out
		case 150:
			fade_perform(FadeTo, ColourBlack, 1);
		break;
		
		// Load into the next room after 3 seconds
		case 180:
			room_goto(DevMenu);
		break;
	}
	
	// Count timer
	RoomTimer++;
}