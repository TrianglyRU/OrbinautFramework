/// @self
/// @description						Loads calculated collision data associated with the specified tilemap sprite.
/// @param {Asset.GMSprite} _sprite_id	The sprite used in the tilemap for which the collision data was calculated.
function tile_load_data(_sprite_id)
{
	var _collision_layers = ["Collision_Main", "Collision_A", "Collision_B"];
	var _marker_layers = ["Markers_Main", "Markers_A", "Markers_B"];
	
	for (var _i = 0; _i < array_length(_collision_layers); _i++)
	{
	    var _c_id = layer_tilemap_get_id(_collision_layers[_i]);
		
	    if _c_id == -1
		{
	        show_debug_message($"[WARN] Could not register collision layer {_collision_layers[_i]}. Skipping");
	    }
		
		var _id = layer_tilemap_get_id(_marker_layers[_i]);
		
	    if _id == -1
		{
	        show_debug_message($"[INFO] Could not register marker layer {_marker_layers[_i]}. Skipping");
	    }
		
		obj_game.tilemaps[_i] = _c_id;
		obj_game.marker_tilemaps[_i] = _id;
	}
	
	obj_game.tile_heights_ref = global.tile_heights[? _sprite_id];
	obj_game.tile_widths_ref = global.tile_widths[? _sprite_id];
	obj_game.tile_angles_ref = global.tile_angles[? _sprite_id];
}