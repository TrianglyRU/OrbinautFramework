// Inherit the parent event
event_inherited();

/// @method m_shield_reset_fire_animation
m_shield_reset_fire_animation = function()
{
	ani_start(spr_obj_shield_fire, 2);
}
	
/// @method m_shield_reset_bubble_animation
m_shield_reset_bubble_animation = function()
{
	ani_start(spr_obj_shield_bubble);
	
	var _order =
	[
		4,  0, 4,  0, 4,  0, 5, 1, 5, 1, 5, 1, 6,  0, 6,  0, 6,  0, 7,  1, 7,  1, 7,  1, 
		8,  0, 8,  0, 8,  0, 9, 1, 9, 1, 9, 1, 10, 0, 10, 0, 10, 0, 11, 1, 11, 1, 11, 1,
		12, 0, 12, 0, 12, 0
	];
	
	// Since we use the same sprite for every Bubble Shield animation, call ani_update()
	ani_update(0, true, _order, 2, 0);
}
	
switch TargetPlayer.shield
{
	case SHIELD_NORMAL:
				
		obj_set_priority(1);
		ani_start(spr_obj_shield, 4);	
		image_alpha = 0.5;
			
	break;
			
	case SHIELD_BUBBLE:
		
		obj_set_priority(1);
		m_shield_reset_bubble_animation();
			
	break;
		
	case SHIELD_FIRE:
				
		obj_set_priority(3);
		m_shield_reset_fire_animation();
			
	break;
		
	case SHIELD_LIGHTNING:
			
		var _thunder_order =
		[
			0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11,
			8, 7, 6, 5, 4, 3, 2, 1, 0, 9, 10, 11
		];
			
		var _thunder_duration =
		[
			4, 4, 4, 4, 4, 4, 4, 4, 4, 2, 2, 2,
			4, 4, 4, 4, 4, 4, 4, 4, 4, 2, 2, 2
		];
			
		obj_set_priority(1);
		ani_start(spr_obj_shield_lightning, _thunder_duration, 0, 0, _thunder_order);
			
	break;
}

obj_set_culling(CULLING.PAUSEONLY);