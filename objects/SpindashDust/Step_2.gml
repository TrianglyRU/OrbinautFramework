/// @description Main
// You can write your code in this editor
	
	x = floor(Player.PosX);
	y = floor(Player.PosY + Player.RadiusY);	
	
	// Destroy if not spindashing anymore
	if Player.SpindashRev == -1
	{
		instance_destroy();
	}