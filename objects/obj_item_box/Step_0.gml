if state == ITEM_BOX_STATE.DESTROYED
{
	return;
}

if itembox_type >= 9
{
	itembox_type = 9 + global.player_main;
}

FOR_EACH_PLAYER
{
    var _player = player_get(_p);
    var _can_destroy = false;
	var _extra_hitbox_active = _player.is_extra_hitbox_active();
	
	if _player.on_object != id
	{
		if _p == 0 && (_player.is_true_glide() || _player.animation == ANIM.SPIN || _extra_hitbox_active)
		{
			_can_destroy = true;
		}
	}
	
	if collision_player(_player, true, bbox_left - 1, bbox_top - 1, bbox_right + 1, bbox_bottom + 1)
	{
		// Bounce up (commenting this block results in SK/S3K Item Box behaviour)
		if _player.vel_y < 0 && !_extra_hitbox_active
		{
			if floor(_player.y) >= floor(y) + 16
		    {
		        _player.vel_y *= -1;
		        vel_y = -1.5;
		        state = ITEM_BOX_STATE.FALLING;
		    }
		}
		
		// Destroy
        else if _can_destroy
	    {
			state = ITEM_BOX_STATE.DESTROYED;
			
	        if !_player.is_grounded
	        {
	            _player.vel_y *= -1;
	        }
            
			with obj_player
	        {
				release_from_solid(other.id);
	        }
			
			if culler.action != CULL_ACTION.DESTROY
			{
				culler.action = CULL_ACTION.PAUSE;
			}
			
			animator.start(spr_item_box_destroyed, 0, 2, 3);
			
	        with instance_create(x, y - 3, obj_item_card)
			{
				image_index = other.itembox_type;
			}
			
	        instance_create(x, y, obj_explosion_dust);
			audio_sfx_play(snd_destroy);
			input_set_rumble(_p, 0.05, INPUT_RUMBLE_MEDIUM);	
			
	        break;
	    }
	}
	
    if state < ITEM_BOX_STATE.FALLING && !_can_destroy
    {
		solid_object(_player, SOLID_TYPE.ITEM_BOX);
    }
}

if state == ITEM_BOX_STATE.FALLING
{
    y += vel_y;
    vel_y += GLOBAL_PARAM_GRV;
    
    var _floor_dist = tile_raycast_v(x, bbox_bottom - 1, 1)[0];
	
    if _floor_dist < 0
    {
        y += _floor_dist;
        state = ITEM_BOX_STATE.IDLE_LANDED;
    }
}