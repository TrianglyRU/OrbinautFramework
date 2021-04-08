function StageActEnd()
{
	if State == ActStateUnload
	{		
		if StateTimer == 0
		{
			// Buffer score, lives, continues and emeralds to transfer it to the next zone/act
			Game.GlobalScore    = Player.Score;
			Game.GlobalLives    = Player.Lives;
			Game.GlobalEmeralds = Player.Emeralds;
			Game.GlobalConts    = Player.Conts;
				
			// Get stage transition data
			if Game.StageTransitions
			{
				Game.StageTransferX = floor(Player.PosX) - Screen.RenderX;
				Game.StageTransferY = floor(Player.PosY) - Screen.RenderY;
			}
				
			// Save game progress at the end of the zone
			if Stage.ActID == Stage.ZoneActAmount - 1
			{
				gamedata_save(Game.ActiveSave, Player.CharacterID, Stage.ZoneID + 1, 0, Game.GlobalLives, 0, Game.GlobalScore);
			}
				
			// Fade out the screen only if this is last act of the zone if stage transition is enabled
			if !Game.StageTransitions or (Game.StageTransitions and Stage.ActID == Stage.ZoneActAmount - 1)
			{
				fade_perform(to, black, 1);
			}
		}
		
		// Start state timer
		StateTimer++;
				
		// Instantly load next act if stage transition is enabled
		if  Game.StageTransitions and Stage.ActID != Stage.ZoneActAmount - 1 and StateTimer == 1
		or  Game.StageTransitions and Stage.ActID == Stage.ZoneActAmount - 1 and StateTimer == 30
		or !Game.StageTransitions and StateTimer == 30
		{
			if ActID == 0
			{
				switch ZoneID
				{
					case 0: room_goto(MBZ2);    break;
					case 1: room_goto(DevMenu); break;
				}
			}
			if ActID == 1
			{
				switch ZoneID
				{
					case 0: room_goto(HHZ); break;
				}
			}
			if ActID == 2
			{
				// Add if needed
			}
		}
	}
}