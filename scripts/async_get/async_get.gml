/// @self
/// @description			Returns a value from async_load if the async event type matches the given one.
/// @param {Real} _event	The expected async event type (e.g. async_load event constant).
/// @param {String} _key	The key to retrieve from the async_load map.
/// @returns {Id.DsMap|Undefined}
function async_get(_event, _key)
{
	if async_load[? "event_type"] == _event 
	{
		return async_load[? _key];
	}
	
	return undefined;
}