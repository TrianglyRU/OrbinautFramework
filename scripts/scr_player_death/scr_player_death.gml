/// @function scr_player_death
function scr_player_death()
{
	gml_pragma("forceinline");
	
	var _pos_y = floor(y);

	switch death_state
	{
	    case DEATH_STATE_WAIT:
			
			// If drowned, wait until we're far enough off screen
	        if air_timer == 0
	        {
	            var _index = camera_data.index;
				
	            if _pos_y <= camera_get_y(_index) + camera_get_height(_index) + 276
	            {
	                break;
	            }
				
	            if player_index == 0
	            {
	                c_framework.state = STATE_STOP_OBJECTS;
	            }
	        }
        
	        var _bound = 32;
	        var _index = camera_data.index;
			
	        if global.player_physics < PHYSICS_S3
	        {
	            _bound += camera_data.max_y;
	        }
	        else
	        {
	            _bound += camera_get_y(_index) + camera_get_height(_index);
	        }
			
	        if _pos_y <= _bound
	        {
	            break;
	        }
        
	        if player_index == 0
	        {
	            if instance_exists(obj_gui_hud)
	            {
	                obj_gui_hud.update_timer = false;
	            }
				
	            if --global.life_count > 0 && c_framework.frame_counter < 36000
	            {
	                death_state = DEATH_STATE_RESTART;
	                restart_timer = 60;
	            }
	            else
	            {
	                death_state--;
	                instance_create_depth(0, 0, RENDERER_DEPTH_HUD, obj_gui_gameover);
	            }
	        }
	        else
	        {
	            m_player_respawn();
	        }
			
	    break;

	    case DEATH_STATE_RESTART:
			
			// Wait 60 steps, then restart the stage
	        if restart_timer > 0
	        {
	            if --restart_timer != 0
	            {
	                break;
	            }
				
	            obj_set_culling(CULLING.NONE);
	            audio_stop_bgm(0.5);
	            fade_perform_black(FADEROUTINE.OUT, 1);    
	        }
        
	        if c_framework.fade.state != FADESTATE.PLAINCOLOUR
	        {
	            break;
	        }
			
	        game_clear_temp_data(false);
	        room_restart();
			
	    break;
	}
}