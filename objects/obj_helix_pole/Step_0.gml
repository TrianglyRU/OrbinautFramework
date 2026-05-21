instance_animate(obj_game.frame_counter, 12);

// Offset the hitbox each animation frame
offset_x = 16 * image_index;

FOR_EACH_PLAYER
{
	var _player = player_get(_p);
	
	if collision_player(_player,, bbox_left + offset_x,, bbox_right + offset_x,)
	{
		_player.hurt(id);
	}
}