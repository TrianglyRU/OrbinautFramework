// Skip branding if flag is set
if global.skip_branding
{
    room_goto(global.start_room);
    exit;
}

logo_scale = 1.5;
logo_alpha = 0;
logo_offset_x = 16;
orbinaut_scale = 1.5;
orbinaut_alpha = 0;
digit_offset_x = camera_get_width(0);

bg_set_colour(c_white);
fade_perform_black(FADEROUTINE.IN, 1);