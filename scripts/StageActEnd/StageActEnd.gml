function StageActEnd()
{
	if State == ActStateUnload
	{	
		// Start state timer
		StateTimer++;
		
		switch StateTimer
		{
			case 1:
			{
				// Buffer score, lives, continues and emeralds to transfer it to the next zone/act
				Game.GlobalScore    = Player.Score;
				Game.GlobalLives    = Player.Lives;
				Game.GlobalEmeralds = Player.Emeralds;
				Game.GlobalConts    = Player.Conts;
				
				// Get stage transition data
				if Game.StageTransition
				{
					Game.StageTransferX = floor(Player.PosX) - Screen.RenderX;
					Game.StageTransferY = floor(Player.PosY) - Screen.RenderY;
				}
				
				// Save game progress at the end of the zone
				if Stage.ActID == Stage.ZoneActAmount - 1
				{
					gamedata_save(Game.ActiveSave, Player.CharacterID, Stage.ZoneID + 1, 0, Game.GlobalLives, 0, Game.GlobalScore);
				}	
				break;
			}

			// Fade out the screen
			case 60:
			{
				if Stage.ActID == Stage.ZoneActAmount - 1
				{
					fade_perform(to, black, 1);
				}
				break;
			}
			case 90:
			{
				// Move to the next act or zone
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
				break;
			}
		}
	}
}