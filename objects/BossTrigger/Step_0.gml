/// @description Main
// You can write your code in this editor

	// Set right boundary if object is active
	Stage.TargetRightBoundary = x + max(global.Width / 2, ArenaWidth / 2);
	
	if Stage.IsBossfight == -1
	{
		if floor(Player.PosX) > x
		{
			// Set new top boundary
			if ArenaHeight != -1
			{
				Stage.TargetTopBoundary = Stage.BottomBoundary - ArenaHeight;
			}
			
			audio_bgm_play(AudioPrimary, BossTheme); 

			/* SPAWN YOUR BOSS HERE. Do not forget to set BossTrigger.BossDefeated to
			'true' once you want your stage to exit boss state! */
			switch room
			{
				default:
			}
			Stage.IsBossfight = true;
		}
	}
	else if Stage.IsBossfight == true
	{
		if !BossDefeated
		{
			// Set left boundary
			Stage.TargetLeftBoundary = x - max(global.Width / 2, ArenaWidth / 2);	
			
			// Check for a key to be pressed if it is example bossfight
			if Template and keyboard_check_pressed(ord("K"))
			{
				Player.Score += 1000;
				BossDefeated  = true;
			}
		}
		else
		{
			/* Set right boundary. Normally, you have to place Egg Prison or Clear Panel
			after the arena, so the game will automatically set new boundaries once again */
			Stage.TargetRightBoundary = room_width;
			Stage.IsBossfight         = false;
			
			// Increase water level for test stage
			if room == Stage_TSZ
			{
				Stage.WaterLevel = 1392;
			}
			
			// Restore music
			if Player.SuperState
			{
				audio_bgm_play(AudioPrimary, SuperTheme);
			}
			else
			{
				audio_bgm_play(AudioPrimary, Stage.StageMusic);
			}
			
			instance_destroy();
		}
	}