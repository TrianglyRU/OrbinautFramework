switch state
{
    case EGGPRISON_STATE_IDLE:
        
        // Check button object state
        if button_obj.offset_y == 0
        {
            break;
        }
        
        // Create explosion dust
        obj_set_culling(CULLING.ACTIVE);
        instance_create(x, lock_obj.y, obj_explosion_dust);
        
        // Update lock object velocity
        lock_obj.vel_x = 8;
        lock_obj.vel_y = -4;
        
        obj_gui_hud.update_timer = false;
        
        // Disable Super forms for player
        with obj_player
        {
            if player_index == 0 && super_timer > 0
            {
                audio_play_bgm(c_stage.bgm_track);
            }
            
            super_timer = -1;
        }
        
        // Delete lock object
        with lock_obj
        {
            obj_set_culling(CULLING.REMOVE);
        }
        
        state = EGGPRISON_STATE_BREAK;
        wait_timer = 29;
        
        break;
    
    case EGGPRISON_STATE_BREAK:
        
        if --wait_timer >= 0
        {
            break;
        }
        
        // Create animals
        for (var i = 0; i < 8; i++)
        {
            instance_create(x - 28 + 7 * i, y, obj_animal, { ReleaseTimer: 154 - i * 8, RandomDirection: true });
        }
        
        // Start gate animation
        with gate_obj
        {
            ani_start(sprite_index, 4, 0, 2);
        }
        
        state = EGGPRISON_STATE_SPAWN_ANIMALS;
        wait_timer = 180;
        
        break;
        
    case EGGPRISON_STATE_SPAWN_ANIMALS:
        
        // Spawn additional animals periodically
        if c_framework.frame_counter % 8 == 0
        {
			instance_create(x + irandom_range(-25, 25), y, obj_animal, { ReleaseTimer: 12, RandomDirection: true });
        }
        else if --wait_timer == 0
        {
            state = EGGPRISON_STATE_WAIT_ANIMALS;
        }
        
        break;
    
    case EGGPRISON_STATE_WAIT_ANIMALS:
		
		var _no_animals = true;
		
		with obj_animal if obj_is_visible(id)
		{
			_no_animals = false;
			break;
		}
		
        // Check if no animals are visible
        if _no_animals
        {
            instance_create_depth(0, 0, RENDERER_DEPTH_HUD, obj_gui_results);
            audio_play_bgm(bgm_actclear);
            
            state++;
        }
        
        break;
}

for (var p = 0; p < PLAYER_COUNT; p++)
{
    obj_act_solid(player_get(p), SOLIDOBJECT.FULL);
}