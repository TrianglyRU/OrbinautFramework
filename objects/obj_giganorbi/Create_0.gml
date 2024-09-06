#macro BOSS_GIGAN_STATE_WAIT 0
#macro BOSS_GIGAN_STATE_FLY_IN 1
#macro BOSS_GIGAN_STATE_ROAM 2
#macro BOSS_GIGAN_STATE_PREPARE 3
#macro BOSS_GIGAN_STATE_BOUNCE 4
#macro BOSS_GIGAN_STATE_FLY_OUT 5

/// @method m_giganorbi_oscillate_y
m_giganorbi_oscillate_y = function(_step)
{
	move_siner += _step;
	
	if move_siner > 360
	{
		move_siner = move_siner - 360;
	}
	
	y = obj_oscillate_y(osc_y, move_siner, 14, 1, 90);
}

/// @method m_giganorbi_create_orbs
m_giganorbi_create_orbs = function()
{
	if boss_hp <= 4
	{
		orb_count = 6;
	}
	
	angle_step = 360 / orb_count;
	
	for (var i = 0; i < orb_count; i++)
	{
		orbs[i] = instance_create(x, y, obj_giganorbi_spike, { ParentBoss: id });
	}
}

// Inherit the parent event
event_inherited();

boss_target = player_get(0);
boss_hp = 8;
boss_inv_frames = 0;
boss_state = BOSS_GIGAN_STATE_WAIT;
boss_state_timer = -1;
vel_x = 0;
vel_y = 0;
osc_y = 0;
orb_direction = 0;
orb_count = 4;
orbs_thrown = 0;
orb_siner = 0;
orb_sin_multiplier = 0;
orb_spin_speed = 1;
move_siner = 0;
angle = 0;
angle_step = 0;
visible = false;

obj_set_hitbox(28, 28);
obj_set_priority(4);