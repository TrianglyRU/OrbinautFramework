if !visible
{
	FOR_EACH_PLAYER
	{
		var _player = player_get(_p);
		
		if _player.state < PLAYER_STATE.NO_INTERACT && point_in_rectangle(floor(_player.x), floor(_player.y), bbox_left, bbox_top, bbox_right - 1, bbox_bottom - 1)
		{
			global.score_count += power(10, image_index + 2);
			visible = true;
			culler.action = CULL_ACTION.DESTROY;
			
			audio_sfx_play(snd_points);
			
			break;
		}
	}
}
else if --wait_timer < 0
{
	instance_destroy();
}