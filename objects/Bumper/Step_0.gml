/// @description Main
// You can write your code in this editor
	
	if object_check_player(ColHitbox)
	{
		if !State and !Player.Hurt
		{
			// Set player speeds based on collision angle
			var Angle = point_direction(x, y, floor(Player.PosX), floor(Player.PosY));
			
			if Player.Grounded
			{
				Player.Gsp = 7 * dcos(Angle);
			}
			else with Player
			{
				if !GlideState
				{
					Xsp = 7 * dcos(Angle);
				}
				Ysp     = 7 * -dsin(Angle);
				Jumping = false;
				AirLock = false;
			}
			
			// Add points to the score
			if ScoreLimit
			{
				var  ThisObject = id;
				var  Object     = instance_create(x, y, ScoreObject);
				with Object
				{
					object_set_depth(ThisObject, 1);
				}
			}
			ScoreLimit--;
			
			audio_sfx_play(sfxBumper, false);
			animation_reset(1);
			
			// Increment state
			State++;
		}
	}
	else if State
	{
		// Decrement state
		State--;
	}