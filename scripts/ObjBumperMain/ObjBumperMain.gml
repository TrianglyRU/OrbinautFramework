function ObjBumperMain()
{
	// Bounce on collision
	if object_check_overlap(Hitbox)
	{
		if Ready
		{
			// Set player speeds based on angle
			var Angle  = point_direction(floor(Player.PosX), floor(Player.PosY), x, y);
			Player.Xsp = -7 * dcos(Angle);
			Player.Ysp =  7 * dsin(Angle);
			
			// Add score and create score object
			if ScoreLimit
			{
				Player.Score += 10;
				instance_create(x, y, ComboScore);
			}
			ScoreLimit--;
			
			// Play sound
			audio_sfx_play(sfxBumper, false);
			
			// Switch to the next frame
			image_index = 1;
			
			Ready = false;
		}
	}
	else
	{
		Ready = true;
	}
	
	// Play animation
	if image_index > 0
	{
		animation_play(sprite_index, 4, 0);
	}
}