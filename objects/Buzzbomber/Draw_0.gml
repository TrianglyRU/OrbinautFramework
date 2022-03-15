/// @description Draw
// You can write your code in this editor
	
	// Draw projectile
	if State == 2
	{
		if Timer < 60 and Timer > 43
		{
			var Frame = Timer > 51 ? 0 : 1;	
			draw_sprite_ext(spr_obj_buzzbomber_shot, Frame, x + 28 * image_xscale, y + 27, image_xscale, 1, 0, c_white, 1);
		}
	}
	
	// Draw object
	draw_self();