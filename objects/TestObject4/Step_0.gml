/// @description Insert description here
// You can write your code in this editor
	
	if hitbox_collision(Player, id)
	{
		if Player.Grounded and Player.Inertia > 0 and round(Player.Angle/90) % 4 = RangeRWall 
		{
			Player.Angle = 90;
		}
	}