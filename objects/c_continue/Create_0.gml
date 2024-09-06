time_left = 659;
character_main = noone;
character_buddy = noone;
continue_count = global.continue_count;
continue_icons = [];
half_width = camera_get_width(0) / 2;
half_height = camera_get_height(0) / 2;

// Determine and create main character instance
switch global.player_main 
{
    case PLAYER_SONIC:
        character_main = obj_continue_sonic;
    break;
    case PLAYER_TAILS:
        character_main = obj_continue_tails;
    break;
    case PLAYER_KNUCKLES:
        character_main = obj_continue_knuckles;
    break;
    case PLAYER_AMY:
        character_main = obj_continue_amy;
    break;
}

character_main = instance_create(half_width, half_height + 45, character_main);

// Determine and create buddy character instance if applicable
switch global.player_cpu 
{
    case PLAYER_TAILS:
        character_buddy = obj_continue_tails_buddy;
    break;
}

if character_buddy != noone
{
    character_main.x -= 9;
    character_buddy = instance_create(half_width + 24, half_height + 48, character_buddy);
}

// Create continue icons based on continue count
if continue_count > 1 
{
    var _shift = max(continue_count - 1, 0) * 10 + 2;
    for (var i = 0; i < continue_count; i++)
    {
        continue_icons[i] = instance_create(half_width + 20 * i - _shift, half_height - 20, obj_continue_icon, { IsScreenSpace: false });
    }
}

fade_perform_black(FADEROUTINE.IN, 1);
audio_play_bgm(bgm_continue);