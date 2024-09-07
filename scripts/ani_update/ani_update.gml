/// @self c_object
/// @description Updates several parameters of the object's current animation.
/// @param {Real|Undefined} frame Refer to `ani_update_frame()` function. Pass `undefined` if no changes are required.
/// @param {Bool} reset_timer Refer to `ani_update_frame()` function.
/// @param {Array<Real>|Undefined} order Refer to `ani_update_order()` function. Pass `undefined` if no changes are required.
/// @param {Real|Array<Real>|Undefined} duration Refer to `ani_update_duration()` function. Pass `undefined` if no changes are required.
/// @param {Real|Undefined} loop_frame Refer to `ani_update_loopframe()` function. Pass `undefined` if no changes are required.
function ani_update(_frame, _reset_timer, _order, _duration, _loopframe)
{
	if _duration != undefined
	{
		ani_update_duration(_duration);
	}
	if _order != undefined
	{
		ani_update_order(_order);
	}
	if _frame != undefined
	{
		ani_update_frame(_frame, _reset_timer);
	}
	if _loopframe != undefined
	{
		ani_update_loopframe(_loopframe);
	}
}
