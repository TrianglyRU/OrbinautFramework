if state == SPECIAL_RESULTS_STATE.LOAD
{
    return;
}

var _x = camera_get_x(view_current);
var _y = camera_get_y(view_current);
var _w = camera_get_width(view_current);
var _h = camera_get_height(view_current);
var _centre_x = _x + _w * 0.5;
var _centre_y = _y + _h * 0.5;
var _factor_x = _w / 320;
var _player_text, _dx, _dy;

_dx = _centre_x + offset_line1 * _factor_x;
_dy = _centre_y - 88;

switch global.player_main
{
    case PLAYER.TAILS:
        _player_text = "TAILS";
    break;
	
    case PLAYER.KNUCKLES:
        _player_text = "KNUCKLES";
    break;
	
    case PLAYER.AMY:
        _player_text = "AMY";
    break;
	
	// PLAYER.SONIC, others
	default:
		_player_text = "SONIC";
}

draw_set_font(global.font_data[? spr_font_large_alt]);
draw_set_halign(fa_center);

// Upper text
if message_super
{
    draw_text(_dx, _dy, "NOW " + string(_player_text) + " CAN BE");
}
else if message_emerald
{
    draw_text(_dx, _dy, string(_player_text) + (global.emerald_count == 7 ? " HAS ALL THE" : " GOT A"));
}

_dx = _centre_x + offset_line2 * _factor_x;
_dy = _centre_y - 70;

// Lower text
if global.emerald_count >= 7
{
    draw_text(_dx, _dy, message_super ? "SUPER " + string(_player_text) : "CHAOS EMERALDS");
}
else
{
    draw_text(_dx, _dy, message_emerald ? "CHAOS EMERALD" : "SPECIAL STAGE");
}

_dx = _centre_x + offset_score * _factor_x;
_dy = _centre_y + 32;

draw_set_font(global.font_data[? spr_font_digits_alt]);
draw_set_halign(fa_right);
draw_sprite(spr_gui_results_score_special, 0, _dx - 75, _dy);
draw_text(_dx + 97, _dy - 7, total_score);

_dx = _centre_x + offset_rings * _factor_x;
_dy = _centre_y + 56;

draw_sprite(spr_gui_results_rings_special, 0, _dx - 75, _dy);
draw_text(_dx + 97, _dy - 7, ring_bonus);

_dx = _centre_x;
_dy = _centre_y - 36;

draw_set_alpha(FRAME_COUNTER % 2 == 0 ? 1 : 0);

for (var _i = 0; _i < global.emerald_count; _i++)
{
    switch _i
    {
        case 0: draw_sprite(spr_gui_emerald, _i, _dx, _dy); break;    
        case 1: draw_sprite(spr_gui_emerald, _i, _dx + 24, _dy + 12); break;
        case 2: draw_sprite(spr_gui_emerald, _i, _dx + 24, _dy + 36); break;
        case 3: draw_sprite(spr_gui_emerald, _i, _dx, _dy + 48); break;
        case 4: draw_sprite(spr_gui_emerald, _i, _dx - 24, _dy + 36); break;
        case 5: draw_sprite(spr_gui_emerald, _i, _dx - 24, _dy + 12); break;
        case 6: draw_sprite(spr_gui_emerald, _i, _dx, _dy + 24); break;
    }
}

draw_set_alpha(1);