/// @description Main
// You can write your code in this editor
	
	// Move object
	PosX += Xsp;
	PosY += Ysp;
	Ysp  += Grv;
	
	x = floor(PosX);
	y = floor(PosY);
	
	if object_check_player(ColHitbox)
	{
		var BasicCheck = Player.BarrierType > BarrierNormal;
		var TailsCheck = Player.FlightState	and floor(Player.PosY) > y;
		var KnuxCheck  = Player.GlideState == GlideAir and sign(x - floor(Player.PosX)) == sign(Player.Facing);
		
		if BasicCheck or TailsCheck or KnuxCheck
		{
			// Reflect projectile
			if !State
			{
				var X	  = floor(Player.PosX - x);
				var Y	  = floor(Player.PosY - y);
				var Angle = darctan2(Y, X);
			
				Xsp    = dcos(Angle) * -8;
				Ysp    = dsin(Angle) * -8;
				Grv    = 0;
				State += 1;
			}
		}
		else if !Player.DoubleSpinAttack
		{
			player_damage(false, false, false);
		}
	}