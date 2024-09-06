// Calculate screen center
var _half_width = camera_get_width(view_current) / 2;
var _half_height = camera_get_height(view_current) / 2;

// Draw branding
draw_sprite_ext(spr_branding_orbinaut, 0, _half_width, _half_height - 32, orbinaut_scale, orbinaut_scale, 0, c_white, orbinaut_alpha);
draw_sprite_ext(spr_branding_logo, 0, _half_width - 24 + logo_offset_x, _half_height + 69, logo_scale, logo_scale, 0, c_white, logo_alpha);
draw_sprite(spr_branding_digit, 0, _half_width + 98 + digit_offset_x, _half_height + 65);