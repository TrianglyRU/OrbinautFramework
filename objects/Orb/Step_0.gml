/// @description Insert description here
// You can write your code in this editor

	var add = 60 * Numb;
		
	var modeX = dsin(Parent.AngleX + add);
	
	var modeY = dcos(Parent.AngleY + add);
	//var mode = abs(dcos(Parent.AngleY + add));
	//var mode = dsin(Parent.AngleY + add);
	//var mode = abs(dsin(Parent.AngleY + add));
	
	switch State
	{
		case 1:
			x = floor(Parent.x + modeX * 35);
			y = floor(Parent.y + modeY * 35 * dsin(Parent.Spin));
			var visualDepth = dsin(Parent.AngleX + add + 90);
			depth = Parent.depth + (Numb + 1) * (visualDepth >= 0 ? 1 : -1);
			image_index = visualDepth <= 0 ? 0 : 1;
			if visualDepth <= 0.8 and object_player_overlap(CollisionHitbox)
			{
				object_damage(false, false, false, false);
			}
		break;
		case 2:
			object_spawn(x, y, DustExplosion);
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
				
			image_xscale = 0;
			image_yscale = 0;
			visible = false;
			x = floor(Parent.x + modeX * 35);
			y = floor(Parent.y + modeY * 35 * dsin(Parent.Spin));
			var visualDepth = dsin(Parent.AngleX + add + 90);
			depth = Parent.depth + (Numb + 1) * (visualDepth >= 0 ? 1 : -1);
			image_index = visualDepth <= 0 ? 0 : 1;
			State = 0;
		break;
		case 3:
			visible = true;
			if image_xscale < 1
			{
				image_xscale += 0.02;
				image_yscale += 0.02;
			} 
			else 
			State = 1;
		break;
	}