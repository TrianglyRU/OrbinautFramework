if !instance_exists(TargetPlayer) || TargetPlayer.shield == SHIELD_NONE
{
    instance_destroy();
    exit;
}

// Render the shield above the player by default
var _priority = 1;

switch TargetPlayer.shield
{
    case SHIELD_BUBBLE:
	
        if ani_get_ended()
        {
            m_shield_reset_bubble_animation();
        }
		
    break;
       
    case SHIELD_FIRE:
	
        if sprite_index == spr_obj_shield_fire_dash
        {
            if !ani_get_ended()
            {
                break;
            }
            
            m_shield_reset_fire_animation();
            _priority = 3;

            // The shield_state flag of the player may be cleared, so check if it is set first
            if TargetPlayer.shield_state == SHIELD_STATE_ACTIVE
            {
                TargetPlayer.shield_state = SHIELD_STATE_DISABLED;
            }
			
            TargetPlayer.air_lock_flag = false;
        }
        else if ani_get_frame() % 2 == 0
        {
            _priority = 3;
        }
		
    break;
        
    case SHIELD_LIGHTNING:
	
        var _frame = ani_get_frame();
		
        if _frame > 11 && _frame < 21
        {
            _priority = 3;
        }
		
    break;
}

obj_set_priority(_priority);