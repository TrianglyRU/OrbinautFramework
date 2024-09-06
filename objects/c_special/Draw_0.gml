var _c_framework = c_framework;

if state = SPECIALSTAGE_STATE_RESULTS
{
    exit;
}

// Set font and alignment for drawing text
draw_set_font(global.font_small);
draw_set_halign(fa_center);

// Calculate screen center and title string properties
var _half_width = camera_get_width(view_current) / 2;
var _half_height = camera_get_height(view_current) / 2;
var _title_string = "* SPECIAL STAGE *";
var _length = string_length(_title_string);
var _center_index = round(_length / 2);

// Draw oscillating title string
for (var i = 0; i < _length; i++)
{
    var _offset_x = (i - _center_index) * 8;
    var _offset_y = obj_oscillate_y(0, _c_framework.frame_counter * 4, 2, 1, i * 48);
    draw_text(_half_width + _offset_x, 48 + _offset_y, string_char_at(_title_string, i + 1));
}

// Check state and draw special message if in EMERALD state
if state == SPECIALSTAGE_STATE_EMERALD 
{
    if _c_framework.frame_counter % 20 < 10
    {
        draw_text(_half_width, _half_height + 84, "YOU GOT A CHAOS EMERALD!");
    }
	
    exit;    
}

// Draw instructions for getting a Chaos Emerald or leaving
draw_text(_half_width, _half_height + 64, "PRESS ACTION 1 TO GET A CHAOS EMERALD");
draw_text(_half_width, _half_height + 74, "PRESS START TO LEAVE");