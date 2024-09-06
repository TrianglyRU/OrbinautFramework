if state == ITEMBOX_STATE_DESTROYED
{
    exit;
}

// Update card drawing state
draw_card = card_index > 0 && ani_get_timer() != 3;

if card_index >= 9
{
    card_index = 9 + player_get(0).PlayerType;
}

for (var p = 0; p < PLAYER_COUNT; p++)
{
    var _player = player_get(p);
    var _can_destroy = false;
    
	// Handle interaction with the lead player
    if p == 0
    {
        if !obj_check_solid(_player, SOLIDCOLLISION.TOP)
        {
            if _player.action == ACTION_GLIDE && _player.action_state != GLIDE_STATE_FALL || _player.animation == ANI_HAMMERDASH || _player.animation == ANI_SPIN
            {
                _can_destroy = true;
            }
        }
        
        if obj_check_hitbox(_player, true)
        {
			// Bounce up. You can leave only 'Destroy' block of code to get SK/S3&K Item Box behaviour
            if _player.vel_y < 0 && _player.data_interact.radius_x_ext == 0
            {
                if floor(_player.y) - floor(y + 16) >= 0
                {
                    _player.vel_y *= -1;
                    vel_y = -1.5;
                    state = ITEMBOX_STATE_FALL;
                }
            }
			
			// Destroy
            else if _can_destroy
            {
                if !_player.is_grounded
                {
                    _player.vel_y *= -1;
                }
                
                draw_card = false;
                state = ITEMBOX_STATE_DESTROYED;
                
                obj_set_culling(CULLING.DISABLE);
                instance_create(x, y - 3, obj_itemcard, { image_index: card_index, depth: depth - 1 });
                instance_create(x, y, obj_explosion_dust);
                ani_update(0, true, [], 2, 2);
				input_set_rumble(_player.player_index, 0.10, INPUT_RUMBLE_LIGHT, INPUT_RUMBLE_LIGHT);
                
				// Release all players attached to this object
                with obj_player if on_object == other.id
                {
                    on_object = noone;
                    is_grounded = false;
                }
            
                break;
            }
        }
    }
    
    // Act as solid when not falling down and cannot be destroyed
    if state == ITEMBOX_STATE_IDLE && !_can_destroy
    {
        obj_act_solid(_player, SOLIDOBJECT.ITEMBOX);
    }
}

// Handle item box falling
if state == ITEMBOX_STATE_FALL
{
    y  += vel_y;
    vel_y += 0.21875;
    
    var _floor_dist = tile_find_v(x, y + 14, DIRECTION.POSITIVE, TILELAYER.MAIN)[0];
    if _floor_dist < 0
    {
        y += _floor_dist;
        state = ITEMBOX_STATE_IDLE;
    }
}