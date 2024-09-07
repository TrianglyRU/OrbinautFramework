/// @function scr_player_water
function scr_player_water()
{
	gml_pragma("forceinline");

	if !instance_exists(c_stage) || !c_stage.water_enabled
	{
		exit;
	}

	/// @method m_local_water_splash
	var m_local_water_splash = function()
	{
		if vel_y == 0 || cpu_state == CPU_STATE_RESPAWN || action == ACTION_CLIMB 
		|| action == ACTION_GLIDE && action_state != GLIDE_STATE_FALL
		{
			exit;
		}
		
		instance_create(x, c_stage.water_level, obj_water_splash);
		audio_play_sfx(sfx_splash);
	}

	/// @method m_local_set_gravity
	var m_local_set_gravity = function()
	{
		if action != ACTION_FLIGHT && (action != ACTION_GLIDE || action_state == GLIDE_STATE_FALL)
		{
			m_player_reset_gravity();
		}
	}

	// Handle entering water
	if !is_underwater
	{
		if floor(y) < c_stage.water_level
		{
			exit;
		}
	
		is_underwater = true;
		air_timer = AIR_TIMER_DEFAULT;
		vel_x *= 0.5;
		vel_y *= 0.25;
		
		m_local_set_gravity();
		m_local_water_splash();
		instance_create(0, 0, obj_bubbles_player, { TargetPlayer: id });
		
		// Destroy elemental shield
		if shield == SHIELD_FIRE || shield == SHIELD_LIGHTNING
		{
			if shield == SHIELD_LIGHTNING
			{
				instance_create(x, y, obj_water_flash);
			}
			else if shield == SHIELD_FIRE
			{
				instance_create(x, c_stage.water_level, obj_explosion_dust, { MakeSound: false });
			}
			
			shield = SHIELD_NONE;		
		}
	}

	// Handle underwater state and air timer
	if shield != SHIELD_BUBBLE
	{
		if air_timer > 0
		{
			air_timer--;
		}
	
		switch air_timer
		{
			case 1500: 
			case 1200:
			case 900:
			
				if player_index == 0
				{
					audio_play_sfx(sfx_alert);
				}
				
			break;
			
			case 720:
			
				if player_index == 0
				{
					audio_play_bgm(bgm_drowning);
				}
				
			break;
			
			case 0:
			
				audio_play_sfx(sfx_drown);
				m_player_reset();
				
				depth = RENDERER_DEPTH_HIGHEST + player_index;
				animation = ANI_DROWN;
				grv = PARAM_GRV_UNDERWATER;
				state = PLAYER_STATE_DEATH;
				vel_x = 0;
				vel_y = 0;
				spd_ground = 0;
				
				if player_index == camera_data.index
				{
					camera_data.allow_movement = false;
				}
				
				exit;
		}
	}

	// Handle exiting water
	if floor(y) >= c_stage.water_level
	{
		exit;
	}

	is_underwater = false;
	m_local_set_gravity();
	m_local_water_splash();

	if action == ACTION_FLIGHT
	{
		audio_play_sfx(sfx_flight);
	}

	if player_index == 0 && audio_is_playing(bgm_drowning)
	{
		audio_reset_bgm(c_stage.bgm_track, id);
	}

	if global.player_physics <= PHYSICS_S2 || vel_y >= -4
	{
		vel_y *= 2;
	}
	
	// Limit vertical velocity
	vel_y = max(-16, vel_y);
}