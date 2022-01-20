function ObjTailsObjectMain()
{
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
		break;
	}
	
	// If we're not rolling or jumping, use player's current visual angle
	if !Player.Spinning
	{
		VisualAngle = Player.VisualAngle;
	}
		
	// In case we're rolling or jumping
	else
	{
		// Get motion angle when airborne
		if !Player.Grounded
		{
			if Player.Facing == FlipRight
			{
				Angle = point_direction(Player.PosX, Player.PosY, Player.PosX + Player.Xsp, Player.PosY + Player.Ysp);
			}
			else if Player.Facing == FlipLeft
			{
				Angle = point_direction(Player.PosX + Player.Xsp, Player.PosY + Player.Ysp, Player.PosX, Player.PosY);
			}
			
			// If smooth rotation is disabled, 8-angle rotation
			if !Game.SmoothRotation
			{
				VisualAngle = ceil((Angle - 22.5) / 45) * 45;
			}
			
			// Else use motion angle
			else
			{
				VisualAngle = Angle;
			}
		}
		else
		{	
			// Get floor angle if grounded
			Angle = Player.Angle;
			
			// If smooth rotation is disabled, 8-angle rotation
			if !Game.SmoothRotation
			{
				VisualAngle = ceil((Angle - 22.5) / 45) * 45;
			}
			
			// Else calculate visual angle
			else
			{
				/* Smooth rotation code by Nihil (NullSpace)
				Used with permission! */
				
				if Angle >= 33.75 and Angle <= 326.25
				{
					var TargetAngle  = Angle;
					var RotationStep = (abs(Player.Inertia) / 16 + abs(Player.Inertia) / 32 - 2) * -1
				}
				else
				{
					var TargetAngle  = 360;
					var RotationStep = (abs(Player.Inertia) / 16 - 2) * -1
				}
				VisualAngle = darctan2(dsin(TargetAngle) + dsin(VisualAngle) * RotationStep, dcos(TargetAngle) + dcos(VisualAngle) * RotationStep);
			}
		}
	}
	
	// If player is not visibile, make us invisible too (is not for invincibility frames!)
	visible = Player.visible;
}