switch state
{
    case FALLING_FLOOR_STATE.IDLE:
        
        FOR_EACH_PLAYER
        {
            var _player = player_get(_p);
			
			solid_object(_player, SOLID_TYPE.TOP);
			
            if !fall_flag
            {
                fall_flag = _player.on_object == id;
            }
        }
        
        if !fall_flag || wait_timer > 0
        {
            if fall_flag
            {
                wait_timer--;
            }
            
            break;
        }
        
        var _is_flipped = image_xscale < 0;
        var _i = _is_flipped ? width - 16 : 0;  
		var _column = 0;
		var _row = 0;
		var _wait_timer = 0;
		
        while true
        {
            for (var _j = height - 16; _j >= 0; _j -= 16)
            {
				_wait_timer = _row * 2 + _column * 4;
				_row++;
				
				instance_create_piece(corner_x + _i + 8, corner_y + _j + 8, sprite_index, image_index, _is_flipped ? width - _i - 16 : _i, _j, 16, 16, 0, 0, _wait_timer, _is_flipped, false, false);
            }
            
            // Move to the next piece
            _i = _is_flipped ? _i - 16 : _i + 16;
			_column++;
			_row = 0;
            
            if _i < 0 || _i >= width
            {
                break;
            }
        }
        
        visible = false;
        state = FALLING_FLOOR_STATE.FALL;
        wait_timer = _wait_timer;
		
		FOR_EACH_PLAYER
		{
			if solid_touch[_p] == SOLID_TOUCH.TOP
			{
				input_set_rumble(_p, 0.65, INPUT_RUMBLE_STRONG);
			}
		}
		
		audio_sfx_play(snd_break_ledge);

    break;
	
    case FALLING_FLOOR_STATE.FALL:
	
        FOR_EACH_PLAYER
		{
			solid_object(player_get(_p), SOLID_TYPE.TOP_NO_LAND);
		}
		
		if wait_timer > 0
		{
			wait_timer--;
		}
		else
		{
			with obj_player
			{
				release_from_solid(other.id);
			}
			
			state = FALLING_FLOOR_STATE.DESTROYED;
		}
		
    break;
}