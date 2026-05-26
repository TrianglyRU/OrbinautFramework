// Inherit the parent event
event_inherited();
event_culler(CULL_ACTION.PAUSE);

enum GIGANORBI_STATE
{
	WAIT,
	FLY_IN,
	ROAM,
	PREPARE,
	BOUNCE,
	FLY_OUT
}

oscillate_y = function(_step)
{
	move_siner += _step;
	
	if move_siner > 360
	{
		move_siner = move_siner - 360;
	}
	
	y = math_oscillate_y(osc_y, move_siner + 90, 14);
}

create_orbs = function()
{
	if boss_hp <= 4
	{
		orb_count = 6;
	}
	
	angle_step = 360 / orb_count;
	
	for (var _i = 0; _i < orb_count; _i++)
	{
		orbs[_i] = instance_create(x, y, obj_giganorbi_spike);
		orbs[_i].parent_boss = id;
	}
}

depth = draw_depth(40);
visible = false;

boss_target = player_get(0);
boss_hp = 8;
boss_inv_frames = 0;
boss_state = GIGANORBI_STATE.WAIT;
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