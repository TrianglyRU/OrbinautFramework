function StageEndProcess()
{
	if !(IsFinished and fade_check(StateMax))
	{
		return;
	}
	
	global.Score			 = Player.Score;
	global.Lives			 = Player.Lives;
	global.SpecialRingList = [];
	global.StarPostData	 = [];
	
	if IsLastZoneAct = true and global.ActiveSave != -1
	{
		if ZoneID == FinalZoneID
		{
			// Mark savefile as completed if this was the last zone
			global.SaveState = 1;
		}
		else
		{
			global.Stage++;
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