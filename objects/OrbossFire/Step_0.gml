/// @description Insert description here
// You can write your code in this editor

	Timer++;	
	if Timer == 8 {
		Timer = 0;
		image_xscale = -image_xscale;
	}
	
	if Bullet
	{
		x = Parent.x;
		y = Parent.y;
		if !image_xscale
		{
			image_xscale += 0.1;
		}
	}
	else
	{
		image_xscale -= 0.1 * sign(image_xscale);
		image_yscale -= 0.1;
	
		if (image_xscale == 0) instance_destroy();
	}
	
	if object_player_overlap(CollisionHitbox)
	{
		object_damage(false, false, false, false);
	}