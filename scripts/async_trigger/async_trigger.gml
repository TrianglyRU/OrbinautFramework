/// @self
/// @description			Triggers a system async event with the given event type and payload.
/// @param {Real} _event	The async event type to assign to the event.
/// @param {String} _key	The key to store the value under in the async_load map.
/// @param {Any} _value		The value associated with the given key.
function async_trigger(_event, _key, _value)
{
	var _map = ds_map_create();
	
	_map[? "event_type"] = _event;
	_map[? _key] = _value;
	
	event_perform_async(ev_async_system_event, _map);
}