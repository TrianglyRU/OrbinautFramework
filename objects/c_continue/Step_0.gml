var _fade = c_framework.fade;

// Check fade state and handle room transition
if _fade.state == FADESTATE.PLAINCOLOUR && _fade.routine == FADEROUTINE.OUT
{
    game_save_data(global.current_save_slot);
    if time_left == 0 || continue_count == 0
    {
        room_goto(room_first);
    }
    else
    {
        room_goto(global.previous_room_id);
    }
	
    exit;
}

// Check if the game is paused
if c_framework.state == STATE_PAUSED
{
    exit;
}

// Handle time left and continue count updates
if character_main.vel_charge == 0
{
    if --time_left == 0
    {
        fade_perform_black(FADEROUTINE.OUT, 1);
        audio_stop_bgm(0.5);
        exit;
    }
}
else if continue_count > 1
{
    with continue_icons[continue_count - 1]
    {
        ani_stop();
        visible = c_framework.frame_counter % 2 == 0;
    }
}

// Check if characters are out of bounds
var _bound = camera_get_width(0) + 64;
if character_main.x < _bound || character_buddy != noone && character_buddy.x < _bound
{
    exit;
}

// Initialise room transition
if global.continue_count > 0
{
    global.continue_count--;
}

fade_perform_black(FADEROUTINE.OUT, 1);
audio_stop_bgm(0.5);
