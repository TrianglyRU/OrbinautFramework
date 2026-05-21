var _hw = camera_get_width(0) * 0.5;
var _hh = camera_get_height(0) * 0.5;

on_fade_load_next_room = function()
{
	if !audio_bgm_is_playing()
	{
		game_save_data(global.current_save_slot);
	
		if time_left == 0 || continue_count == 0
		{
			global.continue_count = 0;
			global.emerald_count = 0;
		
			room_goto(global.start_room);
		}
		else
		{
			room_goto(global.previous_room_id);
		}
			
		return true;
	}
	
	return false;
}

time_left = 659;
character_main = noone;
character_buddy = noone;
continue_count = global.continue_count;
continue_icons = [];

switch global.player_main
{
    case PLAYER.SONIC:
        character_main = obj_continue_sonic;
    break;
	
    case PLAYER.TAILS:
        character_main = obj_continue_tails;
    break;
	
    case PLAYER.KNUCKLES:
        character_main = obj_continue_knuckles;
    break;
	
    case PLAYER.AMY:
        character_main = obj_continue_amy;
    break;
}

character_main = instance_create(_hw, _hh + 45, character_main);

switch global.player_cpu
{
    case PLAYER.TAILS:
        character_buddy = obj_continue_tails_buddy;
    break;
}

if character_buddy != noone
{
    character_main.x -= 9;
    character_buddy = instance_create(_hw + 24, _hh + 48, character_buddy);
}

if continue_count > 1
{
    var _shift = max(continue_count - 1, 0) * 10 + 2;
	
    for (var _i = 0; _i < continue_count; _i++)
    {
        continue_icons[_i] = instance_create(_hw + 20 * _i - _shift, _hh - 20, obj_continue_icon);
    }
}

audio_bgm_play(snd_bgm_continue);
fade_perform_black(FADE_DIRECTION.IN, 1);