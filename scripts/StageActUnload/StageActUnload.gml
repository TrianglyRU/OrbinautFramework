function StageActUnload()
{
	// Exit the code if act is not in its unload state
	if State != ActStateUnload
	{
		exit;
	}
	
	if StateTimer == 0
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
		
		// Save game progress at the end of the zone
		if Stage.ActID == Stage.FinalActID
		{
			gamedata_save(Game.ActiveSave, Player.CharacterID, Stage.ZoneID + 1, Game.Emeralds, Game.Lives, Game.Continues, Game.Score);
		}
				
		// Fade out the screen only if this is last act of the zone if stage transition is enabled
		if !Game.StageTransitions or Game.StageTransitions and Stage.ActID == Stage.FinalActID
		{
			fade_perform(to, black, 1);
		}
	}
		
	// Start state timer
	StateTimer++;
				
	// Instantly load next act if stage transition is enabled
	if  Game.StageTransitions and Stage.ActID != Stage.FinalActID and StateTimer == 1
	or  Game.StageTransitions and Stage.ActID == Stage.FinalActID and StateTimer == 30
	or !Game.StageTransitions and StateTimer == 30
	{
		switch ActID
		{
			case 0:
			{
				switch ZoneID
				{
					case 0: room_goto(MQZ2);    break;
					case 1: room_goto(DevMenu); break;
				}
			}	
			break;
			case 1:
			{
				switch ZoneID
				{
					case 0: room_goto(DevMenu); break;
				}
			}
		}
	}
}