var _view_x = camera_get_x(view_current);
var _view_y = camera_get_y(view_current);
var _view_width = camera_get_width(view_current);
var _view_height = camera_get_height(view_current);
var _y_multiplier = surface_get_height(view_surface_id[view_current]) / _view_height;
var _half_height = _view_height / 2;
var _gfx_enabled = global.gfx_enabled;

if _gfx_enabled
{
    shader_set(sh_orbinaut);
}

#region FADE

var _fade = fade;

if _gfx_enabled
{
    var _do_div = _fade.blend_type == FADETYPE.DULLORDER || 
                    _fade.blend_type == FADETYPE.DULLSYNC || 
                    _fade.blend_type == FADETYPE.FLASHORDER || 
                    _fade.blend_type == FADETYPE.FLASHSYNC;

    shader_set_uniform_f(global.sh_fade_timer, _do_div ? _fade.timer / 3 : _fade.timer);
    shader_set_uniform_i(global.sh_fade_type, _fade.blend_type);
    shader_set_uniform_i(global.sh_fade_active, true);
}

#endregion

#region PALETTE

var _palette = palette;

if _gfx_enabled
{   
    var _ss_split = _palette.split_bound - _view_y;
    var _colour_data1 = _palette.colour_data[0];
    var _colour_data2 = _palette.colour_data[1];
    var _colour_index = _palette.index;

    if _ss_split > 0 && array_length(_colour_data1) > 0
    {
        texture_set_stage(global.sh_pal_tex1, _colour_data1[0]);
        shader_set_uniform_f(global.sh_pal_texel_size1, _colour_data1[1], _colour_data1[2]);
        shader_set_uniform_f(global.sh_pal_uv1, _colour_data1[3], _colour_data1[4], _colour_data1[5]);
        shader_set_uniform_f_array(global.sh_pal_index1, _colour_index);
    }

    if _ss_split < _view_height && array_length(_colour_data2) > 0
    {
        texture_set_stage(global.sh_pal_tex2, _colour_data2[0]);
        shader_set_uniform_f(global.sh_pal_texel_size2, _colour_data2[1], _colour_data2[2]);
        shader_set_uniform_f(global.sh_pal_uv2, _colour_data2[3], _colour_data2[4], _colour_data2[5]);
        shader_set_uniform_f_array(global.sh_pal_index2, _colour_index);
    }

    shader_set_uniform_f(global.sh_pal_bound, _ss_split * _y_multiplier);
    shader_set_uniform_i(global.sh_pal_active, true);
}

#endregion

#region BACKGROUND

var _background = background;
var _layer_count = _background.layer_count;
var _perspective_factor_y = (_background.perspective_y_data[2] - _half_height) / (_background.perspective_y_data[1] - _half_height);

// We cannot use draw_clear here, it won't work properly with fade for some reason
draw_rectangle_colour
(
    _view_x, _view_y, _view_x + _view_width, _view_y + _view_height,
    _background.back_colour,
    _background.back_colour,
    _background.back_colour,
    _background.back_colour, false
);

if _layer_count > 0
{
    if _gfx_enabled
	{
        shader_set_uniform_i(global.sh_bg_active, true);
	}

    for (var i = 0; i < _layer_count; i++)
    {
        var _pd = _background.parallax_data[i];
		
		// If a vertical perspective layer is set, redefine factor_y
        if _background.perspective_y_data[3] != undefined
		{
            _pd.factor_y = _perspective_factor_y;
		}

        var _draw_x = _view_x - ENGINE_RENDERER_HORIZONTAL_BUFFER;
        var _draw_y = floor(_view_y * (1 - _pd.factor_y)) + _pd.offset_y;
        var _frame = 0;

        if _pd.ani_duration > 0
		{
            _frame = floor(frame_counter / _pd.ani_duration) % sprite_get_number(_pd.sprite);
		}

        var _scaling = 1.0;
		
		// If this is the layer configured for vertical perspective, apply scaling
        if i == _background.perspective_y_data[3]
		{
            _scaling = clamp((_background.perspective_y_data[0] - _draw_y) / _pd.height_y, -1, 1);
		}

        if _gfx_enabled
        {
            if _pd.field_line_height != 0
            {
                shader_set_uniform_f(global.sh_bg_incline_step, _pd.field_line_step);
                shader_set_uniform_f(global.sh_bg_incline_height, _pd.field_line_height);
                shader_set_uniform_f(global.sh_bg_scaling, _scaling);
            }

            shader_set_uniform_f(global.sh_bg_offset, (_view_x + _background.scroll_offset) * _pd.factor_x - _pd.scroll_x, -_pd.scroll_y, ENGINE_RENDERER_HORIZONTAL_BUFFER, 0);
            shader_set_uniform_f(global.sh_bg_pos, _draw_x, _draw_y);
            shader_set_uniform_f(global.sh_bg_size, _pd.tex_width, _pd.height_y);
            shader_set_uniform_f(global.sh_bg_map_size, _pd.map_size_x, _pd.map_size_y);
        }
		
		// Draw the layer
        draw_sprite_part_ext(_pd.sprite, _frame, 0, _pd.node_y, _pd.tex_width, _pd.height_y, _draw_x, _draw_y, 1.0, _scaling, c_white, 1.0);
		
        if _gfx_enabled && _pd.field_line_height != 0
        {
            shader_set_uniform_f(global.sh_bg_incline_height, 0);
            shader_set_uniform_f(global.sh_bg_scaling, 0);
        }
    }

    shader_set_uniform_i(global.sh_bg_active, false);
}

#endregion

#region DISTORTION

var _distortion = distortion;

if _gfx_enabled
{
    var _ss_split = _distortion.split_bound - _view_y;

    for (var i = 0; i < 2; i++)
    {
        var _effect = _distortion.effect[i];
		
        if _effect == -1
		{
            continue;
		}

        var _factor_y = _background.perspective_y_data[3] == undefined ? _background.min_factor_y : _perspective_factor_y;
        var _draw_y = i == 0 ? _view_y : _view_y * _factor_y;
        var _effect_range = _distortion.effect_range[i];
        var _u_bound = _effect_range[0] >= 0 ? clamp(_effect_range[0] - _draw_y, 0, _view_height) : 0;
        var _l_bound = _effect_range[1] >= 0 ? clamp(_effect_range[1] - _draw_y, 0, _view_height) : 0;
        var _apply_flag = _distortion.apply_flag[i];
		
		// Calculate final effect bounds
        if _apply_flag[0] && !_apply_flag[1]
        {
            _u_bound = min(_u_bound, _ss_split);
            _l_bound = min(_l_bound, _ss_split);
        }
        else if !_apply_flag[0] && _apply_flag[1]
        {
            _u_bound = max(_u_bound, _ss_split);
            _l_bound = max(_l_bound, _ss_split);
        }
        else
        {
            _u_bound = min(_u_bound, _ss_split);
            _l_bound = max(_l_bound, _ss_split);
        }

        var _offset_y = _distortion.offset_y[i];
        fx_set_parameter(_effect, "g_ScreenWid", camera_get_width(view_current));
        fx_set_parameter(_effect, "g_Bound1", _u_bound * _y_multiplier);
        fx_set_parameter(_effect, "g_Bound2", _ss_split * _y_multiplier);
        fx_set_parameter(_effect, "g_Bound3", _l_bound * _y_multiplier);
        fx_set_parameter(_effect, "g_WaveY1", floor(_offset_y[0] + _draw_y));
        fx_set_parameter(_effect, "g_WaveY2", floor(_offset_y[1] + _draw_y));
    }
}

#endregion