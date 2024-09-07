/// @self
/// @description Returns the data of the camera associated with the specified viewport index.
/// @param {Real} index The index of the viewport.
/// @returns {Struct|Id.Instance}
function camera_get_data(_index)
{
	return c_framework.camera_data[_index];
}