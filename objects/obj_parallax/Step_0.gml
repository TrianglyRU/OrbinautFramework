if frame_duration > 0
{
    image_index = floor(obj_game.frame_counter / frame_duration) % image_number;
}

draw_offset_x = floor(obj_game.bg_scroll_x * scroll_mult_x);
draw_offset_y = floor(obj_game.bg_scroll_y * scroll_mult_y);