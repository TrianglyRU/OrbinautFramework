function ObjBumperMain()
{
	// Bounce on collision
	if object_check_overlap(TypeHitbox)
	{
		if !State
		{
			// Set player speeds based on angle
			var Angle = point_direction(x, y, floor(Player.PosX), floor(Player.PosY));
			
			if Player.Grounded
			{
				Player.Inertia = 7 *  dcos(Angle);
			}
			else
			{
				Player.Xsp     = 7 *  dcos(Angle);
				Player.Ysp     = 7 * -dsin(Angle);
				Player.Jumping = false;
				Player.AirLock = false;
			}
			
			// Add points to player's score
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
			
			// Play sound
			audio_sfx_play(sfxBumper, false);
			
			// Reset animation
			animation_reset(1);
			
			// Increment state
			State++;
		}
	}
	
	// Back to normal state
	else if State
	{
		State--;
	}
}