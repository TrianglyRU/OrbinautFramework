/// @self
/// @description Retrieves the palette index corresponding to a given colour ID.
/// @param {Real} col_id The colour ID.
/// @returns {Real}
function pal_get_index(_col_id)
{
	return c_framework.palette.index[_col_id];
}
