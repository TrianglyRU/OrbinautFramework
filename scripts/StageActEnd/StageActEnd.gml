function StageActEnd()
{
	if State = ActStateUnload
	{	
		// Start state timer
		StateTimer++;
		
		switch StateTimer
		{
			// Move player's score and lives to global values to keep it between the stages
			case 1:
			{
				// TODO: Save the game here using next act/zone
				Game.GlobalScore = Player.Score;
				Game.GlobalLives = Player.Lives;
			}
			break;
			
			// Fade out the screen
			case 60:
			{
				screen_fade_perform(to, black, 1);
			}
			break;
			
			case 90:
			{
				// Move to the next act or zone
				if ActID = 0
				{
					switch ZoneID
					{
						case 0: room_goto(MBZ2);    break;
						case 1: room_goto(DevMenu); break;
					}
				}
				if ActID = 1
				{
					switch ZoneID
					{
						case 0: room_goto(HHZ); break;
					}
				}
				if ActID = 2
				{
					// Add if needed
				}
			}
			break;
		}
	}
}