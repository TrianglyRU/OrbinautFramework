/// @function scr_player_debug_mode_init
function scr_player_debug_mode_init()
{
	debug_mode_ind = 0;
	debug_mode_spd = 0;
	debug_mode_array =
	[	
		obj_ring,
		obj_itembox,
		obj_spring_v_red,
		obj_spring_h_red,
		obj_spikes_v,
		obj_spikes_h,
	];
	
	var _arr = debug_mode_array;
	
	switch room
	{
		case rm_stage_tsz0:
			
			array_push(_arr, obj_block_tsz);
			array_push(_arr, obj_breakable_wall_tsz);
			array_push(_arr, obj_breakable_wall_k_tsz);
			array_push(_arr, obj_falling_floor_tsz);
			array_push(_arr, obj_platform_swing_tsz);
			array_push(_arr, obj_platform_tsz);
			array_push(_arr, obj_pushable_block_tsz);
			array_push(_arr, obj_buzzer);
			array_push(_arr, obj_chopchop);
			array_push(_arr, obj_masher);
			array_push(_arr, obj_motobug);
			array_push(_arr, obj_sol);
			
		break;
	}
}