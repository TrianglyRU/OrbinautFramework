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
		case AnimRoll:
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
			animation_play(spr_tails_tail_hidden, 1, 0);
		break;
	}
	
	// If we're not rolling or jumping, use current visual angle
	if !Player.Spinning
	{
		VisualAngle = Player.VisualAngle;
	}
		
	// In case we're rolling or jumping
	else
	{
		// Get movement angle based on current and next frame position
		if !Player.Grounded
		{
			if Player.Facing == FlipRight
			{
				VisualAngle = point_direction(Player.PosX, Player.PosY, Player.PosX + Player.Xsp, Player.PosY + Player.Ysp);
			}
			else if Player.Facing == FlipLeft
			{
				VisualAngle = point_direction(Player.PosX + Player.Xsp, Player.PosY + Player.Ysp, Player.PosX, Player.PosY);
			}
		}
		
		// Apply smooth rotation
		else if Game.SmoothRotation
		{	
			/* Smooth rotation code by Nihil (NullSpace)
			Used with permission! */		
				   
			if Player.Angle >= 23.91 and Player.Angle <= 337.5
			{
				var TargetAngle  = Player.Angle;
				var RotationStep = (abs(Player.Inertia) / 16 + abs(Player.Inertia) / 32 - 2) * -1
			}
			else
			{
				var TargetAngle  = 360;
				var RotationStep = (abs(Player.Inertia) / 16 - 2) * -1
			}
			VisualAngle = darctan2(dsin(TargetAngle) + dsin(VisualAngle) * RotationStep, dcos(TargetAngle) + dcos(VisualAngle) * RotationStep);
		}

		// If smooth rotation is disabled, use this table for tails visual angle
		else
		{
			if (Player.Angle > 334.5 or Player.Angle < 25.5)  VisualAngle = 360;
			if (Player.Angle > 25.5 and Player.Angle < 75)	  VisualAngle = 45; 
			if (Player.Angle > 75   and Player.Angle < 105)	  VisualAngle = 90; 
			if (Player.Angle > 105  and Player.Angle < 155)   VisualAngle = 135; 
			if (Player.Angle > 155  and Player.Angle < 205)   VisualAngle = 180; 
			if (Player.Angle > 205  and Player.Angle < 255)   VisualAngle = 225; 
			if (Player.Angle > 255  and Player.Angle < 285)   VisualAngle = 270; 
			if (Player.Angle > 285  and Player.Angle < 334.5) VisualAngle = 305;
		}	
	}	
}