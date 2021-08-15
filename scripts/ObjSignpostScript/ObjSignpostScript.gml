function ObjSignpostScript()
{
	if id.PlayerType == "Sonic & Tails" and Player.CharacterID == CharKnuckles
	or id.PlayerType == "Knuckles"		and Player.CharacterID != CharKnuckles
	{
		visible = false;
		exit;
	}
	
	if !Active
	{
		if object_player_overlap(CollisionTriggerbox)
		{
			Active = 1;	
			audio_sfx_play(sfxSignPost, false);
			
			audio_bgm_stop(PriorityLow,  1);
			audio_bgm_stop(PriorityHigh, 1);
			
			Stage.TimeEnabled = false;
			Stage.AllowPause  = false;
			
			if Player.SuperState
			{
				Player.SuperState = false;
			}
		}
		animation_set_frame(SpriteData[0], 1);
	}
	else if Active == 1
	{	
		// Count timer
		ActiveTimer++;
		
		// Play animation
		if ActiveTimer < 62
		{
			animation_play(SpriteData[0], 1, 1);
		}
		else if ActiveTimer < 123
		{
			animation_play(SpriteData[1], 1, 1);
		}
		else
		{
			animation_set_frame(false, 1);
			Active		= 2;
			ActiveTimer = 0;
		}
		
		// Create sparkles
		if ActiveTimer mod 12 == 0 and SparkleToUse < 8
		{
			instance_create(x + SparkleX[SparkleToUse], y + SparkleY[SparkleToUse], RingSparkle);
			SparkleToUse++;
		}
	}
	else if Active == 2 and !Stage.IsFinished
	{
		if (++ActiveTimer) >= 24
		{
			if Player.Grounded
			{
				audio_bgm_play(PriorityLow, ActClearMusic, noone);
				
				Stage.IsFinished   = true;
				Input.IgnoreInput  = true;	
				Player.Xsp		   = 0;
				Player.Ysp		   = 0;
				Player.Inertia     = 0;
				Player.SpindashRev = -1;
				Player.PeeloutRev  = -1;
			}
		}
	}
	
	// Set boundaries
	if floor(Player.PosX) > (x - Screen.Width * 1.5 + 64) + Screen.Width / 2
	{
		Stage.TargetLeftBoundary  = x - Screen.Width * 1.5 + 64;
		Stage.TargetRightBoundary = x + Screen.Width / 2;
		
		if Active
		{
			Stage.TargetLeftBoundary = x - (Screen.Width / 2);
		}
	}	
}