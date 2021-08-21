/// @description Insert description here
// You can write your code in this editor
	
	Ysp  += Grv;
	PosX += Xsp;
	PosY += Ysp;
	x = floor(PosX);
	y = floor(PosY);
	
	if x < Camera.ViewX - 32 or x > Camera.ViewX + Game.Width  + 32
	or y < Camera.ViewY - 32 or y > Camera.ViewY + Game.Height + 32
	{
		instance_destroy();
	}
	
	if object_player_overlap(Hitbox)
	{
		player_damage(false, false, false);
	}