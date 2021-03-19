function PlayerTailsHandle()
{
	object_set_depth(Player, false);
	
	switch Player.Animation
	{
		case AnimIdle:
		{			
			animation_play(spr_tails_tail_idle, 1, 1);
			image_angle = 0;
		}
		break;
		case AnimWalk:
		case AnimRun:
		{
			animation_play(spr_tails_tail_run, 1, 1);
			image_angle = Player.VisualAngle;
		}
		break;
		case AnimRoll:
		{
			animation_play(spr_tails_tail_roll, 1, 1);
			if Player.Grounded
			{
				image_angle = Player.Angle;
			}
			else
			{
				if Player.Facing = 1
				{
					image_angle = point_direction(Player.PosX, Player.PosY, Player.PosX + Player.Xsp, Player.PosY + Player.Ysp);
				}
				else
				{
					image_angle = point_direction(Player.PosX + Player.Xsp, Player.PosY + Player.Ysp, Player.PosX, Player.PosY);
				}
			}
		}
	}
	
	x = floor(Player.PosX);
	y = floor(Player.PosY);
	image_xscale = Player.Facing;
	
}