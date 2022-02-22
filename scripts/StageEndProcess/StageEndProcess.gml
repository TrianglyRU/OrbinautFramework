function StageEndProcess()
{
	if !(IsFinished and fade_check(StateMax))
	{
		return;
	}
	
	global.Score		   = Player.Score;
	global.Lives		   = Player.Lives;
	global.SpecialRingList = [];
	global.StarPostData	   = [];
	
	if SaveProgress and global.ActiveSave != -1
	{
		if IsFinalStage
		{
			// Mark savefile as completed if this was the last stage
			global.SaveState = 1;
		}
		else
		{
			global.ZoneID++;
		}
		
		// Save our progress
		gamedata_save(global.ActiveSave);
	}

	// Load into the next stage
	if NextStage != noone
	{
		room_goto(NextStage);
	}
}