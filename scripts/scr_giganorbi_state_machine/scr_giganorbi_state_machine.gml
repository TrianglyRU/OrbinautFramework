/// @function scr_giganorbi_state_machine
function scr_giganorbi_state_machine()
{
	x += vel_x;
	y += vel_y;

	if boss_state_timer >= 0
	{
		boss_state_timer++;
	}
	
	if boss_state != GIGANORBI_STATE.PREPARE
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
		case GIGANORBI_STATE.WAIT:
		
			if boss_state_timer == -1
			{
				if x > boss_target.x
				{
					break;
				}

				boss_state_timer = 0;
				
				FOR_EACH_VISIBLE_VIEW
				{
					obj_rm_stage.left_bound[_v] = x - 320;
					obj_rm_stage.right_bound[_v] = x + 320;
				}
				
				audio_bgm_stop(1);
				break;
			}

			if boss_state_timer != 80
			{
				break;
			}
			
			visible = true;
			orb_direction = x < floor(boss_target.x) ? -1 : 1;
			boss_state = GIGANORBI_STATE.FLY_IN;
			create_orbs();
			culler.action = CULL_ACTION.NONE;
			
			audio_bgm_play(snd_bgm_boss);
			
			// Fallthrough to GIGANORBI_STATE.FLY_IN
			
		case GIGANORBI_STATE.FLY_IN:
		
			if floor(y) < obj_rm_stage.bottom_bound[0] - 260
			{
				vel_y = 4; break;
			}

			if vel_y != 0
			{
				vel_y -= 0.1; break;
			}
			
			osc_y = y;
			boss_state = GIGANORBI_STATE.ROAM;
			boss_state_timer = 0;
			
		break;

		case GIGANORBI_STATE.ROAM:
		
			vel_x = clamp(vel_x, -2, 2);
			vel_x -= 0.05 * image_xscale;
			
			oscillate_y(3);
			
			if boss_state_timer < 210
			{
				break;
			}
			
			image_xscale = floor(x) < xstart ? -1 : 1;
			orb_direction = image_xscale;
			boss_state = GIGANORBI_STATE.PREPARE;
			boss_state_timer = 0;
			
			audio_sfx_play(snd_spin_charge);
			
		break;

		case GIGANORBI_STATE.PREPARE:
		
			vel_x = clamp(vel_x, -3, 3);
			oscillate_y(6);
			
			if image_xscale == 1 && floor(x) > xstart - 240 || image_xscale == -1 && floor(x) < xstart + 240
			{
				vel_x -= 0.1 * image_xscale; break;
			}

			if abs(vel_x) >= 0.25
			{
				vel_x += 0.1 * image_xscale; break;
			}
			
			boss_state = GIGANORBI_STATE.BOUNCE;
			boss_state_timer = 0;
			vel_x = orb_count > 4 ? 1.25 : 2;
			vel_x *= image_xscale;
			image_index = 1;
			
		break;

		case GIGANORBI_STATE.BOUNCE:
		
			image_xscale = floor(x) < floor(boss_target.x) ? -1 : 1;
			orb_direction = image_xscale * -1;

			if orbs_thrown == orb_count - 1
			{
				boss_state = GIGANORBI_STATE.FLY_OUT;
				boss_state_timer = 0;
				vel_y = 0;
				
				break;
			}

			vel_y += GLOBAL_PARAM_GRV;
			
			if vel_y < 0
			{
				break;
			}
			
			// Collide with the level
			if tile_check_v(x, y + 31, 1)
			{
				while tile_check_v(x, y + 31, 1)
				{
					y--;
				}
			}
			else
			{
				break;
			}
			
			vel_y *= -1;
			boss_target.view_data_ref.shake_timer = 8;
			
			audio_sfx_play(snd_collision);
			audio_sfx_play(snd_spin_release);

			var _orb = orbs[orbs_thrown];
			var _player = player_get(0);
			
			with _orb
			{
				move_towards_point(_player.x, _player.y, random_range(6, 8));
			}
			
			_orb.parent_boss = noone;
			_orb.state = GIGANSPIKE_STATE.LAUNCHED;
			_orb.depth = RENDER_DEPTH_PRIORITY;
			_orb.visible = true;
			_orb.image_index = 0;
			
			orbs[orbs_thrown] = noone;
			orbs_thrown++;
			
		break;

		case GIGANORBI_STATE.FLY_OUT:
		
			if floor(y) > ystart
			{
				vel_y -= 0.1; break;
			}
			
			instance_destroy(orbs[orbs_thrown]);
			
			image_index = 0;
			image_xscale = floor(x) < xstart ? -1 : 1;
			y = ystart;
			boss_state = GIGANORBI_STATE.FLY_IN;
			boss_state_timer = 0;
			vel_x = 0;
			vel_y = 0;
			move_siner = 0;
			orbs_thrown = 0;
			orb_direction = image_xscale;
			
			create_orbs();
			
		break;
	}
}