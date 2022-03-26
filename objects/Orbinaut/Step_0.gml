/// @description Main
// You can write your code in this editor
	
	// Act as badnik and exit if it was destroyed
	if object_act_enemy(EnemyBadnik)
	{
		return;
	}
	
	// Move
	PosX += image_xscale / 4;
	x     = floor(PosX);
	
	// Update orbs angle and position
	Angle = (Angle + 4 * image_xscale) mod 360;

	for (var i = 0; i < 4; i++)
	{
		var ThisObject = id;
		var NewAngle   = Angle + 90 * i;
		
		with Orb[i]
		{
			x = round(ThisObject.x + 16 * dsin(NewAngle));
			y = round(ThisObject.y + 16 * dcos(NewAngle));
		}
	}