/// @description Draw
// You can write your code in this editor
	
	// Draw starpost
	draw_self();
	
	// Draw lamp
	if State == 1
	{
		draw_sprite(spr_obj_starpost_lamp, image_index, x + dsin(Angle) * 12, y + dcos(Angle) * 12 - 12);
	}