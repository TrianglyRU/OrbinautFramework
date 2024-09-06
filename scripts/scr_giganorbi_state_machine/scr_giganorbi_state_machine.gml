/// @function scr_giganorbi_state_machine
function scr_giganorbi_state_machine()
{
	gml_pragma("forceinline");

	// Update boss state timer
	if boss_state_timer >= 0
	{
		boss_state_timer++;
	}

	// Adjust image direction based on player position
	if boss_state != BOSS_GIGAN_STATE_PREPARE
	{
		var _player_x = boss_target.x;
		
		if x < _player_x - 10
		{
			image_xscale = -1;
		}
		else if x > _player_x + 10
		{
			image_xscale = 1;
		}
	}
	
	switch boss_state
	{
		case BOSS_GIGAN_STATE_WAIT:
		
			// Initialise boss position and prepare for the fight
			if boss_state_timer == -1
			{
				if x > boss_target.x
				{
					break;
				}

				boss_state_timer = 0;
				
				for (var i = 0; i < CAMERA_COUNT; i++)
				{
					c_stage.bound_left[i] = x - 320;
					c_stage.bound_right[i] = x + 320;
				}
				
				audio_stop_bgm(1);
				break;
			}

			if boss_state_timer != 80
			{
				break;
			}

			visible = true;
			orb_direction = x < floor(boss_target.x) ? DIRECTION.NEGATIVE : DIRECTION.POSITIVE;
			boss_state = BOSS_GIGAN_STATE_FLY_IN;
			m_giganorbi_create_orbs();
			audio_play_bgm(bgm_boss);
				
			// Fallthrough to BOSS_GIGAN_STATE_FLY_IN
			
		case BOSS_GIGAN_STATE_FLY_IN:
		
			// Move boss towards the arena
			if floor(y) < c_stage.bound_bottom[0] - 260
			{
				vel_y = 4;
				break;
			}

			if vel_y != 0
			{
				vel_y -= 0.1;
				break;
			}

			osc_y = y;
			boss_state = BOSS_GIGAN_STATE_ROAM;
			boss_state_timer = 0;
			
		break;

		case BOSS_GIGAN_STATE_ROAM:
		
			// Roam around
			vel_x = clamp(vel_x, -2, 2);
			vel_x -= 0.05 * image_xscale;
			m_giganorbi_oscillate_y(3);

			if boss_state_timer < 210
			{
				break;
			}

			image_xscale = floor(x) < xstart ? -1 : 1;
			orb_direction = image_xscale;
			boss_state = BOSS_GIGAN_STATE_PREPARE;
			boss_state_timer = 0;
			audio_play_sfx(sfx_charge4);
			
		break;

		case BOSS_GIGAN_STATE_PREPARE:
		
			// Prepare for the bounce attack
			vel_x = clamp(vel_x, -3, 3);
			m_giganorbi_oscillate_y(6);

			if image_xscale == 1 && floor(x) > xstart - 240 || image_xscale == -1 && floor(x) < xstart + 240
			{
				vel_x -= 0.1 * image_xscale;
				break;
			}

			if abs(vel_x) >= 0.25
			{
				vel_x += 0.1 * image_xscale;
				break;
			}

			boss_state = BOSS_GIGAN_STATE_BOUNCE;
			boss_state_timer = 0;
			vel_x = orb_count > 4 ? 1.25 : 2;
			vel_x *= image_xscale;
			image_index = 1;
			
		break;

		case BOSS_GIGAN_STATE_BOUNCE:
		
			// Perform bounce attack and launch orbs
			image_xscale = floor(x) < floor(boss_target.x) ? -1 : 1;
			orb_direction = image_xscale * -1;

			if orbs_thrown == orb_count - 1
			{
				boss_state = BOSS_GIGAN_STATE_FLY_OUT;
				boss_state_timer = 0;
				vel_y = 0;
				break;
			}

			vel_y += 0.21875;
			
			if vel_y < 0
			{
				break;
			}

			var _floor_dist = tile_find_v(x, y + 32, DIRECTION.POSITIVE, TILELAYER.MAIN)[0];
			if _floor_dist >= 0
			{
				break;
			}

			vel_y *= -1;
			boss_target.camera_data.shake_timer = 8;
			audio_play_sfx(sfx_collision);
			audio_play_sfx(sfx_release);

			var _orb = orbs[orbs_thrown];
			var _player = player_get(0);
			
			with _orb
			{
				move_towards_point(_player.x, _player.y, random_range(6, 8));
			}
			
			_orb.ParentBoss = noone;
			_orb.state = GIGAN_SPIKE_STATE_LAUNCHED;
			_orb.depth = RENDERER_DEPTH_HIGHEST;
			_orb.visible = true;
			_orb.image_index = 0;
			orbs[orbs_thrown] = noone;
			orbs_thrown++;
			
		break;

		case BOSS_GIGAN_STATE_FLY_OUT:
		
			// Exit the arena and reset boss state
			if floor(y) >= c_stage.bound_top[0] - 32
			{
				vel_y -= 0.1;
				break;
			}

			var _orb = orbs[orbs_thrown];
			instance_destroy(_orb);
			
			image_index = 0;
			image_xscale = floor(x) < xstart ? -1 : 1;
			boss_state = BOSS_GIGAN_STATE_FLY_IN;
			boss_state_timer = 0;
			vel_x = 0;
			vel_y = 0;
			move_siner = 0;
			orbs_thrown = 0;
			orb_direction = image_xscale;
			
			m_giganorbi_create_orbs();
			
		break;
	}
}