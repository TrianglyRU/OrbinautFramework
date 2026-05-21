/// @self obj_player
function scr_player_init()
{
	var _is_respawned = variable_instance_exists(id, "player_index");
	var _start_y = y;
	
	if !_is_respawned
	{
		base_depth = depth + 20;
		player_index = PLAYER_COUNT - 1;
	}
	else
	{
		ds_list_destroy(recorded_data);
		global.player_shields[player_index] = SHIELD.NONE;
	}
	
	switch player_type
	{
		case PLAYER.TAILS:
		
			radius_x_normal = 10;
			radius_y_normal = 16;
			radius_x_spin = 8;
			radius_y_spin = 15;
			palette_colours = [4, 5, 6];
			
		break;
		
		case PLAYER.KNUCKLES:
		
			radius_x_normal = 10;
			radius_y_normal = 20;
			radius_x_spin = 8;
			radius_y_spin = 15;
			palette_colours = [7, 8, 9];
			
		break;
		
		case PLAYER.AMY:
		
			radius_x_normal = 10;
			radius_y_normal = 17;
			radius_x_spin = 8;
			radius_y_spin = 13;
			palette_colours = [10, 11, 12];
		
		break;
		
		// PLAYER.SONIC, others
		default:
		
			radius_x_normal = 10;
			radius_y_normal = 20;
			radius_x_spin = 8;
			radius_y_spin = 15;
			palette_colours = [0, 1, 2, 3];
	}
	
	radius_x = radius_x_normal;
	radius_y = radius_y_normal;
	radius_wall = radius_x_normal + 1;
	
	state = PLAYER_STATE.DEFAULT;
	is_grounded = true;
	is_jumping = false;
	is_underwater = false;
	is_forced_roll = false;
	air_lock_flag = false;
	death_state = DEATH_STATE.WAIT;
	stick_to_convex = false;
	run_on_water = false;
	on_object = noone;
	extra_mask = noone;
	interact_flag = true;
	
	vel_x = 0;
	vel_y = 0;
	spd = 0;
	angle = 0;
	grv = PARAM_GRV_DEFAULT;
	
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

	ground_lock_timer = 0;
	super_timer = 0;
	camera_view_timer = CAMERA_VIEW_TIMER_DEFAULT;
	air_timer = AIR_TIMER_DEFAULT;
	inv_frames = 0;
	item_speed_timer = 0;
	item_inv_timer = 0;
	restart_timer = 0;

	score_combo = 0;
	score_values = [10, 100, 200, 500, 1000, 10000];
	action = ACTION.NONE;
	action_state = 0;

	spin_dash_charge = 0;
	spin_dash_pitch = 0;
	dash_vel = 0;
	dropdash_charge = 0;
	flight_timer = 0;
	ascend_timer = 0;
	glide_value = 0;
	glide_angle = 0;
	climb_value = 0;
	hammer_dash_timer = 0;
	skid_timer = 0;
	transform_timer = 0;

	carry_target = noone;
	carry_cooldown = 0;
	carry_target_x = 0;
	carry_target_y = 0;
	cpu_target = noone;
	cpu_state = CPU_STATE.MAIN;
	cpu_timer_respawn = 0;
	cpu_control_timer = 0;
	cpu_auto_jump = false;
	
	input_lock_control = false;
	input_press = input_create();
	input_down = input_create();
	
	secondary_layer = COLLISION_LAYER.PATH_A;
	shield_state = SHIELD_STATE.NONE;
	facing = 1;
	animation = ANIM.IDLE;
	visual_angle = 0;
	set_push_anim_by = noone;
	
	recorded_data = ds_list_create();
	recorded_data_length = player_index == 0 ? PLAYER_MAX_COUNT * PARAM_CPU_DELAY : PARAM_RECORD_LENGTH;
	
	debug_mode_ind = 0;
	debug_mode_spd = 0;
	debug_mode_array = [];
	
	if player_index == 0
	{
		// Base object set. More added dynamically in Room Start event
		array_push(debug_mode_array,
			obj_ring,
			obj_item_box,
			obj_star_post,
			obj_spring_v_yellow,
			obj_spring_v_red,
			obj_spring_h_yellow,
			obj_spring_h_red,
			obj_spring_d_yellow,
			obj_spring_d_red,
			obj_spikes_v,
			obj_spikes_h,
			obj_giant_ring,
			obj_sign_post,
			obj_capsule);
	}
	
	// replay_data is a 2D array for input playback. Each sub-array matches the key order
	// defined in the input_down struct and holds frame counts between input state changes:
	// even indices = released, odd indices = pressed
	//
	// Example: 
	// [ 
	//	  [5, 3, 10], 
	//    [2, 6]
	// ]
	// - up: 5 frames released, 3 held, 10 released
	// - down: 2 released, 6 held
	
	replay_data = [];
	replay_button_timer = array_create(9, -1);
	replay_button_state = array_create(9, 0);
	
	depth = base_depth;
	image_angle = 0;
	image_alpha = 1;

	var _ring_data = global.giant_ring_data;
	var _checkpoint_data = global.checkpoint_data;
	
	if array_length(_ring_data) > 0
	{
		x = _ring_data[0];
		y = _ring_data[1];
		
		is_grounded = false;
	}
	else
	{
		if array_length(_checkpoint_data) > 0
		{
			x = _checkpoint_data[0];
			y = _checkpoint_data[1];
		}
		else
		{
			y -= radius_y;
		}
		
		var _floor_dist = tile_raycast_2v(x - radius_x, y + radius_y - 1, x + radius_x - 1, y + radius_y - 1, 1, secondary_layer)[0];
		
		if _floor_dist < 14
		{
			y += _floor_dist;
		}
	}
	
	// Fill up initial record data
	for (var _i = 0; _i < recorded_data_length; _i++)
	{
		record_data(_i);
	}
	
	var _saved_shield = global.player_shields[player_index];
	
	if _saved_shield != SHIELD.NONE
	{
		instance_create(x, y, obj_shield, { player: id });
	}
	
	if player_type == PLAYER.TAILS
	{
		with obj_tail
		{
			if player == other.id
			{
				instance_destroy();
			}
		}
		
		with instance_create(x, y, obj_tail)
		{
			player = other.id;
		}
	}
	
	camera_data = view_data[0];
	
	if player_index > 0
	{
		var _camera_data = view_data[player_index];
		
		if _camera_data != undefined
		{
			camera_data = _camera_data;
		}
	}
	
	if !_is_respawned && camera_data.index == player_index
	{
		camera_data.raw_x = x - camera_get_width(camera_data.index) * 0.5;
		camera_data.raw_y = y - camera_get_height(camera_data.index) * 0.5 + 16;
	}
	
	if player_index == 0 && global.player_cpu != PLAYER.NONE
	{
		player_spawn(x - 16, _start_y, global.player_cpu, depth + player_index);
	}
	
	// Set default animation and hitbox
	scr_player_animate();
	scr_player_update_hitbox();
}