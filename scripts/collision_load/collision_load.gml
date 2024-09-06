/// @self
/// @description Loads pre-generated collision data for the tilemap associated with the specified sprite.
/// @param {Asset.GMSprite} spriteid The sprite used in the tilemap for which the collision data was generated.
/// @param {String} layer_a The name of the primary layer in the room.
/// @param {String} layer_b The name of the secondary layer in the room.
function collision_load(_spriteid, _layer_a, _layer_b)
{
	var _collision = c_framework.collision;
	
	_collision.tile_height = global.generated_tile_height_data[? _spriteid];
	_collision.tile_width = global.generated_tile_width_data[? _spriteid];
	_collision.tile_angle = global.generated_tile_angle_data[? _spriteid];
	
	// Set the tile layers for collision
	_collision.tile_layer = 
	[
		layer_tilemap_get_id(_layer_a), 
		layer_tilemap_get_id(_layer_b)
	];
}
