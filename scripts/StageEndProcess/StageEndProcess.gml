function StageEndProcess()
{
	// Exit if stage is not finished
	if !(IsFinished and fade_check(FadeMax))
	{
		exit;
	}
	
	// Buffer score and lives to transfer it to the next zone/act
	Game.Score = Player.Score;
	Game.Lives = Player.Lives;
	
	// Reset game data
	Game.Rings			 = 0;
	Game.Time	         = 0;
	Game.StageBoundary   = 0;
	Game.StarPostData    = [];
	Game.SpecialRingData = [];
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
		
		// Save next zone but not the current one
		Game.Stage++;
		
		// Save our progress
		gamedata_save(Game.ActiveSave);
	}

	// Load next stage
	switch room
	{
		default:
			room_goto(DevMenu);
		break;
	}
}