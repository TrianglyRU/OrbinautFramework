/// @description Insert description here
// You can write your code in this editor
	
	if Player.BarrierType == BarrierNormal
	{
		image_blend = c_blue;
		gpu_set_blendmode(bm_add);
		draw_self();
		gpu_set_blendmode(bm_normal);
	}
	else
	{
		draw_self();
	}