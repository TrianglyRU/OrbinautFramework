function StageActUnload()
{
	// Exit the code if act is not in its unload state
	if State != ActStateUnload
	{
		exit;
	}
	
	if !StateTimer
	{
		// Buffer score, lives, continues and emeralds to transfer it to the next zone/act
		Game.Score     = Player.Score;
		Game.Lives     = Player.Lives;
		Game.Emeralds  = Player.Emeralds;
		Game.Continues = Player.Conts;
		
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
		
	// Start state timer
	StateTimer++;
				
	// Load next act after 30 frames
	if StateTimer == 30
	{
		switch ActID
		{
			// Act 1
			case 0:
			{
				switch ZoneID
				{
					case 0: room_goto(DevMenu); break;
					case 1: room_goto(MQZ2);    break;
					case 2: room_goto(DevMenu); break;
				}
			}	
			break;
		}
	}
}