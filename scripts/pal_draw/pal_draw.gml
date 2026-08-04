/// @self
/// @description			Activates palette rendering for the specified palette entry.
/// @param {Real} _entry	The palette entry identifier.
function pal_draw(_entry)
{
	obj_game.palette_entry_previous = obj_game.palette_entry_current;
	obj_game.palette_entry_current = _entry;
	
	var _map = obj_game.palette_maps[? _entry];
	
	if _map == undefined
	{
		return;
	}
	
	var _data = _map[0];
	var _sprite_info = _map[1];
	
	if shader_current() != sh_palette_multimap
	{
		shader_set(sh_palette_multimap);
	}
	
	shader_set_uniform_f_array(shader_get_uniform(sh_palette_multimap, "u_indices"), _data.indices);
	
	if _sprite_info[0] != undefined
	{
		var _texture = _sprite_info[0][0];
		var _texel_x = _sprite_info[0][1];
		var _texel_y = _sprite_info[0][2];
		var _uv_x = _sprite_info[0][3];
		var _uv_y = _sprite_info[0][4];
		var _uv_z = _sprite_info[0][5];
		
		shader_set_uniform_f(shader_get_uniform(sh_palette_multimap, "u_uv_a"), _uv_x, _uv_y, _uv_z);
		shader_set_uniform_f(shader_get_uniform(sh_palette_multimap, "u_texel_a"), _texel_x, _texel_y);
		texture_set_stage(shader_get_sampler_index(sh_palette_multimap, "u_texture_a"), _texture);
	}
	
	if _sprite_info[1] != undefined
	{
		var _texture = _sprite_info[1][0];
		var _texel_x = _sprite_info[1][1];
		var _texel_y = _sprite_info[1][2];
		var _uv_x = _sprite_info[1][3];
		var _uv_y = _sprite_info[1][4];
		var _uv_z = _sprite_info[1][5];
	
		shader_set_uniform_f(shader_get_uniform(sh_palette_multimap, "u_uv_b"), _uv_x, _uv_y, _uv_z);
		shader_set_uniform_f(shader_get_uniform(sh_palette_multimap, "u_texel_b"), _texel_x, _texel_y);
		texture_set_stage(shader_get_sampler_index(sh_palette_multimap, "u_texture_b"), _texture);
	}
}