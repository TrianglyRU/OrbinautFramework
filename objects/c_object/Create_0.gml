image_speed = 0;
	
// Initialise animation struct
data_ani =
{
	index: undefined,
	duration: undefined,
	loopframe: undefined,
	timer: undefined,
	sprite_previous: undefined,
	order: undefined
};
	
// Initialise culling struct
data_culling =
{
	behaviour: CULLING.ACTIVE,
	parent_object: noone,
	scale_x: image_xscale,
	scale_y: image_yscale,
	img_index: image_index,
	spr_index: sprite_index,
	is_visible: visible,
	priority: depth,
	size_x: sprite_index < 0 ? 0 : sprite_get_width(sprite_index) / 2,
	size_y: sprite_index < 0 ? 0 : sprite_get_height(sprite_index) / 2
};
	
// Initialise hitbox struct
data_interact =
{	
	interact: true,
	radius_x: 0,
	radius_y: 0,
	offset_x: 0,
	offset_y: 0,
	radius_x_ext: 0,
	radius_y_ext: 0,
	offset_x_ext: 0,
	offset_y_ext: 0
};
	
// Initialise solid struct
data_solid =
{
	no_balance: false,
	radius_x: 0,
	radius_y: 0,
	offset_x: 0,
	offset_y: 0,
	height_map: [],
	push_flags: array_create(ENGINE_PLAYER_MAX_COUNT, false),
	touch_flags: array_create(ENGINE_PLAYER_MAX_COUNT, ENGINE_COLLISION_TOUCH_NONE)
};