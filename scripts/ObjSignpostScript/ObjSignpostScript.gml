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
			Active		      = true;
			Stage.IsFinished  = true;
			
			if Player.SuperState
			{
				SpriteEnd = spr_obj_signpost_end_supersonic;
			}

			audio_sfx_play(sfxSignPost, false);
		}
		animation_set_frame(SpriteStart, 1);
	}
	else
	{	
		// Count timer
		if ActiveTimer < 140
		{
			ActiveTimer++;
		}
		
		// Play animation
		if ActiveTimer < 62
		{
			animation_play(SpriteStart, 1, 1);
		}
		else if ActiveTimer < 123
		{
			animation_play(SpriteEnd, 1, 1);
		}
		else
		{
			animation_set_frame(SpriteEnd, 1);
		}
		
		// Create sparkles
		if ActiveTimer mod 12 == 0 and SparkleToUse < 8
		{
			instance_create(x + SparkleX[SparkleToUse], y + SparkleY[SparkleToUse], RingSparkle);
			SparkleToUse++;
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