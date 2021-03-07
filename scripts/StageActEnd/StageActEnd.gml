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
				// Buffer score and lives to transfer it to the next zone/act
				Game.GlobalScore = Player.Score;
				Game.GlobalLives = Player.Lives;
				
				// Define if we need to save the next zone/act
				if Stage.ActID = 0
				{
					var actToSave  = 1;
					var zoneToSave = Stage.ZoneID;
				}
				else
				{
					var actToSave  = 0;
					var zoneToSave = Stage.ZoneID + 1;
				}
				
				// Save game progress
				gamedata_save(Game.SaveslotUsed, Player.CharacterID, zoneToSave, actToSave, Game.GlobalScore, Game.GlobalLives, 0);
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