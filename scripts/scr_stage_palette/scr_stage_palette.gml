/// @function scr_stage_palette
function scr_stage_palette()
{
	switch room
	{
		case rm_stage_tsz0:
		
			pal_run_rotation([14, 15, 16, 17], 1, 4, 6);
			pal_run_rotation([18], 1, 6, 8);
			pal_run_rotation([19], 1, 6, 4);
			pal_run_rotation([20], 1, 15, 12);
			
			if c_framework.frame_counter % 6 == 0
			{
				pal_set_index([21], irandom_range(1, 3));
			}
			
		break;
	}
}
