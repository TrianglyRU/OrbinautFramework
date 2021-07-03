function ObjStarPostMain()
{
	if !Active 
	{
		if object_player_overlap(CollisionTriggerbox) 
		{
			Game.CheckpointID   = id;
			Game.PlayerPosition = [x, y + sprite_get_height(sprite_index) / 2 - Player.yRadiusDefault];
			Game.Time		    = Stage.Time;
			Game.StageBoundary  = Stage.BottomBoundary;
			Game.Score          = Player.Score;

			var ThisID = ID;
			with StarPost 
			{
				if !Active and ID <= ThisID
				{
					Active = true;
					animation_set_frame(sprite_index, 2);
				}	
			}
			
			audio_sfx_play(sfxStarPost, false);
		}
	}
	else if Angle < 900 
	{
		Angle += 22.5;
		if Angle == 900
		{
			animation_set_frame(sprite_index, 3);
		}
	}
}