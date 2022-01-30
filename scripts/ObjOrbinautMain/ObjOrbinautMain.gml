function ObjOrbinautMain()
{
	// Act as enemy
	object_act_enemy(TypeBadnik);
	
	// Move Orbinaut
	PosX += image_xscale / 4;
	x     = floor(PosX);
	
	// Update orbs angle
	Angle = (Angle + 4 * image_xscale) mod 360;
	
	// Update orbs position
	for (var i = 0; i < 4; i++)
	{
		var ThisObject = id;
		var NewAngle   = Angle + 90 * i;
		with Orb[i]
		{
			x = ThisObject.x + 16 * dsin(NewAngle);
			y = ThisObject.y + 16 * dcos(NewAngle);
		}
	}
}