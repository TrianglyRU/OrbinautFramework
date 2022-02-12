   function ObjBossTriggerMain()
{
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
			
			audio_bgm_play(TypePrimary, BossTheme); 

			/* SPAWN YOUR BOSS HERE. Do not forget to set BossTrigger.BossDefeated to
			'true' once you want your stage to exit boss state! */
			switch room
			{
				default: break;
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
				BossDefeated = true;
			}
		}
		else
		{
			/* Set right boundary. Normally, you have to place Egg Prison or Clear Panel
			after the arena, so the game will automatically set new boundaries once again */
			Stage.TargetRightBoundary = room_width;
			
			Player.Score     += 1000;
			Stage.IsBossfight = false;
			
			// Restore music
			if Player.SuperState
			{
				audio_bgm_play(TypePrimary, SuperTheme);
			}
			else
			{
				audio_bgm_play(TypePrimary, Stage.StageMusic);
			}
			
			instance_destroy();
		}
	}
}