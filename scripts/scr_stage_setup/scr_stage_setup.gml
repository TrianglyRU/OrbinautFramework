/// @function scr_stage_setup
function scr_stage_setup()
{
	var _animal_array =
	[                                        
		spr_obj_animal_cucky, spr_obj_animal_flicky, spr_obj_animal_pecky, spr_obj_animal_picky,
		spr_obj_animal_pocky, spr_obj_animal_ricky, spr_obj_animal_rocky
	];
	
	/// @method m_local_random_animals
	var m_local_random_animals = function(_animals)
	{
		var _length = array_length(_animals) - 1;
	    var _a1 = irandom(_length);
	    var _a2 = irandom(_length);
		
		while _a2 == _a1
		{
		    _a2 = irandom(_length);
		}
		
		return [_animals[_a1], _animals[_a2]];
	}
	
	// Stage setup
	switch room
	{
		case rm_stage_tsz0:
		
			m_stage_set(0, "TECH STADIUM", ACT_SINGLE, bgm_woofle, m_local_random_animals(_animal_array), 1024, 1536, rm_devmenu, true);
			
			player_spawn(112, 896, global.player_main, "Objects");
			player_spawn(96, 896, global.player_cpu, "Objects");
			
			var _bg_dist = dist_get_data(EFFECTDATA.LZBG);
			var _fg_dist = dist_get_data(EFFECTDATA.LZFG);
			
			dist_set_fg([], _fg_dist, -0.5, 0, room_height, ["GraphicsA", "AssetsA", "GraphicsB", "AssetsB"]);
			dist_set_bg(_bg_dist, _bg_dist, -0.25, 192, 348);

			pal_load(spr_pal_tsz_primary, spr_pal_tsz_secondary);
			collision_load_binary("widths_tsz", "heights_tsz", "angles_tsz", "CollisionA", "CollisionB");

			ani_add_sprite(spr_tsz_asset_flower, 12);
			
			// Background
			
			bg_add_layer(spr_tsz_bg_layer0, 0, 72, 0, 0, 0, 0, 0.350, 0);				// Far Horizon
			bg_set_perspective_x(0.200, 8);
			bg_add_layer(spr_tsz_bg_layer0, 72,  120, 72,  0,  0, 0, 0.225, 0);			// Far Buildings
			bg_add_layer(spr_tsz_bg_layer0, 192, 116, 192, 0,  0, 0, 0.275, 0);			// Far Mechanical Stuff
			bg_add_layer(spr_tsz_bg_layer0, 308, 8, 308, 0, 0, 0, 0.245, 0);			// Bottom Lights
			bg_set_perspective_x(0.315, 2);
			bg_add_layer(spr_tsz_bg_layer0, 316, 32, 316, 0, 0, 0, 0.345, 0);			// Bottom Tubes
			bg_set_perspective_x(0.750, 8);
			bg_add_layer(spr_tsz_bg_layer1, 0,   32,  0,   0, -0.10,  0, 0.375, 0);		// Discs 1
			bg_add_layer(spr_tsz_bg_layer1, 32,  32,  32,  0, -0.025, 0, 0.340, 0);		// Discs 2
			bg_add_layer(spr_tsz_bg_layer1, 80,  112, 80,  0,  0,     0, 0.300, 0);		// Close Buildings
			bg_add_layer(spr_tsz_bg_layer1, 208, 96,  208, 0,  0,     0, 0.345, 0);		// Close Mechanical Stuff	
			bg_add_layer(spr_tsz_bg_layer2, 0, 128, 192, 0, 0, 0, 0.300, 0);			// Water Layer
			bg_set_perspective_x(1.0, 2);
			bg_set_perspective_y(water_level_init);
			
		break;
	}
}