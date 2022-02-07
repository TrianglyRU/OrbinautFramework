function ObjSuperStarMain()
{
	// Follow player if flag is set (first star spawned)
	if State
	{
		x = floor(Player.PosX);
		y = floor(Player.PosY);
	}
	
	// Destroy and create a new object on animation end
	if image_index == 5
	{
		if Player.SuperState
		{
			if abs(Player.Inertia) >= Player.TopAcc
			{
				instance_create(Player.PosX, Player.PosY, SuperStar);
			}
		}
		instance_destroy();
	}	
}