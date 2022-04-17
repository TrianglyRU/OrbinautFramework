/// @description Main
// You can write your code in this editor
	
	// Play animation
	switch Player.Animation
	{
		case AnimIdle:
		case AnimLookup:
		case AnimCrouch:	
			animation_play(spr_tails_tail_idle, 8, 0);
		break;
		case AnimSpin:
			animation_play(spr_tails_tail_type1, 4, 0);
		break;
		case AnimSpindash:
			animation_play(spr_tails_tail_type2, 4, 0); 
		break;
		case AnimPush:
		case AnimSkid:
			animation_play(spr_tails_tail_type3, 4, 0);
		break;
		case AnimFly:
			animation_play(spr_tails_tail_fly, Player.Ysp ? 2 : 1, 0);		
		break;
		case AnimFlyTired:
			animation_play(spr_tails_tail_fly, 2, 0);
		break;
		default:
			animation_play(spr_tails_tail_hidden, 0, 0);
	}
	
	if !Player.Spinning
	{
		VisualAngle = Player.VisualAngle;
	}
	else
	{
		if !Player.Grounded
		{
			// Get motion angle
			if Player.Facing == FlipRight
			{
				var Angle = point_direction(Player.PosX, Player.PosY, Player.PosX + Player.Xsp, Player.PosY + Player.Ysp);
			}
			else if Player.Facing == FlipLeft
			{
				var Angle = point_direction(Player.PosX + Player.Xsp, Player.PosY + Player.Ysp, Player.PosX, Player.PosY);
			}
			
			// Apply it
			if !global.SmoothRotation
			{
				VisualAngle = ceil((Angle - 22.5) / 45) * 45;
			}
			else
			{
				VisualAngle = Angle;
			}
		}
		else
		{	
			// Get floor angle
			var Angle = Player.Angle;
			
			// Apply regular classic-like rotation
			if !global.SmoothRotation
			{
				VisualAngle = ceil((Angle - 22.5) / 45) * 45;
			}
			
			// Apply smooth rotation
			else
			{
				/* Smooth rotation code by Nihil (NullSpace)
				Used with permission! */
				
				if Angle >= 35.16 and Angle <= 324.84
				{
					var TargetAngle  = Angle;
					var RotationStep = (abs(Player.Gsp) / 16 + abs(Player.Gsp) / 32 - 2) * -1
				}
				else
				{
					var TargetAngle  = 360;
					var RotationStep = (abs(Player.Gsp) / 16 - 2) * -1
				}
				VisualAngle = darctan2(dsin(TargetAngle) + dsin(VisualAngle) * RotationStep, dcos(TargetAngle) + dcos(VisualAngle) * RotationStep);
			}
		}
	}