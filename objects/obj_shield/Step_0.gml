var _shield = global.player_shields[player.player_index];

if !instance_exists(player) || _shield == SHIELD.NONE
{
    instance_destroy();	
    return;
}

switch _shield
{
	case SHIELD.NORMAL:
		depth = draw_depth(10);
	break;
	
	case SHIELD.BUBBLE:
	
		if sprite_index != spr_shield_bubble && animator.timer < 0
		{
			bubble_shield_animation();
		}
		
		depth = draw_depth(10);
	
	break;
	
    case SHIELD.FIRE:
	
		if sprite_index != spr_shield_fire_dash
		{
			if animator.timer == animator.duration
			{
				depth = draw_depth(image_index % 2 == 0 ? 30: 10);
	        }
		}
        else if animator.timer < 0
		{
			reset_fire_shield_dash();
		}
		
    break;
	
    case SHIELD.LIGHTNING:
		
		if animator.timer == animator.duration
		{
			if image_index == 21
			{
				depth = draw_depth(30);
			}
			else if image_index == 0 || image_index == 39
			{
				depth = draw_depth(10);
			}
		}
		
    break;		
}