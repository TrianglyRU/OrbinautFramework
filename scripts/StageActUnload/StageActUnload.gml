function StageActUnload()
{
	// Exit the code if act is not in its unload state
	if State != StageUnload
	{
		exit;
	}
	
	if !StateTimer
	{
		// Buffer score and lives to transfer it to the next zone/act
		Game.Score = Player.Score;
		Game.Lives = Player.Lives;
		
		// Clear data
		Game.CheckpointID   = false;
		Game.PlayerPosition = false;
		Game.Time	        = 0;
		Game.StageBoundary  = 0;
		
		// Save game progress at the end of the zone if we're not in "no save" mode
		if ActID == FinalActID and Game.ActiveSave != -1
		{
			gamedata_save(Game.ActiveSave, Player.CharacterID, ZoneID + 1, Game.Emeralds, Game.Lives, Game.Continues, Game.Score);
		}
				
		// Fade out
		fade_perform(to, black, 1);
	}
			
	// Load next act after fade reached its max step
	if fade_check(FadeMax)
	{
		switch ActID
		{
			// Act 1
			case 0:
			{
				switch ZoneID
				{
					case 0: 
						room_goto(DevMenu);
					break;
				}
			}	
			break;
		}
	}
}