/// @description Insert description here
// You can write your code in this editor
	
	if object_player_overlap(CollisionHitbox)
	{
		if Ready
		{
			if Player.Grounded
			{
				Player.Inertia = -7 * sign(Player.Inertia);
			}
			else
			{
				var Ang = point_direction(Player.PosX, Player.PosY, x, y);
				Player.Xsp = -7 * dcos(Ang);
				Player.Ysp =  7 * dsin(Ang);
			}
			
			audio_sfx_play(sfxBumper, false);
			
			if !AnimTimer 
			{
				AnimTimer = 18;
			}

			if ScoreLimit
			{
				ScoreLimit--;
				Player.Score += 10;
				instance_create(x, y, ComboScore);
			}
			
			Ready = false;
		}
	}
	else
	{
		Ready = true;
	}
	
	if AnimTimer
	{
		AnimTimer--;
		switch AnimTimer
		{
			case 17: image_index = 1 break;
			case 13: image_index = 2 break;
			case  9: image_index = 1 break;
			case  5: image_index = 2 break;
			case  0: image_index = 0 break;
		}
	}