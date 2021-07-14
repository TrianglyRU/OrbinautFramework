/// @description
// You can write your code in this editor
	
	if object_player_overlap(CollisionTriggerbox)
	{
		if !Active
		{
			Player.ForcedRoll = !Player.ForcedRoll
			Active = true;
		}
	}
	else if Active
	{
		Active = false;
	}