/// @self c_object
/// @description Updates the animation frame order for the current object.
/// @param {Array<Real>} order An array specifying the order of frames.
function ani_update_order(_order)
{
	var _data_ani = data_ani;
	
	if _data_ani.order != undefined
	{
		_data_ani.order = _order;
	}
}
