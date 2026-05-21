if state == RESULTS_STATE.LOAD
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
var _is_single_act = obj_rm_stage.act_index == ACT_SINGLE;
var _player_text, _dx, _dy;

switch player.player_type
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

_dx = _centre_x + offset_line1 * _factor_x;
_dy = _centre_y - 56;

if !_is_single_act && player.player_type == PLAYER.KNUCKLES
{
    _x -= 28;
}

draw_set_font(global.font_data[? spr_font_large]);
draw_set_halign(fa_center);
draw_text(_dx, _dy, string(_player_text) + " GOT");

_dx = _centre_x + offset_line2 * _factor_x;
_dy = _centre_y - 38;

draw_text(_dx - 13 * !_is_single_act, _dy, _is_single_act ? "THROUGH ZONE" : "THROUGH ACT");
draw_sprite(spr_gui_act, obj_rm_stage.act_index, _dx + 98, _dy + 4);

_dx = _centre_x + offset_time * _factor_x;
_dy = _centre_y + 8;

draw_set_font(global.font_data[? spr_font_digits]);
draw_set_halign(fa_right);

draw_sprite(spr_gui_results_time, 0, _dx - 55, _dy);
draw_text(_dx + 97, _dy - 7, time_bonus);

_dx = _centre_x + offset_rings * _factor_x;
_dy = _centre_y + 24;

draw_sprite(spr_gui_results_rings, 0, _dx - 55, _dy);
draw_text(_dx + 97, _dy - 7, ring_bonus);

_dx = _centre_x + offset_total * _factor_x;
_dy = _centre_y + 56;

draw_sprite(spr_gui_results_score, 0, _dx - 55, _dy);
draw_text(_dx + 97, _dy - 7, total_bonus);

draw_set_halign(fa_left);

if continue_timer > 60
{
	var _timer = (continue_timer - 2) % 32;
	
	if _timer >= 16 && _timer < 32
	{
		var _sprite;
		var _index = view_current > 0 ? global.player_cpu : global.player_main;
		
		switch _index
		{
			case PLAYER.TAILS:
				_sprite = spr_gui_continue_tails;
			break;
			
			case PLAYER.KNUCKLES:
				_sprite = spr_gui_continue_knuckles;
			break;
			
			case PLAYER.AMY:
				_sprite = spr_gui_continue_amy;
			break;
			
			// PLAYER.SONIC, others
			default:
				_sprite = spr_gui_continue_sonic;
		}
		
		_dx = _centre_x + 112;
		_dy = _centre_y + 52;
		
		draw_sprite(_sprite, floor(continue_timer / 20) % 2, _dx, _dy);
	}
}