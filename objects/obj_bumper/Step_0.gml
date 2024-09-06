for (var p = 0; p < PLAYER_COUNT; p++)
{
    var _player = player_get(p);
    
    if !obj_check_hitbox(_player)
    {
        continue;
    }
    
    if ani_get_frame() == 0
    {
        ani_update_frame(1);
    }
    
    audio_play_sfx(sfx_bumper);
    
    // Handle hits and scoring
    if hits_left != 0
    {
        hits_left--;
        
        instance_create(x, y, obj_score);
        _player.m_player_add_score(0);
    }
    
    var _angle = math_get_vector_rounded(_player.x - x, _player.y - y);
    
    // Update player's properties
    if _player.action == ACTION_CARRIED
    {
        _player.action = ACTION_NONE;
    }
        
    _player.is_jumping = false;
    _player.is_grounded = false;
    _player.air_lock_flag = false;
    _player.set_push_anim_by = noone;
    _player.vel_x = BUMPER_FORCE * dsin(_angle);
    _player.vel_y = BUMPER_FORCE * dcos(_angle);
	
    break;
}
