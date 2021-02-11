function StageObjectsUnload() 
{	
	// Object deactivation list
	instance_deactivate_object(Ring);
	instance_deactivate_object(Lamppost);
	instance_deactivate_object(Signpost);
	instance_deactivate_object(TestObject);
	instance_deactivate_object(BridgeHandler);
	instance_deactivate_object(BridgeLog);
	instance_deactivate_object(LayerChange);
	
	// Activate objects in a chuck of camera position rounded down to nearest 128
	var Boundary128 = Screen.RenderX div 128 * 128;
	instance_activate_region(Boundary128, 0, Boundary128 + ceil(Screen.Width / 128) * 128, room_height, true);
}