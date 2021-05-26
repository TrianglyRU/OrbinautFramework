/// @description Insert description here
// You can write your code in this editor

	var add = 45 * Numb;
		
	var modeX = sin(Parent.AngleX + add);
	
	var modeY = cos(Parent.AngleY + add);
	//var mode = abs(cos(Parent.AngleY + add));
	//var mode = sin(Parent.AngleY + add);
	//var mode = abs(sin(Parent.AngleY + add));
	
	if !Destroy
	{	
		x = floor(Parent.x + modeX * 35);
		y = floor(Parent.y + modeY * 35 * dsin(Parent.Spin));
		var visualDepth = sin(Parent.AngleX + add + 90);
		depth = Parent.depth + (Numb + 1) * (visualDepth >= 0 ? 1 : -1);
	
		if visualDepth <= 0.8 and object_player_overlap(CollisionHitbox)
		{
			object_damage(false, false, false);
		}
	}
	else
	{
		object_spawn(x, y, DustExplosion);
		audio_sfx_play(sfxDestroy, false, false);
		var Created = object_spawn(x, y, Ring);
		with Created
		{
			object_set_solidbox(8, 8);
			object_set_depth(Player, true);
			
			// Set ring flags and speed
			Physical      = true;
			PickupTimeout = 64;
			Xsp			  = 3 * modeX;
			Ysp			  = 3 * modeY;
		}
				
		instance_destroy();
	}