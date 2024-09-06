/// @function scr_player_init
function scr_player_init()
{
	// Check if the instance is respawned
	var _is_respawned = variable_instance_exists(id, "player_index");

	if !_is_respawned
	{
		player_index = PLAYER_COUNT - 1;
	}
	else
	{
		ds_list_destroy(ds_record_data);
		
		global.player_shield[player_index] = SHIELD_NONE;
		ds_record_data = -1;
	}
	
	if PlayerType == PLAYER_NOONE
	{
		instance_destroy();
		exit;
	}

	// Initialise collision radius values
	radius_x_normal = 9;
	radius_y_normal = 19;
	radius_x_spin = 7;
	radius_y_spin = 14;

	if PlayerType == PLAYER_TAILS
	{
		radius_x_normal = 9;
		radius_y_normal = 15;
		radius_x_spin = 7;
		radius_y_spin = 14;
	}
	else if PlayerType == PLAYER_AMY
	{
		radius_x_normal = 9;
		radius_y_normal = 16;
		radius_x_spin = 7;
		radius_y_spin = 12;
	}

	// Set initial values
	radius_x = radius_x_normal;
	radius_y = radius_y_normal;
	vel_x = 0;
	vel_y = 0;
	spd_ground = 0;
	angle = 0;
	acc_glide = 0;
	acc_climb = 0;
	acc = 0;
	acc_air = 0;
	dec = 0;
	dec_roll = 0;
	frc = 0;
	frc_roll = 0;
	acc_top = 0;
	jump_min_vel = 0;
	jump_vel = 0;
	grv = PARAM_GRV_DEFAULT;
	state = PLAYER_STATE_CONTROL;
	stick_to_convex = false;
	on_object = noone;
	is_grounded = true;
	is_jumping = false;
	is_underwater = false;
	forced_roll = false;
	air_lock_flag = false;
	set_push_anim_by = noone;
	ground_lock_timer = 0;
	super_timer = 0;
	camera_view_timer = CAMERA_VIEW_TIMER_DEFAULT;
	air_timer = AIR_TIMER_DEFAULT;
	inv_frames = 0;
	item_speed_timer = 0;
	item_inv_timer = 0;
	tile_layer = TILELAYER.MAIN;
	tile_behaviour = TILEBEHAVIOUR.DEFAULT;
	shield = SHIELD_NONE;
	shield_state = SHIELD_STATE_NONE;
	death_state = DEATH_STATE_WAIT;
	restart_timer = 0;
	score_combo = 0;
	score_values = [10, 100, 200, 500, 1000, 10000];
	action = ACTION_NONE;
	action_state = 0;
	spindash_charge = 0;
	spindash_pitch = 0;
	dash_charge = 0;
	dash_vel = 0;
	dropdash_charge = 0;
	flight_timer = 0;
	ascend_timer = 0;
	glide_value = 0;
	glide_angle = 0;
	climb_value = 0;
	hammerdash_timer = 0;
	skid_timer = 0;
	transform_timer = 0;
	carry_target = noone;
	carry_cooldown = 0;
	carry_target_x = 0;
	carry_target_y = 0;
	cpu_target = noone;
	cpu_state = CPU_STATE_MAIN;
	cpu_timer_respawn = 0;
	cpu_timer_input = 0;
	cpu_jump_flag = false;
	input_no_control = false;
	input_press = input_create();
	input_down = input_create();
	replay_data = [];
	replay_button_timer = [-1, -1, -1, -1, -1, -1, -1, -1, -1];
	replay_button_state = [0, 0, 0, 0, 0, 0, 0, 0, 0];
	facing = DIRECTION.POSITIVE;
	animation = ANI_IDLE;
	visual_angle = 0;
	ds_record_data = ds_list_create();
	ds_record_length = player_index == 0 ? max(PARAM_RECORD_LENGTH, ENGINE_PLAYER_MAX_COUNT * PARAM_CPU_DELAY) : PARAM_RECORD_LENGTH;
	image_angle = 0;
	image_alpha = 1.0;
	
	// Set position based on saved Giant Ring or Checkpoint data
	var _ring_data = global.giant_ring_data;
	var _checkpoint_data = global.checkpoint_data;

	if array_length(_ring_data) > 0
	{
		x = _ring_data[0];
		y = _ring_data[1];
	}
	else if array_length(global.checkpoint_data) > 0
	{
		x = _checkpoint_data[0];
		y = _checkpoint_data[1] - radius_y - 1;
	}
	else
	{
		x = xstart;
		y = ystart - radius_y - 1;
	}
	
	// Initialise recorded data
	for (var i = 0; i < ds_record_length; i++)
	{
		m_player_record_data(i);
	}
	
	// Handle shield and Tails' tails creation
	var _saved_shield = global.player_shield[player_index];

	if _saved_shield != SHIELD_NONE
	{
		shield = _saved_shield;
		instance_create(x, y, obj_shield, { TargetPlayer: id });
	}

	if PlayerType == PLAYER_TAILS
	{
		with obj_tail if TargetPlayer == other.id
		{
			instance_destroy();
		}
		
		instance_create(0, 0, obj_tail, { TargetPlayer: id });
	}

	// Set camera data
	camera_data = camera_get_data(0);
	
	if player_index > 0
	{
		var _camera_data = camera_get_data(player_index);
		
		if _camera_data != noone
		{
			camera_data = _camera_data;
		}
	}

	if !_is_respawned && player_index == camera_data.index
	{
		var _x = x - camera_get_width(camera_data.index) / 2;
		var _y = y - camera_get_height(camera_data.index) / 2 + 16;
			
		camera_update(camera_data.index, undefined, undefined, _x, _y);
	}

	scr_player_animate();
}