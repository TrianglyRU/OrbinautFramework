/// @description Set Shaders
if room == rm_startup
{
	return;
}

var _camera_x = camera_get_x(view_current);
var _camera_y = camera_get_y(view_current);
var _camera_width = camera_get_width(view_current);
var _camera_height = camera_get_height(view_current);
var _scale_y_factor = surface_get_height(view_surface_id[view_current]) / _camera_height;

// Set deformation filter parameters for the current view
var _deform_ss_bound = deformation_bound - _camera_y;

for (var _i = ds_list_size(deformations_data) - 1; _i >= 0; _i--)
{
    var _data = deformations_data[| _i];
	var _dy = floor(_camera_y * _data.factor);
	var _offset = floor(_data.offset);
    var _has_a = _data.values_a != undefined;
    var _has_b = _data.values_b != undefined;
	var _effect = _data.effect;
	
    var _u_bound = clamp(_data.range_start - _dy, 0, _camera_height);
    var _l_bound = clamp(_data.range_end - _dy, 0, _camera_height);
	
    if _has_a && !_has_b
	{
        _u_bound = min(_u_bound, _deform_ss_bound);
        _l_bound = min(_l_bound, _deform_ss_bound);
    }
    else if !_has_a && _has_b
	{
        _u_bound = max(_u_bound, _deform_ss_bound);
        _l_bound = max(_l_bound, _deform_ss_bound);
    }
    else
	{
        _u_bound = min(_u_bound, _deform_ss_bound);
        _l_bound = max(_l_bound, _deform_ss_bound);
    }
	
    if _has_a
	{
        fx_set_parameter(_effect, "g_DataA", _data.values_a);
        fx_set_parameter(_effect, "g_DataSizeA", array_length(_data.values_a));
    }
	
    if _has_b
	{
        fx_set_parameter(_effect, "g_DataB", _data.values_b);
        fx_set_parameter(_effect, "g_DataSizeB", array_length(_data.values_b));
    }
	
    fx_set_parameter(_effect, "g_Width", _camera_width);
    fx_set_parameter(_effect, "g_Offset", _dy + _offset);
    fx_set_parameter(_effect, "g_BoundUpper", _u_bound * _scale_y_factor);
    fx_set_parameter(_effect, "g_BoundMiddle", _deform_ss_bound * _scale_y_factor);
    fx_set_parameter(_effect, "g_BoundLower", _l_bound * _scale_y_factor);
}

// Set fade filter and shader parameters for the current view
var _type = fade_type;
var _timer = 0;

if _type == FADE_TYPE.DULL_ORDER || _type == FADE_TYPE.DULL_SYNC || _type == FADE_TYPE.FLASH_ORDER || _type == FADE_TYPE.FLASH_SYNC
{
	_timer = round(fade_timer / 3);
}
else
{
	_timer = fade_timer;
}

shader_set(sh_rgb_fade);
shader_set_uniform_i(shader_get_uniform(sh_rgb_fade, "u_type"), _type);
shader_set_uniform_f(shader_get_uniform(sh_rgb_fade, "u_timer"), _timer);
shader_reset();

if fade_effect != -1
{
	fx_set_parameter(fade_effect, "g_Type", _type);
	fx_set_parameter(fade_effect, "g_Timer", _timer);	
}

// Set palette shader parameters for the current view
shader_set(sh_palette_map);

var _palette_ss_bound = palette_bound - _camera_y;

shader_set_uniform_f(shader_get_uniform(sh_palette_map, "u_bound"), _palette_ss_bound * _scale_y_factor);
shader_set_uniform_f_array(shader_get_uniform(sh_palette_map, "u_indices"), palette_indices);

if _palette_ss_bound >= 0 && palette_data[0] != undefined
{
	var _texture = palette_data[0][0];
	var _texel_x = palette_data[0][1];
	var _texel_y = palette_data[0][2];
	var _uv_x = palette_data[0][3];
	var _uv_y = palette_data[0][4];
	var _uv_z = palette_data[0][5];
	
	shader_set_uniform_f(shader_get_uniform(sh_palette_map, "u_uv_a"), _uv_x, _uv_y, _uv_z);
	shader_set_uniform_f(shader_get_uniform(sh_palette_map, "u_texel_a"), _texel_x, _texel_y);
	texture_set_stage(shader_get_sampler_index(sh_palette_map, "u_texture_a"), _texture);
}
	
if _palette_ss_bound < _camera_height && palette_data[1] != undefined
{
	var _texture = palette_data[1][0];
	var _texel_x = palette_data[1][1];
	var _texel_y = palette_data[1][2];
	var _uv_x = palette_data[1][3];
	var _uv_y = palette_data[1][4];
	var _uv_z = palette_data[1][5];
	
	shader_set_uniform_f(shader_get_uniform(sh_palette_map, "u_uv_b"), _uv_x, _uv_y, _uv_z);
	shader_set_uniform_f(shader_get_uniform(sh_palette_map, "u_texel_b"), _texel_x, _texel_y);
	texture_set_stage(shader_get_sampler_index(sh_palette_map, "u_texture_b"), _texture);
}