/// @description Insert description here
// You can write your code in this editor

	ImgTimer++;	
	if ImgTimer == 8 {
		ImgTimer = 0;
		image_xscale = -image_xscale;
	}
	
	if Parent != 0
	{
		if Timer
		{
			Timer--;
			x = Parent.x + round(40 * dsin(Angle + 180) * ((Parent.MaxHP - Parent.HP - 1) / 4 + 1));
			y = Parent.y + round(40 * dcos(Angle + 180));
			if abs(image_xscale) < 1
			{
				image_xscale += 0.1 * (image_xscale >= 0 ? 1 : -1);
				image_yscale += 0.1;
			}
			if (!Timer) Direction = point_direction(x, y, Player.PosX + Player.Xsp * 8, Player.PosY + Player.Ysp * 8) + 90;
		}
		else
		{
			Accel += 0.2;
			x += round(Accel * dsin(Direction));
			y += round(Accel * dcos(Direction));
			var CamY = Screen.CameraY;
			var CamX = Screen.CameraX;
			if x < CamX - 128 or y < CamY - 32 or x > CamX + Screen.Width + 128 or y > CamY + Screen.Height + 32
			{
				instance_destroy();
			}
		}
	}
	else
	{
		image_xscale -= 0.1 * sign(image_xscale);
		image_yscale -= 0.1;
	
		if (image_xscale == 0) instance_destroy();
	}
	
	if object_player_overlap(CollisionHitbox)
	{
		object_damage(false, false, false, false);
	}