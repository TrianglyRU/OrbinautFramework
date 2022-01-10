function StageEndProcess()
{
	// Exit if stage is not finished
	if !(IsFinished and fade_check(StateMax))
	{
		exit;
	}
	
	// Buffer score and lives to transfer it to the next zone/act
	Game.Score = Player.Score;
	Game.Lives = Player.Lives;
	
	// Reset data saved throughout the stage
	Game.StarPostData    = [];
	Game.SpecialRingList = [];
	
	// Clear recorded position
	ds_list_destroy(Player.RecordedPosX);
	ds_list_destroy(Player.RecordedPosY);
		
	// Check if this is the last act of the zone and we're not in "no save" mode
	if ActID == FinalActID and Game.ActiveSave != -1
	{
		// If this if the final zone, mark save as completed
		if ZoneID == FinalZoneID
		{
			Game.SaveState = 1;
		}
		else
		{
			Game.Stage++;
		}
		
		// Save our progress
		gamedata_save(Game.ActiveSave);
	}

	// Load next stage
	room_goto(NextStage);
}