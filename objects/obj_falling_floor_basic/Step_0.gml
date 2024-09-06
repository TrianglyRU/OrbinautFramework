switch state
{
    case FALLING_FLOOR_STATE_IDLE:
        
        // Check if players are on the object and set the fall flag
        for (var p = 0; p < PLAYER_COUNT; p++)
        {
            var _player = player_get(p);

            obj_act_solid(_player, SOLIDOBJECT.TOP);
            
            if !fall_flag
            {
                fall_flag = obj_check_solid(_player, SOLIDCOLLISION.TOP);
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
        
        // Initialise variables for fragment creation
        var _is_flipped = image_xscale < 0;
        var i = _is_flipped ? 0 : width - 16;
        
        // Create fragments
        while true
        {
            for (var j = height - 16; j >= 0; j -= 16)
            {
                fragment_count++;
                    
                instance_create(corner_x + i + 8, corner_y + j + 8, obj_fragment,
                {
                    WaitTime: fragment_count * 2,
                    Sprite: sprite_index,
                    X: _is_flipped ? width - i - 16 : i,
                    Y: j,
                    Width: 16,
                    Height: 16,
                    FlipX: _is_flipped
                });
            }
            
            // Move to the next piece
            i = _is_flipped ? i + 16 : i - 16;
            
            // Exit if out of bounds
            if (i < 0 || i > width)
            {
                break;
            }
        }
        
        // Hide the floor and play break sound
        visible = false;
        audio_play_sfx(sfx_break_ledge);
        
        state = FALLING_FLOOR_STATE_FALL;
        wait_timer = fragment_count * 2;

    break;
    
    case FALLING_FLOOR_STATE_FALL:
    
		// When falling apart, act solid only for the players already standing on the object
        for (var p = 0; p < PLAYER_COUNT; p++)
        {
            obj_act_solid(player_get(p), SOLIDOBJECT.TOP, SOLIDATTACH.NONE);
        }
        
        if wait_timer > 0
        {
            wait_timer--;
            break;
        }
        
        // Release all players attached to this object
        with obj_player if on_object == other.id
        {
            on_object = noone;
            is_grounded = false;
        }
        
        state++;
        
    break;
}