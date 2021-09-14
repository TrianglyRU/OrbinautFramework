function ObjBumperMain()
{
	// Bounce on collision
	if object_check_overlap(Hitbox)
	{
		if !State
		{
			// Set player speeds based on angle
			var Angle = point_direction(x, y, floor(Player.PosX), floor(Player.PosY));
			
			Player.Xsp     = 7 *  dcos(Angle);
			Player.Ysp     = 7 * -dsin(Angle);
			Player.Jumping = false;
			
			// Add points to player's score
			if ScoreLimit
			{
				var  ThisObject = id;
				var  Object = instance_create(x, y, ComboScore);
				with Object
				{
					object_set_depth(ThisObject, id);
				}
			}
			ScoreLimit--;
			
			// Play sound
			audio_sfx_play(sfxBumper, false);
			
			// Switch to the next frame
			image_index = 1;
			
			// Increment state
			State++;
		}
	}
	
	// Back to normal state
	else if State
	{
		State--;
	}
	
	// Play animation
	if image_index > 0
	{
		animation_play(sprite_index, 4, 0);
	}
}