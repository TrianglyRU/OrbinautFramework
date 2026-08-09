/// @self
/// @description				Copies all background layers from the specified room and creates identical copies of them in the current active room, starting at the given depth.
/// @param {Asset.GMRoom} _room	The index of the room to copy background layers from.
/// @param {Real} _target_depth	The depth at which layer creation begins.
function bg_copy(_room, _target_depth)
{
	var _layers = room_get_info(_room, false, false, true, true, false, false).layers;
    var _count = array_length(_layers);
	var _base_depth = undefined;
	
    for (var i = 0; i < _count; i++)
	{
        var _layer = _layers[i];
		
		if array_length(_layer.elements) == 0
		{
			continue;
		}
		
        var _element = _layer.elements[0];
		
		// Type 1 is a background layer
        if _element.type != 1
		{
			continue;
		}
		
		if is_undefined(_base_depth)
		{
			_base_depth = _layer.depth;
		}
		
        var _layer_id = layer_create(_target_depth + (_layer.depth - _base_depth), _layer.name);
		var _bg_id = layer_background_create(_layer_id, _element.sprite_index);
		
        layer_x(_layer_id, _layer.xoffset);
        layer_y(_layer_id, _layer.yoffset);
        layer_hspeed(_layer_id, _layer.hspeed);
        layer_vspeed(_layer_id, _layer.vspeed);
        layer_set_visible(_layer_id, _layer.visible);
		
        layer_background_htiled(_bg_id, _element.htiled);
        layer_background_vtiled(_bg_id, _element.vtiled);
        layer_background_stretch(_bg_id, _element.stretch);
        layer_background_visible(_bg_id, _element.visible);
        layer_background_xscale(_bg_id, _element.xscale);
        layer_background_yscale(_bg_id, _element.yscale);
        layer_background_blend(_bg_id, _element.blendColour);
        layer_background_alpha(_bg_id, _element.blendAlpha);
        layer_background_index(_bg_id, _element.image_index);
        layer_background_speed(_bg_id, _element.image_speed);
    }
}