/// @self obj_player
function scr_player_water()
{
	// If just died, exit
	if state == PLAYER_STATE.DEATH || !instance_exists(obj_water) 
	{
		return;
	}
	
	var _shield = global.player_shields[player_index];
	var _water_level = obj_water.y;
	var _y = floor(y);
	
	// Dive
	if !is_underwater
	{
		if _y < _water_level
		{
			return;
		}
		
		is_underwater = true;
		air_timer = AIR_TIMER_DEFAULT;
		vel_x *= 0.5;
		vel_y *= 0.25;
		
		_set_gravity();
		_spawn_splash();
		
		with instance_create(0, 0, obj_bubbles_player)
		{
			player = other;
		}
		
		if _shield == SHIELD.FIRE || _shield == SHIELD.LIGHTNING
		{
			if _shield == SHIELD.LIGHTNING
			{
				instance_create(x, y, obj_water_flash);
			}
			else if _shield == SHIELD.FIRE
			{
				instance_create(x, _water_level, obj_explosion_dust);
			}
			
			global.player_shields[player_index] = SHIELD.NONE;
		}
	}
	
	// Emerge
	else if _y < _water_level
	{
		is_underwater = false;
	
		_set_gravity();
		_spawn_splash();

		if action == ACTION.FLIGHT
		{
			audio_sfx_play(snd_flight);
		}

		if player_index == 0 && audio_is_playing(snd_bgm_drowning) && instance_exists(obj_rm_stage)
		{
			restart_bgm(obj_rm_stage.bgm_track);
		}
	
		if global.player_physics <= PHYSICS.S2 || vel_y >= -4
		{
			vel_y *= 2;
		}
	
		vel_y = max(-16, vel_y);
		
		// Do not run air timer
		return;
	}
	
	// Air timer
	if _shield != SHIELD.BUBBLE
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
					audio_sfx_play(snd_alert);
				}
				
			break;
			
			case 720:
			
				if player_index == 0
				{
					audio_bgm_play(snd_bgm_drowning);
				}
				
			break;
			
			case 0:
			
				audio_sfx_play(snd_drown);
				
				reset_substate();
				grv = PARAM_GRV_UNDERWATER;
				state = PLAYER_STATE.DEATH;
				animation = ANIM.DROWN;
				vel_x = 0;
				vel_y = 0;
				spd = 0;
				depth = RENDER_DEPTH_PRIORITY + player_index;
				
				if player_index == view_data_ref.index
				{
					view_data_ref.allow_updates = false;
				}
		}
	}
}

/// @self scr_player_water
function _spawn_splash()
{
	if vel_y != 0
	{
		if state != PLAYER_STATE.NO_INTERACT && action != ACTION.CLIMB && !is_true_glide() && cpu_state != CPU_STATE.RESPAWN
		{
			instance_create(x, obj_water.y, obj_water_splash);
			audio_sfx_play(snd_splash);
		}
	}	
}

/// @self scr_player_water
function _set_gravity()
{
	if action != ACTION.FLIGHT && !is_true_glide()
	{
		reset_gravity();
	}
}