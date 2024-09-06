switch state
{
    case GIANTRING_STATE_IDLE:
        
        var _player = player_get(0);
        
        if !obj_check_hitbox(_player)
        {
            break;
        }
        
        audio_play_sfx(sfx_ring_giant);
        
        // Register the giant ring as collected
        ds_list_add(global.ds_giant_rings, id);
        
        // Give 50 rings all the Chaos Emeralds are collected
        if global.emerald_count >= 7
        {
            global.player_rings = min(global.player_rings + 50, 999);
            instance_destroy();
			
            break;
        }
        
        ani_start(spr_obj_giant_ring_flash, 2, 0, 7, [0, 1, 2, 3, 2, 1, 0, 4]);
        
        _player.visible = false;
        _player.state = PLAYER_STATE_NO_CONTROL;
        
        // Buffer player and stage data
        global.giant_ring_data =
        [
            x, y, c_framework.frame_counter, c_stage.bound_top[0], c_stage.bound_bottom[0], c_stage.bound_left[0], c_stage.bound_right[0]
        ];
        
        state = GIANTRING_STATE_ENTRY;
		
    break;
    
    case GIANTRING_STATE_ENTRY:
    
		// Flip the image scale if the animation frame is past a certain point
        if ani_get_frame() > 3
        {
            image_xscale = -1;
        }
        
        if !ani_get_ended()
        {
            break;
        }
        
        visible = false;
        
        if --wait_timer == 0
        {
            state = GIANTRING_STATE_TRANSITION;
            
            // Allow the object to keep running its code
            obj_set_culling(CULLING.NONE);
        
            audio_stop_bgm(0.5);
            audio_play_sfx(sfx_warp);
            fade_perform_white(FADEROUTINE.OUT, 1);
        }
        
    break;
    
    case GIANTRING_STATE_TRANSITION:
    
        // Goto Special Stage once the fade effect is complete
        if c_framework.fade.state == FADESTATE.PLAINCOLOUR && !audio_is_playing(sfx_warp)
        {
            room_goto(rm_special);
        }
   
	break;    
}