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
	
		
	// Save game progress at the end of the zone if we're not in "no save" mode
	if ActID == FinalActID and Game.ActiveSave != -1
	{
		gamedata_save(Game.ActiveSave, Game.Character, ZoneID + 1, Game.Emeralds, Game.Lives, Game.Continues, Game.Score);
	}

	// Load next stage
	switch room
	{
		case TestStage:
			room_goto(DevMenu);
		break;
	}
}