function StageActEnd()
{
	// Exit the code if act is not in its unload state
	if (State != ActStateUnload) exit;
	
	if StateTimer == 0
	{
		// Buffer score, lives, continues and emeralds to transfer it to the next zone/act
		Game.GlobalScore    = Player.Score;
		Game.GlobalLives    = Player.Lives;
		Game.GlobalEmeralds = Player.Emeralds;
		Game.GlobalConts    = Player.Conts;
		
		// Save game progress at the end of the zone
		if Stage.ActID == Stage.FinalActID
		{
			gamedata_save(Game.ActiveSave, Player.CharacterID, Stage.ZoneID + 1, Game.GlobalEmeralds, Game.GlobalLives, Game.GlobalConts, Game.GlobalScore);
		}
				
		// Fade out the screen only if this is last act of the zone if stage transition is enabled
		if !Game.StageTransitions or (Game.StageTransitions and Stage.ActID == Stage.FinalActID)
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
					case 0: room_goto(GVZ2);    break;
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