switch state
{
    case GIANT_RING_STATE.IDLE:
        
        var _player = player_get(0);
		
        if !collision_player(_player)
		{
			break;
		}
        
        audio_sfx_play(snd_ring_giant);
        ds_list_add(global.giant_rings, id);
        
        if global.emerald_count >= 7
        {
			instance_destroy();
            global.player_rings = min(global.player_rings + 50, 999);  
        }
        else
		{
			_player.visible = false;
			_player.state = PLAYER_STATE.NO_INTERACT;
			
			animator.start(spr_giant_ring_flash, 0, 7, 2);
			
	        global.giant_ring_data =
	        [
	            x, y, FRAME_COUNTER, obj_rm_stage.top_bound[0], obj_rm_stage.bottom_bound[0], obj_rm_stage.left_bound[0], obj_rm_stage.right_bound[0]
	        ];
        
	        state = GIANT_RING_STATE.ENTRY;
		}
		
    break;
	
    case GIANT_RING_STATE.ENTRY:
        
        if animator.timer >= 0
		{
			break;
		}
        
        visible = false;
		
        if --wait_timer == 0
        {
            audio_bgm_stop(1);
            audio_sfx_play(snd_warp_enter);
            fade_perform_white(FADE_DIRECTION.OUT, 1, on_fade_load_special_stage);
        }
        
    break;
}