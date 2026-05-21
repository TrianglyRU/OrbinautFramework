orbinaut_alpha = min(orbinaut_alpha + 0.05, 1.0);
orbinaut_scale = max(orbinaut_scale - (orbinaut_scale - 1) / 8, 1.0);

if obj_game.frame_counter >= 8 
{
    logo_alpha = min(logo_alpha + 0.05, 1.0);
    logo_scale = max(logo_scale - (logo_scale - 1) / 8, 1.0);
}

if logo_alpha == 0.15 
{
    audio_sfx_play(snd_branding);
}

var _digit_step = digit_offset_x / 4;

if logo_scale < 1.1 
{
    digit_offset_x = max(digit_offset_x - _digit_step, 1);
}
if digit_offset_x < 16 
{
    logo_offset_x = max(logo_offset_x - _digit_step, 1);
}