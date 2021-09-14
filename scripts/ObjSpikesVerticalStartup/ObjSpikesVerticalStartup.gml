function ObjSpikesVerticalStartup()
{
	// Set object solidbox
	object_set_solidbox(16, 16, false);
	
	// Set object depth
	object_set_depth(Player, false);
	
	// Set object unload type
	object_set_unload(TypePause);
}