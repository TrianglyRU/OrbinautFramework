/// @description Insert description here
// You can write your code in this editor
	
	Ysp  += Grv;
	PosX += Xsp;
	PosY += Ysp;
	x = floor(PosX);
	y = floor(PosY);
	
	if object_player_overlap(CollisionHitbox)
	{
		//object_act_badnik(false, false);
		object_damage(false, false, false);
	}