/// @self
/// @description					Creates a new instance of the specified object, with optional pre-Create Event variable initialisation.
/// @param {Real} _x				The x-position for the instance.
/// @param {Real} _y				The y-position for the instance.
/// @param {Asset.GMObject} _object	The object to create an instance of.
/// @param {Struct} [_vars]			A structure for initialising variables (default is {}).
/// @returns {Id.Instance}
function instance_create(_x, _y, _object, _vars = {})
{
	return instance_create_depth(_x, _y, depth, _object, _vars);
}