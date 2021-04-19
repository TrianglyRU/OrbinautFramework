/// @description Insert description here
// You can write your code in this editor
	
	if Player.Angle == 90 and Player.Grounded
	{
		if object_check_overlap(CollisionTriggerbox)
		{
			Player.Grounded = false;
		}
	}