/// @description
// You can write your code in this editor
	
	if Direction == "Not Defined"
	{
		exit;
	}
	
	if object_player_overlap(CollisionTriggerbox)
	{
		if !Active
		{
			Active = true;
			
			if !Player.ForcedRoll
			{
				if Player.Xsp > 0 and Direction == "Right"
				or Player.Xsp < 0 and Direction == "Left"
				{
					Player.ForcedRoll = true;
				}
			}
			else
			{
				Player.ForcedRoll = false;
			}
		}
	}
	else if Active
	{
		Active = false;
	}