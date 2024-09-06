/// @function scr_player_update_collision
function scr_player_update_collision()
{
	gml_pragma("forceinline");
	
	// Set the basic solidbox
	obj_set_solid(radius_x_normal + 1, radius_y);

	// Handle regular hitbox
	if animation != ANI_DUCK || global.player_physics >= PHYSICS_S3
	{
		obj_set_hitbox(8, radius_y - 3);
	}
	else if PlayerType != PLAYER_TAILS && PlayerType != PLAYER_AMY
	{
		obj_set_hitbox(8, 10, 0, 6);
	}
	
	// Handle extra hitbox
	if action == ACTION_HAMMERSPIN
	{
		obj_set_hitbox_ext(25, 25);
	}
	else if animation == ANI_HAMMERDASH
	{
		switch ani_get_frame() % 4
		{
			case 0:
				obj_set_hitbox_ext(16, 16, 6 * facing, 0);
			break;
			case 1:
				obj_set_hitbox_ext(16, 16, -7 * facing, 0);
			break;
			case 2:
				obj_set_hitbox_ext(14, 20, -4 * facing, -4);
			break;
			case 3:
				obj_set_hitbox_ext(17, 21, 7 * facing, -5);
			break;
		}
	}
	else if shield_state == SHIELD_STATE_DOUBLESPIN
	{
		obj_set_hitbox_ext(24, 24);
	}
	else
	{
		obj_set_hitbox_ext(0, 0);
	}
	
	// Always visualise the hitbox if debugging
	if global.dev_mode && global.debug_collision == 2
	{
		var _ds_list = c_framework.collision.ds_interact;
		var _data = data_interact;
		
		var _x = floor(x);
		var _y = floor(y);
		var _l = _x - _data.radius_x + _data.offset_x;
		var _r = _x + _data.radius_x + _data.offset_x;
		var _t = _y - _data.radius_y + _data.offset_y;
		var _b = _y + _data.radius_y + _data.offset_y;
		var _l_ext = _x - _data.radius_x_ext + _data.offset_x_ext;
		var _r_ext = _x + _data.radius_x_ext + _data.offset_x_ext;
		var _t_ext = _y - _data.radius_y_ext + _data.offset_y_ext;
		var _b_ext = _y + _data.radius_y_ext + _data.offset_y_ext;
		
		ds_list_add(_ds_list, _l_ext, _t_ext, _r_ext, _b_ext, $0000DC, id, _l, _t, _r, _b, $FF00DC, id);
	}
}