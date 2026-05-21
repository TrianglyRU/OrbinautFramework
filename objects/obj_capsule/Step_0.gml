FOR_EACH_PLAYER
{
	solid_object(player_get(_p), SOLID_TYPE.FULL);
}

switch state
{
    case CAPSULE_STATE.IDLE:
        
        if button_obj.y > button_obj.ystart
        {
            instance_create(x, lock_obj.y, obj_explosion_dust);
			audio_sfx_play(snd_destroy);
			
	        with obj_player
	        {
	            if player_index == 0 && super_timer > 0
	            {
	                audio_bgm_play(obj_rm_stage.bgm_track);
	            }
            
	            super_timer = -1;
	        }
			
			lock_obj.vel_x = 8;
			lock_obj.vel_y = -4;
	        state = CAPSULE_STATE.BREAK;
	        wait_timer = 29;
		
			obj_gui_hud.update_timer = false;
        }
        
    break;
	
	case CAPSULE_STATE.BREAK:
        
        if --wait_timer < 0
        {
            for (var _i = 0; _i < 8; _i++)
	        {
	            with instance_create(x - 28 + 7 * _i, y, obj_animal)
				{
					state = ANIMAL_STATE.CAPSULE;
					state_timer = 154 - _i * 8;
				}
	        }
			
	        state = CAPSULE_STATE.SPAWN_ANIMALS;
	        wait_timer = 180;
			gate_obj.animator.start(gate_obj.sprite_index, 0, 2, 4);
        }
        
    break; 
	
    case CAPSULE_STATE.SPAWN_ANIMALS:
        
        if obj_game.frame_counter % 8 == 0
        {
			with instance_create(x + irandom_range(-25, 24), y, obj_animal)
			{
				state = ANIMAL_STATE.CAPSULE;
				state_timer = 12;
			}
        }
        else if --wait_timer == 0
        {
            state = CAPSULE_STATE.CHECK_RESULTS;
        }
        
    break;
	
    case CAPSULE_STATE.CHECK_RESULTS:
		
		with obj_animal
		{
			if instance_is_drawn()
			{
				return;
			}
		}
		
		state = CAPSULE_STATE.RESULTS;
		instance_create(0, 0, obj_gui_results);
			
	break;
}