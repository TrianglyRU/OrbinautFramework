/// @description Set Up Per-View Draw Calls
if room == rm_startup
{
	return;
}

var _v = view_current;
var _wport = view_get_wport(_v);
var _hport = view_get_hport(_v);
var _camera_x = camera_get_x(_v);
var _camera_y = camera_get_y(_v);
var _camera_width = camera_get_width(_v);
var _camera_height = camera_get_height(_v);
var _scale_y_factor = _hport / _camera_height;

var _deform_count = ds_list_size(deformations_data);

if _deform_count > 0
{
	// Define rectangle mask for the deformation effect (outside is primary, inside is secondary)
	var _deform_ss_bound = deformation_bound - _camera_y;
	var _deform_mask = [0, _deform_ss_bound * _scale_y_factor, _wport, _hport];

	// Set deformation filter parameters for the current view
	for (var _i = 0; _i < _deform_count; _i++)
	{
	    var _data = deformations_data[| _i];
		var _effect = _data.effect;
		var _offset = (floor(_camera_y * _data.factor) + floor(_data.offset)) * _scale_y_factor;
	
	    if _data.values_a != undefined
		{
	        fx_set_parameter(_effect, "g_DataA", _data.values_a);
	        fx_set_parameter(_effect, "g_DataSizeA", array_length(_data.values_a));
	    }
		else
		{
	        fx_set_parameter(_effect, "g_DataSizeA", 0);
		}
	
	    if _data.values_b != undefined
		{
	        fx_set_parameter(_effect, "g_DataB", _data.values_b);
	        fx_set_parameter(_effect, "g_DataSizeB", array_length(_data.values_b));
	    }
		else
		{
	        fx_set_parameter(_effect, "g_DataSizeB", 0);
		}
	
	    fx_set_parameter(_effect, "g_Width", _camera_width);
	    fx_set_parameter(_effect, "g_Offset", _offset);
		fx_set_parameter(_effect, "g_ContextRect", _deform_mask);
	}
}

if ds_map_size(palette_maps) > 0
{
	// Define a texture mask for the palette shader (black is primary, white is secondary)
	if !surface_exists(palette_masks[_v])
	{
		palette_masks[_v] = surface_create(_wport, _hport);
	}

	var _palette_ss_bound = palette_bound - _camera_y;
	var _palette_mask = palette_masks[_v];

	surface_set_target(_palette_mask);
	draw_clear_alpha(c_black, 1);
	draw_rectangle_colour(0, _palette_ss_bound * _scale_y_factor, _wport, _hport, c_white, c_white, c_white, c_white, false);
	surface_reset_target();

	// Upload the mask into the shader for the current view
	shader_set(sh_palette_multimap);
	texture_set_stage(shader_get_sampler_index(sh_palette_multimap, "u_context_mask"), surface_get_texture(_palette_mask));
	shader_set_uniform_f(shader_get_uniform(sh_palette_multimap, "u_context_mask_size"), _wport, _hport);
	shader_reset();
}