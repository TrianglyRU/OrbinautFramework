function ObjBossTriggerMain()
{
	// Set right boundary if object exist
	Stage.TargetRightBoundary = x + max(Game.Width / 2, ArenaWidth / 2);
	
	// Check if player ran past the trigger
	if Stage.IsBossfight == -1
	{
		if floor(Player.PosX) > x
		{
			// Play boss music
			audio_bgm_play(ChannelPrimary, Boss); 
			
			// Set new top boundary
			if ArenaHeight != -1
			{
				Stage.TargetTopBoundary = Stage.BottomBoundary - ArenaHeight;
			}
			
			/* SPAWN YOUR BOSS HERE. Do not forget to set BossTrigger.BossDefeated to
			'true' once you want your stage to exit boss state! */
			switch room
			{
				default: break;
			}
			Stage.IsBossfight = true;
		}
	}
	
	// Check if boss is active
	else if Stage.IsBossfight == true
	{
		if !BossDefeated
		{
			// Check for a key to be pressed if it is example bossfight
			if Template and keyboard_check_pressed(ord("K"))
			{
				BossDefeated = true;
			}
			
			// Set new left boundary
			Stage.TargetLeftBoundary = x - max(Game.Width / 2, ArenaWidth / 2);	
		}
		else
		{
			/* Set right boundary to room_width. Normally, you have to place Egg Prison or Clear Panel
			after the arena, so the game will automatically set new boundaries once again */
			Stage.TargetRightBoundary = room_width;
			
			// Give 1000 points and cancel bossfight state
			Player.Score     += 1000;
			Stage.IsBossfight = false;
			
			// Restore music
			if Player.SuperState
			{
				audio_bgm_play(ChannelPrimary, SuperTheme);
			}
			else
			{
				audio_bgm_play(ChannelPrimary, Stage.StageMusic);
			}
			
			// Destroy object
			instance_destroy();
		}
	}
}