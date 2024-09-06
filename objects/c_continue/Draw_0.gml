// Set font and alignment for the title
draw_set_font(global.font_large);
draw_set_halign(fa_center);
draw_text(half_width, half_height - 54, "CONTINUE");

// Set font for displaying time and draw the time left
draw_set_font(global.font_digits);
draw_text(half_width + 1, half_height + 7, (time_left >= 600) ? "10" : $"0{floor(time_left / 60)}");

// Draw the continue stars sprite
draw_sprite(spr_continue_stars, 0, half_width, half_height + 12);