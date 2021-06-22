/// @description Insert description here
// You can write your code in this editor

	var add = AngOfst * Numb;
		
	var modeX = dsin(Parent.AngleX + add);
	
	var modeY = dcos(Parent.AngleY + add);
	//var modeY = abs(dcos(Parent.AngleY + add));
	//var modeY = dsin(Parent.AngleY + add);
	//var modeY = abs(dsin(Parent.AngleY + add));
	
	x = floor(Parent.x + modeX * 35);
	y = floor(Parent.y + modeY * 35 * dsin(Parent.Spin));
	var visualDepth = dsin(Parent.AngleX + add + 90);
	depth = Parent.depth + (Numb + 1) * (visualDepth >= 0 ? 1 : -1);
	image_index = visualDepth <= 0 ? 0 : 1;
	
	switch State
	{
		case 1:
			if visualDepth <= 0.8 and object_player_overlap(CollisionHitbox)
			{
				object_damage(false, false, false, false);
			}
		break;
		case 2:
			instance_create(x, y, DustExplosion);
			var Created = instance_create(x, y, Ring);
			with Created
			{
				object_set_solidbox(8, 8);
				object_set_depth(Player, true);
			
				// Set ring flags and speed
				Physical      = true;
				PickupTimeout = 16;
				Xsp			  = modeX;
				Ysp			  = 2 * modeY;
			}
				
			image_xscale = 0;
			image_yscale = 0;
			visible = false;
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