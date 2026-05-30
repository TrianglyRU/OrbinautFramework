if state != STAR_POST_STATE.IDLE
{
	return;
}

var _checkpoint_data = global.checkpoint_data;

if array_length(_checkpoint_data) > 0 && _checkpoint_data[7] >= iv_index
{
	state = STAR_POST_STATE.ACTIVE;
	lamp_obj.activate();
	
	return;
}

var _player = player_get(0);

if _player.state < PLAYER_STATE.NO_INTERACT && point_in_rectangle(floor(_player.x), floor(_player.y), bbox_left, bbox_top, bbox_right - 1, bbox_bottom - 1)
{
	global.checkpoint_data =
	[
		x,
		y,
		obj_game.frame_counter, 
		obj_rm_stage.top_bound[0], 
		obj_rm_stage.bottom_bound[0], 
		obj_rm_stage.left_bound[0], 
		obj_rm_stage.right_bound[0],
		iv_index
	];
	
	state = STAR_POST_STATE.ACTIVE;
	lamp_obj.state = LAMP_STATE.ROTATE;
	
	if global.player_rings >= 20
	{
		for (var _i = 0; _i < 4; _i++)
		{
			with instance_create(x, y - 50, obj_star_post_star)
			{
				star_index = _i;
				array_push(other.star_objs, id);
			}
		}
	}

	audio_sfx_play(snd_star_post);
}