function StageEndProcess()
{
	if !(IsFinished and fade_check(StateMax))
	{
		return;
	}
	
	Game.Score			 = Player.Score;
	Game.Lives			 = Player.Lives;
	Game.SpecialRingList = [];
	Game.StarPostData	 = [];
	
	if IsLastZoneAct = true and Game.ActiveSave != -1
	{
		if ZoneID == FinalZoneID
		{
			// Mark savefile as completed if this was the last zone
			Game.SaveState = 1;
		}
		else
		{
			Game.Stage++;
		}
		
		// Save our progress
		gamedata_save(Game.ActiveSave);
	}

	// Load into the next stage
	if NextStage != noone
	{
		room_goto(NextStage);
	}
}