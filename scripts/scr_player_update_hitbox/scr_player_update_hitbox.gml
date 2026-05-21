/// @self obj_player
function scr_player_update_hitbox()
{
	switch player_type
	{
		case PLAYER.SONIC:
		
			if animation == ANIM.DUCK && image_index == image_number - 1 && global.player_physics < PHYSICS.S3
			{
				mask_index = spr_mask_sonic_duck;
			}
			else if radius_y == radius_y_normal
			{
				mask_index = spr_mask_sonic_normal;
			}
			else
			{
				mask_index = spr_mask_sonic_spin;
			}
			
		break;
		
		case PLAYER.TAILS:
			mask_index = radius_y == radius_y_normal ? spr_mask_tails_normal : spr_mask_tails_spin;
		break;
		
		case PLAYER.KNUCKLES:
		
			if (animation == ANIM.DUCK || animation == ANIM.GLIDE_LAND) && image_index == image_number - 1 && global.player_physics < PHYSICS.S3
			{
				mask_index = spr_mask_knuckles_duck;
			}
			else if radius_y == radius_y_normal
			{
				mask_index = spr_mask_knuckles_normal;	
			}
			else if radius_y == radius_y_spin
			{
				mask_index = spr_mask_knuckles_spin;
			}
			else
			{
				mask_index = spr_mask_knuckles_glide;	
			}
			
		break;
		
		case PLAYER.AMY:
			mask_index = radius_y == radius_y_normal ? spr_mask_amy_normal : spr_mask_amy_spin;
		break;
	}
	
	if action == ACTION.HAMMER_SPIN
	{
		extra_mask = spr_amy_spin_hammer;
	}
	else if animation == ANIM.HAMMER_DASH
	{
		switch image_index % 4
		{
			case 0: extra_mask = spr_mask_amy_attack_1; break;
			case 1: extra_mask = spr_mask_amy_attack_2; break;
			case 2: extra_mask = spr_mask_amy_attack_3; break;
			case 3: extra_mask = spr_mask_amy_attack_4; break;
		}
	}
	else if shield_state == SHIELD_STATE.DOUBLE_SPIN
	{
		extra_mask = spr_mask_sonic_attack;
	}
	else
	{
		extra_mask = mask_index;
	}
}