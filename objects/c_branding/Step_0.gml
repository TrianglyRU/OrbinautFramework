var _framework = c_framework;
var _fade = _framework.fade;

// Check fade state and handle room transition
if _fade.routine == FADEROUTINE.OUT && _fade.state == FADESTATE.PLAINCOLOUR
{
    room_goto(global.start_room);
}

// Check if the game is paused
if _framework.state == STATE_PAUSED
{
    exit;
}

// Update orbinaut properties
orbinaut_alpha = min(orbinaut_alpha + 0.05, 1.0);
orbinaut_scale = max(orbinaut_scale - (orbinaut_scale - 1) / 8, 1.0);

// Update logo properties
if _framework.frame_counter >= 8 
{
    logo_alpha = min(logo_alpha + 0.05, 1.0);
    logo_scale = max(logo_scale - (logo_scale - 1) / 8, 1.0);
}

// Play branding sound
if logo_alpha == 0.15 
{
    audio_play_sfx(sfx_branding);
}

// Adjust digit and logo offsets
var _digit_step = digit_offset_x / 4;
if logo_scale < 1.1 
{
    digit_offset_x = max(digit_offset_x - _digit_step, 1);
}
if digit_offset_x < 16 
{
    logo_offset_x = max(logo_offset_x - _digit_step, 1);
}

// Initialise room transition
if _framework.frame_counter == 96 || input_get_pressed(0).start 
{
    fade_perform_black(FADEROUTINE.OUT, 1);
}