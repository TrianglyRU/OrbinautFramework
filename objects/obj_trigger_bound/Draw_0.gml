draw_set_alpha(0.5);
draw_set_colour(#6D6DFF);
draw_rectangle(bbox_left, iv_range == BOUND_RANGE.BELOW ? y : bbox_top, bbox_right, iv_range == BOUND_RANGE.ABOVE ? y : bbox_bottom, false);
draw_set_colour(c_white);
draw_set_alpha(1.0);
draw_sprite_ext(sprite_index, image_index, floor(x), floor(y), image_xscale, culler.image_yscale_start, image_angle, draw_colour, image_alpha);