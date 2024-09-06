switch state
{
    case ITEMCARD_STATE_MOVE:
    
        if vel_y < 0
        {
            y += vel_y;
            vel_y += 0.09375;
            break;
        }

        state = ITEMCARD_STATE_IDLE;
        wait_timer = 29;

		// This assumes only the lead player can destroy an Item Box
        var _player = player_get(0);
        var _player_shield = _player.shield;
        
        switch image_index
        {
            // Nothing
            case 0: break;
                
            // Eggman Mark
            case 1:
               _player.m_player_hurt();
            break;
                
            // Super Ring
            case 2:
			
                global.player_rings = min(global.player_rings + 10, 999);
                audio_play_sfx(sfx_ring_left);
                audio_play_sfx(sfx_ring_right);
				
            break;
                
            // Power Sneakers
            case 3:
			
                if _player.super_timer <= 0
                {
                    audio_play_bgm(bgm_highspeed);
                }
				
                _player.item_speed_timer = 1200;
				
            break;
                
            // Shields
            case 4:
			
                _player.shield = SHIELD_NORMAL;
                audio_play_sfx(sfx_shield);
				
            break;
                
            case 5:
			
                _player.shield = SHIELD_BUBBLE;            
                audio_play_sfx(sfx_shield_bubble);
                
                if audio_is_playing(bgm_drowning)
                {
                    audio_reset_bgm(c_stage.bgm_track, _player);
                }
				
            break;
                
            case 6:
			
                _player.shield = SHIELD_FIRE;
                audio_play_sfx(sfx_shield_fire);
				
            break;
                
            case 7:
			
                _player.shield = SHIELD_LIGHTNING;
                audio_play_sfx(sfx_shield_lightning);
				
            break;
                
            // Invincibility
            case 8:
			
                if _player.super_timer > 0
                {
                    break;
                }
                
                if _player.item_inv_timer == 0
                {
                    for (var i = 0; i < 8; i++)
                    {
                        instance_create(x, y, obj_star_invincibility,
                        {
                            StarID: i,
                            TargetPlayer: _player.id
                        });
                    }
					
                    audio_play_bgm(bgm_invincibility);
                }
				
                _player.item_inv_timer = 1200;
				
            break;
                
            // 1UP
            default:
			
                global.life_count++;
                audio_play_bgm(bgm_extralife, AUDIO_CHANNEL_JINGLE);
				
            break;
        }
        
        // Handle shield replacement if the shield has changed
        if _player.shield != _player_shield
        {
            with obj_shield if TargetPlayer == _player
            {
                instance_destroy();
            }
			
            instance_create(0, 0, obj_shield, { TargetPlayer: _player });
			
			global.player_shield[0] = _player.shield;
        }
		
    break;
    
    case ITEMCARD_STATE_IDLE:
    
        if --wait_timer == 0
        {
            instance_destroy();
        }
		
    break;
}