function ObjProjectileMain()
{
	// Move object
	PosX += Xsp;
	PosY += Ysp;
	Ysp  += Grv;
	
	// Update object position
	x = floor(PosX);
	y = floor(PosY);
	
	if Xsp != 0 and Ysp != 0 and object_check_overlap(TypeHitbox)
	{
		// Check if object should bounce off player
		if Player.BarrierType > BarrierNormal
		{
			// Get angle
			var X	  = floor(Player.PosX) - x;
			var Y	  = floor(Player.PosY) - y;
			var Angle = darctan2(Y, X);
			
			// Reflect projectile
			Xsp = dcos(Angle) * -8;
			Ysp = dsin(Angle) * -8;
			Grv = 0;
		}
		
		// Else damage player
		else
		{
			player_damage(false, false, false);
		}
	}
}